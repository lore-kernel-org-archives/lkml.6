Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3955CEB146E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D110B20841
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="fun9vzgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D110B20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeGLS3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:29:33 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36756 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeGLS3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:29:32 -0400
Received: by mail-qk0-f181.google.com with SMTP id a132-v6so15918166qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tWr1ViIWQHTGQuCxHyo1wGHkmCxdSHbWMBm7vyrHfAQ=;
        b=fun9vzgfRH0l+e4FQ3ExOImKOmZxhuAw9WykToeA6cyQgcDsBG+eAegqhuNotxgdgR
         pJZvNI6b0IYZlv6WjzZVq+9uqx8SNUwP4pfuXxVYpU9CcvR/cz4K4tfmQ9EKd99hl1ap
         pbRAIwqdSY19i0O1yJ7hcIIBxrMA/ch3NIuS3wJH/6tMDNv90qsdVf1O4FX2crJV/mbP
         wR8/qrwBYa+6Af1lyLBMQRPPInTlB+hKVD67nypaXD38kB7S9gwo2sHEqHvDiGL44t+K
         yQk4O700eDOZePwd3sNJ+VJEg+9foRwJi6ynOYgYi/LXNEVW1aHHApzu54I+SPGE7i5V
         JjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tWr1ViIWQHTGQuCxHyo1wGHkmCxdSHbWMBm7vyrHfAQ=;
        b=kpN//jnikzi+5qYUcKVy8vgMdHVboThk7t8RWTVw6HUznH22gPaz7jjo7BFrsLOcQ5
         ezDTCgYDtldgBjY4jCm8Jh+KIWzpJA4tovcrADyUB1gG4OpCEFDW3SbXAuIGjbDTevY6
         bZcYrYyxXz7PoOB/VOETQrKeorQ6eEmI4rtNN3n6Cw7jVdZ3qIcVPLAhw+r353r1flBm
         cxUhRndwGUWKEwelHSkjvkhhXfwElfKOieOeYLH+hdnBseItyvXKTG746QW5B4f/VQ3q
         Oyj7HdoSd8DFVEDt0vjZqB8FhqoRPC88M/ZRlvK3HopETHGXcbfsAyEBUpw27N/oLHp/
         UVMw==
X-Gm-Message-State: AOUpUlELtC2q6AsY3Gw/4YQTbqDNk/ReXaTpb+OVmkdS57cTfq/w8DUS
        D9sVvFu6LoYDoGwoYofVk0gIwD0L
X-Google-Smtp-Source: AAOMgpcOJDBW+x0k15bo6DelgOOB47pvxBCkA9bjbyWCmZa7HfnN1EX1Hh6R+RRLoK3lX5DOBxqLLA==
X-Received: by 2002:ae9:eb43:: with SMTP id b64-v6mr2768917qkg.71.1531419529587;
        Thu, 12 Jul 2018 11:18:49 -0700 (PDT)
Received: from cisco.cisco.com ([173.38.117.87])
        by smtp.gmail.com with ESMTPSA id x7-v6sm10576819qtc.66.2018.07.12.11.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:18:48 -0700 (PDT)
Date:   Thu, 12 Jul 2018 12:18:46 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v4] uart: fix race between uart_put_char() and
 uart_shutdown()
Message-ID: <20180712181846.GD13192@cisco.cisco.com>
References: <20180706212220.GC3583@cisco.lan>
 <20180711160744.32074-1-tycho@tycho.ws>
 <20180712150438.GF22502@kroah.com>
 <20180712150822.GC13192@cisco.cisco.com>
 <20180712154015.GC13114@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180712154015.GC13114@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 05:40:15PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 12, 2018 at 09:08:22AM -0600, Tycho Andersen wrote:
> > On Thu, Jul 12, 2018 at 05:04:38PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jul 11, 2018 at 10:07:44AM -0600, Tycho Andersen wrote:
> > > > +	if (uport)
> > > > +		spin_lock_irqsave(&uport->lock, flags);
> > > 
> > > That's the same thing as just calling uart_port_lock(), why aren't you
> > > doing that?
> > 
> > Because the compiler can't seem to "see" through the macros/ref calls,
> > and I get the warning I mentioned here if I use them:
> > 
> > https://lkml.org/lkml/2018/7/6/840
> 
> What horrible version of gcc are you using that give you that?  Don't
> open-code things just because of a broken compiler.

I've tried with both 7.3.0 and 5.4.0. I think the reason we see this
here but not elsewhere in the file is because there's an actual
function call (free_page()) in the critical section.

If we move that out, something like the below patch, it all works for
me.

Tycho


