Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935134AbeBMMk2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:40:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934971AbeBMMkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:40:24 -0500
Date: Tue, 13 Feb 2018 04:39:51 -0800
From: tip-bot for Cao jin <tipbot@zytor.com>
Message-ID: <tip-a06cc94f3f8dfab74fe7fac3a6e9f15d77566d00@git.kernel.org>
Cc: mingo@kernel.org, caoj.fnst@cn.fujitsu.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
        luto@kernel.org, peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org, luto@kernel.org,
        bp@alien8.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, caoj.fnst@cn.fujitsu.com
In-Reply-To: <20180208063857.15197-1-caoj.fnst@cn.fujitsu.com>
References: <20180208063857.15197-1-caoj.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/build] x86/build: Drop superfluous ALIGN from the linker
 script
Git-Commit-ID: a06cc94f3f8dfab74fe7fac3a6e9f15d77566d00
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a06cc94f3f8dfab74fe7fac3a6e9f15d77566d00
Gitweb:     https://git.kernel.org/tip/a06cc94f3f8dfab74fe7fac3a6e9f15d77566d00
Author:     Cao jin <caoj.fnst@cn.fujitsu.com>
AuthorDate: Thu, 8 Feb 2018 14:38:57 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 13:08:46 +0100

x86/build: Drop superfluous ALIGN from the linker script

ALIGN(8) is superfluous since macro TEXT_TEXT already has one.

bonus cleanups:

  - indentation fix
  - spaces -> tab.

Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180208063857.15197-1-caoj.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/vmlinux.lds.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9b138a0..1c43a2e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -102,7 +102,6 @@ SECTIONS
 		_stext = .;
 		/* bootstrapping code */
 		HEAD_TEXT
-		. = ALIGN(8);
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
@@ -198,7 +197,7 @@ SECTIONS
 		. = __vvar_beginning_hack + PAGE_SIZE;
 	} :data
 
-       . = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
+	. = ALIGN(__vvar_page + PAGE_SIZE, PAGE_SIZE);
 
 	/* Init code and data - will be freed after init */
 	. = ALIGN(PAGE_SIZE);
@@ -366,8 +365,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);		/* keep VO_INIT_SIZE page aligned */
 	_end = .;
 
-        STABS_DEBUG
-        DWARF_DEBUG
+	STABS_DEBUG
+	DWARF_DEBUG
 
 	/* Sections to be discarded */
 	DISCARDS
