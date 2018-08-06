Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0734CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD78208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aiaJY+wG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD78208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387726AbeHGAkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:40:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46869 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387629AbeHGAku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id l16-v6so10176020lfc.13;
        Mon, 06 Aug 2018 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kc0UzhE5a74AT1i79aXGGOwb60l9x1wE3g4xDA9GbLE=;
        b=aiaJY+wGP5udMA1gIXrJ03dzpSnoHmM17OF2+mZ0FFuAVAlc7ToGOCaJzEZqj0MzT5
         6AI0KU5o+Jpgv+oI1FgxlZg7fc1Hz+RjG6elpcJ5rTa3vs2lLeCDDHxO0XTcREJ0HDiL
         W+SxYkqYP20qW2KvKNw67HV9tgYxKpIZRftHYwQlmYO9DSu4WOk95QakCnsgCQW7sLbb
         DqUiMvk0tnlS5Kt4WBTfxcdy+EnCR/iiXm9qZ5SkZns3SBmN4wD0luM2MM/8AYDGH0Qg
         AFRCUBUkqExs6vRPmWtIXiR1DGLuJGIfXX5mvArvNzgK/PUieR0B/7Mi5c3BEWCz7GRD
         XNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kc0UzhE5a74AT1i79aXGGOwb60l9x1wE3g4xDA9GbLE=;
        b=N+hOcQ3msjWeXmrxi0oyWOEg0GPtF8ZGn5Pkm6W6Q1Rn6ZAvVqiwlv2YuXgr0N2/3R
         xmkubTD3y49vDiIdluzxF4P/mG4pDSs0mMGA0lc+h5LFZgNt3wQxk2Tdj8TH/af/s6p8
         h7c+bGdGgg5xowdhU4KnC4TjAQOgHPzF61ruXV2orzRJTsR75w8Q8bu63JmZLxwcRZhT
         weeAhVil7LivOGa9PmEjKVbZ5btv8a2INgqfpdQ3gl7/qHYLfz7jqRBQzOn3cAXHt8Rh
         ST9uagm24eXtSkuHvmtsgQtpEmbIcBdNtcNT25CRSexuI89LH8cDt32ayfZGfSg5WUrR
         wfTA==
X-Gm-Message-State: AOUpUlFXZoCJ3bAsO4ZWw7F9aRuikiSoPFw++8tXd+9ZpShHgD18DmSz
        wiQ3MJL+xMO3/n/0+t8WMXM=
X-Google-Smtp-Source: AAOMgpftlgT2LBNt75HgnmEVXCUbyxfdlV1qSGS8i1KDsP4Pv+onp7UCIBniLpb4ZMscgW11lZsMRA==
X-Received: by 2002:a19:2c4f:: with SMTP id s76-v6mr13073045lfs.25.1533594577560;
        Mon, 06 Aug 2018 15:29:37 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:36 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction once per transfer
Date:   Tue,  7 Aug 2018 00:29:13 +0200
Message-Id: <20180806222918.12644-8-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its current shape, the driver sets data port direction before each
byte read/write operation, even during multi-byte transfers.  Since
performance of the driver is completely not acceptable on Amstrad Delta
after it has been converted to GPIO bitbang, try to improve things a
bit by setting the port direction only on first byte of each transfer.

Resulting performance on Amstrad Delta is still far from acceptable.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 58 ++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 78996ddf82e0..d02c48c013e8 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -69,6 +69,30 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
+static void ams_delta_write_commit(struct ams_delta_nand *priv)
+{
+	gpiod_set_value(priv->gpiod_nwe, 0);
+	ndelay(40);
+	gpiod_set_value(priv->gpiod_nwe, 1);
+}
+
+static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	unsigned long bits = byte;
+	int i, value_array[data_gpiods->ndescs];
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		value_array[i] = test_bit(i, &bits);
+
+	gpiod_set_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
+				  value_array);
+
+	ams_delta_write_commit(priv);
+}
+
 static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
@@ -81,12 +105,10 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 		gpiod_direction_output_raw(data_gpiods->desc[i],
 					   test_bit(i, &bits));
 
-	gpiod_set_value(priv->gpiod_nwe, 0);
-	ndelay(40);
-	gpiod_set_value(priv->gpiod_nwe, 1);
+	ams_delta_write_commit(priv);
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
@@ -94,9 +116,6 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 	unsigned long bits = 0;
 	int i, value_array[data_gpiods->ndescs];
 
-	for (i = 0; i < data_gpiods->ndescs; i++)
-		gpiod_direction_input(data_gpiods->desc[i]);
-
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
 
@@ -112,21 +131,38 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
 	return bits;
 }
 
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct gpio_descs *data_gpiods = priv->data_gpiods;
+	int i;
+
+	for (i = 0; i < data_gpiods->ndescs; i++)
+		gpiod_direction_input(data_gpiods->desc[i]);
+
+	return ams_delta_read_next_byte(mtd);
+}
+
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		ams_delta_write_byte(mtd, buf[i]);
+	if (len > 0)
+		ams_delta_write_byte(mtd, buf[0]);
+	for (i = 1; i < len; i++)
+		ams_delta_write_next_byte(mtd, buf[i]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(mtd);
+	if (len > 0)
+		buf[0] = ams_delta_read_byte(mtd);
+	for (i = 1; i < len; i++)
+		buf[i] = ams_delta_read_next_byte(mtd);
 }
 
 /*
-- 
2.16.4

