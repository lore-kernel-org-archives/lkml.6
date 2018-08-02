Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CF3C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E06C214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aHsnYquU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E06C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeHBNMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:12:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39580 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbeHBNMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:12:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so2079239wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBESyd7520mopnHf0EN7ubb+OE45Y444m4m57mwuN4g=;
        b=aHsnYquUCncOnG3sySTjeGvJBnbdjYo/rkMBiF147IOn+L+QPurIMm7IxOYXcMeej7
         Wz4yWds4HrO3/M5oBl6bVboqDNuzUkfV/eyMKbM8AsCFW+Bbqr4ddnZK8pW3OVdzCg2n
         kq2GNUR8LsZUNzCeKETykDm+vsQW1z1UrWAEUh+6Q3kJNuXZIVtoGWjIo4kRmwuAvQVL
         kpUcDgpMAYx/uvZ3/dck7KiBQRpeCTf2y77yWjXr/Je2nrCuTI1WporZl9tdv5zMMuug
         Lf0bCI/R7cjlhvIfP161d63cfWU28rSz2Xb6jlyOhGim/Us/GdubFzf/pN7yE94lclnV
         z8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBESyd7520mopnHf0EN7ubb+OE45Y444m4m57mwuN4g=;
        b=jx3h2DoxWStc81sRO3AVyNKLIltppMxoPgjMIeGFjQzchVcWtnqRZ8/Q3Q/S5k4GMX
         XTvlfkRfUut0pAB35mxm3d1v75Bxd9lQsmB3QkvQML4xngAs0CRtmsJTSW7M8d1GWC/K
         WkvgXjN2nmSxDb918NO6UAC2Nio5c7Gv3fxKpVwURkqvPaPATC9cnoyly/qtSGB2rPQ7
         7IyBvUhH8h5Gpl3K9vrxo89yyg93wB6oKJDZoGYC0RUpxIkEceS3QFonB/sPoYJ5gjGK
         ebMFfVzOFZ3j6sALYMVbxJZHi6ZXrAQls3a9C7x4M4Fl6MBY2jZ9EbiAQqkhoyoIztlm
         HfNw==
X-Gm-Message-State: AOUpUlFIDsH/62N74BsjkqFgRqy6FrSz/sa77oxFP/Fs6YQDhmJFHexw
        yXd9+76j4IWcoVmGgc6QO6//eg==
X-Google-Smtp-Source: AAOMgpc7xuJ3qkDn/SbOtGUxz3VUFCpWXxGFgOPG5TnKvwy/u1S17saizA6sh6e77whIDC31FG1qEA==
X-Received: by 2002:a1c:8010:: with SMTP id b16-v6mr1831758wmd.9.1533208885224;
        Thu, 02 Aug 2018 04:21:25 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id k3-v6sm1664708wme.44.2018.08.02.04.21.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 04:21:24 -0700 (PDT)
Message-ID: <acab5d8ab9eb871c616171c00814d1fec93af1e7.camel@baylibre.com>
Subject: Re: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linus.walleij@linaro.org,
        linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 02 Aug 2018 13:21:23 +0200
In-Reply-To: <d319d871-ba93-ab1d-dae4-b44916161e85@baylibre.com>
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
         <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
         <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
         <d319d871-ba93-ab1d-dae4-b44916161e85@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-02 at 09:52 +0200, Neil Armstrong wrote:
> On 01/08/2018 22:23, Martin Blumenstingl wrote:
> > Hi Neil,
> > 
> > On Wed, Aug 1, 2018 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > > 
> > > The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
> > > set the TEST_N pin direction.
> > > This patch adds a "smc" boolean to the bank structure to differentiate
> > > the TEST_N bank and call the Secure Monitor in the _input/_output functions.
> > > 
> > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > ---
> > >  drivers/pinctrl/meson/Kconfig         |  1 +
> > >  drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
> > >  drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
> > >  3 files changed, 36 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
> > > index c80951d..1b90470 100644
> > > --- a/drivers/pinctrl/meson/Kconfig
> > > +++ b/drivers/pinctrl/meson/Kconfig
> > > @@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
> > >         select GPIOLIB
> > >         select OF_GPIO
> > >         select REGMAP_MMIO
> > > +       select MESON_SM
> > 
> > I wonder why PINCTRL_MESON has to select MESON_SM - shouldn't
> > PINCTRL_MESON_GXBB, PINCTRL_MESON_GXL and PINCTRL_MESON_AXG select it
> > instead?
> > selecting MESON_SM is probably no-op on Meson8 and Meson8b (which
> > don't have the GX secure monitor), but I haven't tested it yet

I'm not so sure about that. meson_sm_call() symbol is used in the common pinctrl
code, so it should be selected when compiled even if meson8b is not going to use
it in the end.

> 
> Hi Martin, you are right !
> 
> I will fix it on v2..
> 
> Neil
> 
> > 
> > 
> > Regards
> > Martin
> > 
> 
> 