From 532e82ceec67142b71c60ce74ce08c5339195a94 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tycho@tycho.ws>
Date: Mon, 4 Jun 2018 09:55:09 -0600
Subject: [PATCH] uart: fix race between uart_put_char() and uart_shutdown()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We have reports of the following crash:

    PID: 7 TASK: ffff88085c6d61c0 CPU: 1 COMMAND: "kworker/u25:0"
    #0 [ffff88085c6db710] machine_kexec at ffffffff81046239
    #1 [ffff88085c6db760] crash_kexec at ffffffff810fc248
    #2 [ffff88085c6db830] oops_end at ffffffff81008ae7
    #3 [ffff88085c6db860] no_context at ffffffff81050b8f
    #4 [ffff88085c6db8b0] __bad_area_nosemaphore at ffffffff81050d75
    #5 [ffff88085c6db900] bad_area_nosemaphore at ffffffff81050e83
    #6 [ffff88085c6db910] __do_page_fault at ffffffff8105132e
    #7 [ffff88085c6db9b0] do_page_fault at ffffffff8105152c
    #8 [ffff88085c6db9c0] page_fault at ffffffff81a3f122
    [exception RIP: uart_put_char+149]
    RIP: ffffffff814b67b5 RSP: ffff88085c6dba78 RFLAGS: 00010006
    RAX: 0000000000000292 RBX: ffffffff827c5120 RCX: 0000000000000081
    RDX: 0000000000000000 RSI: 000000000000005f RDI: ffffffff827c5120
    RBP: ffff88085c6dba98 R8: 000000000000012c R9: ffffffff822ea320
    R10: ffff88085fe4db04 R11: 0000000000000001 R12: ffff881059f9c000
    R13: 0000000000000001 R14: 000000000000005f R15: 0000000000000fba
    ORIG_RAX: ffffffffffffffff CS: 0010 SS: 0018
    #9 [ffff88085c6dbaa0] tty_put_char at ffffffff81497544
    #10 [ffff88085c6dbac0] do_output_char at ffffffff8149c91c
    #11 [ffff88085c6dbae0] __process_echoes at ffffffff8149cb8b
    #12 [ffff88085c6dbb30] commit_echoes at ffffffff8149cdc2
    #13 [ffff88085c6dbb60] n_tty_receive_buf_fast at ffffffff8149e49b
    #14 [ffff88085c6dbbc0] __receive_buf at ffffffff8149ef5a
    #15 [ffff88085c6dbc20] n_tty_receive_buf_common at ffffffff8149f016
    #16 [ffff88085c6dbca0] n_tty_receive_buf2 at ffffffff8149f194
    #17 [ffff88085c6dbcb0] flush_to_ldisc at ffffffff814a238a
    #18 [ffff88085c6dbd50] process_one_work at ffffffff81090be2
    #19 [ffff88085c6dbe20] worker_thread at ffffffff81091b4d
    #20 [ffff88085c6dbeb0] kthread at ffffffff81096384
    #21 [ffff88085c6dbf50] ret_from_fork at ffffffff81a3d69f​

after slogging through some dissasembly:

ffffffff814b6720 <uart_put_char>:
ffffffff814b6720:	55                   	push   %rbp
ffffffff814b6721:	48 89 e5             	mov    %rsp,%rbp
ffffffff814b6724:	48 83 ec 20          	sub    $0x20,%rsp
ffffffff814b6728:	48 89 1c 24          	mov    %rbx,(%rsp)
ffffffff814b672c:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
ffffffff814b6731:	4c 89 6c 24 10       	mov    %r13,0x10(%rsp)
ffffffff814b6736:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
ffffffff814b673b:	e8 b0 8e 58 00       	callq  ffffffff81a3f5f0 <mcount>
ffffffff814b6740:	4c 8b a7 88 02 00 00 	mov    0x288(%rdi),%r12
ffffffff814b6747:	45 31 ed             	xor    %r13d,%r13d
ffffffff814b674a:	41 89 f6             	mov    %esi,%r14d
ffffffff814b674d:	49 83 bc 24 70 01 00 	cmpq   $0x0,0x170(%r12)
ffffffff814b6754:	00 00
ffffffff814b6756:	49 8b 9c 24 80 01 00 	mov    0x180(%r12),%rbx
ffffffff814b675d:	00
ffffffff814b675e:	74 2f                	je     ffffffff814b678f <uart_put_char+0x6f>
ffffffff814b6760:	48 89 df             	mov    %rbx,%rdi
ffffffff814b6763:	e8 a8 67 58 00       	callq  ffffffff81a3cf10 <_raw_spin_lock_irqsave>
ffffffff814b6768:	41 8b 8c 24 78 01 00 	mov    0x178(%r12),%ecx
ffffffff814b676f:	00
ffffffff814b6770:	89 ca                	mov    %ecx,%edx
ffffffff814b6772:	f7 d2                	not    %edx
ffffffff814b6774:	41 03 94 24 7c 01 00 	add    0x17c(%r12),%edx
ffffffff814b677b:	00
ffffffff814b677c:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
ffffffff814b6782:	75 23                	jne    ffffffff814b67a7 <uart_put_char+0x87>
ffffffff814b6784:	48 89 c6             	mov    %rax,%rsi
ffffffff814b6787:	48 89 df             	mov    %rbx,%rdi
ffffffff814b678a:	e8 e1 64 58 00       	callq  ffffffff81a3cc70 <_raw_spin_unlock_irqrestore>
ffffffff814b678f:	44 89 e8             	mov    %r13d,%eax
ffffffff814b6792:	48 8b 1c 24          	mov    (%rsp),%rbx
ffffffff814b6796:	4c 8b 64 24 08       	mov    0x8(%rsp),%r12
ffffffff814b679b:	4c 8b 6c 24 10       	mov    0x10(%rsp),%r13
ffffffff814b67a0:	4c 8b 74 24 18       	mov    0x18(%rsp),%r14
ffffffff814b67a5:	c9                   	leaveq
ffffffff814b67a6:	c3                   	retq
ffffffff814b67a7:	49 8b 94 24 70 01 00 	mov    0x170(%r12),%rdx
ffffffff814b67ae:	00
ffffffff814b67af:	48 63 c9             	movslq %ecx,%rcx
ffffffff814b67b2:	41 b5 01             	mov    $0x1,%r13b
ffffffff814b67b5:	44 88 34 0a          	mov    %r14b,(%rdx,%rcx,1)
ffffffff814b67b9:	41 8b 94 24 78 01 00 	mov    0x178(%r12),%edx
ffffffff814b67c0:	00
ffffffff814b67c1:	83 c2 01             	add    $0x1,%edx
ffffffff814b67c4:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
ffffffff814b67ca:	41 89 94 24 78 01 00 	mov    %edx,0x178(%r12)
ffffffff814b67d1:	00
ffffffff814b67d2:	eb b0                	jmp    ffffffff814b6784 <uart_put_char+0x64>
ffffffff814b67d4:	66 66 66 2e 0f 1f 84 	data32 data32 nopw %cs:0x0(%rax,%rax,1)
ffffffff814b67db:	00 00 00 00 00

