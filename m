Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933577AbeDXNPz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 09:15:55 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.65]:41538 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933220AbeDXNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 09:15:47 -0400
X-Authority-Reason: nr=8
Date: Tue, 24 Apr 2018 08:15:45 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/selftests: Fix uninitialized variable
Message-ID: <20180424131545.GA4053@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.48.65
X-Source-L: No
X-Exim-ID: 1fAxnO-002UtM-5V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:55476
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which variable err is
returned without being properly initialized previously.

Fix this by initializing variable err to 0.

Addresses-Coverity-ID: 1468362 ("Uninitialized scalar variable")
Fixes: f4ecfbfc32ed ("drm/i915: Check whitelist registers across resets")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/selftests/intel_workarounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/selftests/intel_workarounds.c b/drivers/gpu/drm/i915/selftests/intel_workarounds.c
index 5455b26..17444a3 100644
--- a/drivers/gpu/drm/i915/selftests/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/selftests/intel_workarounds.c
@@ -239,7 +239,7 @@ static int live_reset_whitelist(void *arg)
 	struct intel_engine_cs *engine = i915->engine[RCS];
 	struct i915_gpu_error *error = &i915->gpu_error;
 	struct whitelist w;
-	int err;
+	int err = 0;
 
 	/* If we reset the gpu, we should not lose the RING_NONPRIV */
 
-- 
2.7.4
