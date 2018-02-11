Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326191-2-1772743637277333032
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
    t=1518326191; b=ZDpKu8Re22Jbhqabmsh7ncx6QEpR0bcnD1+0hAsobJSY08r
    Nz2kUYnnmTW4aJgCAQmeR2iICt6NVpb+1sfOfj2rFm19crfOz4hJB/22b9JvnE8N
    Z5Q9ehMs5+yBv9xMqU/LgYzCqwn1+TyjfMKls95bkF+GcKjnmLsMDK8lqfs4TKEe
    cYHn6dOHTQpeFrBKyUjxzpo2S7/+u8uipb5B/gqC9f+XDTZSal/EeQUsBXDS6c1R
    5XhYyWQAxRXhIAue9F4vh+odb5apwjDrBUyuDY6Caz8REMdiwhPcaewgfVHUxcLj
    951GXovn6iRa4iaKHx9qYXhsTmIqi8QrBSQtQfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326191; bh=WbjqCDkE/yATie1Dfau
    1jlk7Jynml7OAtcAhjQekAag=; b=WWSTrbrtsDnJsZWvjXze7w+KkoTc9/ByLVl
    pImTZIUDL1ncrIZySx3oBzdR6miLN2776DqPGTf8Hx49L/mQalWlJ6iIcLCUS2AD
    p0BR7Gc0hKN4NP71D0UbS71Czg/aFtO8qRMjFmWIrAjioMGob2oVRxs0y/8F9xWs
    QW5wPQqg6eyn4UEln/olA7ucU2LG4cWJAxb9wrw5nUu3m5feeIk9Xaa1lB2QePxJ
    jMvq6v2An2U/xC6fcobGsG33f/9JN4cfU9V11M5ySDCM6OQJxTKmQzrFGUZsv06T
    VV8EuWjjTJ5TxmseZPyUyyPx8Tukr24KVaKKArQa9z3Iqi9zanw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeBKFOT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:14:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41378 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752601AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Rafal Kupka" <rkupka@telemetry.com>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.230534582@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 61/79] netfilter: xt_TCPOPTSTRIP: fix possible
 mangling beyond packet boundary
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

commit bc6bcb59dd7c184d229f9e86d08aa56059938a4c upstream.

This target assumes that tcph->doff is well-formed, that may be well
not the case. Add extra sanity checkings to avoid possible crash due
to read/write out of the real packet boundary. After this patch, the
default action on malformed TCP packets is to drop them. Moreover,
fragments are skipped.

Reported-by: Rafal Kupka <rkupka@telemetry.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/xt_TCPOPTSTRIP.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/net/netfilter/xt_TCPOPTSTRIP.c
+++ b/net/netfilter/xt_TCPOPTSTRIP.c
@@ -30,17 +30,28 @@ static inline unsigned int optlen(const
 
 static unsigned int
 tcpoptstrip_mangle_packet(struct sk_buff *skb,
-			  const struct xt_tcpoptstrip_target_info *info,
+			  const struct xt_action_param *par,
 			  unsigned int tcphoff, unsigned int minlen)
 {
+	const struct xt_tcpoptstrip_target_info *info = par->targinfo;
 	unsigned int optl, i, j;
 	struct tcphdr *tcph;
 	u_int16_t n, o;
 	u_int8_t *opt;
+	int len;
+
+	/* This is a fragment, no TCP header is available */
+	if (par->fragoff != 0)
+		return XT_CONTINUE;
 
 	if (!skb_make_writable(skb, skb->len))
 		return NF_DROP;
 
+	len = skb->len - tcphoff;
+	if (len < (int)sizeof(struct tcphdr) ||
+	    tcp_hdr(skb)->doff * 4 > len)
+		return NF_DROP;
+
 	tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
 	opt  = (u_int8_t *)tcph;
 
@@ -76,7 +87,7 @@ tcpoptstrip_mangle_packet(struct sk_buff
 static unsigned int
 tcpoptstrip_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	return tcpoptstrip_mangle_packet(skb, par->targinfo, ip_hdrlen(skb),
+	return tcpoptstrip_mangle_packet(skb, par, ip_hdrlen(skb),
 	       sizeof(struct iphdr) + sizeof(struct tcphdr));
 }
 
@@ -93,7 +104,7 @@ tcpoptstrip_tg6(struct sk_buff *skb, con
 	if (tcphoff < 0)
 		return NF_DROP;
 
-	return tcpoptstrip_mangle_packet(skb, par->targinfo, tcphoff,
+	return tcpoptstrip_mangle_packet(skb, par, tcphoff,
 	       sizeof(*ipv6h) + sizeof(struct tcphdr));
 }
 #endif
