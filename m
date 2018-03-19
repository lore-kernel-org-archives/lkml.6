Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3384037-1521482393-2-14994844287063248343
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
    t=1521482392; b=Aa2Rw3lrclv6H96dbSPzichOyst1vUNEdD840FTBYloblbI
    ZI7uGwb41D1M2DIp29G1k5m/520cEWnoDQY3ID7RZCkdk1Djuis9Ojts/Ljo3GKz
    5JRvzlFM9fT15wGptU6LE5pETNub4jWJ426KFNE8x2gzAEMx3+lAdJ53BKHuJ//G
    TSK832FqJ6Xr3+UwJ+h6pE76FaUjUZT44+SO+XPA5bh+o/QBbjHdKB8YjyjNJbJc
    RFAfRefkCWVHq2edo5pc1g0WtYL3AeBdRY0eYiZG2O+t4xmj0Kh93zcrC4bWvtu6
    ng62ossRfvXxrpkKRMJ6oSQznnEaAZIMfD5ph5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521482392; bh=wP1ccf
    ESInh4sIEfnz+cuodJdJ0GKXMYz0XSwBbUUE4=; b=d7YgIxRqsGcHR+Y6KXtbD6
    rjtqyAaBmnxU9ReYv3lA6/C8cpQO1sLkya4noQaUdLeQCo+5l3zvNXO6uQV/aW29
    lHKWIqBxTubwJIsyCzrhx+13JhnR0vkYZYIiNgssbCAM0o8HtL3RvzXuKZYdART9
    xnpFbzq5F2CtDEBBASPlsYeZO0tg5oVoPwOzjUgmjXOhprEJYJBSuoXAbL0oVg09
    vT86HI8lSwfdkfj65GiHZRKt8kkVnRwdOBV8zmryG4KB7gxHdOptABASQ6U3Ywtn
    Qll6XTLna35GnIUVJLrEPADbmaiou2cirij2XJB6aWym0YrE7i4Vf1Vj5Lv0RSQA
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n/O2Kuy6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeileejkeenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=n/O2Kuy6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdejucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeileejkeenucevlhhushhtvghrufhiiigvpeehvd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965688AbeCSR7V (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:59:21 -0400
Received: from mail-bl2nam02on0137.outbound.protection.outlook.com ([104.47.38.137]:29088
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965647AbeCSQEV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:04:21 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 208/281] tags: honor COMPILED_SOURCE with
 apart output directory
Thread-Topic: [PATCH AUTOSEL for 4.9 208/281] tags: honor COMPILED_SOURCE with
 apart output directory
Thread-Index: AQHTv5ucz6UWskBbE0Cg1PR26X7ALw==
Date: Mon, 19 Mar 2018 16:01:59 +0000
Message-ID: <20180319155742.13731-208-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:JS/7hY14Ft2TG3nJU7gubJBP8tajVW45dCVyTPjQcyiS9LbBcFgHD/D8goFhE43UwLiX80TzpCtvsam67XA5tGYtUR3DceMyaeUiVB5qbmiMA38nvadnE19V+HJux/7kBF3AtzZ5JcGUSpa1W7frZ62l8D3g1ks0KUU4MScXJCQg3wk2LnXc3FlxvC9m6ITzr/KEx3RmMK9FcFNuekdLWH+dxyPKLJO8Dcg4qqVVj6mhypLRdYegEjtW2lZDdNJu;20:gRKhBUIbaVB3E3M+RXjc5t+f8Sz4naY0mUhZQc5RAx0Rwb3yoprurJopsaVJ2FZ3YBHN+6OyrYb2WpEGHfIagmsKR6RGDtYyyB7n8Ea1It2hT5ZcClmFTlR1wTjuq7jYeETR3x2XNeAiPdYehQTt6JcG1HQNPJkDdESVPW0aFSA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 041752d1-1614-4196-aa1e-08d58db30834
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727D6AE42413A34012FA41EFBD40@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(191636701735510)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(189003)(199004)(4326008)(53936002)(6512007)(81156014)(305945005)(81166006)(14454004)(6486002)(106356001)(76176011)(2900100001)(6436002)(6506007)(68736007)(22452003)(66066001)(3280700002)(6116002)(110136005)(8676002)(54906003)(10090500001)(3846002)(316002)(2950100002)(26005)(575784001)(86362001)(105586002)(99286004)(36756003)(478600001)(2501003)(186003)(5250100002)(86612001)(97736004)(107886003)(7736002)(1076002)(102836004)(72206003)(5660300001)(25786009)(10290500003)(2906002)(3660700001)(8936002)(22906009)(15866825006)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: MtT11UGyDGP8pddZ2U9t0LnsV1g9k3UtRb+gP4u6qwVBvOwCuh5BhJZO4dU7xiEcQGxu8DHGbTwzxkH+6+7Rb40b/67iuQglGJJGvY0l8o/21BVfH5BcFYxH0rUHBQdlKNxFziI7IHQ8mP0Wl9H0BFlTkfQV+eI4QlkxUz9x+beyfNk71J8ualD9OkzUaqA2vLV+d/O1qdL08f3z8uAQWjp34mUEcIn7XnhVzSFUXNXyVPtAedx2aOjrjW4rhyUohH3Sm8MGHdsCjIy0i5uxTx/h5gRhRTShug+9SY6W0UZZfmXrXrHeLhqEPU8MEJf1/6TAiptG6v9A9TKA/a+aBQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 041752d1-1614-4196-aa1e-08d58db30834
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:59.8396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robert Jarzmik <robert.jarzmik@free.fr>

[ Upstream commit cbf52a3e6a8a92beec6e0c70abf4111cd8f8faf7 ]

When the kernel is compiled with an "O=3D" argument, the object files are
not in the source tree, but in the build tree.

This patch fixes O=3D build by looking for object files in the build tree.

Fixes: 923e02ecf3f8 ("scripts/tags.sh: Support compiled source")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 scripts/tags.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index a2ff3388e5ea..2a61db329adf 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -106,6 +106,7 @@ all_compiled_sources()
 		case "$i" in
 			*.[cS])
 				j=3D${i/\.[cS]/\.o}
+				j=3D"${j#$tree}"
 				if [ -e $j ]; then
 					echo $i
 				fi
--=20
2.14.1
