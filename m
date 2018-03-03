Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153505-1520116712-2-741513494865065475
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
    t=1520116711; b=FedKueV4EcL9UsEgpmkTXSDdOm1BjwUqngi6MToP7cxJv74
    B/FxeZQ/cod/ntjfmqV3V8dtIWe/DI5gmwiJV78fq7hsOrqCxdt4DCpUXlw0Mt/d
    j49EzwfodyFxzugP6VrtgY7ubQdymAbbZzuIv+2YRpfORTkwBI879Vdz5RllzAX4
    uHmXW6bFgqDsmY+KydYUvX/ZjJ/osd+tvI3U0fz8BYzblmi/4vSl4pk4QkKhPKCd
    8MQntCYp3CIHONRk7JpEfQUcrXM5x/9Pq8UahtYH7dC+Nk4n+S6w+CnDEXXpL8Nl
    jVWgDMw+KAgr/H+JHcGqMa63V0wUYPkmXIKeMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116711; bh=O63wNf
    U4S8UKh4pPmss7UzdY22nn6sXIq4uqssm/AKs=; b=kMv0JjXXwiLqdqfNqsNvnL
    OpkbMQxnggqBYZZU//j9dEe76mazbO+xF5xbPm8VCJVrwH5McDGHTTKcCaqAYaie
    CtL81PbdaSnJ9/a6Hh3tMceaV9HUat6JT5H9k1qzSVoHZHbArpv5y//bgBYpoRVT
    ClWJN7GCIcn/w877YSo4u0Jiq8g52j9t2h2z8snvFe0hUsloJKJyxhc6OrBNBPaj
    LbV0Q5qht14gtYVaMFaYMGZrzGE8WIXd8xQyIhLq6zS0G3ObIwIIRgiKxtdSjrGH
    Gy6xiUc4UgXSlM7zhd4kigDU/vJHCKv2yw7UJuiGwY7gkVibeE33aVummUjhjOqg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jg+45PJK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jg+45PJK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934921AbeCCWiU (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:38:20 -0500
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:19904
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934564AbeCCWiQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:38:16 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 030/115] sched: act_csum: don't mangle TCP and
 UDP GSO packets
Thread-Topic: [PATCH AUTOSEL for 4.4 030/115] sched: act_csum: don't mangle
 TCP and UDP GSO packets
Thread-Index: AQHTsz9RyiTXxVWar0Oy+3Punnyw9A==
Date: Sat, 3 Mar 2018 22:31:06 +0000
Message-ID: <20180303223010.27106-30-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:IUXO9yTI1mpx5XrfU+gKeFfanaeRCq4ZSW1RCpwbmVBp1211egTAJ+4aHmKgWRar2spHAW2+gZWbKBqdkrYrDm8Nqebsi7572YefTK8lPaFjX9Qaa1fz8YFUp9SAhULNM0v2FyHHU5Gm8mXHC+5qEr/OhLBwLXT4kYiUJ3ziXrKKN/nJkN26wdxWzt93ztEpuolKIBdcAYC2oi/rmq102t3WJfs6RetW0sryoBCZtZEh/laOPiyRAJPQ1HP9QDL7tFZ/ozKEkhW96FwbABMnR+sHuDK+FzEF11/v/YjDTQokRpgHEYoFy49lAI5znEQRckYS7jLMSlOgAkZE3qOiR97a6wuZXdDWaKPNgPhxspueXFPJgINuC//VEzjJev1V;5:wYzJt2ndOoZguRnroBzHGR6AGDaKZEbBwQ1kh7UJRam3lVdAweXgo+Uik23jU/sEGrQCGOAdRkeeu9gtksH95XOLGrmUos8ITdaqMUw6FhqCTMfd/Pqko/5xPhYsawO+M/zVkbN7Qp5A2/sStOOy0CbkGQrTPsz1TIpkL/gElJY=;24:xjzcnOlSYc/0bv8QgpiI+pygLeBMmUu7EM6hjfnCi8WJfL/H9/HwwWn4iK77yL0+j07tKnKzSB/z34X1iBay6lABy6pZiYVd3dLDDsuIZ0o=;7:REReA6Vd3xsl1AVWjahltyrPgq00aXVaI7UIw7JYBKsOtT7bUaNNYjgtylWtLGMzXpPDxYZaKY2bmiGqpwd9OKuQIJaaRTvEF1u1z6MY6Le6HFlwHtyuZpGh4OV22f4T8PNDHnbJ6SU3wUz6MT94j927ycn+M/bLHruTiIOnTP8hNwn1jxy3KO9mdOVZTZTX9SwXT3s4xIZDGAem7dyk03ePSCs8xwVvsw7LwYVInACfOj/MJbRGj12mUmjCVjPN
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39a8b9c7-777f-4a9d-7b88-08d5815771a5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1067D34E595D38795EA758DEFBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(4326008)(5250100002)(86362001)(1076002)(2501003)(110136005)(6666003)(81156014)(2906002)(8936002)(305945005)(81166006)(2950100002)(7736002)(10290500003)(26005)(186003)(3660700001)(478600001)(72206003)(107886003)(8676002)(3280700002)(59450400001)(2900100001)(76176011)(6116002)(25786009)(3846002)(102836004)(575784001)(6506007)(5660300001)(97736004)(10090500001)(86612001)(106356001)(99286004)(6512007)(66066001)(316002)(53936002)(14454004)(105586002)(36756003)(6486002)(54906003)(6436002)(68736007)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: rju1CbypE3JHGMlFeJW8V/RyoLD7nlm2XABtIsKnNmsqxjJjaerCbOigRAMxSPl+EqR8Eq85CblAKXDXVl12X6lhIrn42UxL8wkZoAqv/y1FPs2Yv9lUQRopWgWapZ8FgbMl68hqgiUjP6aJJvlx6FKn/NUAQBz6mZyHjZ+lwF4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a8b9c7-777f-4a9d-7b88-08d5815771a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:06.2602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
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
index eeb3eb3ea9eb..024d6cf342c5 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -175,6 +175,9 @@ static int tcf_csum_ipv4_tcp(struct sk_buff *skb,
 	struct tcphdr *tcph;
 	const struct iphdr *iph;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
+		return 1;
+
 	tcph =3D tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph =3D=3D NULL)
 		return 0;
@@ -196,6 +199,9 @@ static int tcf_csum_ipv6_tcp(struct sk_buff *skb,
 	struct tcphdr *tcph;
 	const struct ipv6hdr *ip6h;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6)
+		return 1;
+
 	tcph =3D tcf_csum_skb_nextlayer(skb, ihl, ipl, sizeof(*tcph));
 	if (tcph =3D=3D NULL)
 		return 0;
@@ -219,6 +225,9 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb,
 	const struct iphdr *iph;
 	u16 ul;
=20
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+		return 1;
+
 	/*
 	 * Support both UDP and UDPLITE checksum algorithms, Don't use
 	 * udph->len to get the real length without any protocol check,
@@ -272,6 +281,9 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb,
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
