Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26374C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B7E20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q02l1kNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B7E20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeHVOWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:22:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36206 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeHVOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id u7-v6so1107859lji.3;
        Wed, 22 Aug 2018 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XYfaecJx9bBz0jf+ZM8EiKMSyPeWIwllL8/LWZq0uRs=;
        b=Q02l1kNh1XTYt51bjEJs1oBB51RpHZV3MZxXTsLrc9IpJmobV8On9sTkLyT8d+MHw2
         iwoMWKGx2Y+vPHRL/O57IlGGEyHYnAdVo01WHTIPKhE1F8ZWnoMC9FbVJXRy0pARVQjd
         6boZoD51oKobh4CUNgw6+78HQ1DzLxHzBh/qXp7r3pW3EB6pbSa8BBNYiMQFkD87i22M
         DDnnp8VjX8nr1fzn3YQNmAfk20tdOUAlwUQRWUf14Tzm2O8+s4bpsyBgsGRjw0RKJiat
         0/2D57xkqayrDMTn+8j6ulgLYzka7QxWLCB/zIaStH7oo5yL6B5hdnjxTupGwXHEfIa5
         jERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XYfaecJx9bBz0jf+ZM8EiKMSyPeWIwllL8/LWZq0uRs=;
        b=Y6EDgi27kNlhpwZJLhCusobH6y5CXe2Wx176u3XuMXt6r+5RCEhDbLHwjr9aW0NzQ/
         Sgxu1gvwo7KHBMOApwyM5e0yCDcTDNt8kfJBSgSiMs36eWcaEb7c/uX2wwTeg2vW++X0
         T4jkCPo9j/2JsJBGqUA1e0LsUztx27LH/kAx8y6EFkZZBGZ2BE4IYSswvwA6Spq/96iQ
         kjMr912dT1wgiJzPwM7ku9Nbq/249a+pSv/Yb9vZzX5RIU2pJN8k2CyAoK7PAosAt8+7
         9Egjkfm/ldrLY61zToK/lqtiNB3eNaTtTgpzENOk4bJSYFCvj0U8kejpi7rroM/0nowS
         JHmQ==
X-Gm-Message-State: AOUpUlHuCkhn4+bhagBZlZXgPqWVph6cBd8K73cjRw7EdKHIOWh/8CEL
        2YHVe0yUZ8w7uEb90NVGEyk=
X-Google-Smtp-Source: AA+uWPz1n9jLtqjO/KraojagEpNQnhT95Gn94YT0/Sy9odUeSJfLv7ss8KpjJcBfnZ0Oq06tIVNxLA==
X-Received: by 2002:a2e:4103:: with SMTP id o3-v6mr20144461lja.3.1534935441422;
        Wed, 22 Aug 2018 03:57:21 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id z5-v6sm257819lfg.75.2018.08.22.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpC-0002XX-UW; Wed, 22 Aug 2018 12:57:18 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 5/9] mtd: nand: atmel: fix OF child-node lookup
Date:   Wed, 22 Aug 2018 12:55:43 +0200
Message-Id: <20180822105547.9634-6-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the nfc child
node instead of using of_find_compatible_node(), which searches the
entire tree and thus can return an unrelated (i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

While at it, also fix a related nfc-node reference leak.

Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
Cc: stable <stable@vger.kernel.org>     # 4.11
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Josh Wu <rainyfeeling@outlook.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index a068b214ebaa..d3dfe63956ac 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -2061,8 +2061,7 @@ atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
 	int ret;
 
 	nand_np = dev->of_node;
-	nfc_np = of_find_compatible_node(dev->of_node, NULL,
-					 "atmel,sama5d3-nfc");
+	nfc_np = of_get_compatible_child(dev->of_node, "atmel,sama5d3-nfc");
 
 	nc->clk = of_clk_get(nfc_np, 0);
 	if (IS_ERR(nc->clk)) {
@@ -2472,15 +2471,19 @@ static int atmel_nand_controller_probe(struct platform_device *pdev)
 	}
 
 	if (caps->legacy_of_bindings) {
+		struct device_node *nfc_node;
 		u32 ale_offs = 21;
 
 		/*
 		 * If we are parsing legacy DT props and the DT contains a
 		 * valid NFC node, forward the request to the sama5 logic.
 		 */
-		if (of_find_compatible_node(pdev->dev.of_node, NULL,
-					    "atmel,sama5d3-nfc"))
+		nfc_node = of_get_compatible_child(pdev->dev.of_node,
+						   "atmel,sama5d3-nfc");
+		if (nfc_node) {
 			caps = &atmel_sama5_nand_caps;
+			of_node_put(nfc_node);
+		}
 
 		/*
 		 * Even if the compatible says we are dealing with an
-- 
2.18.0

