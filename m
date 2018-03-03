Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117108-2-13292733915803369528
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520117108; b=MTsNJZFcPzsSN6uuHhUsjH6d00LHhJFtz/ANwZWD9gupxRA
    wL0TtLLFNlFPoPRW6hvqEH+hH92KZoYzakLpYC26ocVIn/IC0VZhdRS9ezwvdV1s
    DdMilGY8ssBAr1RHD7QW6t90xuUI/1I1bAkr7mbZS752Ijk6HblwkYwwbuDqBcnK
    rW/9V4lnoqPkqeW+gHKaLCuzQXO6cZrPB3jzX9l6UEAH94mtkHDBE5IPnYMWlzuZ
    dfgJT9yEQeNHqGQEimn5iThieLjiPJhZdP/gGkvpOYRzTjWydHzZqXXvIVmXONmY
    Bch9X69i/EJvJ2qWPREys7eCIglBqr9GuHPJXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117108; bh=Tg++Yy
    1XkUGGl/ZlGie1X1RBaoE7jCI/ExK8JLdTfQg=; b=QvCRMY4CYprZxhKSaWPaNJ
    hNNcLO7vAespRjyEZ0G25o8b7xw8pFC3RTfRPtSBUeRyhq8gUAnYs10XqYu3hZ21
    6ims/4shJ6iIPtvSh+6/k2wFIesXEhNrsM3LbXwa0NFw41yAgrTbXNTddXV17Old
    8ZroDi5EVdAgymk3XbxTKKBNrkqPbmfGp3/UHpNuHI0yLAuXh4Wh1o2a2bdgmLbF
    fYKbArLHe1bXXWDep8wEknvsJwnq8mU8ApUsTlmEpUX1RQJ08o2rbvXU1aMLBanu
    axsXhAeVrm6hgylT8m9PI00GehfIE7DdsMhQn7ACxVPY8N3EgTBVDdILY62sHX1w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S81gVuXK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=S81gVuXK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933411AbeCCWmi (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:42:38 -0500
Received: from mail-by2nam03on0135.outbound.protection.outlook.com ([104.47.42.135]:22992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933391AbeCCWmJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:42:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Stephen Hemminger <stephen@networkplumber.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 59/63] veth: set peer GSO values
Thread-Topic: [PATCH AUTOSEL for 3.18 59/63] veth: set peer GSO values
Thread-Index: AQHTsz+yCdCajojKtk2zdlGCZHx0jA==
Date: Sat, 3 Mar 2018 22:33:48 +0000
Message-ID: <20180303223228.27323-59-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;6:Aewc6Z5mkxZLo89yIpviENPi/zdJGD/WNM4xXED/3UKkbgs01ynmfW6ggWBEq01+f9Fd9/ka0PDT2w/gHZNpn3DPIQrSBZbj0KSWy7f6m+RdqiFTlTUdQI+iHxAOHtN36brLJz1W/1Tb+LwkK1g7+7Zp37vh8rv94+YGL9tDjtD5xilrtOHcxUAciEVsZKC31AZuWraNqmGeCM7i28iMjmUPv+AFn12dyVbia2h1vs0TR5NL+g826l5sL7iNIpk+a1aX+YG+OxcHnnN9PS5LdHugmBzcXiSGTXQSSJmxPlVeXWZG8rI54U4fplUbzROpKSIuPQR+6fZfWOfT29xT9FPFx6dSm4m9+9KxLr0WpTv0rFeE8/5O9Zij8sRyqQik;5:/aXNMidUhlu6kDKOy8at+bqUzpB57prG+mlmqlrN1OTc2HEKvMGctTRa3VjvGVCVH4WhRo4TqTqclMXKVt5GLFYH90apMSuQQjnBxW20dOf5TtkMpheMYkZOMmmoNNDMLT36rahAscMyQHAGo+TmOR9IIhoIAWSNp//DIUdESoU=;24:HMA3Cslh7XsYh+M4jf8Q61H8YlZPSNnnp7NUJ4l1DzfMPFyA/mwv929tKc4jWouV8D0OY9CYLrAvanb6Jz+TZn67GqnE6LrcPOue3nRaC2I=;7:F5xa9oY/ULhBIn9MzXUoAzVXyNWVqIjj60LKIr8yr69gaiB5UwVpY1pjPxZoF/g2rf3lUM8zbNXnYXz74Ql0CpmfiiiG3lje/EF42uBYfo+aua68TEz/Mx7IuHOATy56LaQe3iN0HZGP/y9L/7LJwZemJNZO5NgyOpakDn8lFW8T3B1n4+s3FAvnqn2GuyAzswd3zryh7eyxYVT0niOHm5CtsMuc6J2yYOPfiuBV8gCdL3nDwBRHajiPJJzBz70n
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6be1e34-e682-4299-1f1f-08d58157fe98
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018E6FB66C103B0FB480F3EFBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: Rq+l9QqDGIAZZJh0VavpAoWJied9+fadBU8ofqpZiF0qbma8gJYvh+kzxkzjxI4izItXr7KYHl6TUS3G5Nq5QQrW9UpUgZAQby3/0kUGDXdHI9loUd8jgdENkUl72PnfADvM12uQRdSFgraqpmu4Qi5jeBZpy2alzsAZLkI8lR4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6be1e34-e682-4299-1f1f-08d58157fe98
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:48.2638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit 72d24955b44a4039db54a1c252b5031969eeaac3 ]

When new veth is created, and GSO values have been configured
on one device, clone those values to the peer.

For example:
   # ip link add dev vm1 gso_max_size 65530 type veth peer name vm2

This should create vm1 <--> vm2 with both having GSO maximum
size set to 65530.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/veth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 32ce1cd64d51..b6b322828549 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -382,6 +382,9 @@ static int veth_newlink(struct net *src_net, struct net=
_device *dev,
 	if (ifmp && (dev->ifindex !=3D 0))
 		peer->ifindex =3D ifmp->ifi_index;
=20
+	peer->gso_max_size =3D dev->gso_max_size;
+	peer->gso_max_segs =3D dev->gso_max_segs;
+
 	err =3D register_netdevice(peer);
 	put_net(net);
 	net =3D NULL;
--=20
2.14.1
