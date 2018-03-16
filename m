Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3278546-1521214176-2-324616683789001418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214176; b=PJbG2gPoG4O4RlP7uAzzfmsZ72r2oSC7qfl9YNKox2b3sMM
    JqfvLAaC+YkO060mjqxHdm8422jAA9ELoSJvK5ISCfkS3Kgnnv5Sah407IwThWCA
    Xbn6ATHmf1CPJ69cbuPe9KvOXrakYmef9NXmT7PkTBf8MtQJbH1bHIkz9C3ylQ91
    oL4uV9O3Y0qgVNqIgP8s2mfsWrpEBo7O2gVUYIzu7dj2c+i5nDz4kCYbxWgr7hXn
    43L1y2IPkAMGqp4SjP6eqZcWqXkbTBISbLw09HkiL1v7w56wYGjdQhXCVnMPKK/L
    ESmQR11HdPpMqvG/paz5nJUjatpaF0EUnR3BXLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214176; bh=PhrO64UuR/3MvC+br1IEAWlH9j
    Gh6Z5PwzjKpvdu20A=; b=pX/RZeUgSob613Ti+EWQ6NytFIIQhQiXnJs94nXd+i
    DwEkv8PEvHS0YUpqS04llBFr+i8QHXeIHvuTZuqNoRw7XNA+G1HR/pXIfKV0x9T5
    Fe9L533DZvEdW07S3fpfdN7y99pyJ1f0lsyAKBJfHbna9F+JK7x3BooYt5ZUCMEk
    N4R8aN4TQ4dUJGWBJw+V81eMkAo4edk9EmOdnr0VNZVQ0Adug8bg7cNbeqB2oY2Y
    NPC0xodeYR4ygUEHXMkcfaEU/o7XDM76GCSZY20GCEvJbgZ+y1zT+p6CCmp/S1Kl
    tlthcsxVtdAP6423HhKi86ro127r2YRmzwj4DbDPr/mQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933044AbeCPP3b (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:29:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36154 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933081AbeCPP33 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:29:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.4 42/63] netfilter: x_tables: pass xt_counters struct instead of packet counter
Date: Fri, 16 Mar 2018 16:23:14 +0100
Message-Id: <20180316152304.638131270@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 4d31eef5176df06f218201bc9c0ce40babb41660 upstream.

On SMP we overload the packet counter (unsigned long) to contain
percpu offset.  Hide this from callers and pass xt_counters address
instead.

Preparation patch to allocate the percpu counters in page-sized batch
chunks.

Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/netfilter/x_tables.h |    6 +-----
 net/ipv4/netfilter/arp_tables.c    |    4 ++--
 net/ipv4/netfilter/ip_tables.c     |    4 ++--
 net/ipv6/netfilter/ip6_tables.c    |    5 ++---
 net/netfilter/x_tables.c           |    9 +++++++++
 5 files changed, 16 insertions(+), 12 deletions(-)

--- a/include/linux/netfilter/x_tables.h
+++ b/include/linux/netfilter/x_tables.h
@@ -395,11 +395,7 @@ static inline unsigned long xt_percpu_co
 
 	return 0;
 }
-static inline void xt_percpu_counter_free(u64 pcnt)
-{
-	if (nr_cpu_ids > 1)
-		free_percpu((void __percpu *) (unsigned long) pcnt);
-}
+void xt_percpu_counter_free(struct xt_counters *cnt);
 
 static inline struct xt_counters *
 xt_get_this_cpu_counter(struct xt_counters *cnt)
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -540,7 +540,7 @@ find_check_entry(struct arpt_entry *e, c
 err:
 	module_put(t->u.kernel.target->me);
 out:
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 
 	return ret;
 }
@@ -628,7 +628,7 @@ static inline void cleanup_entry(struct
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 	module_put(par.target->me);
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 }
 
 /* Checks and translates the user-supplied table segment (held in
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -701,7 +701,7 @@ find_check_entry(struct ipt_entry *e, st
 		cleanup_match(ematch, net);
 	}
 
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 
 	return ret;
 }
@@ -797,7 +797,7 @@ cleanup_entry(struct ipt_entry *e, struc
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 	module_put(par.target->me);
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 }
 
 /* Checks and translates the user-supplied table segment (held in
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -713,7 +713,7 @@ find_check_entry(struct ip6t_entry *e, s
 		cleanup_match(ematch, net);
 	}
 
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 
 	return ret;
 }
@@ -808,8 +808,7 @@ static void cleanup_entry(struct ip6t_en
 	if (par.target->destroy != NULL)
 		par.target->destroy(&par);
 	module_put(par.target->me);
-
-	xt_percpu_counter_free(e->counters.pcnt);
+	xt_percpu_counter_free(&e->counters);
 }
 
 /* Checks and translates the user-supplied table segment (held in
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1592,6 +1592,15 @@ void xt_proto_fini(struct net *net, u_in
 }
 EXPORT_SYMBOL_GPL(xt_proto_fini);
 
+void xt_percpu_counter_free(struct xt_counters *counters)
+{
+	unsigned long pcnt = counters->pcnt;
+
+	if (nr_cpu_ids > 1)
+		free_percpu((void __percpu *)pcnt);
+}
+EXPORT_SYMBOL_GPL(xt_percpu_counter_free);
+
 static int __net_init xt_net_init(struct net *net)
 {
 	int i;
