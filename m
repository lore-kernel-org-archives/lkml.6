Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3606188-1521489192-2-16706912722792335727
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
    t=1521489191; b=Hd47fZVeZISu9conrTJyC2+vNBFjYbBLt3h6gh2k/x4057b
    Ow4xgmks7UwRGpm74cfIyVEWxVgkBdKfI+3I49hFhxZcJY/pYqv5y3z25/rcVg6H
    lMsZsYJSANgPnPslXemOvk9Pzc3dicVRrDnQGgou7ncey8aXiUHgaa8Z/Mcwba/+
    JhQAOB9GYxVCk5ZBoFcnGC2PyexqcIyU4sc/IoVJ10L8+Po/zQndOrN88oh+Vewl
    dulAFjbOXBH9MPHa63FQDDCM32DDW6RMRGs/b4UeQqTvR5Lh4n4PERoKF2mcEMxj
    YgcmanUM1yHvrZG1P0R7qCMDwHOPVeL3kri1aUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521489191; bh=/cIIyhtrykWkIRme3uAF1aQ/RP
    zBf/ax6kATjXbmS5w=; b=A6TtOp1JRNO3aOwk2Zeyj5cGzfwmuh5Wtu6b6opTgE
    CbwzasdVJlJv20cPaR361h+2T8EB1GRT4TNpgstn1KgIRJs4oDCE2W7sayubOel4
    Z0IJFEiYIU4eFIUc87L/mXaOdA5Bdz8d36djxjvj5tf/6Z1xOP/a7yWQMvC/bOvI
    DOMvrFaXU/bwUHPt8EYL0t9AqujV7YVLs495asp9BnZzbJEamPs6Dim4QKipNf7Z
    fsW6tVRPEzz1XeJtfx+1LyOn79U2RJWSPLPVvjRdp3Afwn3uwkbT1EsRCWwHdKll
    G+DDnhcISttmmRSob2rTZ5BdxBJDmgmQTwv1RwWA0u8g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinheplhhinhhugihfohhunhgurghtihhonhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehkeelheenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddufeduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinheplhhinhhugihfohhunhgurghtihhonhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeehkeelheenucevlhhushhtvghrufhiiigvpedv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969426AbeCSSTf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:19:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969371AbeCSSTa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:19:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nik Unger <njunger@uwaterloo.ca>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 038/241] netem: apply correct delay when rate throttling
Date: Mon, 19 Mar 2018 19:05:03 +0100
Message-Id: <20180319180752.782095032@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nik Unger <njunger@uwaterloo.ca>


[ Upstream commit 5080f39e8c72e01cf37e8359023e7018e2a4901e ]

I recently reported on the netem list that iperf network benchmarks
show unexpected results when a bandwidth throttling rate has been
configured for netem. Specifically:

1) The measured link bandwidth *increases* when a higher delay is added
2) The measured link bandwidth appears higher than the specified limit
3) The measured link bandwidth for the same very slow settings varies significantly across
  machines

The issue can be reproduced by using tc to configure netem with a
512kbit rate and various (none, 1us, 50ms, 100ms, 200ms) delays on a
veth pair between network namespaces, and then using iperf (or any
other network benchmarking tool) to test throughput. Complete detailed
instructions are in the original email chain here:
https://lists.linuxfoundation.org/pipermail/netem/2017-February/001672.html

There appear to be two underlying bugs causing these effects:

- The first issue causes long delays when the rate is slow and no
  delay is configured (e.g., "rate 512kbit"). This is because SKBs are
  not orphaned when no delay is configured, so orphaning does not
  occur until *after* the rate-induced delay has been applied. For
  this reason, adding a tiny delay (e.g., "rate 512kbit delay 1us")
  dramatically increases the measured bandwidth.

- The second issue is that rate-induced delays are not correctly
  applied, allowing SKB delays to occur in parallel. The indended
  approach is to compute the delay for an SKB and to add this delay to
  the end of the current queue. However, the code does not detect
  existing SKBs in the queue due to improperly testing sch->q.qlen,
  which is nonzero even when packets exist only in the
  rbtree. Consequently, new SKBs do not wait for the current queue to
  empty. When packet delays vary significantly (e.g., if packet sizes
  are different), then this also causes unintended reordering.

I modified the code to expect a delay (and orphan the SKB) when a rate
is configured. I also added some defensive tests that correctly find
the latest scheduled delivery time, even if it is (unexpectedly) for a
packet in sch->q. I have tested these changes on the latest kernel
(4.11.0-rc1+) and the iperf / ping test results are as expected.

Signed-off-by: Nik Unger <njunger@uwaterloo.ca>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_netem.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -462,7 +462,7 @@ static int netem_enqueue(struct sk_buff
 	/* If a delay is expected, orphan the skb. (orphaning usually takes
 	 * place at TX completion time, so _before_ the link transit delay)
 	 */
-	if (q->latency || q->jitter)
+	if (q->latency || q->jitter || q->rate)
 		skb_orphan_partial(skb);
 
 	/*
@@ -530,21 +530,31 @@ static int netem_enqueue(struct sk_buff
 		now = psched_get_time();
 
 		if (q->rate) {
-			struct sk_buff *last;
+			struct netem_skb_cb *last = NULL;
+
+			if (sch->q.tail)
+				last = netem_skb_cb(sch->q.tail);
+			if (q->t_root.rb_node) {
+				struct sk_buff *t_skb;
+				struct netem_skb_cb *t_last;
+
+				t_skb = netem_rb_to_skb(rb_last(&q->t_root));
+				t_last = netem_skb_cb(t_skb);
+				if (!last ||
+				    t_last->time_to_send > last->time_to_send) {
+					last = t_last;
+				}
+			}
 
-			if (sch->q.qlen)
-				last = sch->q.tail;
-			else
-				last = netem_rb_to_skb(rb_last(&q->t_root));
 			if (last) {
 				/*
 				 * Last packet in queue is reference point (now),
 				 * calculate this time bonus and subtract
 				 * from delay.
 				 */
-				delay -= netem_skb_cb(last)->time_to_send - now;
+				delay -= last->time_to_send - now;
 				delay = max_t(psched_tdiff_t, 0, delay);
-				now = netem_skb_cb(last)->time_to_send;
+				now = last->time_to_send;
 			}
 
 			delay += packet_len_2_sched_time(qdisc_pkt_len(skb), q);
