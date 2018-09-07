Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C786BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C8920855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C8920855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeIHCAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:00:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44996 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbeIHCAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:00:48 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F2B5EDC4;
        Fri,  7 Sep 2018 21:18:00 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christopher Ferris <cferris@google.com>,
        Elliott Hughes <enh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.18 068/145] eventpoll.h: wrap casts in () properly
Date:   Fri,  7 Sep 2018 23:08:54 +0200
Message-Id: <20180907210910.132300521@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 45cd74cb5061781e793a098c420a7f548fdc9e7d upstream.

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


