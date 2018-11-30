Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C272C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B23F20868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CV6aZnwD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="fs64NL+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B23F20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeK3XCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:02:06 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeK3XCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:06 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8B39B60B11; Fri, 30 Nov 2018 11:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543578784;
        bh=f1eMrYmqOmvPmQWnFQBHsCTbgU6uDlZ+PXfDWnE/ZIg=;
        h=From:To:Cc:Subject:Date:From;
        b=CV6aZnwD1zL1cgVtDXCLnowextSzrOhpiHKz/ue3JuEd+cBwoGv3qC2JIKrlKkAK9
         lazIjz6OwumugNNdqefct7kuAm156rSuTDq7SaPNXB0meTz0vNcmZegpVibb8bvG/T
         2TInzNAXro6CSnqac5YWfqlLgxB3aZVOYQy11jTw=
Received: from jshekhar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jshekhar@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 14146602F4;
        Fri, 30 Nov 2018 11:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543578783;
        bh=f1eMrYmqOmvPmQWnFQBHsCTbgU6uDlZ+PXfDWnE/ZIg=;
        h=From:To:Cc:Subject:Date:From;
        b=fs64NL+MgqjwlA2gMRMVsGESsmiMs32viVsBwOAXNYnFwuCqhPWpU7KFqwWUYfbPP
         eHzkzPLRVRK+F/hqcO8mSCvrYkW7LOPWhzecXrKyvG8jBnP8TCvz8jz19gzGYlscX2
         vLYOUCOaT86QiKSIChKWQsgVxJBiTGC7vH+Hg4E0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 14146602F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jshekhar@codeaurora.org
From:   Jayant Shekhar <jshekhar@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Jayant Shekhar <jshekhar@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        abhinavk@codeaurora.org, jsanka@codeaurora.org,
        chandanu@codeaurora.org, nganji@codeaurora.org
Subject: =?UTF-8?q?=5BDPU=20PATCH=C2=A0=5D=20drm/msm/dpu=3A=20Ignore=20alpha=20for=20XBGR8888=20format?=
Date:   Fri, 30 Nov 2018 17:22:50 +0530
Message-Id: <1543578770-25708-1-git-send-email-jshekhar@codeaurora.org>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha enable in the pixel format will help in
selecting the blend rule. By keeping alpha enable
to true we are allowing foreground alpha to blend
with the layer. If alpha is don't care, then we
should not allow pixel alpha to be part of blend
equation.

Signed-off-by: Jayant Shekhar <jshekhar@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
index bfcd165..d743e7c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c
@@ -216,7 +216,7 @@ struct dpu_media_color_map {
 	INTERLEAVED_RGB_FMT(XBGR8888,
 		COLOR_8BIT, COLOR_8BIT, COLOR_8BIT, COLOR_8BIT,
 		C2_R_Cr, C0_G_Y, C1_B_Cb, C3_ALPHA, 4,
-		true, 4, 0,
+		false, 4, 0,
 		DPU_FETCH_LINEAR, 1),
 
 	INTERLEAVED_RGB_FMT(RGBA8888,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

