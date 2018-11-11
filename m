Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB53C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A7020869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A7020869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeKLGcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:32:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49340 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729547AbeKLFsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:02 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0000lH-Tu; Sun, 11 Nov 2018 19:58:32 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsN-0001N3-O1; Sun, 11 Nov 2018 19:58:31 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.114410397@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 013/366] arch/x86/kernel/cpu/common.c: fix unused
 symbol warning
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit e48510f45107613bf14060eeabd658c49a044242 upstream.

x86_64 allnoconfig:

arch/x86/kernel/cpu/common.c:968: warning: 'syscall32_cpu_init' defined but not used

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1156,6 +1156,7 @@ static void vgetcpu_set_mode(void)
 		vgetcpu_mode = VGETCPU_LSL;
 }
 
+#ifdef CONFIG_IA32_EMULATION
 /* May not be __init: called during resume */
 static void syscall32_cpu_init(void)
 {
@@ -1167,7 +1168,8 @@ static void syscall32_cpu_init(void)
 
 	wrmsrl(MSR_CSTAR, ia32_cstar_target);
 }
-#endif
+#endif		/* CONFIG_IA32_EMULATION */
+#endif		/* CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_32
 void enable_sep_cpu(void)

