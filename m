Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167EDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BC920663
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692992;
	bh=kaaZFqU7wdDoUyTm3FnFQ/35l1oajLZmKeQswqonMmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DqWo8/U7UScAjTuc+fnoxj1fyiKIo5TvDEMpYYCIONfVlg061higI3aHN20SmXuJL
	 3tq93vqyMiOLf3GIDcOHodPGqJe1aGYbzhHNnis/v8KAbaqrQUMI4PE1KD3sQ6vi3Z
	 HCWncGLOJTiise0J5rg68/lyiIfxrQvQy83HJzRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390449AbfA1Q1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:27:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390438AbfA1Q1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:27:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E11F02171F;
        Mon, 28 Jan 2019 16:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692856;
        bh=kaaZFqU7wdDoUyTm3FnFQ/35l1oajLZmKeQswqonMmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MgaaCNE32czMQhyeBfRAyke4L23yluWwp5K/y7hIbmujQ6BLtTh1alimpZHr/Vy2
         bAvqlOs0sVT3jtcPRwoNGpwIkKk0OMpyjay4e0IyWL1iOEF+tt0LB2Ta6X92oL/bua
         OlvNGJK/KBIGajOr0K6dYpJzWba3Mgj7FJ1r3qw0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 42/61] video: clps711x-fb: release disp device node in probe()
Date:   Mon, 28 Jan 2019 11:26:04 -0500
Message-Id: <20190128162623.59854-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit fdac751355cd76e049f628afe6acb8ff4b1399f7 ]

clps711x_fb_probe() increments refcnt of disp device node by
of_parse_phandle() and leaves it undecremented on both
successful and error paths.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/clps711x-fb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
index 49a7bb4ef02f..dd8fd28d6132 100644
--- a/drivers/video/fbdev/clps711x-fb.c
+++ b/drivers/video/fbdev/clps711x-fb.c
@@ -287,14 +287,17 @@ static int clps711x_fb_probe(struct platform_device *pdev)
 	}
 
 	ret = of_get_fb_videomode(disp, &cfb->mode, OF_USE_NATIVE_MODE);
-	if (ret)
+	if (ret) {
+		of_node_put(disp);
 		goto out_fb_release;
+	}
 
 	of_property_read_u32(disp, "ac-prescale", &cfb->ac_prescale);
 	cfb->cmap_invert = of_property_read_bool(disp, "cmap-invert");
 
 	ret = of_property_read_u32(disp, "bits-per-pixel",
 				   &info->var.bits_per_pixel);
+	of_node_put(disp);
 	if (ret)
 		goto out_fb_release;
 
-- 
2.19.1

