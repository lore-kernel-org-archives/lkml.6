Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D832C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BDF208BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGcQseII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BDF208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936031AbeFMPJX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:09:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35782 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935971AbeFMPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id j15-v6so6158491wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DopT6tfRa5ZXddiWA2KYWqHxQ5fQ330DwA7mzNfZ1z4=;
        b=TGcQseIIokf4O4DZ8xLZt3+w/947HlwG1URxXKRe2h3HY9sqcCru0SNoT6f9MJLOTX
         YI606ldSsZF3FbfJNjBssY3FfNYysjC8t83rfOfi02dK04hqf6ODtLZlS0BUfYtWIRmn
         ia8MofSGAUds8bx1Ag0s09OhrD5dVqzWu9Sqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DopT6tfRa5ZXddiWA2KYWqHxQ5fQ330DwA7mzNfZ1z4=;
        b=Oa9AHWVQaF3BhOYbEpi12vdN36IRO/2mO/JnXDBKUmyzSM5kCkfMWxII/XeWKXesHB
         83A4cP+rHs15Hlv3hr8zwk1bsZsDcOuDqwPtuqsic8fIsAEF25t9KwD7P6xTL4UMNVRh
         riPkknFKzonQIocBG3Tdl5pJvXA08+1Ux/Mm53vBdA3hgTfnRVzPMhDmv/yEKRKFwKez
         RBQk7DgNiqhI1+t/Eoa/b5NHhmevNekt6RVhTSa/xxiOfxNx/rtVA9lYqgqgSn+P+bxF
         GpG390OrBYxcddQuszv/kztGPNEOPM3wYM+RKfzGCf4s2st2LfGWC/753BsP5Fb3s+zD
         4BxQ==
X-Gm-Message-State: APt69E0dEkEqiax5/MpF6fL14QsmkuqMePRSSHG+dsNLIvqUGOBu9nGn
        Vr63dyw8x39Y7jZKM9gsYefvYw==
X-Google-Smtp-Source: ADUXVKLGcmI8Ps4b0FXjwgMbhJjn00PDcQgRSgOTBRxbNoT77VWdMZU9oNxIV5eLjMIuAs77pcrLSA==
X-Received: by 2002:a1c:91c4:: with SMTP id t187-v6mr4035433wmd.51.1528902553219;
        Wed, 13 Jun 2018 08:09:13 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:12 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 06/27] venus: hfi: handle buffer output2 type as well
Date:   Wed, 13 Jun 2018 18:07:40 +0300
Message-Id: <20180613150801.11702-7-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

