Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeB1OWZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:22:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52761 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbeB1OWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:22:24 -0500
Date: Wed, 28 Feb 2018 06:22:15 -0800
From: tip-bot for Jan Beulich <tipbot@zytor.com>
Message-ID: <tip-a368d7fd2a3c6babb852fe974018dd97916bcd3b@git.kernel.org>
Cc: hpa@zytor.com, jbeulich@suse.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, JBeulich@suse.com, tglx@linutronix.de
Reply-To: jbeulich@suse.com, hpa@zytor.com, JBeulich@suse.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <5A93F96902000078001ABAC8@prv-mh.provo.novell.com>
References: <5A93F96902000078001ABAC8@prv-mh.provo.novell.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64: Add instruction suffix
Git-Commit-ID: a368d7fd2a3c6babb852fe974018dd97916bcd3b
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

Commit-ID:  a368d7fd2a3c6babb852fe974018dd97916bcd3b
Gitweb:     https://git.kernel.org/tip/a368d7fd2a3c6babb852fe974018dd97916bcd3b
Author:     Jan Beulich <JBeulich@suse.com>
AuthorDate: Mon, 26 Feb 2018 04:11:21 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 28 Feb 2018 15:18:40 +0100

x86/entry/64: Add instruction suffix

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream gas in the
future (mine does already). Add the single missing suffix here.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/5A93F96902000078001ABAC8@prv-mh.provo.novell.com

---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index d5c7f18f79ac..805f52703ee3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -55,7 +55,7 @@ END(native_usergs_sysret64)
 
 .macro TRACE_IRQS_FLAGS flags:req
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bt	$9, \flags		/* interrupts off? */
+	btl	$9, \flags		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON
 1:
