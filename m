Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBFRkc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:40:32 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:33691 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbeBFRkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:40:25 -0500
From: Stefan Agner <stefan@agner.ch>
To: han.xu@nxp.com, boris.brezillon@free-electrons.com
Cc: marek.vasut@gmail.com, richard@nod.at, dwmw2@infradead.org,
        cyrille.pitchen@wedev4u.fr, max.oss.09@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] dt-bindings: mtd: gpmi-nand: specify fsl,use-minimum-ecc behavior
Date: Tue,  6 Feb 2018 18:40:20 +0100
Message-Id: <20180206174021.5947-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dt property fsl,use-minimum-ecc requires a NAND chip to
provide a ECC strength/step size, otherwise the driver fails
to probe. This is by design to avoid that the driver uses a
fallback and later changes ECC parameters due to additionion
of a NAND chip driver. Document the current behavior.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/mtd/gpmi-nand.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
index b289ef3c1b7e..eb2d9919d063 100644
--- a/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmi-nand.txt
@@ -34,9 +34,8 @@ Optional properties:
                        automatically discoverable for some flash
                        (e.g., according to the ONFI standard).
                        However, note that if this strength is not
-                       discoverable or this property is not enabled,
-                       the software may chooses an implementation-defined
-                       ECC scheme.
+                       discoverable the driver will fail probing with
+                       an error.
   - fsl,no-blockmark-swap: Don't swap the bad block marker from the OOB
                        area with the byte in the data area but rely on the
                        flash based BBT for identifying bad blocks.
-- 
2.16.1
