Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3513F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17B420873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17B420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbeG3Oh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:37:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60059 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbeG3Oh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:37:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F26D2207AC; Mon, 30 Jul 2018 15:03:00 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id A6FC620712;
        Mon, 30 Jul 2018 15:03:00 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 4/4] dt-bindings: net: phy: mscc: vsc8531: factorize vsc8531,led-N-mode
Date:   Mon, 30 Jul 2018 15:02:36 +0200
Message-Id: <20180730130236.3837-4-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730130236.3837-1-quentin.schulz@bootlin.com>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VSC8584 supports 4 LEDs while VSC8531 only supports 2. Let's factorize
the documentation for LED mode properties and give the 4 default values
(the first two being shared between VSC8531 and VSC8584).

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 .../devicetree/bindings/net/mscc-phy-vsc8531.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 4c7d1d384df0..4d3f8b07a286 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -22,14 +22,16 @@ Optional properties:
 			  'vddmac'.
 			  Default value is 0%.
 			  Ref: Table:1 - Edge rate change (below).
-- vsc8531,led-0-mode	: LED mode. Specify how the LED[0] should behave.
-			  Allowed values are define in
+- vsc8531,led-[N]-mode	: LED mode. Specify how the LED[N] should behave.
+			  N depends on the number of LEDs supported by a
+			  PHY.
+			  Allowed values are defined in
 			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
-			  Default value is VSC8531_LINK_1000_ACTIVITY (1).
-- vsc8531,led-1-mode	: LED mode. Specify how the LED[1] should behave.
-			  Allowed values are define in
-			  "include/dt-bindings/net/mscc-phy-vsc8531.h".
-			  Default value is VSC8531_LINK_100_ACTIVITY (2).
+			  Default values are VSC8531_LINK_1000_ACTIVITY (1),
+			  VSC8531_LINK_100_ACTIVITY (2),
+			  VSC8531_LINK_ACTIVITY (0) and
+			  VSC8531_DUPLEX_COLLISION (8).
+
 
 Table: 1 - Edge rate change
 ----------------------------------------------------------------|
-- 
2.17.1

