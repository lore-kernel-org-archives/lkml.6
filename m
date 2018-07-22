Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581E8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CF62086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06CF62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeGVGs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:48:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727830AbeGVGs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:48:28 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3448910369259;
        Sun, 22 Jul 2018 13:52:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.382.0; Sun, 22 Jul 2018 13:52:51 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mingo@redhat.com>, <tglx@linutronix.de>, <bskeggs@redhat.com>,
        <airlied@linux.ie>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH linux-next] driver/gpu: Fix mismatch in funciton argument type
Date:   Sun, 22 Jul 2018 13:41:28 +0800
Message-ID: <1532238088-11193-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

drivers/gpu/drm/nouveau/dispnv50/wndw.c:570:1: error: symbol 'nv50_wndw_new_' redeclared with different type
(originally declared at drivers/gpu/drm/nouveau/dispnv50/wndw.h:39) - incompatible argument 7 (different signedness)

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/gpu/drm/nouveau/dispnv50/wndw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/wndw.h b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
index b0b6428..0770683 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/wndw.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/wndw.h
@@ -38,8 +38,8 @@ struct nv50_wndw {
 
 int nv50_wndw_new_(const struct nv50_wndw_func *, struct drm_device *,
 		   enum drm_plane_type, const char *name, int index,
-		   const u32 *format, enum nv50_disp_interlock_type,
-		   u32 interlock_data, u32 heads, struct nv50_wndw **);
+		   const u32 *format, u32 heads, enum nv50_disp_interlock_type,
+		   u32 interlock_data, struct nv50_wndw **);
 void nv50_wndw_init(struct nv50_wndw *);
 void nv50_wndw_fini(struct nv50_wndw *);
 void nv50_wndw_flush_set(struct nv50_wndw *, u32 *interlock,
-- 
1.7.12.4

