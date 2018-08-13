Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE417C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580F921723
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF89NVC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580F921723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732381AbeHNBTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:19:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34005 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732316AbeHNBTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:19:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id n96-v6so12402339lfi.1;
        Mon, 13 Aug 2018 15:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B/J/zSnahygYuOd62zFWNAm0nwwi22qYKgimEpTrnhw=;
        b=PF89NVC/li8IpcQ0ErazLmmrEsPb7epnQb2xS8WZ+rfJAVRgwJilhhqpLwTCDxr6UK
         QPapuO/Ofrd6A37CTY4VwAvhuvg7zEV11vgne/2bMqvdBaz5HyH7PKyld1gh01DBRtzX
         u7EBsa35y72ExJYPs4tx1FOpLxtrjdL2RBZfdmLGhG8X4vPu42cOdCIxtKjKYLDnqaVG
         bk+VO2v4DLut3BUR1avPAQ50uh7GGhLtflUXAWI2edbtaiwKHF651E5CC6OJ37tcJVTx
         B7N+cVMy2pvs2XU+k4hC9+3N0QwRvyYkid01EQQa/+rU4YTNz3hGbZ5X22F+/ZqqOJ6l
         p2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B/J/zSnahygYuOd62zFWNAm0nwwi22qYKgimEpTrnhw=;
        b=CBK9s8KPq+E2MDi21nQ1QukMxESYA7XmPZ1x1f8qJ2rVe6x/ggO/0hQD4nCKY31uTQ
         kv80N23HMfwF3DEbWJnQEPi3ljuBZkBovznHIxTC5DViAMvhnG4uF9yHp+/vREf1dp27
         iygKS39jw8lB4Xh436fWsYD/fRoVKJ2f/I5bR5YD6xzBJ9BsX4AURdhOhFMRs/etvvIp
         038zUTns+dJ2zRcb43P6PGnDLUsGhJi26wzFmRtLtSs2lKYI2Av4Lgc/XnWCUG/S6ONh
         ZopKa3HUx0l7m4lp+UuU4YaAhDHVBnoAWVxrXfjdYdEMi4BOpHLV3KsJvGUnsmD/THYB
         OnSw==
X-Gm-Message-State: AOUpUlEUbzDngvxtZdtjdIJuQSDNdw15vUx8cPne9vr8izjUVmcxD9hb
        pV5EB/90RcasYI6DTC4g3Cs=
X-Google-Smtp-Source: AA+uWPytJeYZTjY+ej2+dRywqoOTtgJcDNqAk6qWN9h35iJgfGqb9Smkmz4BPnPJhV+n9m7BnIQe1g==
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr11539839lff.11.1534199684031;
        Mon, 13 Aug 2018 15:34:44 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f136-v6sm3572702lfe.71.2018.08.13.15.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 15:34:43 -0700 (PDT)
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
Subject: [PATCH v3 5/7] mtd: rawnand: ams-delta: Set port direction when needed
Date:   Tue, 14 Aug 2018 00:34:46 +0200
Message-Id: <20180813223448.21316-6-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180813223448.21316-1-jmkrzyszt@gmail.com>
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
 drivers/mtd/nand/raw/ams-delta.c | 59 ++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 09d6901fc94d..5f9180fe4f8b 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -45,6 +45,7 @@ struct ams_delta_nand {
 	struct gpio_desc	*gpiod_ale;
 	struct gpio_desc	*gpiod_cle;
 	void __iomem		*io_base;
+	bool			data_in;
 };
 
 /*
@@ -72,50 +73,83 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
 
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
+
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
-	u_char res;
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
+	if (priv->data_in) {
+		writew(0, io_base + OMAP_MPUIO_IO_CNTL);
+		priv->data_in = false;
+	}
+
+	ams_delta_write_next_byte(mtd, byte);
+}
+
+static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	u_char res;
+
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
+
 	res = readw(this->IO_ADDR_R);
+
 	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
 }
 
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	void __iomem *io_base = priv->io_base;
+
+	if (!priv->data_in) {
+		writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
+		priv->data_in = true;
+	}
+
+	return ams_delta_read_next_byte(mtd);
+}
+
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
-	int i;
+	int i = 0;
+
+	if (len > 0)
+		ams_delta_write_byte(mtd, buf[i++]);
 
-	for (i=0; i<len; i++)
-		ams_delta_write_byte(mtd, buf[i]);
+	while (i < len)
+		ams_delta_write_next_byte(mtd, buf[i++]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
-	int i;
+	int i = 0;
+
+	if (len > 0)
+		buf[i++] = ams_delta_read_byte(mtd);
 
-	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(mtd);
+	while (i < len)
+		buf[i++] = ams_delta_read_next_byte(mtd);
 }
 
 /*
@@ -269,6 +303,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
 		goto out_mtd;
 	}
+	priv->data_in = true;
 
 	/* Scan to find existence of the device */
 	err = nand_scan(mtd, 1);
-- 
2.16.4

