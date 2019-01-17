Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AD220652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpaoJNuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbfAQQVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:21:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52217 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbfAQQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:21:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so1699609wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rqq2iTJQ0mjQYAqKv+ITvoSKpjYT4Sn2iEPmLEqQ1y8=;
        b=fpaoJNuEYdX6Q0gc/SsxQ6igfVQvhHken4mff/K5Ft8HGQFDwRbdfnWWzHgsruKouG
         ElA8aeaDwJxzOvfvsBw7co33LD4k2mu/57A348xKulDYFWcUCYFJFdqtfNFV4FDh4kbp
         Jh+QuhbhdI3mohfZsg01luVG6YLvIpqntHI4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rqq2iTJQ0mjQYAqKv+ITvoSKpjYT4Sn2iEPmLEqQ1y8=;
        b=t2v/VQuRsySnH8LEqzW0UtYh7QOG3SVe84Tfq7tOBcjzp8uTdjGECehiuvolqb0G2O
         w9vctuY9qqhkDxb6jf/mXQsR2qOhzxo5teD+n+6irzWqfBW9uRNBsCEeXsln9N6hKwIv
         W6mdG3lnwIqAJHg3bNsKPqb26ErtRQYTNRm0NqqkOkb+JBho9BKByi1LuGSZ6ssHpvvH
         sjs4fdvOkunG/wDgMhx28yQjORdr5IxISY7vh8le5qzl3C7sSpZGIaU+outkgb73HTRn
         Z0FJEu21bmL26GWHAqP3XgEFqbzHP7iH8Z/HyfwTPVrcO/0bl0jOK1a7GnsvzLGHfBOO
         eCAg==
X-Gm-Message-State: AJcUukfi4+xOmiWd3Ht28AVeL8JxdJC5kBkhTPnb43IjZKMkeALBRsYn
        gDBR16gEQA+OA9DBKmN2Jn940u9rxiM=
X-Google-Smtp-Source: ALg8bN7xvAkAJi1gjrI0bZe6wktPlIqpO6zPH6KZB6Hlib92/mnsUjtrAWgLFy68Ge5lu8ix08AFkg==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr12264913wmg.55.1547742069669;
        Thu, 17 Jan 2019 08:21:09 -0800 (PST)
Received: from localhost.localdomain ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id v133sm31124734wmf.19.2019.01.17.08.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:21:09 -0800 (PST)
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
Subject: [PATCH 07/10] venus: helpers: add three more helper functions
Date:   Thu, 17 Jan 2019 18:20:05 +0200
Message-Id: <20190117162008.25217-8-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds three more helper functions:
 * for internal buffers reallocation, applicable when we are doing
dynamic resolution change
 * for initial buffer processing of capture and output queue buffer
types

All of them will be needed for stateful Codec API support.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 82 +++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  2 +
 2 files changed, 84 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index f33bbfea3576..637ce7b82d94 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -322,6 +322,52 @@ int venus_helper_intbufs_free(struct venus_inst *inst)
 }
 EXPORT_SYMBOL_GPL(venus_helper_intbufs_free);
 
+int venus_helper_intbufs_realloc(struct venus_inst *inst)
+{
+	enum hfi_version ver = inst->core->res->hfi_version;
+	struct hfi_buffer_desc bd;
+	struct intbuf *buf, *n;
+	int ret;
+
+	list_for_each_entry_safe(buf, n, &inst->internalbufs, list) {
+		if (buf->type == HFI_BUFFER_INTERNAL_PERSIST ||
+		    buf->type == HFI_BUFFER_INTERNAL_PERSIST_1)
+			continue;
+
+		memset(&bd, 0, sizeof(bd));
+		bd.buffer_size = buf->size;
+		bd.buffer_type = buf->type;
+		bd.num_buffers = 1;
+		bd.device_addr = buf->da;
+		bd.response_required = true;
+
+		ret = hfi_session_unset_buffers(inst, &bd);
+
+		dma_free_attrs(inst->core->dev, buf->size, buf->va, buf->da,
+			       buf->attrs);
+
+		list_del_init(&buf->list);
+		kfree(buf);
+	}
+
+	ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH(ver));
+	if (ret)
+		goto err;
+
+	ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH_1(ver));
+	if (ret)
+		goto err;
+
+	ret = intbufs_set_buffer(inst, HFI_BUFFER_INTERNAL_SCRATCH_2(ver));
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(venus_helper_intbufs_realloc);
+
 static u32 load_per_instance(struct venus_inst *inst)
 {
 	u32 mbs;
@@ -1050,6 +1096,42 @@ void venus_helper_vb2_stop_streaming(struct vb2_queue *q)
 }
 EXPORT_SYMBOL_GPL(venus_helper_vb2_stop_streaming);
 
+int venus_helper_process_initial_cap_bufs(struct venus_inst *inst)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
+	struct v4l2_m2m_buffer *buf, *n;
+	int ret;
+
+	v4l2_m2m_for_each_dst_buf_safe(m2m_ctx, buf, n) {
+		ret = session_process_buf(inst, &buf->vb);
+		if (ret) {
+			return_buf_error(inst, &buf->vb);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(venus_helper_process_initial_cap_bufs);
+
+int venus_helper_process_initial_out_bufs(struct venus_inst *inst)
+{
+	struct v4l2_m2m_ctx *m2m_ctx = inst->m2m_ctx;
+	struct v4l2_m2m_buffer *buf, *n;
+	int ret;
+
+	v4l2_m2m_for_each_src_buf_safe(m2m_ctx, buf, n) {
+		ret = session_process_buf(inst, &buf->vb);
+		if (ret) {
+			return_buf_error(inst, &buf->vb);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(venus_helper_process_initial_out_bufs);
+
 int venus_helper_vb2_start_streaming(struct venus_inst *inst)
 {
 	struct venus_core *core = inst->core;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 24faae5abd93..2ec1c1a8b416 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -69,4 +69,6 @@ int venus_helper_intbufs_realloc(struct venus_inst *inst);
 int venus_helper_queue_dpb_bufs(struct venus_inst *inst);
 int venus_helper_unregister_bufs(struct venus_inst *inst);
 int venus_helper_load_scale_clocks(struct venus_core *core);
+int venus_helper_process_initial_cap_bufs(struct venus_inst *inst);
+int venus_helper_process_initial_out_bufs(struct venus_inst *inst);
 #endif
-- 
2.17.1

