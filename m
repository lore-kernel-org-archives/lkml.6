Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA04C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598E320855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 598E320855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbeKIRuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:50:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42599 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbeKIRuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:50:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA989pmw2272479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 9 Nov 2018 00:09:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA989oQL2272476;
        Fri, 9 Nov 2018 00:09:50 -0800
Date:   Fri, 9 Nov 2018 00:09:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-bdf37b4dd35d2517cadc10735cd33022da7df133@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, sfr@canb.auug.org.au,
        mark.rutland@arm.com, will.deacon@arm.com, boqun.feng@gmail.com,
        torvalds@linux-foundation.org, mingo@kernel.org, bp@suse.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Reply-To: boqun.feng@gmail.com, will.deacon@arm.com, mark.rutland@arm.com,
          sfr@canb.auug.org.au, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, peterz@infradead.org, bp@suse.de,
          mingo@kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20181108194128.13368-1-bp@alien8.de>
References: <20181108194128.13368-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomics: Fix out-of-tree build
Git-Commit-ID: bdf37b4dd35d2517cadc10735cd33022da7df133
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

Commit-ID:  bdf37b4dd35d2517cadc10735cd33022da7df133
Gitweb:     https://git.kernel.org/tip/bdf37b4dd35d2517cadc10735cd33022da7df133
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Thu, 8 Nov 2018 20:41:28 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Nov 2018 09:06:01 +0100

locking/atomics: Fix out-of-tree build

Building a kernel out of tree with:

  make O=/tmp/b oldconfig
  cd /tmp/b
  make

gives this error:

    CALL    /mnt/kernel/kernel/linux/scripts/atomic/check-atomics.sh
  /bin/bash: scripts/atomic/check-atomics.sh: No such file or directory
  make[3]: *** [/mnt/kernel/kernel/linux/./Kbuild:86: old-atomics] Error 127
  make[3]: *** Waiting for unfinished jobs....

Make the command use the proper build prerequisite which is the absolute
path to the script.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: arnd@arndb.de
Cc: aryabinin@virtuozzo.com
Cc: catalin.marinas@arm.com
Cc: dvyukov@google.com
Cc: glider@google.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxdrivers@attotech.com
Fixes: 8d32588077bd ("locking/atomics: Check generated headers are up-to-date")
Link: http://lkml.kernel.org/r/20181108194128.13368-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kbuild b/Kbuild
index 47c9fe175bd9..780048056ac5 100644
--- a/Kbuild
+++ b/Kbuild
@@ -80,7 +80,7 @@ always += old-atomics
 targets += old-atomics
 
 quiet_cmd_atomics = CALL    $<
-      cmd_atomics = $(CONFIG_SHELL) scripts/atomic/check-atomics.sh
+      cmd_atomics = $(CONFIG_SHELL) $<
 
 old-atomics: scripts/atomic/check-atomics.sh FORCE
 	$(call cmd,atomics)
