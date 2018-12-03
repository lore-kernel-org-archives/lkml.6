Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBCBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3745C206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3745C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeLCGna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:43:30 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:16840 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeLCGn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:43:29 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id A7A444E04F7F2AD5C12B;
        Mon,  3 Dec 2018 14:43:26 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB36hNvC071283;
        Mon, 3 Dec 2018 14:43:23 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120314432881-14390111 ;
          Mon, 3 Dec 2018 14:43:28 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Timur Tabi <timur@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] fbdev: fsl-diu: remove redundant null check on cmap
Date:   Mon, 3 Dec 2018 14:43:17 +0800
Message-Id: <20181203064317.57054-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-03 14:43:29,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-03 14:43:23
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB36hNvC071283
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The null check on &info->cmap is redundant since cmap is a struct
inside fb=5Finfo and can never be null, so the check is always true.
we may remove it.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Timur Tabi <timur@kernel.org>
CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC: linux-fbdev@vger.kernel.org
CC: dri-devel@lists.freedesktop.org
CC: linux-kernel@vger.kernel.org
---
 drivers/video/fbdev/fsl-diu-fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu=
-fb.c
index 332a56b6811f..9a5451ba4d44 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1575,8 +1575,7 @@ static void uninstall=5Ffb(struct fb=5Finfo *info)
=20
 	unregister=5Fframebuffer(info);
 	unmap=5Fvideo=5Fmemory(info);
-	if (&info->cmap)
-		fb=5Fdealloc=5Fcmap(&info->cmap);
+	fb=5Fdealloc=5Fcmap(&info->cmap);
=20
 	mfbi->registered =3D 0;
 }
--=20
2.19.1

