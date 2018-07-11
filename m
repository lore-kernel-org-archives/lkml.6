Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC51C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C51AD2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OCGIaWeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51AD2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbeGKMXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:23:53 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:41071 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbeGKMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:23:53 -0400
Received: by mail-io0-f195.google.com with SMTP id q9-v6so23393854ioj.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3yxh4UZ1E7YAq+UwECAU89cNhmF1PUTdKHGX5L7JUQE=;
        b=OCGIaWeoaC24voY1wanH/ZgJmtV81dU1ZhNzs03gWiLlyxrUTvSN6lso9ORQYM5J9T
         hvqwyYZZMzzJNXD2DLbpklH2Hbd5w2jdEwqSW0gdNCex8YatTFj7V0xjEdBw+fYO5C9o
         preXfujpc8nEQ4rVmMlDtzBpaJmC2Wu2PifG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3yxh4UZ1E7YAq+UwECAU89cNhmF1PUTdKHGX5L7JUQE=;
        b=UYH5MDGz+cTNAEe/8r9uaoEWACt5w0Luj4mZ1cdIw0KxUfRTGKIit0gAviJu5U8Jz8
         oSGl4DNOEHICBIEUg85OX9Js2i37QeVIW+R4ugwIe+Dc9rRATnwGICTGS75ksuZsbdpp
         9klmstCM56ZKzBZr4pEgs/gwgnPBw0ghO5GJ7He4T/Ll1TNaLU9+doIUFIVFSEh5+aus
         cdmNRxFmU0cYDyMdJt3ilAvT2JlMraYYS9BQ+Z/PzpZpmd+kIUvgQt0/MFKGV3TCJ9Qr
         B3z0na5+6b2H5D1uDmtqt1ikW07qAtfkOOjowJ2cciTRBSNs2KrUTCeWYjswCzLp/RJY
         7p0Q==
X-Gm-Message-State: AOUpUlHrdLPsg3swV/AkP5hM0O93jan1TlUHTpKjSnXSnL9yy94mKU+D
        Eurl3tSfiCScqUfNhDGRjTWi7FMg0orx0Qzx+g4vbw==
X-Google-Smtp-Source: AAOMgpcWatvzvT47k76YodpjkJC23koxmAJ5jJp0H6ulakXG/cj+ZYMW0xVTP5w8/CEKPnlFLMw2pFSKnkLnrPwGyM4=
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr23567458iou.218.1531311588571;
 Wed, 11 Jul 2018 05:19:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 05:19:48
 -0700 (PDT)
In-Reply-To: <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
References: <cover.1531310547.git.leonard.crestez@nxp.com> <d694bc32feb1c9638485700ba53cd6e51bea495c.1531310547.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Jul 2018 14:19:48 +0200
Message-ID: <CAPDyKFp6MGXGsa1ToDm86mnxsj1nYqb0pA2ySN242YK3Epp5Fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: imx: gpc: Disable 6sl display power gating
 for ERR006287
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
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

On 11 July 2018 at 14:11, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> The imx6sl chip errata document describes ERR006287 like this:
>
>> Upon resuming from power gating, the modules in the display power domain
> (eLCDIF, EPDC, PXP and SPDC) might fail to perform register reads
> correctly.
>
>> When the modules listed above are used, do not use power gating on the
> display power domain.
>
> Link: https://www.nxp.com/docs/en/errata/IMX6SLCE.pdf#page=62
>
> Handle this in the safest possible way by keeping the DISP domain
> always-on.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/imx/gpc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 526f2d02dc78..f7960f773019 100644
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
> +       /* Keep DISP always on if ERR006287 is present */
> +       if (of_id_data->err006287_present)
> +               imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
> +                               GENPD_FLAG_ALWAYS_ON;
> +
>         if (!pgc_node) {
>                 ret = imx_gpc_old_dt_init(&pdev->dev, regmap,
>                                           of_id_data->num_domains);
>                 if (ret)
>                         return ret;
> --
> 2.17.1
>
