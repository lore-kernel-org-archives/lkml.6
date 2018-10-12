Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3B4C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EEA420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEA420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbeJLXq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 19:46:27 -0400
Received: from gateway34.websitewelcome.com ([192.185.149.62]:36635 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728537AbeJLXq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 19:46:27 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 8C8632793D7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 11:13:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id B03LgQ6OF8YaUB03ggrLrO; Fri, 12 Oct 2018 11:13:14 -0500
X-Authority-Reason: nr=8
Received: from lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr ([80.15.51.183]:37192 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gB03K-003oBU-Hq; Fri, 12 Oct 2018 11:12:38 -0500
Date:   Fri, 12 Oct 2018 18:12:36 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/radeon/r300: Mark expected switch fall-throughs
Message-ID: <20181012161236.GA21768@embeddedor.com>
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
X-Source-IP: 80.15.51.183
X-Source-L: No
X-Exim-ID: 1gB03K-003oBU-Hq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: lputeaux-656-1-34-183.w80-15.abo.wanadoo.fr (embeddedor) [80.15.51.183]:37192
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

Notice that in this particular case, I replaced "Pass through." with
"Fall through.", which is what GCC is expecting to find.

Addresses-Coverity-ID: 114734 ("Missing break in switch")
Addresses-Coverity-ID: 114735 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/radeon/r300.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 21161aa..652126f 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -814,7 +814,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
 					  ((idx_value >> 21) & 0xF));
 				return -EINVAL;
 			}
-			/* Pass through. */
+			/* Fall through. */
 		case 6:
 			track->cb[i].cpp = 4;
 			break;
@@ -965,7 +965,7 @@ static int r300_packet0_check(struct radeon_cs_parser *p,
 				return -EINVAL;
 			}
 			/* The same rules apply as for DXT3/5. */
-			/* Pass through. */
+			/* Fall through. */
 		case R300_TX_FORMAT_DXT3:
 		case R300_TX_FORMAT_DXT5:
 			track->textures[i].cpp = 1;
-- 
2.7.4

