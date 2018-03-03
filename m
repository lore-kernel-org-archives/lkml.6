Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520117639-2-13343374437331172921
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117638; b=AJ7LN7DxUvYsRJMd9Xkw2oVsrcu+tIZMZtHqFmS/igh9/sd
    ujDc1YsEJOvteBDJ93iyOYeFYRpXJDO5Ipp8teQaKOKujLlDmxnc8OI9g1oONE5E
    XvA0KDf0Ub7Vy3S2WIViH+zbmRTI9XTbH3RisMJML8UcBEv+Zp4gQwDeCN+tBcPV
    a+cOOaWO8p+WGCl67xaTRMEarYzYCg9YNvw0hjT3CZoVtCTJFgGJFz8vkSQQtcOS
    bp9MiKXrq2QkcuanXXPtksa841Yk3F4l5W+GpeL9lVWAY3ajaBexAlbXguYyxFCV
    nv7ahzem1LRpb/rDVHz/0OCqFnDGPZzJ9suTVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117638; bh=5HdeLQ
    YIqtVFKi3efjqp91xTmfAm68alR1c0w1Y2OgI=; b=tP+dO/KgC9g2ZVuN0kgeQM
    gAZI2OXdqEClTSLZA/h963hiTucN4iuUOfgVxj5kJA3SJ9U1x0p+QuMXaUNu5wca
    EH90jH4htlcvuQEKvHv8h/ompjKuLz7HnCyEPx8NhB9eHk+CB4NbFBYMSBhcezeE
    u8VC31Sb9pOzdp0uxeGcflKAy7tCwRiW3XaVb9m5jlTwI/kIbmt9pm/+3d5UY8CG
    oChae580hqN6KiAHR8t4WHktbdWwIn1O++N1qOweByUQDArpav8+wA12oZfN2s5v
    ppBTrL4T/T0Cj4yYVcxUBwFtz1tefdQJYLVTPpyFIpnWKmZFYoI0J6OOeRCc00cQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e42DaTId x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=e42DaTId x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeCCWxO (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:53:14 -0500
Received: from mail-by2nam01on0095.outbound.protection.outlook.com ([104.47.34.95]:48488
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935413AbeCCWlH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 18/63] sched: act_csum: don't mangle TCP and
 UDP GSO packets
Thread-Topic: [PATCH AUTOSEL for 3.18 18/63] sched: act_csum: don't mangle TCP
 and UDP GSO packets
Thread-Index: AQHTsz+h3XhuJZmK2UCQFzwJMCWvEA==
Date: Sat, 3 Mar 2018 22:33:19 +0000
Message-ID: <20180303223228.27323-18-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0940;6:THkNUavZze5PiflbpaJ/NyNEuH0JrTnyE2LKPHmuIppNictImFJybGQII64oXbmHLOUvY1oQSmqiu7ArKm47eb0m38OwIFYs3PbgyWpl1IugoDkU0gUKTeAwNFv06PcRtPk4GedRrAI153bc26qLPKNkCi5d7UFEaDiCrmxnCd5BxCvyTAuUl50Xx68Lty/J0z2NmLb829Y0wGEz3VHFmfomzUf7i715ZBt+lzWoDkMhqfdG2i22QuJzy3GQlBPJO6j4l1qd5Kidv0T1LaqbWYMMPhUYnR/lmDmHUXW25idv6yo/JrkFNbd8iY+F4rAQphzlA/ShKiZPK8pkmVxSemzUNOy9HfvtL96yKKlBeTCH0tRWM6HzyLu1Xe0GQzba;5:a/XVwd9yCC44jf5bAk9lAlx4Q4aQ8ZFPdQ3O5FhCZVVwXoD1VVrE9X3+aSGkldM+k/byQ/wqLNW+z4P4BT/CDb5pPoBJicBVKuZuPuO1DtSEQjXUs6eg6hd/8fQLfqEEwyGiiWZq5IFDtmzSpRm+kh0zMCwWHc4/NSuGYYXqbUY=;24:/dDAq70bk0STvlzw0cMhcH7kQLG9ohoVdPtOZkYwxG5s+O9vefDYCje1NPn2VBZh/TUViFDxA4cM2PHQbTJkdArLRDhwrtqhDQKyNbU5h2g=;7:L8Ux37RUOaZ8hbSzlIhqr6IjzjtbNcL/C5Mi0aL1vCXh0fQYoXTcJq2Hk9FoB8MP7It85bHKLTfcM18bR1zJpurNlk2n6+jsSQZEivMNvwCt4/s/PzT7n+BJCeD7UPBhG5R1RYmlzvEJDF0u42eyfQUqOPk2+uFHk4uWC9ZsGkyNgJl2SfCJuvX0c96M+TAfDIXazhVzzm4Ufd3c8u4amHrRR81Htul/GlzKyOveDh+E1dxwjhXEUsCCldxUwoYe
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5242d5d8-a2e2-4611-d735-08d58157d922
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0940;
x-ms-traffictypediagnostic: MW2PR2101MB0940:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0940C1DE7CECE5CA9CAF05F8FBC40@MW2PR2101MB0940.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0940;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0940;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(346002)(366004)(39860400002)(396003)(199004)(189003)(106356001)(68736007)(6486002)(25786009)(22452003)(6436002)(186003)(2906002)(81156014)(81166006)(10090500001)(66066001)(8676002)(36756003)(6512007)(2900100001)(316002)(97736004)(59450400001)(102836004)(53936002)(6506007)(3280700002)(26005)(4326008)(5250100002)(305945005)(2501003)(76176011)(2950100002)(86362001)(99286004)(3846002)(72206003)(14454004)(3660700001)(478600001)(1076002)(5660300001)(10290500003)(6666003)(6116002)(7736002)(86612001)(107886003)(110136005)(54906003)(105586002)(8936002)(575784001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0940;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: gWumRXtf6+Ygc2oZ7aGW0ua5qyk196XA5i/hxsosuLPbHQaxUDBCAWlQehsSy+tzI5SgCejIhKW5amPElr0NVo0k4C658r5FQW0xzEO1Z3ZiGrf1KqZ1NGd/V8f/nxe1ySA4W/Xxgc/z9JKKguRfHvegEStBfHHQx2ZU7Cu6AhU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5242d5d8-a2e2-4611-d735-08d58157d922
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:19.8878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0940
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit add641e7dee31b36aee83412c29e39dd1f5e0c9c ]

after act_csum computes the checksum on skbs carrying GSO TCP/UDP packets,
subsequent segmentation fails because skb_needs_check(skb, true) returns
true. Because of that, skb_warn_bad_offload() is invoked and the following
message is displayed:

WARNING: CPU: 3 PID: 28 at net/core/dev.c:2553 skb_warn_bad_offload+0xf0/0x=
fd
<...>

  [<ffffffff8171f486>] skb_warn_bad_offload+0xf0/0xfd
  [<ffffffff8161304c>] __skb_gso_segment+0xec/0x110
  [<ffffffff8161340d>] validate_xmit_skb+0x12d/0x2b0
  [<ffffffff816135d2>] validate_xmit_skb_list+0x42/0x70
  [<ffffffff8163c560>] sch_direct_xmit+0xd0/0x1b0
  [<ffffffff8163c760>] __qdisc_run+0x120/0x270
  [<ffffffff81613b3d>] __dev_queue_xmit+0x23d/0x690
  [<ffffffff81613fa0>] dev_queue_xmit+0x10/0x20

Since GSO is able to compute checksum on individual segments of such skbs,
we can simply skip mangling the packet.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/sched/act_csum.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index edbf40dac709..72ff5d21f4a7 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -176,6 +176,9 @@ static int tcf_csum_ipv4_tcp(struct sk_buff *skb,
 	struct tcphdr *tcph;
 	const struct iphdr *iph;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+		return 1;
+
 	tcph =3D tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph =3D=3D NULL)
 		return 0;
@@ -197,6 +200,9 @@ static int tcf_csum_ipv6_tcp(struct sk_buff *skb,
 	struct tcphdr *tcph;
 	const struct ipv6hdr *ip6h;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
+		return 1;
+
 	tcph =3D tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph =3D=3D NULL)
 		return 0;
@@ -220,6 +226,9 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb,
 	const struct iphdr *iph;
 	u16 ul;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
@@ -273,6 +282,9 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb,
 	const struct ipv6hdr *ip6h;
 	u16 ul;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
--=20
2.14.1
