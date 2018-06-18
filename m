Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1131EC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9751208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9751208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933650AbeFRPjR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:39:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:52267 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752877AbeFRPjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:39:15 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0LaHLm-1fvnLw2x7W-00m7Rl; Mon, 18 Jun 2018 17:38:58 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Mahesh Kumar <mahesh1.kumar@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i915: remove timespec_to_jiffies_timeout
Date:   Mon, 18 Jun 2018 17:38:43 +0200
Message-Id: <20180618153855.2126048-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:IRb8mVSQ+Gj9fFmjbMGgIO3Cqt6iGRS8zJJf9ZwifaBf65BAurY
 S91maZj2IDuDTVHuinD2rp4CygQnH1XiWNXbTRTZNGBscH/ZR+G/mZtMr+O582T7zZrm7bf
 e6dFCydmhWKgIiZklUOqaK1L0CzJ/v7LmT8oBKPIQwgVDA0qGdPyZlQlMXHQAbYmL0rGRl7
 qBV+g10nXUbk8qNtWgOYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tbX1LIrG9DI=:Zy4VjHWpZpTw76AJTz0L58
 v4a5tRL/XxYlm42P9NUF+vBJPBxzHgwGwZzo0BkSjkqacBhLev3UbbSdCBEfih8uHR6d6HTJe
 qBwXW6Esyu1ESxgKnmGuwdUPCQeNYYnL3Y7OG6goy3e1nbrTao3YBwgghY1v1FU43lY9o+WSj
 /lx9qNNxdOiugGhIx1HcLBGCXE0UDJf5yG5yhr88hNS8lYIXKeHtZ4TuTRb8VJG2Hyw5IBmH+
 QrhVz8At0N7j722VbgbN7vGWHDtQtYV4wdS9TCIuC0Z13ZXXajo/ODdBuwF4e69rSCgvKxz3d
 Vt+5jTHRSbYMd6+/lmeGatWT6sgD0gyYiMZ/vkbFR9zcJiE4BEyLauHeayxM+Yxz3nBJamWW4
 Z44Hiak7UFQWTXR3lrTMgcXujfgI+C1pAD08s8edeSbp2dfkkgCpxMiurNkK8mVXtP4mwGkNT
 KAjDskBb/VoNH0PhJhLxpuzkGgEc2huejrQpeo7gMJ7p09qmQnzoteOMDTVRz3t4i1Gl+yFaP
 VyQ+55/vyoSIk+RhbCeVEJcXOlWRmUG+T1TXyxawBw2uvKreqBChgksrK1kHz8pbp8ess88lX
 jbUxJa6bUzLNJZ6HRmFk7kj4P6ihur80zK4e/KRdr5fNe7yBsdVBXh4bLQPTMa+UNymz1E9yr
 p0smdavKm20KEBUU/v8BxFBLsaSjPA4pibe3nvwYfzHFeS581CZbMXOmPVa70zacbCH0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has been unused since commit 5ed0bdf21a85 ("drm: i915:
Use nsec based interfaces"). Let's remove the definition as well now
to help get rid of all uses of 'timespec'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/i915/i915_drv.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 34c125e2d90c..5f61676e8fb8 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -3673,14 +3673,6 @@ static inline unsigned long nsecs_to_jiffies_timeout(const u64 n)
         return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(n) + 1);
 }
 
-static inline unsigned long
-timespec_to_jiffies_timeout(const struct timespec *value)
-{
-	unsigned long j = timespec_to_jiffies(value);
-
-	return min_t(unsigned long, MAX_JIFFY_OFFSET, j + 1);
-}
-
 /*
  * If you need to wait X milliseconds between events A and B, but event B
  * doesn't happen exactly after event A, you record the timestamp (jiffies) of
-- 
2.9.0

