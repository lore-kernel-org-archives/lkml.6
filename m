Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05E6C61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763222146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 763222146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeIMHts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:49:48 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43796 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeIMHsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYt-0006TN-3v; Thu, 13 Sep 2018 02:40:55 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 42/50] remove fallback to drivers for TIOCGICOUNT
Date:   Thu, 13 Sep 2018 03:40:41 +0100
Message-Id: <20180913024049.24567-42-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

none of them handles it anyway.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/tty/tty_io.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index b389163c4c5e..0f75ae6bfaa7 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2606,11 +2606,7 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case TIOCMBIS:
 		return tty_tiocmset(tty, cmd, p);
 	case TIOCGICOUNT:
-		retval = tty_tiocgicount(tty, p);
-		/* For the moment allow fall through to the old method */
-        	if (retval != -EINVAL)
-			return retval;
-		break;
+		return tty_tiocgicount(tty, p);
 	case TCFLSH:
 		switch (arg) {
 		case TCIFLUSH:
-- 
2.11.0

