Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FACAC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07BE52087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XwWx8N2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbfA3TFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:05:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:32819 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387478AbfA3TFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:05:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id i26so500741lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ynAO8iDI7f1xWNXGggBNd8fyyz0/WqPhtdZq74Lk9Kk=;
        b=XwWx8N2iqXBW8tR4GiISRfUVRyqQl1/XsIGA6Llvmg35sX/xq36kgBGdg6UieKvBNU
         +FeVWdSuDV6Gy5mmG5o0RafiNBlihZPGVO52Lu3dE7Y5m+rJk+4uSkiK4Ok+gYDuC091
         5gfsbYG6j8OibgG5BnZzI2uTzqCco6dkc2tuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynAO8iDI7f1xWNXGggBNd8fyyz0/WqPhtdZq74Lk9Kk=;
        b=IY25zlX20wTj5oGKLCtefolIAxNDVM6MNqtHX5rlC1lezNflZ5z2XDhRlVGq6lIUoy
         VdIrojMeJdrjpEfKyV4flaCwApMr9IuMWay4PLLvHFcf3g4psoR7s4mGRwjxWC6XgxES
         KH3LKCrF8a2JxMsA4e83RTTukqnGxmA36+2KCUCpYWcOKiZ6RqX3xV5iVU+dFeTvDQsT
         ubvVVmlMSmsvINSfdDAdEjy2wt7BxsFk8wge6MHcLWoWYJHY54ihbcFWw8obj5fx54Jh
         2xOHPbBygCAjezafqPhSenFcdcnXcXeGybMggIg5DPaue78zZ1kDhY/5snJlQrgPcCI4
         uX1A==
X-Gm-Message-State: AJcUukd0KMF9gxPDZPSx0LOfS2P06IPQkpPxdLntnFeZSS57Wf5B4lSe
        8aHh9su0oiviUzBWPsuk3Yk0vVYNPsI=
X-Google-Smtp-Source: ALg8bN4/kaeg3yy6ir5jIuQEk84NJvylYyjXtG8YqZVpYqw7V9aaAbi9wJr+/X1hh8fInmHtsQIpLQ==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr24555817lfc.124.1548875142455;
        Wed, 30 Jan 2019 11:05:42 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id k68-v6sm414807ljb.35.2019.01.30.11.05.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:05:41 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id y11so480682lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:05:40 -0800 (PST)
X-Received: by 2002:a19:7d42:: with SMTP id y63mr25062787lfc.47.1548875140072;
 Wed, 30 Jan 2019 11:05:40 -0800 (PST)
MIME-Version: 1.0
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
In-Reply-To: <1546314952-15990-16-git-send-email-yong.wu@mediatek.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 30 Jan 2019 11:05:03 -0800
X-Gmail-Original-Message-ID: <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
Message-ID: <CAE=gft6XDC3YGe20iDOpCO0ASg99hucu7rKJwt+5i+3vgrEFvg@mail.gmail.com>
Subject: Re: [PATCH v5 15/20] memory: mtk-smi: Invoke pm runtime_callback to
 enable clocks
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2018 at 7:59 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> This patch only move the clk_prepare_enable and config_port into the
> runtime suspend/resume callback. It doesn't change the code content
> and sequence.
>
> This is a preparing patch for adjusting SMI_BUS_SEL for mt8183.
> (SMI_BUS_SEL need to be restored after smi-common resume every time.)
> Also it gives a chance to get rid of mtk_smi_larb_get/put which could
> be a next topic.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I believe this refactoring is a no-op as described, because the order is still:
1) mtk_smi_clk_enable(common)
2) mtk_smi_clk_enable(larb)
3) larb_gen->config_port()

And teardown still happens in the opposite order, except for
config_port, which they seem not to do in suspend.
So, looks good to me.

Reviewed-by: Evan Green <evgreen@chromium.org>

