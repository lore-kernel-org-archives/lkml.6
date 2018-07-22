Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FAAECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C281C2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOGnrB8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C281C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeGVGy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:54:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39291 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeGVGy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:54:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id h10-v6so14750421wre.6;
        Sat, 21 Jul 2018 22:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jtIjNphk94xclpuJTF7F7TWBnlxAVrDXbpCLSst/Vg=;
        b=NOGnrB8FIJkPFiQGKhTRHI1VfbxjINSidv/Wkl1DmcaaYyX5+TNs97EZYLR3wYn4Ng
         0bclyFW47W+4CZoRs1fkHkVrT2BC5RyMwoFaDEIWxRjlFmcFp/KiN/MwRdne3ae9Ox8/
         Jt3iJ5ceN+hfoQXdjfKEpRGJYOoMYylB09eRFWp30ygobvDhWqf7PHtLj5T8566kJr1P
         2mn8SvIv74Zl2kU9t5P26HEnwpw4f+cQ22yuStUbA9f0WFGXgojOQ/RE9xt9XjamJ0yC
         fnMi7hbCx5QNerJlJz89ekWMlmfpSIWNUBMgNS/k0hBxNFLBIP3Man0XBlnR37nBba/q
         FJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jtIjNphk94xclpuJTF7F7TWBnlxAVrDXbpCLSst/Vg=;
        b=ZVQ+z5yFEL7OXf2uZzBbA+Xuf/JMvWEojrwY3354rSzFM0p4m4qdf/VyuCGWOOsw+z
         cdYHAvB2WFw+mJLahkNH2jtE9bvi7VCpdvUbSWnR6Sk82P2WVv9kP0jmu6w9UbcmlzRy
         fZBBkf8bGxGL8/WDhHziHoIB0TVY0LnPlHY8mdXzNN9iKWp8uK4b5CcDMra9d3i2ezsa
         7oY8r2Kgbt8531n3zBxF+sOfXoj8nbDLOp0GpMpHaB1pp2dZbWTj01yB6rjyQ0dTT5Ga
         h+5vF6u0rGS+y2wmnF9pB9C/tVlsUUz9VACp2pjcb0dKPs9PYfzPAv/P1vY2VvMJjTtm
         OTmQ==
X-Gm-Message-State: AOUpUlFfG26kn+t0XE4kua3PqpzeWWh4Zbw3P+/BGOIgbTzrhQc7bCsx
        V/WS/GsAwZEVWbR4dgkjdfE=
X-Google-Smtp-Source: AAOMgpepmAAAhDss747xA7n2GOFvvqcqE9RBJQKlLJYcqFy4t5WRVUZm0O1OIgJwmsat/bVTWu0+Eg==
X-Received: by 2002:adf:aa0b:: with SMTP id p11-v6mr5071361wrd.220.1532239169747;
        Sat, 21 Jul 2018 22:59:29 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id i205-v6sm7608991wmf.30.2018.07.21.22.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 22:59:29 -0700 (PDT)
Date:   Sun, 22 Jul 2018 07:59:01 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "David S. Miller" <davem@davemloft.net>,
        Corentin Labbe <clabbe@baylibre.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] [PATCH 4/5] arm64: allwinner: h6: add EMAC device
 nodes
Message-ID: <20180722055901.GA8055@Red>
References: <20180722053955.25266-1-icenowy@aosc.io>
 <20180722053955.25266-5-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722053955.25266-5-icenowy@aosc.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 01:39:54PM +0800, Icenowy Zheng wrote:
> Allwinner H6 SoC has an EMAC like the one in A64.
> 
> Add device tree nodes for the H6 DTSI file.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 30 ++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index 3ab6cf0256ca..c65311de301a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -149,6 +149,14 @@
>  			interrupt-controller;
>  			#interrupt-cells = <3>;
>  
> +			ext_rgmii_pins: rgmii_pins {
> +				pins = "PD0", "PD1", "PD2", "PD3", "PD4",
> +				       "PD5", "PD7", "PD8", "PD9", "PD10",
> +				       "PD11", "PD12", "PD13", "PD19", "PD20";
> +				function = "emac";
> +				drive-strength = <40>;
> +			};
> +
>  			mmc0_pins: mmc0-pins {
>  				pins = "PF0", "PF1", "PF2", "PF3",
>  				       "PF4", "PF5";
> @@ -258,6 +266,28 @@
>  			status = "disabled";
>  		};
>  
> +		emac: ethernet@5020000 {
> +			compatible = "allwinner,sun50i-a64-emac",
> +				     "allwinner,sun50i-h6-emac";
> +			syscon = <&syscon>;
> +			reg = <0x05020000 0x10000>;
> +			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "macirq";
> +			resets = <&ccu RST_BUS_EMAC>;
> +			reset-names = "stmmaceth";
> +			clocks = <&ccu CLK_BUS_EMAC>;
> +			clock-names = "stmmaceth";
> +			status = "disabled";
> +			#address-cells = <1>;
> +			#size-cells = <0>;

#address-cells and #size-cells is unnecessary in emac node.

Regards
