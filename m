Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1930BECDE47
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5592082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 20:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5592082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbeJYFGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 01:06:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46190 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeJYFGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 01:06:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so6320349edq.13;
        Wed, 24 Oct 2018 13:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S99y+4VjCwk/4G66guX2S2aY9b7y0YuDh1SVSx5Tlsc=;
        b=fGpSmngMx+1NrKivv7qPpQC2RuPbyh0gICvbJpiIykmyJiLAMIMpaD0by3XFOhaFN2
         G56NRijn4SscxxtgVdFRDKQeHFQ2jkgY1ZQdKPD0+VzWEn29HH7lE0ymnu83cVkflQCb
         dl5163DvejEeCUlD9FYR1rHG0aWSPBk3u4sEJnO83ff0cmAUYj2dhLQH3egU8M5kQpMN
         9e6kxramz989kQhuuexvWCMsEmUrgC+xsEhiOkHQ0t4F6yuQ8cHxbfshKIbfS7mgGHVW
         gwcgDb6O0FnMEK+fNVuRET01xcK541wDfVyplgFH2gWmgJLVL52FyBPLTHpzJngy7m7O
         /nqg==
X-Gm-Message-State: AGRZ1gIZtiyKcWmmMdX5c8Bz5Y31ias9C2YHE9pqDvOYI/k/vcqwxnBs
        +d83cmO0Iku1HfjVQ5RxFcRaGh6O95g=
X-Google-Smtp-Source: AJdET5dWNYR++QWahkNkUFDLORnWb8DIPwDQ6Q2D139ICvJeULwhZuq0JnZDpiYR5H0dn4SPJnE4qQ==
X-Received: by 2002:a17:906:63d1:: with SMTP id u17-v6mr2193948ejk.223.1540413395353;
        Wed, 24 Oct 2018 13:36:35 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 36-v6sm2518023eds.64.2018.10.24.13.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 13:36:33 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id d10-v6so6997565wrs.5;
        Wed, 24 Oct 2018 13:36:33 -0700 (PDT)
X-Received: by 2002:a5d:480b:: with SMTP id l11-v6mr1379566wrq.28.1540413392524;
 Wed, 24 Oct 2018 13:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-16-jagan@amarulasolutions.com> <20181024181159.35lm7ihqestbetvb@flea>
In-Reply-To: <20181024181159.35lm7ihqestbetvb@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 24 Oct 2018 21:36:20 +0100
X-Gmail-Original-Message-ID: <CAGb2v66MwbY1yHN8TLpChRfJPCd7-3qmH3O1R2Ku4wRzJfOu=w@mail.gmail.com>
Message-ID: <CAGb2v66MwbY1yHN8TLpChRfJPCd7-3qmH3O1R2Ku4wRzJfOu=w@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] arm64: dts: allwinner: bananapi-m64: Bananapi
 S070WV20-CT16 DSI panel
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 7:12 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> On Tue, Oct 23, 2018 at 09:20:35PM +0530, Jagan Teki wrote:
> > This patch add support for Bananapi S070WV20-CT16 DSI panel to
> > BPI-M64 board.
> >
> > DSI panel connected via board DSI port with,
> > - DC1SW as AVDD supply
> > - DCDC1 as DVDD supply
> > - PD6 gpio for reset pin
> > - PD5 gpio for backlight enable pin
> > - PD7 gpio for backlight vdd supply

This is for a removable module, which is best handled using an overlay.
This patch should be marked [DO NOT MERGE].

> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v2:
> > - Use quadratic rule on pwm brightness
> >
> >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > index ef1c90401bb2..e0c6d1870a94 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > @@ -45,6 +45,7 @@
> >  #include "sun50i-a64.dtsi"
> >
> >  #include <dt-bindings/gpio/gpio.h>
> > +#include <dt-bindings/pwm/pwm.h>
> >
> >  / {
> >       model = "BananaPi-M64";
> > @@ -56,6 +57,24 @@
> >               serial1 = &uart1;
> >       };
> >
> > +     vdd_bl: regulator@0 {
>
> You shouldn't have a unit address if you don't have a reg
> property. This will trigger a DTC warning.
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "bl-3v3";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* PD7 */
> > +             enable-active-high;
> > +     };
> > +
> > +     backlight_dsi: backlight-dsi {

This should be just "backlight". There's nothing DSI specific
about a backlight.

> > +             compatible = "pwm-backlight";
> > +             pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
> > +             brightness-levels = <1 2 4 8 16 32 64 128 512>;
> > +             default-brightness-level = <2>;
> > +             enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* PD5 */
> > +             power-supply = <&vdd_bl>;
> > +     };
>
> These nodes should be ordered by alphabetical order.
>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
