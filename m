Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD35C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B86020844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTx84hRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbfBAUPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:15:54 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40776 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730125AbfBAUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:15:54 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so6455444edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gq4xaRA94CBhLfyNRSOb/rI9jopU5xrx1oCHWIVSd6M=;
        b=oTx84hRLu6MicF2BmAC0oI3z8daTRKi9bD/W7nvM9VpQ92+R7+r2uqVOB0WIJx4kib
         Q1vwceq/PYE1ttf7c+EXOMuWuGYr7xsOMVKaZzRB4/nwx3g8t45U7pJU1rwjfFVRz4X9
         SRCxjGVcKLoj4jsL0ml4Mjc6dmDTzCKeqKgUDi04CXP9ZxDnOfP8jOkkjI3l7z414GgJ
         mcK3dQ58TBLq3atsYZJM2L6iVoWR/FkfhpCGwOqQDU3xHMqOpJ+0p8Yg09Akd18vzygr
         xMd/McXUU4jMq4Z8B1p88VlXDThdt+gpKXDMcHbhml15fYYyeRG6nl0bfBHASmdSgL3B
         QRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gq4xaRA94CBhLfyNRSOb/rI9jopU5xrx1oCHWIVSd6M=;
        b=PLaLefwAoyNBoOnRIcrCod1p/thIKZ7Npzcn8N8HvMDMsDvCXXExYCvjktB1dR39cq
         LWVN42mPd0apfQyzqoSMu5XPry1j6bQumwpUZz+VERkcrri24URrUKyKQ0sQV+S4gBKu
         9S+43Zs7wVIr6VSnMg6jC6FLsmsMHPPM/GEq2NN/v08kBZxW5F4ZOKfM07tkhbvQ41Nw
         qiTt80qV68Ip/HRjUbF9Pi2QBtRCyzSbLQM9vcTWvqFN/ZcARJKy5FhKQ2eQwIjki9ED
         a5qga2ZLLiGQdqpPxZZovyQEYx2AeOwiBiNl+uAWKArWFxZm+8EMnHoEuxMsT2dpsEQw
         LcDw==
X-Gm-Message-State: AJcUuke3UZMGGRyUwIMFeZpfadWUdfSxD13uQcDU5DulXJlHfrHXCxI+
        MwHYSh3por8NCVSzsGHGKoxum/VhZ94zWg==
X-Google-Smtp-Source: ALg8bN6gNAUlfOugjKc87eLbTl9v52cAmdziiKwA2hu0H7IKKg4NXxcw4zZtWFTPfdDM5RB2figO2w==
X-Received: by 2002:a17:906:7c51:: with SMTP id g17mr35447385ejp.196.1549052152207;
        Fri, 01 Feb 2019 12:15:52 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id x38sm2258414edx.24.2019.02.01.12.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 12:15:51 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        John Barberiz <John.Barberiz@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Use memset to initialize variable in wait_for_training_aux_rd_interval
Date:   Fri,  1 Feb 2019 13:15:41 -0700
Message-Id: <20190201201541.13680-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:50:57:
warning: suggest braces around initialization of subobject
[-Wmissing-braces]
        union training_aux_rd_interval training_rd_interval = {0};
                                                               ^
                                                               {}
1 warning generated.

Previous efforts to fix this type of warning by adding or removing
braces have been met with some pushback in favor of using memset [1][2].
Do that here, mirroring commit 05794eff1aa6 ("drm/amdgpu/gmc: fix
compiler errors [-Werror,-Wmissing-braces] (V2)") in this tree.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Fixes: 3cec41769d21 ("drm/amd/display: Fix use of uninitialized union")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 92f565ca1260..5ee36d6e0512 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -47,7 +47,9 @@ static void wait_for_training_aux_rd_interval(
 	struct dc_link *link,
 	uint32_t default_wait_in_micro_secs)
 {
-	union training_aux_rd_interval training_rd_interval = {0};
+	union training_aux_rd_interval training_rd_interval;
+
+	memset(&training_rd_interval, 0, sizeof(training_rd_interval));
 
 	/* overwrite the delay if rev > 1.1*/
 	if (link->dpcd_caps.dpcd_rev.raw >= DPCD_REV_12) {
-- 
2.20.1

