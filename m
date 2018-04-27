Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524838210-2-345633197876394120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838209; b=gl1aaJvbn9N+2ZUK8ioDbTpbb14f/6ODxh5pdjbh7dE1TJSD7S
    ZzzUiVxC6YttXC8CCQw0enqvOx3r7yPiwVcqdqzkCjPCNQwhIbE6pWm1fh72qZWr
    GU0BHTc5N+KNbrm8Acs/4kCC92oNLQoLMYDUNFxk/vpp9FUgrXhctPtJdiJdTCKD
    6xQWGzS2cafX61F8RI0QsD1lM7ilMELQN1f16I8SBP4o0j/kjEIlikLiicimuuSa
    QtMzdZ/V6vVHEUQnykuQQztXf6tM+OIIpMoLDwdHuafvzNO/i9Qm33oeimmLB7bV
    rVm2qYIFfHqJWScr98bPXen5KrmVasrKkxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838209; bh=FxIMmXKc/PXp/NizzlFjcZDnIXusHU
    5+d2BbDiMAo6I=; b=nLHCaxav5GoELi3L+/2KKh/yAl2FdYh+HILCFKueAFwCPc
    dnlrRz7vgql0iMmGs021IT4QzHKE4VYXf6EGrPjeIW0gPdVwaTdbk9diz5xBKtu2
    lTCd0savJ7tnlsnpUKgUxjiB06rElTjXl1hhhUbAlulMd7HgPk6pUyjBFzaKJhpa
    I4nXionUQ+OcvJLvMqCbMX5IPimS5W7145UdMUaQVDA4vfcHXaxVa2kQif+QUwtl
    htQbdtt+O75u6yfYSsf8P7b7OJtmKWQuzBkaWXNiGUw8noDLcHDhUs5mdW+FisR6
    ndo5ywrB3pFLbCoDlnbCnFLLaD0xPem9fqgeQ0hQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCZ24wlQfPvhn8xLAMT9oxl26m1hqbD6qbLJ4PyctPHqhm0Q4mN2lff2lQQBFFU3fVvSpz8XzoGuoV8l6Cj4QqeNaHQDpKi5VUg/i6LGIxatKU/utE1o
    nrGmtnE1wBOAG8bDByGkMuggw3t/sCtxYMFr95D3sTQV2QYQH2gJsG2vbtP77A/I/5nBPfv1yjTA1fWZusCDx7bmIc0ZvDkbAiiArbNGnVgWJSrKwsQ71eFh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=JrvlcW7RFgscdJ-1EWgA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934749AbeD0OJz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934732AbeD0OJx (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:09:53 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2695C21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 15/81] net: af_packet: fix race in PACKET_{R|T}X_RING
Date: Fri, 27 Apr 2018 15:58:17 +0200
Message-Id: <20180427135744.133912226@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>


[ Upstream commit 5171b37d959641bbc619781caf62e61f7b940871 ]

In order to remove the race caught by syzbot [1], we need
to lock the socket before using po->tp_version as this could
change under us otherwise.

This means lock_sock() and release_sock() must be done by
packet_set_ring() callers.

[1] :
BUG: KMSAN: uninit-value in packet_set_ring+0x1254/0x3870 net/packet/af_packet.c:4249
CPU: 0 PID: 20195 Comm: syzkaller707632 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 packet_set_ring+0x1254/0x3870 net/packet/af_packet.c:4249
 packet_setsockopt+0x12c6/0x5a90 net/packet/af_packet.c:3662
 SYSC_setsockopt+0x4b8/0x570 net/socket.c:1849
 SyS_setsockopt+0x76/0xa0 net/socket.c:1828
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x449099
RSP: 002b:00007f42b5307ce8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 000000000070003c RCX: 0000000000449099
RDX: 0000000000000005 RSI: 0000000000000107 RDI: 0000000000000003
RBP: 0000000000700038 R08: 000000000000001c R09: 0000000000000000
R10: 00000000200000c0 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000080eecf R14: 00007f42b53089c0 R15: 0000000000000001

Local variable description: ----req_u@packet_setsockopt
Variable was created at:
 packet_setsockopt+0x13f/0x5a90 net/packet/af_packet.c:3612
 SYSC_setsockopt+0x4b8/0x570 net/socket.c:1849

Fixes: f6fb8f100b80 ("af-packet: TPACKET_V3 flexible buffer implementation.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -3008,6 +3008,7 @@ static int packet_release(struct socket
 
 	packet_flush_mclist(sk);
 
+	lock_sock(sk);
 	if (po->rx_ring.pg_vec) {
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 0);
@@ -3017,6 +3018,7 @@ static int packet_release(struct socket
 		memset(&req_u, 0, sizeof(req_u));
 		packet_set_ring(sk, &req_u, 1, 1);
 	}
+	release_sock(sk);
 
 	f = fanout_release(sk);
 
@@ -3645,6 +3647,7 @@ packet_setsockopt(struct socket *sock, i
 		union tpacket_req_u req_u;
 		int len;
 
+		lock_sock(sk);
 		switch (po->tp_version) {
 		case TPACKET_V1:
 		case TPACKET_V2:
@@ -3655,12 +3658,17 @@ packet_setsockopt(struct socket *sock, i
 			len = sizeof(req_u.req3);
 			break;
 		}
-		if (optlen < len)
-			return -EINVAL;
-		if (copy_from_user(&req_u.req, optval, len))
-			return -EFAULT;
-		return packet_set_ring(sk, &req_u, 0,
-			optname == PACKET_TX_RING);
+		if (optlen < len) {
+			ret = -EINVAL;
+		} else {
+			if (copy_from_user(&req_u.req, optval, len))
+				ret = -EFAULT;
+			else
+				ret = packet_set_ring(sk, &req_u, 0,
+						    optname == PACKET_TX_RING);
+		}
+		release_sock(sk);
+		return ret;
 	}
 	case PACKET_COPY_THRESH:
 	{
@@ -4210,8 +4218,6 @@ static int packet_set_ring(struct sock *
 	/* Added to avoid minimal code churn */
 	struct tpacket_req *req = &req_u->req;
 
-	lock_sock(sk);
-
 	rb = tx_ring ? &po->tx_ring : &po->rx_ring;
 	rb_queue = tx_ring ? &sk->sk_write_queue : &sk->sk_receive_queue;
 
@@ -4349,7 +4355,6 @@ static int packet_set_ring(struct sock *
 	if (pg_vec)
 		free_pg_vec(pg_vec, order, req->tp_block_nr);
 out:
-	release_sock(sk);
 	return err;
 }
 
