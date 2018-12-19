Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83BEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816112133F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545259633;
	bh=lh3ime6PBx1LGRFhUtp9fUN2DkM0nBJ/Y0LOSlRd2uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zMVte0vKBc4Rq+JBhb0f78HHxY6J+aCtSf9vPFaPbgaF9GObucESMIqcBjqYgP6M6
	 FB8/GybVDI7mLkKiOE3bAJn0k9IcOBT3lYizP09+UChhEtxJyzIDN8wdCeOY/8+yHN
	 UfwXbad1beHGvFVFR35B/FUcCVcJL1FfeEvgUZg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeLSWrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728519AbeLSWrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:47:10 -0500
Received: from sinanubuntu1604.mkjiurmyylmellclgttazegk5f.bx.internal.cloudapp.net (unknown [13.90.192.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FAC20874;
        Wed, 19 Dec 2018 22:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545259630;
        bh=lh3ime6PBx1LGRFhUtp9fUN2DkM0nBJ/Y0LOSlRd2uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDRekvOuFIl2OPdOYiBsdOR85wdldugVd4Pxq10PNgG6FXUhUWXYtJhQDD6y5RcdY
         Rj2hTdw+JNGYRaghqTKoz/1LLqFqA7UTyXNZTp8oNc0xiwhbLd6R3XjDYhpKi8aqPY
         SCfftjThe4LAAWeSc8giIwr6+/AcVTCj3t2Qm0I8=
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
Subject: [PATCH v12 3/7] ACPICA: Remove PCI bits from ACPICA when CONFIG_PCI is unset
Date:   Wed, 19 Dec 2018 22:46:55 +0000
Message-Id: <20181219224659.4802-4-okaya@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow ACPI to be built without PCI support in place.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/acpica/Makefile    | 2 +-
 drivers/acpi/acpica/achware.h   | 9 +++++++++
 drivers/acpi/acpica/evhandler.c | 8 ++++----
 drivers/acpi/acpica/exregion.c  | 4 ++++
 drivers/acpi/osl.c              | 2 ++
 include/acpi/platform/aclinux.h | 4 ++++
 6 files changed, 24 insertions(+), 5 deletions(-)

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
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index d319ee33d040..4ed1e67db6be 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -364,25 +364,25 @@ acpi_ev_install_space_handler(struct acpi_namespace_node *node,
 			handler = acpi_ex_system_io_space_handler;
 			setup = acpi_ev_io_space_region_setup;
 			break;
-
+#ifdef ACPI_PCI_CONFIGURED
 		case ACPI_ADR_SPACE_PCI_CONFIG:
 
 			handler = acpi_ex_pci_config_space_handler;
 			setup = acpi_ev_pci_config_region_setup;
 			break;
-
+#endif
 		case ACPI_ADR_SPACE_CMOS:
 
 			handler = acpi_ex_cmos_space_handler;
 			setup = acpi_ev_cmos_region_setup;
 			break;
-
+#ifdef ACPI_PCI_CONFIGURED
 		case ACPI_ADR_SPACE_PCI_BAR_TARGET:
 
 			handler = acpi_ex_pci_bar_space_handler;
 			setup = acpi_ev_pci_bar_region_setup;
 			break;
-
+#endif
 		case ACPI_ADR_SPACE_DATA_TABLE:
 
 			handler = acpi_ex_data_table_space_handler;
diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 97bbfd07fcf7..2c58f5e00b1a 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -311,6 +311,7 @@ acpi_ex_system_io_space_handler(u32 function,
 	return_ACPI_STATUS(status);
 }
 
+#ifdef ACPI_PCI_CONFIGURED
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_pci_config_space_handler
@@ -387,6 +388,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 
 	return_ACPI_STATUS(status);
 }
+#endif
 
 /*******************************************************************************
  *
@@ -420,6 +422,7 @@ acpi_ex_cmos_space_handler(u32 function,
 	return_ACPI_STATUS(status);
 }
 
+#ifdef ACPI_PCI_CONFIGURED
 /*******************************************************************************
  *
  * FUNCTION:    acpi_ex_pci_bar_space_handler
@@ -451,6 +454,7 @@ acpi_ex_pci_bar_space_handler(u32 function,
 
 	return_ACPI_STATUS(status);
 }
+#endif
 
 /*******************************************************************************
  *
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index b48874b8e1ea..f29e427d0d1d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -769,6 +769,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 	return AE_OK;
 }
 
+#ifdef CONFIG_PCI
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 			       u64 *value, u32 width)
@@ -827,6 +828,7 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 
 	return (result ? AE_ERROR : AE_OK);
 }
+#endif
 
 static void acpi_os_execute_deferred(struct work_struct *work)
 {
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

