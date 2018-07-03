Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85691C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 411B224DE2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 08:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="quosYw0D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 411B224DE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeGCIQW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 04:16:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41739 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933551AbeGCIQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 04:16:20 -0400
Received: by mail-wr0-f193.google.com with SMTP id h10-v6so960154wrq.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 01:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RIejECPgKXXmWMP5M7oeE/hdmjb5KArTWEXIpIUHBJ8=;
        b=quosYw0D8Si4n7CdyIKw0rL0xcvmT1F/EHey8VhaL/Jf/Zd87IJgrBOkZ/eL2wFlhl
         /gZrT5hiSYukVrUZGtkvHX0obKt17Wwr+ar3tQzJfbrwl87Y/lDhCNAB2f89uPvYxAOs
         lZiCFYTzTbRpGsA5GUL1xGae+O6b0jHA34wKcihxyWsDi0guTmOPcoFKN/jPCpChFcic
         LAtrC77Xtx8/Q5wvDJ9Cbc5MXJm2+QfHOYKR7o4D3hUoloXRUpFjXmS7oJ84SSghCq0F
         keel9X/6WCWxAoQHoYXCJYZEq+ondTLZj/gV1HSodBy6TZ0GEbCUKnML1LUJUYX6AdE8
         vkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIejECPgKXXmWMP5M7oeE/hdmjb5KArTWEXIpIUHBJ8=;
        b=UIkPa5mmrmZU6DiQ4kyglXMA0/Ok4sYdBcFcCQ3XGE+3dmWdCx7aV/GggPAZSUI6ks
         tYacRcZ0U0rSpYJTCc2SgqIx7xCXMIuuolglaPCSaEe4O+GcyFaWJ1m/E5yIk29Coh3m
         +tEZ1V1ls27ROVhN3e+d+6+MDM7N/V6xVMOgJfq9nf8xcuDCO/Zr/frQei5BrtcAc2xN
         DomvFXIPvDgNjEjyJW1UjBKCI/GqIEIWGOuxIrzVA0AywCmI6Xp3G8cAiY2gQOMVzYcC
         HCPXDbK/XHtl/kqTZgGH7ztT4M+I7xSIXZpY2OASbg0CB5wy2wtmjhu1XZAo/oum3fXk
         bz8A==
X-Gm-Message-State: APt69E3jdUsg50WZ9H/IHg7KiMKraundMgumHJ8MxzYWzjR2wtO08W/Q
        xNfxW47rQNfc4hVWowfr0+UMuQ==
X-Google-Smtp-Source: AAOMgpcEMhbrRqGf6yk6GmwHJgIcjEnuD9NP4/v45FuvRggLrb1CRiyhgf2fwSrqpkcxkjJOw+lDwA==
X-Received: by 2002:adf:afd3:: with SMTP id y19-v6mr23677743wrd.176.1530605778696;
        Tue, 03 Jul 2018 01:16:18 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t10-v6sm493287wrq.74.2018.07.03.01.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 01:16:17 -0700 (PDT)
Message-ID: <1530605776.2900.163.camel@baylibre.com>
Subject: Re: [PATCH 1/3] clk: meson: add DT documentation for emmc clock
 controller
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Tue, 03 Jul 2018 10:16:16 +0200
In-Reply-To: <20180703145716.31860-2-yixun.lan@amlogic.com>
References: <20180703145716.31860-1-yixun.lan@amlogic.com>
         <20180703145716.31860-2-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-03 at 14:57 +0000, Yixun Lan wrote:
> Document the EMMC sub clock controller driver, the potential consumer
> of this driver is EMMC or NAND.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../bindings/clock/amlogic,emmc-clkc.txt      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
> new file mode 100644
> index 000000000000..5534bd446363
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,emmc-clkc.txt
> @@ -0,0 +1,45 @@
> +* Amlogic EMMC Sub Clock Controller Driver
> +
> +The Amlogic EMMC clock controller generates and supplies clock to support
> +EMMC and NAND controller
> +
> +Required Properties:
> +
> +- compatible: should be:
> +		"amlogic,emmc-clkc"

missing clocks and clock-names here

> +
> +- #clock-cells: should be 1.
> +
> +Two clocks are provided as the parent of this EMMC clock controller driver from
> +upper layer clock controller - eg "amlogic,axg-clkc" in AXG platfrom.
> +The main consumer of this driver is EMMC or NAND, to specify which the clock
> +they may consume, the preprocessor macros in the dt-bindings/clock/emmc-clkc.h
> +header and can be used in device tree sources.

Not sure this explanation belongs in dt-binding documentation.
Maybe this should be in the driver itself.

> +
> +Parent node should have the following properties :
> +- compatible: "syscon", "simple-mfd, and "amlogic,emmc-clkc"
> +- reg: base address and size of the EMMC control register space.
> +
> +Example: Clock controller node:
> +
> +sd_emmc_c_clkc: clock-controller@7000 {
> +	compatible = "amlogic,emmc-clkc", "syscon", "simple-mfd";
> +	reg = <0x0 0x7000 0x0 0x4>;
> +	#clock-cells = <1>;
> +
> +	clock-names = "clkin0", "clkin1";
> +	clocks = <&clkc CLKID_SD_EMMC_C_CLK0>,
> +			<&clkc CLKID_FCLK_DIV2>;
> +};
> +

Not sure the following is necessary, you don't really to show how to use a clock
controller.

> +Example: NAND controller node that consumes the clock generated by the clock
> +  controller:
> +
> +	nand: nfc@7800 {
> +		compatible = "amlogic,meson-axg-nfc";
> +		reg = <0x0 0x7800 0x0 0x100>;
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc CLKID_SD_EMMC_C>,
> +				<&sd_emmc_c_clkc CLKID_EMMC_C_DIV>;
> +		clock-names = "core", "device";
> +	};

