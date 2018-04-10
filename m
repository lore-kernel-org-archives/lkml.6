Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399080-2-11574149483870283625
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
    1523399078; b=k1UEtawzlAUxqVv4ONS06amMjoFYY20RL4pIM8spFZ/GO+iJQl
    8Q0pEFqhWZFeC7ai5UoeaClQOMkGBdTKyLcUx2OMhLUjxG1OESS798i8ybbU2u27
    2Tq9vDbTbkytTasgnQeX40SyZ3HTay9wS6xrG6+nOgKwOps4BXETK7DJgHk02ych
    oM5wgGniO8c7kJdGxadsJAcUkU5UIvIKw50Zz5aVrB7MoCpTeyZ9+w8BCwsJq2fB
    FfaOdCUjVSTeul5IDGHQwXUvu5NQzY1dTrKlAON6lBgkDBwivdEYFiawY1IKO5II
    5TU0Z8UMeWWPzYdTMMBeaT6RlSzBOQoSi1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399078; bh=ZQ/LS1miJjkhd8Zo0sFXIasbh33BKn
    GUl5pmWv5mMHc=; b=NW1vOrN6P6+t444/IY+r/ehetUxATS9ks0u3Nu9gbVH/e0
    8otAI8PHSwPr7/AWPQMDfxMDOIMBQ+iLIJd56ma+fEyM373hbfpV3MdOwX49j/B4
    3eKEuXsyD4ny+UEoOCm4TOZDf42++NpYBYrkAeuzvVVOnbAW5udaLsQnFsDzxIn/
    Q7TBAD3J0a8t5Fo+W4nt53Wtjf6cvWj8NXuCTCjxDlM8ZoGBAizb76juvojUAhnK
    +hW2ZhYsebi6Ew+mSgO+88hqn1WV3iXMiGay1y8ow1W7LVCPvZSpNIOGKlY4v8Pz
    bY3zIqmwcSAFCu20mh11gCrxNSmFqlsj89vxTNXg==
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
X-CM-Envelope: MS4wfJSNPl1YXDUh7v2A90Z0hmsmHL+G0XVUb9y3AacfEbL7qZZNxn4IVqgmZj8qIHwVUjTQ9qBO4SUw4y13zUQmAGJBiv3c3fKPNpw+jQugh1zauuARUDT8
    36klEtIfFJzGz/Xpsc9Vn6mcLWxDjd4jU4i3BGBsWtJl8eB5G/QHiqeJKiUWdNrMV4KZRYHu5EiDw1yNr1Wqf2wcc7Pau7t0byF8rAgdvSwM2yow36uNV5YG
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=vmLDa1wCAAAA:8 a=4RBUngkUAAAA:8
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=raf6b--22dHueX6QDn8A:9 a=QEXdDO2ut3YA:10
    a=h8Bt5HTj68qkN2fS7gvA:22 a=_sbA2Q-Kp09kWB8D3iXc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeDJWYf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:24:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeDJWYe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:24:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 07/18] sctp: do not leak kernel memory to user space
Date: Wed, 11 Apr 2018 00:23:42 +0200
Message-Id: <20180410212758.961732699@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
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


[ Upstream commit 6780db244d6b1537d139dea0ec8aad10cf9e4adb ]

syzbot produced a nice report [1]

Issue here is that a recvmmsg() managed to leak 8 bytes of kernel memory
to user space, because sin_zero (padding field) was not properly cleared.

[1]
BUG: KMSAN: uninit-value in copy_to_user include/linux/uaccess.h:184 [inline]
BUG: KMSAN: uninit-value in move_addr_to_user+0x32e/0x530 net/socket.c:227
CPU: 1 PID: 3586 Comm: syzkaller481044 Not tainted 4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 kmsan_report+0x142/0x240 mm/kmsan/kmsan.c:1067
 kmsan_internal_check_memory+0x164/0x1d0 mm/kmsan/kmsan.c:1176
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 move_addr_to_user+0x32e/0x530 net/socket.c:227
 ___sys_recvmsg+0x4e2/0x810 net/socket.c:2211
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313
 SYSC_recvmmsg+0x29b/0x3e0 net/socket.c:2394
 SyS_recvmmsg+0x76/0xa0 net/socket.c:2378
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2
RIP: 0033:0x4401c9
RSP: 002b:00007ffc56f73098 EFLAGS: 00000217 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401c9
RDX: 0000000000000001 RSI: 0000000020003ac0 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000020003bc0 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000217 R12: 0000000000401af0
R13: 0000000000401b80 R14: 0000000000000000 R15: 0000000000000000

Local variable description: ----addr@___sys_recvmsg
Variable was created at:
 ___sys_recvmsg+0xd5/0x810 net/socket.c:2172
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313

Bytes 8-15 of 16 are uninitialized

==================================================================
Kernel panic - not syncing: panic_on_warn set ...

CPU: 1 PID: 3586 Comm: syzkaller481044 Tainted: G    B            4.16.0+ #82
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x185/0x1d0 lib/dump_stack.c:53
 panic+0x39d/0x940 kernel/panic.c:183
 kmsan_report+0x238/0x240 mm/kmsan/kmsan.c:1083
 kmsan_internal_check_memory+0x164/0x1d0 mm/kmsan/kmsan.c:1176
 kmsan_copy_to_user+0x69/0x160 mm/kmsan/kmsan.c:1199
 copy_to_user include/linux/uaccess.h:184 [inline]
 move_addr_to_user+0x32e/0x530 net/socket.c:227
 ___sys_recvmsg+0x4e2/0x810 net/socket.c:2211
 __sys_recvmmsg+0x54e/0xdb0 net/socket.c:2313
 SYSC_recvmmsg+0x29b/0x3e0 net/socket.c:2394
 SyS_recvmmsg+0x76/0xa0 net/socket.c:2378
 do_syscall_64+0x309/0x430 arch/x86/entry/common.c:287
 entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc:	Vlad Yasevich <vyasevich@gmail.com>
Cc:	Neil Horman <nhorman@tuxdriver.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -728,8 +728,10 @@ static int sctp_v6_addr_to_user(struct s
 			sctp_v6_map_v4(addr);
 	}
 
-	if (addr->sa.sa_family == AF_INET)
+	if (addr->sa.sa_family == AF_INET) {
+		memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
 		return sizeof(struct sockaddr_in);
+	}
 	return sizeof(struct sockaddr_in6);
 }
 
