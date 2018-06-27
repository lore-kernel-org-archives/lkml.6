Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93179C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BBBF25DA1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="andpg2ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BBBF25DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934727AbeF0PbP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:31:15 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54800 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934930AbeF0P2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:19 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so6279016wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87ORcY69pnhjHzwy3ZGqBtyUOPwoa/Ckei7U+5Elc6I=;
        b=andpg2ad2iFhNWB44+bfKQse24Kk/JcZ+mbt6rhd9QGMhSsAsy1chcJr+Qwnetg6xL
         AKibdFkUg0zDI1Ofsr7bnJh5VgK4f229EpD02kGw35F/qV56nUxGM4YjiBKwFI87Q8jm
         zP0xVzU/IL3g00XO2sPc2Gc/2GCRRZJlVoWD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87ORcY69pnhjHzwy3ZGqBtyUOPwoa/Ckei7U+5Elc6I=;
        b=I7iuG33hyQ7FjwdqjsUalfcKL4Q6nOOIvA8F9PfQuKL8gdq6EiXNG2aNyECsmXjClX
         C9DHe80wiYjMKgZYgiKfHDkpQffx2fsQvT/QqhSw22uiCNcsGNkjDumheRPuhQnyiaNT
         wPgrMGu++eFk+N/Wc+ghbJtVy9cIv4wJOecycFT3rbltbBb3O+ms8dUIEQmWN9qUI3g9
         EQJvbonUtysrjnSDaI1d88w5i+zHiw1sOeDHKS/w61ZTTmay/Et2AD3XZWEZyi18xjAT
         LqMUpUfllIXOd1xEQQjlcny6p1w87LJm6QATeIcRWByQ0+ewv4rt9Ll5KRvm+FLrst2D
         VEmw==
X-Gm-Message-State: APt69E3LD0SdFWGeaOC2+kBr4vKBu2KzRcnEJViADfIeDKAaQTchDYgJ
        hPerOSM/wc4AZ88/V9IyBLfRbtTRd3k=
X-Google-Smtp-Source: AAOMgpfkBorMtPvZILNlnryy/qo7DBEes98IdoS3j6eDgBl5j7zx52UDYjrX0OP9TRRAVPkKWPF4KQ==
X-Received: by 2002:a1c:6b51:: with SMTP id g78-v6mr5570668wmc.149.1530113298609;
        Wed, 27 Jun 2018 08:28:18 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:18 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 17/27] venus: helpers: add buffer type argument to a helper
Date:   Wed, 27 Jun 2018 18:27:15 +0300
Message-Id: <20180627152725.9783-18-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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
index 0cce664f093d..2eeb243e4dbe 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -453,12 +453,13 @@ int venus_helper_set_input_resolution(struct venus_inst *inst,
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
index aa6b0026d79d..1d7f87e0f5b3 100644
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

