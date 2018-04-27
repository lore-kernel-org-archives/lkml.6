Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333748-1524839495-2-10396475737362463276
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
    1524839494; b=jhVTpOgDkTe7XZuN5AAaGXLzpbjkTCVumxPztfeENBrUzJRNrQ
    kB1Lcx4/64vKPXMaAvZVKFmAWtWqyFCNH2GngYimr4Aslt6dp5/t8Fn7Kpfxg7SE
    fz3vvhx3SBcqfPKN8ySTctapA46reNyeMPL8HSL8UFjJphG+YbZhgOwJG2IAU0CQ
    NnlkU8A5nZWl/9tXrUCr+BwyZ5BJYpJQuzv9Y7NwUQ5zFa4NZWNLThuy3fJf0zyW
    uawCF/3Ao6LSRAmAbyuLY1xH1HK4zZYfjJhHt2If4EbkdIbhV5sMaQME4DoKWZGG
    KIb6Yyr3jquqaf1vStgb8CAOkXODWCRRziTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839494; bh=d3TXD+/AZeZjfXivhHpKg8uiF5rc6S
    K5Pw70G8nrjtw=; b=fmQjEfyNupLUBeD+VGTstGN8m21mIFx8HFZUXUMcUZmh2/
    ifvKTgZf5OOTmbgO49AqAWidUoJE2cqf7bVfVeHjdWqXHXFuP44gGQ/gyiisBHjt
    5cHEOWvGB6zO2K1HJgCszen9Fj7CcD9g66LFA/YNrrJJ/HALsr0Is+gahcnNpb5F
    bqsZ0xAvRLi1pUH905yaChZe8GA89NIOVcEXFU2Oz2fLNpp+lgRTkfRaUP9xTYNi
    04zoxJUQ5vMHUIgDENlTns1rMutbWvIPDptbfe0vstgECEHq957UO1Qp0t/KMi5S
    QKy5zQEnM2D/rMm12e6GsIFVVLYmymdASt654PIQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfJTTOYKo0sI3gj0t9M+TlWyYKRHgErFYOQmiEPzjVuJkGY6MM8ESN0rnZtrmmHcqE04oCj42tgM+gAGOz0TYft5wr7xDRAIKBDBepcq6cplxB1WhvzwF
    01cWdkB/R0r1Kg9OGI5fk1EZAYlPmtIiZR77+q/vd1i7P1KJgi8SncXhCFr7RyIGckFvCHeiGeCtKHDPeF4Uxlcs9Rliw2+OvxAriyD2fDo7q1Ozy3Rkpfz6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=BgG5UwPwBxsVCEsEynYA:9 a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934869AbeD0OKk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OKf (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C82C21864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 29/81] tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
Date: Fri, 27 Apr 2018 15:58:31 +0200
Message-Id: <20180427135744.787739982@linuxfoundation.org>
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


[ Upstream commit 7212303268918b9a203aebeacfdbd83b5e87b20d ]

syzbot/KMSAN reported an uninit-value in tcp_parse_options() [1]

I believe this was caused by a TCP_MD5SIG being set on live
flow.

This is highly unexpected, since TCP option space is limited.

For instance, presence of TCP MD5 option automatically disables
TCP TimeStamp option at SYN/SYNACK time, which we can not do
once flow has been established.

Really, adding/deleting an MD5 key only makes sense on sockets
in CLOSE or LISTEN state.

[1]
BUG: KMSAN: uninit-value in tcp_parse_options+0xd74/0x1a30 net/ipv4/tcp_input.c:3720
CPU: 1 PID: 6177 Comm: syzkaller192004 Not tainted 4.16.0+ #83
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 __msan_warning_32+0x6c/0xb0 mm/kmsan/kmsan_instr.c:676
 tcp_parse_options+0xd74/0x1a30 net/ipv4/tcp_input.c:3720
 tcp_fast_parse_options net/ipv4/tcp_input.c:3858 [inline]
 tcp_validate_incoming+0x4f1/0x2790 net/ipv4/tcp_input.c:5184
 tcp_rcv_established+0xf60/0x2bb0 net/ipv4/tcp_input.c:5453
 tcp_v4_do_rcv+0x6cd/0xd90 net/ipv4/tcp_ipv4.c:1469
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __release_sock+0x2d6/0x680 net/core/sock.c:2271
 release_sock+0x97/0x2a0 net/core/sock.c:2786
 tcp_sendmsg+0xd6/0x100 net/ipv4/tcp.c:1464
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
 SyS_sendto+0x8a/0xb0 net/socket.c:1715
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x448fe9
RSP: 002b:00007fd472c64d38 EFLAGS: 00000216 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00000000006e5a30 RCX: 0000000000448fe9
RDX: 000000000000029f RSI: 0000000020a88f88 RDI: 0000000000000004
RBP: 00000000006e5a34 R08: 0000000020e68000 R09: 0000000000000010
R10: 00000000200007fd R11: 0000000000000216 R12: 0000000000000000
R13: 00007fff074899ef R14: 00007fd472c659c0 R15: 0000000000000009

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:278 [inline]
 kmsan_internal_poison_shadow+0xb8/0x1b0 mm/kmsan/kmsan.c:188
 kmsan_kmalloc+0x94/0x100 mm/kmsan/kmsan.c:314
 kmsan_slab_alloc+0x11/0x20 mm/kmsan/kmsan.c:321
 slab_post_alloc_hook mm/slab.h:445 [inline]
 slab_alloc_node mm/slub.c:2737 [inline]
 __kmalloc_node_track_caller+0xaed/0x11c0 mm/slub.c:4369
 __kmalloc_reserve net/core/skbuff.c:138 [inline]
 __alloc_skb+0x2cf/0x9f0 net/core/skbuff.c:206
 alloc_skb include/linux/skbuff.h:984 [inline]
 tcp_send_ack+0x18c/0x910 net/ipv4/tcp_output.c:3624
 __tcp_ack_snd_check net/ipv4/tcp_input.c:5040 [inline]
 tcp_ack_snd_check net/ipv4/tcp_input.c:5053 [inline]
 tcp_rcv_established+0x2103/0x2bb0 net/ipv4/tcp_input.c:5469
 tcp_v4_do_rcv+0x6cd/0xd90 net/ipv4/tcp_ipv4.c:1469
 sk_backlog_rcv include/net/sock.h:908 [inline]
 __release_sock+0x2d6/0x680 net/core/sock.c:2271
 release_sock+0x97/0x2a0 net/core/sock.c:2786
 tcp_sendmsg+0xd6/0x100 net/ipv4/tcp.c:1464
 inet_sendmsg+0x48d/0x740 net/ipv4/af_inet.c:764
 sock_sendmsg_nosec net/socket.c:630 [inline]
 sock_sendmsg net/socket.c:640 [inline]
 SYSC_sendto+0x6c3/0x7e0 net/socket.c:1747
 SyS_sendto+0x8a/0xb0 net/socket.c:1715
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: cfb6eeb4c860 ("[TCP]: MD5 Signature Option (RFC2385) support.")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2830,8 +2830,10 @@ static int do_tcp_setsockopt(struct sock
 #ifdef CONFIG_TCP_MD5SIG
 	case TCP_MD5SIG:
 	case TCP_MD5SIG_EXT:
-		/* Read the IP->Key mappings from userspace */
-		err = tp->af_specific->md5_parse(sk, optname, optval, optlen);
+		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+			err = tp->af_specific->md5_parse(sk, optname, optval, optlen);
+		else
+			err = -EINVAL;
 		break;
 #endif
 	case TCP_USER_TIMEOUT:
