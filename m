Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D82C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE3F2087C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 01:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE3F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rock-chips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbeH2FwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 01:52:24 -0400
Received: from regular1.263xmail.com ([211.150.99.136]:55956 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeH2FwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 01:52:24 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.11])
        by regular1.263xmail.com (Postfix) with ESMTP id CA0FA2FE;
        Wed, 29 Aug 2018 09:57:56 +0800 (CST)
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
Received: from localhost.localdomain (localhost [127.0.0.1])
        by smtp.263.net (Postfix) with ESMTPA id 40C273BF;
        Wed, 29 Aug 2018 09:57:27 +0800 (CST)
X-RL-SENDER: hjc@rock-chips.com
X-FST-TO: hjc@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: hjc@rock-chips.com
X-UNIQUE-TAG: <e3dbd10f913a060d531a23b86daa11d5>
X-ATTACHMENT-NUM: 0
X-SENDER: hjc@rock-chips.com
X-DNS-TYPE: 0
Received: from unknown (unknown [58.22.7.114])
        by smtp.263.net (Postfix) whith SMTP id 122529WO7H7;
        Wed, 29 Aug 2018 09:57:43 +0800 (CST)
From:   Sandy Huang <hjc@rock-chips.com>
To:     hjc@rock-chips.com, heiko@sntech.de, seanpaul@chromium.org,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] drm/rockchip: Add directly output rgb feature for px30
Date:   Wed, 29 Aug 2018 09:57:05 +0800
Message-Id: <1535507825-195695-4-git-send-email-hjc@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535507825-195695-1-git-send-email-hjc@rock-chips.com>
References: <1535507825-195695-1-git-send-email-hjc@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add this feature bit indicate px30 vop can directly output
parallel or serial rgb data.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index d824ca6..d2c3a5c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -278,6 +278,7 @@ static const struct vop_win_data px30_vop_big_win_data[] = {
 
 static const struct vop_data px30_vop_big = {
 	.intr = &px30_intr,
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.common = &px30_common,
 	.modeset = &px30_modeset,
 	.output = &px30_output,
@@ -292,6 +293,7 @@ static const struct vop_win_data px30_vop_lit_win_data[] = {
 
 static const struct vop_data px30_vop_lit = {
 	.intr = &px30_intr,
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.common = &px30_common,
 	.modeset = &px30_modeset,
 	.output = &px30_output,
-- 
2.7.4


