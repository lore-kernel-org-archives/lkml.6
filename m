Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475834-2-15605043454982769942
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
    t=1521475833; b=Ocahg3JmqUHQsGDFp+nTdki10lng4WJ89Za6/ZLrDR/Do28
    nfx2AQsIKuov7X/gYEtQ+na2zf1AIapm0on5DUpSBHqm53rp/GDZUavP/PqgY8JT
    CjbopWZwoezMmJqzp1cneOlziZjQM9tF4hdiKvZjkZadt1eqFc8k0xWwb8c/yhaB
    Iq1oun2qVmew0bHBOkVGuil+Y7TY1umvsy1mm0ywv8L4tOYhUqu3zgDU7JWHwnEd
    I7NMdThgIgWzK+ZiIchUzUI8oy/fbSSAWza52TeJtlA2Ua+rue0ZdGo4/VOLHmKD
    0GX/sxFyqxEmbFwQ97aM02y6pdy9Un1MiVWbrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475833; bh=TTcIAW
    +hJVTgl4n22w89zRiulgGwTZc74A2aZE2Deg8=; b=IeekhN5x26btvZS3qScH3C
    7I/2qa7XIdXvehL/sktYMHBHopptxzYCdLsgUODguBKT2+ugC+1tWF2QwZdHrpBk
    fqgVR8oBv4g4/jsv3jYQf40wQ7jPrZz00H1lA0jrr79rjGRiWa06BLDDSQuYTwFI
    iZf5h0MO+aiRggLFHIOzNxwsev7V0+zGVKj2GN8w7vP4vxT/dnJpYv9m7A2pVvHj
    X6gydi6X0o18BxJIDrz1uyW7ndNf4OQJIG/YIUKJA3uuNrDtLhHPy92QgO4geZ8O
    ZFcB9xDCaTE7uM2iva5MIua+aIrodgszzxElC+xPoU4nreTZYX9giyYFYIU7c+MA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DomXNwEq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheeinecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DomXNwEq x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeejheeinecuvehluhhsthgvrhfuihiivgepheef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966473AbeCSQKa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:10:30 -0400
Received: from mail-bn3nam01on0110.outbound.protection.outlook.com ([104.47.33.110]:35072
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966564AbeCSQKH (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:07 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 103/167] net/mlx5: avoid build warning for
 uniprocessor
Thread-Topic: [PATCH AUTOSEL for 4.4 103/167] net/mlx5: avoid build warning
 for uniprocessor
Thread-Index: AQHTv5xiCJVGQ7qMEkuUdUomv7/K3g==
Date: Mon, 19 Mar 2018 16:07:31 +0000
Message-ID: <20180319160513.16384-103-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1095;7:Gn6TT9+pEkNljle7J8tCsLx26lAJlrdAsmAEXWJeuEGqml5nMXAjbT2ABlhdLSTKnC8Q+ypXCMuRPoB0yV+9d8MUN0PsdBJM3DeBN6PbmDVlOLcBP/Yz7YbY25NKGbHdnBMOLui7gQEPwx0iAcgOWTsfyDdKvxlDrjIy2nUvDF4yRtNFdd4tLpnBAtCWVo4dId0z1eJwQxfVQ0s5ZX8PLqlGCyhggKRHYofZp8ZC0jIzBjViduWu5oxTqS2ZHmAd;20:k/ibloawdcdvhk03RBjauKzKWyheINzbV5BgIQNBqxQIfuO5dJCEUhoFrDXj5bWZtKIV9BbPpqF5blzy/tW11Q1uCD/+O2amWZwTXV/+ySDEgjcJZqJmdpBE8Pifmbu/Gvd8eAhlBmb3eT8EuS/NxLtgKyOQHgRoDYzKZ8a7iWI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7784e3b1-4dc8-4458-d6d9-08d58db3da70
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1095;
x-ms-traffictypediagnostic: DM5PR2101MB1095:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10950F8DCF14CC0FBE8592E6FBD40@DM5PR2101MB1095.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1095;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1095;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(346002)(366004)(39860400002)(396003)(39380400002)(189003)(199004)(305945005)(316002)(1076002)(7736002)(14454004)(86612001)(25786009)(8936002)(2950100002)(110136005)(66066001)(186003)(10090500001)(6666003)(5250100002)(2501003)(99286004)(76176011)(86362001)(575784001)(4326008)(68736007)(3660700001)(105586002)(8676002)(81166006)(81156014)(106356001)(3280700002)(72206003)(10290500003)(478600001)(2900100001)(59450400001)(97736004)(54906003)(6512007)(53936002)(6506007)(102836004)(6436002)(5660300001)(6486002)(107886003)(26005)(2906002)(22452003)(6116002)(3846002)(36756003)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1095;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dqhP5RW8pGVqcXiGD2YsqxmnDZfk/rYvqitV4OUFfBNW8MZ1Ia5/9RNNp3Sj19p55yDDTRRQJKvxmeJ37FX5yK6EdcP68nASAM42tJJEcA/TN3oqoqK2iiaSPjzbshRqTwJAb8eMvQVBw2wOGgLYBhEZ8tvfJJ5nOWJsJTWZfM+iXtaa4ZSHN00Xsp/o5PKXZDxlEn4evWzgLggB5IFgqyQVXfXR/5EiSrpnLxa/G5+vJ/9wWVDhfgnuTfjLhvlBj0wjWwV1LtjX5lAEYqSsGHKjjTn5tr2ERoLs5hTS4YpdE3EezubZPap/E2zM3ZuMLKhlYzxbifMtw0VJc8BIFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7784e3b1-4dc8-4458-d6d9-08d58db3da70
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:31.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1095
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit f0d7ae95fff4ab444b8433f07afc4b077ef1a285 ]

Building the driver with CONFIG_SMP disabled results in a harmless
warning:

ethernet/mellanox/mlx5/core/main.c: In function 'mlx5_irq_set_affinity_hint=
':
ethernet/mellanox/mlx5/core/main.c:615:6: error: unused variable 'irq' [-We=
rror=3Dunused-variable]

It's better to express the conditional compilation using IS_ENABLED()
here, as that lets the compiler see what the intented use for the variable
is, and that it can be silently discarded.

Fixes: b665d98edc9a ("net/mlx5: Tolerate irq_set_affinity_hint() failures")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/e=
thernet/mellanox/mlx5/core/main.c
index 2aa42dd321e9..7c42be586be8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -522,10 +522,9 @@ static int mlx5_irq_set_affinity_hint(struct mlx5_core=
_dev *mdev, int i)
 	cpumask_set_cpu(cpumask_local_spread(i, priv->numa_node),
 			priv->irq_info[i].mask);
=20
-#ifdef CONFIG_SMP
-	if (irq_set_affinity_hint(irq, priv->irq_info[i].mask))
+	if (IS_ENABLED(CONFIG_SMP) &&
+	    irq_set_affinity_hint(irq, priv->irq_info[i].mask))
 		mlx5_core_warn(mdev, "irq_set_affinity_hint failed, irq 0x%.4x", irq);
-#endif
=20
 	return 0;
 }
--=20
2.14.1
