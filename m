Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE872084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Uwe+/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE872084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbeLJXma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:42:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50556 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeLJXm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:42:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so401972wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 15:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hO2cM2zJi2SuG74ItghQmHcUUIbBMcVFUOPugxeMdTA=;
        b=D4Uwe+/FGkJWgRKtRmHkha7/QFdVvZPK2oWRBYR+TjxjNw0IMeDrNhcTjkSPL837A1
         g1caxuYpXAcRq+jx6X2db/caO0xSXbNKzd2BklpFapORg0YIwtTnvIaH/YpEayr0uJ4Q
         +AMfSvsj13k6GeJku+S0vYys3cmmywXyQZ3u6fCZ3kjdcdvxPstlGS1zYxdL8lTo1Z0b
         Nu/m0a80qc4931Oa63Lq3lI4Koccp6xKjtQsX5i1Ps75WbY3BFVKjry+akJqUoA1ErnK
         Ru4QAM0bZYnKuRxfM3ZFyggB/9j8N2rRorXjzhh2Cfxp9EMuqkoxdoxEVTrX0CxaWh+X
         kp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hO2cM2zJi2SuG74ItghQmHcUUIbBMcVFUOPugxeMdTA=;
        b=reDItP/IqPl0R2wqC0enTT+aOurQPFSH3qY0nrDc16neRqjImH2c35Ig+Q8Bd3kN2Q
         SSNYPUvVeg3n6UW5AZqjyGOvp/hPSvvhd+VcdRj9dyTGBG/cGa8cedmP2ELEaXSSL+Gs
         n4AoahofpLlSNW//erpxGRoUmymIWfzK3X1ljkkNFevBj0w6fYWoRYCP2eLqhlXHKJK9
         Hld370PnnNpQ2DAW9jl/hCRY0RM7GzBRZ9iKoVQV+NH5svlEQs/PjsZb2YepbPOkJo2Q
         q/MJaAbz9I3aNXiv5G3XBhTEQPjmoxWAIytOoCSq1HEuxkatMYOcw1u2c4bI/ybwoROA
         RSxQ==
X-Gm-Message-State: AA+aEWYqNlldkK0RwHDj2CUKUXudcy5fXLhfE0+eXWeoNSCyofB8OjRz
        0uKFiU+jGFjD18WQHBjTQ0c=
X-Google-Smtp-Source: AFSGD/XReIxxjfQivP4agXyI0ORXNpTBnFp3+rQGFmRAXtLGdCcJh3RigDDJAS17GnZegebQ5Ij5tw==
X-Received: by 2002:a1c:e513:: with SMTP id c19mr317226wmh.101.1544485346375;
        Mon, 10 Dec 2018 15:42:26 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id a6sm279729wmh.10.2018.12.10.15.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 15:42:25 -0800 (PST)
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
Subject: [PATCH] drm/amd/display: Pass app_tf by value rather than by reference
Date:   Mon, 10 Dec 2018 16:42:01 -0700
Message-Id: <20181210234201.4850-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when an expression that equals zero is used as a null
pointer constant (in lieu of NULL):

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4435:3:
warning: expression which evaluates to zero treated as a null pointer
constant of type 'const enum color_transfer_func *'
[-Wnon-literal-null-conversion]
                TRANSFER_FUNC_UNKNOWN,
                ^~~~~~~~~~~~~~~~~~~~~
1 warning generated.

This warning is caused by commit bb47de736661 ("drm/amdgpu: Set FreeSync
state using drm VRR properties") and it could be solved by using NULL
instead of TRANSFER_FUNC_UNKNOWN or casting TRANSFER_FUNC_UNKNOWN as a
pointer. However, after looking into it, there doesn't appear to be a
good reason to pass app_tf by reference as it is never mutated along the
way. This is the only code path in which app_tf is used:

mod_freesync_build_vrr_infopacket ->
    build_vrr_infopacket_v2 ->
        build_vrr_infopacket_fs2_data

Neither mod_freesync_build_vrr_infopacket or build_vrr_infopacket_v2
modify app_tf's value and build_vrr_infopacket_fs2_data expects just
the value so we can avoid dereferencing anything by just passing in
app_tf's value to mod_freesync_build_vrr_infopacket and
build_vrr_infopacket_v2.

There is no functional change because build_vrr_infopacket_fs2_data
doesn't do anything if TRANSFER_FUNC_UNKNOWN is passed to it, the same
as not calling build_vrr_infopacket_fs2_data at all like before this
change when NULL was used for app_tf.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 7 +++----
 drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h  | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 620a171620ee..520665a9d81a 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -656,7 +656,7 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
 
 static void build_vrr_infopacket_v2(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
-		const enum color_transfer_func *app_tf,
+		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
 	unsigned int payload_size = 0;
@@ -664,8 +664,7 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
 	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
 	build_vrr_infopacket_data(vrr, infopacket);
 
-	if (app_tf != NULL)
-		build_vrr_infopacket_fs2_data(*app_tf, infopacket);
+	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
 	build_vrr_infopacket_checksum(&payload_size, infopacket);
 
@@ -676,7 +675,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
-		const enum color_transfer_func *app_tf,
+		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
 	/* SPD info packet for FreeSync */
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index 949a8b62aa98..063af6258fd9 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -145,7 +145,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 		const struct dc_stream_state *stream,
 		const struct mod_vrr_params *vrr,
 		enum vrr_packet_type packet_type,
-		const enum color_transfer_func *app_tf,
+		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket);
 
 void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
-- 
2.20.0

