Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C784C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749002133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 20:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="HFVRz+8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390638AbfAKUK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 15:10:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38229 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388761AbfAKUK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 15:10:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id g189so6753663pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N2t2CkOAm8FQ5aserNlV4RpNfw0q7c3zGmUG3z9KhEM=;
        b=HFVRz+8pHY5br+co8CLV5eogPIABPb0HgDM6TJ9MupONRsZe4K3ePAMZTZusTp0oj+
         uT/IAIN7HL0Hg7PwR5t3x9wBJ9d/lX+VitXPsexDN2pCzItameO9zDdiVjG3JFUuRMIJ
         TfWdQUKwVEgZmNzn/930fgJs4K62qGj2V5JcvBK4Eha+qXXpjsVOo4dg9yzKd7ukO23i
         pyostSxlpoERcplNMqv8d70UXNMhWaiXCx7n2oDZFfHtob/uxfjqjj2bM3fo4H3iey5z
         mEm17LwKY+MfZ+oopO0qASY36KTf7FXdKxaOIP+fPXnByMDne8T1BYp6mR7xzNrqYZxQ
         bsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N2t2CkOAm8FQ5aserNlV4RpNfw0q7c3zGmUG3z9KhEM=;
        b=kAd3sCNr4PtwXtQWpkv1x4ruGouyqSRxkvjsLXY8zVeoNYTxuuiPlm1rzZ1V3GOWK4
         ZVyLsyjv0Eg0gf6TnPQqG5ITGu2tWg4fgqenmrbFggDNFH1Uzs+hJGeDttoa9ZH+JG5f
         PdOPQesmo5FVQRdW3vkbsvf51RXfNKEb0mHowsqm8hfaW8H9C+GBceYuTboZRDSTDEeu
         dQ0LprB3gwo+3tp+SEuOlGcADYZ+37Lb7/G8kM8885hIvgwVFo8y4uJgFG1S11uoE8Z6
         Voy949p5wwJwt5xIUnlYXbKqoXRfro+HNYnG5lqqAupeL90w4TLu9dmjNWz4RqRwwiFM
         5uHA==
X-Gm-Message-State: AJcUukfBbRoDRvkicR1khTuim/p6tGhI4bzELoP/skHJIVXBS5VHC1Iq
        ENrZRePuMTvqMviZsUR8rBGxcQ==
X-Google-Smtp-Source: ALg8bN4ZMGrtC+D6keTcE5kPQRaPOL1nBKqWX51cLcR/iOGYCHIPsMKL4oZv3jVPSr8K5oy7szVNEA==
X-Received: by 2002:a63:c503:: with SMTP id f3mr14204907pgd.431.1547237426713;
        Fri, 11 Jan 2019 12:10:26 -0800 (PST)
Received: from trong0.mtv.corp.google.com ([2620:0:1000:1601:c43f:8c1b:f6ef:3dce])
        by smtp.gmail.com with ESMTPSA id l185sm117201899pfl.54.2019.01.11.12.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 12:10:26 -0800 (PST)
From:   Tri Vo <trong@android.com>
To:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com
Cc:     grimar@accesssoftek.com, dima@golovin.in, morbo@google.com,
        ndesaulniers@google.com, matz@suse.de, ruiu@google.com,
        linux-kernel@vger.kernel.org, Tri Vo <trong@android.com>
Subject: [PATCH v3] x86_64: Add "-m elf_i386" when linking i386 object files.
Date:   Fri, 11 Jan 2019 12:10:12 -0800
Message-Id: <20190111201012.71210-1-trong@android.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <CAKwvOdkR=1AzePbuFBcCW32shAK_cvR1iPiTGqHF=7MRH_oAjA@mail.gmail.com>
References: <CAKwvOdkR=1AzePbuFBcCW32shAK_cvR1iPiTGqHF=7MRH_oAjA@mail.gmail.com>
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
Signed-off-by: George Rimar <grimar@accesssoftek.com>
Signed-off-by: Tri Vo <trong@android.com>
Tested-by: Tri Vo <trong@android.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
---
v2: updated commit message to clarify that ld documentation is ambiguous w.r.t
    -m vs OUTPUT_FORMAT behavior.
v3: fixed/added SOB and "Tested-by" fields.

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

