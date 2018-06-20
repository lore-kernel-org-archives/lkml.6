Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB139C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890C820874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 14:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4++NhK+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890C820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754185AbeFTO53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 10:57:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54658 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeFTO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 10:57:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so26290wmf.4;
        Wed, 20 Jun 2018 07:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1FhyFNuNdGOauTgx0a9O8mAiD2rN6gpyJ0yQBsAAR8c=;
        b=A4++NhK+ntI0+0c8jc0XXirmynxnZDRAYm/voTvCgx+2F/78DyHqyfEwjIm0sQN+4x
         gGpOhRU8QPNgNHPWNMYpoKKaOCBv8GsURdr26z3VgdN0ZGX5XuyN6niUbIOG3lOjCO+j
         yAbazmfCvtmLjsV0ZYGqEXSCKaxKwLyrjQa19qilR//AnhMJ29ef+FstN7iDUADnYh3K
         e+9qoT5Xxvj6dsESWs75XCmeysJYjLRvVA+LjIoy/gSyZ2oxtuQkTjNWAOdsrPEV1Yl6
         08UpNMFyYuWWFcEj2yKHsoearKx6Jz3VVioisigHzXx4gM7saURmFvEikOZhMwDAkFNW
         PHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=1FhyFNuNdGOauTgx0a9O8mAiD2rN6gpyJ0yQBsAAR8c=;
        b=sr4/RNjJ1RBw9Ko/QBIUhy9H6eldP6i0cNNUiGKB3fhZ6oEeHs2+hsa9zP2Pmvd1mD
         sQrHvOcvSA3//4xzVvsue3s3oYgn3l3eWDMLbXuQF1sk2PHGJ5HRwrPiM9ifOF7jp1/a
         2OKIJHpaEZLSK/OxT9nC60HW6KSdsN4s8qWFOD1XUWn8ipD/lAZs3fARQyPUmmVkRhhs
         uYQ0TOO9Z9CirdE3cLTVC4oRtCziDNjhWY4GoKnnk3MsW35XVEdzSlU2Eiy8jrco89Dg
         3tVZ6gBNsCXziJYggUrH/2WB6ozq2En/R4henGgMFUUBGBF8pGW32uqZC4VSGInzAQTW
         qlkw==
X-Gm-Message-State: APt69E1Qntd78WJW7ytRUWqhbl0qaVWqaMkYanfNXC7ErTwoV+uYcxXZ
        sJTLGxUh+SUE+vHMPxESoZKk/wE+nwbge6DxIYA=
X-Google-Smtp-Source: ADUXVKI9GgxqITKVwwNrcyPuMOVBoOZ2K1fxeLPAsSoY9STLzVDbGoGny24cKZNbg9v8W6G4sADqlz8y/G8Ln4AowFE=
X-Received: by 2002:a1c:d8:: with SMTP id 207-v6mr1873815wma.99.1529506646567;
 Wed, 20 Jun 2018 07:57:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:5c8d:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 07:57:05
 -0700 (PDT)
Reply-To: andrea.merello@gmail.com
In-Reply-To: <DM6PR02MB436181CD5544B0FA95318077C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com>
 <20180620083653.17010-5-andrea.merello@gmail.com> <DM6PR02MB436181CD5544B0FA95318077C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 20 Jun 2018 16:57:05 +0200
Message-ID: <CAN8YU5OMgOv6JUAA5PrMGihhVgPE3=c3KJk-LXJoO2Zt1WcKPA@mail.gmail.com>
Subject: Re: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
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

