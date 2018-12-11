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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1185CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C817F20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcR3bDbE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C817F20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLKNDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:03:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33212 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeLKNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:03:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so6916626plo.0;
        Tue, 11 Dec 2018 05:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ldnC2bXQhUcjYcil88jUSx4w10/5+BAqB5GMgpL+qtE=;
        b=jcR3bDbEqS8OeuRcGIjK08oKO9tLwTAtR53sFwc8nabvTu6KaERHnQa2j8QSFN9KwO
         OFXsR3sFmPTY4BobOUjBFOAg92x7BSbu/Ue/iYKOx7pyysfi0ztjGWsfT8Oh/f0Q8kBk
         XJ/1lxWY4IiNuL1EPPJN2RbwAe1SYbhozNg6cw6b0PNA2W8OFjyYoYzi6Q96xEgRQFMX
         RwIMG9iai5pY8h/ooci0+EZgJdOfTjVfSvOb6S2Mmk+TDdO8jJQYt93N2lyWaDL7fRRH
         1aWqlEMl1pKkLOS0BfmF/18V15A5+2p77tAlvkxKqTRClAtQhlSrX+GXMkaHYUMIlx4l
         2cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ldnC2bXQhUcjYcil88jUSx4w10/5+BAqB5GMgpL+qtE=;
        b=U+f8QsrHJNvTlpjOeWenUTYq8W1XU/PQQ3aDuxQgTui2cj/W4JnRnt0g6uzyeBSvMy
         gq2iO1lbR5wp1J/UjNgw1D+mHUlYzWbLQnyFEOrkBbtV6xqYkSE2T1kIowQeJgw/nAXs
         t8t/2vUvXSKToSoDuQGn1tVaZ+nR7ET9JIh73V9Jovpmf4uZwkLK6+AlPsY1QK2ZGV8m
         qB+NrgJgqbgSOmkOKsFoDG6AUUXUQvfuL3kdmlwd6AUuSuoky8ouTCImDV9cmZGiYSHa
         /m8HJfMF97oHV1k3gHC/B636gBaqLhM25Hyv/KxiRIeT1vVrFkmppkorTL4yJtY+7oMH
         h+BA==
X-Gm-Message-State: AA+aEWZlhGvxz3+fiv3Sm5SRXUu65P4KoAVjRQv42xWdqRbLjkqBqBNr
        RCZyk475e8LQqMohpsoktArEFDAZ
X-Google-Smtp-Source: AFSGD/XGgCaGWA+RnlC+ff5KcHYdUgpYU9D2Y8ud3e4arp99DMlQFg9W5ugd1xAhnTfnCSsbgpQUaw==
X-Received: by 2002:a17:902:8687:: with SMTP id g7mr15859456plo.96.1544533432535;
        Tue, 11 Dec 2018 05:03:52 -0800 (PST)
Received: from localhost.localdomain ([106.51.67.149])
        by smtp.googlemail.com with ESMTPSA id 196sm52315895pfc.77.2018.12.11.05.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 05:03:50 -0800 (PST)
From:   Hardik Singh Rathore <hardiksingh.k@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     michael.hennerich@analog.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>
Subject: [PATCH v3] Input: touchscreen: Fix coding style issue
Date:   Tue, 11 Dec 2018 18:33:32 +0530
Message-Id: <20181211130332.27781-1-hardiksingh.k@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211111740.25643-1-hardiksingh.k@gmail.com>
References: <20181211111740.25643-1-hardiksingh.k@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the coding style problem reported
by checkpatch.pl as below:

ERROR: foo* bar should be "foo *bar"

Signed-off-by: Hardik Singh Rathore <hardiksingh.k@gmail.com>
---
v3:
- v2 was depends on v1 so it didn't solve the issue.

 drivers/input/touchscreen/ad7879.c   | 2 +-
 drivers/input/touchscreen/ektf2127.c | 2 +-
 drivers/input/touchscreen/gunze.c    | 4 ++--
 drivers/input/touchscreen/inexio.c   | 4 ++--
 drivers/input/touchscreen/mtouch.c   | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 6bad23ee47a1..b68902c17f2e 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -290,7 +290,7 @@ static int ad7879_open(struct input_dev *input)
 	return 0;
 }
 
-static void ad7879_close(struct input_dev* input)
+static void ad7879_close(struct input_dev *input)
 {
 	struct ad7879 *ts = input_get_drvdata(input);
 
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

