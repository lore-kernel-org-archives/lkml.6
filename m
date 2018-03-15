Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeCOSN4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:13:56 -0400
Received: from vern.gendns.com ([206.190.152.46]:36537 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeCOSNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:13:54 -0400
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: davinci: DA8XX: simplify CFGCHIP regmap_config
Date: Thu, 15 Mar 2018 13:13:41 -0500
Message-Id: <1521137621-6491-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8253bb3f8255 ("regmap: potentially duplicate the name
string stored in regmap"), the name field of struct regmap_config
is copied in __regmap_init(), so we no longer need to worry about
keeping our own copy of the name.

Just use a string literal in the initialization of da8xx_cfgchip_config
instead of creating a separate variable for the name.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 273b6c2..1fd3619 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1095,11 +1095,8 @@ int __init da850_register_sata(unsigned long refclkpn)
 
 static struct regmap *da8xx_cfgchip;
 
-/* regmap doesn't make a copy of this, so we need to keep the pointer around */
-static const char da8xx_cfgchip_name[] = "cfgchip";
-
 static const struct regmap_config da8xx_cfgchip_config __initconst = {
-	.name		= da8xx_cfgchip_name,
+	.name		= "cfgchip",
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-- 
2.7.4
