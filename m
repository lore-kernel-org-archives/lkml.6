Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nZdhOZNtG1uzTAAAmS7hNA
	; Sat, 09 Jun 2018 06:04:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 07E86608B8; Sat,  9 Jun 2018 06:04:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1T+bJUk"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7B93960290;
	Sat,  9 Jun 2018 06:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B93960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeFIGEZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:04:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39692 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752858AbeFIGEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:04:24 -0400
Received: by mail-pf0-f196.google.com with SMTP id r11-v6so7644127pfl.6;
        Fri, 08 Jun 2018 23:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqpCV6I/zxEEob+QMPJjkt6PRG/TH6uL89zWXeFMJ+A=;
        b=O1T+bJUkLwyMZyxx5AeNOBZ0tscg7sGYZjW9KaGiDsto1+4y+6x8QeV8/wCCKn1I/6
         XZnoWphi1xAgcNSKpswaPbC+ZdxGfR81Ic8NOugoW3yrkMfn3r5dxBsylns7sbCmfKvX
         OWeSpND4j2a0BGHRXE4fCDwZsts3c9WquFvVon+ZH+681iN88zNRRVRMKEmRRRN93iKr
         vSTWyNJY3KdFt8AIRuaepnZsRhS+oO+2hOmDtvRHfjuldf0AteQXTctm7vzD9WaAHasL
         /xI9tgXEbZ2m4yBj5jOgNfc9dwmYfA5XltXBJAOO6DFXAumgzuIkE2DIttnZTeG1mq0X
         Wzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lqpCV6I/zxEEob+QMPJjkt6PRG/TH6uL89zWXeFMJ+A=;
        b=G8WwNjIpMlTPFMgw2uzQ2CUVNwhEsPfZu/+izS+/eD971v60taV+65q9kSAnijBe52
         zlhWSuBfn67QJ8WgI0REQMR48mcjDh9D7Cstg6/L3z6oUCRE6P8Xws5SuPSGQS3s8RV/
         KJUETxDHSwTIUp7Mr85Ci8MEocCIPP08AouRHmGe6pKqoESPZ7AdJ9Pe9qVTZraKDlY1
         WIaOS1/PStIGgeGccA60QFoUVgRHRk0OayaCOA1Ra01/3SfBHpqztUgOI8EKMgG8CN0x
         Rn6pCSTHr/xHKapFCrMR0p3Z8ZEZIUZ1BCzx8KM5GaKEBtoPd4bOSMEnP3dCbmqL6gvh
         sB5g==
X-Gm-Message-State: APt69E3UtlIHK85ajfV18RMmGBb32BlSv3WHhtolTey5IM8rkZcqQPjn
        yLJNvksXMI4WkdFkYlyIsu8=
X-Google-Smtp-Source: ADUXVKLHHIK1hwXSh0yffj+F2y/TzBww/mi1IuzMDLL5Ng73hT+9icpm0bwszVV3F3cBm6J7X6PQ6w==
X-Received: by 2002:a65:5c02:: with SMTP id u2-v6mr7742932pgr.304.1528524263603;
        Fri, 08 Jun 2018 23:04:23 -0700 (PDT)
Received: from joonhwan-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id p22-v6sm54777924pfj.166.2018.06.08.23.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 23:04:23 -0700 (PDT)
From: "JoonHwan.Kim" <spilit464@gmail.com>
To: gregkh@linuxfoundation.org
Cc: neil@brown.name, blogic@openwrt.org, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] staging: mt7621-spi: fix indentation for switch statement
Date: Sat, 09 Jun 2018 15:04:21 +0900
Message-ID: <2677421.r3Zvpk0yfm@joonhwan-virtualbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* fix checkpatch.pl error:
  ERROR: switch and case should be at the same indent

Signed-off-by: Joonhwan Kim <spilit464@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index a11cca3e2304..11a65ec48178 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -139,17 +139,17 @@ static int mt7621_spi_prepare(struct spi_device *spi, unsigned int speed)
 
 	reg &= ~(MT7621_CPHA | MT7621_CPOL);
 	switch(spi->mode & (SPI_CPOL | SPI_CPHA)) {
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
 
-- 
2.17.0
