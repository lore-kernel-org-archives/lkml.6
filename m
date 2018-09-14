Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DF8FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2762920853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2762920853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeINNbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:31:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33619 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeINNaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:30:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6BE16208B7; Fri, 14 Sep 2018 10:16:51 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3D753208ED;
        Fri, 14 Sep 2018 10:16:33 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH net-next v3 09/11] dt-bindings: add constants for Microsemi Ocelot SerDes driver
Date:   Fri, 14 Sep 2018 10:16:07 +0200
Message-Id: <73113ea4b3d8d34c05d88413b3d15cc1733cf25e.1536912834.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
References: <cover.ff40d591b548a6da31716e6e600f11a303e0e643.1536912834.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microsemi Ocelot has multiple SerDes and requires that the SerDes be
muxed accordingly to the hardware representation.

Let's add a constant for each SerDes available in the Microsemi Ocelot.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 include/dt-bindings/phy/phy-ocelot-serdes.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-ocelot-serdes.h

diff --git a/include/dt-bindings/phy/phy-ocelot-serdes.h b/include/dt-bindings/phy/phy-ocelot-serdes.h
new file mode 100644
index 0000000..cf111ba
--- /dev/null
+++ b/include/dt-bindings/phy/phy-ocelot-serdes.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/* Copyright (c) 2018 Microsemi Corporation */
+#ifndef __PHY_OCELOT_SERDES_H__
+#define __PHY_OCELOT_SERDES_H__
+
+#define SERDES1G_0	0
+#define SERDES1G_1	1
+#define SERDES1G_2	2
+#define SERDES1G_3	3
+#define SERDES1G_4	4
+#define SERDES1G_5	5
+#define SERDES1G_MAX	6
+#define SERDES6G_0	SERDES1G_MAX
+#define SERDES6G_1	(SERDES1G_MAX + 1)
+#define SERDES6G_2	(SERDES1G_MAX + 2)
+#define SERDES6G_MAX	(SERDES1G_MAX + 3)
+#define SERDES_MAX	(SERDES1G_MAX + SERDES6G_MAX)
+
+#endif
-- 
git-series 0.9.1