> ---
>  drivers/memory/mtk-smi.c | 113 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 72 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index a430721..9790801 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -86,17 +86,13 @@ struct mtk_smi_larb { /* larb: local arbiter */
>         u32                             *mmu;
>  };
>
> -static int mtk_smi_enable(const struct mtk_smi *smi)
> +static int mtk_smi_clk_enable(const struct mtk_smi *smi)
>  {
>         int ret;
>
> -       ret = pm_runtime_get_sync(smi->dev);
> -       if (ret < 0)
> -               return ret;
> -
>         ret = clk_prepare_enable(smi->clk_apb);
>         if (ret)
> -               goto err_put_pm;
> +               return ret;
>
>         ret = clk_prepare_enable(smi->clk_smi);
>         if (ret)
> @@ -118,59 +114,28 @@ static int mtk_smi_enable(const struct mtk_smi *smi)
>         clk_disable_unprepare(smi->clk_smi);
>  err_disable_apb:
>         clk_disable_unprepare(smi->clk_apb);
> -err_put_pm:
> -       pm_runtime_put_sync(smi->dev);
>         return ret;
>  }
>
> -static void mtk_smi_disable(const struct mtk_smi *smi)
> +static void mtk_smi_clk_disable(const struct mtk_smi *smi)
>  {
>         clk_disable_unprepare(smi->clk_gals1);
>         clk_disable_unprepare(smi->clk_gals0);
>         clk_disable_unprepare(smi->clk_smi);
>         clk_disable_unprepare(smi->clk_apb);
> -       pm_runtime_put_sync(smi->dev);
>  }
>
>  int mtk_smi_larb_get(struct device *larbdev)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> -       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> -       int ret;
> +       int ret = pm_runtime_get_sync(larbdev);
>
> -       /* Enable the smi-common's power and clocks */
> -       ret = mtk_smi_enable(common);
> -       if (ret)
> -               return ret;
> -
> -       /* Enable the larb's power and clocks */
> -       ret = mtk_smi_enable(&larb->smi);
> -       if (ret) {
> -               mtk_smi_disable(common);
> -               return ret;
> -       }
> -
> -       /* Configure the iommu info for this larb */
> -       larb_gen->config_port(larbdev);
> -
> -       return 0;
> +       return (ret < 0) ? ret : 0;
>  }
>  EXPORT_SYMBOL_GPL(mtk_smi_larb_get);
>
>  void mtk_smi_larb_put(struct device *larbdev)
>  {
> -       struct mtk_smi_larb *larb = dev_get_drvdata(larbdev);
> -       struct mtk_smi *common = dev_get_drvdata(larb->smi_common_dev);
> -
> -       /*
> -        * Don't de-configure the iommu info for this larb since there may be
> -        * several modules in this larb.
> -        * The iommu info will be reset after power off.
> -        */
> -
> -       mtk_smi_disable(&larb->smi);
> -       mtk_smi_disable(common);
> +       pm_runtime_put_sync(larbdev);
>  }
>  EXPORT_SYMBOL_GPL(mtk_smi_larb_put);
>
> @@ -385,12 +350,52 @@ static int mtk_smi_larb_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +       const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
> +       int ret;
> +
> +       /* Power on smi-common. */
> +       ret = pm_runtime_get_sync(larb->smi_common_dev);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to pm get for smi-common(%d).\n", ret);
> +               return ret;
> +       }
> +
> +       ret = mtk_smi_clk_enable(&larb->smi);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to enable clock(%d).\n", ret);
> +               pm_runtime_put_sync(larb->smi_common_dev);
> +               return ret;
> +       }
> +
> +       /* Configure the basic setting for this larb */
> +       larb_gen->config_port(dev);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
> +{
> +       struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> +
> +       mtk_smi_clk_disable(&larb->smi);
> +       pm_runtime_put_sync(larb->smi_common_dev);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops smi_larb_pm_ops = {
> +       SET_RUNTIME_PM_OPS(mtk_smi_larb_suspend, mtk_smi_larb_resume, NULL)
> +};
> +
>  static struct platform_driver mtk_smi_larb_driver = {
>         .probe  = mtk_smi_larb_probe,
>         .remove = mtk_smi_larb_remove,
>         .driver = {
>                 .name = "mtk-smi-larb",
>                 .of_match_table = mtk_smi_larb_of_ids,
> +               .pm             = &smi_larb_pm_ops,
>         }
>  };
>
> @@ -489,12 +494,38 @@ static int mtk_smi_common_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static int __maybe_unused mtk_smi_common_resume(struct device *dev)
> +{
> +       struct mtk_smi *common = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = mtk_smi_clk_enable(common);
> +       if (ret) {
> +               dev_err(common->dev, "Failed to enable clock(%d).\n", ret);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static int __maybe_unused mtk_smi_common_suspend(struct device *dev)
> +{
> +       struct mtk_smi *common = dev_get_drvdata(dev);
> +
> +       mtk_smi_clk_disable(common);
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops smi_common_pm_ops = {
> +       SET_RUNTIME_PM_OPS(mtk_smi_common_suspend, mtk_smi_common_resume, NULL)
> +};
> +
>  static struct platform_driver mtk_smi_common_driver = {
>         .probe  = mtk_smi_common_probe,
>         .remove = mtk_smi_common_remove,
>         .driver = {
>                 .name = "mtk-smi-common",
>                 .of_match_table = mtk_smi_common_of_ids,
> +               .pm             = &smi_common_pm_ops,
>         }
>  };
>
> --
> 1.9.1
>
