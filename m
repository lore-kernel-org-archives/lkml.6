Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9864DC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1FE20844
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMENNyNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfBAUOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:14:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42874 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfBAUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:14:45 -0500
Received: by mail-ed1-f68.google.com with SMTP id y20so6425555edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6Nfu88pA53HNFg0+s4Z6awlFIAM9fPPZy5OIjL6MbQ=;
        b=YMENNyNtbV5eg9zIhoPRi85DlUEKy8v5uOY/t0UOgpjCodWAdDSa695UjribCMwA4C
         JoJJf9m7JpM8/Y+oGK0wZ3RJoMxZEy8tSXvRwZVXTRFw3JpU8/496V5KzT60gQZuQT48
         jX++vlUZYxSAeV+2l2IE21Reis1XW4lTrD36ybycmVxJcF4yxKkj88KyXQ61peM5aPEw
         o4jCHEznkVoXgh5kQ4Ua07A/Yyj33guEXUHm7zh1y0Esrm/+zPFTvNo1dVXNKJEM3CSw
         t3f5gWfbZSNyA83WVDowBC8N0w+HFBgYSV2Sj7X6ogQr+m/5InjAw0LfEk68lGjUeA1h
         02EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6Nfu88pA53HNFg0+s4Z6awlFIAM9fPPZy5OIjL6MbQ=;
        b=iXad0D/kZoK1KkjVV3Juz6g6tAqS1GJkmg5LJVhI4/qCKX/fy3H72O/2zCz/lO4xBy
         1rhoDL1I8RanIP4jLPWAofN5k+qYMfdLXR/hS0BSpkP9zb3Tso8z9jwLH/vaeuJaYvG9
         ruSDB1U+PVdZcNJWNHnj7RKD10+9XP16f7WSQUW4P+H+aG9kLgO9+SofIhCTfAXrnkAT
         0YONG642UpmuaeOUHW4kcZn+7Ip+tOZhWXvTu69fExFZ9pAJwKk0ut9GRo2DMex+QgOp
         MPKrFegHbEmBrVtuCaJPvwoYcJbEgXrQkd2GdqZdd6fwbKZGIYUGekpUW3sR8acVz9m/
         2lJg==
X-Gm-Message-State: AJcUukfh7yrfyh9PdCzcGDQIdytKxWRy9xmHrAa8rUs74IX0ICiT4QWE
        w0xTnfhy6EXe70LUNHH0S6w=
X-Google-Smtp-Source: ALg8bN4OoNHEVuhRcBociptFvwNX2HG8xjQaHEDdAmLeyiF6JJ5DbL/wUTs3HGh9icKAz902oBe6hQ==
X-Received: by 2002:a50:8c04:: with SMTP id p4mr40025412edp.274.1549052083599;
        Fri, 01 Feb 2019 12:14:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id b15sm1406799ejl.42.2019.02.01.12.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 12:14:42 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Use memset to initialize variables in amdgpu_dm_atomic_commit_tail
Date:   Fri,  1 Feb 2019 13:14:28 -0700
Message-Id: <20190201201428.13357-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:5089:60:
warning: suggest braces around initialization of subobject
[-Wmissing-braces]
                struct dc_surface_update dummy_updates[MAX_SURFACES] = { 0 };
                                                                         ^
                                                                         {}

Previous efforts to fix this type of warning by adding or removing
braces have been met with some pushback in favor of using memset [1][2].
Do that here, mirroring commit 05794eff1aa6 ("drm/amdgpu/gmc: fix
compiler errors [-Werror,-Wmissing-braces] (V2)") in this tree.

[1]: https://lore.kernel.org/lkml/022e41c0-8465-dc7a-a45c-64187ecd9684@amd.com/
[2]: https://lore.kernel.org/lkml/20181128.215241.702406654469517539.davem@davemloft.net/

Fixes: 02d6a6fcdf68 ("drm/amd/display: Simplify underscan and ABM commit")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1c1c162c4eee..f70f4bbde665 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5089,10 +5089,13 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		struct dm_connector_state *dm_new_con_state = to_dm_connector_state(new_con_state);
 		struct dm_connector_state *dm_old_con_state = to_dm_connector_state(old_con_state);
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(dm_new_con_state->base.crtc);
-		struct dc_surface_update dummy_updates[MAX_SURFACES] = { 0 };
-		struct dc_stream_update stream_update = { 0 };
+		struct dc_surface_update dummy_updates[MAX_SURFACES];
+		struct dc_stream_update stream_update;
 		struct dc_stream_status *status = NULL;
 
+		memset(&dummy_updates, 0, sizeof(dummy_updates));
+		memset(&stream_update, 0, sizeof(stream_update));
+
 		if (acrtc) {
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
-- 
2.20.1

