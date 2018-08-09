Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EE6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8699223A4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C++cK/rt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8699223A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbeHJCGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:06:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38464 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbeHJCGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:06:45 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so3474427pgq.5;
        Thu, 09 Aug 2018 16:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mhr7JwFi8iflendta6bT0wM7DZnPnlvlWV2sR3YuKf4=;
        b=C++cK/rteZHVAky5xDXKW03NWWkB9WG4PBdVVtE1pWeDX35Lyxi3q34itxzxm1a/tX
         fiGMoakbsQc9vCQQLz4yXVl8bmpwil0yuV+pcjRFFwCutuVlGFWimATEk1DEmtD+vZjg
         NnTx23e5/pEuQHoanPUjLy82lzv+A0B2JsJxylukG3msRBINxBIg+Aqlpu3LfGQiyNee
         gHZE589V3rm1rbpRqciNopRrBmFnEg44dnqt56nrGZOka2wqu1FubIByOJeaShetJR3p
         Zp3XEVv2uIk4yLKRSkKNNPPWuYwbXw4Tcxb6Axnmh5ZpsuAK/xxCuvkBpLX34w2j+/BD
         /XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mhr7JwFi8iflendta6bT0wM7DZnPnlvlWV2sR3YuKf4=;
        b=mkjOdH0B0LdZsKQfn1SepnnfPVg87BlfyRC8g25UdqapCiKiH4tddFS4895fK2Y/qj
         Wc7Yi+yeo0m5u6hL0hz7Fny7EG96AArsf99C0uZGoEQVh54cQ04slhfCqCVAlbooPb2J
         wTLvvyiTmniGwPKP9uukJNHjn8e0UpXZbpCJSbhK3fEOWmpz+AHfNKGBFU7KIDq+Eypl
         8sPp5G1j1KJzOZJ6oXtzB9UUpM4ptNdVw87f2gfF+T8bPa6GZ71mygJgzZPulLe4df9K
         ZkxV7uCXmMv76P6zkjWexMWDcp6XlcLm+YblGO7eDSDq22r040CXrUT33chQs9rrGg6k
         rW4Q==
X-Gm-Message-State: AOUpUlHRYAIkV8RVTe8v8hi8jZ8aBPoRDcLZGCMUHscG+5YeR7FVaPcX
        s2CKNcF+C/zZZK4saxsT4AGdzPEl
X-Google-Smtp-Source: AA+uWPx+Oq6Zk/QpPTctn+KhrRXl1FFeXTqPFTPUHt1vpXUZh+nNBbsXplXTeUp9n3FxCS1Wdt2cZw==
X-Received: by 2002:a63:714a:: with SMTP id b10-v6mr3858496pgn.73.1533857975074;
        Thu, 09 Aug 2018 16:39:35 -0700 (PDT)
Received: from hobbes.alyptik.lan (cpe-98-150-136-16.hawaii.res.rr.com. [98.150.136.16])
        by smtp.gmail.com with ESMTPSA id d191-v6sm14275101pfg.172.2018.08.09.16.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 16:39:34 -0700 (PDT)
From:   Joey Pabalinas <joeypabalinas@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Daniel Martin <consume.noise@gmail.com>
Subject: [PATCH RESEND 4/4] HID: multitouch: remove unneeded else conditional cases
Date:   Thu,  9 Aug 2018 13:39:19 -1000
Message-Id:
 <d35643165a1d1972fd91e547922697a3c785a413.1530402641.git.joeypabalinas@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180809233919.bkHn4ajY5xtFVm20dmlFMPl-GgEBX2yYDMj_iiHUKmg@z>

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

