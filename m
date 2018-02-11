Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326201-2-7526000084752503710
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
    t=1518326200; b=VI1OKBlSlHjJpAG6xiCtk0v018lgjSindrVxa4ic7YbJdu4
    PwY2FIe+hESfAKMUi7MBsZnM2KZO35jgnRSamFtX7pkj94VNODiiaSB/supfoLK4
    +rWcrIEKyOyUVujsq8l83FCX0sm+nD3n8qP5Y0n0p76S7VvkVtcDsJfkeef+XdV4
    EWrSvfTdcZlSW1ltE1tQnQhiFLY1zk+1ahNF7v2C1GXwmbOEt2+00/Gv9o7/KIVH
    p6m94tv81BjWpBkm4tjN9xaYmdT3mzy/UgyxfmBb3TWzfDH/QOMBMMkw0BaTDXca
    nAWCwtnKCbuakIVys8IqW6nEDCgdk2LK0WHc6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326200; bh=IcfEo9A+Id0ao3yyOT5
    gOjg6V3t4L0f/5S2SmOyIgOQ=; b=W8YWzq5PR6RQiWmpAH4boNQfVesxB83HTa/
    FqKcxjJ+Wio/XBcTpUYJmFvR2eM6VUa2qQpxpDvsiO0qHGDF3nB2tlH6pjhO63RV
    uU36yGnjMQcUHBDHTA2G9s+i+ln5lGBg4zA8Y1pRyVZLI1o/t2R3HUhGOnkPpolA
    O/bGdQEQ6WVaUWw6Sx/tJDn72JyHmIQ80+P8f7oaY5ZxZgskyEE/Ea1gnwHc+0Of
    Hnuuq3UEvF3/bQaikNCIOJt4JVbTzp0VYz5pCz0IvVDsEo2xRysXxT4kM1dNAasz
    QWDx5jTcKUp7dP/VzMofZ5xV4rJY1wGmy0zLTzJNdWALopwsVOQ==
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
        id S1753765AbeBKFOS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:14:18 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41384 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752616AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Phil Oester" <kernel@linuxace.com>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.259131783@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 62/79] netfilter: xt_TCPOPTSTRIP: don't use tcp_hdr()
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

commit ed82c437320c48a4032492f4a55a7e2c934158b6 upstream.

In (bc6bcb5 netfilter: xt_TCPOPTSTRIP: fix possible mangling beyond
packet boundary), the use of tcp_hdr was introduced. However, we
cannot assume that skb->transport_header is set for non-local packets.

Cc: Florian Westphal <fw@strlen.de>
Reported-by: Phil Oester <kernel@linuxace.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/xt_TCPOPTSTRIP.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/netfilter/xt_TCPOPTSTRIP.c
+++ b/net/netfilter/xt_TCPOPTSTRIP.c
@@ -48,11 +48,13 @@ tcpoptstrip_mangle_packet(struct sk_buff
 		return NF_DROP;
 
 	len = skb->len - tcphoff;
-	if (len < (int)sizeof(struct tcphdr) ||
-	    tcp_hdr(skb)->doff * 4 > len)
+	if (len < (int)sizeof(struct tcphdr))
 		return NF_DROP;
 
 	tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
+	if (tcph->doff * 4 > len)
+		return NF_DROP;
+
 	opt  = (u_int8_t *)tcph;
 
 	/*
