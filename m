Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBC821709
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzetkwo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC821709
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeHCTgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:36:51 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:35697 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeHCTgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:36:51 -0400
Received: by mail-ua0-f201.google.com with SMTP id l22-v6so3057566uak.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SfASL4WVP4AoU489Xfidj2MP5Y9bShGHEOW26RWa2mo=;
        b=fzetkwo+Q7nxgMpyYnqtmrMYw3Kn8KeXn7MowGRVFHaO7PXPzSdL3jYoBuT6u4mZ8C
         GW2z0wyWtMteMZ2MgwHCowBMun+8QPkrvvmh7EelUoNLji1+e5x1A5ZQdelmbNCQEdXv
         ofFKp6MSdIfI3OVq6BJfRa8eJzyE12ptWhLnPfRcghyvB+8elxmhNpZKCrNyvGk+hqC2
         z8WdTB8ldzgMgy4F7HR22Q9Qv43DjTxm4eR8wiqZMBgzrC0DIhmkjnTrl2LU4yWZQdaj
         r5B/GjXoz8rQ4WfQ4oNP+MOA57QQbR3QTTsqVUZniVPucwIalmsYQIhW59Vp+w4pdEkm
         Z9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SfASL4WVP4AoU489Xfidj2MP5Y9bShGHEOW26RWa2mo=;
        b=X51cw9yDwjXvJI1cB/yp0DalzdTNtTkxoV7W2GeUtHzZ8lT1yxg1o/jVMHfBCgmoTJ
         AbsWPis7d0WHRHUe9XYpZNo/M79TdtARbeSvDhyR8lH/bXSk+mltmseytMxQzWL5IYJ4
         A6iL2kUB797fISmJjbYuGxse25+f1Rm6fBeelM9Uc297qJc3FII0XxGzTBdRQ9P7dT1q
         1CMg7fRbA6S8qvhAhRRgWUB5K1zf92EgN/6okyhqgUMwQBoE85oB3EmVOISGG6jjNiCV
         GpKnJ1l6ywGgUiPFcPZR9p0yd3kzM3lsZvej+gtTYs0H9AB7blwIzlA33XwC7jkcziiW
         /f1g==
X-Gm-Message-State: AOUpUlGmp4CVHFZmTgjmdzP+RzYGU17mYKygH3X+7f4EJV5KF7bzEivF
        hT02kzZBdU4zbQgMEDtyycdLCpQh/jU94gKUvPPFbqZE0FTdT+fqfZ3aPJfEXTpSe2uonRnbf9V
        im9HhJn1yzjtU+cDaUW4y9/QPKDlcv+vWMS9xLcI/+tXpR+hwzPEtuKq5CatsB+tl3/EpwQ1fXf
        c7Cw==
X-Google-Smtp-Source: AAOMgpcrnA7Hx/qEu8oypLFDcFvZYGLTgTmXdGX16pSs8BoCHmrzNsBtOIRtrc4eRRSJ6qS7LJ1xNcKO4i5/2jM=
X-Received: by 2002:a1f:64f:: with SMTP id 76-v6mr3775618vkg.49.1533317973760;
 Fri, 03 Aug 2018 10:39:33 -0700 (PDT)
Date:   Fri,  3 Aug 2018 10:39:31 -0700
Message-Id: <20180803173931.117515-1-astrachan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2] x86: vdso: Use $LD instead of $CC to link
From:   Alistair Strachan <astrachan@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, kernel-team@android.com, joel@joelfernandes.org
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

This change drops references to DISABLE_LTO; this option doesn't seem to
be set anywhere, and not knowing what its possible values are, it's not
clear how to convert it from CC to LD flag.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org
Cc: kernel-team@android.com
Cc: joel@joelfernandes.org
Signed-off-by: Alistair Strachan <astrachan@google.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
v2: Updated changelog and rediffed
Supersedes "x86: vdso: Fix leaky vdso link with CC=clang"
 arch/x86/entry/vdso/Makefile | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 261802b1cc50..42c6c1bea4f4 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -46,10 +46,8 @@ targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
 CPPFLAGS_vdso.lds += -P -C
 
-VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
-			-Wl,--no-undefined \
-			-Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096 \
-			$(DISABLE_LTO)
+VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
+			-z max-page-size=4096 -z common-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
 	$(call if_changed,vdso)
@@ -95,10 +93,8 @@ CFLAGS_REMOVE_vvar.o = -pg
 #
 
 CPPFLAGS_vdsox32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdsox32.lds = -Wl,-m,elf32_x86_64 \
-			   -Wl,-soname=linux-vdso.so.1 \
-			   -Wl,-z,max-page-size=4096 \
-			   -Wl,-z,common-page-size=4096
+VDSO_LDFLAGS_vdsox32.lds = -m elf32_x86_64 -soname linux-vdso.so.1 \
+			   -z max-page-size=4096 -z common-page-size=4096
 
 # x32-rebranded versions
 vobjx32s-y := $(vobjs-y:.o=-x32.o)
@@ -123,7 +119,7 @@ $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
 	$(call if_changed,vdso)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
-VDSO_LDFLAGS_vdso32.lds = -m32 -Wl,-m,elf_i386 -Wl,-soname=linux-gate.so.1
+VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
 
 targets += vdso32/vdso32.lds
 targets += vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
@@ -157,13 +153,13 @@ $(obj)/vdso32.so.dbg: FORCE \
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
