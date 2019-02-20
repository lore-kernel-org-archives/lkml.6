Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D757720C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfBTMvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:51:06 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:49732 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbfBTMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:51:06 -0500
Received: from ramsan ([84.194.111.163])
        by albert.telenet-ops.be with bizsmtp
        id f0r11z00U3XaVaC060r1uC; Wed, 20 Feb 2019 13:51:03 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRL3-0001QJ-CN; Wed, 20 Feb 2019 13:51:01 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gwRL3-0008Ty-8w; Wed, 20 Feb 2019 13:51:01 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] vfs: Make __vfs_write() static
Date:   Wed, 20 Feb 2019 13:50:59 +0100
Message-Id: <20190220125059.32563-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vfs_write() was unexported, and removed from <linux/fs.h>, but
forgotten to be made static.

Fixes: eb031849d52e61d2 ("fs: unexport __vfs_read/__vfs_write")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/read_write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index ff3c5e6f87cfaa7c..4b328e45db36682a 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -478,8 +478,8 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	return ret;
 }
 
-ssize_t __vfs_write(struct file *file, const char __user *p, size_t count,
-		    loff_t *pos)
+static ssize_t __vfs_write(struct file *file, const char __user *p,
+			   size_t count, loff_t *pos)
 {
 	if (file->f_op->write)
 		return file->f_op->write(file, p, count, pos);
-- 
2.17.1

