Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C2BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C578420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pnq5AiZN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C578420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJYWhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:37:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38802 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeJYWhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:37:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so9475062wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HACt8ml0njX/72qFHpEvwHCi5Al01vqXe2z4OYhbfEY=;
        b=Pnq5AiZNiyDdDi04bZrnLee1GYVMnX28xehpcuoKyg81NdDNK8g2P55+wb7bOZdxNZ
         jExUb2dVjuSERPRvOJmdH51CimCip2ZPtJbYKmxIhtydMlKGu4grm7fmyfsyS3Tp6n3D
         DhbabAVLZTNtBQTs/U/Xk7PJoAaxmv3V0V/mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HACt8ml0njX/72qFHpEvwHCi5Al01vqXe2z4OYhbfEY=;
        b=DblSn5tEx2iM/2FKNc1a1qGTdt0bwVPZ+mXc1SAOWInD7zjdd1uneqdWPfL4/AfkHH
         yqilt7tUTNFyc0HLjcCDiPl3CuktOm0kejQnIjn4jWyoxxJcTXM48jAkiFJfmPfo9CVA
         ASOQivi7hvglqFjr0AVv4zNy01Z7AKEIhPMg8fWzSfsNYM1QoPNhJZyXTWqjCWCs+4OD
         +9u8CCZPXH3gUz6hmonrER3vtVsNdwZldaEISubJkETkbFFsL/pH5n7n9h/R9sagRjXl
         fnqERLYZIljpGwaPLdFU/cjnzEI06ZyXvu7Ud4plqPjPJj7TiUrJiI5L0nq+cHCtaJuC
         tM4w==
X-Gm-Message-State: AGRZ1gKdVbKNGhehasAyJLTnUzXO5fbUQVjd5dSc06UrLeIiEfKZC65H
        8fUoTSuFRVli9PSJziX/6sQEXA==
X-Google-Smtp-Source: AJdET5feXAZ6zBsOBfO70KJ0sbszrMr3LTokniU70EAeoQCeh85IcZnt9fOjXa8IWp6f8ayjIHtVIw==
X-Received: by 2002:adf:a591:: with SMTP id g17-v6mr2200996wrc.188.1540476245746;
        Thu, 25 Oct 2018 07:04:05 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u10-v6sm7313771wrt.59.2018.10.25.07.04.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 07:04:05 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [Resend 2/2] mpt3sas: Add support to Aero PCI IDs.
Date:   Thu, 25 Oct 2018 19:33:41 +0530
Message-Id: <1540476221-14987-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1540476221-14987-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540476221-14987-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Aero/Sea controllers and
add warning for configurable secure type IOC.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index df56cbe..5001439 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -10284,6 +10284,10 @@ _scsih_determine_hba_mpi_version(struct pci_dev *pdev)
 	case MPI26_MFGPAGE_DEVID_SAS3516_1:
 	case MPI26_MFGPAGE_DEVID_SAS3416:
 	case MPI26_MFGPAGE_DEVID_SAS3616:
+	case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
+	case MPI26_MFGPAGE_DEVID_HARD_SEC_3916:
+	case MPI26_MFGPAGE_DEVID_CFG_SEC_3816:
+	case MPI26_MFGPAGE_DEVID_HARD_SEC_3816:
 		return MPI26_VERSION;
 	}
 	return 0;
@@ -10369,6 +10373,11 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case MPI26_MFGPAGE_DEVID_SAS3516_1:
 		case MPI26_MFGPAGE_DEVID_SAS3416:
 		case MPI26_MFGPAGE_DEVID_SAS3616:
+		case MPI26_MFGPAGE_DEVID_CFG_SEC_3816:
+		case MPI26_MFGPAGE_DEVID_CFG_SEC_3916:
+			ioc_warn(ioc, "HBA is in Configurable Secure mode\n");
+		case MPI26_MFGPAGE_DEVID_HARD_SEC_3816:
+		case MPI26_MFGPAGE_DEVID_HARD_SEC_3916:
 			ioc->is_gen35_ioc = 1;
 			break;
 		default:
@@ -10830,6 +10839,23 @@ static const struct pci_device_id mpt3sas_pci_table[] = {
 	/* Mercator ~ 3616*/
 	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3616,
 		PCI_ANY_ID, PCI_ANY_ID },
+
+	/* Aero SI 0x00E1 Configurable Secure
+	 * 0x00E2 Hard Secure
+	 */
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_CFG_SEC_3916,
+		PCI_ANY_ID, PCI_ANY_ID },
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_HARD_SEC_3916,
+		PCI_ANY_ID, PCI_ANY_ID },
+
+	/* Sea SI 0x00E5 Configurable Secure
+	 * 0x00E6 Hard Secure
+	 */
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_CFG_SEC_3816,
+		PCI_ANY_ID, PCI_ANY_ID },
+	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_HARD_SEC_3816,
+		PCI_ANY_ID, PCI_ANY_ID },
+
 	{0}     /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(pci, mpt3sas_pci_table);
-- 
1.8.3.1

