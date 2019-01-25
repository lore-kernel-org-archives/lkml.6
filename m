Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B353CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85889218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9hDWa+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfAYLaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:30:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44421 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYLaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:30:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so9880101wrt.11;
        Fri, 25 Jan 2019 03:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q06YcEO7r7oiNXtCNtDcZmxkFfAsBt1uDq63g/LTR2k=;
        b=u9hDWa+A9ZSeDhwxO2PJYVUeabsCCIk5+sY7lohHO0Aw5SOas+5g0LZAlWcKmL0wTS
         0z5Do/JuAE+N+Nxnr6ODfZn0rpKGxxPfdNmbs5h+OsAUnAZBdKNlGQ6yY/k9u7AvcDkl
         tAhYHbYC5TK8IWpWUD2VpKszbE6nAv/oxJWaa9iLIwsV7a9uadlLAmXaUXOUdcGz8jXQ
         Hnlo/n8bZoaApFvfXH5CV9a6Bp8Pjp0S5sHWmCfXeRz/HVXTrCS9mTFu5H2drqer/PFl
         cqf7WM6i7jHDNtcKm/KdYxDPAEYLhkYqem5P10gNXjAZ3Ia5QctXERbxnxiGovI2xILl
         b9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q06YcEO7r7oiNXtCNtDcZmxkFfAsBt1uDq63g/LTR2k=;
        b=Eu/k7grOMfrLmqWg9HJLbl+i2647nwD9DP7E9vgi2QD0WLVDSRaGbQl73oCMZ9jeNd
         XHL0Kse4UAKwIcGtz8w9l7uIRjXNI/uGb4BZEW/NJtj/sAg29qQPlwR9kYIHcNtTQ9gl
         x01Fvfq2AdSF3mbnhrtZe97zM5NMWQhdOYnEHC9S6N4zEZIpgnp+YeyCDovxOOITBMHJ
         A1A1+DEg6ku4zLvh7SY2I8XtF7tHDyu44h3lOIn6HiiRUUU1HcgXdBMPHWc+26ObyPw2
         dkRIMwbfLLsP5sglZRjmP5mHuGQy+OY0PGn4VsKTUR382fem+uL83tw3EVwffPBczlsS
         5ZjQ==
X-Gm-Message-State: AJcUuke8q0LIc8/rQAo8LGr90rVonQcFetpp2FIj0aWm6Ru7Tpay67ZA
        72j/GdHDA7XXmdaMCr3g/RWzhwcYJGs=
X-Google-Smtp-Source: ALg8bN7VKasZeS/QWhcrDQihl6Hci1HQF2F2uJbnE21PVShB0UmtdHIryhVr35QCI+QBwBjdossPqQ==
X-Received: by 2002:adf:a357:: with SMTP id d23mr11621314wrb.195.1548415817320;
        Fri, 25 Jan 2019 03:30:17 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a12sm114926161wro.18.2019.01.25.03.30.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 03:30:16 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] usb: host: xhci-tegra: Selectively program IPFS
Date:   Fri, 25 Jan 2019 12:30:09 +0100
Message-Id: <20190125113013.11447-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190125113013.11447-1-thierry.reding@gmail.com>
References: <20190125113013.11447-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JC Kuo <jckuo@nvidia.com>

Starting with Tegra186, the XUSB controller no longer has the IPFS
wrapper. This commit adds a "has_ipfs" field to struct tegra_xusb_soc
that can be used to declare the existence of the IPFS wrapper.

For the existing chips (i.e. Tegra124 and Tegra210), the new field is
set to true. A future patch adding support for Tegra186 will set it to
false.

Signed-off-by: JC Kuo <jckuo@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/usb/host/xhci-tegra.c | 43 +++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 938ff06c0349..49e033f953a2 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -161,6 +161,7 @@ struct tegra_xusb_soc {
 	} ports;
 
 	bool scale_ss_clock;
