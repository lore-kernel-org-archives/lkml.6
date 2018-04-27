Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524838232-2-5667470449973022058
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enfr, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838232; b=iL4YPiY6x/PJieuD73B4RrfIrtnyzLh1iH7U/yjwQnWfOlPuaA
    2lg66lsfRnDonYGw8kL9RMxG3n11jWC9PvkZ4LaUf+FZuqq9h4Vl2eFSx5wQmyvg
    LjijL1Hma6PjoTPY6OXoap3aP2mKbE0B2f6OTk4rs0uUO/yoOV0MgfpCh7JDIE1d
    8Srvhwk7Bo9GQo5o00uvRvOP/ho9mPhb0uObbnOj8jKZyYWKzJv20KUeC4G9hZo0
    a7UFGV4I5wqral3XaNU1coYIeyIlC/+Bbvg2baABdjipDx08R05qEjux4DVcbLOO
    MsqzddW3bZmcBrrviKhbAPrDlUZ4KWzMdrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838232; bh=uTnhvRs45XK2oIIbLP8fiCgb0X4CsA
    Oua59TCooR/Kc=; b=llVfskwtJXI5xaebKA+87y3HBLHyhmIybbZNKVi/RhWIWo
    M0mSOPZF5u6FrQQnAokZWhncJFaJHvoaEvPYUwLLVzaiDN2EZV3TP1TBuU+YC0xI
    bpJqGgc0LfCJlq3QZmhHYUlYUpA4Gswg5w+opjJGSoTT2DNa18Q6K4D7wSPP1yWU
    ruUJWK7GvzLf0EMmS3LxSV/GafxaCYj49IHiutezVRGcUhxQH5p6j2nVS9eMQ6Tw
    2QakB9Wl/KABJM919qZKo5s9i0Yuj11/BxmFxqwp7wBd82Glybl6+K5EF4hn7fgu
    TSyrNLRJwXeorfmWVGQ0jH+8RpBn7EU7dlNCQpmw==
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
X-CM-Envelope: MS4wfMtjQZkV7QrIwHG62kOkSMS+d96FmnKmHKSz8zji72bDrKqEGGgbIWcrk0nTcQAilK5O7cGvzgbZThQ8GkvVi3YbIoPRmRnHRrOn8dg1y/UrFdkaKZaG
    6Vois0Zbw3zVQX/uqrZBdK8KjKPMllvpt2tmljDE/93k7munOz3D3yV7vSbfCW/D3cBTNWjsimsb13VUyTMDW9dt4PmMn/4qusiXq/47QNiZ9O2nzl9cJ47T
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=vmLDa1wCAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=B5kgTa-OJr302yQp2YMA:9 a=eEFkMGFhjyoL3bTw:21
    a=goHr4I-h5IuJYFYn:21 a=QEXdDO2ut3YA:10 a=h8Bt5HTj68qkN2fS7gvA:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934819AbeD0OKT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934799AbeD0OKS (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:10:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DA921892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianwen Ji <jiji@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 24/81] sctp: do not check port in sctp_inet6_cmp_addr
Date: Fri, 27 Apr 2018 15:58:26 +0200
Message-Id: <20180427135744.582358944@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 1071ec9d453a38023579714b64a951a2fb982071 ]

pf->cmp_addr() is called before binding a v6 address to the sock. It
should not check ports, like in sctp_inet_cmp_addr.

But sctp_inet6_cmp_addr checks the addr by invoking af(6)->cmp_addr,
sctp_v6_cmp_addr where it also compares the ports.

