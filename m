Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB7C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0AE2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0AE2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeJEEA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:00:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeJEEA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:00:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w94L57ro2884703
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 4 Oct 2018 14:05:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w94L56KG2884700;
        Thu, 4 Oct 2018 14:05:06 -0700
Date:   Thu, 4 Oct 2018 14:05:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a51e996d48ac9fa0a1260a3822a14f3d570d3be7@git.kernel.org>
Cc:     luto@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, john.stultz@linaro.org,
        pbonzini@redhat.com, arnd@arndb.de, kys@microsoft.com,
        mingo@kernel.org, fweimer@redhat.com, matt@softrans.com.au,
        vkuznets@redhat.com, sboyd@kernel.org, hpa@zytor.com,
        jgross@suse.com
Reply-To: jgross@suse.com, hpa@zytor.com, sboyd@kernel.org,
          vkuznets@redhat.com, matt@softrans.com.au, kys@microsoft.com,
          fweimer@redhat.com, mingo@kernel.org, pbonzini@redhat.com,
          arnd@arndb.de, john.stultz@linaro.org, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          luto@kernel.org
In-Reply-To: <20180917130707.151963007@linutronix.de>
References: <20180917130707.151963007@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/vdso] x86/vdso: Enforce 64bit clocksource
Git-Commit-ID: a51e996d48ac9fa0a1260a3822a14f3d570d3be7
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

Commit-ID:  a51e996d48ac9fa0a1260a3822a14f3d570d3be7
Gitweb:     https://git.kernel.org/tip/a51e996d48ac9fa0a1260a3822a14f3d570d3be7
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 17 Sep 2018 14:45:36 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 4 Oct 2018 23:00:25 +0200

x86/vdso: Enforce 64bit clocksource

All VDSO clock sources are TSC based and use CLOCKSOURCE_MASK(64). There is
no point in masking with all FF. Get rid of it and enforce the mask in the
sanity checker.

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
Link: https://lkml.kernel.org/r/20180917130707.151963007@linutronix.de

---
 arch/x86/entry/vdso/vclock_gettime.c | 2 +-
 arch/x86/kernel/time.c               | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index e48ca3afa091..6a950854034f 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -201,7 +201,7 @@ notrace static inline u64 vgetsns(int *mode)
 #endif
 	else
 		return 0;
-	v = (cycles - gtod->cycle_last) & gtod->mask;
+	v = cycles - gtod->cycle_last;
 	return v * gtod->mult;
 }
 
diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 1fa632e0829f..b23f5420b26a 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -120,4 +120,10 @@ void clocksource_arch_init(struct clocksource *cs)
 			cs->name, cs->archdata.vclock_mode);
 		cs->archdata.vclock_mode = VCLOCK_NONE;
 	}
+
+	if (cs->mask != CLOCKSOURCE_MASK(64)) {
+		pr_warn("clocksource %s registered with invalid mask %016llx. Disabling vclock.\n",
+			cs->name, cs->mask);
+		cs->archdata.vclock_mode = VCLOCK_NONE;
+	}
 }
