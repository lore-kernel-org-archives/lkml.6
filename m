Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527164548-2-10640950355478281311
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
    1527164547; b=XaVJwJtSBI0XsYH+bKQj2IIBxNC37DS8wsh2psqYmHJJBowKme
    k7fAs/iamw7iDh3szaITL4YaF0mQkJ763X0GceGFOLQrRoqPYGRY+X+XMSlGqBUB
    ciXqlJ82cXcwKSs0QYzIz6+asxBU7HnXWEd7rVv9z/7UYLgUJIEMVTOXKeivEijN
    msjqLSuqPOshG6g04tNLPL3cen7WvmQd9d/r4JrCPNytzCkMObojNEVES1b0Vdny
    dDEuiVROprJUIIpVy+IqIYv5rn1+yaAYV9YCyCHTwEE67GPccNKOJPfolRtvWlFI
    9+GLUlKvKSXaw4ir/cFIMqDHqAk5974bkhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164547; bh=isXM++l2JhZ/V6pzBT7dvXsQoSHrcU
    rXkAirSYto4/s=; b=FjFHFYq2nIR6Y7n+E1bKGvs+/qF6pehoZe+PGX/Srqu+KE
    FPy1hfIEcFDd3O9w52cKt/BL3f0fvNBFydRXMLVnwhFyGJDtUlV7DF2zUaBG6zTq
    suxYDsoXFz6J+E3Vc3t33VFPn7AA8QmOS0W19aUGl4iAe46yJnVtCH0oUrT7kzil
    CnALvsWUA/9vge18C3zBVTQefAnE7PXx6VE5QKn7FCKPwajObNLf9TeujK+07LGl
    VWS2wXsM3cswzU2xeFd3/l8f87Yqbidf1mONYrbm8qIdHSUtI8zNqoiCN4a1tQz0
    7nT2yMVRiN6sTD4lN527HrMqhq0/2przOisxW3Zw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=muaEz+rX x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=muaEz+rX x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfC4mju7DN7M481xviAA3WSyqonF73PVckkS+SV6AbkddMztjLhjapcJwUESyQvLud8S8EhifBC6hB1AlOOO0MgyTpvwucjlnj2B7ndt/yhfvGUNhdgM9
    T1Jb5qvaPzSbvqiMMEv1Uovl/usQX6w5/3M1mieDH5fRO26tHQcmWbI4yN5sxLkHZLN8Rz7VqS2YuUaibJyKaPl0RJB0Ol1YHPQhPqvMdjx2n0OfF5mIKQjI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=7rEblIYDAAAA:8 a=VwQbUJbxAAAA:8
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=9R2M5RTcieio-Ai7DlMA:9 a=QEXdDO2ut3YA:10
    a=_sbA2Q-Kp09kWB8D3iXc:22 a=r-x8xPlcpNX_XLVtWTHX:22 a=AjGcO6oz07-iQ99wixmX:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966291AbeEXMV5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966157AbeEXJlL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 03/45] dccp: fix tasklet usage
Date: Thu, 24 May 2018 11:38:11 +0200
Message-Id: <20180524093120.982327688@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a8d7aa17bbc970971ccdf71988ea19230ab368b1 ]

syzbot reported a crash in tasklet_action_common() caused by dccp.

dccp needs to make sure socket wont disappear before tasklet handler
has completed.

This patch takes a reference on the socket when arming the tasklet,
and moves the sock_put() from dccp_write_xmit_timer() to dccp_write_xmitlet()

kernel BUG at kernel/softirq.c:514!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 17 Comm: ksoftirqd/1 Not tainted 4.17.0-rc3+ #30
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tasklet_action_common.isra.19+0x6db/0x700 kernel/softirq.c:515
RSP: 0018:ffff8801d9b3faf8 EFLAGS: 00010246
dccp_close: ABORT with 65423 bytes unread
RAX: 1ffff1003b367f6b RBX: ffff8801daf1f3f0 RCX: 0000000000000000
RDX: ffff8801cf895498 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffff8801d9b3fc40 R08: ffffed0039f12a95 R09: ffffed0039f12a94
dccp_close: ABORT with 65423 bytes unread
R10: ffffed0039f12a94 R11: ffff8801cf8954a3 R12: 0000000000000000
R13: ffff8801d9b3fc18 R14: dffffc0000000000 R15: ffff8801cf895490
FS:  0000000000000000(0000) GS:ffff8801daf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc28000 CR3: 00000001a08a9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tasklet_action+0x1d/0x20 kernel/softirq.c:533
 __do_softirq+0x2e0/0xaf5 kernel/softirq.c:285
dccp_close: ABORT with 65423 bytes unread
 run_ksoftirqd+0x86/0x100 kernel/softirq.c:646
 smpboot_thread_fn+0x417/0x870 kernel/smpboot.c:164
 kthread+0x345/0x410 kernel/kthread.c:238
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:412
Code: 48 8b 85 e8 fe ff ff 48 8b 95 f0 fe ff ff e9 94 fb ff ff 48 89 95 f0 fe ff ff e8 81 53 6e 00 48 8b 95 f0 fe ff ff e9 62 fb ff ff <0f> 0b 48 89 cf 48 89 8d e8 fe ff ff e8 64 53 6e 00 48 8b 8d e8
RIP: tasklet_action_common.isra.19+0x6db/0x700 kernel/softirq.c:515 RSP: ffff8801d9b3faf8

Fixes: dc841e30eaea ("dccp: Extend CCID packet dequeueing interface")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Cc: dccp@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dccp/ccids/ccid2.c |   14 ++++++++++++--
 net/dccp/timer.c       |    2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

--- a/net/dccp/ccids/ccid2.c
+++ b/net/dccp/ccids/ccid2.c
@@ -126,6 +126,16 @@ static void ccid2_change_l_seq_window(st
 						  DCCPF_SEQ_WMAX));
 }
 
+static void dccp_tasklet_schedule(struct sock *sk)
+{
+	struct tasklet_struct *t = &dccp_sk(sk)->dccps_xmitlet;
+
+	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
+		sock_hold(sk);
+		__tasklet_schedule(t);
+	}
+}
+
 static void ccid2_hc_tx_rto_expire(unsigned long data)
 {
 	struct sock *sk = (struct sock *)data;
@@ -166,7 +176,7 @@ static void ccid2_hc_tx_rto_expire(unsig
 
 	/* if we were blocked before, we may now send cwnd=1 packet */
 	if (sender_was_blocked)
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	/* restart backed-off timer */
 	sk_reset_timer(sk, &hc->tx_rtotimer, jiffies + hc->tx_rto);
 out:
@@ -706,7 +716,7 @@ static void ccid2_hc_tx_packet_recv(stru
 done:
 	/* check if incoming Acks allow pending packets to be sent */
 	if (sender_was_blocked && !ccid2_cwnd_network_limited(hc))
-		tasklet_schedule(&dccp_sk(sk)->dccps_xmitlet);
+		dccp_tasklet_schedule(sk);
 	dccp_ackvec_parsed_cleanup(&hc->tx_av_chunks);
 }
 
--- a/net/dccp/timer.c
+++ b/net/dccp/timer.c
@@ -252,12 +252,12 @@ static void dccp_write_xmitlet(unsigned
 	else
 		dccp_write_xmit(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
 
 static void dccp_write_xmit_timer(unsigned long data)
 {
 	dccp_write_xmitlet(data);
-	sock_put((struct sock *)data);
 }
 
 void dccp_init_xmit_timers(struct sock *sk)
