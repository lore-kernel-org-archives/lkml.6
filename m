Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80043C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B4C32412F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UiKoYQI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4C32412F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754509AbeGENFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51967 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754425AbeGENFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so11040635wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m7EbUSCixlczjT8GRHqc9JZ/Q677zWmKsckfCGoGQ9s=;
        b=UiKoYQI1QtgF0V0kAasHM99HSqOqngH7Nzf/1EvOZfaESKoiVVO2BJmaT5UN5AdQym
         afCNwYoGoK+o3aDLoIQrzDNJzDozI7vp0MrZdGrn3HwGwKEQj2cCrFPL3vgpmU45H833
         +ybF8XcA9/Vsjoy8g8me65S+0Xn0Yl3xDFmyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m7EbUSCixlczjT8GRHqc9JZ/Q677zWmKsckfCGoGQ9s=;
        b=mjlCpA3+xWgSIK4Ww82jAe41K9594ElU7+PwRTOygayY/UmOFj9s4sNGFK23VS8iuC
         AnJVAxvpvN/j8PtXvf0QCZdc71UtqgRN+haDerL55kgRp+iGRK5w9acz/TsXgBP1wZIQ
         4wsbR9mUxS8q2xVUKoq+HE5RTwmHRmYMyPqc3t4kiQbC9mGb2dRLtpbc7is9TtxRQBUL
         1sO9anJe8y2xrXS1Pdq6+udRL4umszC8nvdBnldZZZsdWX5WXi0Zh/+Kt9c5h3dy+y3K
         HIeD658wwQdXNfYhObYYjSPFEKSMBJ6H+mYHDGm9tPz7mwfdLPjTX+kgn3FR3rQ1OtBN
         evpA==
X-Gm-Message-State: APt69E0BFW31KwCnQSmkWEanvMb/ftI9b858weZ3qbayPz06tTj8uVWF
        4nVGTM9HSa5wMSirypO/yLPzlQ==
X-Google-Smtp-Source: AAOMgpejJM4xvLg+hhinhUkAqg7NE3VDmfNcTBCrgrjdPS0P9eAWHaZGsiMVSyygO5lWLMG2VK8row==
X-Received: by 2002:adf:9485:: with SMTP id 5-v6mr4848877wrr.82.1530795923393;
        Thu, 05 Jul 2018 06:05:23 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:22 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 15/27] venus: helpers: add helper function to set actual buffer size
Date:   Thu,  5 Jul 2018 16:03:49 +0300
Message-Id: <20180705130401.24315-16-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and use a helper function to set actual buffer size for
particular buffer type. This is also preparation to use
the second decoder output.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 12 ++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 drivers/media/platform/qcom/venus/vdec.c    | 10 ++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 29cc84777125..6fd7458f390a 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -546,6 +546,18 @@ int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_dyn_bufmode);
 
+int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype)
+{
+	const u32 ptype = HFI_PROPERTY_PARAM_BUFFER_SIZE_ACTUAL;
+	struct hfi_buffer_size_actual bufsz;
+
+	bufsz.type = buftype;
+	bufsz.size = bufsize;
+
+	return hfi_session_set_property(inst, ptype, &bufsz);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_bufsize);
+
 static void delayed_process_buf_func(struct work_struct *work)
 {
 	struct venus_buffer *buf, *n;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 52b961ed491e..cd306bd8978f 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -41,6 +41,7 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
 int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
+int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index c37779d82fec..d2a53c0eab86 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -710,7 +710,6 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(q);
 	struct venus_core *core = inst->core;
-	u32 ptype;
 	int ret;
 
 	mutex_lock(&inst->lock);
@@ -740,13 +739,8 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto deinit_sess;
 
 	if (core->res->hfi_version == HFI_VERSION_3XX) {
-		struct hfi_buffer_size_actual buf_sz;
-
-		ptype = HFI_PROPERTY_PARAM_BUFFER_SIZE_ACTUAL;
-		buf_sz.type = HFI_BUFFER_OUTPUT;
-		buf_sz.size = inst->output_buf_size;
-
-		ret = hfi_session_set_property(inst, ptype, &buf_sz);
+		ret = venus_helper_set_bufsize(inst, inst->output_buf_size,
+					       HFI_BUFFER_OUTPUT);
 		if (ret)
 			goto deinit_sess;
 	}
-- 
2.14.1

