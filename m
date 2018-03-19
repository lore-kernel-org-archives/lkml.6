Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521481679-2-15948816511043192337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciica, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521481678; b=eNS+v1WHQCxR74bnTSX3TcVZBxllxJpV88wAJb4VIXumY7Z
    dxjiLh7i7tg5iTyxNhwyuDq7Nk5DwBe8g8BCUa2N6vxhyRzJFyXYkOfKoUmUnAJs
    dIxh8U0pNHSa0h8MOcxmRz9jU9Uvw44NTXIR2eDkhot/iYELEEiT9vAguO6GgRtC
    aFxiigFSy/kX8wyAo/KeoTz5B15szRnBT5F4Gxb4x7cK7oIpFO0ZJRZZ8zLlJLqh
    K8RwvnwpqjO2lmKBRAfVz8cE1zytXhXHygI7tnXNyiy1uRgovyVHBSYeVHO9Ke5n
    +M7pLsOW6gj4LHZbL0CzzzeQyCBBogUil1cbQ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521481678; bh=0rY6bn
    C5g8buRWIpL4qtTFAAniK9HS+/YXqD62X6ZvY=; b=litU6CBsGFzabvD0tkjpHy
    v3k7qByilz3vOLe25bXCK56OnRAlp+vm5TltnDLQd/fGBxzGH8BQLpqKjn0Oaafd
    UHHCiytzAEYUYP6ab5LMivKFNAGkMfOm5cM+aEBhFQqscKMgBNEgBQpvVRMUHyPi
    emodnohR/aNEgUal91qna+nmtWi6Dix8tYh9IXlxWGQFWrA4lDcX5xjIhRY7BYr6
    4GDKlCAE6xql+czLnFSsraW3cpEztkaGWjQWLBC28+MasF8tcNtm3KhXa0LA1P70
    SjmCxv+rIOOhxqsHpL+cLd/WdgvIOzwMKulc8KjabwUmI/VeYZ0s9LkgUV7JwcMQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eTjs18Pb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelkedukeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eTjs18Pb x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeelkedukeenucevlhhushhtvghrufhiiigvpeeffe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965768AbeCSRrz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:47:55 -0400
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:7948
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965345AbeCSQFJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:05:09 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Girish Moodalbail <girish.moodalbail@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 238/281] geneve: add missing rx stats
 accounting
Thread-Topic: [PATCH AUTOSEL for 4.9 238/281] geneve: add missing rx stats
 accounting
Thread-Index: AQHTv5uyhc0AzjRqw0mi7+caQvY9Uw==
Date: Mon, 19 Mar 2018 16:02:36 +0000
Message-ID: <20180319155742.13731-238-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:n5whJwIVEXQIgSdgn/6izB9c0TQ3F2f5BrQCPjC76WrUlsQ28s1/iaRMjMP1DlyiPQOdSvTXtIk3cgf6wiPbBI0xnTDphbDAw/TABjlHsyrF0JuPneL7ap44SASXM4jYvhSCIdc+VXUqEE0YrZpZCt8R5v7nqd9atQ4RrcrucDxMsq/unajmlxb3nW/wWFGMJJIWWPGyMLXl71R21zHeFNruHFdnnN9JzTk4MBe1+ywKmHYRoLkpD+bzHdF8hCLf;20:s5rnP6G3rncqUvaEvJPA2+LNZ/JtTg7K4r/treoGoG1qlNWbIrZ4LGe0xoBZERAOkcv/o9AYaF+lQIja+CMICC8Gag/sOeEwZ+5exKYW9PjxiTrAlcoumOqKvrIXz5d0kPnGw1eb4filyBnqcrbHhoPiX/KOrZtQ92cLb6xwJ4A=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16d1e363-9dc9-4b20-f14f-08d58db327ef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885FEFE341DE21C0424E502FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(15650500001)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(59450400001)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2SMLYMfJpGdeCuAck+/ti4r3zLfjaiHknXy4Ml83GmW9I17ZW+KHKipD2w8HwrX9BZGhX13ZbxW0FGNdKx8d6Ram12oLUhGCD+umo1vifBF32+4t+M7iQ0cTWa3Jt5pge8+TvEAOB9kI6L2dUAoedIEADDf3bKQxQV6lc3s6RtRYW49De3Wn5j+yeD+JPVcwZketjgbjI33yRi4sxpoq70ab7Phb153dOM5bc52hDX2zxOiGuYk1F8rhVUsiq4Bnpwks/6OtDO2rfXP6QBbrCB44KNyg83GM26EJJnL2iWcN6DNuRFLefziJ/Kyu6Mt0bIty4ZTUpYwdKehAiXrYLA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d1e363-9dc9-4b20-f14f-08d58db327ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:36.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Girish Moodalbail <girish.moodalbail@oracle.com>

