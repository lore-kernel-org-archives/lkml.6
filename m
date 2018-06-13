Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 77FF8C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7B0204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TF0Mqgh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7B0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936110AbeFMPQ0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:16:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37053 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935955AbeFMPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id d8-v6so3152728wro.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zcA1bMzMKszM/ZqPgSXw+wRPd+0JBjNguhSfmeGv3BM=;
        b=TF0Mqgh5bSpxgUlwke8em8VV7DVKMQYAGM/9iY6iqAKHrgmi44xTqcbM4iiN7kJtgA
         n26bilFX6CLEoRNFMdGUlYOgX8u9AmOh3QRRckv6rXx2sr5g4Toj6W9ctFVWQKCdBWe8
         vuoWZC11ETuVtPGDilc/g5wkrlyaeDKoLj5ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zcA1bMzMKszM/ZqPgSXw+wRPd+0JBjNguhSfmeGv3BM=;
        b=TucXsnkPUlBfWmFO1u2zrdNXZnhsvXoAw14uvf5dwLenDUH8olzJWpQAeeIjC28DBY
         Rd3DZh21Dyp74G4Hv+2a/JQ04gQmNTWl8B7KiUg3aTYwBDKVhjyCpZ0Zir+aPX2ENmTi
         nNBtJ71ljEvxU2iz3UZSYDu9l5dIKA1Yc3vuY6BWTPFqoJBeAzXSEnP0u850Oq84oVVK
         jTnt8aKvi20UpaGowiTsJJk/+cO84GwEzXCy3MbMjeUHQ0IflRDq+GQisDN1YNA7jVoF
         fisU2+zoxqoB3K/PCnQvNtL4a8RhC6y9bnoO9XW4zlED+nF2y/O3IHVNYLuL5S0n98d0
         itQg==
X-Gm-Message-State: APt69E0+WnR6HTlXZZVONpFEUwnv4HrpiiwAWp5abQEWlRRA9yHbyg/F
        0Nut3V50uWpwKF1hdbrtzqnQdA==
X-Google-Smtp-Source: ADUXVKJDRNaVFLqD/pzJWX8iKRThhd99O50MuuLoojG5DIlDOkcAG/1JI+AsywElOGJIUhyhRevr5w==
X-Received: by 2002:adf:c00b:: with SMTP id z11-v6mr4284465wre.268.1528902551308;
        Wed, 13 Jun 2018 08:09:11 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:10 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 05/27] venus: hfi: support session continue for 4xx version
Date:   Wed, 13 Jun 2018 18:07:39 +0300
Message-Id: <20180613150801.11702-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

