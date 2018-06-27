Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5C2C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B37425CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAu+UGG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B37425CF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965193AbeF0Pes (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:34:48 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37090 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932147AbeF0P2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id k6-v6so2478469wrp.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iP3OBq3KmmkdIHc4ClU6RmJI5t+xyWo9eNZ9y9WZFKg=;
        b=QAu+UGG+Kzcc915ZKNuhrLTocXs6qRLejPoTmNT4GfKzpIVQsDzz+OSgbT8adIPHfR
         igWEQyoHFwGXQR3MlIqMJHbmVIpfmS9WwFCYVB5NgfcPVS3/HBkDf82rKpuXxIhQ52UV
         j23TB05DJiq12ksZxvIckvxaSqLIVHamCZISw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iP3OBq3KmmkdIHc4ClU6RmJI5t+xyWo9eNZ9y9WZFKg=;
        b=LV3bTD9v7FiazKn+Vs2EkHXUDcQvZkkK+loxuxHAP/SlSoTeB667O41GHOtQ+w4NxY
         spN0Q9fGNhEd0WtcVPfVwJKGHDYTboaPMnfjkauFx36B5Mr+N1zaIq6Iy3XuGQxP/J/T
         zogMQGkkRUwXtDH8NSdI38x6falt3FfMF+dplELdZ1RcOQzJxXmYpKkvER5f8eDlrmnK
         coxaa1tPv73MvAusj3FUJ7KKIj0bk4UGNRTmg2ORPcqlnG8bQGI6hxquZTrbb7NZaQHJ
         Wx0XVbmoSVEROc3Y3fYREakThm/QDjk45KrhgMiku31MzNSjYnxRuIVr0dsC8ZoNS0ef
         55Ow==
X-Gm-Message-State: APt69E0I8N2Y3XlspYEXAodQSn0QmZjVba0O4WtaqG0196ov/g7PxHcE
        HPAIdFMmvx+V0BxfzYaQQl2ZSA==
X-Google-Smtp-Source: AAOMgpdDErl4TQ/cqKTZ/vru9EFick5+8i61YxWNnDuvRDGWcawn++VyyMY5Nf7PjZPZBxsiD6YIIA==
X-Received: by 2002:adf:e881:: with SMTP id d1-v6mr2407375wrm.43.1530113288238;
        Wed, 27 Jun 2018 08:28:08 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:07 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 09/27] venus: hfi_venus: move set of default properties to core init
Date:   Wed, 27 Jun 2018 18:27:07 +0300
Message-Id: <20180627152725.9783-10-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves setting of default properties (firmware debug, idle
indicator and low power mode) from session init to core init.
All of those properties are need to be enabled/disabled early
so that they could be used before the clients are even initialized.

The other reason is to set idle indicator property early before
we enter into venus_suspend function where we need to check for
ARM9 WFI.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 72a8547eab39..7a83e967a8ea 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -1091,6 +1091,10 @@ static int venus_core_init(struct venus_core *core)
 	if (ret)
 		dev_warn(dev, "failed to send image version pkt to fw\n");
 
+	ret = venus_sys_set_default_properties(hdev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1135,10 +1139,6 @@ static int venus_session_init(struct venus_inst *inst, u32 session_type,
 	struct hfi_session_init_pkt pkt;
 	int ret;
 
-	ret = venus_sys_set_default_properties(hdev);
-	if (ret)
-		return ret;
-
 	ret = pkt_session_init(&pkt, inst, session_type, codec);
 	if (ret)
 		goto err;
-- 
2.14.1

