Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683090-2-6540921941892637335
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
    t=1517683089; b=bTerq+T1njd93P+BiNV8VA4YJ6WZlNBi4FI4IdGj0l9aJXo
    InWR+8o8fHwLOQADPOeSXudWgbODWdNGShdU1CynmGczvXZOWzCVSAICaSxMetT8
    H0O6YXr+1xAMMdgvm2RACnGV7xF+S7yJJIqZwwA5arnjfWyCzmfThySlcn6mzo4y
    3VQhgUi34tBMgwgOxjBRbepoTY4EmuLEIgvmp4eT3KA64RAYtevqxdttMUnuW/lp
    t6P9hwqhgmT3n9FVn2mASv5ZdF7E6dBLp/9eHciIJvK/gWbkhMxRiZwweMgTW8ml
    rGm+fnMkxOWR1nHvGjk/yHRZvvNjfTH9qtOyoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683089; bh=Iu9PLB
    4fn7toBj683+PFGHIwW6V6tejlzX83b6ABBDU=; b=DOZcirEDh2a3/bdo1NNPUp
    4FXJJvEFfJhbLc6JNNHO1ainN5Ut1MyX5bnCvIh8JQMuquQLYyM6E4qAKbCrxFPV
    +QdLFfk1bXOI7VzvDal2CRaxkYT6GjCUuY7f+8SKT1JUZo+0poL9yegHXXdK2oMY
    Mi/qcMFTOL1OPsjz93cn5pDANUVIBv+3ZPHQyr+fr/59vmy1c4itn+6TTZFuTaC1
    R7X6vpmChFfBlMoCkH07kCuq3lgfh4rMQmYT0S2+Z3HbuC/PrAirW4L72QbQjhFR
    MCGXzwEJvhjw5sHqUiRM1noJaPkPaTYmX+UsQ433lyLFV5XGOlAARtQcK+wuODGg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lH0di4Dn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lH0di4Dn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbeBCSeq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:34:46 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:45129
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753297AbeBCSEL (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:04:11 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 071/110] ip6_tunnel: allow ip6gre dev mtu to
 be set below 1280
Thread-Topic: [PATCH AUTOSEL for 4.14 071/110] ip6_tunnel: allow ip6gre dev
 mtu to be set below 1280
Thread-Index: AQHTnRj8VA+Z9fEDMEek4X091If8iA==
Date: Sat, 3 Feb 2018 18:01:15 +0000
Message-ID: <20180203180015.29073-71-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1105;7:8A71FmEao6E2NJxwV5MGhV/lxMLJA03T60KvzI1IAPkDk47eMAuw/Eim8uzIbX1ET0Etg66sS+RbvJKK98bBFzb2Kx4eHJmrjkEQNkBGJVOgST+K0vnsE+cFlIBhaIMAIM91Ku/TWQWas7tE0bwIRyd3V91uFkjdeTakYtuKO4cbbsowJAuhK1nCx2cqmfrlVtyTUmZdMuxRuD8IT0Ou/N6N+JE+r6wvj40YfC6IUidcGwl8IV99gHdRz7Mj7Szp
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c1562d0b-8876-4e77-f03d-08d56b303d2c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1105;
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB1105DAB602F8998A98EF6242FBF80@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1105;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1105;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(39860400002)(346002)(376002)(199004)(189003)(6346003)(97736004)(6512007)(7736002)(26005)(305945005)(102836004)(105586002)(68736007)(5250100002)(8936002)(6486002)(6436002)(106356001)(6506007)(81166006)(81156014)(2501003)(2906002)(10090500001)(99286004)(66066001)(54906003)(6116002)(3846002)(36756003)(1076002)(8676002)(110136005)(575784001)(39060400002)(107886003)(72206003)(2950100002)(478600001)(10290500003)(22452003)(6666003)(5660300001)(2900100001)(4326008)(25786009)(14454004)(316002)(86362001)(53936002)(3280700002)(186003)(3660700001)(76176011)(86612001)(22906009)(32563001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: GbFfILlf0Ouq7V4rLkFlbpg2ePsjb4ajNASl+H1yx0dWvjAXmOGDQ/XLEyck36Fn05ZQBdfz4i07PFvjhYn+Tg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1562d0b-8876-4e77-f03d-08d56b303d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:15.8315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 2fa771be953a17f8e0a9c39103464c2574444c62 ]

Commit 582442d6d5bc ("ipv6: Allow the MTU of ipip6 tunnel to be set
below 1280") fixed a mtu setting issue. It works for ipip6 tunnel.

But ip6gre dev updates the mtu also with ip6_tnl_change_mtu. Since
the inner packet over ip6gre can be ipv4 and it's mtu should also
be allowed to set below 1280, the same issue also exists on ip6gre.

This patch is to fix it by simply changing to check if parms.proto
is IPPROTO_IPV6 in ip6_tnl_change_mtu instead, to make ip6gre to
go to 'else' branch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/ip6_tunnel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index c3e963a2a017..1161fd5630c1 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1684,11 +1684,11 @@ int ip6_tnl_change_mtu(struct net_device *dev, int =
new_mtu)
 {
 	struct ip6_tnl *tnl =3D netdev_priv(dev);
=20
-	if (tnl->parms.proto =3D=3D IPPROTO_IPIP) {
-		if (new_mtu < ETH_MIN_MTU)
+	if (tnl->parms.proto =3D=3D IPPROTO_IPV6) {
+		if (new_mtu < IPV6_MIN_MTU)
 			return -EINVAL;
 	} else {
-		if (new_mtu < IPV6_MIN_MTU)
+		if (new_mtu < ETH_MIN_MTU)
 			return -EINVAL;
 	}
 	if (new_mtu > 0xFFF8 - dev->hard_header_len)
--=20
2.11.0
