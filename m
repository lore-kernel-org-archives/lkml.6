Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB4FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2283320873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2283320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732060AbeG3OiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:38:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60050 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729578AbeG3Oh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:37:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AEE722082B; Mon, 30 Jul 2018 15:03:00 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 684B820703;
        Mon, 30 Jul 2018 15:03:00 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 3/4] dt-bindings: net: phy: mscc: vsc8531: fix missing "/bits/ 8" in example
Date:   Mon, 30 Jul 2018 15:02:35 +0200
Message-Id: <20180730130236.3837-3-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730130236.3837-1-quentin.schulz@bootlin.com>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "vsc8531,led-N-mode" property is read as a u8 in the driver and
there aren't a lot of modes anyway.

Without the "/bits/ 8" in front of the value of the property, the
value is stored as an u32 resulting in of_read_property_u8 to always
return 0.

Fix the example so that people using the property can actually use it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 664d9d0543fc..4c7d1d384df0 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -63,6 +63,6 @@ Example:
                 compatible = "ethernet-phy-id0007.0570";
                 vsc8531,vddmac		= <3300>;
                 vsc8531,edge-slowdown	= <7>;
-                vsc8531,led-0-mode	= <LINK_1000_ACTIVITY>;
-                vsc8531,led-1-mode	= <LINK_100_ACTIVITY>;
+                vsc8531,led-0-mode	= /bits/ 8 <LINK_1000_ACTIVITY>;
+                vsc8531,led-1-mode	= /bits/ 8 <LINK_100_ACTIVITY>;
         };
-- 
2.17.1

