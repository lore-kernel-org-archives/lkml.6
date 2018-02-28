Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519837130-2-8713327815720091535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519837128; b=L6L/RXV8EEQGxmPBrI0YEBup1JbGopRhUJIaQNtKt8PlCNA
    a28YVYmITGUE0t1n1TLmhjdw0ygvccahmCygBmuvgqoyKw5OTkIZtSeL4jU7XfiP
    5vzYYwp0/VtMtzi7HXKkc75NtGzGV7tsbNbjTOR/JJJNY848P3Swj1iRn2s6N6MA
    rp2EG0NNFpgzXcJUiZhxsZGsvBXgTKRvwn7HGFlwNPlP2LZ4R8QGlZh1S24OsU3s
    XhVikFs6qkQoG9h2dea6wqe6HZ8BVAmjCpt5asHCPgoiy5dn0nvyNHP0+Z/BchNo
    0TUtQRcRUNlj3Mqd1WgINJOiWJtuoeJr60Y3ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837128; bh=njg/BGNs9HjHhNcXDHA
    PMkC3uz+vZvmQZC73Sn0rCC8=; b=k/NVZK7Fux52gRk3x6NPRldIkMNhHPDma2o
    Jg+TX2weKiM7f2CJ/ui2aOLVqD7eVvgDzZmqwYMrjG8Rp3Wzz5ltroptQOz5jzAH
    PBYXUHelcYavMmlu/pYoo1dnJM4fSX1pOf54+1ENIRQMpd5GLG+jU/Dy4sJyhgou
    bsFprv8HZ/tCGtR67qYhJYGlJ8eqAcqC42r4RWfOXM890gfL6aLC27RMeY+GdHbM
    962k0pPilwWXuRr3vk5iSByRXpHiULrPlTNOxb53Fu/9AxAmC7VotrrENh5o5qSF
    8jt1Bp3HVL/eiwrpBRK+MXoqMt5MHrHSSOucujKPFeJZuA1+WDQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933882AbeB1Pwm (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:52:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932426AbeB1Pwj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:52:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Glauber Costa" <glommer@parallels.com>,
        "Tonghao Zhang" <zhangtonghao@didichuxing.com>,
        "Tonghao Zhang" <xiangxia.m.yue@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.9283306@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 143/254] sctp: Replace use of sockets_allocated with
 specified macro.
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

commit 8cb38a602478e9f806571f6920b0a3298aabf042 upstream.

The patch(180d8cd942ce) replaces all uses of struct sock fields'
memory_pressure, memory_allocated, sockets_allocated, and sysctl_mem
to accessor macros. But the sockets_allocated field of sctp sock is
not replaced at all. Then replace it now for unifying the code.

Fixes: 180d8cd942ce ("foundations of per-cgroup memory pressure controlling.")
Cc: Glauber Costa <glommer@parallels.com>
Signed-off-by: Tonghao Zhang <zhangtonghao@didichuxing.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/sctp/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4021,7 +4021,7 @@ static int sctp_init_sock(struct sock *s
 	SCTP_DBG_OBJCNT_INC(sock);
 
 	local_bh_disable();
-	percpu_counter_inc(&sctp_sockets_allocated);
+	sk_sockets_allocated_inc(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, 1);
 
 	/* Nothing can fail after this block, otherwise
@@ -4065,7 +4065,7 @@ static void sctp_destroy_sock(struct soc
 	}
 	sctp_endpoint_free(sp->ep);
 	local_bh_disable();
-	percpu_counter_dec(&sctp_sockets_allocated);
+	sk_sockets_allocated_dec(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
 	local_bh_enable();
 }
