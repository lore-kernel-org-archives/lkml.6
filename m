Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48351C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D969B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jf0uIOLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D969B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937477AbeFSIUx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:20:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:45009 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937419AbeFSIUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619082004euoutp02795b637bdda67e4ffebf9eed9e866dab~5ge07TYmJ1527215272euoutp02C;
        Tue, 19 Jun 2018 08:20:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619082004euoutp02795b637bdda67e4ffebf9eed9e866dab~5ge07TYmJ1527215272euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396404;
        bh=HCHl/tbrJkKBu+tvKkfbTt7UILumojL13lnXKlnqfg8=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=jf0uIOLLS+GsJmVHzNdqs+R6hpD7MsjKWoOUK4ZyijRb39DhgEwfSsVVb0KjXcRjt
         es+7kZ9ab3Z++ZFkQwr+xlt1jKO0O5SxUvSRfMj3EKJgvC5i5+JwFsA1xfU39gYYtr
         2xGkLsJCLd9Ui0bxWbfc4GOVyOBpU85dmKHG2TU4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619082003eucas1p1d736e159aa748318df6d8bc06cd504b7~5ge0Ih_IS0549505495eucas1p1x;
        Tue, 19 Jun 2018 08:20:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3A.88.10409.3BCB82B5; Tue, 19
        Jun 2018 09:20:03 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619082002eucas1p2e3606dff0191ab5380cc455e33083459~5gezSxA1-1912919129eucas1p2l;
        Tue, 19 Jun 2018 08:20:02 +0000 (GMT)
X-AuditID: cbfec7f5-f95739c0000028a9-e1-5b28bcb335c7
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.E3.04183.2BCB82B5; Tue, 19
        Jun 2018 09:20:02 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:20:02 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 7/9] drm/bridge: tc358764: Add DSI to LVDS bridge driver
Date:   Tue, 19 Jun 2018 10:19:28 +0200
Message-id: <1529396370-18761-8-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
In-reply-to: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe3fO2TmuFodp+KolNpCWpRVZvFBYlNkJIYqiD1rZzIMzncrm
        NcNULG9oNhNXXqtpNixt3lJSYq5WiFtmaJrzgiTOWxdTMUxzbn77P8/z+z8XeChMkEU4U2GR
        MawsUhwh5PLwpvdLRs/6N6LA/V3dFBp4aSBQruEjB6VlzhDolbKWQOW6tdyX+R9cpBjOx9HE
        UDeO7o1NYchorCNRV9o0ibLuq0ikGeslUE9rCRcpje0cVGEewNELnYlElX3dHHSnTUciZYGZ
        i5Zay/Dj25iashrA9OTlcpiWRyaSKc58SDAadRaXaV4YIZjhHD2HqVfdZvIa1ICZ07ie4wXw
        joawEWFxrGyfzzWepLbOBKKrM0CCeWQWTwF50dnAjoK0N2xbXMazAY8S0NUAKiqqSEtBQM8B
        +GAF34AGW+aAFaoC0Py2HbMGqwD++65boyiKS3vAmowgS96BVgNY/3Vm3YHRhQT8VD5FWFrZ
        0/6wc7qZa9E47Q7LW8bXR/BpX5jTMWUb5wr7DVmYRdvRp+Cj0kWOpRGkC0j41Dxjg3zh0JMq
        zKrt4aS+gbTq7bCnIMfGJMHn5me41ZwC4B9Tj81wBHbou9c3wuitUNFUhFlOgDQfZt4VWBEG
        alUq25lKADtNqZx84FQBNqmBIxsrl4ay8oORbLyXXCyVx0aGel2PkmrA2oN0rujnX4P25WAt
        oCkg3MIX1e4KFBDiOHmiVAsghQkd+I2VokABP0SceJOVRQXJYiNYuRa4ULjQkX9VlBwgoEPF
        MWw4y0azso0qh7JzTgEiBdl4eenn56ILv/r7TrqRUYNBZ3Ra7pyClOwxOBuqZlw9i0+fLxwz
        BuOSgFte+hNtFz9kuCS3pd8Yrzh7KWnHhOPfuMxU/97D6eGTjxMWYjerdgpHV4+5SVomFd/c
        02Wl7wjvvU4+QAqC/eJLcvyv/HaqdXAbZP1mnZSju0sOCXG5RHzAA5PJxf8BBi+fxBwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t/xa7qb9mhEGyzbo2hxa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBnrN9xlLFjRzljx8sE7lgbGvoIuRk4OCQETiTs7PzN2MXJxCAksYZR4tLADymlk
        kvg97yx7FyMHB5uAlsSa9niQuIjAKkaJqX/vsIM4zAKzWSVePZrACDJKWMBb4vSb7WwgNouA
        qsT8nc9YQGxeAReJ7sOvWSDWyUncPNfJDGJzCrhKzJr7nQnEFgKqebH6CtMERp4FjAyrGEVS
        S4tz03OLjfSKE3OLS/PS9ZLzczcxAoN/27GfW3Ywdr0LPsQowMGoxMPbsFE9Wog1say4MvcQ
        owQHs5II79alGtFCvCmJlVWpRfnxRaU5qcWHGKU5WJTEec8bVEYJCaQnlqRmp6YWpBbBZJk4
        OKUaGNNb4i9Lt/JdEbrzq7970/u0QqYjLZVn3x5+r6x3boHRDLVdWZtvMF1xsNwSbsVTtp9P
        aneqwo3mR68NlnZoBZdPyJjE9iveN2DzEcEkzhvrDbvFepxXflGaWrh98rWZ6uq2KlsuLDg2
        0fsla5n1/QV1kyY9+nW7fGmBRn1anvjOOWkFCU7dMkosxRmJhlrMRcWJAMvV2Hh6AgAA
