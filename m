Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE35C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147792146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 147792146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIMHsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43638 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbeIMHsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:14 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYp-0006QP-50; Thu, 13 Sep 2018 02:40:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/50] rfcomm: get rid of mentioning TIOC[SG]SERIAL
Date:   Thu, 13 Sep 2018 03:40:15 +0100
Message-Id: <20180913024049.24567-16-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

no support there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 net/bluetooth/rfcomm/tty.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index 5e44d842cc5d..ba4f59389405 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -839,14 +839,6 @@ static int rfcomm_tty_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned l
 		BT_DBG("TIOCMIWAIT");
 		break;
 
-	case TIOCGSERIAL:
-		BT_ERR("TIOCGSERIAL is not supported");
-		return -ENOIOCTLCMD;
-
-	case TIOCSSERIAL:
-		BT_ERR("TIOCSSERIAL is not supported");
-		return -ENOIOCTLCMD;
-
 	case TIOCSERGSTRUCT:
 		BT_ERR("TIOCSERGSTRUCT is not supported");
 		return -ENOIOCTLCMD;
-- 
2.11.0

