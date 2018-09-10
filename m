Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA33C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF9020870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF9020870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbeIJQ5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:57:45 -0400
Received: from shell.v3.sk ([90.176.6.54]:36108 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIJQ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:57:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 80A47B8258;
        Mon, 10 Sep 2018 14:03:58 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BnA2fybz0RiL; Mon, 10 Sep 2018 14:03:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5DF28B825F;
        Mon, 10 Sep 2018 14:03:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xjy-CsOJadGi; Mon, 10 Sep 2018 14:03:55 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id D9053B8258;
        Mon, 10 Sep 2018 14:03:54 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] pxa168fb: prepare the clock
Date:   Mon, 10 Sep 2018 14:03:51 +0200
Message-Id: <20180910120351.164257-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  ------------[ cut here ]------------
  WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:874 clk_core_enable+0x2c/0x1b0
  Enabling unprepared disp0_clk
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc8-00032-g02b43ddd4f21-dirty #25
  Hardware name: Marvell MMP2 (Device Tree Support)
  [<c010f7cc>] (unwind_backtrace) from [<c010cc6c>] (show_stack+0x10/0x14)
  [<c010cc6c>] (show_stack) from [<c011dab4>] (__warn+0xd8/0xf0)
  [<c011dab4>] (__warn) from [<c011db10>] (warn_slowpath_fmt+0x44/0x6c)
  [<c011db10>] (warn_slowpath_fmt) from [<c043898c>] (clk_core_enable+0x2c/0x1b0)
  [<c043898c>] (clk_core_enable) from [<c0439ec8>] (clk_core_enable_lock+0x18/0x2c)
  [<c0439ec8>] (clk_core_enable_lock) from [<c0436698>] (pxa168fb_probe+0x464/0x6ac)
  [<c0436698>] (pxa168fb_probe) from [<c04779a0>] (platform_drv_probe+0x48/0x94)
  [<c04779a0>] (platform_drv_probe) from [<c0475bec>] (driver_probe_device+0x328/0x470)
  [<c0475bec>] (driver_probe_device) from [<c0475de4>] (__driver_attach+0xb0/0x124)
  [<c0475de4>] (__driver_attach) from [<c0473c38>] (bus_for_each_dev+0x64/0xa0)
  [<c0473c38>] (bus_for_each_dev) from [<c0474ee0>] (bus_add_driver+0x1b8/0x230)
  [<c0474ee0>] (bus_add_driver) from [<c0476a20>] (driver_register+0xac/0xf0)
  [<c0476a20>] (driver_register) from [<c0102dd4>] (do_one_initcall+0xb8/0x1f0)
  [<c0102dd4>] (do_one_initcall) from [<c0b010a0>] (kernel_init_freeable+0x294/0x2e0)
  [<c0b010a0>] (kernel_init_freeable) from [<c07e9eb8>] (kernel_init+0x8/0x10c)
  [<c07e9eb8>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
  Exception stack(0xd008bfb0 to 0xd008bff8)
  bfa0:                                     00000000 00000000 00000000 00000000
  bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
  bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
  ---[ end trace c0af40f9e2ed7cb4 ]---

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/video/fbdev/pxa168fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index def3a501acd6..d059d04c63ac 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -712,7 +712,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * enable controller clock
 	 */
-	clk_enable(fbi->clk);
+	clk_prepare_enable(fbi->clk);
 
 	pxa168fb_set_par(info);
 
@@ -767,7 +767,7 @@ static int pxa168fb_probe(struct platform_device *pdev)
 failed_free_cmap:
 	fb_dealloc_cmap(&info->cmap);
 failed_free_clk:
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 failed_free_fbmem:
 	dma_free_coherent(fbi->dev, info->fix.smem_len,
 			info->screen_base, fbi->fb_start_dma);
@@ -807,7 +807,7 @@ static int pxa168fb_remove(struct platform_device *pdev)
 	dma_free_wc(fbi->dev, PAGE_ALIGN(info->fix.smem_len),
 		    info->screen_base, info->fix.smem_start);
 
-	clk_disable(fbi->clk);
+	clk_disable_unprepare(fbi->clk);
 
 	framebuffer_release(info);
 
-- 
2.17.1

