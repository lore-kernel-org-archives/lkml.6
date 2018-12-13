Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD18AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCA820870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV5wX1Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DCA820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbeLMT3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:29:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39926 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMT3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:29:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1515537pld.6;
        Thu, 13 Dec 2018 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T467ZZbTZR3q+VQqhmMxHAbmSK9ER2R7ds/efM85/YM=;
        b=NV5wX1TvhKiqXN8y1aw2ZUEGGvoQJPpvPxtaa5UhvWiF7S+n1N/y+pvJ52Rzq2aixX
         iwdTOO/6KAwfwQZCNFZFzd6+rT8S2jAgpJfp/qrC/4d9OU9sKhL1CdQVUGPXzjk3sTvp
         asoFtVFYEeGVCKtqTePstJDKTOsTmyr5y1JjfthFMne9cHzgwzB4takZtRe1vaBJZfL+
         jiKFF7o54IFgSl3nL8rykD/nIYxpUQQGwsT5zXly1SqVdmHafv/rmjvs0vDFoHDg3Edu
         y7j6w+rm2XDtLa4j5gbESV+lqQlH6BFtORgmtiRb83RlJ50D5QnaZ0NCJ9Z/KcMPtHel
         Td2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T467ZZbTZR3q+VQqhmMxHAbmSK9ER2R7ds/efM85/YM=;
        b=IzBQSZohmB0+/RySmNHsTL5GTO15kMD2xY2zflzh4sUmmui4DwBgfIzRcIM+/HlTDs
         IazrfpDJN8dvgl7SpS9e7Z9dWx563reyy0jyCdziMQQBviALqY4h6UT32muEpmEL3nw0
         3CThbxlpfQWOlOju3FbfdRcZJM31+PZpckFqJlHKMIV4THx7iZXr0ZsfhZTLX9xM5m5T
         L+TSSKEH8DAmlyRQUFhiXgnTIdOIpB392WWV9IRF9tRnWmcw2yJ75iDpNvXP4Z4MgfUQ
         5jpmef/FlpgR0pajYvVfIfAUgQBvQXpB/CTcehpDiLaq7njBSKxl0AuFZAeACAKrYONJ
         sOKg==
X-Gm-Message-State: AA+aEWbLqaVKVIeblhXbwPOgfVoyIzrfD8tTmDP3vAWjFDtRWbrBrMrp
        uBbQEHWnJYW3/FnC3pkJ5KnXPI2ZpEo=
X-Google-Smtp-Source: AFSGD/XaraydAbuALmOww5RFfEc9PZ5/LnvB1U+Up5pdNMlvqYwQ0ukhhJ/0CD/8GHS76GFtrRNsSA==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr40632plr.207.1544729389245;
        Thu, 13 Dec 2018 11:29:49 -0800 (PST)
Received: from dev-aglagolev.dev.purestorage.com ([192.30.188.252])
        by smtp.googlemail.com with ESMTPSA id x3sm9383221pgt.45.2018.12.13.11.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 11:29:48 -0800 (PST)
From:   Anatoliy Glagolev <glagolig@gmail.com>
To:     qla2xxx-upstream@qlogic.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@linux.vnet.ibm.com,
        kmahlkuc@linux.vnet.ibm.com, benh@au1.ibm.com,
        aglagolev@purestorage.com
Cc:     Anatoliy Glagolev <glagolig@gmail.com>
Subject: [PATCH v2] scsi: qla2xxx: pci error handler sync
Date:   Thu, 13 Dec 2018 12:29:08 -0700
Message-Id: <1544729348-7286-1-git-send-email-glagolig@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544212602-28085-1-git-send-email-glagolig@gmail.com>
References: <1544212602-28085-1-git-send-email-glagolig@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qla2x00_disable_board_on_pci_error and PCI error handlers may run
in parallel. Specifically, I observed qla2xxx_pci_slot_reset running
at around the same moment as qla2x00_disable_board_on_pci_error.
If scsi_qla_host_t or qla_hw_data structs are removed before an error
handler completes, the handler crashes.

This patch provides syncronization of paths deleting PCI device
specific structs and PCI error handlers, so that the handlers
always run race-free.

Under the most generic assumptions about the PCI error handling
the handlers may run at any moment between pci_register_driver
and pci_unregister_driver. Then we have to maintain per-pci_dev
context with the state of in-flight handlers and the driver
structures associated with pci_dev. The contet outlives both
the structs and the pci_dev.

