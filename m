Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3664AC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E9B208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 19:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYHurD4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E9B208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeJPD0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 23:26:48 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36076 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPD0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 23:26:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id p89-v6so18624425ljb.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gpAxKCJHhJjj+lN8WLPl+rXChbbfElVUx5p01InmYQs=;
        b=MYHurD4Xkb1B7L+kxZUVQlsP5PUnaB9kLusgTgCH1UuMUclt5SPa5GMyRQPNqgsetc
         Vy6Nmdc3/kIyXTJuh3wfBO6ruqDTO7N69jL2JQ0+XCVyHt4Vo0AB2E0jv8HKv+Cm4msB
         xiLCST16guNCVuQLzxW1zLxFTiYcOpzac9kAdp5lG4emuPzUpmeCZ3URzlTtcS3FZw3L
         /g0zo9ub/DLTELFMm2P1YP0ZWsGGZYTgel6sclAL4/ZxaTlm9jv6UkNOZmc9a5/PJbQ0
         pZGhPE0S7XUf02kpuIqmOmJmbPruGz7XZjYECqcTkhC627Umt1nmKhepFHQvXBOP9oEt
         6IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gpAxKCJHhJjj+lN8WLPl+rXChbbfElVUx5p01InmYQs=;
        b=lAXCep81te2r0g1/lTL5/qTq2hyIjIGkS5dSZzNu4q58wAU3EPG71HGv3qmyvnCKbR
         nI/GIXZiJqroF4AWm7oZ2j1E+6IYoqPxAYKWS1n2Huq2GW9l3N+RSMlZVWi7ag05u0Kj
         7XROF/IyVGZWpULRo19oc+fMQv1Qn0PcnIHRhER84EFT9rVmnTQb+oiQFjxzr0dW+u4H
         kMD2oDIWL2GT+/c+SWECrTmgqDgex3bD3e16gOAnOZUac2YEvBBlcmUOLbvvrMhE4/AM
         oH3YDbyx714nxuVmhCAn88gk9yBVmOVVZmj0oJ4PocdD98ojwU2jcVnRiATi/i19X0c7
         OQ2Q==
X-Gm-Message-State: ABuFfojafaDM/Hbsofs1101haGIG0iNk6mtdAvzyK0d/w7SBHGBF5rjW
        n9IhKBJL9QMwaesrIrPLShu9CgZXVLo=
X-Google-Smtp-Source: ACcGV61fnaMuAsDAf3s0AhMj0stIdVVD58fbQT4wsjdSyTC/zyvYzkxis+6UreLnt3i86lQy5ukTBA==
X-Received: by 2002:a2e:8797:: with SMTP id n23-v6mr11701628lji.173.1539632406519;
        Mon, 15 Oct 2018 12:40:06 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id l3-v6sm2658830lji.60.2018.10.15.12.40.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 12:40:05 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 3/3] mtd: rawnand: ams-delta: Convert the driver to ->exec_op()
Date:   Mon, 15 Oct 2018 21:41:30 +0200
Message-Id: <20181015194130.21764-3-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181015194130.21764-1-jmkrzyszt@gmail.com>
References: <20181012204101.26274-1-jmkrzyszt@gmail.com>
 <20181015194130.21764-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace legacy callbacks with ->select_chip() and ->exec_op().

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changelog:
v3:
- former PATCH 2/2 from which PATCH v3 2/3 has been split out,
- added missing return on check_only - requested by Boris Brezillon,
  thanks
v2:
- replace references to legacy structure .IO_ADDR_R/W members with 
  runtime calculated values - requested by Boris Brezillon, thanks!
- modify ams_delta_read/write_buf() functions, no longer exposed as 
  callbacks, to accept driver private structure instead of struct 
  nand_chip,
- use newly introduced nand_gpio_waitrdy() helper instead of legacy 
  nand_wait_ready() - suggested by Boris Brezillon, thanks!
