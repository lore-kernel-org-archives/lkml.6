Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836346-2-8462231812209332739
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836345; b=Du/BiWm1tGNe7+ynVPodHxXXrxPvQ2ZTer8X8QlyNz4GTqN
    gedhHTwNcIutuLXd82PEyBx8IUJU+QIMPk64prEC5jCel+Ssi0rhOi0EWgmZpTc9
    UQBt2xRRFuLWR0w8jc2NywgngzRGs45UffJ4MPSgrOf8nSkPH9kCNG80FFQz7xvp
    KcSnJt9MpuBBHgEgipRJMeYzDvPWDfQRgNoS/eh41AgiMQuWwLTPgUcV38MgBOfg
    IhoQ9o8t8J9yiwZb2vtD9AZ+2x3ohge3y+l2msHx6Gk5iXTZwRAmCErscYC1n0lM
    VdCaCM7Xz37dCcpIN4iY8TrPVPAMmIM73J2hgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836345; bh=jat1zsMS8BWZaN8Kvx/
    aIInYT/ET0a0TsGfFlLzL9Sg=; b=rDHnffp/BrB8hpB+BNoWC8IAYINtz8RXyOZ
    26XhjXjiVzyyiZl7lgyFx4SPmfxoSq7xcOSlAEHnOedLzi2+YqGa51d4XoI8h+Ye
    Z+EFtQChb5H4pAtrSpqrHMLbT2AME+SNWQB+jpo/v6TFdDErp7kwJN4SoGBkSsR2
    WKce4f6sNThLSJUdezzXeN8AyD44WIPMlLLVioq0kb8MTFSuFgtaHHePxHWzr9/C
    lfNE2slvw4NrTHjBv7Nw6BuA3pnRYKTWFRWLn99+lhVVTd01afw4FnP0olKit38Z
    bZHrvzPhKP5TTd1rJFwgNsijBFRRq1wwc0OBwlz1NcvL2sQM+EA==
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
        id S1753072AbeB1QAV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:00:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34651 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753064AbeB1QAU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:20 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Christoph Hellwig" <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Huacai Chen" <chenhc@lemote.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.454612149@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 010/254] scsi: libsas: align sata_device's rps_resp
 on a cacheline
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/scsi/libsas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -170,11 +170,11 @@ enum ata_command_set {
 
 struct sata_device {
         enum   ata_command_set command_set;
-        struct smp_resp        rps_resp; /* report_phy_sata_resp */
         u8     port_no;        /* port number, if this is a PM (Port) */
 
 	struct ata_port *ap;
 	struct ata_host ata_host;
+	struct smp_resp rps_resp ____cacheline_aligned; /* report_phy_sata_resp */
 	u8     fis[ATA_RESP_FIS_SIZE];
 };
 
