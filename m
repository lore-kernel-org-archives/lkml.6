Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED2FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637B0214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CuWdPgao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfBKLbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:31:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36659 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbfBKLbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:31:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id r124so115433pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 03:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1JEsM2JroaIkgmQdl0RF583/B2IH0sbtfKhWqOtEjUs=;
        b=CuWdPgao3jxTWpC42B3xsZEZDyFAk2lPD1KD1eLGUXz1wc548X8a22ZQNNAyOUn3qA
         30fi/Bu55C3jAfB7dd83OJgWKTQ9y5EDTgtFYgxcMu6PlGKLtu8vT4u477weNfva54dY
         RfC5ID5AcVPQ2QdQBfY0ADLMQ+cFHlOsbo8qGnsFns07cOQOgYuYwwPsc3Gy8QjCfa1q
         oGnzM1D7tOKLibD8SLJIemPnHZuwtxJKU9LO+4+blkYA7L8cyN6r5BAX4fDWd08yzfEP
         CoYT1dyIspgxBp8PRi5jqPuuet9jNvwTgKgOUl+0RaBOrIgDEU9BGnPP03QnZtFEgIqj
         mNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1JEsM2JroaIkgmQdl0RF583/B2IH0sbtfKhWqOtEjUs=;
        b=rQRne9/mJ5h43g+oD9LbktiEbKgmcv2iw7SmY73aYN/aT2EB4xDrPW8HLJUkoHRV+V
         0gNHuMuHQFvnifMxsN3dJhtEs6ZFKiYOrVfqAxaUOzBtLVSoTLbYBxIxBFB6bdgn7Pdy
         qCNq8NYPF6XY7+3/yQlpwyi8vnJtDpToxZtWuI3En9bzjbyGm8MtIbWaJgLEIJhKjq72
         feVi+jchjwP9fiFRec58LZJb90ER+0DqEdPQjJ1qoVqEiphUO3RVSKzfPo0L0jah+sUn
         S1J+fe9du6SMqVPFgrxOaW0GKGmvyVzd7JLGSZvVmI4LcZe7TdjKbu/2sbuOSkE8vrxf
         ZqYw==
X-Gm-Message-State: AHQUAuZo/T/r998NjURhftohSYQ+TXpQ6OVm7bgmOm3YmKVnty+X66Ql
        Ma5RpJW+rg8Ze5shnI78E9hw+Ul7Zg==
X-Google-Smtp-Source: AHgI3IZZuo9rgU7o3ot5BBMRbdYb73AQNCudhwnF1oIxRzD93E9ZK/P4t2XDoT8ubAU4REJBl3WKZg==
X-Received: by 2002:a65:6242:: with SMTP id q2mr33334510pgv.245.1549884697128;
        Mon, 11 Feb 2019 03:31:37 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id e21sm48408047pfh.45.2019.02.11.03.31.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 03:31:36 -0800 (PST)
Date:   Mon, 11 Feb 2019 17:01:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, ezequiel@collabora.com,
        tom@vamrs.com, dev@vamrs.com, linux-kernel@vger.kernel.org,
        mani@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add on-board WiFi/BT support for
 Rock960 boards
Message-ID: <20190211113128.GA22843@mani>
References: <20190207055349.27919-1-manivannan.sadhasivam@linaro.org>
 <CALeDE9MNa+CDJR8bvS05f2UTKrhwMRo8jzdS5o8Ndu7H8V8Ldg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALeDE9MNa+CDJR8bvS05f2UTKrhwMRo8jzdS5o8Ndu7H8V8Ldg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Feb 08, 2019 at 04:45:01PM +0000, Peter Robinson wrote:
