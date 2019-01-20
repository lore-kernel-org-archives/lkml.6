Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4DDC6369F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C53A2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 09:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFql+9qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbfATJ6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 04:58:55 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36453 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfATJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 04:58:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so14388535edb.3;
        Sun, 20 Jan 2019 01:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVKj1nMfR7j7/ER9sbODVHGhgpdJAj3BE1AU8ok7UWk=;
        b=oFql+9qplfj7TakBWabCSYfXBQ+otJlOVcJ7VHsrN6VUZNywoL6ocwCNRBgLKCk1m6
         gaaO8TUEJZD5DdD77veodrt48ah3M1g0ko2vuJUC0gKvx2P4Ms4XCr/JgVvUOiavFj7Z
         gJq4+YMRCumK12dW9nMQgFe4ahxe696wtFM1SeZcPeu5MgncfF8M8syz5i8tK3GDP170
         bL7dkDCcWpmWAx1yqZ0FWeXP1+qhPWywA5wYKuk5MLkClsSF3DSCsAfSQjKz/vKzaBIR
         b9q7ndEvTrDfkmg5c0EU23JUzHhb7OdyycRt8aNiQDmDmZmuR20xIwlQPt8YCi3imxnj
         r8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVKj1nMfR7j7/ER9sbODVHGhgpdJAj3BE1AU8ok7UWk=;
        b=QsxnOgo0H3NaV9aKyrsxKp9l0roYSEJSZNLCSCIFjHmemvN1M3shQsOJPBQSPUfe0y
         rmBaEstp+0EDh21DsomBW3yll3qFNVCWUGq01Cck4HfXEi93ys7qIe71kQ1hq+X6QO83
         M4X3fw4D4QNNyCnlatJIC93155egSaLe76RmI/k2sl2DCrr+VmK8ChNkae3q9QRXjw1o
         IcrrYOLFX8fW78ZyHvTGY/vYgvPZ7cFupLIxfXndWbFdHvqZLediXatNsVDcWXhkr+mc
         nRo8Uf8SSCbdBAAn8c7piPPLa7slLnAES1PLQBhu8kK6yMjDKeH0HB8BPJR6bidTrx0s
         Uj2w==
X-Gm-Message-State: AJcUukf8Fd83A/XWxFPu0qc9tcjrE9u8iqyyM8+x2WKdi69Ggv5erpt4
        Epqi6AyQO6udfD/MHxd6hFvp//KAKQqlKG2EPrw=
X-Google-Smtp-Source: ALg8bN5UApHLmg96dAlZzW0RNAhQnfCA2dLBZ/j7mELlZEERmbJF5icxPUKEU1fHAV8PJW+0TPGZSr7d0nNbk3fUph4=
X-Received: by 2002:a50:b356:: with SMTP id r22mr22806949edd.164.1547978332774;
 Sun, 20 Jan 2019 01:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20190120023150.17138-1-angus@akkea.ca> <20190120023150.17138-3-angus@akkea.ca>
In-Reply-To: <20190120023150.17138-3-angus@akkea.ca>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Sun, 20 Jan 2019 11:58:41 +0200
Message-ID: <CAEnQRZBLLKotGy2t-f3rURnoUCjkxfuwrtYkirv6+kdAzidaFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 4:32 AM Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>
> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
>
> based on NXP commit MLK-16841-1

Hi Angus,

Thanks for doing this!

I'm not sure specifying the MLK here helps. I think it would be better
to somehow add the original Signed-off-by and mention that the commit
was pulled from NXP linux-imx tree.
>
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
>  drivers/dma/imx-sdma.c                        | 20 +++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 3c9a57a8443b..17544c1820b7 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -67,6 +67,7 @@ Optional properties:
>      reg is the GPR register offset.
>      shift is the bit position inside the GPR register.
>      val is the value of the bit (0 or 1).
> +- fsl,ratio-1-1: AHB/SDMA core clock ration 1:1, 2:1 without this.
>
>  Examples:
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 0b3a67ff8e82..65dada21d3c1 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -440,6 +440,8 @@ struct sdma_engine {
>         unsigned int                    irq;
>         dma_addr_t                      bd0_phys;
>         struct sdma_buffer_descriptor   *bd0;
> +       /* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
> +       bool                            clk_ratio;
>  };
>
>  static int sdma_config_write(struct dma_chan *chan,
> @@ -662,8 +664,14 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
>                 dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
>
>         /* Set bits of CONFIG register with dynamic context switching */
> -       if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
> -               writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
> +       if (readl(sdma->regs + SDMA_H_CONFIG) == 0) {
> +               if (sdma->clk_ratio)
> +                       reg = SDMA_H_CONFIG_CSM | SDMA_H_CONFIG_ACR;
> +               else
> +                       reg = SDMA_H_CONFIG_CSM;
> +
> +               writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
> +       }
>
>         return ret;
>  }
> @@ -1880,8 +1888,10 @@ static int sdma_init(struct sdma_engine *sdma)
>         writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
>
>         /* Set bits of CONFIG register but with static context switching */
> -       /* FIXME: Check whether to set ACR bit depending on clock ratios */
> -       writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
> +       if (sdma->clk_ratio)
> +               writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
> +       else
> +               writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
>
>         writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
>
> @@ -1975,6 +1985,8 @@ static int sdma_probe(struct platform_device *pdev)
>         if (!sdma)
>                 return -ENOMEM;
>
> +       sdma->clk_ratio = of_property_read_bool(np, "fsl,ratio-1-1");
> +
>         spin_lock_init(&sdma->channel_0_lock);
>
>         sdma->dev = &pdev->dev;
> --
> 2.17.1
>
