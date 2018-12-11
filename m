Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BAC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3C920849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3C920849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbeLKNZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:25:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35739 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbeLKNZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:25:29 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBDP1EY4003101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 05:25:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBDP0mx4003096;
        Tue, 11 Dec 2018 05:25:00 -0800
Date:   Tue, 11 Dec 2018 05:25:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-e4f752dda0de351efd198f438b68e743029da68a@git.kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        yamada.masahiro@socionext.com, ndesaulniers@google.com,
        tglx@linutronix.de, hpa@zytor.com, richard@nod.at,
        mingo@kernel.org, mingo@redhat.com, jdike@addtoit.com, bp@suse.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, richard@nod.at,
          mingo@redhat.com, mingo@kernel.org, bp@suse.de,
          jdike@addtoit.com, x86@kernel.org, linux-kernel@vger.kernel.org,
          yamada.masahiro@socionext.com, ndesaulniers@google.com
In-Reply-To: <20181206191231.192355-1-ndesaulniers@google.com>
References: <20181206191231.192355-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/um/vdso: Drop implicit common-page-size linker
 flag
Git-Commit-ID: e4f752dda0de351efd198f438b68e743029da68a
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

Commit-ID:  e4f752dda0de351efd198f438b68e743029da68a
Gitweb:     https://git.kernel.org/tip/e4f752dda0de351efd198f438b68e743029da68a
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Mon, 10 Dec 2018 14:27:16 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Tue, 11 Dec 2018 14:19:42 +0100

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
 
