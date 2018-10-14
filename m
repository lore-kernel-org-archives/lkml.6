Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63085C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289842077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZsOa7omx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289842077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeJNXBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:01:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46869 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJNXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:01:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id n11-v6so18278032wru.13
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dqAN3UQr5Z5crsqmyfr7zCZnzzm1TnIxid6v8uzkyc=;
        b=ZsOa7omxsElpVzzW/zLWbsCtT6XVfZ6yZuXc89YsXEMxXmgS0BW+0wbWZ1vjfYafyI
         UOMZYpmZND+oi5/YYMyGhVVvXN63IzLrikCvn3W1ww+U9zTTJ8R3Xy9LnH1feiJO8a8K
         sAKKUprxqq5SAKSrOKCe7uTiqlJKDMCQ8Un8eBcQSb985Zy/FWZfajGzWHKZMoeyxxaO
         ENF3sE9vkKmlb9x4qEs3D4g7o9LX7bgLRUzvobjBKHT8RJ+4wsxgcGP3ZiXyquIH+0Fl
         bHForlNwS8rhmWQ0Rw57DOdD+o37241qEXMcFB9uFBKMW8xB4+MZ4G41F1YPygmpLVvN
         LLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dqAN3UQr5Z5crsqmyfr7zCZnzzm1TnIxid6v8uzkyc=;
        b=VAGf5pD7uLlgNlinawpOHu+4TjMsTOc67dqYmC967BBxJfNE8yMIy5Jr7e4pReIWhW
         tcbFQQ3IyjDri0RWedKdq59Rm1tjOzoGE40I21n0wyMwffrt0hEuT/HilkrL9twr2uV6
         RARv0NaBPk1YRQRR1FCSXxlZTTkY2DaOuZPLXn0uSPfjwYIE34oAgsZDhHTx9IILQR9s
         LU42n22+ZDWcTcaDZ4ewNRENQBURsEqNi3DhAOqJhFOe1aQEHKDkz8ETW9oWCyEjBRHW
         JwJXHx4uFHOGyyzxBj0aZBJ3m4lig97pURLekhX88mqyWi6stp0n5isJvt9tmJL4wPrz
         CDeg==
X-Gm-Message-State: ABuFfohqb6j0dfBFaeDXFe164ijA0M+ibfuPwfAlMn2dlCSe3XAbhl0A
        iit7Nm1vM50U/jjrQV1w6myPcw==
X-Google-Smtp-Source: ACcGV61HGeL5Z+E9vC/EfCKHl1Dqu2PRXanjO2k4NhPbuPT3srCYqESh841+4ys3yWp+7zd95xCtbg==
X-Received: by 2002:adf:f3c7:: with SMTP id g7-v6mr10990175wrp.229.1539530424135;
        Sun, 14 Oct 2018 08:20:24 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b139-v6sm14789830wmd.36.2018.10.14.08.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 08:20:23 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v6 4/4] mailbox: tegra-hsp: use devm_kstrdup_const()
Date:   Sun, 14 Oct 2018 17:20:10 +0200
Message-Id: <20181014152010.2021-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014152010.2021-1-brgl@bgdev.pl>
References: <20181014152010.2021-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kstrdup_const() in the tegra-hsp driver. This mostly serves as
an example of how to use this new routine to shrink driver code.

Also use devm_kzalloc() instead of regular kzalloc() to get shrink the
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

