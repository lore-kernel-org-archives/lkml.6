Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3DCC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3D925D4B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TAAX/5OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3D925D4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934804AbeF0PbS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:31:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53551 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934932AbeF0P2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:18 -0400
Received: by mail-wm0-f68.google.com with SMTP id b188-v6so184790wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fvphImxtYi/pZ1ibjMA94jz0O9EQMA8I8Ho1rpQimyE=;
        b=TAAX/5OYls5Fb0SufmcRtV9BCLZDMhjfq6rk4sT3ISDsixoLsOlZl4RfzQg6EcsP08
         H+VIGGABSI7FjgXUwRebaY42+zFFBA4X70pVAa4zh/pJXZRcR78HjzpmX9FDLMkgCuxG
         syjXSAKCErqIe/1T+JPq4iahU/lmNXUae23gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fvphImxtYi/pZ1ibjMA94jz0O9EQMA8I8Ho1rpQimyE=;
        b=Ngcf3JplQWix9RVyr91tmb/j53OGB80gathi6UWrq5lM+rKyOWagWDYdF5Z1D+RZrL
         +KIuWvNlJoxEYrQjRZwdHHWeNzQzVfsZbEAqJuJR4tA7mVAmA6mwHBVaZZxlJE6Buu82
         VND2a4BGVc2nhZQGfiSrYIbi+DcU6X3rE0WvYQ4dyT3ovWwX0iF6RJwpAZKUp/7y99Ac
         LFLYIuH1xWrmhFPJJyXX2iLA8g03zPbIb2yXHnTDR9RNDtSnQK8BlMJxstV+/Sdzrz5h
         qxnHh0dbY69BpwgVxeNexJjofwHHrJ3XTYnwvutXtuZ2bQcGVGnM5DbxBph7D5t275vO
         kM5g==
X-Gm-Message-State: APt69E1QjlwENUvwotipu/xQ4/9mOTppHHAY1pPXqfKeIs4KEagTRdqh
        YnoM9i1sRCTF6Bqi2ETKrNx9xA==
X-Google-Smtp-Source: AAOMgpdiifAPMQYnIdSpp5w3qdh4/flUv7VeQJzYyxXngUs/bl6vZUBhqJAkywvXd5rqc5DMmWB98g==
X-Received: by 2002:a1c:78b:: with SMTP id 133-v6mr5669838wmh.59.1530113297475;
        Wed, 27 Jun 2018 08:28:17 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:16 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 16/27] venus: core: delete not used buffer mode flags
Date:   Wed, 27 Jun 2018 18:27:14 +0300
Message-Id: <20180627152725.9783-17-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete not used flag for capture buffer allocation mode and
no longer used cap_bufs_mode_dynamic from instance structure.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/core.h       |  4 ----
 drivers/media/platform/qcom/venus/hfi_parser.c | 11 +++--------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index b995d1601c87..1d1a59a5d343 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -255,8 +255,6 @@ struct venus_buffer {
  * @priv:	a private for HFI operations callbacks
  * @session_type:	the type of the session (decoder or encoder)
  * @hprop:	a union used as a holder by get property
- * @cap_bufs_mode_static:	buffers allocation mode capability
- * @cap_bufs_mode_dynamic:	buffers allocation mode capability
  */
 struct venus_inst {
 	struct list_head list;
@@ -305,8 +303,6 @@ struct venus_inst {
 	const struct hfi_inst_ops *ops;
 	u32 session_type;
 	union hfi_get_property hprop;
-	bool cap_bufs_mode_static;
-	bool cap_bufs_mode_dynamic;
 };
 
 #define IS_V1(core)	((core)->res->hfi_version == HFI_VERSION_1XX)
diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
index 8d284cfbba7a..5f1aedc0ef5a 100644
--- a/drivers/media/platform/qcom/venus/hfi_parser.c
+++ b/drivers/media/platform/qcom/venus/hfi_parser.c
@@ -60,8 +60,7 @@ fill_buf_mode(struct venus_caps *cap, const void *data, unsigned int num)
 }
 
 static void
-parse_alloc_mode(struct venus_core *core, struct venus_inst *inst, u32 codecs,
-		 u32 domain, void *data)
+parse_alloc_mode(struct venus_core *core, u32 codecs, u32 domain, void *data)
 {
 	struct hfi_buffer_alloc_mode_supported *mode = data;
 	u32 num_entries = mode->num_entries;
@@ -74,13 +73,9 @@ parse_alloc_mode(struct venus_core *core, struct venus_inst *inst, u32 codecs,
 
 	while (num_entries--) {
 		if (mode->buffer_type == HFI_BUFFER_OUTPUT ||
-		    mode->buffer_type == HFI_BUFFER_OUTPUT2) {
-			if (*type == HFI_BUFFER_MODE_DYNAMIC && inst)
-				inst->cap_bufs_mode_dynamic = true;
-
+		    mode->buffer_type == HFI_BUFFER_OUTPUT2)
 			for_each_codec(core->caps, ARRAY_SIZE(core->caps),
 				       codecs, domain, fill_buf_mode, type, 1);
-		}
 
 		type++;
 	}
@@ -267,7 +262,7 @@ u32 hfi_parser(struct venus_core *core, struct venus_inst *inst,
 			parse_profile_level(core, codecs, domain, data);
 			break;
 		case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE_SUPPORTED:
-			parse_alloc_mode(core, inst, codecs, domain, data);
+			parse_alloc_mode(core, codecs, domain, data);
 			break;
 		default:
 			break;
-- 
2.14.1

