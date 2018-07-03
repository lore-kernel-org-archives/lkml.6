Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D333C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524E324C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524E324C34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933702AbeGCHwz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:52:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933028AbeGCHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:52:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w637qC9p202179
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 00:52:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w637qCnZ202176;
        Tue, 3 Jul 2018 00:52:12 -0700
Date:   Tue, 3 Jul 2018 00:52:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Masahiro Yamada <tipbot@zytor.com>
Message-ID: <tip-b5722a457b6e5eabd97a7f39c6c2b8e9a623ab15@git.kernel.org>
Cc:     yamada.masahiro@socionext.com, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, luto@kernel.org,
        richard@nod.at, torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, yamada.masahiro@socionext.com, hpa@zytor.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          jdike@addtoit.com, tglx@linutronix.de, richard@nod.at,
          torvalds@linux-foundation.org, luto@kernel.org
In-Reply-To: <1530582614-5173-2-git-send-email-yamada.masahiro@socionext.com>
References: <1530582614-5173-2-git-send-email-yamada.masahiro@socionext.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/build/vdso: Remove unused vdso-syms.lds
Git-Commit-ID: b5722a457b6e5eabd97a7f39c6c2b8e9a623ab15
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

Commit-ID:  b5722a457b6e5eabd97a7f39c6c2b8e9a623ab15
Gitweb:     https://git.kernel.org/tip/b5722a457b6e5eabd97a7f39c6c2b8e9a623ab15
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue, 3 Jul 2018 10:50:13 +0900
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 3 Jul 2018 09:20:07 +0200

x86/build/vdso: Remove unused vdso-syms.lds

This file contains symbol values, and was originally linked into
vmlinux, but I have no idea what it was actually used for.

Since the following commit:

  827880ec260b ("x86/um: thin archives build fix")

it is not even linked.  Now it is completely orphan, and no problem has
been reported.  It is a proof that this file was not needed in the
first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Richard Weinberger <richard@nod.at>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-um@lists.infradead.org
Link: http://lkml.kernel.org/r/1530582614-5173-2-git-send-email-yamada.masahiro@socionext.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/um/vdso/.gitignore |  1 -
 arch/x86/um/vdso/Makefile   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
index 9cac6d072199..f8b69d84238e 100644
--- a/arch/x86/um/vdso/.gitignore
+++ b/arch/x86/um/vdso/.gitignore
@@ -1,2 +1 @@
-vdso-syms.lds
 vdso.lds
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index b2d6967262b2..822ccdba93ad 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,22 +53,6 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
 CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 
-targets += vdso-syms.lds
-extra-$(VDSO64-y)			+= vdso-syms.lds
-
-#
-# Match symbols in the DSO that look like VDSO*; produce a file of constants.
-#
-sed-vdsosym := -e 's/^00*/0/' \
-	-e 's/^\([0-9a-fA-F]*\) . \(VDSO[a-zA-Z0-9_]*\)$$/\2 = 0x\1;/p'
-quiet_cmd_vdsosym = VDSOSYM $@
-define cmd_vdsosym
-	$(NM) $< | LC_ALL=C sed -n $(sed-vdsosym) | LC_ALL=C sort > $@
-endef
-
-$(obj)/%-syms.lds: $(obj)/%.so.dbg FORCE
-	$(call if_changed,vdsosym)
-
 #
 # The DSO images are built using a special linker script.
 #
