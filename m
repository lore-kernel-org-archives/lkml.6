Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53482C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E9A2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21E9A2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJEEF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:05:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725758AbeJEEF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:05:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L9aJ62885362
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:09:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L9aIO2885359;
        Thu, 4 Oct 2018 14:09:36 -0700
Date:   Thu, 4 Oct 2018 14:09:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-315f28fa3a7bfbbb6233d800dffa327e87f96129@git.kernel.org>
Cc:     vkuznets@redhat.com, pbonzini@redhat.com, matt@softrans.com.au,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org, luto@kernel.org, mingo@kernel.org,
        sboyd@kernel.org, tglx@linutronix.de, kys@microsoft.com,
        peterz@infradead.org, jgross@suse.com, fweimer@redhat.com,
        hpa@zytor.com
Reply-To: vkuznets@redhat.com, pbonzini@redhat.com, matt@softrans.com.au,
          linux-kernel@vger.kernel.org, arnd@arndb.de,
          john.stultz@linaro.org, luto@kernel.org, mingo@kernel.org,
          sboyd@kernel.org, tglx@linutronix.de, kys@microsoft.com,
          peterz@infradead.org, jgross@suse.com, fweimer@redhat.com,
          hpa@zytor.com
In-Reply-To: <20180917130707.823878601@linutronix.de>
References: <20180917130707.823878601@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x66/vdso: Add CLOCK_TAI support
Git-Commit-ID: 315f28fa3a7bfbbb6233d800dffa327e87f96129
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

Commit-ID:  315f28fa3a7bfbbb6233d800dffa327e87f96129
Gitweb:     https://git.kernel.org/tip/315f28fa3a7bfbbb6233d800dffa327e87f96129
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:44 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:27 +0200

x66/vdso: Add CLOCK_TAI support

With the storage array in place it's now trivial to support CLOCK_TAI in
the vdso. Extend the base time storage array and add the update code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Matt Rickard <matt@softrans.com.au>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
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
Link: https://lkml.kernel.org/r/20180917130707.823878601@linutronix.de

---
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 4 ++++
 arch/x86/include/asm/vgtod.h            | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index 31b9e5e0cfdf..cfcdba082feb 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -51,6 +51,10 @@ void update_vsyscall(struct timekeeper *tk)
 	base->sec = tk->xtime_sec;
 	base->nsec = tk->tkr_mono.xtime_nsec;
 
+	base = &vdata->basetime[CLOCK_TAI];
+	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
+	base->nsec = tk->tkr_mono.xtime_nsec;
+
 	base = &vdata->basetime[CLOCK_MONOTONIC];
 	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec = tk->tkr_mono.xtime_nsec;
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index 10e534a1a51a..d17b092b9f1b 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -18,8 +18,8 @@ struct vgtod_ts {
 	u64		nsec;
 };
 
-#define VGTOD_BASES	(CLOCK_MONOTONIC_COARSE + 1)
-#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC))
+#define VGTOD_BASES	(CLOCK_TAI + 1)
+#define VGTOD_HRES	(BIT(CLOCK_REALTIME) | BIT(CLOCK_MONOTONIC) | BIT(CLOCK_TAI))
 #define VGTOD_COARSE	(BIT(CLOCK_REALTIME_COARSE) | BIT(CLOCK_MONOTONIC_COARSE))
 
 /*
