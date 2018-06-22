Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA780C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7386A245DC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bvqvx/Vm";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jNAYsnCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7386A245DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934382AbeFVQjC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:39:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60912 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934338AbeFVQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:38:57 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83A0960B18; Fri, 22 Jun 2018 16:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529685536;
        bh=+wKHmcPBJW8gpltC72ojDI0WvEc1N5mvlcQXpNEWORc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bvqvx/VmISBRdIyTKdma4qLlk1PsC9SOkvQTpS8VCoEQlRC59EYDex3u0Fp5SYjWB
         8MyOSTCYiK2gWpR341HqnS9sj2dAq5ir17Wb3pTVicT2X11R1BhaRcIVWxCS2ciR/G
         yKDEXQBo88StfBoO4xXwF4TIl5hPZkulutJ4kRYM=
Received: from [192.168.1.8] (cpe-174-109-142-144.nc.res.rr.com [174.109.142.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tbaicar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B08FD60275;
        Fri, 22 Jun 2018 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529685535;
        bh=+wKHmcPBJW8gpltC72ojDI0WvEc1N5mvlcQXpNEWORc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jNAYsnCPLHBegtK7SY7Can23fzvg9XCoXbYWfmloM9CD/P9UNhw0X77R2gJ09XgLS
         02QFbEbgIxncCm4VK/rH2Krastpok/MUC08GXdCyogJVyD5a1nI2/J5vA/4LoWkXUI
         xM3ZEO0uHSC5My/MbZVEnW6xdLsUHcTzi+oyxDUI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B08FD60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
Subject: Re: [PATCH v5 3/5] PCI/AER: Add sysfs attributes to provide breakdown
 of AERs
To:     rajatxjain@gmail.com, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jes Sorensen <jsorensen@fb.com>, Kyle McMartin <jkkm@fb.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180620234147.48438-1-rajatja@google.com>
 <20180620234147.48438-3-rajatja@google.com>
 <20180621184822.GB14136@bhelgaas-glaptop.roam.corp.google.com>
 <CAA93t1rz6YGmvvORDB0ehr7Gwp-W+0HDYxEDgjtgYmGm3qMgCw@mail.gmail.com>
From:   Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <a16746f0-351f-276e-2a66-3ebf2c267507@codeaurora.org>
Date:   Fri, 22 Jun 2018 12:38:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAA93t1rz6YGmvvORDB0ehr7Gwp-W+0HDYxEDgjtgYmGm3qMgCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/2018 5:25 PM, Rajat Jain wrote:
> On Thu, Jun 21, 2018 at 11:48 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> [+cc Tyler for AER dmesg decoding]
>>
>> - Tyler posted a patch [1] to update those dmesg strings so they match
>>    the way lspci decodes them.  I really liked that update, but we
>>    never quite finished it.  If we're going to do that, it would be
>>    nice to do it first, so we don't publish new sysfs files, then
>>    immediately change the labels used in them.
> Sure, I guess you can push them in the right order.
The way the prints are handled has already been unified in 4.18rc1:

https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/pci/pcie/aer.c#L636

So that patch isn't needed anymore in it's entirety.
>> - IIRC, Tyler's patch had the nice property of changing the strings so
>>    each error name had no spaces, which would make it a little easier
>>    to parse this sysfs file: each line would be a single identifier
>>    followed by a single number (I would probably remove the "=" from
>>    the middle).
>
> Will do.
Would you like me to send a patch with just the string changes?

Thanks,
Tyler
>> [1] https://lkml.kernel.org/r/1518034285-3543-1-git-send-email-tbaicar@codeaurora.org
>>
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

