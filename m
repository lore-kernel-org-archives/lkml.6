Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F19C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 526C820823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og2ZjSM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfAVQIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:08:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36825 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfAVQIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:08:11 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so20800418itj.1;
        Tue, 22 Jan 2019 08:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQnukHJhUtN1zC6XGrh1yFMwJ3zuZecoXCMtbRf1T7Y=;
        b=Og2ZjSM0MCqw7jQobZ07XPEH90DayF53y6b8+4nLyXdZXQ9WneE0C9mLL0HP8201rG
         csAViWw13AlM1Qb4E9B50fxOjf407tjOXfneYeP+e1h7UruJb1RuxH4ndm+mEmmpMYcQ
         tELpUibHUE6o25ajvo42HFCE09xj8yE8uA0RIc4DekX1fnQm8b2GEXMRk/j3Mu4kI3Gf
         iwtM4lRjGHBiHI+4y2BkOk/hBm7d9jesUu0oGu07SrY9lF8i+hVPyDOj1uU2c7qq9NkH
         bnQYoVEOFvrNepOBUPGOJSZyWseV+R0fNo+XtvYmszYAfxHWMuAO+KKEXRetSk1l4Z07
         wInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQnukHJhUtN1zC6XGrh1yFMwJ3zuZecoXCMtbRf1T7Y=;
        b=L/Gq1xige4EzWM7tM2Xghc8edLz/aq6W7CkOtxWWjXGaYh97SEt1ria8U+N3Rykupk
         la1iuivpYEmd2DJMI/ktN2nPdytDjcwtzUMtggQNR99qB6cSv5o6Uq0r4bmZGDKQ4mEC
         8WJshjTdKIKm8j7K1rOcupm+I4aWt+pQr+4Ad5Aaatde2GiT+JN30Vu8Nnw1NRpiMjan
         B3xXq2G93xfnJ23dDM6owE/U9Smir7EQlUrwcqS/INX0DYhtuQ+Qg6SKkvx/gehIdpaA
         d7Se42vONpxpgzxt0jobv4z+mbs0s5liBlj+3jvy2tzXW4E0BDf/urBCKd7PHk0Qfou+
         GyRA==
X-Gm-Message-State: AHQUAuZjv7C6EHINL8yeBWvl280h2bxJYJngbOslsJ27/uwI84dOaesr
        ZqNILIZQg5qNUhytYILj3t1h0q93M+XiGGxNPXU=
X-Google-Smtp-Source: AHgI3IbFPWICymMoiUMUhZUiSEU0UlY9I3qWRypXhY0OXznkV/nwBJb7whv14bbPs/8b1AcVV7clHr7wLLsLtGQSYLw=
X-Received: by 2002:a24:2452:: with SMTP id f79mr2643559ita.143.1548173289827;
 Tue, 22 Jan 2019 08:08:09 -0800 (PST)
MIME-Version: 1.0
References: <20190122140705.4918-1-aford173@gmail.com> <CAOMZO5D1bNjBkRbVukDCgXYOO6wqAEiBgj17dmW22Zstcj3e7w@mail.gmail.com>
In-Reply-To: <CAOMZO5D1bNjBkRbVukDCgXYOO6wqAEiBgj17dmW22Zstcj3e7w@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 22 Jan 2019 10:07:58 -0600
Message-ID: <CAHCN7x+uSyejYrJWBFyyy7eLwu05OT7Gf-9y+5MORaEVFcHOZg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Add support for Logic PD i.MX6QD EVM
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 9:19 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Adam,
>
> On Tue, Jan 22, 2019 at 12:07 PM Adam Ford <aford173@gmail.com> wrote:
>
> > +       reg_audio: regulator-audio {
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_reg_audio>;
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "3v3_aud";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               gpio = <&gpio1 29 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +               regulator-always-on;
>
> It seems that the 'regulator-always-on' property is not needed in this case.
>
> > +&i2c1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c1>;
> > +       clock-frequency = <400000>;
> > +       status = "okay";
> > +
> > +       codec: wm8962@1a {
>
> Node name should be generic and label name should be specific, so:
>
> wm8962: codec@1a {
>
> > +       chosen {
> > +               stdout-path = &uart1;
> > +       };
> > +
> > +       memory@10000000 {
>
> Need to pass device_type = "memory";
>
> > +               reg = <0x10000000 0x80000000>;
> > +       };
> > +
> > +       reg_wl18xx_vmmc: regulator-wl18xx {
> > +               compatible = "regulator-fixed";
> > +               regulator-name = "vwl1837";
> > +               regulator-min-microvolt = <3300000>;
> > +               regulator-max-microvolt = <3300000>;
> > +               gpio = <&gpio7 0 GPIO_ACTIVE_HIGH>;
> > +               startup-delay-us = <70000>;
> > +               enable-active-high;
> > +       };
> > +
>
> No need for this blank line.
>
> > +};
>
> > +&i2c3 {
> > +       clock-frequency = <100000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c3>;
> > +       status = "okay";
> > +
> > +       pmic: pfuze100@8 {
>
> pfuze100: pmic@8
>
> > +       tmp102_0: tmp102@4a {
>
> generic node name, please.

I have two temperature sensors.  Should I just call them tempsense0
and tempsense1?

>
> > +               compatible = "ti,tmp102";
> > +               reg = <0x4a>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_tempsense>;
> > +               interrupt-parent = <&gpio6>;
> > +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> > +               #thermal-sensor-cells = <1>;
> > +       };
> > +
> > +       tmp102_1: tmp102@49 {
>
> Ditto
>
> > +               compatible = "ti,tmp102";
> > +               reg = <0x49>;
> > +               interrupt-parent = <&gpio6>;
> > +               interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
> > +               #thermal-sensor-cells = <1>;
> > +       };
> > +
> > +       at24c64_mfg: at24@51 {

I have two eeproms.  One is a programmed by the factory with info like
serial number, model name, etc.  The other is blank and available for
users.

Should I name them something like 'eeprom_mfg' and 'eeprom_usr'?
>
> Ditto
>
> > +               compatible = "atmel,24c64";
> > +               pagesize = <32>;
> > +               read-only;      /* Manufacturing EEPROM programmed at factory */
> > +               reg = <0x51>;
> > +       };
> > +
> > +       at24c64_usr: at24@52 {
>
> Ditto
>
> > +       panel-lvds0 {
> > +               compatible = "ampire,am800480b3tmqw";
>
> Could not found this compatible documented.

I'll pull this out in V2.  I pushed a patch a while ago for this
display, but it's not been accepted yet, and I need to follow up on
this.
>
> > +&i2c1 {
> > +       ili_touch: ilitouch@26 {
>
> Generic node name, please.
>
> > +               compatible = "ili,ili2117a";
>
> Could not found this compatible documented.

I'll pull this out in V2.  I have a working driver, but I haven't
pushed it yet.  I'll add them back in once the driver's been pushed
and accepted.

thanks for reviewing this so quickly.

adam
