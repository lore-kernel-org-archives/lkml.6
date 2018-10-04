Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD4C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8028F2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8028F2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeJEEAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:00:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725752AbeJEEAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:00:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L4X8m2884654
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:04:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L4Xvk2884651;
        Thu, 4 Oct 2018 14:04:33 -0700
Date:   Thu, 4 Oct 2018 14:04:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-2a21ad571b62440a4ad66d70b4b5d09c00029af4@git.kernel.org>
Cc:     fweimer@redhat.com, pbonzini@redhat.com, jgross@suse.com,
        kys@microsoft.com, mingo@kernel.org, peterz@infradead.org,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        matt@softrans.com.au, sboyd@kernel.org, vkuznets@redhat.com,
        arnd@arndb.de, luto@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, john.stultz@linaro.org, peterz@infradead.org,
          fweimer@redhat.com, pbonzini@redhat.com, kys@microsoft.com,
          jgross@suse.com, hpa@zytor.com, tglx@linutronix.de,
          luto@kernel.org, arnd@arndb.de, matt@softrans.com.au,
          linux-kernel@vger.kernel.org, vkuznets@redhat.com,
          sboyd@kernel.org
In-Reply-To: <20180917130707.069167446@linutronix.de>
References: <20180917130707.069167446@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/time: Implement clocksource_arch_init()
Git-Commit-ID: 2a21ad571b62440a4ad66d70b4b5d09c00029af4
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

Commit-ID:  2a21ad571b62440a4ad66d70b4b5d09c00029af4
Gitweb:     https://git.kernel.org/tip/2a21ad571b62440a4ad66d70b4b5d09c00029af4
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:35 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:24 +0200

x86/time: Implement clocksource_arch_init()

Runtime validate the VCLOCK_MODE in clocksource::archdata and disable
VCLOCK if invalid, which disables the VDSO but keeps the system running.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: devel@linuxdriverproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20180917130707.069167446@linutronix.de

---
 arch/x86/Kconfig       |  1 +
 arch/x86/kernel/time.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..adc8c96df914 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -48,6 +48,7 @@ config X86
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ANON_INODES
 	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_DEBUG_VIRTUAL
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index be01328eb755..1fa632e0829f 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -105,3 +106,18 @@ void __init time_init(void)
 {
 	late_time_init = x86_late_time_init;
 }
+
+/*
+ * Sanity check the vdso related archdata content.
+ */
+void clocksource_arch_init(struct clocksource *cs)
+{
+	if (cs->archdata.vclock_mode == VCLOCK_NONE)
+		return;
+
+	if (cs->archdata.vclock_mode > VCLOCK_MAX) {
+		pr_warn("clocksource %s registered with invalid vclock_mode %d. Disabling vclock.\n",
+			cs->name, cs->archdata.vclock_mode);
+		cs->archdata.vclock_mode = VCLOCK_NONE;
+	}
+}
