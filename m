Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD07C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA2720880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA2720880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeISU0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:26:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49004 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730986AbeISU0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:26:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 45450EFFB345E;
        Wed, 19 Sep 2018 22:48:28 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 22:48:25 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <airlied@linux.ie>
CC:     <bskeggs@redhat.com>, <okaya@codeaurora.org>, <helgaas@kernel.org>,
        <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: nouveau: remove a redundant local variable 'pclks'
Date:   Wed, 19 Sep 2018 22:36:04 +0800
Message-ID: <1537367764-59819-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable 'pclks' is never used after being assigned.
hence it should be redundant and can be removed.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv04/arb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/arb.c b/drivers/gpu/drm/nouveau/dispnv04/arb.c
index c79160c..cae8f71 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/arb.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/arb.c
@@ -56,7 +56,7 @@ struct nv_sim_state {
 nv04_calc_arb(struct nv_fifo_info *fifo, struct nv_sim_state *arb)
 {
 	int pagemiss, cas, width, bpp;
-	int nvclks, mclks, pclks, crtpagemiss;
+	int nvclks, mclks, crtpagemiss;
 	int found, mclk_extra, mclk_loop, cbs, m1, p1;
 	int mclk_freq, pclk_freq, nvclk_freq;
 	int us_m, us_n, us_p, crtc_drain_rate;
@@ -71,7 +71,6 @@ struct nv_sim_state {
 	bpp = arb->bpp;
 	cbs = 128;
 
-	pclks = 2;
 	nvclks = 10;
 	mclks = 13 + cas;
 	mclk_extra = 3;
-- 
1.7.12.4

