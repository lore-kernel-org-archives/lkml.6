Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324919-2-9780562172261814025
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
    t=1518324918; b=U2Bue6se6lZ1++FIbkmTL4XxYES609VAUGar+y1ohO1I/AG
    x8URgIFyAG7gQXYvPVNrvWcp7c71gH8PoSi7zaQfESj8/0GJV4LWCBSih785w1yd
    Uxf7IEJ9v1Yf/mOMiZ5cST+/axDCncrliSJsDOI7CPXxu6bVwx7UA31LOSkqvo4z
    0P1dkn1hEHnSvp/N8nOi+tKujTGB2wE6/hmtxL5eAT+fJN8A82/jc54rOL3rBQif
    jScuLzTE+lRyihcxRCw1FMpKcFkdEK1l/pmma+xQoqzzdSpDeJSd7c9B+FMls/j7
    hbNantpcXGzQ9eSTSn0IJU/db+qnK5PPJQZRCMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324918; bh=w97EjgALFtxd8+JlpIU
    bBiVlvLb3aSVohF/nIS8OLHM=; b=ILol91VBg9krJ5OCKs141d6HWg7A9qziC3M
    z4pJO+6iBJa+sWQ6MnKCVPGzR43dvDZ499CcTNZ7qxiKjeHSU/s0oW15Jm7sTWzY
    miXgsDYicATxfy259daMT5ClC66JItOfjC6o16rlVWdMqOKF1Pdcsgvbw3NL0uC0
    VtFL35DddAsiPeCrHgB03msyA0VWgmCSiXW0os0hmFkzijc6hXgCenoqAj5RaXee
    0dZcPuc74rWN5k1RIy1qcB8W5r9zny1652US+MfK8sI/Ga25qFTqIp4z4AVgxWhd
    nJfY6r3qoXD0PzGkZkncyq/emVIvIB2yBv5SYAWEP0OnxvACZ+g==
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
        id S1752809AbeBKEyT (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:54:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41730 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752805AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Dumazet" <edumazet@google.com>,
        "Denys Fedoryshchenko" <nuclearcat@nuclearcat.com>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.281219415@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 117/136] netfilter: xt_TCPMSS: add more sanity tests
 on tcph->doff
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -104,7 +104,7 @@ tcpmss_mangle_packet(struct sk_buff *skb
 	tcph = (struct tcphdr *)(skb_network_header(skb) + tcphoff);
 	tcp_hdrlen = tcph->doff * 4;
 
-	if (len < tcp_hdrlen)
+	if (len < tcp_hdrlen || tcp_hdrlen < sizeof(struct tcphdr))
 		return -1;
 
 	if (info->mss == XT_TCPMSS_CLAMP_PMTU) {
@@ -156,6 +156,10 @@ tcpmss_mangle_packet(struct sk_buff *skb
 	if (len > tcp_hdrlen)
 		return 0;
 
+	/* tcph->doff has 4 bits, do not wrap it to 0 */
+	if (tcp_hdrlen >= 15 * 4)
+		return 0;
+
 	/*
 	 * MSS Option not found ?! add it..
 	 */
