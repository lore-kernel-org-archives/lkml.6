Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360EAC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11845218A4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 15:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbfA3PNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:13:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfA3PNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 10:13:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0UFCtqZ2461836
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 30 Jan 2019 07:12:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0UFCsMJ2461833;
        Wed, 30 Jan 2019 07:12:54 -0800
Date:   Wed, 30 Jan 2019 07:12:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Slaby <tipbot@zytor.com>
Message-ID: <tip-5a064d398fbe2901e55be15c108f7ffa98b7eefb@git.kernel.org>
Cc:     jslaby@suse.cz, bp@suse.de, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        rafael.j.wysocki@intel.com, x86@kernel.org, hpa@zytor.com,
        mingo@kernel.org, tglx@linutronix.de, pavel@ucw.cz
Reply-To: linux-kernel@vger.kernel.org, mingo@redhat.com,
          rafael.j.wysocki@intel.com, jslaby@suse.cz, bp@suse.de,
          len.brown@intel.com, hpa@zytor.com, mingo@kernel.org,
          x86@kernel.org, tglx@linutronix.de, pavel@ucw.cz
In-Reply-To: <20190130124711.12463-3-jslaby@suse.cz>
References: <20190130124711.12463-3-jslaby@suse.cz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/asm/suspend: Drop ENTRY from local data
Git-Commit-ID: 5a064d398fbe2901e55be15c108f7ffa98b7eefb
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

Commit-ID:  5a064d398fbe2901e55be15c108f7ffa98b7eefb
Gitweb:     https://git.kernel.org/tip/5a064d398fbe2901e55be15c108f7ffa98b7eefb
Author:     Jiri Slaby <jslaby@suse.cz>
AuthorDate: Wed, 30 Jan 2019 13:46:45 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 30 Jan 2019 16:07:10 +0100

x86/asm/suspend: Drop ENTRY from local data

ENTRY is intended for functions and shall be paired with ENDPROC. ENTRY
also aligns symbols which creates unnecessary holes between data.

So drop ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64,
as these symbols are local only.

One could've used SYM_DATA_LOCAL for these symbols, but it was
discouraged earlier:

  https://lkml.kernel.org/r/20170427124310.GC23352@amd

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190130124711.12463-3-jslaby@suse.cz
---
 arch/x86/kernel/acpi/wakeup_32.S |  2 +-
 arch/x86/kernel/acpi/wakeup_64.S | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 0c26b1b44e51..4203d4f0c68d 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -90,7 +90,7 @@ ret_point:
 .data
 ALIGN
 ENTRY(saved_magic)	.long	0
-ENTRY(saved_eip)	.long	0
+saved_eip:		.long 0
 
 # saved registers
 saved_idt:	.long	0,0
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 50b8ed0317a3..510fa12aab73 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
 ENDPROC(do_suspend_lowlevel)
 
 .data
-ENTRY(saved_rbp)	.quad	0
-ENTRY(saved_rsi)	.quad	0
-ENTRY(saved_rdi)	.quad	0
-ENTRY(saved_rbx)	.quad	0
+saved_rbp:		.quad	0
+saved_rsi:		.quad	0
+saved_rdi:		.quad	0
+saved_rbx:		.quad	0
 
-ENTRY(saved_rip)	.quad	0
-ENTRY(saved_rsp)	.quad	0
+saved_rip:		.quad	0
+saved_rsp:		.quad	0
 
 ENTRY(saved_magic)	.quad	0
