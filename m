Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965323AbeBMQ7D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:59:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965218AbeBMQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:59:01 -0500
Date: Tue, 13 Feb 2018 08:58:35 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-afed7d172091040f38c75a2927fed170ea11585f@git.kernel.org>
Cc: torvalds@linux-foundation.org, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        jgross@suse.com, hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
        douly.fnst@cn.fujitsu.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org, jgross@suse.com
In-Reply-To: <20180117034543.26723-1-douly.fnst@cn.fujitsu.com>
References: <20180117034543.26723-1-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/x2apic: Mark set_x2apic_phys_mode() as __init
Git-Commit-ID: afed7d172091040f38c75a2927fed170ea11585f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  afed7d172091040f38c75a2927fed170ea11585f
Gitweb:     https://git.kernel.org/tip/afed7d172091040f38c75a2927fed170ea11585f
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Wed, 17 Jan 2018 11:45:43 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 17:24:36 +0100

x86/x2apic: Mark set_x2apic_phys_mode() as __init

set_x2apic_phys_mode() is only called as part of early_param()
initialization - so mark it as __init.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180117034543.26723-1-douly.fnst@cn.fujitsu.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/apic/x2apic_phys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index f8d9d69..e2829bf 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -14,7 +14,7 @@ int x2apic_phys;
 
 static struct apic apic_x2apic_phys;
 
-static int set_x2apic_phys_mode(char *arg)
+static int __init set_x2apic_phys_mode(char *arg)
 {
 	x2apic_phys = 1;
 	return 0;
