Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480485-2-6324059233206288114
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480485; b=JYqBv8KwLZkRwZ3QSbphJ+mAnw0Nq8VGQvUN2gHYcdSm2Eh
    TjPLhjbGUV0FGvP3jlDysmZuGeN9FE5pZF1d6iu415vDGUXf7/cP8+aML4Su9rT9
    hMgG2w2jyGiVhbU3RGr34ERZ5wa8ph/Xt9NPVVaoRZmJW5uNJUYnpU+MXpDy+x/i
    AWWTOETPjp9RqOGMO4K8XgbJfhQTyiaiJwTJb1c2rMJf55EP4H9kypGoqEOp0kID
    XkNRpjd3Mb+1zcrMmUZhM30An+MARiFloY1YVmKPUzDDgFYH2lgx5RsbnZLyEnzs
    CFdWS74uro4NiGNCi4/Zlgkiyj+CDYlzB6SSZ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480485; bh=9h5IaT
    RjMbNmEKkMSoUvI/WtiM5PeVHXOwCJflW89FU=; b=HDG9ZOttOQcReWIY6dS9Fw
    K7tWXl5Fk6xPzXft7v0yh3V5b+JH4GPza9svz4bSSDipAJn+ihiJ9CNlIVcJ8tox
    SSPph0DT4+O3lsE/8AAG7MLXu6AP55FMDv1WquYLy000GQLn8+9JuJNFZC9eUPlO
    SGG+UsQSofzfXJGUZeVF240FW3SWsZO4h3ilVJ+qHQjnq3x2V/NaRTVjIwErOgSX
    +OOtCIsussh5443sO69Lwwc7Ij8HJS1Ddi2ZoOxJt1TcWbNRnnOsF8SGTNjDh4gi
    vNKn4YoaR9erVPIhm4t8ApcW3nGXq3GaKf5NDl/qEbE/tykEeOVDppPzOUivLXcw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cCkY0fib x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeelheenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cCkY0fib x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejjeelheenucevlhhushhtvghrufhiiigvpeek;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965703AbeCSQHr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:07:47 -0400
Received: from mail-by2nam03on0137.outbound.protection.outlook.com ([104.47.42.137]:54368
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966174AbeCSQHm (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:07:42 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Mahesh Bandewar <maheshb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 037/167] ipv6: avoid dad-failures for
 addresses with NODAD
Thread-Topic: [PATCH AUTOSEL for 4.4 037/167] ipv6: avoid dad-failures for
 addresses with NODAD
Thread-Index: AQHTv5ww/wEP+WJJwkm/ymD0E6TBfg==
Date: Mon, 19 Mar 2018 16:06:07 +0000
Message-ID: <20180319160513.16384-37-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:p8zo9PWA+uBqQRLaEdVKNd6320n4wEGMUfF0FEm/bHzz5MLJIgTAO0XcRxQ2DgVpxd0lw04zgsXuTKEItFZy3+bhlZDgrybe46TXX90QkrbZDLnJ1u4syPDsgVH/3mawbIQT/UEv1ndduvm2ejQUNgvEoEoIKgiW4F5Wgl9QOQligHpnnZ573nIoGI4stWXysqI6jabzGslkdczMQGiJazgESX8o4fX9DcHtQdPORyRzL4nwgUpOW5rWy+9E0+Ma;20:X2/V0RjxJjHuK9eZNPW3PrkDa5mS4sJOWc2yhjQicillPC9RS8AUz5+vOKaSIUgprg7L3uu+u1oNBtTSoih0GzkOm35bqKyvZY8rgQ8aJDKVS/qQyTZFXV1U7ARPhbM7WhQyom0ShBGGMXiUy5tmGd1PdoDGA8vypmJX7Bv+dJ0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c3e367a-e095-4abb-46c9-08d58db388ab
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920816B8CD11E76686F70EEFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RTogJ/W1e7f1H2ujoNA9WG7nNB5QSoEc2PQoH8GH2PR7bkzINZRvhOUFwWMiF5bdAB/o1VCy0hl/4KmGQl8oJLt2WURa9zqWGB+RjnevDsiAfw6nH6hCtVS//jPxDq6KGNexO6kKYNugbzBpZ15YUXADqb5QHYsjH+CSd+co5iX+BNrGDLfpKT10uvVhoWh1ky+HzfRbqpBqKz5+9cEwUo2K79VAd8CGvr0iQFo9eVHv2ZSwZiheQ50auE7se2+mG6bx3QXDXfV8Dwqr2uRg0T+1Z/KVQhU8tiaFMylOA9fy4ppD59wSEVs5haqcZBZzvehW5Mq67bcwrZXf8cDUMQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3e367a-e095-4abb-46c9-08d58db388ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:06:07.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mahesh Bandewar <maheshb@google.com>

[ Upstream commit 66eb9f86e50547ec2a8ff7a75997066a74ef584b ]

Every address gets added with TENTATIVE flag even for the addresses with
IFA_F_NODAD flag and dad-work is scheduled for them. During this DAD proces=
s
we realize it's an address with NODAD and complete the process without
sending any probe. However the TENTATIVE flags stays on the
address for sometime enough to cause misinterpretation when we receive a NS=
.
While processing NS, if the address has TENTATIVE flag, we mark it DADFAILE=
D
and endup with an address that was originally configured as NODAD with
DADFAILED.

We can't avoid scheduling dad_work for addresses with NODAD but we can
avoid adding TENTATIVE flag to avoid this racy situation.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
Acked-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 net/ipv6/addrconf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 92174881844d..0613be57513e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -957,7 +957,10 @@ ipv6_add_addr(struct inet6_dev *idev, const struct in6=
_addr *addr,
 	INIT_HLIST_NODE(&ifa->addr_lst);
 	ifa->scope =3D scope;
 	ifa->prefix_len =3D pfxlen;
-	ifa->flags =3D flags | IFA_F_TENTATIVE;
+	ifa->flags =3D flags;
+	/* No need to add the TENTATIVE flag for addresses with NODAD */
+	if (!(flags & IFA_F_NODAD))
+		ifa->flags |=3D IFA_F_TENTATIVE;
 	ifa->valid_lft =3D valid_lft;
 	ifa->prefered_lft =3D prefered_lft;
 	ifa->cstamp =3D ifa->tstamp =3D jiffies;
--=20
2.14.1
