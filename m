Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352585-1520123475-2-6431711419694877359
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
    t=1520123474; b=H03Ejlq6r3ECMla8yK7jmLNpwDyh2+krtxige5rSFG7PP6f
    wloXPA4UdYeYo1zN6HvH7uvhVZTtAhVpxky7VLvbWFXg+oyLJRp9OVCLpR60CvX0
    8m+EGwwm28WElbcpKZ/jbajGKK2a3FzA0S+Bn0CoCc1s/2fUby6NdcUDhYcIbL1X
    ZUG2WoNcnq8NJzWDgqdlRiLuhSeYx0wN/XNBwXRqS/uVinL7KRaGlzaJdLVCYppO
    jCTPX9nXhHhcL8HvpeiXWCOblM6j+KMPCaKz8A8wINogSv8dtjXju2YdKcnGtgaI
    N2nwa1MMvTqaoGZglNjXllR7iMaQ9w+VadDhiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123474; bh=zS+E6X
    fRiwft0YbSizKzrfVZLNws+dxfFDablhbb2bI=; b=efft0PpOZzQz5jalxMdazI
    1QLwRBclq/y+CWeytFOmrkNP+EMMXczntaUaBeW4gYwEJxKhK1F+8pw0HDGdU6Wq
    dIFBFC/9BHOAYjNfiSPoSG+8AcAjKtRuFWhReHQa5dA2vgntx5KmnSXBC7Xp9djG
    HGpPx0cqAQ6xbdUdDJcACveYOfHJ34aW1IIXuDyF2TQvJRJabOUGQXXp6qB0vlfJ
    5/39uHRVHlGpncfg9Qvs8qmbuqVCb2fhduVt5ZShOThLBvJB5ifYIR3NldNClSNa
    FNBnS1V+1JYKcT0mPrb2IKOBEroNzIl1mQzi/dagr97ckqOKcleOuXGf4AzxfAFA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cI16i/lW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cI16i/lW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeCDAaY (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:30:24 -0500
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:45281
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932466AbeCCW14 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:27:56 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 097/102] ipvlan: add L2 check for packets
 arriving via virtual devices
Thread-Topic: [PATCH AUTOSEL for 4.15 097/102] ipvlan: add L2 check for
 packets arriving via virtual devices
Thread-Index: AQHTsz57FlmPy93M40mgad9HcIzcIA==
Date: Sat, 3 Mar 2018 22:25:05 +0000
Message-ID: <20180303222318.26006-97-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;6:b+94ATAYPPdI0yf9viivEjZnXHNFo/QyGN2izFOQQbhVcPy1NONIcTDG7zz9ZA1zanPj4dFRXFRET0CFabm5XAjf1lSamb7aDKQVPAOuB/uhSGB3l1RQQY4ln5Xbrn4q7905wT+PeVAch3Frbb+WtQlTw7bqT44l0naMMJJ93QXRRXUAejq4sY/OviURB5VcKfsz782132qG2CAryp1aRhp40gdkY9QdJyX2N4UIsSM54y3+3glkF60oFufnK/X5toofHNH4Tv4d64Be9njcxc+cP0bmKxbiR8II+9AgFDkf6B5A4wAxOcjwnNgOrExl384mF/+lcZ1YEsd1UvEW9B2EOPEzcATa5I5BvG9Mi+bF2ZnJo7DHUYhRS0JRZyx5;5:qtakdp2AxoMg01L4V8LoCsAKBiixaK97loj8p1Fe8QNbJdiNgeFBTZyU9WZeWmlJbzf1zi3s+iROOgJefHrV9hNDxFtXioOPpZ13f/JF112ikWfz362qLOJF6aTb0GELkbIvPA6wx6Lr2+tdw7+K5Ed0RDinv3ImyBoYPxfIlts=;24:0w1I+DK33V/or/ffhWgU9A7HzJCuHm7ic4+W8hiNQPMkxnGv+FAQlwDxaTH88OtIFOGFRAlSROtlgeySj6PufcP5MpFKQ8tdYm/hnhzepCw=;7:kJXtjG/BRHGzuAtpC28sV4zibyQ0UJl7d6UdOGURJFPGeKhlRO7nt77t43EMgn1q3g5Q9T0zBLtpEEoY89TJDEPOAuhvu1uoHnYVwPCrb3K3AYTodumLdlcXc9M6LYCzI0K1Y8iiVNeHYLu7GuXJmUTT/J8IH+kfDopm+gtfM0FJWOHE1ZdiRV8dd4FAIT/2PQe2GdyZUSpNz+KCARtzBmO5ucaPIfPZfbjehRrcfCP+VD6UnI3pBj8C6IRJvT+C
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b6fbda22-3c7c-405a-f187-08d581560143
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06E60074EA6B5670D04C3EFBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(39380400002)(396003)(346002)(39860400002)(189003)(199004)(68736007)(2900100001)(97736004)(107886003)(36756003)(1076002)(76176011)(86612001)(6666003)(6116002)(99286004)(22452003)(10090500001)(3280700002)(105586002)(2950100002)(3846002)(26005)(2501003)(6506007)(4326008)(305945005)(25786009)(7736002)(66066001)(54906003)(86362001)(8936002)(72206003)(3660700001)(6512007)(110136005)(14454004)(5660300001)(5250100002)(478600001)(102836004)(106356001)(8676002)(81166006)(6486002)(186003)(316002)(10290500003)(53936002)(6436002)(2906002)(81156014)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SE9OMtEbL5UIkiSu7MyDqsex8/mirFgkVTkAquEL04it8fvg5W3xS6L+8jcpCBNn9q509LfACj0WM7PVYUvMUQq+BKvEbfKhCmUtqVNrcr4Yn9ZyEcKs9e1J3Kfy9t+eaAoptIzmln8m7kjBxDoaZVBxkDnyjOiJnkZl1Ppl4sQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fbda22-3c7c-405a-f187-08d581560143
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:25:05.9159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 77cc4fbaeace..e92f31a53339 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -322,6 +322,10 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, st=
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
