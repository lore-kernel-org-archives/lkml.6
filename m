Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519838708-2-6046286413091957637
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838707; b=OaaSDfBqSBBtCS9Zi447+YZAdX79DvSEo5rGvk8Qhx+Ys77
    /IeJ51HDVKftpRPc3UyXyIfEfNDsnCdEtVrnPsov/QlgaXHIJlRLZpaB0m/5V2b6
    KS+NUbEsTnSNpOSAEVf/6vAz7NJ9gyFoNOMHjlxVRjfMweoNml23IP+IY25ZiR5H
    PA7YLKnMiV6wz5d4EyGeteRVcOsT7Yv57lUga24b9llctMxGr/2AknpGH3i7jf05
    1Pj6rgl4yGkVmdkY4xTyWw7JWx+DiT9AOzP/BExXj5XiqXROyIcbPRTBQrBvaUCt
    6wN9bjFW63tQ7GbWm2dcp1V6N9JwllyUsVsI9kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838707; bh=txyNJPgzkL6U9QfNlyI
    NEYomxu0UhQZhrQXE9BvdLJI=; b=i/HoOK5Z5K6zyE/p4TSL2pUcMRLfPwpWxE/
    3kvHmtEiffiTp4rqZuxayAM0zRv+vputp+oajcAKnYKtJ5t5Z+ofRl9p9JOE2t90
    lN1B6eiiCiqzZTMT8u/oJh3WysO7T2CCKJP0OFMSaw36Vskq0GtR1hp1GaNs6ILZ
    2YwCJ7NhQz2Z2Q5ycIGLyMgViu8NV7Ozjo557+4/hJhLPQNWnNrPGzvAbnP631my
    y6KDSQu4+a4Dzdsp5iKW4F3akQs950m++T5+ml9M8VSnDKFTxxTKV0K1DwwcqCxP
    45707CuasHdw/bxH6UGaPdx1SyascqIOhc5OZIoDyRm4KVfW3rw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeB1RZG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:25:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33323 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932617AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Huacai Chen" <chenhc@lemote.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Christoph Hellwig" <hch@lst.de>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.685047854@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 009/140] scsi: libsas: align sata_device's rps_resp on
 a cacheline
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

From: Huacai Chen <chenhc@lemote.com>

commit c2e8fbf908afd81ad502b567a6639598f92c9b9d upstream.

The rps_resp buffer in ata_device is a DMA target, but it isn't
explicitly cacheline aligned. Due to this, adjacent fields can be
overwritten with stale data from memory on non-coherent architectures.
As a result, the kernel is sometimes unable to communicate with an SATA
device behind a SAS expander.

Fix this by ensuring that the rps_resp buffer is cacheline aligned.

This issue is similar to that fixed by Commit 84bda12af31f93 ("libata:
align ap->sector_buf") and Commit 4ee34ea3a12396f35b26 ("libata: Align
ata_device's id on a cacheline").

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/scsi/libsas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -163,7 +163,6 @@ enum ata_command_set {
 
 struct sata_device {
         enum   ata_command_set command_set;
-        struct smp_resp        rps_resp; /* report_phy_sata_resp */
         __le16 *identify_device;
         __le16 *identify_packet_device;
 
@@ -172,6 +171,7 @@ struct sata_device {
 
 	struct ata_port *ap;
 	struct ata_host ata_host;
+	struct smp_resp rps_resp ____cacheline_aligned; /* report_phy_sata_resp */
 	u8     fis[ATA_RESP_FIS_SIZE];
 };
 
