Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA962C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03F82087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUwKQM/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfAHQxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:53:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33432 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbfAHQxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:53:15 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so4018864ljd.0;
        Tue, 08 Jan 2019 08:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fLC8xP95XjKGKpur7tchfnAoZqhWli1WpKDNedamUH0=;
        b=mUwKQM/t9UWAJrx0/NjmVv6wD6xEDFa8v9So03SgRKTJcNyLnQpD8I/EmTE+iwr/wV
         /Sd1dGMzpiq+YYRl82wEtHRN8w5ZqRkudSxGB5Q5zmWl/MtfslerlffPJKBmKe/G0e7g
         w6d/HUVWFHLGlIY6k2mUlTVsIcB1GTf1i4K+3TKaSvEskTCveFXLgfxk37foqhQfDQGX
         Z/BbJu5XT32QzNspceDyXErg7L3v62WUdUffJUHarBcVB9M8PRDSwFJSCKQHWdwJ5vk+
         qBsQUDpuvoIt8dg8jaKfB2iJ6fvfypENjNr7DTTNlGnsmWqA2yWuVVTNvmydAe2H35Io
         rXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fLC8xP95XjKGKpur7tchfnAoZqhWli1WpKDNedamUH0=;
        b=KAhGQ5pGFGX1tgFH7vPO3uYNQ5elGx+4udSOqkV8lOG7xW21LAP3tZpfg8WQWBCafR
         gSNO1ysytUlHXf0JfU7q36NQIN5l132XQSVLpwPLa6Ai6w3PIg2q1Ayrexz89xrGkJqk
         bVZGAM7iNYA/JAT1bcYEBMZiQ20tVQiU4d7TZ70l8s3dftGKO6SGcwHsib3jrH80/Rzk
         XuqPBQYiqrQiOvuLgqCIDh8FaP12qSTroHdZwaY1WoeCfnTRGrGd3avvhkoZDwCmpJrI
         5u1E4cdrUB8nFQVgUSWFltErxjugS/D4xcYewHGWpfONtmH+Uv6vzAySJ/i45ATlUmKY
         XO7A==
X-Gm-Message-State: AJcUukeIOxCnVCenqxCN3wU9WLNqk4D1zbL93yeeCRjRtGflACrcd9YF
        ioRFa9/uuFxNpTNf1CUpq4k=
X-Google-Smtp-Source: ALg8bN58gxOsEGjGm2+0wNnx47qrnBxpebtsrC6ucTdhFNjQXeOGnerFIliO8eDpl/Qmnavo9Tyvbw==
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1514187ljj.9.1546966391546;
        Tue, 08 Jan 2019 08:53:11 -0800 (PST)
