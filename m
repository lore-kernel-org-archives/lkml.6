Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0738EC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C591320868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C591320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbeLGSed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:34:33 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbeLGSec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:34:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB7IXucr2221791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 7 Dec 2018 10:33:56 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB7IXu7g2221785;
        Fri, 7 Dec 2018 10:33:56 -0800
Date:   Fri, 7 Dec 2018 10:33:56 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Nick Desaulniers <tipbot@zytor.com>
Message-ID: <tip-ac3e233d29f7f77f28243af0132057d378d3ea58@git.kernel.org>
Cc:     morbo@google.com, hpa@zytor.com, dima@golovin.in, luto@kernel.org,
        maskray@google.com, mingo@redhat.com, andi@firstfloor.org,
        ndesaulniers@google.com, ruiu@google.com, mingo@kernel.org,
        x86@kernel.org, tglx@linutronix.de, bp@suse.de,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, x86@kernel.org, bp@suse.de,
          linux-kernel@vger.kernel.org, dima@golovin.in, morbo@google.com,
          hpa@zytor.com, luto@kernel.org, maskray@google.com,
          andi@firstfloor.org, mingo@redhat.com, mingo@kernel.org,
          ruiu@google.com, ndesaulniers@google.com
In-Reply-To: <20181206191231.192355-1-ndesaulniers@google.com>
References: <20181206191231.192355-1-ndesaulniers@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/vdso: Drop implicit common-page-size linker
 flag
Git-Commit-ID: ac3e233d29f7f77f28243af0132057d378d3ea58
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

Commit-ID:  ac3e233d29f7f77f28243af0132057d378d3ea58
Gitweb:     https://git.kernel.org/tip/ac3e233d29f7f77f28243af0132057d378d3ea58
Author:     Nick Desaulniers <ndesaulniers@google.com>
AuthorDate: Thu, 6 Dec 2018 11:12:31 -0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 7 Dec 2018 18:57:38 +0100

x86/vdso: Drop implicit common-page-size linker flag

GNU linker's -z common-page-size's default value is based on the target
architecture. arch/x86/entry/vdso/Makefile sets it to the architecture
default, which is implicit and redundant. Drop it.

Fixes: 2aae950b21e4 ("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu")
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Bill Wendling <morbo@google.com>
Suggested-by: Dmitry Golovin <dima@golovin.in>
Suggested-by: Rui Ueyama <ruiu@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Fangrui Song <maskray@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
Link: https://bugs.llvm.org/show_bug.cgi?id=38774
Link: https://github.com/ClangBuiltLinux/linux/issues/31
---
 arch/x86/entry/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 141d415a8c80..0624bf2266fd 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,7 +47,7 @@ targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
-			-z max-page-size=4096 -z common-page-size=4096
+			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -98,7 +98,7 @@ CFLAGS_REMOVE_vvar.o = -pg
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
-			   -z max-page-size=4096 -z common-page-size=4096
+			   -z max-page-size=4096
 
 # x32-rebranded versions
 vobjx32s-y := $(vobjs-y:.o=-x32.o)
