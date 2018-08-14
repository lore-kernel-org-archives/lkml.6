Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AEFC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27C4216E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aUPdzKNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27C4216E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeHNN2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:28:20 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50929 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732078AbeHNN2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:28:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id s12-v6so11795753wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMKxYfunPUelvdHamU38RWEs21USN4/iNc1dndZKgns=;
        b=aUPdzKNxcvgTYNMWk1GPZLU2Me7D9F2SfSpQAdVQI+hkI9uTKW4Tz9kalS7PqADjJ/
         PE8/qiE6XIBqhcKtm+F10z0+usBivyWKSBCNiGSIatbwddbSHwK8RXNz5O/sixr5ZUz+
         t0e4zBdJaORYRzGRh2A6DsaWNVf/t+0DhbLdEk9H3PgaVZD9TG9/Nux+gYux1/foUkcw
         2XnK+6gr8e8+b9qcLg596YradtmsS0JAT0gC2CcDRJYqMXqmcRBerQmYsTmhuM6YQ55z
         vDwj3Vmfdqiyd+c7YUckiw9UCKQqjDGm5Ku4JONwhsWBu7PumsG9SYu/wI6BJSYbeRhU
         1/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMKxYfunPUelvdHamU38RWEs21USN4/iNc1dndZKgns=;
        b=t49AuD6UVOjsyYDR9fdlTX8lKeKGGwRcO0XETS33Fhb1ciAEDhDiVv1iom0rvINYX3
         DDBasj1RoJkLvz+oCp1cnsuAwfURS8fNzRMVjz9iESsZwod+BNQIfNXlk5s2e1sxhhP5
         fQ4utgXA40xB0QBiu1oBjAX0IdPt1Ls+lZb4TZr6mBEghN418/2nPdD4k/2IACqGgZMT
         6Hgrhzm3N5D0MzXkKAVxozK0QC++Behh5FkXPtaNOg+3cTeQBSEasn4R4x1VRbGp5HtV
         V+bBGRE2f+9gz5fsvCad9bB/VyP739WtwSrNkWf2ATzMu0Fmvs9g6WaatVaZxWtIMOcT
         p5pg==
X-Gm-Message-State: AOUpUlEz0q8DVSz04KTqPzZJcPMRr+khNJt2GPn+D5T6nLPDzMzVs5rw
        11d9X36Rg2Nuz3L+PXRntpOY7Q==
X-Google-Smtp-Source: AA+uWPwnuKU/4gK//ojif8c1ylJ7wa0rwjYfzFW+RvTnCm+QZLKVaAbNlKH2PVaosBOeGjvV8iygyA==
X-Received: by 2002:a1c:c019:: with SMTP id q25-v6mr10242734wmf.148.1534243302347;
        Tue, 14 Aug 2018 03:41:42 -0700 (PDT)
Received: from boomer ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y206-v6sm12613951wmg.45.2018.08.14.03.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 03:41:41 -0700 (PDT)
Message-ID: <486e8ab477cc22ff231d2e18d7de22efba2c5abd.camel@baylibre.com>
Subject: Re: [PATCH 2/2] PCI: meson: add the Amlogic Meson PCIe phy driver
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Hanjie Lin <hanjie.lin@amlogic.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Yue Wang <yue.wang@amlogic.com>, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        shawn.lin@rock-chips.com
Date:   Tue, 14 Aug 2018 12:41:40 +0200
In-Reply-To: <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
References: <1534227134-151584-1-git-send-email-hanjie.lin@amlogic.com>
         <1534227134-151584-3-git-send-email-hanjie.lin@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-14 at 02:12 -0400, Hanjie Lin wrote:
> From: Yue Wang <yue.wang@amlogic.com>
> 
> The Meson-PCIE-PHY controller supports the 5-Gbps data rate
> of the PCI Express Gen 2 specification and is backwardcompatible
> with the 2.5-Gbps Gen 1.1 specification with only
> inferred idle detection supported on AMLOGIC SoCs.

It looks like the sole purpose of this driver is to provide the reset lines to
pcie driver.

I wonder why we need this ? Can't the pcie driver claim the reset lines itself.

Also, an init of this phy will always reset both port. What will happen if the
first port is in use and the 2nd port comes up ?? 

Looks the the pcie driver should claim 'apb' and 'phy' reset lines as "shared"
reset and the required 'port' as 'exclusive'

