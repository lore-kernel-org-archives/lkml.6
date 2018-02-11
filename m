Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324157-2-9858318670699189840
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324156; b=mOKprM6mhOblgo9x2e05n4/JemOeFWojdU9m3gD64yDKBg+
    GOzQffkoqmgFjVHaSMnrkH22CwSmec1dcT6YiiRgL4TXBimAIXA0rLUNUX7aCDkc
    i1ZGQ2uxpNwzJLXp5P43fOazm7ZtMCCizASaU4jO3UlAYN9Nyvw1cVINpAOgJv8y
    Q9+cXljX57omQEukGDX2ml3BDA6px+WmBxPngt4lTMW76U9e71IYBx44udz6mihG
    lNtUz7v49yK+FHFN3ba3j2plIlUqPFmas038TjCZN2CcOidRd72ZhRz/y+1+iMut
    b5Uz+beVJH+KiD5qlgBUgCp+0aqQvuscLULiSDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324156; bh=GcoJL17iLzutBgAFkWL
    Ht+12vYgvSwN2FRqzqcq2NS8=; b=SCfo4NteAXrgwFDSGjxA9WFmwRrQ8RB77RH
    feOFcCHXjOBCXPj1mYTVxTTyonFiCXZOtOCLUKuHA4n96Un+moIW62tr70vKPDsj
    W3Ic1k6hYjKbsNTDCyv6g4PvxPjWC7TahgKv09o18m6q44KlHgj+wg/N4SCN3D8A
    SDsd8rfzRpKCRqCo+Jdzhl/Wao+S8e/gCSxucSglaqQ/pQ+VXoGPV8JjQP0zHPlT
    1laAVEfoSOFARyAEFts4krmRBRUXwfUAXNaC9pIYWxzq85zJfPqu1CrvDdHkPw6M
    2ERQfjSLk7oz/JTfQAjzxtFKvaNPXbie4wJTL0XMVnsY6mS4CfA==
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
        id S1753139AbeBKEkz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:40:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41665 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752925AbeBKEeG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:06 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@free-electrons.com>,
        "Roger Quadros" <rogerq@ti.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.256003166@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 031/136] mtd: nand: omap2: Fix subpage write
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Roger Quadros <rogerq@ti.com>

commit 739c64414f01748a36e7d82c8e0611dea94412bd upstream.

Since v4.12, NAND subpage writes were causing a NULL pointer
dereference on OMAP platforms (omap2-nand) using OMAP_ECC_BCH4_CODE_HW,
OMAP_ECC_BCH8_CODE_HW and OMAP_ECC_BCH16_CODE_HW.

This is because for those ECC modes, omap_calculate_ecc_bch()
generates ECC bytes for the entire (multi-sector) page and this can
overflow the ECC buffer provided by nand_write_subpage_hwecc()
as it expects ecc.calculate() to return ECC bytes for just one sector.

However, the root cause of the problem is present since v3.9
but was not seen then as NAND buffers were being allocated
as one big chunk prior to commit 3deb9979c731 ("mtd: nand: allocate
aligned buffers if NAND_OWN_BUFFERS is unset").

Fix the issue by providing a OMAP optimized write_subpage()
implementation.

Fixes: 62116e5171e0 ("mtd: nand: omap2: Support for hardware BCH error correction.")
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
[bwh: Backported to 3.16:
 - Open-code mtd_to_omap()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1163,130 +1163,174 @@ static u8  bch8_polynomial[] = {0xef, 0x
 				0x97, 0x79, 0xe5, 0x24, 0xb5};
 
 /**
- * omap_calculate_ecc_bch - Generate bytes of ECC bytes
+ * _omap_calculate_ecc_bch - Generate ECC bytes for one sector
  * @mtd:	MTD device structure
  * @dat:	The pointer to data on which ecc is computed
  * @ecc_code:	The ecc_code buffer
+ * @i:		The sector number (for a multi sector page)
  *
- * Support calculating of BCH4/8 ecc vectors for the page
+ * Support calculating of BCH4/8/16 ECC vectors for one sector
+ * within a page. Sector number is in @i.
  */
-static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
-					const u_char *dat, u_char *ecc_calc)
+static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
+				   const u_char *dat, u_char *ecc_calc, int i)
 {
 	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
 						   mtd);
 	int eccbytes	= info->nand.ecc.bytes;
 	struct gpmc_nand_regs	*gpmc_regs = &info->reg;
 	u8 *ecc_code;
