Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839502-2-16969590927994878349
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839502; b=e0MgbQ8qHA39y4qqlsjb9/bad+F6z5BA/WuWtZdrI9MuMCC
    pldTn3LKeEv2VEwrVYgC8lvIcpaGiy23KaVCA0wjtvaoxzCMLZqUIpfbDonzXB4s
    Ha5diWETsr78G9/sMXobMUj8pBvVkQGmrDmaieHruO32qAzE1/un7SD5cQooMUEB
    1Znu67Q/LdGIpg9lASO24eFN4npCR+5ZhdljKCdqsngErFY1pvg7fqA3Ex6MfW3s
    mDjre0E68BUUbGM5TyEL1VZ+2XCf9fnrArWr8RBRoyvPLrYQjRKavvJi+RfGpIbA
    htY4or3oMaT8W1RkxG7VMFt7wTfRh6KVm/VakNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839502; bh=/jscPnmu+zx9DqHOcTD
    fpojiNJHBbZWNDWEX+wpDPRA=; b=DIxbRsCI/b2RdMogII9dbDawKUUsixCWFI1
    BpHtxaAgkkeL5ik5YqGVXCbM0QpMcYR4r8Ra6Ekh7yhCKv4ghLF5qhGj8hV1gJpE
    /nABePpWu9M0bH4Cgv23SpE+7AYP6tDEtEBI4DLbPa+2ORRhWPVRTwwm0vnGGo1W
    +DxeQw8cAE6FfKnvQt9m+x6QRgYIBxGnopC20bnRwYEqlHNlGf/tJsQpNbVqVnru
    dtPX/qoZvBlNM04NDw6428aYj/kLipRlAhG4FORsQhxLJjxVnz5y1sd0a8b2Aooy
    fyOjNHG5wP6c4PWytUtl02p50+Enc13hHeQylQQdUpNOz2109EA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeB1Rg0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:36:26 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33191 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932546AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jack Wang" <jack_wang@usish.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "James Bottomley" <JBottomley@Parallels.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.52857869@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 008/140] [SCSI] libsas: remove unused ata_task_resp fields
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 95ac7fd189b7e81a200b4d00b2bb6669b31acf3a upstream.

Commit 1e34c838 "[SCSI] libsas: remove spurious sata control register
read/write" removed the routines to fake the presence of the sata
control registers, now remove the unused data structure fields to kill
any remaining confusion.

Acked-by: Jack Wang <jack_wang@usish.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: James Bottomley <JBottomley@Parallels.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/libsas/sas_ata.c | 4 ----
 include/scsi/libsas.h         | 7 -------
 2 files changed, 11 deletions(-)

--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -121,10 +121,6 @@ static void sas_ata_task_done(struct sas
 			if (unlikely(link->eh_info.err_mask))
 				qc->flags |= ATA_QCFLAG_FAILED;
 		}
-
-		dev->sata_dev.sstatus = resp->sstatus;
-		dev->sata_dev.serror = resp->serror;
-		dev->sata_dev.scontrol = resp->scontrol;
 	} else {
 		ac = sas_to_ata_err(stat);
 		if (ac) {
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -173,9 +173,6 @@ struct sata_device {
 	struct ata_port *ap;
 	struct ata_host ata_host;
 	u8     fis[ATA_RESP_FIS_SIZE];
-	u32 sstatus;
-	u32 serror;
-	u32 scontrol;
 };
 
 /* ---------- Domain device ---------- */
@@ -492,10 +489,6 @@ enum exec_status {
 struct ata_task_resp {
 	u16  frame_len;
 	u8   ending_fis[ATA_RESP_FIS_SIZE];	  /* dev to host or data-in */
-	u32  sstatus;
-	u32  serror;
-	u32  scontrol;
-	u32  sactive;
 };
 
 #define SAS_STATUS_BUF_SIZE 96
