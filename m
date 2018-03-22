Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCVSV7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:21:59 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.196]:42011 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751455AbeCVSV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:21:58 -0400
Date: Thu, 22 Mar 2018 13:21:54 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Chris Wilson <chris@chris-wilson.co.uk>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>
Cc: intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915/gvt/scheduler: Remove unnecessary NULL checks in
 sr_oa_regs
Message-ID: <20180322182154.GA21590@embeddedgus>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1ez4qa-0046zM-6U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:52536
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks are misleading and not required [1].

[1] https://lkml.org/lkml/2018/3/19/1792

Addresses-Coverity-ID: 1466017
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/gvt/scheduler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 78588ef..b6da223 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -74,7 +74,7 @@ static void sr_oa_regs(struct intel_vgpu_workload *workload,
 		i915_mmio_reg_offset(EU_PERF_CNTL6),
 	};
 
-	if (!workload || !reg_state || workload->ring_id != RCS)
+	if (workload->ring_id != RCS)
 		return;
 
 	if (save) {
-- 
2.7.4
