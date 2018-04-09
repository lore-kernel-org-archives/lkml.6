Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3757758-1523238483-2-9086964370759680308
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523238483; b=OcWPkxmCHFlW/BsEJj8b/LKV02ZEhbXf3UV6YuGPuj4LZraOVr
    4bNLktz8tNFW/qTVO312Vsp3VXNZAr3ObwteVckFdV6hHygjfUbmC7x/2CQfgkSP
    qPufZjJDILsPRbCHOEOmHpzLMZ8T7Gax/1ghgQvqw1PEvpTwI/jzPpGa9VLhQv52
    +9mnLkkLCqpLXSex0CgWRRiOGyK0HMNUDlT6v2KaKYY92dkPgZKfEIYWMLXff2b3
    ZuOVFaDdz/719eP/pz2drPI2SDIXVEVE2iHSdTLO5i4FIwUletOA+Z8c94xUK2jJ
    stAvAW8Vy8Bgp0TF63un4KQOAgRhNHfCWrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523238483; bh=kioKG/iQpa
    udekidcbwEglXIuYWxhY+uxyo9dRECNSE=; b=p07Yd0hBWmTozxaZaFLqtmBTLx
    Llki3g6f2c7RM1xWopgVR4y/D6DgX2Kr56MUQh0cMB1MEzd3XARw5nYUTrdt9DE9
    eswuTQpM4Z2rVRHWatpkRc7+HNuT6mT5gYzXIb13pu2ep3TmTujF07xSolEFdamE
    s8svKafYs+TX3f46PiD6w6gQUp1d/cnIstsJUmfxOLn81MQ3XFT3gTRAqf9SxS7b
    tW5aQpx6fNu/gZhChxppU6B66go6qRgLuWtN2DzC1s1Fe2kN6aeoJz8qYYNbj17I
    CqncbamdIqqymMnQ0DVlPkTgSJAKoKeOLbAnNKAQNcTUrKFt+RIphOUikD5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HJxxF4Ip x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HJxxF4Ip x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDq3BSuLpDZergiJITrRn80vu9p5E2HbKcDIULRO6Ii2HYybkKn0s0jcvASu76DGJ3cYvLWgXKbIg3oPolBEH1dO9Qbmcv3GkCbz6Mlj//6n1OuyYiB
    v7/FGDTNP9niPh4BUE2bzh3p5nnZqire8FwzYWgOA6xCGPs3KAk2q5AwPlAdESHpVWjtIYspV95jqxqcG9E6T2phTUl3ZO7/TJ/II+Rlv6/4k3IizKrRnGiU
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mzo1gerHAAAA:8 a=P8mRVJMrAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=66TFoo7zPJJTDV5F-WAA:9 a=vJb7ax8TLcsZ9_9F:21
    a=ois-_ODyTlqiL3z-:21 a=wPNLvfGTeEIA:10 a=GnAkmKsofkalbZQ5jfbZ:22
    a=Vc1QvrjMcIoGonisw6Ob:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756677AbeDIBrp (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:47:45 -0400
Received: from mail-bl2nam02on0114.outbound.protection.outlook.com ([104.47.38.114]:2685
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932333AbeDIAeD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:34:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ed Swierk <eswierk@skyportsystems.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 264/293] openvswitch: Remove padding from
 packet before L3+ conntrack processing
Thread-Topic: [PATCH AUTOSEL for 4.9 264/293] openvswitch: Remove padding from
 packet before L3+ conntrack processing
Thread-Index: AQHTz5liDQens2NkrkS61Dp/1u8udg==
Date: Mon, 9 Apr 2018 00:26:20 +0000
Message-ID: <20180409002239.163177-264-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:Tf6CwtDVE7QG/poeSrg9xmk6LTcKHCpj4D8Thte0RQE1M8FC7UqEeu6UZDbFB/jNkQRypo7Fd1tU5kLLnk9ANRuiCjdGL6fzNM/QCDm9/bNSbcjV6Y1L0zTU3unsnb/tlFym1IY3kNjKUvt9J73LJCZeSHv1Z5ljPMKROG/5EwXV1d1PAP49q2eTEs8mSC86WwnuJ6d5lURUI61DizBjZbVfH7KYf+QQyd9oyXkHfik0/sTbrP6EsmxP8DtqgOlR;20:bzlqW597+ftRMs5ClmJcvkN47ohIkXJIfyLLnNonb8/hY9A/ZJySRGwXkf+SYwJ/cZ2p9kcEWPDasLzBhQlnugIFoJ5NYoZuNIIvLfmGectqUfx9sVyvngNrXRP/iyDx2R74iD5cx0EhWUZn8Q2DTlvmYTnFVSRm7izFbIEuHM8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: b882984a-fe04-4f8c-f78a-08d59db1961f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0984F9CAF21AFF137628144EFBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(39380400002)(346002)(376002)(199004)(189003)(26005)(99286004)(2906002)(14454004)(97736004)(59450400001)(8676002)(81156014)(81166006)(8936002)(6512007)(106356001)(76176011)(186003)(3280700002)(10090500001)(36756003)(6506007)(66066001)(3660700001)(72206003)(478600001)(6666003)(53936002)(2900100001)(105586002)(102836004)(2501003)(110136005)(54906003)(5250100002)(486006)(1076002)(25786009)(6116002)(6436002)(11346002)(6486002)(22452003)(4326008)(446003)(7736002)(86362001)(305945005)(2616005)(476003)(68736007)(3846002)(86612001)(5660300001)(10290500003)(107886003)(316002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: BaxrIgQcBZWf292CT9Gbc/ntKeUqJQkCNvlutjDKKaWQJVXXnKtQFWlJDBYsWJZhQAYvVctwZCTFZjjyXG7l+WLRo9NtDioQr6lGwWC8yWIP9UGqs01grsllldAtWrl59k2hIMAantTMIAuklylwfeDcbpZ4q+zwrddc5W/CTMf2ZbCqgSnMX+B6DZnu+qjZKWEHTrmezted00ss0D+xtuKg06bpDScv4rdl9fzHQ2vks4912n7Fq1i8+0Q+FpFHJ4GyRqGpdK1fxeSUdN+Q8yJdUtzOV59OrLhg69CTlA6SckXH/UDAUuuQzUN9MKVU1a8fhsEE5YRLuoIlQKNYHp2ilE6GcNpo19eWxYQ0fn9+H3j83nZIIV+ZfYKQNyW5q46NcF+Y938Q/JIdJvoi5x4WCfhEjJFRqQ7Y4dmdYVs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b882984a-fe04-4f8c-f78a-08d59db1961f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:20.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Ed Swierk <eswierk@skyportsystems.com>

[ Upstream commit 9382fe71c0058465e942a633869629929102843d ]

IPv4 and IPv6 packets may arrive with lower-layer padding that is not
included in the L3 length. For example, a short IPv4 packet may have
up to 6 bytes of padding following the IP payload when received on an
Ethernet device with a minimum packet length of 64 bytes.

Higher-layer processing functions in netfilter (e.g. nf_ip_checksum(),
and help() in nf_conntrack_ftp) assume skb->len reflects the length of
the L3 header and payload, rather than referring back to
ip_hdr->tot_len or ipv6_hdr->payload_len, and get confused by
lower-layer padding.

In the normal IPv4 receive path, ip_rcv() trims the packet to
ip_hdr->tot_len before invoking netfilter hooks. In the IPv6 receive
path, ip6_rcv() does the same using ipv6_hdr->payload_len. Similarly
in the br_netfilter receive path, br_validate_ipv4() and
br_validate_ipv6() trim the packet to the L3 length before invoking
netfilter hooks.

Currently in the OVS conntrack receive path, ovs_ct_execute() pulls
the skb to the L3 header but does not trim it to the L3 length before
calling nf_conntrack_in(NF_INET_PRE_ROUTING). When
nf_conntrack_proto_tcp encounters a packet with lower-layer padding,
nf_ip_checksum() fails causing a "nf_ct_tcp: bad TCP checksum" log
message. While extra zero bytes don't affect the checksum, the length
in the IP pseudoheader does. That length is based on skb->len, and
without trimming, it doesn't match the length the sender used when
computing the checksum.

In ovs_ct_execute(), trim the skb to the L3 length before higher-layer
processing.

Signed-off-by: Ed Swierk <eswierk@skyportsystems.com>
Acked-by: Pravin B Shelar <pshelar@ovn.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/openvswitch/conntrack.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 466393936db9..f135814c34ad 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -906,6 +906,36 @@ static int ovs_ct_commit(struct net *net, struct sw_fl=
ow_key *key,
 	return 0;
 }
=20
+/* Trim the skb to the length specified by the IP/IPv6 header,
+ * removing any trailing lower-layer padding. This prepares the skb
+ * for higher-layer processing that assumes skb->len excludes padding
+ * (such as nf_ip_checksum). The caller needs to pull the skb to the
+ * network header, and ensure ip_hdr/ipv6_hdr points to valid data.
+ */
+static int ovs_skb_network_trim(struct sk_buff *skb)
+{
+	unsigned int len;
+	int err;
+
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		len =3D ntohs(ip_hdr(skb)->tot_len);
+		break;
+	case htons(ETH_P_IPV6):
+		len =3D sizeof(struct ipv6hdr)
+			+ ntohs(ipv6_hdr(skb)->payload_len);
+		break;
+	default:
+		len =3D skb->len;
+	}
+
+	err =3D pskb_trim_rcsum(skb, len);
+	if (err)
+		kfree_skb(skb);
+
+	return err;
+}
+
 /* Returns 0 on success, -EINPROGRESS if 'skb' is stolen, or other nonzero
  * value if 'skb' is freed.
  */
@@ -920,6 +950,10 @@ int ovs_ct_execute(struct net *net, struct sk_buff *sk=
b,
 	nh_ofs =3D skb_network_offset(skb);
 	skb_pull_rcsum(skb, nh_ofs);
=20
+	err =3D ovs_skb_network_trim(skb);
+	if (err)
+		return err;
+
 	if (key->ip.frag !=3D OVS_FRAG_TYPE_NONE) {
 		err =3D handle_fragments(net, key, info->zone.id, skb);
 		if (err)
--=20
2.15.1
