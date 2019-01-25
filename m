Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F67C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11E6218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Dqw2ZGpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbfAYSRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:17:45 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46386 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfAYSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:17:20 -0500
Received: by mail-oi1-f193.google.com with SMTP id x202so8309631oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OilTxVa7pCTPGP5u3/v8c3UozhGw7Nvi5GHmzIN1Wnk=;
        b=Dqw2ZGpJDWYUQRAI7ZPXvZltAPmzhZFAy/8P4/ll5mhS3OD+xnyy1ZiIoF0DLarKxo
         mJrmy5FGNc2BiGVUSZirMBb9fb3sB5MBz0aMWZpfHHNtTGDohMT8BYvzPbB2JqvLQw6a
         x32bfdxP2EgY2b0oJwXZuUCT/CRoIrNbSWq8123N5EAlR9XZqPrKP4K22YJ3HUVKI5SQ
         8bnhq76V50uQwOEhjwsC/XyMUbhWbqiDk5kVeXIORmxUqayP0BLp9C5R+P9cOrRaRaYn
         VCGKR5+oP1kCzkck2FAm5VACHkYIwLTONdmY+2SBFoxpg4SR69eZPAcTUkab3fVQ8u/j
         NXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OilTxVa7pCTPGP5u3/v8c3UozhGw7Nvi5GHmzIN1Wnk=;
        b=m2yhxzZV7CMl2XEcyd4f7sIrmCFEvjlCDHDsqjyvR6ZM7fzongCZb5dCmUWG2PpeLM
         1Ql9AEQ/GDf76tTWTE0gbxBBUuguqIJ99sMvOABzgCJJb9K+/fTyxlKDooG3Agm36sf3
         eTF5EmfJ41Wgc8eC6czzR3b2hfVCAIDMELOTUyvU2ls++46NNtmz0BvasEvRvqbQfHEN
         oyQO/AJW0+FZI0Qjh+w24gn218JtnNgQK4W02JdW290nM6p9XCDw0JnCKf0b2gm15aH+
         eMzmt7E36+uhfWKYh19OQ3y5vEuOGSop1p3cFW3YB+NwKQmuoXLrUOyEkKnCvGdb6lTe
         UTqg==
X-Gm-Message-State: AJcUukeebyeH0lU6wzsG7DMJtTQ6dPdwDwbDwUQvGrG4NV6HRElZgFWf
        5/gSGcqMhygd+FvT5gTprMikixU+33s=
X-Google-Smtp-Source: ALg8bN5epIbd25iSQmKHBmED1yYRRlUEpc7hvimYAeX/TVb81X0yy6ADB6hAcTpfgouYxMB3kuJHrw==
X-Received: by 2002:a54:4713:: with SMTP id k19mr1887344oik.241.1548440238765;
        Fri, 25 Jan 2019 10:17:18 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l204sm1461179oia.54.2019.01.25.10.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:17:17 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/5] cxl: Move to drivers/accel
Date:   Fri, 25 Jan 2019 10:16:13 -0800
Message-Id: <20190125181616.62609-3-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190125181616.62609-1-olof@lixom.net>
References: <CAOesGMicf17+0x6AUCNrUYu=d4uREVCyH8F2JvUz5fN5+=jW_A@mail.gmail.com>
 <20190125181616.62609-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move include files in separate commit, so leave them alone for now.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
