Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73C0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939A424090
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ALkgydW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939A424090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754570AbeGENHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:07:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53205 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754450AbeGENFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id w16-v6so10970211wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VamVn5fSKrK4jIDm67aUg+jNMsWMI46PpJA4aHsLT5c=;
        b=ALkgydW9wsSzJuQFxkwBrZrmo5SRODbIFWkta67CEBZlOeDDHcqkUu2Flg2aoO2tI6
         rz9Y3VO8tMo4s1qW/fB8Dvctgu4TbDIBD9hb1FwK/b/3a+OSOL930kz6JgaIg3xzOCP6
         8tLN5zZLMzQgoWSERoZSmVIBGe/erThRa5sbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VamVn5fSKrK4jIDm67aUg+jNMsWMI46PpJA4aHsLT5c=;
        b=cdUv7M7A5p+Rf+l7UbWeI53ocWWQYbl4+Jh++P605Pp6wRt1rqaKUzWvUU/UMaiS94
         +br0b3YpFEzILjK/ZSpf5IUfkoYnrcY8IL8QtF0tAg5oEkPymlsIa8sDUuAnP54x4aX8
         HZJeiUlr/Lb8P4wAvs4AIHk+vo0oU0iLtV1DhEC+nntm/p5+tu4abnuntSTkzSjU7z2C
         z71SSXSN7D+xdUmyohJ21oOch5244aswfc4MXihl6um0FGfSN9ZUphjZ95okpU5jL4AB
         oTIdDICzAG6nH8b8KFiGS8MjnPlGkgaMulLWmmZgdwiwl5Ez0CcLlroR/GMsPCWE8b2K
         G9IQ==
X-Gm-Message-State: APt69E1iD3qsrNybvZqfCUicjGqcG+9L40aexOJuoLKWtq3Pke8Kmv3o
        wg0/HqZ29l2zVYXJEGwchio/uQ==
X-Google-Smtp-Source: AAOMgpcJSVMe4EMW0MmgDyr/w93D3Th1ppT74U8WJcJDDZFIfFqvBuXms/l9aXupijdZV9VYc6ey4A==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr4394798wre.268.1530795930265;
        Thu, 05 Jul 2018 06:05:30 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:29 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 21/27] venus: helpers: add a helper to return opb buffer sizes
Date:   Thu,  5 Jul 2018 16:03:55 +0300
Message-Id: <20180705130401.24315-22-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
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
index 13f0bc4e5ffa..8d2f4db52e48 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -613,6 +613,21 @@ int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype)
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

