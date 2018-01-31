Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753121AbeAaMyV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:54:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60587 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbeAaMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:54:19 -0500
Message-ID: <1517403243.14302.1.camel@pengutronix.de>
Subject: Re: [PATCH v3 33/43] drm/panel: simple: Change mode for Sharp
 lq123p1jx31
From: Lucas Stach <l.stach@pengutronix.de>
To: Thierry Escande <thierry.escande@collabora.com>,
        Archit Taneja <architt@codeaurora.org>,
        Inki Dae <inki.dae@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>, Tomasz Figa <tfiga@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Zain Wang <wzz@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, Yakir Yang <ykk@rock-chips.com>,
        =?ISO-8859-1?Q?=D8rjan?= Eide <orjan.eide@arm.com>,
        Mark Yao <mark.yao@rock-chips.com>, Haixia Shi <hshi@chromium.org>
Date: Wed, 31 Jan 2018 13:54:03 +0100
In-Reply-To: <20180130202913.28724-34-thierry.escande@collabora.com>
References: <20180130202913.28724-1-thierry.escande@collabora.com>
         <20180130202913.28724-34-thierry.escande@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 30.01.2018, 21:29 +0100 schrieb Thierry Escande:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Change the mode for Sharp lq123p1jx31 panel to something more
> rockchip-friendly such that we can use the fixed PLLs to
> generate the pixel clock

This should really switch to a display timing instead of exposing a
single mode. The display timing has min, typical, max tuples for all
the timings values, which would allow the attached driver to vary the
timings inside the allowed bounds if it makes sense.

Trying to hit a specific pixel clock to free up a PLL is exactly one of
the use cases envisioned for the display timings stuff.

Regards,
Lucas
 
> Cc: Chris Zhong <zyw@rock-chips.com>
> Cc: Stéphane Marchesin <marcheu@chromium.org>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> ---
>  drivers/gpu/drm/panel/panel-simple.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-simple.c
> b/drivers/gpu/drm/panel/panel-simple.c
> index 5591984a392b..a4a6ea3ca0e6 100644
> --- a/drivers/gpu/drm/panel/panel-simple.c
> +++ b/drivers/gpu/drm/panel/panel-simple.c
> @@ -1742,17 +1742,18 @@ static const struct panel_desc
> sharp_lq101k1ly04 = {
>  };
>  
>  static const struct drm_display_mode sharp_lq123p1jx31_mode = {
> -	.clock = 252750,
> +	.clock = 266667,
>  	.hdisplay = 2400,
>  	.hsync_start = 2400 + 48,
>  	.hsync_end = 2400 + 48 + 32,
> -	.htotal = 2400 + 48 + 32 + 80,
> +	.htotal = 2400 + 48 + 32 + 139,
>  	.vdisplay = 1600,
>  	.vsync_start = 1600 + 3,
>  	.vsync_end = 1600 + 3 + 10,
> -	.vtotal = 1600 + 3 + 10 + 33,
> +	.vtotal = 1600 + 3 + 10 + 84,
>  	.vrefresh = 60,
>  	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +	.type = DRM_MODE_TYPE_PREFERRED | DRM_MODE_TYPE_DRIVER,
>  };
>  
>  static const struct panel_desc sharp_lq123p1jx31 = {
