Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836294-2-12566529896173861219
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
    t=1519836293; b=Ca/XUsM3O/aGyRfv7delL1pbLd3JPjfdV6G7bzqgCpjXfvu
    fVNRstSbHZEGo7N7HADZh83qLcchB8D3u58v/gpz7nF62VloYpm+EH4aw50zbiZq
    +oKhMFyQ6PR5w1z82IdTtMwJWnXkDhbIwJWelbSJgvXXCSsZfPoAKC/1BrIhnsSt
    Malqvs4gAd9dv7sgdFOYm0VMaY/QRYGSLFLsxax7FzKPnWxHz+HebMtTZE9zGId7
    8nXlc5VKsr/8L/xfwBFPDOOK80fa0naLzZkIl685Ke7O57Y6wYjr8YiKg0RboRen
    gNsvPt8/gAGo1k92WGIPmzDASWoZGcBU1C/qO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836293; bh=bVFqDTPYKTZ/TIOkbsW
    ihBah36NZbmXrnvRhBseY5nY=; b=GG5X74UwCoGl3vlyj93EPMwlKeIqxyX9aef
    gOMczbVW7SPpjMUTVDgsiRjIMq2blXRd4V7REe/lRJE2VGnJs6jEQTOigCUuQ+Mh
    OAeBcEggHyTailwH8FMGSiv+OCDMvvgKbUJD9Yu7MWcGHJKUPXfTCZZKnTOWoeF2
    pWv7zi5IxggKAneMV2pbg9UKl6rdy2+7ToThBxhPSeIeyKRAuTEZAyJjqe8x43Gr
    drGlI5j0munLWWgPyudvzd/ZLXDfbcLm+i7wGfbf2ZFK2Y+nqXdMhUUvrmylK1V0
    ZrTyKqpysABdtg9kvzhp8Uh6hrTD7epgeYPVSHPExhh53qLSELA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeB1Qoh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:44:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34679 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932091AbeB1QAk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:00:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Christoph Paasch" <cpaasch@apple.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.554100668@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 090/254] tcp md5sig: Use skb's saddr when replying to
 an incoming segment
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Paasch <cpaasch@apple.com>

commit 30791ac41927ebd3e75486f9504b6d2280463bf0 upstream.

The MD5-key that belongs to a connection is identified by the peer's
IP-address. When we are in tcp_v4(6)_reqsk_send_ack(), we are replying
to an incoming segment from tcp_check_req() that failed the seq-number
checks.

Thus, to find the correct key, we need to use the skb's saddr and not
the daddr.

This bug seems to have been there since quite a while, but probably got
unnoticed because the consequences are not catastrophic. We will call
tcp_v4_reqsk_send_ack only to send a challenge-ACK back to the peer,
thus the connection doesn't really fail.

Fixes: 9501f9722922 ("tcp md5sig: Let the caller pass appropriate key for tcp_v{4,6}_do_calc_md5_hash().")
Signed-off-by: Christoph Paasch <cpaasch@apple.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/tcp_ipv4.c | 2 +-
 net/ipv6/tcp_ipv6.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -809,7 +809,7 @@ static void tcp_v4_reqsk_send_ack(struct
 			tcp_time_stamp,
 			req->ts_recent,
 			0,
-			tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->daddr,
+			tcp_md5_do_lookup(sk, (union tcp_md5_addr *)&ip_hdr(skb)->saddr,
 					  AF_INET),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos);
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -941,7 +941,7 @@ static void tcp_v6_reqsk_send_ack(struct
 			tcp_rsk(req)->snt_isn + 1 : tcp_sk(sk)->snd_nxt,
 			tcp_rsk(req)->rcv_nxt,
 			req->rcv_wnd, tcp_time_stamp, req->ts_recent, sk->sk_bound_dev_if,
-			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->daddr),
+			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr),
 			0, 0);
 }
 
