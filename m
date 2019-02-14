Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272EF222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 06:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="htdykzQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392594AbfBNGCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 01:02:34 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41135 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfBNGCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 01:02:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id u188so2925143qkh.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 22:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fjYk8M+ZpYBHIdl3SpuI+eMPnvXJ1FTwPx90gKG5ags=;
        b=htdykzQ6xRtqzlK300swdx4zlf+eSRWKvGd++NszWWrVAyevn5sSGjQoFRgg53bRt3
         ODwpAL2JsbRsFvSlgHHkg4s1+qIX1HzXzHJtKmgzuGWqNgc29TKbBAlgmPc2Dxr6XWi5
         cLo/mQsXn0b4UBcivhHQG1LMWDCEvVM+hQOUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fjYk8M+ZpYBHIdl3SpuI+eMPnvXJ1FTwPx90gKG5ags=;
        b=JudbI8DExtoHMblQVsQsGf7SWaAtFa21++eTqpveutkqhryqoFVHQtWuHxfDTz3AAL
         c98SEfpAJKSEox6eInjfR84L4NvwfPsYsNRHos7xI3hNMVLeo3Kfom5sbzT0Uklg3Lpc
         kBEYz05PA7J/gjqbGypBdba32tDA8sZ443bTJ0uDH8tVQDGFXsEC7O0lSDlAPqtJk18z
         mA0YOKyjxLdkZHib+fSbdtuzUsL8kAjC++eNg+PnRFN7+ENTdyP44CgKnYp/4Z1TwsJh
         nEDDYFZ4b4RU193LKaFJpNz0AAn1NizfrC3FTxhJ4klRRIrWiNBsEykStazTvatqmRPk
         8HFQ==
X-Gm-Message-State: AHQUAubD5FlNN0BoVi5m+AWfZIAeaBusFZlHae9ejI817ygUbblBdWk0
        S0YWWiPKnQiz99dm4ciLP1iw4lf9H9RRvHAH9QuKjw==
X-Google-Smtp-Source: AHgI3Iby8fhzCIwktkWL4Ujf0oyJahj4kZsiZDwr2lsB2cT0Yffc5bVfRKg2O4WsTWc1D/2jb9WkzHFYqVAoonPJNDw=
X-Received: by 2002:a37:4d57:: with SMTP id a84mr1433821qkb.288.1550124152382;
 Wed, 13 Feb 2019 22:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
In-Reply-To: <20190214044243.129920-1-jitao.shi@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 14 Feb 2019 14:02:21 +0800
Message-ID: <CANMq1KC+ga-Sjxj6eD51nLmq_54Y-gpJR_8qOLQee5gAy7ypkQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/mediatek: move mipi_dsi_host_register to probe
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        cawa cheng <cawa.cheng@mediatek.com>,
        =?UTF-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= 
        <bibby.hsieh@mediatek.com>, CK HU <ck.hu@mediatek.com>,
        stonea168@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just some comments on the error path, I'm not sure about the change itself.

On Thu, Feb 14, 2019 at 12:42 PM Jitao Shi <jitao.shi@mediatek.com> wrote:
>
> DSI panel driver need attach function which is inculde in
> mipi_dsi_host_ops.
>
> If mipi_dsi_host_register is not in probe, dsi panel will
> probe fail or more delay.
>
> So move the mipi_dsi_host_register to probe from bind.
>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 49 ++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 27b507eb4a99..93fa255b4aad 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>                 return ret;
>         }
>
> -       ret = mipi_dsi_host_register(&dsi->host);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to register DSI host: %d\n", ret);
> -               goto err_ddp_comp_unregister;
> -       }
> -
>         ret = mtk_dsi_create_conn_enc(drm, dsi);
>         if (ret) {
>                 DRM_ERROR("Encoder create failed with %d\n", ret);
> @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>         return 0;
>
>  err_unregister:
> -       mipi_dsi_host_unregister(&dsi->host);
> -err_ddp_comp_unregister:
>         mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>         return ret;
>  }
> @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>
>         dsi->host.ops = &mtk_dsi_ops;
>         dsi->host.dev = dev;
> +       dsi->dev = dev;
> +       ret = mipi_dsi_host_register(&dsi->host);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register DSI host: %d\n", ret);
> +               return -EPROBE_DEFER;

return ret

> +       }
>
>         ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>                                           &dsi->panel, &dsi->bridge);
>         if (ret)
> -               return ret;
> +               goto err_unregister_host;
>
>         dsi->engine_clk = devm_clk_get(dev, "engine");
>         if (IS_ERR(dsi->engine_clk)) {
>                 ret = PTR_ERR(dsi->engine_clk);
>                 dev_err(dev, "Failed to get engine clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->digital_clk = devm_clk_get(dev, "digital");
>         if (IS_ERR(dsi->digital_clk)) {
>                 ret = PTR_ERR(dsi->digital_clk);
>                 dev_err(dev, "Failed to get digital clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->hs_clk = devm_clk_get(dev, "hs");
>         if (IS_ERR(dsi->hs_clk)) {
>                 ret = PTR_ERR(dsi->hs_clk);
>                 dev_err(dev, "Failed to get hs clock: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1129,33 +1127,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>         if (IS_ERR(dsi->regs)) {
>                 ret = PTR_ERR(dsi->regs);
>                 dev_err(dev, "Failed to ioremap memory: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         dsi->phy = devm_phy_get(dev, "dphy");
>         if (IS_ERR(dsi->phy)) {
>                 ret = PTR_ERR(dsi->phy);
>                 dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>         if (comp_id < 0) {
>                 dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> -               return comp_id;
> +               ret = comp_id;
> +               goto err_unregister_host;
>         }
>
>         ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
>                                 &mtk_dsi_funcs);
>         if (ret) {
>                 dev_err(dev, "Failed to initialize component: %d\n", ret);
> -               return ret;
> +               goto err_unregister_host;
>         }
>
>         irq_num = platform_get_irq(pdev, 0);
>         if (irq_num < 0) {
>                 dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;

I think you need to do ret = irq_num here, too (and yes, it was
probably wrong before?)

> +               goto err_unregister_host;
>         }
>
>         irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> @@ -1163,14 +1163,25 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>                                IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> -               return -EPROBE_DEFER;
> +               ret = -EPROBE_DEFER;

Ditto, I'd not reassign ret.

> +               goto err_unregister_host;
>         }
>
>         init_waitqueue_head(&dsi->irq_wait_queue);
>
>         platform_set_drvdata(pdev, dsi);
>
> -       return component_add(&pdev->dev, &mtk_dsi_component_ops);
> +       ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
> +       if (ret) {
> +               ret = -EPROBE_DEFER;

Ditto (this one _was_ right before).

> +               goto err_unregister_host;
> +       }
> +
> +       return 0;
> +
> +err_unregister_host:
> +       mipi_dsi_host_unregister(&dsi->host);
> +       return ret;
>  }
>
>  static int mtk_dsi_remove(struct platform_device *pdev)
> --
> 2.20.1
>
