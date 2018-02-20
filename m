Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752252AbeBTPJ3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:09:29 -0500
Received: from mail01.prevas.se ([62.95.78.3]:29123 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751808AbeBTPJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:09:24 -0500
X-IronPort-AV: E=Sophos;i="5.46,539,1511823600";
   d="scan'208";a="3274638"
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        York Sun <york.sun@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] EDAC, layerscape: allow building for LS1021A
Date: Tue, 20 Feb 2018 16:09:12 +0100
Message-ID: <20180220150912.2954-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.8.31]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LS1021A has a memory controller supported by this driver. It builds
just fine, and I've done some rudimentary testing using the error
injection facility, which suggests that it is indeed working.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
Hi York

In https://patchwork.kernel.org/patch/9264623/, you wrote that LS1021A
support is "just one step away". I'm wondering if this is simply that
step, or there is a little more to it. As I write, it seems to work
just fine, but I may be missing something.

 drivers/edac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 96afb2aeed18..23f619afe31d 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -254,7 +254,7 @@ config EDAC_MPC85XX
 
 config EDAC_LAYERSCAPE
 	tristate "Freescale Layerscape DDR"
-	depends on ARCH_LAYERSCAPE
+	depends on ARCH_LAYERSCAPE || SOC_LS1021A
 	help
 	  Support for error detection and correction on Freescale memory
 	  controllers on Layerscape SoCs.
-- 
2.15.1
