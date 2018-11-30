Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023F1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A2D20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHRX0Xqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A2D20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLACKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:10:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46874 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeLACKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:10:38 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so6157058qtm.13;
        Fri, 30 Nov 2018 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FIYmFGHlDtXLaqHVE1ZXmEz+PUDSoNeUl/RQokZJ9SA=;
        b=NHRX0XqwoV0qaHxOIQkO13UEtMbdfOiJtFt+lrARDujAjtoQkyoJUMwsGajFB3LsB4
         R+D5mJlZIGMV24GMv9tFRmnkEIm4Qso2W7lxvSFpQSzjRROqX7xPw5f6qK+bOcytmWBa
         v5qauvXB84Cwkw5EzzHceFgNHCJvMOnuFmvP+t0pqab/sS2RD+3aEc2Z0umSco5VpLne
         Aeh9OpJq6MGn5PThuuMu+UwZldybW7wBUPq4Dx9rUPl71XE1w1h5nJulpOQ17Iol2Lz1
         wbnk/p50YgdzY/GlOVhCY6PjoB8UANbIRsPme7YmkmMpaoUn2ffx00ThWwNtKV31+ySO
         I/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIYmFGHlDtXLaqHVE1ZXmEz+PUDSoNeUl/RQokZJ9SA=;
        b=U3sfbKXvtgyAXpL6Y+uKFJZyFe3RxeXzIO8N4PvviB5B/2l9YGimJ2MuUYHWXqg2cB
         Xocz6HangMIuzMILFa5l5JRm5LvyK40yO8pnpZmn55CFoCl4pJkUhBuZWCKdxbME0OCx
         OSRSHl3NgjjxG59lZ/CW2EK6ib/kkZefbls0Q04hnm9W78F35r/71LzNGy7E3uqknhWq
         EGLtv5A4kN8C5ppYr+F0RA4OJ43Gl6PKSkOBkdWFKq2jgctdXMfU9tLuv8SykldE3CAw
         RwnURPSabXAImJxSEFvEdc55+FP2RhkXSjIDpngpZ2+rj9WCLtIhN+ieKVKBmXZhmkUo
         ougw==
X-Gm-Message-State: AA+aEWZyzkOUs585b5ZU5An8QYif0U9I2PdQrU0ObnsxCKLosynVbA2n
        6bRf3nfwQuU/oXdkY49qQXlxbUpx
X-Google-Smtp-Source: AFSGD/WX6xAvGVT8Jgdyw9E/DU9IGPs9fF24IOFE8NkNFreFxGl1ly9vxBxLHC6Y9d1ZHPxNoFkdUA==
X-Received: by 2002:ac8:3810:: with SMTP id q16mr5433033qtb.91.1543590061445;
        Fri, 30 Nov 2018 07:01:01 -0800 (PST)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id l15sm2377586qtr.25.2018.11.30.07.01.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 07:01:00 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/msm/gpu: add submit flag to hint which buffers should be dumped
Date:   Fri, 30 Nov 2018 10:00:39 -0500
Message-Id: <20181130150050.13762-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130150050.13762-1-robdclark@gmail.com>
References: <20181130150050.13762-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To lower CPU  overhead, future userspace will be switching to pinning
iova and avoiding the use of relocs, and only include cmds table entries
for IB1 level cmdstream (but not IB2 or state-groups).

This leaves the kernel unsure what to dump for rd/hangrd cmdstream
dumping.  So add a MSM_SUBMIT_BO_DUMP flag so userspace can indicate
buffers that contain cmdstream (or are otherwise important to dump).

Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c |  5 ++++-
 drivers/gpu/drm/msm/msm_rd.c         | 13 ++++++++++---
 include/uapi/drm/msm_drm.h           |  5 ++++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index ddd95a078ec4..eab638011f4c 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -114,8 +114,11 @@ static int submit_lookup_objects(struct msm_gem_submit *submit,
 			pagefault_disable();
 		}
 
+/* at least one of READ and/or WRITE flags should be set: */
+#define MANDATORY_FLAGS (MSM_SUBMIT_BO_READ | MSM_SUBMIT_BO_WRITE)
+
 		if ((submit_bo.flags & ~MSM_SUBMIT_BO_FLAGS) ||
-			!(submit_bo.flags & MSM_SUBMIT_BO_FLAGS)) {
+			!(submit_bo.flags & MANDATORY_FLAGS)) {
 			DRM_ERROR("invalid flags: %x\n", submit_bo.flags);
 			ret = -EINVAL;
 			goto out_unlock;
diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 0c2c8d2c631f..90e9d0a48dc0 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -348,6 +348,12 @@ static void snapshot_buf(struct msm_rd_state *rd,
 	msm_gem_put_vaddr(&obj->base);
 }
 
+static bool
+should_dump(struct msm_gem_submit *submit, int idx)
+{
+	return rd_full || (submit->bos[idx].flags & MSM_SUBMIT_BO_DUMP);
+}
+
 /* called under struct_mutex */
 void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 		const char *fmt, ...)
@@ -389,15 +395,16 @@ void msm_rd_dump_submit(struct msm_rd_state *rd, struct msm_gem_submit *submit,
 
 	rd_write_section(rd, RD_CMD, msg, ALIGN(n, 4));
 
-	for (i = 0; rd_full && i < submit->nr_bos; i++)
-		snapshot_buf(rd, submit, i, 0, 0);
+	for (i = 0; i < submit->nr_bos; i++)
+		if (should_dump(submit, i))
+			snapshot_buf(rd, submit, i, 0, 0);
 
 	for (i = 0; i < submit->nr_cmds; i++) {
 		uint64_t iova = submit->cmd[i].iova;
 		uint32_t szd  = submit->cmd[i].size; /* in dwords */
 
 		/* snapshot cmdstream bo's (if we haven't already): */
-		if (!rd_full) {
+		if (!should_dump(submit, i)) {
 			snapshot_buf(rd, submit, submit->cmd[i].idx,
 					submit->cmd[i].iova, szd * 4);
 		}
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index c06d0a5bdd80..3c3af92c4b3e 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -188,8 +188,11 @@ struct drm_msm_gem_submit_cmd {
  */
 #define MSM_SUBMIT_BO_READ             0x0001
 #define MSM_SUBMIT_BO_WRITE            0x0002
+#define MSM_SUBMIT_BO_DUMP             0x0004
 
-#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | MSM_SUBMIT_BO_WRITE)
+#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
+					MSM_SUBMIT_BO_WRITE | \
+					MSM_SUBMIT_BO_DUMP)
 
 struct drm_msm_gem_submit_bo {
 	__u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
-- 
2.19.2

