Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E528DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985BD20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/zVEqJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 985BD20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbeKRE3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 23:29:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35557 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbeKRE3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 23:29:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id v1-v6so5517700plo.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Ja3cqe9P7lywBDvi9A6bj647BvEa60WNLcrBD8nI2k=;
        b=r/zVEqJI3RLrJw3XW/L6GkNOWnNfjzb/DAaZiJi6kwb2F+uykJWR4fXn4Oo6aXGmnC
         pRW4GOOT6cgMpsxUjRWtgJHOdkNSBZnaE115JZkZ0TALQ3B+qQbRZ5DYBR6ZFFcN2Tmw
         lN9+vKzuuRWJjY9cohytVJ1TaDWS56LpJaboWhvWGqfM85o1MJLkUntuUVsGyv/oXkNu
         ebp2R8mvSsicnv/OcGvo+ye3VcoKXFzqDk+zWcRSwwW/xaIRl2Qh9BVFIvnczUzl//z2
         ym2UNVleOtDOiqJ/QML0no/I3B8g0gQ3dn57MfLC3IpTyeZo3ExzCRnRvAqa7WXBPe0g
         g6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Ja3cqe9P7lywBDvi9A6bj647BvEa60WNLcrBD8nI2k=;
        b=qtDVXijpIvu4fYfysF0qfBkTmMmzmPdutqhVyMKb6St0wxH019CfvB1GyYJIVtripo
         1C77hVHdPLsZ7RDmkGhwe5u72qK3Z6Jr2ICKJu7Qo7q0ilsiCBzfz8iOlKWR+FXbdBTp
         Eyz/DXi7OKgGVE45STjFSudrwdQv5rLcWnO49b4zV0jWZpG7+dkw2GAs/+b1SlEsukH2
         /edfoV+KBqytFJNydx2PZUGOCa4fOAdFcXK8+5zimEz81VjRb2ywGiobcXp3r8gyYbdZ
         xkNjWYo4BChpSklMSLLqFwbeAY7uCCuPXfhxmIMRz/JmpSMgu5rBgQBqbt1NjfeNNk4A
         X3/Q==
X-Gm-Message-State: AGRZ1gIJGQiAXD/xT0tm3ObfqltQns4rzdPOJvexiU1jArAgI8OGFKzw
        AeWA8OWgg9SCorOjmRra0Bm5tu71rkM=
X-Google-Smtp-Source: AJdET5duCnEh3XHUdMYi8Unhc6DP9epV/rU4EBLIK2UmJVWUPDSkCLxpsQpuYCWvnUerSsiPcv24tg==
X-Received: by 2002:a17:902:aa84:: with SMTP id d4-v6mr16096731plr.25.1542478338236;
        Sat, 17 Nov 2018 10:12:18 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id g190sm34634026pgc.28.2018.11.17.10.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 10:12:17 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] soc: imx: gpcv2: Add support for i.MX8MQ
Date:   Sat, 17 Nov 2018 10:12:06 -0800
Message-Id: <20181117181206.10267-4-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181117181206.10267-1-andrew.smirnov@gmail.com>
References: <20181117181206.10267-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPCv2 IP block found on i.MX7D can also be found on i.MX8MQ. Add the
code needed to support the latter as well as the former.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: cphealy@gmail.com
Cc: l.stach@pengutronix.de
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/soc/imx/Kconfig |   4 +-
 drivers/soc/imx/gpcv2.c | 195 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 197 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a5b86a28f343..8d0072e7c359 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -2,9 +2,9 @@ menu "i.MX SoC drivers"
 
 config IMX7_PM_DOMAINS
 	bool "i.MX7 PM domains"
-	depends on SOC_IMX7D || (COMPILE_TEST && OF)
+	depends on SOC_IMX8MQ || SOC_IMX7D || (COMPILE_TEST && OF)
 	depends on PM
 	select PM_GENERIC_DOMAINS
-	default y if SOC_IMX7D
+	default y if SOC_IMX7D || SOC_IMX8MQ
 
 endmenu
diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 184ffd4cc9aa..b464f2caa76d 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -15,9 +15,28 @@
 #include <linux/regulator/consumer.h>
 #include <dt-bindings/power/imx7-power.h>
 
