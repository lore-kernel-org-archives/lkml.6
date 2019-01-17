Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE402C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE20520652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSQu0bn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfAQQVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:21:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39905 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbfAQQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:21:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so11687559wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SNb+6XKLjhFXr1Fd19oZUt5CC0wXzn1Vgn9kxNRJIs0=;
        b=gSQu0bn7+O02Yk6QIAPNDwgLFN9/1QiHD7Y7r9xiwfiK2A8k6xb2SBc3Ut5JWrx3Bl
         p/ZdugOLdtFScafh51vgS+65J/yoxM64/2HBwL6fmXbJBxCpWlYWKIW1V1zN8s0r/JbI
         XckqEWMvXNs6n7Zx5LE0LUDxztKeZWJ+SHmD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SNb+6XKLjhFXr1Fd19oZUt5CC0wXzn1Vgn9kxNRJIs0=;
        b=IhGIewVKNw/5tasm2yOhBbUGZbPvOq+abeyJ13QG8JlQ7XWdoIOhVakaJeffC7ekVd
         nMv93NmV+HNx2A5n/QYxgdYR44dfI18peWETopTNmSTR5EKgtZP0nrPv3kC0+rwoqjsi
         EIXbLhT4QVaXm0h8QN2ZnTaFiOs7I8TVkwUFydG9xV+UAq/sYZ+2DBiMSKXevq8T+Bub
         XFu07usibEfmxwPtHq4Dr8KrfXnGk3PPm+JLMi2jQ2bw/eoudz1dHv141XwQuWhdafHv
         ESdpcPmcwEywSQ2xIxpwrC+vMQ8gZiUUXZQbwhinc7oWT3r+XvgmCeQ6IKdgqi3GHgBl
         g98A==
X-Gm-Message-State: AJcUukeCqt5261pNVFu9+QJrLv4Ystl8jngW4t3r8XhgcO9boAL53jdC
        d+8MdehqAbozXFR+8fvrTO8pa6/3muQ=
X-Google-Smtp-Source: ALg8bN6c3MgkDBCCXVN8VWSfx/aV6b2dIEHFec7+iCMHKtfHCwFpbDorJ9CL0XkG9lb9lIeMpy93Pw==
X-Received: by 2002:adf:b6a1:: with SMTP id j33mr12641852wre.55.1547742071200;
        Thu, 17 Jan 2019 08:21:11 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id v133sm31124734wmf.19.2019.01.17.08.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:21:10 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 08/10] venus: vdec_ctrls: get real minimum buffers for capture
Date:   Thu, 17 Jan 2019 18:20:06 +0200
Message-Id: <20190117162008.25217-9-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now we returned num_output_bufs set during reqbuf but
that could be wrong when we implement stateful Codec API. So
get the minimum buffers for capture from HFI. This is supposed
to be called after stream header parsing, i.e. after dequeue
v4l2 event for change resolution.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec_ctrls.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec_ctrls.c b/drivers/media/platform/qcom/venus/vdec_ctrls.c
index f4604b0cd57e..e1da87bf52bc 100644
--- a/drivers/media/platform/qcom/venus/vdec_ctrls.c
+++ b/drivers/media/platform/qcom/venus/vdec_ctrls.c
@@ -16,6 +16,7 @@
 #include <media/v4l2-ctrls.h>
 
 #include "core.h"
+#include "helpers.h"
 #include "vdec.h"
 
 static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
@@ -47,7 +48,9 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct venus_inst *inst = ctrl_to_inst(ctrl);
 	struct vdec_controls *ctr = &inst->controls.dec;
+	struct hfi_buffer_requirements bufreq;
 	union hfi_get_property hprop;
+	enum hfi_version ver = inst->core->res->hfi_version;
 	u32 ptype = HFI_PROPERTY_PARAM_PROFILE_LEVEL_CURRENT;
 	int ret;
 
@@ -71,7 +74,9 @@ static int vdec_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
 		ctrl->val = ctr->post_loop_deb_mode;
 		break;
 	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
-		ctrl->val = inst->num_output_bufs;
+		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_OUTPUT, &bufreq);
+		if (!ret)
+			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
 		break;
 	default:
 		return -EINVAL;
-- 
2.17.1

