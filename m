Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518325912-2-4546602047755513112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325911; b=qgqfAI97MS3/I2udq8k1W7+Dy5s633xADpiT2AAZHc1PzaR
    W+M3Vt4UsiLrJSWaBIjtONnS9fOKtBekYzQbXxyopvBM+tT729e17Kqa3evPSrMg
    Nc6SOaqitfXox837E8BKk5L5duADj4VXdKmljouW6AvEm4B7c8XyvqSVGYAw7awW
    +YlMVGkfOWcwanv6tHMtPOUE4q8LenSfGZxsFaKrmgET+YAOtgKw0QwXmJKPoRGQ
    1hp6ViTMpRd67WxyPuBynXd7uZ55lnVyU4nP4SqTwbX+lPsIIqQ+jvCeMsYvrX8P
    FfNM42s/4YVmvzS3H5E1vAQbo395zWb/orc44UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325911; bh=894pVWHyz1vMsyvP320
    FaziavhMIzITu3OOC92Jhen8=; b=Qhu8aDZVH221+RNviRvjhl/qMhcqgSkqlKU
    IttOJLRAboGYYdTOgBmlMgxMermQvaAzUw7kQwR5nzz+1ia2yPIoyKbSNR5V1T3v
    MJD8+VN2SNvXkt965GH4w/94uvCqBaTljeVc2a14j4jtzhHr09X2Efro9cykB9x2
    1vYnJ4WvU1G+4qD/p7ooAFnBEgqQniRpL8WJqXputwvEJCbMywpllTnTIVvvZ8oA
    tGKka2cogJBMVfGA/QQ6MBCXzJY00Din1ZJH73WzMy+DY/PFBbPGr1cCi9sCMrYp
    sxTK9o+LEXGJOxKPxRK3HLTU/R5xWEdBMdTIW1RTc16orGg1MKg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeBKFLI (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:11:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41411 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752630AbeBKEdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jason Gunthorpe" <jgunthorpe@obsidianresearch.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Neil Horman" <nhorman@tuxdriver.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.145374340@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 41/79] sctp: Fixup v4mapped behaviour to comply with
 Sock API
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

commit 299ee123e19889d511092347f5fc14db0f10e3a6 upstream.

The SCTP socket extensions API document describes the v4mapping option as
follows:

8.1.15.  Set/Clear IPv4 Mapped Addresses (SCTP_I_WANT_MAPPED_V4_ADDR)

   This socket option is a Boolean flag which turns on or off the
   mapping of IPv4 addresses.  If this option is turned on, then IPv4
   addresses will be mapped to V6 representation.  If this option is
   turned off, then no mapping will be done of V4 addresses and a user
   will receive both PF_INET6 and PF_INET type addresses on the socket.
   See [RFC3542] for more details on mapped V6 addresses.

This description isn't really in line with what the code does though.

Introduce addr_to_user (renamed addr_v4map), which should be called
before any sockaddr is passed back to user space. The new function
places the sockaddr into the correct format depending on the
SCTP_I_WANT_MAPPED_V4_ADDR option.

Audit all places that touched v4mapped and either sanely construct
a v4 or v6 address then call addr_to_user, or drop the
unnecessary v4mapped check entirely.

Audit all places that call addr_to_user and verify they are on a sycall
return path.

Add a custom getname that formats the address properly.

Several bugs are addressed:
 - SCTP_I_WANT_MAPPED_V4_ADDR=0 often returned garbage for
   addresses to user space
 - The addr_len returned from recvmsg was not correct when
   returning AF_INET on a v6 socket
 - flowlabel and scope_id were not zerod when promoting
   a v4 to v6
 - Some syscalls like bind and connect behaved differently
   depending on v4mapped

Tested bind, getpeername, getsockname, connect, and recvmsg for proper
behaviour in v4mapped = 1 and 0 cases.

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/net/sctp/sctp.h    |   2 +
 include/net/sctp/structs.h |   8 +--
 net/sctp/ipv6.c            | 156 ++++++++++++++++++++++++---------------------
 net/sctp/protocol.c        |  12 ++--
 net/sctp/socket.c          |  33 +++++-----
 net/sctp/transport.c       |   4 +-
 net/sctp/ulpevent.c        |   2 +-
 7 files changed, 112 insertions(+), 105 deletions(-)

