Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B49CC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF63D25DA1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAX/j7JN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF63D25DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeF0PbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:31:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39019 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934942AbeF0P2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id p11-v6so5921749wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBNFMYHtBk25cq657W5saatgm8VT3r2BxDc+quPr6ks=;
        b=PAX/j7JN8AxISUMxyJyg51rqePRavoKFk9K917ZcvsOszrJJWk5qqfB6t8SzWmAlcd
         ECUN2FQ+m9JZ7/3JfrB9+Y5CIgVJ5bZ8gHn9tzvFej1xW1sZG3lQfdWrBsKyM6wY+dGt
         Erzpmy9rGRAQzuPFO43CkRegVJejuSnvEkNoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBNFMYHtBk25cq657W5saatgm8VT3r2BxDc+quPr6ks=;
        b=Xde1cyAqWRS0JBGwbAQsNdMNdkOMeWcuNcjEVhUZ+C/26ExnWta1xYcxubbxUltWx6
         Gv66Wc/UWnoH8XJfs8qUH0duR3ppuGx00E88EREn8ikDUbvlwKbF2ZLBbsKo7F624KAH
         JThjQsHLMr5TgOdBjYHKDWUvWaXPo0+Zxr9brPs6NxqP3TkiBbXwTVldDfCvp+uKzK8Y
         24omspEyG0KzhcZm2n6knXgtyf1ekG2dfqYbTyz+VEK2lmKS23pwHBDZNdMdXVTGmoWB
         Rcy7Gd6tPbF8/ZGY6rxQ6/XYLiQxQ6HLZsDQ6gIKHDv5ckm2kgqiSBb8VM+pBGBqBniA
         gu/A==
X-Gm-Message-State: APt69E08OaqTptEuAKvSiyIfPEpuCW9Y/gmSCamz+koNwhNm1NhobmfK
        5W9cRYTEL6GsCz7Dr8Fji/XAiw==
X-Google-Smtp-Source: AAOMgpeF4ko+wvq3L8uYRgqfsTiD3WhUFTujJfb73HcsUnuA6FEXsEFLJODxfwU9OHR6hcZWCbNLag==
X-Received: by 2002:a1c:aa12:: with SMTP id t18-v6mr5219571wme.54.1530113299674;
        Wed, 27 Jun 2018 08:28:19 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:19 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 18/27] venus: helpers: add a new helper to set raw format
Date:   Wed, 27 Jun 2018 18:27:16 +0300
Message-Id: <20180627152725.9783-19-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper will has one more argument for buffer type, that
way the decoder can configure the format on it's secondary
output.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 52 ++++++++++++++++++-----------
 drivers/media/platform/qcom/venus/helpers.h |  2 ++
 2 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 2eeb243e4dbe..a1590d5cc921 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -407,6 +407,20 @@ static int session_register_bufs(struct venus_inst *inst)
 	return ret;
 }
 
+static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
+{
+	switch (v4l2_fmt) {
+	case V4L2_PIX_FMT_NV12:
+		return HFI_COLOR_FORMAT_NV12;
+	case V4L2_PIX_FMT_NV21:
+		return HFI_COLOR_FORMAT_NV21;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 			    struct hfi_buffer_requirements *req)
 {
@@ -488,35 +502,35 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_num_bufs);
 
-int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
+int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
+				u32 buftype)
 {
-	struct hfi_uncompressed_format_select fmt;
 	u32 ptype = HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SELECT;
-	int ret;
+	struct hfi_uncompressed_format_select fmt;
+
+	fmt.buffer_type = buftype;
+	fmt.format = hfi_format;
+
+	return hfi_session_set_property(inst, ptype, &fmt);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_raw_format);
+
+int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
+{
+	u32 hfi_format, buftype;
 
 	if (inst->session_type == VIDC_SESSION_TYPE_DEC)
-		fmt.buffer_type = HFI_BUFFER_OUTPUT;
+		buftype = HFI_BUFFER_OUTPUT;
 	else if (inst->session_type == VIDC_SESSION_TYPE_ENC)
-		fmt.buffer_type = HFI_BUFFER_INPUT;
+		buftype = HFI_BUFFER_INPUT;
 	else
 		return -EINVAL;
 
-	switch (pixfmt) {
-	case V4L2_PIX_FMT_NV12:
-		fmt.format = HFI_COLOR_FORMAT_NV12;
-		break;
-	case V4L2_PIX_FMT_NV21:
-		fmt.format = HFI_COLOR_FORMAT_NV21;
-		break;
-	default:
+	hfi_format = to_hfi_raw_fmt(pixfmt);
+	if (!hfi_format)
 		return -EINVAL;
-	}
 
-	ret = hfi_session_set_property(inst, ptype, &fmt);
-	if (ret)
-		return ret;
-
-	return 0;
+	return venus_helper_set_raw_format(inst, hfi_format, buftype);
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_color_format);
 
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 0de9989adcdb..79af7845efbd 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -40,6 +40,8 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 				       u32 buftype);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
+int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
+				u32 buftype);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
 int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
 int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype);
-- 
2.14.1

