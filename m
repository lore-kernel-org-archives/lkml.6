Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1070038-1520761429-2-4397242742394950226
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
    t=1520761428; b=hIGPL6lmLYADAcmF/1J+fNLjOFnKphL2lpBKkVgH1xsEqfH
    aAt/uuslBVtcIufJ3cWSVa7GC5jKIaO/p+EYTMVXLYjF7+oCSzGDrqdMaOHHW4OA
    puA4l5ojdZ/pUpz6DZbNlEKH6GgUXZC7IAlGT3aPExeyDlrLy2BIJsPXQN9xQB3K
    i3x1u27AyON+gMowPG4R3e3IqpNa6/X4ym6icXnRl3nJ5c73VBpcR6f6vmxdPI/P
    IndguP2gL0QAPJirwhpr3DaPN8ZvuDxAJ+vkBcdIBx7bXIhqEPXGEDFlwqJT72GI
    X2UXn4b9sXHMqrUg3G2K8snzxgz/Ay8Nnzuj/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520761428; bh=i/Pl+YwzWICaO72Z3lgoi4fLFRuGDNlQFpYxsHUHiv0=; b=P
    KYJlXzmxDoJvedZoHGSQ9htGmFHNd0Tal4L9L6ivUY3gsp6WgYxBpvx3nPnjDSdU
    VJn3SWVROOj8sK4UJKmTaWuW3Zi3KLibUADjBJG4jTCavBkCLrhzMYiUAsiUrP1Z
    JEGAWipmHJYLLSb8rbWr3YjJiospUym0RrW1rSwF7r+jK5uKn6TeHo0yDtstkVrf
    UPMSoOYwZ99esgZvUkpdp85JwLhSXLbqoHL0RQpi/tA/K9iYzEfnGx0Kb2WUpQtD
    yVG4ymTk8oVPHQJhS6pqMfiWvwnC0FRsExFQvDZMH/TeerDJSTQwHW/skqC1mCKp
    ops8wvsmNkCM3aeRaGFxw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=cB5r4poO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=cB5r4poO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932113AbeCKJnp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 05:43:45 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:26884 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbeCKJno (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 11 Mar 2018 05:43:44 -0400
X-IronPort-AV: E=Sophos;i="5.47,455,1515456000";
   d="scan'208";a="711382997"
From: "Tautschnig, Michael" <tautschn@amazon.co.uk>
To: "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] x86: always use SYSCALL_DEFINE*
Thread-Topic: [PATCH v2] x86: always use SYSCALL_DEFINE*
Thread-Index: AQHTuR1t6+xAKmQrs0eoXQ4iLgB3kg==
Date: Sun, 11 Mar 2018 09:43:37 +0000
Message-ID: <CA5F8E03-A6D6-4FD1-B891-57A290BDF53C@amazon.com>
References: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
In-Reply-To: <14A5C8D0-3F9D-486F-A20C-55849D70FC80@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EADCEAB9B50FFB43AF2CC26836F015FB@amazon.com>
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
index 2f72330..7db3d65 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -23,7 +23,8 @@
 /*
  * this changes the io permissions bitmap in the current task.
  */
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn=
_on)
+SYSCALL_DEFINE3(ioperm, unsigned long, from, unsigned long, num, int,
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



