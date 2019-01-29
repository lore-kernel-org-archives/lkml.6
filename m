Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17FAC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736BC20663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M3IZaBeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfA2MO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:14:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40390 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfA2MO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:14:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so9569602pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qbR01j/6Y5h4jK4Q4Vw3PWE240tOgVvX27Ci2PbGkEw=;
        b=M3IZaBegnoYdvBkE8DdhBKGslbiz6GdhajJtSd1Rh/P3gW1GD4YG9m+F229t4dmQtV
         AJHsSk6Qb8ohPHkCjHnRcU54JR8LmzljTw/tWFf5ynT6uB3FG6TQ5iOTSbIuQcwYdLsv
         JPj3wKPk8erfnFurLBNYG9Y0+AZZnqkt3M4vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qbR01j/6Y5h4jK4Q4Vw3PWE240tOgVvX27Ci2PbGkEw=;
        b=JmNUy1KNeHwnsHKoW/NjipG9rPjdzHoaFn9TCqNzOqA1L2Im2Pm5luME0cDI8zQ8VU
         p9tD8iLm6N0A8wey8zUPdAHXA6o6eIL4v9gvbSeAZd7n61bCIfXzfM9q58KUpSNlEWhT
         YCN7Eyzz+VbGYd6a7iPRCnfwO+O2vh2jXFvKJkrAEa7ysWOiyxVir8oz0L4f0WkbNIYR
         S4u0VRtBJ49uvhvJnw0t/ipFtKH1142dltjk5PqW8m+dxp36TQhQm57GRi0ddPuVIfaj
         ZL5YyJifptyNamSEoxnl+Qk6Nct1qq3FJ5VIwK6o96Br/DdkQCiu8kUfev+PnsaBiQpN
         4AVQ==
X-Gm-Message-State: AJcUukcOW58/e8KWOkYp9oHUnFP7oIbGZY+7Qr64XtYfalB/4LxJnuUG
        PE18SrEELY7m5yw1NG91+d3TTg==
X-Google-Smtp-Source: ALg8bN4s+9H1vmKnrN+jxM4P4BiNZBKQxb3fDla6gUtDMB+GC+eicQP9xwypEtGWTVr5AKtzBglbJg==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr22748387pgo.223.1548764096626;
        Tue, 29 Jan 2019 04:14:56 -0800 (PST)
Received: from dhcp-10-123-20-72.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g136sm48689876pfb.154.2019.01.29.04.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:14:56 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 1/4] mpt3sas: Rename mpi endpoint device ID macro.
Date:   Tue, 29 Jan 2019 07:14:40 -0500
Message-Id: <1548764083-5781-2-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPI Endpoint is a PCIe switch based on MPI2,
Renaming device ID macro from
MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP
to MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index 398fa6f..a53a758 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -548,7 +548,7 @@ typedef struct _MPI2_CONFIG_REPLY {
 #define MPI2_MFGPAGE_DEVID_SAS2308_1                (0x0086)
 #define MPI2_MFGPAGE_DEVID_SAS2308_2                (0x0087)
 #define MPI2_MFGPAGE_DEVID_SAS2308_3                (0x006E)
-#define MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP           (0x02B0)
+#define MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP            (0x02B0)
 
 /*MPI v2.5 SAS products */
 #define MPI25_MFGPAGE_DEVID_SAS3004                 (0x0096)
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 6be39dc..c3a0f70 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10256,7 +10256,7 @@ _scsih_determine_hba_mpi_version(struct pci_dev *pdev)
 	case MPI2_MFGPAGE_DEVID_SAS2308_1:
 	case MPI2_MFGPAGE_DEVID_SAS2308_2:
 	case MPI2_MFGPAGE_DEVID_SAS2308_3:
-	case MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP:
+	case MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP:
 		return MPI2_VERSION;
 	case MPI25_MFGPAGE_DEVID_SAS3004:
 	case MPI25_MFGPAGE_DEVID_SAS3008:
@@ -10343,7 +10343,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			ioc->is_warpdrive = 1;
 			ioc->hide_ir_msg = 1;
 			break;
-		case MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP:
+		case MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP:
 			ioc->is_mcpu_endpoint = 1;
 			break;
 		default:
@@ -10783,7 +10783,7 @@ static const struct pci_device_id mpt3sas_pci_table[] = {
 		PCI_ANY_ID, PCI_ANY_ID },
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2308_3,
 		PCI_ANY_ID, PCI_ANY_ID },
-	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2308_MPI_EP,
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP,
 		PCI_ANY_ID, PCI_ANY_ID },
 	/* SSS6200 */
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SSS6200,
-- 
1.8.3.1

