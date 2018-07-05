Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3508AC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E065E2412B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8h3Sbse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E065E2412B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754652AbeGENGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:06:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35681 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754512AbeGENFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id h40-v6so1134562wrh.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rLJrcqwr+U5qiHZwf9V1nV8FSGGmPF39OlgIgvisi0Y=;
        b=W8h3Sbseb4M64faQQYVpYCbdPFDK2sCzxH6W9HJ/1gIxHkW8YGwfAHAf8xPw3KoPwA
         SPdtQITGN7GqvSXfP5Z1YpcALRpd6Toea1eNjgAUWbELsfj1yIc3B1EtVOF9b5y3U7FT
         zFU7coTLaWYJTwNZqPbZ88O85maTjP3EZbsMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rLJrcqwr+U5qiHZwf9V1nV8FSGGmPF39OlgIgvisi0Y=;
        b=URrg5NAqupSpEqPMEwd37fIwmCupsEHv2G1rRjAPQYYeT/HPbFRcqDWl2GVOpbi0xS
         +UbqJR5cYxIgM5uNtLT35qjD7nSqkXDAOvVzjs9PySf9D2D4Bfezv39DLu+G4qD8Fd06
         cGFydPTLEPx698o/838f6HQ47Jcsa4uVNYugGWUrtEpcHsh4r+DNVCelgRe9wzTsCSDV
         0srThk5PvaK2af68X3CgsUn97m8YdeRG38u1dRnKIPly3J1Q04B2UTEj9DRvjUYKIK6j
         ENYGzEkkcydpLniOCqJGHWkwszIJ4LcBx7kA8HOjy9/TrfjGU3eQp7eFNmT4QcHlIjm0
         QIuQ==
X-Gm-Message-State: APt69E2O9QcPUv+GHLX+fc3u5gBM/NfffDAQGvZHHB30T/9IAvb4gT33
        fv63JK3YA3Z8JQcTYFnWc0MkrYMGryI=
X-Google-Smtp-Source: AAOMgpcjq+XYxugWyfSid94NXz3xq+SK/WLdOvpmzw2C74jIVg7hB9qtishjzHz6yI+uigKPNrON+g==
X-Received: by 2002:adf:9f0f:: with SMTP id l15-v6mr4654445wrf.206.1530795932574;
        Thu, 05 Jul 2018 06:05:32 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:32 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 23/27] venus: vdec: a new function for output configuration
Date:   Thu,  5 Jul 2018 16:03:57 +0300
Message-Id: <20180705130401.24315-24-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a new function vdec_output_conf() for decoder output
configuration. vdec_output_conf() will set properties via
HFI interface related to the output configuration, and
keep vdec_set_properties() which will set properties
related to decoding parameters.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/vdec.c | 34 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index c98084f51e5e..11db3074d1a5 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -545,6 +545,22 @@ static const struct v4l2_ioctl_ops vdec_ioctl_ops = {
 static int vdec_set_properties(struct venus_inst *inst)
 {
 	struct vdec_controls *ctr = &inst->controls.dec;
+	struct hfi_enable en = { .enable = 1 };
+	u32 ptype;
+	int ret;
+
+	if (ctr->post_loop_deb_mode) {
+		ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
+		ret = hfi_session_set_property(inst, ptype, &en);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int vdec_output_conf(struct venus_inst *inst)
+{
 	struct venus_core *core = inst->core;
 	struct hfi_enable en = { .enable = 1 };
 	u32 ptype;
@@ -569,14 +585,6 @@ static int vdec_set_properties(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
-	if (ctr->post_loop_deb_mode) {
-		ptype = HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER;
-		en.enable = 1;
-		ret = hfi_session_set_property(inst, ptype, &en);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
@@ -724,7 +732,6 @@ static int vdec_verify_conf(struct venus_inst *inst)
 static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct venus_inst *inst = vb2_get_drv_priv(q);
-	struct venus_core *core = inst->core;
 	int ret;
 
 	mutex_lock(&inst->lock);
@@ -753,12 +760,9 @@ static int vdec_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (ret)
 		goto deinit_sess;
 
-	if (core->res->hfi_version == HFI_VERSION_3XX) {
-		ret = venus_helper_set_bufsize(inst, inst->output_buf_size,
-					       HFI_BUFFER_OUTPUT);
-		if (ret)
-			goto deinit_sess;
-	}
+	ret = vdec_output_conf(inst);
+	if (ret)
+		goto deinit_sess;
 
 	ret = vdec_verify_conf(inst);
 	if (ret)
-- 
2.14.1

