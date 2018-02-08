Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752222AbeBHTjb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 14:39:31 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54646 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHTj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 14:39:29 -0500
X-Google-Smtp-Source: AH8x226mzaySdNPQ3A3WTeNDWtJjkYWbH+p/Ay1BzfAHf97yqVW5jYfK5wcaO5fOFjDopPC0AlK/2A==
From: Corentin Labbe <clabbe@baylibre.com>
To: fenghua.yu@intel.com, tony.luck@intel.com, hch@lst.de,
        christian.koenig@amd.com
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ia64: fix build failure with CONFIG_SWIOTLB
Date: Thu,  8 Feb 2018 19:39:20 +0000
Message-Id: <1518118760-5224-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/ia64/kernel/pci-swiotlb.c is removed in commit 4fac8076df85 ("ia64: clean up swiotlb support")
but pci-swiotlb.o is still present in Makefile, and so build fail when
CONFIG_SWIOTLB is enabled.
Fix the build failure by removing pci-swiotlb.o from makefile

Fixes: 4fac8076df85 ("ia64: clean up swiotlb support")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/ia64/kernel/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 0b4c65a1af25..498f3da3f225 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -41,7 +41,6 @@ ifneq ($(CONFIG_IA64_ESI),)
 obj-y				+= esi_stub.o	# must be in kernel proper
 endif
 obj-$(CONFIG_INTEL_IOMMU)	+= pci-dma.o
-obj-$(CONFIG_SWIOTLB)		+= pci-swiotlb.o
 
 obj-$(CONFIG_BINFMT_ELF)	+= elfcore.o
 
-- 
2.13.6
