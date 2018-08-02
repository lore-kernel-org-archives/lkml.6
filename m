Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760EA2156F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="g66BxOhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760EA2156F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeHBWfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:35:52 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:35045 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeHBWfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:35:52 -0400
Received: by mail-oi0-f68.google.com with SMTP id m11-v6so6022298oic.2;
        Thu, 02 Aug 2018 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Igkeqw00ub3V3T4WFEIWQor5VGaAIfw1oNxoKYEoySc=;
        b=g66BxOhylRnj2jDoRDl1i7nzrFWl4vBGPY3l67M4cVKaDhius+fprNgbv0wy+NdRxH
         yTj2npWy+NOvKrP0TpfmvMwwddHC2gpI9MJZFshS3VOooWBy0v/numMFDppBqwSmx6pd
         p9vhkkUMuVE9I3EFEjnwfPdF3ioO55eM2bPNE5tbFuJKHOEVsxuXYtUVyx9sn8hvf/K2
         5bXw1Z/m/8cLvx4xOX7NpJAwORsoRDMekBmNhnFP/UhNaiIYn2isxM1mrcigYtX8F55e
         B80Mz7fVx4cr7xxBzRDL7f2ZDcLic18aU5auNOakGgbWCJ+T7jyUip6xColjDnzJFQLV
         Y1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Igkeqw00ub3V3T4WFEIWQor5VGaAIfw1oNxoKYEoySc=;
        b=LVhpB24Ep+A+OyhPEXPJN/YHkQzlJfdmgo9hvJZhvJaYIaSblKquthSUFg6lIYEDid
         9HJRuRvaJmz58elQRI0kqAco8ve1psVlVKIMHdRc+Kf2ESz+nj34yklpu3Pw/KT9uw+A
         KBz3T4TIOkwV2Onw1S/uQw0HaSNvAiu3q1ozf0H5FHoJw7fdPZXr81hAAQhntprgPReK
         /Xfopc9WK0f60UgWqtXzRglXMDCzxterHXYBVLM11mnktQXXQ7y/N0/2rZEP1LwJ8o3A
         TlTZmARZ5s4F07toCAa94wQ+FdAkDkvuQr7wTc/MLuhOxb7epi0343isctnkXAJ9QZbw
         aHiw==
X-Gm-Message-State: AOUpUlGDq/lT93IKOc2UHvieK6suAvI/5jSB0gvYrvCCeu+oTm95h9iw
        1H/g0+o2xW0kFED0xC3TeOi4TMCQgyyNJ5+xXS8=
X-Google-Smtp-Source: AA+uWPxOoAnDLpJeHeo9Lh4Wwf52piwtADFTGmJ8N4wpokbymAQqC3h+Bw2TMMe5mJpRoe0E9o7EsbeY/dnLu+B5IB8=
X-Received: by 2002:aca:31c6:: with SMTP id x189-v6mr366198oix.213.1533242584719;
 Thu, 02 Aug 2018 13:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <1533117623-27856-1-git-send-email-narmstrong@baylibre.com>
 <1533117623-27856-3-git-send-email-narmstrong@baylibre.com>
 <CAFBinCBcUijFGdLoQwkzioX7MF0H_gH1rbcvxG+UWc1rA2pRiQ@mail.gmail.com>
 <d319d871-ba93-ab1d-dae4-b44916161e85@baylibre.com> <acab5d8ab9eb871c616171c00814d1fec93af1e7.camel@baylibre.com>
In-Reply-To: <acab5d8ab9eb871c616171c00814d1fec93af1e7.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 2 Aug 2018 22:42:53 +0200
Message-ID: <CAFBinCAAcqiJAwBMr2_7V90beFwq9xkPBnBdKB8oPsMKXU_-HA@mail.gmail.com>
Subject: Re: [PATCH 2/5] pinctrl: meson: Add support to set direction with a
 secure monitor call
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        linus.walleij@linaro.org, linux-amlogic@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 1:21 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Thu, 2018-08-02 at 09:52 +0200, Neil Armstrong wrote:
> > On 01/08/2018 22:23, Martin Blumenstingl wrote:
> > > Hi Neil,
> > >
> > > On Wed, Aug 1, 2018 at 12:05 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> > > >
> > > > The Amlogic Meson GX and AXG SoCs needs to do a Secure Monitor call to
> > > > set the TEST_N pin direction.
> > > > This patch adds a "smc" boolean to the bank structure to differentiate
> > > > the TEST_N bank and call the Secure Monitor in the _input/_output functions.
> > > >
> > > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > > ---
> > > >  drivers/pinctrl/meson/Kconfig         |  1 +
> > > >  drivers/pinctrl/meson/pinctrl-meson.c | 31 ++++++++++++++++++++++++++-----
> > > >  drivers/pinctrl/meson/pinctrl-meson.h | 10 +++++++++-
> > > >  3 files changed, 36 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
> > > > index c80951d..1b90470 100644
> > > > --- a/drivers/pinctrl/meson/Kconfig
> > > > +++ b/drivers/pinctrl/meson/Kconfig
> > > > @@ -8,6 +8,7 @@ menuconfig PINCTRL_MESON
> > > >         select GPIOLIB
> > > >         select OF_GPIO
> > > >         select REGMAP_MMIO
> > > > +       select MESON_SM
> > >
> > > I wonder why PINCTRL_MESON has to select MESON_SM - shouldn't
> > > PINCTRL_MESON_GXBB, PINCTRL_MESON_GXL and PINCTRL_MESON_AXG select it
> > > instead?
> > > selecting MESON_SM is probably no-op on Meson8 and Meson8b (which
> > > don't have the GX secure monitor), but I haven't tested it yet
>
> I'm not so sure about that. meson_sm_call() symbol is used in the common pinctrl
> code, so it should be selected when compiled even if meson8b is not going to use
> it in the end.
unfortunately MESON_SM depends on ARM64_4K_PAGES so it can't be
enabled for the 32-bit SoCs
any ideas how to solve this?


Regards
Martin
