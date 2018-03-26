Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCZTrO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 15:47:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:33825 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752186AbeCZTrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 15:47:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="41410826"
From: thor.thayer@linux.intel.com
To: dinguyen@kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, thor.thayer@linux.intel.com
Subject: [PATCH] ARM: socfpga_defconfig: Remove QSPI Sector 4K size force
Date: Mon, 26 Mar 2018 14:50:00 -0500
Message-Id: <1522093800-7822-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Remove QSPI Sector 4K size force which is causing QSPI boot
problems with the JFFS2 root filesystem.

Fixes the following error:
     "Magic bitmask 0x1985 not found at ..."

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 arch/arm/configs/socfpga_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 2620ce790db0..371fca4e1ab7 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -57,6 +57,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
 CONFIG_OF_CONFIGFS=y
-- 
2.7.4
