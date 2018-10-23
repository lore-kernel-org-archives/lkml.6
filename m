Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3311C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C182075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 23:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/QNYWBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C182075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbeJXHhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 03:37:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43533 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbeJXHhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 03:37:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id t10-v6so3443587wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 16:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqfHpKNPDXrTx6bBHrEv0c3/mEZg1D2zhZ4+XENhV28=;
        b=L/QNYWByumjP+0yOahoFKBxg8TVkO6yTCLUbs1+bM6Sbz6iVLZoiRIS6Uu7Y+H6sO5
         45/+W80/rVTzBZZYjKSa3twzewCTVdAs71rwiDIOfF0whXDaWIGcafYX2+a6KgpblyXc
         dWBRrxt3BkNVIqrG4lLKpzejPgCp+Mjz17fDqTHwK9OIrCUGhBpxvBeR0m61Sv92JnfW
         R8XnSfyrc+OPF3cj+mIP6G0KVYuJsNyCeuDgpFgcGUjrpUCGXU+WqHPnucg3RW+ihpaX
         CpaoiWbuf2z9QAEVvUjJJLD8gTpe6pnpZK2ykWZXdB4jMBFBE7/gqm+DLG/V45OLmhZf
         Pl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kqfHpKNPDXrTx6bBHrEv0c3/mEZg1D2zhZ4+XENhV28=;
        b=Bh38Gvqi08xI9XM/jFB5zsMieTVPmp+87BqP8SbSFhS6XqfW8Ym2GH1uVc+KlVfC+9
         msG8a8QqvUFq4xJWbWWBcd8xLv4CzqvIYIlx63ycvpyyV1H/TpL986435BmxQhqueIzF
         bRrE1oDI22m1SMrghex+XByv35p6sDDHOuwes+J4lz2iqeZVJmzKVxQjr7/IMxtDm6Vt
         uxKxNwsuCSdY01atIcWbHHhJbgdqWwqbPobYoU4otcMCHj+o1Jp5Zwvfa7iMXBSQZrpz
         K2V5nE55lyqpcpyTRd3bG0zyJQdaeNx+BQaa+QJAL/5C4mFXgGBo8crBCVP9ZvSf/pB4
         N//A==
X-Gm-Message-State: AGRZ1gI5lX2wxeuK7RFnCz33+Qw4Mf4g19R8fj+32Wg7gnGhrGcUvzE6
        3PAIdWj9TDyHHToriPDT0Nk=
X-Google-Smtp-Source: AJdET5dFujq0TFWA6i6MR8agEvLFqFX+/EpHN1rI/YtuJkR6EJ5K3lq8DXXn+SrH9DOlrcv+Bqv4Vw==
X-Received: by 2002:adf:a201:: with SMTP id p1-v6mr221643wra.89.1540336303694;
        Tue, 23 Oct 2018 16:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j189-v6sm2616888wmb.12.2018.10.23.16.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 16:11:42 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] x86: Remove -pipe from KBUILD_CFLAGS
Date:   Tue, 23 Oct 2018 16:11:25 -0700
Message-Id: <20181023231125.27976-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in
inline assembly code to work around asm() related GCC inlining bugs")
added -Wa,- to KBUILD_CFLAGS, which breaks compiling with Clang (hangs
indefinitely at compiling init/main.o). This happens because while Clang
accepts -pipe (and has it documented in its list of supported flags), it
silently ignores it after this 2010 commit (thanks to Nick Desaulniers
for tracking this down), meaning that gas just infinitely waits for
stdin and never receives it.

https://github.com/llvm-mirror/clang/commit/c19a12dc3d441bec62eed55e312b76c12d6d9022

Initially, I had suggested just add -Wa,- to KBUILD_CFLAGS when GCC was
being used but that was before realizing it is because Clang doesn't do
anything with -pipe. H. Peter Anvin suggested checking to see if -pipe
gives us any gains out of GCC. Turns out it might actually be hurting:

With -pipe:

real    3m40.813s
real    3m44.449s
real    3m39.648s

Without -pipe:

real    3m38.492s
real    3m38.335s
real    3m38.975s

The issue of -Wa,- being passed along to gas without -pipe being
supported should still probably be fixed on the LLVM side (open issue:
https://bugs.llvm.org/show_bug.cgi?id=39410) but this is not as much of
a workaround anymore since it helps both GCC and Clang.

Link: https://github.com/ClangBuiltLinux/linux/issues/213
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/x86/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 73f4831283ac..672c689c1faa 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -213,8 +213,6 @@ ifdef CONFIG_X86_64
 KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
-# Speed up the build
-KBUILD_CFLAGS += -pipe
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
@@ -239,7 +237,7 @@ archheaders:
 archmacros:
 	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
 
-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s -Wa,-
+ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
 export ASM_MACRO_FLAGS
 KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
 
-- 
2.19.1

