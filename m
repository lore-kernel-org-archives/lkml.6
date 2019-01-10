Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B50C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324A120660
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFmTLe7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfAJVS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:18:57 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33602 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAJVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:18:56 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so10535093oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMuwHYAw2tuTkvMiYqLLPhdr2mwWCxFg+NYEyaPwoqM=;
        b=VFmTLe7DEP2F4UdDBmoRkpnrd+Kigdg5SNmJX/nqJ3bdbu9eGre6nR/eDiL93AJfAM
         /FllUgdQM8/3wMqrXM+Rs960FiNMSDJmY47txogDipRAoR4qbb7TgsijQ02lYATWE5UB
         drB6dOWm6PqLkfl3SjaI6PVwwc+EsGvg3j1K/TuuoUuYEGDAz+sGw5I7+krM04wlgXKl
         9MQeMVWrLe2coXQ8C7PCg9L1ED9k6XSNKDIXmmJGnXMPxX3j7oDuV3j5i6MyDifh/csG
         2DH/tavZxW8fbQefkmWStoHYU27cLORkrGk94PzE8y4esjDrKHhDlZPKfFKAYfC0FMx3
         9vCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMuwHYAw2tuTkvMiYqLLPhdr2mwWCxFg+NYEyaPwoqM=;
        b=KArD6csAQEPtraUcxywa1Gdo1YSUtMOEozydeTtT9GTfe8Ax4fTyI8cDYOPx+neo2o
         g1ehUIloxKcuu3y9nn2rCJsWvcrLZRpGa2rH3mhUz3M02HzzwvBNXDN62oFW4OKLvBna
         9CWeqMpl+sJkGRPeJNPVY46CizhlC9JTvh+qYFNN5jBPv8u55d5ZYft9fHeSh60qF5EB
         UwoeV26hotI+wlJB2oQSvyAFiWAZFFz5i0Ipr7sdM/I4rJxSTMzPoFKLshw69G/ssmJU
         u4IlYWuvqbAD/P1JplKaerDjcq0jZ+DxVT3UJXGXWXGnVgDmPmH0Qc354fvxOryZvniA
         fHog==
X-Gm-Message-State: AJcUukegTgAhD6XIMzLR0FwvZ6lmhCQefOg064IWxBjmbxO8fqIozhHc
        lmOAmCmjbHYp8Q8d06pPh3e3i7w18SO1m6ES0RA6Dw==
X-Google-Smtp-Source: ALg8bN6a66yF0El2kuzEN6vxYKseXMaBtbxB2fSAu8mB/B0F9Bhri5kqbyh0PTEUVokkcj9n28GZUOs0rymEHOO7fns=
X-Received: by 2002:a05:6808:296:: with SMTP id z22mr7885948oic.67.1547155134331;
 Thu, 10 Jan 2019 13:18:54 -0800 (PST)
MIME-Version: 1.0
References: <1547043209-8283-1-git-send-email-robert.chiras@nxp.com> <1547043209-8283-9-git-send-email-robert.chiras@nxp.com>
In-Reply-To: <1547043209-8283-9-git-send-email-robert.chiras@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 10 Jan 2019 19:19:11 -0200
Message-ID: <CAOMZO5BwnoVxBNr4G2iYuZE=1hmU1eC332=0xVQ+kX=k9pi_BQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] drm/mxsfb: Update mxsfb to support LCD reset
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Anson Huang <anson.huang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

On Thu, Jan 10, 2019 at 6:34 AM Robert Chiras <robert.chiras@nxp.com> wrote:
>
> The eLCDIF controller has control pin for the external LCD reset pin.
> Add support for it and assert this pin in enable and de-assert it in
> disable.
> Also, correct the pm_runtime_enable call, since it was made too early in
> the probe, causing issues to DRM enable routines.

The pm_runtime change should be on a different patch.

> Signed-off-by: Robert Chiras <robert.chiras@nxp.com>
> ---
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 12 ++++++++++--
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 20 ++++++++------------
>  drivers/gpu/drm/mxsfb/mxsfb_regs.h |  1 +
>  3 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> index b62b607..8d1b6a6 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_crtc.c
> @@ -230,9 +230,12 @@ static void mxsfb_enable_controller(struct mxsfb_drm_private *mxsfb)
>                 clk_prepare_enable(mxsfb->clk_disp_axi);
>         clk_prepare_enable(mxsfb->clk);
>
> -       if (mxsfb->devdata->ipversion >= 4)
> +       if (mxsfb->devdata->ipversion >= 4) {
>                 writel(CTRL2_OUTSTANDING_REQS(REQ_16),
>                         mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
> +               /* Assert LCD Reset bit */
> +               writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_SET);
> +       }
>
>         /* If it was disabled, re-enable the mode again */
>         writel(CTRL_DOTCLK_MODE, mxsfb->base + LCDC_CTRL + REG_SET);
> @@ -250,9 +253,12 @@ static void mxsfb_disable_controller(struct mxsfb_drm_private *mxsfb)
>  {
>         u32 reg;
>
> -       if (mxsfb->devdata->ipversion >= 4)
> +       if (mxsfb->devdata->ipversion >= 4) {
>                 writel(CTRL2_OUTSTANDING_REQS(0x7),
>                         mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
> +               /* De-assert LCD Reset bit */
> +               writel(CTRL2_LCD_RESET, mxsfb->base + LCDC_V4_CTRL2 + REG_CLR);
> +       }
>
>         writel(CTRL_RUN, mxsfb->base + LCDC_CTRL + REG_CLR);
>
> @@ -346,6 +352,8 @@ static void mxsfb_crtc_mode_set_nofb(struct mxsfb_drm_private *mxsfb)
>                 return;
>
>         clk_set_rate(mxsfb->clk, m->crtc_clock * 1000);
> +       DRM_DEV_DEBUG_DRIVER(drm->dev, "Pixel clock: %dkHz (actual: %dkHz)\n",
> +               m->crtc_clock, (int)(clk_get_rate(mxsfb->clk) / 1000));

This unrelated change should also be in a different patch.
>
>         DRM_DEV_DEBUG_DRIVER(drm->dev,
>                 "Connector bus_flags: 0x%08X\n", bus_flags);
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index f528a37..135b8e1 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -287,7 +287,7 @@ static int mxsfb_load(struct drm_device *drm, unsigned long flags)
>         if (IS_ERR(mxsfb->base))
>                 return PTR_ERR(mxsfb->base);
>
> -       mxsfb->clk = devm_clk_get(drm->dev, NULL);
> +       mxsfb->clk = devm_clk_get(drm->dev, "pix");

This breaks mx23 and mx28 as there is no "pix" clock defined in their
dtsi files.
