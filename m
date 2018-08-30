Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C72C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC3720835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC3720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHaBQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:16:27 -0400
Received: from gloria.sntech.de ([185.11.138.130]:55360 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbeHaBQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:16:26 -0400
Received: from ip5f5a866f.dynamic.kabel-deutschland.de ([95.90.134.111] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fvUEi-00009T-BY; Thu, 30 Aug 2018 23:12:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com
Cc:     seanpaul@chromium.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v8 3/3] drm/rockchip: Add directly output rgb feature for px30
Date:   Thu, 30 Aug 2018 23:12:07 +0200
Message-Id: <20180830211207.10480-4-heiko@sntech.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180830211207.10480-1-heiko@sntech.de>
References: <20180830211207.10480-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandy Huang <hjc@rock-chips.com>

Add this feature bit indicate px30 vop can directly output
parallel or serial rgb data.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 7f29913824ce..09910d3b01ce 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -276,6 +276,7 @@ static const struct vop_win_data px30_vop_big_win_data[] = {
 
 static const struct vop_data px30_vop_big = {
 	.intr = &px30_intr,
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.common = &px30_common,
 	.modeset = &px30_modeset,
 	.output = &px30_output,
@@ -290,6 +291,7 @@ static const struct vop_win_data px30_vop_lit_win_data[] = {
 
 static const struct vop_data px30_vop_lit = {
 	.intr = &px30_intr,
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.common = &px30_common,
 	.modeset = &px30_modeset,
 	.output = &px30_output,
-- 
2.17.0

