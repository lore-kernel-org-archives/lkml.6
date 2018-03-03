Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122499-2-664358273011979714
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122499; b=ttw8oy6py91zj3ORf2GnK6MKAuKnhrCxbQt4ilUQtFklV+D
    94PF+DBK9aZSPjDBtU+qAk56u+O0BzqncFWBwZlKRPTlA/6TXCT+oTDaPDkWcf6y
    V2uSxzR1PusfcySZYt4mGMs4n+CL7fDwqiAZXkSLt4oTwMf454UDRDe21fOuCrqi
    +97UMuANs64Uwq/Qsoi05rjQmf1YfOWzI+GkMpS3+dqxIWG7qAgDfFTlCh3x6rLu
    Aapehhpeg56caZxHHTAneWnNyhO6GC+YqWaroUwZcLmygsi4ouz5U73RxE0ie2pV
    1zc5duT/QVXs7TFfBqC46IW5F10x8qi5CPR7nnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122499; bh=hFLykV
    dUwrHvjmMuCFsIUqB4s2C8gdiopNmddwSEMsg=; b=sFbchp6C3YdFMSO6o4hUSF
    ey6I8axrESKs9uaxaOqU26FUaJMoom51GQj6KYXQpbnmjQUnzUbxcpeG3lGfxc1Z
    8fxTU24mRLCGKwEEHe+J8KhaH4yMjJ3S8Ba8YIC0SZ8IZrWnuhlU3uxWYGa3cel4
    FMgzGe37QB2PN6FOsbX6LRgMLyV5KiHQnkHe5bpoucAUE4WSFBrAUkMGii6dveCM
    QdBxxxxBuqqaWw+C45beZ24iXoGFZjmhZ3aho0uEkZDVleZ/bfnwI3EG1X12qFbQ
    RsCQzOZOTQvWty+areMDWWpuGpwGbT4F8AGVpGtRBnYSA8Ha7sRtFFSoeW9l5fqQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NWEwY+Ig x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NWEwY+Ig x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933549AbeCDAOO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:14:14 -0500
Received: from mail-sn1nam01on0112.outbound.protection.outlook.com ([104.47.32.112]:31677
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932989AbeCCWaq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 66/84] net: sched: drop qdisc_reset from
 dev_graft_qdisc
Thread-Topic: [PATCH AUTOSEL for 4.14 66/84] net: sched: drop qdisc_reset from
 dev_graft_qdisc
Thread-Index: AQHTsz6yud1o77Dc0Eu3/y6mwDhO2w==
Date: Sat, 3 Mar 2018 22:26:38 +0000
Message-ID: <20180303222518.26271-66-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:OYVKL1l1PFXBXIxRUm8BifPdEulrA4IciV6PkmAokp0pTAc3nWBVIgSQuQOWrBXg/n/54kAuiLiyukrqCu3v1FsN4yGpt6PFaOMTomlCXEIjxv6BfkpjLQQ7w7aw/mMZccF7UaPZR/CrPCz4dx0iW1JmOziygS7jo++bMEBQymAI7uWpReVsPoW3+I4JMPS/L3/rqLyiJaAZC37gAKuJteRC6NSFPENLfrzJaeG6WdJ3UJH06al+ppZ8OluhJTERuN+S7T7wrpalmNHGW6B3FxXvpjaf2tzpJK5+PThns2759t0cqkZAFrP7NPMMbwpGBS6GtavLCbLsqpdxXqSqGleC/ennj/2A3wJIxAthfWmyMejJk75LpNpsuBjWvemI;5:AyXKlonDBDdDS/t3OQHQ5KqkZkCYDebZWo9upzcSMr1GQWOP0iRshl7BHj4bpmlY9IKrGMGUcyoYBbyR+KIdF1G1zbTz8KUezFr8TwNJs27jJkAU1USvZ1TRz/lHvRYTcTatEPzcvujiTcwj5LsQw7e5DqXH3UkksFDzozskpts=;24:LR3PElgk86om8zC8AOI8uBaL3qVl/q11jnUD1ccOC/IqMPpiwi3KMMthhRdG2JA1m1mQwuy00kXCBQLb6atQMlr1CpREIAxPxTsUULAmUXI=;7:REMeH7NeCbQwR/EEgY3x+fLz0QDo1YVZzvZabsI7Ax66X8fsN9NNfTIdzZoH3hGj4S0KZTBr2dxXSEf1qwh3OqeQYCKqFYSJEKsyOFtGYLprx5co5cXoWq6lt71AFS9o4gVfyBZNrze3tJJKQVFxRTogJ6zSpM/wsjp9OQDr6nMsklnJiHk/+UxwrD9IKe0fwKXhsuh6oUU0vqzdGzfq6RsActRTHmHkcvFHMXroKbt5yJrldX/Xs2fq1Wk1ZgA5
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 094590eb-1e44-4c24-20b5-08d58156672e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB097044938B7F52954B425143FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(5890100001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: P3J8OovyiAMw5m+gq/LdpOKHlBY5qFhOIm7DkAdcn21C2ynNxBV/1l/F/0+2Y5K9vNzyoNxyADLWe3ur2M9UVJy+9vrsYoFxVT+OC+96/BoCeY0InvdOJLPuMrQ/JoT+M79E024dGEx79GvMT/KBBzkwBdWNlIhfuN+x+gwkCKA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094590eb-1e44-4c24-20b5-08d58156672e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:38.8380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 net/sched/sch_generic.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index bf8c81e07c70..79549baf5804 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -743,10 +743,6 @@ struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev=
_queue,
 	root_lock =3D qdisc_lock(oqdisc);
 	spin_lock_bh(root_lock);
=20
-	/* Prune old scheduler */
-	if (oqdisc && refcount_read(&oqdisc->refcnt) <=3D 1)
-		qdisc_reset(oqdisc);
-
 	/* ... and graft new one */
 	if (qdisc =3D=3D NULL)
 		qdisc =3D &noop_qdisc;
@@ -897,6 +893,16 @@ static bool some_qdisc_is_busy(struct net_device *dev)
 	return false;
 }
=20
+static void dev_qdisc_reset(struct net_device *dev,
+			    struct netdev_queue *dev_queue,
+			    void *none)
+{
+	struct Qdisc *qdisc =3D dev_queue->qdisc_sleeping;
+
+	if (qdisc)
+		qdisc_reset(qdisc);
+}
+
 /**
  * 	dev_deactivate_many - deactivate transmissions on several devices
  * 	@head: list of devices to deactivate
@@ -907,7 +913,6 @@ static bool some_qdisc_is_busy(struct net_device *dev)
 void dev_deactivate_many(struct list_head *head)
 {
 	struct net_device *dev;
-	bool sync_needed =3D false;
=20
 	list_for_each_entry(dev, head, close_list) {
 		netdev_for_each_tx_queue(dev, dev_deactivate_queue,
@@ -917,20 +922,25 @@ void dev_deactivate_many(struct list_head *head)
 					     &noop_qdisc);
=20
 		dev_watchdog_down(dev);
-		sync_needed |=3D !dev->dismantle;
 	}
=20
 	/* Wait for outstanding qdisc-less dev_queue_xmit calls.
 	 * This is avoided if all devices are in dismantle phase :
 	 * Caller will call synchronize_net() for us
 	 */
-	if (sync_needed)
-		synchronize_net();
+	synchronize_net();
=20
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
=20
 void dev_deactivate(struct net_device *dev)
--=20
2.14.1
