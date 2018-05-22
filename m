Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751503AbeEVJlC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:41:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49661 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbeEVJk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:40:56 -0400
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Haim Boot <hayim@marvell.com>,
        Hanna Hawa <hannah@marvell.com>, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 01/16] dt-bindings/interrupt-controller: fix Marvell ICU length in the example
Date: Tue, 22 May 2018 11:40:27 +0200
Message-Id: <20180522094042.24770-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180522094042.24770-1-miquel.raynal@bootlin.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICU size in CP110 is not 0x10 but at least 0x440 bytes long (from the
specification).

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
index aa8bf2ec8905..649b7ec9d9b1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt
@@ -39,7 +39,7 @@ Example:
 
 icu: interrupt-controller@1e0000 {
 	compatible = "marvell,cp110-icu";
-	reg = <0x1e0000 0x10>;
+	reg = <0x1e0000 0x440>;
 	#interrupt-cells = <3>;
 	interrupt-controller;
 	msi-parent = <&gicp>;
-- 
2.14.1
