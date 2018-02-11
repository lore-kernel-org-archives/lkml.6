Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326241-2-5279432680114000677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326241; b=fRLLyCu7y3pdQ6B4NeXUBOPhhAPWRzU1Gq715e58b0NVG8l
    RRqoXy9WHdsi0P9FAuuOGWU3B1op8ayFnXjzEZLNoM60ppD41AgSTAJKwzRingO4
    MieWX6x/K2ydX0nwJl20z3QvO/XdfiW/YRdF2sAMZIxTcgKRdHs9JFzLq0COEiTP
    5z45UwT6SZaxB58kU42HNJD4vkP3laEx+Fm4OmobYTWwA8VKKdXt4K+iEP4ZcCzB
    mghxi6s95fHZHmgUb+xqev65mQGiGmBpTZ12GS3KeFrWJ9WIpGG1VtnGowEQuNE3
    4Uf7Moty9m9BWGcITOehiaNliW3XNVGmcpICjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326241; bh=d4CyxUmRxpHvn6+dOZl
    wtgqCrsfSmiBadbzqHAFcg4o=; b=PNjVxOKdCodafTfml5AubeCe5KwT2W5Knur
    M66yZ6UIjNvBKqDDeQPLvPELLj59InpOmvyOWAqnzGfdxE61Pxk9mHa+10g3rBDB
    ClBjTimogGDhHAo1CvnnYnHZVH4NRFwXC4/V1hzkQpTnDSQrq8u3i+76d+vkrvNk
    jGNfACnUdyi+44UUjeTXm3qqbJpFPbqi123oEuhKoHCMlkHxjZS+N3DBe/qPP+ZE
    v4OkitA0cAovuuBDh/tiEkYewEvu7AEEd3Fk1VVEZSIxWP02V21d8AVbZSukoeiR
    64ekOnepy0mrqk8wphF8T9yaA3m/QVIY5fCzcJqNEqYX0P1WeTw==
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
        id S1753484AbeBKFQx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:16:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41360 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752580AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Phil Oester" <kernel@linuxace.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.404260891@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 63/79] netfilter: xt_TCPMSS: Fix missing fragmentation
 handling
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

From: Phil Oester <kernel@linuxace.com>

commit b396966c4688522863572927cb30aa874b3ec504 upstream.

Similar to commit bc6bcb59 ("netfilter: xt_TCPOPTSTRIP: fix
possible mangling beyond packet boundary"), add safe fragment
handling to xt_TCPMSS.

Signed-off-by: Phil Oester <kernel@linuxace.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[bwh: Backported to 3.2: Change parameters for tcpmss_mangle_packet() as
 done upstream in commit 70d19f805f8c "netfilter: xt_TCPMSS: Fix IPv6 default
 MSS too"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -44,17 +44,22 @@ optlen(const u_int8_t *opt, unsigned int
 
 static int
 tcpmss_mangle_packet(struct sk_buff *skb,
-		     const struct xt_tcpmss_info *info,
+		     const struct xt_action_param *par,
 		     unsigned int in_mtu,
 		     unsigned int tcphoff,
 		     unsigned int minlen)
 {
+	const struct xt_tcpmss_info *info = par->targinfo;
 	struct tcphdr *tcph;
 	unsigned int tcplen, i;
 	__be16 oldval;
 	u16 newmss;
 	u8 *opt;
 
+	/* This is a fragment, no TCP header is available */
+	if (par->fragoff != 0)
+		return XT_CONTINUE;
+
 	if (!skb_make_writable(skb, skb->len))
 		return -1;
 
@@ -183,7 +188,7 @@ tcpmss_tg4(struct sk_buff *skb, const st
 	__be16 newlen;
 	int ret;
 
-	ret = tcpmss_mangle_packet(skb, par->targinfo,
+	ret = tcpmss_mangle_packet(skb, par,
 				   tcpmss_reverse_mtu(skb, PF_INET),
 				   iph->ihl * 4,
 				   sizeof(*iph) + sizeof(struct tcphdr));
@@ -211,7 +216,7 @@ tcpmss_tg6(struct sk_buff *skb, const st
 	tcphoff = ipv6_skip_exthdr(skb, sizeof(*ipv6h), &nexthdr);
 	if (tcphoff < 0)
 		return NF_DROP;
-	ret = tcpmss_mangle_packet(skb, par->targinfo,
+	ret = tcpmss_mangle_packet(skb, par,
 				   tcpmss_reverse_mtu(skb, PF_INET6),
 				   tcphoff,
 				   sizeof(*ipv6h) + sizeof(struct tcphdr));