X-CMS-MailID: 20180619082002eucas1p2e3606dff0191ab5380cc455e33083459
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619082002eucas1p2e3606dff0191ab5380cc455e33083459
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
        <CGME20180619082002eucas1p2e3606dff0191ab5380cc455e33083459@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrzej Hajda <a.hajda@samsung.com>

Add a drm_bridge driver for the Toshiba TC358764 DSI to LVDS bridge.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/gpu/drm/bridge/Kconfig    |   8 +
 drivers/gpu/drm/bridge/Makefile   |   1 +
 drivers/gpu/drm/bridge/tc358764.c | 521 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 530 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/tc358764.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index fa2c799..f3da8a7 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -110,6 +110,14 @@ config DRM_THINE_THC63LVD1024
 	---help---
 	  Thine THC63LVD1024 LVDS/parallel converter driver.
 
+config DRM_TOSHIBA_TC358764
+	tristate "TC358764 DSI/LVDS bridge"
+	depends on DRM && DRM_PANEL
+	depends on OF
+	select DRM_MIPI_DSI
+	help
+	  Toshiba TC358764 DSI/LVDS bridge driver.
+
 config DRM_TOSHIBA_TC358767
 	tristate "Toshiba TC358767 eDP bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 35f88d4..bf7c0ce 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_DRM_SIL_SII8620) += sil-sii8620.o
 obj-$(CONFIG_DRM_SII902X) += sii902x.o
 obj-$(CONFIG_DRM_SII9234) += sii9234.o
 obj-$(CONFIG_DRM_THINE_THC63LVD1024) += thc63lvd1024.o
+obj-$(CONFIG_DRM_TOSHIBA_TC358764) += tc358764.o
 obj-$(CONFIG_DRM_TOSHIBA_TC358767) += tc358767.o
 obj-$(CONFIG_DRM_ANALOGIX_DP) += analogix/
 obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511/
