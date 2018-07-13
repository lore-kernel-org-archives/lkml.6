Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B659ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB52720843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UspjXDEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB52720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbeGMLgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:36:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51066 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeGMLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:36:11 -0400
Received: by mail-it0-f68.google.com with SMTP id w16-v6so11076696ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MNijLxjKgL+oarstX8vAl1cNwCS6mTnX1xb70agafp4=;
        b=UspjXDElEBzeJmgU8f5y8+d3cJSJVxj/L5zPEBPdtQYmUQ9MJNQumUyfAUjpim59Yd
         //8Q9Aqa67Iq2onRd43pSAyAHFaQ/1rVe7wgZZLGLzmDhOGRMryFoAp1tOe0A8KBq3/g
         aPAZ8GOBxN9Rw/Y8G9bUx5+YMrngIAoy466lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MNijLxjKgL+oarstX8vAl1cNwCS6mTnX1xb70agafp4=;
        b=frCXj9Kzbsp1cVx08dZ3r9STWj9yOIu46uBHmN/rFqXkX1QCFUPfr6Wa7y0WZJ6gj1
         vuQncOlQgEqvR+wlXNchSoBBE7dE1ikW8aj8JPPT0CQ2Ny24g6/u1FzTXP6GbZmp9wZh
         Q9dk3YSZ/cbqnQu+klTkvb1wX/cKGCGmzMeeeUJILtmJZnG6vgRG71pJv4H6LNNbUPit
         hodn6QqZzZ6PSCyR8rYxaFnF48vEgTqkMG2ik/5lPgctmacIE/awgWVAfx0PL3cmuvMr
         LfncW00i4YBJ1VdvPyPPYXf/jFeKtMH+0fCH+aPpNcE0Do9A315TL03baMD/5esNkrRD
         +ZIw==
X-Gm-Message-State: AOUpUlG+AkcLXLnGOyUiAjZVSzL6ygNC/gD/GO/WZ/Mkn5r3OqBZHOD5
        MZN5vbXaqYEOElFph5CD774BRGfMWzYkwsq/1RNhNA==
X-Google-Smtp-Source: AAOMgpfL0NHhslcgToydXphx8hJcR/yfR5HyJv4Tv3JUdv90yo83BsSaIba64aBGuxZUL87abnXDZEnhoKz30ERbdRU=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr4888642jad.107.1531480916221;
 Fri, 13 Jul 2018 04:21:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 04:21:55
 -0700 (PDT)
In-Reply-To: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
References: <c00ad2ebf94d105544b328c77fa1edbfe6bbc193.1531475786.git.leonard.crestez@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 13 Jul 2018 13:21:55 +0200
Message-ID: <CAPDyKFrcn9oK2vDiZaf+d0t=dx0GsO-hv9_MkV2d+PPRHAQEWA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx6qp: Use GENPD_FLAG_ALWAYS_ON for PU errata
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On 13 July 2018 at 12:01, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> This is functionally identical but simpler and slightly faster.
>
> The PU domain is turned on at boot time and never turned off. In the
> current implementation the pm core will repeatedly call power_off when
> the domain is unused and get -EBUSY back. If the domain is marked as
> "always on" instead the pm core won't even attempt to turn it off.
>
> In theory on 6qp it is safe to turn PU off in suspend, however that is
> best accomplished with a new core flag.
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/soc/imx/gpc.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> Previous discussion:
> * https://lkml.org/lkml/2018/7/11/431
> * https://lkml.org/lkml/2018/7/10/103
>
> Attempt at turning PU off in suspend:
> * https://lkml.org/lkml/2018/7/6/698
>
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index faf13a0b85d6..f31978e5af20 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -45,11 +45,10 @@ struct imx_pm_domain {
>         struct clk *clk[GPC_CLK_MAX];
>         int num_clks;
>         unsigned int reg_offs;
>         signed char cntr_pdn_bit;
>         unsigned int ipg_rate_mhz;
> -       unsigned int flags;
>  };
>
>  static inline struct imx_pm_domain *
>  to_imx_pm_domain(struct generic_pm_domain *genpd)
>  {
> @@ -60,13 +59,10 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
>  {
>         struct imx_pm_domain *pd = to_imx_pm_domain(genpd);
>         int iso, iso2sw;
>         u32 val;
>
> -       if (pd->flags & PGC_DOMAIN_FLAG_NO_PD)
> -               return -EBUSY;
> -
>         /* Read ISO and ISO2SW power down delays */
>         regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
>         iso = val & 0x3f;
>         iso2sw = (val >> 8) & 0x3f;
>
> @@ -419,12 +415,12 @@ static int imx_gpc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
>         /* Disable PU power down in normal operation if ERR009619 is present */
>         if (of_id_data->err009619_present)
> -               imx_gpc_domains[GPC_PGC_DOMAIN_PU].flags |=
> -                               PGC_DOMAIN_FLAG_NO_PD;
> +               imx_gpc_domains[GPC_PGC_DOMAIN_PU].base.flags |=
> +                               GENPD_FLAG_ALWAYS_ON;
>
>         /* Keep DISP always on if ERR006287 is present */
>         if (of_id_data->err006287_present)
>                 imx_gpc_domains[GPC_PGC_DOMAIN_DISPLAY].base.flags |=
>                                 GENPD_FLAG_ALWAYS_ON;
> --
> 2.17.1
>
