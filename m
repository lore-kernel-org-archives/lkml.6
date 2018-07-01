Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35976C6778F
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA4B22545C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzFFXAQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4B22545C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeGAAUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 20:20:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42410 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeGAAUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 20:20:03 -0400
Received: by mail-pf0-f196.google.com with SMTP id v9-v6so4713862pff.9;
        Sat, 30 Jun 2018 17:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mhr7JwFi8iflendta6bT0wM7DZnPnlvlWV2sR3YuKf4=;
        b=KzFFXAQ2R6A7xjAorleokBxIXUW6phi7ewLB3GOp6ByRGqtGBMHhwsWQ6BVY8dKuX5
         OwZKPb78pStWOHoGgpmR/jMt2GslXTNZkvlaBxqXr57p22mAIX9rsvgs+2giajOIE4Lz
         YGDjYBcwriYrMMG3QPIef9/52bH3nMt1cgYWYVMbjFh/Ey9K4hJdYuvBZrTDQ6LMZppH
         C15F6wA5irX71p7nGUKjCggTvKRxxlApiD5j1YzkXKQxMUX8Wriupl8lpRCVAGrhakTn
         T1knjWseYKmQ7exdvAfGSQFxD4Hz7uqK50cWUU9dpQvtmbdmxoj31NP77nu1QelOZpm8
         DmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mhr7JwFi8iflendta6bT0wM7DZnPnlvlWV2sR3YuKf4=;
        b=XKzMkY5GjIleG+705LuIeI8+yeHieBjhmaXt64Wvukc/kkHblg7CPvmAjdnpDnh4WU
         PGwxDZmiq8ZdaHee8rrn+/R3lyvQWP7JoJ2MKDm1Vlw2wlwtd3CVhF35w244X3OuQZJ0
         wyv67cb8bq2yB+a6VMC3qm8fbgFEc6T0M9b1WjQWeno/3AmxQPLs6XbZ4mNFHj7oZLWm
         Oib9K6/xGzEKDv/RaoXy4FUSQHm35wuKsZNLUVvJsajHOUB7nDeaRWz2XhGZj5U0TEq/
         T+kL7SLosB3jIYyuFtJYXfaZddEGLWXUoXl2AlQqIdrMm9GqASVGwCQ8PVrS7CZR86qP
         yLAw==
X-Gm-Message-State: APt69E0/lmZmDGy2RApfCTXsZPfre0fW0tsK81MWHZQGnTsBktbSOPnN
        JaqFARR/S7sT2xVoi+lFHUBN6A==
X-Google-Smtp-Source: AAOMgpdZAGo8j9aYckcfptoZWBbl8aWYK/s7zHGpYrp4d+zxphnQRWqbYCgKqheYR9+WpkW7z9YfiA==
X-Received: by 2002:a62:8917:: with SMTP id v23-v6mr20166699pfd.127.1530404402133;
        Sat, 30 Jun 2018 17:20:02 -0700 (PDT)
Received: from hobbes.alyptik.lan ([2605:e000:1117:c002:2e0:1bff:fe70:ea])
        by smtp.gmail.com with ESMTPSA id b123-v6sm8424566pfb.156.2018.06.30.17.20.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 17:20:01 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH 4/4] HID: multitouch: remove unneeded else conditional cases
Date:   Sat, 30 Jun 2018 14:19:53 -1000
Message-Id: <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Elide lone `else` cases and replace `else if` clauses
with plain `if` conditionals when they occur immediately
after return statements.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 08b50e5908cecdda66..30b1a2c67f39a41325 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -205,12 +205,12 @@ static void mt_post_parse(struct mt_device *td);
 
 static int cypress_compute_slot(struct mt_device *td)
 {
 	if (td->curdata.contactid != 0 || td->num_received == 0)
 		return td->curdata.contactid;
-	else
-		return -1;
+
+	return -1;
 }
 
 static struct mt_class mt_classes[] = {
 	{ .name = MT_CLS_DEFAULT,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
@@ -803,12 +803,12 @@ static int mt_compute_timestamp(struct mt_device *td, struct hid_field *field,
 	delta *= 100;
 
 	if (jdelta > MAX_TIMESTAMP_INTERVAL)
 		/* No data received for a while, resync the timestamp. */
 		return 0;
-	else
-		return td->timestamp + delta;
+
+	return td->timestamp + delta;
 }
 
 static int mt_touch_event(struct hid_device *hid, struct hid_field *field,
 				struct hid_usage *usage, __s32 value)
 {
@@ -1110,11 +1110,12 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	 * HID_DG_CONTACTCOUNT from the pen report as it is outside the physical
 	 * collection, but within the report ID.
 	 */
 	if (field->physical == HID_DG_STYLUS)
 		return 0;
-	else if ((field->physical == 0) &&
+
+	if ((field->physical == 0) &&
 		 (field->report->id != td->mt_report_id) &&
 		 (td->mt_report_id != -1))
 		return 0;
 
 	if (field->application == HID_DG_TOUCHSCREEN ||
-- 
2.18.0

