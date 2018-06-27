Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA8FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24A326031
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGiJNOZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24A326031
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934891AbeF0Pfh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:35:37 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:39699 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934682AbeF0P2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:04 -0400
Received: by mail-wm0-f48.google.com with SMTP id p11-v6so5920950wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zcA1bMzMKszM/ZqPgSXw+wRPd+0JBjNguhSfmeGv3BM=;
        b=JGiJNOZ2LVBCGpHPOnqeAt1PhA6cY8/dd9dra4E14e9U7v0y630Pj3/eTD9XbDPBDd
         9nsHJ9dk0uC4LCobhvaIBWJu2SsXx8gCbRSOK/N3E9o3zqNoJM30Bq3BdGPC8V0hrUP3
         KgwSP7bQ259ZScAW875aq6ogCOkE/JdHADcFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zcA1bMzMKszM/ZqPgSXw+wRPd+0JBjNguhSfmeGv3BM=;
        b=ajwc4rJiTVCRIfbny7zJDRDbMnQgCQjubvJdMmRPrX3mdXvuXnACsgc1zCvwotIaNZ
         HbB/jXYkkzTRnD3AUnnh1J4x9uMzcaMibpQHJHxst6pl/Yskm/PIKQHZQgD/Pvu4QN3g
         LiTlILIK9pysgeSyiJoGBjWbd/q6DNIcUFIGg0Mhm5frLN9m93uNXl/4INvK6++9mDO4
         18orwYk/Uw/2unv7+UT2Y4MOeJ1UulqfZ3FpbDBKaLEDiL70LajQYwxp1IwQCZUZPj7K
         HS5b21+3xHriHrt0KXfYz/4NHD97ajophdhFtBeR8N9omMC99TXYzkgFNQ1WHu85fn5A
         ZCnA==
X-Gm-Message-State: APt69E07B2ddlnWYHJ6reZn4skJ95PqiOkey16w2MSqNmGosa82jHUbt
        gqN5+u7a6zC0S9KcOU6qiwiuQw==
X-Google-Smtp-Source: AAOMgpcVq1fEV4oJAjR7Syx8UOjsKkjqXF8DSVRkHq3qUhCPaJc2fbYp74MFSJgsWNOf3IjZ9B4/Sw==
X-Received: by 2002:a1c:369c:: with SMTP id y28-v6mr1345067wmh.34.1530113283554;
        Wed, 27 Jun 2018 08:28:03 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:03 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 05/27] venus: hfi: support session continue for 4xx version
Date:   Wed, 27 Jun 2018 18:27:03 +0300
Message-Id: <20180627152725.9783-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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