-	unsigned long nsectors, bch_val1, bch_val2, bch_val3, bch_val4;
+	unsigned long bch_val1, bch_val2, bch_val3, bch_val4;
 	u32 val;
-	int i, j;
+	int j;
+
+	ecc_code = ecc_calc;
+	switch (info->ecc_opt) {
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH8_CODE_HW:
+		bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
+		bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
+		bch_val3 = readl(gpmc_regs->gpmc_bch_result2[i]);
+		bch_val4 = readl(gpmc_regs->gpmc_bch_result3[i]);
+		*ecc_code++ = (bch_val4 & 0xFF);
+		*ecc_code++ = ((bch_val3 >> 24) & 0xFF);
+		*ecc_code++ = ((bch_val3 >> 16) & 0xFF);
+		*ecc_code++ = ((bch_val3 >> 8) & 0xFF);
+		*ecc_code++ = (bch_val3 & 0xFF);
+		*ecc_code++ = ((bch_val2 >> 24) & 0xFF);
+		*ecc_code++ = ((bch_val2 >> 16) & 0xFF);
+		*ecc_code++ = ((bch_val2 >> 8) & 0xFF);
+		*ecc_code++ = (bch_val2 & 0xFF);
+		*ecc_code++ = ((bch_val1 >> 24) & 0xFF);
+		*ecc_code++ = ((bch_val1 >> 16) & 0xFF);
+		*ecc_code++ = ((bch_val1 >> 8) & 0xFF);
+		*ecc_code++ = (bch_val1 & 0xFF);
+		break;
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH4_CODE_HW:
+		bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
+		bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
+		*ecc_code++ = ((bch_val2 >> 12) & 0xFF);
+		*ecc_code++ = ((bch_val2 >> 4) & 0xFF);
+		*ecc_code++ = ((bch_val2 & 0xF) << 4) |
+			((bch_val1 >> 28) & 0xF);
+		*ecc_code++ = ((bch_val1 >> 20) & 0xFF);
+		*ecc_code++ = ((bch_val1 >> 12) & 0xFF);
+		*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
+		*ecc_code++ = ((bch_val1 & 0xF) << 4);
+		break;
+	case OMAP_ECC_BCH16_CODE_HW:
+		val = readl(gpmc_regs->gpmc_bch_result6[i]);
+		ecc_code[0]  = ((val >>  8) & 0xFF);
+		ecc_code[1]  = ((val >>  0) & 0xFF);
+		val = readl(gpmc_regs->gpmc_bch_result5[i]);
+		ecc_code[2]  = ((val >> 24) & 0xFF);
+		ecc_code[3]  = ((val >> 16) & 0xFF);
+		ecc_code[4]  = ((val >>  8) & 0xFF);
+		ecc_code[5]  = ((val >>  0) & 0xFF);
+		val = readl(gpmc_regs->gpmc_bch_result4[i]);
+		ecc_code[6]  = ((val >> 24) & 0xFF);
+		ecc_code[7]  = ((val >> 16) & 0xFF);
+		ecc_code[8]  = ((val >>  8) & 0xFF);
+		ecc_code[9]  = ((val >>  0) & 0xFF);
+		val = readl(gpmc_regs->gpmc_bch_result3[i]);
+		ecc_code[10] = ((val >> 24) & 0xFF);
+		ecc_code[11] = ((val >> 16) & 0xFF);
+		ecc_code[12] = ((val >>  8) & 0xFF);
+		ecc_code[13] = ((val >>  0) & 0xFF);
+		val = readl(gpmc_regs->gpmc_bch_result2[i]);
+		ecc_code[14] = ((val >> 24) & 0xFF);
+		ecc_code[15] = ((val >> 16) & 0xFF);
+		ecc_code[16] = ((val >>  8) & 0xFF);
+		ecc_code[17] = ((val >>  0) & 0xFF);
+		val = readl(gpmc_regs->gpmc_bch_result1[i]);
+		ecc_code[18] = ((val >> 24) & 0xFF);
+		ecc_code[19] = ((val >> 16) & 0xFF);
+		ecc_code[20] = ((val >>  8) & 0xFF);
+		ecc_code[21] = ((val >>  0) & 0xFF);
+		val = readl(gpmc_regs->gpmc_bch_result0[i]);
+		ecc_code[22] = ((val >> 24) & 0xFF);
+		ecc_code[23] = ((val >> 16) & 0xFF);
+		ecc_code[24] = ((val >>  8) & 0xFF);
+		ecc_code[25] = ((val >>  0) & 0xFF);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* ECC scheme specific syndrome customizations */
+	switch (info->ecc_opt) {
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+		/* Add constant polynomial to remainder, so that
+		 * ECC of blank pages results in 0x0 on reading back
+		 */
+		for (j = 0; j < eccbytes; j++)
+			ecc_calc[j] ^= bch4_polynomial[j];
+		break;
+	case OMAP_ECC_BCH4_CODE_HW:
+		/* Set  8th ECC byte as 0x0 for ROM compatibility */
+		ecc_calc[eccbytes - 1] = 0x0;
+		break;
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+		/* Add constant polynomial to remainder, so that
+		 * ECC of blank pages results in 0x0 on reading back
+		 */
+		for (j = 0; j < eccbytes; j++)
+			ecc_calc[j] ^= bch8_polynomial[j];
+		break;
+	case OMAP_ECC_BCH8_CODE_HW:
+		/* Set 14th ECC byte as 0x0 for ROM compatibility */
+		ecc_calc[eccbytes - 1] = 0x0;
+		break;
+	case OMAP_ECC_BCH16_CODE_HW:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * omap_calculate_ecc_bch_sw - ECC generator for sector for SW based correction
+ * @mtd:	MTD device structure
+ * @dat:	The pointer to data on which ecc is computed
+ * @ecc_code:	The ecc_code buffer
+ *
+ * Support calculating of BCH4/8/16 ECC vectors for one sector. This is used
+ * when SW based correction is required as ECC is required for one sector
+ * at a time.
+ */
+static int omap_calculate_ecc_bch_sw(struct mtd_info *mtd,
+				     const u_char *dat, u_char *ecc_calc)
+{
+	return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
+}
+
+/**
+ * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
+ * @mtd:	MTD device structure
+ * @dat:	The pointer to data on which ecc is computed
+ * @ecc_code:	The ecc_code buffer
+ *
+ * Support calculating of BCH4/8/16 ecc vectors for the entire page in one go.
+ */
+static int omap_calculate_ecc_bch_multi(struct mtd_info *mtd,
+					const u_char *dat, u_char *ecc_calc)
+{
+	struct omap_nand_info *info = container_of(mtd, struct omap_nand_info,
+						   mtd);
+	int eccbytes = info->nand.ecc.bytes;
+	unsigned long nsectors;
+	int i, ret;
 
 	nsectors = ((readl(info->reg.gpmc_ecc_config) >> 4) & 0x7) + 1;
 	for (i = 0; i < nsectors; i++) {
-		ecc_code = ecc_calc;
-		switch (info->ecc_opt) {
-		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-		case OMAP_ECC_BCH8_CODE_HW:
-			bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
-			bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
-			bch_val3 = readl(gpmc_regs->gpmc_bch_result2[i]);
-			bch_val4 = readl(gpmc_regs->gpmc_bch_result3[i]);
-			*ecc_code++ = (bch_val4 & 0xFF);
-			*ecc_code++ = ((bch_val3 >> 24) & 0xFF);
-			*ecc_code++ = ((bch_val3 >> 16) & 0xFF);
-			*ecc_code++ = ((bch_val3 >> 8) & 0xFF);
-			*ecc_code++ = (bch_val3 & 0xFF);
-			*ecc_code++ = ((bch_val2 >> 24) & 0xFF);
-			*ecc_code++ = ((bch_val2 >> 16) & 0xFF);
-			*ecc_code++ = ((bch_val2 >> 8) & 0xFF);
-			*ecc_code++ = (bch_val2 & 0xFF);
-			*ecc_code++ = ((bch_val1 >> 24) & 0xFF);
-			*ecc_code++ = ((bch_val1 >> 16) & 0xFF);
-			*ecc_code++ = ((bch_val1 >> 8) & 0xFF);
-			*ecc_code++ = (bch_val1 & 0xFF);
-			break;
-		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-		case OMAP_ECC_BCH4_CODE_HW:
-			bch_val1 = readl(gpmc_regs->gpmc_bch_result0[i]);
-			bch_val2 = readl(gpmc_regs->gpmc_bch_result1[i]);
-			*ecc_code++ = ((bch_val2 >> 12) & 0xFF);
-			*ecc_code++ = ((bch_val2 >> 4) & 0xFF);
-			*ecc_code++ = ((bch_val2 & 0xF) << 4) |
-				((bch_val1 >> 28) & 0xF);
-			*ecc_code++ = ((bch_val1 >> 20) & 0xFF);
-			*ecc_code++ = ((bch_val1 >> 12) & 0xFF);
-			*ecc_code++ = ((bch_val1 >> 4) & 0xFF);
-			*ecc_code++ = ((bch_val1 & 0xF) << 4);
-			break;
-		case OMAP_ECC_BCH16_CODE_HW:
-			val = readl(gpmc_regs->gpmc_bch_result6[i]);
-			ecc_code[0]  = ((val >>  8) & 0xFF);
-			ecc_code[1]  = ((val >>  0) & 0xFF);
-			val = readl(gpmc_regs->gpmc_bch_result5[i]);
-			ecc_code[2]  = ((val >> 24) & 0xFF);
-			ecc_code[3]  = ((val >> 16) & 0xFF);
-			ecc_code[4]  = ((val >>  8) & 0xFF);
-			ecc_code[5]  = ((val >>  0) & 0xFF);
-			val = readl(gpmc_regs->gpmc_bch_result4[i]);
-			ecc_code[6]  = ((val >> 24) & 0xFF);
-			ecc_code[7]  = ((val >> 16) & 0xFF);
-			ecc_code[8]  = ((val >>  8) & 0xFF);
-			ecc_code[9]  = ((val >>  0) & 0xFF);
-			val = readl(gpmc_regs->gpmc_bch_result3[i]);
-			ecc_code[10] = ((val >> 24) & 0xFF);
-			ecc_code[11] = ((val >> 16) & 0xFF);
-			ecc_code[12] = ((val >>  8) & 0xFF);
-			ecc_code[13] = ((val >>  0) & 0xFF);
-			val = readl(gpmc_regs->gpmc_bch_result2[i]);
-			ecc_code[14] = ((val >> 24) & 0xFF);
-			ecc_code[15] = ((val >> 16) & 0xFF);
-			ecc_code[16] = ((val >>  8) & 0xFF);
-			ecc_code[17] = ((val >>  0) & 0xFF);
-			val = readl(gpmc_regs->gpmc_bch_result1[i]);
-			ecc_code[18] = ((val >> 24) & 0xFF);
-			ecc_code[19] = ((val >> 16) & 0xFF);
-			ecc_code[20] = ((val >>  8) & 0xFF);
-			ecc_code[21] = ((val >>  0) & 0xFF);
-			val = readl(gpmc_regs->gpmc_bch_result0[i]);
-			ecc_code[22] = ((val >> 24) & 0xFF);
-			ecc_code[23] = ((val >> 16) & 0xFF);
-			ecc_code[24] = ((val >>  8) & 0xFF);
-			ecc_code[25] = ((val >>  0) & 0xFF);
-			break;
-		default:
-			return -EINVAL;
-		}
-
-		/* ECC scheme specific syndrome customizations */
-		switch (info->ecc_opt) {
-		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-			/* Add constant polynomial to remainder, so that
-			 * ECC of blank pages results in 0x0 on reading back */
-			for (j = 0; j < eccbytes; j++)
-				ecc_calc[j] ^= bch4_polynomial[j];
-			break;
-		case OMAP_ECC_BCH4_CODE_HW:
-			/* Set  8th ECC byte as 0x0 for ROM compatibility */
-			ecc_calc[eccbytes - 1] = 0x0;
-			break;
-		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-			/* Add constant polynomial to remainder, so that
-			 * ECC of blank pages results in 0x0 on reading back */
-			for (j = 0; j < eccbytes; j++)
-				ecc_calc[j] ^= bch8_polynomial[j];
-			break;
-		case OMAP_ECC_BCH8_CODE_HW:
-			/* Set 14th ECC byte as 0x0 for ROM compatibility */
-			ecc_calc[eccbytes - 1] = 0x0;
-			break;
-		case OMAP_ECC_BCH16_CODE_HW:
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret = _omap_calculate_ecc_bch(mtd, dat, ecc_calc, i);
+		if (ret)
+			return ret;
 
-	ecc_calc += eccbytes;
+		ecc_calc += eccbytes;
 	}
 
 	return 0;
@@ -1527,7 +1571,7 @@ static int omap_write_page_bch(struct mt
 	chip->write_buf(mtd, buf, mtd->writesize);
 
 	/* Update ecc vector from GPMC result registers */
-	chip->ecc.calculate(mtd, buf, &ecc_calc[0]);
+	omap_calculate_ecc_bch_multi(mtd, buf, &ecc_calc[0]);
 
 	for (i = 0; i < chip->ecc.total; i++)
 		chip->oob_poi[eccpos[i]] = ecc_calc[i];
@@ -1538,6 +1582,72 @@ static int omap_write_page_bch(struct mt
 }
 
 /**
+ * omap_write_subpage_bch - BCH hardware ECC based subpage write
+ * @mtd:	mtd info structure
+ * @chip:	nand chip info structure
+ * @offset:	column address of subpage within the page
+ * @data_len:	data length
+ * @buf:	data buffer
+ * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
+ *
+ * OMAP optimized subpage write method.
+ */
+static int omap_write_subpage_bch(struct mtd_info *mtd,
+				  struct nand_chip *chip, u32 offset,
+				  u32 data_len, const u8 *buf,
+				  int oob_required, int page)
+{
+	u8 *ecc_calc = chip->buffers->ecccalc;
+	int ecc_size      = chip->ecc.size;
+	int ecc_bytes     = chip->ecc.bytes;
+	int ecc_steps     = chip->ecc.steps;
+	u32 start_step = offset / ecc_size;
+	u32 end_step   = (offset + data_len - 1) / ecc_size;
+	int step, ret = 0;
+
+	/*
+	 * Write entire page at one go as it would be optimal
+	 * as ECC is calculated by hardware.
+	 * ECC is calculated for all subpages but we choose
+	 * only what we want.
+	 */
+
+	/* Enable GPMC ECC engine */
+	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+
+	/* Write data */
+	chip->write_buf(mtd, buf, mtd->writesize);
+
+	for (step = 0; step < ecc_steps; step++) {
+		/* mask ECC of un-touched subpages by padding 0xFF */
+		if (step < start_step || step > end_step)
+			memset(ecc_calc, 0xff, ecc_bytes);
+		else
+			ret = _omap_calculate_ecc_bch(mtd, buf, ecc_calc, step);
+
+		if (ret)
+			return ret;
+
+		buf += ecc_size;
+		ecc_calc += ecc_bytes;
+	}
+
+	/* copy calculated ECC for whole page to chip->buffer->oob */
+	/* this include masked-value(0xFF) for unwritten subpages */
+	ecc_calc = chip->buffers->ecccalc;
+	ret = mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
+
+	/* write OOB buffer to NAND device */
+	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
+}
+
+/**
  * omap_read_page_bch - BCH ecc based page read function for entire page
  * @mtd:		mtd info structure
  * @chip:		nand chip info structure
@@ -1574,7 +1684,7 @@ static int omap_read_page_bch(struct mtd
 	chip->read_buf(mtd, oob, chip->ecc.total);
 
 	/* Calculate ecc bytes */
-	chip->ecc.calculate(mtd, buf, ecc_calc);
+	omap_calculate_ecc_bch_multi(mtd, buf, ecc_calc);
 
 	memcpy(ecc_code, &chip->oob_poi[eccpos[0]], chip->ecc.total);
 
@@ -1823,7 +1933,7 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 4;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1863,9 +1973,9 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 4;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap_elm_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1898,7 +2008,7 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 8;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= nand_bch_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
+		nand_chip->ecc.calculate	= omap_calculate_ecc_bch_sw;
 		/* define ECC layout */
 		ecclayout->eccbytes		= nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1939,9 +2049,9 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 8;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap_elm_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
 		/* This ECC scheme requires ELM H/W block */
 		err = is_elm_present(info, pdata->elm_of_node, BCH8_ECC);
 		if (err < 0) {
@@ -1974,9 +2084,9 @@ static int omap_nand_probe(struct platfo
 		nand_chip->ecc.strength		= 16;
 		nand_chip->ecc.hwctl		= omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		= omap_elm_correct_data;
-		nand_chip->ecc.calculate	= omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	= omap_read_page_bch;
 		nand_chip->ecc.write_page	= omap_write_page_bch;
+		nand_chip->ecc.write_subpage	= omap_write_subpage_bch;
 		/* This ECC scheme requires ELM H/W block */
 		err = is_elm_present(info, pdata->elm_of_node, BCH16_ECC);
 		if (err < 0) {
