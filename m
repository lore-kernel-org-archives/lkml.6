Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449BC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACA2213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mH7ur8hQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACA2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbeHNN2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:28:05 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52912 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731697AbeHNN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:28:05 -0400
Received: by mail-wm0-f67.google.com with SMTP id o11-v6so11725148wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ek1VyfZBkNL95MpOEtQ1JWHEARP2X549/Zayie6+/A0=;
        b=mH7ur8hQpwfOD/VMEEKxTH/HiXG49H0KPZaDCTzM+3CA6IGJTqQL3vVUT3J4Vlf2I5
         85fAGbOR3PSK38yml3+/UkqYVVrUHYVr4M+P3dBlEs7DB2x3C6ZYB1kg8DmJRo8jNPrn
         Y9uxw/1CeIJ0dOQQoVR6uoO+78rNZDJOBH7gGOgE9mStBpI2HxBR/xqyUl47cDbZ02e+
         7EyMuGKY92sZBDe74h5RrB/OF+NkfDgqd4a5Wvnb/ws/jkcWYD4wH6hVsciLAMa3hY7o
         6+rhUR8f95Hy5GrDHqlAYu0gBJhDCVGN7NG0EnS5t/cXNHhPKi7wupjhGFjP5ijT+IqZ
         cfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ek1VyfZBkNL95MpOEtQ1JWHEARP2X549/Zayie6+/A0=;
        b=Tbsz9mIHxadeNFkzxohQDd3VeNULyYzQDglT5IMnSIzbHazeICjBiO6sTVPdTARkVu
         9X2z2INwyaJmjWFlP6VyQXAO5AaWS6h0FN5XP+4ZZdUbQ+AKcJIa06LshLnucg7BjMRs
         cQSiPRD+o30EDbCiwos6lzHUAV4jY9AHdE1OzJE+FX+pMvLYzzppdxpD+AXu2b4yjP76
         N8vAfcP4PUqiRY4ostn2Jn3H6ngv5vIPukCtANh1PJHEZbTnexq/OgCgbxVMoMxIFWyX
         hD9OZ38IyuhWwd2ZBrq4utbMJGngUg7Kt87GZkDrXTHlD6mlzOQ25P78ISEDuLE5xuKW
         M8pw==
X-Gm-Message-State: AOUpUlHjSHbBRLY4f87gXZyxV/9nHgME3hBV89iwyzuM/N/w6drg5aGN
        tIpaRoEPHWTYgeBBkiAhz3WA8w==
X-Google-Smtp-Source: AA+uWPyYC38xSbgrI/BWYNbcZf5x6h1BkHvMRygd82uu2jTSSD9m1mCIMRkSkJ+T7mctrD74+gOvbg==
X-Received: by 2002:a1c:aa0c:: with SMTP id t12-v6mr9962906wme.109.1534243287944;
        Tue, 14 Aug 2018 03:41:27 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id w204-v6sm16947225wmw.5.2018.08.14.03.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 03:41:27 -0700 (PDT)
Message-ID: <fd6b76f0c6f5b4dfd1527440b0f6275417e434c1.camel@baylibre.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Date:   Tue, 14 Aug 2018 12:41:26 +0200
In-Reply-To: <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
References: <1534227522-186798-1-git-send-email-hanjie.lin@amlogic.com>
         <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 02:18 -0400, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> controller.
> 
> Signed-off-by: Yue Wang <hanjie.lin@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> new file mode 100644
> index 0000000..48233e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -0,0 +1,57 @@
> +Amlogic Meson AXG DWC PCIE SoC controller
> +
> +Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
> +It shares common functions with the PCIe DesignWare core driver and
> +inherits common properties defined in
> +Documentation/devicetree/bindings/pci/designware-pci.txt.
> +
> +Additional properties are described here:
> +
> +Required properties:
> +- compatible:
> +	should contain "amlogic,axg-pcie" to identify the core.
> +- reg:
> +	Should contain the configuration address space.
> +- reg-names: Must be
> +	- "elbi"	External local bus interface registers
> +	- "cfg"		Meson specific registers
> +	- "config"	PCIe configuration space
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Must include the following entries:
> +	- "pcie"
> +	- "pcie_bus"
> +	- "pcie_general"
> +	- "pcie_mipi_en"

Could you briefly describe what each clock is needed for ?

> +
> +Example configuration:
> +
> +	pcie: pcie@dffff000 {
> +			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +			reg = <0x0 0xf9800000 0x0 0x400000
> +					0x0 0xff646000 0x0 0x2000
> +					0x0 0xf9f00000 0x0 0x100000>;
> +			reg-names = "elbi", "cfg", "config";
> +			reset-gpio = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
> +			interrupts = <0 177 IRQ_TYPE_EDGE_RISING>;

replace 0 with GIC_SPI please

> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +			bus-range = <0x0 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			phys = <&pcie_phy>;
> +			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
> +			num-lanes = <1>;
> +			pcie-num = <1>;
> +
> +			clocks = <&clkc CLKID_USB
> +					&clkc CLKID_MIPI_ENABLE
> +					&clkc CLKID_PCIE_A
> +					&clkc CLKID_PCIE_CML_EN0>;
> +			clock-names = "pcie_general",
> +					"pcie_refpll",
> +					"pcie_mipi_en",
> +					"pcie",
> +					"port";

Several things are disturbing above:
* pcie_general is provided by the USB clock gate ???
* pcie_refpll: I suppose this is a copy/paste error, not used in your driver
(and shouldn't be need BTW)

suggested names:
* pcie_general -> general
* pcie_mipi_en -> mipi
* pcie -> pclk
* port (OK)

> +	};


