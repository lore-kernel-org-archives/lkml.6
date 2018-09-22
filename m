Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D776C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3352154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3352154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbeIVTRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:17:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46099 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730087AbeIVTRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:17:45 -0400
Received: by mail-ed1-f68.google.com with SMTP id k14-v6so12812410edr.13;
        Sat, 22 Sep 2018 06:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8IyemNlfEgsHl8o4vwhRok3tH1f2PO2gPNvvTGeCDM=;
        b=SmZ4Gzfr3rcB574E5Z3cIthup6w8JvWS7PHNpSc7BQ0t+Y2PcdpL1cATG47O26BYOn
         txXyLL6V0RehXNe9inGYxk62igLHdOK160lT1XVFZs7NMhdtck4RUm0+jl8seXUyy8ic
         7YX1uiZflBw2t5CoN5E02xuiz0gJKH/K3OspYvjc94OdtG1yEm/oQw2iDvs7OipfEZtG
         yc1cI35hEIO8LJexNAXaCe8ILs4NSW/3XZ4i3BIvdgfj1ihxoMwyujX/lT9NwrF2UtFI
         K5eCK2L71CsMp6fBGfdQD6SdCY4km/XWoaicqS48xOcJ8jDHB4EW5ZPBVuxt/xoZ2R4H
         St/A==
X-Gm-Message-State: ABuFfoha8y7mpaelo/KC0sy15k1LBpAQSQ9sO/ccr50M7TdluAYqCVZn
        UjD7IGLQPj5K4C5+zMAWp+ne3R+4BnY=
X-Google-Smtp-Source: ANB0VdYZUkvIrPZ2YG5NgXAQTWYA76d8TLdqpTTCuTJkR8NvR6GPSOgmp4MV7cAzLgsTgc92b2kszw==
X-Received: by 2002:a50:ef1a:: with SMTP id m26-v6mr3908827eds.136.1537622648336;
        Sat, 22 Sep 2018 06:24:08 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id r44-v6sm6054144edd.87.2018.09.22.06.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 06:24:07 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id e1-v6so15393217wrt.3;
        Sat, 22 Sep 2018 06:24:07 -0700 (PDT)
X-Received: by 2002:a5d:4a10:: with SMTP id m16-v6mr1961284wrq.278.1537622647202;
 Sat, 22 Sep 2018 06:24:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-14-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-14-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Sep 2018 21:23:55 +0800
X-Gmail-Original-Message-ID: <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com>
Message-ID: <CAGb2v66kp4B5VZfmTc8L6qt=OPHjbYBtXRbC=L6jGTzvEKvb=w@mail.gmail.com>
Subject: Re: [PATCH 13/27] drm/sun4i: Add support for H6 DE3 mixer 0
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Mixer 0 has 1 VI and 3 UI planes, scaler on all planes and can output
> 4K image @60Hz. It also support 10 bit colors.

AFAICT 10 bit color support is not implemented? Please mention this.

>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> index a9218abf0935..54eca2dd4b33 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -540,6 +540,15 @@ static int sun8i_mixer_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct sun8i_mixer_cfg sun50i_h6_mixer0_cfg = {

Please sort the per-compatible structures according to "version sort" rules.

> +       .ccsc           = 0,
> +       .is_de3         = true,
> +       .mod_rate       = 600000000,
> +       .scaler_mask    = 0xf,
> +       .ui_num         = 3,
> +       .vi_num         = 1,
> +};
> +
>  static const struct sun8i_mixer_cfg sun8i_a83t_mixer0_cfg = {
>         .ccsc           = 0,
>         .scaler_mask    = 0xf,
> @@ -587,6 +596,10 @@ static const struct sun8i_mixer_cfg sun8i_v3s_mixer_cfg = {
>  };
>
>  static const struct of_device_id sun8i_mixer_of_table[] = {
> +       {
> +               .compatible = "allwinner,sun50i-h6-de3-mixer-0",
> +               .data = &sun50i_h6_mixer0_cfg,
> +       },

Same here.

ChenYu

>         {
>                 .compatible = "allwinner,sun8i-a83t-de2-mixer-0",
>                 .data = &sun8i_a83t_mixer0_cfg,
> --
> 2.18.0
>
