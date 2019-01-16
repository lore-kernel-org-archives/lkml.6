Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB2AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7970F206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 19:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llEKrwug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfAPTvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 14:51:47 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39327 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731691AbfAPTvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 14:51:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so3327438wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 11:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SfLHsFdGJBWSULrI/JrLIMXZuHcal7zVDCKaPfdAxM=;
        b=llEKrwugZp6FUFyPmd45CYzhmvyPO4a7wxEVsWDdUGd/Bo6Vl6YS/mY/Wi8ztUfmYx
         n8JmJ1Sb3SC6zeR+vIiHF1IHulhqNPf6IYpwzmWc5Nk/aTXk0EI/nhuUIxC0bJnP9mxj
         vFUMuUL1f25DDaiWLG1qO2cJ3XTYYJZHtJpvzIiCNgPdfaEEJfneR9pZ5ZzMEyuWj4Gs
         NYjEm7DJbt4yk9zjdDgRoP63IvWEWsvjJSunkC2WPcfENmuE1nj5TcDVIeL3j2YLCaZh
         QMOy55LbXP0+wQoYMsaLX3+dXHWoCHRsgoOAfRfFRZo4xqMdM0YaTjfmANraN8Cncbs4
         yKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9SfLHsFdGJBWSULrI/JrLIMXZuHcal7zVDCKaPfdAxM=;
        b=GncCdkuKkTh9BJYvrdq1b6j8ZVZJ9kzy4Ivlk02DrbDk5xFUEq36rHHpI3lznv65oV
         49t+ME5E8IyASLJ3lPiUHO/3U/QF6QOL1h55wO81WG4pORMiX3OU88dygu95Q5eaizVV
         SOTKC6bdocUR8cp9T2c4ebDBEF61u9jlU0tfD1Z9ZrKqbcGvvOzfWrrcBh50es3WqdLt
         sxwxoghih2TpUDEnIbJRAyWcHpwheMnwKrDwYEqFPzdAwppwmcq1kfEjeV6Dygnbr8MR
         MY5mw6OOKyb06Vzg6XIdBdQL5KCmW4pfMSQ9QrgdBh7UWR29IzfvhBtWGEsm57N9LyIc
         K3LA==
X-Gm-Message-State: AJcUukfeiixtBw7KoH0ehXB6uA0IcYx2Du5yY8fDeh0ON29iOtkddsi3
        6uNSGRyU3RaQ2yVnRBBBIAo=
X-Google-Smtp-Source: ALg8bN4rkaXwUisbCE5/5dZajKtebFcyV1VJLZfMy1mDxfRGCno1mCl1XNeGC/yd8FlGtke0iX7TEA==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr9198412wmh.87.1547668305893;
        Wed, 16 Jan 2019 11:51:45 -0800 (PST)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id v6sm34247343wrd.88.2019.01.16.11.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 11:51:45 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id CA5C711423A3; Wed, 16 Jan 2019 20:51:38 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: Annotate implicit fall through in nand_scan_tail
Date:   Wed, 16 Jan 2019 20:50:04 +0100
Message-Id: <20190116195004.2499-2-malat@debian.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190116195004.2499-1-malat@debian.org>
References: <20190116195004.2499-1-malat@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1).

This commit removes the following warnings:

  drivers/mtd/nand/raw/nand_base.c:5556:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/mtd/nand/raw/nand_base.c:5575:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
  drivers/mtd/nand/raw/nand_base.c:5613:13: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 drivers/mtd/nand/raw/nand_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index cca4b24d2ffa..da344c276088 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5555,6 +5555,7 @@ static int nand_scan_tail(struct nand_chip *chip)
 		}
 		if (!ecc->read_page)
 			ecc->read_page = nand_read_page_hwecc_oob_first;
+		/* fall through */
 
 	case NAND_ECC_HW:
 		/* Use standard hwecc read page function? */
@@ -5574,6 +5575,7 @@ static int nand_scan_tail(struct nand_chip *chip)
 			ecc->read_subpage = nand_read_subpage;
 		if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
 			ecc->write_subpage = nand_write_subpage_hwecc;
+		/* fall through */
 
 	case NAND_ECC_HW_SYNDROME:
 		if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
@@ -5611,6 +5613,7 @@ static int nand_scan_tail(struct nand_chip *chip)
 			ecc->size, mtd->writesize);
 		ecc->mode = NAND_ECC_SOFT;
 		ecc->algo = NAND_ECC_HAMMING;
+		/* fall through */
 
 	case NAND_ECC_SOFT:
 		ret = nand_set_ecc_soft_ops(chip);
-- 
2.19.2

