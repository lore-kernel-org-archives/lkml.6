Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAB0C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369222146E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="pcSab4X3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfAYMhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:37:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35879 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYMhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:37:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so6824525lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 04:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VhZ+784RV1v5pTFCPCy7Q4ULT9fiRZPvud4Y3Kgl1I=;
        b=pcSab4X3EGzcyJeOR660pdHEMGhTcHpOtSdXZ/p8MG9Jpq42fP7ho7ppeoctTiin/p
         y40iAwtk5hFrx8UJfaaUyV96emj91b4Va0uyNS4gj0M4rjfk7JCKw4TZ5ZIDOwApoZSo
         Fih/Fv+PlIGFV/mHP5ALL1Usp85y8w7efYmKfczFt1WCoXq2Tv4vATGr58sbEmKaa4u4
         pPy3V+kCxCVZuyT/+RUbhj8FhL//P7/sbiKheeN13rmD9jx4alZCcQLEkUhl/w2R5GEu
         svAeeNtB7PMmbxvcdhTaLX1BKBZ12IUI85yBx4TxdC30rNlUgGoDbMK8BSRkh9HAEOgF
         Phqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/VhZ+784RV1v5pTFCPCy7Q4ULT9fiRZPvud4Y3Kgl1I=;
        b=nEM7s/wbW+KR7M+f+DX3pdaQ1oy1BG18KEaiOXerzMDzZJQdIi0eYToWSBZYd5cj6r
         JlZ+1b7cwApJR2/LLj6sXQ8s1/eBL2g2v59Eq1toxjBMo55LD7qZzKO+YnhorFP0jGXs
         R7a7coTBtxuxOqZepioFkQYQ41W3pVn1XhkrpAi3WZkvb341XPb+A/5wvBWVfzxDIdGF
         +smGVdU+6uPTpMVdAvzZV26jP7sRzpQpX3dJn1UIofA3N5eTe2aSTfH29rlyGWG/VGLG
         jwQt9li4zpW6OHD119XIkPpG6lyr/zJRf6/rIgjGGXHs0JGjOMTy5F1PYnTt/Mk51ACq
         3CtA==
X-Gm-Message-State: AJcUukdx9h90OF1ebBCSXoujKHAiv/cCby9RNra1ekqwc2ueYRQNpSfh
        9zbF3bcayBfhrbGDaKMeb4OkytTkco4=
X-Google-Smtp-Source: ALg8bN75UpBxZRFnBIkPDaonR1Jo1f4LJ/5B1jWoYLbG1WZ/7TSpgDw0C1hqayHHrul9hioY3mdmTw==
X-Received: by 2002:a19:6719:: with SMTP id b25mr8565012lfc.38.1548419852884;
        Fri, 25 Jan 2019 04:37:32 -0800 (PST)
Received: from mimer.lan (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id 12-v6sm1446545ljf.96.2019.01.25.04.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:37:32 -0800 (PST)
From:   Jonas Bonn <jonas@norrbonn.se>
To:     linux-kernel@vger.kernel.org
Cc:     Jonas Bonn <jonas@norrbonn.se>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: [PATCH 1/1] spi-nor: allow setting the BPNV (default locked) bit
Date:   Fri, 25 Jan 2019 13:37:26 +0100
Message-Id: <20190125123726.31122-1-jonas@norrbonn.se>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the BPNV bit defaults the block protection bits BP0-2 to 1 at
reset.  This means that all the flash sectors are protected until they
are explicity unlocked by the user.

Together with protection of the status register via the SRWD bit and the
WP# signal, this allows a flash device to be effectively protected from
erasure by unauthorized actors.

The patch has been tested with a Cypress s25fl512s and works as
advertised.  The concern that I have with this, though, is that the BPNV
bit is "write once":  if somebody inadvertently sets this feature on the
device, it is irrevocable!  Whether or not this actually belongs in the
mainline kernel is therefore up for debate...

Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
CC: Marek Vasut <marek.vasut@gmail.com>
CC: David Woodhouse <dwmw2@infradead.org>
CC: Brian Norris <computersforpeace@gmail.com>
CC: Boris Brezillon <bbrezillon@kernel.org>
CC: Richard Weinberger <richard@nod.at>
CC: linux-mtd@lists.infradead.org
---
 drivers/mtd/mtdchar.c         |  6 +++
 drivers/mtd/mtdcore.c         |  8 +++
 drivers/mtd/spi-nor/spi-nor.c | 98 ++++++++++++++++++++++++-----------
 include/linux/mtd/mtd.h       |  2 +
 include/linux/mtd/spi-nor.h   |  1 +
 include/uapi/mtd/mtd-abi.h    |  1 +
 6 files changed, 86 insertions(+), 30 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 02389528f622..72842308087b 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -800,6 +800,12 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		break;
 	}
 
+	case MEMSETDEFAULTLOCKED:
+	{
+		ret = mtd_set_default_locked(mtd);
+		break;
+	}
+
 	case MEMLOCK:
 	{
 		struct erase_info_user einfo;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 999b705769a8..b5d555e1373a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1715,6 +1715,14 @@ int mtd_lock_user_prot_reg(struct mtd_info *mtd, loff_t from, size_t len)
 }
 EXPORT_SYMBOL_GPL(mtd_lock_user_prot_reg);
 
