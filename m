Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5FDECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757CF20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757CF20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anholt.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKIBxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:53:13 -0500
Received: from anholt.net ([50.246.234.109]:33386 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeKIBxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:53:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id CD19C10A130F;
        Thu,  8 Nov 2018 08:16:59 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id i7rQ6WZ7NHt6; Thu,  8 Nov 2018 08:16:58 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 6142B10A12AF;
        Thu,  8 Nov 2018 08:16:55 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 0C6C82FE1BF4; Thu,  8 Nov 2018 08:16:54 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, boris.brezillon@bootlin.com,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/4] drm/v3d: Update a comment about what uses v3d_job_dependency().
Date:   Thu,  8 Nov 2018 08:16:52 -0800
Message-Id: <20181108161654.19888-3-eric@anholt.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108161654.19888-1-eric@anholt.net>
References: <20181108161654.19888-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I merged bin and render's paths in a late refactoring.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 9243dea6e6ad..e1f2aab0717b 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -39,7 +39,7 @@ v3d_job_free(struct drm_sched_job *sched_job)
 }
 
 /**
- * Returns the fences that the bin job depends on, one by one.
+ * Returns the fences that the bin or render job depends on, one by one.
  * v3d_job_run() won't be called until all of them have been signaled.
  */
 static struct dma_fence *
-- 
2.19.1

