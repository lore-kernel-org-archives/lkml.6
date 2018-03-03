Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1247250-1520119402-2-14508461114026042227
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
    t=1520119401; b=cOVdqFsU/VPXKOxP2FOgie6m6NgwjS+gmPP6XykcSfQyaS5
    TGTGXjfLlbPF9VizP+gX7b7aUzOgyQTi2zdXeNjmgM1AweUUxtbsy5y82rgTFAAV
    xOviHYKkK8D25Og267NFdMSTISRcBIVtgEhaIjxW4/JkJ4ZSxItMDPnrYckhx2Is
    I+3NjxcCQGpI9Q4Lj3DXwgN6Ir2LaGMHtHwybZv1L+BBdbV5RCoCJSVvsNA8u/cR
    1Gy9JxGnbq700dEZC/EfEuXTPMvS8haCxZThCKFuMZzCS1URnJzIKaw80sPA5Ezh
    YNLrmS6w+vMrQ0RoJ0ceGLssYHuifSRLTlAS2lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119401; bh=oBQFUv
    4w1NXxcHc8ULeK/kJQeyAFh5yCwsVljPjUJu4=; b=TTqaZJzRFRK0Gj16KLGQHs
    Zq+/X8ZArYlu66EQXLQJbv8FMmjJOmwmopruE10FXqeg9X8YvOfhW5CvPVlgM/zx
    4JwLluW9CBC/Gkvsckm4pEGF1jpjYBz2czCM6YmzCBMRIgnKHBcULlRAk6v928VT
    IAaxKlyqV/8vbN/Xp160IWRos4SOEakJqgzT06dlgSL99rwBeGuFhIVekaLzV9PD
    x+PjKNcYk/BUU4kn+wFiE8QUR/jfS5aXXdXtNgP8hn6LIJ4nL1yPkL0D2E9ifeGH
    E89HoI+dHs2fVWWj8l32riCk1j6E6q6r1UeKXHuaLoBTwf++l32xK8Bc/cePZslg
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BU0wFSjZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=BU0wFSjZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932119AbeCCXXE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:23:04 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:45128
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934719AbeCCWhw (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:37:52 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 216/219] ipvlan: add L2 check for packets
 arriving via virtual devices
Thread-Topic: [PATCH AUTOSEL for 4.9 216/219] ipvlan: add L2 check for packets
 arriving via virtual devices
Thread-Index: AQHTsz8rSlGVfwhyG0KaWnZ2i7t5Ig==
Date: Sat, 3 Mar 2018 22:30:02 +0000
Message-ID: <20180303222716.26640-216-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;6:eJBYo5Umz7qScE9ltikm5r3ejhqmvEUUFp6j2VA43DayP554jRf21rmb0EPgvDJ4n51l6ZzD+VAFKi4/gakAeyfz2pdEIW8ry/FJ1H/ppsN64oy2uHQg/CkrRHkOnmRad4ZKyAjkW3M8Ig5nS7SGfkJk0LQtaAtZfbNn0KT1NMOi0S6pAFglhnfSJJUlaj3z6Hv9j7QBtBZYOBBkvuKRc3Cf/2d0DmGcUUrxBtpftIB0SyJ3HbjMBN3B/JRlC2qJCWRYQVpPdF5yHJDnWB6RWcfsC/xu2+2W/6HgJjrIAMLuEaxVWEDwdqN3A4F8q3WhNwbYMX0KlWSCVVfMCLc7nYj8iPiEyUgiQZzR9t4XEAFuVhPl5gnBkANMrMANu1Km;5:PMCsLdMJMi3p1q1577gBMZcZtFmQUVDiKnqmjGfuYscOHF32utdKfvzmAjDHRMuTr8SiHzsN82HjW6X4gZu91eBDQWnDCSUtBVqxDwPrxrrZsmujgDkcLYU4JyvDJJj5UDaIVE9PsD63NCcNfzERZEiUmVenwSrAHoh2XJycXyA=;24:wYcpAs5S7yYj9TXSSFVduTLSHCA/I1lQrQnb+mlig4NZFUpujaG0X9q9xC8dTqjjlU3ZeAaVboyTTjp/ObtzZg0Jndpzad0XXWs3BPhrGgI=;7:6GXmM/jsyksGqhpli81p7SkoOz5iwmx3vAyzlgp8Oda5cOpVOAPHSkz7wTPP2h9zTiP80ueDpaigFY/KCj4qdv8GTjaQxT4NcYw17hDEGm4t+owmtOk7qCTOiL9GWWagF+k1oUnNf2TLmQT3Y1thUKwpgw+06KiyBAoz7dPnWG96ByH2MF81/VkXQEYAnX6du48oXrzxAGFRGsiVeYMFxyNT+1riTPxziDViUg/rO9oIARTXzz2/ZYjJ0gyIlrow
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1da5165-775d-4bdc-0515-08d5815764ef
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB11003A595BD60109FD908449FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: tjTrpxz/QUCoyW1hw1q0VaM2VhUgN5PivXsC3e/rO7koP4bp2tFRLPaFYHHdF8NZfsRLuS6gkTiq+Te5/bWm4PEHjwNHbvOO6cIFIVHssykZQ/iZu2T/0hgRD16KmwszqNQ6VqT0d3NGs1zQ+FHvSD3dTcrlPHyvKmmyxANvooY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1da5165-775d-4bdc-0515-08d5815764ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:02.1351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 92ff42645028fa6f9b8aa767718457b9264316b4 ]

Packets that don't have dest mac as the mac of the master device should
not be entertained by the IPvlan rx-handler. This is mostly true as the
packet path mostly takes care of that, except when the master device is
a virtual device. As demonstrated in the following case -

  ip netns add ns1
  ip link add ve1 type veth peer name ve2
  ip link add link ve2 name iv1 type ipvlan mode l2
  ip link set dev iv1 netns ns1
  ip link set ve1 up
  ip link set ve2 up
  ip -n ns1 link set iv1 up
  ip addr add 192.168.10.1/24 dev ve1
  ip -n ns1 addr 192.168.10.2/24 dev iv1
  ping -c2 192.168.10.2
  <Works!>
  ip neigh show dev ve1
  ip neigh show 192.168.10.2 lladdr <random> dev ve1
  ping -c2 192.168.10.2
  <Still works! Wrong!!>

This patch adds that missing check in the IPvlan rx-handler.

Reported-by: Amit Sikka <amit.sikka@ericsson.com>
Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ipvlan/ipvlan_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_c=
ore.c
index 627eb825eb74..c747ab652665 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -299,6 +299,10 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, st=
ruct sk_buff **pskb,
 		if (dev_forward_skb(ipvlan->dev, skb) =3D=3D NET_RX_SUCCESS)
 			success =3D true;
 	} else {
+		if (!ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
+					     ipvlan->phy_dev->dev_addr))
+			skb->pkt_type =3D PACKET_OTHERHOST;
+
 		ret =3D RX_HANDLER_ANOTHER;
 		success =3D true;
 	}
--=20
2.14.1
