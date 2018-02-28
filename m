Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519831942-2-12750540984568919911
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
    t=1519831941; b=QKQ8uq8D+4/DLCmuEKO+0kT54X4+QEUkxqrsaK8oYGueGYV
    vb1l2nxjBnk7OoD20lLDkxumSJDIu7zd9FRn2yIdnTLvqvQcdmQZud3DDY05IAeh
    QctHWx5hy7m+yB9JoI7cRcAUnqKeZ9EeCxowtqEAZ6+ovbk+xQhUjqB1tNswIU6G
    ZsdhhiIA6l1tIQNF93KDnu59pr/+ur3j9WiPH1oRsCNyBiN3gh85u0VQ+RDvZujI
    h7RoIgHXxdCTb6+A3W6GtDrFbM/tD+lC+T6Nwr8mEN2wff+DkrHbjcCl5x2Th0Pk
    EhMXkJPzqvfrFDetY2inCBGwY2gPb+wugjxScQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831941; bh=p1oG71VzoOQmnk8zY1X
    w9bKxUMhM0SqrJNg/ATNkzCg=; b=et2LEzC6wAa6QtQvgZFRXRwNe/GkgesBDh1
    z2n1GsqjdrRkh2Pnunrxuh4kYGU2kj55G/M2ELsH/gDiq6XHNYyIgO4bga6Az8mR
    bMEJgYOePrm9+3ktFHLq/aZbbQsHyh9ynJdCXM7103fyiI2F0Ry/i8EKuYvzi1l0
    u7e0MEtqRkO5zo8lLOutpK2Rn6US5YLrIbZsiYxwVgsXk2C6YXoFqwxwExSUEY/N
    G3a+/yMWq5EIpev5rAz67avqLh+p/c1SwdFxw5cEvYgKxbP+XK8uzJa1mjby1ArU
    3luLh53Fc7KhH/1zE9enpyIx3rQ2pITazmMJJ+44Cz5SDvotYxQ==
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
        id S932729AbeB1Pby (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:31:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33321 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752529AbeB1PWj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.892593980@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 040/140] ipv4: Avoid reading user iov twice after
 raw_probe_proto_opt
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

commit c008ba5bdc9fa830e1a349b20b0be5a137bdef7a upstream.

Ever since raw_probe_proto_opt was added it had the problem of
causing the user iov to be read twice, once during the probe for
the protocol header and once again in ip_append_data.

This is a potential security problem since it means that whatever
we're probing may be invalid.  This patch plugs the hole by
firstly advancing the iov so we don't read the same spot again,
and secondly saving what we read the first time around for use
by ip_append_data.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/raw.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 8 deletions(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -78,6 +78,16 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/compat.h>
+#include <linux/uio.h>
+
+struct raw_frag_vec {
+	struct iovec *iov;
+	union {
+		struct icmphdr icmph;
+		char c[1];
+	} hdr;
+	int hlen;
+};
 
 static struct raw_hashinfo raw_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(raw_v4_hashinfo.lock),
@@ -409,25 +419,57 @@ error:
 	return err;
 }
 
-static int raw_probe_proto_opt(struct flowi4 *fl4, struct msghdr *msg)
+static int raw_probe_proto_opt(struct raw_frag_vec *rfv, struct flowi4 *fl4)
 {
-	struct icmphdr icmph;
 	int err;
 
 	if (fl4->flowi4_proto != IPPROTO_ICMP)
 		return 0;
 
 	/* We only need the first two bytes. */
-	err = memcpy_fromiovecend((void *)&icmph, msg->msg_iov, 0, 2);
+	rfv->hlen = 2;
+
+	err = memcpy_fromiovec(rfv->hdr.c, rfv->iov, rfv->hlen);
 	if (err)
 		return err;
 
-	fl4->fl4_icmp_type = icmph.type;
-	fl4->fl4_icmp_code = icmph.code;
+	fl4->fl4_icmp_type = rfv->hdr.icmph.type;
+	fl4->fl4_icmp_code = rfv->hdr.icmph.code;
 
 	return 0;
 }
 
+static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
+		       struct sk_buff *skb)
+{
+	struct raw_frag_vec *rfv = from;
+
+	if (offset < rfv->hlen) {
+		int copy = min(rfv->hlen - offset, len);
+
+		if (skb->ip_summed == CHECKSUM_PARTIAL)
+			memcpy(to, rfv->hdr.c + offset, copy);
+		else
+			skb->csum = csum_block_add(
+				skb->csum,
+				csum_partial_copy_nocheck(rfv->hdr.c + offset,
+							  to, copy, 0),
+				odd);
+
+		odd = 0;
+		offset += copy;
+		to += copy;
+		len -= copy;
+
+		if (!len)
+			return 0;
+	}
+
+	offset -= rfv->hlen;
+
+	return ip_generic_getfrag(rfv->iov, to, offset, len, odd, skb);
+}
+
 static int raw_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr *msg,
 		       size_t len)
 {
@@ -441,6 +483,7 @@ static int raw_sendmsg(struct kiocb *ioc
 	u8  tos;
 	int err;
 	struct ip_options_data opt_copy;
+	struct raw_frag_vec rfv;
 
 	err = -EMSGSIZE;
 	if (len > 0xFFFF)
@@ -547,7 +590,10 @@ static int raw_sendmsg(struct kiocb *ioc
 			   daddr, saddr, 0, 0);
 
 	if (!inet->hdrincl) {
-		err = raw_probe_proto_opt(&fl4, msg);
+		rfv.iov = msg->msg_iov;
+		rfv.hlen = 0;
+
+		err = raw_probe_proto_opt(&rfv, &fl4);
 		if (err)
 			goto done;
 	}
@@ -576,8 +622,8 @@ back_from_confirm:
 		if (!ipc.addr)
 			ipc.addr = fl4.daddr;
 		lock_sock(sk);
-		err = ip_append_data(sk, &fl4, ip_generic_getfrag,
-				     msg->msg_iov, len, 0,
+		err = ip_append_data(sk, &fl4, raw_getfrag,
+				     &rfv, len, 0,
 				     &ipc, &rt, msg->msg_flags);
 		if (err)
 			ip_flush_pending_frames(sk);
