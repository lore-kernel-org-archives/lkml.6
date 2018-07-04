Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB48DC6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C072098B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hVU38Wvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C072098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeGDPIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:08:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36634 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752969AbeGDPIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:08:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so6271241wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AXwnCu8ouDrM6QovqAjhcReG2tzwqPmVUwyqM1UCJGQ=;
        b=hVU38Wvxr1QwIco6YEVpWlFjVnl2ssnavLCsNZVS0HC83bT4KLYJr6zdRfy08jVQeS
         4/FrBoyjyJhNNtrGwpym3szQ7xCE9QtTlw04NnkAyZdwh/QLDE4ADRn9OL+TlvZSbcDh
         MhvJaDW0UbQZDCLlE7eOD5EVCU2bbJWSgYpW03CdxTT2CVVfS8nY/c2Lr0IIXBasmrXr
         AuEoy3FwmkawOWmiHGe9lJ4jDwNLntaQCxHVUTXfbQdMdzqaTd97KqniVntFJj6yDGwZ
         HKHMyLQWrDIZu6YNyV5AGoBsGBKFMqUhgCyHZKTL1327m2gLHQ2Q30qxia1WTXweegpP
         4ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AXwnCu8ouDrM6QovqAjhcReG2tzwqPmVUwyqM1UCJGQ=;
        b=Rl5lIKrsGS+mw0UZpTTWGBF1LlgW1Z5OZxxUroEF4+Wkjpt48E0FDAmb0UNNnB10X3
         xfyV192qmzWeoc0LGI1woKFMnKbhkclt13K/gKcTg0DhirqVzV3D6in8jrfghTWRPnIg
         Eqy0QWyBePtUJQDBbq5K5x6b6j3YD0w08vdKAMkKk83bvNo8miRAdn/QGY9uFMTMhwTh
         tjplmJDO/D57XcooDkY+HwUfn3W5mHfwt4Bs2TXPugcxvA6SK3nyV0q3yRpoGxear8Wu
         ZRiSRQrfbt7v5uhBbk3aLLUjs7W/EyjvQG6cLDWd5Zuz1zAp+ufOEfqCQx+aurK6Qs+V
         f4Qg==
X-Gm-Message-State: APt69E3lTrDRCWzm7TYwFXWQZ9et0rpz1QZdYpnIP1xAqpjllDzv1QIH
        6Dc8AoDhZLGOFXJSxNg7WWq/3g==
X-Google-Smtp-Source: AAOMgpcUYMlMRAM1vTRtYIzEIk/W/8scZCGQ+QbVNXfbrgull62n+q3vXPv1qZ8TSzg4BuyXuH6TMQ==
X-Received: by 2002:a1c:90c2:: with SMTP id s185-v6mr1917497wmd.5.1530716909702;
        Wed, 04 Jul 2018 08:08:29 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l7-v6sm9607737wmh.1.2018.07.04.08.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 08:08:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     airlied@linux.ie, hans.verkuil@cisco.com, lee.jones@linaro.org,
        olof@lixom.net, seanpaul@google.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, sadolfsson@google.com,
        felixe@google.com, bleung@google.com, darekm@google.com,
        marcheu@chromium.org, fparent@baylibre.com,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        eballetbo@gmail.com
Subject: [PATCH v8 4/6] mfd: cros-ec: Introduce CEC commands and events definitions.
Date:   Wed,  4 Jul 2018 17:08:19 +0200
Message-Id: <1530716901-30164-5-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
References: <1530716901-30164-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC can expose a CEC bus, this patch adds the CEC related definitions
needed by the cros-ec-cec driver.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Hans Verkuil <hans.verkuil@cisco.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/cros_ec_commands.h | 81 ++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index c4f0caa..584e04e 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -804,6 +804,8 @@ enum ec_feature_code {
 	EC_FEATURE_MOTION_SENSE_FIFO = 24,
 	/* EC has RTC feature that can be controlled by host commands */
 	EC_FEATURE_RTC = 27,
+	/* EC supports CEC commands */
+	EC_FEATURE_CEC = 35,
 };
 
 #define EC_FEATURE_MASK_0(event_code) (1UL << (event_code % 32))
@@ -2078,6 +2080,12 @@ enum ec_mkbp_event {
 	/* EC sent a sysrq command */
 	EC_MKBP_EVENT_SYSRQ = 6,
 
+	/* Notify the AP that something happened on CEC */
+	EC_MKBP_EVENT_CEC_EVENT = 8,
+
+	/* Send an incoming CEC message to the AP */
+	EC_MKBP_EVENT_CEC_MESSAGE = 9,
+
 	/* Number of MKBP events */
 	EC_MKBP_EVENT_COUNT,
 };
@@ -2847,6 +2855,79 @@ struct ec_params_reboot_ec {
 
 /*****************************************************************************/
 /*
+ * HDMI CEC commands
+ *
+ * These commands are for sending and receiving message via HDMI CEC
+ */
+#define EC_MAX_CEC_MSG_LEN 16
+
+/* CEC message from the AP to be written on the CEC bus */
+#define EC_CMD_CEC_WRITE_MSG 0x00B8
+
+/**
+ * struct ec_params_cec_write - Message to write to the CEC bus
+ * @msg: message content to write to the CEC bus
+ */
+struct ec_params_cec_write {
+	uint8_t msg[EC_MAX_CEC_MSG_LEN];
+} __packed;
+
+/* Set various CEC parameters */
+#define EC_CMD_CEC_SET 0x00BA
+
+/**
+ * struct ec_params_cec_set - CEC parameters set
+ * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ * @val: in case cmd is CEC_CMD_ENABLE, this field can be 0 to disable CEC
+ *	or 1 to enable CEC functionality, in case cmd is CEC_CMD_LOGICAL_ADDRESS,
+ *	this field encodes the requested logical address between 0 and 15
+ *	or 0xff to unregister
+ */
+struct ec_params_cec_set {
+	uint8_t cmd; /* enum cec_command */
+	uint8_t val;
+} __packed;
+
+/* Read various CEC parameters */
+#define EC_CMD_CEC_GET 0x00BB
+
+/**
+ * struct ec_params_cec_get - CEC parameters get
+ * @cmd: parameter type, can be CEC_CMD_ENABLE or CEC_CMD_LOGICAL_ADDRESS
+ */
+struct ec_params_cec_get {
+	uint8_t cmd; /* enum cec_command */
+} __packed;
+
+/**
+ * struct ec_response_cec_get - CEC parameters get response
+ * @val: in case cmd was CEC_CMD_ENABLE, this field will 0 if CEC is
+ *	disabled or 1 if CEC functionality is enabled,
+ *	in case cmd was CEC_CMD_LOGICAL_ADDRESS, this will encode the
+ *	configured logical address between 0 and 15 or 0xff if unregistered
+ */
+struct ec_response_cec_get {
+	uint8_t val;
+} __packed;
+
+/* CEC parameters command */
+enum ec_cec_command {
+	/* CEC reading, writing and events enable */
+	CEC_CMD_ENABLE,
+	/* CEC logical address  */
+	CEC_CMD_LOGICAL_ADDRESS,
+};
+
+/* Events from CEC to AP */
+enum mkbp_cec_event {
+	/* Outgoing message was acknowledged by a follower */
+	EC_MKBP_CEC_SEND_OK			= BIT(0),
+	/* Outgoing message was not acknowledged */
+	EC_MKBP_CEC_SEND_FAILED			= BIT(1),
+};
+
+/*****************************************************************************/
+/*
  * Special commands
  *
  * These do not follow the normal rules for commands.  See each command for
-- 
2.7.4

