Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38226ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D773320858
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rvnrCEM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D773320858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbeIYSyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:54:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40429 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbeIYSyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:54:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8-v6so19586359wrh.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O0syVcyhMbKhyp2iqYZ+ip089O6apq5xjZEumPKtFH0=;
        b=rvnrCEM/Z/FjAF10btQEVl39K0wR7FmhNb2m1KMIHrQzomkug3Z39OQDttS5FJkCCa
         bZRz5Vn8EnaTQjX9fsP1nnZjQhzFqI2fhkqOw1QNm1CqRnYCAc1ppVU5XBvS6vgm4V25
         oZIYS2uJ8ZxCLdhwVgaUD/hVyNRLbbywscYPI2lrzoYiEX1FxX2etL5rxDIJUyqD25zO
         0kG7kZST83kSG7sRsEaI9u5TRcd/7bQy7eMvhWVKts02xPspTbXjT3/2lL18bdqZ/5NG
         7eHVutr3zo544N4s3a3yHlFjeVDD9fBbRbtN9M1JDT/eq9++U/sDDy0y6t/lLjoeUPET
         /GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O0syVcyhMbKhyp2iqYZ+ip089O6apq5xjZEumPKtFH0=;
        b=BxvTTzJcuwA5G4vl97Dud01XGjTUvFtMfJmZe0mRwnhvG59bqwY+wbg/P5QM+iMgqX
         3SURh5pzO0SX9FliYND7JztiNg+kBrE+4rE2RdKN7Eya4ywAn1/WvGMmZaOZpzcKwAGR
         V5UTfE7YdmzXjOnY7YxO2IMPC3RYAUKMzIsW9d5K0yCcQ9DnDLNFaYzy8+9VsjcbYAY5
         +VcsJvVw4/W1oDNqf+Z7dCGv8twldbVd5u091+3HV/yTV3Z1o+VhYBR11qanW2wDTs2E
         8+76Jgg4NjM1MXqz6ETa4WQA9HPu328HuKviya88cL/NOo1KL7TupiTZbsq1+AL+yMNv
         uv3w==
X-Gm-Message-State: ABuFfoiDEQjlvwNmfk6oiWC0SR8v2D4tVZY91Jxoxvu/eftC0/tySs+Q
        jZdoygis6bL49ndt7Pq17Wr+yg==
X-Google-Smtp-Source: ACcGV63ftiq498gnnXbNYrZBucn0eilwH2omh09NC5/WIEVbBQh3+Wixw8+7LP77wautR/nhyWX1Vg==
X-Received: by 2002:a05:6000:10d0:: with SMTP id b16mr838873wrx.226.1537879605494;
        Tue, 25 Sep 2018 05:46:45 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z13sm2276160wrw.19.2018.09.25.05.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:46:44 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 4/4] mailbox: tegra-hsp: use devm_kstrdup_const()
Date:   Tue, 25 Sep 2018 14:46:29 +0200
Message-Id: <20180925124629.20710-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180925124629.20710-1-brgl@bgdev.pl>
References: <20180925124629.20710-1-brgl@bgdev.pl>
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

