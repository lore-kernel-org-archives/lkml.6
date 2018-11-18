Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51081C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DFC20817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 21:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlyfUeGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DFC20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeKSISl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 03:18:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35272 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeKSISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 03:18:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so12910680pgu.2;
        Sun, 18 Nov 2018 13:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StH4xEnxYKKNsCfKd2a5UrvLuU918LMRNqWIoV8Go7U=;
        b=NlyfUeGCGJUzK9B5W/F6ZiOhwBpmAp8beH7/dG8LRqUqbkqfwWl6pWFbYgUQxPuFhI
         BLaPyg8UvC5NSYdSYW4QTocv9ujeFqKh//1KFQBOUHDCFbwUABBJZGHIjv/RBvvvzMTV
         lk1yLbMB2ODQopUAN/KIwMQhcq30qs9fZjac+Wgjn2Hh3ofpyPP4ByXy0KNaeb0JkcLB
         EO92WvgEFDMSBrlOWmnWQV7OjFoohzuXhUNzbS64/btRXsHBia/WdEldZepB4uasmIqo
         DP65FQOUpxOTmfhk3FCJ8EAzNtSLTQFHkH36+f2pdj9O+bkJS9BeABHQculPNv0wbJd/
         K//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StH4xEnxYKKNsCfKd2a5UrvLuU918LMRNqWIoV8Go7U=;
        b=VK4wITBoN3RhggbfphZr2iYS8N5Abl61eu6MD3j8swRKlyVEBxNlY5f1o4G+bYs1sr
         XyTNQnrpZUUZBZvGe8zwMJdPzdEXXI9ZGCGeHDImNMyuPxHF6U6zTv34U271MaYe52SB
         KvNgUm9NEMMSkn100qCtbnGK5WFj+o7yiNFDTvoYVMInYn0/o0GA5jlBYo2vNth0/nlq
         wsnyqo4SuuUmEpN2SmICHaTs+BCYSksW72BY+BT4a+99EeR0J1jN1tXOCRc+6I1j2cph
         S1lsBRWFzR86vDj8d3+xC2+hxlKK1H8apiul71ViJjFIgSxU7GC0mPW7PVTWomzmOgTN
         ugwg==
X-Gm-Message-State: AGRZ1gKCLL0EXlQXriFksfkMiQOo+70MGSMxJJdIEpNEEQBYr5ISFUyV
        iaARSPl74reMGtv5JY9w1eQ=
X-Google-Smtp-Source: AJdET5d1CPRHBjdrhJPTqyhnkBBhCcJyEykYotQ2duQarZjuw9t/EkEoD0wC8TXIECgxN1H6hpgFgQ==
X-Received: by 2002:aa7:814f:: with SMTP id d15-v6mr20616001pfn.78.1542578231260;
        Sun, 18 Nov 2018 13:57:11 -0800 (PST)
Received: from localhost.localdomain (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.gmail.com with ESMTPSA id j64-v6sm9733422pfc.43.2018.11.18.13.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Nov 2018 13:57:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] regulator: core: Keep regulators-list locked while traversing the list
Date:   Mon, 19 Nov 2018 00:56:19 +0300
Message-Id: <20181118215619.21518-5-digetx@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181118215619.21518-1-digetx@gmail.com>
References: <20181118215619.21518-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unlikely that regulators may disappear/appear while regulators
debug-summary is being prepared, but let's be consistent and avoid that
situation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a3ab419a3aa6..7bb5bc16babf 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4971,7 +4971,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 			regulator_disable(rdev->supply);
 		regulator_put(rdev->supply);
 	}
+
 	mutex_lock(&regulator_list_mutex);
+
 	debugfs_remove_recursive(rdev->debugfs);
 	flush_work(&rdev->disable_work.work);
 	WARN_ON(rdev->open_count);
@@ -4979,8 +4981,9 @@ void regulator_unregister(struct regulator_dev *rdev)
 	unset_regulator_supplies(rdev);
 	list_del(&rdev->list);
 	regulator_ena_gpio_free(rdev);
-	mutex_unlock(&regulator_list_mutex);
 	device_unregister(&rdev->dev);
+
+	mutex_unlock(&regulator_list_mutex);
 }
 EXPORT_SYMBOL_GPL(regulator_unregister);
 
@@ -5313,6 +5316,8 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 	struct regulator_dev *old_contended_rdev = NULL;
 	int err;
 
+	mutex_lock(&regulator_list_mutex);
+
 	ww_acquire_init(ww_ctx, &regulator_ww_class);
 
 	do {
@@ -5339,6 +5344,8 @@ static void regulator_summary_unlock(struct ww_acquire_ctx *ww_ctx)
 	class_for_each_device(&regulator_class, NULL, NULL,
 			      regulator_summary_unlock_one);
 	ww_acquire_fini(ww_ctx);
+
+	mutex_unlock(&regulator_list_mutex);
 }
 
 static int regulator_summary_show_roots(struct device *dev, void *data)
-- 
2.19.1

