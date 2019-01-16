Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB2AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0156B206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbfAPLhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:37:16 -0500
Received: from terminus.zytor.com ([198.137.202.136]:51411 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389465AbfAPLhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:37:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0GBb26A246312
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 16 Jan 2019 03:37:02 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0GBb2vZ246308;
        Wed, 16 Jan 2019 03:37:02 -0800
Date:   Wed, 16 Jan 2019 03:37:02 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-e6d7bc0bdf4155e896c48cf6f8fb7ef76b504058@git.kernel.org>
Cc:     bp@suse.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          bp@suse.de, tglx@linutronix.de
In-Reply-To: <20190109181531.27513-1-bp@alien8.de>
References: <20190109181531.27513-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Use the single-argument OUTPUT_FORMAT()
 linker script command
Git-Commit-ID: e6d7bc0bdf4155e896c48cf6f8fb7ef76b504058
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

Commit-ID:  e6d7bc0bdf4155e896c48cf6f8fb7ef76b504058
Gitweb:     https://git.kernel.org/tip/e6d7bc0bdf4155e896c48cf6f8fb7ef76b504058
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 9 Jan 2019 17:32:10 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 16 Jan 2019 12:21:53 +0100

x86/build: Use the single-argument OUTPUT_FORMAT() linker script command

The various x86 linker scripts use the three-argument linker script
command variant OUTPUT_FORMAT(DEFAULT, BIG, LITTLE) which specifies
three object file formats when the -EL and -EB linker command line
options are used. When -EB is specified, OUTPUT_FORMAT issues the BIG
object file format, when -EL, LITTLE, respectively, and when neither is
specified, DEFAULT.

However, those -E[LB] options are not used by arch/x86/ so switch to the
simple OUTPUT_FORMAT(BFDNAME) macro variant.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20190109181531.27513-1-bp@alien8.de
---
 arch/x86/boot/compressed/vmlinux.lds.S | 2 +-
 arch/x86/boot/setup.ld                 | 2 +-
 arch/x86/kernel/vmlinux.lds.S          | 2 +-
 arch/x86/realmode/rm/realmode.lds.S    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index f491bbde8493..508cfa6828c5 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm-generic/vmlinux.lds.h>
 
-OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT)
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #undef i386
 
diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 96a6c7563538..0149e41d42c2 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -3,7 +3,7 @@
  *
  * Linker script for the i386 setup code
  */
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
 
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index ee3b5c7d662e..bad8c51fee6e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -31,7 +31,7 @@
 
 #undef i386     /* in case the preprocessor is a 32bit one */
 
-OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT, CONFIG_OUTPUT_FORMAT)
+OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #ifdef CONFIG_X86_32
 OUTPUT_ARCH(i386)
diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
index df8e11e26bc3..3bb980800c58 100644
--- a/arch/x86/realmode/rm/realmode.lds.S
+++ b/arch/x86/realmode/rm/realmode.lds.S
@@ -9,7 +9,7 @@
 
 #undef i386
 
-OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_FORMAT("elf32-i386")
 OUTPUT_ARCH(i386)
 
 SECTIONS