Signed-off-by: Anatoliy Glagolev <glagolig@gmail.com>
---
 drivers/scsi/qla2xxx/Makefile                |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                | 117 +++++++++++----
 drivers/scsi/qla2xxx/qla_pci_error_handler.c | 212 +++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_pci_error_handler.h |  46 ++++++
 4 files changed, 352 insertions(+), 26 deletions(-)
 create mode 100644 drivers/scsi/qla2xxx/qla_pci_error_handler.c
 create mode 100644 drivers/scsi/qla2xxx/qla_pci_error_handler.h

diff --git a/drivers/scsi/qla2xxx/Makefile b/drivers/scsi/qla2xxx/Makefile
index 17d5bc1..04f41d6 100644
--- a/drivers/scsi/qla2xxx/Makefile
+++ b/drivers/scsi/qla2xxx/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 qla2xxx-y := qla_os.o qla_init.o qla_mbx.o qla_iocb.o qla_isr.o qla_gs.o \
 		qla_dbg.o qla_sup.o qla_attr.o qla_mid.o qla_dfs.o qla_bsg.o \
-		qla_nx.o qla_mr.o qla_nx2.o qla_target.o qla_tmpl.o qla_nvme.o
+		qla_nx.o qla_mr.o qla_nx2.o qla_target.o qla_tmpl.o qla_nvme.o \
+		qla_pci_error_handler.o
 
 obj-$(CONFIG_SCSI_QLA_FC) += qla2xxx.o
 obj-$(CONFIG_TCM_QLA2XXX) += tcm_qla2xxx.o
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index e881fce..37ee188 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -20,6 +20,7 @@
 #include <scsi/scsi_transport_fc.h>
 
 #include "qla_target.h"
+#include "qla_pci_error_handler.h"
 
 /*
  * Driver version
@@ -2775,9 +2776,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 			return ret;
 	}
 
-	/* This may fail but that's ok */
-	pci_enable_pcie_error_reporting(pdev);
-
 	ha = kzalloc(sizeof(struct qla_hw_data), GFP_KERNEL);
 	if (!ha) {
 		ql_log_pci(ql_log_fatal, pdev, 0x0009,
@@ -3091,6 +3089,14 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	    host->max_cmd_len, host->max_channel, host->max_lun,
 	    host->transportt, sht->vendor_id);
 
+	/* This may fail but that's ok */
+	ret = qla_enable_pci_error_handler(pdev);
+	if (ret) {
+		ql_log_pci(ql_log_fatal, pdev, 0x0031,
+			"qla_enable_pci_error_handler failed\n");
+		ret = 0;
+	}
+
 	INIT_WORK(&base_vha->iocb_work, qla2x00_iocb_work_fn);
 
 	/* Set up the irqs */
@@ -3400,6 +3406,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 		kthread_stop(t);
 	}
 
+	qla_disable_pci_error_handler(pdev);
+
 	qla2x00_free_device(base_vha);
 	scsi_host_put(base_vha->host);
 	/*
@@ -3625,6 +3633,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	}
 	qla2x00_wait_for_hba_ready(base_vha);
 
+	qla_disable_pci_error_handler(pdev);
+
 	qla2x00_wait_for_sess_deletion(base_vha);
 
 	/*
@@ -3698,8 +3708,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	pci_release_selected_regions(ha->pdev, ha->bars);
 	kfree(ha);
 
-	pci_disable_pcie_error_reporting(pdev);
-
 	pci_disable_device(pdev);
 }
 
@@ -5826,6 +5834,8 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
 		return;
 	}
 
+	qla_disable_pci_error_handler(pdev);
+
 	qla2x00_wait_for_sess_deletion(base_vha);
 
 	set_bit(UNLOADING, &base_vha->dpc_flags);
@@ -5866,7 +5876,6 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
 	qla2x00_unmap_iobases(ha);
 
 	pci_release_selected_regions(ha->pdev, ha->bars);
-	pci_disable_pcie_error_reporting(pdev);
 	pci_disable_device(pdev);
 
 	/*
@@ -6543,8 +6552,15 @@ struct fw_blob *
 static pci_ers_result_t
 qla2xxx_pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
 {
-	scsi_qla_host_t *vha = pci_get_drvdata(pdev);
-	struct qla_hw_data *ha = vha->hw;
+	scsi_qla_host_t *vha;
+	struct qla_hw_data *ha;
+	pci_ers_result_t ret = PCI_ERS_RESULT_DISCONNECT;
+
+	if (qla_on_pci_error_handler_entry(pdev) != 0)
+		return ret;
+
+	vha = pci_get_drvdata(pdev);
+	ha = vha->hw;
 
 	ql_dbg(ql_dbg_aer, vha, 0x9000,
 	    "PCI error detected, state %x.\n", state);
@@ -6552,7 +6568,8 @@ struct fw_blob *
 	if (!atomic_read(&pdev->enable_cnt)) {
 		ql_log(ql_log_info, vha, 0xffff,
 			"PCI device is disabled,state %x\n", state);
-		return PCI_ERS_RESULT_NEED_RESET;
+		ret = PCI_ERS_RESULT_NEED_RESET;
+		goto exit_error_detected;
 	}
 
 	switch (state) {
@@ -6562,7 +6579,8 @@ struct fw_blob *
 			set_bit(QPAIR_ONLINE_CHECK_NEEDED, &vha->dpc_flags);
 			qla2xxx_wake_dpc(vha);
 		}
-		return PCI_ERS_RESULT_CAN_RECOVER;
+		ret = PCI_ERS_RESULT_CAN_RECOVER;
+		break;
 	case pci_channel_io_frozen:
 		ha->flags.eeh_busy = 1;
 		/* For ISP82XX complete any pending mailbox cmd */
