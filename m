Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DF3C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F3206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IxvDX9Vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819F3206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeIERyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:54:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:46680 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIERyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:54:46 -0400
Received: by mail-io0-f196.google.com with SMTP id y12-v6so5874532ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 06:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wrgUW+Qe2h7543QU1/yKa6rEWxvgRGrktRiXtyC9Ubo=;
        b=IxvDX9VrSPS8AwIJJ9NAWDbnpVuaHjAFSneOiPnr9NJEBATfyGRiqzTeI+Tnoy8IRN
         DGiklSNESqUBbAe7E+ZkSFwhCxyKyTG0gnb+qcSff7yYHIDQMYlncT/VMA4OdleyrcBI
         +8fw3WZ4ViZE4FpSZ+bBUinv9Jh9ip05qW+QQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wrgUW+Qe2h7543QU1/yKa6rEWxvgRGrktRiXtyC9Ubo=;
        b=pcj1uLuTrcY527Q8Kiy+2I7OCfly8SZsKSX+eLCfADbf+H7FiXPYmZBputxcdw9ZGG
         6KPBGDIk8YCzGjeSOY3+j0LQqlqpZ8Z7cMmPAyCASlluCWSCeRNUZsSA3ZBl9VfXCX7E
         3OmRwzVkIXO+4oYj6FneyHxNqKI1zabdvDspFcru53v1hQOy1VAdDd8fXsVVdo22uiId
         8kEKAwfHX47DJJ4yTQydVZNzmg1OMw2H0BnleQTD1RtaEYOf/SseGzeJL9TkP8fdbzwj
         bfWlCuwCqx1s40EfUHDB5ASYZiuXtC67wRZbLlZg9BtYO1fm2KgWP036ftb7g4tdqXwT
         tTIA==
X-Gm-Message-State: APzg51AP/fKp/2SD3lGtrXTwoGmzSit47aA8HV++E0P+ZrYNyIWTVc1h
        0n/dLL/m13TwYrLG0fOGRWdhJP4Q90szqs9SLHYEOg==
X-Google-Smtp-Source: ANB0VdbM/UEMzZuCnWSwCvBa9rO5XiYT716JZ8Lkpob8U2/Ys5ZxsC89lBIlZt3vRwBT5Xx0kMp4dq9Sv93MGwFGvtw=
X-Received: by 2002:a6b:ba45:: with SMTP id k66-v6mr26751093iof.252.1536153870394;
 Wed, 05 Sep 2018 06:24:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 06:24:29 -0700 (PDT)
In-Reply-To: <20180419093225.614-1-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Sep 2018 18:54:29 +0530
Message-ID: <CAMty3ZAPGuxLB99jod8Mq1fF+Mw6GLpLHiGuSHRNFKOT2uJSOQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] drm/sun4i: Support color dithering for LCD panels
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jonathan Liu <net147@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 3:02 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> Dithering is a method of approximating a color from a mixture of other
> colors when the required color isn't available. It reduces color
> banding artifacts that can be observed when displaying gradients
> (e.g. grayscale gradients). This may occur when the image that needs
> to be displayed is 24-bit but the LCD panel is a lower bit depth and
> does not perform dithering on its own.
>
> The TCON (LCD controller) found in Allwinner SoCs has hardware support
> for dithering on channel 0, the channel used to feed LCD panels. This
> series adds support for it.
>
> Patch 1 reworks the mode set function for the CPU interface to pass
> the encoder object, so it can be passed to other helper functions.
>
> Patch 2 renames the dithering related register macros to reflect the
> fact that dithering is only supported on channel 0.
>
> Patch 3 adds support for dithering on all LCD panel output types.
>
> Patch 4 adds support for Banana Pi's 7" DPI LCD panel.
>
> Patch 5 adds a pinmux setting for RGB888 for the Allwinner A20 SoC.
> This change has been sent by others before.
>
> Patch 6 provides an example for enabling the Banana Pi 7" DPI LCD panel
> on the Banana Pi M1+. This should not be merged. I will likely rework
> this into an overlay in the future.
>
> Note that I was only able to test dithering with DPI, as I do not have
> other panel types. However the underlying concept and core code is the
> same, as are the drm objects accessed. Nevertheless I'm hoping Jonathan
> can test LVDS and Maxime can test MIPI DSI.
>
> Also it seems pwm-backlight hardware is unusable at the moment. I'm not
> sure whether the pwm-backlight or sun4i-pwm driver is to blame. I had to
> manually poke the pwm registers so the LCD backlight wouldn't be
> completely black.
>
>
> Regards
> ChenYu
>
> Chen-Yu Tsai (5):
>   drm/sun4i: tcon: Pass drm_encoder * into sun4i_tcon0_mode_set_cpu
>   drm/sun4i: tcon: Rename Dithering related register macros
>   drm/panel: simple: Add support for Banana Pi 7" S070WV20-CT16 panel
>   ARM: dts: sun7i: add pinmux setting for RGB888 output for LCD0
>   [DO NOT MERGE] ARM: dts: sun7i: bananapi-m1-plus: Enable Bananapi 7"
>     800x480 RGB LCD panel
>
> Jonathan Liu (1):
>   drm/sun4i: tcon: Add dithering support for RGB565/RGB666 LCD panels

Do you have any working branch to test this, I can't see drm probing
on linux-next, I even enabled de on dts which is missing.

Jagan.
