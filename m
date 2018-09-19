Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B710FECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6207F21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYxWjTD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6207F21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387578AbeITEb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:31:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33075 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeITEbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:31:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so6625789lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E12Ueqxaf9bzdi7+nmXp2SBaeWRJjKEMYTo5gVLEdTE=;
        b=JYxWjTD6Yn2huzbVkY/o532fv7cMa3qKrOatxqdRdKEmkUmdsJp1rHtB6MiZ0bgzm8
         7M6hjWoin7CM1OlduKW4lNxcs9Fq5Mm9qvnOFNXQ22nhTkv5B4RedGNjTpDKn1z8Z996
         B6A1tCIUrOpO9vls3/Ix6pG+Gvc7x8lK+XLUZi3zReVrM/dfnzpDojeNg0RHjOkY7XcW
         WvHB2k8J4iHAY7gZDmO/TnmyyLnfsb5UlP7PMiVXEMo38g7oZRDX1NK6Tm65OAA/hqNP
         Yzc77/+wOSGt3K5RkPE75EJcM9EqoaNSGi3jWMfDcxbPiQlbr0JEN4UZWzBXoNKaX08u
         AVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E12Ueqxaf9bzdi7+nmXp2SBaeWRJjKEMYTo5gVLEdTE=;
        b=ZYE7LZmG7r7T8EXp41tR3xKNyleuU8RpgH0FEXr5k1mM1uHSwY94yVbHvwgN2DDtwZ
         8WfIJCS9UDvsdpR0IQVBNs9okGpkUQ0kXhMEzsNJRiEt6QOWoCjYpqNL0nMZLdSSArzU
         WbPEMFt1Uj8llixRTskNQrumclq7jy07xtEFr3D+rcsXv/FbSLubiLwoXdhdeKribKSC
         ihlUX0Qa8GmFaYLLXDZyxtc/EFb13ssUJ15fopc3nueoOFBcWCJ+uK+WAbw63ps/91Gg
         YEVnTr6bebCMhDnQFeIx5hHzWAJo82pDTcHZC4x2TNtLNp7BviAaLVgCAF9VSG87vkgY
         cYtg==
X-Gm-Message-State: APzg51BMu7QNUwhegCsBPcVCH1DEG+phI+mdygFhFF6ezgEKuuOUMdxo
        qqs8BI2cFUY4COcm3BnkNFo=
X-Google-Smtp-Source: ANB0Vdba72Bo1snR5P2sNL149P2Igub6XDo4B2Y71nyw3Fji27ALWiJ0GIW1XCHMrM3pL4Cjv3k2zQ==
X-Received: by 2002:a19:1ac8:: with SMTP id a191-v6mr18498884lfa.29.1537397504443;
        Wed, 19 Sep 2018 15:51:44 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id q22-v6sm1249211lff.10.2018.09.19.15.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:51:43 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] mtd: rawnand: ams-delta: Set port direction when needed
Date:   Thu, 20 Sep 2018 00:52:55 +0200
Message-Id: <20180919225255.31175-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180919225255.31175-1-jmkrzyszt@gmail.com>
References: <20180820213904.13475-1-jmkrzyszt@gmail.com>
 <20180919225255.31175-1-jmkrzyszt@gmail.com>
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

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 57 ++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index eb2aeadc3b65..5ba180a291eb 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -45,6 +45,7 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
 	void __iomem		*io_base;
+	bool			data_in;
 };
 
 /*
@@ -72,48 +73,64 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_byte(struct nand_chip *this, u_char byte)
+static void ams_delta_io_write(struct ams_delta_nand *priv, u_char byte)
 {
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
-
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
-	writew(byte, this->legacy.IO_ADDR_W);
+	writew(byte, priv->nand_chip.legacy.IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static u_char ams_delta_read_byte(struct nand_chip *this)
+static u_char ams_delta_io_read(struct ams_delta_nand *priv)
 {
 	u_char res;
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
-	res = readw(this->legacy.IO_ADDR_R);
+	res = readw(priv->nand_chip.legacy.IO_ADDR_R);
 	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
 }
 
+static void ams_delta_dir_input(struct ams_delta_nand *priv, bool in)
+{
+	writew(in ? ~0 : 0, priv->io_base + OMAP_MPUIO_IO_CNTL);
+	priv->data_in = in;
+}
+
 static void ams_delta_write_buf(struct nand_chip *this, const u_char *buf,
 				int len)
 {
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
-	for (i=0; i<len; i++)
-		ams_delta_write_byte(this, buf[i]);
+	if (priv->data_in)
+		ams_delta_dir_input(priv, false);
+
+	for (i = 0; i < len; i++)
+		ams_delta_io_write(priv, buf[i]);
 }
 
 static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
 {
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
-	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(this);
+	if (!priv->data_in)
+		ams_delta_dir_input(priv, true);
+
+	for (i = 0; i < len; i++)
+		buf[i] = ams_delta_io_read(priv);
+}
+
+static u_char ams_delta_read_byte(struct nand_chip *this)
+{
+	u_char res;
+
+	ams_delta_read_buf(this, &res, 1);
+
+	return res;
 }
 
 /*
@@ -135,8 +152,11 @@ static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
 		gpiod_set_value(priv->gpiod_ale, !!(ctrl & NAND_ALE));
 	}
 
-	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(this, cmd);
+	if (cmd != NAND_CMD_NONE) {
+		u_char byte = cmd;
+
+		ams_delta_write_buf(this, &byte, 1);
+	}
 }
 
 static int ams_delta_nand_ready(struct nand_chip *this)
@@ -258,6 +278,9 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_mtd;
 	}
 
+	/* Initialize data port direction to a known state */
+	ams_delta_dir_input(priv, true);
+
 	/* Scan to find existence of the device */
 	err = nand_scan(this, 1);
 	if (err)
-- 
2.16.4

