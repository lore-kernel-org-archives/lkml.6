Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31387C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E864E218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zf7gEdNS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbfAYSR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:17:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41622 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729304AbfAYSRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:17:24 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so9352665otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=91hEWPHOUR4b8r3kbZvhORrCjDdjZqvBF52TfokpC9Y=;
        b=zf7gEdNSLMbz1xlaNhuiAvmWLbyPoCp1GNSp7MKkcfP4lEk4g/WpyuwLPmzZ5fBXaR
         Fv80aJUngmZn7s11VcloRwLX8SPmluiZ0DmnJQ3YqtUfaUxIym6t6i8gQiJFORZvoD4f
         vmu0viINkyd44NLylUIt7b8YvFb9F1BmN5fKjojfx1lk09scRHmbI88yvGlewMPnUWQi
         4XOk3kZY40wNQD70O2jlCSeoARo8LHbEbMAAUPEQYI6fvCHrKqLe/iVfVO98odaZH82H
         MVbOHJ0boe3W5TIT+kWWlvJxQb6rqcwOpqxkqxAJT0S/dMsX7NjLYi5Z9ycdNMc1EJO5
         yKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=91hEWPHOUR4b8r3kbZvhORrCjDdjZqvBF52TfokpC9Y=;
        b=kJHKVpt4izUyGZG94LdKQt3R/XNqOoxKCOsJR5L/ZNZBPJvEgDvxX1LrJmAggr0CZs
         toLfv4VRNrjrzOvAhNC929o0WHikyKIPqer3YESGZxCQ2FrLJuh5NQ1HVygvgnQZh6VN
         3Yx6U13KCp4sXuqjC4mnLNbsr7KhbhHreY5dgZvaYOfwlfZq34wCd2CgxRfyQrvn7BMp
         kUoKC6FWvPVZ6tybetgz/U4HONXVr1W0vqFqZDTFBocHR6x7fcp6R6m6n2LhlQngrNvX
         tPEO0TC8QeNSgaCuybZ6iuCNNocwIHqXi6DA1nBqDI2e3gv9bgB+UeqF0yacfXGptXCw
         EQuw==
X-Gm-Message-State: AJcUukdhLza3mPJOYBfW7ogRaPA4j9/jrFOZjAgjPArU31XtC0Y/5LtN
        rAbmS9BZ6F6cvKmdQg4UqYbpw5qQSwI=
X-Google-Smtp-Source: ALg8bN768j9qFmnubbQeL3h9ERRcdXpVAs7Zb9nm9v7vO2w/EDy+KXIdAfoHPYCjffghf+Pe8NR1RQ==
X-Received: by 2002:a9d:664f:: with SMTP id q15mr9347305otm.282.1548440242725;
        Fri, 25 Jan 2019 10:17:22 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id l204sm1461179oia.54.2019.01.25.10.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 10:17:21 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4/5] ocxl: Move to drivers/accel
Date:   Fri, 25 Jan 2019 10:16:15 -0800
Message-Id: <20190125181616.62609-5-olof@lixom.net>
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
 MAINTAINERS                                  | 2 +-
 drivers/accel/Kconfig                        | 1 +
 drivers/accel/Makefile                       | 1 +
 drivers/{misc => accel}/ocxl/Kconfig         | 0
 drivers/{misc => accel}/ocxl/Makefile        | 0
 drivers/{misc => accel}/ocxl/afu_irq.c       | 0
 drivers/{misc => accel}/ocxl/config.c        | 0
 drivers/{misc => accel}/ocxl/context.c       | 0
 drivers/{misc => accel}/ocxl/file.c          | 0
 drivers/{misc => accel}/ocxl/link.c          | 0
 drivers/{misc => accel}/ocxl/main.c          | 0
 drivers/{misc => accel}/ocxl/ocxl_internal.h | 0
 drivers/{misc => accel}/ocxl/pasid.c         | 0
 drivers/{misc => accel}/ocxl/pci.c           | 0
 drivers/{misc => accel}/ocxl/sysfs.c         | 0
 drivers/{misc => accel}/ocxl/trace.c         | 0
 drivers/{misc => accel}/ocxl/trace.h         | 0
 drivers/misc/Kconfig                         | 1 -
 drivers/misc/Makefile                        | 1 -
 19 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/{misc => accel}/ocxl/Kconfig (100%)
 rename drivers/{misc => accel}/ocxl/Makefile (100%)
 rename drivers/{misc => accel}/ocxl/afu_irq.c (100%)
 rename drivers/{misc => accel}/ocxl/config.c (100%)
 rename drivers/{misc => accel}/ocxl/context.c (100%)
 rename drivers/{misc => accel}/ocxl/file.c (100%)
 rename drivers/{misc => accel}/ocxl/link.c (100%)
 rename drivers/{misc => accel}/ocxl/main.c (100%)
 rename drivers/{misc => accel}/ocxl/ocxl_internal.h (100%)
 rename drivers/{misc => accel}/ocxl/pasid.c (100%)
 rename drivers/{misc => accel}/ocxl/pci.c (100%)
 rename drivers/{misc => accel}/ocxl/sysfs.c (100%)
 rename drivers/{misc => accel}/ocxl/trace.c (100%)
 rename drivers/{misc => accel}/ocxl/trace.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97aed390129f0..a1b2ba3bd402d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11012,7 +11012,7 @@ L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	arch/powerpc/platforms/powernv/ocxl.c
 F:	arch/powerpc/include/asm/pnv-ocxl.h
