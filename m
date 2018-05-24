Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527154883-2-13757418797983152947
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
    1527154883; b=I6TmNDv0Y+iY5J7BmqMGNSR8N3jTn0PaEvtnu4JcOAVLtq/+AX
    NjOILbLKjdrRbPKPNkqIZ6h/kGqcWMKQlSxkutAnfY0z9KozJEzIN3sSHEXrPN2n
    I/WcuPtbhhh1PvU1ffnbg/sAhiLnXUiVvnA02Ga0fE3lkSOT9qGVxAMWP6PnwQ0S
    pHQZQ7L1o2YrRqN/y6yYXx7WJDbGzYO8DNiW9FZ8FUvQqvWWxOjejUAHIH6NCnoA
    4wbKz4I6lSvJ3YAvBgPQZfsozMGfrIBpQF9+cv6NN8JGb+Zc87j8Ir4TvTIMBCOn
    nCqKerArcCbBIpMXn357quM2mF8OWICUwZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154883; bh=vD846U124XfSRcVrTMwyF3qCPwmGWs
    rNXNP+Hweh2ZY=; b=SVYmccSjrVbz46+7pygvmFG10OJ8XnKn2tuDL0vLWHCY7v
    mS4S5sYTz61K2Hm+/NAfJwMQChCrtPbDjTPwkE1YFPsiCkM8/Xz4kwjoy5UK7amz
    pWH87vb2FOwV4qKQRXIfa/pvtBJ3lyYfWMe+ZCJqSwZTgbS19pTQu3tx5KmEJt+L
    PFflTk1EW3ekiwj4sqYdMEpoqdrIYOwRkjNWgiEsHNtAZGNk392CuccfWZE6tpZi
    YP0JnMNcJGQKeocThHI7uq3OEWq16SpWJk06zyl9jd4uvRVfqQQy8h7DdOgHb7ds
    I8B2whwtlbUhj8T0GC8yWBNhAjGlNWJ8vUAaMvtA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jKZ40vxh x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jKZ40vxh x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfCwBhHl6neVuPP2ijALK5CABCTpXYk+CAL003G+jO4LHtB6m/U5eBZWAsBsrC5JakeszZV2jKgoUMlflgnbxkJBrPTUrUYdsFaGAQCJoMIPtF8tt6OKQ
    pgWbLsvDOA9N1ytViD0slmFBOtLgs7sX0jXKZKHy+a+eePfCvViLRM50FxvrnBEWnu05QLgGvtioEru3SzsNM3KOKmc1LstcF1ERw9hahyjwReOP2rTqIJBn
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=4RBUngkUAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=emohYkzIdC9npJpdZZcA:9 a=iaXcMtGj-1b0JJzK:21 a=Alg6EIVyMvnv-dkJ:21
    a=QEXdDO2ut3YA:10 a=_sbA2Q-Kp09kWB8D3iXc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966167AbeEXJlV (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966153AbeEXJlR (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 05/45] llc: better deal with too small mtu
Date: Thu, 24 May 2018 11:38:13 +0200
Message-Id: <20180524093121.232416874@linuxfoundation.org>
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

[ Upstream commit 2c5d5b13c6eb79f5677e206b8aad59b3a2097f60 ]

syzbot loves to set very small mtu on devices, since it brings joy.
We must make llc_ui_sendmsg() fool proof.

usercopy: Kernel memory overwrite attempt detected to wrapped address (offset 0, size 18446612139802320068)!

kernel BUG at mm/usercopy.c:100!
invalid opcode: 0000 [#1] SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 0 PID: 17464 Comm: syz-executor1 Not tainted 4.17.0-rc3+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:usercopy_abort+0xbb/0xbd mm/usercopy.c:88
RSP: 0018:ffff8801868bf800 EFLAGS: 00010282
RAX: 000000000000006c RBX: ffffffff87d2fb00 RCX: 0000000000000000
RDX: 000000000000006c RSI: ffffffff81610731 RDI: ffffed0030d17ef6
RBP: ffff8801868bf858 R08: ffff88018daa4200 R09: ffffed003b5c4fb0
R10: ffffed003b5c4fb0 R11: ffff8801dae27d87 R12: ffffffff87d2f8e0
R13: ffffffff87d2f7a0 R14: ffffffff87d2f7a0 R15: ffffffff87d2f7a0
FS:  00007f56a14ac700(0000) GS:ffff8801dae00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2bc21000 CR3: 00000001abeb1000 CR4: 00000000001426f0
DR0: 0000000020000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000030602
Call Trace:
 check_bogus_address mm/usercopy.c:153 [inline]
 __check_object_size+0x5d9/0x5d9 mm/usercopy.c:256
 check_object_size include/linux/thread_info.h:108 [inline]
 check_copy_size include/linux/thread_info.h:139 [inline]
 copy_from_iter_full include/linux/uio.h:121 [inline]
 memcpy_from_msg include/linux/skbuff.h:3305 [inline]
 llc_ui_sendmsg+0x4b1/0x1530 net/llc/af_llc.c:941
 sock_sendmsg_nosec net/socket.c:629 [inline]
 sock_sendmsg+0xd5/0x120 net/socket.c:639
 __sys_sendto+0x3d7/0x670 net/socket.c:1789
 __do_sys_sendto net/socket.c:1801 [inline]
 __se_sys_sendto net/socket.c:1797 [inline]
 __x64_sys_sendto+0xe1/0x1a0 net/socket.c:1797
 do_syscall_64+0x1b1/0x800 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x455979
RSP: 002b:00007f56a14abc68 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f56a14ac6d4 RCX: 0000000000455979
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000018
RBP: 000000000072bea0 R08: 00000000200012c0 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000548 R14: 00000000006fbf60 R15: 0000000000000000
Code: 55 c0 e8 c0 55 bb ff ff 75 c8 48 8b 55 c0 4d 89 f9 ff 75 d0 4d 89 e8 48 89 d9 4c 89 e6 41 56 48 c7 c7 80 fa d2 87 e8 a0 0b a3 ff <0f> 0b e8 95 55 bb ff e8 c0 a8 f7 ff 8b 95 14 ff ff ff 4d 89 e8
RIP: usercopy_abort+0xbb/0xbd mm/usercopy.c:88 RSP: ffff8801868bf800

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -928,6 +928,9 @@ static int llc_ui_sendmsg(struct kiocb *
 	if (size > llc->dev->mtu)
 		size = llc->dev->mtu;
 	copied = size - hdrlen;
+	rc = -EINVAL;
+	if (copied < 0)
+		goto release;
 	release_sock(sk);
 	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
 	lock_sock(sk);
