Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9FC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBC1216FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 22:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBC1216FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbeHOBjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 21:39:37 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42161 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbeHOBjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 21:39:36 -0400
Received: by mail-io0-f193.google.com with SMTP id n18-v6so19945263ioa.9;
        Tue, 14 Aug 2018 15:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m3bpnkmjaKXsxRO/eHbXgejx0ldGkK96dJbJO3+PG18=;
        b=CAVSiVhy7ZcP5w+tVG5NfAsueEg5hnorrKeNRjRDiAAS8POhplb6TEuSRhNXS7gZuM
         tvrZgK4hXyu0dzknXyb09IafC5d33xqyl+3DQQqauyJq1++gGIB1T7MVf6KdAZ4gDQyE
         AFvmqk1a6kSRCFum6eVYvjFPeNGbMTO13OKWdw94zW4ixo+BWZkcOcP+x/5J5fZ7Okkd
         vLlG/BlR9aRTqAgJF/DAgOFxlOScUh8IaIXdDVMJ5m7SEJvgioYTYft3U+3a1geq6IIN
         1ZNHX9uxmHzGb4ly+Y+RmtkVgzyWxte7n+YvKZoWJZV0Nzh62gP2vzf7skXug5+jabty
         B0ag==
X-Gm-Message-State: AOUpUlFic8ZRn0ed1oj6Er0nlRrFu5r/5/Cb9y4Z2d4WiMYEV9eQovME
        b8wv/rtW6msQFBO80p3Few==
X-Google-Smtp-Source: AA+uWPwgxjfPirwtyoS0WDdv6gSTQYeTnQtduJEyJymbbOeWFWkZxfv70J0k8ARv6qKuiR6CTslnHQ==
X-Received: by 2002:a5e:9b14:: with SMTP id j20-v6mr21310141iok.193.1534287014473;
        Tue, 14 Aug 2018 15:50:14 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w76-v6sm190314itc.0.2018.08.14.15.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 15:50:13 -0700 (PDT)
Date:   Tue, 14 Aug 2018 16:50:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanjie Lin <hanjie.lin@amlogic.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, shawn.lin@rock-chips.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: PCI: meson: add DT bindings for Amlogic
 Meson PCIe Phy controller
Message-ID: <20180814225012.GA19305@rob-hp-laptop>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
 <1534227134-151584-2-git-send-email-hanjie.lin@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534227134-151584-2-git-send-email-hanjie.lin@amlogic.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 02:12:13AM -0400, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>

Subject should be "dt-bindings: phy: ..."

> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
> of the PCI Express Gen 2 specification and is backwardcompatible

space                                                   ^

> with the 2.5-Gbps Gen 1.1 specification with only
> inferred idle detection supported on AMLOGIC SoCs.

AMLOGIC or Amlogic? 

> 
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> ---
>  .../bindings/phy/amlogic,meson-pcie-phy.txt        | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
> new file mode 100644
> index 0000000..db99085
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-pcie-phy.txt
> @@ -0,0 +1,31 @@
> +* Amlogic Meson AXG PCIE PHY binding
> +
> +Required properties:
> +- compatible:	Should be
> +	- "amlogic,axg-pcie-phy"
> +- #phys-cells:	must be 0 (see phy-bindings.txt in this directory)

You don't need to distinguish port A and B?

> +- reg:		The base address and length of the registers
> +- resets:	phandle to the reset lines
> +- reset-names:	must contain "phy" and "peripheral"
> +	- "port_a" Port A reset
> +	- "port_b" Port B reset
> +	- "phy"	PHY reset
> +	- "apb"	APB reset
> +Optional properties:
> +- phy-supply:	see phy-bindings.txt in this directory
> +
> +Example:
> +	pcie_phy: pcie-phy@ff644000 {
> +		#phy-cells = <0>;
> +		compatible = "amlogic,axg-pcie-phy";
> +		reg = <0x0 0xff644000 0x0 0x2000>;
> +		resets = <&reset RESET_PCIE_A>,
> +				<&reset RESET_PCIE_B>,
> +				<&reset RESET_PCIE_PHY>,
> +				<&reset RESET_PCIE_APB>;
> +		reset-names =
> +				"port_a",
> +				"port_b",
> +				"phy",
> +				"apb";
> +	};
> -- 
> 2.7.4
> 
