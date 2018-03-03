Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121702-2-9147219996361760289
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
    t=1520121701; b=ww0d7H0Ga2Qt4ZA5dGP6HDWW4vQEWaC8WLWvROj4hqKzMm/
    1ub71SRi1ZgpJfoO/6WPfbGEeNwYXrot0Rg4Pml2q2TdStGcFrbAJZde+DbHmDv1
    EvnlVX0kFv4buj+WJH3AMrNqtpEZrYGlCf/q+QTljc9k3hUoplOW2RwOY07gC+l4
    j2L+EKHGZ938BtSsbc9mmTRUp3YMDgigLEtQBNN6WLsjyzRK9v0gT3hOpRfmsvjB
    TN7/as+QvFpzCeNGWfXjsy81ZwJE3B5+ddDH/DtRIXxXt/7+5MAoquXlBlUYzqvC
    j2YzghKoWj3/B3C+C4P5k//80GMEkV89FfI8LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121701; bh=afBHyZ
    dRLhuxIVAElCJef1ULEDtzttveC2c40bXYvb8=; b=KSnts6ASqpcE7jk/PkyFW+
    wDlljXOOVFC09dZYVeU5Cs5aBbPwUMPvoBCX6ZkYwKAaNN/Q5vFO6TnXpU013OIP
    LDr7nYp5PIWA9rIqC+5NXHmedwMw9OCW7A+sIQhft4r8wrCXATsckN9BaCtEw60D
    jBTQUgHP/9YH0HPUbBfdjMwvgas/U9aj1iM9b/Am/ISa0X13ZvuOpcwwT4yHgvoD
    /lEitLLgJWQM/6Y0FN0bVFZj8efMIh3MZN1GnHC/J2qdfXKYo7FLch23t5XomZk9
    O1WSmfUnQjY3M9L/nKhmwwN1sMh3nBrpS+cvb+lndM+3KJcmCY12dcIxE2ztsNcQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C7XtpSyM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=C7XtpSyM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932084AbeCDABX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:01:23 -0500
Received: from mail-co1nam03on0109.outbound.protection.outlook.com ([104.47.40.109]:6764
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933209AbeCCWcE (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Nik Unger <njunger@uwaterloo.ca>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 040/219] netem: apply correct delay when rate
 throttling
Thread-Topic: [PATCH AUTOSEL for 4.9 040/219] netem: apply correct delay when
 rate throttling
Thread-Index: AQHTsz7uSkt6dlUfVkWu3BbZ80Utqg==
Date: Sat, 3 Mar 2018 22:28:18 +0000
Message-ID: <20180303222716.26640-40-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1083;7:uk5DclBlCJ1AyceLQcfTI25teXAGATF2XoLDWv8bjnRl71D4miyrafSc0wx+f7AhUpzc9grwUjr71PyG8WpFqxZedS5SSbvl0gu0ItkN85JRtn6LFEsgmodGG9tydJGb2th9K7yy+UOUOsMpej7Zcp+McqXfDzT4bF1oIF2UGALH6M3JofUINDXBSCyrif9t+vFuaBow5I0wrhHeW1gZFv/L+PLEDif8hSRIEWZpMgCEdxF0kVfRG0jAeaHvsYlk
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9e0ea0d2-14a0-4b48-a143-08d5815695a2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1083;
x-ms-traffictypediagnostic: MW2PR2101MB1083:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB108332E0CB1BEF7F2D8090FBFBC40@MW2PR2101MB1083.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(157189615257929);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1083;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1083;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(33974003)(31014005)(106356001)(53936002)(316002)(305945005)(7736002)(3280700002)(107886003)(2906002)(6512007)(6436002)(97736004)(3660700001)(6306002)(6486002)(99286004)(81166006)(8936002)(81156014)(76176011)(8676002)(25786009)(2950100002)(6506007)(4326008)(110136005)(5250100002)(54906003)(36756003)(575784001)(105586002)(6116002)(6666003)(22452003)(86612001)(10090500001)(186003)(68736007)(26005)(2900100001)(86362001)(66066001)(102836004)(3846002)(14454004)(478600001)(72206003)(10290500003)(5660300001)(59450400001)(1076002)(966005)(2501003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1083;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: qbBwIQxRkqy/ZDSVlcHkPqEflGCjmkIo3rt3Kk4SqIwui10ZCIZnRCv5Wqdcc+jJoTuW9Wm/Oy48qoufjOCfmLhSgbscbLtgl5i/kfidlIf+cTurX5gi6a/qOppvP4cbYkAc7MizEtPUVy6WBgz4K0DM4ok3CFX/+rPazDrS7IQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0ea0d2-14a0-4b48-a143-08d5815695a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:18.9787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1083
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Nik Unger <njunger@uwaterloo.ca>

[ Upstream commit 5080f39e8c72e01cf37e8359023e7018e2a4901e ]

I recently reported on the netem list that iperf network benchmarks
show unexpected results when a bandwidth throttling rate has been
configured for netem. Specifically:

1) The measured link bandwidth *increases* when a higher delay is added
2) The measured link bandwidth appears higher than the specified limit
3) The measured link bandwidth for the same very slow settings varies signi=
ficantly across
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
---
 net/sched/sch_netem.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 9f7b380cf0a3..c73d58872cf8 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -462,7 +462,7 @@ static int netem_enqueue(struct sk_buff *skb, struct Qd=
isc *sch,
 	/* If a delay is expected, orphan the skb. (orphaning usually takes
 	 * place at TX completion time, so _before_ the link transit delay)
 	 */
-	if (q->latency || q->jitter)
+	if (q->latency || q->jitter || q->rate)
 		skb_orphan_partial(skb);
=20
 	/*
@@ -530,21 +530,31 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
 		now =3D psched_get_time();
=20
 		if (q->rate) {
-			struct sk_buff *last;
+			struct netem_skb_cb *last =3D NULL;
+
+			if (sch->q.tail)
+				last =3D netem_skb_cb(sch->q.tail);
+			if (q->t_root.rb_node) {
+				struct sk_buff *t_skb;
+				struct netem_skb_cb *t_last;
+
+				t_skb =3D netem_rb_to_skb(rb_last(&q->t_root));
+				t_last =3D netem_skb_cb(t_skb);
+				if (!last ||
+				    t_last->time_to_send > last->time_to_send) {
+					last =3D t_last;
+				}
+			}
=20
-			if (sch->q.qlen)
-				last =3D sch->q.tail;
-			else
-				last =3D netem_rb_to_skb(rb_last(&q->t_root));
 			if (last) {
 				/*
 				 * Last packet in queue is reference point (now),
 				 * calculate this time bonus and subtract
 				 * from delay.
 				 */
-				delay -=3D netem_skb_cb(last)->time_to_send - now;
+				delay -=3D last->time_to_send - now;
 				delay =3D max_t(psched_tdiff_t, 0, delay);
-				now =3D netem_skb_cb(last)->time_to_send;
+				now =3D last->time_to_send;
 			}
=20
 			delay +=3D packet_len_2_sched_time(qdisc_pkt_len(skb), q);
--=20
2.14.1
