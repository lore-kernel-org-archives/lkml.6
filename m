Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF29C64EB0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A3821476
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w7W/tX/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A3821476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeJADAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:00:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32779 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728633AbeJADAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:00:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id y140-v6so1153216wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O0syVcyhMbKhyp2iqYZ+ip089O6apq5xjZEumPKtFH0=;
        b=w7W/tX/T82M7c8f+3bIhAve5JFO+DY5Rq/2i2fCIRsiRQ6Ly2dYZBl765fvH24WH3G
         JmCG9rlZHdOA5Ql9EhsPMPtx4PhSptEP/anrdZwDMWQ+lOkwszTGMTRV8RSg/8MXlwAR
         rQdYV8kY/ZAgCE+HPYsd7/vaq0PaVDoCTC+BpKXjuDgzX5HZZ8o/F28itZW5DtjfFxnw
         8a+HeuypnIZv3RoniHbHyB47mTjJnw73pzV7nRUYwx6KgVMnSa+xlY8PfJK2lMMdIt9F
         N77seMORgsw5Giqy3bC8gtZs1bbzcOl3S/wOD3nEhHar2VQtVaosedt71ZsWMCy1Mfyr
         vmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O0syVcyhMbKhyp2iqYZ+ip089O6apq5xjZEumPKtFH0=;
        b=S+UNIWNxNadMVu1ttW4psrt8GiPaFRvJDze4eEqgXa+rW0jSeUYZqaj5zctu5lNQEL
         8ovj02Z68/tBwLYD71PadJZg2Yk1eqT5SfLMirDK3B5JZDA0bN5cpj504l6IIJfRHt7V
         barNy+Yp6j0ZDEFBAYt25Fy7tdq8SYmoiABqynxzyolFJn7F3RbZkW17M8UjKViJZvT+
         SS7fR4MgvB9FbPOwAOqRYanKma5pVRH5tKEjDDO7M/70Xd17Gck/VR5cKNxzuD73EbZF
         7GX/9aRbtDTEbtHwGmp2LQWSTH35yPOfWjzgM1yGwCW9RdTg10AifP2vYkYHWR0hD4DY
         KpWg==
X-Gm-Message-State: ABuFfohhUlBfTHW7J5I/PIsZvHOZAjZs120Sr54BOCm9eh59dZTqrPZg
        WcYAg5HVKELRXfTK3a3kHLDfkw==
X-Google-Smtp-Source: ACcGV63VEVVK1jkBPOt9G/PKx3iIU00AOIjNPTudis33UXJEKkC/iwZgNmYbzNkIdlYHsIL4ih0TvQ==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr6843040wmc.81.1538339185950;
        Sun, 30 Sep 2018 13:26:25 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v16-v6sm18566465wrw.12.2018.09.30.13.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:26:25 -0700 (PDT)
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
Subject: [PATCH v6 4/4] mailbox: tegra-hsp: use devm_kstrdup_const()
Date:   Sun, 30 Sep 2018 22:26:15 +0200
Message-Id: <20180930202615.12951-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180930202615.12951-1-brgl@bgdev.pl>
References: <20180930202615.12951-1-brgl@bgdev.pl>
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

