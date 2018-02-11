Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326245-2-13163749652297428503
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
    t=1518326244; b=kllEcDNpb4LqtiwI5pPBNHWTljVLmt9MV1S9xqNz9M+4SIx
    PP3ze3IfEA4aU9MqmRDF1OTqfLVNs0/nKWXNwKyaoCReIjYG+Qs37sI3W+3l8r7G
    2isJtCbDRmq3Pzbqr56wOG8UvWxjUokLjFHqYWDNRL1l4uiinQDqnURdCUROokpw
    YUotQWQFZSM9cN08qLCo/giTuI3ZNKVlhJ76E5F0mMRDiDeYdd8wb+U3bUmtqSAj
    PHiQFDrcW6+SKrU9RHx1G9T9x3bgpRpwJgcwh95X/TkmYv/NaX/tmBuQL+Wp8+H3
    izWUvIJqUQ/tQs8pKFgK0v14pw7RzKAsnrPVtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326244; bh=P2yoQrIJEeXgnhGo2ZQ
    c5/o6LnGHgFs8GvED3qy2AN8=; b=Lpmp+J4vlmO5RbBrg/vjQOR1NIfYGa5oGzc
    s7HHu6qOWtFFM8upIxJVu29HwgIC7IIltUCwnHzkoWiWrlei3dynRbKWPoeCjP/w
    +tcPx7KSuOIe23ftPSm9FVBHL2JlTx8BjLzFvKPSyptx2wuxQp6o+jsKfNAZPf0V
    W3689DmqN73vA1ynPRT1JvojlmlpZAaejvOCLwfk9J4xkSwJUeiQ3eWWxB5A55O9
    GdG2hGb2hKrGH9dFCCFwO4Y9n+nWSlt4zrbyVXocSl0Ax3uDU1xYL3Hn9d0/P21K
    1khk0tqUMMs+izCJ6BdHXM7sePq1m/60M7IYXrZn+8WjdNOvKLA==
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
        id S1753440AbeBKFQw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:16:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41365 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752581AbeBKEdl (ORCPT
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
Message-ID: <lsq.1518322806.468971680@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 65/79] netfilter: xt_TCPMSS: correct return value in
 tcpmss_mangle_packet
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

commit 1205e1fa615805c9efa97303b552cf445965752a upstream.

In commit b396966c4 (netfilter: xt_TCPMSS: Fix missing fragmentation handling),
I attempted to add safe fragment handling to xt_TCPMSS.  However, Andy Padavan
of Project N56U correctly points out that returning XT_CONTINUE in this
function does not work.  The callers (tcpmss_tg[46]) expect to receive a value
of 0 in order to return XT_CONTINUE.

Signed-off-by: Phil Oester <kernel@linuxace.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/xt_TCPMSS.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -59,7 +59,7 @@ tcpmss_mangle_packet(struct sk_buff *skb
 
 	/* This is a fragment, no TCP header is available */
 	if (par->fragoff != 0)
-		return XT_CONTINUE;
+		return 0;
 
 	if (!skb_make_writable(skb, skb->len))
 		return -1;