> Hi Mani,
> 
> On Thu, Feb 7, 2019 at 5:54 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Add on-board WiFi/BT support for Rock960 boards such as Rock960 based
> > on AP6356S and Ficus based on AP6354 wireless modules.
> >
> > Firmwares for the respective boards are available here:
> >
> > http://people.linaro.org/~manivannan.sadhasivam/rock960_wifi/
> > http://people.linaro.org/~manivannan.sadhasivam/ficus_wifi/
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> There's some warnings on building these I noticed in testing this on Fedora:
> 
>   DTC     arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
> (reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
> (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning
> (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (i2c_bus_reg):
> Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-ficus.dtb: Warning (spi_bus_reg):
> Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> #address-cells value
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> #size-cells value
> 
>   DTC     arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:490.3-13: Warning
> (reg_format): /dwmmc@fe310000/wifi@1:reg: property has invalid length
> (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
> (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
> (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtb: Warning
> (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> #address-cells value
> arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi:488.16-496.4: Warning
> (avoid_default_addr_size): /dwmmc@fe310000/wifi@1: Relying on default
> #size-cells value
> 

Hmm. Since the parent node "sdio0" is missing the address/size cells
property, the default value has been used by the DTC. I think it would
make sense to just drop the reg property from "wifi" node instead of
modifying the parent "sdio0" node.

If no one has any issue over this, I'll send out another revision with the
reg property removed.

Thanks,
Mani

> > ---
> >  .../boot/dts/rockchip/rk3399-rock960.dtsi     | 96 ++++++++++++++++++-
> >  1 file changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > index 56abbb08c133..1b2f7cd82244 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
> > @@ -9,6 +9,15 @@
> >  #include "rk3399-opp.dtsi"
> >
> >  / {
> > +       sdio_pwrseq: sdio-pwrseq {
> > +               compatible = "mmc-pwrseq-simple";
> > +               clocks = <&rk808 1>;
> > +               clock-names = "ext_clock";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&wifi_enable_h>;
> > +               reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
> > +       };
> > +
> >         vcc1v8_s0: vcc1v8-s0 {
> >                 compatible = "regulator-fixed";
> >                 regulator-name = "vcc1v8_s0";
> > @@ -362,6 +371,20 @@
> >  };
> >
> >  &pinctrl {
> > +       bt {
> > +               bt_enable_h: bt-enable-h {
> > +                       rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
> > +               };
> > +
> > +               bt_host_wake_l: bt-host-wake-l {
> > +                       rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
> > +               };
> > +
> > +               bt_wake_l: bt-wake-l {
> > +                       rockchip,pins = <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
> > +               };
> > +       };
> > +
> >         sdmmc {
> >                 sdmmc_bus1: sdmmc-bus1 {
> >                         rockchip,pins =
> > @@ -387,6 +410,26 @@
> >                 };
> >         };
> >
> > +       sdio0 {
> > +               sdio0_bus4: sdio0-bus4 {
> > +                       rockchip,pins =
> > +                               <2 20 RK_FUNC_1 &pcfg_pull_up_20ma>,
> > +                               <2 21 RK_FUNC_1 &pcfg_pull_up_20ma>,
> > +                               <2 22 RK_FUNC_1 &pcfg_pull_up_20ma>,
> > +                               <2 23 RK_FUNC_1 &pcfg_pull_up_20ma>;
> > +               };
> > +
> > +               sdio0_cmd: sdio0-cmd {
> > +                       rockchip,pins =
> > +                               <2 24 RK_FUNC_1 &pcfg_pull_up_20ma>;
> > +               };
> > +
> > +               sdio0_clk: sdio0-clk {
> > +                       rockchip,pins =
> > +                               <2 25 RK_FUNC_1 &pcfg_pull_none_20ma>;
> > +               };
> > +       };
> > +
> >         pmic {
> >                 pmic_int_l: pmic-int-l {
> >                         rockchip,pins =
> > @@ -403,6 +446,19 @@
> >                                 <1 14 RK_FUNC_GPIO &pcfg_pull_down>;
> >                 };
> >         };
> > +
> > +       sdio-pwrseq {
> > +               wifi_enable_h: wifi-enable-h {
> > +                       rockchip,pins =
> > +                               <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
> > +               };
> > +       };
> > +
> > +       wifi {
> > +               wifi_host_wake_l: wifi-host-wake-l {
> > +                       rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> > +               };
> > +       };
> >  };
> >
> >  &pwm2 {
> > @@ -413,6 +469,33 @@
> >         status = "okay";
> >  };
> >
> > +&sdio0 {
> > +       clock-frequency = <50000000>;
> > +       bus-width = <4>;
> > +       cap-sdio-irq;
> > +       cap-sd-highspeed;
> > +       no-emmc;
> > +       keep-power-in-suspend;
> > +       mmc-pwrseq = <&sdio_pwrseq>;
> > +       non-removable;
> > +       num-slots = <1>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
> > +       sd-uhs-sdr104;
> > +
> > +       status = "okay";
> > +
> > +       brcmf: wifi@1 {
> > +               compatible = "brcm,bcm4329-fmac";
> > +               reg = <1>;
> > +               interrupt-parent = <&gpio0>;
> > +               interrupts = <RK_PA3 GPIO_ACTIVE_HIGH>;
> > +               interrupt-names = "host-wake";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&wifi_host_wake_l>;
> > +       };
> > +};
> > +
> >  &sdhci {
> >         bus-width = <8>;
> >         mmc-hs400-1_8v;
> > @@ -439,8 +522,19 @@
> >
> >  &uart0 {
> >         pinctrl-names = "default";
> > -       pinctrl-0 = <&uart0_xfer &uart0_cts>;
> > +       pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> >         status = "okay";
> > +
> > +       bluetooth {
> > +               compatible = "brcm,bcm43438-bt";
> > +               clocks = <&rk808 1>;
> > +               clock-names = "ext_clock";
> > +               device-wakeup-gpios = <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
> > +               host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
> > +               shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
> > +       };
> >  };
> >
> >  &uart2 {
> > --
> > 2.17.1
> >
