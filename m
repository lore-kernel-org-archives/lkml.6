Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5A5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4832075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RZEl1589"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4832075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730252AbeGRXWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:22:06 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:41761 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbeGRXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:22:06 -0400
Received: by mail-it0-f73.google.com with SMTP id h26-v6so3968265itj.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=/SXidF8hAXshqkiFbGoLk/sQ+aaGc8icFptsQuMCA0M=;
        b=RZEl1589f3jm9MF2c55+cO06KecxJbXsgUBYOrJJvwzZe86uXsDri3nu5F0jIGcJtj
         bRpwH0LgJaj+L9D4kzrDELKzojKi/z1xSWOK/abERUtktG/vudlekDhF8koqjbcOjrOG
         RupHib+v5XQHT2aihzCTF8QzkRi/bUvb57uRyuwrpkY7liKJaQSPORtVVnvbfaZAMwCx
         oL9AjQHyv3oWUC4Ho6JUAsWKpbSVGmvGR6wT5V34V0LTMh1VMQSUjRNWxbaUGBOxBovU
         tZO+TZ4hJME/EdH3D4i+PFN4eCbvMe2MxDVGhpBns/VP7bqjbb9a9iKBIhR34JG6qcBU
         NIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=/SXidF8hAXshqkiFbGoLk/sQ+aaGc8icFptsQuMCA0M=;
        b=Tc/rtL7tVquACrpAoqJi4JQ39Rd6Kue+1JpW/yUYik9GA8YrX6G8RTxHmgpIe4BVlm
         YaON1Jkx5eXmkR7j+Fme507DTGRGx+i55xgnJqacLMcjbIdmLW2GPJPKrsixHC+5YJWg
         GdGOBAIpO6YQDGHaZtRPJtvIAL4OEXk00vnKqyWpaJ5yzZxe+lYy0c9HkVFm0BD/aMF0
         eX0kpQ/EBr/y/8/gMpnG83CYnEkZcWOk4bL6uIMpitqZNlfegbWiZQOSH6LptmVZpdfw
         802+3WYSyJzweh0MeCe4yPUOa9dtS3W/dA9KKQ+c6q5C98gFg7QHBPbX0Kw11sOyaC+o
         AGHg==
X-Gm-Message-State: AOUpUlFRJJH9nKW027dc1Wph5e97J4+17dOvXQJgqgnJ6Lqu+OClj7jC
        AORxAkCONhtUyZh8G6bxgiaZfzFvmVlS9KLVqhSMrNfwfX1fAigXD3xjUGImk+Bk1jCVgKd8bN+
        ungvRkG2yLmAWLdY7IBtM/GJsQF3KFRWGl9wAAJmVrtAFZyMa5XooA6vJISC9l7aMvgu779gCya
        MBrw==
X-Google-Smtp-Source: AAOMgpdIADJI/bybvx3upZiku+PoLAJaquzlQVNK2mOTZqwEPAmces+hnc01ZfqlwVx2ufbSI63tAAexDZ/5t+M=
MIME-Version: 1.0
X-Received: by 2002:a24:1f46:: with SMTP id d67-v6mr1906148itd.49.1531953722265;
 Wed, 18 Jul 2018 15:42:02 -0700 (PDT)
Date:   Wed, 18 Jul 2018 15:41:59 -0700
Message-Id: <20180718224159.18236-1-astrachan@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH] x86: vdso: Use $LD instead of $CC to link
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdso{32,64}.so can fail to link with CC=clang when clang tries to
find a suitable GCC toolchain to link these libraries with.

/usr/bin/ld: arch/x86/entry/vdso/vclock_gettime.o:
  access beyond end of merged section (782)

This happens because the host environment leaked into the cross
compiler environment due to the way clang searches for suitable GCC
toolchains.

Clang is a retargetable compiler, and each invocation of it must
provide --target=<something> --gcc-toolchain=<something> to allow it
to find the correct binutils for cross compilation. These flags had
been added to KBUILD_CFLAGS, but the vdso code uses CC and not
KBUILD_CFLAGS (for various reasons) which breaks clang's ability to
find the correct linker when cross compiling.

Most of the time this goes unnoticed because the host linker is new
enough to work anyway, or is incompatible and skipped, but this cannot
be reliably assumed.

This change alters the vdso makefile to just use LD directly, which
bypasses clang and thus the searching problem. The makefile will just
use ${CROSS_COMPILE}ld instead, which is always what we want. This
matches the method used to link vmlinux.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org
Cc: kernel-team@android.com
Cc: joel@joelfernandes.com
Signed-off-by: Alistair Strachan <astrachan@google.com>
---
Supersedes "x86: vdso: Fix leaky vdso link with CC=clang"
 arch/x86/entry/vdso/Makefile | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 1943aebadede..896a55204386 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -48,10 +48,8 @@ targets += $(vdso_img_sodbg)
 
 export CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
-			-Wl,--no-undefined \
-			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
-			$(DISABLE_LTO)
+VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
+			-z max-page-size=4096 -z common-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(src)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -97,10 +95,8 @@ CFLAGS_REMOVE_vvar.o = -pg
 #
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
-			   -Wl,-soname=linux-vdso.so.1 \
-			   -Wl,-z,max-page-size=4096 \
-			   -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
+			   -z max-page-size=4096 -z common-page-size=4096
 
 # 64-bit objects to re-brand as x32
 vobjs64-for-x32 := $(filter-out $(vobjs-nox32),$(vobjs-y))
@@ -128,7 +124,7 @@ $(obj)/vdsox32.so.dbg: $(src)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdso32.lds = -m32 -Wl,-m,elf_i386 -Wl,-soname=linux-gate.so.1
+VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
 targets += vdso32/vdso32.lds
 targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
@@ -162,13 +158,13 @@ $(obj)/vdso32.so.dbg: FORCE \
 # The DSO images are built using a special linker script.
 #
 quiet_cmd_vdso = VDSO    $@
-      cmd_vdso = $(CC) -nostdlib -o $@ \
+      cmd_vdso = $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -Wl,-T,$(filter %.lds,$^) $(filter %.o,$^) && \
+		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
-VDSO_LDFLAGS = -fPIC -shared $(call cc-ldoption, -Wl$(comma)--hash-style=both) \
-	$(call cc-ldoption, -Wl$(comma)--build-id) -Wl,-Bsymbolic $(LTO_CFLAGS)
+VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
+	$(call ld-option, --build-id) -Bsymbolic
 GCOV_PROFILE := n
 
 #
