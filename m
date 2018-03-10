Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941007-1520715359-2-15826496647275315561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520715358; b=rKq9j+zhMeLYOvxmSWuoonOSuYQ1Zb8zlTy6YvUr9YEKJbz
    xoekLJoMqIaDCT5AKmFyb079P4xgOheTqDyBBa47YipiM3HhuTDoyI86BTLlEGAo
    Qd6kUqVrE/Rew8cwwu/kaek7F/ErnAlvKypynFeJlOT5lYaIbgB0CXdyQ18mFf5J
    tXv5iNMatRXoWRHeETz46f+cK7Z4SOcWM8KqZNs1/jAwu4OpnYyWEZqBVkHMFo+8
    JU+DR1BiSJhHSbbA8b/RlNzbjrLXSZ9em9w4UVbVpcISVbgqxeRD5cbGFnq4lyuB
    6HBr1OUTa5wPP/94VX0u3ER7g8Im6uh8QaDJGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-id:mime-version:content-transfer-encoding
    :sender:list-id; s=arctest; t=1520715358; bh=CC7rmtpmSC7YB18WcPs
    8RicTttI2/P6uoX5b/6c8SK0=; b=dPhf1eGWZ9PQ2Axn+lggkhDwL44GjQYdmc6
    21CnE2PhTNbtLYh7zF31c/CpGR+wJ+bZYQZFrT0BqWCKMej9lfGMpd7VRQxJ4z/H
    CJE5DyMSTGsetOvox0EbiJzcDyDWTQJHrAYWrpc0TCRXc+lTHOamEBiMnJRfjfyq
    wnQeqdwXDruzfIe3TJvzRQAU2mZF3e+pP19sBNXzSg8VF6hCRV/3QcDZMn/cz/uj
    3yw76jRBmQ3A0qhPrjSGwobPm+wMNVsRaKeGaKDqIKTaix/1/iQJqDomc5NKhhlr
    G21v74tID7m0LuQ0G2enJEt7Ivbg4UpNnVKo0kGfDwsQ6AtKaSQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=SlzQszhd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=SlzQszhd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750946AbeCJUzy (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 15:55:54 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:42080 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeCJUzx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 10 Mar 2018 15:55:53 -0500
X-IronPort-AV: E=Sophos;i="5.47,452,1515456000";
   d="scan'208";a="670141726"
From: "Tautschnig, Michael" <tautschn@amazon.co.uk>
To: "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86: always use SYSCALL_DEFINE*
Thread-Topic: [PATCH] x86: always use SYSCALL_DEFINE*
Thread-Index: AQHTuLIp4kJZlR4voUmoYns5SdXQ2A==
Date: Sat, 10 Mar 2018 20:55:46 +0000
Message-ID: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.246]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91976A686E6EEE4DB3F549E4F8BBBB3C@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All syscall arguments are passed in as types of the same byte size as
unsigned long (width of full registers). Using a smaller type without a
cast may result in losing bits of information. SYSCALL_DEFINE* introduce
adequate type casts. All definitions of syscalls in x86 except for those
patched here have already been using the appropriate SYSCALL_DEFINE*.

Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jaswinder Singh <jaswinder@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/ioport.c | 3 ++-
 arch/x86/kernel/signal.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index 2f72330..d98b2a3 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -23,7 +23,8 @@
 /*
  * this changes the io permissions bitmap in the current task.
  */
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn=
_on)
+SYSCALL_DEFINE3(sys_ioperm, unsigned long, from, unsigned long, num, int,
+		turn_on)
 {
 	struct thread_struct *t =3D &current->thread;
 	struct tss_struct *tss;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index b9e00e8..40ba242 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -25,6 +25,7 @@
 #include <linux/user-return-notifier.h>
 #include <linux/uprobes.h>
 #include <linux/context_tracking.h>
+#include <linux/syscalls.h>

 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -601,7 +602,7 @@ static int x32_setup_rt_frame(struct ksignal *ksig,
  * Do a signal return; undo the signal stack.
  */
 #ifdef CONFIG_X86_32
-asmlinkage unsigned long sys_sigreturn(void)
+SYSCALL_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs =3D current_pt_regs();
 	struct sigframe __user *frame;
@@ -633,7 +634,7 @@ asmlinkage unsigned long sys_sigreturn(void)
 }
 #endif /* CONFIG_X86_32 */

-asmlinkage long sys_rt_sigreturn(void)
+SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs =3D current_pt_regs();
 	struct rt_sigframe __user *frame;
--
2.7.3.AMZN



Amazon Web Services UK Limited. Registered in England and Wales with regist=
ration number 08650665 with its registered office at 1 Principal Place, Wor=
ship Street, London, EC2A 2FA, United Kingdom.