This would cause that setsockopt(SCTP_SOCKOPT_BINDX_ADD) could bind
multiple duplicated IPv6 addresses after Commit 40b4f0fd74e4 ("sctp:
lack the check for ports in sctp_v6_cmp_addr").

This patch is to remove af->cmp_addr called in sctp_inet6_cmp_addr,
but do the proper check for both v6 addrs and v4mapped addrs.

v1->v2:
  - define __sctp_v6_cmp_addr to do the common address comparison
    used for both pf and af v6 cmp_addr.

Fixes: 40b4f0fd74e4 ("sctp: lack the check for ports in sctp_v6_cmp_addr")
Reported-by: Jianwen Ji <jiji@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/ipv6.c |   60 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -521,46 +521,49 @@ static void sctp_v6_to_addr(union sctp_a
 	addr->v6.sin6_scope_id = 0;
 }
 
-/* Compare addresses exactly.
- * v4-mapped-v6 is also in consideration.
- */
-static int sctp_v6_cmp_addr(const union sctp_addr *addr1,
-			    const union sctp_addr *addr2)
+static int __sctp_v6_cmp_addr(const union sctp_addr *addr1,
+			      const union sctp_addr *addr2)
 {
 	if (addr1->sa.sa_family != addr2->sa.sa_family) {
 		if (addr1->sa.sa_family == AF_INET &&
 		    addr2->sa.sa_family == AF_INET6 &&
-		    ipv6_addr_v4mapped(&addr2->v6.sin6_addr)) {
-			if (addr2->v6.sin6_port == addr1->v4.sin_port &&
-			    addr2->v6.sin6_addr.s6_addr32[3] ==
-			    addr1->v4.sin_addr.s_addr)
-				return 1;
-		}
+		    ipv6_addr_v4mapped(&addr2->v6.sin6_addr) &&
+		    addr2->v6.sin6_addr.s6_addr32[3] ==
+		    addr1->v4.sin_addr.s_addr)
+			return 1;
+
 		if (addr2->sa.sa_family == AF_INET &&
 		    addr1->sa.sa_family == AF_INET6 &&
-		    ipv6_addr_v4mapped(&addr1->v6.sin6_addr)) {
-			if (addr1->v6.sin6_port == addr2->v4.sin_port &&
-			    addr1->v6.sin6_addr.s6_addr32[3] ==
-			    addr2->v4.sin_addr.s_addr)
-				return 1;
-		}
+		    ipv6_addr_v4mapped(&addr1->v6.sin6_addr) &&
+		    addr1->v6.sin6_addr.s6_addr32[3] ==
+		    addr2->v4.sin_addr.s_addr)
+			return 1;
+
 		return 0;
 	}
-	if (addr1->v6.sin6_port != addr2->v6.sin6_port)
-		return 0;
+
 	if (!ipv6_addr_equal(&addr1->v6.sin6_addr, &addr2->v6.sin6_addr))
 		return 0;
+
 	/* If this is a linklocal address, compare the scope_id. */
-	if (ipv6_addr_type(&addr1->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) {
-		if (addr1->v6.sin6_scope_id && addr2->v6.sin6_scope_id &&
-		    (addr1->v6.sin6_scope_id != addr2->v6.sin6_scope_id)) {
-			return 0;
-		}
-	}
+	if ((ipv6_addr_type(&addr1->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) &&
+	    addr1->v6.sin6_scope_id && addr2->v6.sin6_scope_id &&
+	    addr1->v6.sin6_scope_id != addr2->v6.sin6_scope_id)
+		return 0;
 
 	return 1;
 }
 
+/* Compare addresses exactly.
+ * v4-mapped-v6 is also in consideration.
+ */
+static int sctp_v6_cmp_addr(const union sctp_addr *addr1,
+			    const union sctp_addr *addr2)
+{
+	return __sctp_v6_cmp_addr(addr1, addr2) &&
+	       addr1->v6.sin6_port == addr2->v6.sin6_port;
+}
+
 /* Initialize addr struct to INADDR_ANY. */
 static void sctp_v6_inaddr_any(union sctp_addr *addr, __be16 port)
 {
@@ -846,8 +849,8 @@ static int sctp_inet6_cmp_addr(const uni
 			       const union sctp_addr *addr2,
 			       struct sctp_sock *opt)
 {
-	struct sctp_af *af1, *af2;
 	struct sock *sk = sctp_opt2sk(opt);
+	struct sctp_af *af1, *af2;
 
 	af1 = sctp_get_af_specific(addr1->sa.sa_family);
 	af2 = sctp_get_af_specific(addr2->sa.sa_family);
@@ -863,10 +866,7 @@ static int sctp_inet6_cmp_addr(const uni
 	if (sctp_is_any(sk, addr1) || sctp_is_any(sk, addr2))
 		return 1;
 
-	if (addr1->sa.sa_family != addr2->sa.sa_family)
-		return 0;
-
-	return af1->cmp_addr(addr1, addr2);
+	return __sctp_v6_cmp_addr(addr1, addr2);
 }
 
 /* Verify that the provided sockaddr looks bindable.   Common verification,
