Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBD6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA5420811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 11:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB5SnXAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA5420811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeLKLSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 06:18:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46200 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKLSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 06:18:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so6480132pgp.13;
        Tue, 11 Dec 2018 03:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zXHPsANlFIWCyShc+cbKZupPu+a3kQieoGyv9HMfwyY=;
        b=IB5SnXASfkprezXcqmZbHyH033HYVKrgFQ6ewJ7W9zEr/sa/JH90S3vihMV4Uj/7h+
         kWMgxbrzAycSt8L2q9r0Y1Jq/xMdVq92TYEXyyz13M6u0H8goCcgU+XITDhh8XINiz+Z
         sIP3jJT8KXr4qWb6e40KvxsKbM5eT9Gmc3hf8jLRbO8zJH0da2MCGq5FQ96iYaHQ1vUz
         /MJvRT5spsEkV8swTTNpYRmBMgSiCAm98J3ktWV08LfI2y0UCX4uITSAWEOyKCJCtqj1
         A2Nt+RVQYYvEmI2LmqH75Whmg0Jot8Uc4G/z4OsvL+v9BfUFaFk9GOsQ95FfTgpRdgxv
         zwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zXHPsANlFIWCyShc+cbKZupPu+a3kQieoGyv9HMfwyY=;
        b=ayFNt8HWcYofX5ApW3AORqnJaidBW5K3d5k8UyHDAH16dJPqIUqnXSjht2ZZb0Jyr5
         qdtYvKQ/3cDCAlbL5O5ox/77oAmOsjiXa+AGpvEtAEVsnF4fWWSULVTy8/picb9NC6oB
         9rry8PCwnokPl2b5IaMgzTF1f7GK/7vQ5SIJEfHUl/qK9/tiuXhQ/f2zLNQB75bYCG0h
         RHSbdy6qjzq7o6FJ6/oQodeMjNrOfpfbyiSgO0v34F9jU91WPU312yeNBeDUtw1bsN/F
         7klAji6aZBHuWe36Xj32l6ky/BDQqPlo/OsqU7oRFRyKKuLOlTGAj2zFJvNESWzGe1y0
         +qew==
X-Gm-Message-State: AA+aEWbeoSIp3VvBiZ2DtdepCAOA7aibps7T6v17IAZ5QfblXRO8FPfz
        lDG9ArcnaxyQKr2iY832shNlAPm9
X-Google-Smtp-Source: AFSGD/V5MiLPQSUFC3JyYviKS+swDa43UNzVpq3XY3ZUhFk+U5jd5Hrwyiie4hangNPRP5wNFrWNeA==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr13960841pgk.102.1544527101638;
        Tue, 11 Dec 2018 03:18:21 -0800 (PST)
Received: from localhost.localdomain ([106.51.67.149])
        by smtp.googlemail.com with ESMTPSA id z9sm31417757pfd.99.2018.12.11.03.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 03:18:21 -0800 (PST)
From:   Hardik Singh Rathore <hardiksingh.k@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        joe@perches.com, Hardik Singh Rathore <hardiksingh.k@gmail.com>
Subject: [PATCH v2] Input: touchscreen: Fix ERROR: foo* bar should be "foo *bar"
Date:   Tue, 11 Dec 2018 16:47:40 +0530
Message-Id: <20181211111740.25643-1-hardiksingh.k@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210154433.28319-1-hardiksingh.k@gmail.com>
References: <20181210154433.28319-1-hardiksingh.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the coding style problem reported by checkpatch.pl.

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
v2:
- fix the pointer location style problem in drivers/input/touchscreen/*
files leftover in previous patch.

 drivers/input/touchscreen/ektf2127.c | 2 +-
 drivers/input/touchscreen/gunze.c    | 4 ++--
 drivers/input/touchscreen/inexio.c   | 4 ++--
 drivers/input/touchscreen/mtouch.c   | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
index 0ed34ff787ce..28fa1b36f7a5 100644
--- a/drivers/input/touchscreen/ektf2127.c
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -51,7 +51,7 @@ struct ektf2127_ts {
 	struct touchscreen_properties prop;
 };
 
-static void ektf2127_parse_coordinates(const u8* buf, unsigned int touch_count,
+static void ektf2127_parse_coordinates(const u8 *buf, unsigned int touch_count,
 				       struct input_mt_pos *touches)
 {
 	int index = 0;
diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 054c2537b392..56cf1a1ea3ea 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -53,7 +53,7 @@ struct gunze {
 	char phys[32];
 };
 
-static void gunze_process_packet(struct gunze* gunze)
+static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
 
@@ -72,7 +72,7 @@ static void gunze_process_packet(struct gunze* gunze)
 static irqreturn_t gunze_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-	struct gunze* gunze = serio_get_drvdata(serio);
+	struct gunze *gunze = serio_get_drvdata(serio);
 
 	if (data == '\r') {
 		gunze_process_packet(gunze);
diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
index b9bc56233ccc..13bd0bf580a7 100644
--- a/drivers/input/touchscreen/inexio.c
+++ b/drivers/input/touchscreen/inexio.c
@@ -79,7 +79,7 @@ static void inexio_process_data(struct inexio *pinexio)
 static irqreturn_t inexio_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-	struct inexio* pinexio = serio_get_drvdata(serio);
+	struct inexio *pinexio = serio_get_drvdata(serio);
 
 	pinexio->data[pinexio->idx] = data;
 
@@ -97,7 +97,7 @@ static irqreturn_t inexio_interrupt(struct serio *serio,
 
 static void inexio_disconnect(struct serio *serio)
 {
-	struct inexio* pinexio = serio_get_drvdata(serio);
+	struct inexio *pinexio = serio_get_drvdata(serio);
 
 	input_get_device(pinexio->dev);
 	input_unregister_device(pinexio->dev);
diff --git a/drivers/input/touchscreen/mtouch.c b/drivers/input/touchscreen/mtouch.c
index a3707fad4d1c..8278a9058640 100644
--- a/drivers/input/touchscreen/mtouch.c
+++ b/drivers/input/touchscreen/mtouch.c
@@ -90,7 +90,7 @@ static void mtouch_process_response(struct mtouch *mtouch)
 static irqreturn_t mtouch_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags)
 {
-	struct mtouch* mtouch = serio_get_drvdata(serio);
+	struct mtouch *mtouch = serio_get_drvdata(serio);
 
 	mtouch->data[mtouch->idx] = data;
 
@@ -110,7 +110,7 @@ static irqreturn_t mtouch_interrupt(struct serio *serio,
 
 static void mtouch_disconnect(struct serio *serio)
 {
-	struct mtouch* mtouch = serio_get_drvdata(serio);
+	struct mtouch *mtouch = serio_get_drvdata(serio);
 
 	input_get_device(mtouch->dev);
 	input_unregister_device(mtouch->dev);
-- 
2.17.1

