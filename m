Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeCJRNJ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 12:13:09 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42768 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeCJRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 12:13:07 -0500
X-Google-Smtp-Source: AG47ELu81KkQoIq4rWEM3pQO0xmhUJ6FJ6LgIO7fdv+HQS7/gsvc9iqKZN9ULT6gF9rQSp2yEjYaKA==
From: Vivek Unune <npcomplete13@gmail.com>
To: florian.fainelli@broadcom.com, hauke@hauke-m.de, zajec5@gmail.com,
        jonmason@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vivek Unune <npcomplete13@gmail.com>
Subject: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys Panamera
Date: Sat, 10 Mar 2018 12:12:44 -0500
Message-Id: <20180310171244.70299-1-npcomplete13@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using BCH8 gives ecc errors and makes the router unsuable.
Switching to BCH1 fixes these errors.

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index b6750f70dffb..ea1b3f5eff29 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -7,7 +7,7 @@
 /dts-v1/;
 
 #include "bcm47094.dtsi"
-#include "bcm5301x-nand-cs0-bch8.dtsi"
+#include "bcm5301x-nand-cs0-bch1.dtsi"
 
 / {
 	compatible = "linksys,panamera", "brcm,bcm47094", "brcm,bcm4708";
-- 
2.11.0