Received: from acerlaptop.localnet ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.gmail.com with ESMTPSA id k21-v6sm14229459ljc.15.2019.01.08.08.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 08:53:10 -0800 (PST)
From:   =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, xc-racer2@live.ca,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] ARM: dts: s5pv210: aries: Support for more devices present on Aries
Date:   Tue, 08 Jan 2019 17:53:09 +0100
Message-ID: <2674227.8dsLnzbNuO@acerlaptop>
In-Reply-To: <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
References: <20181228161819.18931-1-pawel.mikolaj.chmiel@gmail.com> <20181228161819.18931-6-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPf3Z9=mjq_UWyD1oVEapvnNR71cDfyJP1Y_VLkXkFcyew@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia poniedzia=C5=82ek, 31 grudnia 2018 14:35:55 CET Krzysztof Kozlowski pi=
sze:
> On Fri, 28 Dec 2018 at 17:18, Pawe=C5=82 Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> >
> > From: Jonathan Bakker <xc-racer2@live.ca>
> >
> > This commit enables following devices present on Aries based phones:
> > - pwm-vibrator attached to PWM 1
> > - poweroff support
> > - Atmel maXTouch touchscreen. It's connected to i2c2
> > - Broadcom BCM4329 bluetooth over uart0
> >
> > Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> >  arch/arm/boot/dts/s5pv210-aries.dtsi | 68 ++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s=
5pv210-aries.dtsi
> > index 35ba009a1a33..b7246f879648 100644
> > --- a/arch/arm/boot/dts/s5pv210-aries.dtsi
> > +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> > @@ -41,6 +41,13 @@
> >                 };
> >         };
> >
> > +       vibrator_pwr: regulator-fixed-0 {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "vibrator-en";
> > +               enable-active-high;
> > +               gpio =3D <&gpj1 1 GPIO_ACTIVE_HIGH>;
> > +       };
> > +
> >         wifi_pwrseq: wifi-pwrseq {
> >                 compatible =3D "mmc-pwrseq-simple";
> >                 reset-gpios =3D <&gpg1 2 GPIO_ACTIVE_LOW>;
> > @@ -314,6 +321,22 @@
> >                         reg =3D <0x36>;
> >                 };
> >         };
> > +
> > +       vibrator: pwm-vibrator {
> > +               compatible =3D "pwm-vibrator";
> > +               pwms =3D <&pwm 1 44642 0>;
> > +               pwm-names =3D "enable";
> > +               vcc-supply =3D <&vibrator_pwr>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&pwm1_out>;
> > +       };
> > +
> > +       poweroff: syscon-poweroff {
> > +               compatible =3D "syscon-poweroff";
> > +               regmap =3D <&pmu_syscon>;
> > +               offset =3D <0x681c>; /* PS_HOLD_CONTROL */
> > +               value =3D <0x5200>;
> > +       };
> >  };
> >
> >  &fimd {
> > @@ -347,6 +370,23 @@
> >         status =3D "okay";
> >  };
> >
> > +&i2c2 {
> > +       samsung,i2c-sda-delay =3D <100>;
> > +       samsung,i2c-max-bus-freq =3D <400000>;
> > +       samsung,i2c-slave-addr =3D <0x10>;
> > +       status =3D "okay";
> > +
> > +       touchscreen@4a {
> > +               compatible =3D "atmel,maxtouch";
> > +               reg =3D <0x4a>;
> > +               interrupt-parent =3D <&gpj0>;
> > +               interrupts =3D <5 IRQ_TYPE_LEVEL_LOW>;
> > +               pinctrl-names =3D "default";
> > +               pinctrl-0 =3D <&ts_irq>;
> > +               reset-gpios =3D <&gpj1 3 GPIO_ACTIVE_HIGH>;
> > +       };
> > +};
> > +
> >  &mfc {
> >         memory-region =3D <&mfc_left>, <&mfc_right>;
> >  };
> > @@ -372,6 +412,13 @@
> >                 samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
> >         };
> >
> > +       bt_host_wake: bt-host-wake {
> > +               samsung,pins =3D "gph2-5";
> > +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_DOWN>;
> > +               samsung,pin-drv =3D <EXYNOS4_PIN_DRV_LV1>;
> > +       };
> > +
> >         tf_detect: tf-detect {
> >                 samsung,pins =3D "gph3-4";
> >                 samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> > @@ -384,6 +431,17 @@
> >                 samsung,pin-function =3D <EXYNOS_PIN_FUNC_OUTPUT>;
> >                 samsung,pin-pud =3D <S3C64XX_PIN_PULL_NONE>;
> >         };
> > +
> > +       ts_irq: ts-irq {
> > +               samsung,pins =3D "gpj0-5";
> > +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_INPUT>;
> > +               samsung,pin-pud =3D <S3C64XX_PIN_PULL_UP>;
>=20
> It seems there is a difference here between Aries and Fascinate. At
> least in vendor kernel. One disables pull and second pulls down.
> Anyway neither of them pulls it up.
=46ixed with all other issues in v2.
Thanks

>=20
> Best regards,
> Krzysztof




