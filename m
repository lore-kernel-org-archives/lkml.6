Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66316C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358F8213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rt+n9xiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfBYNbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:31:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37133 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbfBYNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:31:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id m12so7556785edv.4;
        Mon, 25 Feb 2019 05:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57oQ2o4V5orS4cTes6nGMZZBv36lxjCx8o3Sf9yfq78=;
        b=rt+n9xiGzBU1qD2mExYcd8nvdtdLLUwrBScMh6pnrtB4o2gAUnomVw2iXH0CoLTY/S
         LteGFI4FMGru0KnJp6sMB2q9EC6Y/fCZUpT8OA/k8gUwBNF212AMmH4GfcKn0EgegFua
         Eh+86LjP3fJNEyG3ZkP2SvmVypkEJa1yaGb2eKYQ0HPYHgeiwko6XZji4QmEOkkB866k
         g6S4JxL7c3nA050+SwShC+OWIKmrzv2jEePqUy0KmC4I8Ns0cYt11AtKMBP8Uqa1fRpt
         g6QF4FhYMAy07HBlG5Bbkh/JaWfojwVOWHFaGnu+qPMg3/oTpkHaoPaFZNS/Kkm1bDOq
         fBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57oQ2o4V5orS4cTes6nGMZZBv36lxjCx8o3Sf9yfq78=;
        b=mapWrFD59mIIyJ79Zw26D/6rI+n+HIT56B1V4w5e/1CSIXj/LvmgxILkWL4+p89eH8
         z4BCUEjMxRR7hq7MiT7dDIDifES+LuWRks72Dxylr/Zx5A8wmprph73IZlMbAgU+coCM
         D3FhTjraJz+mSYZbVlVmTtenc8BISisBp8Bpb+xOI6jZ09TQ4dSveoFnMcu3sWDUnAiw
         AUIl9uaSZU5k9hs/RXmhok1SbPzUfPgYsnDI489kLlsHDGZ50ChFu6l+eyBrhK9o/ZmL
         QSnpHrLwi8k/GS34fRr48+4a1JNxCHsAm5dA5BXakluIVhQnFX9Nc4Jhn/aCEoxXEPev
         duFw==
X-Gm-Message-State: AHQUAuaoG7QHpScb4GMxWCPruppW3v3LrwnOBEHbvGY9P2kOj57Rh9n8
        /1LiQQBAzc0+PyWk44hAuGuOHGM1MpuxPz3i2kk=
X-Google-Smtp-Source: AHgI3IY7bXbCLZIso2EcuMRIPiXC7nAYQg5j9xgV2vgIIoW8jpq6j31e++PDwfdvKVUentvVl1dOs0Pvhg2wLpqEgmo=
X-Received: by 2002:a17:906:f1d8:: with SMTP id gx24mr13013720ejb.227.1551101503721;
 Mon, 25 Feb 2019 05:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca> <20190128160323.28170-1-angus@akkea.ca>
 <20190128160323.28170-3-angus@akkea.ca>
In-Reply-To: <20190128160323.28170-3-angus@akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 25 Feb 2019 15:31:32 +0200
Message-ID: <CAEnQRZCPuSgfSWctDrLAXANVAjoN=4AHfoecj=K=2dsWJoVUTw@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] dmaengine: imx-sdma: add a test for imx8mq multi
 sdma devices
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 6:04 PM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> On i.mx8mq, there are two sdma instances, and the common dma framework
> will get a channel dynamically from any available sdma instance whether
> it's the first sdma device or the second sdma device. Some IPs like
> SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
> the correct sdma device, use the node pointer to match.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Thanks Angus for the patch!

Tested-by: Daniel Baluta <daniel.baluta@nxp.com>


> ---
>  drivers/dma/imx-sdma.c                | 6 ++++++
>  include/linux/platform_data/dma-imx.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 757fad2fbfae..d2fae53be689 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1914,11 +1914,16 @@ static int sdma_init(struct sdma_engine *sdma)
>  static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
>  {
>         struct sdma_channel *sdmac = to_sdma_chan(chan);
> +       struct sdma_engine *sdma = sdmac->sdma;
>         struct imx_dma_data *data = fn_param;
>
>         if (!imx_dma_is_general_purpose(chan))
>                 return false;
>
> +       /* return false if it's not the right device */
> +       if (sdma->dev->of_node != data->of_node)
> +               return false;
> +
>         sdmac->data = *data;
>         chan->private = &sdmac->data;
>
> @@ -1946,6 +1951,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>          * be set to sdmac->event_id1.
>          */
>         data.dma_request2 = 0;
> +       data.of_node = ofdma->of_node;
>
>         return dma_request_channel(mask, sdma_filter_fn, &data);
>  }
> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 7d964e787299..9daea8d42a10 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -55,6 +55,7 @@ struct imx_dma_data {
>         int dma_request2; /* secondary DMA request line */
>         enum sdma_peripheral_type peripheral_type;
>         int priority;
> +       struct device_node *of_node;
>  };
>
>  static inline int imx_dma_is_ipu(struct dma_chan *chan)
> --
> 2.17.1
>