+#define IMX8M_POWER_DOMAIN_MIPI_DSI_PHY		0
+#define IMX8M_POWER_DOMAIN_PCIE1_PHY		1
+#define IMX8M_POWER_DOMAIN_USB_OTG1		2
+#define IMX8M_POWER_DOMAIN_USB_OTG2		3
+#define IMX8M_POWER_DOMAIN_GPU			4
+#define IMX8M_POWER_DOMAIN_VPU			5
+#define IMX8M_POWER_DOMAIN_HDMI			6
+#define IMX8M_POWER_DOMAIN_DISP			7
+#define IMX8M_POWER_DOMAIN_MIPI_CSI1_PHY	8
+#define IMX8M_POWER_DOMAIN_MIPI_CSI2_PHY	9
+#define IMX8M_POWER_DOMAIN_PCIE2_PHY		10
+
 #define GPC_LPCR_A_CORE_BSC			0x000
 
 #define GPC_PGC_CPU_MAPPING		0x0ec
+#define PCIE2_A_CORE_DOMAIN		BIT(15)
+#define MIPI_CSI2_A_CORE_DOMAIN		BIT(14)
+#define MIPI_CSI1_A_CORE_DOMAIN		BIT(13)
+#define DISP_A_CORE_DOMAIN		BIT(12)
+#define HDMI_A_CORE_DOMAIN		BIT(11)
+#define VPU_A_CORE_DOMAIN		BIT(10)
+#define GPU_A_CORE_DOMAIN		BIT(9)
 #define USB_HSIC_PHY_A_CORE_DOMAIN		BIT(6)
 #define USB_OTG2_PHY_A_CORE_DOMAIN		BIT(5)
 #define USB_OTG1_PHY_A_CORE_DOMAIN		BIT(4)
@@ -26,6 +45,13 @@
 
 #define GPC_PU_PGC_SW_PUP_REQ		0x0f8
 #define GPC_PU_PGC_SW_PDN_REQ		0x104
+#define PCIE2_SW_Pxx_REQ		BIT(13)
+#define MIPI_CSI2_SW_Pxx_REQ		BIT(12)
+#define MIPI_CSI1_SW_Pxx_REQ		BIT(11)
+#define DISP_SW_Pxx_REQ			BIT(10)
+#define HDMI_SW_Pxx_REQ			BIT(9)
+#define VPU_SW_Pxx_REQ			BIT(8)
+#define GPU_SW_Pxx_REQ			BIT(7)
 #define USB_HSIC_PHY_SW_Pxx_REQ		BIT(4)
 #define USB_OTG2_PHY_SW_Pxx_REQ		BIT(3)
 #define USB_OTG1_PHY_SW_Pxx_REQ		BIT(2)
@@ -42,7 +68,16 @@
  */
 #define PGC_MIPI			16
 #define PGC_PCIE			17
+#define PGC_USB_OTG1			18
+#define PGC_USB_OTG2			19
 #define PGC_USB_HSIC			20
+#define PGC_GPU				23
+#define PGC_VPU				24
+#define PGC_HDMI			25
+#define PGC_DISP			26
+#define PGC_MIPI_CSI1			27
+#define PGC_MIPI_CSI2			28
+#define PGC_PCIE2			29
 #define GPC_PGC_CTRL(n)			(0x800 + (n) * 0x40)
 #define GPC_PGC_SR(n)			(GPC_PGC_CTRL(n) + 0xc)
 
@@ -219,6 +254,165 @@ static const struct imx_pgc_domain_data imx7_pgc_domain_data = {
 	},
 };
 
