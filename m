Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEADC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA81720836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/0juxyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA81720836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeFTNPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:15:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35554 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753952AbeFTNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:15:33 -0400
Received: by mail-wr0-f196.google.com with SMTP id l8-v6so1711003wrr.2;
        Wed, 20 Jun 2018 06:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tB73JhffxrpYdtji+q3qnZzVuto+tI3jWk47X3c1nvA=;
        b=S/0juxyilLFA4aaUga/27I71xkSW3d1tw24uJNM9BA+a8ybsDwBUtSi0Ik49QRblqy
         mNgu+1TxjELlWRgFE4mXls4v9rcRfrl7yaFzAQNN7u8srFWC3F+Jdngswv6oyWS8RkC1
         ONUT/+DiVofLpsmI6AvednVMxLQUSO3DVdovTmEUHAN0NPE54ZxWxS879/NkMLz18KtU
         BEt3Jv12H+xoMAS/O9SWcmtKkkRDH2wlv7Q8NKtV/iF88/NdN8Tpq1C+l5RqmsoXxdef
         U5i4NUhoKsOwCIz3TycAmMAPMtND/bP04NNCegpxctzYC6GZoJLD+H36lZEi3ajSlUZM
         ACrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=tB73JhffxrpYdtji+q3qnZzVuto+tI3jWk47X3c1nvA=;
        b=iIjjpooqXCPSK0MHhE5wtwxS1/iZ03CYaFXkz4JKFRrAf3FcUfQWTYQShqtyzbW5Ej
         qah6q/bCNinW/9NWGau3FH430O0mzgxMBro4XwkhIFdnEiWvsKpqYy0XcRjAuXOSfEkI
         3bX1Bg1V579eP9HoA6YoSjbyfX2Szk5Sg1P6fl5InQwsbJid8W1iy7d7s3aWlHW67Do2
         L9L6nhOQDVdk+VfgS0Zldds4Aij5h/tLiQhsWFUITXagUqWxHvEvjOfKSv5BEqAYggVs
         1Mcs59+7y94E2g1XgXuj63xWECxmRuYQWoWaapVi5hSRxBs+OmZFhKy0UZHcJVtrJmNh
         geoA==
X-Gm-Message-State: APt69E3sQNAF9VqKtYk8Rz9GQ2lFqq/4/M4xBoayYVA8QtU6IFVMenO4
        9YmFLIOePp2fjSdtvZh3daHoS8uLrKhJWJMH6sM=
X-Google-Smtp-Source: ADUXVKKfjWPsDyMfAsl8c1LxI18yuCv4pDQBfdUdE0XkzdIHRgmA2nNsKzlg3pifs2G3QbeUfPAMpbHSM7wePgoYTbY=
X-Received: by 2002:adf:9025:: with SMTP id h34-v6mr19026421wrh.123.1529500532253;
 Wed, 20 Jun 2018 06:15:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:5c8d:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 06:15:11
 -0700 (PDT)
Reply-To: andrea.merello@gmail.com
In-Reply-To: <DM6PR02MB4361458180616B591C6742E2C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <20180620083653.17010-1-andrea.merello@gmail.com> <DM6PR02MB4361458180616B591C6742E2C7770@DM6PR02MB4361.namprd02.prod.outlook.com>
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Wed, 20 Jun 2018 15:15:11 +0200
Message-ID: <CAN8YU5N8en1dtUShuK=0KCtLk3v4kVqm-TcM4J0=XBZo0=Sh-A@mail.gmail.com>
Subject: Re: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes misalignments
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

On Wed, Jun 20, 2018 at 1:37 PM, Radhey Shyam Pandey <radheys@xilinx.com> wrote:
>> -----Original Message-----
>> From: dmaengine-owner@vger.kernel.org [mailto:dmaengine-
>> owner@vger.kernel.org] On Behalf Of Andrea Merello
>> Sent: Wednesday, June 20, 2018 2:07 PM
>> To: vkoul@kernel.org; dan.j.williams@intel.com; Michal Simek
>> <michals@xilinx.com>; Appana Durga Kedareswara Rao
>> <appanad@xilinx.com>; dmaengine@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
>> Andrea Merello <andrea.merello@gmail.com>
>> Subject: [PATCH 1/6] dmaengine: xilinx_dma: fix splitting transfer causes
>> misalignments
>
> We should rephrase commit message to something like "In axidma
> slave_sg and dma_cylic mode align split descriptors"

OK

>>
>> Whenever a single or cyclic transaction is prepared, the driver
>> could eventually split it over several SG descriptors in order
>> to deal with the HW maximum transfer length.
>>
>> This could end up in DMA operations starting from a misaligned
>> address. This seems fatal for the HW.
> This seems fatal for the HW if DRE is not enabled.

