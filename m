Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A9C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EC225857
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRDJndGe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EC225857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965237AbeF0P2Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:28:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34144 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934849AbeF0P2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:17 -0400
Received: by mail-wm0-f68.google.com with SMTP id l15-v6so18349494wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+ssufRupM9PR8pPvQwm/oq0OgQo86xh959S5/coLDU0=;
        b=FRDJndGeLO6T30aFBXt+ka12bRhUi4mBx3XxdjQDypdkW8l3fgdngkKvKySig+4QrS
         y9TwB6jrKDV2AOjjTbDMBO7ieTFQfuNpjgf4b36OI5zmwDpzEHQo9yHUVYF61ALC6r79
         ylYEP/wB/WjqFfVxxbsejhp/+8U1WkCAU6EQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+ssufRupM9PR8pPvQwm/oq0OgQo86xh959S5/coLDU0=;
        b=TxYcwQtnQbytOJ1rgc64b8GoV52KoggDGmHLOC/MBZc1F17WVi8d8ynXgWRZi7PbZE
         zzAuZHsj1y0EHgeV4DBs2BzZxnIxFh3W69DUazpGwodatdOUKrcp2vHaUqBAgfcdY3Mg
         6sdAsHi/5K9Kd8OM8ambf8XWuQjQZYb25ADmOnIRBiNz32yIDbQ+GkXW0gLsyzS5sEs8
         RjKtXTIygUo9WXQfVMoBlEkETtDY58vZPwK6RC/OVaM3S0OwfawaHQCgUy4jOwfXelWY
         AoqjGfAmGbSJLZSCGWlo2sr9DAommmbBlhI3drniGNLzA+3Q3+KEdyUO4g60FLAdDnwO
         d6JA==
X-Gm-Message-State: APt69E2gt/ZCwVsZirUMY6TrLbiPYN0X7KKShkTA957B2n+V7EpAb4/N
        uXu/4SUCEOmoJyRUBcmVhB4Q+g==
X-Google-Smtp-Source: AAOMgpdXT8LMXWsVfu7WCm7cyeJLJoZZs/CX2J32onGThKKSguh7E7U7HcrB9By5Ol59QTHglrwKZQ==
X-Received: by 2002:a1c:b590:: with SMTP id e138-v6mr2406569wmf.154.1530113296331;
        Wed, 27 Jun 2018 08:28:16 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:15 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 15/27] venus: helpers: add helper function to set actual buffer size
Date:   Wed, 27 Jun 2018 18:27:13 +0300
Message-Id: <20180627152725.9783-16-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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

