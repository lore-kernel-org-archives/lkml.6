Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE261C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937752075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937752075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbeIFNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:24:42 -0400
Received: from mout.perfora.net ([74.208.4.196]:52027 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeIFNYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:24:41 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LsAZt-1fsux92xGp-013zNR; Thu, 06 Sep 2018 10:49:33 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-mtd@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 2/2] mtd: nand: esmt: retrieve ecc requirements from 5th id byte
Date:   Thu,  6 Sep 2018 10:49:22 +0200
Message-Id: <20180906084922.14845-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180906084922.14845-1-marcel@ziswiler.com>
References: <20180906084922.14845-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:KugurajwO1t/DCnRBB9T7ma9F2Ek5JHfPFMkwiB0I2gVImtC44J
 /urNlWZHfis1H3wbgIdbkNCkBNQY/ZB0zTagr01KeR3NNgPOH0SZ13gmjHu8EmYOVWJQabR
 wZKdFv1B26usZBhB0I+8l/hwX2LX1DZMvPs4zbw0lZ5Sgfq/sWjnTcPAKI/rAjt17EDnDPE
 lc1WBfGLvpEifFTmE8JEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:99t7MRnuZDo=:fc1N4lD7X/uUUOhlObvjz3
 WGuAiqatwuYP9vmcCLmk5AKxud7hzJjDtm9pZDXPOr6uK7aLECLB8uJUoP5k3jLFpa8c8E2x1
 m7ar41T7lljn1gW9uD/BdeiHCWkxvBPwgYLl9/Yzop212UuqBK2itOfTng2h0BA/mm+z8oCi/
 82k9LgW5aGqBUQ8UGgIPMHrNm2ECUm+8cCBv6d4LEzlY+BSqH4Ixpu3HG5EIGJiSMMuGfXg0i
 NKumz5FD3Pq8fGtvRNUSu4VMFip9qIe/91yv/w5YXb809invlaPbDUd5FrZRwbrAJ6WTRXZ4P
 X/u6DhVFoxh6REi4scR0xBFi1rlsn34B3vBpdGDB70WFxrpah/AWvRSSPXo/aHxFlGEcOTufw
 7QW9O80ju3A/Ne/S9bkWEH68S05aNBsxlxl5Ti1CFauA8m5UMyCqGnKEYYYqDvH5pJWdcGgrJ
 gwrJr8m1drh2R0mgxuszYRa5bhdShaRnSU1fqkL+aeJ+bFSHKvs3OM7ttsY+NnMCBMeqUYNS9
 VSo5inuJ2xF0SFJqAuW/UrXgOzTzhkOwb1fqeJaXAghtFd+ZfMLFZPti38zE7ePYnMD5MjPHV
 3ybPSA3MQ9wbSrYwYLc8HOvFxgseFL4kS6qmL12tzEnoDM9w1YM5kO5nhC7BbnMmwoISIV5J3
 qT7m/ble4ayH8V1dsuIH/MbwsmoYhJy2zJnBqa687CZJWVNA3OeRjPVtF8G6xZ8OASLc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This patch enables support to read the ECC level from the NAND flash
using ESMT SLC NAND ID byte 5 information as documented e.g. in the
following data sheet:

https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F59L1G81LA(2Y).pdf

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/mtd/nand/raw/nand_esmt.c | 46 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 drivers/mtd/nand/raw/nand_esmt.c

diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
new file mode 100644
index 000000000000..360d351ac043
--- /dev/null
+++ b/drivers/mtd/nand/raw/nand_esmt.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Toradex AG
+ *
+ * Author: Marcel Ziswiler <marcel.ziswiler@toradex.com>
+ */
+
+#include <linux/mtd/rawnand.h>
+
+static void esmt_nand_decode_id(struct nand_chip *chip)
+{
+	nand_decode_ext_id(chip);
+
+	/* Extract ECC requirements from 5th id byte. */
+	if (chip->id.len >= 5 && nand_is_slc(chip)) {
+		chip->ecc_step_ds = 512;
+		switch (chip->id.data[4] & 0x3) {
+		case 0x0:
+			chip->ecc_strength_ds = 4;
+			break;
+		case 0x1:
+			chip->ecc_strength_ds = 2;
+			break;
+		case 0x2:
+			chip->ecc_strength_ds = 1;
+			break;
+		default:
+			WARN(1, "Could not get ECC info");
+			chip->ecc_step_ds = 0;
+			break;
+		}
+	}
+}
+
+static int esmt_nand_init(struct nand_chip *chip)
+{
+	if (nand_is_slc(chip))
+		chip->bbt_options |= NAND_BBT_SCAN2NDPAGE;
+
+	return 0;
+}
+
+const struct nand_manufacturer_ops esmt_nand_manuf_ops = {
+	.detect = esmt_nand_decode_id,
+	.init = esmt_nand_init,
+};
-- 
2.14.4

