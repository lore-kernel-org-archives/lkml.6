Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E187224027
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1swYuuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E187224027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933539AbeGFNFo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:05:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38235 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932679AbeGFNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:05:29 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so14346132wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/mf4+83ViPj1iK27CkQ1OhZ1KivB8GyjbH3i6v8+LPY=;
        b=N1swYuuX3igHAcCiLrU0mni/+u+RKjKPGWMA7CHSoNQNhrZiC3dt26sO6FXyiocKgH
         iirSvEndWtqSHxnX6Y3CmvUMiEn3XLb/LdjdSjzmyCY5NH0H4CHhgeB/boN3tppHa5XV
         /Py7lupksH5z+uu4I3vsM20RMaOrBZ8IkoYn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/mf4+83ViPj1iK27CkQ1OhZ1KivB8GyjbH3i6v8+LPY=;
        b=UrjuSJkx5Scgv/p2ZPrvIIYrxZCmT41G3AYqtqL9wmE/4qHpnNyCbdeJj3hTQARtwa
         Q9fsuffrLWzI2Fg4xvHrohRyRewBOkVY83VZF3mMDMkP1bYEQ4n9LosTj4NEBqi4/vsd
         h7VCfDLRt+T5rurEO8Se3t33dbvEEKpEQyDyTKIeM0EU8I0yf5LnPMBXy+IFNc2h5hZf
         E6/vaQltuI2C71X34rchEznVpntFCU8eygsuJhOkCv0A73RAIgGZ7GLqYBA455mgS5fh
         /yGoUm02mRsivuEP2ZRR3wDAdvMdBIaSd5DMl294EBGyDweC518ZxnyoZu47rKbS5eIg
         U8lQ==
X-Gm-Message-State: APt69E2pzyrVm5aSqDqD9lTPrRl/Lum5eg1lIPam9MU+X6HXO2M6iTM0
        2rzWmW8AuzRG7pF5NGk/GfWu6A==
X-Google-Smtp-Source: AAOMgpfF8F4Px9j2o6vEqxcfUcf/EITxmHoCTWIUL8+1iVCiVMARz+QnKeNR3UQ+S0h47VL33/45+Q==
X-Received: by 2002:a1c:6709:: with SMTP id b9-v6mr6825764wmc.68.1530882328820;
        Fri, 06 Jul 2018 06:05:28 -0700 (PDT)
Received: from lmecxl0911.lme.st.com ([80.214.65.221])
        by smtp.gmail.com with ESMTPSA id i14-v6sm6559273wro.11.2018.07.06.06.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Jul 2018 06:05:28 -0700 (PDT)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] mtd: stm32-quadspi: replace "%p" with "%pK"
Date:   Fri,  6 Jul 2018 15:05:25 +0200
Message-Id: <20180706130525.22223-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/mtd/spi-nor/stm32-quadspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
index 72553506a00b..13e9fc961d3b 100644
--- a/drivers/mtd/spi-nor/stm32-quadspi.c
+++ b/drivers/mtd/spi-nor/stm32-quadspi.c
@@ -355,7 +355,7 @@ static int stm32_qspi_read_reg(struct spi_nor *nor,
 	struct device *dev = flash->qspi->dev;
 	struct stm32_qspi_cmd cmd;
 
-	dev_dbg(dev, "read_reg: cmd:%#.2x buf:%p len:%#x\n", opcode, buf, len);
+	dev_dbg(dev, "read_reg: cmd:%#.2x buf:%pK len:%#x\n", opcode, buf, len);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = opcode;
@@ -376,7 +376,7 @@ static int stm32_qspi_write_reg(struct spi_nor *nor, u8 opcode,
 	struct device *dev = flash->qspi->dev;
 	struct stm32_qspi_cmd cmd;
 
-	dev_dbg(dev, "write_reg: cmd:%#.2x buf:%p len:%#x\n", opcode, buf, len);
+	dev_dbg(dev, "write_reg: cmd:%#.2x buf:%pK len:%#x\n", opcode, buf, len);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode = opcode;
@@ -398,7 +398,7 @@ static ssize_t stm32_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
 	struct stm32_qspi_cmd cmd;
 	int err;
 
-	dev_dbg(qspi->dev, "read(%#.2x): buf:%p from:%#.8x len:%#zx\n",
+	dev_dbg(qspi->dev, "read(%#.2x): buf:%pK from:%#.8x len:%#zx\n",
 		nor->read_opcode, buf, (u32)from, len);
 
 	memset(&cmd, 0, sizeof(cmd));
-- 
2.15.0

