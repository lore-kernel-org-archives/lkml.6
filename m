Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1351814-1522346670-2-11664514900750816076
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522346669; b=VKRmX2EyL40PjPtm6Yvk3QhYR3+Zkbv2CEEhFanWuqNAxWueX3
    agEte+RDYqknWz9iSq7naAqLMZSpjZ2eyJIqdqU9ffuSx1RgI2HUjSHG63qyFkWa
    bIw4NBamTfYGWLxwHZ4Zly/doTmimffBgfXSnb/aMwwW2n1YbhSj6DvOmlsSRY4t
    SugBggYn1ZunBubGsCMmxpvojeFC+ev25MF1KcZUeW4rheXM0vfJUIJRfGHAixCu
    7yzMSbZlKbdPLAovAYRWjzZCX/p00BTcXZc8izV8tVP5ldQSJtBrIU92wdLVF6q/
    V931zNczWfbP58cTRS2Wq7mvvruXC4MecMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1522346669; bh=Z36qr/6kvh5hSDz4EHvb1OP1BwmcRz
    zJP0FJ+bU7+40=; b=vDNP/y86UPtfS9VkxE67Qka0JQt0cPOHcUnzVOZNhVii++
    2SmC1hPRtglHqGd8jQrd7GnjFLzi1nexcfagS9vvUPyLzK3c0Y+yMCsieItwc3Er
    ICJtsnpYx04IyUkuS9JCeUPfNYU5wD00MTJYo42/j4ZclcM6Ej/TLHd3fWKtUufK
    sz4OTcAVr5uBCpi0rkatEaTgzWSMCoxf8ZoePyLWAahS01l508tdRjgPg/29sHjH
    ylrQwZSM2cuIeY4aPMtPKMU1n4YS8byAgWb6AV1lFVNOj38MtCWoiSpN7eoyqxEC
    DrFdPm0C8Moo1hc8jz17lj7Iq8bDG7cWcqHGs3Rw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfCLYGiOZbqV22UXr6ms1Dk7vVJw4rbN1S+mOsRBtmuXnxWLtj5q+RF3IzNnY6OeQ7GzFLJSIfFOQ//a3CjX+RlX//ft/53vLwwvjeCJyYiICfbj3Ds
    LV50xveDM5rs+kczjkNrk7Bv2IHN28OphBm3AFZDXVJr/TmXplkPU6M7MU9s3Fofdl2uWFCYn/ws2u0oN7MAsn5IIuhLH4xSvRaps5jIuQe0IAdvY1Wqk/iy
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=jKjxfLc-AAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=hjTGy2TR-yuV7bmPjl8A:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeC2SEZ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 14:04:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58780 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753146AbeC2SEY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 14:04:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, xu heng <xuheng333@zoho.com>,
        Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 15/43] ppp: avoid loop in xmit recursion detection code
Date: Thu, 29 Mar 2018 20:00:10 +0200
Message-Id: <20180329175731.656227777@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit 6d066734e9f09cdea4a3b9cb76136db3f29cfb02 ]

We already detect situations where a PPP channel sends packets back to
its upper PPP device. While this is enough to avoid deadlocking on xmit
locks, this doesn't prevent packets from looping between the channel
and the unit.

The problem is that ppp_start_xmit() enqueues packets in ppp->file.xq
before checking for xmit recursion. Therefore, __ppp_xmit_process()
might dequeue a packet from ppp->file.xq and send it on the channel
which, in turn, loops it back on the unit. Then ppp_start_xmit()
queues the packet back to ppp->file.xq and __ppp_xmit_process() picks
it up and sends it again through the channel. Therefore, the packet
will loop between __ppp_xmit_process() and ppp_start_xmit() until some
other part of the xmit path drops it.

