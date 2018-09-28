Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D81C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE2121746
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eH5Bu5Tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE2121746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbeI1Ngv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:36:51 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36986 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbeI1Ngu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:36:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id y26-v6so1085790wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O0syVcyhMbKhyp2iqYZ+ip089O6apq5xjZEumPKtFH0=;
        b=eH5Bu5TjjtCkudqDsqgVImR5aSsVR9PfvdmPNwy0Ab3E3IEL7Wf8GNG13icu3K+SVe
         YeiOesAFjXCjNyCIdvwLaEm9Qg+6M8GVcDCD3hgP0cONHxeEKlCCiLYbvtNdNy2Q8Gs5
         h4mYjaJeNoCmRJyFJSz8cPkcAcfAYUxeDok7X1Cb0ef+aKJ5bIk/qlAg+327GoJU2O7s
         PHjjJcEqgFZCXKtAqUHH1hSGWQV5crARB2a0vy9ldUPOrxhAefROKo1kW3yYw0Tge5x5
         YxAhWBZ5iIj2V7s3W1sbn6BQNROXbtXNufEQkWGb7VSvFmEpN+8gJcWP/3NPQKE25gjw
         qOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O0syVcyhMbKhyp2iqYZ+ip089O6apq5xjZEumPKtFH0=;
        b=OPEN3e91Ncmua9O5u7quvxjRx+E1r1GHfyYkyUVvk3/xhNYf442dILUV/0DG6vKl8Y
         OlxPq3yoRr9aKWaJmgO9Vdd14IAgbcbfPT/J5oY8b9CMgzoPwUxXdZYjWO7rxkMMIUt+
         yVCP3gWl3PcjDzEvWwCfQ0PCxn0qQzRuTZFT9y9z8Xo93DMmb+eBJcqg0ub5hP70z76w
         zkvzIGacKW+xKfcXoOCCIfwzMCuG/0vHrm4UHdtl1foRYilQCfA5ZMEvrgIrUMKuCI75
         bYEhrWadwSv6GT4cjO4poNZp51SDrrz8cwIsoNNVaQiVOutkUBhveghn91/QApyKd7NQ
         pvIA==
X-Gm-Message-State: ABuFfohQ9hKNGrSiXfvXYppXZg9nH/GKAH9ObtimsgW9JdH/KvNDV5n2
        ryCaTdw9H5KU49BJgj0m0Mq0xA==
X-Google-Smtp-Source: ACcGV62OtkYGNUVoag8MQ8Dim53QZGhQ76CQ7wFrYyT9hH7M+b6Jk0oCtMElLoxflnt871Kv8EjfuQ==
X-Received: by 2002:a1c:b4d:: with SMTP id 74-v6mr683041wml.15.1538118867141;
        Fri, 28 Sep 2018 00:14:27 -0700 (PDT)
Received: from brgl-bgdev.sitez.s.ibrowse.com (93-158-26-51.subs.ibrowse.com. [93.158.26.51])
        by smtp.gmail.com with ESMTPSA id w3-v6sm2699580wru.93.2018.09.28.00.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:14:26 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v5 4/4] mailbox: tegra-hsp: use devm_kstrdup_const()
Date:   Fri, 28 Sep 2018 09:14:14 +0200
Message-Id: <20180928071414.30703-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180928071414.30703-1-brgl@bgdev.pl>
References: <20180928071414.30703-1-brgl@bgdev.pl>
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
2.18.0

