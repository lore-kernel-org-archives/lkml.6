Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241736-2-11611532371057782086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241735; b=s+eLR7Ki9OySYhwEJF/7484tjV2FBmQolGBfLlzEfmUOGK18Dw
    8e16+rYUhOCFq4XOJfmfYAvU5JRYJBfSq7IiSODTF1GZkBAIuG02ip6lMGf+xcsl
    XsHTRWOAwhvzv2BqBrI9cvNNKPE/MsxCbs6e0RdcSncBYRGwVETF5XKK02hONeN7
    xLnXdQb2nP0/TJNaO71XKDXF5oBL72UZ/PdwK9y9hbB6HPUvwf2a8X5m0pqJ8T0L
    gkUhXh8DBaGqz5k63FlOlZJZ8YsU5t7d5HBHKiZdM66yaFSZyJvMwVcGpyX8vSsL
    jq9QndCXTjBuhz1uyA52n94PvMPgV/iEr2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241735; bh=aqA+bVgbH5
    DFnFVTGaKIPeDpk6hZZcoYAWGtx3mX2Uw=; b=qip5Jq7f1NpUArQlneP7m3ITfo
    9m7Im0NtO5xtV4NFl28D3zC7pxeB+3h7tRTQCgg2ljmCnGkipmJiGsCC63bgCOi0
    5YX0qDnqSEVkwSuZX7iAdOg5r/LONoGhiz4VeXuwRZKBrYJuqUf03TLZYnD1idCp
    rZJmrul6+PxevDjoZIgRGD3DCgjl96Yi7fP/IRQFKWEOYLZ2DGdbnFpjCz5AkO8z
    iIwajk5zsbSQqOc4L2jQx8P7BRDXlz8Sx0wuSjrP+qccQ4i92tpIhwsToAdvpSoH
    VphjZIz/O+QNMVwB23QPLag0BFDcJgl7bwuKlpXS8z0UChoI9ZBVnu1U7Gcw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vdmj9yeY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Vdmj9yeY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBh656LVnyGxSktGuIWQr/N2pD4doow17rgG8RPErbkLdwyQPolH2MOLWKKXY2CvInmM3YJydjcib7Gcn618ZKAKGkc0OR9vV0pvq0M+I5EBSU9h1CP8
    qtT+sDTY0OEx2vYh6u9NOj5242UL9CfgWlF3HbU81MITwLr8wkr9J5B+7MT5TTESNba0Npm3VCpUdduWWI/bY0G5kJfnpj7MPayY7ntXuEN36n1XXs4qKzXI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=yPCof4ZbAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=7EDWiz23SQz5kOWZxAoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=wPNLvfGTeEIA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755478AbeDIA04 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:26:56 -0400
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:2432
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755453AbeDIA0u (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:26:50 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Girish Moodalbail <girish.moodalbail@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 024/293] geneve: add missing rx stats
 accounting
Thread-Topic: [PATCH AUTOSEL for 4.9 024/293] geneve: add missing rx stats
 accounting
Thread-Index: AQHTz5jvangZuMdkFUeUwFjNM9elCA==
Date: Mon, 9 Apr 2018 00:23:08 +0000
Message-ID: <20180409002239.163177-24-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:cxCIiHgGLNnlOuhf5QaNmHJjQsIqmGxXJgirMfkYd++AVPFr7Rk5ggHJeC8IoxNYQnPtNF3/Q80F9045sdVFDmm4An2uoaLI0q+eT4fLO6nmDYtX/UjONO2xf4iFtNUitEvEdZ+jjIxV4oERlCXvjqrnNgYRrO7C5+CWxRZLDEBe+IergSEJ1g/axKMU5cFrjbSie9TTgezW6MyIpQ4YkZ4R30scZYVMx0tz3ggKkPVOvFFAMOCsgqMvG71cR2jt;20:vZxG1X6dgtRl8jIVZBzr1fkQYAu8tOLbXqWdswdOA0MIZR+5Z66ABpiEXFVOg840vwRPsBJzNK5A/fLVjzW8AkaxC4ydtn0IJzdfF9F+f7XsGoLumNyHtGxgoNnV+tAJuGFnyXPHkUddfKYmwSP3XklVaopl9tid0IfW1SFURmc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ba01d40-80c6-42b7-9b89-08d59db0925a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885A95A894FB7CECDFE2E06FBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(15650500001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(3846002)(305945005)(86362001)(59450400001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 8UQkqM1tFMApqOH1odh2XvxtnnQprsxGJea0gEAojRoJz8nRrQLMAm8lu3Fm/+RTTVQ82uYsgZ9r11dclEmKvis/wYOmpftuUzWt6pHbVJ9cHRpBuW8lDFdQXxs8o852XwTLKhOHLhAUrHhjq0EHExiyXCYRGua8CrQX3n3tShD8QvTgQbxVGHEIphNovbe27hBwP5W/mSUGHFYzb9gvCs1gZY8LDqrgeH2TXsBtFIpnhYdd4jyDe+ES0ne3Ye4qWdQNWPdM9yGiOIrTK/h4G1VS62mJCf+77UsBAYGQRKgyEVl6zu+BE3W01FXlVN1uhioS6IWydlF3+gMojcXXK066/Y8FoMLVB16J1nQXbM28vnmGp/g0SG6WLMDnZcQGtyseo2vCcim+ilOYdDp9aC1xrwpGDISR0kfU/D/t9E8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba01d40-80c6-42b7-9b89-08d59db0925a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:08.7842
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
2.15.1
