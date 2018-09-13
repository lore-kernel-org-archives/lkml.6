Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF31C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653FF2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 653FF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbeIMHsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:48:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43580 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeIMHsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:48:12 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0HYn-0006Oq-5z; Thu, 13 Sep 2018 02:40:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/50] presence of RS485 ioctls has been unconditional since 2014
Date:   Thu, 13 Sep 2018 03:40:00 +0100
Message-Id: <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180913023119.GQ19965@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/compat_ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a9b00942e87d..53bc3659dcef 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -749,12 +749,8 @@ COMPATIBLE_IOCTL(TIOCOUTQ)
 COMPATIBLE_IOCTL(TIOCSPGRP)
 COMPATIBLE_IOCTL(TIOCGPGRP)
 COMPATIBLE_IOCTL(TIOCSERGETLSR)
-#ifdef TIOCSRS485
 COMPATIBLE_IOCTL(TIOCSRS485)
-#endif
-#ifdef TIOCGRS485
 COMPATIBLE_IOCTL(TIOCGRS485)
-#endif
 #ifdef TCGETS2
 COMPATIBLE_IOCTL(TCGETS2)
 COMPATIBLE_IOCTL(TCSETS2)
-- 
2.11.0

