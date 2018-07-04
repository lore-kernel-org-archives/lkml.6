Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC25EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E1A2098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UI1q92r2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E1A2098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeGDPJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:09:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36630 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752960AbeGDPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:08:29 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so6271093wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vflu0p5Tb+mMM8w4aaKWVP4Avwpv/DVSALsVho9Xd+s=;
        b=UI1q92r2eJLHzBHBUOWIUw29pKK+3XBLI1jk6Y/Co/vx8vkOAJ+C4G/ikiSQO7rmHo
         rXCgVS5htYVqsU8sjezZdE2FbVChl6cFyHZSZs5rXjNnf3DSrVtE0/0BhTRpSTWYOamu
         ICBk4OStJUx0H3YnfCK2xz6Ypy1FopziKPuZU7bS2EWrWe7EY6HHfMOX+POv1R/jGJ6b
         9vhmx2EPKI+FqSocTliPds+j7GX3ZJsBrRCVSzdSuqUQYwZkk2D6qFPeoEj8zsYAkw6R
         TuIFu5QT3bH/xajlR5GEKsmmhEaJMleNU0HbcQVBNTBsDJsc8kZHbiDjKt6mBreZ1ym5
         Hx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vflu0p5Tb+mMM8w4aaKWVP4Avwpv/DVSALsVho9Xd+s=;
        b=uBG4YC919fad7aFUAs9YbzJeWvvE5UYW2xItrQcBiBwx9JVIlQHCMhB7hdJu8J9HS7
         J57riBgU4Jf8z/plq6v2iJlw1dNADyZNBuDwiK8SrNqwe/0n1CVu8nL8JB2LsDG1elwB
         WLPkToDdG4yqvrSgPzjhuY25y/KtYoviRrhCEMWGDvCp+TrbULAOTm/vpgh8kKJA8iLJ
         pck1RApJT0Wo/LqrFBQ1qFYu7vxD/juBgwvT+RA62dukYBTacuJLPY8G8vVbNTC6tBgE
         U/VUWZke8e+PDfywhPba67a1fDSz+tyUxKXJTl40VA7J+o6mz4ddmQaiDntyLOacz1vZ
         xJQQ==
X-Gm-Message-State: APt69E2VqeVb6qQfGTMNJsrQJMgpYWEfXbqCvoQGLgcch9Qri69qKb6s
        yGs/fbqZw54OJ59/1F57mCp8Zg==
X-Google-Smtp-Source: AAOMgpegQQrnzbUQuDL2gtGavT5OF/EqXRy2N/7x7QF5DXglnD++UZSJK9dejdPB0hDRODvqU7u8sg==
X-Received: by 2002:adf:ba01:: with SMTP id o1-v6mr1973319wrg.249.1530716908252;
        Wed, 04 Jul 2018 08:08:28 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l7-v6sm9607737wmh.1.2018.07.04.08.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 08:08:27 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com, Stefan Adolfsson <sadolfsson@chromium.org>
Subject: [PATCH v8 3/6] mfd: cros-ec: Increase maximum mkbp event size
Date:   Wed,  4 Jul 2018 17:08:18 +0200
Message-Id: <1530716901-30164-4-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having a 16 byte mkbp event size makes it possible to send CEC
messages from the EC to the AP directly inside the mkbp event
instead of first doing a notification and then a read.

Signed-off-by: Stefan Adolfsson <sadolfsson@chromium.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
---
 drivers/platform/chrome/cros_ec_proto.c | 40 +++++++++++++++++++++++++--------
 include/linux/mfd/cros_ec.h             |  2 +-
 include/linux/mfd/cros_ec_commands.h    | 16 +++++++++++++
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 8350ca2..398393a 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -506,10 +506,31 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
 
+static int get_next_event_xfer(struct cros_ec_device *ec_dev,
+			       struct cros_ec_command *msg,
+			       int version, uint32_t size)
+{
+	int ret;
+
+	msg->version = version;
+	msg->command = EC_CMD_GET_NEXT_EVENT;
+	msg->insize = size;
+	msg->outsize = 0;
+
+	ret = cros_ec_cmd_xfer(ec_dev, msg);
+	if (ret > 0) {
+		ec_dev->event_size = ret - 1;
+		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
+	}
+
+	return ret;
+}
+
 static int get_next_event(struct cros_ec_device *ec_dev)
 {
 	u8 buffer[sizeof(struct cros_ec_command) + sizeof(ec_dev->event_data)];
 	struct cros_ec_command *msg = (struct cros_ec_command *)&buffer;
+	static int cmd_version = 1;
 	int ret;
 
 	if (ec_dev->suspended) {
@@ -517,18 +538,19 @@ static int get_next_event(struct cros_ec_device *ec_dev)
 		return -EHOSTDOWN;
 	}
 
-	msg->version = 0;
-	msg->command = EC_CMD_GET_NEXT_EVENT;
-	msg->insize = sizeof(ec_dev->event_data);
-	msg->outsize = 0;
+	if (cmd_version == 1) {
+		ret = get_next_event_xfer(ec_dev, msg, cmd_version,
+				sizeof(struct ec_response_get_next_event_v1));
+		if (ret < 0 || msg->result != EC_RES_INVALID_VERSION)
+			return ret;
 
-	ret = cros_ec_cmd_xfer(ec_dev, msg);
-	if (ret > 0) {
-		ec_dev->event_size = ret - 1;
-		memcpy(&ec_dev->event_data, msg->data,
-		       sizeof(ec_dev->event_data));
+		/* Fallback to version 0 for future send attempts */
+		cmd_version = 0;
 	}
 
+	ret = get_next_event_xfer(ec_dev, msg, cmd_version,
+				  sizeof(struct ec_response_get_next_event));
+
 	return ret;
 }
 
diff --git a/include/linux/mfd/cros_ec.h b/include/linux/mfd/cros_ec.h
index 32421df..20949dd 100644
--- a/include/linux/mfd/cros_ec.h
+++ b/include/linux/mfd/cros_ec.h
@@ -147,7 +147,7 @@ struct cros_ec_device {
 	bool mkbp_event_supported;
 	struct blocking_notifier_head event_notifier;
 
-	struct ec_response_get_next_event event_data;
+	struct ec_response_get_next_event_v1 event_data;
 	int event_size;
 	u32 host_event_wake_mask;
 };
diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index f2edd99..c4f0caa 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2093,12 +2093,28 @@ union ec_response_get_next_data {
 	uint32_t   sysrq;
 } __packed;
 
+union ec_response_get_next_data_v1 {
+	uint8_t key_matrix[16];
+	uint32_t host_event;
+	uint32_t buttons;
+	uint32_t switches;
+	uint32_t sysrq;
+	uint32_t cec_events;
+	uint8_t cec_message[16];
+} __packed;
+
 struct ec_response_get_next_event {
 	uint8_t event_type;
 	/* Followed by event data if any */
 	union ec_response_get_next_data data;
 } __packed;
 
+struct ec_response_get_next_event_v1 {
+	uint8_t event_type;
+	/* Followed by event data if any */
+	union ec_response_get_next_data_v1 data;
+} __packed;
+
 /* Bit indices for buttons and switches.*/
 /* Buttons */
 #define EC_MKBP_POWER_BUTTON	0
-- 
2.7.4

