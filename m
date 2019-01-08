Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335CDC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03BCA2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfAHGtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:49:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfAHGtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:49:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x086muWI3399855
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 7 Jan 2019 22:48:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x086muKT3399852;
        Mon, 7 Jan 2019 22:48:56 -0800
Date:   Mon, 7 Jan 2019 22:48:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tycho Andersen <tipbot@zytor.com>
Message-ID: <tip-a77d1d196bc63b37d9b4d1b614884669e8e79d32@git.kernel.org>
Cc:     bp@alien8.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, keescook@chromium.org,
        jmorris@namei.org, tycho@tycho.ws, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, bp@alien8.de, keescook@chromium.org,
          jmorris@namei.org, tycho@tycho.ws
In-Reply-To: <20190107231631.1849-1-tycho@tycho.ws>
References: <20190107231631.1849-1-tycho@tycho.ws>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] samples/seccomp: Fix 32-bit build
Git-Commit-ID: a77d1d196bc63b37d9b4d1b614884669e8e79d32
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

Commit-ID:  a77d1d196bc63b37d9b4d1b614884669e8e79d32
Gitweb:     https://git.kernel.org/tip/a77d1d196bc63b37d9b4d1b614884669e8e79d32
Author:     Tycho Andersen <tycho@tycho.ws>
AuthorDate: Mon, 7 Jan 2019 16:16:31 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 8 Jan 2019 07:45:01 +0100

samples/seccomp: Fix 32-bit build

Both the .o and the actual executable need to be built with -m32 in order
to link correctly.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Tycho Andersen <tycho@tycho.ws>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: James Morris <jmorris@namei.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")
Link: http://lkml.kernel.org/r/20190107231631.1849-1-tycho@tycho.ws
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 samples/seccomp/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 4920903c8009..fb43a814d4c0 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -34,6 +34,7 @@ HOSTCFLAGS_bpf-direct.o += $(MFLAG)
 HOSTCFLAGS_dropper.o += $(MFLAG)
 HOSTCFLAGS_bpf-helper.o += $(MFLAG)
 HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
+HOSTCFLAGS_user-trap.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
