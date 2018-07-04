Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEDBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A614B208B1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 16:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFXhV8q/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A614B208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeGDQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 12:40:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34993 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752165AbeGDQkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 12:40:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id q7-v6so1964025pff.2;
        Wed, 04 Jul 2018 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j+upXkgERpePvjNZspRqtBidgvJTrSCYmZ5cK1m5E0Y=;
        b=LFXhV8q/fmEJlGrTISMSQlzSDI3D/0oW5C9yUfObTx8GqU9IwaCT/kYpgRtSAptKmm
         xtTN6SAs8ppV/ENK8nGh0EEEPbXvuO2bvdSwj6qugQ86wKgIPiZgn1rIFYQfFQiAxDn6
         nWksup5/xVSN9yrnWzdwOfIp79/PPWX744jas75wkYekWEO+7rPR9giJzuhEqdBmhe62
         qoVpUEIqbF1C1VNBYtTkfYXS2AdCETqfUMraI5ZXSQh18OfjkPicm1rIUnpQISX84J3e
         od1x4FhRbQMTSbX4FouyRdPcAWXsZ3sxsYqXZPvnmy1PqDLPjl9FoVIQ9SV5psnp8prc
         MOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j+upXkgERpePvjNZspRqtBidgvJTrSCYmZ5cK1m5E0Y=;
        b=BxMQntW//bWC1MkKT0EaGp4ZqwbZOIqGF5m/FATzKvb0vEUKiNgFZk07j1UqZ/Xmo7
         okJsXY4a7PgPsxZx3c86RnksTKz0ras0+6lBVMlAgsv21/ErN5sbnnCbEgSE2b6KPwv/
         UYW2LVHH7egWJkNA6AbhyicNCv2wMFAM+8v+++HWSjjzK3gDaKn7WFh0W3HI0GsKwZeX
         L1Wm8i6Rwf5mYY2wtRE4TMqSR7pdytFLJSmPlJXp5gYTmXTt2ZmAEmWPciZN+sZRevHa
         2WKQq5u3HYK5UjQC20kPOIrn9tEA6c3A370/4kqyEIkRXMMxt/V1QDu0wU1W+4O6/HJH
         jNSA==
X-Gm-Message-State: APt69E0YTfcDiPTDIXMXDonu73l2SwOHKR2s4x6PK2YXb64/WYZXnGlu
        wzGz/yQ4/pMGjX5ekpgv8vtT+XtcRThOGkJTHlQ=
X-Google-Smtp-Source: AAOMgpc7dZdAqk4W4z6O89H0DP8fVsgQHFaRd5Ah4AStBxrPnYjaDOQ6bXpJNlaYBjwHkKBmEWTdz7zA29IlYwNzZtU=
X-Received: by 2002:a63:a1a:: with SMTP id 26-v6mr2560270pgk.221.1530722400963;
 Wed, 04 Jul 2018 09:40:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Wed, 4 Jul 2018 09:40:00
 -0700 (PDT)
In-Reply-To: <20180703123214.23090-4-paul@crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-4-paul@crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 4 Jul 2018 22:10:00 +0530
Message-ID: <CANc+2y6iT=cDuzHibBuSvhp4s-e3y+Y4TcC_LBev+WXPaE_1rg@mail.gmail.com>
Subject: Re: [PATCH 03/14] dmaengine: dma-jz4780: Use 4-word descriptors
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
> The only information we use in the 8-word version of the hardware DMA
> descriptor that is not present in the 4-word version is the transfer
> type, aka. the ID of the source or recipient device.
>
> Since the transfer type will never change for a DMA channel in use,
> we can just set it once for all in the corresponding DMA register
> before starting any transfer.
>
> This has several benefits:
>
> * the driver will handle twice as many hardware DMA descriptors;
>
> * the driver is closer to support the JZ4740, which only supports 4-word
>   hardware DMA descriptors;
>
> * the JZ4770 SoC needs the transfer type to be set in the corresponding
>   DMA register anyway, even if 8-word descriptors are in use.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/dma/dma-jz4780.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index 4d234caf5d62..cd2cd70fd843 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -93,17 +93,12 @@
>   * @dtc: transfer count (number of blocks of the transfer size specified in DCM
>   * to transfer) in the low 24 bits, offset of the next descriptor from the
>   * descriptor base address in the upper 8 bits.
> - * @sd: target/source stride difference (in stride transfer mode).
> - * @drt: request type
>   */
>  struct jz4780_dma_hwdesc {
>         uint32_t dcm;
>         uint32_t dsa;
>         uint32_t dta;
>         uint32_t dtc;
> -       uint32_t sd;
> -       uint32_t drt;
> -       uint32_t reserved[2];
>  };
>
>  /* Size of allocations for hardware descriptor blocks. */
> @@ -280,7 +275,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
>                 desc->dcm = JZ_DMA_DCM_SAI;
>                 desc->dsa = addr;
>                 desc->dta = config->dst_addr;
> -               desc->drt = jzchan->transfer_type;
>
>                 width = config->dst_addr_width;
>                 maxburst = config->dst_maxburst;
> @@ -288,7 +282,6 @@ static int jz4780_dma_setup_hwdesc(struct jz4780_dma_chan *jzchan,
>                 desc->dcm = JZ_DMA_DCM_DAI;
>                 desc->dsa = config->src_addr;
>                 desc->dta = addr;
> -               desc->drt = jzchan->transfer_type;
>
>                 width = config->src_addr_width;
>                 maxburst = config->src_maxburst;
> @@ -433,9 +426,10 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_memcpy(
>         tsz = jz4780_dma_transfer_size(dest | src | len,
>                                        &jzchan->transfer_shift);
>
> +       jzchan->transfer_type = JZ_DMA_DRT_AUTO;
> +
>         desc->desc[0].dsa = src;
>         desc->desc[0].dta = dest;
> -       desc->desc[0].drt = JZ_DMA_DRT_AUTO;
>         desc->desc[0].dcm = JZ_DMA_DCM_TIE | JZ_DMA_DCM_SAI | JZ_DMA_DCM_DAI |
>                             tsz << JZ_DMA_DCM_TSZ_SHIFT |
>                             JZ_DMA_WIDTH_32_BIT << JZ_DMA_DCM_SP_SHIFT |
> @@ -490,9 +484,12 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
>                         (jzchan->curr_hwdesc + 1) % jzchan->desc->count;
>         }
>
> -       /* Use 8-word descriptors. */
> -       jz4780_dma_chn_writel(jzdma, jzchan->id,
> -                             JZ_DMA_REG_DCS, JZ_DMA_DCS_DES8);
> +       /* Use 4-word descriptors. */
> +       jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
> +
> +       /* Set transfer type. */
> +       jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DRT,
> +                             jzchan->transfer_type);
>
>         /* Write descriptor address and initiate descriptor fetch. */
>         desc_phys = jzchan->desc->desc_phys +
> @@ -502,7 +499,7 @@ static void jz4780_dma_begin(struct jz4780_dma_chan *jzchan)
>
>         /* Enable the channel. */
>         jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS,
> -                             JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
> +                             JZ_DMA_DCS_CTE);
>  }
>
>  static void jz4780_dma_issue_pending(struct dma_chan *chan)
> --
> 2.18.0
>
>

Patch looks good to me.
Reviewed-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>

Regards,
PrasannaKumar
