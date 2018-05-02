Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeEBNk6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:40:58 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:62797 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeEBNku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:40:50 -0400
From: "Reizer, Eyal" <eyalr@ti.com>
To: "Nori, Sekhar" <nsekhar@ti.com>, Eyal Reizer <eyalreizer@gmail.com>,
        "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm: dts: am437x-sk-evm: add wilink8 support
Thread-Topic: [PATCH] arm: dts: am437x-sk-evm: add wilink8 support
Thread-Index: AQHT4e/o3j/tTV/a2U2rKUML7UrPhqQcciFA
Date: Wed, 2 May 2018 13:40:39 +0000
Message-ID: <d6e88ea0fe624c238bace4dfe5aaf882@ti.com>
References: <1525159453-32489-1-git-send-email-eyalr@ti.com>
 <abebf4a1-11d6-413b-a3c0-4f46ac6fc485@ti.com>
In-Reply-To: <abebf4a1-11d6-413b-a3c0-4f46ac6fc485@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.167.25.139]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w42Df0V5017984

> 
> ARM should be capitalized in subject line.

OK, will be fixed in v2
> 
> > +
> > +&mmc3 {
> > +	status = "okay";
> > +	/*
> > +	 * these are on the crossbar and are outlined in the
> > +	 * xbar-event-map element
> > +	 */
> > +	dmas = <&edma_xbar 30 0 1>,
> > +		<&edma_xbar 31 0 2>;
> > +	dma-names = "tx", "rx";
> > +	vmmc-supply = <&vmmcwl_fixed>;
> > +	bus-width = <4>;
> > +	pinctrl-names = "default", "sleep";
> > +	pinctrl-0 = <&mmc3_pins_default>;
> > +	pinctrl-1 = <&mmc3_pins_sleep>;
> > +	cap-power-off-card;
> > +	keep-power-in-suspend;
> > +	ti,non-removable;
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	wlcore: wlcore@0 {
> 
> wlcore@2
> 
Will be fixed in v2

> > +		compatible = "ti,wl1835";
> > +		pinctrl-names = "default", "sleep";
> > +		pinctrl-0 = <&wlan_pins_default>;
> > +		pinctrl-1 = <&wlan_pins_sleep>;
> > +		reg = <2>;
> > +		interrupt-parent = <&gpio4>;
> > +		interrupts = <13 IRQ_TYPE_LEVEL_HIGH>;
> > +	};
> > +};
> 
Best Regards,
Eyal
