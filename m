Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB9DC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6749C218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="10IA1Cjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfAYSRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:17:30 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40303 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbfAYSR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:17:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id t204so8331181oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hk9cyR0k5uDsT0aA4QtgSw3h3Jc44qhUbM4XwW7P87c=;
        b=10IA1CjgGwc27vuyjVhpdq7zJLtl1ilqfq5N943pEO6eDfA81Tz4DSoB5kQlHe0zMz
         Qi0DNJYQjbMeD/PW37eN44FHDGc0Zc4Gv8MBbHR/latMILLOSipElQNX67Bk6wBJuOPy
         MmBxrWqoSiQ1UzjLPTFZn41eb5EiKyRF808CThqxrH53WjoJKMumKGDfVAGrlNWXT8h5
         iteK9HN1g9O2xGFYOar95CKJIspVtGxLWWQ3zcd0Yl0+yBwbccLQPZ9WXWGCgM/bQYrx
         d75+VekNbmc03m2uqpy9L15gg8FiJk8KZxyhwF+d1pJWlWK3ZgTI0t7ZskoJQYtHwc3U
         QRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hk9cyR0k5uDsT0aA4QtgSw3h3Jc44qhUbM4XwW7P87c=;
        b=glTbN8rr+3idVlwj9mj9AkkXsB/RN5i/lY2qvGl5bmHzl8qyVJYKfjawot/ZLvH1Lq
         DHfKmIQjZMiVJFvxixYyAVHnJ51w6rgCUTots63Xrllrt+nY8NoXMnPGwR3ey755CrW/
         8wLTharzwXcC8bHD+OikhK0yMwL4MoVNgfBL0o6HMNWF7TXBtPgkwpoan2BoeIg3+336
         GoUW17K3PNTrXH/nQop22KxGOUNB9LjrbVSF/UC9iEizv5tUEeeixS2woqFhD4U0838l
         fMMOLhoj9lQBnsjG1wvI7L2fKgZRWNdRP+0XWL59Jx//jhjsC6t7XtAAa3MMQOqTysdO
         nUKQ==
X-Gm-Message-State: AHQUAuaq+a/y/SlGeNFuam5I4akc7gi3x723/T+p1vQ7W0F6Nk61hBUH
        SU4XdbZM0pZvePCmL8arP0AhqbovWIE=
X-Google-Smtp-Source: ALg8bN5C3m2Uh7sO4ire3F6wpO2De8HdwIU3SqAKiVoPMAbYca6ccwnl3VpL8SJlffK04VGdc8BHWQ==
X-Received: by 2002:aca:c5d2:: with SMTP id v201mr2056600oif.113.1548440244773;
        Fri, 25 Jan 2019 10:17:24 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l204sm1461179oia.54.2019.01.25.10.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:17:23 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/5] drivers/accel: ocxl: Move non-uapi include files
Date:   Fri, 25 Jan 2019 10:16:16 -0800
Message-Id: <20190125181616.62609-6-olof@lixom.net>
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
 MAINTAINERS                                 | 2 +-
 arch/powerpc/platforms/powernv/ocxl.c       | 2 +-
 drivers/accel/ocxl/config.c                 | 4 ++--
 drivers/accel/ocxl/link.c                   | 2 +-
 drivers/accel/ocxl/ocxl_internal.h          | 2 +-
 drivers/scsi/cxlflash/ocxl_hw.c             | 2 +-
 include/{misc => linux/accel}/ocxl-config.h | 6 +++---
 include/{misc => linux/accel}/ocxl.h        | 6 +++---
 8 files changed, 13 insertions(+), 13 deletions(-)
 rename include/{misc => linux/accel}/ocxl-config.h (94%)
 rename include/{misc => linux/accel}/ocxl.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1b2ba3bd402d..faa39da1445d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11013,7 +11013,7 @@ S:	Supported
 F:	arch/powerpc/platforms/powernv/ocxl.c
 F:	arch/powerpc/include/asm/pnv-ocxl.h
 F:	drivers/accel/ocxl/
-F:	include/misc/ocxl*
+F:	include/linux/accel/ocxl*
 F:	include/uapi/misc/ocxl.h
 F:	Documentation/accelerators/ocxl.rst
 
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 8c65aacda9c81..90e3a66c51dde 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -3,7 +3,7 @@
 #include <asm/pnv-ocxl.h>
 #include <asm/opal.h>
 #include <asm/xive.h>
