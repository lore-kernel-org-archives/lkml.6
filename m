Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3615CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0420B2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0420B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeLKNbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:31:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52581 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLKNbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:31:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBBDVTAk4004762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 05:31:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBBDVTNF4004759;
        Tue, 11 Dec 2018 05:31:29 -0800
Date:   Tue, 11 Dec 2018 05:31:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-3bfaf95cb1fe81872df884956c704469e68a5bee@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de, bp@suse.de,
        linux-kernel@vger.kernel.org, tony.luck@intel.com
Reply-To: hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de, bp@suse.de,
          linux-kernel@vger.kernel.org, tony.luck@intel.com
In-Reply-To: <20181205200913.GR29510@zn.tnic>
References: <20181205200913.GR29510@zn.tnic>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/mce: Unify pr_* prefix
Git-Commit-ID: 3bfaf95cb1fe81872df884956c704469e68a5bee
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

Commit-ID:  3bfaf95cb1fe81872df884956c704469e68a5bee
Gitweb:     https://git.kernel.org/tip/3bfaf95cb1fe81872df884956c704469e68a5bee
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Wed, 5 Dec 2018 21:05:13 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 6 Dec 2018 12:04:52 +0100

x86/mce: Unify pr_* prefix

Move the pr_fmt prefix to internal.h and include it everywhere. This
way, all pr_* printed strings will be prepended with "mce: ".

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20181205200913.GR29510@zn.tnic
---
 arch/x86/kernel/cpu/mce/core.c        | 2 --
 arch/x86/kernel/cpu/mce/dev-mcelog.c  | 2 --
 arch/x86/kernel/cpu/mce/internal.h    | 3 +++
 arch/x86/kernel/cpu/mce/p5.c          | 2 ++
 arch/x86/kernel/cpu/mce/therm_throt.c | 2 ++
 arch/x86/kernel/cpu/mce/threshold.c   | 2 ++
 arch/x86/kernel/cpu/mce/winchip.c     | 2 ++
 7 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b0ae12cf7827..ad8f62a0c706 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -8,8 +8,6 @@
  * Author: Andi Kleen
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/thread_info.h>
 #include <linux/capability.h>
 #include <linux/miscdevice.h>
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 41d9169d27fa..9690ec5c8051 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -8,8 +8,6 @@
  * Author: Andi Kleen
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index ceb67cd5918f..af5eab1e65e2 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -2,6 +2,9 @@
 #ifndef __X86_MCE_INTERNAL_H__
 #define __X86_MCE_INTERNAL_H__
 
+#undef pr_fmt
+#define pr_fmt(fmt) "mce: " fmt
+
 #include <linux/device.h>
 #include <asm/mce.h>
 
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 5cddf831720f..4ae6df556526 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -14,6 +14,8 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 /* By default disabled */
 int mce_p5_enabled __read_mostly;
 
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 2da67b70ba98..df01ff8513a5 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -30,6 +30,8 @@
 #include <asm/msr.h>
 #include <asm/trace/irq_vectors.h>
 
+#include "internal.h"
+
 /* How long to wait between reporting thermal events */
 #define CHECK_INTERVAL		(300 * HZ)
 
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 2b584b319eff..10586a85c23f 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -10,6 +10,8 @@
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
 
+#include "internal.h"
+
 static void default_threshold_interrupt(void)
 {
 	pr_err("Unexpected threshold interrupt at vector %x\n",
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index 3b45b270a865..a30ea13cccc2 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -13,6 +13,8 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 /* Machine check handler for WinChip C6: */
 static void winchip_machine_check(struct pt_regs *regs, long error_code)
 {
