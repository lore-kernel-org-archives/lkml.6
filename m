Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC99C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E85218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KTcQc89M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfAYSRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:17:24 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42661 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfAYSRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:17:22 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so8317694oiw.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/oPkh2eQXeLKjJWwIkFeDDvqvUgqciEIX6ygLRCXldw=;
        b=KTcQc89Mr2GERQmznKmgPH8rGRytvGvmHIAw3vhoyv2zphDlSIO5UM9C9alhMy1bMI
         4L4RBTi82/8lwLEckVu+qiG1ymuZM00HmxugvIdwhzTNv5TfmAPWLc0BoaYmd6RTZrzH
         H6Yn3tmZrOXT1Ft3Gw5s8HLrPbPBQC9ONNfco8oTRj48Q3mNEYukCGEF8RrQARgZHnJF
         RqibPhITeL6YcovPcT/uzrTwOsFcB9vqWoDem20uPL14wzNqCyDlEUcTR+zb2kkLOFUO
         I6cH5TQHper/bujWcAIz8Y99sCVJnFLhgA8AA9ke2cyEfSmQIbBHHAIJh7s5opwxFosA
         x9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/oPkh2eQXeLKjJWwIkFeDDvqvUgqciEIX6ygLRCXldw=;
        b=cs+4eLPW9a52WaH555d36lXULJakSU6M+avijjKlFBG4V9m1FK7sX1rAnsPFumolEt
         iwHoH/fmdCJbZZQukKqQP0/b8JfhUAahAxtU6IeXBVAOLCSAVbs6yAjzBO1u99NDfHti
         RMnjXv0CELbqAp3LO5z2mUEhKYBH4j1O7o+Opi8nNwbjwCzOJtrxOwTAVp8NgUrxngha
         lTMEjf24dZYN9OnYPbE9TWq2ro9hP/yx8U3hFxzm4rh888/ihQVrJiXJID0v0jME/rf4
         HsR4l2iSfVLK0h0bnJA8JHXFHrL/ySo/GlQYV1pQ2QAN/XqiaZFBVeTxPCCt854ON3Tv
         Mc/g==
X-Gm-Message-State: AJcUukdeNw7ucfut8H/f02Nrkl+LwrMJjKCJc6Jf/y2byv3CyGgJYIdp
        wvGAC9sxCklolO+NiwmNX4nhyRtFWeQ=
X-Google-Smtp-Source: ALg8bN5DbHdoZ/pKx31gB3tQs5T6BhLVIQuXlupslNLRMVGnOkxNYjN+0HdZsQ5KdR4mw+i1o+wuAg==
X-Received: by 2002:aca:4208:: with SMTP id p8mr2051588oia.331.1548440240826;
        Fri, 25 Jan 2019 10:17:20 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l204sm1461179oia.54.2019.01.25.10.17.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:17:19 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/5] drivers/accel: cxl: Move non-uapi include files
