Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30059C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3BE24137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wj6BqHz/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3BE24137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754686AbeGENNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:13:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754330AbeGENFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id k7-v6so1138924wrq.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iP3OBq3KmmkdIHc4ClU6RmJI5t+xyWo9eNZ9y9WZFKg=;
        b=Wj6BqHz/6uOQqXGNAt2gEk12LfFBh7wTeo9oNw+TI7HVV8kPdabQPXSDfI7+6xIULm
         ue16H3oK6OGpUcjRcKtWigD0+2PESCrGgR3vvwFgIRWzFYlVZA/a0J2BrsWrLSNNRe7W
         j/W87PrKAMJT285Dv8ZsNM8TXS2/iGeReEIBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iP3OBq3KmmkdIHc4ClU6RmJI5t+xyWo9eNZ9y9WZFKg=;
        b=gWrs5leVyJgV5vjFZ48sYCbpItLmSZ9hIyONCSa5/lWT3OicnGsu9NsQema80cBGuA
         PInQpLXw8YqjIISGsWVE2ykV2rZ0B9M0usL75NdQdpoO5c8DhipaCO/vk0uTp8W9l+q4
         YZQrF5QxAxqtogZUXpBLOMtJlgtqegPJVXByJNjqd9Otj4Dxl07Wmp8xoNGV1HOYawTY
         YPjXfonOid44PNIoZPkrrzmbiDDYecGzHZG1mAQS2w6MSgWkPhiRr78P5lEI18lS4vr1
         6giBvu6jPZ4IU2x6jd4avd1s9InnEujlgXoP9RuLWCKAYaqE+6PgrcKZVdocMV5Ack5n
         OfIw==
X-Gm-Message-State: APt69E2SAW+s/LwuASuFZVc6rCDPeikHBemfuXwsiLw56YPK5K0kpWBi
        Tt0nlOKfIpDGGDbanMpe5k1vi5JGx1o=
X-Google-Smtp-Source: AAOMgpcV/SnSbL1BLggXwBPez+LA1lCwrkWQy48VePWisGXFFa/kclxkqbKCpwVZeEpwEL981SdL8Q==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr4394146wre.268.1530795916640;
        Thu, 05 Jul 2018 06:05:16 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:16 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 09/27] venus: hfi_venus: move set of default properties to core init
Date:   Thu,  5 Jul 2018 16:03:43 +0300
Message-Id: <20180705130401.24315-10-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
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

