Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9635FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4535720850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0gQIx24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4535720850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeGRUfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:35:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbeGRUfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:35:12 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990AB2084E;
        Wed, 18 Jul 2018 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531943746;
        bh=IX/aS3a9Ovh2LhlNCZq9yOjZAYoum4hj2Su72WUJz9k=;
        h=From:To:Cc:Subject:Date:From;
        b=g0gQIx24EZbLCASuQSpar0jShKzCnGxh7hBPmjXTuTe5XvJAgg3qZ/7hAGWPyX6ao
         UTOoM4VL0A+1KP8ON2RcPEkJ20Z7l2IiVUFJEhHbXDt0I9QE4rmpw56afV8fwjHaDP
         y0ccGBa0t4aSMYAWfvjM06ZN6AvsvKPs5QG3gG34=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tobias Jakobi <tjakobi@math.uni-bielefeld.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] drm/exynos/mixer: Remove unused local variable priv
Date:   Wed, 18 Jul 2018 21:55:20 +0200
Message-Id: <20180718195520.5226-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove local variable 'priv' to fix GCC warning:

    drivers/gpu/drm/exynos/exynos_mixer.c: In function 'mixer_initialize':
    drivers/gpu/drm/exynos/exynos_mixer.c:840:29: warning: variable 'priv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 272c79f5f5bf..b86ae2ab9590 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -837,8 +837,6 @@ static int mixer_initialize(struct mixer_context *mixer_ctx,
 			struct drm_device *drm_dev)
 {
 	int ret;
-	struct exynos_drm_private *priv;
-	priv = drm_dev->dev_private;
 
 	mixer_ctx->drm_dev = drm_dev;
 
-- 
2.14.1

