Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A73C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DDB20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhIg2WBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DDB20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeJXDHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:07:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43165 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXDHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:07:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so2735167qtq.10;
        Tue, 23 Oct 2018 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5I4jJmJY18k8jFrKZs61HiMBE7oB5H0TbtuwvkjeXOA=;
        b=mhIg2WBuS983BgiTTgcOdCHM8LcybHktUwZ/FU8X17u2xmIIuBQwS7Esm41pRf7xU+
         lINReL24yG9hgt92dX1RWfQY4AF2hJTIOyYnjjBjXQzR2UmCXK818jBq1E3XecQYdsRR
         iu02lntAhsp2jNLeNtDzGy9TnVj93eK/OFvOLasUKHfFpyMVoi1gj71UL5b7YLWTP6pB
         YQYp80UNriZ7mWddlTCxSgKXxScuT7xuuV3pVSsNBEbgUfzhJ5Zisqb9u5hBLW6o1gbW
         2qF74KSQoUFK38erdi3XLEFiFP7gQOpt2cPvYHXo1VL9oaBF/ZFOvK49d3RnErH6l9/m
         y79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5I4jJmJY18k8jFrKZs61HiMBE7oB5H0TbtuwvkjeXOA=;
        b=SqAjyOvEIV0HDzuNy3VJ9YaV4FPyX7PnCiDK7lPWcEpEZUNg08IWleLxd2qbAxlPu6
         6ykhn57Fp1swMK+XO/6sIvcky+ND47NxhBnKAhKE6Zmk3370TcpqxxEyaTE7AxHUW6Wm
         dZI2snWGjJX2MkhSfBGdKWewkxufwIKOUcfFdWddaWYPXb9eV41daqSdCZU9qtgK2ZMu
         v15x415BqRp+LsUaa0GdfNqHdd3NJY0ls82Q7cmbyXADqWfFL+xEYSMpYA6LIvvC4ng6
         Zkz/8VXi3HQCNa2DcFunQOLnWcgzp8E3GMV+CzAOodJ5SlSZEFtwTLyFGwpgw2+TRApd
         uUZA==
X-Gm-Message-State: ABuFfohkm0cYquUY8i7VvG1mjykNHXFUy02WFv4ST78ySkqsZNhF1dES
        RzXR1OVwpim07hkRWGO7uic=
X-Google-Smtp-Source: ACcGV60RQ/cCfepyrD2cRd2SBrRIHOmMWpn5RXb1dXZYs+27qt4+B8qaTUyGMNgnygMqTG5NNILCxQ==
X-Received: by 2002:aed:2f82:: with SMTP id m2-v6mr49228746qtd.85.1540320162268;
        Tue, 23 Oct 2018 11:42:42 -0700 (PDT)
Received: from localhost ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id o7-v6sm1432200qkc.67.2018.10.23.11.42.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 11:42:41 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     jcrouse@codeaurora.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/msm/gpu: add submit flag to hint which buffers should be dumped
Date:   Tue, 23 Oct 2018 14:42:37 -0400
Message-Id: <20181023184239.18771-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.17.2
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
index 66673ea9bf6f..a43dd946d208 100644
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
2.17.2

