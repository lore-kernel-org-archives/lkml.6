Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A7834C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4B20660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VLaWf1fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF4B20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936134AbeFMPLs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:11:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40317 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936020AbeFMPJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id n5-v6so6069027wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KGtopIdccvCWqxzw2Y/ssJlKU0JmcRx1SeA6otkSH9k=;
        b=VLaWf1fY9HIjzDFPTtNjqGiIPhWbh5+bvSYbDHF9zFah94z277RF6En+CBGFOmG7Ug
         WattPOxTOpRnYixcIgz+cYlxehw0InIYlAEjavYTMl/ofmyTqFEsZ7bJKx1YrzK1iVOr
         nuqqCCBn5aCWGOmVpBczGq2Ct+TLf5NSY9msw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KGtopIdccvCWqxzw2Y/ssJlKU0JmcRx1SeA6otkSH9k=;
        b=Sm8eQmbKzJHXzyEy3fPspij4S0kF+pGlcPik4mFoqoq3fm52eOriGV2QxuYfScl1Ie
         /1NqI0qUHkJX+8+J09bWnqPqlLdxRCpbaIxrMgbeIW6eWdVG1WdTJ/bQah0caZnmeqAA
         pVjXXiHdVE5s+zrq9Hyv5Sv1byHLnO5n3fNoH3307/dlGIn70KH+YLm+ClV+NtmVToY7
         vmRHAS9hsiehX0XhcCwIvo0z5XC73AT4mK3TUVjlfkjl+Jyr63E67sJYGZvf3UeYWOpS
         tVQlBvnz202YEBf7WRAVlpw3s6YDw84aTCFQjNqtFClC9mH4Ig787SUA7q1YN5/W10en
         JIYw==
X-Gm-Message-State: APt69E1MScHKtNKtsr5dm+GmlPEB3rnpaL2FvzISp9j1+SVfdOxe35lJ
        YgDgxxpHWXH+Fq7/+4K8CUV/Qg==
X-Google-Smtp-Source: ADUXVKIXqe4qwNX3n81tILVYH2Pb/dlBB1EVjBYhUVIvAAETkuKSSZtgosQqgs7r7dUmHMuXFjm9Rg==
X-Received: by 2002:a1c:6d85:: with SMTP id b5-v6mr3558349wmi.135.1528902578264;
        Wed, 13 Jun 2018 08:09:38 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:37 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 22/27] venus: vdec: get required input buffers as well
Date:   Wed, 13 Jun 2018 18:07:56 +0300
Message-Id: <20180613150801.11702-23-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

