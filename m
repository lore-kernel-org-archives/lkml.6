Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521807474-2-1362928462432161478
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807474; b=L7ca5tU+/JohbaFOxGFlI1ylbdwBOijdbXHIS8KT+7rzv1g
    bZSKn73kpGHoUZmx+GmO3tDINeZeksLBzBuEk7pEfQ4DLjYbHUWjJkF63urZZVAE
    bDvYDnzHRxXYrAWoG/MlJxofPceelLE8lcZDNNlAdxpbBLuQy3lTjSy9xyUToWNM
    TUDY4pEpSFxUQMW13zkxygWdxFVIyUf/wPMeXiR33Hr/F99A2tCVS4EaZCiblhiG
    nuIxMAG0Ep+b210wjMNHnHp97ilJaV3wR2psUwZc+Xn5wC0dYcB9hne9GQy3Hle/
    PlWoCypds9UG5iGCdmLolruVqVfOIOwznss8zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807474; bh=N5YBEU3M7TsKb1Mo9w4iurxwPN
    e+aZgqOPYrIzcSpAI=; b=d6ZYJrR82lPpBh+ZHRdxarBCv/zJV5ffpc0dg1+NlW
    qygsgKy010QhLPQlBqdUkBViFO1CiutrLhHL0FHfsiCn4SJaaKNmgu7764OEHXEv
    i/1OG/kFIihgMD3h07zQ5BL4dFDQlyjcldI71WG2LyK1lgAg8LOcl+64g+FWFuyo
    F5wQQxpbxsw4QyNkHIq960HLChXqvc+49uAbkLuf2Bj3R9Ws+rOLQc7RkLvkT/CW
    HXgP3l5WWv8PUKUW3EGvz9Dk48fM+P+9QyevT9/JOMnwZ6Li2uRUb8GpkamaAAbd
    7F7BWUfO9MwGztBjEDuZr+HaR2AP9HUzR6HPiWj/wAAw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeCWJ4M (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:56:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbeCWJ4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Ibanez <sibanez@stanford.edu>,
        Neal Cardwell <ncardwell@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Nandita Dukkipati <nanditad@google.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 14/84] tcp: allow TLP in ECN CWR
Date: Fri, 23 Mar 2018 10:53:28 +0100
Message-Id: <20180323095414.070509290@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>


[ Upstream commit b4f70c3d4ec32a2ff4c62e1e2da0da5f55fe12bd ]

This patch enables tail loss probe in cwnd reduction (CWR) state
to detect potential losses. Prior to this patch, since the sender
uses PRR to determine the cwnd in CWR state, the combination of
CWR+PRR plus tcp_tso_should_defer() could cause unnecessary stalls
upon losses: PRR makes cwnd so gentle that tcp_tso_should_defer()
defers sending wait for more ACKs. The ACKs may not come due to
packet losses.

Disallowing TLP when there is unused cwnd had the primary effect
of disallowing TLP when there is TSO deferral, Nagle deferral,
or we hit the rwin limit. Because basically every application
write() or incoming ACK will cause us to run tcp_write_xmit()
to see if we can send more, and then if we sent something we call
tcp_schedule_loss_probe() to see if we should schedule a TLP. At
that point, there are a few common reasons why some cwnd budget
could still be unused:

(a) rwin limit
(b) nagle check
(c) TSO deferral
(d) TSQ

For (d), after the next packet tx completion the TSQ mechanism
will allow us to send more packets, so we don't really need a
TLP (in practice it shouldn't matter whether we schedule one
or not). But for (a), (b), (c) the sender won't send any more
packets until it gets another ACK. But if the whole flight was
lost, or all the ACKs were lost, then we won't get any more ACKs,
and ideally we should schedule and send a TLP to get more feedback.
In particular for a long time we have wanted some kind of timer for
TSO deferral, and at least this would give us some kind of timer

Reported-by: Steve Ibanez <sibanez@stanford.edu>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Reviewed-by: Nandita Dukkipati <nanditad@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_output.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -2440,15 +2440,12 @@ bool tcp_schedule_loss_probe(struct sock
 
 	early_retrans = sock_net(sk)->ipv4.sysctl_tcp_early_retrans;
 	/* Schedule a loss probe in 2*RTT for SACK capable connections
-	 * in Open state, that are either limited by cwnd or application.
+	 * not in loss recovery, that are either limited by cwnd or application.
 	 */
 	if ((early_retrans != 3 && early_retrans != 4) ||
 	    !tp->packets_out || !tcp_is_sack(tp) ||
-	    icsk->icsk_ca_state != TCP_CA_Open)
-		return false;
-
-	if ((tp->snd_cwnd > tcp_packets_in_flight(tp)) &&
-	     !tcp_write_queue_empty(sk))
+	    (icsk->icsk_ca_state != TCP_CA_Open &&
+	     icsk->icsk_ca_state != TCP_CA_CWR))
 		return false;
 
 	/* Probe timeout is 2*rtt. Add minimum RTO to account
