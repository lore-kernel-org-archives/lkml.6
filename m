Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DB2215F0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DB2215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeI1Ag0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:36:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34913 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeI1AgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:36:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id j9-v6so3526768otl.2;
        Thu, 27 Sep 2018 11:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HbqgzRDsFoHfh/PD5bSwuxuZlxkzFwExWkWx2uZClDU=;
        b=UO3H/hRWmP2k2CL8MkfcjtFP3D+Xrvi31HPsaWCoaQmMRE1YkdHrmxRPaUGonyQGjg
         3kS1dVU9CFpQ243ep5PA5kfcC8aprgHSOr1FPDkI6gV+OIiwmhzMbhj2Q1DQxQU9ralp
         2PyT8HhS9NfLbTffRf8fRFOk6iJY4Ot8MKL6l4QEJea8N3kdNZlPG2Ot91XxBxfP7lDJ
         3NPHPvF2GIyWDNXUiS/GhO5X8z3HRYUbjP6mHbd5oTcrKz9O2i4UG+A4wgEEMbYXNpyX
         xKXSL/nhuWDSYXnd+mJMV+3J2cm5e+NqrbbDPS+m3EOSsqnByQIgyhnVp6x3czhV9Ivm
         3CAA==
X-Gm-Message-State: ABuFfoh2oCo45mvIw7hijLHvY05h8qN8VEo6CnAuP5I+qJNL+uT4HX7D
        yz6uWjjr/4lRRfPxkcK+VA==
X-Google-Smtp-Source: ACcGV60x3yc8KkcnfxwmYo8pnapDjepkbAzfOVvEbSCI/2jtKnD20pfDRMMWHyDicFkInjRhb73Yag==
X-Received: by 2002:a9d:171c:: with SMTP id i28-v6mr7349444ota.359.1538072214712;
        Thu, 27 Sep 2018 11:16:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r18-v6sm991104otc.24.2018.09.27.11.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:16:53 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:16:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-mtd@lists.infradead.org, Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: nand: meson: add Amlogic NAND
 controller driver
Message-ID: <20180927181653.GA22153@bogus>
References: <1537433449-65213-1-git-send-email-jianxin.pan@amlogic.com>
 <1537433449-65213-2-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537433449-65213-2-git-send-email-jianxin.pan@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 04:50:48PM +0800, Jianxin Pan wrote:
> From: Liang Yang <liang.yang@amlogic.com>
> 
> Add Amlogic NAND controller dt-bindings for Meson SoC,
> Current this driver support GXBB/GXL/AXG platform.
> 
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  .../devicetree/bindings/mtd/amlogic,meson-nand.txt | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> new file mode 100644
> index 0000000..803df2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> @@ -0,0 +1,60 @@
> +Amlogic NAND Flash Controller (NFC) for GXBB/GXL/AXG family SoCs
> +
> +This file documents the properties in addition to those available in
> +the MTD NAND bindings.
> +
> +Required properties:
> +- compatible : contains one of:
> +  - "amlogic,meson-gxl-nfc"
> +  - "amlogic,meson-axg-nfc"
> +- clocks     :
> +	A list of phandle + clock-specifier pairs for the clocks listed
> +	in clock-names.
> +
> +- clock-names: Should contain the following:
> +	"core" - NFC module gate clock
> +	"device" - device clock from eMMC sub clock controller
> +
> +- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
> +				controller port C
> +
> +Optional children nodes:
> +Children nodes represent the available nand chips.
> +
> +Other properties:
> +see Documentation/devicetree/bindings/mtd/nand.txt for generic bindings.
> +
> +Example demonstrate on AXG SoC:
> +
> +	sd_emmc_c_clkc: mmc@7000 {
> +		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
> +		reg = <0x0 0x7000 0x0 0x800>;
> +		status = "okay";
> +	};
> +
> +	nand: nfc@7800 {

nand-controller@7800

> +		compatible = "amlogic,meson-axg-nfc";
> +		reg = <0x0 0x7800 0x0 0x100>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +		status = "disabled";
> +
> +		clocks = <&clkc CLKID_SD_EMMC_C>,
> +			<&sd_emmc_c_clkc CLKID_MMC_DIV>;
> +		clock-names = "core", "device";
> +		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
> +
> +		status = "okay";

Don't show status in examples, plus you have it twice.

> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&nand_pins>;
> +
> +		nand@0 {
> +			reg = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			nand-on-flash-bbt;
> +		};
> +	};
> -- 
> 1.9.1
> 
