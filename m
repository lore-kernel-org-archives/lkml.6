Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C7AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59A62146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 07:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3cknnJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59A62146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbeLFH31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 02:29:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42843 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbeLFH31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 02:29:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so6561228plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 23:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9URZ+wcpgMphsBNvFO+OztPEZ7JTHqRcySRnbHG7IMg=;
        b=O3cknnJYAt+SUQQDN1JH/t5GEh4cu6hKP4za5JTn4d1kJBkXuPNlUsR8/owqlKYpNE
         Hk+A+VrgenAXV9Uxjn6IF/+nFVYBH4mgSu03P5EvL0Tdi0vLRVEhsoZK083thkgKLWvX
         s8JGQ+OYQAXyY16W60me0XdZN8UM/SbRwnLjTCW13lE/z/nLQ+qI7rBI6g8LQbVTE8WU
         ymEHkaEFMmaU/Hvp4XM8ABOho6069+ECVmQHCDzbOxDQyXBc43VMaAiDw1l42gsVhbo4
         sIuf/6kYhSxr3rzgFO+XJnFgHdvXJKbDEhd+LOxkNXxTOW2w2J3+n999QDSvret7cEnv
         3tQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9URZ+wcpgMphsBNvFO+OztPEZ7JTHqRcySRnbHG7IMg=;
        b=QPkaBvo15EI2jtot3GUGxCtlcdzT6Vz47S5fbAEbv9eL4GyfsVjSoGHyN7IYOAp9lM
         hGgKfS8/S99uu517DYCUgEVhmUEmjMvqntELDPgZ880lwyAnjJufn5diALNl204B7OYV
         m+0Ty4ztiQSORa7Pmhaqoz132EfMSBIZdbCefccVD/hTHCl4DBWwWiUiivX3i4yJNcq0
         zFmBKPyydR+d2UVl1lExY8gklinjRyP/FRiTx+WaNFzT84mzIoCgGixONzyCbzo2kVtn
         6SP/Yp7NrDkTPBS8833PD4YcDEYC9j7Pn/HJpWkc6EQCyfPFkCS85s6Yx+9R+qQcVIWG
         +79g==
X-Gm-Message-State: AA+aEWbOztTqa94dUzmL16z1t7CtggK2VXMyhEepi53oEMuYFeJ0ZFev
        X+oVgvmn7qnLvklbBlciVEMgU4vZ9gwiPx4v+LZ1C8cL
X-Google-Smtp-Source: AFSGD/U+qUFPwro6s+6xJ3AXXRoi8m+YPUzLn7SyTq6AlZDlz1sXcOpT16M9VR3K2kFvzITzFEEcWyKGtMGr+v8k5jc=
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr27896073pll.54.1544081366249;
 Wed, 05 Dec 2018 23:29:26 -0800 (PST)
MIME-Version: 1.0
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
In-Reply-To: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
From:   Jonathan Liu <net147@gmail.com>
Date:   Thu, 6 Dec 2018 18:29:00 +1100
Message-ID: <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giulio,

On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> Differently from other Lcd signals, HSYNC and VSYNC signals
> result inverted if their bits are cleared to 0.
>
> Invert their settings of IO_POL register.
>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 3c15cf2..aaf911a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>                      SUN4I_TCON0_BASIC3_H_SYNC(hsync));
>
>         /* Setup the polarity of the various signals */
> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>                 val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
>
> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>                 val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
>
>         regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,

I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
LCD touchscreen (Innolux AT070TN92) connected to Olimex
A20-OLinuXino-MICRO that the image does not display correctly after
this change.
The image is shifted to the right.

Reverting the change results in the image being displayed correctly on
the screen.

I have in the device tree a "panel" node with compatible =
"innolux,at070tn92" which uses the timings in
drivers/gpu/drm/panel/panel-simple.c.

Any ideas?

Thanks.

Regards,
Jonathan
