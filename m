Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3B9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1524D20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xQA7pbn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1524D20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbeKGTLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:11:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbeKGTLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:11:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id a8-v6so15043882wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 01:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEmZ4B5NLPm7sbS8U0uahMmV7akpbAHP8pL0hlfpaBQ=;
        b=xQA7pbn58vHuWusvB6tmzoK5YfMo1s5FkJ5cxXGx7MOMJfEdfmU4Co9VI2GzhD/ZwP
         Bp+RpzWv35DsskSaSDFF9J3o8c7w9BKYBybCNpHbjavLDYWHXXykTIOBaB4C5Kv4F9uS
         k3Cq1LBCOWUYnWycsk+POiD1nqQbK6Tuidked+LczbqAIT43ffuWxfx70pYQJ5gYerbx
         S1rk9xFLORD30n/EefG330TzZcr3NeSLBPNkcJqmmZ7Tqi4YK4s/ppBqRWTTCxt1DMnD
         FEDldLsYe4O/D90pvxz3VrMG3Vc2YHKhq5gTRKU9BdHX9Y2Hc+dFgWNgpaprQj7tXT5s
         HGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEmZ4B5NLPm7sbS8U0uahMmV7akpbAHP8pL0hlfpaBQ=;
        b=InfMDsZ44Vo+3vOG9NenYFFT+ti1n+K09hzFt79j6Rshv8uiiUr7qXUKrOoX+uyz2l
         xnrgqvyTzPMLT/JTIuGpxkFnRruY+WtWR9ZxqL/k1us/3MqMMj0tgUL8zNTXTqmSaR1d
         0QyiVyBzNeGTCeujzb4ueGfIbgMlH2VF1+KnO48ZNj9DjpDwT+HZGJbCINbvpJ6IjKNW
         gTDJ5IX4/DqswMo6v3ylecQK9cYrcN6qEgs4atfDc0q8MTfTvtcI/Yj+C+jbH4BmzLEs
         0A0pNMzGdaNFV8jCS+RhFNJCLwM6KWmqB87gW0eRJqQxni06j4rXc6FwcaRW6I9eA4We
         ua9w==
X-Gm-Message-State: AGRZ1gJl55upASILAw7rVRj9r1+/+uN26PKdtU/lpXXGAKsf+ntI6kbE
        sKNnOz1jzlpEP7DUkzE8QRoGosKbbglpa0UyYkq+lQ==
X-Google-Smtp-Source: AJdET5drHqdVEfDEex09kZuu29EdmGedL971FOBrYW6c04carkf44TTQN+DLvp8mnMzCZK9gAn2meYTfpLxNmtn/e1c=
X-Received: by 2002:a1c:8c8c:: with SMTP id o134-v6mr1310198wmd.35.1541583699333;
 Wed, 07 Nov 2018 01:41:39 -0800 (PST)
MIME-Version: 1.0
References: <1541497202-20570-1-git-send-email-narmstrong@baylibre.com> <1541497202-20570-2-git-send-email-narmstrong@baylibre.com>
In-Reply-To: <1541497202-20570-2-git-send-email-narmstrong@baylibre.com>
From:   Maxime Jourdan <mjourdan@baylibre.com>
Date:   Wed, 7 Nov 2018 10:41:27 +0100
Message-ID: <CAMO6nay=te3W67b83LKv35tXL8+09rvE9EaFwLDrRBhwpEgMvQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/meson: Support Overlay plane for video rendering
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 10:40 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The Amlogic Meson GX SoCs support an Overlay plane behind the primary
> plane for video rendering.
>
> This Overlay plane support various YUV layouts :
> - YUYV
> - NV12 / NV21
> - YUV444 / 422 / 420 / 411 / 410
>
> The scaler supports a wide range of scaling ratios, but for simplicity,
> plane atomic check limits the scaling from x5 to /5 in vertical and
> horizontal scaling.
>
> The z-order is fixed and always behind the primary plane and cannot be changed.
>
> The scaling parameter algorithm was taken from the Amlogic vendor kernel
> code and rewritten to match the atomic universal plane requirements.
>
> The video rendering using this overlay plane support has been tested using
> the new Kodi DRM-KMS Prime rendering path along the in-review V4L2 Mem2Mem
> Hardware Video Decoder up to 3840x2160 NV12 frames on various display modes.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/Makefile          |   2 +-
>  drivers/gpu/drm/meson/meson_canvas.c    |   7 +-
>  drivers/gpu/drm/meson/meson_canvas.h    |  11 +-
>  drivers/gpu/drm/meson/meson_crtc.c      | 216 +++++++++++-
>  drivers/gpu/drm/meson/meson_drv.c       |  29 +-
>  drivers/gpu/drm/meson/meson_drv.h       |  52 +++
>  drivers/gpu/drm/meson/meson_overlay.c   | 586 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/meson/meson_overlay.h   |  14 +
>  drivers/gpu/drm/meson/meson_registers.h |   3 +
>  drivers/gpu/drm/meson/meson_viu.c       |  15 +
>  drivers/gpu/drm/meson/meson_vpp.c       |  44 ++-
>  11 files changed, 971 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.c
>  create mode 100644 drivers/gpu/drm/meson/meson_overlay.h
>

Tested by rendering video with:
 - gstreamer 1.14.4 using kmssink
 - ffmpeg-drm (https://github.com/Elyotna/ffmpeg-drm),
by applying this patch on top of the video decoder patch series.

Used different resolutions and pixel aspect ratios.

Tested-by: Maxime Jourdan <mjourdan@baylibre.com>

[snip]
