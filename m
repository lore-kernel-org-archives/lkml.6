Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683397-2-5155886525766584470
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683397; b=i3rlei7CWlBTxu397QxTEVLb7lbEjTbt/YjZbGn/dMyrQat
    PMf9m7lvxUX82rvKklq5kAXgIDuPX7LD3RwDJ/dsVfNe+RkafkrR2eDkM7/62nvl
    1A04bkS62XIrCAAgM56CheYebBfYGL74qUybODF85NJWcwdHqBKvA7PPDx/aalsk
    VpQlXuAC7HZaHqqRVqYIemsriIHcVaNJefkeInHbZh1K1b4jG0mYvNP37uNT9Hn2
    lTYE/ynsbapPtqFJ7PQGHCJdzTMXPctpsVq8xzOWmeHJ6V2mfoHa0BujcD0RtxP+
    9zKhpXhTo4ngVCXcM8zlRmaVRNcKoqANJuuCMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683397; bh=USlU7c
    HHEc4Y7s/TUxzpZ/blWV4xK4CUghl66nx9nMw=; b=DdA/EBvhoV5N5P1+wEneWB
    6EkrVqp+nygAITdONr9zBG6LhM9jE0j9DZ4YNWt7zAgyhIACxAb6InPBPVkiUidw
    IYxRncxFbvatDnS0T1mo07AHViNXTpiwasAcFxWhagdqqpQu50cTsLNqbmsHDrCH
    47k6UYvfFY7FACG/1asS08QCjPwnQBxEq0VqIBVyxp3jOVHLyYxlOgmKmYiWm9xb
    qRxOTyW4nCu6btWYxGqvDncKz1byQIiAwPMisuCFtiYFsU7dn2lp9uJlmy+JqNya
    ojdbdHkkR19yzT2N2FotB3W8qgf58cmxQqwmPiK4t0ALJU9lbaVMP47N3NDkyR1Q
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/VdYWsO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=O/VdYWsO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755162AbeBCSnM (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:12 -0500
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:2624
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753202AbeBCSDK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:10 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 037/110] ip6_gre: remove the incorrect mtu
 limit for ipgre tap
Thread-Topic: [PATCH AUTOSEL for 4.14 037/110] ip6_gre: remove the incorrect
 mtu limit for ipgre tap
Thread-Index: AQHTnRjqmz5+OZsNUEWm5F0xBO4zEA==
Date: Sat, 3 Feb 2018 18:00:46 +0000
Message-ID: <20180203180015.29073-37-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1090;7:PhX/4HR4G2+dG+d9EuAURGH9xJXoujgqybzfHTWcg0B9nWUINZueiF21HK7TS6HumIAOmfymmkq6MCDDUmGXc0aH0xlK97H0dG9cFezma55WDOUJKpS9Voa6Vp7JuIa6AGgzF1tVmNI60f7w3OIe1jJ29YnInIQwJVahtataurPlnRHQNZWiJEcA6jgCHSIOSNkaGhldSVJX9hOWCxRfy7jw47yY5KiPvHcZ6Y6QcMUVLcuzdThMU98UEKLzpD1A
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 67703141-f014-49a6-9a01-08d56b3020a8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1090;
x-ms-traffictypediagnostic: BL0PR2101MB1090:
x-microsoft-antispam-prvs: <BL0PR2101MB109058063948F72645DF814BFBF80@BL0PR2101MB1090.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1090;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1090;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(396003)(39380400002)(39860400002)(346002)(199004)(189003)(2900100001)(5660300001)(316002)(25786009)(4326008)(14454004)(2950100002)(478600001)(39060400002)(107886003)(72206003)(6666003)(22452003)(10290500003)(186003)(3660700001)(86612001)(76176011)(86362001)(53936002)(3280700002)(106356001)(6436002)(6486002)(59450400001)(81166006)(81156014)(2501003)(6506007)(97736004)(26005)(7736002)(6512007)(6346003)(102836004)(105586002)(68736007)(8936002)(5250100002)(305945005)(36756003)(1076002)(6116002)(3846002)(8676002)(110136005)(66066001)(54906003)(2906002)(10090500001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1090;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ueybaeczaZIUDN/1eZ8gbdO8MmBEFRqpsQ4S2URL035eccXDK30SFPzuvF3h1YgVM4MAzqe70nkBPSC26T76Aw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67703141-f014-49a6-9a01-08d56b3020a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:00:46.5815
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

[ Upstream commit 2c52129a7d74d017320804c6928de770815c5f4a ]

The same fix as the patch "ip_gre: remove the incorrect mtu limit for
ipgre tap" is also needed for ip6_gre.

Fixes: 61e84623ace3 ("net: centralize net_device min/max MTU checking")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_gre.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 5b4870caf268..e8ab306794d8 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1335,6 +1335,7 @@ static void ip6gre_tap_setup(struct net_device *dev)
=20
 	ether_setup(dev);
=20
+	dev->max_mtu =3D 0;
 	dev->netdev_ops =3D &ip6gre_tap_netdev_ops;
 	dev->needs_free_netdev =3D true;
 	dev->priv_destructor =3D ip6gre_dev_free;
--=20
2.11.0
