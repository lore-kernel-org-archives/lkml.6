Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F944C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B50121567
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 03:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B50121567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbeHQGNC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 02:13:02 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56586 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQGNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 02:13:02 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A8C8CB51FB84DF267005;
        Fri, 17 Aug 2018 11:11:22 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7H3BDmC066519;
        Fri, 17 Aug 2018 11:11:13 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from localhost.localdomain ([10.75.10.200])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018081711112178-4868553 ;
          Fri, 17 Aug 2018 11:11:21 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     airlied@linux.ie
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        wen.yang99@zte.com.cn, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] drm/amd/display: fix a compile warning
Date:   Fri, 17 Aug 2018 11:09:48 +0800
Message-Id: <1534475388-40036-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-17 11:11:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-17 11:10:58
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn w7H3BDmC066519
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix comile warning like,
  CC [M]  drivers/gpu/drm/i915/gvt/execlist.o
  CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.o
  CC [M]  drivers/gpu/drm/radeon/btc_dpm.o
  CC [M]  drivers/isdn/hisax/avm_a1p.o
  CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.o
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function ‘dcn10_update_mpcc’:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1903:9: warning: missing braces around initializer [-Wmissing-braces]
  struct mpcc_blnd_cfg blnd_cfg = {0};
         ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1903:9: warning: (near initialization for ‘blnd_cfg.black_color’) [-Wmissing-braces]

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index cfcc54f..a06a035 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1900,7 +1900,7 @@ static void update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
 static void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	struct mpcc_blnd_cfg blnd_cfg = {0};
+	struct mpcc_blnd_cfg blnd_cfg = {{0}};
 	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
 	int mpcc_id;
 	struct mpcc *new_mpcc;
-- 
1.8.3.1

