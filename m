Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8263C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA472145D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544757188;
	bh=JSnqW4EVNCLR8clO+ZtGh9AaHwHlbjePrfHlvSYS+c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lwxn/PnRHO/M22ucHHHElPdLP+L2imx+bNH5vkwKFS55lyRW2J8gp9EqR8AphZ0sC
	 3n5ZDGoqugZfxE1Q/r9q+iO0yRTJTDHc4JwAg0yOFQkXbo4sKsak9pqz/3MOQzqwIl
	 2mTX94rIwmT8uHm3eY8kl624DzUb95TtVkq8lbEI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA472145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeLNDNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:33240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727343AbeLNDNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:13:06 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [40.87.50.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D5420879;
        Fri, 14 Dec 2018 03:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544757185;
        bh=JSnqW4EVNCLR8clO+ZtGh9AaHwHlbjePrfHlvSYS+c0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgxI2I57ZOA8nG7+FgJBLezUL3B8SHMiXa+COh3VM3v8f/wJyqO2n/bjC53jxi16m
         ImPehyB4qKCnKDkM2kQ4erepdMPy8WhhdjtEL+5tabATC24is1lgNZ7q9UQY8b4pm8
         s+SAvOr1C0TpDsDTTHo1ntcrq0O+qOhbWHvUrSLs=
From:   Sinan Kaya <okaya@kernel.org>
To:     linux-acpi@vger.kernel.org
Cc:     Sinan Kaya <okaya@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anuj Mittal <anuj.mittal@intel.com>,
        devel@acpica.org (open list:ACPI COMPONENT ARCHITECTURE (ACPICA)),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v8 4/4] ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is unset
Date:   Fri, 14 Dec 2018 03:12:52 +0000
Message-Id: <20181214031252.28707-5-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181214031252.28707-1-okaya@kernel.org>
References: <20181214031252.28707-1-okaya@kernel.org>
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

