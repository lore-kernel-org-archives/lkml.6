Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9E2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC77214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 09:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ccWKYLtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLRJGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 04:06:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46655 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeLRJGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 04:06:34 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so7511805ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 01:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yTV4X8CkEIiOkt+tdSxJrLNju+SrdagLpO1CMXTxP4=;
        b=ccWKYLtGlWLvpkdaXxGtTR5xuXYyVmHwy0bt2P/DnBDwF2jM+msDmnBZom0ROAxvrB
         o51hEdJAE3uXCCj6s/bNhmsBKYIvooGdzQA3ratqAFImk+dJmhZNdlCxi9akSYRgoSUl
         I0ipY0rMojxaj+ejn98iF1oaoF1N9w13mwACs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4yTV4X8CkEIiOkt+tdSxJrLNju+SrdagLpO1CMXTxP4=;
        b=IFBFX3V1zpRzxLuTIEeA8ynV2NaERKV+ptuF3uIQZYk4zwoXWjrvYD99ZFXqSVpqeG
         rczfblD6cUX+Xt9ttdkupbKVN3G7cfxDH3WrK2/nzUAC+kvuKEiQrOfzFXn0DEDU47ZM
         vfg4eL4xo6h8jFHnsMzZlGCy9S87sUtHdOeGXOKRhrB2b8g8a7fnYbrA7csaFOZIwbFR
         AJUEdAztZi5VXLUWagya7vLO8GHcsLvAc6WpEAXvwDDKFRP6NgbsVLcduV6IgN3zu01+
         ObRqOpnl2Qc4Wqmf2XrVoRZ+XL+NJ/pzLmA34ftnfHsNknxXasSBrfzjwrDFCVC9iehb
         u2uA==
X-Gm-Message-State: AA+aEWYgJi9Uo8FYWfpT2JhEt+ra9iLbz+tVSy5IYv8cJVTNFxjyB81b
        fVSgDnJH6H+h9S4ZdzlOifoLpcRbcAU=
X-Google-Smtp-Source: AFSGD/XHXjiQ6E2Yhc4deGZrCymQfyljuTUqvdqK8zdCxGhZyWZDR3bOYOwDXGVAYk7UabyW6SrfIA==
X-Received: by 2002:a17:902:4523:: with SMTP id m32mr15614593pld.53.1545123993221;
        Tue, 18 Dec 2018 01:06:33 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id y71sm31698299pfi.123.2018.12.18.01.06.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 01:06:32 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [RESEND v2] mfd: cros_ec: Add commands to control codec
Date:   Tue, 18 Dec 2018 17:06:26 +0800
Message-Id: <20181218090626.46625-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host commands to control codec on EC.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 9a9631f0559e2..fc91082d4c357 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2790,6 +2790,100 @@ struct ec_response_battery_vendor_param {
 	uint32_t value;
 } __packed;
 
+/*****************************************************************************/
+/* Commands for I2S recording on audio codec. */
+
+#define EC_CMD_CODEC_I2S 0x00BC
+
+enum ec_codec_i2s_subcmd {
+	EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
+	EC_CODEC_SET_GAIN = 0x1,
+	EC_CODEC_GET_GAIN = 0x2,
+	EC_CODEC_I2S_ENABLE = 0x3,
+	EC_CODEC_I2S_SET_CONFIG = 0x4,
+	EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
+	EC_CODEC_I2S_SET_BCLK = 0x6,
+};
+
+enum ec_sample_depth_value {
+	EC_CODEC_SAMPLE_DEPTH_16 = 0,
+	EC_CODEC_SAMPLE_DEPTH_24 = 1,
+};
+
+enum ec_i2s_config {
+	EC_DAI_FMT_I2S = 0,
+	EC_DAI_FMT_RIGHT_J = 1,
+	EC_DAI_FMT_LEFT_J = 2,
+	EC_DAI_FMT_PCM_A = 3,
+	EC_DAI_FMT_PCM_B = 4,
+	EC_DAI_FMT_PCM_TDM = 5,
+};
+
+struct ec_param_codec_i2s {
+	/*
+	 * enum ec_codec_i2s_subcmd
+	 */
+	uint8_t cmd;
+	union {
+		/*
+		 * EC_CODEC_SET_SAMPLE_DEPTH
+		 * Value should be one of ec_sample_depth_value.
+		 */
+		uint8_t depth;
+
+		/*
+		 * EC_CODEC_SET_GAIN
+		 * Value should be 0~43 for both channels.
+		 */
+		struct ec_param_codec_i2s_set_gain {
+			uint8_t left;
+			uint8_t right;
+		} __packed gain;
+
+		/*
+		 * EC_CODEC_I2S_ENABLE
+		 * 1 to enable, 0 to disable.
+		 */
+		uint8_t i2s_enable;
+
+		/*
+		 * EC_CODEC_I2S_SET_COFNIG
+		 * Value should be one of ec_i2s_config.
+		 */
+		uint8_t i2s_config;
+
+		/*
+		 * EC_CODEC_I2S_SET_TDM_CONFIG
+		 * Value should be one of ec_i2s_config.
+		 */
+		struct ec_param_codec_i2s_tdm {
+			/*
+			 * 0 to 496
+			 */
+			int16_t ch0_delay;
+			/*
+			 * -1 to 496
+			 */
+			int16_t ch1_delay;
+			uint8_t adjacent_to_ch0;
+			uint8_t adjacent_to_ch1;
+		} __packed tdm_param;
+
+		/*
+		 * EC_CODEC_I2S_SET_BCLK
+		 */
+		uint32_t bclk;
+	};
+} __packed;
+
+/*
+ * For subcommand EC_CODEC_GET_GAIN.
+ */
+struct ec_response_codec_gain {
+	uint8_t left;
+	uint8_t right;
+} __packed;
+
 /*****************************************************************************/
 /* System commands */
 
-- 
2.20.1.415.g653613c723-goog

