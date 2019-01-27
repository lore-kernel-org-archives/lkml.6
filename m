Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1617C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA12C214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 11:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfA0Lfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 06:35:45 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46439 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfA0Lfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 06:35:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0RBYBEV1007793
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 27 Jan 2019 03:34:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0RBY8rw1007790;
        Sun, 27 Jan 2019 03:34:08 -0800
Date:   Sun, 27 Jan 2019 03:34:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Lukas Bulwahn <tipbot@zytor.com>
Message-ID: <tip-62a8ddc93a8526eafbdc26e5ee3830e2e9f639e8@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        rlove@rlove.org, lukas.bulwahn@gmail.com, rml@tech9.net,
        corbet@lwn.net, torvalds@linux-foundation.org,
        peterz@infradead.org, hpa@zytor.com, efault@gmx.de,
        robert.w.love@intel.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
          peterz@infradead.org, corbet@lwn.net, robert.w.love@intel.com,
          efault@gmx.de, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, rml@tech9.net, rlove@rlove.org,
          lukas.bulwahn@gmail.com
In-Reply-To: <20190112060613.7115-1-lukas.bulwahn@gmail.com>
References: <20190112060613.7115-1-lukas.bulwahn@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] MAINTAINERS, sched: Drop PREEMPTIBLE KERNEL
 section entry
Git-Commit-ID: 62a8ddc93a8526eafbdc26e5ee3830e2e9f639e8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  62a8ddc93a8526eafbdc26e5ee3830e2e9f639e8
Gitweb:     https://git.kernel.org/tip/62a8ddc93a8526eafbdc26e5ee3830e2e9f639e8
Author:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate: Sat, 12 Jan 2019 07:06:13 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 27 Jan 2019 12:29:37 +0100

MAINTAINERS, sched: Drop PREEMPTIBLE KERNEL section entry

The PREEMPTIBLE KERNEL section entry seems quite outdated:

Robert Love is not actively maintaining the file anymore, nor a recorded
contributor to the files in the PREEMPTIBLE KERNEL section for the last
few years.

The mailing list kpreempt-tech@lists.sourceforge.net does not exist
anymore; the website just points to some very old patches for v2.4/v2.5.

So, let's delete the PREEMPTIBLE KERNEL section entry and clean this up:

- Documentation/preempt-locking.txt is not modified much anyway, and the
  changes in that file are generally maintained by Jonathan Corbet. So,
  we do not need to explicitly mention Documentation/preempt-locking.txt
  in MAINTAINERS.

- include/linux/preempt.h is maintained by Peter and Ingo, so we simply
  add that file to the SCHEDULER section entry.

I got directed to this issue, as I could not subscribe to the outdated
mailing list address and decided to investigate and then cleaned this up.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Robert Love <rlove@rlove.org>
Cc: Robert Love <rml@tech9.net>
Cc: Robert Love <robert.w.love@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190112060613.7115-1-lukas.bulwahn@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..2eea25ab58ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12226,14 +12226,6 @@ S:	Maintained
 F:	drivers/net/ppp/pptp.c
 W:	http://sourceforge.net/projects/accel-pptp
 
-PREEMPTIBLE KERNEL
-M:	Robert Love <rml@tech9.net>
-L:	kpreempt-tech@lists.sourceforge.net
-W:	https://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel
-S:	Supported
-F:	Documentation/preempt-locking.txt
-F:	include/linux/preempt.h
-
 PRINTK
 M:	Petr Mladek <pmladek@suse.com>
 M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
@@ -13456,6 +13448,7 @@ F:	kernel/sched/
 F:	include/linux/sched.h
 F:	include/uapi/linux/sched.h
 F:	include/linux/wait.h
+F:	include/linux/preempt.h
 
 SCR24X CHIP CARD INTERFACE DRIVER
 M:	Lubomir Rintel <lkundrak@v3.sk>
