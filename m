Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBWJVT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 04:21:19 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37036 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751273AbeBWJVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 04:21:17 -0500
X-Google-Smtp-Source: AH8x224o1GV7be9SgCaIU0LYiDsemlUXKfI7qxhnajiRtUer5YVvGyJnll9aPJMhi4yxbNrvLOQHcA==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] microblaze: Provide pgprot_device/writecombine macros for nommu
Date: Fri, 23 Feb 2018 10:21:11 +0100
Message-Id: <e9444122a422915e9a19daf9dc4c0a62ce7932f4.1519377667.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These macros are required for generic mmap.c implementation created by:
commit f719582435af ("PCI: Add pci_mmap_resource_range() and use it for
ARM64") which Microblaze is going to use.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Suggested-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index e53b8532353c..db8b1fa83452 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -33,6 +33,8 @@
 #define PAGE_KERNEL		__pgprot(0) /* these mean nothing to non MMU */
 
 #define pgprot_noncached(x)	(x)
+#define pgprot_writecombine	pgprot_noncached
+#define pgprot_device		pgprot_noncached
 
 #define __swp_type(x)		(0)
 #define __swp_offset(x)		(0)
-- 
1.9.1
