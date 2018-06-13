Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 68C39C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEC7208C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAvcH6mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEC7208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964864AbeFMPJi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:09:38 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38314 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936020AbeFMPJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id e18-v6so3154166wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ssufRupM9PR8pPvQwm/oq0OgQo86xh959S5/coLDU0=;
        b=HAvcH6mT/lQ1wclNDe8VS5pd8ZPeAO+ONYeGGJw3nArgNCX1nyd/vsR4nbLvDyj3ww
         Ffm2reqWvkQK8RVDPYEe1EjarTCCw0I9s3VyRbKQP/d/f1jlou+7bUBzOLMfNcyIAqwT
         zvL13Op5aT18qk0+FSQjjOSbAA1xItbxrEOHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ssufRupM9PR8pPvQwm/oq0OgQo86xh959S5/coLDU0=;
        b=hEzioAOsNLYizKKYNAQpAdHhSfmOZH0HOYE0JHnurqUfj7ZUCvBrc9prYeKbzaYeF0
         aHhOXDZsYhmfERH3e5NIMm6O4Eyd5mGmXW9xp/qVUg5wWdJHjLZThFDt93m1PKH1O4bV
         Q8mnz69nNdsclAl9m/onLc2Q5lokyIr+SYwUzsV7LqArtZY0+mXHtOg3cQHtsvCgQzhG
         ocsagyAAQa+m2lLkzfRAK3jZK8MN4I53rFZvz1DNqK5+glZ0ETOwl7VddC2dfFUyuuap
         BYAD6aVyWNB8cgkiaqqewKQMZ78CbGEL81aNHy/JIYDxJNtMteOVArR8OXyWnjH3Szh7
         OuLg==
X-Gm-Message-State: APt69E0B14ESnuWz8gtxF6WPmxRn8cOQvpFx4Cr+ER5/Ap/8DGHLFNMH
        D9ReebSoLWSeHa3BIg5BtWCr2g==
X-Google-Smtp-Source: ADUXVKK1OCaNJt/TIM+qIPO1Xsx4zt3B755zUxkpUij0t0DQ2Dzobr9nDqx2ebA2a391Id/c3wQjSQ==
X-Received: by 2002:adf:ac37:: with SMTP id v52-v6mr4684099wrc.56.1528902569996;
        Wed, 13 Jun 2018 08:09:29 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:29 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 15/27] venus: helpers: add helper function to set actual buffer size
Date:   Wed, 13 Jun 2018 18:07:49 +0300
Message-Id: <20180613150801.11702-16-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and use a helper function to set actual buffer size for
particular buffer type. This is also preparation to use
the second decoder output.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 12 ++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 drivers/media/platform/qcom/venus/vdec.c    | 10 ++--------
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index e3dc2772946f..0cce664f093d 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -541,6 +541,18 @@ int venus_helper_set_dyn_bufmode(struct venus_inst *inst)
 }
 EXPORT_SYMBOL_GPL(venus_helper_set_dyn_bufmode);
 
+int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype)
+{
+	u32 ptype = HFI_PROPERTY_PARAM_BUFFER_SIZE_ACTUAL;
+	struct hfi_buffer_size_actual bufsz;
+
+	bufsz.type = buftype;
+	bufsz.size = bufsize;
+
+	return hfi_session_set_property(inst, ptype, &bufsz);
+}
+EXPORT_SYMBOL_GPL(venus_helper_set_bufsize);
+
 static void delayed_process_buf_func(struct work_struct *work)
 {
 	struct venus_buffer *buf, *n;
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 52b961ed491e..cd306bd8978f 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -41,6 +41,7 @@ int venus_helper_set_num_bufs(struct venus_inst *inst, unsigned int input_bufs,
 			      unsigned int output_bufs);
 int venus_helper_set_color_format(struct venus_inst *inst, u32 fmt);
 int venus_helper_set_dyn_bufmode(struct venus_inst *inst);
+int venus_helper_set_bufsize(struct venus_inst *inst, u32 bufsize, u32 buftype);
 void venus_helper_acquire_buf_ref(struct vb2_v4l2_buffer *vbuf);
 void venus_helper_release_buf_ref(struct venus_inst *inst, unsigned int idx);
 void venus_helper_init_instance(struct venus_inst *inst);
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 92669a358a90..eae9c651ac91 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -710,7 +710,6 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(q);
 	struct venus_core *core = inst->core;
-	u32 ptype;
 	int ret;
 
 	mutex_lock(&inst->lock);
@@ -740,13 +739,8 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 		goto deinit_sess;
 
 	if (core->res->hfi_version == HFI_VERSION_3XX) {
-		struct hfi_buffer_size_actual buf_sz;
-
-		ptype = HFI_PROPERTY_PARAM_BUFFER_SIZE_ACTUAL;
-		buf_sz.type = HFI_BUFFER_OUTPUT;
-		buf_sz.size = inst->output_buf_size;
-
-		ret = hfi_session_set_property(inst, ptype, &buf_sz);
+		ret = venus_helper_set_bufsize(inst, inst->output_buf_size,
+					       HFI_BUFFER_OUTPUT);
 		if (ret)
 			goto deinit_sess;
 	}
-- 
2.14.1

