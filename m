Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E9920872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixTxzZuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E9920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754284AbeFTNcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:32:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46083 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752891AbeFTNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:32:42 -0400
Received: by mail-wr0-f194.google.com with SMTP id v13-v6so3305390wrp.13;
        Wed, 20 Jun 2018 06:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lqUjxbFZJnbLw6sxx3tgEDZ8J0hF4yGPrCfPxDnYrLA=;
        b=ixTxzZuRqIFfj8M6psUno5so6JgYuwjN5xSxWYmsuAC2gpuxEL3YeMYOY22RyFvDwK
         hwCYgHo4qenM6AMjJcCgAd5rLVNx6qN3o1rxShMKwvC8+onmTRcCci9ETealDPTWpIoL
         tC0uSKecnLE7KQmmw+8y2eEj92A3Ml0HwNsJrfYdWLIgR42ks0z5s+wgT4SRBSxno0kk
         d05KLj56/iSLUrH/b0RRP9mVLY22uxLjOsDBaQ1L5uBSbFr6Tfc2x/VxSFxt6ypW5UdU
         eeZWl5hLmsIX8vO6EUiMUkrmBx/thnz6QPwKShnPX0bpBv+p7Rp07Ddo8g+p+qPC3BR4
         ymSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=lqUjxbFZJnbLw6sxx3tgEDZ8J0hF4yGPrCfPxDnYrLA=;
        b=Tt6AWCorWxiFHgD5kFBxhZ1TqrIUyI3o6zBNLCza1P+Mmf37Fa7/vAV8CzbpFEIWex
         eUuQ84gLMZJN3YjgTd/KH8ezjCa9D1jLxoifYdhHYcXz5K9zo05rFIhqxMPNprrhbooG
         eWbKgrX+qKtkQoSSnnSxUU1iX62ITeJN5NjrLzhEqPjYnVsW8gO/HIb2hvAtMpmR3GPf
         40oVKfLTwMFnikk12WHjT3TZiyF4ZQ5U7QcMkbRqjF5r5gGs4C9bv7pWbGr48FqxcOY1
         xOz7jFY2JrQSO2FZIbgy8r/I1XzV/V7aH2RO/+8B1NM7J+v1kDgLQdfX1aDHGIJa7Y+l
         sjOA==
X-Gm-Message-State: APt69E1N1KoOECmMWUXge4oamkMTvYPE+VnDMitoWj0XMZOc9+Dlb4nn
        vzmO6r4kSHgCHUrpQS1QuKGQ3kd/Xs2osTByz24=
X-Google-Smtp-Source: ADUXVKJ7cWhfW0qPDysR3IQAoeVW8ubtd0AmJrv2GYNasbnGvimn1XBrLf3AdVfCQDYzmVUh55tr8ULpER3gHq3YftU=
X-Received: by 2002:adf:e751:: with SMTP id c17-v6mr17960442wrn.143.1529501561236;
 Wed, 20 Jun 2018 06:32:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:5c8d:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 06:32:20
 -0700 (PDT)
Reply-To: andrea.merello@gmail.com
In-Reply-To: <DM6PR02MB43615ED0221189B6B8D9017EC7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-2-andrea.merello@gmail.com> <DM6PR02MB43615ED0221189B6B8D9017EC7770@DM6PR02MB4361.namprd02.prod.outlook.com>
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 20 Jun 2018 15:32:20 +0200
Message-ID: <CAN8YU5O35du2RpTV78sJMx+MpGdOKf2LCQu8FqO1og6FO-JBOQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not
 invoked for each DMA operation
To:     Radhey Shyam Pandey <radheys@xilinx.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Michal Simek <michals@xilinx.com>,
        Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 2:36 PM, Radhey Shyam Pandey <radheys@xilinx.com> wrote:
>> -----Original Message-----
>> From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
>> owner@vger.kernel.org] On Behalf Of Andrea Merello
>> Sent: Wednesday, June 20, 2018 2:07 PM
>> To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
>> <michals@xilinx.com>; Appana Durga Kedareswara Rao
>> <appanad@xilinx.com>; dmaengine@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> Andrea Merello <andrea.merello@gmail.com>
>> Subject: [PATCH 2/6] dmaengine: xilinx_dma: fix completion callback is not
>> invoked for each DMA operation
>>
>> API specification says: "On completion of each DMA operation, the next in
>> queue is started and a tasklet triggered. The tasklet will then call the
>> client driver completion callback routine for notification, if set."
>>
>> Currently the driver keeps a "desc_pendingcount" counter of the total
>> descriptor pending, and it uses as IRQ coalesce threshold, as result it
>> only calls the CBs after ALL pending operations are completed, which is
>> wrong.
> I think IRQ coalescing enable/disable should be configurable.
> Performance related usecases will need this support.

I didn't intend this (only) wrt performances; my concern was mostly
wrt correctness. If my point of view is wrong then I'll drop this
patch from the series.

