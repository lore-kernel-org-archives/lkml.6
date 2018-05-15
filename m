Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AB8JxZoIdj9LXVv28eYQLFmQF6djqiYHbbF5+/V3akTpy9As0btTqHiu2GG/YDEjMCNM9m8ybNLC
ARC-Seal: i=1; a=rsa-sha256; t=1526417361; cv=none;
        d=google.com; s=arc-20160816;
        b=IQDILvBceTZXw5hDv+Z8ce0cUQ/0HZ7Ql5LUQtozmeMvvJ+wJGYdLFtx3DFm2lxUgV
         fLWZ+Dkp8Egob1fZNNrRfe52PoHxI2la6uEEmldMCHU/7Yj58ghuLoSPQ+KlUNckp6sv
         uAGzUWKxrN0M5a4ccWPXZ+MBFam7RM1M1fm20I5LGuFubr/Vlf17cMq0dwRKEpTRNN6q
         LDLaQXHTiTQEXdFv7eXyi5yaEDnU2b33Ck21v+qjHM3NH/2nDLmCBh0HtT4aBdA+ZRH0
         WEjKX9MnytvWyQ0bGfTLmfYnNXFvzfUlOLiKK1dt38r61lRD+NZnZfzAaP6UyIuxhhH8
         JGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=EksQlChVjXS+aX6vrrT5i7qDci1wcgpKhJWQLeqNWC4=;
        b=DYv5uhgGyxUHfYc1Mc2zrbbl17p8cgYxlZhFBdYoUsy+5/Coh5iIR7cAOmlMrIYW6a
         B0JaOtwcsbTYg3nbxHMOlzcs4gL6jMaVjzBbmMrmyY2zjxqljVPV2gMCcBcatMCdfFgl
         3bh/SVnZoarynbIO9kh12f3wHCD6UAC48L+ihpo88PmgheM73HoVdjy2oslvaZqFOyv5
         +JCgnp6oaKpb9V6C1LMXe1lmu9fuV33vVkiESBXyGG4/8DfxSlcPiHNFPo83OCregP0A
         mkhGAPx+WYgGT+/s4059GUMEh9iw2S7vS3pIxX5YxUAZrGG0ISunoHz9mGk0SALXK5Pw
         n04A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 15 May 2018 13:48:55 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dexuan Cui <tipbot@zytor.com>
Message-ID: <tip-5596fe34495cf0f645f417eb928ef224df3e3cb4@git.kernel.org>
Cc: tglx@linutronix.de, fweisbec@gmail.com, kys@microsoft.com,
        dvyukov@google.com, adobriyan@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        rakib.mullick@gmail.com, decui@microsoft.com,
        Michael.H.Kelley@microsoft.com, hpa@zytor.com, jopoulso@microsoft.com,
        peterz@infradead.org, Jork.Loeser@microsoft.com
Reply-To: Jork.Loeser@microsoft.com, peterz@infradead.org,
        jopoulso@microsoft.com, hpa@zytor.com, Michael.H.Kelley@microsoft.com,
        decui@microsoft.com, rakib.mullick@gmail.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, adobriyan@gmail.com, dvyukov@google.com,
        kys@microsoft.com, fweisbec@gmail.com, tglx@linutronix.de
In-Reply-To: <KL1P15301MB0006FA63BC22BEB64902EAA0BF930@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
	<KL1P15301MB0006FA63BC22BEB64902EAA0BF930@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] tick/broadcast: Use for_each_cpu() specially on
 UP kernels
Git-Commit-ID: 5596fe34495cf0f645f417eb928ef224df3e3cb4
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600561072875598164?=
X-GMAIL-MSGID: =?utf-8?q?1600564611594293463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  5596fe34495cf0f645f417eb928ef224df3e3cb4
Gitweb:     https://git.kernel.org/tip/5596fe34495cf0f645f417eb928ef224df3e3cb4
Author:     Dexuan Cui <decui@microsoft.com>
AuthorDate: Tue, 15 May 2018 19:52:50 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 May 2018 22:45:54 +0200

tick/broadcast: Use for_each_cpu() specially on UP kernels

for_each_cpu() unintuitively reports CPU0 as set independent of the actual
cpumask content on UP kernels. This causes an unexpected PIT interrupt
storm on a UP kernel running in an SMP virtual machine on Hyper-V, and as
a result, the virtual machine can suffer from a strange random delay of 1~20
minutes during boot-up, and sometimes it can hang forever.

Protect if by checking whether the cpumask is empty before entering the
for_each_cpu() loop.

[ tglx: Use !IS_ENABLED(CONFIG_SMP) instead of #ifdeffery ]

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poulson <jopoulso@microsoft.com>
Cc: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: stable@vger.kernel.org
Cc: Rakib Mullick <rakib.mullick@gmail.com>
Cc: Jork Loeser <Jork.Loeser@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: KY Srinivasan <kys@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Link: https://lkml.kernel.org/r/KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
Link: https://lkml.kernel.org/r/KL1P15301MB0006FA63BC22BEB64902EAA0BF930@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM
---
 kernel/time/tick-broadcast.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index b398c2ea69b2..aa2094d5dd27 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -612,6 +612,14 @@ static void tick_handle_oneshot_broadcast(struct clock_event_device *dev)
 	now = ktime_get();
 	/* Find all expired events */
 	for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
+		/*
+		 * Required for !SMP because for_each_cpu() reports
+		 * unconditionally CPU0 as set on UP kernels.
+		 */
+		if (!IS_ENABLED(CONFIG_SMP) &&
+		    cpumask_empty(tick_broadcast_oneshot_mask))
+			break;
+
 		td = &per_cpu(tick_cpu_device, cpu);
 		if (td->evtdev->next_event <= now) {
 			cpumask_set_cpu(cpu, tmpmask);
