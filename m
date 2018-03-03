Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520122258-2-140532454172238376
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
    t=1520122258; b=wv2gCYpxoATb1lDEMFcUhcGe+XQnXxlUn2BGdIH+5MQakKD
    LH3hgKVBKcB/QKat2Lq26Y72XUK8YB3Dbd9bKZQggfNQil5Cdtetq/CKZm+JTvY9
    OM8hsoNOyMUROkH/ahtavsWJ0YcckeRhMOENqVK1lVLLM3E6eDV9in81lHYyBTif
    HMleNUEkFo+qb/0rSs+jpr7zUnqLfd5yal1sxZcijNA8G+bxoCqqf+rvOd8bk7zx
    blY6yKEOGCcN1vgh5PuuEOhEd51P1LlAy8zrW2Bi5WoAAbFPwiTtYqqQ6+uS+k4n
    4mziimj+WKVPJMKctBWpkp6QxJdE/zSOQj967Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122258; bh=PzDHNK
    Ekw6/gUHMJME6L1ocb0Kd6zGWza+jWeIiOQ4w=; b=Dze2QpV7CbEqH44ld+frPv
    OXqWIR8HtC29a4UAKILFT1hR4AAHliLvMKRXUUs4+pjyxSTD3SaDJNbWo0eJ9JXN
    BKPDco/DgGQ0xCE8GoGzOzECIeSP1EvyGV2vF1/iuRCctq1EuEUOKBfb6DByfYOY
    PeahYt1FMdegE8kJ5jlQw+gz1Wj6vmzWyfQHuvdwvV5+LdgxgwEybQ5gmoUgW5ZM
    kd0XLbdRln/8C6pSa1YZGl7rPdizlaAfbM7Jy9iPEJ/SScGpe6iKsUiJE/V8rxAy
    ahsIT8toZz0zU5fwWvKFRN1cscMyrai9NVjV9qRMFCQYVv0MK7Be5bNMbxI8ex/Q
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jWUiDlPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jWUiDlPT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeCDAKj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:10:39 -0500
Received: from mail-by2nam01on0117.outbound.protection.outlook.com ([104.47.34.117]:32496
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933532AbeCCWa5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:30:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 79/84] ipvlan: add L2 check for packets
 arriving via virtual devices
Thread-Topic: [PATCH AUTOSEL for 4.14 79/84] ipvlan: add L2 check for packets
 arriving via virtual devices
Thread-Index: AQHTsz63RCIn5NJNBUKyCAz73tBD3g==
Date: Sat, 3 Mar 2018 22:26:46 +0000
Message-ID: <20180303222518.26271-79-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;6:aD4gXHcxI7XxYUOYkQSVm+oGx0sR5aoeLPkDVwpASl57A2W4PxYyPYBFR4oCwmLBbbnBLvu3m6YttquCTlbVqVEZpTzaJVrry0BenlpsMBNT07ESuHD6noByASnWnBuQrxUbzro5hrY4WLFnW/w2IKfMIQGZAvGKDLm12vr0sm7XcZnNJcZl2Fj21+FiPou75MfLCfXoG9PHtCFlqTR8GsKE6lE5ofZ8eTasD3PH4fSjNGCtbxJn/k37p9qcs3zqEBDpTbhO0txVkjtODVv6aDrkCr/Pd9gOu1yR3J/+GTjC9RmD9w3QTvTcHO+eJbvfDulKM2cVvg/CV1Q6E27n/c9gN0vNrC0h4Zyrr2vga6h98ZlYBGLhXQKPJ49W7cRz;5:Na02Q4zPQ5/sCt8ZdazsuIpv+3M5kAO9+8DBsWuy9Nf67dasjt9XWiU2XNWCkVfhBVD0yIaOoAdXst6DDKrCxsTy45EByzl/Nw5TcNLHiWIt/C6mvoi4Ej2qyEdY2H53lCeGefbBIAdM2F+tR6T4Bx/zMA+p7LA8RlVRjzwrH3s=;24:1hJt1VZeIxlEp5S+uOvBCP7/Ga0SZxjhX9JA4yq7YBCz9Bd/3yCoenjn+u37juMdZGbjV1T0P/ecywgwShFqRc3kSamjo9Q/hdhq7onpwcs=;7:mAI/yXaoFwiD7rQcm8+WEcpdt/1LXqPvmI5TVd+j2nPeG77yfbJ5aR1PoBIQMof44bxnadCWkOvMAYkP76FMwkoTBmhYPEspM8E3dtmFMexlH82gHhVzWEj4eJD9bMyWYT+wDLXA0uT6tX79zi8rBGfVh/ptszUI5Z2/OgjsQY2eouHfuedd5PqNp0kF2EV90Nmfx6DHFzXRuM/kDBaRSU5NqYW7lYOkyVl7i+oTBvG7XOg8VkDy5JrxLssjtt3D
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef4a6016-b5cd-4802-9cd7-08d581566bb9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115AF7F94315B28F8B5B828FBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(37575265505322)(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(575784001)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: kYZmsOHF8E66GWIyhpdw1+OeSXULeX2XyLp0AEnqeEcxxbAVv9JlnKq7JWlbXztgsFng9aIVuNR5clt9mcK4kpm6vdxqwEVlvpUYMbz1nj8yfqg4WClQmsgbjkhssDt8cKrZVflgExffM+jwPUh7FauqbOvbBE2JIO/miUC4uV4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4a6016-b5cd-4802-9cd7-08d581566bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:46.5567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
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
index c23dea48ad0f..71ff6bd4be9f 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -304,6 +304,10 @@ static int ipvlan_rcv_frame(struct ipvl_addr *addr, st=
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
