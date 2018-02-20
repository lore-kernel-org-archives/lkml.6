Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeBTK3E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:29:04 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55123 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbeBTK3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:29:02 -0500
Date: Tue, 20 Feb 2018 02:23:37 -0800
From: tip-bot for KarimAllah Ahmed <tipbot@zytor.com>
Message-ID: <tip-894266466aa74a226e58e23975118ff6231dd2e4@git.kernel.org>
Cc: karahmed@amazon.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org, tglx@linutronix.de,
        kys@microsoft.com, sthemmin@microsoft.com, mingo@kernel.org,
        haiyangz@microsoft.com
Reply-To: haiyangz@microsoft.com, mingo@kernel.org, sthemmin@microsoft.com,
        kys@microsoft.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        karahmed@amazon.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
In-Reply-To: <1519112391-23773-1-git-send-email-karahmed@amazon.de>
References: <1519112391-23773-1-git-send-email-karahmed@amazon.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/headers/UAPI: Use __u64 instead of u64 in
 <uapi/asm/hyperv.h>
Git-Commit-ID: 894266466aa74a226e58e23975118ff6231dd2e4
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

Commit-ID:  894266466aa74a226e58e23975118ff6231dd2e4
Gitweb:     https://git.kernel.org/tip/894266466aa74a226e58e23975118ff6231dd2e4
Author:     KarimAllah Ahmed <karahmed@amazon.de>
AuthorDate: Tue, 20 Feb 2018 08:39:51 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 08:54:47 +0100

x86/headers/UAPI: Use __u64 instead of u64 in <uapi/asm/hyperv.h>

... since u64 has a hidden header dependency that was not there before
using it (i.e. it breaks our VMM build).

Also, __u64 is the right way to expose data types through UAPI.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: devel@linuxdriverproject.org
Fixes: 93286261 ("x86/hyperv: Reenlightenment notifications support")
Link: http://lkml.kernel.org/r/1519112391-23773-1-git-send-email-karahmed@amazon.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/uapi/asm/hyperv.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 197c2e6..0994143 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -241,24 +241,24 @@
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
 
 struct hv_reenlightenment_control {
-	u64 vector:8;
-	u64 reserved1:8;
-	u64 enabled:1;
-	u64 reserved2:15;
-	u64 target_vp:32;
+	__u64 vector:8;
+	__u64 reserved1:8;
+	__u64 enabled:1;
+	__u64 reserved2:15;
+	__u64 target_vp:32;
 };
 
 #define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
 #define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
 
 struct hv_tsc_emulation_control {
-	u64 enabled:1;
-	u64 reserved:63;
+	__u64 enabled:1;
+	__u64 reserved:63;
 };
 
 struct hv_tsc_emulation_status {
-	u64 inprogress:1;
-	u64 reserved:63;
+	__u64 inprogress:1;
+	__u64 reserved:63;
 };
 
 #define HV_X64_MSR_HYPERCALL_ENABLE		0x00000001
