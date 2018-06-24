Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91DAC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586DB252A3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586DB252A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ccbib.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeFXQlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:41:32 -0400
Received: from h1.radempa.de ([176.9.142.194]:40595 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeFXQla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 12:41:30 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Jun 2018 12:41:29 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.cosmopool.net (Postfix) with ESMTP id BF50E9011A7;
        Sun, 24 Jun 2018 18:34:47 +0200 (CEST)
Received: from mail.cosmopool.net ([127.0.0.1])
        by localhost (mail.your-server.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LFTug78XZQTu; Sun, 24 Jun 2018 18:34:44 +0200 (CEST)
Received: from stardust.g4.wien.funkfeuer.at (77.117.167.127.wireless.dyn.drei.com [77.117.167.127])
        by mail.cosmopool.net (Postfix) with ESMTPSA id 6746C9009D1;
        Sun, 24 Jun 2018 18:34:43 +0200 (CEST)
Received: from lambda by stardust.g4.wien.funkfeuer.at with local (Exim 4.89)
        (envelope-from <harald@ccbib.org>)
        id 1fX7yK-0000OC-HA; Sun, 24 Jun 2018 18:34:40 +0200
From:   Harald Geyer <harald@ccbib.org>
To:     Icenowy Zheng <icenowy@aosc.io>
cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>, info@olimex.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCHv2 5/5] arm64: allwinner: a64: Add support for TERES-I laptop
In-reply-to: <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
References: <20180315162510.11669-1-harald@ccbib.org> <20180315162510.11669-6-harald@ccbib.org> <a7011fe78d171658742406bf01d50b7e3d7eaf1d.camel@aosc.io>
Comments: In-reply-to Icenowy Zheng <icenowy@aosc.io>
   message dated "Sat, 23 Jun 2018 00:27:21 +0800."
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-ID: <1498.1529858080.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: 8bit
Date:   Sun, 24 Jun 2018 18:34:40 +0200
Message-Id: <E1fX7yK-0000OC-HA@stardust.g4.wien.funkfeuer.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Icenowy Zheng writes:
> 在 2018-03-15四的 16:25 +0000，Harald Geyer写道：
> > +&mmc1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc1_pins>;
> > +	vmmc-supply = <&reg_aldo2>;
> > +	vqmmc-supply = <&reg_dldo4>;
> > +	mmc-pwrseq = <&wifi_pwrseq>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	status = "okay";
> > +
> > +	rtl8723bs: wifi@1 {
> > +		reg = <1>;
> > +		interrupt-parent = <&r_pio>;
> > +		interrupts = <0 3 IRQ_TYPE_LEVEL_LOW>; /* PL3 */
> > +		interrupt-names = "host-wake";
> > +	};
> 
> I think this node has some problem:

Thanks for the heads up! Admittedly, I simply copied this node from
sun50i-a64-olinuxino.dts and since it worked, didn't look into it in
too much detail.

> - This device node has no binding. The "host-wake" interrupt is part of
>  Broadcom SDIO Wi-Fi binding, rather than a generic one.

I think the general mmc and interrupts bindings apply. And the mmc binding
clearly states that for sub-nodes a compatible string is optional.

However I just realized that the 'interrupt-names' property is not part
of the general interrupts binding, so I guess at least this property should
be removed.

> - Without the interrupt this device node isn't needed, as RTL8723BS has
> MAC eFUSE and doesn't need a MAC in device tree.

Indeed. I wasn't aware of this, but I just tested and the device probes
fine without the subnode present. I think the devicetree is mainly for
information which cannot be probed, so maybe the subnode should just get
removed.

> In order to solve the problems. I suggest either drop this device node
> or make a generic "sdio-wifi" device tree binding. Personally I prefer
> the latter, as it's more accurate device representation.
> 
> If such a device tree binding is added, I think it should contain the
> "host-wake" interrupt and a "local-mac-address" property. Both can be
> ignored by the driver. (This interrupt can be needed if a more card-
> ventor-neutral name is found.)

I don't feel qualified to comment on this. If you want to propose such
a patch and fix above node accordingly, I won't object. Otherwise I'll
just send a patch to remove the subnode.

Thanks,
Harald