---
 MAINTAINERS                           | 2 +-
 drivers/accel/Kconfig                 | 2 ++
 drivers/accel/Makefile                | 1 +
 drivers/{misc => accel}/cxl/Kconfig   | 0
 drivers/{misc => accel}/cxl/Makefile  | 0
 drivers/{misc => accel}/cxl/api.c     | 0
 drivers/{misc => accel}/cxl/base.c    | 0
 drivers/{misc => accel}/cxl/context.c | 0
 drivers/{misc => accel}/cxl/cxl.h     | 0
 drivers/{misc => accel}/cxl/cxllib.c  | 0
 drivers/{misc => accel}/cxl/debugfs.c | 0
 drivers/{misc => accel}/cxl/fault.c   | 0
 drivers/{misc => accel}/cxl/file.c    | 0
 drivers/{misc => accel}/cxl/flash.c   | 0
 drivers/{misc => accel}/cxl/guest.c   | 0
 drivers/{misc => accel}/cxl/hcalls.c  | 0
 drivers/{misc => accel}/cxl/hcalls.h  | 0
 drivers/{misc => accel}/cxl/irq.c     | 0
 drivers/{misc => accel}/cxl/main.c    | 0
 drivers/{misc => accel}/cxl/native.c  | 0
 drivers/{misc => accel}/cxl/of.c      | 0
 drivers/{misc => accel}/cxl/pci.c     | 0
 drivers/{misc => accel}/cxl/sysfs.c   | 0
 drivers/{misc => accel}/cxl/trace.c   | 0
 drivers/{misc => accel}/cxl/trace.h   | 0
 drivers/{misc => accel}/cxl/vphb.c    | 0
 drivers/misc/Kconfig                  | 1 -
 drivers/misc/Makefile                 | 1 -
 28 files changed, 4 insertions(+), 3 deletions(-)
 rename drivers/{misc => accel}/cxl/Kconfig (100%)
 rename drivers/{misc => accel}/cxl/Makefile (100%)
 rename drivers/{misc => accel}/cxl/api.c (100%)
 rename drivers/{misc => accel}/cxl/base.c (100%)
 rename drivers/{misc => accel}/cxl/context.c (100%)
 rename drivers/{misc => accel}/cxl/cxl.h (100%)
 rename drivers/{misc => accel}/cxl/cxllib.c (100%)
 rename drivers/{misc => accel}/cxl/debugfs.c (100%)
 rename drivers/{misc => accel}/cxl/fault.c (100%)
 rename drivers/{misc => accel}/cxl/file.c (100%)
 rename drivers/{misc => accel}/cxl/flash.c (100%)
 rename drivers/{misc => accel}/cxl/guest.c (100%)
 rename drivers/{misc => accel}/cxl/hcalls.c (100%)
 rename drivers/{misc => accel}/cxl/hcalls.h (100%)
 rename drivers/{misc => accel}/cxl/irq.c (100%)
 rename drivers/{misc => accel}/cxl/main.c (100%)
 rename drivers/{misc => accel}/cxl/native.c (100%)
 rename drivers/{misc => accel}/cxl/of.c (100%)
 rename drivers/{misc => accel}/cxl/pci.c (100%)
 rename drivers/{misc => accel}/cxl/sysfs.c (100%)
 rename drivers/{misc => accel}/cxl/trace.c (100%)
 rename drivers/{misc => accel}/cxl/trace.h (100%)
 rename drivers/{misc => accel}/cxl/vphb.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a9bbaf8f6e90..93fbfed6e6915 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4214,7 +4214,7 @@ M:	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/pci-cxl.c
-F:	drivers/misc/cxl/
+F:	drivers/accel/cxl/
 F:	include/misc/cxl*
 F:	include/uapi/misc/cxl.h
 F:	Documentation/powerpc/cxl.txt
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index 13b36c0398895..c0754448efdf0 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -13,4 +13,6 @@ if ACCEL
 
 comment "HW Accellerator drivers"
 
+source "drivers/accel/cxl/Kconfig"
+
 endif
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 343bbb8f45a14..752a54e227ad7 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -3,3 +3,4 @@
 # Makefile for accel devices
 #
 
