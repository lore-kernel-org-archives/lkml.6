Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531DAC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC6924138
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkC7iggz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC6924138
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbeGENJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:09:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51971 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbeGENF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so11040859wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oU/c81CKUJQLLGDhE1U7BJ8H3e590k2PwcQruab6xc0=;
        b=BkC7iggzUe43eEIW0Tq1j7+eKjDNnNx8Ilx9gfLqBRcUwhT+le/NErI5xEgobr6oS7
         L2qA2YB7zCwmAFjJ+pqY+6rlySXjR12KpOTK0Lzff+AlaDu+riLCGt9tds79o+34ACjB
         jwzHIqiGL4N2ha/gHnAFf8IOMabteet+3NLAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oU/c81CKUJQLLGDhE1U7BJ8H3e590k2PwcQruab6xc0=;
        b=kUW3dOhzsbcyZ0s6cNPlU4sZD/usgghuUG2rcn+RHFklQqBUxqW5IFAXn0G0MLcxme
         sJb9mamLiGqv0pxKVkMbiv5oRrKVb+6pwUS3lbtNXF/mMi5dic0LKFmyr7jitolRI5mn
         QRZmbNu/ZF4qSWq6WmYGE9BR6tAXEk/AKj8OA0vrQIZ8MatIWqs8XAp/WbQifQT/s4mE
         s3Sxz11aIiSiZ6xy45xS5fi4rr7cvJCVNMpt+LMzUkA4TMIBq/L+6XjWglhqzkqH9Yiv
         bJQYfay/a77CttzKGUI1Eb2VGmft/iM5WfGfzNd+TjTrL7BZSaS00vOosjxRUlpNBH/z
         ePIg==
X-Gm-Message-State: APt69E1ltMgWAKo/mimDhTzCzmxSDZosqPCWkorx50TorXXaopXpbLxO
        RUgqeZrl9PUWrHz+5wiROX4yyw==
X-Google-Smtp-Source: AAOMgpcDoVM+5Cy6WmxpKCMIc4ZS1qjiYIa0qLLDbHLck3pv9AuV1d9B9HQxAQrGPv/hY8jwDD/oMQ==
X-Received: by 2002:adf:8e49:: with SMTP id n67-v6mr4376875wrb.131.1530795925715;
        Thu, 05 Jul 2018 06:05:25 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:25 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 17/27] venus: helpers: add buffer type argument to a helper
Date:   Thu,  5 Jul 2018 16:03:51 +0300
Message-Id: <20180705130401.24315-18-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds one more function argument to pass buffer type to
set_output_resolution() helper function. That is a preparation
to support secondary decoder output.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 5 +++--
 drivers/media/platform/qcom/venus/helpers.h | 3 ++-
 drivers/media/platform/qcom/venus/venc.c    | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 6fd7458f390a..7e764eeeb07c 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -458,12 +458,13 @@ int venus_helper_set_input_resolution(struct venus_inst *inst,
 EXPORT_SYMBOL_GPL(venus_helper_set_input_resolution);
 
 int venus_helper_set_output_resolution(struct venus_inst *inst,
-				       unsigned int width, unsigned int height)
+				       unsigned int width, unsigned int height,
+				       u32 buftype)
 {
 	u32 ptype = HFI_PROPERTY_PARAM_FRAME_SIZE;
 	struct hfi_framesize fs;
 
-	fs.buffer_type = HFI_BUFFER_OUTPUT;
+	fs.buffer_type = buftype;
 	fs.width = width;
 	fs.height = height;
 
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index cd306bd8978f..0de9989adcdb 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -36,7 +36,8 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
 int venus_helper_set_input_resolution(struct venus_inst *inst,
 				      unsigned int width, unsigned int height);
 int venus_helper_set_output_resolution(struct venus_inst *inst,
-				       unsigned int width, unsigned int height);
+				       unsigned int width, unsigned int height,
+				       u32 buftype);
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index df54841c910d..650e6b0a01d2 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -795,7 +795,8 @@ static int venc_init_session(struct venus_inst *inst)
 		goto deinit;
 
 	ret = venus_helper_set_output_resolution(inst, inst->width,
-						 inst->height);
+						 inst->height,
+						 HFI_BUFFER_OUTPUT);
 	if (ret)
 		goto deinit;
 
-- 
2.14.1