For L2TP, we rapidly fill the skb's headroom and pppol2tp_xmit() drops
the packet after a few iterations. But PPTP reallocates the headroom
if necessary, letting the loop run and exhaust the machine resources
(as reported in https://bugzilla.kernel.org/show_bug.cgi?id=199109).

Fix this by letting __ppp_xmit_process() enqueue the skb to
ppp->file.xq, so that we can check for recursion before adding it to
the queue. Now ppp_xmit_process() can drop the packet when recursion is
detected.

__ppp_channel_push() is a bit special. It calls __ppp_xmit_process()
without having any actual packet to send. This is used by
ppp_output_wakeup() to re-enable transmission on the parent unit (for
implementations like ppp_async.c, where the .start_xmit() function
might not consume the skb, leaving it in ppp->xmit_pending and
disabling transmission).
Therefore, __ppp_xmit_process() needs to handle the case where skb is
NULL, dequeuing as many packets as possible from ppp->file.xq.

Reported-by: xu heng <xuheng333@zoho.com>
Fixes: 55454a565836 ("ppp: avoid dealock on recursive xmit")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ppp/ppp_generic.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -256,7 +256,7 @@ struct ppp_net {
 /* Prototypes. */
 static int ppp_unattached_ioctl(struct net *net, struct ppp_file *pf,
 			struct file *file, unsigned int cmd, unsigned long arg);
-static void ppp_xmit_process(struct ppp *ppp);
+static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb);
 static void ppp_send_frame(struct ppp *ppp, struct sk_buff *skb);
 static void ppp_push(struct ppp *ppp);
 static void ppp_channel_push(struct channel *pch);
@@ -512,13 +512,12 @@ static ssize_t ppp_write(struct file *fi
 		goto out;
 	}
 
-	skb_queue_tail(&pf->xq, skb);
-
 	switch (pf->kind) {
 	case INTERFACE:
-		ppp_xmit_process(PF_TO_PPP(pf));
+		ppp_xmit_process(PF_TO_PPP(pf), skb);
 		break;
 	case CHANNEL:
+		skb_queue_tail(&pf->xq, skb);
 		ppp_channel_push(PF_TO_CHANNEL(pf));
 		break;
 	}
@@ -1264,8 +1263,8 @@ ppp_start_xmit(struct sk_buff *skb, stru
 	put_unaligned_be16(proto, pp);
 
 	skb_scrub_packet(skb, !net_eq(ppp->ppp_net, dev_net(dev)));
-	skb_queue_tail(&ppp->file.xq, skb);
-	ppp_xmit_process(ppp);
+	ppp_xmit_process(ppp, skb);
+
 	return NETDEV_TX_OK;
 
  outf:
@@ -1417,13 +1416,14 @@ static void ppp_setup(struct net_device
  */
 
 /* Called to do any work queued up on the transmit side that can now be done */
-static void __ppp_xmit_process(struct ppp *ppp)
+static void __ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
-	struct sk_buff *skb;
-
 	ppp_xmit_lock(ppp);
 	if (!ppp->closing) {
 		ppp_push(ppp);
+
+		if (skb)
+			skb_queue_tail(&ppp->file.xq, skb);
 		while (!ppp->xmit_pending &&
 		       (skb = skb_dequeue(&ppp->file.xq)))
 			ppp_send_frame(ppp, skb);
@@ -1437,7 +1437,7 @@ static void __ppp_xmit_process(struct pp
 	ppp_xmit_unlock(ppp);
 }
 
-static void ppp_xmit_process(struct ppp *ppp)
+static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
 	local_bh_disable();
 
@@ -1445,7 +1445,7 @@ static void ppp_xmit_process(struct ppp
 		goto err;
 
 	(*this_cpu_ptr(ppp->xmit_recursion))++;
-	__ppp_xmit_process(ppp);
+	__ppp_xmit_process(ppp, skb);
 	(*this_cpu_ptr(ppp->xmit_recursion))--;
 
 	local_bh_enable();
@@ -1455,6 +1455,8 @@ static void ppp_xmit_process(struct ppp
 err:
 	local_bh_enable();
 
+	kfree_skb(skb);
+
 	if (net_ratelimit())
 		netdev_err(ppp->dev, "recursion detected\n");
 }
@@ -1939,7 +1941,7 @@ static void __ppp_channel_push(struct ch
 	if (skb_queue_empty(&pch->file.xq)) {
 		ppp = pch->ppp;
 		if (ppp)
-			__ppp_xmit_process(ppp);
+			__ppp_xmit_process(ppp, NULL);
 	}
 }
 