+obj-$(CONFIG_CXL_BASE)		+= cxl/
diff --git a/drivers/misc/cxl/Kconfig b/drivers/accel/cxl/Kconfig
similarity index 100%
rename from drivers/misc/cxl/Kconfig
rename to drivers/accel/cxl/Kconfig
diff --git a/drivers/misc/cxl/Makefile b/drivers/accel/cxl/Makefile
similarity index 100%
rename from drivers/misc/cxl/Makefile
rename to drivers/accel/cxl/Makefile
diff --git a/drivers/misc/cxl/api.c b/drivers/accel/cxl/api.c
similarity index 100%
rename from drivers/misc/cxl/api.c
rename to drivers/accel/cxl/api.c
diff --git a/drivers/misc/cxl/base.c b/drivers/accel/cxl/base.c
similarity index 100%
rename from drivers/misc/cxl/base.c
rename to drivers/accel/cxl/base.c
diff --git a/drivers/misc/cxl/context.c b/drivers/accel/cxl/context.c
similarity index 100%
rename from drivers/misc/cxl/context.c
rename to drivers/accel/cxl/context.c
diff --git a/drivers/misc/cxl/cxl.h b/drivers/accel/cxl/cxl.h
similarity index 100%
rename from drivers/misc/cxl/cxl.h
rename to drivers/accel/cxl/cxl.h
diff --git a/drivers/misc/cxl/cxllib.c b/drivers/accel/cxl/cxllib.c
similarity index 100%
rename from drivers/misc/cxl/cxllib.c
rename to drivers/accel/cxl/cxllib.c
diff --git a/drivers/misc/cxl/debugfs.c b/drivers/accel/cxl/debugfs.c
similarity index 100%
rename from drivers/misc/cxl/debugfs.c
rename to drivers/accel/cxl/debugfs.c
diff --git a/drivers/misc/cxl/fault.c b/drivers/accel/cxl/fault.c
similarity index 100%
rename from drivers/misc/cxl/fault.c
rename to drivers/accel/cxl/fault.c
diff --git a/drivers/misc/cxl/file.c b/drivers/accel/cxl/file.c
similarity index 100%
rename from drivers/misc/cxl/file.c
rename to drivers/accel/cxl/file.c
diff --git a/drivers/misc/cxl/flash.c b/drivers/accel/cxl/flash.c
similarity index 100%
rename from drivers/misc/cxl/flash.c
rename to drivers/accel/cxl/flash.c
diff --git a/drivers/misc/cxl/guest.c b/drivers/accel/cxl/guest.c
similarity index 100%
rename from drivers/misc/cxl/guest.c
rename to drivers/accel/cxl/guest.c
diff --git a/drivers/misc/cxl/hcalls.c b/drivers/accel/cxl/hcalls.c
similarity index 100%
rename from drivers/misc/cxl/hcalls.c
rename to drivers/accel/cxl/hcalls.c
diff --git a/drivers/misc/cxl/hcalls.h b/drivers/accel/cxl/hcalls.h
similarity index 100%
rename from drivers/misc/cxl/hcalls.h
rename to drivers/accel/cxl/hcalls.h
diff --git a/drivers/misc/cxl/irq.c b/drivers/accel/cxl/irq.c
similarity index 100%
rename from drivers/misc/cxl/irq.c
rename to drivers/accel/cxl/irq.c
diff --git a/drivers/misc/cxl/main.c b/drivers/accel/cxl/main.c
similarity index 100%
rename from drivers/misc/cxl/main.c
rename to drivers/accel/cxl/main.c
diff --git a/drivers/misc/cxl/native.c b/drivers/accel/cxl/native.c
similarity index 100%
rename from drivers/misc/cxl/native.c
rename to drivers/accel/cxl/native.c
diff --git a/drivers/misc/cxl/of.c b/drivers/accel/cxl/of.c
similarity index 100%
rename from drivers/misc/cxl/of.c
rename to drivers/accel/cxl/of.c
diff --git a/drivers/misc/cxl/pci.c b/drivers/accel/cxl/pci.c
similarity index 100%
rename from drivers/misc/cxl/pci.c
rename to drivers/accel/cxl/pci.c
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/accel/cxl/sysfs.c
similarity index 100%
rename from drivers/misc/cxl/sysfs.c
rename to drivers/accel/cxl/sysfs.c
diff --git a/drivers/misc/cxl/trace.c b/drivers/accel/cxl/trace.c
similarity index 100%
rename from drivers/misc/cxl/trace.c
rename to drivers/accel/cxl/trace.c
diff --git a/drivers/misc/cxl/trace.h b/drivers/accel/cxl/trace.h
similarity index 100%
rename from drivers/misc/cxl/trace.h
rename to drivers/accel/cxl/trace.h
diff --git a/drivers/misc/cxl/vphb.c b/drivers/accel/cxl/vphb.c
similarity index 100%
rename from drivers/misc/cxl/vphb.c
rename to drivers/accel/cxl/vphb.c
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f417b06e11c51..02153382d67b6 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -532,7 +532,6 @@ source "drivers/misc/vmw_vmci/Kconfig"
 source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
-source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e39ccbbc1b3a8..72fa4fc42a2d6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -52,7 +52,6 @@ obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
-obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
-- 
2.11.0

