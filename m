Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0BFC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBFF25D4B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YSVc3ths"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBFF25D4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965391AbeF0Pau (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:30:50 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46853 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964826AbeF0P2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id t6-v6so2461627wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ohBxby42Vxzlh/dYlM+pRHCgvQbfNHDMttBaQvAQZWk=;
        b=YSVc3thsHvUSfV2fZ1HtSgZ8mp7jp1CQy3di0/h27v40fs2PNOG/CcCf7UXUm14Aat
         1n4lKe4Mvnoa4Go56+hiHKFN2ib2ucG26WQCPbA8s5gmcrLsjvehAgfSaH792WpcDGQC
         ss93o8ZkfphX2v5umfnmYWPa0v/bWo4GwVDW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ohBxby42Vxzlh/dYlM+pRHCgvQbfNHDMttBaQvAQZWk=;
        b=Hx6sPTcJOtg3CKA2pLVMbv3V3XuuecnxVZwWdhJVhEHMHOAKHmiZKj721mWCuMvGD7
         9zO9x2htsOKkbDHM/aoE78cebwG3+OPCTwCTvoFiVqkbFWKyMHCSaTR3YS2RPd/jG6JX
         lbAuymS4HvQffUDRcESfG1eDCBzR6dXiUtBBwwLO6I+Yu7TIL154DDZ304MlncOb0Y/U
         z6Q5ryTvFKPo6xWN2eL5k7MNUOtp/Q+ZFw7gLkNkKvxmA+mN7eeGKiATAbJGwLB3ezTY
         YrDdEvC932KpSLKwPttDq7VeaBaev6h8lt9Nv69XIO6W1c7ItEetX8nZN72R4LjpiRZv
         HpaA==
X-Gm-Message-State: APt69E2OqL+WDBEozRwTe1guMsUAkTD5bRj3tKLjRP6cgR5EHRZawgBX
        t7AX7tV+hhFJ+10h6I1UfcF7FA==
X-Google-Smtp-Source: AAOMgpcRc6Tj1qJjv6d7YPC1IAfbF0FExWDj87SfqOs7HyX++A6PByM4yNh/59VxgPBq/5xVvDUHBA==
X-Received: by 2002:adf:b69c:: with SMTP id j28-v6mr5558264wre.200.1530113302022;
        Wed, 27 Jun 2018 08:28:22 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:21 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 20/27] venus: helpers: extend set_num_bufs helper with one more argument
Date:   Wed, 27 Jun 2018 18:27:18 +0300
Message-Id: <20180627152725.9783-21-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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
index 2295cca3c22a..e332c9682b9c 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -510,7 +510,8 @@ int venus_helper_set_core_usage(struct venus_inst *inst, u32 usage)
 EXPORT_SYMBOL_GPL(venus_helper_set_core_usage);
 
 int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
-			      unsigned int output_bufs)
+			      unsigned int output_bufs,
+			      unsigned int output2_bufs)
 {
 	u32 ptype = HFI_PROPERTY_PARAM_BUFFER_COUNT_ACTUAL;
 	struct hfi_buffer_count_actual buf_count;
@@ -526,7 +527,18 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
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
index f1cf4678d013..5d8bf288bd2a 100644
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
index 4f0a5daa97e2..abde7d6d123f 100644
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

