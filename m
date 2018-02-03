Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1602359-1517683291-2-8449103548067929896
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
    t=1517683290; b=v4MWnvc5L6S3WxuorC2ULv6EbsjHzI6j8yIn99N5QcsHiLL
    GKUB9Wmweg65nQI3idsRDETXgmJoZUuzM0wXHmgIcBvSdP5Xjgk17Fz092bSCZ6w
    3qWEz6LQo92vsUcAHUj0VqXBfmwjCnPu9NGZI+A79R3yFXgDVXfOhEhPU5k/vb3w
    nTblwd9KYSGfEMitv5zNd00e6ibivw9w5DliAJ+G43ybFtzy0tNCJhCna/LdUGK9
    Yb/6/RIeWUrVsBgAm4oMUS3iYvv8qXBQvJMK9tR1SdfiiFz75+OKhFLGIsfJqCxF
    ZdQ3NwFpf2yVZReE1YqaCAWUKpSUsul0rQBYxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683290; bh=3hq2hV
    x/aRhyim5Xo9BmcMxqOOGh4SD4/CmZc3h34So=; b=PLvIfZyPGYfII9YTjBpqnl
    8H6+r4McKCBU+2wI+BuNEIqkLvdyWdbY3+KVs7T3+0AZYtiH+Uu00bvAoD0ttqiC
    5SbC6kHUhUZVw9tBzE1U8tz5YIAVRcvvJzYkMwzrZgFh/b7yhOqHZzvQ4MrgPPu+
    yzoKQbXTbqmeWZClPIkRo1ckJKL2h7V9Oxa/NkdQBThCuxj04gtaR/bUEoK3Ao91
    KUm6xylBgEMgZexFnOl+YpoPDJczc5UApxpHH4JIbFBgz3fRxKLu9gg0ztMJZJjk
    8TBoq7y5QOAtlUK9DIT/Xl1Hti2NtlkyWnc9+ePXgQQ0SS2O7vCus9e9mF77OOoA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ikCCjkd7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ikCCjkd7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754915AbeBCSlZ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:41:25 -0500
Received: from mail-bl2nam02on0134.outbound.protection.outlook.com ([104.47.38.134]:35168
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753234AbeBCSDZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:25 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 038/110] ip6_tunnel: get the min mtu properly
 in ip6_tnl_xmit
Thread-Topic: [PATCH AUTOSEL for 4.14 038/110] ip6_tunnel: get the min mtu
 properly in ip6_tnl_xmit
Thread-Index: AQHTnRjqox8RCZNktESa7e7LyonRUQ==
Date: Sat, 3 Feb 2018 18:00:47 +0000
Message-ID: <20180203180015.29073-38-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;6:DY0N25kajU4Y1Tn34rVpNmJ1w8oBMXPI2mmabaPrw6z2c9sccUO02C6IMWe7jeJLjwaozFv3c0NkIJiz3p1QNsYV+FUxbkGnM+xS4m1bPKY/Brhr+owX7mWYPSVLJ4onNk/O1Prjsqc8gVmJkRWwh2jWvRcr6L19eIfrGu+7qooXhg6O5NHplNdhvojewrdWACX/AK2yO1a3VjpmqFS+wnB5+6fRo5lmMQp5FpvajZdbitIte30kNoeZW2DbMy5PWxwbHlt3AUDSJb8HaLECIzIYJaZ41PTEBh6IdY6tBUEsCotTqxLheozb8rSiTxWkmdGffcqEuhOwgKqMdTL3HFAMgx3pjOh3bqn0CHCcsqylxWKJu5b5ATy28f3HHFiR;5:yDMBhJoj4u9FHuEnxJYdkE+4e/d700B5XQnXs1pNL47B0m0fhbqZ3qk9gYzbnAR9eA+jWkwEvbpw2dDxqstZUs+BbUKWlGXfAgH6iUE0CiR5QetVt2Xw2bN527mXOFf42w7tHUutzeH/dObmaFwgQ3OS10a8FhqmHxjCbxyPQkU=;24:R5eX0QQjGfEI/UHTfOQYCM6rqSEcxUL/d3j5ezg1cp8ceWndSzy4qacYrU29n44WFCOqj8ruzk6Mo8WuxHocAl5jkggrToxmshU7W6RLFpw=;7:1iB1T26zeSOD8l/MyX4VdnCHHiAwQ8l8Fmshzh9EdhX31TMnEKVKC4hV0jfSdt0rSQt3fYPiZMD5igtCMzHFRpLlAIkJjijqH8POkIk/8Q4gZkEna9ZC7o2bhb4dKdPEHInxBYdY1ZwN/vE7eSyeNCAEK4ecHyP1XvFsm4JRR5lGzOLzf1UF5XwVgTuBMv8wrDAPpE+Xsz3YvrlNQAEqXTy7goi5+XQpSXVq0qvsQY4h5CM80fT61XnC5Yz6Plgv
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a22a4b4a-283e-47dd-f6a5-08d56b302126
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB10904CE257A49099049D7D57FBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(575784001)(39060400002)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(15583001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: EwvhsptZFXoX7akVN/yTvsufwE942vH3mUjMEJSnuSUezg6EXkeYjPa5Zxes9AoI8pmtuVFCpYHvkMQgjc1FMw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22a4b4a-283e-47dd-f6a5-08d56b302126
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:47.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1090
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
index 3f46121ad139..c3e963a2a017 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1131,8 +1131,13 @@ route_lookup:
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
