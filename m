Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D026ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5D320854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5D320854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388096AbeGWTt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:49:57 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.155]:22312 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387941AbeGWTt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:49:56 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 2C787400C80B3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:47:24 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id hfrFfrpoRPvAdhfrVfw19v; Mon, 23 Jul 2018 13:47:23 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=33114 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fhfrE-001Sr0-N3; Mon, 23 Jul 2018 13:46:56 -0500
Date:   Mon, 23 Jul 2018 13:46:55 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/msm: Replace PTR_RET with PTR_ERR_OR_ZERO
Message-ID: <20180723184655.GA15283@embeddedor.com>
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
X-Exim-ID: 1fhfrE-001Sr0-N3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:33114
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
index 8d907fa..25ddbb8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_io_util.c
@@ -35,7 +35,7 @@ int msm_dss_get_clk(struct device *dev, struct dss_clk *clk_arry, int num_clk)
 
 	for (i = 0; i < num_clk; i++) {
 		clk_arry[i].clk = clk_get(dev, clk_arry[i].clk_name);
-		rc = PTR_RET(clk_arry[i].clk);
+		rc = PTR_ERR_OR_ZERO(clk_arry[i].clk);
 		if (rc) {
 			DEV_ERR("%pS->%s: '%s' get failed. rc=%d\n",
 				__builtin_return_address(0), __func__,
-- 
2.7.4

