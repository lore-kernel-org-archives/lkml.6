Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeBSOu3 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:50:29 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:35393 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeBSOu1 (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Mon, 19 Feb 2018 09:50:27 -0500
Message-Id: <5A8AF23F02000078001A91E5@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Mon, 19 Feb 2018 07:50:23 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: <mingo@elte.hu>, <tglx@linutronix.de>, <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/IO-APIC: avoid warning in 32-bit builds
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constants wider than 32 bits should be tagged with ULL.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/kernel/apic/io_apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 4.16-rc2/arch/x86/kernel/apic/io_apic.c
+++ 4.16-rc2-ix86-IO-APIC-constant/arch/x86/kernel/apic/io_apic.c
@@ -1603,7 +1603,7 @@ static void __init delay_with_tsc(void)
 	do {
 		rep_nop();
 		now = rdtsc();
-	} while ((now - start) < 40000000000UL / HZ &&
+	} while ((now - start) < 40000000000ULL / HZ &&
 		time_before_eq(jiffies, end));
 }
 
