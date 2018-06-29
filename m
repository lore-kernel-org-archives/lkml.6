Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86B7C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7D820883
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 07:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwEitBZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7D820883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934225AbeF2Hxf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 03:53:35 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39412 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933325AbeF2Hxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 03:53:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so1012065wmc.4;
        Fri, 29 Jun 2018 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YBH2uqY0hK0BNQZg0JYXoXTRozE8wiG2CYSRbiF6C0I=;
        b=nwEitBZYce0xbjg9JBaAlcwQz/Tt4cM0md7Pl0wAiq63zggUshAjkhi2zYJH4vqU41
         3Ctge5zN8qTcQj3DJq8V3KIrJMEpmC/E8jm+GQDT+kAw+QZC7b5DmKTGVNzEDrZfTwDH
         T5sjGP6R9zvP5V+IKAOPRMaQob3tZnaydKtqKIedHqVrr861ZMx/bfxEUtN6KZVCMUa/
         i+d+rXI3p+CyWeNEXSH0H/Fc1/WyvWHJfTfwjAaPhBOaYOGZ62Lof3LKsJ8BqOA9DrdM
         CLIsLOY3eV4v4KUwl1j4UtVmMNHggoSlUnVypW4Nf76BYB8WfSkic+F9PHZfm7MlLroi
         C+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=YBH2uqY0hK0BNQZg0JYXoXTRozE8wiG2CYSRbiF6C0I=;
        b=JmfUWPmjFEKtpogfyKF0Pro6Ax7J4Wr6xftm1WJYf5JsbpQT4v5kEYSovnN4V3NskU
         BeLESag1Vy7Tb65hE2yHSGaItf7FAumjFT16eFZ9JIQPi77pP6jEGL0YEJ8IRjB5WOuz
         K6lxxQj0WNxgpdaAYH7js0+fNYnMUzio8YHKZis3q7RfybNDJABdGCPIEWa7N8b7nifh
         96YBQzTPBbrKasMUM15o4bDRTHPOmSWd4HU3aOrVD08MqV4t0JhsytaMApmOEaJpdL2w
         saRZ0C3bGb6G4FGZjrrVqx8TfQA+SOYqr8vvMg4YACxXslHxQX/oY9HpVuO/8L5lFTOE
         u58Q==
X-Gm-Message-State: APt69E3E3QjrYS7iU6OF5UWMPHvEP4y8tWIxLWAZpehiQtzsO7C4SH8C
        A5oPAyvW4xUDYG9V0kNmX1iV2nbLO3skSPAKRC8=
X-Google-Smtp-Source: AAOMgpcSxJBbyFTI7FYSUvY073NCL22P+nDk8uNs1J1HEPLdU2hhLB1aAOJ+KDC42BCWcrVT9xKbZ5iWv6Zh1LORJVY=
X-Received: by 2002:a1c:4a06:: with SMTP id x6-v6mr987335wma.89.1530258811597;
 Fri, 29 Jun 2018 00:53:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:5c8d:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 00:53:11
 -0700 (PDT)
Reply-To: andrea.merello@gmail.com
In-Reply-To: <20180629073707.GZ22377@vkoul-mobl>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180625092724.22164-4-andrea.merello@gmail.com> <20180629073707.GZ22377@vkoul-mobl>
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Fri, 29 Jun 2018 09:53:11 +0200
Message-ID: <CAN8YU5Mmzko0DeoCbCCpS7DyahrUddqWf+PxZNxT3rHanJT-Ag@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] dmaengine: xilinx_dma: autodetect whether the HW
 supports scatter-gather
To:     Vinod <vkoul@kernel.org>
Cc:     dan.j.williams@intel.com, michal.simek@xilinx.com,
        appana.durga.rao@xilinx.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 9:37 AM, Vinod <vkoul@kernel.org> wrote:
> On 25-06-18, 11:27, Andrea Merello wrote:
>> The AXIDMA and CDMA HW can be either direct-access or scatter-gather
>> version. These are SW incompatible.
>>
>> The driver can handle both version: a DT property was used to
>                                 ^^^^
> versions
>

OK

>> tell the driver whether to assume the HW is is scatter-gather mode.
>                                            ^^^^^
> is in?

Yes, it is. Thanks

>>
>> This patch makes the driver to autodetect this information. The DT
>> property is not required anymore.
>>
>> No changes for VDMA.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
>> ---
>> Changes in v2:
>>       - autodetect only in !VDMA case
>> Changes in v3:
>>       - cc DT maintainers/ML
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
>>  1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index 7f0ab904b749..43fcc71ff287 100644
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
>> @@ -406,7 +407,6 @@ struct xilinx_dma_config {
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
>>       struct xilinx_dma_chan *chan[XILINX_DMA_MAX_CHANS_PER_DEVICE];
>> -     bool has_sg;
>>       bool mcdma;
>>       u32 flush_on_fsync;
>>       bool ext_addr;
>> @@ -2393,7 +2392,6 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>>
>>       chan->dev = xdev->dev;
>>       chan->xdev = xdev;
>> -     chan->has_sg = xdev->has_sg;
>>       chan->desc_pendingcount = 0x0;
>>       chan->ext_addr = xdev->ext_addr;
>>       /* This variable ensures that descriptors are not
>> @@ -2486,6 +2484,15 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>>               chan->stop_transfer = xilinx_dma_stop_transfer;
>>       }
>>
>> +     /* check if SG is enabled (only for AXIDMA and CDMA) */
>> +     if (xdev->dma_config->dmatype != XDMA_TYPE_VDMA) {
>> +             if (dma_ctrl_read(chan, XILINX_DMA_REG_DMASR) &
>> +                 XILINX_DMA_DMASR_SG_MASK)
>
> why not read this for VDMA too, will it return false?

AFAIK this bit is reserved in VDMA, so reading it can lead to any
random thing.. I would say that potentially it could even be used for
other purposes in future IP releases..

>> +                     chan->has_sg = true;
>> +             dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
>> +                     chan->has_sg ? "enabled" : "disabled");
>
> this debug print can be removed

IMHO if someone will ever enable debug prints for debugging something
and then he/she reports us a log, then it would be useful to see in
the log if the IP was SG or not..

> --
> ~Vinod
