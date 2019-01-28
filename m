Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09051C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0DF2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691752;
	bh=VJHfTeWE69BzaokekwoAcSIM5OmZnXbFokFQuWGBqaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N1m4R4Oz7hfrfdzGqCOsPS2Q6ydzQRMNo697JxKbpJ5TYaLuLoy6sn4EwRueRqyEB
	 /YO6k0tqEqv+82FyJsM3aPRc7oZBpeqoKYVdg4S062ZvhUoM16rO9o/zA2AuEBlLrL
	 gQoG2L+DGEov6NNNOSwJ3aF6vI31O64W5odDk5Ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfA1QJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:09:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:33416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731941AbfA1QJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D282084A;
        Mon, 28 Jan 2019 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691747;
        bh=VJHfTeWE69BzaokekwoAcSIM5OmZnXbFokFQuWGBqaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=forGuKRLbmYT/NB65GziIVIBTf8TUuCxBm9yzE8td2+9Nuozvx3cAnb5+0W9LESJA
         IW8F5xF19bvHufJ5vNN+6vDDZYkIWe1P5iqOojOvlMt+WwLrE9gtdvP+NFTnDzl7+L
         LV45rWF3EYxvBM8Y1Mo5HNlPHvuvEGHVZSxElvR8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 204/258] video: clps711x-fb: release disp device node in probe()
Date:   Mon, 28 Jan 2019 10:58:30 -0500
Message-Id: <20190128155924.51521-204-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index ff561073ee4e..42f909618f04 100644
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

