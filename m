Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1F7C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF6620872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF6620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeFTNb0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:31:26 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.18]:21175 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932226AbeFTNbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:31:25 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 6A6762260E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:31:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id VdCRfrPxGPvAdVdCdf1npo; Wed, 20 Jun 2018 08:31:24 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=59682 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fVdCP-003SkH-4O; Wed, 20 Jun 2018 08:31:01 -0500
Date:   Wed, 20 Jun 2018 08:31:00 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/i915: mark expected switch fall-through
Message-ID: <20180620133100.GA608@embeddedor.com>
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
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1fVdCP-003SkH-4O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:59682
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 14
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1470102 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/i915/intel_dpll_mgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/intel_dpll_mgr.c b/drivers/gpu/drm/i915/intel_dpll_mgr.c
index 132fe63..6a40a77 100644
--- a/drivers/gpu/drm/i915/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/intel_dpll_mgr.c
@@ -2566,6 +2566,7 @@ int icl_calc_dp_combo_pll_link(struct drm_i915_private *dev_priv,
 	switch (index) {
 	default:
 		MISSING_CASE(index);
+		/* fall through */
 	case 0:
 		link_clock = 540000;
 		break;
-- 
2.7.4

