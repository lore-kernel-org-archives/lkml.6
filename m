Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D6EC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35B620837
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35B620837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbeHOBnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:43:04 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34055 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbeHOBnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:43:04 -0400
Received: by mail-io0-f193.google.com with SMTP id l7-v6so20021420ioj.1;
        Tue, 14 Aug 2018 15:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w4lAbeM7xQausb9TtgNu+NV9s7SWh2vgfR6/SVCCK2Y=;
        b=GyxWyF62KnyNPO5iwBwmH2RVU+4ZtTPEU28sKMndqcSdr+Q+gJPqjgDt9m+Z1cwLqt
         qQhY+sMjqYMYpOXQ0vpH5vgF8CYLiQJxuDkaZ1PL3op35M6ss4x66HAS8zp+t8jDftrx
         GtPHpNSk0D5PEO2R7ihK1dgaZ5ks7xPgOpSyiGh8nwAYV34mK0JUpnheCKxslxg5NoGs
         q38bG1cihKSu/HNasQduYIkvnpdy5hd77FQgptwQUiZkJR2YM2eXuOr6ecS48nyJVDD4
         2ezRoDbaa0hLpB4bN8NX/KFSsVUuAdIAJM4PIA8hx0HTqxs4Sa+C/Njyxg/pW/CtBd+L
         Ip0A==
X-Gm-Message-State: AOUpUlESNNS2mNu2dBsA5JQq9mbu+3cMQYL87Db8tk7iIv9AC6bIkKw2
        Bv48F/+IchD3T+wKSLZ/8Q==
X-Google-Smtp-Source: AA+uWPyegso8iGgb/qeqIcdE33BIcCk2zM2GzL4jSzl5gl0XywTGjoVV2mjr8moflgQDXN6GKO/3Gw==
X-Received: by 2002:a6b:3347:: with SMTP id z68-v6mr19515867ioz.231.1534287221829;
        Tue, 14 Aug 2018 15:53:41 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id z195-v6sm18999180ioe.38.2018.08.14.15.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 15:53:41 -0700 (PDT)
Date:   Tue, 14 Aug 2018 16:53:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe controller
Message-ID: <20180814225340.GA25470@rob-hp-laptop>
References: <1534227522-186798-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534227522-186798-2-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 02:18:41AM -0400, Hanjie Lin wrote:
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
> +
> +Example configuration:
> +
> +	pcie: pcie@dffff000 {

Unit-address is wrong.

> +			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
> +			reg = <0x0 0xf9800000 0x0 0x400000
> +					0x0 0xff646000 0x0 0x2000
> +					0x0 0xf9f00000 0x0 0x100000>;
> +			reg-names = "elbi", "cfg", "config";
> +			reset-gpio = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;

Not documented and should be reset-gpios.

> +			interrupts = <0 177 IRQ_TYPE_EDGE_RISING>;
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

Not documented. What's this?

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
> +	};
> -- 
> 2.7.4
> 
