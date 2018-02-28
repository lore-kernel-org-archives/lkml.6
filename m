Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519832793-2-5964228403681201751
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES rocaen,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832792; b=fdVutNsf2+qqX41kwgAgpHnwdZyJAd5a9xyJeYURiU8qrip
    YjJUyvTjflROK1572wTCUL1Zt3dgxf36FI9NHhk2l1WtCovKvT1xv6JmyykZfm0v
    p4ELYiQgvWiO5K52aEEAsd/x5jricu3ngaaqo97pWmDM6zKxYH91O1mXOqJeR/vD
    GAPwJCsBxXtDtcIM+DE8sApqNsjBBf+UDXAy105bMkuVRI5nCXOWlZECeD0mEVkf
    u8yGt9a5AisjobO2fgbB7MJ4sqO5OkOm3HuMoHbeRyyGJ4UuTlTVsUIj+vlltbYy
    THpa4nB/kbxqPB9MSp+W62Erd64BBR2HsVdXhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832792; bh=KXUNhPsmmI5QUErVPAL
    6NcMfQ6tvhQLibWfxJxkD6LA=; b=uJbGwGgvJ9YijNhPKzacF3w3MIoTxmgUDY/
    lU1fjY/rUusuqffFSIdWNUa8YJAmPvarSq6TOYrq8zptiAJA8SKPqPcaeqWd7hXa
    +1iscsNn6sCi7wrCQ8IVYhntkk3WBjjW3zjzyV/7Z8z+wmZeLfHXIBjHOkOb07x3
    1wypvKStDzlOnOKS46jYsd+TdCWwEjudZkFWTrHQOjEp3vREfVvNocHxAsZ4b3m0
    16LDuaZfsytmN6oz1fmohva6SQiVYXsR1kSgngXL4E22X0Y9uV0B4LAyllUxxQG1
    10b1iPx4Fq9DnI47lZwSR/jFJfC/N6hqQ+pJFpWLF+kpparrbOQ==
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
        id S932652AbeB1PpW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:45:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33378 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932639AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.719953985@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 055/140] xfrm: Reinject transport-mode packets through
 tasklet
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

commit acf568ee859f098279eadf551612f103afdacb4e upstream.

This is an old bugbear of mine:

https://www.mail-archive.com/netdev@vger.kernel.org/msg03894.html

By crafting special packets, it is possible to cause recursion
in our kernel when processing transport-mode packets at levels
that are only limited by packet size.

The easiest one is with DNAT, but an even worse one is where
UDP encapsulation is used in which case you just have to insert
an UDP encapsulation header in between each level of recursion.

This patch avoids this problem by reinjecting tranport-mode packets
through a tasklet.

Fixes: b05e106698d9 ("[IPV4/6]: Netfilter IPsec input hooks")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
[bwh: Backported to 3.2:
 - netfilter finish callbacks only receive an sk_buff pointer
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1439,6 +1439,7 @@ extern int xfrm_prepare_input(struct xfr
 extern int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 		      int encap_type);
 extern int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
+int xfrm_trans_queue(struct sk_buff *skb, int (*finish)(struct sk_buff *));
 extern int xfrm_output_resume(struct sk_buff *skb, int err);
 extern int xfrm_output(struct sk_buff *skb);
 extern int xfrm_inner_extract_output(struct xfrm_state *x, struct sk_buff *skb);
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -22,6 +22,11 @@ int xfrm4_extract_input(struct xfrm_stat
 	return xfrm4_extract_header(skb);
 }
 
+static int xfrm4_rcv_encap_finish2(struct sk_buff *skb)
+{
+	return dst_input(skb);
+}
+
 static inline int xfrm4_rcv_encap_finish(struct sk_buff *skb)
 {
 	if (skb_dst(skb) == NULL) {
@@ -31,7 +36,11 @@ static inline int xfrm4_rcv_encap_finish
 					 iph->tos, skb->dev))
 			goto drop;
 	}
-	return dst_input(skb);
+
+	if (xfrm_trans_queue(skb, xfrm4_rcv_encap_finish2))
+		goto drop;
+
+	return 0;
 drop:
 	kfree_skb(skb);
 	return NET_RX_DROP;
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -29,6 +29,13 @@ int xfrm6_rcv_spi(struct sk_buff *skb, i
 }
 EXPORT_SYMBOL(xfrm6_rcv_spi);
 
+static int xfrm6_transport_finish2(struct sk_buff *skb)
+{
+	if (xfrm_trans_queue(skb, ip6_rcv_finish))
+		__kfree_skb(skb);
+	return -1;
+}
+
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	skb_network_header(skb)[IP6CB(skb)->nhoff] =
@@ -43,7 +50,7 @@ int xfrm6_transport_finish(struct sk_buf
 	__skb_push(skb, skb->data - skb_network_header(skb));
 
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING, skb, skb->dev, NULL,
-		ip6_rcv_finish);
+		xfrm6_transport_finish2);
 	return -1;
 }
 
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -7,15 +7,31 @@
  *
  */
 
+#include <linux/bottom_half.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/percpu.h>
 #include <net/dst.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
 
+struct xfrm_trans_tasklet {
+	struct tasklet_struct tasklet;
+	struct sk_buff_head queue;
+};
+
+struct xfrm_trans_cb {
+	int (*finish)(struct sk_buff *skb);
+};
+
+#define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]))
+
 static struct kmem_cache *secpath_cachep __read_mostly;
 
+static DEFINE_PER_CPU(struct xfrm_trans_tasklet, xfrm_trans_tasklet);
+
 void __secpath_destroy(struct sec_path *sp)
 {
 	int i;
@@ -285,10 +301,50 @@ int xfrm_input_resume(struct sk_buff *sk
 }
 EXPORT_SYMBOL(xfrm_input_resume);
 
+static void xfrm_trans_reinject(unsigned long data)
+{
+	struct xfrm_trans_tasklet *trans = (void *)data;
+	struct sk_buff_head queue;
+	struct sk_buff *skb;
+
+	__skb_queue_head_init(&queue);
+	skb_queue_splice_init(&trans->queue, &queue);
+
+	while ((skb = __skb_dequeue(&queue)))
+		XFRM_TRANS_SKB_CB(skb)->finish(skb);
+}
+
+int xfrm_trans_queue(struct sk_buff *skb, int (*finish)(struct sk_buff *))
+{
+	struct xfrm_trans_tasklet *trans;
+
+	trans = this_cpu_ptr(&xfrm_trans_tasklet);
+
+	if (skb_queue_len(&trans->queue) >= netdev_max_backlog)
+		return -ENOBUFS;
+
+	XFRM_TRANS_SKB_CB(skb)->finish = finish;
+	skb_queue_tail(&trans->queue, skb);
+	tasklet_schedule(&trans->tasklet);
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_trans_queue);
+
 void __init xfrm_input_init(void)
 {
+	int i;
+
 	secpath_cachep = kmem_cache_create("secpath_cache",
 					   sizeof(struct sec_path),
 					   0, SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 					   NULL);
+
+	for_each_possible_cpu(i) {
+		struct xfrm_trans_tasklet *trans;
+
+		trans = &per_cpu(xfrm_trans_tasklet, i);
+		__skb_queue_head_init(&trans->queue);
+		tasklet_init(&trans->tasklet, xfrm_trans_reinject,
+			     (unsigned long)trans);
+	}
 }