- remove no longer needed ams_delta_dev_ready() legacy callback and
  legacy structure member .chip_delay.

 drivers/mtd/nand/raw/ams-delta.c | 100 ++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 44 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 46193db6d368..9ca70aab199d 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -99,10 +99,9 @@ static void ams_delta_dir_input(struct ams_delta_nand *priv, bool in)
 	priv->data_in = in;
 }
 
-static void ams_delta_write_buf(struct nand_chip *this, const u_char *buf,
+static void ams_delta_write_buf(struct ams_delta_nand *priv, const u_char *buf,
 				int len)
 {
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
 	if (priv->data_in)
@@ -112,9 +111,9 @@ static void ams_delta_write_buf(struct nand_chip *this, const u_char *buf,
 		ams_delta_io_write(priv, buf[i]);
 }
 
-static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
+static void ams_delta_read_buf(struct ams_delta_nand *priv, u_char *buf,
+			       int len)
 {
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
 	if (!priv->data_in)
@@ -124,46 +123,66 @@ static void ams_delta_read_buf(struct nand_chip *this, u_char *buf, int len)
 		buf[i] = ams_delta_io_read(priv);
 }
 
-static u_char ams_delta_read_byte(struct nand_chip *this)
-{
-	u_char res;
-
-	ams_delta_read_buf(this, &res, 1);
-
-	return res;
-}
-
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
+	int ret = 0;
+
+	if (check_only)
+		return 0;
+
+	for (instr = op->instrs; instr < op->instrs + op->ninstrs; instr++) {
+
+		switch (instr->type) {
+		case NAND_OP_CMD_INSTR:
+			gpiod_set_value(priv->gpiod_cle, 1);
+			ams_delta_write_buf(priv, &instr->ctx.cmd.opcode, 1);
+			gpiod_set_value(priv->gpiod_cle, 0);
+			break;
+
+		case NAND_OP_ADDR_INSTR:
+			gpiod_set_value(priv->gpiod_ale, 1);
+			ams_delta_write_buf(priv, instr->ctx.addr.addrs,
+					    instr->ctx.addr.naddrs);
+			gpiod_set_value(priv->gpiod_ale, 0);
+			break;
+
+		case NAND_OP_DATA_IN_INSTR:
+			ams_delta_read_buf(priv, instr->ctx.data.buf.in,
+					   instr->ctx.data.len);
+			break;
+
+		case NAND_OP_DATA_OUT_INSTR:
+			ams_delta_write_buf(priv, instr->ctx.data.buf.out,
+					    instr->ctx.data.len);
+			break;
+
+		case NAND_OP_WAITRDY_INSTR:
+			ret = priv->gpiod_rdy ?
+			      nand_gpio_waitrdy(this, priv->gpiod_rdy,
+						instr->ctx.waitrdy.timeout_ms) :
+			      nand_soft_waitrdy(this,
+						instr->ctx.waitrdy.timeout_ms);
+			break;
+		}
+
+		if (ret)
+			break;
+	}
 
-	return gpiod_get_value(priv->gpiod_rdy);
+	return ret;
 }
 
 
@@ -211,10 +230,8 @@ static int ams_delta_init(struct platform_device *pdev)
 	nand_set_controller_data(this, priv);
 
 	/* Set address of NAND IO lines */
-	this->legacy.read_byte = ams_delta_read_byte;
-	this->legacy.write_buf = ams_delta_write_buf;
-	this->legacy.read_buf = ams_delta_read_buf;
-	this->legacy.cmd_ctrl = ams_delta_hwcontrol;
+	this->select_chip = ams_delta_select_chip;
+	this->exec_op = ams_delta_exec_op;
 
 	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
 	if (IS_ERR(priv->gpiod_rdy)) {
@@ -223,11 +240,6 @@ static int ams_delta_init(struct platform_device *pdev)
 		goto out_mtd;
 	}
 
-	if (priv->gpiod_rdy)
-		this->legacy.dev_ready = ams_delta_nand_ready;
-
-	/* 25 us command delay time */
-	this->legacy.chip_delay = 30;
 	this->ecc.mode = NAND_ECC_SOFT;
 	this->ecc.algo = NAND_ECC_HAMMING;
 
-- 
2.16.4

