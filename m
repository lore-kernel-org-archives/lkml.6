Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BCC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EAD24137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARsYTs3v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EAD24137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754692AbeGENIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:08:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50245 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754465AbeGENF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id v25-v6so11042710wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xjY2pgEoTA9v1GrVLiJUVDtWBCCmEDIrn4PrFqxnYRw=;
        b=ARsYTs3v6lFEkzXCmw8I0Cfe4mVJ2ViQCjSlhZy95NOXUaMka8YJQrB9ePCF9NHZ6D
         8L6KUJgieytQzjeHwPkDb0Ae5AxExIuU0SMspMilyPsixSOWXOp8ErsKOV/Y53LKhEco
         lLPRG7duYQFoliOJfR32zRNQJyPWFrmJaud+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xjY2pgEoTA9v1GrVLiJUVDtWBCCmEDIrn4PrFqxnYRw=;
        b=NH99nSXeOBOUL8EFzNAt2jeyeRz4muj0TMraMZRiFIwNXbmz0TN8bthgrSVgaBsqg7
         H9uliQAyBpyqUS2FB0I+Moxe+eP3Jcpxp2KCe4I52AbRgSQvrb/qc2ufUIEuMz0Q6t6p
         LzRX1B4sIumJuLxBuQ2wz1TafOBTyTk+0JQ3lvY2q0PkCdBKsBIE9EIOiCJ9zcsCG1UI
         BvA+PXb20Z5kqeLtTa81/SpOzwvbnmh1yadeE689YTS3NT18cE86dOFG1ryAdgMJRobW
         gwhk5m4Icd2OzkBAxzqNXfk7oO6v5vYydr47NcCGPgdYoYCT8J2bdSIFqWqVwiZ+9o+x
         9KNw==
X-Gm-Message-State: APt69E1NhRHB8He+5ERXJgNbC9LUWNFfhcCL7ncr5Fxhc0M5dQimTYqU
        amAQAPainvJPZL9e7ey6OVEn0g==
X-Google-Smtp-Source: AAOMgpd9KPQLmer2a1NjbD/JOMlkpNdSuZLfPDn1s0QtDldNSewb9gfckiQmAEuJAkqC9bFJxXGxRQ==
X-Received: by 2002:a1c:ac03:: with SMTP id v3-v6mr3963295wme.100.1530795926779;
        Thu, 05 Jul 2018 06:05:26 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:26 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 18/27] venus: helpers: add a new helper to set raw format
Date:   Thu,  5 Jul 2018 16:03:52 +0300
Message-Id: <20180705130401.24315-19-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
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
index 7e764eeeb07c..4e4109e80988 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -412,6 +412,20 @@ static int session_register_bufs(struct venus_inst *inst)
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
@@ -493,35 +507,35 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_num_bufs);
 
-int venus_helper_set_color_format(struct venus_inst *inst, u32 pixfmt)
+int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
+				u32 buftype)
 {
+	const u32 ptype = HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SELECT;
 	struct hfi_uncompressed_format_select fmt;
-	u32 ptype = HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SELECT;
-	int ret;
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

