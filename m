Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F1AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B52075A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 23:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b06qnl8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfBVXRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:17:08 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40225 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfBVXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 18:17:08 -0500
Received: by mail-lf1-f66.google.com with SMTP id t14so2950850lfk.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 15:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVA5AzqZXjoEZrnV/wDb3648VGZnrciSCRyMN8afaEI=;
        b=b06qnl8+NxU0DFRKXfrkRf89dNhg2oEWtuDsDM1SAX3FlBjMBeRHbuzEPwov6IPXxB
         ys/bOhRH/ce6+jSAWumO0o+FOKFTIT9o/xdPVqWyTCr3F0ifZMcf+GnMFVAQN8pjiRQm
         cVRbXjzjEtbmH+oc+koPHed/GuPZ23SPXdqS0WP2NHr3tEQs+LUQCDwHjd71egu4aq+E
         BYSZnDi+7PALKXd/TiYzbBeJCXvOdTo8NAUrjgJ+0cBuV1JblRz5ghXdQ2Nzr65UIxmV
         0Xfx1Y/3KgFXJBN1B/M1cvTMDyoVLNNPZiAs+qIXxwRijjQtaeiane9d66kdVwsf+aUM
         63Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVA5AzqZXjoEZrnV/wDb3648VGZnrciSCRyMN8afaEI=;
        b=tq9Cen6JgNa/RHxoMLKVcshgBF5oc7zKgi2996Kmhs5RnpHiRoqqYz/Bg9QmtC+o6W
         F3Eofy0yGsu1oA+fGIEjr1eF5Au4pv6lFDI7YMyNx7nD1aoerzu5LOH+amuKxmgvWKJN
         Jll4bEkben42b6j3WEVXRSEKf45pfBZ1qbFQPsDOSYQEHagANMsPCTvYxuKAdOt1lrWR
         FUjs24vAd8wsNsQXHmS54CIhoOfY7vpdl2EXgsoadQRmoF1BUKwf6n4TRV6MzOazVu6+
         vnfobvQvZzb0BMfZ3w/TP3cm8HXRDk0kpQ4yjR1uhN4uiCRdmZ48ILw8o9JBtXC6lBLM
         gsCA==
X-Gm-Message-State: AHQUAubZ8rPXhHbS/kHOLx7ibvOo/8/R2Cm4Nh+BIoOdaBMHEzHz2KHq
        kA4xkLjsUM7G9vvzd2kc33kMiloVUalkITVyOTZaXA==
X-Google-Smtp-Source: AHgI3IYxYgwN64NEcMkPWmYeD4yKD23EGN/aBuTZ0FgXvYhV6n/aP6dHDRihRHGlzXr8LvRoqdDkhOS5ZGT/cYxoQSI=
X-Received: by 2002:ac2:52b7:: with SMTP id r23mr4159046lfm.66.1550877424745;
 Fri, 22 Feb 2019 15:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-3-briannorris@chromium.org> <20190222182740.GC223791@google.com>
In-Reply-To: <20190222182740.GC223791@google.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Fri, 22 Feb 2019 15:16:27 -0800
Message-ID: <CACK8Z6ErHe3jJK7rVFA65BmJ_T9p1UcbXZWOdHJ0THXsVYk5Cg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: move QCA6174A wakeup pin into
 its USB node
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Brian Norris <briannorris@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:27 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Thu, Feb 21, 2019 at 04:34:03PM -0800, Brian Norris wrote:
> > Currently, we don't coordinate BT USB activity with our handling of the
> > BT out-of-band wake pin, and instead just use gpio-keys. That causes
> > problems because we have no way of distinguishing wake activity due to a
> > BT device (e.g., mouse) vs. the BT controller (e.g., re-configuring wake
> > mask before suspend). This can cause spurious wake events just because
> > we, for instance, try to reconfigure the host controller's event mask
> > before suspending.
> >
> > We can avoid these synchronization problems by handling the BT wake pin
> > directly in the btusb driver -- for all activity up until BT controller
> > suspend(), we simply listen to normal USB activity (e.g., to know the
> > difference between device and host activity); once we're really ready to
> > suspend the host controller, there should be no more host activity, and
> > only *then* do we unmask the GPIO interrupt.
> >
> > This is already supported by btusb; we just need to describe the wake
> > pin in the right node.
> >
> > We list 2 compatible properties, since both PID/VID pairs show up on
> > Scarlet devices, and they're both essentially identical QCA6174A-based
> > modules.
> >
> > Also note that the polarity was wrong before: Qualcomm implemented WAKE
> > as active high, not active low. We only got away with this because
> > gpio-keys always reconfigured us as bi-directional edge-triggered.
> >
> > Finally, we have an external pull-up and a level-shifter on this line
> > (we didn't notice Qualcomm's polarity in the initial design), so we
> > can't do pull-down. Switch to pull-none.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>

