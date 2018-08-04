Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EFEC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9208F217B4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 00:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y71VCIBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9208F217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbeHDB7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 21:59:39 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44448 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731990AbeHDB7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 21:59:39 -0400
Received: by mail-pl0-f68.google.com with SMTP id ba4-v6so3204896plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 17:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TeDGWoUCE1/7nYGv9ZuhCQ6I7+aZQaGsKzWeIInoLbA=;
        b=Y71VCIBsHQBr523kwGBnnb+r5x20Af2j5Y81GuGM5GuaAXlMD4BKKjU1DI0wO61N6b
         Z8474z0dRAoTaUKqnxxeVBmUY2IcRtG1LMczsE9dunRhumcAyyDXY+EzSdboF9ItT8Y4
         ry+wj1cXTjFmIqNKdLo8QjSVd9r2N7pECv3NOb/NxmFEC3SNLnTeX95nRdSoTpXuwThz
         aOPZvsYp6LlkQRoIQhGYwuIWVOq2LwV79Ok5elGWBjBDwe42KZ6kLkVMvdYOm4EiXsOC
         +impkNM86QgCQsO8kWaRhS5S0Goku25ghrZQt3dZ8E2MxXwMyPCBfYBfMY2ZEdxu6f5w
         Gzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TeDGWoUCE1/7nYGv9ZuhCQ6I7+aZQaGsKzWeIInoLbA=;
        b=AW401nknEt7KDQmXLjakG08TK5KbwekqcYbXrbfW2WcyWbLoBWmFk2Xn1xB5r2YgoC
         fVEGUS5c/ozXCz3D1cKRntx9Chb/w6l2lMdZcImpyBOvybRI64lUZ7kLah6lzndzO7lG
         +MS38H6VrahzOhI4uImwLQHDHMkrHQ/dwK0b3BWvprhYC9iafFn5SHUh/upT436vn8mO
         +j/E7T6plm7w1d2G3nIMeUmiA93VX8vhmlaP2uCBqWYNpTS8M0uYO0aYl+swfuS9QkDF
         GJoNo62/JirUWU83WhmeILheyWJEq0Mu4PLMTMdFbeqnwneNGXAvRgi/drk6uQ4wC3Z2
         vO8w==
X-Gm-Message-State: AOUpUlE13R+wuAoh5dxY1TO+kx7ypvnGmbzvtead0CwNX4BDw0V3QICR
        Op/dCg3LteeCR+kjzGIZQWk=
X-Google-Smtp-Source: AAOMgpemKyrsAKSsprEEiB/BUCAkZ/udhDJiYHdtJJLmCg22nFSmLdwm3uiwyVbc9+ZMAqY5YiHgXA==
X-Received: by 2002:a17:902:7896:: with SMTP id q22-v6mr5374852pll.47.1533340870474;
        Fri, 03 Aug 2018 17:01:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:80c0:93b4:a4e2:6d2f])
        by smtp.gmail.com with ESMTPSA id s14-v6sm14369312pfj.105.2018.08.03.17.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:01:09 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: radeon_test: Replace mdelay() with msleep()
Date:   Sat,  4 Aug 2018 08:01:02 +0800
Message-Id: <20180804000102.17737-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

radeon_test_ring_sync() and radeon_test_ring_sync2() are never 
called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
index f5e9abfadb56..411efa303f54 100644
--- a/drivers/gpu/drm/radeon/radeon_test.c
+++ b/drivers/gpu/drm/radeon/radeon_test.c
@@ -347,7 +347,7 @@ void radeon_test_ring_sync(struct radeon_device *rdev,
 	if (r)
 		goto out_cleanup;
 
-	mdelay(1000);
+	msleep(1000);
 
 	if (radeon_fence_signaled(fence1)) {
 		DRM_ERROR("Fence 1 signaled without waiting for semaphore.\n");
@@ -368,7 +368,7 @@ void radeon_test_ring_sync(struct radeon_device *rdev,
 		goto out_cleanup;
 	}
 
-	mdelay(1000);
+	msleep(1000);
 
 	if (radeon_fence_signaled(fence2)) {
 		DRM_ERROR("Fence 2 signaled without waiting for semaphore.\n");
@@ -441,7 +441,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 	if (r)
 		goto out_cleanup;
 
-	mdelay(1000);
+	msleep(1000);
 
 	if (radeon_fence_signaled(fenceA)) {
 		DRM_ERROR("Fence A signaled without waiting for semaphore.\n");
@@ -461,7 +461,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 	radeon_ring_unlock_commit(rdev, ringC, false);
 
 	for (i = 0; i < 30; ++i) {
-		mdelay(100);
+		msleep(100);
 		sigA = radeon_fence_signaled(fenceA);
 		sigB = radeon_fence_signaled(fenceB);
 		if (sigA || sigB)
@@ -486,7 +486,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 	radeon_semaphore_emit_signal(rdev, ringC->idx, semaphore);
 	radeon_ring_unlock_commit(rdev, ringC, false);
 
-	mdelay(1000);
+	msleep(1000);
 
 	r = radeon_fence_wait(fenceA, false);
 	if (r) {
-- 
2.17.0

