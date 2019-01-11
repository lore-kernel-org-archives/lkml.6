Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80033C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BCC2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="CoXNGlnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390300AbfAKTOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:14:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34827 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfAKTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:14:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so7169760plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4PSkVHaKw5CbKmm0QxQ+ILpAKzDW8YTfbZwfcjQmuvo=;
        b=CoXNGlnAUbnMlQdjQLKk1Snt6BMB21PQyckYQ1FYs6Uo325vRaM8NLMDh0HxKSJJ7e
         QIQeXH/V0rxqlpTMbr4zwkP6VYzOZyHFFrixWqHShc3M2EHCktl4UfgOEozkSgee3aOr
         6wK1/qyEuwM0Q4eWj2La7uZxlj0mCz+Mmvf2aynO0DRdflJMcpum53JediNsG/MnyiL+
         7noBZsin/mJJXrZr5CxpTztQMWuaLMYA9McUMWrSNIVBALyoQB4Bi7CMwOyKcm6VL/LJ
         +0NHf1Q/y1hxDEvpP4YiJiHcX8ikdJVOhNN+k0NP3oxd5rMySxVwyEvNZ74FmtMwZMEb
         rG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4PSkVHaKw5CbKmm0QxQ+ILpAKzDW8YTfbZwfcjQmuvo=;
        b=ctX/iy+jFwpW2Hrjd14m1RcbqWbYKH8BkIjGBQEds8Wh4Dso0/O/buW5j+gnaH84F3
         wQrKBo4zfufyOrg8v8Kl7ljJiATgBDyxyuXQsabWfmPVIlzHU+cUupQ9zgF3qvZErku0
         xhWk3TKzm/1uGl2h4K5fQda2HVbKepvXnKw4tuZeC40LPLk2BCC6hkt9DxQspF+FhFR9
         i1d8FheVPxQsBYpE7p5rxNog6esCW24WAyf72wHpDgXpGy15YbNqFjGUTaqm9HutQb0+
         jmT71GA0xCZR5TA37z8TUIwoqADVMNd4/O2rgUquiRqfCs4Ug2XTL9Duq9tHSGQAnYES
         s4Dw==
X-Gm-Message-State: AJcUukdT2FMyY2KErXGWJvqwMDwL4pFyrPXtqX/q53OqPi2oMS4u/u+F
        s69RFN7AgC9AdeUiXnJS4zMICQ==
X-Google-Smtp-Source: ALg8bN4b5JIWIllMgJ4K3hvmwfWWJACjqSIUtXgQnxxKxFovjrFwwtzWOGqWbWX8GsH7Uf1bJzkGvg==
X-Received: by 2002:a17:902:30a3:: with SMTP id v32mr15996029plb.26.1547234088159;
        Fri, 11 Jan 2019 11:14:48 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id e16sm107060897pfn.46.2019.01.11.11.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 11:14:47 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com
Cc:     grimar@accesssoftek.com, dima@golovin.in, morbo@google.com,
        ndesaulniers@google.com, matz@suse.de, ruiu@google.com,
        linux-kernel@vger.kernel.org, Tri Vo <trong@android.com>
Subject: [PATCH v2] x86_64: Add "-m elf_i386" when linking i386 object files.
Date:   Fri, 11 Jan 2019 11:14:20 -0800
Message-Id: <20190111191420.47731-1-trong@android.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <CAKwvOdnr1=Q=mL-P2icMTP8do3CVH+KF8564fKmpK_OshKxKwg@mail.gmail.com>
References: <CAKwvOdnr1=Q=mL-P2icMTP8do3CVH+KF8564fKmpK_OshKxKwg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Rimar <grimar@accesssoftek.com>

Linux kernel uses OUTPUT_FORMAT in it's linker scripts. Most of the time
-m option is passed to the linker with correct architecture, but
sometimes (at least for x86_64) the -m option contradicts OUTPUT_FORMAT
directive. Specifically, arch/x86/boot and arch/x86/realmode/rm modules
have i386 object files, but are linked with -m elf_x86_64 linker flag
when building for x86_64.

"man ld" doesn't explicitly state any tie-breakers between -m and
OUTPUT_FORMAT. BFD and Gold linkers override -m value with
OUTPUT_FORMAT. But LLVM lld has a different behavior. When supplied with
contradicting -m and OUTPUT_FORMAT values it fails with the following
error message:

  ld.lld: error: arch/x86/realmode/rm/header.o is incompatible with elf_x86_64

Suggested fix: just add correct -m after incorrect one (it overrides
it), so the linker invocation looks like this: ld -m elf_x86_64 -z
max-page-size=0x200000 -m elf_i386 --emit-relocs -T realmode.lds
header.o trampoline_64.o stack.o reboot.o -o realmode.elf

This is not a functional change for GNU ld, because (although not
explicitly documented) it already overrides -m EMULATION with
OUTPUT_FORMAT.

Tested by building x86_64 kernel with GNU gcc/ld toolchain and booting
it in QEMU.

Suggested-by: Dmitry Golovin <dima@golovin.in>
Signed-off-by: Georgii Rymar <grimar@accesssoftek.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Tri Vo <trong@android.com>
---
 arch/x86/boot/Makefile        | 2 +-
 arch/x86/realmode/rm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9b5adae9cc40..e2839b5c246c 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -100,7 +100,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
 AFLAGS_header.o += -I$(objtree)/$(obj)
 $(obj)/header.o: $(obj)/zoffset.h
 
-LDFLAGS_setup.elf	:= -T
+LDFLAGS_setup.elf	:= -m elf_i386 -T
 $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index 4463fa72db94..96cb20de08af 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -47,7 +47,7 @@ $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
 targets += realmode.lds
 $(obj)/realmode.lds: $(obj)/pasyms.h
 
-LDFLAGS_realmode.elf := --emit-relocs -T
+LDFLAGS_realmode.elf := -m elf_i386 --emit-relocs -T
 CPPFLAGS_realmode.lds += -P -C -I$(objtree)/$(obj)
 
 targets += realmode.elf
-- 
2.20.1.97.g81188d93c3-goog

