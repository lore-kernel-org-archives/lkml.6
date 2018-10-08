Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B25C676C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AEE620652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 11:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hS296L2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AEE620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJHTDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:03:18 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43300 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeJHTDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:03:17 -0400
Received: by mail-io1-f65.google.com with SMTP id y10-v6so15581053ioa.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=v4+bTw6iDHKh23adZmm02D1aGVtPElNslPeNy/MbO2E=;
        b=hS296L2Fol5BzbIkJrE5y66MSWaBSegVs4GZMcdMX+LnE5AUj/0VjZ2+OKzs7wrrH8
         P1zLUvz7DD0cc4WZ4cYNQQqlZWnNvXiT2cpPLnkKFakhPboNvo4ubcmh4Y/mw+D+4/Bn
         J3RcxRoZhy0LIiusp2rNOtGhcKoFcRgxL0+tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=v4+bTw6iDHKh23adZmm02D1aGVtPElNslPeNy/MbO2E=;
        b=lcs67WebmbMMaIb9qRFyX63tIQr3k5HyYs4LpKf4Uab/LagT3TMLH683sgbfrB8NzJ
         sYDXH6L3jYLjTBZjxMun+QZE0TiEiXWwyV57zGcr/fYnXUfo0j/UirtM25AOQligxKWD
         bMPwECF37lu24NCQvJgBcb1LMbG1PYtTXqC1grcuzMcCIQ08d6XdaCKlkHy2U/26EvT7
         WA3ORpz8Qaef0aLSvI1vyXiI3cbpY9mGeqAg5dkckZVfdt66lpuz+hFAUACyk0ymgrFM
         ECAEF6iCOLh+SqaOwOn+cNQNiUTR/ubm7S9+kjRJtfBzbXS2cMYgBr7dad/URVQPr2hw
         4FRQ==
X-Gm-Message-State: ABuFfoj+nTyF7AumOLsKK2R4rLrvYOSmPId/889gVEZLhJJSaModnAIp
        QJNfASn9eBGsjbtNZNz4QH0tXci4xdu0+oouXcipIQ==
X-Google-Smtp-Source: ACcGV63UGZt0cEoqZQXT3k+mFyaTeoUaFs83hvdue2l+vqlXWyb/A/Wg2DQy+f26XET/LVrs+s7WDLnJI0XJ/gpiFVI=
X-Received: by 2002:a6b:203:: with SMTP id 3-v6mr15031986ioc.131.1538999515514;
 Mon, 08 Oct 2018 04:51:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 04:51:15 -0700 (PDT)
In-Reply-To: <1538188195-3608-2-git-send-email-chaotian.jing@mediatek.com>
References: <1538188195-3608-1-git-send-email-chaotian.jing@mediatek.com> <1538188195-3608-2-git-send-email-chaotian.jing@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Oct 2018 13:51:15 +0200
Message-ID: <CAPDyKFr7BeED5Zzkfacknrh=usBwHXcDF=GGPYNpOb9R7itopA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: mediatek: add bus_clk control
To:     Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 September 2018 at 04:29, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> when gate MSDC0_HCLK, access register will hang, even the MSDC driver
> will never accessing register after HCLK was gated, but for safety, need
> gate the bus_clk(which used to access register) too.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 0484138..1c1c967 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -387,6 +387,7 @@ struct msdc_host {
>
>         struct clk *src_clk;    /* msdc source clock */
>         struct clk *h_clk;      /* msdc h_clk */
> +       struct clk *bus_clk;    /* bus clock which used to access register */
>         struct clk *src_clk_cg; /* msdc source clock control gate */
>         u32 mclk;               /* mmc subsystem clock frequency */
>         u32 src_clk_freq;       /* source clock frequency */
> @@ -660,12 +661,14 @@ static void msdc_gate_clock(struct msdc_host *host)
>  {
>         clk_disable_unprepare(host->src_clk_cg);
>         clk_disable_unprepare(host->src_clk);
> +       clk_disable_unprepare(host->bus_clk);
>         clk_disable_unprepare(host->h_clk);
>  }
>
>  static void msdc_ungate_clock(struct msdc_host *host)
>  {
>         clk_prepare_enable(host->h_clk);
> +       clk_prepare_enable(host->bus_clk);
>         clk_prepare_enable(host->src_clk);
>         clk_prepare_enable(host->src_clk_cg);
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
> @@ -1900,6 +1903,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                 goto host_free;
>         }
>
> +       host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> +       if (IS_ERR(host->bus_clk))
> +               host->bus_clk = NULL;
>         /*source clock control gate is optional clock*/
>         host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
>         if (IS_ERR(host->src_clk_cg))
> --
> 1.8.1.1.dirty
>