+int mtd_set_default_locked(struct mtd_info *mtd)
+{
+	if (!mtd->_set_default_locked)
+		return -EOPNOTSUPP;
+	return mtd->_set_default_locked(mtd);
+}
+EXPORT_SYMBOL_GPL(mtd_set_default_locked);
+
 /* Chip-supported device locking */
 int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index b819b12fafcf..c960c097e0bc 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -278,6 +278,10 @@ struct flash_info {
 #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
 #define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
 #define USE_CLSR		BIT(14)	/* use CLSR command */
+#define SPI_NOR_HAS_BPNV	BIT(15) /* Block protection bits can be set
+					 * non-volatile, meaning all blocks
+					 * are protected by default at reset
+					 */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -1319,6 +1323,36 @@ static int stm_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return write_sr_and_check(nor, status_new, mask);
 }
 
+/*
+ * Write status Register and configuration register with 2 bytes
+ * The first byte will be written to the status register, while the
+ * second byte will be written to the configuration register.
+ * Return negative if error occurred.
+ */
+static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
+{
+	int ret;
+
+	write_enable(nor);
+
+	ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
+	if (ret < 0) {
+		dev_err(nor->dev,
+			"error while writing configuration register\n");
+		return -EINVAL;
+	}
+
+	ret = spi_nor_wait_till_ready(nor);
+	if (ret) {
+		dev_err(nor->dev,
+			"timeout while writing configuration register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+
 /*
  * Check if a region of the flash is (completely) locked. See stm_lock() for
  * more info.
@@ -1337,6 +1371,35 @@ static int stm_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
 	return stm_is_locked_sr(nor, ofs, len, status);
 }
 
+static int spi_nor_set_default_locked(struct mtd_info *mtd)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	struct device *dev = nor->dev;
+	u8 sr_cr[2];
+	int ret;
+
+	ret = read_cr(nor);
+	if (ret < 0) {
+		dev_err(dev, "error while reading configuration register\n");
+		return -EINVAL;
+	}
+
+	if (ret & CR_BPNV)
+		return 0;
+
+	sr_cr[1] = ret | CR_BPNV;
+
+	/* Keep the current value of the Status Register. */
+	ret = read_sr(nor);
+	if (ret < 0) {
+		dev_err(dev, "error while reading status register\n");
+		return -EINVAL;
+	}
+	sr_cr[0] = ret;
+
+	return write_sr_cr(nor, sr_cr);
+}
+
 static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
@@ -1382,35 +1445,6 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 	return ret;
 }
 
-/*
- * Write status Register and configuration register with 2 bytes
- * The first byte will be written to the status register, while the
- * second byte will be written to the configuration register.
- * Return negative if error occurred.
- */
-static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
-{
-	int ret;
-
-	write_enable(nor);
-
-	ret = nor->write_reg(nor, SPINOR_OP_WRSR, sr_cr, 2);
-	if (ret < 0) {
-		dev_err(nor->dev,
-			"error while writing configuration register\n");
-		return -EINVAL;
-	}
-
-	ret = spi_nor_wait_till_ready(nor);
-	if (ret) {
-		dev_err(nor->dev,
-			"timeout while writing configuration register\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 /**
  * macronix_quad_enable() - set QE bit in Status Register.
  * @nor:	pointer to a 'struct spi_nor'
@@ -1880,7 +1914,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "s25fl256s0", INFO(0x010219, 0x4d00, 256 * 1024, 128, USE_CLSR) },
 	{ "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024, 512, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | USE_CLSR) },
-	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | USE_CLSR) },
+	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256, SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_HAS_BPNV | USE_CLSR) },
 	{ "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024, 256, 0) },
 	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
 	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },
@@ -4055,6 +4089,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		mtd->_is_locked = spi_nor_is_locked;
 	}
 
+	if (info->flags & SPI_NOR_HAS_BPNV) {
+		mtd->_set_default_locked = spi_nor_set_default_locked;
+	}
+
 	/* sst nor chips use AAI word program */
 	if (info->flags & SST_WRITE)
 		mtd->_write = sst_write;
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 677768b21a1d..30ee6f1c1142 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -313,6 +313,7 @@ struct mtd_info {
 	int (*_writev) (struct mtd_info *mtd, const struct kvec *vecs,
 			unsigned long count, loff_t to, size_t *retlen);
 	void (*_sync) (struct mtd_info *mtd);
+	int (*_set_default_locked) (struct mtd_info *mtd);
 	int (*_lock) (struct mtd_info *mtd, loff_t ofs, uint64_t len);
 	int (*_unlock) (struct mtd_info *mtd, loff_t ofs, uint64_t len);
 	int (*_is_locked) (struct mtd_info *mtd, loff_t ofs, uint64_t len);
@@ -451,6 +452,7 @@ static inline void mtd_sync(struct mtd_info *mtd)
 int mtd_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
 int mtd_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len);
 int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len);
+int mtd_set_default_locked(struct mtd_info *mtd);
 int mtd_block_isreserved(struct mtd_info *mtd, loff_t ofs);
 int mtd_block_isbad(struct mtd_info *mtd, loff_t ofs);
 int mtd_block_markbad(struct mtd_info *mtd, loff_t ofs);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fa2d89e38e40..4fcf4077cf2a 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -136,6 +136,7 @@
 #define FSR_PT_ERR		BIT(1)	/* Protection error bit */
 
 /* Configuration Register bits. */
+#define CR_BPNV			BIT(3)	/* Block protection non-volatile */
 #define CR_QUAD_EN_SPAN		BIT(1)	/* Spansion Quad I/O */
 
 /* Status Register 2 bits. */
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index aff5b5e59845..27b752796efa 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -204,6 +204,7 @@ struct otp_info {
  * without OOB, e.g., NOR flash.
  */
 #define MEMWRITE		_IOWR('M', 24, struct mtd_write_req)
+#define MEMSETDEFAULTLOCKED	_IO('M', 25)
 
 /*
  * Obsolete legacy interface. Keep it in order not to break userspace
-- 
2.19.1

