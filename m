Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3913452-1523243036-2-4269370911743567159
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
    1523243035; b=wFIYYsL6zAunPT6IH5nFuUQgBgEN2wMU0D3lHLMennz2y1Fo9c
    ftAVkkpZPOKrHfB8xHtTvqr9xKLTD6YFEG4gGluctdPmGnaQrVcw/faNmRgJ+UU6
    w/ah10ohUN++L19JW0cRJnPdIEU448IPat+ZuCSrVAVwcH5w+wNG3X/3o0jKgP1Z
    9h+Z7/1ULbXjfi2Ar/dcmpPfR+SvpP/KfPg0es84MQoQO1cDbjw2HZo5t9GjPgpY
    Z0GFjsFR4zh4XSeDheD9MFwPXRHucxONITa/fOrqT2G8Kw1MdcTddCjm5ffyV3Tf
    CdQJUiQB3OR1ej3sUJtjUPOIsGNP7fCh4sYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243035; bh=al6CVFkrEZ
    psXuxNqmIYWRApQN1GYFo0sooH+Am/cYo=; b=oxFA+cInoqMyprDaDvh5KCxV9+
    Q2/UrJ74i4pHd/osjpKT82aS9H463/IbXLMPWEG7dxDfsmz0RcntMSj1P99Lu0bq
    FxSWALO2pieji7zBBEaQNmOHCzZr2TWVx0saKe957X6t3Zg1HH+lNgm4YoTXURZP
    Ec3P/qyI7/N0gbIfyyBecdyufoQSwDvHm54zciCPArnHFbpjghQZ1vEeuVTSrIMP
    Ur6rI9r7Ku5pJFbCnEB0vqJef+iKi1Pw+4zIcfP07SFb+H/pdDFVmNinbKjX54hi
    nA2XT2L5PaxAdU+FBrDqpeRJAe3BB4Z2igEWLrnJzkPXx4GyT6x7fu67aJ3Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hWho/Btp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hWho/Btp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK/BhRsPg/+PU6C5fG67NyIJ2SiOIH8CG9RTM/JpmEn1XUGgyrXoI5zySWHNwuThE3+wVDER01KnPF7prNjLDb+TYLTqJzB2pQiPR+joycNSn5cKqzyo
    a9Wcf38IynhL3hW/bie5Uq9qlHKRugzwggZ6uAo8eQ9VnAKft/FDzzzUtCQ00ja/pKAYLorHYqypxCnov2NZfYGJD8oDj0T5Kg7Lf/rNSxO1fnFQ53sdgC0o
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mzo1gerHAAAA:8 a=P8mRVJMrAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=66TFoo7zPJJTDV5F-WAA:9 a=vJb7ax8TLcsZ9_9F:21
    a=ois-_ODyTlqiL3z-:21 a=wPNLvfGTeEIA:10 a=GnAkmKsofkalbZQ5jfbZ:22
    a=Vc1QvrjMcIoGonisw6Ob:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeDIDDu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:03:50 -0400
Received: from mail-sn1nam02on0136.outbound.protection.outlook.com ([104.47.36.136]:19528
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755093AbeDIAYx (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:53 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ed Swierk <eswierk@skyportsystems.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 106/161] openvswitch: Remove padding from
 packet before L3+ conntrack processing
Thread-Topic: [PATCH AUTOSEL for 4.14 106/161] openvswitch: Remove padding
 from packet before L3+ conntrack processing
Thread-Index: AQHTz5iuH/zXX9+u7Em2XWHNeAWtdw==
Date: Mon, 9 Apr 2018 00:21:19 +0000
Message-ID: <20180409001936.162706-106-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:mKIaWzdc+qNhIZ5hM/8/LT8J0e+smHB2MPVLuB+P5RowkQIwrqtTpyUmrP4jLTTMqOC2zg9kgoNZebfM7AXbsJYv0A01AAfH5N0GoACjsWB7bWktvZ61U/DicfvdUrR3CSe1feajr+MviihOcCfeZ/7I1tt4X5N24/vdHfZLIARWUUGRtiF3YZqojKMq37509iPO9NYUVtdqbyfGQymCoWym2f6zxC8giTXZlqW5erJa7tM79C6Sge+xVfJbj/V9;20:0H3+w7VIbc3hGN4dO56jnte8RpJw0WBAEP9cbqWCI9+KjOurkEUCP1xEg/MZvxRRFliFq7PKOAKL/hrCHuU7ifDstz74lneq9ygsbNJf1kL4gksSPWczK/VPhAajp9n0c3VTosIgq+iXIwxyXBdBu8toiD+livQi9Wb47D+7odA=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 32616e09-b133-4e1f-ddfb-08d59db04c28
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB098378B61BB431C065979AEBFBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(575784001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fIfQdekSLR01V+KM+0XT6XeYgKR1m6lVQMO6VKjpk0u16dzW9vpFIqtGxm+U5dA8SSakb1W0ZzzRBxO0wdPTqYyIjaXCiKhZ8AWaGi2KEDtlsNBLcimkSpdMdTanxCy41PIADyCU7vQYxxrSkiztUlqT4ggT9es+KPsrOEIYZGw1zG/4iLZ+rhmg+l7j/VdZNVfoZyv42JWhV5/G/ORiZcSwIKkAXkqGEaBtQi/y/vlMVtkKSrusZ/TDJSyh3ujtnGOdwmasCTmMu5DeR/sGwxea6R7TrnPgPqT/iL+g/aa+w5Zskd38tDqxCJq7Z+AmlqrlPzDrSwONv36zX1qpxZXxcvfi1W4SFWHnqnNn8ndNQA7avRQaA2gKODtmLou2AALXBYQG/QwuRHMAFV71wEVPEGSjIIL9OhlXbTCGN3g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32616e09-b133-4e1f-ddfb-08d59db04c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:19.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index d558e882ca0c..285f8797c26a 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1097,6 +1097,36 @@ static int ovs_ct_commit(struct net *net, struct sw_=
flow_key *key,
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
@@ -1111,6 +1141,10 @@ int ovs_ct_execute(struct net *net, struct sk_buff *=
skb,
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
