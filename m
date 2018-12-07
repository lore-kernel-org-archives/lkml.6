Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76367C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2732D20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 19:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gROOvirD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2732D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbeLGT4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 14:56:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38554 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeLGT4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 14:56:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so2290351plb.5;
        Fri, 07 Dec 2018 11:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HV0ad/tgre+nQE1kpbpFmKwpw7ygKBPnSSglbtGnX7Q=;
        b=gROOvirD1iZcrkD8A5kMTq10pDO4gNhlIA7Qrgx2npb0l41LbJ87UsMVOA2mlBg5gS
         D7mIyuA9KnqpkM0ziPpB+NaXmwwr+baDu3ytkmwXRmT2uuPMbloUEBv7nFftHseRjEc8
         nInmesZwVu4h4v1jPOQ8wc5cj+GAYa5IGp081lxYMrBlannvlNZxowPUT37XDmNzibvj
         frIsJb2GMb1ZqecCO3vgPaucGbJlnHN5fxxQH7gTtCmAWQAt9kiqCXOdDGs9RWgMJyKz
         XdPpnL9US94g1bXpY2ReIP98BsgMFhV8pCUwN4uLhwX06Fue+CcUooWdLBDIqaLsXgCW
         4xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HV0ad/tgre+nQE1kpbpFmKwpw7ygKBPnSSglbtGnX7Q=;
        b=DbfI6JpNpdoZrsEOlMDn2zh8YAcvzJU+W4AA775ltIDuqCRR6SQ6IEkhAgrcvt6iIX
         kAwbCT3FX2CNo3HzzpfP2fF/xE5W16ISDLXcdMA4jXpEFJhbU3fWsewEUA+wZv1D+8j6
         l2dDqNh+uOjf70zmL6O2qLhM5kz+yx7eV85SmaMe5pZ5FNAHSkmNX+QwzDagRxkjuFFH
         uQQVnaSsVuHy2g9lJ3zwIQzJUF9e3CWA6TqP8yd1Fv6vDKNYrmba7K84CsqII+jkvARG
         J9GcAEaqEHrAqqzjjvo5nR4xAyCAbBIn/5c5c07O2pOwNDwTNc3higucyR0kPbVElC5n
         6Iww==
X-Gm-Message-State: AA+aEWZXkbZLVHZs/jNilXELEtBB7ZLqLrcSCZPqfF0+VTQrv1cN4qoq
        Qb0eIDDqm68G//J7FziD3rU=
X-Google-Smtp-Source: AFSGD/X8PO5r9Gsg8JljzXFZ3p+ZllH2vy3wz20EtAYSZi4lQ51oBXKegNYST10FDETSln7SM2l1iQ==
X-Received: by 2002:a17:902:112c:: with SMTP id d41mr3270364pla.144.1544212612139;
        Fri, 07 Dec 2018 11:56:52 -0800 (PST)
Received: from dev-aglagolev.dev.purestorage.com ([192.30.188.252])
        by smtp.googlemail.com with ESMTPSA id i123sm6687358pfg.164.2018.12.07.11.56.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 11:56:51 -0800 (PST)
From:   Anatoliy Glagolev <glagolig@gmail.com>
To:     aglagolev@purestorage.com, qla2xxx-upstream@qlogic.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anatoliy Glagolev <glagolig@gmail.com>
Subject: [PATCH] scsi: qla2xxx: disabling pci error handler early
Date:   Fri,  7 Dec 2018 12:56:42 -0700
Message-Id: <1544212602-28085-1-git-send-email-glagolig@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qla2x00_disable_board_on_pci_error and pcie error handlers may run
in parallel. Specifically, I observed qla2xxx_pci_slot_reset running
at around the same moment as qla2x00_disable_board_on_pci_error.
If scsi_qla_host_t or qla_hw_data structs are removed before an error
handler completes, the handler crashes.

This patch disables pcie error handling early in
qla2x00_disable_board_on_pci_error and in other paths that remove
those structs.

Signed-off-by: Anatoliy Glagolev <glagolig@gmail.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index e881fce..b8f277a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2775,9 +2775,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 			return ret;
 	}
 
-	/* This may fail but that's ok */
-	pci_enable_pcie_error_reporting(pdev);
-
 	ha = kzalloc(sizeof(struct qla_hw_data), GFP_KERNEL);
 	if (!ha) {
 		ql_log_pci(ql_log_fatal, pdev, 0x0009,
@@ -3039,6 +3036,9 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 		goto probe_hw_failed;
 	}
 
+	/* This may fail but that's ok */
+	pci_enable_pcie_error_reporting(pdev);
+
 	pci_set_drvdata(pdev, base_vha);
 	set_bit(PFLG_DRIVER_PROBING, &base_vha->pci_flags);
 
@@ -3400,6 +3400,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 		kthread_stop(t);
 	}
 
+	pci_disable_pcie_error_reporting();
+
 	qla2x00_free_device(base_vha);
 	scsi_host_put(base_vha->host);
 	/*
@@ -3625,6 +3627,8 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	}
 	qla2x00_wait_for_hba_ready(base_vha);
 
+	pci_disable_pcie_error_reporting(pdev);
+
 	qla2x00_wait_for_sess_deletion(base_vha);
 
 	/*
@@ -3698,8 +3702,6 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
 	pci_release_selected_regions(ha->pdev, ha->bars);
 	kfree(ha);
 
-	pci_disable_pcie_error_reporting(pdev);
-
 	pci_disable_device(pdev);
 }
 
@@ -5826,6 +5828,8 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
 		return;
 	}
 
+	pci_disable_pcie_error_reporting(pdev);
+
 	qla2x00_wait_for_sess_deletion(base_vha);
 
 	set_bit(UNLOADING, &base_vha->dpc_flags);
@@ -5866,7 +5870,6 @@ void qla2x00_relogin(struct scsi_qla_host *vha)
 	qla2x00_unmap_iobases(ha);
 
 	pci_release_selected_regions(ha->pdev, ha->bars);
-	pci_disable_pcie_error_reporting(pdev);
 	pci_disable_device(pdev);
 
 	/*
-- 
1.9.1