--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -705,6 +705,8 @@ static inline void sctp_v6_map_v4(union
 static inline void sctp_v4_map_v6(union sctp_addr *addr)
 {
 	addr->v6.sin6_family = AF_INET6;
+	addr->v6.sin6_flowinfo = 0;
+	addr->v6.sin6_scope_id = 0;
 	addr->v6.sin6_port = addr->v4.sin_port;
 	addr->v6.sin6_addr.s6_addr32[3] = addr->v4.sin_addr.s_addr;
 	addr->v6.sin6_addr.s6_addr32[0] = 0;
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -603,10 +603,6 @@ struct sctp_af {
 					 int saddr);
 	void		(*from_sk)	(union sctp_addr *,
 					 struct sock *sk);
-	void		(*to_sk_saddr)	(union sctp_addr *,
-					 struct sock *sk);
-	void		(*to_sk_daddr)	(union sctp_addr *,
-					 struct sock *sk);
 	void		(*from_addr_param) (union sctp_addr *,
 					    union sctp_addr_param *,
 					    __be16 port, int iif);
@@ -647,7 +643,9 @@ struct sctp_pf {
 	int  (*supported_addrs)(const struct sctp_sock *, __be16 *);
 	struct sock *(*create_accept_sk) (struct sock *sk,
 					  struct sctp_association *asoc);
-	void (*addr_v4map) (struct sctp_sock *, union sctp_addr *);
+	int (*addr_to_user)(struct sctp_sock *sk, union sctp_addr *addr);
+	void (*to_sk_saddr)(union sctp_addr *, struct sock *sk);
+	void (*to_sk_daddr)(union sctp_addr *, struct sock *sk);
 	struct sctp_af *af;
 };
 
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -430,7 +430,7 @@ static void sctp_v6_from_sk(union sctp_a
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */
 static void sctp_v6_to_sk_saddr(union sctp_addr *addr, struct sock *sk)
 {
-	if (addr->sa.sa_family == AF_INET && sctp_sk(sk)->v4mapped) {
+	if (addr->sa.sa_family == AF_INET) {
 		inet6_sk(sk)->rcv_saddr.s6_addr32[0] = 0;
 		inet6_sk(sk)->rcv_saddr.s6_addr32[1] = 0;
 		inet6_sk(sk)->rcv_saddr.s6_addr32[2] = htonl(0x0000ffff);
@@ -444,7 +444,7 @@ static void sctp_v6_to_sk_saddr(union sc
 /* Initialize sk->sk_daddr from sctp_addr. */
 static void sctp_v6_to_sk_daddr(union sctp_addr *addr, struct sock *sk)
 {
-	if (addr->sa.sa_family == AF_INET && sctp_sk(sk)->v4mapped) {
+	if (addr->sa.sa_family == AF_INET) {
 		inet6_sk(sk)->daddr.s6_addr32[0] = 0;
 		inet6_sk(sk)->daddr.s6_addr32[1] = 0;
 		inet6_sk(sk)->daddr.s6_addr32[2] = htonl(0x0000ffff);
@@ -554,8 +554,6 @@ static int sctp_v6_available(union sctp_
 	if (IPV6_ADDR_ANY == type)
 		return 1;
 	if (type == IPV6_ADDR_MAPPED) {
-		if (sp && !sp->v4mapped)
-			return 0;
 		if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
 			return 0;
 		sctp_v6_map_v4(addr);
@@ -585,8 +583,6 @@ static int sctp_v6_addr_valid(union sctp
 		/* Note: This routine is used in input, so v4-mapped-v6
 		 * are disallowed here when there is no sctp_sock.
 		 */
-		if (!sp || !sp->v4mapped)
-			return 0;
 		if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
 			return 0;
 		sctp_v6_map_v4(addr);
@@ -682,11 +678,23 @@ out:
 	return newsk;
 }
 
-/* Map v4 address to mapped v6 address */
-static void sctp_v6_addr_v4map(struct sctp_sock *sp, union sctp_addr *addr)
+/* Format a sockaddr for return to user space. This makes sure the return is
+ * AF_INET or AF_INET6 depending on the SCTP_I_WANT_MAPPED_V4_ADDR option.
+ */
+static int sctp_v6_addr_to_user(struct sctp_sock *sp, union sctp_addr *addr)
 {
-	if (sp->v4mapped && AF_INET == addr->sa.sa_family)
-		sctp_v4_map_v6(addr);
+	if (sp->v4mapped) {
+		if (addr->sa.sa_family == AF_INET)
+			sctp_v4_map_v6(addr);
+	} else {
+		if (addr->sa.sa_family == AF_INET6 &&
+		    ipv6_addr_v4mapped(&addr->v6.sin6_addr))
+			sctp_v6_map_v4(addr);
+	}
+
+	if (addr->sa.sa_family == AF_INET)
+		return sizeof(struct sockaddr_in);
+	return sizeof(struct sockaddr_in6);
 }
 
 /* Where did this skb come from?  */
@@ -713,82 +721,68 @@ static void sctp_v6_ecn_capable(struct s
 	inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
 }
 
-/* Initialize a PF_INET6 socket msg_name. */
-static void sctp_inet6_msgname(char *msgname, int *addr_len)
-{
-	struct sockaddr_in6 *sin6;
-
-	sin6 = (struct sockaddr_in6 *)msgname;
-	sin6->sin6_family = AF_INET6;
-	sin6->sin6_flowinfo = 0;
-	sin6->sin6_scope_id = 0; /*FIXME */
-	*addr_len = sizeof(struct sockaddr_in6);
-}
-
 /* Initialize a PF_INET msgname from a ulpevent. */
 static void sctp_inet6_event_msgname(struct sctp_ulpevent *event,
 				     char *msgname, int *addrlen)
 {
-	struct sockaddr_in6 *sin6, *sin6from;
-
-	if (msgname) {
-		union sctp_addr *addr;
-		struct sctp_association *asoc;
-
-		asoc = event->asoc;
-		sctp_inet6_msgname(msgname, addrlen);
-		sin6 = (struct sockaddr_in6 *)msgname;
-		sin6->sin6_port = htons(asoc->peer.port);
-		addr = &asoc->peer.primary_addr;
-
-		/* Note: If we go to a common v6 format, this code
-		 * will change.
-		 */
-
-		/* Map ipv4 address into v4-mapped-on-v6 address.  */
-		if (sctp_sk(asoc->base.sk)->v4mapped &&
-		    AF_INET == addr->sa.sa_family) {
-			sctp_v4_map_v6((union sctp_addr *)sin6);
-			sin6->sin6_addr.s6_addr32[3] =
-				addr->v4.sin_addr.s_addr;
-			return;
-		}
-
-		sin6from = &asoc->peer.primary_addr.v6;
-		ipv6_addr_copy(&sin6->sin6_addr, &sin6from->sin6_addr);
-		if (ipv6_addr_type(&sin6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
-			sin6->sin6_scope_id = sin6from->sin6_scope_id;
+	union sctp_addr *addr;
+	struct sctp_association *asoc;
+	union sctp_addr *paddr;
+
+	if (!msgname)
+		return;
+
+	addr = (union sctp_addr *)msgname;
+	asoc = event->asoc;
+	paddr = &asoc->peer.primary_addr;
+
+	if (paddr->sa.sa_family == AF_INET) {
+		addr->v4.sin_family = AF_INET;
+		addr->v4.sin_port = htons(asoc->peer.port);
+		addr->v4.sin_addr = paddr->v4.sin_addr;
+	} else {
+		addr->v6.sin6_family = AF_INET6;
+		addr->v6.sin6_flowinfo = 0;
+		if (ipv6_addr_type(&paddr->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL)
+			addr->v6.sin6_scope_id = paddr->v6.sin6_scope_id;
+		else
+			addr->v6.sin6_scope_id = 0;
+		addr->v6.sin6_port = htons(asoc->peer.port);
+		addr->v6.sin6_addr = paddr->v6.sin6_addr;
 	}
+
+	*addrlen = sctp_v6_addr_to_user(sctp_sk(asoc->base.sk), addr);
 }
 
 /* Initialize a msg_name from an inbound skb. */
 static void sctp_inet6_skb_msgname(struct sk_buff *skb, char *msgname,
 				   int *addr_len)
 {
+	union sctp_addr *addr;
 	struct sctphdr *sh;
-	struct sockaddr_in6 *sin6;
 
-	if (msgname) {
-		sctp_inet6_msgname(msgname, addr_len);
-		sin6 = (struct sockaddr_in6 *)msgname;
-		sh = sctp_hdr(skb);
-		sin6->sin6_port = sh->source;
-
-		/* Map ipv4 address into v4-mapped-on-v6 address. */
-		if (sctp_sk(skb->sk)->v4mapped &&
-		    ip_hdr(skb)->version == 4) {
-			sctp_v4_map_v6((union sctp_addr *)sin6);
-			sin6->sin6_addr.s6_addr32[3] = ip_hdr(skb)->saddr;
-			return;
-		}
+	if (!msgname)
+		return;
 
-		/* Otherwise, just copy the v6 address. */
-		ipv6_addr_copy(&sin6->sin6_addr, &ipv6_hdr(skb)->saddr);
-		if (ipv6_addr_type(&sin6->sin6_addr) & IPV6_ADDR_LINKLOCAL) {
+	addr = (union sctp_addr *)msgname;
+	sh = sctp_hdr(skb);
+
+	if (ip_hdr(skb)->version == 4) {
+		addr->v4.sin_family = AF_INET;
+		addr->v4.sin_port = sh->source;
+		addr->v4.sin_addr.s_addr =  ip_hdr(skb)->saddr;
+	} else {
+		addr->v6.sin6_family = AF_INET6;
+		addr->v6.sin6_flowinfo = 0;
+		addr->v6.sin6_port = sh->source;
+		addr->v6.sin6_addr = ipv6_hdr(skb)->saddr;
+		if (ipv6_addr_type(&addr->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) {
 			struct sctp_ulpevent *ev = sctp_skb2event(skb);
-			sin6->sin6_scope_id = ev->iif;
+			addr->v6.sin6_scope_id = ev->iif;
 		}
 	}
+
+	*addr_len = sctp_v6_addr_to_user(sctp_sk(skb->sk), addr);
 }
 
 /* Do we support this AF? */
@@ -864,9 +858,6 @@ static int sctp_inet6_bind_verify(struct
 				return 0;
 			}
 			rcu_read_unlock();
-		} else if (type == IPV6_ADDR_MAPPED) {
-			if (!opt->v4mapped)
-				return 0;
 		}
 
 		af = opt->pf->af;
@@ -921,6 +912,23 @@ static int sctp_inet6_supported_addrs(co
 	return 1;
 }
 
+/* Handle SCTP_I_WANT_MAPPED_V4_ADDR for getpeername() and getsockname() */
+static int sctp_getname(struct socket *sock, struct sockaddr *uaddr,
+			int *uaddr_len, int peer)
+{
+	int rc;
+
+	rc = inet6_getname(sock, uaddr, uaddr_len, peer);
+
+	if (rc != 0)
+		return rc;
+
+	*uaddr_len = sctp_v6_addr_to_user(sctp_sk(sock->sk),
+					  (union sctp_addr *)uaddr);
+
+	return rc;
+}
+
 static const struct proto_ops inet6_seqpacket_ops = {
 	.family		   = PF_INET6,
 	.owner		   = THIS_MODULE,
@@ -929,7 +937,7 @@ static const struct proto_ops inet6_seqp
 	.connect	   = inet_dgram_connect,
 	.socketpair	   = sock_no_socketpair,
 	.accept		   = inet_accept,
-	.getname	   = inet6_getname,
+	.getname	   = sctp_getname,
 	.poll		   = sctp_poll,
 	.ioctl		   = inet6_ioctl,
 	.listen		   = sctp_inet_listen,
@@ -983,8 +991,6 @@ static struct sctp_af sctp_af_inet6 = {
 	.copy_addrlist	   = sctp_v6_copy_addrlist,
 	.from_skb	   = sctp_v6_from_skb,
 	.from_sk	   = sctp_v6_from_sk,
-	.to_sk_saddr	   = sctp_v6_to_sk_saddr,
-	.to_sk_daddr	   = sctp_v6_to_sk_daddr,
 	.from_addr_param   = sctp_v6_from_addr_param,
 	.to_addr_param	   = sctp_v6_to_addr_param,
 	.cmp_addr	   = sctp_v6_cmp_addr,
@@ -1014,7 +1020,9 @@ static struct sctp_pf sctp_pf_inet6 = {
 	.send_verify   = sctp_inet6_send_verify,
 	.supported_addrs = sctp_inet6_supported_addrs,
 	.create_accept_sk = sctp_v6_create_accept_sk,
-	.addr_v4map    = sctp_v6_addr_v4map,
+	.addr_to_user  = sctp_v6_addr_to_user,
+	.to_sk_saddr   = sctp_v6_to_sk_saddr,
+	.to_sk_daddr   = sctp_v6_to_sk_daddr,
 	.af            = &sctp_af_inet6,
 };
 
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -615,10 +615,10 @@ out:
 	return newsk;
 }
 
-/* Map address, empty for v4 family */
-static void sctp_v4_addr_v4map(struct sctp_sock *sp, union sctp_addr *addr)
+static int sctp_v4_addr_to_user(struct sctp_sock *sp, union sctp_addr *addr)
 {
-	/* Empty */
+	/* No address mapping for V4 sockets */
+	return sizeof(struct sockaddr_in);
 }
 
 /* Dump the v4 addr to the seq file. */
@@ -1010,7 +1010,9 @@ static struct sctp_pf sctp_pf_inet = {
 	.send_verify   = sctp_inet_send_verify,
 	.supported_addrs = sctp_inet_supported_addrs,
 	.create_accept_sk = sctp_v4_create_accept_sk,
-	.addr_v4map	= sctp_v4_addr_v4map,
+	.addr_to_user  = sctp_v4_addr_to_user,
+	.to_sk_saddr   = sctp_v4_to_sk_saddr,
+	.to_sk_daddr   = sctp_v4_to_sk_daddr,
 	.af            = &sctp_af_inet
 };
 
@@ -1081,8 +1083,6 @@ static struct sctp_af sctp_af_inet = {
 	.copy_addrlist	   = sctp_v4_copy_addrlist,
 	.from_skb	   = sctp_v4_from_skb,
 	.from_sk	   = sctp_v4_from_sk,
-	.to_sk_saddr	   = sctp_v4_to_sk_saddr,
-	.to_sk_daddr	   = sctp_v4_to_sk_daddr,
 	.from_addr_param   = sctp_v4_from_addr_param,
 	.to_addr_param	   = sctp_v4_to_addr_param,
 	.cmp_addr	   = sctp_v4_cmp_addr,
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -265,7 +265,7 @@ static struct sctp_transport *sctp_addr_
 	if (id_asoc && (id_asoc != addr_asoc))
 		return NULL;
 
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
 						(union sctp_addr *)addr);
 
 	return transport;
@@ -410,7 +410,7 @@ SCTP_STATIC int sctp_do_bind(struct sock
 	/* Copy back into socket for getsockname() use. */
 	if (!ret) {
 		inet_sk(sk)->inet_sport = htons(inet_sk(sk)->inet_num);
-		af->to_sk_saddr(addr, sk);
+		sp->pf->to_sk_saddr(addr, sk);
 	}
 
 	return ret;
@@ -1061,7 +1061,6 @@ static int __sctp_connect(struct sock* s
 	struct sctp_association *asoc2;
 	struct sctp_transport *transport;
 	union sctp_addr to;
-	struct sctp_af *af;
 	sctp_scope_t scope;
 	long timeo;
 	int err = 0;
@@ -1089,6 +1088,8 @@ static int __sctp_connect(struct sock* s
 	/* Walk through the addrs buffer and count the number of addresses. */
 	addr_buf = kaddrs;
 	while (walk_size < addrs_size) {
+		struct sctp_af *af;
+
 		if (walk_size + sizeof(sa_family_t) > addrs_size) {
 			err = -EINVAL;
 			goto out_free;
@@ -1212,8 +1213,7 @@ static int __sctp_connect(struct sock* s
 
 	/* Initialize sk's dport and daddr for getpeername() */
 	inet_sk(sk)->inet_dport = htons(asoc->peer.port);
-	af = sctp_get_af_specific(sa_addr->sa.sa_family);
-	af->to_sk_daddr(sa_addr, sk);
+	sp->pf->to_sk_daddr(sa_addr, sk);
 	sk->sk_err = 0;
 
 	/* in-kernel sockets don't generally have a file allocated to them
@@ -4080,7 +4080,7 @@ static int sctp_getsockopt_sctp_status(s
 	memcpy(&status.sstat_primary.spinfo_address, &transport->ipaddr,
 			transport->af_specific->sockaddr_len);
 	/* Map ipv4 address into v4-mapped-on-v6 address.  */
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
 		(union sctp_addr *)&status.sstat_primary.spinfo_address);
 	status.sstat_primary.spinfo_state = transport->state;
 	status.sstat_primary.spinfo_cwnd = transport->cwnd;
@@ -4239,8 +4239,8 @@ SCTP_STATIC int sctp_do_peeloff(struct s
 				struct socket **sockp)
 {
 	struct sock *sk = asoc->base.sk;
+	struct sctp_sock *sp = sctp_sk(sk);
 	struct socket *sock;
-	struct sctp_af *af;
 	int err = 0;
 
 	/* Do not peel off from one netns to another one. */
@@ -4269,8 +4269,7 @@ SCTP_STATIC int sctp_do_peeloff(struct s
 	/* Make peeled-off sockets more like 1-1 accepted sockets.
 	 * Set the daddr and initialize id to something more random
 	 */
-	af = sctp_get_af_specific(asoc->peer.primary_addr.sa.sa_family);
-	af->to_sk_daddr(&asoc->peer.primary_addr, sk);
+	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sk);
 
 	/* Populate the fields of the newsk from the oldsk and migrate the
 	 * asoc to the newsk.
@@ -4645,8 +4644,8 @@ static int sctp_getsockopt_peer_addrs(st
 	list_for_each_entry(from, &asoc->peer.transport_addr_list,
 				transports) {
 		memcpy(&temp, &from->ipaddr, sizeof(temp));
-		sctp_get_pf_specific(sk->sk_family)->addr_v4map(sp, &temp);
-		addrlen = sctp_get_af_specific(temp.sa.sa_family)->sockaddr_len;
+		addrlen = sctp_get_pf_specific(sk->sk_family)
+			      ->addr_to_user(sp, &temp);
 		if (space_left < addrlen)
 			return -ENOMEM;
 		if (copy_to_user(to, &temp, addrlen))
@@ -4689,9 +4688,9 @@ static int sctp_copy_laddrs(struct sock
 		if (!temp.v4.sin_port)
 			temp.v4.sin_port = htons(port);
 
-		sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
-								&temp);
-		addrlen = sctp_get_af_specific(temp.sa.sa_family)->sockaddr_len;
+		addrlen = sctp_get_pf_specific(sk->sk_family)
+			      ->addr_to_user(sctp_sk(sk), &temp);
+
 		if (space_left < addrlen) {
 			cnt =  -ENOMEM;
 			break;
@@ -4779,8 +4778,8 @@ static int sctp_getsockopt_local_addrs(s
 	 */
 	list_for_each_entry(addr, &bp->address_list, list) {
 		memcpy(&temp, &addr->a, sizeof(temp));
-		sctp_get_pf_specific(sk->sk_family)->addr_v4map(sp, &temp);
-		addrlen = sctp_get_af_specific(temp.sa.sa_family)->sockaddr_len;
+		addrlen = sctp_get_pf_specific(sk->sk_family)
+			      ->addr_to_user(sp, &temp);
 		if (space_left < addrlen) {
 			err =  -ENOMEM; /*fixme: right error?*/
 			goto out;
@@ -4839,7 +4838,7 @@ static int sctp_getsockopt_primary_addr(
 	memcpy(&prim.ssp_addr, &asoc->peer.primary_path->ipaddr,
 		asoc->peer.primary_path->af_specific->sockaddr_len);
 
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sp,
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sp,
 			(union sctp_addr *)&prim.ssp_addr);
 
 	if (put_user(len, optlen))
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -274,8 +274,8 @@ void sctp_transport_route(struct sctp_tr
 		 */
 		if (asoc && (!asoc->peer.primary_path ||
 				(transport == asoc->peer.active_path)))
-			opt->pf->af->to_sk_saddr(&transport->saddr,
-						 asoc->base.sk);
+			opt->pf->to_sk_saddr(&transport->saddr,
+					     asoc->base.sk);
 	} else
 		transport->pathmtu = SCTP_DEFAULT_MAXSEGMENT;
 }
--- a/net/sctp/ulpevent.c
+++ b/net/sctp/ulpevent.c
@@ -348,7 +348,7 @@ struct sctp_ulpevent *sctp_ulpevent_make
 	memcpy(&spc->spc_aaddr, aaddr, sizeof(struct sockaddr_storage));
 
 	/* Map ipv4 address into v4-mapped-on-v6 address.  */
-	sctp_get_pf_specific(asoc->base.sk->sk_family)->addr_v4map(
+	sctp_get_pf_specific(asoc->base.sk->sk_family)->addr_to_user(
 					sctp_sk(asoc->base.sk),
 					(union sctp_addr *)&spc->spc_aaddr);
 
