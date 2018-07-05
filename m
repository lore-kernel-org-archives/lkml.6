Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B8C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74AB724137
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1mizovZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AB724137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754327AbeGENFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:05:17 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37989 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeGENFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so10664076wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zcA1bMzMKszM/ZqPgSXw+wRPd+0JBjNguhSfmeGv3BM=;
        b=V1mizovZps8cOIMo3Vkh1MqRpu38AyElbafWwbX5Dno/2YEGgXd3rE5HMXpxumutbY
         61GasrGuI/RdQSdBHvXqGq+EK6dVRqi6K88Ubx+wf8OTa645+EzK4HuJoY0czEq8Djo4
         YKrXpcffA0kMxMxpDO5f/c1O1SrJSIOu9E5Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zcA1bMzMKszM/ZqPgSXw+wRPd+0JBjNguhSfmeGv3BM=;
        b=PjiLsJ6MFVc73chpXJc7dLchMv66ta+MLSQr1ub8Y2DV7tIc8C8uancoo0Z9K7gRHf
         VwplMyIRwvp2y6cH/fQslCMK/8vPCAdHDWWALwFBKUEwBRk2ALRBGn/Pl5jJb1knxw00
         jt/vLjzzxZl75ZI+bSRZU2Eesdm+Uslcytpz73rq8LgMbkSm+Tg7ShOvrW5Lq5VdmphG
         KAd3kJvClrD5OeGA1qQT0XrYcjCw2oOafZNthM5dkhkxmLMh6YxzgrvIM0DWiIys/1UA
         ixenWF+Enos2QcILl1N5dWPGzrSEw/uRFjTqNQ6zYfvEY64yco4PYZIv7qWv4jKnjXWz
         NlyQ==
X-Gm-Message-State: APt69E0E0VseT2Tz9bO2c/sq8+kGI6+1lXnGLz7quxLAhUBcY6aZOr9D
        7l9OdWpvQt1bGpxU0WHXOsCGY2ECcQQ=
X-Google-Smtp-Source: AAOMgpfQimxSvfPj4IBt+awePGfI/JSkfII+7FUb8NAYxtPpyscwrLfW6egrhFFtmGKWUDU425tkBA==
X-Received: by 2002:a1c:dc41:: with SMTP id t62-v6mr4206882wmg.42.1530795912008;
        Thu, 05 Jul 2018 06:05:12 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:11 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 05/27] venus: hfi: support session continue for 4xx version
Date:   Thu,  5 Jul 2018 16:03:39 +0300
Message-Id: <20180705130401.24315-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes possible to handle session_continue for 4xx as well.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index bca894a00c07..cbc6fad05e47 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -312,7 +312,7 @@ int hfi_session_continue(struct venus_inst *inst)
 {
 	struct venus_core *core = inst->core;
 
-	if (core->res->hfi_version != HFI_VERSION_3XX)
+	if (core->res->hfi_version == HFI_VERSION_1XX)
 		return 0;
 
 	return core->ops->session_continue(inst);
-- 
2.14.1