@@ -6579,7 +6597,8 @@ struct fw_blob *
 			set_bit(QPAIR_ONLINE_CHECK_NEEDED, &vha->dpc_flags);
 			qla2xxx_wake_dpc(vha);
 		}
-		return PCI_ERS_RESULT_NEED_RESET;
+		ret = PCI_ERS_RESULT_NEED_RESET;
+		break;
 	case pci_channel_io_perm_failure:
 		ha->flags.pci_channel_io_perm_failure = 1;
 		qla2x00_abort_all_cmds(vha, DID_NO_CONNECT << 16);
@@ -6587,9 +6606,15 @@ struct fw_blob *
 			set_bit(QPAIR_ONLINE_CHECK_NEEDED, &vha->dpc_flags);
 			qla2xxx_wake_dpc(vha);
 		}
-		return PCI_ERS_RESULT_DISCONNECT;
+		ret = PCI_ERS_RESULT_DISCONNECT;
+		break;
+	default:
+		ret = PCI_ERS_RESULT_NEED_RESET;
 	}
-	return PCI_ERS_RESULT_NEED_RESET;
+
+exit_error_detected:
+	qla_on_pci_error_handler_exit(pdev);
+	return ret;
 }
 
 static pci_ers_result_t
@@ -6598,13 +6623,24 @@ struct fw_blob *
 	int risc_paused = 0;
 	uint32_t stat;
 	unsigned long flags;
-	scsi_qla_host_t *base_vha = pci_get_drvdata(pdev);
-	struct qla_hw_data *ha = base_vha->hw;
-	struct device_reg_2xxx __iomem *reg = &ha->iobase->isp;
-	struct device_reg_24xx __iomem *reg24 = &ha->iobase->isp24;
+	pci_ers_result_t ret;
+	scsi_qla_host_t *base_vha;
+	struct qla_hw_data *ha;
+	struct device_reg_2xxx __iomem *reg;
+	struct device_reg_24xx __iomem *reg24;
 
-	if (IS_QLA82XX(ha))
-		return PCI_ERS_RESULT_RECOVERED;
+	if (qla_on_pci_error_handler_entry(pdev) != 0)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	base_vha = pci_get_drvdata(pdev);
+	ha = base_vha->hw;
+	reg = &ha->iobase->isp;
+	reg24 = &ha->iobase->isp24;
+
+	if (IS_QLA82XX(ha)) {
+		ret = PCI_ERS_RESULT_RECOVERED;
+		goto exit_mmio_enabled;
+	}
 
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	if (IS_QLA2100(ha) || IS_QLA2200(ha)){
@@ -6627,9 +6663,13 @@ struct fw_blob *
 		    "RISC paused -- mmio_enabled, Dumping firmware.\n");
 		ha->isp_ops->fw_dump(base_vha, 0);
 
-		return PCI_ERS_RESULT_NEED_RESET;
+		ret = PCI_ERS_RESULT_NEED_RESET;
 	} else
