Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AADC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2A2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HIOPFR/f";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="lTMrnF1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE2A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeGSTUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 15:20:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34236 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731625AbeGSTUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 15:20:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 51622607B9; Thu, 19 Jul 2018 18:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532025384;
        bh=AKeQb8RdSaIV0O/urw4vsAXCiG72IyanuyGHnqdDx7k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HIOPFR/fUWvmlpjAyFwQK5nf8wgnFLFCGfzDs1XnS4rTHMK8ycgFHaJkz4PPXI1lp
         hg82bcWx9fh+OzITM02C92YLXLmkfDONrjXjE4f5OX+eIEdXyN4PJlN34YUknVGSXW
         dFxa65qWOwPyx2h2k4hnMl6IYNfjDUNHJOe1oI3M=
Received: from [10.235.228.39] (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tbaicar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CC0160791;
        Thu, 19 Jul 2018 18:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532025382;
        bh=AKeQb8RdSaIV0O/urw4vsAXCiG72IyanuyGHnqdDx7k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lTMrnF1ani5IZkxMYpWfXkTlRulEg/Vi4lheC/LpQs1rB7YU+pIc24fbG/YbG4e2S
         aq5lsmijthDHKsuuh7XVZ5mj2uTTlaE9/U7u5P7NbPW4vVLtrsWR/6L3dYyxyLTKc+
         Mgu00cBkLAwhKJbtWGO2Hj9mb2GZfhT5/24o0j3M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CC0160791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
To:     James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
        harba@qti.qualcomm.com
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
From:   Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
Date:   Thu, 19 Jul 2018 14:36:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/2018 10:46 AM, James Morse wrote:
> On 19/07/18 15:01, Borislav Petkov wrote:
>> On Mon, Jul 16, 2018 at 01:26:49PM -0400, Tyler Baicar wrote:
>>> Enable per-layer error reporting for ARM systems so that the error
>>> counters are incremented per-DIMM.
>>>
>>> On ARM systems that use firmware first error handling it is understood
> understood by whom? Is this written down somewhere, or is it the convention. (in
> which case, lets get it written down somewhere)
Hey Boris, James,

It has just been convention, but Harb recently brought up the idea of adding it 
to SBBR.
>>> that card=channel and module=DIMM on that channel. Populate that
> I'm guessing this is the mapping between CPER records and the DMItable data.
Unfortunately the DMI table doesn't actually have channel and DIMM number values 
which
makes this more complicated than I originally thought...
>>> information and enable per layer error reporting for ARM systems so that
>>> the EDAC error counters are incremented based on DIMM number as per the
>>> SMBIOS table rather than just incrementing the noinfo counters on the
>>> memory controller.
> Does this work on x86, and its just the dmi/cper fields have a subtle difference?
There are CPU specific EDAC drivers for a lot of x86 folks and those drivers 
populate the layer information
in a custom way.

With more investigation and testing it turns out a simple patch like this is not 
going to work. This worked for
me on a 1DPC board since the card number turned out to always be the same as the 
index into the DMI table
to find the proper DIMM. On a 2DPC board this fails completely. The ghes_edac 
driver only sets up a single
layer so it is only using the card number with this patch. That setup can be 
seen here:

https://elixir.bootlin.com/linux/v4.18-rc5/source/drivers/edac/ghes_edac.c#L469

So it is only setting up a single layer with all the DIMMs on that layer. In 
order to properly enable the layers
to represent channel and DIMM number on that channel, we would need to have a 
way of determining the
number of channels (which would be layers[0].size) and the number of DIMMs each 
channel supported
(layers[1].size). There doesn't appear to be a way to determine that information 
at this point.

With the current ghes_edac setup, it seems the only way this could work would be 
to have the firmware
always report the module value to be the index into the DMI table that this DIMM 
information lives. When I
say index into the DMI table, I'm meaning the index into the list of "type 17" 
DMI entries. So, DIMM number
doesn't actually matter, what really matters is the ordering of the type 17 
entries in the DMI table.

This seems pretty hacky to me, so if anyone has other suggestions please share 
them. The goal is to be able to
enable the per layer error reporting in the ghes_edac driver so that the per 
dimm counters exposed in the
EDAC sysfs nodes are properly updated. The other obvious but more messy way 
would be to have notifiers
register to be called by ghes_edac and have a custom EDAC driver for each CPU to 
properly populate their layer
information.

Thanks,
Tyler

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

