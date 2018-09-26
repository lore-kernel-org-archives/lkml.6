Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA7AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FD021537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI/yIXtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FD021537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbeI0EFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:05:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46795 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbeI0EFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:05:41 -0400
Received: by mail-ot1-f68.google.com with SMTP id q4-v6so477756otf.13;
        Wed, 26 Sep 2018 14:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18Kwi0sqkWczbQrbhRMMYhOayhXo11zmj1XWOIKCBZo=;
        b=RI/yIXtU0cBh0KgaVa3vNPDzIYiVp/XoejYaLuc3/ohDchfwSA4/YwGu20qNiD7S1b
         xF0c3V92WaBf337exwK8BZpTjSiKSbTN7yRcEWHBLKPSrheR2UPBrwM2pcZvMvPkrspk
         pPHUoMTT6y8p4LB+mHtZzw9X9SC0T7wR0OOQv/hHpxVMKioehp35ZbDBerwSi4wxBF1s
         EhI0JQl+Pw2I4O2PRGJEsdaDqN3/aWD+w5G9afIuylApIO32+CEgP7r0mfT5kmI0gWJB
         r1cCg3Z/efzqcej+M2q7PBFLhSZCl+fMBHZfpJnLgqEjP+oUcMIP+O1XfFTSQ12M+OME
         A5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=18Kwi0sqkWczbQrbhRMMYhOayhXo11zmj1XWOIKCBZo=;
        b=YRTLQSRM8zsb6CYo9+2Hlejdrp2CveanPSXRy9FSe7tImadXLl1lR8k9XVWgcaypXQ
         XcrNnOU3CX9gZPAdfIDNwXjGDpKgvT7au2LFArxwBgxmfVt0C0o4qWkn4nAenldXaCls
         snl3BKYXBrupEKMgE4OOBfuoiMXtLDmaw1aOrG25TIiu/9ncWPx0SVOsx9y3KICECOoz
         2O0i6Ii+ZWAhoZYVYvsHMjASenookUOFK40e/kSE2zipMNTb2F/Ii1I1KAiiYE4Fz7b4
         LjPsnEtpP+Lbfutt50DqbQN+6EWzCzeMjZPeqiSJ2gnB22GregcR26YKZbXe0rXSntRB
         sI/w==
X-Gm-Message-State: ABuFfojIdfvklhEyP5yLj6KVcSILCVD680Il27Q2HbHNkJad9n8ofQxP
        bbcT1k4B4cme7mxC/KACXF4=
X-Google-Smtp-Source: ACcGV60RgaBUGVsAaDMPEZ7/k7VbhbF6jhki/GLNEMtdwuwEKek32cvCWz+VpdyoZsW4WUX9Tkt8dQ==
X-Received: by 2002:a9d:3d22:: with SMTP id a31-v6mr5149676otc.326.1537998641566;
        Wed, 26 Sep 2018 14:50:41 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b124-v6sm95121oii.14.2018.09.26.14.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:50:40 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Doug Warzecha <Douglas_Warzecha@dell.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2 4/5] firmware: dcdbas: Move dcdbas to drivers/platform/x86
Date:   Wed, 26 Sep 2018 16:50:20 -0500
Message-Id: <20180926215021.30471-5-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
References: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move dcdbas to the more appropriate directory drivers/platform/x86.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v2 changes:
 - add commit message

 drivers/firmware/Kconfig                    | 16 ----------------
 drivers/firmware/Makefile                   |  1 -
 drivers/platform/x86/Kconfig                | 16 ++++++++++++++++
 drivers/platform/x86/Makefile               |  1 +
 drivers/{firmware => platform/x86}/dcdbas.c |  0
 drivers/{firmware => platform/x86}/dcdbas.h |  0
 drivers/platform/x86/dell-smbios-smm.c      |  2 +-
 7 files changed, 18 insertions(+), 18 deletions(-)
 rename drivers/{firmware => platform/x86}/dcdbas.c (100%)
 rename drivers/{firmware => platform/x86}/dcdbas.h (100%)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 02f39d20efce..6d0c28fd3bad 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -145,22 +145,6 @@ config EFI_PCDP
 	  See DIG64_HCDPv20_042804.pdf available from
 	  <http://www.dig64.org/specifications/> 
 
-config DCDBAS
-	tristate "Dell Systems Management Base Driver"
-	depends on X86
-	help
-	  The Dell Systems Management Base Driver provides a sysfs interface
-	  for systems management software to perform System Management
-	  Interrupts (SMIs) and Host Control Actions (system power cycle or
-	  power off after OS shutdown) on certain Dell systems.
-
-	  See <file:Documentation/dcdbas.txt> for more details on the driver
-	  and the Dell systems on which Dell systems management software makes
-	  use of this driver.
-
-	  Say Y or M here to enable the driver for use by Dell systems
-	  management software such as Dell OpenManage.
-
 config DMIID
     bool "Export DMI identification via sysfs to userspace"
     depends on DMI
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 61887ba9df1d..edda4206d8fc 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_DMI)		+= dmi_scan.o
 obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
 obj-$(CONFIG_EDD)		+= edd.o
 obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
-obj-$(CONFIG_DCDBAS)		+= dcdbas.o
 obj-$(CONFIG_DMIID)		+= dmi-id.o
 obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index cb037da32107..1c7e553c28ce 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -105,6 +105,22 @@ config ASUS_LAPTOP
 
 	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
 
+config DCDBAS
+	tristate "Dell Systems Management Base Driver"
+	depends on X86
+	help
+	  The Dell Systems Management Base Driver provides a sysfs interface
+	  for systems management software to perform System Management
+	  Interrupts (SMIs) and Host Control Actions (system power cycle or
+	  power off after OS shutdown) on certain Dell systems.
+
+	  See <file:Documentation/dcdbas.txt> for more details on the driver
+	  and the Dell systems on which Dell systems management software makes
+	  use of this driver.
+
+	  Say Y or M here to enable the driver for use by Dell systems
+	  management software such as Dell OpenManage.
+
 #
 # The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those
 # backends are selected. The "depends" line prevents a configuration
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 8843f8e22127..4e2712c9c0b0 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_ACPI_CMPC)		+= classmate-laptop.o
 obj-$(CONFIG_COMPAL_LAPTOP)	+= compal-laptop.o
+obj-$(CONFIG_DCDBAS)		+= dcdbas.o
 obj-$(CONFIG_DELL_SMBIOS)	+= dell-smbios.o
 dell-smbios-objs		:= dell-smbios-base.o
 dell-smbios-$(CONFIG_DELL_SMBIOS_WMI)	+= dell-smbios-wmi.o
diff --git a/drivers/firmware/dcdbas.c b/drivers/platform/x86/dcdbas.c
similarity index 100%
rename from drivers/firmware/dcdbas.c
rename to drivers/platform/x86/dcdbas.c
diff --git a/drivers/firmware/dcdbas.h b/drivers/platform/x86/dcdbas.h
similarity index 100%
rename from drivers/firmware/dcdbas.h
rename to drivers/platform/x86/dcdbas.h
diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell-smbios-smm.c
index 97a90bebc360..ab9b822a6dfe 100644
--- a/drivers/platform/x86/dell-smbios-smm.c
+++ b/drivers/platform/x86/dell-smbios-smm.c
@@ -18,7 +18,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
-#include "../../firmware/dcdbas.h"
+#include "dcdbas.h"
 #include "dell-smbios.h"
 
 static int da_command_address;
-- 
2.19.0

