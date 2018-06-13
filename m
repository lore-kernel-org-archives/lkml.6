Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CB356C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8177620660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bc6Vc+K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8177620660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935714AbeFMPLc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:11:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38550 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936022AbeFMPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so6094589wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nhKxdCOw37kKVgSprpQsFMGs84elFtpX09ZZT6Wn24=;
        b=bc6Vc+K7NDABYOCuuC83CwKHPsRdm0cY2lubJEApqZ+FlP8y/peI/zqnmZfbumzopI
         zPjEr5wMsZX+ujKbvJB81zM+e5xfLvpLxYtcG1ItT+Xhks7RAfacxUft5bVadL1IccW4
         P3Ii0F7YINxGg3IGc+3kc0dwY5oQBI23spfhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nhKxdCOw37kKVgSprpQsFMGs84elFtpX09ZZT6Wn24=;
        b=E8y3Zm9SRkk0FnhyUfDDPvw6wQDKWXerIT9EsYvdgX6BTud1en5GuwRcnJcw1VmSEk
         hZPcawofG1RHhcN2Z9g27RUBjFk/ZLlmO7KQDbQchUMXOgOeST9WRvVcQQee44DAbGkT
         UpWyx/4ucjAGxQn709Fr7hVyS0v8ptD6UJOCGGriRUFKGvIYZlLSMN4CKmYd9GY7aUxE
         SPHk3VAOxOb615bbvcknaRh9mkvO+wiOTcojDPLXY8LOozPjXnsRqrXPmGCtGOcf2j6K
         yZOw7Sqr0n6Ctj1suQrjfT/P6KCuBo4AlBfpE+2OxdapJ2YH2e6p/rIOyyea3uswKKRP
         xtKg==
X-Gm-Message-State: APt69E2sbEcXTB9G8stcMuVSOgZW16gPpiWWfMUaba6qPjPGlGbtQNtL
        jKoSk4ddnkA7A2npT6I7zV+hdw==
X-Google-Smtp-Source: ADUXVKKzd2ai8byj/JTRuOzmVILFovEoovDpYvYztVdLykba8yqElVbX/CyjUZ1Q0F7ZAaat8Fn1tA==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73-v6mr3633958wme.141.1528902579372;
        Wed, 13 Jun 2018 08:09:39 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:38 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 23/27] venus: vdec: a new function for output configuration
Date:   Wed, 13 Jun 2018 18:07:57 +0300
Message-Id: <20180613150801.11702-24-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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
index 55213a8d55a3..4d3f1cd7ed1d 100644
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