+static const struct imx_pgc_domain imx8m_pgc_domains[] = {
+	[IMX8M_POWER_DOMAIN_MIPI_DSI_PHY] = {
+		.genpd = {
+			.name      = "mipi-phy",
+		},
+		.bits  = {
+			.pxx = MIPI_PHY_SW_Pxx_REQ,
+			.map = MIPI_PHY_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_MIPI,
+	},
+
+	[IMX8M_POWER_DOMAIN_PCIE1_PHY] = {
+		.genpd = {
+			.name      = "pcie1-phy",
+		},
+		.bits  = {
+			.pxx = PCIE_PHY_SW_Pxx_REQ,
+			.map = PCIE_PHY_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_PCIE,
+	},
+
+	[IMX8M_POWER_DOMAIN_USB_OTG1] = {
+		.genpd = {
+			.name      = "usb-otg1",
+		},
+		.bits  = {
+			.pxx = USB_OTG1_PHY_SW_Pxx_REQ,
+			.map = USB_OTG1_PHY_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_USB_OTG1,
+	},
+
+	[IMX8M_POWER_DOMAIN_USB_OTG2] = {
+		.genpd = {
+			.name      = "usb-otg2",
+		},
+		.bits  = {
+			.pxx = USB_OTG2_PHY_SW_Pxx_REQ,
+			.map = USB_OTG2_PHY_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_USB_OTG2,
+	},
+
+	[IMX8M_POWER_DOMAIN_GPU] = {
+		.genpd = {
+			.name      = "gpu",
+		},
+		.bits  = {
+			.pxx = GPU_SW_Pxx_REQ,
+			.map = GPU_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_GPU,
+	},
+
+	[IMX8M_POWER_DOMAIN_VPU] = {
+		.genpd = {
+			.name      = "vpu",
+		},
+		.bits  = {
+			.pxx = VPU_SW_Pxx_REQ,
+			.map = VPU_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_VPU,
+	},
+
+	[IMX8M_POWER_DOMAIN_HDMI] = {
+		.genpd = {
+			.name      = "hdmi",
+		},
+		.bits  = {
+			.pxx = HDMI_SW_Pxx_REQ,
+			.map = HDMI_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_HDMI,
+	},
+
+	[IMX8M_POWER_DOMAIN_DISP] = {
+		.genpd = {
+			.name      = "disp",
+		},
+		.bits  = {
+			.pxx = DISP_SW_Pxx_REQ,
+			.map = DISP_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_DISP,
+	},
+
+	[IMX8M_POWER_DOMAIN_MIPI_CSI1_PHY] = {
+		.genpd = {
+			.name      = "mipi-csi1-phy",
+		},
+		.bits  = {
+			.pxx = MIPI_CSI1_SW_Pxx_REQ,
+			.map = MIPI_CSI1_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_MIPI_CSI1,
+	},
+
+	[IMX8M_POWER_DOMAIN_MIPI_CSI2_PHY] = {
+		.genpd = {
+			.name      = "mipi-csi2-phy",
+		},
+		.bits  = {
+			.pxx = MIPI_CSI2_SW_Pxx_REQ,
+			.map = MIPI_CSI2_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_MIPI_CSI2,
+	},
+
+	[IMX8M_POWER_DOMAIN_PCIE2_PHY] = {
+		.genpd = {
+			.name      = "pcie2-phy",
+		},
+		.bits  = {
+			.pxx = PCIE2_SW_Pxx_REQ,
+			.map = PCIE2_A_CORE_DOMAIN,
+		},
+		.pgc	   = PGC_PCIE2,
+	},
+};
+
+static const struct regmap_range imx8m_pgc_yes_ranges[] = {
+	regmap_reg_range(GPC_LPCR_A_CORE_BSC,
+			 GPC_M4_PU_PDN_FLG),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI),
+			 GPC_PGC_SR(PGC_MIPI)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_PCIE),
+			 GPC_PGC_SR(PGC_PCIE)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_USB_OTG1),
+			 GPC_PGC_SR(PGC_USB_OTG1)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_USB_OTG2),
+			 GPC_PGC_SR(PGC_USB_OTG2)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_GPU),
+			 GPC_PGC_SR(PGC_GPU)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_VPU),
+			 GPC_PGC_SR(PGC_VPU)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_HDMI),
+			 GPC_PGC_SR(PGC_HDMI)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_DISP),
+			 GPC_PGC_SR(PGC_DISP)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI_CSI1),
+			 GPC_PGC_SR(PGC_MIPI_CSI1)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_MIPI_CSI2),
+			 GPC_PGC_SR(PGC_MIPI_CSI2)),
+	regmap_reg_range(GPC_PGC_CTRL(PGC_PCIE2),
+			 GPC_PGC_SR(PGC_PCIE2)),
+};
+
+static const struct imx_pgc_domain_data imx8m_pgc_domain_data = {
+	.domains = imx8m_pgc_domains,
+	.domains_num = ARRAY_SIZE(imx8m_pgc_domains),
+	.access_table = {
+		.yes_ranges	= imx8m_pgc_yes_ranges,
+		.n_yes_ranges	= ARRAY_SIZE(imx8m_pgc_yes_ranges),
+	},
+};
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
@@ -373,6 +567,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx_gpcv2_dt_ids[] = {
 	{ .compatible = "fsl,imx7d-gpc", .data = &imx7_pgc_domain_data, },
+	{ .compatible = "fsl,imx8m-gpc", .data = &imx8m_pgc_domain_data, },
 	{ }
 };
 
-- 
2.19.1

