Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB846C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6293521537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVnG6CTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6293521537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeI0EGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:06:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39652 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725722AbeI0EFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:05:39 -0400
Received: by mail-oi1-f194.google.com with SMTP id y81-v6so443634oia.6;
        Wed, 26 Sep 2018 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/afg/UvmSkYHhmNxJ6kX9vCceUTJZfYsQZZUO95LAs=;
        b=oVnG6CTMcbE3T7P10xo3XXZ71GlkqCr5z3lgZNY84xaVw/KlZbFfRSmc8l9QCuAM0O
         EXIGTAHjsPDPZov04EWCxwVr+a9pD6IzIdr6P6dFz3Qbxwjdz7MZN2jDPrYdt5dXSGAc
         kn5meDMXGqYp024Li2+ODXeFkORqSsZQYyOiT5g1S+QwHsIum4SHFz294q3JDNbifvAv
         9iVicmlm7L4KFoez0f5kX6Nhed489BvSD37qLX4U1BUYlCEdLj+mVr/Bs6kVOYLc1llt
         6YU+NMHvG7UnAQKrCqH9NfnF8Stj9XL+ZwqYVMve0pDjLTm9EF6Yp0C2rZHiQMGis0ya
         7l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/afg/UvmSkYHhmNxJ6kX9vCceUTJZfYsQZZUO95LAs=;
        b=isbVAuPJwlLwWgUHJqWu8C4Io7EmD777p7zIJ+yc/jayOllK+7xns//vXWj3qKSq9T
         pm8sATknIEbIcXyMS0f6GWQL+rSOE2ObhdX0R/keeSATPBRM4U+QE0QsWJdpPQ0YpjuQ
         mpmDo7wr44bW0dFCJEWd5XRmdbOH/e63fGH7yHaK2j9WMF2EZRW9NtKWNy6H1KQECRSY
         RMCq5IRASf+yJ+Af8FZALu4QUTSx68dK6Rx+2XO6ygkGJjEUzHotvuRnUgfMmMgkxXCW
         Kuq4g+9p2QcnvHk/8S60xfH/l+zcOrHO870K+In71jwhl8wAIDLE5+bwQo/wVS775jrV
         bw2Q==
X-Gm-Message-State: ABuFfohK9MtsQugMLBK9VdCGJdvD3NwnltUdKgB8ymTkBwnFflGSQbSb
        csSrIo8x3P6T9igMrNzyIaY=
X-Google-Smtp-Source: ACcGV62mAFy2Gk53Y0XwXZydt+C/rmChJvJvcK3LngISq6XlQcxEgFRZlqXmpBY+TgjSbIhq0CNq5A==
X-Received: by 2002:aca:da54:: with SMTP id r81-v6mr1711518oig.47.1537998640081;
        Wed, 26 Sep 2018 14:50:40 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b124-v6sm95121oii.14.2018.09.26.14.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:50:39 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Doug Warzecha <Douglas_Warzecha@dell.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2 3/5] firmware: dell_rbu: Move dell_rbu to drivers/platform/x86
Date:   Wed, 26 Sep 2018 16:50:19 -0500
Message-Id: <20180926215021.30471-4-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
References: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move dell_rbu to the more appropriate directory drivers/platform/x86.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v2 changes:
 - add commit message

 drivers/firmware/Kconfig                      | 12 ------------
 drivers/firmware/Makefile                     |  1 -
 drivers/platform/x86/Kconfig                  | 12 ++++++++++++
 drivers/platform/x86/Makefile                 |  1 +
 drivers/{firmware => platform/x86}/dell_rbu.c |  0
 5 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/{firmware => platform/x86}/dell_rbu.c (100%)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6e83880046d7..02f39d20efce 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -145,18 +145,6 @@ config EFI_PCDP
 	  See DIG64_HCDPv20_042804.pdf available from
 	  <http://www.dig64.org/specifications/> 
 
-config DELL_RBU
-	tristate "BIOS update support for DELL systems via sysfs"
-	depends on X86
-	select FW_LOADER
-	select FW_LOADER_USER_HELPER
-	help
-	 Say m if you want to have the option of updating the BIOS for your
-	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
-	 supporting application to communicate with the BIOS regarding the new
-	 image for the image update to take effect.
-	 See <file:Documentation/dell_rbu.txt> for more details on the driver.
-
 config DCDBAS
 	tristate "Dell Systems Management Base Driver"
 	depends on X86
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index e18a041cfc53..61887ba9df1d 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_DMI)		+= dmi_scan.o
 obj-$(CONFIG_DMI_SYSFS)		+= dmi-sysfs.o
 obj-$(CONFIG_EDD)		+= edd.o
 obj-$(CONFIG_EFI_PCDP)		+= pcdp.o
-obj-$(CONFIG_DELL_RBU)          += dell_rbu.o
 obj-$(CONFIG_DCDBAS)		+= dcdbas.o
 obj-$(CONFIG_DMIID)		+= dmi-id.o
 obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0c1aa6c314f5..cb037da32107 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -227,6 +227,18 @@ config DELL_RBTN
 	  To compile this driver as a module, choose M here: the module will
 	  be called dell-rbtn.
 
+config DELL_RBU
+	tristate "BIOS update support for DELL systems via sysfs"
+	depends on X86
+	select FW_LOADER
+	select FW_LOADER_USER_HELPER
+	help
+	 Say m if you want to have the option of updating the BIOS for your
+	 DELL system. Note you need a Dell OpenManage or Dell Update package (DUP)
+	 supporting application to communicate with the BIOS regarding the new
+	 image for the image update to take effect.
+	 See <file:Documentation/dell_rbu.txt> for more details on the driver.
+
 
 config FUJITSU_LAPTOP
 	tristate "Fujitsu Laptop Extras"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index e6d1becf81ce..8843f8e22127 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_DELL_WMI_AIO)	+= dell-wmi-aio.o
 obj-$(CONFIG_DELL_WMI_LED)	+= dell-wmi-led.o
 obj-$(CONFIG_DELL_SMO8800)	+= dell-smo8800.o
 obj-$(CONFIG_DELL_RBTN)		+= dell-rbtn.o
+obj-$(CONFIG_DELL_RBU)          += dell_rbu.o
 obj-$(CONFIG_ACER_WMI)		+= acer-wmi.o
 obj-$(CONFIG_ACER_WIRELESS)	+= acer-wireless.o
 obj-$(CONFIG_ACERHDF)		+= acerhdf.o
diff --git a/drivers/firmware/dell_rbu.c b/drivers/platform/x86/dell_rbu.c
similarity index 100%
rename from drivers/firmware/dell_rbu.c
rename to drivers/platform/x86/dell_rbu.c
-- 
2.19.0