Date:   Fri, 25 Jan 2019 10:16:14 -0800
Message-Id: <20190125181616.62609-4-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190125181616.62609-1-olof@lixom.net>
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate to expose the edits vs pure moves.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 MAINTAINERS                               | 2 +-
 arch/powerpc/include/asm/pnv-pci.h        | 2 +-
 arch/powerpc/mm/copro_fault.c             | 2 +-
 arch/powerpc/mm/hash_native_64.c          | 2 +-
 arch/powerpc/mm/pgtable-book3s64.c        | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 drivers/accel/cxl/api.c                   | 2 +-
 drivers/accel/cxl/base.c                  | 2 +-
 drivers/accel/cxl/cxl.h                   | 4 ++--
 drivers/accel/cxl/cxllib.c                | 2 +-
 drivers/accel/cxl/irq.c                   | 2 +-
 drivers/accel/cxl/main.c                  | 2 +-
 drivers/accel/cxl/native.c                | 2 +-
 drivers/accel/cxl/pci.c                   | 2 +-
 drivers/accel/cxl/vphb.c                  | 2 +-
 drivers/scsi/cxlflash/cxl_hw.c            | 2 +-
 include/{misc => linux/accel}/cxl-base.h  | 4 ++--
 include/{misc => linux/accel}/cxl.h       | 6 +++---
 include/{misc => linux/accel}/cxllib.h    | 6 +++---
 19 files changed, 25 insertions(+), 25 deletions(-)
 rename include/{misc => linux/accel}/cxl-base.h (94%)
 rename include/{misc => linux/accel}/cxl.h (99%)
 rename include/{misc => linux/accel}/cxllib.h (97%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93fbfed6e6915..97aed390129f0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4215,7 +4215,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/pci-cxl.c
 F:	drivers/accel/cxl/
-F:	include/misc/cxl*
+F:	include/linux/accel/cxl*
 F:	include/uapi/misc/cxl.h
 F:	Documentation/powerpc/cxl.txt
 F:	Documentation/ABI/testing/sysfs-class-cxl
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index 630eb8b1b7ed3..17e0ded18ffd6 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -13,7 +13,7 @@
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/irq.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 #include <asm/opal-api.h>
 
 #define PCI_SLOT_ID_PREFIX	(1UL << 63)
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index c8da352e8686c..441a51d9c8f8a 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -26,7 +26,7 @@
 #include <asm/reg.h>
 #include <asm/copro.h>
 #include <asm/spu.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
 /*
  * This ought to be kept in sync with the powerpc specific do_page_fault
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index aaa28fd918fe4..b6f49c98aa732 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -31,7 +31,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/feature-fixups.h>
 
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
 #ifdef DEBUG_LOW
 #define DBG_LOW(fmt...) udbg_printf(fmt)
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 55876b7e38130..34bdd8bca31e6 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -10,7 +10,7 @@
 #include <linux/sched.h>
 #include <linux/mm_types.h>
 #include <linux/memblock.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7db3119f8a5b3..0506eb74b99b6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -41,7 +41,7 @@
 #include <asm/pnv-pci.h>
 #include <asm/mmzone.h>
 
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
 #include "powernv.h"
 #include "pci.h"
diff --git a/drivers/accel/cxl/api.c b/drivers/accel/cxl/api.c
index 750470ef2049b..220944d7a398c 100644
--- a/drivers/accel/cxl/api.c
+++ b/drivers/accel/cxl/api.c
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/file.h>
-#include <misc/cxl.h>
+#include <linux/accel/cxl.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/sched/mm.h>
diff --git a/drivers/accel/cxl/base.c b/drivers/accel/cxl/base.c
index 7557835cdfcd6..bd2958a7a379a 100644
--- a/drivers/accel/cxl/base.c
+++ b/drivers/accel/cxl/base.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/rcupdate.h>
 #include <asm/errno.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 #include <linux/of_platform.h>
 #include "cxl.h"
 
diff --git a/drivers/accel/cxl/cxl.h b/drivers/accel/cxl/cxl.h
index d1d927ccb589c..82457ccc58cad 100644
--- a/drivers/accel/cxl/cxl.h
+++ b/drivers/accel/cxl/cxl.h
@@ -22,9 +22,9 @@
 #include <asm/cputable.h>
 #include <asm/mmu.h>
 #include <asm/reg.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
-#include <misc/cxl.h>
+#include <linux/accel/cxl.h>
 #include <uapi/misc/cxl.h>
 
 extern uint cxl_verbose;
diff --git a/drivers/accel/cxl/cxllib.c b/drivers/accel/cxl/cxllib.c
index 5a3f912552585..ba5cde62e030f 100644
--- a/drivers/accel/cxl/cxllib.c
+++ b/drivers/accel/cxl/cxllib.c
@@ -10,7 +10,7 @@
 #include <linux/hugetlb.h>
 #include <linux/sched/mm.h>
 #include <asm/pnv-pci.h>
-#include <misc/cxllib.h>
+#include <linux/accel/cxllib.h>
 
 #include "cxl.h"
 
diff --git a/drivers/accel/cxl/irq.c b/drivers/accel/cxl/irq.c
index ce08a9f22308f..6f55130dd014c 100644
--- a/drivers/accel/cxl/irq.c
+++ b/drivers/accel/cxl/irq.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/pid.h>
 #include <asm/cputable.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
 #include "cxl.h"
 #include "trace.h"
diff --git a/drivers/accel/cxl/main.c b/drivers/accel/cxl/main.c
index f35406be465a5..f49edfe0371d2 100644
--- a/drivers/accel/cxl/main.c
+++ b/drivers/accel/cxl/main.c
@@ -22,7 +22,7 @@
 #include <linux/sched/task.h>
 
 #include <asm/cputable.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
 #include "cxl.h"
 #include "trace.h"
diff --git a/drivers/accel/cxl/native.c b/drivers/accel/cxl/native.c
index c9d5d82dce8ec..e9b8116a5e34b 100644
--- a/drivers/accel/cxl/native.c
+++ b/drivers/accel/cxl/native.c
@@ -17,7 +17,7 @@
 #include <linux/delay.h>
 #include <asm/synch.h>
 #include <asm/switch_to.h>
-#include <misc/cxl-base.h>
+#include <linux/accel/cxl-base.h>
 
 #include "cxl.h"
 #include "trace.h"
diff --git a/drivers/accel/cxl/pci.c b/drivers/accel/cxl/pci.c
index c79ba1c699ad1..ff8d0b5679c43 100644
--- a/drivers/accel/cxl/pci.c
+++ b/drivers/accel/cxl/pci.c
@@ -24,7 +24,7 @@
 #include <asm/reg.h>
 
 #include "cxl.h"
-#include <misc/cxl.h>
+#include <linux/accel/cxl.h>
 
 
 #define CXL_PCI_VSEC_ID	0x1280
diff --git a/drivers/accel/cxl/vphb.c b/drivers/accel/cxl/vphb.c
index 49da2f744bbf1..c3670d8b4a252 100644
--- a/drivers/accel/cxl/vphb.c
+++ b/drivers/accel/cxl/vphb.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/pci.h>
-#include <misc/cxl.h>
+#include <linux/accel/cxl.h>
 #include "cxl.h"
 
 static int cxl_pci_probe_mode(struct pci_bus *bus)
diff --git a/drivers/scsi/cxlflash/cxl_hw.c b/drivers/scsi/cxlflash/cxl_hw.c
index b42da88386bdd..bb3b6b9443062 100644
--- a/drivers/scsi/cxlflash/cxl_hw.c
+++ b/drivers/scsi/cxlflash/cxl_hw.c
@@ -12,7 +12,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <misc/cxl.h>
+#include <linux/accel/cxl.h>
 
 #include "backend.h"
 
diff --git a/include/misc/cxl-base.h b/include/linux/accel/cxl-base.h
similarity index 94%
rename from include/misc/cxl-base.h
rename to include/linux/accel/cxl-base.h
index f53808fa638ab..8e7825693f7de 100644
--- a/include/misc/cxl-base.h
+++ b/include/linux/accel/cxl-base.h
@@ -7,8 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef _MISC_CXL_BASE_H
-#define _MISC_CXL_BASE_H
+#ifndef _LINUX_ACCEL_CXL_BASE_H
+#define _LINUX_ACCEL_CXL_BASE_H
 
 #ifdef CONFIG_CXL_BASE
 
diff --git a/include/misc/cxl.h b/include/linux/accel/cxl.h
similarity index 99%
rename from include/misc/cxl.h
rename to include/linux/accel/cxl.h
index ea9ff4a1a9ca5..07c3942c62ea1 100644
--- a/include/misc/cxl.h
+++ b/include/linux/accel/cxl.h
@@ -7,8 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef _MISC_CXL_H
-#define _MISC_CXL_H
+#ifndef _LINUX_ACCEL_CXL_H
+#define _LINUX_ACCEL_CXL_H
 
 #include <linux/pci.h>
 #include <linux/poll.h>
@@ -266,4 +266,4 @@ void cxl_set_driver_ops(struct cxl_context *ctx,
 void cxl_context_events_pending(struct cxl_context *ctx,
 				unsigned int new_events);
 
-#endif /* _MISC_CXL_H */
+#endif /* _LINUX_ACCEL_CXL_H */
diff --git a/include/misc/cxllib.h b/include/linux/accel/cxllib.h
similarity index 97%
rename from include/misc/cxllib.h
rename to include/linux/accel/cxllib.h
index e5aa29f019a6b..ef045430a9679 100644
--- a/include/misc/cxllib.h
+++ b/include/linux/accel/cxllib.h
@@ -7,8 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef _MISC_CXLLIB_H
-#define _MISC_CXLLIB_H
+#ifndef _LINUX_ACCEL_CXLLIB_H
+#define _LINUX_ACCEL_CXLLIB_H
 
 #include <linux/pci.h>
 #include <asm/reg.h>
@@ -130,4 +130,4 @@ int cxllib_get_PE_attributes(struct task_struct *task,
 int cxllib_handle_fault(struct mm_struct *mm, u64 addr, u64 size, u64 flags);
 
 
-#endif /* _MISC_CXLLIB_H */
+#endif /* _LINUX_ACCEL_CXLLIB_H */
-- 
2.11.0

