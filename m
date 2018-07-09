Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8CCC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1481B208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 22:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSFAsoRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1481B208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeGIWdZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 18:33:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:46622 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeGIWdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 18:33:22 -0400
Received: by mail-io0-f193.google.com with SMTP id i18-v6so2797948ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=68FL1kgmCvh4yf7d4yzqEFVGaAmzEL1RVYX3zAalxz4=;
        b=hSFAsoRRzK3t8skk0SZrOL1Mb6/m1f3sbcPXhs/y/BOUcz8EZ762GGbC4csfN7oTat
         2fUbKf/a/l6Z/KKGDwKCEdCaNBmpHWNXBmbKKq1KtoQtrfJ3v4S/Qz775nUe0Wj4JOek
         PUcOMpOCx8ril8rLCRI/SkVxNyRLfpBnN4gOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=68FL1kgmCvh4yf7d4yzqEFVGaAmzEL1RVYX3zAalxz4=;
        b=VwuihQdU2OegHelZsNkYQM15Qe1ICykZys6ZuAVWGV47l7/FG+I1FKCNS49HEEHeDH
         uLm3XIHVObpERAFArWEwtBoM72SMHi/dCj2nlaQwk7RmOoWQCXHO3xMVW0Y8VnWirDz2
         pf+RmNYeQJVVh0Ol1wKDtj/zK3+vg4zaYQJhB4C9Tu2jBSf4zbvBQWE9cNyiAD6DN18v
         DAW08kptc7geUGSXnup7BFuN6A1+o3UWtnr2YS559qSnIOhoCkYl4ca41L/6nAlcvBgd
         24Qq0E5qI2QCJZjgoaIl2kvBSeMuzSpdkNwgAhMqomEUqgMC6Dyyk7RgYuvXKDWvpH3R
         FRSg==
X-Gm-Message-State: APt69E2ebebHmXhg+f2SoCORfWM4G153aDIFRTPTpg/dSRAmWYwdD44q
        R7+3vraEMAQZDgbjcPSERV9X+hhrGXUSIzuqCFTnlA==
X-Google-Smtp-Source: AAOMgpcMo3l9UfQka+J3EGwC6QfPWTNkD/vSAz6/PCEembEfVsmDuRLiUi+QIsR40fycUmnJ3Y/uxzcRA+FRPvqKxVA=
X-Received: by 2002:a6b:e403:: with SMTP id u3-v6mr18074620iog.131.1531175602253;
 Mon, 09 Jul 2018 15:33:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 15:33:21 -0700 (PDT)
In-Reply-To: <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
References: <cover.1531138446.git.leonard.crestez@nxp.com> <a00303c5672b332d1d363b78926903187169b8cc.1531138446.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Jul 2018 00:33:21 +0200
Message-ID: <CAPDyKFoELWSiZ4cfOByziPQzqW7Tx3m29qKu9uCKPHO1gXO4YA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 July 2018 at 14:23, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> The imx6sl chip errata document describes ERR006287 like this:
>
> """
> Upon resuming from power gating, the modules in the display power domain
> (eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
> correctly.
>
> When the modules listed above are used, do not use power gating on the
> display power domain.
> """
>
> Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62
>
> Handle this in linux in the same way as imx6qp ERR009619: make the DISP
> domain return -EBUSY on power_off.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/soc/imx/gpc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 526f2d02dc78..6b726dada560 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -339,30 +339,35 @@ static struct imx_pm_domain imx_gpc_domains[] = {
>  };
>
>  struct imx_gpc_dt_data {
>         int num_domains;
>         bool err009619_present;
> +       bool err006287_present;
>  };
>
>  static const struct imx_gpc_dt_data imx6q_dt_data = {
>         .num_domains = 2,
>         .err009619_present = false,
> +       .err006287_present = false,
>  };
>
>  static const struct imx_gpc_dt_data imx6qp_dt_data = {
>         .num_domains = 2,
>         .err009619_present = true,
> +       .err006287_present = false,
>  };
>
>  static const struct imx_gpc_dt_data imx6sl_dt_data = {
>         .num_domains = 3,
>         .err009619_present = false,
> +       .err006287_present = true,
>  };
>
>  static const struct imx_gpc_dt_data imx6sx_dt_data = {
>         .num_domains = 4,
>         .err009619_present = false,
> +       .err006287_present = false,
>  };
>
>  static const struct of_device_id imx_gpc_dt_ids[] = {
>         { .compatible = "fsl,imx6q-gpc", .data = &imx6q_dt_data },
>         { .compatible = "fsl,imx6qp-gpc", .data = &imx6qp_dt_data },
> @@ -467,10 +472,15 @@ static int imx_gpc_probe(struct platform_device *pdev)
>         /* Disable PU power down in normal operation if ERR009619 is present */
>         if (of_id_data->err009619_present)
>                 imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
>                                 PGC_DOMAIN_FLAG_NO_PD;
>
> +       /* Disable DISP power down in normal operation if ERR006287 is present */
> +       if (of_id_data->err006287_present)
> +               imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].flags |=
> +                               PGC_DOMAIN_FLAG_NO_PD;
> +

This looks like a use-case for an always powered on PM domain?

If that's the case, GENPD_FLAG_ALWAYS_ON does the trick, but more
efficient as it enables genpd to take a few shortcuts when trying to
power of a PM domain.

>         if (!pgc_node) {
>                 ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
>                                           of_id_data->num_domains);
>                 if (ret)
>                         return ret;
> --
> 2.17.1
>

Kind regards
Uffe
