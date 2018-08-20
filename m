Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FEAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC28A2172C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9VrJDCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC28A2172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeHUAzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:55:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41032 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHUAzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:55:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so12019781lfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6jXgZaPUuQCyB1QVs66x1a3ankQyYayK8soBVRkFNHI=;
        b=B9VrJDCdJuZodxc4/Z7R3Xl2TmRo9UDYU1+sQsgIxK+lpHkFZZil/3hTYf2F4jvefI
         6OJjg/4fWCVpWF5AczAMjrDjex89mz8w4kapXqAN0LIpk5j1FXpEMtyH2gMz+KjjKHA6
         ToxF5CQNwTegW3ch750bNIiCTaE8VHzl1HFVElSgSo3Y1jQnz/0NK18u59dXcD6zh8Yb
         oKV9i7A0L1cwc4MxrTAZ3hiQO9uorlZ/szlgomKe6Zp46fx/h2GwP6naAQXai85IHFKn
         49jNGUPLaetgtoe3WFe1f0Cnoja9u5TPE1ezPKjqz7OnXgaH8tdFa8LrzzrJTVtUeRJj
         yxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6jXgZaPUuQCyB1QVs66x1a3ankQyYayK8soBVRkFNHI=;
        b=T1LP3sEd5NTrjX0vh8Su1UuMkFdNHRHYP6tLYV0SI+ue7s0h0VYT2ZFJJSEhBk1NNG
         9xipom4kuCzQo9Mgse+A3j0o9INFVdmaHMIo04P7ERbKRxcv+RrOF5wy1hZ2f3Og+BVk
         1gY807yuvV/rF4WeUVV/TpPPwxN1EBuc+VWdT9o9sBjYl41iqiKcZkT26Q3cmnLDR9U/
         NezaTmtC4mD4lVThmuXXOOwBYwusAu9SQ+GaJ9/2S+rzla6PQjkmZpNA1saZZDpCF1rq
         xvb3zO2X8M19LVjQdYUnplbiKpYGGFZWF1yjjPWyW+BnFeneYlg+MmbRQtE5T4POjjZ2
         AwoQ==
X-Gm-Message-State: AOUpUlHtpi5YbTrlKoLBQG2ktNX7LCoZfZn/JW9f1+G70tJLufNCyFBx
        zFajHbjuxfeuhD+aZ6JWDuI=
X-Google-Smtp-Source: AA+uWPydEONXZKg+uol5aPVTOHfSKkVlJvyN+/6fAdyS0tyBXzB7F3+iJxo8S+RqTxNkLbAQq/jGpQ==
X-Received: by 2002:a19:f50d:: with SMTP id j13-v6mr6014633lfb.127.1534801102872;
        Mon, 20 Aug 2018 14:38:22 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o72-v6sm1417868lfg.31.2018.08.20.14.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 14:38:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4 3/3] mtd: rawnand: ams-delta: Set port direction when needed
Date:   Mon, 20 Aug 2018 23:39:04 +0200
Message-Id: <20180820213904.13475-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820213904.13475-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820213904.13475-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its current shape, the driver sets data port direction before each
byte read/write operation, even during multi-byte transfers.  Improve
performance of the driver by setting the port direction only when
needed.

This optimisation will become particularly important as soon as
planned conversion of the driver to GPIO API for data I/O will be
implemented.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 68 ++++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 48233d638d2a..4d5e5790f18e 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -45,6 +45,7 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
 	void __iomem		*io_base;
+	bool			data_in;
 };
 
 /*
@@ -72,50 +73,65 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_io_write(struct ams_delta_nand *priv, u8 byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
-
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
-	writew(byte, this->IO_ADDR_W);
+	writew(byte, priv->nand_chip.IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static u8 ams_delta_io_read(struct ams_delta_nand *priv)
 {
-	u_char res;
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
+	u8 res;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
-	res = readw(this->IO_ADDR_R);
+	res = readw(priv->nand_chip.IO_ADDR_R);
 	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
 }
 
-static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
-				int len)
+static void ams_delta_dir_input(struct ams_delta_nand *priv, bool in)
 {
+	writew(in ? ~0 : 0, priv->io_base + OMAP_MPUIO_IO_CNTL);
+	priv->data_in = in;
+}
+
+static void ams_delta_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
-	for (i=0; i<len; i++)
-		ams_delta_write_byte(mtd, buf[i]);
+	if (priv->data_in)
+		ams_delta_dir_input(priv, false);
+
+	for (i = 0; i < len; i++)
+		ams_delta_io_write(priv, buf[i]);
 }
 
-static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+static void ams_delta_read_buf(struct mtd_info *mtd, u8 *buf, int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
-	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(mtd);
+	if (!priv->data_in)
+		ams_delta_dir_input(priv, true);
+
+	for (i = 0; i < len; i++)
+		buf[i] = ams_delta_io_read(priv);
+}
+
+static u8 ams_delta_read_byte(struct mtd_info *mtd)
+{
+	u8 res;
+
+	ams_delta_read_buf(mtd, &res, 1);
+
+	return res;
 }
 
 /*
@@ -138,8 +154,11 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 		gpiod_set_value(priv->gpiod_ale, !!(ctrl & NAND_ALE));
 	}
 
-	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(mtd, cmd);
+	if (cmd != NAND_CMD_NONE) {
+		u8 byte = cmd;
+
+		ams_delta_write_buf(mtd, &byte, 1);
+	}
 }
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
@@ -262,6 +281,9 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_mtd;
 	}
 
+	/* Initialize data port direction to a known state */
+	ams_delta_dir_input(priv, true);
+
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
 	if (err)
-- 
2.16.4

