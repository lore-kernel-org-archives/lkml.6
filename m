Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F93C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F65A208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lS80CVE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F65A208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeHXL4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:56:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51569 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeHXL4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:56:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so777774wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rdI3eGrgDRdi+ZECJXI3q/qcnJLKHUsibWfAleizWb4=;
        b=lS80CVE07PWoOdbqjP4M3CHlLEvuumJe3lhWIUl2QnI3HJJrOMDu+zxJVD2avW7P/J
         Rav8N+7Txa4bRIuhxhOdqHvh9QHe51zashB6ndz0YlPG0LvEkV45PT77ZeazXGfXW+Np
         7VGb/9/Ezr2PBwAY4mt9NZtCUHRp1Abs1cw/fzJK7vNm6oFE27OJmlDBVNDxhp7XEzOi
         7b2P2omdP63aVyOiuiLeQgKKMYgGBW/4bE9EEHF9Mhd8cNKk6hX+InS9sWzyopE1W1K4
         UI0QSLP5If+K9vqzS4b0DlvU4cp0R/+pARqnlqhzXkEYlyC5J67r6nKCouaP2Wclqefh
         qSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rdI3eGrgDRdi+ZECJXI3q/qcnJLKHUsibWfAleizWb4=;
        b=BR43Izv6Eea7xA3h5IEHCeWkjx/wgOWM/cgwt1Bj6evREsMqeGFP1Co99yRqOvmM/Z
         CFrlbLZ5XhSPq0McPwi0PVu93CGACVCZcWDwXiEOAsAyIj0H5NRZlod4rXdYtk7OrU4V
         dFeu7SVm4/zQLI9C/d4LUbpjaV8p0C92JvaqwXz2m3h1TFeP+aXL59tYW5F8oLH4ZPrh
         JhV4ZkrwC/werbkkMo9tEExmdHlsdOn7lu78dsN4mt5Zcairfn5zEBeN+WSW1BJ6/PLW
         G23pHQW3uSDXFKf3Cr9n1cZfrgrVsy2lRt1Rn4TS0lRlgla8HJGkWWbGZoHs0SKabjzV
         lVzQ==
X-Gm-Message-State: APzg51Dpg3B9lyXDiZvUJ7jzLZ41UVUl0oa2EH12EB5dyzmz3LoElwwX
        mGX+8Ee9INThB41BlBUoEtRR8Q==
X-Google-Smtp-Source: ANB0VdYElGPb0wd3nTOyJ39kIG6grnhXR9wqwhwSWov1s0/Ah8CS50tLfIHFPIJZ47vNuXv2PMHy+Q==
X-Received: by 2002:a1c:9dc3:: with SMTP id g186-v6mr732486wme.26.1535098977659;
        Fri, 24 Aug 2018 01:22:57 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a37-v6sm16148462wrc.21.2018.08.24.01.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 01:22:57 -0700 (PDT)
Message-ID: <8c48964151d24758298ba935da336c0829e2b287.camel@baylibre.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: meson: add DT bindings for
 Amlogic Meson PCIe controller
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Yixun Lan <yixun.lan@amlogic.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, devicetree@vger.kernel.org
Date:   Fri, 24 Aug 2018 10:22:55 +0200
In-Reply-To: <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
References: <1535096165-45827-1-git-send-email-hanjie.lin@amlogic.com>
         <1535096165-45827-2-git-send-email-hanjie.lin@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-24 at 15:36 +0800, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Amlogic Meson PCIe host controller is based on the Synopsys DesignWare
> PCI core. This patch adds documentation for the DT bindings in Meson PCIe
> controller.
> 
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> ---
>  .../devicetree/bindings/pci/amlogic,meson-pcie.txt | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> new file mode 100644
> index 0000000..8a831d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
> @@ -0,0 +1,63 @@
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
> +- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Must include the following entries:
> +	- "pclk"       PCIe GEN 100M PLL clock
> +	- "port"       PCIe_x(A or B) RC clock gate
> +	- "general"    PCIe Phy clock
> +	- "mipi"       PCIe_x(A or B) 100M ref clock gate
> +- resets: phandle to the reset lines.
> +- reset-names: must contain "phy" and "peripheral"
> +       - "port" Port A or B reset
> +       - "apb" APB reset

The above description is not coherent (phy <=> port)

> +
> +Example configuration:
> +
> +	pcie: pcie@f9800000 {
> +			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +			reg = <0x0 0xf9800000 0x0 0x400000
> +					0x0 0xff646000 0x0 0x2000
> +					0x0 0xf9f00000 0x0 0x100000>;
> +			reg-names = "elbi", "cfg", "config";
> +			reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
> +			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0>;
> +			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
> +			bus-range = <0x0 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";

Not described above - is it even used ?

> +			phys = <&pcie_phy>;

Not documented and not necessary. Please remove this.

> +			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
> +
> +			clocks = <&clkc CLKID_USB
> +					&clkc CLKID_MIPI_ENABLE
> +					&clkc CLKID_PCIE_A
> +					&clkc CLKID_PCIE_CML_EN0>;
> +			clock-names = "general",
> +					"mipi",
> +					"pclk",
> +					"port";
> +			resets = <&reset RESET_PCIE_A>,
> +				<&reset RESET_PCIE_APB>;
> +			reset-names = "port",
> +					"apb";
> +	};


