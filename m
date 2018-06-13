Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3168EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDF420891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYahaee9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDF420891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936052AbeFMPPM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:15:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37072 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936009AbeFMPJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id d8-v6so3153355wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uzFPQjolv+jdPi2Rzia1jtwxKrkKgXp+JYTymg81g5w=;
        b=WYahaee9FKtN9RHnrOnFKlknZvB2h0rYgwo/5nedys4o7g2YZYgQRAdBQ2GhGH/712
         JsC0sFJRZLEZM+P8FYfehiho8g9UjKvTg3m1t8NoMTie3nZ5Kz2U+bpbPBW2U3FNpQ6o
         Z0PSeSnIQKuROVwvjRr07jbLFfEibnFT3BXNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uzFPQjolv+jdPi2Rzia1jtwxKrkKgXp+JYTymg81g5w=;
        b=nw+6K+nIMalGcb1dQKS6sqktV2gAIdu8HL+KcDDLQKodqk6vlTP4Q/9vlEoh43UqYS
         BhCgkjOVTO7rA8iVRGRaUeI4aM5/wtB1qmoaR4DZnh/2QcJOqxDD0kOwA3xywmObzuip
         OeGSV0hTaDKvE0zmJn8DCc0+vd1zBojFA9Jw1gqxEg0272jH4TrJPD/hpigKwUgnGaxh
         FSpKpG6NiUsN/QwCxKoadLPAvw5PhUI3d3rKKvFwI6L20PTmpiw1kwrGRArJD9r4XwKV
         ctWQSf484Gpvtp/fqPk0yqjQT+rWDSqDKA8NIxJzlXbAnL7DblcK0NOBfMabFswPYCaV
         UNaw==
X-Gm-Message-State: APt69E3Fk/qA/4V1nPhZx0qhq5GEBapZaxzwBVeYIqNNjY+OjcNzwVmg
        klXcDnMXEsz+AJKTBGdIJMSdTg==
X-Google-Smtp-Source: ADUXVKKa1wPmXKRJn8Og7rxfv3cjsYleDMUwSgyqd3uxIfVz6xUFV8lCO8n4fTiQsDDsQ86klwwO8g==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr4284919wre.268.1528902560453;
        Wed, 13 Jun 2018 08:09:20 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:20 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 10/27] venus: hfi_venus: add suspend functionality for Venus 4xx
Date:   Wed, 13 Jun 2018 18:07:44 +0300
Message-Id: <20180613150801.11702-11-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds suspend (power collapse) functionality by reusing
the suspend function for Venus 3xx and also enables idle indicator
property for Venus 4xx (where it is disabled by default).

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi_venus.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index 7a83e967a8ea..9366dae16b0a 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -879,6 +879,14 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
 	if (ret)
 		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
 
+	/*
+	 * Idle indicator is disabled by default on some 4xx firmware versions,
+	 * enable it explicitly in order to make suspend functional by checking
+	 * WFI (wait-for-interrupt) bit.
+	 */
+	if (IS_V4(hdev->core))
+		venus_sys_idle_indicator = true;
+
 	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
 	if (ret)
 		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
@@ -1533,7 +1541,8 @@ static int venus_suspend_3xx(struct venus_core *core)
 
 static int venus_suspend(struct venus_core *core)
 {
-	if (core->res->hfi_version == HFI_VERSION_3XX)
+	if (core->res->hfi_version == HFI_VERSION_3XX ||
+	    core->res->hfi_version == HFI_VERSION_4XX)
 		return venus_suspend_3xx(core);
 
 	return venus_suspend_1xx(core);
-- 
2.14.1

