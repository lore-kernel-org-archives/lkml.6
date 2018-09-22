Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC225C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC1F2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 09:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC1F2154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeIVPJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 11:09:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeIVPJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 11:09:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8M9FrKU2272348
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 Sep 2018 02:15:53 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8M9Fq962272345;
        Sat, 22 Sep 2018 02:15:52 -0700
Date:   Sat, 22 Sep 2018 02:15:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for zhong jiang <tipbot@zytor.com>
Message-ID: <tip-8e6b65a1b6cd1711d3acd2aa5c60d38c3e15dabb@git.kernel.org>
Cc:     tglx@linutronix.de, konrad.wilk@oracle.com, zhongjiang@huawei.com,
        mingo@kernel.org, bp@suse.de, hpa@zytor.com, x86@kernel.org,
        dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, luto@kernel.org,
        pasha.tatashin@oracle.com
Reply-To: pasha.tatashin@oracle.com, luto@kernel.org,
          linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, x86@kernel.org,
          hpa@zytor.com, bp@suse.de, mingo@kernel.org,
          zhongjiang@huawei.com, tglx@linutronix.de, konrad.wilk@oracle.com
In-Reply-To: <1536806985-24197-1-git-send-email-zhongjiang@huawei.com>
References: <1536806985-24197-1-git-send-email-zhongjiang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/CPU: Fix unused variable warning when
 !CONFIG_IA32_EMULATION
Git-Commit-ID: 8e6b65a1b6cd1711d3acd2aa5c60d38c3e15dabb
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

Commit-ID:  8e6b65a1b6cd1711d3acd2aa5c60d38c3e15dabb
Gitweb:     https://git.kernel.org/tip/8e6b65a1b6cd1711d3acd2aa5c60d38c3e15dabb
Author:     zhong jiang <zhongjiang@huawei.com>
AuthorDate: Thu, 13 Sep 2018 10:49:45 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 15 Sep 2018 14:57:05 +0200

x86/CPU: Fix unused variable warning when !CONFIG_IA32_EMULATION

Get rid of local @cpu variable which is unused in the
!CONFIG_IA32_EMULATION case.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: x86-ml <x86@kernel.org>
Link: http://lkml.kernel.org/r/1536806985-24197-1-git-send-email-zhongjiang@huawei.com
[ Clean up commit message. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2d5b1fa5f9c6..8bffeae9bac2 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1531,8 +1531,6 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
-	int __maybe_unused cpu = smp_processor_id();
-
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
 	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
@@ -1545,7 +1543,8 @@ void syscall_init(void)
 	 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
 	 */
 	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
-	wrmsrl_safe(MSR_IA32_SYSENTER_ESP, (unsigned long)(cpu_entry_stack(cpu) + 1));
+	wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
+		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
 	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
 #else
 	wrmsrl(MSR_CSTAR, (unsigned long)ignore_sysret);
