Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4102378-1523245649-2-4093518175622276839
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
    1523245649; b=hbUtO/JRprIVSDYeW0p5NaZ8VR5fBpLsTlws5a8X6en2fR7rSU
    oZBRK95XF5eBySb/Y/09HVD9SQDNkegeBgAPdIfreajaYVxI0L8j/ypS2ijslOV5
    2EyfQQ4HefiYn0vLVYfr01Z5Fe569VZhFLvXyluNLxWqc5uFWN3H4Zw+KrvbxMHg
    OXJcfooPGjdXjLZ5LYZDI0aoS7tlYMW6fVqUgyMrqgyl95G4IKuPMaqNqvjijATg
    ugXkI0/qE+FNL6rZuos1Uq4CouvSza9k5S73krUZOUb8pR5is0ljkXv+7DxDK6MK
    Ul6rR3OcvKbWhIiqPavTXnaVw1gU5dgq9NbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245649; bh=GolHb/JmG0
    18fQauv+xlE6eUXcFz35pei5T11gIWV3I=; b=oghHT6p236r4tfdPLA4T/s5mw0
    Zb/pHA7rhMbKmeDAh/MND5HIHSN/4en047QDAWcCRUbtAYawLBqpkmWoHtt7RJ9O
    ycubwQxAS9bl7a4+mgoQCnWuu6fohuJhK2cGj+RvI6jicderCDlpvoMf6wXAZP58
    JNHIk7eFdVQHJSFj3j8WAy2SsevgZKpzMYwbziwCO9aJRFrYEiYMZJlD0EnD9rFZ
    5MJtP98/lNMrUNw/lx5QlOR/CA2HKAEb0pjwTC6B1Wbx3yFOYDm7hwXgW/Edjtxs
    N0/Qk0vft9VtEY1SQ81WZJ0HTHg0zeyp+eTUrlU3GglajN6coobeVsbvtO6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AEoWbtth x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=AEoWbtth x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHE++Ldcey3R57kbCR2a2N8QAZ7rZrtMpK82Yw4qJx4WAMJYmBuKIlTBGEoaoQBUFszXZwJkHtz2T2jiRm7GDI9+gyK+Zt7UYphvDyVhX6dcI5a5l7Ha
    sh/j922SCWbjNNuuObbnJw0EKiyJkQfAdzTx/XqLgWZwxVs+t4s/iz33T1Dvd/J0vwhIRB44DS5IC9vDv/O9gNiJMW2Cd06w/Uw7lTfyWeVtXo/vJTQOuFvQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=mzo1gerHAAAA:8 a=P8mRVJMrAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=n3s4s1kxcNMt5zGBPTAA:9 a=vJb7ax8TLcsZ9_9F:21
    a=ois-_ODyTlqiL3z-:21 a=wPNLvfGTeEIA:10 a=GnAkmKsofkalbZQ5jfbZ:22
    a=Vc1QvrjMcIoGonisw6Ob:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754157AbeDIDrY (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:47:24 -0400
Received: from mail-bn3nam01on0125.outbound.protection.outlook.com ([104.47.33.125]:5792
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754085AbeDIAUL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:11 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Ed Swierk <eswierk@skyportsystems.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 126/189] openvswitch: Remove padding from
 packet before L3+ conntrack processing
Thread-Topic: [PATCH AUTOSEL for 4.15 126/189] openvswitch: Remove padding
 from packet before L3+ conntrack processing
Thread-Index: AQHTz5hISJOrcgkW9kyzrzrqKVb3Yg==
Date: Mon, 9 Apr 2018 00:18:27 +0000
Message-ID: <20180409001637.162453-126-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:jZmxVtPKMPmXe0zjiT1sMKfyKTfPJWSziaETuVRiYC56edVauvPRESSd03FUwU0o/3CwrnsHkTyFPQhhDPmfyeiDsciRK8uk2MvFf5U3KqYaJVTwUTgaSt5jNuyhfVPOzftlClEZAiKUlhXVl5HLVZpQVdtJqeqIiJnAm3WVcSl07F1j5jwh4S5gVua/vZzSOUylB0JdhY39dSKASO4j3eZG4SBk1vu9N5Irw1YASgmJ5SKnsanB+YzDMYumSBuJ;20:IZel0703vLJcHlU76aQ4x0i+1dSEIgZhjHAJI9KHgd67u57NXjuq2/3gr5VdRhtQFCIsCNzYxHJrxbsFjwhXj4KOQrowVuNik6JQuopxQQGswtfFoSQIxsOVY49X+75oAEpBamFZB6uB08yQO2pttfbFR9lP9wl5ZWWn8rTQ4Rk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: c33bdf60-1959-4d86-260e-08d59dafa5a6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726FAA43AAD31AD651D9C15FBBF0@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39380400002)(39860400002)(396003)(376002)(199004)(189003)(6486002)(26005)(6512007)(4326008)(81166006)(6666003)(6436002)(81156014)(8676002)(97736004)(186003)(36756003)(72206003)(53936002)(107886003)(2906002)(86362001)(76176011)(110136005)(305945005)(10090500001)(486006)(3660700001)(102836004)(5660300001)(14454004)(476003)(86612001)(446003)(99286004)(68736007)(66066001)(11346002)(54906003)(2616005)(1076002)(7736002)(5250100002)(25786009)(8936002)(478600001)(2900100001)(2501003)(3280700002)(105586002)(59450400001)(316002)(106356001)(22452003)(6506007)(3846002)(10290500003)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: CcVpc8n0QLRNcItD6YT5D+Zhawfii1WkkT5GG5ocaaV/exZ+DYvQojuvcLFNRIZ9DgDBPxTqk+Cj9aQ1lA2K5MSvSYcMRKZgt+SjvUUjpgXzLiCoQ49Y8MBByZuXfDkyz+lDPdrG8S/xdwh+dqI4xXrA87YFZSbCZjMdhCRJulRz/G6VEbUd74PBcsnulz5DcYBFNDrYHJZPxcua6NBd71EUk4M+IDM3lMTuso7DXzFo8wvRKnMYBxehVryEBWUw7JIMotq6RZZyijw1iJHjUps9qR25a1R0NTNSkOLO1hvKv20NTEpESOYFFhpEJo0LYNGOp+86eRd+5/IfNA2A3RQBwzekHxdRDk8e3FocxnuXT1s/yq7lyq4/ZilRO+lj3azxewFus4dFLPLTgRPxhrs7V9HSfM8lYFRmlcsZJ7w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33bdf60-1959-4d86-260e-08d59dafa5a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:27.6446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
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
index b27c5c6d9cab..8f04bd6e44bb 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -1098,6 +1098,36 @@ static int ovs_ct_commit(struct net *net, struct sw_=
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
@@ -1112,6 +1142,10 @@ int ovs_ct_execute(struct net *net, struct sk_buff *=
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
