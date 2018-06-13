Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BA037C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D37020660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Peysxwj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D37020660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964842AbeFMPJf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:09:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35901 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964794AbeFMPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so6113013wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tdgb7i3pHOc18juXBnV581NGwky8g4nU20Ecgz01uNo=;
        b=Peysxwj/SxfKV2HWMBS22WXjOKTcC4lZjBQI9R80bN+ZxC3VZcVtRvL+YNKbzybTRz
         I6Bzi9UPL4pM2ajXjyAga3Ihmiv3p74n3CZWAeWuXB98WxmaiKZKzBwViRVRKtm5eG+K
         iQ0g0Ev2epWxrIHAWaUPnY6b87df6s4dfC+k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tdgb7i3pHOc18juXBnV581NGwky8g4nU20Ecgz01uNo=;
        b=N1XVaetj6+a77OS5gFo4at7igXwPKuM+AOrzaETka1BXgL9/Ajx9Zofz+DNcoLr0LH
         epHRZbRkBKn881kZ0wHqP5itrvimjnRoLYBremO9klMchRWmq+Q8e4dcmrGAkm8QQ3Lz
         IuNyyo8kECxi4DPerw1Bd+CHKGxIEyaVn2hvQErUvfcDUH99mEpXl/aiKc1BU18trh8P
         LuWXTIPlNoVdvWQalGM985ds2S2cdvQk5tKf/wwBR49Z0bm6LQ9hTxkePdLBo9dsBcpY
         gGlm1POP1r+vz6q39svvWk47UCi5wk0cs6vW861jJ2aA+hJdtkLzBj+J5QlV6OtNYq1z
         O7Cg==
X-Gm-Message-State: APt69E2rPIvFo8u6UT3ZcV6gDJN4TRyVC7DeTEzI257kHgR4NihZswA3
        NbANFanNCeN/9Ax3tk/BOveaKw==
X-Google-Smtp-Source: ADUXVKKtpHV676mXgW+4EADMRYQatXr9Of697ldoDrN8/oJckkIV24v1j76bCcwjLxRE7o8ze4+CbQ==
X-Received: by 2002:a1c:40d4:: with SMTP id n203-v6mr3687240wma.101.1528902567203;
        Wed, 13 Jun 2018 08:09:27 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:26 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 14/27] venus: helpers: add a helper function to set dynamic buffer mode
Date:   Wed, 13 Jun 2018 18:07:48 +0300
Message-Id: <20180613150801.11702-15-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new helper function to set dynamic buffer mode if it is
supported by current HFI version. The dynamic buffer mode is
set unconditionally for both decoder outputs.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 22 ++++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 drivers/media/platform/qcom/venus/vdec.c    | 15 +++------------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 03121dbb4175..e3dc2772946f 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -519,6 +519,28 @@ int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_color_format);
 
+int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
+{
+	u32 ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
+	struct hfi_buffer_alloc_mode mode;
+	int ret;
+
+	if (!is_dynamic_bufmode(inst))
+		return 0;
+
+	mode.type = HFI_BUFFER_OUTPUT;
+	mode.mode = HFI_BUFFER_MODE_DYNAMIC;
+
+	ret = hfi_session_set_property(inst, ptype, &mode);
+	if (ret)
+		return ret;
+
+	mode.type = HFI_BUFFER_OUTPUT2;
+
+	return hfi_session_set_property(inst, ptype, &mode);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_dyn_bufmode);
+
 static void delayed_process_buf_func(struct work_struct *work)
 {
 	struct venus_buffer *buf, *n;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 0e64aa95624a..52b961ed491e 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -40,6 +40,7 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
+int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 31a240ab142b..92669a358a90 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -557,18 +557,9 @@ static int vdec_set_properties(struct venus_inst *inst)
 			return ret;
 	}
 
-	if (core->res->hfi_version == HFI_VERSION_3XX ||
-	    inst->cap_bufs_mode_dynamic) {
-		struct hfi_buffer_alloc_mode mode;
-
-		ptype = HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE;
-		mode.type = HFI_BUFFER_OUTPUT;
-		mode.mode = HFI_BUFFER_MODE_DYNAMIC;
-
-		ret = hfi_session_set_property(inst, ptype, &mode);
-		if (ret)
-			return ret;
-	}
+	ret = venus_helper_set_dyn_bufmode(inst);
+	if (ret)
+		return ret;
 
 	if (ctr->post_loop_deb_mode) {
 		ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
-- 
2.14.1