-		return PCI_ERS_RESULT_RECOVERED;
+		ret = PCI_ERS_RESULT_RECOVERED;
+
+exit_mmio_enabled:
+	qla_on_pci_error_handler_exit(pdev);
+	return ret;
 }
 
 static uint32_t
@@ -6744,11 +6784,17 @@ struct fw_blob *
 qla2xxx_pci_slot_reset(struct pci_dev *pdev)
 {
 	pci_ers_result_t ret = PCI_ERS_RESULT_DISCONNECT;
-	scsi_qla_host_t *base_vha = pci_get_drvdata(pdev);
-	struct qla_hw_data *ha = base_vha->hw;
+	scsi_qla_host_t *base_vha;
+	struct qla_hw_data *ha;
 	struct rsp_que *rsp;
 	int rc, retries = 10;
 
+	if (qla_on_pci_error_handler_entry(pdev) != 0)
+		return ret;
+
+	base_vha = pci_get_drvdata(pdev);
+	ha = base_vha->hw;
+
 	ql_dbg(ql_dbg_aer, base_vha, 0x9004,
 	    "Slot Reset.\n");
 
@@ -6804,15 +6850,23 @@ struct fw_blob *
 	ql_dbg(ql_dbg_aer, base_vha, 0x900e,
 	    "slot_reset return %x.\n", ret);
 
+	qla_on_pci_error_handler_exit(pdev);
+
 	return ret;
 }
 
 static void
 qla2xxx_pci_resume(struct pci_dev *pdev)
 {
-	scsi_qla_host_t *base_vha = pci_get_drvdata(pdev);
-	struct qla_hw_data *ha = base_vha->hw;
 	int ret;
+	scsi_qla_host_t *base_vha;
+	struct qla_hw_data *ha;
+
+	if (qla_on_pci_error_handler_entry(pdev) != 0)
+		return;
+
+	base_vha = pci_get_drvdata(pdev);
+	ha = base_vha->hw;
 
 	ql_dbg(ql_dbg_aer, base_vha, 0x900f,
 	    "pci_resume.\n");
@@ -6826,6 +6880,7 @@ struct fw_blob *
 	pci_cleanup_aer_uncorrect_error_status(pdev);
 
 	ha->flags.eeh_busy = 0;
+	qla_on_pci_error_handler_exit(pdev);
 }
 
 static int qla2xxx_map_queues(struct Scsi_Host *shost)
@@ -6959,8 +7014,19 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
 	ql_log(ql_log_info, NULL, 0x0005,
 	    "QLogic Fibre Channel HBA Driver: %s.\n",
 	    qla2x00_version_str);
