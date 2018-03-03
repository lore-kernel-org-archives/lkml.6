Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123677-2-2564684730112698825
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
    t=1520123677; b=e4ZkETbMlqXqG6Z+HghF2XTR7js2lBrS+0ImdfI6Zg/QZAL
    yIyQmx0KYWoMD71Eq+5XR9oJPYeCCwDFbqaOyZ53CYJHetkxdbXEchRhMO1hIL08
    w6ClLzB2lBRFWljr87KAAt/8nOmEs6ZyQ64ZdXv61MBHafr/n0leVrMm3eDWWAH1
    ehVP4S2EkV0WVKkahZJWSb0NoKwy42GmmH64Qk0a+Hcmtxu2vQ8cotSybL1AWLqT
    dHIVGOegGT5mnbdjMaVCsnabV6Ld87C/PGDhtTDDffradLP21JeOYs+BDu/gMLXi
    v89RsBYPvK1aHPWrVxm7ifVYgrQqSXRjddUo2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123677; bh=H+nNnz
    qFNl2CdMD+A4D6rAwhpkdfVY/oxNpKq1ouwko=; b=ewqyE3Dd/Y3vmLaSWGk6yE
    e1n6kzFCRN5NiwJPwEy9KYN4l3iTQNUq69PpATSwL1oAJBQNm6HVAzljX13hPU1I
    euHQBHNB7GHwV9kxTkXK6Ui1ke5W4HnhrS9LhFLfHgIi83Q9pHdlfGfLq3zSoxj9
    sshPDy7J+g/lYl0cEXQnvzrshKWvnKs7yrq+3Tq9yAJxjAyW+5UbYWWUhayLiFHD
    u7U1M62reGdvBh6OwJ7htl7CBzPIX0ZPihpPhjPG9KSd7sGFhJabOV6pOgUILB3C
    5In4lEpaHO8wZf2ok5FyVdqAN7pBQLxRANBFsFN65okICtw+L6dFZBB/tKif0ZPA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xx93J4E1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Xx93J4E1 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbeCDAeQ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:34:16 -0500
Received: from mail-sn1nam01on0105.outbound.protection.outlook.com ([104.47.32.105]:19488
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932921AbeCCW1P (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:15 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 084/102] net: sched: drop qdisc_reset from
 dev_graft_qdisc
Thread-Topic: [PATCH AUTOSEL for 4.15 084/102] net: sched: drop qdisc_reset
 from dev_graft_qdisc
Thread-Index: AQHTsz52uzct8OMpGkKexZ3wqPdqrg==
Date: Sat, 3 Mar 2018 22:24:58 +0000
Message-ID: <20180303222318.26006-84-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;6:FDaIzqvc1Cbgs5c/MUJ3zi6CODpcKKGPuj6sRh+oCGmUnEL6e2W8cmoHeyWUdedflZFCzUxXZ8PUmsKtgHJlXUdwBmddHYdF4IRg7vqWeL5cQEWEIT2vxFgWqBNRI5P4tz/iyD48w86ldst99a+AtYmv7ynpjxygPOkOs4p+7uZJIYfyqbU360d6+aekCIJ/5jSHskyxmNBoEfM/SN7+4K/+stOay6eojxjdMIYngK2hXtn5E9X335G6gTNzSbb1p91ccj8gOFV7uTWox8q6lS4/RjhofodzLyjBhjsE1rLGUSgEMnDLWSRUYnRq5ywTMiiODfub9xhgtNKRmZpb/mCbXPK7uSXhN9LDckCsYpmGmCEUtLTWbLcVTiN6UDo1;5:rgfNLjdZbghR3bQo+F4y+ZvhoB2fph+HSVYQOdNv4F4B9KziNXlA2OHGC6yNrlR/ZGbXN6zGsPO9ouAolttzaCAx0jqh/Q+abqx5lMMFtHD6rYnaB63f5oEE5dG4fM65JPIaZjucATMf1CScEMkbNEphceHI0cHFto48Fsj94Ao=;24:WLTZuEqyy3OpDZYyh3uOFsFQZUH3b6lJ1UZDyGLk4tzH40kXj888SJCKe4Bq40UuKtEjKBH2S8RQnZ/QDreiFjSy5XEBWwbimbUnl0+6g14=;7:ntg2PZOYbT7Fp9y4rued55PxioqKm4GapIUnwmK6Xr90ZZ3tvTV0inJ8d85mCaGwPyW3vn9cfpyvdRrVK7G9R97MW6Fr5wLDgsXphWUgSlEfMAYGycFOvnV43fMKHK5SvBD3Fb1YUtRz6Qg6CIJqJluCzIyW5N4Kvyt85oFdZR5x3lHlyQdwX56WPIdH1abaNmCjOJAaiMWrAAG0MFDei3/S5KRXkoKgQjtV7MIaJg2swaJ5gouCqdbNj+IakXij
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46f09b9c-d913-4fb9-4414-08d58155e965
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970D0E4911B4923CEAD53E6FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(6666003)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(5890100001)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: oytBnsRRzo1LfXVBYoonjMlvmvyPhxa9GX/zBuKMuYKQjpiY6+9vMKp9K29Wz+KVnDpeedOL/D6sYVxPQ4QT+KdLTKKU4y16wPFKotd8XEx/sVRkyRdo8NT5l6cv4ksJI/sG/fhb5e+cll1VQSn7uv9dA1ZVUTf/CgtE335bvqI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f09b9c-d913-4fb9-4414-08d58155e965
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:58.5566
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
index cac003fddf3e..b8db13708370 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -762,10 +762,6 @@ struct Qdisc *dev_graft_qdisc(struct netdev_queue *dev=
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
@@ -916,6 +912,16 @@ static bool some_qdisc_is_busy(struct net_device *dev)
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
@@ -926,7 +932,6 @@ static bool some_qdisc_is_busy(struct net_device *dev)
 void dev_deactivate_many(struct list_head *head)
 {
 	struct net_device *dev;
-	bool sync_needed =3D false;
=20
 	list_for_each_entry(dev, head, close_list) {
 		netdev_for_each_tx_queue(dev, dev_deactivate_queue,
@@ -936,20 +941,25 @@ void dev_deactivate_many(struct list_head *head)
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
