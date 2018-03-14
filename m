Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1280822-1521020518-2-16394633731956110082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES dasven, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521020517; b=rCSvGcjmjUtIW7+M5OpL2LjCa+QthabFtXSIZObCEfe5nzi
    GVmLs2PE8S1fZAvNoT4G0ixJSYJyf5B4RGQtXHf8F28+Zq3QgS9yhstADEggbyIa
    wzkgfd7pNG/zZO6Ab6zMlMX2iAxkrszczqTk/5Qb6iXsOH8znH70DJlTP8lxZf2U
    if4spVgEKaoQLtGc1GpY4/BPBKC96S2uujKtA8B9Z7Wko/4aUs26Xy0R8UEinS+u
    BEgCW2xz50NixI8PlAifb+YwoGJDYsL86dOhiYBA2/iwEnBAxqg2+BxGCic9TcbK
    LVhxl7YTQw49fnrgOxWv2r0J/i645an+eGqep2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :content-type:content-id:mime-version:content-transfer-encoding
    :sender:list-id; s=arctest; t=1521020517; bh=dVNYAiewxVB9GaxdY+y
    tXmE2ISnU/lGrxXL01MH/J6M=; b=ShAkPA5Sez246NxIQif2VoHYBjav6LyTkRt
    hP1OugGtWp2O2+SB6H3mtD4sz3GpGVhPHS3WsXt6nxlOIBQqT9Gq0TszEQCmnGbX
    HeQe9MhNZP7TmvR/mg3YEzASqeQWslxp1Ldnhm4W9VO3+xI+7zYk0Y9bRMKXuKC3
    pcRO7TxPYbAl+zn+3qGjAY4QGZ+TXIresMNiOE0XePyz7MxJPPesfBpfiwhAswyR
    waNmcEeE+S8eQZpHySu+zlbmOyP4Pc4pJQURnPWbxPdqoPbMBoesWviOdm2JJ4+4
    7uV/RCNr7YxO+pYy/depLNeDoSaN7QyVQTqBv98sqsUyr3lQ+RQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=vzBCRSGV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=discard (ADSP policy from amazon.co.uk);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=vzBCRSGV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=amazon.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751381AbeCNJlz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 05:41:55 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:47370 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNJlx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Mar 2018 05:41:53 -0400
X-IronPort-AV: E=Sophos;i="5.47,469,1515456000";
   d="scan'208";a="599674396"
From: "Tautschnig, Michael" <tautschn@amazon.co.uk>
To: "x86@kernel.org" <x86@kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jaswinder Singh <jaswinder@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] x86/sigreturn: use SYSCALL_DEFINE0  
Thread-Topic: [PATCH] x86/sigreturn: use SYSCALL_DEFINE0  
Thread-Index: AQHTu3ioXWZ/5N/YjEqO1zxD9uUWOA==
Date: Wed, 14 Mar 2018 09:41:42 +0000
Message-ID: <9C9981F4-0E5E-42A7-8788-70F3DEAD258D@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBB771763136B645B98AA59E70099F0B@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All definitions of syscalls in x86 except for those patched here have
already been using the appropriate SYSCALL_DEFINE*.

Signed-off-by: Michael Tautschnig <tautschn@amazon.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jaswinder Singh <jaswinder@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/kernel/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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



