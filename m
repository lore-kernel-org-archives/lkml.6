Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-404623-1525451453-2-2760915224257523047
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525451453; b=aawH2YlWO3PqDdzh0vHgXdDa9LFVvSZlyakxlF+Sb7yVAp2g5f
    YiK428JWfgIt42yhuDaR2VuLI1aIDs+94yLLHFvc306za5ksbDWUAoJnr/nVO+I/
    05LhEfG2ZcwW2qSqsBpZFiVsYsZ6IpWRBDsnNlPWreeDZGkaQ13JmVLwCEzb7ceE
    ic7f8PiSXHXiO776rbRIIJJX4vkjoMpGkaZRv+mpixZK/sPfWkpS29vYtBygbK7K
    WAmU+kvk61uxNg8u3HgVm8lA0sq1X8oGcLUTxC9waeqHEbAOLOeuJ0DDtFBzjpMn
    mQepaIIReSHlDqtIa3Q1GG7bh6//r228xlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525451453; bh=73ZdL4nDp+DmKPR8/fLjXLqXHm6OWp
    olUWBNQYjAeSA=; b=Bzu5i2CXiUqv+Se+n+niIbHdInWHbnkX2ZF9XOKMjpkWxR
    0InZMk0NWT4lDFs1/HsNen/lYEA+R02Mx81vMsHNafQpwBzormovGxWvPfGj4eLv
    X8dR7xnbq2/J5cIXfkouXRzhibcGefXGKFUw/CPSmbWk1thAIzffz7EtVBj4sTAQ
    knzscppWu6zI7o09R3qLQpUeyWjgp7QHxECI3mJKBka3siz5cNoJurFVC2jA7Bcg
    NcbdPwBI3pR6HI2ZG36gDuuHPmUILiaqHSbxxS7803dDuBZn0kOBz0qkctPNEYmp
    YXQ4VttdLDDOoIQO5s1JbjiFoC+d60+wCX8I2arw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=monom.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=monom.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOTz4N2Z9CoVGvpeSkm5asogkqIxRzDc57ADcBIr3mMlxKuGMGKEcuTHhM/ArzF8eLuUk4rLFXq+fqUnUNQIIW9imMyo1vCFhIZzIewzRRxM2CMB01Qw
    peEOUZuvmMxihI7NPadl/52q3yiMZ9CuKOd7TO1qkHlo0YXoHKS2+iJLb3seAaNQSzitWic7ijbba9yQmZ6rKVXwUqHJvWmtRkfi+3CHAylNyjW2GQUAN6Pi
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=a_U1oVfrAAAA:8
    a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=tgf0_7RPPExJJp9HkRQA:9
    a=9tQt16chFYpXjSPs:21 a=UQkWfTKAC_-ToryL:21 a=x8gzFH9gYPwA:10
    a=ILgoY2Ve9XsnFM_ECIJt:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeEDQau (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 12:30:50 -0400
Received: from mail.monom.org ([188.138.9.77]:45246 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751539AbeEDQat (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 May 2018 12:30:49 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail.monom.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.1
From: Daniel Wagner <wagi@monom.org>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-rt-users@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-sh@vger.kernel.org, gregkh@linuxfoundation.org,
        Daniel Wagner <daniel.wagner@siemens.com>
Subject: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding version
Date: Fri,  4 May 2018 18:30:41 +0200
Message-Id: <20180504163041.28726-1-wagi@monom.org>
X-Mailer: git-send-email 2.14.3
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@siemens.com>

Commit 40f70c03e33a ("serial: sh-sci: add locking to console write
function to avoid SMP lockup") copied the strategy to avoid locking
problems in conjuncture with the console from the UART8250
driver. Instead using directly spin_{try}lock_irqsave(),
local_irq_save() followed by spin_{try}lock() was used. While this is
correct on mainline, for -rt it is a problem. spin_{try}lock() will
check if it is running in a valid context. Since the local_irq_save()
has already been executed, the context has changed and
spin_{try}lock() will complain. The reason why spin_{try}lock()
complains is that on -rt the spin locks are turned into mutexes and
therefore can sleep. Sleeping with interrupts disabled is not valid.

BUG: sleeping function called from invalid context at /home/wagi/work/rt/v4.4-cip-rt/kernel/locking/rtmutex.c:995
in_atomic(): 0, irqs_disabled(): 128, pid: 778, name: irq/76-eth0
CPU: 0 PID: 778 Comm: irq/76-eth0 Not tainted 4.4.126-test-cip22-rt14-00403-gcd03665c8318 #12
Hardware name: Generic RZ/G1 (Flattened Device Tree)
Backtrace:
[<c00140a0>] (dump_backtrace) from [<c001424c>] (show_stack+0x18/0x1c)
 r7:c06b01f0 r6:60010193 r5:00000000 r4:c06b01f0
[<c0014234>] (show_stack) from [<c01d3c94>] (dump_stack+0x78/0x94)
[<c01d3c1c>] (dump_stack) from [<c004c134>] (___might_sleep+0x134/0x194)
 r7:60010113 r6:c06d3559 r5:00000000 r4:ffffe000
[<c004c000>] (___might_sleep) from [<c04ded60>] (rt_spin_lock+0x20/0x74)
 r5:c06f4d60 r4:c06f4d60
[<c04ded40>] (rt_spin_lock) from [<c02577e4>] (serial_console_write+0x100/0x118)
 r5:c06f4d60 r4:c06f4d60
[<c02576e4>] (serial_console_write) from [<c0061060>] (call_console_drivers.constprop.15+0x10c/0x124)
 r10:c06d2894 r9:c04e18b0 r8:00000028 r7:00000000 r6:c06d3559 r5:c06d2798
 r4:c06b9914 r3:c02576e4
[<c0060f54>] (call_console_drivers.constprop.15) from [<c0062984>] (console_unlock+0x32c/0x430)
 r10:c06d30d8 r9:00000028 r8:c06dd518 r7:00000005 r6:00000000 r5:c06d2798
 r4:c06d2798 r3:00000028
[<c0062658>] (console_unlock) from [<c0062e1c>] (vprintk_emit+0x394/0x4f0)
 r10:c06d2798 r9:c06d30ee r8:00000006 r7:00000005 r6:c06a78fc r5:00000027
 r4:00000003
[<c0062a88>] (vprintk_emit) from [<c0062fa0>] (vprintk+0x28/0x30)
 r10:c060bd46 r9:00001000 r8:c06b9a90 r7:c06b9a90 r6:c06b994c r5:c06b9a3c
 r4:c0062fa8
[<c0062f78>] (vprintk) from [<c0062fb8>] (vprintk_default+0x10/0x14)
[<c0062fa8>] (vprintk_default) from [<c009cd30>] (printk+0x78/0x84)
[<c009ccbc>] (printk) from [<c025afdc>] (credit_entropy_bits+0x17c/0x2cc)
 r3:00000001 r2:decade60 r1:c061a5ee r0:c061a523
 r4:00000006
[<c025ae60>] (credit_entropy_bits) from [<c025bf74>] (add_interrupt_randomness+0x160/0x178)
 r10:466e7196 r9:1f536000 r8:fffeef74 r7:00000000 r6:c06b9a60 r5:c06b9a3c
 r4:dfbcf680
[<c025be14>] (add_interrupt_randomness) from [<c006536c>] (irq_thread+0x1e8/0x248)
 r10:c006537c r9:c06cdf21 r8:c0064fcc r7:df791c24 r6:df791c00 r5:ffffe000
 r4:df525180
[<c0065184>] (irq_thread) from [<c003fba4>] (kthread+0x108/0x11c)
 r10:00000000 r9:00000000 r8:c0065184 r7:df791c00 r6:00000000 r5:df791d00
 r4:decac000
[<c003fa9c>] (kthread) from [<c00101b8>] (ret_from_fork+0x14/0x3c)
 r8:00000000 r7:00000000 r6:00000000 r5:c003fa9c r4:df791d00

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
---

changes since v1:
 - Ported to current mainline (initial version was against v4.4.y)
 - Left local_irq_save() in place when spinlocks are not used as suggested
   by Geert.

 drivers/tty/serial/sh-sci.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fdbbff547106..ec7417be9e08 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2890,16 +2890,16 @@ static void serial_console_write(struct console *co, const char *s,
 	unsigned long flags;
 	int locked = 1;
 
-	local_irq_save(flags);
 #if defined(SUPPORT_SYSRQ)
-	if (port->sysrq)
+	if (port->sysrq) {
 		locked = 0;
-	else
+		local_irq_save(flags);
+	} else
 #endif
 	if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
 
 	/* first save SCSCR then disable interrupts, keep clock source */
 	ctrl = serial_port_in(port, SCSCR);
@@ -2919,8 +2919,9 @@ static void serial_console_write(struct console *co, const char *s,
 	serial_port_out(port, SCSCR, ctrl);
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
+	else
+		local_irq_restore(flags);
 }
 
 static int serial_console_setup(struct console *co, char *options)
-- 
2.14.3
