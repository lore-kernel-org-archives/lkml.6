Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD3BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F13CD21916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539811;
	bh=UsidTJ97iBWOL2Frxx4t0fNr0Fvyf2F4ljbNf14n3II=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DMxP21HhnKAtiOxDQnFLRfOwU3W8rHPhE8mD1jh+WSXbtVcpSB0tXxfyXkNpENIV4
	 vKl56j3kGLFzk8QJdnnENxxOY98TGSjSHmH5BCD0CEDQ3vEOPTsXg6j+nEzCMZjlC1
	 kpMhPb4WnXIfix9SqbEzQekiKou3NAjl+LHIqKt0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbfBGLn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727423AbfBGLn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC5A921907;
        Thu,  7 Feb 2019 11:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539805;
        bh=UsidTJ97iBWOL2Frxx4t0fNr0Fvyf2F4ljbNf14n3II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHUVi9eXrtOoE9nO5ig32DzE37/DSJZZSeeP4F0libN0FnBwsvpMyLV7+Izaj49jj
         iyVBEx+B+2eghVfMrOtcNQk/++XrpaW0ZILQZ0yWdkpuA1nfwC11uqX3CxSFnA5AdM
         acrzQrKDDpqsSQYYC8Odbf+zNiCPetd18WOTSlcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 14/34] inet: frags: remove inet_frag_maybe_warn_overflow()
Date:   Thu,  7 Feb 2019 12:41:56 +0100
Message-Id: <20190207113026.138410319@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 2d44ed22e607f9a285b049de2263e3840673a260 upstream.

This function is obsolete, after rhashtable addition to inet defrag.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/inet_frag.h                 |    2 --
 net/ieee802154/6lowpan/reassembly.c     |    5 ++---
 net/ipv4/inet_fragment.c                |   11 -----------
 net/ipv4/ip_fragment.c                  |    5 ++---
 net/ipv6/netfilter/nf_conntrack_reasm.c |    5 ++---
 net/ipv6/reassembly.c                   |    5 ++---
 6 files changed, 8 insertions(+), 25 deletions(-)

--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -109,8 +109,6 @@ void inet_frags_exit_net(struct netns_fr
 void inet_frag_kill(struct inet_frag_queue *q);
 void inet_frag_destroy(struct inet_frag_queue *q);
 struct inet_frag_queue *inet_frag_find(struct netns_frags *nf, void *key);
-void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
-				   const char *prefix);
 
 static inline void inet_frag_put(struct inet_frag_queue *q)
 {
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -83,10 +83,9 @@ fq_find(struct net *net, const struct lo
 	key.dst = *dst;
 
 	q = inet_frag_find(&ieee802154_lowpan->frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct lowpan_frag_queue, q);
 }
 
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -225,14 +225,3 @@ struct inet_frag_queue *inet_frag_find(s
 	return inet_frag_create(nf, key);
 }
 EXPORT_SYMBOL(inet_frag_find);
-
-void inet_frag_maybe_warn_overflow(struct inet_frag_queue *q,
-				   const char *prefix)
-{
-	static const char msg[] = "inet_frag_find: Fragment hash bucket"
-		" list length grew over limit. Dropping fragment.\n";
-
-	if (PTR_ERR(q) == -ENOBUFS)
-		net_dbg_ratelimited("%s%s", prefix, msg);
-}
-EXPORT_SYMBOL(inet_frag_maybe_warn_overflow);
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -221,10 +221,9 @@ static struct ipq *ip_find(struct net *n
 	struct inet_frag_queue *q;
 
 	q = inet_frag_find(&net->ipv4.frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct ipq, q);
 }
 
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -184,10 +184,9 @@ static struct frag_queue *fq_find(struct
 	struct inet_frag_queue *q;
 
 	q = inet_frag_find(&net->nf_frag.frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct frag_queue, q);
 }
 
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -154,10 +154,9 @@ fq_find(struct net *net, __be32 id, cons
 		key.iif = 0;
 
 	q = inet_frag_find(&net->ipv6.frags, &key);
-	if (IS_ERR_OR_NULL(q)) {
-		inet_frag_maybe_warn_overflow(q, pr_fmt());
+	if (!q)
 		return NULL;
-	}
+
 	return container_of(q, struct frag_queue, q);
 }
 