+	bool has_ipfs;
 };
 
 struct tegra_xusb {
@@ -637,16 +638,18 @@ static irqreturn_t tegra_xusb_mbox_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void tegra_xusb_ipfs_config(struct tegra_xusb *tegra,
-				   struct resource *regs)
+static void tegra_xusb_config(struct tegra_xusb *tegra,
+			      struct resource *regs)
 {
 	u32 value;
 
-	value = ipfs_readl(tegra, IPFS_XUSB_HOST_CONFIGURATION_0);
-	value |= IPFS_EN_FPCI;
-	ipfs_writel(tegra, value, IPFS_XUSB_HOST_CONFIGURATION_0);
+	if (tegra->soc->has_ipfs) {
+		value = ipfs_readl(tegra, IPFS_XUSB_HOST_CONFIGURATION_0);
+		value |= IPFS_EN_FPCI;
+		ipfs_writel(tegra, value, IPFS_XUSB_HOST_CONFIGURATION_0);
 
-	usleep_range(10, 20);
+		usleep_range(10, 20);
+	}
 
 	/* Program BAR0 space */
 	value = fpci_readl(tegra, XUSB_CFG_4);
@@ -661,13 +664,15 @@ static void tegra_xusb_ipfs_config(struct tegra_xusb *tegra,
 	value |= XUSB_IO_SPACE_EN | XUSB_MEM_SPACE_EN | XUSB_BUS_MASTER_EN;
 	fpci_writel(tegra, value, XUSB_CFG_1);
 
-	/* Enable interrupt assertion */
-	value = ipfs_readl(tegra, IPFS_XUSB_HOST_INTR_MASK_0);
-	value |= IPFS_IP_INT_MASK;
-	ipfs_writel(tegra, value, IPFS_XUSB_HOST_INTR_MASK_0);
+	if (tegra->soc->has_ipfs) {
+		/* Enable interrupt assertion */
+		value = ipfs_readl(tegra, IPFS_XUSB_HOST_INTR_MASK_0);
+		value |= IPFS_IP_INT_MASK;
+		ipfs_writel(tegra, value, IPFS_XUSB_HOST_INTR_MASK_0);
 
-	/* Set hysteresis */
-	ipfs_writel(tegra, 0x80, IPFS_XUSB_HOST_CLKGATE_HYSTERESIS_0);
+		/* Set hysteresis */
+		ipfs_writel(tegra, 0x80, IPFS_XUSB_HOST_CLKGATE_HYSTERESIS_0);
+	}
 }
 
 static int tegra_xusb_clk_enable(struct tegra_xusb *tegra)
@@ -1015,10 +1020,12 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 	if (IS_ERR(tegra->fpci_base))
 		return PTR_ERR(tegra->fpci_base);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	tegra->ipfs_base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(tegra->ipfs_base))
-		return PTR_ERR(tegra->ipfs_base);
+	if (tegra->soc->has_ipfs) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		tegra->ipfs_base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(tegra->ipfs_base))
+			return PTR_ERR(tegra->ipfs_base);
+	}
 
 	tegra->xhci_irq = platform_get_irq(pdev, 0);
 	if (tegra->xhci_irq < 0)
@@ -1208,7 +1215,7 @@ static int tegra_xusb_probe(struct platform_device *pdev)
 		goto disable_rpm;
 	}
 
-	tegra_xusb_ipfs_config(tegra, regs);
+	tegra_xusb_config(tegra, regs);
 
 	err = tegra_xusb_load_firmware(tegra);
 	if (err < 0) {
@@ -1380,6 +1387,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 		.usb3 = { .offset = 0, .count = 2, },
 	},
 	.scale_ss_clock = true,
+	.has_ipfs = true,
 };
 MODULE_FIRMWARE("nvidia/tegra124/xusb.bin");
 
@@ -1411,6 +1419,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 		.usb3 = { .offset = 0, .count = 4, },
 	},
 	.scale_ss_clock = false,
+	.has_ipfs = true,
 };
 MODULE_FIRMWARE("nvidia/tegra210/xusb.bin");
 
-- 
2.19.1

