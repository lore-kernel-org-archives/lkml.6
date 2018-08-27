Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6951FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2529A21746
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fzi7GNmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2529A21746
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbeH0MIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43956 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeH0MIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id m84-v6so11587581lje.10;
        Mon, 27 Aug 2018 01:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZNAYksAopsEQ5bLVYvPV8FzwGGcmlbAzmNT8NC9D34g=;
        b=Fzi7GNmMMyZEtg76T3LfNOS8zFvJ/xL98cm+6Wdjs6gY0gBvY6rsEKbgOXEsMRCFc8
         I42EerwKTwUsNqpNZV76TZFN9n24T35hPhCKmo0XwSNKGR+mF2kmOxp+RlfQECuenZV/
         9pOh+qTrBKj9C8mdx99GH2GVQDx2CbgWXhdZ3I+3kNKic+4yp6qMywyci3q5mVCR+gJ7
         LJzMqpDhoG9Cfjw7Z2CPZCiP/LMIZ0VxpFUKyIKstoVEU/+DDTREf0K6QNDy8jiuhnHT
         mP8tNffzeOOHBPIK6G6IXgj86vVleelRDQux4olT4LySd6PMsho/Z1NUoTFFyCGYH1jQ
         3KSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZNAYksAopsEQ5bLVYvPV8FzwGGcmlbAzmNT8NC9D34g=;
        b=VrsLiAKA8VUmh8ZQjww5O1KHfSmAJIQrIynoI0JBj6GMEyN1g0JiEUI+vMEFT8k/mf
         a86p6YM5TxAw5W8ZE/Q554YULaBo8/HG9V9B5H9oKTDcyTvdfwvKRPmEnv+MiuBX3hWB
         BnNr1pD63BRmvHsSWgmCAgveu6gPXZ+kpMTXi0viHtRehf8eFmmfpOQovU6QZ+o01lqY
         g53eF29cFXUaWZCFhTN6EoppXokilt5x4VaWsyoZXkUsQLZDzOqq3rkdLXpuXhiPJ4dL
         xCOeVgCxY2GVZXNd8CjzDjWhIRSXNTK5KdKW4BOOA7WscoS/mvqLIAvfwPSDn3po1xzV
         5zFw==
X-Gm-Message-State: APzg51CfajZdNdGmbo1yOlmvQqC0c/Bgvf3hq6p4WE8jhtxPvgxAzU54
        fJTFqq6eZjxE/GCtiYSWJg4=
X-Google-Smtp-Source: ANB0VdZJTEoZgDeEQu3V2r0GEjUS3QHkRYPZH4xfYm4OG1RS1g//p03S4+wS8WuD00dN+ummnfs/nw==
X-Received: by 2002:a2e:2e02:: with SMTP id u2-v6mr8107552lju.77.1535358157432;
        Mon, 27 Aug 2018 01:22:37 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q23-v6sm2729468lfj.80.2018.08.27.01.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn6-0005sm-UV; Mon, 27 Aug 2018 10:22:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v2 5/9] mtd: nand: atmel: fix OF child-node lookup
Date:   Mon, 27 Aug 2018 10:21:49 +0200
Message-Id: <20180827082153.22537-6-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the nfc child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

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