diff --git a/drivers/gpu/drm/bridge/tc358764.c b/drivers/gpu/drm/bridge/tc358764.c
new file mode 100644
index 0000000..0aee155
--- /dev/null
+++ b/drivers/gpu/drm/bridge/tc358764.c
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Samsung Electronics Co., Ltd
+ *
+ * Authors:
+ *	Andrzej Hajda <a.hajda@samsung.com>
+ *	Maciej Purski <m.purski@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.
+ *
+ */
+
+#include <drm/drm_atomic_helper.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
+
+#include <drm/drm_crtc.h>
+#include <drm/drm_crtc_helper.h>
+
+#include <linux/gpio/consumer.h>
+#include <linux/of_graph.h>
+#include <linux/regulator/consumer.h>
+
+#include <video/mipi_display.h>
+
+#define FLD_MASK(start, end)    (((1 << ((start) - (end) + 1)) - 1) << (end))
+#define FLD_VAL(val, start, end) (((val) << (end)) & FLD_MASK(start, end))
+
+/* PPI layer registers */
+#define PPI_STARTPPI		0x0104 /* START control bit */
+#define PPI_LPTXTIMECNT		0x0114 /* LPTX timing signal */
+#define PPI_LANEENABLE		0x0134 /* Enables each lane */
+#define PPI_TX_RX_TA		0x013C /* BTA timing parameters */
+#define PPI_D0S_CLRSIPOCOUNT	0x0164 /* Assertion timer for Lane 0 */
+#define PPI_D1S_CLRSIPOCOUNT	0x0168 /* Assertion timer for Lane 1 */
+#define PPI_D2S_CLRSIPOCOUNT	0x016C /* Assertion timer for Lane 2 */
+#define PPI_D3S_CLRSIPOCOUNT	0x0170 /* Assertion timer for Lane 3 */
+#define PPI_START_FUNCTION	1
+
+/* DSI layer registers */
+#define DSI_STARTDSI		0x0204 /* START control bit of DSI-TX */
+#define DSI_LANEENABLE		0x0210 /* Enables each lane */
+#define DSI_RX_START		1
+
+/* Video path registers */
+#define VP_CTRL			0x0450 /* Video Path Control */
+#define VP_CTRL_MSF(v)		FLD_VAL(v, 0, 0) /* Magic square in RGB666 */
+#define VP_CTRL_VTGEN(v)	FLD_VAL(v, 4, 4) /* Use chip clock for timing */
+#define VP_CTRL_EVTMODE(v)	FLD_VAL(v, 5, 5) /* Event mode */
+#define VP_CTRL_RGB888(v)	FLD_VAL(v, 8, 8) /* RGB888 mode */
+#define VP_CTRL_VSDELAY(v)	FLD_VAL(v, 31, 20) /* VSYNC delay */
+#define VP_CTRL_HSPOL		BIT(17) /* Polarity of HSYNC signal */
+#define VP_CTRL_DEPOL		BIT(18) /* Polarity of DE signal */
+#define VP_CTRL_VSPOL		BIT(19) /* Polarity of VSYNC signal */
+#define VP_HTIM1		0x0454 /* Horizontal Timing Control 1 */
+#define VP_HTIM1_HBP(v)		FLD_VAL(v, 24, 16)
+#define VP_HTIM1_HSYNC(v)	FLD_VAL(v, 8, 0)
+#define VP_HTIM2		0x0458 /* Horizontal Timing Control 2 */
+#define VP_HTIM2_HFP(v)		FLD_VAL(v, 24, 16)
+#define VP_HTIM2_HACT(v)	FLD_VAL(v, 10, 0)
+#define VP_VTIM1		0x045C /* Vertical Timing Control 1 */
+#define VP_VTIM1_VBP(v)		FLD_VAL(v, 23, 16)
+#define VP_VTIM1_VSYNC(v)	FLD_VAL(v, 7, 0)
+#define VP_VTIM2		0x0460 /* Vertical Timing Control 2 */
+#define VP_VTIM2_VFP(v)		FLD_VAL(v, 23, 16)
+#define VP_VTIM2_VACT(v)	FLD_VAL(v, 10, 0)
+#define VP_VFUEN		0x0464 /* Video Frame Timing Update Enable */
+
+/* LVDS registers */
+#define LV_MX0003		0x0480 /* Mux input bit 0 to 3 */
+#define LV_MX0407		0x0484 /* Mux input bit 4 to 7 */
+#define LV_MX0811		0x0488 /* Mux input bit 8 to 11 */
+#define LV_MX1215		0x048C /* Mux input bit 12 to 15 */
+#define LV_MX1619		0x0490 /* Mux input bit 16 to 19 */
+#define LV_MX2023		0x0494 /* Mux input bit 20 to 23 */
+#define LV_MX2427		0x0498 /* Mux input bit 24 to 27 */
+#define LV_MX(b0, b1, b2, b3)	(FLD_VAL(b0, 4, 0) | FLD_VAL(b1, 12, 8) | \
+				FLD_VAL(b2, 20, 16) | FLD_VAL(b3, 28, 24))
+
+/* Input bit numbers used in mux registers */
+enum {
+	LVI_R0,
+	LVI_R1,
+	LVI_R2,
+	LVI_R3,
+	LVI_R4,
+	LVI_R5,
+	LVI_R6,
+	LVI_R7,
+	LVI_G0,
+	LVI_G1,
+	LVI_G2,
+	LVI_G3,
+	LVI_G4,
+	LVI_G5,
+	LVI_G6,
+	LVI_G7,
+	LVI_B0,
+	LVI_B1,
+	LVI_B2,
+	LVI_B3,
+	LVI_B4,
+	LVI_B5,
+	LVI_B6,
+	LVI_B7,
+	LVI_HS,
+	LVI_VS,
+	LVI_DE,
+	LVI_L0
+};
+
+#define LV_CFG			0x049C /* LVDS Configuration */
+#define LV_PHY0			0x04A0 /* LVDS PHY 0 */
+#define LV_PHY0_RST(v)		FLD_VAL(v, 22, 22) /* PHY reset */
+#define LV_PHY0_IS(v)		FLD_VAL(v, 15, 14)
+#define LV_PHY0_ND(v)		FLD_VAL(v, 4, 0) /* Frequency range select */
+#define LV_PHY0_PRBS_ON(v)	FLD_VAL(v, 20, 16) /* Clock/Data Flag pins */
+
+/* System registers */
+#define SYS_RST			0x0504 /* System Reset */
+#define SYS_ID			0x0580 /* System ID */
+
+#define SYS_RST_I2CS		BIT(0) /* Reset I2C-Slave controller */
+#define SYS_RST_I2CM		BIT(1) /* Reset I2C-Master controller */
+#define SYS_RST_LCD		BIT(2) /* Reset LCD controller */
+#define SYS_RST_BM		BIT(3) /* Reset Bus Management controller */
+#define SYS_RST_DSIRX		BIT(4) /* Reset DSI-RX and App controller */
+#define SYS_RST_REG		BIT(5) /* Reset Register module */
+
+#define LPX_PERIOD		2
+#define TTA_SURE		3
+#define TTA_GET			0x20000
+
+/* Lane enable PPI and DSI register bits */
+#define LANEENABLE_CLEN		BIT(0)
+#define LANEENABLE_L0EN		BIT(1)
+#define LANEENABLE_L1EN		BIT(2)
+#define LANEENABLE_L2EN		BIT(3)
+#define LANEENABLE_L3EN		BIT(4)
+
+/* LVCFG fields */
+#define LV_CFG_LVEN		BIT(0)
+#define LV_CFG_LVDLINK		BIT(1)
+#define LV_CFG_CLKPOL1		BIT(2)
+#define LV_CFG_CLKPOL2		BIT(3)
+
+static const char * const tc358764_supplies[] = {
+	"vddc", "vddio", "vddmipi", "vddlvds133", "vddlvds112"
+};
+
+struct tc358764 {
+	struct device *dev;
+	struct drm_bridge bridge;
+	struct drm_connector connector;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(tc358764_supplies)];
+	struct gpio_desc *gpio_reset;
+
+	struct drm_panel *panel;
+};
+
+static int tc358764_read(struct tc358764 *ctx, u16 addr, u32 *val)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	ssize_t ret;
+
+	cpu_to_le16s(&addr);
+	ret = mipi_dsi_generic_read(dsi, &addr, sizeof(addr), val, sizeof(val));
+	if (ret >= 0)
+		le32_to_cpus(val);
+
+	dev_dbg(ctx->dev, "read: %d, addr: %d\n", addr, *val);
+
+	return ret;
+}
+
+static int tc358764_write(struct tc358764 *ctx, u16 addr, u32 val)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	ssize_t ret;
+	u8 data[6];
+
+	data[0] = addr;
+	data[1] = addr >> 8;
+	data[2] = val;
+	data[3] = val >> 8;
+	data[4] = val >> 16;
+	data[5] = val >> 24;
+
+	ret = mipi_dsi_generic_write(dsi, data, sizeof(data));
+
+	return ret;
+}
+
+static inline struct tc358764 *bridge_to_tc358764(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct tc358764, bridge);
+}
+
+static inline
+struct tc358764 *connector_to_tc358764(struct drm_connector *connector)
+{
+	return container_of(connector, struct tc358764, connector);
+}
+
+static int tc358764_init(struct tc358764 *ctx)
+{
+	u32 v = 0;
+
+	tc358764_read(ctx, SYS_ID, &v);
+	dev_info(ctx->dev, "ID: %#x\n", v);
+
+	/* configure PPI counters */
+	tc358764_write(ctx, PPI_TX_RX_TA, TTA_GET | TTA_SURE);
+	tc358764_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
+	tc358764_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
+	tc358764_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
+	tc358764_write(ctx, PPI_D2S_CLRSIPOCOUNT, 5);
+	tc358764_write(ctx, PPI_D3S_CLRSIPOCOUNT, 5);
+
+	/* enable four data lanes and clock lane */
+	tc358764_write(ctx, PPI_LANEENABLE, LANEENABLE_L3EN | LANEENABLE_L2EN |
+		       LANEENABLE_L1EN | LANEENABLE_L0EN | LANEENABLE_CLEN);
+	tc358764_write(ctx, DSI_LANEENABLE, LANEENABLE_L3EN | LANEENABLE_L2EN |
+		       LANEENABLE_L1EN | LANEENABLE_L0EN | LANEENABLE_CLEN);
+
+	/* start */
+	tc358764_write(ctx, PPI_STARTPPI, PPI_START_FUNCTION);
+	tc358764_write(ctx, DSI_STARTDSI, DSI_RX_START);
+
+	/* configure video path */
+	tc358764_write(ctx, VP_CTRL, VP_CTRL_VSDELAY(15) | VP_CTRL_RGB888(1) |
+		       VP_CTRL_EVTMODE(1) | VP_CTRL_HSPOL | VP_CTRL_VSPOL);
+
+	/* reset PHY */
+	tc358764_write(ctx, LV_PHY0, LV_PHY0_RST(1) |
+		       LV_PHY0_PRBS_ON(4) | LV_PHY0_IS(2) | LV_PHY0_ND(6));
+	tc358764_write(ctx, LV_PHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_IS(2) |
+		       LV_PHY0_ND(6));
+
+	/* reset bridge */
+	tc358764_write(ctx, SYS_RST, SYS_RST_LCD);
+
+	/* set bit order */
+	tc358764_write(ctx, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
+	tc358764_write(ctx, LV_MX0407, LV_MX(LVI_R4, LVI_R7, LVI_R5, LVI_G0));
+	tc358764_write(ctx, LV_MX0811, LV_MX(LVI_G1, LVI_G2, LVI_G6, LVI_G7));
+	tc358764_write(ctx, LV_MX1215, LV_MX(LVI_G3, LVI_G4, LVI_G5, LVI_B0));
+	tc358764_write(ctx, LV_MX1619, LV_MX(LVI_B6, LVI_B7, LVI_B1, LVI_B2));
+	tc358764_write(ctx, LV_MX2023, LV_MX(LVI_B3, LVI_B4, LVI_B5, LVI_L0));
+	tc358764_write(ctx, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R6));
+	tc358764_write(ctx, LV_CFG, LV_CFG_CLKPOL2 | LV_CFG_CLKPOL1 |
+		       LV_CFG_LVEN);
+
+	return 0;
+}
+
+static void tc358764_reset(struct tc358764 *ctx)
+{
+	msleep(20);
+	gpiod_set_value(ctx->gpio_reset, 0);
+	msleep(20);
+	gpiod_set_value(ctx->gpio_reset, 1);
+	msleep(40);
+}
+
+static void tc358764_poweroff(struct tc358764 *ctx)
+{
+	int ret;
+
+	tc358764_reset(ctx);
+
+	drm_panel_disable(ctx->panel);
+	msleep(40);
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	if (ret < 0)
+		dev_err(ctx->dev, "error disabling regulators (%d)\n", ret);
+}
+
+static int tc358764_get_modes(struct drm_connector *connector)
+{
+	struct tc358764 *ctx = connector_to_tc358764(connector);
+
+	if (ctx->panel && ctx->panel->funcs && ctx->panel->funcs->get_modes)
+		return ctx->panel->funcs->get_modes(ctx->panel);
+
+	return 0;
+}
+
+static const
+struct drm_connector_helper_funcs tc358764_connector_helper_funcs = {
+	.get_modes = tc358764_get_modes,
+};
+
+static const struct drm_connector_funcs tc358764_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.reset = drm_atomic_helper_connector_reset,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static void tc358764_disable(struct drm_bridge *bridge)
+{
+	struct tc358764 *ctx = bridge_to_tc358764(bridge);
+
+	tc358764_poweroff(ctx);
+}
+
+static void tc358764_pre_enable(struct drm_bridge *bridge)
+{
+	struct tc358764 *ctx = bridge_to_tc358764(bridge);
+	int ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies),
+					ctx->supplies);
+	if (ret < 0)
+		dev_err(ctx->dev, "error enabling regulators (%d)\n", ret);
+
+	tc358764_reset(ctx);
+	tc358764_init(ctx);
+}
+
+static void tc358764_enable(struct drm_bridge *bridge)
+{
+	struct tc358764 *ctx = bridge_to_tc358764(bridge);
+	int ret;
+
+	drm_panel_prepare(ctx->panel);
+
+	ret = drm_panel_enable(ctx->panel);
+	if (ret < 0)
+		pr_err("panel enable failed\n");
+
+	msleep(40);
+}
+
+static int tc358764_attach(struct drm_bridge *bridge)
+{
+	struct tc358764 *ctx = bridge_to_tc358764(bridge);
+	struct drm_device *drm = bridge->dev;
+	int ret;
+
+	if (!bridge->encoder) {
+		DRM_ERROR("Encoder not found\n");
+		return -ENODEV;
+	}
+
+	ctx->connector.polled = DRM_CONNECTOR_POLL_HPD;
+	ret = drm_connector_init(drm, &ctx->connector,
+				 &tc358764_connector_funcs,
+				 DRM_MODE_CONNECTOR_LVDS);
+	if (ret) {
+		DRM_ERROR("Failed to initialize connector\n");
+		return ret;
+	}
+
+	drm_connector_helper_add(&ctx->connector,
+				 &tc358764_connector_helper_funcs);
+
+	drm_mode_connector_attach_encoder(&ctx->connector, bridge->encoder);
+
+	if (ctx->panel)
+		drm_panel_attach(ctx->panel, &ctx->connector);
+
+	drm_atomic_helper_connector_reset(&ctx->connector);
+	drm_connector_register(&ctx->connector);
+
+	return 0;
+}
+
+static const struct drm_bridge_funcs tc358764_bridge_funcs = {
+	.disable = tc358764_disable,
+	.enable = tc358764_enable,
+	.pre_enable = tc358764_pre_enable,
+	.attach = tc358764_attach,
+};
+
+static struct device_node *tc358764_of_find_panel_node(struct device *dev)
+{
+	struct device_node *np, *ep;
+
+	ep = of_graph_get_endpoint_by_regs(dev->of_node, 1, 0);
+	if (!ep) {
+		pr_err("failed to get endpoint\n");
+		return NULL;
+	}
+
+	np = of_graph_get_remote_port_parent(ep);
+
+	return np;
+}
+
+static int tc358764_parse_dt(struct tc358764 *ctx)
+{
+	struct device *dev = ctx->dev;
+	struct device_node *np = dev->of_node;
+	struct device_node *lvds;
+
+	ctx->gpio_reset = devm_gpiod_get_from_of_node(dev, np, "reset", 0,
+						      GPIOD_OUT_LOW,
+						      "tc358764-reset");
+	if (IS_ERR(ctx->gpio_reset)) {
+		dev_err(dev, "no reset GPIO pin provided\n");
+		return PTR_ERR(ctx->gpio_reset);
+	}
+
+	lvds = tc358764_of_find_panel_node(ctx->dev);
+	if (!lvds) {
+		dev_err(dev, "cannot find panel node\n");
+		return -EINVAL;
+	}
+
+	ctx->panel = of_drm_find_panel(lvds);
+	if (!ctx->panel) {
+		dev_err(dev, "panel not registered\n");
+		return -EPROBE_DEFER;
+	}
+
+	return 0;
+}
+
+static int tc358764_configure_regulators(struct tc358764 *ctx)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(ctx->supplies); ++i)
+		ctx->supplies[i].supply = tc358764_supplies[i];
+
+	ret = devm_regulator_bulk_get(ctx->dev, ARRAY_SIZE(ctx->supplies),
+				      ctx->supplies);
+	if (ret < 0)
+		dev_err(ctx->dev, "failed to get regulators: %d\n", ret);
+
+	return ret;
+}
+
+static int tc358764_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	struct tc358764 *ctx;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(struct tc358764), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	ctx->dev = dev;
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST
+		| MIPI_DSI_MODE_VIDEO_AUTO_VERT | MIPI_DSI_MODE_LPM;
+
+	ret = tc358764_parse_dt(ctx);
+	if (ret < 0)
+		return ret;
+
+	ret = tc358764_configure_regulators(ctx);
+	if (ret < 0)
+		return ret;
+
+	ctx->bridge.funcs = &tc358764_bridge_funcs;
+	ctx->bridge.of_node = dev->of_node;
+
+	drm_bridge_add(&ctx->bridge);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_bridge_remove(&ctx->bridge);
+		dev_err(dev, "failed to attach dsi\n");
+	}
+
+	return ret;
+}
+
+static int tc358764_remove(struct mipi_dsi_device *dsi)
+{
+	struct tc358764 *ctx = mipi_dsi_get_drvdata(dsi);
+
+	tc358764_poweroff(ctx);
+
+	mipi_dsi_detach(dsi);
+	drm_bridge_remove(&ctx->bridge);
+
+	return 0;
+}
+
+static const struct of_device_id tc358764_of_match[] = {
+	{ .compatible = "toshiba,tc358764" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tc358764_of_match);
+
+static struct mipi_dsi_driver tc358764_driver = {
+	.probe = tc358764_probe,
+	.remove = tc358764_remove,
+	.driver = {
+		.name = "tc358764",
+		.owner = THIS_MODULE,
+		.of_match_table = tc358764_of_match,
+	},
+};
+module_mipi_dsi_driver(tc358764_driver);
+
+MODULE_AUTHOR("Andrzej Hajda <a.hajda@samsung.com>");
+MODULE_AUTHOR("Maciej Purski <m.purski@samsung.com>");
+MODULE_DESCRIPTION("MIPI-DSI based Driver for TC358764 DSI/LVDS Bridge");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

