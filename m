Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0D8ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48942156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcVh5ZHF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48942156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391556AbeIVDp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:45:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39619 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVDp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:45:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id q8-v6so4711838wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6D/UcS5N1o2MjDIEppwnTslPGvHZVt+WncviFuTnyM=;
        b=KcVh5ZHFHcmsF2GQN7laPZuBBDd3SCei7V0gMroNXAwu7V1qEYhSGJwkwXXZfeF4mj
         dxgnbhSQr04FTKMRFjjb6oLkKH9KgrukTILSOuA1zswThkHANALf79oAUT9ZbzQD/ay3
         KR3/hDrddC5ujO8zbMXPT4cl0DBJq/Q3l5zXCet6Yz7RLaQCsliZvqjT9cM9Yim+ai7M
         XgT0h3EcTJG7X/qoIjkVeqjCaNnHpJx6n42ZucuP4JJGGCOJjO4EPP+HZM8W8jla/jTl
         SZh8wRwE7OyPxn0eKAjPip38KJsVfHWwSn9Ybo+IZkmhltih1M6uN+I180Wi0HmIQ7gf
         q8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e6D/UcS5N1o2MjDIEppwnTslPGvHZVt+WncviFuTnyM=;
        b=euVrwsAfkW8fDeTxHF1VJZSGIWhOL4tPCQQrerixdph/4PQon6pXUJpiP9FXi+Ksbt
         kvdnfX1bXeXeI6NzDISxIYZi43fOzRYGJuHLESwzpgXlMGHs322j8+uWDbfBpFcAP6FC
         e8Knb7PXVzGukLIR5fiu9Mc4obOERCxvGf42TtXXhDZ1XK9x0I2w3Gu1pa2gbzu+Vmve
         zSVvAtsf5RQ/UzrBoRUxd3MmXOYEMCcaSB0yz6JkX8fz8/pPTCl9N+WWXPvtTh7n/mQv
         T69rP3Y9KRjWdZDuixg3nWnM9WFPYw30Nbk33lCG4J0MDRcy+L0C+69k0M6Xb+1xFkWs
         1vxA==
X-Gm-Message-State: APzg51ATm+DuzL9tph+7Euc0rGF3uf5hJh4frDq8kMfNB9rteIt4oo5k
        NH8AX4Sa7qSWZp0h8Ggl6Us=
X-Google-Smtp-Source: ANB0Vda7tD+L7P8VLVhfXPNiRg0IlynxjKS9Xb92NaeFfBIMZg6WF58ek0HloEl9ZzHTiL88OzC3Rw==
X-Received: by 2002:a1c:357:: with SMTP id 84-v6mr8970940wmd.8.1537566910502;
        Fri, 21 Sep 2018 14:55:10 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id f12-v6sm7270860wrj.55.2018.09.21.14.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 14:55:09 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amd/display: Change status's type in aux_reply_transaction_data
Date:   Fri, 21 Sep 2018 14:55:05 -0700
Message-Id: <20180921215505.14634-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:315:19: warning:
implicit conversion from enumeration type 'enum
aux_channel_operation_result' to different enumeration type 'enum
aux_transaction_reply' [-Wenum-conversion]
                reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
                              ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/i2caux/dce110/aux_engine_dce110.c:349:19:
warning: implicit conversion from enumeration type 'enum
aux_channel_operation_result' to different enumeration type 'enum
aux_transaction_reply' [-Wenum-conversion]
                reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
                              ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Instead of implicitly or explicitly converting between types, just
change status to type uint8_t (since its max size is 255) which avoids
this construct altogether.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
index 05c8c31d8b31..97e1d4d19263 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_ddc_types.h
@@ -79,7 +79,7 @@ enum aux_transaction_reply {
 };
 
 struct aux_reply_transaction_data {
-	enum aux_transaction_reply status;
+	uint8_t status;
 	uint32_t length;
 	uint8_t *data;
 };
-- 
2.19.0