+	ret = qla_init_pci_error_handlers();
+	if (ret) {
+		kmem_cache_destroy(srb_cachep);
+		qlt_exit();
+		fc_release_transport(qla2xxx_transport_template);
+		fc_release_transport(qla2xxx_transport_vport_template);
+		ql_log(ql_log_fatal, NULL, 0x0006,
+		    "qla_init_pci_error_handlers failed.\n");
+		return -ENOMEM;
+	}
 	ret = pci_register_driver(&qla2xxx_pci_driver);
 	if (ret) {
+		qla_cleanup_pci_error_handlers();
 		kmem_cache_destroy(srb_cachep);
 		qlt_exit();
 		fc_release_transport(qla2xxx_transport_template);
@@ -6980,6 +7046,7 @@ static int qla2xxx_map_queues(struct Scsi_Host *shost)
 {
 	unregister_chrdev(apidev_major, QLA2XXX_APIDEV);
 	pci_unregister_driver(&qla2xxx_pci_driver);
+	qla_cleanup_pci_error_handlers();
 	qla2x00_release_firmware();
 	kmem_cache_destroy(srb_cachep);
 	qlt_exit();
diff --git a/drivers/scsi/qla2xxx/qla_pci_error_handler.c b/drivers/scsi/qla2xxx/qla_pci_error_handler.c
new file mode 100644
index 0000000..454aa1c
--- /dev/null
+++ b/drivers/scsi/qla2xxx/qla_pci_error_handler.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: LGPL-2.1+
+
+/*
+ * The implementation part of PCIe error handler sync helpers
+ * for Qlogic FC adapter driver to guarantee race-free handler completion
+ * prior to releasing the driver contexts associated with PCI devices.
+ */
+
+#include "qla_pci_error_handler.h"
+
+#include <linux/aer.h>
+#include <linux/semaphore.h>
+#include <linux/spinlock.h>
+
+/*
+ * State of the whole implementation: array of per-device contexts, its lock.
+ */
+struct qla_pci_error_handler_state {
+	/* Spinlock for access synchronization */
+	spinlock_t lock;
+	/* Array size */
+	int dev_count;
+	/* Count of valid contexts in the array */
+	int dev_index;
+	/* Pointer to buffers storing contexts */
+	struct qla_pci_error_handler_dev_context *contexts;
+};
+
+static struct qla_pci_error_handler_state state;
+
+#define QLA_DEFAULT_PCI_DEV_COUNT 8
+
+/*
+ * Per-PCI-device context.
+ */
+struct qla_pci_error_handler_dev_context {
+	/* The device */
+	struct pci_dev *dev;
+	/* ..disable.. calls wait on this semaphore for callbacks in-flight */
+	struct semaphore sem;
+	/* Callbacks in-flight */
+	int callback_count;
+	/* ..disable.. calls waiting for callbacks in-flight */
+	int waiter_count;
+	/* true if ..disable.. call was invoked */
+	bool disabled;
+};
+
+/*
+ * Runs before any PCI callbacks are possible (before pci_register_driver).
+ * Initializes the state. Returns 0 on success.
+ */
+int qla_init_pci_error_handlers(void)
+{
+	spin_lock_init(&state.lock);
+	state.contexts = kzalloc(sizeof(
+		struct qla_pci_error_handler_dev_context) *
+			QLA_DEFAULT_PCI_DEV_COUNT, GFP_KERNEL);
+	if (!state.contexts)
+		return -1;
+	state.dev_count = QLA_DEFAULT_PCI_DEV_COUNT;
+	return 0;
+}
+
+/*
+ * Runs after any PCI callbacks are possible and all PCI-related work threads
+ * are joined (after pci_unregister_driver). Thus no ..endble.., ..disable..
+ * calls or PCI callbacks can run in parallel with this function. Cleans up
+ * the state, frees the buffer holding per-pci_dev contexts.
+ */
+void qla_cleanup_pci_error_handlers(void)
+{
+	kfree(state.contexts);
+}
+
+/*
+ * Enables PCI error callbacks for 'dev'. (Before this call, any
+ * PCI handler callbacks bypass the functions defined by the driver.)
+ * Returns 0 on success.
+ */
+int qla_enable_pci_error_handler(struct pci_dev *dev)
+{
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&state.lock, flags);
+	if (state.dev_index == state.dev_count) {
+		/*
+		 * We are out of space in the per-'dev' context buffer.
+		 * Re-allocating twice the old size.
+		 */
+		struct qla_pci_error_handler_dev_context *new_contexts;
+
+		new_contexts = krealloc(state.contexts,
+			sizeof(struct qla_pci_error_handler_dev_context) *
+				state.dev_count * 2,
+			GFP_ATOMIC);
+		if (!new_contexts) {
+			spin_unlock_irqrestore(&state.lock, flags);
+			return -1;
+		}
+		state.contexts = new_contexts;
+		memset(state.contexts + state.dev_count, 0,
+			sizeof(struct qla_pci_error_handler_dev_context) *
+				state.dev_count);
+		state.dev_count *= 2;
+	}
+	state.contexts[state.dev_index].dev = dev;
+	sema_init(&state.contexts[state.dev_index].sem, 0);
+	++state.dev_index;
+	spin_unlock_irqrestore(&state.lock, flags);
+
+	return pci_enable_pcie_error_reporting(dev);
+}
+
+/*
+ * Disables future PCI error callbacks for 'dev'. Blocks for in-flight
+ * callbacks. On return from this call, any in-flight callbacks are gone
+ * and no future callbacks are possible.
+ */
+void qla_disable_pci_error_handler(struct pci_dev *dev)
+{
+	unsigned long flags = 0;
+	int i;
+	struct qla_pci_error_handler_dev_context *context = NULL;
+	struct semaphore *p = NULL;
+
+	pci_disable_pcie_error_reporting(dev);
+
+	spin_lock_irqsave(&state.lock, flags);
+	for (i = 0; i < state.dev_index; ++i) {
+		if (state.contexts[i].dev == dev) {
+			context = state.contexts + i;
+			break;
+		}
+	}
+	if (!context) {
+		spin_unlock_irqrestore(&state.lock, flags);
+		return;
+	}
+	context->disabled = 1;
+	if (context->callback_count != 0) {
+		++context->waiter_count;
+		p = &context->sem;
+	}
+	spin_unlock_irqrestore(&state.lock, flags);
+	if (p)
+		down(p);
+}
+
+/*
+ * Runs on PCI error callback entry. Looks up per-'dev' context,
+ * if callbacks have not been disabled, increments the callback
+ * count and returns 0. Then the the driver-defined callback goes
+ * on. If the context is not found or it has been disabled,
+ * returns -1 and the the driver-defined callback returns right away.
+ */
+int qla_on_pci_error_handler_entry(struct pci_dev *dev)
+{
+	unsigned long flags = 0;
+	struct qla_pci_error_handler_dev_context *context = NULL;
+	int i;
+	int ret = 0;
+
+	spin_lock_irqsave(&state.lock, flags);
+	for (i = 0; i < state.dev_index; ++i) {
+		if (state.contexts[i].dev == dev) {
+			context = state.contexts + i;
+			break;
+		}
+	}
+	if (!context || context->disabled)
+		ret = -1;
+	else
+		++context->callback_count;
+	spin_unlock_irqrestore(&state.lock, flags);
+	return ret;
+}
+
+/*
+ * Runs on PCI error callback exit, if the entry allowed running the
+ * driver-defined callback. Decrements the in-flight callback count.
+ * If there are any waiting ..disable.. calls, signals the semaphore
+ * to unblock those calls.
+ */
+void qla_on_pci_error_handler_exit(struct pci_dev *dev)
+{
+	unsigned long flags = 0;
+	struct qla_pci_error_handler_dev_context *context = NULL;
+	int i;
+	struct semaphore *p = NULL;
+	int waiters = 0;
+
+	spin_lock_irqsave(&state.lock, flags);
+	for (i = 0; i < state.dev_index; ++i) {
+		if (state.contexts[i].dev == dev) {
+			context = state.contexts + i;
+			break;
+		}
+	}
+	if (context) {
+		--context->callback_count;
+		if (!context->callback_count && context->disabled) {
+			waiters = context->waiter_count;
+			p = &context->sem;
+			context->dev = NULL;
+		}
+	}
+	spin_unlock_irqrestore(&state.lock, flags);
+	for (i = 0; i < waiters; ++i)
+		down(p);
+}
+
diff --git a/drivers/scsi/qla2xxx/qla_pci_error_handler.h b/drivers/scsi/qla2xxx/qla_pci_error_handler.h
new file mode 100644
index 0000000..9130c14
--- /dev/null
+++ b/drivers/scsi/qla2xxx/qla_pci_error_handler.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: LGPL-2.1+
+ *
+ * PCI error handler synchronization helpers for Qlogic FC adapter driver
+ * to guarantee race-free handler completion prior to releasing
+ * the driver contexts associated with PCI devices.
+ */
+
+#ifndef __QLA_PCI_ERROR_HANDLER_H
+#define __QLA_PCI_ERROR_HANDLER_H
+
+#include <linux/pci.h>
+
+/* Initialization; runs before any PCI callbacks */
+int qla_init_pci_error_handlers(void);
+
+/* Cleanup; runs after any PCI callbacks */
+void qla_cleanup_pci_error_handlers(void);
+
+/* Enables PCI error callbacks for 'dev' */
+int qla_enable_pci_error_handler(struct pci_dev *dev);
+
+/* Disables PCI error callbacks for 'dev' */
+void qla_disable_pci_error_handler(struct pci_dev *dev);
+
+/*
+ * Called by PCI error callbacks on callback entry.
+ * Returns 0 if the callback is allowed to proceed.
+ */
+int qla_on_pci_error_handler_entry(struct pci_dev *dev);
+
+/* Called by PCI error callbacks on callback exit */
+void qla_on_pci_error_handler_exit(struct pci_dev *dev);
+
+/*
+ * Usage: assume that we want to define 'pci_resume' PCI error handler callback.
+ *
+ * void qla_pci_resume(struct pci_dev *dev)
+ * {
+ *         if (qla_on_pci_error_handler_entry(dev) != 0)
+ *                 return;
+ *         ... code here ...
+ *         qla_on_pci_error_handler_exit(dev);
+ * }
+ */
+
+#endif
-- 
1.9.1

