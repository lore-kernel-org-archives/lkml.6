Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89DDC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8291427B9D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7u0mxSm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8291427B9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933933AbeF2HrN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:47:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51284 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933177AbeF2HrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:47:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id w137-v6so1107999wmw.1;
        Fri, 29 Jun 2018 00:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eNl/pNFG1Q1EonbePgtUCGxk0dRgugSqxhAwE+Dk31Q=;
        b=t7u0mxSmF4PcG0PLejkQTTspvSf50kqPR4UydfXBCE4TM9zNkfnhCPCKDWyHmutZbW
         fS1J8uy9idHXENIoQddXN2X02mPi66PbMtQh5D1X2/GyKDax80IV2usMr3aCdDNMkCCO
         YAyeUY671EhRsooIaLzx4V4cq33V1TkIX5vFTTbgits31u4n3pwcHr+fC41VvWZkwWb/
         KIBR6oWb/Mp/0fOq8/iWtm85CT1Vm5wNIE4PxTJj6mV4zTohvYklbcFcgrWWHMiLW9tC
         KKoSAWmjsX/KCi5nOFEd6bsSwQnwOsMHOcJBEWBiV4xg6k7w38rqbJ8jeDx3cTRT6wZu
         MHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=eNl/pNFG1Q1EonbePgtUCGxk0dRgugSqxhAwE+Dk31Q=;
        b=lAG7rg1ueo4m2cnZOya0egX1lasswf8PGdi3voH6rc5F1tJwISmIU4fDyJFdpnxWRQ
         OitXao2ZK99qHizk4Z47riLsHR5uztZXjl/SpO4KAtCmZkSoyerPT7yan5lHa8m7Pp6m
         2vizqYRR45ojrZ6rQn1aosMYkWXow0mpE4daCl2m3kEfbP/CO+vO0FfYAB3muZA76dN/
         S+sU3PhQLvTcQlqa2RRpbAaEkg/iezFWuSwemQApPNPWBAIt/nDC+GRFnqx4f6h2Q+5u
         HDElze0gVyVIBzRmDjnQzbv16eYQ80XRuW5CEnDUQHLml4rfIr2UIJF9Qv09kWnh5RaP
         Gxog==
X-Gm-Message-State: APt69E245gpJhBDv8iXApDKjrFeNNv8TPVCEPwo+k/tP9s68ZJYB1Qaf
        XaUwhu1zlzr92M7fjItrEjimBcFtAOPKb5E99So=
X-Google-Smtp-Source: AAOMgpdPrjNB+mHX6UJXMUQyu8T7EHU9nfZwpoFAIV+TRr/ocdctUZBrLvtFLBzcs65ssCpIx/32UCCcQOKJWwcfcPU=
X-Received: by 2002:a1c:3fd1:: with SMTP id m200-v6mr962715wma.88.1530258430121;
 Fri, 29 Jun 2018 00:47:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:5c8d:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 00:46:49
 -0700 (PDT)
Reply-To: andrea.merello@gmail.com
In-Reply-To: <20180629072552.GY22377@vkoul-mobl>
References: <20180625092724.22164-1-andrea.merello@gmail.com> <20180629072552.GY22377@vkoul-mobl>
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 29 Jun 2018 09:46:49 +0200
Message-ID: <CAN8YU5Owh2Sb+-mOR0nVFkdZpD=dRd2jCin5MCdnsNLPo5zwwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 9:25 AM, Vinod <vkoul@kernel.org> wrote:
> On 25-06-18, 11:27, Andrea Merello wrote:
>> Whenever a single or cyclic transaction is prepared, the driver
>> could eventually split it over several SG descriptors in order
>> to deal with the HW maximum transfer length.
>>
>> This could end up in DMA operations starting from a misaligned
>> address. This seems fatal for the HW if DRE is not enabled.
>>
>> This patch eventually adjusts the transfer size in order to make sure
>> all operations start from an aligned address.
>>
>> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>> ---
>> Changes in v2:
>>         - don't introduce copy_mask field, rather rely on already-esistent
>>           copy_align field. Suggested by Radhey Shyam Pandey
>>         - reword title
>> Changes in v3:
>>       - fix bug introduced in v2: wrong copy size when DRE is enabled
>>         use implementation suggested by Radhey Shyam Pandey
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index 27b523530c4a..113d9bf1b6a1 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -1793,6 +1793,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_slave_sg(
>>                        */
>>                       copy = min_t(size_t, sg_dma_len(sg) - sg_used,
>>                                    XILINX_DMA_MAX_TRANS_LEN);
>> +
>> +                     if ((copy + sg_used < sg_dma_len(sg)) &&
>> +                         chan->xdev->common.copy_align) {
>> +                             /*
>> +                              * If this is not the last descriptor, make sure
>> +                              * the next one will be properly aligned
>> +                              */
>> +                             copy = rounddown(copy,
>> +                                     (1 << chan->xdev->common.copy_align));
>> +                     }
>>                       hw = &segment->hw;
>>
>>                       /* Fill in the descriptor */
>> @@ -1898,6 +1908,16 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
>>                        */
>>                       copy = min_t(size_t, period_len - sg_used,
>>                                    XILINX_DMA_MAX_TRANS_LEN);
>> +
>> +                     if ((copy + sg_used < period_len) &&
>> +                         chan->xdev->common.copy_align) {
>> +                             /*
>> +                              * If this is not the last descriptor, make sure
>> +                              * the next one will be properly aligned
>> +                              */
>> +                             copy = rounddown(copy,
>> +                                     (1 << chan->xdev->common.copy_align));
>> +                     }
>
> same code pasted twice, can we have a routine for this... perhaps more
> code can be made common too

Yes, I see.. Indeed there was duplicated code before this series and
it is still there after it.

I can see if we can have a routine as you suggested at least for the
code portions touched by this patch. Do you eventually want this extra
change to be done in the same patch 1/5 or do you want a separate
patch i.e. 2/6 or 6/6 ?

> --
> ~Vinod
