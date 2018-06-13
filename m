Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CA94EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7723C208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWtf5/vA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7723C208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936089AbeFMPM3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:12:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46582 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964832AbeFMPJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id v13-v6so3123758wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=88FFyjErotOxDmhgzqLVFCd4JC06AOb71V78xZlxmq0=;
        b=DWtf5/vAnk4J0ykQlmOj12hv6UzFLjEPzAdjszIInMO3CSQiHOauLKP6/0UJ3MDK2P
         l9vuvljcNT0DJtwFYVOd5DiayQpoHJ4uqi90HRMO7QycM57o9omIAefUOMiDsCicvN15
         dImRiwksxCmivl1tiIqZdgvKno+vTscTXo1YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=88FFyjErotOxDmhgzqLVFCd4JC06AOb71V78xZlxmq0=;
        b=J0pqTsEYZ+5qUrUHPwIewy5ipuaoirftLShhUwerkL+6VKOHMgNY5Zt2z2P4bOWjIv
         aOT3VvczxhudtUbNnJQjHnE5ha6RgEreHeHXJYNDt8ZoYsgCwJQGeA25lS4nZ9IkvNJW
         vruo/+8oao+3a7LD/LLYR2A3Gk8h90ce0UhIPZ2X923W80pev3WmhdYka1t4h0INhUl4
         tjzhCC5n18rLHPIquVmicxuU7J84OUp1NTD9jHghTK1WZZtCVvK4mvBb4xPkCR64dusH
         7YZTPV/us0U76r3+i5wngp3WPeW3AH0vsi9xG+INjIRRfy+9KHQZ8QmuH1Ar3g8OMQNP
         HMlg==
X-Gm-Message-State: APt69E1cb3w/2PuFSwwtQurjaWJO5CQ5v82Obou/HjWVa0PndAY2Qe1l
        CMh89p8FjIgftnkSTdXudkxmpg==
X-Google-Smtp-Source: ADUXVKIaxig0sinBfY28J8GIWtDovqQRqpZ24KY9TIVW44p899weekzlYY/yFN3OmTLYvdeBCyzSFQ==
X-Received: by 2002:a5d:45cb:: with SMTP id b11-v6mr4588034wrs.106.1528902574620;
        Wed, 13 Jun 2018 08:09:34 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:34 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 19/27] venus: helpers,vdec,venc: add helpers to set work mode and core usage
Date:   Wed, 13 Jun 2018 18:07:53 +0300
Message-Id: <20180613150801.11702-20-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are new properties applicable to Venus version 4xx. Add the
helpers and call them from decoder and encoder drivers.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 28 ++++++++++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    |  8 ++++++++
 drivers/media/platform/qcom/venus/venc.c    |  8 ++++++++
 4 files changed, 46 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index a1590d5cc921..2295cca3c22a 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -481,6 +481,34 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_output_resolution);
 
+int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode)
+{
+	u32 ptype = HFI_PROPERTY_PARAM_WORK_MODE;
+	struct hfi_video_work_mode wm;
+
+	if (!IS_V4(inst->core))
+		return 0;
+
+	wm.video_work_mode = mode;
+
+	return hfi_session_set_property(inst, ptype, &wm);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_work_mode);
+
+int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage)
+{
+	u32 ptype = HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE;
+	struct hfi_videocores_usage_type cu;
+
+	if (!IS_V4(inst->core))
+		return 0;
+
+	cu.video_core_enable_mask = usage;
+
+	return hfi_session_set_property(inst, ptype, &cu);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_core_usage);
+
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs)
 {
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 79af7845efbd..d5e727e1ecab 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -38,6 +38,8 @@ int venus_helper_set_input_resolution(struct venus_inst *inst,
 int venus_helper_set_output_resolution(struct venus_inst *inst,
 				       unsigned int width, unsigned int height,
 				       u32 buftype);
+int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode);
+int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index eae9c651ac91..f1cf4678d013 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -550,6 +550,14 @@ static int vdec_set_properties(struct venus_inst *inst)
 	u32 ptype;
 	int ret;
 
+	ret = venus_helper_set_work_mode(inst, VIDC_WORK_MODE_2);
+	if (ret)
+		return ret;
+
+	ret = venus_helper_set_core_usage(inst, VIDC_CORE_ID_1);
+	if (ret)
+		return ret;
+
 	if (core->res->hfi_version == HFI_VERSION_1XX) {
 		ptype = HFI_PROPERTY_PARAM_VDEC_CONTINUE_DATA_TRANSFER;
 		ret = hfi_session_set_property(inst, ptype, &en);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 1d7f87e0f5b3..4f0a5daa97e2 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -643,6 +643,14 @@ static int venc_set_properties(struct venus_inst *inst)
 	u32 ptype, rate_control, bitrate, profile = 0, level = 0;
 	int ret;
 
+	ret = venus_helper_set_work_mode(inst, VIDC_WORK_MODE_2);
+	if (ret)
+		return ret;
+
+	ret = venus_helper_set_core_usage(inst, VIDC_CORE_ID_2);
+	if (ret)
+		return ret;
+
 	ptype = HFI_PROPERTY_CONFIG_FRAME_RATE;
 	frate.buffer_type = HFI_BUFFER_OUTPUT;
 	frate.framerate = inst->fps * (1 << 16);
-- 
2.14.1

