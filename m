Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbeB0BDW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 20:03:22 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:43633 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbeB0BDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 20:03:20 -0500
X-Google-Smtp-Source: AG47ELvHKiVWq2lUHMH+U7tscodxktMRBuntGtN9/zSb9DqDc1sTJponQOHYuhib60/x15crpshxNA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: NSP: Fix amount of RAM on BCM958625HR
Date: Mon, 26 Feb 2018 17:03:12 -0800
Message-Id: <20180227010312.7495-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jon attempted to fix the amount of RAM on the BCM958625HR in commit
c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
but it seems like we tripped over some poorly documented schematics.

The top-level page of the schematics says the board has 2GB, but when
you end-up scrolling to page 6, you see two chips of 4GiB (512MB) but
what the bootloader really initializes only 512MB, any attempt to use
more than that results in data aborts. Fix this again back to 512MB.

Fixes: c53beb47f621 ("ARM: dts: NSP: Correct RAM amount for BCM958625HR board")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 6a44b8021702..f0e2008f7490 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -49,7 +49,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x60000000 0x80000000>;
+		reg = <0x60000000 0x20000000>;
 	};
 
 	gpio-restart {
-- 
2.14.1
