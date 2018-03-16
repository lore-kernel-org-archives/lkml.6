Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3366930-1521215571-2-6129190673391420017
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
    t=1521215570; b=T8t1pwkuV0MDsWw3pr+npY4/G9PnAjIJlFnQGBIMaNoRpEx
    1sQSrxscSOTIK4DkPzl5yLPX+CfD1xOOpkOe0NqJIuHQzGT3QzmJVdlgEuq/Kx4b
    UgaBoMPYH4EHO6c2iL0E8nXOeKl6TPhESmNmqgqwYwmni4z6anPbROjhGskKaz08
    6Ch8wijd4fn5uC1K2rP7x2u+nWaExfZfd7gx27d1vg+ictqzcx6HrCZ02fj6nHTv
    tTadAWif6cG/PB7teJLW9sKgeCb6wSp0W2E5JlVGqtV5ldc3Vj1bEWmh28B29XVC
    IZ4y+U44D1WicalXaprtMHxR5WEKOcWH2fTkkWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521215570; bh=L9Hv6b8n9f6uHoOfm88dD2vUtO
    lFOrtDnWEqbG72cig=; b=nXwyTn2+JczFNXLOzW40M0AetteM/Fd6M/1MCTrYy4
    pTLbLpQseGuu7eGrBPYypCXUjr+Bx5hG/vuzn9CPCbY/JMybO8lFpiXFPqdctQgt
    3npQnNLp7cJ3Zs0fMfQVa7+yk41BFcudn8+FgIuJvxHslx0a/uTp3s1EEaZ7Spi9
    jptluvxATLVeD1uXYsByxklrsKylZJ3gGlftB/MJ+HIeZhLInXD9pfA5XBNe0S/x
    ArYB6D1kJ+JI8J9WgJkLq1ODsksNOODLWS8ne5PkoKJEsm/ONKCXfjodzg0DE+TO
    WdNr8wt4cxt3fcvEx5yLCAgCNHO2AvTcYp+jvMR+ONpg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965389AbeCPPoR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:44:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45864 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965372AbeCPPoL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:44:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 109/128] net: sched: drop qdisc_reset from dev_graft_qdisc
Date: Fri, 16 Mar 2018 16:24:10 +0100
Message-Id: <20180316152341.971330169@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>


[ Upstream commit 7bbde83b1860c28a1cc35516352c4e7e5172c29a ]

In qdisc_graft_qdisc a "new" qdisc is attached and the 'qdisc_destroy'
operation is called on the old qdisc. The destroy operation will wait
a rcu grace period and call qdisc_rcu_free(). At which point
gso_cpu_skb is free'd along with all stats so no need to zero stats
and gso_cpu_skb from the graft operation itself.

Further after dropping the qdisc locks we can not continue to call
qdisc_reset before waiting an rcu grace period so that the qdisc is
detached from all cpus. By removing the qdisc_reset() here we get
the correct property of waiting an rcu grace period and letting the
qdisc_destroy operation clean up the qdisc correctly.

Note, a refcnt greater than 1 would cause the destroy operation to
be aborted however if this ever happened the reference to the qdisc
would be lost and we would have a memory leak.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_generic.c |   28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -762,10 +762,6 @@ struct Qdisc *dev_graft_qdisc(struct net
 	root_lock = qdisc_lock(oqdisc);
 	spin_lock_bh(root_lock);
 
-	/* Prune old scheduler */
-	if (oqdisc && refcount_read(&oqdisc->refcnt) <= 1)
-		qdisc_reset(oqdisc);
-
 	/* ... and graft new one */
 	if (qdisc == NULL)
 		qdisc = &noop_qdisc;
@@ -916,6 +912,16 @@ static bool some_qdisc_is_busy(struct ne
 	return false;
 }
 
+static void dev_qdisc_reset(struct net_device *dev,
+			    struct netdev_queue *dev_queue,
+			    void *none)
+{
+	struct Qdisc *qdisc = dev_queue->qdisc_sleeping;
+
+	if (qdisc)
+		qdisc_reset(qdisc);
+}
+
 /**
  * 	dev_deactivate_many - deactivate transmissions on several devices
  * 	@head: list of devices to deactivate
@@ -926,7 +932,6 @@ static bool some_qdisc_is_busy(struct ne
 void dev_deactivate_many(struct list_head *head)
 {
 	struct net_device *dev;
-	bool sync_needed = false;
 
 	list_for_each_entry(dev, head, close_list) {
 		netdev_for_each_tx_queue(dev, dev_deactivate_queue,
@@ -936,20 +941,25 @@ void dev_deactivate_many(struct list_hea
 					     &noop_qdisc);
 
 		dev_watchdog_down(dev);
-		sync_needed |= !dev->dismantle;
 	}
 
 	/* Wait for outstanding qdisc-less dev_queue_xmit calls.
 	 * This is avoided if all devices are in dismantle phase :
 	 * Caller will call synchronize_net() for us
 	 */
-	if (sync_needed)
-		synchronize_net();
+	synchronize_net();
 
 	/* Wait for outstanding qdisc_run calls. */
-	list_for_each_entry(dev, head, close_list)
+	list_for_each_entry(dev, head, close_list) {
 		while (some_qdisc_is_busy(dev))
 			yield();
+		/* The new qdisc is assigned at this point so we can safely
+		 * unwind stale skb lists and qdisc statistics
+		 */
+		netdev_for_each_tx_queue(dev, dev_qdisc_reset, NULL);
+		if (dev_ingress_queue(dev))
+			dev_qdisc_reset(dev, dev_ingress_queue(dev), NULL);
+	}
 }
 
 void dev_deactivate(struct net_device *dev)
