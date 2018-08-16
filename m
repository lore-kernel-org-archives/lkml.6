Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F995C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2118321477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+VKeV7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2118321477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387812AbeHPFkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:40:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38133 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeHPFkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:40:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so1330580plq.5;
        Wed, 15 Aug 2018 19:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WB5YLAG5F5y6IWxFhlAGC/WdNvOpGjLb+B1NuNsthz4=;
        b=a+VKeV7NXBEL2KPZTXJNleHRkuESXsYwLTRJ1zp/GULzkMFscHxrl/bKS4fKXAwUE/
         7BVtMA5vjTbfDSKzWJd6PhVTpP734d9BiFCn3eHGEQjInuoEkvQ/bkxpEwkVPt5pzAi6
         nBdNm+3pzK94G+mhDpn2RWZOuWXVe6gGYbTceHJSuN/zW7J3tbcy2ZGbOdDzUYRssLzG
         fIfoGaS6aoE0oFMRgin+7bjjucB9AKvEvYKqiPdmvr4YWkIJqj5oUklVrV0/SgmmcRCa
         vaYdQopz/KGq6P4+zEt0d4BfsuZtUbH/YliSki0ddjEG57A6c2xSd4yxa/4nv4FVjLtm
         u7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WB5YLAG5F5y6IWxFhlAGC/WdNvOpGjLb+B1NuNsthz4=;
        b=IPYkEZO/3g7KcbOUfFPph4QLdWtkv0JwaCqIx5/EMRhBdZehE15IEUYxMB+D9ZXEWV
         K9XVCNtWICDDS654AnfZMdKylljK5pROecM9X2ENxMH4uqk1G3SCEYWCptgIjvo3psfs
         yWEuKqdG/Aof0bYR0ipJDKKXjy9r4b5UCHmlsIcJjGuxMtPsTiHpBsQ9jUY/YSrm7HvS
         z1xzpZVZ6wlfnDk96DkYFvxdd5SYCQJ0+wYCzSPO+w+a0CklydRMva8nzsCy8HqTeHZP
         iU4KuszJkrgRkI2LH2yN6iJHnHz6hSgCqNVHhiW7VYL/pN/nogGtedD1PppGEd+5Kp22
         7ZKQ==
X-Gm-Message-State: AOUpUlG2A14iMfOZLTIIzOg5DqJ0C/2ZzoyXYRAZw8NMo3ujnkoc3zxc
        zLKQM0W9XkU9TcufqI+JOFg=
X-Google-Smtp-Source: AA+uWPylMHLDmF4sO0+whtbua2tnZoWE8dxYwK+rG15okff4g7fRo77hDtXTdQ24QBQ/UtjyL1liFg==
X-Received: by 2002:a17:902:32a4:: with SMTP id z33-v6mr27192975plb.226.1534387508705;
        Wed, 15 Aug 2018 19:45:08 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t15-v6sm37823323pfa.158.2018.08.15.19.45.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 19:45:07 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Subject: [PATCH v2 1/2] hid: microsoft: Convert private data to be a proper struct
Date:   Wed, 15 Aug 2018 19:44:09 -0700
Message-Id: <20180816024410.29218-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180816024410.29218-1-andrew.smirnov@gmail.com>
References: <20180816024410.29218-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to have more than just an unsigned long worth of
private data, convert the code to allocate and use a dedicated struct.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/hid/hid-microsoft.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 96e7d3231d2f..f8868d96c0c7 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -29,10 +29,15 @@
 #define MS_NOGET		0x10
 #define MS_DUPLICATE_USAGES	0x20
 
+struct ms_data {
+	unsigned long quirks;
+};
+
 static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	/*
 	 * Microsoft Wireless Desktop Receiver (Model 1028) has
@@ -134,7 +139,8 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_ERGONOMY) {
 		int ret = ms_ergonomy_kb_quirk(hi, usage, bit, max);
@@ -153,7 +159,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 
 	if (quirks & MS_DUPLICATE_USAGES)
 		clear_bit(usage->code, *bit);
@@ -164,7 +171,8 @@ static int ms_input_mapped(struct hid_device *hdev, struct hid_input *hi,
 static int ms_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
-	unsigned long quirks = (unsigned long)hid_get_drvdata(hdev);
+	struct ms_data *ms = hid_get_drvdata(hdev);
+	unsigned long quirks = ms->quirks;
 	struct input_dev *input;
 
 	if (!(hdev->claimed & HID_CLAIMED_INPUT) || !field->hidinput ||
@@ -222,9 +230,16 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	unsigned long quirks = id->driver_data;
+	struct ms_data *ms;
 	int ret;
 
-	hid_set_drvdata(hdev, (void *)quirks);
+	ms = devm_kzalloc(&hdev->dev, sizeof(*ms), GFP_KERNEL);
+	if (ms == NULL)
+		return -ENOMEM;
+
+	ms->quirks = quirks;
+
+	hid_set_drvdata(hdev, ms);
 
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
-- 
2.17.1

