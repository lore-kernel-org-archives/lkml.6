Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999F9C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAE52086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npvXCnsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAE52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeIZBnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:43:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34356 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeIZBnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:43:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id i12-v6so25727296otl.1;
        Tue, 25 Sep 2018 12:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VSM+YL8RaEYyPZTMSdhDEWOLDLlw1tPrWKUMYSMgQo=;
        b=npvXCnsRUt8QtVH3N+hzfy/L20DAtXrjM9E37OluzSLcD7FN2WQ/gURZuyonMnePio
         8p0cv+QMxIq46uRoE9hB4ldW1xK3r2mBx2bB7+Jw13T4p7Ynr9Yd7YWZ0Mj7OLtzTufs
         RDYuDjyO2yRdPgQ0eVM9Nx77kSb8pk2cdOP31nQMalTPjnJq1+WHSwZR81leOQU2O9W3
         Tsse1xG6JZxz1w6FXMw2z1C63TAGF7T5wCi9K6SSWZWw0F0/bDLBGVqVN8GYmVGLxzp4
         /z1xtB6eEhcFWbyWdUqg89NI/GRbr1mCj2goU+E+EbTKticSRBx/UMxpDXLITd38uT1D
         o2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VSM+YL8RaEYyPZTMSdhDEWOLDLlw1tPrWKUMYSMgQo=;
        b=NmBU/Goa4dWChxqdkCtZmMb5bzSRSudmv9DiFGimD8wanbFSq1cKOkmJdzChC4Kv1p
         lPRO73UZvFodiHKk6/yVi/UmceRIfWuq3YZ2SvjG42w1/kw022pIOYS6cna035IwW2At
         HN9shzKOMDY+X+EWSbv/SilWv9g8pFs0LXr2zsJtRIGWRGwK+KOzgzNjoxdz7HcA5O2p
         Oq3t70HPBZshn6TEM7bRTynUPAsfr/iZWSXlfsnG3JBrfCsWlhj0rtljzknku5fIBaQF
         V8tAlVLTC5uhakZZzR6UOHuGI6scfzT9ylKqY2x9HbsP63H6zxNfoA0Fo0ZDppp+s2Ht
         PdjA==
X-Gm-Message-State: ABuFfognNLxVOlp9HB60Bp3UmJ06CWlnSdjZNg1OGqheR4ng+wJSrCm9
        BhLDkQgFvm5zxcIepw+Lgcc=
X-Google-Smtp-Source: ACcGV612fR+aLsHT2/+TZO2qGtzuJLpf7VPJQzijrDARHO3EpIevRMkOY4mPK+J+JRXvLVepNGVogg==
X-Received: by 2002:a9d:29fd:: with SMTP id g58-v6mr1746320otd.390.1537904074553;
        Tue, 25 Sep 2018 12:34:34 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1049193otl.43.2018.09.25.12.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:34:33 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
X-Google-Original-From: Stuart Hayes <stuart.hayes@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH 3/5] firmware: dell_rbu: Move dell_rbu to drivers/platform/x86
Date:   Tue, 25 Sep 2018 14:34:16 -0500
Message-Id: <20180925193418.28493-4-stuart.hayes@dell.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925193418.28493-1-stuart.hayes@dell.com>
References: <20180925193418.28493-1-stuart.hayes@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayes <stuart.w.hayes@gmail.com>

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
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
2.19.0.221.g150f307af

