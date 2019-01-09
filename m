Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BFE206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S0T9L2Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfAIWSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:18:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42097 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfAIWSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:18:52 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so8152583otk.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eajiQ24UNxwoRXCMgoYAv710gsNkfyQN/SYf67E/6Zk=;
        b=S0T9L2Cfshpk5gAISGag7w4FTbGEe0MBQ5wpDmf3UZ0HziZetNrGg8K2NSzh1BuuQa
         VmWXAbhYKuGyJ9/jasHlNBBgctx5jUQiNsUcrQAAwRvVWu5ONKb9dcVQHTrGi1TgUKlU
         uLHXIsmhb3VsulAIlxMgFAz6x1KERjW+85wwzWkqf17JHx2SzB4apDdkhy1o/CXjFLgJ
         ndYYrXA76UX+BPB1iU3UWJFebimmzF83SnbJtCrYQr6HMr+d79LdXybTaBlV1eAPr43h
         tNoHe60C33+NCFEgRAiFyqIqjU8WXIWVOE5fN/UP6CiBFHlzSHeAjtpZuNxNnzjRdY5M
         Urpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eajiQ24UNxwoRXCMgoYAv710gsNkfyQN/SYf67E/6Zk=;
        b=Qc9o53avfaTqYeg4LwohKd9BGUwXPH2xCHRM9ZjaAL27sgxJHHtt3S/XmATlrZNg22
         N6RsE84j+u7J4vHZkbRnHoeBsDh77bHV3bdQrAuURbD0eUIPYJKNwy5Qe13sSEjeKfnH
         1u1U8jBBTIQ/VoqJ6YCCMcIE3GURTHgi7O5oFWGoSDuALjOpyKdwXO1uvlG+e0azEIKS
         C+sSfx6HKHE5w3d0WGJVv/3bxdC1UvqefJ+rC9xcg32ebFWpX4CUQBWOXG45O45r012s
         cn3su8IsBNqR1/U/R8aGJyYKBrHHeL/R6V5p93UCBbSB+qFL9AnTWovvG7KvnhQ6mzF+
         VbAw==
X-Gm-Message-State: AJcUukfAr1Yjpo52BTKG8rxBqL8/c2Ax2IfriRo24gUhvIkbDm9oUl3Y
        dyfAunUqdIelspsoQgzKwpkiu9peB45+VxE/yIVXbCYc
X-Google-Smtp-Source: ALg8bN7I2OlYvd8AOTDV66Tv0PvdZoWzd3whezjTYp12qwyB8kyViw4I5aL2d8lJCaRFwMS0luftFP0gApORVdYeIp4=
X-Received: by 2002:a9d:a48:: with SMTP id 66mr5256177otg.308.1547072330952;
 Wed, 09 Jan 2019 14:18:50 -0800 (PST)
MIME-Version: 1.0
References: <20190109133644.27459-1-narmstrong@baylibre.com>
In-Reply-To: <20190109133644.27459-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 9 Jan 2019 23:18:40 +0100
Message-ID: <CAFBinCAGGDx_9g3Y16fczUPGaBC0Ep=ULkY__n3WdrQRnDSsyA@mail.gmail.com>
Subject: Re: [PATCH] drm/meson: Fix atomic mode switching regression
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     daniel@ffwll.ch, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Jan 9, 2019 at 2:36 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Since commit 2bcd3ecab773 when switching mode from X11 (ubuntu mate for
> example) the display gets blurry, looking like an invalid framebuffer width.
>
> This commit fixed atomic crtc modesetting but didn't update the display
> parameters when changing mode, but only when starting a mode setting after
> a crtc disable.
>
> This commit setups the crctc parameter in _begin() and _enable() to
> take in account the current ctrc parameters.
>
> Reported-by: Tony McKahan <tonymckahan@gmail.com>
> Fixes: 2bcd3ecab773 ("drm/meson: Fixes for drm_crtc_vblank_on/off support")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_crtc.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/meson/meson_crtc.c b/drivers/gpu/drm/meson/meson_crtc.c
> index 75d97f1b2e8f..5bb432021caf 100644
> --- a/drivers/gpu/drm/meson/meson_crtc.c
> +++ b/drivers/gpu/drm/meson/meson_crtc.c
> @@ -82,14 +82,12 @@ static const struct drm_crtc_funcs meson_crtc_funcs = {
>
>  };
>
> -static void meson_crtc_enable(struct drm_crtc *crtc)
> +static void meson_crtc_setup(struct drm_crtc *crtc)
>  {
>         struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
>         struct drm_crtc_state *crtc_state = crtc->state;
>         struct meson_drm *priv = meson_crtc->priv;
>
> -       DRM_DEBUG_DRIVER("\n");
> -
>         if (!crtc_state) {
>                 DRM_ERROR("Invalid crtc_state\n");
>                 return;
> @@ -98,6 +96,16 @@ static void meson_crtc_enable(struct drm_crtc *crtc)
>         /* Enable VPP Postblend */
nit-pick: this "enable" comment is now in meson_crtc_setup().
I would drop it because my interpretation of the following lines is
now "setting VPP_POSTBLEND_H_SIZE enables the VPP postblend"

>         writel(crtc_state->mode.hdisplay,
>                priv->io_base + _REG(VPP_POSTBLEND_H_SIZE));
> +}
> +
> +static void meson_crtc_enable(struct drm_crtc *crtc)
> +{
> +       struct meson_crtc *meson_crtc = to_meson_crtc(crtc);
> +       struct meson_drm *priv = meson_crtc->priv;
> +
> +       DRM_DEBUG_DRIVER("\n");
> +
> +       meson_crtc_setup(crtc);
>
>         /* VD1 Preblend vertical start/end */
>         writel(FIELD_PREP(GENMASK(11, 0), 2303),
> @@ -121,6 +129,8 @@ static void meson_crtc_atomic_enable(struct drm_crtc *crtc,
>
>         if (!meson_crtc->enabled)
>                 meson_crtc_enable(crtc);
> +       else
> +               meson_crtc_setup(crtc);
it's probably only personal preference, but have you thought about
re-ordering this:
  meson_crtc_setup(crtc);

  if (!meson_crtc->enabled)
    meson_crtc_enable(crtc);

with that you could get rid of the meson_crtc_setup() call in
meson_crtc_enable(), leaving only one code-path (instead of two) which
calls meson_crtc_setup()


Regards
Martin
