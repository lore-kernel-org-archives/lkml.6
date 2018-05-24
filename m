Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527160696-2-16921822369986504097
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160695; b=j9G/3SS0yaApysT8SWVxa9mrvf4idNq+I/FSy+0GBC4gI82M0T
    iCyrUl6Bd9+GE7hMkjgBhqXF1Sfmu/NuQVeZpM2oYuJL/q/nPkRqljMTP4mvcCyX
    LT6AaO3uUxPZV1pFtkeviM8WI+Z2vOcOcmC7I2adRDviO14pDygUcAFh0oSDzMTy
    FA7VbIInUrlSTaUwxUDsjc/v82OsjzmwbdrLSwIMc5UgIdmRqEL+5o5xmp1MP/7w
    3XWIxen1f2hlUp3Fl8cC2OiQ88sLLhl2nzr60PqETvwE1+cY/0CTyBbiwKHw2SSB
    NhI10qmheoUNiN0WAK/ry4G76S7tj4QJqeMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160695; bh=jU9XV84bcbIU6hFDzt0J3UTVqwnDeJ
    vWUPl0z8wVtRI=; b=dxFtBgdVZD78FGp9CIcMwc4SLWy1vOpPXN6ApSoRui/xlJ
    tM/f9TNIFCTjZ619y9iKoKc9UR3JJAWLeDzyOMh3JIzYhgclccTUucH/H+IK4q7q
    Rki6r9gr2nR9KtvMEZxBLaPbbAvqcAVtkmecn4xgx9tlK3yOrgmuGwy/PXcLVhid
    iq176oCy7Oui0WzpejwhoFXnw7yEkgQ1z8+GHtrD4BlDE37lYuHrzfRt46Bqdk0Y
    qjETnro9YyC3i8zO+sb9811FZjb6N3N3l2W4ZsOOA7HWXGBMOeDEYLuDb7umlubn
    61aYvFJDpRi2KvfK62m3QhOcV8F7irPZ475zmdUA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IR6rmSFt x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=IR6rmSFt x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP7gYo9m1EclNEBqytw83L3zY7lzLuoVCfrAEjhbUm8uIR6QtUmdET3RqRk2chjglrJ8srlh4d4+SM5nIva8W0NvITmDm7ovmx0DAQlns0I7GM4jwgH1
    ITx9fD+OyRWdw/Jdxi957d4GdvtKzK7AT2No87RkscF3EZQxLTKzfcxN8fMaLCWXdylLdlUOiIQmERZfEC8T37arxH/we8RMH2V/zIbBiyP2b8XbUMe7hvJk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=jxzauDbPASHEnw4kFhcA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967967AbeEXJxO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967991AbeEXJxI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 009/165] tcp: purge write queue in tcp_connect_init()
Date: Thu, 24 May 2018 11:36:55 +0200
Message-Id: <20180524093622.349174480@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7f582b248d0a86bae5788c548d7bb5bca6f7691a ]

syzkaller found a reliable way to crash the host, hitting a BUG()
in __tcp_retransmit_skb()

Malicous MSG_FASTOPEN is the root cause. We need to purge write queue
in tcp_connect_init() at the point we init snd_una/write_seq.

This patch also replaces the BUG() by a less intrusive WARN_ON_ONCE()

kernel BUG at net/ipv4/tcp_output.c:2837!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 5276 Comm: syz-executor0 Not tainted 4.17.0-rc3+ #51
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__tcp_retransmit_skb+0x2992/0x2eb0 net/ipv4/tcp_output.c:2837
RSP: 0000:ffff8801dae06ff8 EFLAGS: 00010206
RAX: ffff8801b9fe61c0 RBX: 00000000ffc18a16 RCX: ffffffff864e1a49
RDX: 0000000000000100 RSI: ffffffff864e2e12 RDI: 0000000000000005
RBP: ffff8801dae073a0 R08: ffff8801b9fe61c0 R09: ffffed0039c40dd2
R10: ffffed0039c40dd2 R11: ffff8801ce206e93 R12: 00000000421eeaad
R13: ffff8801ce206d4e R14: ffff8801ce206cc0 R15: ffff8801cd4f4a80
FS:  0000000000000000(0000) GS:ffff8801dae00000(0063) knlGS:00000000096bc900
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000001c47b6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 tcp_retransmit_skb+0x2e/0x250 net/ipv4/tcp_output.c:2923
 tcp_retransmit_timer+0xc50/0x3060 net/ipv4/tcp_timer.c:488
 tcp_write_timer_handler+0x339/0x960 net/ipv4/tcp_timer.c:573
 tcp_write_timer+0x111/0x1d0 net/ipv4/tcp_timer.c:593
 call_timer_fn+0x230/0x940 kernel/time/timer.c:1326
 expire_timers kernel/time/timer.c:1363 [inline]
 __run_timers+0x79e/0xc50 kernel/time/timer.c:1666
 run_timer_softirq+0x4c/0x70 kernel/time/timer.c:1692
 __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
 invoke_softirq kernel/softirq.c:365 [inline]
 irq_exit+0x1d1/0x200 kernel/softirq.c:405
 exiting_irq arch/x86/include/asm/apic.h:525 [inline]
 smp_apic_timer_interrupt+0x17e/0x710 arch/x86/kernel/apic/apic.c:1052
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:863

Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Yuchung Cheng <ycheng@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2814,8 +2814,10 @@ int __tcp_retransmit_skb(struct sock *sk
 		return -EBUSY;
 
 	if (before(TCP_SKB_CB(skb)->seq, tp->snd_una)) {
-		if (before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))
-			BUG();
+		if (unlikely(before(TCP_SKB_CB(skb)->end_seq, tp->snd_una))) {
+			WARN_ON_ONCE(1);
+			return -EINVAL;
+		}
 		if (tcp_trim_head(sk, skb, tp->snd_una - TCP_SKB_CB(skb)->seq))
 			return -ENOMEM;
 	}
@@ -3312,6 +3314,7 @@ static void tcp_connect_init(struct sock
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->snd_wnd = 0;
 	tcp_init_wl(tp, 0);
+	tcp_write_queue_purge(sk);
 	tp->snd_una = tp->write_seq;
 	tp->snd_sml = tp->write_seq;
 	tp->snd_up = tp->write_seq;
