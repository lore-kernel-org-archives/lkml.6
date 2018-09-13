Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3EDC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4AC12146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AC12146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbeIMHta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:49:30 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43832 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbeIMHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYt-0006U3-T2; Thu, 13 Sep 2018 02:40:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 48/50] compat_ioctl - kill keyboard ioctl handling
Date:   Thu, 13 Sep 2018 03:40:47 +0100
Message-Id: <20180913024049.24567-48-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

all of those are provided only by vt and s390 tty3270; both have
proper ->compat_ioctl()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/compat_ioctl.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 7eec04b6e757..0c445a03e682 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -644,9 +644,6 @@ static int compat_ioctl_preallocate(struct file *file,
 
 static unsigned int ioctl_pointer[] = {
 /* compatible ioctls first */
-COMPATIBLE_IOCTL(0x4B50)   /* KDGHWCLK - not in the kernel, but don't complain */
-COMPATIBLE_IOCTL(0x4B51)   /* KDSHWCLK - not in the kernel, but don't complain */
-
 /* Little t */
 COMPATIBLE_IOCTL(TIOCOUTQ)
 /* Little f */
@@ -663,23 +660,6 @@ COMPATIBLE_IOCTL(FIGETBSZ)
 COMPATIBLE_IOCTL(FIFREEZE)
 COMPATIBLE_IOCTL(FITHAW)
 COMPATIBLE_IOCTL(FITRIM)
-COMPATIBLE_IOCTL(KDGETKEYCODE)
-COMPATIBLE_IOCTL(KDSETKEYCODE)
-COMPATIBLE_IOCTL(KDGKBTYPE)
-COMPATIBLE_IOCTL(KDGETMODE)
-COMPATIBLE_IOCTL(KDGKBMODE)
-COMPATIBLE_IOCTL(KDGKBMETA)
-COMPATIBLE_IOCTL(KDGKBENT)
-COMPATIBLE_IOCTL(KDSKBENT)
-COMPATIBLE_IOCTL(KDGKBSENT)
-COMPATIBLE_IOCTL(KDSKBSENT)
-COMPATIBLE_IOCTL(KDGKBDIACR)
-COMPATIBLE_IOCTL(KDSKBDIACR)
-COMPATIBLE_IOCTL(KDGKBDIACRUC)
-COMPATIBLE_IOCTL(KDSKBDIACRUC)
-COMPATIBLE_IOCTL(KDKBDREP)
-COMPATIBLE_IOCTL(KDGKBLED)
-COMPATIBLE_IOCTL(KDGETLED)
 #ifdef CONFIG_BLOCK
 /* Big S */
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_IDLUN)
@@ -1185,15 +1165,6 @@ static long do_ioctl_trans(unsigned int cmd,
 	case HOT_ADD_DISK:
 	case SET_DISK_FAULTY:
 	case SET_BITMAP_FILE:
-	/* Big K */
-	case KDSIGACCEPT:
-	case KIOCSOUND:
-	case KDMKTONE:
-	case KDSETMODE:
-	case KDSKBMODE:
-	case KDSKBMETA:
-	case KDSKBLED:
-	case KDSETLED:
 		return vfs_ioctl(file, cmd, arg);
 	}
 
-- 
2.11.0

