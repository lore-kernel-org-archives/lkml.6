Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804878-2-1084086275355067373
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804878; b=WNiiq+ZFvw0cMaFI4lvBZFT7P4WJ/aj6evRAitqGJCNYQBS
    NaTSyvbsYTo9JvxzktMHx+yMSWCyjjVK9S3J03yk+tGSlx+r2x/bioWWpcvOpYxW
    GOXXgeaUoly8G5Q1reJPxjHb8XR1+YFAk8X6C2Q+Y/1H7vn1Aj1cEvv/GiU0ng20
    HhzeXDDWgmZy1Mtxwyk1dNLwDT70eyIdotdFanB5fvIuGg7FWEU7aqn3q0fD3uM/
    8aA0ZGgandtLR19O4ClISR97cDJkIjh7qHvKT7/Wl2X7zALc2BEBApivLu6i6Uxv
    SDFKmYEd8JvBUW4aemVX6FTLUJgEpVpU6QpmjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804878; bh=Xvx5xNBe6m1RlyZG0z9+bybguQ
    F5I1q/n0aPXn7Imnk=; b=LHdoF3Q7YE2z02P0fzCFvbbiZISLKGvmghMUBk4eCn
    xpFS5FJyaMgruf3uXkUuLUgmlGyIQEZg7JSR54F8ARPweA624ESa/SfLkeufGoXa
    WSbERF0ohwCHujVCDXQMrpaEZZth8gRaIJC/8st+mgKeQGvN1/N8yWU1fQGFL+95
    S5b6pDyYs5l44RtiHh9atNbVzOIb5onk2H+aIJhFH3fwxcgMk6O7cmyxrknDNwLh
    R7Uf3jWP4cZqQSfBGSRxTimlM6UHBb7OQf0MEIYwXUraI0J053uwHdu5pZVfpyft
    o78hmvQOQPm3VttzaoQiCRwGZMa2uOVhaxcA1IzzALTA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbeCWLeQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:34:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39636 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754963AbeCWKFX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiantian Feng <fengtiantian@huawei.com>,
        Xishi Qiu <qiuxishi@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 035/177] x86/reboot: Turn off KVM when halting a CPU
Date: Fri, 23 Mar 2018 10:52:43 +0100
Message-Id: <20180323094206.708266756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiantian Feng <fengtiantian@huawei.com>


[ Upstream commit fba4f472b33aa81ca1836f57d005455261e9126f ]

A CPU in VMX root mode will ignore INIT signals and will fail to bring
up the APs after reboot.  Therefore, on a panic we disable VMX on all
CPUs before rebooting or triggering kdump.

Do this when halting the machine as well, in case a firmware-level reboot
does not perform a cold reset for all processors.  Without doing this,
rebooting the host may hang.

Signed-off-by: Tiantian Feng <fengtiantian@huawei.com>
Signed-off-by: Xishi Qiu <qiuxishi@huawei.com>
[ Rewritten commit message. ]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kvm@vger.kernel.org
Link: http://lkml.kernel.org/r/20170419161839.30550-1-pbonzini@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/smp.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
 #include <asm/kexec.h>
+#include <asm/virtext.h>
 
 /*
  *	Some notes on x86 processor bugs affecting SMP operation:
@@ -162,6 +163,7 @@ static int smp_stop_nmi_callback(unsigne
 	if (raw_smp_processor_id() == atomic_read(&stopping_cpu))
 		return NMI_HANDLED;
 
+	cpu_emergency_vmxoff();
 	stop_this_cpu(NULL);
 
 	return NMI_HANDLED;
@@ -174,6 +176,7 @@ static int smp_stop_nmi_callback(unsigne
 asmlinkage __visible void smp_reboot_interrupt(void)
 {
 	ipi_entering_ack_irq();
+	cpu_emergency_vmxoff();
 	stop_this_cpu(NULL);
 	irq_exit();
 }
