Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932867AbeBLWcR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:32:17 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41081 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932628AbeBLWcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:32:15 -0500
X-Google-Smtp-Source: AH8x227gORkvsYNMJhI/SCvixBTssFRFgpWkYznv79xFv/hspMFu4dh5QzDpfMjTi5jUai+iHSc1Mg==
From: Guenter Roeck <linux@roeck-us.net>
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] ia64: Remove pci-swiotlb.o from kernel Makefile
Date: Mon, 12 Feb 2018 14:32:13 -0800
Message-Id: <1518474733-2972-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4fac8076df85 ("ia64: clean up swiotlb support") removed
arch/ia64/kernel/pci-swiotlb.c but neglected to update the ia64
kernel Makefile. This results in

make[2]: *** No rule to make target 'arch/ia64/kernel/pci-swiotlb.o',
	needed by 'arch/ia64/kernel/built-in.o'.  Stop.

when trying to build ia64 images.

Fixes: 4fac8076df85 ("ia64: clean up swiotlb support")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
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
2.7.4
