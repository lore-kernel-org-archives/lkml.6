Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517683414-2-13064636010500884411
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES roen, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683413; b=vrXF2TBzsrXrAuZCCv/tyK6nrHLKdPFG34GAbYON1bOWQtN
    0WVjZaWSbm08cyd8AoNVoi3wkK1xUabkt2R0VLYXVgGgDzn+t5ZcIfGZqfW1hps4
    AW37tQEUZ+ETfZ4xNUZfLsgYbl5rfEbqvlkrPZH4X6duhyhZZAbSDEMposn7Rhhh
    PfYALfdVSOB2TTx3UgippaFUy9tw2GbSfwrp15JtoF634HkpoTx4B0JiG+9wtvgP
    4/zx4tdus/uOCi+R/NgJHZ4xfNpJXba8kTr2/3b9MGnOCNMxqmk9qnK6N6y0ToJe
    j6Qx7vKTBzwT3kECBXf52EfMqn55nm132ozOwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683413; bh=7r5T8T
    bJnp6Gm1qa1qM0MT+GuxfT6df1ttcLhxO9bEo=; b=M3dRqbY/lMHS2qgvSqjpqk
    +J+d64ufX/6RM/e4W5xGBF2Jdk6WRFhgoy4z3FQBmJc6oiQ7ua8NL9PcuDSIwM2z
    2gFigsdmj9S1gRXdkg8BTOfyC2w6aRBwZoyVCN6BDDXq5Uv56Nb9zT136vLHWLnT
    6ahPWlsot48p1oyvOpEKUOuWgTNzzCZGy7kD8QBqN7bksQ0Lm1MiZFYwyiMwbCH7
    bbdy3DYYx5mEFbs3CsTXcrLwnvQqaOS1gksq/IjTJNLaXDWLaQNBb7YzeIRoCAFC
    PMehiSEG9htjZBhWLhCW+J65UncbgfvLjK/swYJie6Ne2BaBtg0bTy7yLtUa5Kzg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HKf6Iq63 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HKf6Iq63 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeBCSn3 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:43:29 -0500
Received: from mail-bl2nam02on0113.outbound.protection.outlook.com ([104.47.38.113]:13185
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753199AbeBCSDC (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 102/110] SolutionEngine771x: fix Ether
 platform data
Thread-Topic: [PATCH AUTOSEL for 4.14 102/110] SolutionEngine771x: fix Ether
 platform data
Thread-Index: AQHTnRkF8/NsMjezAECu33QWLaQ8+g==
Date: Sat, 3 Feb 2018 18:01:32 +0000
Message-ID: <20180203180015.29073-102-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;7:R7Ip8H7nTlOewNEMejPmySaQGuMkgpoiFLsjWg9jmSySt5ZMD/sZvuQT+k1xVaODBSbV8q/rYOzcLReji/e/L30/jNcNqq0L766JMZ6WztAEPACdonF4h3pgExkpPBKvGFqpV9fT2qjsxyrUULzPXjAfyvhg54z8gvypwkc6tmk4x4YMIHSnqRmu3wTHIPvR5U+s/bmUKZsFJk25scLNm8KLn9VWfTfE/B/M+iO7WQP9GpKK1Fv9RDTTHDBb5N/m
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9862d383-e7c7-4867-d2a3-08d56b3057d6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993A7FA03D7E7645F41D645FBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(15760500003)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: ltVt4+XcquEaeRw4++R06YGuayaVCUo6aVMsbbnbzxMHU3SFZumJTXBriG+zGqcg6s0lNCI8Vi+U6drbqosykA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9862d383-e7c7-4867-d2a3-08d56b3057d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:32.3315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit 195e2addbce09e5afbc766efc1e6567c9ce840d3 ]

The 'sh_eth' driver's probe() method would fail  on the SolutionEngine7710
board and crash on SolutionEngine7712 board  as the platform code is
hopelessly behind the driver's platform data --  it passes the PHY address
instead of 'struct sh_eth_plat_data *'; pass the latter to the driver in
order to fix the bug...

Fixes: 71557a37adb5 ("[netdrvr] sh_eth: Add SH7619 support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/sh/boards/mach-se/770x/setup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-se/770x/setup.c b/arch/sh/boards/mach-se/7=
70x/setup.c
index 77c35350ee77..b7fa7a87e946 100644
--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -9,6 +9,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <mach-se/mach/se.h>
 #include <mach-se/mach/mrshpc.h>
 #include <asm/machvec.h>
@@ -115,6 +116,11 @@ static struct platform_device heartbeat_device =3D {
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) ||\
 	defined(CONFIG_CPU_SUBTYPE_SH7712)
 /* SH771X Ethernet driver */
+static struct sh_eth_plat_data sh_eth_plat =3D {
+	.phy =3D PHY_ID,
+	.phy_interface =3D PHY_INTERFACE_MODE_MII,
+};
+
 static struct resource sh_eth0_resources[] =3D {
 	[0] =3D {
 		.start =3D SH_ETH0_BASE,
@@ -132,7 +138,7 @@ static struct platform_device sh_eth0_device =3D {
 	.name =3D "sh771x-ether",
 	.id =3D 0,
 	.dev =3D {
-		.platform_data =3D PHY_ID,
+		.platform_data =3D &sh_eth_plat,
 	},
 	.num_resources =3D ARRAY_SIZE(sh_eth0_resources),
 	.resource =3D sh_eth0_resources,
@@ -155,7 +161,7 @@ static struct platform_device sh_eth1_device =3D {
 	.name =3D "sh771x-ether",
 	.id =3D 1,
 	.dev =3D {
-		.platform_data =3D PHY_ID,
+		.platform_data =3D &sh_eth_plat,
 	},
 	.num_resources =3D ARRAY_SIZE(sh_eth1_resources),
 	.resource =3D sh_eth1_resources,
--=20
2.11.0
