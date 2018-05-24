Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527155052-2-2956483988586831910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES ensk.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155052; b=iSp+yoR1XaAerZexlYEjBQ1HyImKt2TJRKdSrrTw7f8egASFpK
    g5wVbkDSoPV9MgMMI6Sz4MUt+wpitAGqJhCSPturPOuccMR0An52kXFGpsghmXdQ
    hin2exG9fVyIAfMJFzkP0wHVm3ko9X55vr8GKAEKVt04yHql0NqwPE6ndPWtwZo1
    Oo/HcsMesvniybVw9mv324focw7vmEV9RIsOUE/O7DPdimAL0QQF+JKOe3HtvZ44
    5+9y3xzVaheOr5FMAlGn0YSp6mT9ob6qxgcfWQA0vuzsTKgcJZ92QIVL/F8EsaTI
    Y6mGHlRfeqUKqNC3niuposD1GBORFD0wR0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155052; bh=Ly6M3u/f2mrsij875mBGM9NxRCreik
    fUQaEpdYBPvgk=; b=eDUqSQyWVCbRtV0QPhfV+TQrti1r8Jo9DrMB2i7Np4ol/C
    OO0+9Vz6Vijc5B5P7Y2W7z6hsZFhimRDVHbrP1mMELmvKBXl9af+QArrHltPEc7A
    Y7YjP6hzDzZiWuzPah+CWAtolep4fkU69jwDGOHca+R0WlDgt1c6YTvw8RGf5F8X
    /xFsOBluX6ih4hDbh3m/kzftkf/6YYkjzxBvlAxvDYde0nMEeGV+MdRRQQrqXHwF
    wYDvd5pElKtgI3q5Zgi7hVEvASCq8iAYh89Z7zxW5jtYPChjV+NE1lOA/ipB7p8z
    CrXrW7PbFBlNthQJKjKd2pjVbsRZ1QoioknXhkEQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=UlSXrFng x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=UlSXrFng x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAVtsvJgAAmQTkGfCFrbkZWFMOZlI6asBTnZbo83sFzODM029GrZV2d+VDnBtzoZ7oUiIYpXlQ39C6PS++tqjL7Xjomt00ndMr1JWLV3Qy/ZeX+ZyfTL
    C3mkhx4xir7LGFNnOHATDr/xCIW4Etmf+uPlBq8hBv+lMlKMALdXCOLhSfk+ozYDycyp5eI0Xxtb9z9HFroY9HVzO3pnT8I5wO4Pl+HbUaO6sWhuLhL3IIml
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=2jGULyhPSjjowrF_JfMA:9
    a=VhoEJJMoeQ9qKMuQ:21 a=79x0wBomllWRMlcT:21 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966574AbeEXJoK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966584AbeEXJoH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 08/92] net_sched: fq: take care of throttled flows before reuse
Date: Thu, 24 May 2018 11:37:45 +0200
Message-Id: <20180524093200.019659107@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 7df40c2673a1307c3260aab6f9d4b9bf97ca8fd7 ]

Normally, a socket can not be freed/reused unless all its TX packets
left qdisc and were TX-completed. However connect(AF_UNSPEC) allows
this to happen.

With commit fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for
reused flows") we cleared f->time_next_packet but took no special
action if the flow was still in the throttled rb-tree.

Since f->time_next_packet is the key used in the rb-tree searches,
blindly clearing it might break rb-tree integrity. We need to make
sure the flow is no longer in the rb-tree to avoid this problem.

Fixes: fc59d5bdf1e3 ("pkt_sched: fq: clear time_next_packet for reused flows")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_fq.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -126,6 +126,28 @@ static bool fq_flow_is_detached(const st
 	return f->next == &detached;
 }
 
+static bool fq_flow_is_throttled(const struct fq_flow *f)
+{
+	return f->next == &throttled;
+}
+
+static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
+{
+	if (head->first)
+		head->last->next = flow;
+	else
+		head->first = flow;
+	head->last = flow;
+	flow->next = NULL;
+}
+
+static void fq_flow_unset_throttled(struct fq_sched_data *q, struct fq_flow *f)
+{
+	rb_erase(&f->rate_node, &q->delayed);
+	q->throttled_flows--;
+	fq_flow_add_tail(&q->old_flows, f);
+}
+
 static void fq_flow_set_throttled(struct fq_sched_data *q, struct fq_flow *f)
 {
 	struct rb_node **p = &q->delayed.rb_node, *parent = NULL;
@@ -153,15 +175,6 @@ static void fq_flow_set_throttled(struct
 
 static struct kmem_cache *fq_flow_cachep __read_mostly;
 
-static void fq_flow_add_tail(struct fq_flow_head *head, struct fq_flow *flow)
-{
-	if (head->first)
-		head->last->next = flow;
-	else
-		head->first = flow;
-	head->last = flow;
-	flow->next = NULL;
-}
 
 /* limit number of collected flows per round */
 #define FQ_GC_MAX 8
@@ -265,6 +278,8 @@ static struct fq_flow *fq_classify(struc
 				     f->socket_hash != sk->sk_hash)) {
 				f->credit = q->initial_quantum;
 				f->socket_hash = sk->sk_hash;
+				if (fq_flow_is_throttled(f))
+					fq_flow_unset_throttled(q, f);
 				f->time_next_packet = 0ULL;
 			}
 			return f;
@@ -419,9 +434,7 @@ static void fq_check_throttled(struct fq
 			q->time_next_delayed_flow = f->time_next_packet;
 			break;
 		}
-		rb_erase(p, &q->delayed);
-		q->throttled_flows--;
-		fq_flow_add_tail(&q->old_flows, f);
+		fq_flow_unset_throttled(q, f);
 	}
 }
 
