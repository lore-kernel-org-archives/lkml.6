Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326064-2-10942430403255191971
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326064; b=wafLQI1OGU+14Of7gfI6tQmDOvqhzbAftsMDnVt9v0wCFQ/
    une4eZlvZcHQ3tY5NElhNnYEm1B8JQZGtacPNEECSSYSYOlCxyNoZxy+a+1+UWum
    1KyDpEBzNSe/UOzApWNt5XHD3guvRovQ3NlHtpjzkZn6TUKcCxODBKPbDbCTLhLp
    EEWnIfhWqesO9DO8S33vx1iJQ9M24U04LsPnZy5yj7QdS3ADSLdxs3n/qKmU7mMD
    zOwy1gtRolq0FBRDIXnsABEMerqGS/s5ltWk6y9UgTxnBSl2NapI6h2iRrUoeKHI
    S8i3NWjN74HZPUuqxtgGzoSkQOTkGm8L2fhL5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326064; bh=mPdJjvMsgYsTSCGTnoM
    8zjQGK2gMoJipW3sHDtJyXO8=; b=FCqcUoZ3htmQZQmbCjqJ5cd+RCLNTckHePH
    JYZ0t4ag2EdFm9to2uAInO/kTjRT0wC3ZZVKD3PgnzrMDx/WL4auZfLmt1dRCJbn
    TevVxRt8gpuYK+WC6e1Ll/Ch0LdD155CCeemrs24/kVUD41KBwW1VhT3cp8YlC5c
    1oa8UTeS+BS4mao9zftYJ2kxr9J423OXySkLmiSR8EzosTSb1OdzCXge8inCyX/x
    QsQD/uX9ZLX55fx+blEt/56DSKXz259QbtnUMWuABqL6569Y222eFoPA7AqQQ7vx
    pSw9im+4CKzWysSgKChKk9TnepoAK8SAKAJl3caWVSV6wR1IY6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeBKFOT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:14:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41376 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752593AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Julian Anastasov" <ja@ssi.bg>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.764914825@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 64/79] netfilter: xt_TCPMSS: fix handling of malformed
 TCP header and options
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 71ffe9c77dd7a2b62207953091efa8dafec958dd upstream.

Make sure the packet has enough room for the TCP header and
that it is not malformed.

While at it, store tcph->doff*4 in a variable, as it is used
several times.

This patch also fixes a possible off by one in case of malformed
TCP options.

Reported-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/xt_TCPMSS.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -51,7 +51,8 @@ tcpmss_mangle_packet(struct sk_buff *skb
 {
 	const struct xt_tcpmss_info *info = par->targinfo;
 	struct tcphdr *tcph;
-	unsigned int tcplen, i;
+	int len, tcp_hdrlen;
+	unsigned int i;
 	__be16 oldval;
 	u16 newmss;
 	u8 *opt;
@@ -63,11 +64,14 @@ tcpmss_mangle_packet(struct sk_buff *skb
 	if (!skb_make_writable(skb, skb->len))
 		return -1;
 
-	tcplen = skb->len - tcphoff;
+	len = skb->len - tcphoff;
+	if (len < (int)sizeof(struct tcphdr))
+		return -1;
+
 	tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
+	tcp_hdrlen = tcph->doff * 4;
 
-	/* Header cannot be larger than the packet */
-	if (tcplen < tcph->doff*4)
+	if (len < tcp_hdrlen)
 		return -1;
 
 	if (info->mss == XT_TCPMSS_CLAMP_PMTU) {
@@ -88,9 +92,8 @@ tcpmss_mangle_packet(struct sk_buff *skb
 		newmss = info->mss;
 
 	opt = (u_int8_t *)tcph;
-	for (i = sizeof(struct tcphdr); i < tcph->doff*4; i += optlen(opt, i)) {
-		if (opt[i] == TCPOPT_MSS && tcph->doff*4 - i >= TCPOLEN_MSS &&
-		    opt[i+1] == TCPOLEN_MSS) {
+	for (i = sizeof(struct tcphdr); i <= tcp_hdrlen - TCPOLEN_MSS; i += optlen(opt, i)) {
+		if (opt[i] == TCPOPT_MSS && opt[i+1] == TCPOLEN_MSS) {
 			u_int16_t oldmss;
 
 			oldmss = (opt[i+2] << 8) | opt[i+3];
@@ -113,9 +116,10 @@ tcpmss_mangle_packet(struct sk_buff *skb
 	}
 
 	/* There is data after the header so the option can't be added
-	   without moving it, and doing so may make the SYN packet
-	   itself too large. Accept the packet unmodified instead. */
-	if (tcplen > tcph->doff*4)
+	 * without moving it, and doing so may make the SYN packet
+	 * itself too large. Accept the packet unmodified instead.
+	 */
+	if (len > tcp_hdrlen)
 		return 0;
 
 	/*
@@ -132,10 +136,10 @@ tcpmss_mangle_packet(struct sk_buff *skb
 	skb_put(skb, TCPOLEN_MSS);
 
 	opt = (u_int8_t *)tcph + sizeof(struct tcphdr);
-	memmove(opt + TCPOLEN_MSS, opt, tcplen - sizeof(struct tcphdr));
+	memmove(opt + TCPOLEN_MSS, opt, len - sizeof(struct tcphdr));
 
 	inet_proto_csum_replace2(&tcph->check, skb,
-				 htons(tcplen), htons(tcplen + TCPOLEN_MSS), 1);
+				 htons(len), htons(len + TCPOLEN_MSS), 1);
 	opt[0] = TCPOPT_MSS;
 	opt[1] = TCPOLEN_MSS;
 	opt[2] = (newmss & 0xff00) >> 8;