On Wed, Jun 20, 2018 at 4:43 PM, Radhey Shyam Pandey <radheys@xilinx.com> wrote:
>> -----Original Message-----
>> From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
>> owner@vger.kernel.org] On Behalf Of Andrea Merello
>> Sent: Wednesday, June 20, 2018 2:07 PM
>> To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
>> <michals@xilinx.com>; Appana Durga Kedareswara Rao
>> <appanad@xilinx.com>; dmaengine@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> Andrea Merello <andrea.merello@gmail.com>
>> Subject: [PATCH 5/6] dmaengine: xilinx_dma: autodetect whether the HW
>> supports scatter-gather
>>
>> The HW can be either direct-access or scatter-gather version. These are
>> SW incompatible.
>>
>> The driver can handle both version: a DT property was used to
>> tell the driver whether to assume the HW is is scatter-gather mode.
>>
>> This patch makes the driver to autodetect this information. The DT
>> property is not required anymore.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index bdbc8ba9092a..8c6e818e596f 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -86,6 +86,7 @@
>>  #define XILINX_DMA_DMASR_DMA_DEC_ERR         BIT(6)
>>  #define XILINX_DMA_DMASR_DMA_SLAVE_ERR               BIT(5)
>>  #define XILINX_DMA_DMASR_DMA_INT_ERR         BIT(4)
>> +#define XILINX_DMA_DMASR_SG_MASK             BIT(3)
>>  #define XILINX_DMA_DMASR_IDLE                        BIT(1)
>>  #define XILINX_DMA_DMASR_HALTED              BIT(0)
>>  #define XILINX_DMA_DMASR_DELAY_MASK          GENMASK(31, 24)
>> @@ -407,7 +408,6 @@ struct xilinx_dma_config {
>>   * @dev: Device Structure
>>   * @common: DMA device structure
>>   * @chan: Driver specific DMA channel
>> - * @has_sg: Specifies whether Scatter-Gather is present or not
>>   * @mcdma: Specifies whether Multi-Channel is present or not
>>   * @flush_on_fsync: Flush on frame sync
>>   * @ext_addr: Indicates 64 bit addressing is supported by dma device
>> @@ -426,7 +426,6 @@ struct xilinx_dma_device {
>>       struct device *dev;
>>       struct dma_device common;
>>       struct xilinx_dma_chan
>> *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
>> -     bool has_sg;
>>       bool mcdma;
>>       u32 flush_on_fsync;
>>       bool ext_addr;
>> @@ -2391,7 +2390,6 @@ static int xilinx_dma_chan_probe(struct
>> xilinx_dma_device *xdev,
>>
>>       chan->dev = xdev->dev;
>>       chan->xdev = xdev;
>> -     chan->has_sg = xdev->has_sg;
>>       chan->desc_pendingcount = 0x0;
>>       chan->ext_addr = xdev->ext_addr;
>>       /* This variable ensures that descriptors are not
>> @@ -2488,6 +2486,13 @@ static int xilinx_dma_chan_probe(struct
>> xilinx_dma_device *xdev,
>>               chan->stop_transfer = xilinx_dma_stop_transfer;
>>       }
>>
>> +     /* check if SG is enabled */
>> +     if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
>> +             XILINX_DMA_DMASR_SG_MASK)
> I think SGIncld mask is only applicable for AXI DMA and CDMA IP.
> For VDMA IP this bit is reserved.

OK. I can make it conditional wrt the IP type. As far as I can see
VDMA IP has not the two (SG vs no-SG) variant at all, so all should be
still OK.

> .
>> +             chan->has_sg = true;
>> +     dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
>> +             chan->has_sg ? "enabled" : "disabled");
>> +
>>       /* Initialize the tasklet */
>>       tasklet_init(&chan->tasklet, xilinx_dma_do_tasklet,
>>                       (unsigned long)chan);
>> @@ -2626,7 +2631,6 @@ static int xilinx_dma_probe(struct platform_device
>> *pdev)
>>               return PTR_ERR(xdev->regs);
>>
>>       /* Retrieve the DMA engine properties from the device tree */
>> -
> Unrelated change

Oops.. Sorry.

>
>>       if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
>>               xdev->mcdma = of_property_read_bool(node, "xlnx,mcdma");
>>               err = of_property_read_u32(node, "xlnx,lengthregwidth",
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