OK

>>
>> This patch eventually adjusts the transfer size in order to make sure
>> all operations start from an aligned address.
>>
>> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
>> ---
>>  drivers/dma/xilinx/xilinx_dma.c | 27 ++++++++++++++++++++-------
>>  1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
>> index 27b523530c4a..a516e7ffef21 100644
>> --- a/drivers/dma/xilinx/xilinx_dma.c
>> +++ b/drivers/dma/xilinx/xilinx_dma.c
>> @@ -376,6 +376,7 @@ struct xilinx_dma_chan {
>>       void (*start_transfer)(struct xilinx_dma_chan *chan);
>>       int (*stop_transfer)(struct xilinx_dma_chan *chan);
>>       u16 tdest;
>> +     u32 copy_mask;
> We can reuse copy_align itself.  See below.

OK

>>  };
>>
>>  /**
>> @@ -1789,10 +1790,14 @@ static struct dma_async_tx_descriptor
>> *xilinx_dma_prep_slave_sg(
>>
>>                       /*
>>                        * Calculate the maximum number of bytes to transfer,
>> -                      * making sure it is less than the hw limit
>> +                      * making sure it is less than the hw limit and that
>> +                      * the next chuck start address is aligned
>
> /s/chuck/chunk

OK

>>                        */
>> -                     copy = min_t(size_t, sg_dma_len(sg) - sg_used,
>> -                                  XILINX_DMA_MAX_TRANS_LEN);
>> +                     copy = sg_dma_len(sg) - sg_used;
>> +                     if (copy > XILINX_DMA_MAX_TRANS_LEN)
>> +                             copy = XILINX_DMA_MAX_TRANS_LEN &
>> +                                     chan->copy_mask;
>> +
>
>
> In below implementation, we can reuse copy_align.
> Same for dma_cyclic.
>
> if ((copy + sg_used  < sg_dma_len(sg)) &&
>         chan->xdev->common.copy_align) {
>         /* If this is not the last descriptor, make sure
>           * the next one will be properly aligned
>          */
>         copy = rounddown(copy,
>                (1 << chan->xdev->common.copy_align));
>      }

OK for the general idea. But to me it seems a bit more complicated than needed:
What's the point in setting 'copy' with min_t, performing also the
subtraction sg_dma_len(sg) - sg_used, and then add sg_used again? What
about something like:


-                       copy = min_t(size_t, sg_dma_len(sg) - sg_used,
-                                    XILINX_DMA_MAX_TRANS_LEN);
+                       copy = sg_dma_len(sg) - sg_used;
+                       if (copy > XILINX_DMA_MAX_TRANS_LEN &&
+                           chan->xdev->common.copy_align)
+                               copy = rounddown(XILINX_DMA_MAX_TRANS_LEN,
+                                        (1 << chan->xdev->common.copy_align));
+


>>                       hw = &segment->hw;
>>
>>                       /* Fill in the descriptor */
>> @@ -1894,10 +1899,14 @@ static struct dma_async_tx_descriptor
>> *xilinx_dma_prep_dma_cyclic(
>>
>>                       /*
>>                        * Calculate the maximum number of bytes to transfer,
>> -                      * making sure it is less than the hw limit
>> +                      * making sure it is less than the hw limit and that
>> +                      * the next chuck start address is aligned
>>                        */
>> -                     copy = min_t(size_t, period_len - sg_used,
>> -                                  XILINX_DMA_MAX_TRANS_LEN);
>> +                     copy = period_len - sg_used;
>> +                     if (copy > XILINX_DMA_MAX_TRANS_LEN)
>> +                             copy = XILINX_DMA_MAX_TRANS_LEN &
>> +                                     chan->copy_mask;
>> +
>>                       hw = &segment->hw;
>>                       xilinx_axidma_buf(chan, hw, buf_addr, sg_used,
>>                                         period_len * i);
>> @@ -2402,8 +2411,12 @@ static int xilinx_dma_chan_probe(struct
>> xilinx_dma_device *xdev,
>>       if (width > 8)
>>               has_dre = false;
>>
>> -     if (!has_dre)
>> +     if (has_dre) {
>> +             chan->copy_mask = ~0;
>> +     } else {
>>               xdev->common.copy_align = fls(width - 1);
>> +             chan->copy_mask = ~(width - 1);
>> +     }
>
> As mentioned above we don't need this additional field.

OK

>>
>>       if (of_device_is_compatible(node, "xlnx,axi-vdma-mm2s-channel") ||
>>           of_device_is_compatible(node, "xlnx,axi-dma-mm2s-channel") ||
>> --
>> 2.17.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
