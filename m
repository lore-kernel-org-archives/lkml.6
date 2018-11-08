Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910ADECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F777208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="naS9MWxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F777208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbeKICWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:22:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50280 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbeKICWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:22:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id 124-v6so1960610wmw.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 08:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXL2oXxjpuNjWt/hucj26s9Y9MA48Yp9jON68YMd/JY=;
        b=naS9MWxJPZEYXzoKH9Lz5a5eMGeiH3wAk9e8Nxn/wOkBj/rGu/L5uD8VNzAD5BimjC
         MJ3W/JVGZGUdZsVFH9VmC6Da4gJY/wbIfkQGCwd0Tk0W/LiNaB0EelpIRcIr7UIg1Q/u
         rPEqPruWf52tDD7u4fdH4veOzpoFVi+4m3lgRyJLdYlIrO1/OixqbsSA6booJjCh5xbP
         t9cu/3nhBd7vO5R2hry0i+1uEVGX9Z9lt++Z4P/vb6CE4HMqa4zscq3j3Gk8i+09JcBs
         i3m/WgvjXbuqr8RBRtyzkumjPofShHpnspjLISZxK0Espfn1ZsFW2nSHvAO10RpT30lK
         tQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BXL2oXxjpuNjWt/hucj26s9Y9MA48Yp9jON68YMd/JY=;
        b=AFHlJosGj3g86oap9AeAxwpO4y5BaYm4pet+nULRu/aKGvCoVisno8bi1d7G9Z3rlP
         VJWqDP/0QrQ9fUikV+ZuRf9QBB45l0R15LVVV2oaXU1nmHNrPdj6VbnZBOZKWk4VRp2T
         jVlsjpMWBFXzutXAzv1fejXGxwCztABWBhThRpMafhDIGg81G/TquDg9H4lAdI6D18DU
         LSsyehAW6VY0E4Q/z8Dp9tuX2sLRm9y9318XA6cSLUf80mmbh2Yk/LjvbDJJLcXtwrKl
         50Q/H7R4YnnMuJDqFDPyGSP9MMCp55q7FZ53l/Fk3P6NFe9Mw0NQ8HDrIsNGxhw0SxrR
         80aw==
X-Gm-Message-State: AGRZ1gI44jdPYhBmTNsJGDcywNZ0ME2oL3Gwmw630vSaO3mxVe/Ea8d7
        ykUMIG9OWH0WwRPGb/WhSKQsmQ==
X-Google-Smtp-Source: AJdET5dkkzKokK3Z155wSb+6AwD4tAbKJWqacEhRDjkG8vRFf6PWTyj/qcRV6jvo1ZeYOsukRRNl5w==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14-v6mr1781539wmg.45.1541695575251;
        Thu, 08 Nov 2018 08:46:15 -0800 (PST)
Received: from debian-brgl.lan ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id w11-v6sm4425591wrr.96.2018.11.08.08.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 08:46:14 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] mailbox: tegra-hsp: use devm_kstrdup_const()
Date:   Thu,  8 Nov 2018 17:46:10 +0100
Message-Id: <20181108164610.28361-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kstrdup_const() in the tegra-hsp driver. This mostly serves as
an example of how to use this new routine to shrink driver code.

Also use devm_kzalloc() instead of regular kzalloc() to shrink the
driver even more.

Doorbell objects are only removed in the driver's remove callback so
it's safe to convert all memory allocations to devres.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/mailbox/tegra-hsp.c | 41 ++++++++-----------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 0cde356c11ab..106c94dedbf1 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -183,14 +183,15 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, void *data)
 }
 
 static struct tegra_hsp_channel *
-tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
-			  unsigned int master, unsigned int index)
+tegra_hsp_doorbell_create(struct device *dev, struct tegra_hsp *hsp,
+			  const char *name, unsigned int master,
+			  unsigned int index)
 {
 	struct tegra_hsp_doorbell *db;
 	unsigned int offset;
 	unsigned long flags;
 
-	db = kzalloc(sizeof(*db), GFP_KERNEL);
+	db = devm_kzalloc(dev, sizeof(*db), GFP_KERNEL);
 	if (!db)
 		return ERR_PTR(-ENOMEM);
 
@@ -200,7 +201,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 	db->channel.regs = hsp->regs + offset;
 	db->channel.hsp = hsp;
 
-	db->name = kstrdup_const(name, GFP_KERNEL);
+	db->name = devm_kstrdup_const(dev, name, GFP_KERNEL);
 	db->master = master;
 	db->index = index;
 
@@ -211,13 +212,6 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 	return &db->channel;
 }
 
-static void __tegra_hsp_doorbell_destroy(struct tegra_hsp_doorbell *db)
-{
-	list_del(&db->list);
-	kfree_const(db->name);
-	kfree(db);
-}
-
 static int tegra_hsp_doorbell_send_data(struct mbox_chan *chan, void *data)
 {
 	struct tegra_hsp_doorbell *db = chan->con_priv;
@@ -332,31 +326,16 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
 	return chan ?: ERR_PTR(-EBUSY);
 }
 
-static void tegra_hsp_remove_doorbells(struct tegra_hsp *hsp)
-{
-	struct tegra_hsp_doorbell *db, *tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&hsp->lock, flags);
-
-	list_for_each_entry_safe(db, tmp, &hsp->doorbells, list)
-		__tegra_hsp_doorbell_destroy(db);
-
-	spin_unlock_irqrestore(&hsp->lock, flags);
-}
-
-static int tegra_hsp_add_doorbells(struct tegra_hsp *hsp)
+static int tegra_hsp_add_doorbells(struct device *dev, struct tegra_hsp *hsp)
 {
 	const struct tegra_hsp_db_map *map = hsp->soc->map;
 	struct tegra_hsp_channel *channel;
 
 	while (map->name) {
-		channel = tegra_hsp_doorbell_create(hsp, map->name,
+		channel = tegra_hsp_doorbell_create(dev, hsp, map->name,
 						    map->master, map->index);
-		if (IS_ERR(channel)) {
-			tegra_hsp_remove_doorbells(hsp);
+		if (IS_ERR(channel))
 			return PTR_ERR(channel);
-		}
 
 		map++;
 	}
@@ -412,7 +391,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	if (!hsp->mbox.chans)
 		return -ENOMEM;
 
-	err = tegra_hsp_add_doorbells(hsp);
+	err = tegra_hsp_add_doorbells(&pdev->dev, hsp);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to add doorbells: %d\n", err);
 		return err;
@@ -423,7 +402,6 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	err = mbox_controller_register(&hsp->mbox);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
-		tegra_hsp_remove_doorbells(hsp);
 		return err;
 	}
 
@@ -443,7 +421,6 @@ static int tegra_hsp_remove(struct platform_device *pdev)
 	struct tegra_hsp *hsp = platform_get_drvdata(pdev);
 
 	mbox_controller_unregister(&hsp->mbox);
-	tegra_hsp_remove_doorbells(hsp);
 
 	return 0;
 }
-- 
2.19.1

