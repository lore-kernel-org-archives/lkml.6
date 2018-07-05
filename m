Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E8CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388732412B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NXjY1ls9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388732412B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeGENIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:08:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55415 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754478AbeGENFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id v16-v6so11020098wmv.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=olV8QCV6OTgGL+a7O+uasLtsP5Ovu74pzCpIsDTiQaA=;
        b=NXjY1ls9miz/xtVcYPTlpHp55RGPE0LUjpLPfjNGLr0URgaDZg1RlvExour0XmF+lE
         W2JLYMF6HbpWFtVcBaHURAPSsfp8E16amouYSBYeOfqG41U/ehOuvi/nQ8sNWfilS3ph
         YoS2GzRw1FjcpSQzP/tJ3rSZygBEOx0RB+xZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=olV8QCV6OTgGL+a7O+uasLtsP5Ovu74pzCpIsDTiQaA=;
        b=m1XjV8wIOciDMvj7NBvagktMGglmb7BUiEU3e4RX3yATVNu9wv5drEJ2cnQG8hClSa
         0me+rs9fx8KfKZf1OQwPGULTbu1NSKNQMufCMx2H19irwJ3lRwI0qEgt6KaloaAPd4pw
         k9Znm/evd6kBuA3D7tBKaoiXrcIK2nZVwn/If3UP0le89tk0EboPryeI4k0w2iEZ+U7a
         swcyy+Zu2uIgjcnpHf5vJ4H6PFn2xPbL4kAchRfCExmrzAkNDUxKzZNXOC8CsaK4sVbQ
         ApODZr9Z3GB0ac/6SxjKTTlUaC9kXAQI3G54Q905TD1qORH/L/yoJEPRNGcPTDHpXZ5C
         qe7g==
X-Gm-Message-State: APt69E1ltH2oFGuylvXqaMEK7o0EAQzVyfCafwFIKMvCHYoi0yDMxm+M
        j+BFsnjLRaosUpmA7tslInwgRkNVxrE=
X-Google-Smtp-Source: AAOMgpdQhB1umq4oWMtsXXvroslZYFVFzXZ8IVCzo94tmR+nOjoLXDyzeuKvgCoIG71wTjUSc7vnSQ==
X-Received: by 2002:a1c:ca0f:: with SMTP id a15-v6mr3966291wmg.102.1530795929111;
        Thu, 05 Jul 2018 06:05:29 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:28 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 20/27] venus: helpers: extend set_num_bufs helper with one more argument
Date:   Thu,  5 Jul 2018 16:03:54 +0300
Message-Id: <20180705130401.24315-21-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend venus_helper_set_num_bufs() helper function with one more
argument to set number of output buffers for the secondary decoder
output.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 16 ++++++++++++++--
 drivers/media/platform/qcom/venus/helpers.h |  3 ++-
 drivers/media/platform/qcom/venus/vdec.c    |  2 +-
 drivers/media/platform/qcom/venus/venc.c    |  2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 3cd25e25aa70..13f0bc4e5ffa 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -515,7 +515,8 @@ int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage)
 EXPORT_SYMBOL_GPL(venus_helper_set_core_usage);
 
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
-			      unsigned int output_bufs)
+			      unsigned int output_bufs,
+			      unsigned int output2_bufs)
 {
 	u32 ptype = HFI_PROPERTY_PARAM_BUFFER_COUNT_ACTUAL;
 	struct hfi_buffer_count_actual buf_count;
@@ -531,7 +532,18 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 	buf_count.type = HFI_BUFFER_OUTPUT;
 	buf_count.count_actual = output_bufs;
 
-	return hfi_session_set_property(inst, ptype, &buf_count);
+	ret = hfi_session_set_property(inst, ptype, &buf_count);
+	if (ret)
+		return ret;
+
+	if (output2_bufs) {
+		buf_count.type = HFI_BUFFER_OUTPUT2;
+		buf_count.count_actual = output2_bufs;
+
+		ret = hfi_session_set_property(inst, ptype, &buf_count);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_num_bufs);
 
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index d5e727e1ecab..8ff4bd3ef958 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -41,7 +41,8 @@ int venus_helper_set_output_resolution(struct venus_inst *inst,
 int venus_helper_set_work_mode(struct venus_inst *inst, u32 mode);
 int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
-			      unsigned int output_bufs);
+			      unsigned int output_bufs,
+			      unsigned int output2_bufs);
 int venus_helper_set_raw_format(struct venus_inst *inst, u32 hfi_format,
 				u32 buftype);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 75f622c73222..3af1fb81cc32 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -758,7 +758,7 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto deinit_sess;
 
 	ret = venus_helper_set_num_bufs(inst, inst->num_input_bufs,
-					VB2_MAX_FRAME);
+					VB2_MAX_FRAME, VB2_MAX_FRAME);
 	if (ret)
 		goto deinit_sess;
 
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 6dc153f16d88..cc8049fd8811 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -963,7 +963,7 @@ static int venc_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto deinit_sess;
 
 	ret = venus_helper_set_num_bufs(inst, inst->num_input_bufs,
-					inst->num_output_bufs);
+					inst->num_output_bufs, 0);
 	if (ret)
 		goto deinit_sess;
 
-- 
2.14.1