-#include <misc/ocxl-config.h>
+#include <linux/accel/ocxl-config.h>
 #include "pci.h"
 
 #define PNV_OCXL_TL_P9_RECV_CAP		0x000000000000000Full
diff --git a/drivers/accel/ocxl/config.c b/drivers/accel/ocxl/config.c
index 8f2c5d8bd2eee..38351c6b28039 100644
--- a/drivers/accel/ocxl/config.c
+++ b/drivers/accel/ocxl/config.c
@@ -2,8 +2,8 @@
 // Copyright 2017 IBM Corp.
 #include <linux/pci.h>
 #include <asm/pnv-ocxl.h>
-#include <misc/ocxl.h>
-#include <misc/ocxl-config.h>
+#include <linux/accel/ocxl.h>
+#include <linux/accel/ocxl-config.h>
 
 #define EXTRACT_BIT(val, bit) (!!(val & BIT(bit)))
 #define EXTRACT_BITS(val, s, e) ((val & GENMASK(e, s)) >> s)
diff --git a/drivers/accel/ocxl/link.c b/drivers/accel/ocxl/link.c
index d50b861d7e57b..7c0550425a129 100644
--- a/drivers/accel/ocxl/link.c
+++ b/drivers/accel/ocxl/link.c
@@ -6,7 +6,7 @@
 #include <linux/mmu_context.h>
 #include <asm/copro.h>
 #include <asm/pnv-ocxl.h>
-#include <misc/ocxl.h>
+#include <linux/accel/ocxl.h>
 #include "ocxl_internal.h"
 #include "trace.h"
 
diff --git a/drivers/accel/ocxl/ocxl_internal.h b/drivers/accel/ocxl/ocxl_internal.h
index a32f2151029f6..4516390a8dbcb 100644
--- a/drivers/accel/ocxl/ocxl_internal.h
+++ b/drivers/accel/ocxl/ocxl_internal.h
@@ -6,7 +6,7 @@
 #include <linux/pci.h>
 #include <linux/cdev.h>
 #include <linux/list.h>
-#include <misc/ocxl.h>
+#include <linux/accel/ocxl.h>
 
 #define MAX_IRQ_PER_LINK	2000
 #define MAX_IRQ_PER_CONTEXT	MAX_IRQ_PER_LINK
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 37b8dc60f5f6d..7a62f78033b73 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -19,7 +19,7 @@
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 
-#include <misc/ocxl.h>
+#include <linux/accel/ocxl.h>
 
 #include <uapi/misc/cxl.h>
 
diff --git a/include/misc/ocxl-config.h b/include/linux/accel/ocxl-config.h
similarity index 94%
rename from include/misc/ocxl-config.h
rename to include/linux/accel/ocxl-config.h
index 3526fa996a220..4d25ed7b971f8 100644
--- a/include/misc/ocxl-config.h
+++ b/include/linux/accel/ocxl-config.h
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright 2017 IBM Corp.
-#ifndef _OCXL_CONFIG_H_
-#define _OCXL_CONFIG_H_
+#ifndef _LINUX_ACCEL_OCXL_CONFIG_H_
+#define _LINUX_ACCEL_OCXL_CONFIG_H_
 
 /*
  * This file lists the various constants used to read the
@@ -42,4 +42,4 @@
 #define   OCXL_DVSEC_VENDOR_TLX_VERS            0x10
 #define   OCXL_DVSEC_VENDOR_DLX_VERS            0x20
 
-#endif /* _OCXL_CONFIG_H_ */
+#endif /* _LINUX_ACCEL_OCXL_CONFIG_H_ */
diff --git a/include/misc/ocxl.h b/include/linux/accel/ocxl.h
similarity index 98%
rename from include/misc/ocxl.h
rename to include/linux/accel/ocxl.h
index 9ff6ddc28e221..1ab4c50700029 100644
--- a/include/misc/ocxl.h
+++ b/include/linux/accel/ocxl.h
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 // Copyright 2017 IBM Corp.
-#ifndef _MISC_OCXL_H_
-#define _MISC_OCXL_H_
+#ifndef _LINUX_ACCEL_OCXL_H_
+#define _LINUX_ACCEL_OCXL_H_
 
 #include <linux/pci.h>
 
@@ -220,4 +220,4 @@ extern int ocxl_link_irq_alloc(void *link_handle, int *hw_irq,
  */
 extern void ocxl_link_free_irq(void *link_handle, int hw_irq);
 
-#endif /* _MISC_OCXL_H_ */
+#endif /* _LINUX_ACCEL_OCXL_H_ */
-- 
2.11.0

