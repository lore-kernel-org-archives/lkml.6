Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0244C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628DC208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 628DC208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933823AbeGJPPm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:15:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933374AbeGJPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:15:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B8504D61;
        Tue, 10 Jul 2018 15:15:40 +0000 (UTC)
Date:   Tue, 10 Jul 2018 17:15:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christopher Ferris <cferris@google.com>,
        Elliott Hughes <enh@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] eventpoll.h: wrap casts in () properly
Message-ID: <20180710151538.GA28739@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

When importing the latest copy of the kernel headers into Bionic,
Christpher and Elliott noticed that the eventpoll.h casts were not
wrapped in ().  As it is, clang complains about macros without
surrounding (), so this makes it a pain for userspace tools.

So fix it up by adding another () pair, and make them line up purty by
using tabs.

Fixes: 65aaf87b3aa2 ("add EPOLLNVAL, annotate EPOLL... and event_poll->event")
Reported-by: Christopher Ferris <cferris@google.com>
Reported-by: Elliott Hughes <enh@google.com>
Cc: stable <stable@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/eventpoll.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Al, I can take this through my tree if you don't want to bother with it,
just let me know.

thanks,

greg k-h


--- a/include/uapi/linux/eventpoll.h
+++ b/include/uapi/linux/eventpoll.h
@@ -42,7 +42,7 @@
 #define EPOLLRDHUP	(__force __poll_t)0x00002000
 
 /* Set exclusive wakeup mode for the target file descriptor */
-#define EPOLLEXCLUSIVE (__force __poll_t)(1U << 28)
+#define EPOLLEXCLUSIVE	((__force __poll_t)(1U << 28))
 
 /*
  * Request the handling of system wakeup events so as to prevent system suspends
@@ -54,13 +54,13 @@
  *
  * Requires CAP_BLOCK_SUSPEND
  */
-#define EPOLLWAKEUP (__force __poll_t)(1U << 29)
+#define EPOLLWAKEUP	((__force __poll_t)(1U << 29))
 
 /* Set the One Shot behaviour for the target file descriptor */
-#define EPOLLONESHOT (__force __poll_t)(1U << 30)
+#define EPOLLONESHOT	((__force __poll_t)(1U << 30))
 
 /* Set the Edge Triggered behaviour for the target file descriptor */
-#define EPOLLET (__force __poll_t)(1U << 31)
+#define EPOLLET		((__force __poll_t)(1U << 31))
 
 /* 
  * On x86-64 make the 64bit structure have the same alignment as the
