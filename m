Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41C6C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2B825B6C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2B825B6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeF1CSH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:18:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40014 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeF1CSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:18:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id m15-v6so4187765edr.7;
        Wed, 27 Jun 2018 19:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VBnhp+ndwXQ3tho/HZj2k5iWXMSr3SVVlZ6R41IDft0=;
        b=R0jYfF0U5DEloJjmHOBb0JtGe/Sagrgeag/x0F3nfbSS2zVoavCUbw0Vt7hkTtVHAt
         vBqRGTEW4h5G8fVv0T6UYKmHo2PGukgEQVQ4lZan4dABCi6f4VyirTnh2iYiucXKY4ho
         8ITY4w3buyhjKmWJmTawAH7rnrNp43aPZ0OE2Mm2uaLhXVaTJbILUxX8CVND9C6SMCA4
         ZDJ1CITcwzcrVW0gBOBpyJ2TM8OqdTyb7yWDmJqqfa4U7sHY5z0mxRWTYDyvWpBViGnF
         IQqgtOqqgZVzR2bKL9rg+/vO+xQQJ0sOOfpAb5WJkBRO9rG1PGhSJSZLrFYoAM/OgEHP
         S0jA==
X-Gm-Message-State: APt69E2HCnR7BHIlM+VBvVFLlbvPVJNeO8jE+WSfGZUr3SGUaMcDdAML
        EbvZ9Yx23oQ1pOQXM/+1DDZhzXL7
X-Google-Smtp-Source: AAOMgpcW+H+fgvDCMVCHY6kDEXQ6QZiqrloi8j4Jv8f6p7doKuKpFyur1/Ybv7kaab/K+4CGzxBv6w==
X-Received: by 2002:a50:8f42:: with SMTP id 60-v6mr7242339edy.248.1530152281242;
        Wed, 27 Jun 2018 19:18:01 -0700 (PDT)
Received: from mail-wr0-f182.google.com (mail-wr0-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id o2-v6sm2560544edd.84.2018.06.27.19.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:18:00 -0700 (PDT)
Received: by mail-wr0-f182.google.com with SMTP id t6-v6so3805788wrq.13;
        Wed, 27 Jun 2018 19:17:59 -0700 (PDT)
X-Received: by 2002:adf:a54d:: with SMTP id j13-v6mr7414082wrb.155.1530152279525;
 Wed, 27 Jun 2018 19:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:17:38
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-13-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-13-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:17:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v67KBqu7_2Q-yZP+zmB9A4Hu1Hh=9Yq2rrnBU5uxyzTpGg@mail.gmail.com>
Message-ID: <CAGb2v67KBqu7_2Q-yZP+zmB9A4Hu1Hh=9Yq2rrnBU5uxyzTpGg@mail.gmail.com>
Subject: Re: [PATCH v3 12/24] drm/sun4i: Don't check for panel or bridge on TV TCONs
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> TV TCONs are always connected to TV or HDMI encoder, so it doesn't make
> sense to check if panel or bridge is connected to them.
>
> Check if TCON has channel 0 and only then check for connected panel or
> bridges.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 761687ebacba..a41c7bb0d557 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -1178,13 +1178,19 @@ static const struct component_ops sun4i_tcon_ops = {
>  static int sun4i_tcon_probe(struct platform_device *pdev)
>  {
>         struct device_node *node = pdev->dev.of_node;
> +       const struct sun4i_tcon_quirks *quirks;
>         struct drm_bridge *bridge;
>         struct drm_panel *panel;
>         int ret;
>
> -       ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
> -       if (ret == -EPROBE_DEFER)
> -               return ret;
> +       quirks = of_device_get_match_data(&pdev->dev);
> +
> +       /* panels and bridges are present only on TCONs with channel 0 */
> +       if (quirks->has_channel_0) {

This is implied by the device tree binding. TCONs that don't have panels
or bridges will have endpoint 0 unconnected, and drm_of_find_panel_or_bridge
will return -ENODEV.

It doesn't hurt to skip the check though.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +               ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
> +               if (ret == -EPROBE_DEFER)
> +                       return ret;
> +       }
>
>         return component_add(&pdev->dev, &sun4i_tcon_ops);
>  }
> --
> 2.18.0
>
