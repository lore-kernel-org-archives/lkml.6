Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EEEFC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38F020853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38F020853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeINO6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:58:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36782 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbeINO6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:58:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF17F20877; Fri, 14 Sep 2018 11:44:56 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6A52B206F6;
        Fri, 14 Sep 2018 11:44:56 +0200 (CEST)
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
Subject: [PATCH net-next 1/7] dt-bindings: net: vsc8531: add two additional LED modes for VSC8584
Date:   Fri, 14 Sep 2018 11:44:22 +0200
Message-Id: <f54f6cda7f505d99531e33626f8d4e6f1dc084ec.1536916714.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
References: <cover.b921b010b6d6bde1c11e69551ae38f3b2818645b.1536916714.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VSC8584 (and most likely other PHYs in the same generation) has two
additional LED modes that can be picked, so let's add them.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 include/dt-bindings/net/mscc-phy-vsc8531.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
index 697161f..9eb2ec2 100644
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
git-series 0.9.1
