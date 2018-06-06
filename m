Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="dTK4X9CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 140BB607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752499AbeFFNzD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:55:03 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49340 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752453AbeFFNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:54:57 -0400
X-IronPort-AV: E=Sophos;i="5.49,483,1520899200";
   d="scan'208";a="723031124"
From: Norbert Manthey <nmanthey@amazon.de>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [less-CONFIG_NET 7/7] kvm: drop CONFIG_NET
Date: Wed, 6 Jun 2018 15:53:26 +0200
Message-ID: <1528293206-24298-7-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
References: <1528293127-23825-1-git-send-email-nmanthey@amazon.de>
 <1528293206-24298-1-git-send-email-nmanthey@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some scenarios, we do not want to use CONFIG_NET even though we want
to use CONFIG_KVM. To get this working, and to not pull in more
dependencies, we need to disable CONFIG_TASKSTATS as well.

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
---
 arch/x86/kvm/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 92fd433..f209817 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -22,8 +22,8 @@ config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
 	depends on HAVE_KVM
 	depends on HIGH_RES_TIMERS
-	# for TASKSTATS/TASK_DELAY_ACCT:
-	depends on NET && MULTIUSER
+	# TASK_DELAY_ACCT:
+	depends on MULTIUSER
 	depends on X86_LOCAL_APIC
 	select PREEMPT_NOTIFIERS
 	select MMU_NOTIFIER
@@ -37,7 +37,6 @@ config KVM
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
 	select KVM_MMIO
-	select TASKSTATS
 	select TASK_DELAY_ACCT
 	select PERF_EVENTS
 	select HAVE_KVM_MSI
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
