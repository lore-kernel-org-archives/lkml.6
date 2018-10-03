Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C11C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1002064A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 11:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q41sJ55Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1002064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeJCSrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 14:47:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39859 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeJCSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 14:47:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id w21-v6so3917148lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 04:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FlZqKwjVoeFu/nEuPnA5WnfWrBB8OUWnxD8mhm28kUQ=;
        b=Q41sJ55ZIFpVmf6K5XSH0egwojzvcE6ZsZ3PIBQmODsuDnashWlNFjt4g8x9dsL3HT
         VunYEtbc/Z2Wo2piS0jjD212n1ttuDwfprb1bmYAmV6gcX6zGJkcFgVQHclN9Ea/C5Xv
         rNRkgYviNsOKdgzoE+ZhPuovUzRBzRMn8BorxieQKXJ+Ph961kjgIyeHSWl5NkDEToPX
         sMR26S4+6Blw6uoMQFHeBIJuvXSKDjBMYTFp5aYXHXkANNn8hm/3cNG63FjbwUz9S+VX
         foEwefumt3m5qkK3Q/drwEKHkAtk/Q/+OwqoSqdLaDfOZfBTZQTCk1afUn/HNGc2wEOk
         qzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FlZqKwjVoeFu/nEuPnA5WnfWrBB8OUWnxD8mhm28kUQ=;
        b=BV2wnI5Sx1RJYPeCOJrQa7PrwahI3Sf8zvgrHG+vQoWTGjHseb6VsKNx7J9tOneGK5
         SpmmsjAjI5UHg2EbYc9K6mc+xCU8Xw4o1r/9tZ0F+elNZIlyZD9hmfPthp/Puy1kWxgg
         UUWNFbF0aQP4kyZV0jPDTe9tAQxlLnK0+u3kFNZYcc/t/VmScZFww3XszuPHrXjtO3H8
         4kxgzC8PIT+ViWIGD8T0ehNG52dSITu+/ZhLz6k/N7nnXIyQs23Qzq9mXkn0mlEtPOF7
         Svyr59rRKN/OhrHHaZIaXxer9P8JH8gfLCEI2UcO8ahWIkGRCV+HIInGe/+pILVDwrYv
         CXDg==
X-Gm-Message-State: ABuFfojwaOQJlzuhlfO2pgw2G13PO5l8/aIkEhJ+H71QJD7R1ApQ5v62
        I3oDt6WfSvh8AkgqYjjK9rdv8y5W
X-Google-Smtp-Source: ACcGV624WJm+QgZ0BY/GVDAaYUajHyTSVJZoznrMfi2DpdvwMZlJ4d0R3tNlcwY7c3DtSFOW2rrmyg==
X-Received: by 2002:a19:5118:: with SMTP id f24-v6mr873303lfb.104.1538567946426;
        Wed, 03 Oct 2018 04:59:06 -0700 (PDT)
Received: from z50.intranet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id j5-v6sm286654lfb.62.2018.10.03.04.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 04:59:05 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Date:   Wed,  3 Oct 2018 14:00:28 +0200
Message-Id: <20181003120028.9257-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180719081508.5dafebde@bbrezillon>
References: <20180719081508.5dafebde@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace legacy callbacks with ->select_chip() and ->exec_op().

Implementation of NAND_OP_WAITRDY_INSTR has been based on legacy
nand_wait_ready(), otherwise that function would probabaly have to be
reimplemented inside the driver.  Hence, legacy callback ->dev_ready()
is still used.

Use of IO_ADDR_R and IO_ADDR_W legacy structure members will be dropped
later, as soon as the driver is converted to use GPIO API for data I/O.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Hi,

I've not tested the change on hardware yet as I'm not sure if:
- handling of NCE limited to that inside ->select_chip() is
  sufficient,
- releasing ALE / CLE immediately after ams_delta_write_buf() is
  correct.
Please advise before I break my test hardware :-).

Thanks,
Janusz

 drivers/mtd/nand/raw/ams-delta.c | 83 +++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 5ba180a291eb..90c283a2c1b7 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -124,46 +124,69 @@ static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
 		buf[i] = ams_delta_io_read(priv);
 }
 
-static u_char ams_delta_read_byte(struct nand_chip *this)
+static int ams_delta_nand_ready(struct nand_chip *this)
 {
-	u_char res;
-
-	ams_delta_read_buf(this, &res, 1);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 
-	return res;
+	return gpiod_get_value(priv->gpiod_rdy);
 }
 
-/*
- * Command control function
- *
- * ctrl:
- * NAND_NCE: bit 0 -> bit 2
- * NAND_CLE: bit 1 -> bit 7
- * NAND_ALE: bit 2 -> bit 6
- */
-static void ams_delta_hwcontrol(struct nand_chip *this, int cmd,
-				unsigned int ctrl)
+static void ams_delta_select_chip(struct nand_chip *this, int n)
 {
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
 
-	if (ctrl & NAND_CTRL_CHANGE) {
-		gpiod_set_value(priv->gpiod_nce, !(ctrl & NAND_NCE));
-		gpiod_set_value(priv->gpiod_cle, !!(ctrl & NAND_CLE));
-		gpiod_set_value(priv->gpiod_ale, !!(ctrl & NAND_ALE));
-	}
-
-	if (cmd != NAND_CMD_NONE) {
-		u_char byte = cmd;
+	if (n > 0)
+		return;
 
-		ams_delta_write_buf(this, &byte, 1);
-	}
+	gpiod_set_value(priv->gpiod_nce, n < 0);
 }
 
-static int ams_delta_nand_ready(struct nand_chip *this)
+static int ams_delta_exec_op(struct nand_chip *this,
+			     const struct nand_operation *op, bool check_only)
 {
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	const struct nand_op_instr *instr;
+	int i;
 
-	return gpiod_get_value(priv->gpiod_rdy);
+	for (i = 0; i < op->ninstrs; i++) {
+		instr = &op->instrs[i];
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			gpiod_set_value(priv->gpiod_cle, 1);
+			ams_delta_write_buf(this, &instr->ctx.cmd.opcode, 1);
+			gpiod_set_value(priv->gpiod_cle, 0);
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			gpiod_set_value(priv->gpiod_ale, 1);
+			ams_delta_write_buf(this, instr->ctx.addr.addrs,
+					    instr->ctx.addr.naddrs);
+			gpiod_set_value(priv->gpiod_ale, 0);
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			ams_delta_read_buf(this, instr->ctx.data.buf.in,
+					   instr->ctx.data.len);
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			ams_delta_write_buf(this, instr->ctx.data.buf.out,
+					    instr->ctx.data.len);
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			if (this->legacy.dev_ready) {
+				nand_wait_ready(this);
+				break;
+			}
+
+			return nand_soft_waitrdy(this,
+						 instr->ctx.waitrdy.timeout_ms);
+		}
+	}
+
+	return 0;
 }
 
 
@@ -213,10 +236,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	/* Set address of NAND IO lines */
 	this->legacy.IO_ADDR_R = io_base + OMAP_MPUIO_INPUT_LATCH;
 	this->legacy.IO_ADDR_W = io_base + OMAP_MPUIO_OUTPUT;
-	this->legacy.read_byte = ams_delta_read_byte;
-	this->legacy.write_buf = ams_delta_write_buf;
-	this->legacy.read_buf = ams_delta_read_buf;
-	this->legacy.cmd_ctrl = ams_delta_hwcontrol;
+	this->select_chip = ams_delta_select_chip;
+	this->exec_op = ams_delta_exec_op;
 
 	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
 	if (IS_ERR(priv->gpiod_rdy)) {
-- 
2.16.4

