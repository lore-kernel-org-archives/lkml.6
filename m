Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934040AbeB1Rih (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:38:37 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36079 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932537AbeB1Rie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:38:34 -0500
From: Colin King <colin.king@canonical.com>
To: Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH] ARM: iop13xx: Remove duplicated bit-wise or of PCI_STATUS_REC_TARGET_ABORT
Date: Wed, 28 Feb 2018 17:38:23 +0000
Message-Id: <20180228173823.4074-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Bit pattern PCI_STATUS_REC_TARGET_ABORT is being bit-wise or'd twice;
remove the redundant 2nd PCI_STATUS_REC_TARGET_ABORT

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/arm/mach-iop13xx/pci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-iop13xx/pci.h b/arch/arm/mach-iop13xx/pci.h
index 736168d8c7ac..c6a0678c1741 100644
--- a/arch/arm/mach-iop13xx/pci.h
+++ b/arch/arm/mach-iop13xx/pci.h
@@ -23,7 +23,6 @@ void iop13xx_map_pci_memory(void);
 #define IOP_PCI_STATUS_ERROR (PCI_STATUS_PARITY |	     \
 			       PCI_STATUS_SIG_TARGET_ABORT | \
 			       PCI_STATUS_REC_TARGET_ABORT | \
-			       PCI_STATUS_REC_TARGET_ABORT | \
 			       PCI_STATUS_REC_MASTER_ABORT | \
 			       PCI_STATUS_SIG_SYSTEM_ERROR | \
 	 		       PCI_STATUS_DETECTED_PARITY)
-- 
2.15.1
