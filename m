Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB0C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2E420857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 10:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JCI+OV6H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JCI+OV6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfBHKel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 05:34:41 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46994 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHKel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 05:34:41 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4C8D607DD; Fri,  8 Feb 2019 10:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549622079;
        bh=O8TKgjndctFx0+oZYKhO5TRhW3gJ1HQ7s8fu+SbY+GU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JCI+OV6HCp8H/NUNNdPV8hfIscCQzqpqYynBVuWq4f2kVIapRxuQ2FDINgF1cmZFX
         IdZUFj1wn8VLVojTjDohiWyCf4f6tghCdcuc5Fft+1daDYcQ1+jNNsFaXAcB6D6pV1
         sg1V9EgoUNalJWAuILpgLjeRJHF3VlJAlBG8HrB4=
Received: from [10.206.25.20] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 421E2601CF;
        Fri,  8 Feb 2019 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549622079;
        bh=O8TKgjndctFx0+oZYKhO5TRhW3gJ1HQ7s8fu+SbY+GU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JCI+OV6HCp8H/NUNNdPV8hfIscCQzqpqYynBVuWq4f2kVIapRxuQ2FDINgF1cmZFX
         IdZUFj1wn8VLVojTjDohiWyCf4f6tghCdcuc5Fft+1daDYcQ1+jNNsFaXAcB6D6pV1
         sg1V9EgoUNalJWAuILpgLjeRJHF3VlJAlBG8HrB4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 421E2601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=asutoshd@codeaurora.org
Subject: Re: [PATCH 1/2] mmc: cqhci: replace NUM_SLOTS with cq_host->num_slots
To:     Ritesh Harjani <riteshh@codeaurora.org>,
        Alamy Liu <alamy.liu@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190114191724.29960-1-alamy.liu@gmail.com>
 <ee3dc963-53f0-e362-caa5-069ce0e6eae7@intel.com>
 <CAJ3kudsgJsZ1KFXdD9Vnfx0GypnEf+ba-D8t+Wy1e8GdLF=U0w@mail.gmail.com>
 <362c073b-d795-4431-f1dd-c203cc606a6f@codeaurora.org>
From:   "Asutosh Das (asd)" <asutoshd@codeaurora.org>
Message-ID: <dcf57693-3daf-8277-53e9-1c4b094f2449@codeaurora.org>
Date:   Fri, 8 Feb 2019 16:04:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <362c073b-d795-4431-f1dd-c203cc606a6f@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2019 8:07 AM, Ritesh Harjani wrote:
> Hi Alamy,
> 
> On 2/8/2019 1:00 AM, Alamy Liu wrote:
>> It says in B.2.1 in the JESD84-B51.pdf (I don't have JESD84-B51A.pdf):
>>
>>     /The TDL is located in a memory location known to the CQE, and is
>>     comprised of up to 32 fixed-size slots. Each slot is comprised of
>>     one Task Descriptor and one Transfer Descriptor./
>>
>>
>> So if the IP has 16 slots, it should still meet the specification. 
>> Then the configuration could be moved to DTS, maybe:
>>
>>     cqhci-slotnum = <16>;
>>
>>     cqhci-dcmd-slotno = <15>;
>>
> Does your IP defines this as 16 slots & DCMD slot to be 15?
> Because if there is a deviation then IP may also define num_slots by 
> using some reserved registers.
> Also in JESD84-B51.pdf, specific slot no. is used extensively for 
> defining policies(like in case of DCMD & CQCFG), so in that case 
> defining via DT may not be that helpful.
> Unless there is no other way in your IP to determine the num_slots 
> except going via DT?
> 
> Let others also provide an opinion here.
> 
> Regards
> Ritesh
> 
> 
>>
>> Please comment.
>>
>> Regards,
>> Alamy
>>
>>
>>
>> On Thu, Jan 31, 2019 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com 
>> <mailto:adrian.hunter@intel.com>> wrote:
>>
>>     On 14/01/19 9:17 PM, Alamy Liu wrote:
>>     > Prevent to use fixed value (NUM_SLOTS) after it had been determined
>>     > and saved in a variable (cq_host->num_slots).
>>
>>     num_slots is always 32 (i.e. NUM_SLOTS) so why not go the other
>>     way and get
>>     rid of num_slots and just use NUM_SLOTS?
>>
>>     >
>>     > Signed-off-by: Alamy Liu <alamy.liu@gmail.com
>>     <mailto:alamy.liu@gmail.com>>
>>     > ---
>>     >  drivers/mmc/host/cqhci.c | 2 +-
>>     >  1 file changed, 1 insertion(+), 1 deletion(-)
>>     >
>>     > diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
>>     > index 159270e947..26d63594b7 100644
>>     > --- a/drivers/mmc/host/cqhci.c
>>     > +++ b/drivers/mmc/host/cqhci.c
>>     > @@ -699,7 +699,7 @@ static void cqhci_error_irq(struct mmc_host
>>     *mmc, u32 status, int cmd_error,
>>     >                * The only way to guarantee forward progress is
>>     to mark at
>>     >                * least one task in error, so if none is
>>     indicated, pick one.
>>     >                */
>>     > -             for (tag = 0; tag < NUM_SLOTS; tag++) {
>>     > +             for (tag = 0; tag < cq_host->num_slots; tag++) {
>>     >                       slot = &cq_host->slot[tag];
>>     >                       if (!slot->mrq)
>>     >                               continue;
>>     >
>>
Is it worth exploring to tie up the TDL memory allocations with the 
queue-depth? Because the queue-depth may vary with vendor; in most host 
controllers the slot size is 32. And since memory allocations are done 
on the basis of host slot size there's unused slots in the case of card 
advertising less than 32 queue-depth.
The tricky part would be the DCMD handling though.

In the IP in question, what slot is assigned to DCMD?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
