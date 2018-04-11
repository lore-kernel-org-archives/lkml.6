Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479421-2-4877358186876975337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479420; b=uhfI9FWZ0VcayMbhEGKaneJfLRDJ2+VJDkrCglHqolHqhjvFyk
    zJVA1LdjgG5g+5ssOL++D4zQF8sP0PWJIeF2PIxPhx63scsG0bvSEiccN8udoqWZ
    /nRevBTmXCHbo3Njpl3lKnXHuZsUyxu4QNEFn+QldBpPFVYBqG27zl+0C89e9qQ6
    PqFM81nKrbTmviLPGXoeFtjyXh3SWQrRVNMnQRU5x8k2ZHpgTnCFtL6e1dT5ozVy
    p959xM4bcEBYRrIarIYD0D/GKEZb5pAR+SvrJYjhIPKb60aNQaY89Gr+qJ0lpE+r
    woLtLpRbnmxl7v3IL9u4Zq46RlC3qc9SHfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479420; bh=699n0GVG9iWYZWo8UWfGwa0/MRx9/N
    yFpczcdzdySDI=; b=LMqdvZHbCTJw+ocUrz+vLfwMg4kv0XF4Ks2U1bIA7JW0ZT
    FeIazCEHLN37gc7CnP5Yu5kgCp6yQ+WN+hDQu+FA2MLJACpCL+CJxrMUjMt1Beev
    nNLG/6ts9Lo/fiooHQ/Aqr7GnldyB56/nqx0h7+mCiSvGyCQf4pxl7iOIAIqZi8o
    oisKDNupZhpDHTxBtb0kRtq2UpgJGhw6N3s85DH2Ly4X/YFSrptxrl8vQDlxBx04
    kebNZF8CVWcZQSK187T919ezuACkD9UkHDmG7fVnXF7aboymonWnsd2HgqyvyeIM
    VjBJHgOVOGw4hNU3NeeEcWIzQI78XXpYKGHaDyhQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLSh4tWVQFevTy/CledSYVdL9jHYZWkc6nOhS1AR1e/916I7AUZHLmQnsN6see2FHF9Xc0Jl+Ixc4A1SEhu/aRRIY4n8hVV4UQb0HAKjExetO0cMqoub
    obXKtoyQWy1ftQ8W3StYlPkYNwVFSIhdbeHfIkVDM8BRoATQ8PmO2JfE+dsQi83/SpNevR3PkM3olPZv3byAAXcBw3FoKdEGUGMhFLCYZ7J71hyhcqnrTOtQ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Q-fNiiVtAAAA:8 a=yPCof4ZbAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=JIHOz45QZUSSGx34f7cA:9 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755926AbeDKSrb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755922AbeDKSr3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 090/190] scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" flag.
Date: Wed, 11 Apr 2018 20:35:36 +0200
Message-Id: <20180411183555.884616955@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chaitra P B <chaitra.basappa@broadcom.com>


[ Upstream commit f49d4aed1315a7b766d855f1367142e682b0cc87 ]

1. In IO path, setting of "ATA command pending" flag early before device
   removal, invalid device handle etc., checks causes any new commands
   to be always returned with SAM_STAT_BUSY and when the driver removes
   the drive the SML issues SYNC Cache command and that command is
   always returned with SAM_STAT_BUSY and thus making SYNC Cache command
   to requeued.

2. If the driver gets an ATA PT command for a SATA drive then the driver
   set "ATA command pending" flag in device specific data structure not
   to allow any further commands until the ATA PT command is completed.
   However, after setting the flag if the driver decides to return the
   command back to upper layers without actually issuing to the firmware
   (i.e., returns from qcmd failure return paths) then the corresponding
   flag is not cleared and this prevents the driver from sending any new
   commands to the drive.

This patch fixes above two issues by setting of "ATA command pending"
flag after checking for whether device deleted, invalid device handle,
device busy with task management. And by setting "ATA command pending"
flag to false in all of the qcmd failure return paths after setting the
flag.

Signed-off-by: Chaitra P B <chaitra.basappa@broadcom.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -3886,19 +3886,6 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 		return 0;
 	}
 
-	/*
-	 * Bug work around for firmware SATL handling.  The loop
-	 * is based on atomic operations and ensures consistency
-	 * since we're lockless at this point
-	 */
-	do {
-		if (test_bit(0, &sas_device_priv_data->ata_command_pending)) {
-			scmd->result = SAM_STAT_BUSY;
-			scmd->scsi_done(scmd);
-			return 0;
-		}
-	} while (_scsih_set_satl_pending(scmd, true));
-
 	sas_target_priv_data = sas_device_priv_data->sas_target;
 
 	/* invalid device handle */
@@ -3924,6 +3911,19 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 	    sas_device_priv_data->block)
 		return SCSI_MLQUEUE_DEVICE_BUSY;
 
+	/*
+	 * Bug work around for firmware SATL handling.  The loop
+	 * is based on atomic operations and ensures consistency
+	 * since we're lockless at this point
+	 */
+	do {
+		if (test_bit(0, &sas_device_priv_data->ata_command_pending)) {
+			scmd->result = SAM_STAT_BUSY;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+	} while (_scsih_set_satl_pending(scmd, true));
+
 	if (scmd->sc_data_direction == DMA_FROM_DEVICE)
 		mpi_control = MPI2_SCSIIO_CONTROL_READ;
 	else if (scmd->sc_data_direction == DMA_TO_DEVICE)
@@ -3945,6 +3945,7 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 	if (!smid) {
 		pr_err(MPT3SAS_FMT "%s: failed obtaining a smid\n",
 		    ioc->name, __func__);
+		_scsih_set_satl_pending(scmd, false);
 		goto out;
 	}
 	mpi_request = mpt3sas_base_get_msg_frame(ioc, smid);
@@ -3975,6 +3976,7 @@ scsih_qcmd(struct Scsi_Host *shost, stru
 	if (mpi_request->DataLength) {
 		if (ioc->build_sg_scmd(ioc, scmd, smid)) {
 			mpt3sas_base_free_smid(ioc, smid);
+			_scsih_set_satl_pending(scmd, false);
 			goto out;
 		}
 	} else
