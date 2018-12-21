Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CF2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FC621927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NxSrbpi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbeLUQXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:23:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33969 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeLUQXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:23:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so5878111wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MtxMedezO/SO2ydy0vk2j3ybDj6JbE4oP2cGnPpI5Zc=;
        b=NxSrbpi5kRDPhyF7PbDz8tJGxTG6zf2v5rGgTjceDWTKm5Vo0mKm566wdJje9kq/U9
         9dMdkZZ5A+wxfYw6VpjqWI5EZYteQhK6JVuFMPmJE9Eu/iX6Y/P8HlJlimnZCoOohn9V
         wk7dYJQ5UGdPoTEE9nIbrcRoC4czmtRw3l/11Bh2rnXzZR/NORzqGPLjci06fMu6wMy8
         MozeVxr0k7UXOzc6gZRcW0oLgBrinB3cNLW4WRz4xTHJqtEkbcBFgSkoNl2ntkOrFxkc
         Bpcc/501nlL99fmrq12aVRlPeXD2FemsdvuUfddYVO0jcFqVpaiw8qAjNQWgG40nY+J2
         a0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MtxMedezO/SO2ydy0vk2j3ybDj6JbE4oP2cGnPpI5Zc=;
        b=dXr3BoORzYiyt122S8cp41DHicPAStmPHbG1EQyzzVmcdaCbfovhvfGtDX/ZnTxWaa
         A78OBjOuRwvFo8hLEe9zXP5InpZ33z1bV+/XSVUIuoioMvyCYo9VCiJGnVJbhzfklqRx
         Djxu/xFcw4X97cjVOlygCGe4Lr6AoOKPLz9rFLb6Tymf0LLH5GCqatuFALmVqSc2Hh5A
         nGDXRyHW2BP+XLsfoevwijWhEI8TQGZrEl/jDp8T2v2niSf+xxKHV3UraHGPzhQt0ugQ
         H4J77PpmFHC+IdG5l7mu/taStFXqRjCINx8X2g3qtm8KXijzr6WtvJyuRkHYlw3elz9H
         R4ow==
X-Gm-Message-State: AJcUukdrAsl5MzJmfHIliyKbLwmNJpAxOdgVDAcsA5b/MFJRligD/Yl/
        +uvTAgoP8BayeNXOEP7N/QUSJg==
X-Google-Smtp-Source: ALg8bN4D9IA7ldCkcaDihBOGVxrYU3X/w2FnadUPOHt6tYF3r84YQpvEpNYy0RSYQ80qT5GTzJtx1w==
X-Received: by 2002:a5d:6988:: with SMTP id g8mr3162627wru.33.1545409427230;
        Fri, 21 Dec 2018 08:23:47 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b13sm15712373wrn.28.2018.12.21.08.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 08:23:46 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: [PATCH] driver core: silence device link messages unless debugging
Date:   Fri, 21 Dec 2018 17:23:41 +0100
Message-Id: <20181221162341.9847-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On platforms making a fair use of regulators, the dev_info() messages
coming from the device link function are a bit too verbose. The amount
of message will increase further with the clock framework joining the
device link party.

These messages looks valuable for people debugging device link related
issues, so dev_dbg() looks more appropriate than dev_info().

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/base/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd779e11..8d330f921ad7 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -301,7 +301,7 @@ struct device_link *device_link_add(struct device *consumer,
 	list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
 	list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
 
-	dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
+	dev_dbg(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
 
  out:
 	device_pm_unlock();
@@ -327,8 +327,8 @@ static void __device_link_del(struct kref *kref)
 {
 	struct device_link *link = container_of(kref, struct device_link, kref);
 
-	dev_info(link->consumer, "Dropping the link to %s\n",
-		 dev_name(link->supplier));
+	dev_dbg(link->consumer, "Dropping the link to %s\n",
+		dev_name(link->supplier));
 
 	if (link->flags & DL_FLAG_PM_RUNTIME)
 		pm_runtime_drop_link(link->consumer);
-- 
2.19.2

