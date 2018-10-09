Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09F9C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C1B2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C1B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbeJIPOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:14:11 -0400
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:62860 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbeJIPOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:14:11 -0400
X-IronPort-AV: E=Sophos;i="5.54,359,1534789800"; 
   d="scan'208";a="240326"
Received: from ironmsg03-blr.qualcomm.com ([10.86.208.132])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Oct 2018 13:22:14 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9040"; a="1605177"
Received: from mgottam-linux.qualcomm.com ([10.204.66.66])
  by ironmsg03-blr.qualcomm.com with ESMTP; 09 Oct 2018 13:22:12 +0530
Received: by mgottam-linux.qualcomm.com (Postfix, from userid 2305155)
        id A70682E3B; Tue,  9 Oct 2018 13:22:11 +0530 (IST)
From:   Malathi Gottam <mgottam@codeaurora.org>
To:     stanimir.varbanov@linaro.org, hverkuil@xs4all.nl,
        mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org, mgottam@codeaurora.org
Subject: [PATCH] media: venus: amend buffer size for bitstream plane
Date:   Tue,  9 Oct 2018 13:22:10 +0530
Message-Id: <1539071530-1441-1-git-send-email-mgottam@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For lower resolutions, incase of encoder, the compressed
frame size is more than half of the corresponding input
YUV. Keep the size as same as YUV considering worst case.

Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 2679adb..05c5423 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -649,7 +649,7 @@ u32 venus_helper_get_framesz(u32 v4l2_fmt, u32 width, u32 height)
 	}
 
 	if (compressed) {
-		sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2 / 2;
+		sz = ALIGN(height, 32) * ALIGN(width, 32) * 3 / 2;
 		return ALIGN(sz, SZ_4K);
 	}
 
-- 
1.9.1

