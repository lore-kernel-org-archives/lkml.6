Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326170-2-2254610280147216227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326170; b=GfrpjEnIpvA00Tq9kkseJjRpPxDfilV1F0q7HBazAvdMYZw
    2tWPjjZTm0EZhXvSBdNulnKDQgl57YM7Uxpsx05VxDbs8DQNn2W+fymcazGjjAFj
    JUtBmX6oZzncxU+6BJ3R1Z24NxdHP80bZEahjCL8Q8Bhn7VN/V7diwX0rmRoDFXO
    COrlZ4UHJOEB+BQzjVWLESRFBzG+a7Gd9vf+5Xe1g5Fcebz0niddt3e6fI17404W
    yIK6HkVFPW3ECmfn2rkLAFEw3TgwvPOLjcc0zE2phKbaynqlusECGEkgjoKGrT6g
    8fGUqH2YqUfNlU59vBwmG4kJ9Y/dZ7ZPANvuMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326170; bh=ETXYDrtvBE2DQ7YwYnw
    KZ/opPjeCWEfO0PAis5lzuPE=; b=ftLgbtuudEhbap8po2t1m4yPVes8DPqaH7F
    tpY1jfU2eoFpodH+gu4hhkg5SY6sFfhb1PeOR44h5f7XgWSnNkhVr+11mpFhslHj
    O6cZMfgqb2SLQ8Xre5cgGDaMSHbw+D1liWRwal2GCxAAr466WbFj+phxDqymqJbx
    yVM/AYqmTrax4p8n70WQD/T4G4xFhBbHCjJNc+Dbpv16LpGH04K7i5f1VF4EeQvT
    GfxWqA/pe7D+Vy1bA2bWL9pNXimHeIHNSxCioGetmdCu3CpY8Fm9ny6apWJw4fOx
    xUl2goth5kGd4/Ph29FaGoex8htLgqA6YYEgngSjJkKtAIq2g/w==
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
        id S1754023AbeBKFOW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:14:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41364 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752586AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Denys Fedoryshchenko" <nuclearcat@nuclearcat.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.298079355@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 66/79] netfilter: xt_TCPMSS: add more sanity tests on
 tcph->doff
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

From: Eric Dumazet <edumazet@google.com>

commit 2638fd0f92d4397884fd991d8f4925cb3f081901 upstream.

Denys provided an awesome KASAN report pointing to an use
after free in xt_TCPMSS

I have provided three patches to fix this issue, either in xt_TCPMSS or
in xt_tcpudp.c. It seems xt_TCPMSS patch has the smallest possible
impact.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Denys Fedoryshchenko <nuclearcat@nuclearcat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/xt_TCPMSS.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -71,7 +71,7 @@ tcpmss_mangle_packet(struct sk_buff *skb
 	tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
 	tcp_hdrlen = tcph->doff * 4;
 
-	if (len < tcp_hdrlen)
+	if (len < tcp_hdrlen || tcp_hdrlen < sizeof(struct tcphdr))
 		return -1;
 
 	if (info->mss == XT_TCPMSS_CLAMP_PMTU) {
@@ -122,6 +122,10 @@ tcpmss_mangle_packet(struct sk_buff *skb
 	if (len > tcp_hdrlen)
 		return 0;
 
+	/* tcph->doff has 4 bits, do not wrap it to 0 */
+	if (tcp_hdrlen >= 15 * 4)
+		return 0;
+
 	/*
 	 * MSS Option not found ?! add it..
 	 */
