Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BAE20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="jp5T9tnR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IfBXMuF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbfBDQQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:16:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50408 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731728AbfBDQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:16:01 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 878CA60A72; Mon,  4 Feb 2019 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296960;
        bh=2pkas+5mUJQt9blw21SP40O8+D1+Uus3jKGfI2wfqVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jp5T9tnR5NM7nRFgRpp49ejN+r6mtZjCLFloOuaWf/haoZIIm2ukQ0Rph8LR9kJDI
         xSjEJHTCRJdh6mvNJlpy7Gj7e7wV0xtff/V0GiXNwX+jOYQjHwbwznht+3DO4EcfVf
         za96I8NtQKvv8A4iCn9Nd/0oIJi+HY5KMawG8kNY=
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2528A60A37;
        Mon,  4 Feb 2019 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549296958;
        bh=2pkas+5mUJQt9blw21SP40O8+D1+Uus3jKGfI2wfqVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IfBXMuF0dY7kXqVJr5WyEztea+EJ9y2RoAgHv7Ycou0JH36N0yxcDgPPTGrO/EKui
         OUxtUxLQW3VLc58C8hHL8VbKroPMgvI8J1Z3rEBWiGpu4aElxkJSXf8P+G9f9dV6bc
         R12hN0W9cIx02zF2EBNdUpcEvAsnS1YjSvMY19AU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2528A60A37
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org,
        Sharat Masetty <smasetty@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 6/6] drm/msm/a6xx: Remove an unused struct member
Date:   Mon,  4 Feb 2019 09:15:44 -0700
Message-Id: <1549296944-17285-7-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
References: <1549296944-17285-1-git-send-email-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HFI tasklet was removed in df0dff1 ("drm/msm/a6xx: Poll for HFI
responses") but the tasklet_struct was accidentally left behind.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/gpu/drm/msm/adreno/a6xx_gmu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index c5b1887..bedd8e6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -75,7 +75,6 @@ struct a6xx_gmu {
 
 	struct a6xx_hfi_queue queues[2];
 
-	struct tasklet_struct hfi_tasklet;
 	bool hung;
 };
 
-- 
2.7.4

