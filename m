Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681289-2-1261500772252993740
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517681288; b=uzXhF/4R0A7M4g0osKQPTuEebgA7hdD7oGQiX9uUSM2Z6Ka
    UJ4+BUYC36JWvqjT4LxmgTeimJaoWYmIDjn5pbzkMc3clbzE4bmXT3USoXEtrJdl
    b2P8E6JMTNRYWjO6jLlLX5FtZHhcRaswejLPJXFuzos3DQYhbmEUlo2gcjbEMtWw
    uhJgO/GXQLGlvA32MT+C+oLr1RqJZN3Gw5quNpnnVMOc22VbTyEZ6ssFdT3g/+Ty
    ritG1oAG6TZiVfcaK090UFhnDwGtUNH7BJCDCmbdMLvnD7THn/FqVitclYK53I0+
    Npw1GKZSFuw4GfAGg0e4UfCmoAe780fB6j94mOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681288; bh=U+kKRQ
    1gB1qn8WE0LdxAtgN0rWcGTnnfVWSaa3loSO4=; b=Zg99qw61Aiua73vrb1Dnr5
    4+CHDLnT/F5h0MMdBKIenBYYJnHgcuvLt3ajde7zkerNCg6XXFIJ4mQMfvfvP2i9
    Eh9JR8l2xlieU0TfsNKq31YnJHSrIYrN3cUgWS/uhj/fmeo/fT64p5uGmvEFmb/z
    dz9hk7m5aSQWBpWNinyz6IdDiO5B4SSiInuwLA4eO4X2Pgj2MHX1Uin6NtF6zaPA
    GNEkrJR9WyvU6jAIDXNouAw3r8w+irTy/CYv9OTSjZf6IJVCbVI5gKhyy64jvPVg
    IwFgz0XDif6PrB+rxMai1hFfTfm2zRUylmpHM67DFoFk5iJQaRLUdBBzYunq6MOw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NOemEYYz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=NOemEYYz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753633AbeBCSIE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:08:04 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:36352
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753348AbeBCSFH (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:07 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 18/52] ip6_tunnel: get the min mtu properly in
 ip6_tnl_xmit
Thread-Topic: [PATCH AUTOSEL for 4.9 18/52] ip6_tunnel: get the min mtu
 properly in ip6_tnl_xmit
Thread-Index: AQHTnRlT2jeJIPTrF0yRLvYRxrB/Gw==
Date: Sat, 3 Feb 2018 18:03:43 +0000
Message-ID: <20180203180303.8490-18-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1091;6:G3VaRW22Gm++U8AEVM8fTRY7mOvuXUWWM1AUtGa48mgKOsNFiTPP4mJ6GEhW4704RnVQG/zP0Vo4hrq/3o00ZNi3V4UmqDFsfPEoQbm1PzkhvZZEvSKiAVtBzjMz4rqLt/WVcN5Oaev+ClFh401yQomo3SVXI9B4YRWdq4e3d3XBzXYDPX7DmIY5UpsCZHOJ+ghcaNuQoKzjQyC62qs2tmZj/PBMCswnWb3Rl5SJBfUkzeYAZ6RMXFEI30SIZeVVTYuzuTTZG4la0lb7qEpKZtEeCzFkcbhou8EA/eIKWdvlPkBbrgwg8Ro8piVJvBuvex6mlKGQzFaVy31AX62Hdk4Jv7z06X9V1WZFSBJx6Q6qCNwhxOes2W0HMxeZ9beV;5:RG5+5yo0IYXceBOvBWLKQsTHOC+1W/JOqm/d5tylqmXYCGFpV1GNjdjkEdxoLn6N4rD9klzhMpPGXpqUbYNnFwbChEMqoPyKxWa9/GuZlbY+qq3WougH2g7XjL5Nx5Xwod5RM20ZSuOBTSZ2zoIX0mHOZrx33eqAwmg55Lx+kdk=;24:/E3jCm16H2epYU7kBqlACBwgwCCu56F6+tL8YFnJLcpUAI7XCBjWPfyW3XtO/3QnWEfaAkSQdw/MmtR5c7BOy/TBSBDv7QXrXdJF1xwBx4Y=;7:CfeRqeozSBTi9xquuIMdzaxnxup5elQmlDYZO01z1azoQcc9E+w+Jh4K9EOn5tFjhgDqynJJgocegUDenKlK/ZCJvtFzr0UBZXbg5XBGam6ScWBV6zDjN0ACBF7BL9vlJrHTeXg7bjDdrJZ0GHeHc25+GrnFCIXD/+Rl17nQlaISQLV+8pNg7OIMcthzV6FwXwzAp/xkRF4EaPgSD9ah5LNqlaXhAMUxE9VX7S5cit6Pi055OZi4G1R7/W/Z9frd
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a319939-8293-404e-7216-08d56b30768b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1091;
x-ms-traffictypediagnostic: BL0PR2101MB1091:
x-microsoft-antispam-prvs: <BL0PR2101MB1091FBF746F1A50D0748C9AEFBF80@BL0PR2101MB1091.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1091;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1091;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(346002)(376002)(366004)(39860400002)(199004)(189003)(86362001)(575784001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(39060400002)(2900100001)(107886003)(3846002)(102836004)(1076002)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(14454004)(186003)(6486002)(59450400001)(6436002)(53936002)(72206003)(7736002)(316002)(305945005)(99286004)(110136005)(54906003)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(15583001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1091;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: wCMWqsHuPGNtNM44wVH/4bzhUWf21O0NKXUZ4R61LKyXoztBNH0iOorsYlP5n3Rd8qUk8aW8G7ZmValcAUqVfw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a319939-8293-404e-7216-08d56b30768b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:43.2370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1091
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit c9fefa08190fc879fb2e681035d7774e0a8c5170 ]

Now it's using IPV6_MIN_MTU as the min mtu in ip6_tnl_xmit, but
IPV6_MIN_MTU actually only works when the inner packet is ipv6.

With IPV6_MIN_MTU for ipv4 packets, the new pmtu for inner dst
couldn't be set less than 1280. It would cause tx_err and the
packet to be dropped when the outer dst pmtu is close to 1280.

Jianlin found it by running ipv4 traffic with the topo:

  (client) gre6 <---> eth1 (route) eth2 <---> gre6 (server)

After changing eth2 mtu to 1300, the performance became very
low, or the connection was even broken. The issue also affects
ip4ip6 and ip6ip6 tunnels.

So if the inner packet is ipv4, 576 should be considered as the
min mtu.

Note that for ip4ip6 and ip6ip6 tunnels, the inner packet can
only be ipv4 or ipv6, but for gre6 tunnel, it may also be ARP.
This patch using 576 as the min mtu for non-ipv6 packet works
for all those cases.

Reported-by: Jianlin Shi <jishi@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_tunnel.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 131e6aa954bc..a2fcf7bdb597 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1127,8 +1127,13 @@ route_lookup:
 		max_headroom +=3D 8;
 		mtu -=3D 8;
 	}
-	if (mtu < IPV6_MIN_MTU)
-		mtu =3D IPV6_MIN_MTU;
+	if (skb->protocol =3D=3D htons(ETH_P_IPV6)) {
+		if (mtu < IPV6_MIN_MTU)
+			mtu =3D IPV6_MIN_MTU;
+	} else if (mtu < 576) {
+		mtu =3D 576;
+	}
+
 	if (skb_dst(skb) && !t->parms.collect_md)
 		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);
 	if (skb->len - t->tun_hlen - eth_hlen > mtu && !skb_is_gso(skb)) {
--=20
2.11.0
