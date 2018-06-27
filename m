Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDE7C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA28025D4A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbNwQtG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA28025D4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754638AbeF0PaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:30:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37121 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964969AbeF0P2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id k6-v6so2479326wrp.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VRMNPzwCVtxgb0LfMFtJgW6g4iKfhAD4kYYPw52509I=;
        b=EbNwQtG2ppKGxlecIPu3W4ImpNvAsO6Hrzj2CYS7cMP5VdpnQ82snR1s/VKxpoMPD+
         4u60M9G0+8aWf5kV0cULVIqcG6qUN2He97HooG3f/Pk4OPB+cBBTI1FPSGTf/IqU6abF
         12bAikshHDQPOR7BMUfbnB7Ep3fkNhhEU0N/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VRMNPzwCVtxgb0LfMFtJgW6g4iKfhAD4kYYPw52509I=;
        b=CCj3U02Qho1YgPDr/two0WprCcEl0yI6dzuOuzUqU/tCaxoZImkaiYS0wYvsK16Vjd
         4DiEvImYPvM2tAG0k03voNNzy58TghAoNv/QITstm3yRed0Bblh8L8NQlxTesCpar2SX
         a22xcsMfBVG8L6g+3d9aZBSM0GgOIVv9Sih3qZDdzMt7SGfx8Q5qqFQq9xWVmqguKkGK
         01ZDCF0fFINvppTYfMR/NrhMWoOXAbPkDhcWQgoajA2dVeBNHsIA1l4bou/WFSH8cbei
         3zMT6+FJNv805gXbaUAiW7CAMdALRJy5+DeujpTdQvHDtLpuUCGN8Mz1lK054XQXQdSc
         WT0w==
X-Gm-Message-State: APt69E2rMp+WrfSw06lHhuLYU7QMJSEtkql+8yJduc62PecEyPp1D71C
        Lz0w8xE/y1J7yBJQPcWlhfJe9g==
X-Google-Smtp-Source: AAOMgpfzIgL07maIWFk9dUFuZAK5WrnNGW8KaRMIAZIq0CwJDWLI9m/hIxi+PD/3Bs1ce2vOfWh+UA==
X-Received: by 2002:adf:b60d:: with SMTP id f13-v6mr5364050wre.186.1530113303105;
        Wed, 27 Jun 2018 08:28:23 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:22 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 21/27] venus: helpers: add a helper to return opb buffer sizes
Date:   Wed, 27 Jun 2018 18:27:19 +0300
Message-Id: <20180627152725.9783-22-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to return current output picture buffer size.
OPB sizes can vary depending on the selected decoder output(s).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h    |  6 ++++++
 drivers/media/platform/qcom/venus/helpers.c | 15 +++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 3 files changed, 22 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 1d1a59a5d343..f8e4d92ff0e1 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -239,6 +239,9 @@ struct venus_buffer {
  * @num_output_bufs:	holds number of output buffers
  * @input_buf_size	holds input buffer size
  * @output_buf_size:	holds output buffer size
+ * @output2_buf_size:	holds secondary decoder output buffer size
+ * @opb_buftype:	output picture buffer type
+ * @opb_fmt:		output picture buffer raw format
  * @reconfig:	a flag raised by decoder when the stream resolution changed
  * @reconfig_width:	holds the new width
  * @reconfig_height:	holds the new height
@@ -288,6 +291,9 @@ struct venus_inst {
 	unsigned int num_output_bufs;
 	unsigned int input_buf_size;
 	unsigned int output_buf_size;
+	unsigned int output2_buf_size;
+	u32 opb_buftype;
+	u32 opb_fmt;
 	bool reconfig;
 	u32 reconfig_width;
 	u32 reconfig_height;
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index e332c9682b9c..6b31c91528ed 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -608,6 +608,21 @@ int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_bufsize);
 
+unsigned int venus_helper_get_opb_size(struct venus_inst *inst)
+{
+	/* the encoder has only one output */
+	if (inst->session_type == VIDC_SESSION_TYPE_ENC)
+		return inst->output_buf_size;
+
+	if (inst->opb_buftype == HFI_BUFFER_OUTPUT)
+		return inst->output_buf_size;
+	else if (inst->opb_buftype == HFI_BUFFER_OUTPUT2)
+		return inst->output2_buf_size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(venus_helper_get_opb_size);
+
 static void delayed_process_buf_func(struct work_struct *work)
 {
 	struct venus_buffer *buf, *n;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 8ff4bd3ef958..92be45894a69 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -48,6 +48,7 @@ int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
 int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
 int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype);
+unsigned int venus_helper_get_opb_size(struct venus_inst *inst);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
-- 
2.14.1

