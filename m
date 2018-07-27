Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC13C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF252088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 15:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CF252088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388771AbeG0RHe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:07:34 -0400
Received: from mailoutvs39.siol.net ([185.57.226.230]:35025 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388075AbeG0RHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:07:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id E122C521376;
        Fri, 27 Jul 2018 17:45:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id y31Pj7pYCjg9; Fri, 27 Jul 2018 17:45:02 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4C2815213D8;
        Fri, 27 Jul 2018 17:45:02 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id 571675213B2;
        Fri, 27 Jul 2018 17:45:00 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, icenowy@aosc.io
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI output on A64 boards w/ HDMI
Date:   Fri, 27 Jul 2018 17:44:59 +0200
Message-ID: <2190272.845Jehz4jH@jernej-laptop>
In-Reply-To: <7e1dcd8796e417924072f14b2a50af73@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io> <20180727140032.go6f3dwzxrzfstzj@flea> <7e1dcd8796e417924072f14b2a50af73@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 27. julij 2018 ob 17:42:08 CEST je Icenowy Zheng napisal(a):
> 在 2018-07-27 22:00，Maxime Ripard 写道：
> 
> > On Fri, Jul 27, 2018 at 09:26:11PM +0800, Icenowy Zheng wrote:
> >> 于 2018年7月27日 GMT+08:00 下午8:56:15, Maxime Ripard
> >> 
> >> <maxime.ripard@bootlin.com> 写到:
> >> >On Fri, Jul 27, 2018 at 01:12:57AM +0800, Icenowy Zheng wrote:
> >> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> >
> >> >b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> >
> >> >> index 1b9b92e541d2..1b972bade9f6 100644
> >> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> >> >> @@ -62,6 +62,21 @@
> >> >> 
> >> >>  	chosen {
> >> >>  	
> >> >>  		stdout-path = "serial0:115200n8";
> >> >>  	
> >> >>  	};
> >> >> 
> >> >> +
> >> >> +	connector {
> >> >> +		compatible = "hdmi-connector";
> >> >> +		type = "a";
> >> >> +
> >> >> +		port {
> >> >> +			hdmi_con_in: endpoint {
> >> >> +				remote-endpoint = <&hdmi_out_con>;
> >> >> +			};
> >> >> +		};
> >> >> +	};
> >> >> +};
> >> >> +
> >> >> +&de {
> >> >> +	status = "okay";
> >> >> 
> >> >>  };
> >> >>  
> >> >>  &ehci0 {
> >> >> 
> >> >> @@ -82,6 +97,17 @@
> >> >> 
> >> >>  };
> >> >> 
> >> >> +&hdmi {
> >> >> +	hdmi-supply = <&reg_dldo1>;
> >> >> +	status = "okay";
> >> >> +};
> >> >> +
> >> >> +&hdmi_out {
> >> >> +	hdmi_out_con: endpoint {
> >> >> +		remote-endpoint = <&hdmi_con_in>;
> >> >> +	};
> >> >> +};
> >> >> +
> >> >> 
> >> >>  &i2c1 {
> >> >>  
> >> >>  	pinctrl-names = "default";
> >> >>  	pinctrl-0 = <&i2c1_pins>;
> >> >> 
> >> >> @@ -99,6 +125,10 @@
> >> >> 
> >> >>  	};
> >> >>  
> >> >>  };
> >> >> 
> >> >> +&mixer1 {
> >> >> +	status = "okay";
> >> >> +};
> >> >> +
> >> >> 
> >> >>  &mmc0 {
> >> >>  
> >> >>  	pinctrl-names = "default";
> >> >>  	pinctrl-0 = <&mmc0_pins>;
> >> >> 
> >> >> @@ -238,6 +268,10 @@
> >> >> 
> >> >>  	status = "disabled";
> >> >>  
> >> >>  };
> >> >> 
> >> >> +&tcon1 {
> >> >> +	status = "okay";
> >> >> +};
> >> >
> >> >Is it working or not on the pine64?
> >> 
> >> Not tested yet, as my main A64 device is Pine A64-LTS now.
> > 
> > It was last reported as broken, so it's better to leave it out of that
> > patch until someone figures it out.
> 
> Sorry, I did find a bug. Although after fixing it HDMI on Pine A64+
> works fine.
> 
> Will fix the bug when sending v3.2 (resending after rc1).

Why don't you simply send v4, with all patches and changelogs? It would be 
easier to comprehend.

Best regards,
Jernej

> 
> > Thanks!
> > Maxime




