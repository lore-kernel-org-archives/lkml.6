Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCDAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0F4208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0F4208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeLCTfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:35:18 -0500
Received: from mout.gmx.net ([212.227.17.21]:38847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbeLCTfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:35:17 -0500
Received: from qcai.nay.com ([66.187.233.206]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LrZOj-1hUIBS2GRp-013KJH; Mon, 03
 Dec 2018 20:34:28 +0100
From:   Qian Cai <cai@gmx.us>
To:     mark.rutland@arm.com, marc.zyngier@arm.com
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        peterz@infradead.org, mingo@kernel.org, longman@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@gmx.us>
Subject: [PATCH] clocksource/arm_arch_timer: fix a lockdep warning
Date:   Mon,  3 Dec 2018 14:33:44 -0500
Message-Id: <1543865624-17301-1-git-send-email-cai@gmx.us>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:T3JKhvsLTMlt02j5Xa/ivotfktyAs09MImuJwRehiTtilHpq/Sl
 QHFV3W8gGDf7joKXtImhbLUdJsrVUi2F/KgHBBqkzZmuIBJ54g5ETCslpgRs82y200AxAQh
 CXM+QmcpkrWpS6EUpnKBVccVQPvnq0X+dDVV8uR1zh2x57Vnmm8P+ETqB00KeIeD8oK7pjX
 21ltqjUqt9HYPmQEFm4tQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TZBS9a4/07Y=:mipIW+jv6ooWBP2gnLQdzF
 6dyRZuIDBmmIni7UM8zxefWxNaSPNyfPNPAEy2QLwGPdSKZvF7OZsCeLiAgCsukWToUP3rGK1
 nTqQLWVezoVvXaI/hpyb3fhFRPRzKKA91lvba8hBsH23yGrklAo5SHfB/4tLK3rIp7nv6HN6D
 VBh+s1dqQvlJ/QhZETzlqcvvyVVH6b3nHx/J2ddFsAHz5PlapEdG6AiTWAyl7IAIKVQ3JbZFi
 W4XF27cg+P5EQPUHcL0tiPlQ9WAOsYxijTSSg8UxtDcMy8P49QCR/9sHUu5FqUHheYUgJtUCu
 lf2Yu75arT9vbQqt9xFwcZUwZpNLD+GyjyvWyI4i8At/4dSoQaLHv676L0k9cmnU2vek0+2MJ
 z0gq1ttUsn35dIs+9aXBqut2iVygEzRDlxJAEQbPNMMKCPerU6QqQJ20bvJtCUL/mx0l/BXvv
 OKesVyqODlTArqP8QURaPwkhF+59HjC+UyL2abs3L76OmgZlqX85WZS/SGTVfoytkDtaPZeaZ
 BxRR4+lCo3OXG7dlDqNY9+lgG4lvfKLuqxrCJ/bjqhXiQFcLLWAohtU/SJdDMnoiPXvDP5OeJ
 +lc+56Z1yVSN1QQVILC5u42feTJXLBYFtPxsdXrNFCNouuyVz0YadCyp9o1wOtqXCtbNicDn1
 +EtX1JwFKqXUJ2Bd1PSZwSt0FPJAOq3jjEQ4XfplT5kitOk39lW2mcBCYtRj+CpR6v29vqrwt
 nLhxBK2UGnv1R/5iIkYyJKa1gWasTk7pKw09KWvLpKo7vAAwGlLy0LPbObLzJpQBQZKmne1lO
 6y5WbthM7HbH3YC89/kOSJgtm77o2M/w+5HOKJIke0XdbaYhyxM+A0gxFoK1B6FZDTiB5R/MN
 /15opRrc/Hw9MAAM++jH8g3wV/MzKRZbmY2Gq9Y/Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
warning.

[    0.000000]  lockdep_assert_cpus_held+0x50/0x60
[    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
[    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
[    0.000000]  arch_timer_acpi_init+0x274/0x6ac
[    0.000000]  acpi_table_parse+0x1ac/0x218
[    0.000000]  __acpi_probe_device_table+0x164/0x1ec
[    0.000000]  timer_probe+0x1bc/0x254
[    0.000000]  time_init+0x44/0x98
[    0.000000]  start_kernel+0x4ec/0x7d4

This is due to the commit cb538267ea1e ("jump_label/lockdep: Assert we hold
the hotplug lock for _cpuslocked() operations"). Therefore, it will check
if it is really in the CPU hotplug path or not, and work around this
problem by using cpus_read_trylock(). The chance of not getting the read
lock is very small. If that happens, it will report a lockdep warning at
most.

Signed-off-by: Qian Cai <cai@gmx.us>
---
 drivers/clocksource/arm_arch_timer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc..5c9acbd 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -497,11 +497,20 @@ void arch_timer_enable_workaround(const struct arch_timer_erratum_workaround *wa
 			per_cpu(timer_unstable_counter_workaround, i) = wa;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+	i = 0;
+
 	/*
 	 * Use the locked version, as we're called from the CPU
 	 * hotplug framework. Otherwise, we end-up in deadlock-land.
 	 */
+	i = cpus_read_trylock();
 	static_branch_enable_cpuslocked(&arch_timer_read_ool_enabled);
+	if (i)
+		cpus_read_unlock();
+#else
+	static_branch_enable(&arch_timer_read_ool_enabled);
+#endif
 
 	/*
 	 * Don't use the vdso fastpath if errata require using the
-- 
1.8.3.1

