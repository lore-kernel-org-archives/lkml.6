Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1817771-1527161024-2-17974763357344143489
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161023; b=huSCWybIE3+dag52llY1ZNFDS6fPwM/eriJ7IlEEkYYsCBqu2l
    BNpWAyurMat9BN+rNKv7KcOTKkbjQsK6J2rPstpCBqkdWjgOfQY0OctOWCbL7Rrh
    tTvcKYAcQXuM7OBr3s4RCiKmdRogyYqNTF306V2iD9ymqZptwBZSfGQKnWpXn21m
    snroHmDT9JijfGFGvUZRrVPiYzYkUNW32bsiRfPzdCU1MNPFIPB9psZhltaoEYG7
    3iyHQa91ijQV7qiyCcdqvXz3j8aF1mpXKQWd0oDt9IjyJY3YJRKD2tYOKPVF41/7
    EOpTDXsi+dNF69QI+IUbmDos/1tq+QAofuIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161023; bh=7JWJ5h0Tt0a3NZMxCHUJ1u4qW3gul1
    +L3iXvrTLYkb4=; b=alDCGrg0ABxfpsaKBkg1ctU/RJjxWs5/5vSP46tc/TYVae
    nd2XSI85bbtn0izb5gBbQv337SkleCL3Y1Vy2dZH3jy7wA/Z+qd1TKNO7oCgiVPq
    Em9+t6rtaJ4rKFa2ar577ecpL+8eOcxnH82UWx6mopvT8d2G3rkNigsbJlyLKDmy
    n2MlWAAqm7MkOm7eAAA/L+19m0Ktph02TxtZYBYhJHtGmnn6/1k0+yMEkHlIjX+C
    HnXL3mJK38b151M0TjgMEAuM66ppFWed7ptY7TqYKzEgVSotuhD40piwAR6qu+Ow
    CO5UPxQpIMbiiEiI4PpXTSDUyUo93O+nVmxDi+Kw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=leWAWcCW x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=leWAWcCW x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAjd9qkmQjoJjGi2OOhUa4igdfDo6O9SCgGh26K2cjizjJwBH4VhEqe8vnEUtup+TsMy9YuF1b5E7Fr5mQbv0rjulZyy/awuLh+jpgeir5++Z9xyo0bG
    VmY3IufViApUFrA/uPDsPNCyH0nBnkXjjm20PXm4khTe7Qxejq8p9+HnIwQh0ZE8G7m7tTmn6MSoYk+bVvznMirPssRQC5hMdG2bBYV1IN6eaIxiyHcDop5N
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=16fswNRuB07zdXDSXE4A:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967890AbeEXLXA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:23:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967806AbeEXJwI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hangbin Liu <liuhangbin@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jiri Kosina <jkosina@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 004/165] net: sched: red: avoid hashing NULL child
Date: Thu, 24 May 2018 11:36:50 +0200
Message-Id: <20180524093622.150403466@linuxfoundation.org>
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

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 44a63b137f7b6e4c7bd6c9cc21615941cb36509d ]

Hangbin reported an Oops triggered by the syzkaller qdisc rules:

 kasan: GPF could be caused by NULL-ptr deref or user memory access
 general protection fault: 0000 [#1] SMP KASAN PTI
 Modules linked in: sch_red
 CPU: 0 PID: 28699 Comm: syz-executor5 Not tainted 4.17.0-rc4.kcov #1
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:qdisc_hash_add+0x26/0xa0
 RSP: 0018:ffff8800589cf470 EFLAGS: 00010203
 RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff824ad971
 RDX: 0000000000000007 RSI: ffffc9000ce9f000 RDI: 000000000000003c
 RBP: 0000000000000001 R08: ffffed000b139ea2 R09: ffff8800589cf4f0
 R10: ffff8800589cf50f R11: ffffed000b139ea2 R12: ffff880054019fc0
 R13: ffff880054019fb4 R14: ffff88005c0af600 R15: ffff880054019fb0
 FS:  00007fa6edcb1700(0000) GS:ffff88005ce00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000020000740 CR3: 000000000fc16000 CR4: 00000000000006f0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  red_change+0x2d2/0xed0 [sch_red]
  qdisc_create+0x57e/0xef0
  tc_modify_qdisc+0x47f/0x14e0
  rtnetlink_rcv_msg+0x6a8/0x920
  netlink_rcv_skb+0x2a2/0x3c0
  netlink_unicast+0x511/0x740
  netlink_sendmsg+0x825/0xc30
  sock_sendmsg+0xc5/0x100
  ___sys_sendmsg+0x778/0x8e0
  __sys_sendmsg+0xf5/0x1b0
  do_syscall_64+0xbd/0x3b0
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 RIP: 0033:0x450869
 RSP: 002b:00007fa6edcb0c48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 00007fa6edcb16b4 RCX: 0000000000450869
 RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000013
 RBP: 000000000072bea0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
 R13: 0000000000008778 R14: 0000000000702838 R15: 00007fa6edcb1700
 Code: e9 0b fe ff ff 0f 1f 44 00 00 55 53 48 89 fb 89 f5 e8 3f 07 f3 fe 48 8d 7b 3c 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 04 84 d2 75 51
 RIP: qdisc_hash_add+0x26/0xa0 RSP: ffff8800589cf470

When a red qdisc is updated with a 0 limit, the child qdisc is left
unmodified, no additional scheduler is created in red_change(),
the 'child' local variable is rightfully NULL and must not add it
to the hash table.

This change addresses the above issue moving qdisc_hash_add() right
after the child qdisc creation. It additionally removes unneeded checks
for noop_qdisc.

Reported-by: Hangbin Liu <liuhangbin@gmail.com>
Fixes: 49b499718fa1 ("net: sched: make default fifo qdiscs appear in the dump")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_red.c |    5 +++--
 net/sched/sch_tbf.c |    5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -191,10 +191,11 @@ static int red_change(struct Qdisc *sch,
 		child = fifo_create_dflt(sch, &bfifo_qdisc_ops, ctl->limit);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
-	}
 
-	if (child != &noop_qdisc)
+		/* child is fifo, no need to check for noop_qdisc */
 		qdisc_hash_add(child, true);
+	}
+
 	sch_tree_lock(sch);
 	q->flags = ctl->flags;
 	q->limit = ctl->limit;
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -388,6 +388,9 @@ static int tbf_change(struct Qdisc *sch,
 			err = PTR_ERR(child);
 			goto done;
 		}
+
+		/* child is fifo, no need to check for noop_qdisc */
+		qdisc_hash_add(child, true);
 	}
 
 	sch_tree_lock(sch);
@@ -396,8 +399,6 @@ static int tbf_change(struct Qdisc *sch,
 					  q->qdisc->qstats.backlog);
 		qdisc_destroy(q->qdisc);
 		q->qdisc = child;
-		if (child != &noop_qdisc)
-			qdisc_hash_add(child, true);
 	}
 	q->limit = qopt->limit;
 	if (tb[TCA_TBF_PBURST])
