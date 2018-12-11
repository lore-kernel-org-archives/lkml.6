Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A81C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52DB520811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DB520811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLKNN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:13:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbeLKNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:13:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBDCrv63998776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 05:12:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBDCrB83998773;
        Tue, 11 Dec 2018 05:12:53 -0800
Date:   Tue, 11 Dec 2018 05:12:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for ndesaulniers@google.com" <tipbot@zytor.com>
Message-ID: <tip-f4313ba52f9caccfda6a55f991c84aba6726b88f@git.kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, jdike@addtoit.com, hpa@zytor.com,
        bp@suse.de, mingo@kernel.org, tglx@linutronix.de, richard@nod.at,
        mingo@redhat.com, yamada.masahiro@socionext.com
Reply-To: richard@nod.at, yamada.masahiro@socionext.com, mingo@redhat.com,
          linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
          jdike@addtoit.com, ndesaulniers@google.com, tglx@linutronix.de,
          mingo@kernel.org, bp@suse.de
In-Reply-To: <20181206191231.192355-1-ndesaulniers@google.com>
References: <20181206191231.192355-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size linker
 flag
Git-Commit-ID: f4313ba52f9caccfda6a55f991c84aba6726b88f
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

Commit-ID:  f4313ba52f9caccfda6a55f991c84aba6726b88f
Gitweb:     https://git.kernel.org/tip/f4313ba52f9caccfda6a55f991c84aba6726b88f
Author:     ndesaulniers@google.com <ndesaulniers@google.com>
AuthorDate: Mon, 10 Dec 2018 14:27:16 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Dec 2018 13:58:57 +0100

x86/um/vdso: Drop implicit common-page-size linker flag

GNU linker's -z common-page-size's default value is based on the target
architecture. arch/x86/um/vdso/Makefile sets it to the architecture
default, which is implicit and redundant. Drop it so that one more LLVM
build issue gets addressed.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Richard Weinberger <richard@nod.at>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-um@lists.infradead.org
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
---
 arch/x86/um/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 822ccdba93ad..bf94060fc06f 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -26,7 +26,7 @@ targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
-       -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+       -Wl,-z,max-page-size=4096
 
 $(obj)/vdso.o: $(src)/vdso.S $(obj)/vdso.so
 
