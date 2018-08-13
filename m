Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D3BC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EF421709
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPe45A5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EF421709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732420AbeHNBTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:19:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39769 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732285AbeHNBTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:19:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id a134-v6so12397599lfe.6;
        Mon, 13 Aug 2018 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7PaRe0Kcvcx7hiv+aZ/0LG6vJqsdKc6trNkBzyVvLs=;
        b=gPe45A5SUYgSodBEwXYxl4cY6QCuG9T1pS4kZoMPmUX7HhqEw+TaCNXmA0Q8dEIAWk
         1QJEDVSuGJjSYTNDXF9uxrf4IUE9RRLR40M8x8GIa3iVpy+0cDxzisccxsztC0wJkJvB
         cVjrhHA1ndYm/JZHNYaq2Nb9vdSA0ksIJc151Lqi3hoSJiet+sFDTzqMTvYybywgogjx
         3EmcNhoCDCIXCSNVu944uGYBAU151rNOkiGxQfRhvKB9Gsd1QzcZnia34iMN3wr1aQHn
         nntPOTRVm27UhrOhzG+JZId9wb5eQTb8xThnhkgTLUFbEoGaSJ/LJoVB2pEsbPAJX+xQ
         MsmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7PaRe0Kcvcx7hiv+aZ/0LG6vJqsdKc6trNkBzyVvLs=;
        b=EGzHPkYC04Tjaz4qoi/Z1j2FHQkYhYecEQBiw6wthNB1SmflDaynAVyxpNR5QWxG4O
         s1+l/4FXXx1ae1bD75oyv6poZ2Kb2GRhis45PWjxZDpOPo/vpGXf/PixND4M3ERR7Aj0
         KIvwoZUVOKeCabJqkbTpFAsa7MFmsF3vteEy/ncRlhIrA3p3v5cXf0egHk/3OhvwLPM+
         iXOBOixF8v1K4/WTyZ6fltArgBf8gxRqmed1XSp1r/LWKQV3TYsaQx1vqq385ppGJiKJ
         ZKhfXMMgxS3DwDFxUTRxyTfn5yYiYX/GYl/cyjAgfhNaIQbCMP2kDEfJvxoqt3kWeWZn
         w9gQ==
X-Gm-Message-State: AOUpUlHlexUJv5hVjWeyCOdwZF1qA7lqDu0ie5FqWVrqkHuSedWQoWnJ
        mVKotgcVqstaFWKNNYn9yfM=
X-Google-Smtp-Source: AA+uWPwavSaEse9bsLkIUaVrmEhHcahOk3am45tTQUsit/zyaY4SG1CIhgEph8o17Upefkm8zjFMJg==
X-Received: by 2002:a19:e546:: with SMTP id c67-v6mr12608411lfh.135.1534199685420;
        Mon, 13 Aug 2018 15:34:45 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f136-v6sm3572702lfe.71.2018.08.13.15.34.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:34:44 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 6/7] mtd: rawnand: ams-delta: Simplify pointer resolution on read/write
Date:   Tue, 14 Aug 2018 00:34:47 +0200
Message-Id: <20180813223448.21316-7-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify data read/write sub-functions by making them accept private
structure pointer instead of resolving it again from mtd_info.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 5f9180fe4f8b..59fc417e8fa9 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -73,10 +73,9 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 
 	writew(byte, this->IO_ADDR_W);
 
@@ -85,10 +84,8 @@ static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
 	if (priv->data_in) {
@@ -96,13 +93,12 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 		priv->data_in = false;
 	}
 
-	ams_delta_write_next_byte(mtd, byte);
+	ams_delta_write_next_byte(priv, byte);
 }
 
-static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 	u_char res;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
@@ -126,30 +122,34 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 		priv->data_in = true;
 	}
 
-	return ams_delta_read_next_byte(mtd);
+	return ams_delta_read_next_byte(priv);
 }
 
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i = 0;
 
 	if (len > 0)
-		ams_delta_write_byte(mtd, buf[i++]);
+		ams_delta_write_byte(priv, buf[i++]);
 
 	while (i < len)
-		ams_delta_write_next_byte(mtd, buf[i++]);
+		ams_delta_write_next_byte(priv, buf[i++]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i = 0;
 
 	if (len > 0)
 		buf[i++] = ams_delta_read_byte(mtd);
 
 	while (i < len)
-		buf[i++] = ams_delta_read_next_byte(mtd);
+		buf[i++] = ams_delta_read_next_byte(priv);
 }
 
 /*
@@ -173,7 +173,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(mtd, cmd);
+		ams_delta_write_byte(priv, cmd);
 }
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
-- 
2.16.4

