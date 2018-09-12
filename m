Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77798C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F22620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F22620866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeILReV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:34:21 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34862 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbeILReU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:34:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so1630159edq.2;
        Wed, 12 Sep 2018 05:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RIdg9jlLSHIUyk4rZ9mg+idrlIoxTyQvbGEpNTtby6g=;
        b=si2/c9AQSKLSCD1zeEsCSHt1d8EZUmXPXjSSXuaGh+pqYxHdzGdk0ZM2PPGW2dpPlx
         jLhAiQbo+Ff9jH1cgfZFKOMaHteECiktkM/fmZZE1buGCvC3ThUMIyzmH3NBDmRt+R+p
         YhUe5uix4oPqTwrEtyL+vGfIdnb+AdjG3dzlE3Csj/kG+YrN1gGHPIXMSAUdLybD/Isu
         5O6B6w+10QHTS+e/DUHBMHmLYV7nUlXegAEE3DXtap5EnicMRAeJqpMvBlzYfNnFeYMi
         LLAXmXqW9xQtm6VYWh/ZBTOSKZG/flJdTQMjpHpYxj9Y6HSa0zrqSVF4qWV/Evi940kS
         pCPg==
X-Gm-Message-State: APzg51A0yYtoos9j6lF5AqQ63etjGOUYDW7S7TfLbJqORwi0fDAA2Khd
        0BhxmFV+Ji6Zg7dNpqmzkuEwVNvNnqI=
X-Google-Smtp-Source: ANB0VdZ9yL9mgrxOFOZc+Zepu5IMc2GT+BT0TOr2oa2EkID/aY+dZISdJVWESfTPU8yoQ65eTLK89Q==
X-Received: by 2002:a50:d9c6:: with SMTP id x6-v6mr2481600edj.63.1536755400275;
        Wed, 12 Sep 2018 05:30:00 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id y27-v6sm554280edb.20.2018.09.12.05.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 05:29:59 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id t25-v6so2184927wmi.3;
        Wed, 12 Sep 2018 05:29:59 -0700 (PDT)
X-Received: by 2002:a1c:7c18:: with SMTP id x24-v6mr1470435wmc.33.1536755399444;
 Wed, 12 Sep 2018 05:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-20-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-20-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 12 Sep 2018 20:29:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v67XJoJGQjF6bELkiRGnkG=ZumvScDb8_3j_yUi7nhuQtQ@mail.gmail.com>
Message-ID: <CAGb2v67XJoJGQjF6bELkiRGnkG=ZumvScDb8_3j_yUi7nhuQtQ@mail.gmail.com>
Subject: Re: [PATCH 19/27] drm/sun4i: Add support for H6 DW HDMI controller
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
> H6 has DW HDMI 2.0 controller v2.12a.
>
> It supports 4K at 60 Hz and HDCP 2.2.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> index 16a0c7a88ea8..44143c9f20d0 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> @@ -43,6 +43,16 @@ sun8i_dw_hdmi_mode_valid_a83t(struct drm_connector *connector,
>         return MODE_OK;
>  }
>
> +static enum drm_mode_status
> +sun8i_dw_hdmi_mode_valid_h6(struct drm_connector *connector,
> +                           const struct drm_display_mode *mode)
> +{
> +       if (mode->clock > 600000)

600 MHz seems slightly arbitrary. AFAIK the dot clock for 4K 60Hz is 594 MHz?
A comment on this limit would be nice.

> +               return MODE_CLOCK_HIGH;
> +
> +       return MODE_OK;
> +}
> +
>  static bool sun8i_dw_hdmi_node_is_tcon_top(struct device_node *node)
>  {
>         return IS_ENABLED(CONFIG_DRM_SUN8I_TCON_TOP) &&
> @@ -220,12 +230,20 @@ static int sun8i_dw_hdmi_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
> +       .mode_valid = sun8i_dw_hdmi_mode_valid_h6,
> +};
> +

Please "version" sort the SoC families and models.

>  static const struct sun8i_dw_hdmi_quirks sun8i_a83t_quirks = {
>         .mode_valid = sun8i_dw_hdmi_mode_valid_a83t,
>         .set_rate = true,
>  };
>
>  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> +       {
> +               .compatible = "allwinner,sun50i-h6-dw-hdmi",
> +               .data = &sun50i_h6_quirks,
> +       },

Here also.

Once fixed,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

>         {
>                 .compatible = "allwinner,sun8i-a83t-dw-hdmi",
>                 .data = &sun8i_a83t_quirks,
> --
> 2.18.0
>
