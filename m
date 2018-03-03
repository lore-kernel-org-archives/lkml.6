Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4109688-1520073884-2-5081758442873106019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520073884; b=oRS8aNDWeudfR8zATlY9D03lV1IVkPLdNe1zujYx9urhJmK
    u6929rgfzzBRmj17qf16nlsyzA/Pvg1LWd6cSglNH9f40SHZR8F9VA2aRj4ba+mM
    +zRo6/pmxIxuKz43ZwL10bN47AoWLNc0174SsqTVZmRLZQXVV65uIyKMfxOw7U+k
    fbAgPSCLl4d+KAZE5XKoCzeb8uAzNuK6FTRZVDuL6QU8crvvnggMB9XmD8bHCgDr
    bjNKIPKnt8jsrTKuGyPdZVO05yJSASdz7g9daMxxoTHpNFdJR19zbBMg9HSX32rQ
    YIi+FFfraxDiAdpeGfaM6lsUHuUQyCQn+6bLqgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520073884; bh=cWv9rN0qTaBaGrPa7MdLcEFDmB
    n2uyJTUnF68ccq5NU=; b=wRqRUfyW/tm2pFZ3xE9/mlibVKfX2U6Zd7wXkfGYBG
    89GbwbInm+lMPO+tLfVkrVxT6SZmascnYGOc4mY6Plhm3xYXCh7l0pFUvU3k2m0t
    cOy7H5pSBHtJKSjsp2QAVL/mWObefSl9+9E/KCUJLhAU6nmshANKQyXMZ0tEzqUQ
    S5zSvxKQ2WGLwQyyw25wAClmTF2jfVQnL1KDGhHBeQkn/CeF+vIENS0pHXloH3zY
    QLicHhIImSVjzwe3bzNyBWTXy1yD40is0F7FPzFcXVQk7kXndYQ35OlNJpsy77ZK
    Hhat/Adfp6ECL8mye548Ft7db+vOvdnzRgF06Cc7X1iQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nod.at header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeCCKol (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 05:44:41 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:49960 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeCCKol (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 05:44:41 -0500
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, cyrille.pitchen@wedev4u.fr,
        marek.vasut@gmail.com, boris.brezillon@free-electrons.com,
        computersforpeace@gmail.com, dwmw2@infradead.org, richard@nod.at,
        dedekind1@gmail.com, tharvey@gateworks.com, stable@vger.kernel.org
Subject: [PATCH] ubi: Reject MLC NAND
Date: Sat,  3 Mar 2018 11:45:54 +0100
Message-Id: <20180303104554.5958-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

While UBI and UBIFS seem to work at first sight with MLC NAND, you will
most likely lose all your data upon a power-cut or due to read/write
disturb.
In order to protect users from bad surprises, refuse to attach to MLC
NAND.

Cc: stable@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/build.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index e941395de3ae..753494e042d5 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -854,6 +854,17 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 		return -EINVAL;
 	}
 
+	/*
+	 * Both UBI and UBIFS have been designed for SLC NAND and NOR flashes.
+	 * MLC NAND is different and needs special care, otherwise UBI or UBIFS
+	 * will die soon and you will lose all your data.
+	 */
+	if (mtd->type == MTD_MLCNANDFLASH) {
+		pr_err("ubi: refuse attaching mtd%d - MLC NAND is not supported\n",
+			mtd->index);
+		return -EINVAL;
+	}
+
 	if (ubi_num == UBI_DEV_NUM_AUTO) {
 		/* Search for an empty slot in the @ubi_devices array */
 		for (ubi_num = 0; ubi_num < UBI_MAX_DEVICES; ubi_num++)
-- 
2.13.6
