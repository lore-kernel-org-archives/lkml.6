Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F472C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3118C2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3118C2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeJED74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:59:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727489AbeJED74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:59:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L3vGY2883119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:03:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L3ufY2883116;
        Thu, 4 Oct 2018 14:03:56 -0700
Date:   Thu, 4 Oct 2018 14:03:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d67f34c19a679436dd2963b588015e119279e7a8@git.kernel.org>
Cc:     jgross@suse.com, john.stultz@linaro.org, fweimer@redhat.com,
        vkuznets@redhat.com, luto@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        matt@softrans.com.au, mingo@kernel.org, pbonzini@redhat.com,
        kys@microsoft.com, arnd@arndb.de, peterz@infradead.org
Reply-To: tglx@linutronix.de, luto@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, john.stultz@linaro.org,
          jgross@suse.com, fweimer@redhat.com, vkuznets@redhat.com,
          mingo@kernel.org, matt@softrans.com.au, pbonzini@redhat.com,
          kys@microsoft.com, peterz@infradead.org, arnd@arndb.de,
          sboyd@kernel.org
In-Reply-To: <20180917130706.973042587@linutronix.de>
References: <20180917130706.973042587@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] clocksource: Provide clocksource_arch_init()
Git-Commit-ID: d67f34c19a679436dd2963b588015e119279e7a8
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

Commit-ID:  d67f34c19a679436dd2963b588015e119279e7a8
Gitweb:     https://git.kernel.org/tip/d67f34c19a679436dd2963b588015e119279e7a8
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:34 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:24 +0200

clocksource: Provide clocksource_arch_init()

Architectures have extra archdata in the clocksource, e.g. for VDSO
support. There are no sanity checks or general initializations for this
available. Add support for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Acked-by: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Matt Rickard <matt@softrans.com.au>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: devel@linuxdriverproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20180917130706.973042587@linutronix.de

---
 include/linux/clocksource.h | 5 +++++
 kernel/time/Kconfig         | 4 ++++
 kernel/time/clocksource.c   | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 308918928767..6e6b86f9046d 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -241,6 +241,11 @@ static inline void __clocksource_update_freq_khz(struct clocksource *cs, u32 khz
 	__clocksource_update_freq_scale(cs, 1000, khz);
 }
 
+#ifdef CONFIG_ARCH_CLOCKSOURCE_INIT
+extern void clocksource_arch_init(struct clocksource *cs);
+#else
+static inline void clocksource_arch_init(struct clocksource *cs) { }
+#endif
 
 extern int timekeeping_notify(struct clocksource *clock);
 
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 78eabc41eaa6..58b981f4bb5d 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -12,6 +12,10 @@ config CLOCKSOURCE_WATCHDOG
 config ARCH_CLOCKSOURCE_DATA
 	bool
 
+# Architecture has extra clocksource init called from registration
+config ARCH_CLOCKSOURCE_INIT
+	bool
+
 # Clocksources require validation of the clocksource against the last
 # cycle update - x86/TSC misfeature
 config CLOCKSOURCE_VALIDATE_LAST_CYCLE
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0e6e97a01942..ffe081623aec 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -937,6 +937,8 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 {
 	unsigned long flags;
 
+	clocksource_arch_init(cs);
+
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
 
