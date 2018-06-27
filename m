Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B49C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900AF25857
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2v2iX/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900AF25857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965541AbeF0PaG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:30:06 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34173 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965209AbeF0P2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:25 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so2487824wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGtopIdccvCWqxzw2Y/ssJlKU0JmcRx1SeA6otkSH9k=;
        b=D2v2iX/qgTJOgKhlxD0O+emIRCP1LIwORkb3L6rqjSzJaIIe0RsFkPUxyQhVJLQPwi
         fW9fVut1BZ0XJXlA+Vl+RRIMqrsEEO6shCo2APH2uRncfiPfIGnKaFaN10abdcDC0edV
         cxjW7rOzZd+p3qvviFntrOVrqsrxIUzIYFgss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KGtopIdccvCWqxzw2Y/ssJlKU0JmcRx1SeA6otkSH9k=;
        b=fWkKGq+fTnnufZoeJZzbNi6uI1kkJL9mvhj5dzPg+Lz+xeMBYeDJ8SXdCeWfAiW8hz
         m/NvX1uvziMplKS3afi5EweCBFmALDwSe5tqir7L2I/prE+4kj6lAwKAdiQB0NSdPEP0
         zqyktJm/oq4YwPxhGm1PoFpAMAOgAyAw1dQXKY3Ir0hRDol7v/npKXq2ejslTFDDd/3p
         ZPoLtc7OL8Y3QpgPvOElACCkO9MuBLMf1CzwFwtRQCWlk0KuPsU2l+CSs+oQSop7osc5
         IYbJ578w3WGayIx3aFzhi67Kwc9UwxOsczoy8TLkkXhwGcESQmmkVZno4sr19iIhOShS
         C5Jg==
X-Gm-Message-State: APt69E1JCmOkaEIOrErCN+jV9QNRBE4mqDymC9PEleBH+hhaCEX3XNwk
        Hhsh9rQ/a7qzGZMqtI2TvNZynQ==
X-Google-Smtp-Source: AAOMgpd+tHalR/dNJ0V8/bRP9B03jdYHhRVcW0B+PttDciQ+DRm/mkjq3VfNPWhUP5qPXy+W3Mwkxw==
X-Received: by 2002:adf:86e9:: with SMTP id 38-v6mr6017182wry.232.1530113304170;
        Wed, 27 Jun 2018 08:28:24 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:23 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 22/27] venus: vdec: get required input buffers as well
Date:   Wed, 27 Jun 2018 18:27:20 +0300
Message-Id: <20180627152725.9783-23-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework and rename vdec_cap_num_buffers() to get the number of
input buffers too.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 41 +++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 5d8bf288bd2a..55213a8d55a3 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -603,19 +603,32 @@ static int vdec_init_session(struct venus_inst *inst)
 	return ret;
 }
 
-static int vdec_cap_num_buffers(struct venus_inst *inst, unsigned int *num)
+static int vdec_num_buffers(struct venus_inst *inst, unsigned int *in_num,
+			    unsigned int *out_num)
 {
+	enum hfi_version ver = inst->core->res->hfi_version;
 	struct hfi_buffer_requirements bufreq;
 	int ret;
 
+	*in_num = *out_num = 0;
+
 	ret = vdec_init_session(inst);
 	if (ret)
 		return ret;
 
+	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
+	if (ret)
+		goto deinit;
+
+	*in_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+
 	ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
+	if (ret)
+		goto deinit;
 
-	*num = bufreq.count_actual;
+	*out_num = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
 
+deinit:
 	hfi_session_deinit(inst);
 
 	return ret;
@@ -626,7 +639,7 @@ static int vdec_queue_setup(struct vb2_queue *q,
 			    unsigned int sizes[], struct device *alloc_devs[])
 {
 	struct venus_inst *inst = vb2_get_drv_priv(q);
-	unsigned int p, num;
+	unsigned int p, in_num, out_num;
 	int ret = 0;
 
 	if (*num_planes) {
@@ -649,35 +662,29 @@ static int vdec_queue_setup(struct vb2_queue *q,
 		return 0;
 	}
 
+	ret = vdec_num_buffers(inst, &in_num, &out_num);
+	if (ret)
+		return ret;
+
 	switch (q->type) {
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
 		*num_planes = inst->fmt_out->num_planes;
 		sizes[0] = get_framesize_compressed(inst->out_width,
 						    inst->out_height);
 		inst->input_buf_size = sizes[0];
+		*num_buffers = max(*num_buffers, in_num);
 		inst->num_input_bufs = *num_buffers;
-
-		ret = vdec_cap_num_buffers(inst, &num);
-		if (ret)
-			break;
-
-		inst->num_output_bufs = num;
+		inst->num_output_bufs = out_num;
 		break;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 		*num_planes = inst->fmt_cap->num_planes;
 
-		ret = vdec_cap_num_buffers(inst, &num);
-		if (ret)
-			break;
-
-		*num_buffers = max(*num_buffers, num);
-
 		for (p = 0; p < *num_planes; p++)
 			sizes[p] = get_framesize_uncompressed(p, inst->width,
 							      inst->height);
-
-		inst->num_output_bufs = *num_buffers;
 		inst->output_buf_size = sizes[0];
+		*num_buffers = max(*num_buffers, out_num);
+		inst->num_output_bufs = *num_buffers;
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.14.1

