Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756065AbeEaSzv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:55:51 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41833 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755955AbeEaSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:55:49 -0400
X-Google-Smtp-Source: ADUXVKLEid2i1qGt/vmpUc9rag7z7gMZkou9HoMCE9VzeXtEquGdt6HsncvljK3rvDHl3E9iGf8fNg==
Date: Fri, 1 Jun 2018 00:25:43 +0530
From: Sankalp Negi <sankalpnegi2310@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        NeilBrown <neil@brown.name>, Sankalp Negi <sankalpnegi2310@gmail.com>
Subject: [PATCH] staging: mt7621-spi: Fix Coding style issues reported by
 checkpatch.pl.
Message-ID: <20180531185542.phhu2rkdoq2czkav@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes following checkpatch.pl issues:

WARNING : line over 80 characters
ERROR   : code indent should use tabs where possible
WARNING : no spaces at the start of a line
ERROR   : switch and case should be at the same indent
ERROR   : space required before the open parenthesis
WARNING : braces {} are not necessary for single statement blocks

Signed-off-by: Sankalp Negi <sankalpnegi2310@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index 37f299080410..cd94f5f569df 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -55,7 +55,8 @@
 #define MT7621_CPOL		BIT(4)
 #define MT7621_LSB_FIRST	BIT(3)
 
-#define RT2880_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST | SPI_CS_HIGH)
+#define RT2880_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA |		\
+				SPI_LSB_FIRST | SPI_CS_HIGH)
 
 struct mt7621_spi;
 
@@ -104,7 +105,7 @@ static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
 	int cs = spi->chip_select;
 	u32 polar = 0;
 
-        mt7621_spi_reset(rs, cs);
+	mt7621_spi_reset(rs, cs);
 	if (enable)
 		polar = BIT(cs);
 	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
@@ -137,18 +138,18 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 		reg |= MT7621_LSB_FIRST;
 
 	reg &= ~(MT7621_CPHA | MT7621_CPOL);
-	switch(spi->mode & (SPI_CPOL | SPI_CPHA)) {
-		case SPI_MODE_0:
-			break;
-		case SPI_MODE_1:
-			reg |= MT7621_CPHA;
-			break;
-		case SPI_MODE_2:
-			reg |= MT7621_CPOL;
-			break;
-		case SPI_MODE_3:
-			reg |= MT7621_CPOL | MT7621_CPHA;
-			break;
+	switch (spi->mode & (SPI_CPOL | SPI_CPHA)) {
+	case SPI_MODE_0:
+		break;
+	case SPI_MODE_1:
+		reg |= MT7621_CPHA;
+		break;
+	case SPI_MODE_2:
+		reg |= MT7621_CPOL;
+		break;
+	case SPI_MODE_3:
+		reg |= MT7621_CPOL | MT7621_CPHA;
+		break;
 	}
 	mt7621_spi_write(rs, MT7621_SPI_MASTER, reg);
 
@@ -164,9 +165,8 @@ static inline int mt7621_spi_wait_till_ready(struct spi_device *spi)
 		u32 status;
 
 		status = mt7621_spi_read(rs, MT7621_SPI_TRANS);
-		if ((status & SPITRANS_BUSY) == 0) {
+		if ((status & SPITRANS_BUSY) == 0)
 			return 0;
-		}
 		cpu_relax();
 		udelay(1);
 	}
-- 
2.11.0
