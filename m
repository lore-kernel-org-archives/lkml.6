Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838708-2-18026970680501934829
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
    t=1519838707; b=VYYvC/PQowqbDQbjxuNRz8OLKH+GtC3uo0rj6ukQml8Oj5a
    yC466DEGfSoGWoHC6zsRfYLLtKJhg5Hwp5bgxlNLDmChUB40TD7W4/DG0JAS05OK
    +ZHBDb7FxaP4OvTZXwIaa2y9UIs+mIivG7MAUxjooegZ28IbP13rlTERZW0kYeBW
    IbHJxjoTurFi0MMgPkC9m6jAoAQ1LIKwH8WxI/ut82Fc32TFxyFnxS5M2qGVdBVd
    GLJ6KgEcahBdlW71k5IWPgeiklRIrvIi2vlgjT+jKrqGGo04rM9bchicGluVc+9O
    JImBWyJBJUY3tjntyhtqZG3d/XenHLtsUMj+3oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838707; bh=uJf8abSJ/DRF+iJEZ9z
    PBOn29Om4lvz+Q9/VTC8dCmI=; b=IX3lTullR8QtASPVNjwS8l0KGYJcT4P2dJ5
    5et3ail4SDOzPzcPqt9OGTg1f1CVeyP1Uzzm+RU52n3HYFwm5QZYGAwvO6GIfW8t
    O5P2N00d4PVfqFAmu0oKcRK4D6ezZSQOZs0mFXniD9+JyfvBqnfCkbQVdiH4A1h7
    urvrb2CkrXSx+K1hHCWA3QVS+kSghUCWHKee6wXNdibvi69xUdZtIYbi15Y4W4gJ
    DYjVqpks9XysSrURcb/+3IJixECi5eGy0GzuoH4Hj4eS7QH7oHC7O5aLhw1SyvQs
    PhUmD5r4akKADpF3O6RRtn6mlF6D1lLtJ9cUzl9Hpup+zlLTKsg==
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
        id S1753361AbeB1RZF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:25:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33327 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932618AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Huacai Chen" <chenhc@lemote.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.512757025@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 007/140] scsi: use dma_get_cache_alignment() as
 minimum DMA alignment
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

commit 90addc6b3c9cda0146fbd62a08e234c2b224a80c upstream.

In non-coherent DMA mode, kernel uses cache flushing operations to
maintain I/O coherency, so scsi's block queue should be aligned to the
value returned by dma_get_cache_alignment().  Otherwise, If a DMA buffer
and a kernel structure share a same cache line, and if the kernel
structure has dirty data, cache_invalidate (no writeback) will cause
data corruption.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
[hch: rebased and updated the comment and changelog]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/scsi_lib.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1688,11 +1688,13 @@ struct request_queue *__scsi_alloc_queue
 		q->limits.cluster = 0;
 
 	/*
-	 * set a reasonable default alignment on word boundaries: the
-	 * host and device may alter it using
-	 * blk_queue_update_dma_alignment() later.
+	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
+	 * which is a common minimum for HBAs, and the minimum DMA alignment,
+	 * which is set by the platform.
+	 *
+	 * Devices that require a bigger alignment can increase it later.
 	 */
-	blk_queue_dma_alignment(q, 0x03);
+	blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment()) - 1);
 
 	return q;
 }