If it matters, LGTM.

Reviewed-by: Rajat Jain <rajatja@google.com>

> > ---
> > This patch is also required to make this stable, but since it's not
> > really tied to the device tree, and it's an existing bug, I sent it
> > separately:
> >
> >   https://lore.kernel.org/patchwork/patch/1044896/
> >   Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
> >
> >  .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 13 ++++++
> >  .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 46 ++++++++++++-------
> >  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 13 ------
> >  3 files changed, 42 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> > index c400be64170e..931640e9aed4 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi
> > @@ -200,6 +200,19 @@
> >               pinctrl-0 = <&bl_en>;
> >               pwm-delay-us = <10000>;
> >       };
> > +
> > +     gpio_keys: gpio-keys {
> > +             compatible = "gpio-keys";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&bt_host_wake_l>;
> > +
> > +             wake_on_bt: wake-on-bt {
> > +                     label = "Wake-on-Bluetooth";
> > +                     gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <KEY_WAKEUP>;
> > +                     wakeup-source;
> > +             };
> > +     };
> >  };
> >
> >  &ppvar_bigcpu {
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> > index fc50b3ef758c..3e2196c08473 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
> > @@ -175,6 +175,21 @@
> >               pinctrl-0 = <&dmic_en>;
> >               wakeup-delay-ms = <250>;
> >       };
> > +
> > +     gpio_keys: gpio-keys {
> > +             compatible = "gpio-keys";
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&pen_eject_odl>;
> > +
> > +             pen-insert {
> > +                     label = "Pen Insert";
> > +                     /* Insert = low, eject = high */
> > +                     gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> > +                     linux,code = <SW_PEN_INSERTED>;
> > +                     linux,input-type = <EV_SW>;
> > +                     wakeup-source;
> > +             };
> > +     };
> >  };
> >
> >  /* pp900_s0 aliases */
> > @@ -328,20 +343,6 @@ camera: &i2c7 {
> >               <400000000>;
> >  };
> >
> > -&gpio_keys {
> > -     pinctrl-names = "default";
> > -     pinctrl-0 = <&bt_host_wake_l>, <&pen_eject_odl>;
> > -
> > -     pen-insert {
> > -             label = "Pen Insert";
> > -             /* Insert = low, eject = high */
> > -             gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> > -             linux,code = <SW_PEN_INSERTED>;
> > -             linux,input-type = <EV_SW>;
> > -             wakeup-source;
> > -     };
> > -};
> > -
> >  &i2c_tunnel {
> >       google,remote-bus = <0>;
> >  };
> > @@ -437,8 +438,19 @@ camera: &i2c7 {
> >       status = "okay";
> >  };
> >
> > -&wake_on_bt {
> > -     gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> > +&usb_host0_ohci {
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +
> > +     qca_bt: bt@1 {
> > +             compatible = "usb0cf3,e300", "usb04ca,301a";
> > +             reg = <1>;
> > +             pinctrl-names = "default";
> > +             pinctrl-0 = <&bt_host_wake_l>;
> > +             interrupt-parent = <&gpio1>;
> > +             interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
> > +             interrupt-names = "wakeup";
> > +     };
> >  };
>
> I didn't know it was possible to configure (certain) USB devices
> through the DT, neat!
>
> >
> >  /* PINCTRL OVERRIDES */
> > @@ -455,7 +467,7 @@ camera: &i2c7 {
> >  };
> >
> >  &bt_host_wake_l {
> > -     rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_up>;
> > +     rockchip,pins = <1 2 RK_FUNC_GPIO &pcfg_pull_none>;
> >  };
> >
> >  &ec_ap_int_l {
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > index ea607a601a86..da03fa9c5662 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> > @@ -269,19 +269,6 @@
> >               #clock-cells = <0>;
> >       };
> >
> > -     gpio_keys: gpio-keys {
> > -             compatible = "gpio-keys";
> > -             pinctrl-names = "default";
> > -             pinctrl-0 = <&bt_host_wake_l>;
> > -
> > -             wake_on_bt: wake-on-bt {
> > -                     label = "Wake-on-Bluetooth";
> > -                     gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> > -                     linux,code = <KEY_WAKEUP>;
> > -                     wakeup-source;
> > -             };
> > -     };
> > -
> >       max98357a: max98357a {
> >               compatible = "maxim,max98357a";
> >               pinctrl-names = "default";
>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
