Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9986C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E5D22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E5D22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbeKNPIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:08:14 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37289 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbeKNPIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:08:14 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so7712499edb.4;
        Tue, 13 Nov 2018 21:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39bY1xg2aYyB2irnYj7cEOVbdrrvuhUEgj7aA/dSgT0=;
        b=cJq9xzkgmPsiLnbKpR1dH+jCNs1u0LBCCQBvF5nDl7iyt/9y1SDFgCF6yQ+ctOP86j
         YBnvkgkB9zrL1Z4lY0Hi78GzEx2NsxiYuWfCP51McvG+2nwfLnrXk/Bx657QrVo91Ucw
         iQHox/K8OzfaY9yoftKk3CFjuwOLjKBlIUE9Cobum72QzvsnUlo7bNt9/0uDMu8pWBcQ
         pJp5bXnsT33rZwhz626ozbYItSaDZh+7ECOWHf3wYM0WZ5kwyjCCrt2umDDWwiTNFmTE
         Fp5E9cqm/M+0MVTxR11ASIOrUKJZj2oVlkw5OVAKMQYKK8J70vuO/4cKgNsEtuxW+s6j
         B45Q==
X-Gm-Message-State: AGRZ1gLa29YJHM9ib/WyXmGQnGkmmQuwTassOXaJ3IqjO+rBZT0eRK1j
        JRAqWXhfT6t3Sbm8RdWnGMGqQx9wN2w=
X-Google-Smtp-Source: AJdET5e5ivMj3GuXk4wmi9te0xF94CQ4/qqsTwxNaDzGR8OLO31kRE7pAqjB6SGtUoBjAHUaPanKZw==
X-Received: by 2002:a50:9226:: with SMTP id i35-v6mr752629eda.50.1542171996294;
        Tue, 13 Nov 2018 21:06:36 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id 1-v6sm3344819ejv.65.2018.11.13.21.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 21:06:36 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id p4so6575788wrt.7;
        Tue, 13 Nov 2018 21:06:35 -0800 (PST)
X-Received: by 2002:a5d:4844:: with SMTP id n4-v6mr373374wrs.28.1542171995504;
 Tue, 13 Nov 2018 21:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20181107101308.7626-1-wens@csie.org> <20181107101308.7626-15-wens@csie.org>
 <20181108082447.5og6sz7ump7ccjnq@flea>
In-Reply-To: <20181108082447.5og6sz7ump7ccjnq@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 14 Nov 2018 13:06:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v66rJUg7FzNRHikh3uC1aB=3HxqFtZ7D8mmOOROubLsnEQ@mail.gmail.com>
Message-ID: <CAGb2v66rJUg7FzNRHikh3uC1aB=3HxqFtZ7D8mmOOROubLsnEQ@mail.gmail.com>
Subject: Re: [PATCH 14/15] ARM: dts: sunxi: Enable Broadcom-based Bluetooth
 for multiple boards
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-sunxi@googlegroups.com,
        Loic Poulain <loic.poulain@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 4:24 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Wed, Nov 07, 2018 at 06:13:07PM +0800, Chen-Yu Tsai wrote:
> > This patch adds the Bluetooth node, and the underlying UART node if it's
> > missing, to the board device tree file for several boards. The LPO clock
> > is also added to the WiFi side's power sequencing node if it's missing,
> > to correctly represent the shared connections. There is also a PCM
> > connection for Bluetooth, but this is not covered in this patch.
> >
> > These boards all have a WiFi+BT module from AMPAK, which contains one or
> > two Broadcom chips, depending on the model. The older AP6210 contains
> > two, while the newer AP6212 and AP6330 contain just one, as they use
> > two-in-one combo chips.
> >
> > The Bluetooth side of the module is always connected to a UART on the
> > same pingroup as the SDIO pins for the WiFi side, in a 4 wire
> > configuration. Power to the VBAT and VDDIO pins are provided either by
> > the PMIC, using one or several of its regulator outputs, or other fixed
> > regulators on the board. The VBAT and VDDIO pins are shared with the
> > WiFi side, which would correspond to vmmc-supply and vqmmc-supply in the
> > mmc host node. A clock output from the SoC or the external X-Powers RTC
> > provides the LPO low power clock at 32.768 kHz.
> >
> > All the boards covered in this patch are ones that do not require extra
> > changes to the SoC's dtsi file. For the remaining boards that I have
> > worked on, properties or device nodes for the LPO clock's source are
> > missing.
> >
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  arch/arm/boot/dts/sun7i-a20-cubietruck.dts    | 22 +++++++++++++++++++
> >  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  | 18 +++++++++++++++
> >  .../boot/dts/sun8i-a83t-cubietruck-plus.dts   | 18 +++++++++++++++
> >  arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  | 14 ++++++++++++
> >  4 files changed, 72 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > index 5649161de1d7..ccbf3b7a062b 100644
> > --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> > @@ -103,6 +103,8 @@
> >               pinctrl-names = "default";
> >               pinctrl-0 = <&mmc3_pwrseq_pin_cubietruck>;
> >               reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
> > +             clocks = <&ccu CLK_OUT_A>;
> > +             clock-names = "ext_clock";
> >       };
> >
> >       sound {
> > @@ -246,6 +248,10 @@
> >  };
> >
> >  &pio {
> > +     /* Pin outputs low power clock for WiFi and BT */
> > +     pinctrl-0 = <&clk_out_a_pins_a>;
> > +     pinctrl-names = "default";
> > +
>
> I guess we should make it clear in the comment why it cannot be tied
> to both devices.

I think it's a limitation of the implementation. But it's also a shared output,
so putting it at the source probably makes more sense. So I think it's more like
a preference rather than a hard limitation.

> >       ahci_pwr_pin_cubietruck: ahci_pwr_pin@1 {
> >               pins = "PH12";
> >               function = "gpio_out";
> > @@ -350,6 +356,22 @@
> >       status = "okay";
> >  };
> >
> > +&uart2 {
> > +     pinctrl-names = "default";
> > +     pinctrl-0 = <&uart2_pins_a>;
> > +     status = "okay";
>
> No RTS/CTS?

Missed this one. This was your Cubietruck patch squashed in with the rest.

ChenYu
