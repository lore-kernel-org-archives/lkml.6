Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B53BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C9E23DDE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 11:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C9E23DDE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752630AbeGCLNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 07:13:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCLNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 07:13:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w63BD86P257970
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 3 Jul 2018 04:13:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w63BD7tS257967;
        Tue, 3 Jul 2018 04:13:07 -0700
Date:   Tue, 3 Jul 2018 04:13:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-dbd0fbc76c77daac08ddd245afdcbade0d506e19@git.kernel.org>
Cc:     mingo@kernel.org, pasha.tatashin@oracle.com,
        andriy.shevchenko@linux.intel.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com,
          pasha.tatashin@oracle.com, andriy.shevchenko@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180629193113.84425-4-andriy.shevchenko@linux.intel.com>
References: <20180629193113.84425-4-andriy.shevchenko@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Add missing header to tsc_msr.c
Git-Commit-ID: dbd0fbc76c77daac08ddd245afdcbade0d506e19
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

Commit-ID:  dbd0fbc76c77daac08ddd245afdcbade0d506e19
Gitweb:     https://git.kernel.org/tip/dbd0fbc76c77daac08ddd245afdcbade0d506e19
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Fri, 29 Jun 2018 22:31:10 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 3 Jul 2018 13:08:19 +0200

x86/tsc: Add missing header to tsc_msr.c

Add a missing header otherwise compiler warns about missed prototype:

CC      arch/x86/kernel/tsc_msr.o
arch/x86/kernel/tsc_msr.c:73:15: warning: no previous prototype for ‘cpu_khz_from_msr’ [-Wmissing-prototypes]
   unsigned long cpu_khz_from_msr(void)
                 ^~~~~~~~~~~~~~~~

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Link: https://lkml.kernel.org/r/20180629193113.84425-4-andriy.shevchenko@linux.intel.com

---
 arch/x86/kernel/tsc_msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 19afdbd7d0a7..5532d1be7687 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -12,6 +12,7 @@
 #include <asm/setup.h>
 #include <asm/apic.h>
 #include <asm/param.h>
+#include <asm/tsc.h>
 
 #define MAX_NUM_FREQS	9
 
