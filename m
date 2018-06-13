Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 03AD3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1E720660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bV3CIa0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1E720660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964903AbeFMPMx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:12:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35920 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964821AbeFMPJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so6113765wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBNFMYHtBk25cq657W5saatgm8VT3r2BxDc+quPr6ks=;
        b=bV3CIa0xUuxCdgKwWNrfpkv0DO2KPsdQN+EhIcQtL7pcHVipOb+YlbHx8u4tRMipf0
         mbiIZeXoav75uF6EHJnFvN5mZerPGVYpSosbsUCtm5lxT+rLjNzwEjwCjhx2lLMWa+LA
         sR8A2gkOnoCyzWs3FfIsuzYB6CYcowgDIGmhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBNFMYHtBk25cq657W5saatgm8VT3r2BxDc+quPr6ks=;
        b=oUW57jt1BEicIvuXVAe1qqz5i2/4TlclviWHfrswZ8zPN0ldZ4MHzAXxFeR5/XJMfD
         Kf4ECFjoHpXkOuB+zVdC0R/e61slgrz6KYKGIplyXiGLKE+0pTC6kH75iWIrQ9suRvgp
         7tu2kUVx5sW232LWOIJGPbcJhTx4nkYmrOBej1nERVJykShnj0sp+RiNl3Xk5vrFeEdh
         WBZffwGn0MQPtGhXoYRR9gk/cL11fR0/YsCEFnCRDwqHzZCSCdoek64j8CasEQLxHPFi
         /prdM56KY04JJlqNjG0xDRDObmPoglJrBZ4RoDWKRD4LavcmzdJzutcRIfng8Dinqy2F
         t5rg==
X-Gm-Message-State: APt69E2Blfa60mpJferbNjUxcfmEyv/cl5keU/jb/oghy1PuvhIrs+UV
        C6adIXd/lrE1cHO4p+IukrlQWg==
X-Google-Smtp-Source: ADUXVKI++/Q8sCMP097FpX59vfrbArGFILXPNR88vucgFRj6JvTF/33uUAJtEIoQ7GYMk6at5Omarg==
X-Received: by 2002:a1c:c90:: with SMTP id 138-v6mr3611866wmm.110.1528902573343;
        Wed, 13 Jun 2018 08:09:33 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:32 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 18/27] venus: helpers: add a new helper to set raw format
Date:   Wed, 13 Jun 2018 18:07:52 +0300
Message-Id: <20180613150801.11702-19-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

