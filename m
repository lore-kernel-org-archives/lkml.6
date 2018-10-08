Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A9C64EB0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEAC2064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEAC2064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJHR0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:26:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39182 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbeJHR0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:26:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D77A32090A; Mon,  8 Oct 2018 12:15:11 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id A55B720898;
        Mon,  8 Oct 2018 12:14:51 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, davem@davemloft.net, andrew@lunn.ch,
        f.fainelli@gmail.com
Cc:     allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        antoine.tenart@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [RESEND PATCH net-next v2 1/5] dt-bindings: net: vsc8531: add two additional LED modes for VSC8584
Date:   Mon,  8 Oct 2018 12:14:41 +0200
Message-Id: <20181008101445.25946-2-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008101445.25946-1-quentin.schulz@bootlin.com>
References: <20181008101445.25946-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VSC8584 (and most likely other PHYs in the same generation) has two
additional LED modes that can be picked, so let's add them.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 include/dt-bindings/net/mscc-phy-vsc8531.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
index 697161f80eb5..9eb2ec2b2ea9 100644
--- a/include/dt-bindings/net/mscc-phy-vsc8531.h
+++ b/include/dt-bindings/net/mscc-phy-vsc8531.h
@@ -18,9 +18,11 @@
 #define VSC8531_LINK_100_1000_ACTIVITY  4
 #define VSC8531_LINK_10_1000_ACTIVITY   5
 #define VSC8531_LINK_10_100_ACTIVITY    6
+#define VSC8584_LINK_100FX_1000X_ACTIVITY	7
 #define VSC8531_DUPLEX_COLLISION        8
 #define VSC8531_COLLISION               9
 #define VSC8531_ACTIVITY                10
+#define VSC8584_100FX_1000X_ACTIVITY	11
 #define VSC8531_AUTONEG_FAULT           12
 #define VSC8531_SERIAL_MODE             13
 #define VSC8531_FORCE_LED_OFF           14
-- 
2.17.1

