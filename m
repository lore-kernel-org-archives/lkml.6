Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 48223C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C5020891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JEVvuOBU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C5020891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936078AbeFMPO3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:14:29 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35537 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936033AbeFMPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:26 -0400
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so3164339wrn.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tpg/OEO6kmuXcfyGgT7M54n6/6j/1UYfIVpGWyjDnSc=;
        b=JEVvuOBUkZR9I2+mI1l9O8R3pWwYyfNE7mSdJu+Qt91VTiaSrBCuUBUzicavGUSCaA
         NPf5Wlz4Sf11zw2wJhrgqwhpcmUYyMxwpKY4eIPIVyffB7+WEGCowY7KOK75KIfMX3hx
         g40eJ4kY++PTpv5Q1P2M3nAsyKI1k6SdOUDSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tpg/OEO6kmuXcfyGgT7M54n6/6j/1UYfIVpGWyjDnSc=;
        b=Z/av8INt8La/03i0oEoZ66PJAML+7WmDZVTR4YUba6L8vYpbAZRS6L9WuRwn5uVhfp
         ZwV8n824O0Ut/BeeWr6lF69Gm1Bsese8fTocKskUy6mK7v28o+tu/rJYS6yevr8xuJgH
         uXx9ohX6pt66L24ThcUsUai7cFZP5DUr/fzFSJ/ilLQbCa0ptcadDspfNi15VH91p1GQ
         t2lJZOV2PCZeKqoq7QRhZtJf6VkcYLaanbBdGxj7J+2+wLscC5IqfwsFBpYttmKSW5CL
         ut7PfrcNcrgjLT5WLMTyVCyqofolsSymplbeSaHCgRnxq9B3bWuSAZkg+quNWGuGA9a2
         qq5Q==
X-Gm-Message-State: APt69E3FklapicE9kshlVQqGzYU0Mu8DR2233Rg/XPJ2dIp9w/ER4QEn
        vYT8eUk9yh8pe5WMjq2B4rEnnw==
X-Google-Smtp-Source: ADUXVKLePS/8QIww1uO9EY6IEArv7xQO3TGj5cieksVY7MqFePbSuGk6GRpQVN70c1K73QJYD/1TjA==
X-Received: by 2002:adf:91e5:: with SMTP id 92-v6mr4548396wri.124.1528902565457;
        Wed, 13 Jun 2018 08:09:25 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:24 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 13/27] venus: helpers: rename a helper function and use buffer mode from caps
Date:   Wed, 13 Jun 2018 18:07:47 +0300
Message-Id: <20180613150801.11702-14-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename is_reg_unreg_needed() to better name is_dynamic_bufmode() and
use buffer mode from enumerated per codec capabilities.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 228084e72fb7..03121dbb4175 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -354,18 +354,16 @@ session_process_buf(struct venus_inst *inst, struct vb2_v4l2_buffer *vbuf)
 	return 0;
 }
 
-static inline int is_reg_unreg_needed(struct venus_inst *inst)
+static bool is_dynamic_bufmode(struct venus_inst *inst)
 {
-	if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
-	    inst->core->res->hfi_version == HFI_VERSION_3XX)
-		return 0;
+	struct venus_core *core = inst->core;
+	struct venus_caps *caps;
 
-	if (inst->session_type == VIDC_SESSION_TYPE_DEC &&
-	    inst->cap_bufs_mode_dynamic &&
-	    inst->core->res->hfi_version == HFI_VERSION_1XX)
+	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
+	if (!caps)
 		return 0;
 
-	return 1;
+	return caps->cap_bufs_mode_dynamic;
 }
 
 static int session_unregister_bufs(struct venus_inst *inst)
@@ -374,7 +372,7 @@ static int session_unregister_bufs(struct venus_inst *inst)
 	struct hfi_buffer_desc bd;
 	int ret = 0;
 
-	if (!is_reg_unreg_needed(inst))
+	if (is_dynamic_bufmode(inst))
 		return 0;
 
 	list_for_each_entry_safe(buf, n, &inst->registeredbufs, reg_list) {
@@ -394,7 +392,7 @@ static int session_register_bufs(struct venus_inst *inst)
 	struct venus_buffer *buf;
 	int ret = 0;
 
-	if (!is_reg_unreg_needed(inst))
+	if (is_dynamic_bufmode(inst))
 		return 0;
 
 	list_for_each_entry(buf, &inst->registeredbufs, reg_list) {
-- 
2.14.1

