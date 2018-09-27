Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F8FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4F7216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+WLNcdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4F7216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbeI1A0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:26:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35656 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeI1A0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:26:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id o16so3637554wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UEeulAjiOWAtqzm4y+NbcWygbkvyt477fVUAQwaNkkw=;
        b=b+WLNcdXpsvnpzngdJnZqKr/W4C5alr+JyzgNpzn1QSogx/kAJ9L6geA4HZMw1aAIR
         wIjFCtk7yt/FAs5/EocHSVBGwaz1oSDCilLHK7E9e1VVciFDx1dRadaJzddOhMDdrW2g
         O9uPl5nx8Wx7lLHfK6E0l+SnHP8dvdAM7glnexaYvYrOTahQN7XHB3FzR96fUVUNBVC3
         9CU6RWcf3mHw5Lgi8aDAGqqc6pd9v49wqEyvV7R0PqlgjiEisyo047otKN0pOCYvocm6
         ogxxNiGhvwEIjkTZ4BWIFXBvJsyyAaDUcXQeFlUf/fY3nIDdaB6OUICUOOwHd9helsOU
         lX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UEeulAjiOWAtqzm4y+NbcWygbkvyt477fVUAQwaNkkw=;
        b=TUNxlqZhofUWVs47btsMaJhO0UX4vuVz79iwGTreSHUujAyU+M5Bw3u6cMmIUni2lg
         TgaUOph0Mu+SMNzTcidNCeE54K947/twYl/VkLiZezQrj4MlvXFxVYMZtFHaCZo5NxiO
         akm3141nKqYFkqjySB2ZD0exyLCM+Jv2ROgcV87GOdn9gOHJn7dkMdxZxb8yucIi/x6W
         hSBiNBUDTaoQEYjF8AvcHZp/S6UFDpyEE3xuVhuHa8Rma99rVHyIIyug0LLy3HXlp53j
         sfbobemFIPOvAS3j+TtY7DMYTYxhaT6VDK1PaD6D5S/BaKGVQCeW/aJda8KYzwtd43S2
         PK1Q==
X-Gm-Message-State: ABuFfog0uM33uAvLBJkfxbnQ4cOjrwqROI4L5i8oyZ0sZjtu7zwUAF8s
        etdLpMic8NkpOud36kbqoD1evqXm2CWsFA==
X-Google-Smtp-Source: ACcGV60VZiqFg+X517kaqKk3rcNPquDMRfdDsmJGiMMk7mcE43Xkm31UhUgb1YmG7JhFIOGIEGUAsQ==
X-Received: by 2002:adf:9031:: with SMTP id h46-v6mr9650316wrh.248.1538071605122;
        Thu, 27 Sep 2018 11:06:45 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 144-v6sm3893418wma.19.2018.09.27.11.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 11:06:44 -0700 (PDT)
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
Subject: [PATCH v2] drm/amd/display: Use proper enums in process_channel_reply
Date:   Thu, 27 Sep 2018 11:06:33 -0700
Message-Id: <20180927180632.11520-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921215505.14634-1-natechancellor@gmail.com>
References: <20180921215505.14634-1-natechancellor@gmail.com>
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

The current enum is incorrect, it should be from aux_transaction_reply,
so use AUX_TRANSACTION_REPLY_HPD_DISCON.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Rather than change status to an integer, use the proper enumerated
  type from aux_transaction reply as suggested by Nick and confirmed
  by Henry.

 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c                    | 2 +-
 .../gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 3f5b2e6f7553..aaeb7faac0c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -312,7 +312,7 @@ static void process_channel_reply(
 
 	/* in case HPD is LOW, exit AUX transaction */
 	if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
-		reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
+		reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
index 8eee8ace1259..59c3ed43d609 100644
--- a/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/i2caux/dce110/aux_engine_dce110.c
@@ -346,7 +346,7 @@ static void process_channel_reply(
 
 	/* in case HPD is LOW, exit AUX transaction */
 	if ((sw_status & AUX_SW_STATUS__AUX_SW_HPD_DISCON_MASK)) {
-		reply->status = AUX_CHANNEL_OPERATION_FAILED_HPD_DISCON;
+		reply->status = AUX_TRANSACTION_REPLY_HPD_DISCON;
 		return;
 	}
 
-- 
2.19.0

