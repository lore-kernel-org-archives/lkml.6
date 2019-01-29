Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5033C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41520856
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfA2UUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:20:12 -0500
Received: from gateway30.websitewelcome.com ([192.185.179.30]:12470 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727308AbfA2UUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:20:12 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id C03E57DF1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 14:20:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id oZregTSx6dnCeoZregVJzb; Tue, 29 Jan 2019 14:20:10 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=48556 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1goZrd-001B58-TT; Tue, 29 Jan 2019 14:20:10 -0600
Date:   Tue, 29 Jan 2019 14:20:06 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/savage: mark expected switch fall-throughs
Message-ID: <20190129202005.GA25789@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1goZrd-001B58-TT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:48556
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

drivers/gpu/drm/savage/savage_state.c:301:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/gpu/drm/savage/savage_state.c:438:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/gpu/drm/savage/savage_state.c:559:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
drivers/gpu/drm/savage/savage_state.c:697:8: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/savage/savage_state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/savage/savage_state.c b/drivers/gpu/drm/savage/savage_state.c
index 7559a820bd43..ebb8b7d32b33 100644
--- a/drivers/gpu/drm/savage/savage_state.c
+++ b/drivers/gpu/drm/savage/savage_state.c
@@ -299,6 +299,7 @@ static int savage_dispatch_dma_prim(drm_savage_private_t * dev_priv,
 	case SAVAGE_PRIM_TRILIST_201:
 		reorder = 1;
 		prim = SAVAGE_PRIM_TRILIST;
+		/* fall through */
 	case SAVAGE_PRIM_TRILIST:
 		if (n % 3 != 0) {
 			DRM_ERROR("wrong number of vertices %u in TRILIST\n",
@@ -436,6 +437,7 @@ static int savage_dispatch_vb_prim(drm_savage_private_t * dev_priv,
 	case SAVAGE_PRIM_TRILIST_201:
 		reorder = 1;
 		prim = SAVAGE_PRIM_TRILIST;
+		/* fall through */
 	case SAVAGE_PRIM_TRILIST:
 		if (n % 3 != 0) {
 			DRM_ERROR("wrong number of vertices %u in TRILIST\n",
@@ -557,6 +559,7 @@ static int savage_dispatch_dma_idx(drm_savage_private_t * dev_priv,
 	case SAVAGE_PRIM_TRILIST_201:
 		reorder = 1;
 		prim = SAVAGE_PRIM_TRILIST;
+		/* fall through */
 	case SAVAGE_PRIM_TRILIST:
 		if (n % 3 != 0) {
 			DRM_ERROR("wrong number of indices %u in TRILIST\n", n);
@@ -695,6 +698,7 @@ static int savage_dispatch_vb_idx(drm_savage_private_t * dev_priv,
 	case SAVAGE_PRIM_TRILIST_201:
 		reorder = 1;
 		prim = SAVAGE_PRIM_TRILIST;
+		/* fall through */
 	case SAVAGE_PRIM_TRILIST:
 		if (n % 3 != 0) {
 			DRM_ERROR("wrong number of indices %u in TRILIST\n", n);
-- 
2.20.1