for our build, this is crashing at:

    circ->buf[circ->head] = c;

Looking in uart_port_startup(), it seems that circ->buf (state->xmit.buf)
protected by the "per-port mutex", which based on uart_port_check() is
state->port.mutex. Indeed, the lock acquired in uart_put_char() is
uport->lock, i.e. not the same lock.

Anyway, since the lock is not acquired, if uart_shutdown() is called, the
last chunk of that function may release state->xmit.buf before its assigned
to null, and cause the race above.

To fix it, let's lock uport->lock when allocating/deallocating
state->xmit.buf in addition to the per-port mutex.

v2: switch to locking uport->lock on allocation/deallocation instead of
    locking the per-port mutex in uart_put_char. Note that since
    uport->lock is a spin lock, we have to switch the allocation to
    GFP_ATOMIC.
v3: move the allocation outside the lock, so we can switch back to
    GFP_KERNEL
v4: * switch to positive condition of state->xmit.buf in
      uart_port_startup()
    * declare `flags` on its own line
    * use the result of uart_port_lock() in uart_shutdown() to avoid
      uninitialized warning
    * don't use the uart_port_lock/unlock macros in uart_port_startup,
      instead test against uport directly; the compiler can't seem to "see"
      through the macros/ref/unref calls to not warn about uninitialized
      flags. We don't need to do a ref here since we hold the per-port
      mutex anyway.
v5: use uart_port_lock/unlock, but free the page outside the critical
    section if it is unused

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 drivers/tty/serial/serial_core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 9c14a453f73c..91b292bbda91 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -182,6 +182,8 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 {
 	struct uart_port *uport = uart_port_check(state);
 	unsigned long page;
+	unsigned long flags;
+	bool page_used = false;
 	int retval = 0;
 
 	if (uport->type == PORT_UNKNOWN)
@@ -196,15 +198,20 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	 * Initialise and allocate the transmit and temporary
 	 * buffer.
 	 */
-	if (!state->xmit.buf) {
-		/* This is protected by the per port mutex */
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page)
-			return -ENOMEM;
+	page = get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
 
+	uport = uart_port_lock(state, flags);
+	if (!state->xmit.buf) {
 		state->xmit.buf = (unsigned char *) page;
 		uart_circ_clear(&state->xmit);
+		page_used = true;
 	}
+	uart_port_unlock(uport, flags);
+
+	if (!page_used)
+		free_page(page);
 
 	retval = uport->ops->startup(uport);
 	if (retval == 0) {
@@ -263,6 +270,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 {
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
+	unsigned long flags;
 
 	/*
 	 * Set the TTY IO error marker
@@ -295,10 +303,12 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	/*
 	 * Free the transmit buffer page.
 	 */
+	uport = uart_port_lock(state, flags);
 	if (state->xmit.buf) {
 		free_page((unsigned long)state->xmit.buf);
 		state->xmit.buf = NULL;
 	}
+	uart_port_unlock(uport, flags);
 }
 
 /**
-- 
2.17.1