(.. I might respin it again in future: I had a patch wrt an old driver
version that allowed submitting new descriptors to the HW while the
DMA is running, and in this case disabling coalesce is needed i.e. in
order to submit a new empty buffer whenever the DMA finishes a
transfer without waiting the DMA to stop).

BTW, is there any dmaengine API suitable for setting interrupt coalesce?

>>
>> This patch uses disable IRQ coalesce and checks for the completion flag
>> for the descriptors (which is further divided in segments).
>>
>> Possibly a better optimization could be using proper IRQ coalesce
>> threshold to get an IRQ after all segments of the descriptors are done.
>> But we don't do that yet..
>>
>> NOTE: for now we do this only for AXI DMA, other DMA flavors are
>> untested/untouched.
>> This is loosely based on
>> commit 65df81a6dc74 ("xilinx_dma: IrqThreshold set incorrectly, unreliable.")
>> in my linux-4.6-zynq tree
> NOTE description doesn't help much.
>
>>
>> From: Jeremy Trimble [original patch]
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 39 +++++++++++++++++++++------------
>>  1 file changed, 25 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index a516e7ffef21..cf12f7147f07 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -164,6 +164,7 @@
>>  #define XILINX_DMA_CR_COALESCE_SHIFT 16
>>  #define XILINX_DMA_BD_SOP            BIT(27)
>>  #define XILINX_DMA_BD_EOP            BIT(26)
>> +#define XILINX_DMA_BD_CMPLT          BIT(31)
>>  #define XILINX_DMA_COALESCE_MAX              255
>>  #define XILINX_DMA_NUM_DESCS         255
>>  #define XILINX_DMA_NUM_APP_WORDS     5
>> @@ -1274,12 +1275,9 @@ static void xilinx_dma_start_transfer(struct
>> xilinx_dma_chan *chan)
>>
>>       reg = dma_ctrl_read(chan, XILINX_DMA_REG_DMACR);
>>
>> -     if (chan->desc_pendingcount <= XILINX_DMA_COALESCE_MAX) {
>> -             reg &= ~XILINX_DMA_CR_COALESCE_MAX;
>> -             reg |= chan->desc_pendingcount <<
>> -                               XILINX_DMA_CR_COALESCE_SHIFT;
>> -             dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>> -     }
>> +     reg &= ~XILINX_DMA_CR_COALESCE_MAX;
>> +     reg |= 1 << XILINX_DMA_CR_COALESCE_SHIFT;
>> +     dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
>>
>>       if (chan->has_sg && !chan->xdev->mcdma)
>>               xilinx_write(chan, XILINX_DMA_REG_CURDESC,
>> @@ -1378,6 +1376,20 @@ static void xilinx_dma_complete_descriptor(struct
>> xilinx_dma_chan *chan)
>>               return;
>>
>>       list_for_each_entry_safe(desc, next, &chan->active_list, node) {
>> +             if (chan->xdev->dma_config->dmatype ==
>> XDMA_TYPE_AXIDMA) {
>> +                     /*
>> +                      * Check whether the last segment in this descriptor
>> +                      * has been completed.
>> +                      */
>> +                     const struct xilinx_axidma_tx_segment *const tail_seg
>> =
>> +                             list_last_entry(&desc->segments,
>> +                                             struct
>> xilinx_axidma_tx_segment,
>> +                                             node);
>> +
>> +                     /* we've processed all the completed descriptors */
>> +                     if (!(tail_seg->hw.status & XILINX_DMA_BD_CMPLT))
>> +                             break;
>> +             }
>>               list_del(&desc->node);
>>               if (!desc->cyclic)
>>                       dma_cookie_complete(&desc->async_tx);
>> @@ -1826,14 +1838,13 @@ static struct dma_async_tx_descriptor
>> *xilinx_dma_prep_slave_sg(
>>                                  struct xilinx_axidma_tx_segment, node);
>>       desc->async_tx.phys = segment->phys;
>>
>> -     /* For the last DMA_MEM_TO_DEV transfer, set EOP */
>> -     if (chan->direction == DMA_MEM_TO_DEV) {
>> -             segment->hw.control |= XILINX_DMA_BD_SOP;
>> -             segment = list_last_entry(&desc->segments,
>> -                                       struct xilinx_axidma_tx_segment,
>> -                                       node);
>> -             segment->hw.control |= XILINX_DMA_BD_EOP;
>> -     }
>> +     /* For the first transfer, set SOP */
>> +     segment->hw.control |= XILINX_DMA_BD_SOP;
>> +     /* For the last transfer, set EOP */
>> +     segment = list_last_entry(&desc->segments,
>> +                               struct xilinx_axidma_tx_segment,
>> +                               node);
>> +     segment->hw.control |= XILINX_DMA_BD_EOP;
>>
>>       return &desc->async_tx;
>>
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
