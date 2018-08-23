Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F69BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05F2208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0FjRDaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05F2208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeHWEep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 00:34:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbeHWEep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 00:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8gNn1X4sw8n1r8TVz1AHrAqpTTgb+HAQStUde/1/8S8=; b=Q0FjRDaGfLpbq65YipgvmmHqP
        op9H6UBPybLLpCBwt4Mon37ipSqT3s+dWe8W310nZlhPaSgxCTDGCd4X5+JW1eGTWqnD5jrLj1u2Z
        8JuOA99bC1BRcUPB1fe1PY+4YlbQdqhWhe2788ouvCyUPbJ8j6mGboDvfVfG9Y4tYstiKA3i2BDaf
        EAL69yXlI8IxtDVPjWDU8CWeDxKQSMzuq210GAc5WvDtEWwzhuGua4oGt9SQs+L5uCavbkXozD5S6
        sKK2ABqxJIJCvEpYBD7IiOte923RyHcxFfElLA9pewjU9oUPyLSda4Wcg0SGZepTaDb9Tft0J45vK
        5DoAePqWw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fse63-0004Oe-0o; Thu, 23 Aug 2018 01:07:35 +0000
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is
 installed" introduced in v4.18.4.
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        lucas.demarchi@profusion.mobi, lucas.de.marchi@gmail.com,
        michal.lkml@markovi.net, jeyu@kernel.org, cwhuang@linux.org.tw,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
 <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
 <CAKdAkRQ+BXezzT0JsuSa_-imHq+u-q2P5rMVMCL4=N18VYxSAw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7e154505-5f73-1054-e67e-cdfb249fec43@infradead.org>
Date:   Wed, 22 Aug 2018 18:07:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKdAkRQ+BXezzT0JsuSa_-imHq+u-q2P5rMVMCL4=N18VYxSAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/2018 05:39 PM, Dmitry Torokhov wrote:
> On Wed, Aug 22, 2018 at 4:35 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 08/22/2018 11:53 AM, H. Nikolaus Schaller wrote:
>>> This patch requires that /sbin/depmod is installed and installable on
>>> the build host.
>>>
>>> But not all build hosts for cross compiling Linux are Linux systems
>>> and are able to provide a working port of depmod, especially at the
>>> file patch /sbin/depmod.
>>>
>>> I use, for example, a Darwin system to cross compile Linux and I run
>>> depmod -a on the embedded system once, after installing a new Linux
>>> kernel there.
>>>
>>> I have no problem with seeing a warning, but aborting the build process
>>> is IMHO a bad idea since the previous behaviour didn't harm many people
>>> as far as I see. Probably 99% of people compiling Linux kernels do that
>>> on Linux and 99% of those have depmod installed for optimal operation of
>>> their build host. So IMHO printing the warning is good enough.
>>
>> Thanks for the report and sorry about the problem.
>>
>> I'm OK with changing the error to a warning.
>> Does the patch below work for you?
> 
> Why would one want a warning on a host that never runs "make modules_install"?
> Can this check be only done when we actually try to install modules?


So Nikolaus:  how do you provoke this problem that you are reporting?
It's not just a theoretical problem, is it?

The way that I read the top-level Makefile, this check for $DEPMOD only happens
when you run "make modules_install".

-- 
~Randy
