Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbeDHOEF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 10:04:05 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:59564 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751549AbeDHOEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 10:04:04 -0400
From: Tomer Maimon <tmaimon77@gmail.com>
To: arm@kernel.org, linux@armlinux.org.uk, avifishman70@gmail.com,
        brendanhiggins@google.com, venture@google.com, yuenn@google.com,
        joel@jms.id.au
Cc: arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/1] arm: npcm: enable L2 cache in NPCM7xx architecture
Date: Sun,  8 Apr 2018 17:03:17 +0300
Message-Id: <1523196197-2072-2-git-send-email-tmaimon77@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1523196197-2072-1-git-send-email-tmaimon77@gmail.com>
References: <1523196197-2072-1-git-send-email-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable ARM L2 cache module in Nuvoton NPCM7xx BMC by adding
L2 cache parameters into NPCM7xx DT machine start structure.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/mach-npcm/npcm7xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-npcm/npcm7xx.c b/arch/arm/mach-npcm/npcm7xx.c
index 5f7cd88103ef..c5f77d854c4f 100644
--- a/arch/arm/mach-npcm/npcm7xx.c
+++ b/arch/arm/mach-npcm/npcm7xx.c
@@ -17,4 +17,6 @@ static const char *const npcm7xx_dt_match[] = {
 DT_MACHINE_START(NPCM7XX_DT, "NPCM7XX Chip family")
 	.atag_offset	= 0x100,
 	.dt_compat	= npcm7xx_dt_match,
+	.l2c_aux_val	= 0x0,
+	.l2c_aux_mask	= ~0x0,
 MACHINE_END
-- 
2.14.1
