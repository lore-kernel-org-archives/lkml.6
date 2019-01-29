Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98625C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6351520663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SbeAVn+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbfA2MPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:15:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43684 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfA2MPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:15:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so9557262pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5LB3pwvnk4GJemSCy28xjYAPXvXv16KpVfezXgyBDJc=;
        b=SbeAVn+0hb9RxK2Sd8fQWQpk3LFtYhcWBCkrYqLQa5Ye+AAT3CMEfE9lCsFZ1i76f4
         kxKLb/zkkHIi1dWM3B7whj4SE0xD+FBApm+qRpfEVIhQaVsbGdYDY9uBZ/yHaL4qtwiD
         LI8WBLnlxxqbvT88Y/98Ua/9BPgqymDBgf5Tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5LB3pwvnk4GJemSCy28xjYAPXvXv16KpVfezXgyBDJc=;
        b=I9JbWM6OUXUoci98YOfzpiShjLdCJ3oqIRj77Wc8MstElQfvHWa2k/6FyRLzeCur1Y
         Bp+nNPPJdfeImWsEThZXRX0iL+RHhcugKmmtt9a3JRlQ+aHtN6jh0cMbsICboO2UEg/T
         /r2ZxhrHADvd8eNHNS+VjiMNHwv96cUBsFjZtEtTBZDcu065+33EdM3bwo+iXofm7f6M
         6KJv3X2Yp+5HoVVhQfIE2kdXwteRH3lpaJOS+5xPhfQGswzImTCl2sU1gamfiXHeQTKR
         dBT7j75ytBc7qZi6zzpjMSWDB29Pz2samIvy8YIsxe+XhZ3BN1daWYPPwPl/7HGzEfbc
         XMvA==
X-Gm-Message-State: AJcUukfWJVvlzJkXcJ3ExNRsqu5kZrRnin2ZVAov00tl3y9j5P+6KgfL
        6cKPyJVx5emQHptxDh9dDjBD9Q==
X-Google-Smtp-Source: ALg8bN4gOjzWAZMQq6xpp4wPkms7NB0GWs/NkEDDCsFiCD+mpVNKNVTAE0ui2itweN9aWhJ0I4vmXA==
X-Received: by 2002:a63:e344:: with SMTP id o4mr23148364pgj.158.1548764098953;
        Tue, 29 Jan 2019 04:14:58 -0800 (PST)
Received: from dhcp-10-123-20-72.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g136sm48689876pfb.154.2019.01.29.04.14.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:14:58 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 2/4] mpt3sas: Add support for NVMe Switch Adapter
Date:   Tue, 29 Jan 2019 07:14:41 -0500
Message-Id: <1548764083-5781-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device ID for NVMe Switch Adapter (Ambrosia).
VID: 0x1000
DID: 0x02B1

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h | 1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index a53a758..a2f4a55 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -549,6 +549,7 @@ typedef struct _MPI2_CONFIG_REPLY {
 #define MPI2_MFGPAGE_DEVID_SAS2308_2                (0x0087)
 #define MPI2_MFGPAGE_DEVID_SAS2308_3                (0x006E)
 #define MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP            (0x02B0)
+#define MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP_1          (0x02B1)
 
 /*MPI v2.5 SAS products */
 #define MPI25_MFGPAGE_DEVID_SAS3004                 (0x0096)
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3a0f70..4a73753 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10257,6 +10257,7 @@ _scsih_determine_hba_mpi_version(struct pci_dev *pdev)
 	case MPI2_MFGPAGE_DEVID_SAS2308_2:
 	case MPI2_MFGPAGE_DEVID_SAS2308_3:
 	case MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP:
+	case MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP_1:
 		return MPI2_VERSION;
 	case MPI25_MFGPAGE_DEVID_SAS3004:
 	case MPI25_MFGPAGE_DEVID_SAS3008:
@@ -10344,6 +10345,7 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			ioc->hide_ir_msg = 1;
 			break;
 		case MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP:
+		case MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP_1:
 			ioc->is_mcpu_endpoint = 1;
 			break;
 		default:
@@ -10785,6 +10787,8 @@ static const struct pci_device_id mpt3sas_pci_table[] = {
 		PCI_ANY_ID, PCI_ANY_ID },
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP,
 		PCI_ANY_ID, PCI_ANY_ID },
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP_1,
+		PCI_ANY_ID, PCI_ANY_ID },
 	/* SSS6200 */
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SSS6200,
 		PCI_ANY_ID, PCI_ANY_ID },
-- 
1.8.3.1

