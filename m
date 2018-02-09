Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1420212-1518184347-2-11134200210594234708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518184346; b=grNooIEur1rMyBTxXTLqezW4YCC1Tt8aJB550PWxP5xe6m1
    ocDnaMuuNpILz7y7ydWsGzuGvrfnkBBs+W3vTgV+O9BIvZAGwIXZEF/JyENruwhn
    Y+SGrtLLxpi3aCu3CpPmbAiKm6AqKPtcRXQhOyW9Sn0tSqMdYX23R8fVhZUKhJnu
    4xoXEfzd2/0ioOlmfVTEqUFMUV+AoEebeuTM0E8JEYndDLK6ljzGKq7WslHXNCtR
    R0IBJE77AhHLYaWjO37J705GjKWvWrQSDvUksXeQ0nPluIOvGRoO0DD38fKVitVN
    L0sUffOdhjp151SD0qJL4a2aQ8uEM5iKydqCVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518184346; bh=L21fMNiuIjyoIGxqd0IYrR9gnP
    VPlFTgV1AqkzxKw9o=; b=hyrgFrwFGtiiffl4yHm1Tf9UTABFFdLHJ7iu3j/mCb
    qGBeM7U3t867A/bi/f+q5KsIZv5Ct2Cwb+a+EKNB8qVBIpeP2Yd+fsN9ALivKlHV
    uARVp8A2VC2t9EInjWNCGa3E+Ysqo2b1cKjphTn9pCLOXTb/7hvWUiM4yetBycPa
    6TnzG297trRreaMH8J432+oa1jDxsj+cqNnsTvZQeSoCZSKN1zqjN5F93C3IAhFY
    Csd/Ms2dQcFbpxvlwQtjb90gkp/rwKCXzhecGZk/Fo1QxRUuKPqe8Up5Lvc2+N14
    8EDjHvA7GjbUjhHkko/AI1rZVjDG9zHHQAx3EfRVnraw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753432AbeBINqN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:46:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52572 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753360AbeBINqL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:46:11 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4.15 10/23] Revert "defer call to mem_cgroup_sk_alloc()"
Date: Fri,  9 Feb 2018 14:40:08 +0100
Message-Id: <20180209133938.897550194@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133938.366024920@linuxfoundation.org>
References: <20180209133938.366024920@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roman Gushchin <guro@fb.com>


[ Upstream commit edbe69ef2c90fc86998a74b08319a01c508bd497 ]

This patch effectively reverts commit 9f1c2674b328 ("net: memcontrol:
defer call to mem_cgroup_sk_alloc()").

Moving mem_cgroup_sk_alloc() to the inet_csk_accept() completely breaks
memcg socket memory accounting, as packets received before memcg
pointer initialization are not accounted and are causing refcounting
underflow on socket release.

Actually the free-after-use problem was fixed by
commit c0576e397508 ("net: call cgroup_sk_alloc() earlier in
sk_clone_lock()") for the cgroup pointer.

So, let's revert it and call mem_cgroup_sk_alloc() just before
cgroup_sk_alloc(). This is safe, as we hold a reference to the socket
we're cloning, and it holds a reference to the memcg.

Also, let's drop BUG_ON(mem_cgroup_is_root()) check from
mem_cgroup_sk_alloc(). I see no reasons why bumping the root
memcg counter is a good reason to panic, and there are no realistic
ways to hit it.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memcontrol.c                 |   14 ++++++++++++++
 net/core/sock.c                 |    5 +----
 net/ipv4/inet_connection_sock.c |    1 -
 3 files changed, 15 insertions(+), 5 deletions(-)

--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5828,6 +5828,20 @@ void mem_cgroup_sk_alloc(struct sock *sk
 	if (!mem_cgroup_sockets_enabled)
 		return;
 
+	/*
+	 * Socket cloning can throw us here with sk_memcg already
+	 * filled. It won't however, necessarily happen from
+	 * process context. So the test for root memcg given
+	 * the current task's memcg won't help us in this case.
+	 *
+	 * Respecting the original socket's memcg is a better
+	 * decision in this case.
+	 */
+	if (sk->sk_memcg) {
+		css_get(&sk->sk_memcg->css);
+		return;
+	}
+
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(current);
 	if (memcg == root_mem_cgroup)
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1675,16 +1675,13 @@ struct sock *sk_clone_lock(const struct
 		newsk->sk_dst_pending_confirm = 0;
 		newsk->sk_wmem_queued	= 0;
 		newsk->sk_forward_alloc = 0;
-
-		/* sk->sk_memcg will be populated at accept() time */
-		newsk->sk_memcg = NULL;
-
 		atomic_set(&newsk->sk_drops, 0);
 		newsk->sk_send_head	= NULL;
 		newsk->sk_userlocks	= sk->sk_userlocks & ~SOCK_BINDPORT_LOCK;
 		atomic_set(&newsk->sk_zckey, 0);
 
 		sock_reset_flag(newsk, SOCK_DONE);
+		mem_cgroup_sk_alloc(newsk);
 		cgroup_sk_alloc(&newsk->sk_cgrp_data);
 
 		rcu_read_lock();
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -475,7 +475,6 @@ struct sock *inet_csk_accept(struct sock
 		}
 		spin_unlock_bh(&queue->fastopenq.lock);
 	}
-	mem_cgroup_sk_alloc(newsk);
 out:
 	release_sock(sk);
 	if (req)
