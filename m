Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3BCC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6611B2412B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7xUd24f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6611B2412B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeGENFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37867 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754503AbeGENFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id n17-v6so10744443wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M+oHvhOxeajEleWqY/pKIr12AGkun8DctwS20UTRPoc=;
        b=G7xUd24fjdUgudFXl/E7d+WwP7Gv/iBVmIZJppkl2QWAtWjvgmzBmAJ9EEOsbPmDX7
         853YvZLoxHvtWdTj7R6NS0fstwbKzrleQSAb2DH0Fhn3vsZBsn1hhliXPlWoNN4Ttyjx
         bOw6+d2U1MK8Y+DMGZraWWjD4yLXlAWRuoRNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M+oHvhOxeajEleWqY/pKIr12AGkun8DctwS20UTRPoc=;
        b=py8/x6HmVXg6tLI4I3zIF0nAaJbS5Ld8iDHHgB73G5cBo1zy/2HpMwyrCyUYJtXS00
         6PmNt1oZza7XoP8EmSH3yQ+/OJEG1vKcivuc5GrJzc7gluiVHPawsH6ThKtK6PqJdT8o
         4fXjgvaIaCRpAQ8Fr/aQ9JhyVPuha/q3vGwz+LdCQ/RCZZsAknmQOppQI4vY6EqYtLdm
         Rrt00axgVmIHTuAL9azFS/urdFs4kAZcACpT2fti78gwGdDIZD+QWAa9ldnew304cFqD
         vv9J2djsaYjx1sxPh8DDsrte4Aoj81jZT1d9TbI4div+X5ICSWzhIX1lr88hcKCYYg/M
         Etyg==
X-Gm-Message-State: APt69E1O2qgqylArMPhOTsgmuUy3HPvepkQgYEVGqjUt2LNQ+lE2unZN
        KeEycLhoqYxUkBLhVtjQ1YGolQ==
X-Google-Smtp-Source: AAOMgpcv7VOKADh56W15QlEYnwDYBUjW/eQ1FUZdoZBjCGAlZpOs3uExbNqLdZabbycG0G8SUsH9Fg==
X-Received: by 2002:a1c:818e:: with SMTP id c136-v6mr4214555wmd.107.1530795931291;
        Thu, 05 Jul 2018 06:05:31 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:30 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 22/27] venus: vdec: get required input buffers as well
Date:   Thu,  5 Jul 2018 16:03:56 +0300
Message-Id: <20180705130401.24315-23-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
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
index 3af1fb81cc32..c98084f51e5e 100644
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

