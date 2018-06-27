Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA0C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960324491
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTTIUh1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0960324491
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965572AbeF0Pew (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:34:52 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41848 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934639AbeF0P2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:05 -0400
Received: by mail-wr0-f195.google.com with SMTP id h10-v6so2468123wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DopT6tfRa5ZXddiWA2KYWqHxQ5fQ330DwA7mzNfZ1z4=;
        b=RTTIUh1NszVoP/tmJF2cGpBKo3PWNyEcYbh7tdayfs5Z+EgDM4BA0/5xTEokTLG/LY
         /95pr2bp4ocyxMdG6PcNQhuwWys59pCt0g7vM3t6EA1xpm9BGqkpU/jqzuD++JJEUxOS
         Wy8DFHjD3HOZG1iH4Avy5Fvm1GL+c3wh7CaPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DopT6tfRa5ZXddiWA2KYWqHxQ5fQ330DwA7mzNfZ1z4=;
        b=b/f+2B1N4QtqIPpZJKt+xELFx0r5cH/KAqh85snxyLwQ0NyohEcG5bEsfsKK4I6hJK
         efpoXtg8go2Y7LxbbrIEKsabr5/fAZdxfLGPmclEToJFGfH2xV3I3Fs1NV3yNp9I3w19
         oI6eRIeE0RUk2xTO6Y2SnTSonc2iwuZCfj0HI1RK05ruwiEBmFMBnN7rlclogkIDjOuY
         z+FVk+vJeJO4nzSOfWEC1cgsdWFE+Z6zGCf5bh1d9SW7BqCy5N3Y2Xz+ZCkA1s6SsQ7s
         RVIaJXIZf/GGdz4GuaO/Ko7cPIQ0D7+hSpcMV165LmtmDSqVWVvyxHPn6hsziuExDfh0
         rW8g==
X-Gm-Message-State: APt69E2wDkpKg9gpZha0sA+8LbeIyZgNiq6akbrqfDCHSjso/RwaM7rJ
        u68JpBaZof3hbi7shRcT9rrozRnSc2Y=
X-Google-Smtp-Source: AAOMgpfHM6djMpgfPCzYl/TF5a40v/JwpIWSY0nlh4lAfnbZ9rS4uF2HGxLNqre8AO+7AZePMKxKUA==
X-Received: by 2002:adf:e590:: with SMTP id l16-v6mr5281175wrm.190.1530113284727;
        Wed, 27 Jun 2018 08:28:04 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:04 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 06/27] venus: hfi: handle buffer output2 type as well
Date:   Wed, 27 Jun 2018 18:27:04 +0300
Message-Id: <20180627152725.9783-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds handling of buffers of type OUTPUT2 which is needed to
support Venus 4xx version.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Reviewed-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/platform/qcom/venus/hfi.c      | 3 ++-
 drivers/media/platform/qcom/venus/hfi_msgs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi.c b/drivers/media/platform/qcom/venus/hfi.c
index cbc6fad05e47..a570fdad0de0 100644
--- a/drivers/media/platform/qcom/venus/hfi.c
+++ b/drivers/media/platform/qcom/venus/hfi.c
@@ -473,7 +473,8 @@ int hfi_session_process_buf(struct venus_inst *inst, struct hfi_frame_data *fd)
 
 	if (fd->buffer_type == HFI_BUFFER_INPUT)
 		return ops->session_etb(inst, fd);
-	else if (fd->buffer_type == HFI_BUFFER_OUTPUT)
+	else if (fd->buffer_type == HFI_BUFFER_OUTPUT ||
+		 fd->buffer_type == HFI_BUFFER_OUTPUT2)
 		return ops->session_ftb(inst, fd);
 
 	return -EINVAL;
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 54cd41e5837c..c0f3bef8299f 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -823,7 +823,8 @@ static void hfi_session_ftb_done(struct venus_core *core,
 		error = HFI_ERR_SESSION_INVALID_PARAMETER;
 	}
 
-	if (buffer_type != HFI_BUFFER_OUTPUT)
+	if (buffer_type != HFI_BUFFER_OUTPUT &&
+	    buffer_type != HFI_BUFFER_OUTPUT2)
 		goto done;
 
 	if (hfi_flags & HFI_BUFFERFLAG_EOS)
-- 
2.14.1

