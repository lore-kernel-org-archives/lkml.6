Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493228-2-13941596700029078426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521493228; b=XpQxSOlkwGQ9v4WS48Q6o1XvBuW14vSlmCz8loel0UUzxnL
    qvJnjXajbkeFYWCrz+AgFhY/rBfL5qstNsx/dBb0fkbe8kc9ElaLdmcM7d5Dmt9H
    4vrhjZ8uY0EKz7jXOXpTdVUVV1I9yWHQt4HpNtJkkkqyHJ30v0BjykkCY/UrkXji
    /UmrtYI7ucp3xdJAku4ltt9cPeBbT6/reEgTZl0YpV4mTHUHuM7ujLH5QiQ1SKs+
    TUKmxW/c8MtEHW1Lnb8mOtwvA0a+uze7boYQQrDniFlA/T3ALnC5zLi4Y8BI0uoj
    1Y+R0Rd0OwulhLn2YfiS2KdRxiuJK5E/p4t3Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493228; bh=LsbdxR
    24/sAfH19P1jy4m6dAvd4GRYA26yQG/lNBUy8=; b=XTDQwzyv9jj16Qo+TviXaD
    /jdYpyHK2pQiW7Wq0uWxs4X0RqxSR7kXjINOrW0WHc4F4+eME+e9uSo6Nfyo5KoW
    CPAJ8+9j9fmsvH4+bqQpDrDxnWtbaFztMC3iz4hR4eml8C4KX3lpT+YphtBW7x6A
    6bxGFTp5XmFsOHMU1DHqRhHBddVUrzvDJiXQ0fZyA0MybJ5HWRtrXfu/JKk5z47i
    cf16/JbV1qzbcES3M9fXE+nJKFcAP7H6Ns3W9YhViqMhhbsmeNVmlAzpPKOhW50o
    cgbEdcfMKs0WZYh0w9aJo7SKHA7OpoLBVqDFyn8iL/kTMmwD1FAbSQpoteb/iWiA
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DdlpjRIP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdegkeenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=DdlpjRIP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejvdegkeenucevlhhushhtvghrufhiiigvpeduie;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968606AbeCSU7g (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 16:59:36 -0400
Received: from mail-cys01nam02on0122.outbound.protection.outlook.com ([104.47.37.122]:7795
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965512AbeCSQDE (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:03:04 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 171/281] clk: at91: fix clk-generated
 parenting
Thread-Topic: [PATCH AUTOSEL for 4.9 171/281] clk: at91: fix clk-generated
 parenting
Thread-Index: AQHTv5uCEVhloUOlfkWVBOdk05oWfw==
Date: Mon, 19 Mar 2018 16:01:16 +0000
Message-ID: <20180319155742.13731-171-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:S3RrQP2MW/6PnzcuHhJUh+ww0zqImUdBnroBlfAZK7TNS+MYHjOwN+dINvNUEBcjVtaOlKNYuE2EaSDSdRCzxPuMy1iolwU1j8wIJWAlX9s8NFYDwqaK9iCV0K/ugYWtjrVQXrlOzE9VH6CQpqbl+UHVP/nlmoBWJgl4ctPMfRwJABrDGz9KzDp+pnhDMjYJ4Wap91J9mek4wggpUXRoO4V77o96NX22xu6yn91K5n9OrNdG+abatJFv3YqCtfVp;20:N1DxDg6PxmSjMfuiBDg3pL41kjmNtftifH3B7Nw7IB2KSPKeiME/zMPA8e1Qo9Y8aRxc6KVPfxNZAGubep5MG0TcGPIoDr0o2Vn99ALcJ+JDYUqPAxToOrjqwQvaW0gv3x1N6/cNdIXtzzvWRAukP6gBKNp21ZCRTVqjrx4md3s=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7a1e02c-0899-48c3-2b59-08d58db2e1d3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072532C8B02AFC280651F2C3FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: w2crm9OxxUwNUQd9a4GLoaXeWXqPJSU3tMFTLa6ElaZ6bbCRPxgWVDX/KWbvkJGGYe2XiWsB+9aK+ytoOVtFX6u3kcrZJP3MdrrM+lQlYKr/gAhn2N+dFhTxu5CvKxjg6dJUuXJap3PAz6y9p2BeuGfCvam0ys6NARETXuNXZAwcS7YNraZEPUsiYHTqWlP9xLcenUMAWm1zTvAqKKdK2LZgAI0w6w56g84D9Uvh6qT3rZ1Zs/pHkorc82B56GxDAiq7zsgqJmI3Y/1UD/zcDnURV7kk4B0u5kX+qfvGIZ41csLCl5edJu6WMiq4RWQl76WIXgAOXtF4AlPwbtPtgw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a1e02c-0899-48c3-2b59-08d58db2e1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:16.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

[ Upstream commit 8e56133e5c7b7a7a97f6a92d92f664d5ecd30745 ]

clk_generated_startup is called after clk_hw_register. So the first call to
get_parent will not have the correct value (i.e. 0) and because this is
cached, it may never be updated.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Fixes: df70aeef6083 ("clk: at91: add generated clock driver")
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/clk/at91/clk-generated.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-genera=
ted.c
index 4e1cd5aa69d8..70474bd97a10 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -260,13 +260,12 @@ at91_clk_register_generated(struct regmap *regmap, sp=
inlock_t *lock,
 	gck->lock =3D lock;
 	gck->range =3D *range;
=20
+	clk_generated_startup(gck);
 	hw =3D &gck->hw;
 	ret =3D clk_hw_register(NULL, &gck->hw);
 	if (ret) {
 		kfree(gck);
 		hw =3D ERR_PTR(ret);
-	} else
-		clk_generated_startup(gck);
=20
 	return hw;
 }
--=20
2.14.1