[ Upstream commit fe741e2362f33bbea813bcc3a921de356c6653db ]

There are few places on the receive path where packet drops and packet
errors were not accounted for. This patch fixes that issue.

Signed-off-by: Girish Moodalbail <girish.moodalbail@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/geneve.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 3c1f89ab0110..92ad43e53c72 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -209,6 +209,7 @@ static void geneve_rx(struct geneve_dev *geneve, struct=
 geneve_sock *gs,
 	struct genevehdr *gnvh =3D geneve_hdr(skb);
 	struct metadata_dst *tun_dst =3D NULL;
 	struct pcpu_sw_netstats *stats;
+	unsigned int len;
 	int err =3D 0;
 	void *oiph;
=20
@@ -222,8 +223,10 @@ static void geneve_rx(struct geneve_dev *geneve, struc=
t geneve_sock *gs,
 		tun_dst =3D udp_tun_rx_dst(skb, geneve_get_sk_family(gs), flags,
 					 vni_to_tunnel_id(gnvh->vni),
 					 gnvh->opt_len * 4);
-		if (!tun_dst)
+		if (!tun_dst) {
+			geneve->dev->stats.rx_dropped++;
 			goto drop;
+		}
 		/* Update tunnel dst according to Geneve options. */
 		ip_tunnel_info_opts_set(&tun_dst->u.tun_info,
 					gnvh->options, gnvh->opt_len * 4);
@@ -231,8 +234,11 @@ static void geneve_rx(struct geneve_dev *geneve, struc=
t geneve_sock *gs,
 		/* Drop packets w/ critical options,
 		 * since we don't support any...
 		 */
-		if (gnvh->critical)
+		if (gnvh->critical) {
+			geneve->dev->stats.rx_frame_errors++;
+			geneve->dev->stats.rx_errors++;
 			goto drop;
+		}
 	}
=20
 	skb_reset_mac_header(skb);
@@ -243,8 +249,10 @@ static void geneve_rx(struct geneve_dev *geneve, struc=
t geneve_sock *gs,
 		skb_dst_set(skb, &tun_dst->dst);
=20
 	/* Ignore packet loops (and multicast echo) */
-	if (ether_addr_equal(eth_hdr(skb)->h_source, geneve->dev->dev_addr))
+	if (ether_addr_equal(eth_hdr(skb)->h_source, geneve->dev->dev_addr)) {
+		geneve->dev->stats.rx_errors++;
 		goto drop;
+	}
=20
 	oiph =3D skb_network_header(skb);
 	skb_reset_network_header(skb);
@@ -276,13 +284,15 @@ static void geneve_rx(struct geneve_dev *geneve, stru=
ct geneve_sock *gs,
 		}
 	}
=20
-	stats =3D this_cpu_ptr(geneve->dev->tstats);
-	u64_stats_update_begin(&stats->syncp);
-	stats->rx_packets++;
-	stats->rx_bytes +=3D skb->len;
-	u64_stats_update_end(&stats->syncp);
-
-	gro_cells_receive(&geneve->gro_cells, skb);
+	len =3D skb->len;
+	err =3D gro_cells_receive(&geneve->gro_cells, skb);
+	if (likely(err =3D=3D NET_RX_SUCCESS)) {
+		stats =3D this_cpu_ptr(geneve->dev->tstats);
+		u64_stats_update_begin(&stats->syncp);
+		stats->rx_packets++;
+		stats->rx_bytes +=3D len;
+		u64_stats_update_end(&stats->syncp);
+	}
 	return;
 drop:
 	/* Consume bad packet */
@@ -332,7 +342,7 @@ static int geneve_udp_encap_recv(struct sock *sk, struc=
t sk_buff *skb)
 	struct geneve_sock *gs;
 	int opts_len;
=20
-	/* Need Geneve and inner Ethernet header to be present */
+	/* Need UDP and Geneve header to be present */
 	if (unlikely(!pskb_may_pull(skb, GENEVE_BASE_HLEN)))
 		goto drop;
=20
@@ -355,8 +365,10 @@ static int geneve_udp_encap_recv(struct sock *sk, stru=
ct sk_buff *skb)
 	opts_len =3D geneveh->opt_len * 4;
 	if (iptunnel_pull_header(skb, GENEVE_BASE_HLEN + opts_len,
 				 htons(ETH_P_TEB),
-				 !net_eq(geneve->net, dev_net(geneve->dev))))
+				 !net_eq(geneve->net, dev_net(geneve->dev)))) {
+		geneve->dev->stats.rx_dropped++;
 		goto drop;
+	}
=20
 	geneve_rx(geneve, gs, skb);
 	return 0;
--=20
2.14.1
