Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E172C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82012077B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82012077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeICNxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 09:53:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54613 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbeICNxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 09:53:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7DED522A3E; Mon,  3 Sep 2018 11:33:54 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id A4D3C22A46;
        Mon,  3 Sep 2018 11:33:26 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, kishon@ti.com,
        andrew@lunn.ch, f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH v2 09/11] dt-bindings: add constants for Microsemi Ocelot SerDes driver
Date:   Mon,  3 Sep 2018 11:33:06 +0200
Message-Id: <20180903093308.24366-10-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903093308.24366-1-quentin.schulz@bootlin.com>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
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
index 000000000000..cf111baa87c8
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
2.17.1

