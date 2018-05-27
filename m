Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeE0Vy6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:54:58 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:45028 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbeE0Vyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:54:50 -0400
From: Stefan Agner <stefan@agner.ch>
To: boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc: dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 1/6] mtd: rawnand: add Reed-Solomon error correction algorithm
Date: Sun, 27 May 2018 23:54:37 +0200
Message-Id: <20180527215442.14760-2-stefan@agner.ch>
X-Mailer: git-send-email 2.17.0
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[26];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:37.17.238.0/23, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reed-Solomon (RS) to the enumeration of ECC algorithms.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mtd/nand/raw/nand_base.c | 1 +
 include/linux/mtd/rawnand.h      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index f28c3a555861..9eb5678dd6d0 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5744,6 +5744,7 @@ static int of_get_nand_ecc_mode(struct device_node *np)
 static const char * const nand_ecc_algos[] = {
 	[NAND_ECC_HAMMING]	= "hamming",
 	[NAND_ECC_BCH]		= "bch",
+	[NAND_ECC_RS]		= "rs",
 };
 
 static int of_get_nand_ecc_algo(struct device_node *np)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 5dad59b31244..6a82da8c44ce 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -114,6 +114,7 @@ enum nand_ecc_algo {
 	NAND_ECC_UNKNOWN,
 	NAND_ECC_HAMMING,
 	NAND_ECC_BCH,
+	NAND_ECC_RS,
 };
 
 /*
-- 
2.17.0