-F:	drivers/misc/ocxl/
+F:	drivers/accel/ocxl/
 F:	include/misc/ocxl*
 F:	include/uapi/misc/ocxl.h
 F:	Documentation/accelerators/ocxl.rst
diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
index c0754448efdf0..1790630c560e6 100644
--- a/drivers/accel/Kconfig
+++ b/drivers/accel/Kconfig
@@ -14,5 +14,6 @@ if ACCEL
 comment "HW Accellerator drivers"
 
 source "drivers/accel/cxl/Kconfig"
+source "drivers/accel/ocxl/Kconfig"
 
 endif
diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 752a54e227ad7..313867582ff5a 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_OCXL)		+= ocxl/
diff --git a/drivers/misc/ocxl/Kconfig b/drivers/accel/ocxl/Kconfig
similarity index 100%
rename from drivers/misc/ocxl/Kconfig
rename to drivers/accel/ocxl/Kconfig
diff --git a/drivers/misc/ocxl/Makefile b/drivers/accel/ocxl/Makefile
similarity index 100%
rename from drivers/misc/ocxl/Makefile
rename to drivers/accel/ocxl/Makefile
diff --git a/drivers/misc/ocxl/afu_irq.c b/drivers/accel/ocxl/afu_irq.c
similarity index 100%
rename from drivers/misc/ocxl/afu_irq.c
rename to drivers/accel/ocxl/afu_irq.c
diff --git a/drivers/misc/ocxl/config.c b/drivers/accel/ocxl/config.c
similarity index 100%
rename from drivers/misc/ocxl/config.c
rename to drivers/accel/ocxl/config.c
diff --git a/drivers/misc/ocxl/context.c b/drivers/accel/ocxl/context.c
similarity index 100%
rename from drivers/misc/ocxl/context.c
rename to drivers/accel/ocxl/context.c
diff --git a/drivers/misc/ocxl/file.c b/drivers/accel/ocxl/file.c
similarity index 100%
rename from drivers/misc/ocxl/file.c
rename to drivers/accel/ocxl/file.c
diff --git a/drivers/misc/ocxl/link.c b/drivers/accel/ocxl/link.c
similarity index 100%
rename from drivers/misc/ocxl/link.c
rename to drivers/accel/ocxl/link.c
diff --git a/drivers/misc/ocxl/main.c b/drivers/accel/ocxl/main.c
similarity index 100%
rename from drivers/misc/ocxl/main.c
rename to drivers/accel/ocxl/main.c
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/accel/ocxl/ocxl_internal.h
similarity index 100%
rename from drivers/misc/ocxl/ocxl_internal.h
rename to drivers/accel/ocxl/ocxl_internal.h
diff --git a/drivers/misc/ocxl/pasid.c b/drivers/accel/ocxl/pasid.c
similarity index 100%
rename from drivers/misc/ocxl/pasid.c
rename to drivers/accel/ocxl/pasid.c
diff --git a/drivers/misc/ocxl/pci.c b/drivers/accel/ocxl/pci.c
similarity index 100%
rename from drivers/misc/ocxl/pci.c
rename to drivers/accel/ocxl/pci.c
diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/accel/ocxl/sysfs.c
similarity index 100%
rename from drivers/misc/ocxl/sysfs.c
rename to drivers/accel/ocxl/sysfs.c
diff --git a/drivers/misc/ocxl/trace.c b/drivers/accel/ocxl/trace.c
similarity index 100%
rename from drivers/misc/ocxl/trace.c
rename to drivers/accel/ocxl/trace.c
diff --git a/drivers/misc/ocxl/trace.h b/drivers/accel/ocxl/trace.h
similarity index 100%
rename from drivers/misc/ocxl/trace.h
rename to drivers/accel/ocxl/trace.h
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 02153382d67b6..35c11005a5150 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -532,6 +532,5 @@ source "drivers/misc/vmw_vmci/Kconfig"
 source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
 source "drivers/misc/echo/Kconfig"
-source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 72fa4fc42a2d6..2ee4eeb573b58 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -55,6 +55,5 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_ASPEED_LPC_CTRL)	+= aspeed-lpc-ctrl.o
 obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
-obj-$(CONFIG_OCXL)		+= ocxl/
 obj-y				+= cardreader/
 obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
-- 
2.11.0

