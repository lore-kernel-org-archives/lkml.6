Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF63C67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D572086E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n33pwGwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D572086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbeLIGOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:14:34 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42561 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeLIGOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:14:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so3703525plp.9;
        Sat, 08 Dec 2018 22:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mFFsganM5yysFPO4IRgicxx+jPhD6yBTm9ZFW2lffBM=;
        b=n33pwGwLv02PPNA/NMBO7lX/U7t5GwOAPinMgSHqmrHqKZ97jTZb08WD3N3db6yvLz
         HntDcXZjAkOWGTPvBnDJxjLvJl7qzPM0PWTnvo18BsEWehkTpdkn7rbJUHy5hgum1/aL
         HCr7eGOirpJT567NYNRHgmA2+pKs8E8ra9M1/Ev+TaCY4t6sX7SPa0Y89bNNDytjfrA0
         u4BP+ThQcp1X1nUhZ7hJM07kKp39nZhvbvht/VQ+wfWmH1jwCGvQvJH8t/Gqxy/V9EMO
         sotvNYmMvyR/X0CZJktWxKwchgc59BPJ5mAcwdHffTKDyW/Z9sLMIGEaPS67GItqiO9q
         IVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mFFsganM5yysFPO4IRgicxx+jPhD6yBTm9ZFW2lffBM=;
        b=J7vOmuEUGUVUwgEvn3A1fOm+FTumnRwqC4uODJP8hZxz/tdIwCFYWdw9u0xKmXLBnN
         jjuU5wzpahl5kb7J5YXWLK7IY4o1oCoLaMTxunBCs3DTwfhkosSfe4MnEahxadoQi5Xo
         SvsCN9fcWd9sbCdkRW5xMBcFePb0aQ82ZJ3uxEQWaQrhN3j432FxTXMCHWfTEWkbbr3/
         TR7OJBxCuygjx3v6ZlYj/pZrxjExUkA2pEX9PCPtRKEmis4mQV4jnuBADLCRacR88/i9
         rd555YvrNzDPIiOF5YkvVoP11e1iDfPRpcrkUCsu5mgjXBDvV26kfpvrdmzCGm2AlRaE
         q/XA==
X-Gm-Message-State: AA+aEWbFOIWLa5by0RrC8WJFxUmxQUi+O6+Y0C/fqUTKGYEODtoBezn4
        yOk8lVB5XU7XHGBTCgkXqHqzwFrC9RM=
X-Google-Smtp-Source: AFSGD/XMRpk0UXaCy5mz7GRGVDV8Jzy+PFFXkvVTQyK7eG3JZGTm6YEKVMtjsbs8iMoXSfrsIVWRFg==
X-Received: by 2002:a17:902:a50a:: with SMTP id s10mr7466704plq.278.1544336073572;
        Sat, 08 Dec 2018 22:14:33 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id h134sm13029961pfe.27.2018.12.08.22.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 22:14:32 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3] Input: i8042 add i8042_is_mr_coffee() helper to avoid refconut leak
Date:   Sun,  9 Dec 2018 01:14:28 -0500
Message-Id: <20181209061428.19205-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_node_by_path() acquires a reference to the node returned by
it and that reference needs to be dropped by its caller. Add
i8042_is_mr_coffee() helper to avoid refconut leak.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
changes in v3:
-add i8042_is_mr_coffee
---
 drivers/input/serio/i8042-sparcio.h | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/i8042-sparcio.h b/drivers/input/serio/i8042-sparcio.h
index 796289846204..c8dc5b4b5e4f 100644
--- a/drivers/input/serio/i8042-sparcio.h
+++ b/drivers/input/serio/i8042-sparcio.h
@@ -106,11 +106,23 @@ static struct platform_driver sparc_i8042_driver = {
 	.remove		= sparc_i8042_remove,
 };
 
+static inline bool i8042_is_mr_coffee(void)
+{
+	struct device_node *root;
+	bool is_mr_coffree;
+
+	root = of_find_node_by_path("/");
+	is_mr_coffree = !strcmp(root->name, "SUNW,JavaStation-1");
+	of_node_put(root);
+
+	return is_mr_coffee;
+}
+
 static int __init i8042_platform_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (!strcmp(root->name, "SUNW,JavaStation-1")) {
+	if (match) {
 		/* Hardcoded values for MrCoffee.  */
 		i8042_kbd_irq = i8042_aux_irq = 13 | 0x20;
 		kbd_iobase = ioremap(0x71300060, 8);
@@ -138,9 +150,9 @@ static int __init i8042_platform_init(void)
 
 static inline void i8042_platform_exit(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	bool match = i8042_is_mr_coffee();
 
-	if (strcmp(root->name, "SUNW,JavaStation-1"))
+	if (!match)
 		platform_driver_unregister(&sparc_i8042_driver);
 }
 
-- 
2.17.0

