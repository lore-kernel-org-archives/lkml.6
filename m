Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D05CC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035BE208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZSQqhk5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035BE208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936094AbeFMPPO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:15:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51516 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935999AbeFMPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so5359959wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iP3OBq3KmmkdIHc4ClU6RmJI5t+xyWo9eNZ9y9WZFKg=;
        b=IZSQqhk5croRiez/q3h2TX1sKS+RYjVRd8n/uuYbuYWdX44k/XyiddD+uigw30icW3
         rpD5FW+0IKVZJvgygJQKkM3x314H6elaik0Yb3v6v24eDC/kfZ8AnnxKcvdWc616E8qr
         mbmLf6NraRqLm/Lk9O7hGJvsKQawAFgJfmyhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iP3OBq3KmmkdIHc4ClU6RmJI5t+xyWo9eNZ9y9WZFKg=;
        b=n3F5GPAghzH9kYkvJ30kcVBwf1YBpUdAfRFuuZXcIW2ZR3q0nb1eaEjOhEDJ79Wz0D
         193ZDccJZQSFL/RfGoaCsbQIofnXKb5iB5QrkXv2Ph7WoN+/1FuBtYHie+QNq8gqZVt2
         iiRcLPNceydMHGevKCvUNUbFjJHLUf5k7xiOUi0pRFiDnKdCUn50t9l85pjhYs+Khyf5
         rsW/LGryKuiVTUGvIZPlDJcQPhzpwoJzRPFntwe2cJfF4omqBdmE3bMws06QNyqisod0
         Hd7d8JvNtjMF0y2siIXXLEX0Kql3sdAm1O1DufiDaLQyVUFXE/Tpo+rDtGwS4f/i92q5
         xIRw==
X-Gm-Message-State: APt69E3tNcakO/MghTXB/PctjcfyIyRGH+7LoDY3rAcElY00dUUT0uot
        MvfkoPQRpeTabU4WUNUSjYg15g==
X-Google-Smtp-Source: ADUXVKKX60fOb2G7Ee9FNd8AniwNzZl0RTk6F07QiYN1VJ1Dm7PLOlgnQ1swApdVWPA1pwZiPtaDeg==
X-Received: by 2002:a1c:9e95:: with SMTP id h143-v6mr3542325wme.105.1528902558857;
        Wed, 13 Jun 2018 08:09:18 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:18 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 09/27] venus: hfi_venus: move set of default properties to core init
Date:   Wed, 13 Jun 2018 18:07:43 +0300
Message-Id: <20180613150801.11702-10-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

