Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518325599-2-12214145949420108178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325599; b=QjOes35rLyEKED/fzMtsl8i1dg8qICYQEL6f97DbFNtYavG
    zifR36WXgeFudRdoLU7Zc2454u+R4OKmrcMwhuuu6ecPpx1fKELv9tW030R+Sb73
    s4DmE1PWDlHvK90O/vmUKj1JrR7FoIS9xZ7X8TdisE7atqRSdBhLc0ocZBKniFLk
    e9FQAyDo1Re2amrloABysA/WLbf+73rDYu65Jw64GRwKeIWL1KdvE/d5MkO4vZ0n
    QiEyhbpc6ePhPHWZRyH934l8Xmdsjm0HATflKVuAj24mocRx6iBwPLRDqZYQTd30
    OHJz2sYhwpwfOWSSF3+R8Ap4WKfEe+SRKsI5KNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325599; bh=y606sNS29rhpbq9PO3D
    qtEwfYsNZWGFu4tvZ4pIHdIQ=; b=tmGRi2sPevBNcxsPTZSE8ehOl+A7SlAtX3h
    EgG+apaMT6Lr9eJCtQIddzKbyoyndjBeHe8A/OaagJJ75XnkMl7bRxgy4u5gkAeU
    Sh2VeXONpXMaN2780bzfZvZEOqxVHzz+dH11VmfRyt7qavJh8+T2KZznbVvyhUcy
    i+0AMAneVCPrb2qSbQP0nnhFL08FT0DiqkbXDiIzIxdB53bxogkF6ZHAXzZyzgE9
    /kLVWXtsHnIiw4KewjGyN0KyqDKgY8+v6m+T6BqpPtNOe6GalWqnd3/sEZoNNQNa
    MMuVSFYsZpIkqaxRWicX4zZ3HcRPrM/RB6O3yiYRavYayxB3vBA==
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
        id S1753782AbeBKFFm (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:05:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41500 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752676AbeBKEdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:43 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@free-electrons.com>,
        "Brent Taylor" <motobud@gmail.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.274990324@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 23/79] mtd: nand: Fix writing mtdoops to nand flash.
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Brent Taylor <motobud@gmail.com>

commit 30863e38ebeb500a31cecee8096fb5002677dd9b upstream.

When mtdoops calls mtd_panic_write(), it eventually calls
panic_nand_write() in nand_base.c. In order to properly wait for the
nand chip to be ready in panic_nand_wait(), the chip must first be
selected.

When using the atmel nand flash controller, a panic would occur due to
a NULL pointer exception.

Fixes: 2af7c6539931 ("mtd: Add panic_write for NAND flashes")
Signed-off-by: Brent Taylor <motobud@gmail.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/nand/nand_base.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2290,6 +2290,7 @@ static int panic_nand_write(struct mtd_i
 			    size_t *retlen, const uint8_t *buf)
 {
 	struct nand_chip *chip = mtd->priv;
+	int chipnr = (int)(to >> chip->chip_shift);
 	struct mtd_oob_ops ops;
 	int ret;
 
@@ -2299,12 +2300,14 @@ static int panic_nand_write(struct mtd_i
 	if (!len)
 		return 0;
 
-	/* Wait for the device to get ready */
-	panic_nand_wait(mtd, chip, 400);
-
 	/* Grab the device */
 	panic_nand_get_device(chip, mtd, FL_WRITING);
 
+	chip->select_chip(mtd, chipnr);
+
+	/* Wait for the device to get ready */
+	panic_nand_wait(mtd, chip, 400);
+
 	ops.len = len;
 	ops.datbuf = (uint8_t *)buf;
 	ops.oobbuf = NULL;