> 
> Signed-off-by: Yue Wang <yue.wang@amlogic.com>
> Signed-off-by: Hanjie Lin <hanjie.lin@amlogic.com>
> ---
>  drivers/phy/amlogic/Kconfig              |   8 ++
>  drivers/phy/amlogic/Makefile             |   1 +
>  drivers/phy/amlogic/phy-meson-axg-pcie.c | 160 +++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>  create mode 100644 drivers/phy/amlogic/phy-meson-axg-pcie.c
> 
> diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
> index 23fe1cd..3ab07f9 100644
> --- a/drivers/phy/amlogic/Kconfig
> +++ b/drivers/phy/amlogic/Kconfig
> @@ -36,3 +36,11 @@ config PHY_MESON_GXL_USB3
>  	  Enable this to support the Meson USB3 PHY and OTG detection
>  	  IP block found in Meson GXL and GXM SoCs.
>  	  If unsure, say N.
> +
> +config PHY_MESON_AXG_PCIE
> +	bool "Meson AXG PCIe PHY driver"
> +	depends on OF && (ARCH_MESON || COMPILE_TEST)
> +	select GENERIC_PHY
> +	help
> +	  Enable PCIe PHY support for Meson AXG SoC series.
> +	  This driver provides PHY interface for Meson PCIe controller.
> \ No newline at end of file
> diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
> index 4fd8848..5ab8578 100644
> --- a/drivers/phy/amlogic/Makefile
> +++ b/drivers/phy/amlogic/Makefile
> @@ -1,3 +1,4 @@
>  obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
>  obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
> +obj-$(CONFIG_PHY_MESON_AXG_PCIE)	+= phy-meson-axg-pcie.o
> diff --git a/drivers/phy/amlogic/phy-meson-axg-pcie.c b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> new file mode 100644
> index 0000000..8bc5c49
> --- /dev/null
> +++ b/drivers/phy/amlogic/phy-meson-axg-pcie.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Amlogic MESON SoC series PCIe PHY driver
> + *
> + * Phy provider for PCIe controller on MESON SoC series
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Yue Wang <yue.wang@amlogic.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> +#include <linux/reset.h>
> +
> +struct meson_pcie_phy_data {
> +	const struct phy_ops	*ops;
> +};
> +
> +struct meson_pcie_reset {
> +	struct reset_control	*port_a;
> +	struct reset_control	*port_b;
> +	struct reset_control	*phy;
> +	struct reset_control	*apb;
> +};
> +
> +struct meson_pcie_phy {
> +	const struct meson_pcie_phy_data	*data;
> +	struct meson_pcie_reset	reset;
> +	void __iomem	*phy_base;
> +};
> +
> +static int meson_pcie_phy_init(struct phy *phy)
> +{
> +	struct meson_pcie_phy *mphy = phy_get_drvdata(phy);
> +	struct meson_pcie_reset *mrst = &mphy->reset;
> +
> +	writel(0x1c, mphy->phy_base);
> +	reset_control_assert(mrst->port_a);
> +	reset_control_assert(mrst->port_b);
> +	reset_control_assert(mrst->phy);
> +	reset_control_assert(mrst->apb);
> +	udelay(400);
> +	reset_control_deassert(mrst->port_a);
> +	reset_control_deassert(mrst->port_b);
> +	reset_control_deassert(mrst->phy);
> +	reset_control_deassert(mrst->apb);
> +	udelay(500);
> +
> +	return 0;
> +}
> +
> +static const struct phy_ops meson_phy_ops = {
> +	.init		= meson_pcie_phy_init,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static const struct meson_pcie_phy_data meson_pcie_phy_data = {
> +	.ops		= &meson_phy_ops,
> +};
> +
> +static const struct of_device_id meson_pcie_phy_match[] = {
> +	{
> +		.compatible = "amlogic,axg-pcie-phy",
> +		.data = &meson_pcie_phy_data,
> +	},
> +	{},
> +};
> +
> +static int meson_pcie_phy_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct meson_pcie_phy *mphy;
> +	struct meson_pcie_reset *mrst;
> +	struct phy *generic_phy;
> +	struct phy_provider *phy_provider;
> +	struct resource *res;
> +	const struct meson_pcie_phy_data *data;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	mphy = devm_kzalloc(dev, sizeof(*mphy), GFP_KERNEL);
> +	if (!mphy)
> +		return -ENOMEM;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mphy->phy_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(mphy->phy_base))
> +		return PTR_ERR(mphy->phy_base);
> +
> +	mrst = &mphy->reset;
> +
> +	mrst->port_a = devm_reset_control_get_shared(dev, "port_a");
> +	if (IS_ERR(mrst->port_a)) {
> +		if (PTR_ERR(mrst->port_a) != -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get port a reset %ld\n",
> +				PTR_ERR(mrst->port_a));
> +
> +		return PTR_ERR(mrst->port_a);
> +	}
> +
> +	mrst->port_b = devm_reset_control_get_shared(dev, "port_b");
> +	if (IS_ERR(mrst->port_b)) {
> +		if (PTR_ERR(mrst->port_b) != -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get port b reset %ld\n",
> +				PTR_ERR(mrst->port_b));
> +
> +		return PTR_ERR(mrst->port_b);
> +	}
> +
> +	mrst->phy = devm_reset_control_get_shared(dev, "phy");
> +	if (IS_ERR(mrst->phy)) {
> +		if (PTR_ERR(mrst->phy) != -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get phy reset\n");
> +
> +		return PTR_ERR(mrst->phy);
> +	}
> +
> +	mrst->apb = devm_reset_control_get_shared(dev, "apb");
> +	if (IS_ERR(mrst->apb)) {
> +		if (PTR_ERR(mrst->apb) != -EPROBE_DEFER)
> +			dev_err(dev, "couldn't get apb reset\n");
> +
> +		return PTR_ERR(mrst->apb);
> +	}
> +
> +	reset_control_deassert(mrst->port_a);
> +	reset_control_deassert(mrst->port_b);
> +	reset_control_deassert(mrst->phy);
> +	reset_control_deassert(mrst->apb);
> +
> +	mphy->data = data;
> +
> +	generic_phy = devm_phy_create(dev, dev->of_node, mphy->data->ops);
> +	if (IS_ERR(generic_phy)) {
> +		if (PTR_ERR(generic_phy) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to create PHY\n");
> +
> +		return PTR_ERR(generic_phy);
> +	}
> +
> +	phy_set_drvdata(generic_phy, mphy);
> +	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +	return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static struct platform_driver meson_pcie_phy_driver = {
> +	.probe	= meson_pcie_phy_probe,
> +	.driver = {
> +		.of_match_table	= meson_pcie_phy_match,
> +		.name		= "meson-pcie-phy",
> +	}
> +};
> +
> +builtin_platform_driver(meson_pcie_phy_driver);


