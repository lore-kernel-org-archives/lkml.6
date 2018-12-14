Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E34FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA67206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544805227;
	bh=JSnqW4EVNCLR8clO+ZtGh9AaHwHlbjePrfHlvSYS+c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TahHvlbQQkD+i5+QITzHvNPyJJxSyA7j7cMhDaYyzJoyjO9FO1Kb1sv9bjR82QxOJ
	 g+o/BkJi/MEI3S3t/SCs77Lde2nzqxHH6l5fAxAq+1+uTjjuH8xa/xuEa6b+QhQUar
	 CVcOaOXdnyL9xlvHo7+FmVtJt6MmUFv5zpvXShyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbeLNQdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbeLNQda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:33:30 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [23.96.30.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0942206C2;
        Fri, 14 Dec 2018 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544805210;
        bh=JSnqW4EVNCLR8clO+ZtGh9AaHwHlbjePrfHlvSYS+c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbFLoC31wyljnQlOL0hdIgQjejb6YbQeg9Fkcs1YB5Zo62MZrnHCS9/Zg7EvXbWBL
         frjrmEBKsm6I2cbbPKjanC5Ti6jMgcq9GTTCvTiBe/exits+ecrrWpuPyUxjd0/EDO
         +41AEt1F/sduB2dfDTodQWOr02tCYah1Olk7vpJY=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Lv Zheng <lv.zheng@intel.com>,
        Anuj Mittal <anuj.mittal@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 4/6] ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is unset
Date:   Fri, 14 Dec 2018 16:33:17 +0000
Message-Id: <20181214163319.27479-5-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181214163319.27479-1-okaya@kernel.org>
References: <20181214163319.27479-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we allow CONFIG_PCI to be unset, remove useless code from ACPICA
too.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/acpica/Makefile    | 2 +-
 drivers/acpi/acpica/achware.h   | 9 +++++++++
 include/acpi/platform/aclinux.h | 4 ++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index b14621da5413..59700433a96e 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -77,13 +77,13 @@ acpi-y +=		\
 	hwacpi.o	\
 	hwesleep.o	\
 	hwgpe.o		\
-	hwpci.o		\
 	hwregs.o	\
 	hwsleep.o	\
 	hwvalid.o	\
 	hwxface.o	\
 	hwxfsleep.o
 
+acpi-$(CONFIG_PCI) += hwpci.o
 acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
 acpi-y +=		\
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 43ce67a9da1f..ef99e2fc37f8 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -106,11 +106,20 @@ acpi_hw_enable_runtime_gpe_block(struct acpi_gpe_xrupt_info *gpe_xrupt_info,
 				 struct acpi_gpe_block_info *gpe_block,
 				 void *context);
 
+#ifdef ACPI_PCI_CONFIGURED
 /*
  * hwpci - PCI configuration support
  */
 acpi_status
 acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
 		      acpi_handle root_pci_device, acpi_handle pci_region);
+#else
+static inline acpi_status
+acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id, acpi_handle root_pci_device,
+		      acpi_handle pci_region)
+{
+	return AE_SUPPORT;
+}
+#endif
 
 #endif				/* __ACHWARE_H__ */
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 7451b3bca83a..e3d21d014fcc 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -33,6 +33,10 @@
 
 /* Kernel specific ACPICA configuration */
 
+#ifdef CONFIG_PCI
+#define ACPI_PCI_CONFIGURED
+#endif
+
 #ifdef CONFIG_ACPI_REDUCED_HARDWARE_ONLY
 #define ACPI_REDUCED_HARDWARE 1
 #endif
-- 
2.19.0

