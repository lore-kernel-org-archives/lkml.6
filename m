Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576794-1517681998-2-9843477466207864511
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
    t=1517681997; b=f6S93mWhNSlKuDq/1967qd8XJ0pTxHY36jClGHCsjI9xrWT
    j3BUz+uI2LVzNj3WHG+fr1pE3G3ybW+kXJNWoCY8Ng8kW/rIFL9r5oMYjhiOBt4a
    IL1FhgEqRCIN4zTenC4epIBW67g96iCnIiXKgRV5LM+Zn7jPj2gAnIerCq7HcDmd
    uBnmgpexIUfDRVFjfLTE+oLN/6y90ku6kUxNR3ZCpG6hmm+kbsJVIcCZHWG9Biva
    9mdPKIt7GCqe09pGyn3eyrR+VzgChhW7/hxdy0dq3FxCZltuYjGdN5VT3wTR8c2L
    Ct6lHcj85HWnAUOCwAuzwxwA7PF/s084RpjY2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681997; bh=tKndLO
    tyXxpRQ86VAVFec/0hkJUsh5vGIwzek94mY30=; b=YfzjADzxmje6r+IjFCKtUJ
    UUIyQr4zUrN+idVMUmN0Vslk+QmwWC28kkRWnwnaenam4x3FElEwm+3FWTPP1rhm
    TkNpBo24IMdJ8qfz5MfJAF1dC9GYY7/aH3CacvtgWk/xz+C6YJ9egIweocUT83gY
    urjHKsWrQJ0lhsmd2tVeViRKONim6sNkD+R3HfbX8ePbmwskRyL2lQkv0BdGiyUK
    u10qQ0jljSAeu2w1kSkVh+3Vx0OPkC4Y/T0xBfq68HX2oG/DujbhtVQcxXdYl2Ty
    kdHsMapdIxIXjrAD04IP/mP2fuB6dOi0hhaW/KHhkolJV1zg5E266P3d5fGfjywQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XT4slA0F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=XT4slA0F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754110AbeBCSTz (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:19:55 -0500
Received: from mail-bl2nam02on0091.outbound.protection.outlook.com ([104.47.38.91]:39758
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753245AbeBCSGs (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:48 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 20/24] SolutionEngine771x: fix Ether platform
 data
Thread-Topic: [PATCH AUTOSEL for 3.18 20/24] SolutionEngine771x: fix Ether
 platform data
Thread-Index: AQHTnRmHo+Kv+u/wAEufHDI3Nn1Apg==
Date: Sat, 3 Feb 2018 18:05:09 +0000
Message-ID: <20180203180444.10801-20-alexander.levin@microsoft.com>
References: <20180203180444.10801-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180444.10801-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1025;7:uoxFeGAEXZ8Ii0EEWO17JHLI+hA049zn+TJTHwVT+0lCSsgcTbhyDabpyYUuB9c+kFH0Y3vVg2Dn2F6XeNA/Eskkr3fYTc1MrsEcW9AKRN4wK+bv5p1s/asMqz2u8xKs1mVHDg95t6/UwPBFpBgsOsAcza0MKyjUYdXGLie7mhoNuH65CkWuhPa7iLDih/k+Gw7rFY/cWS2kFIJQhN/XtU9SGlgbN3Rvr/x3BUJUUThTxtU35JNp8tQioYnTUEpX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c824b877-2b74-4eca-eb2f-08d56b30e33a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1025;
x-ms-traffictypediagnostic: BL0PR2101MB1025:
x-microsoft-antispam-prvs: <BL0PR2101MB10251B1A303A2C9378591CACFBF80@BL0PR2101MB1025.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(2400082)(944501161)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR2101MB1025;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1025;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(396003)(376002)(39860400002)(199004)(189003)(6506007)(97736004)(86612001)(6116002)(3846002)(1076002)(59450400001)(76176011)(2906002)(26005)(6346003)(68736007)(102836004)(186003)(72206003)(2501003)(66066001)(2900100001)(53936002)(6512007)(14454004)(106356001)(10290500003)(25786009)(8936002)(107886003)(478600001)(6486002)(81166006)(4326008)(81156014)(8676002)(5660300001)(5250100002)(2950100002)(3280700002)(7736002)(305945005)(36756003)(6436002)(6666003)(3660700001)(105586002)(15760500003)(110136005)(86362001)(316002)(99286004)(10090500001)(54906003)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1025;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: SmAZNPo/QJ6qUSzkca6w75svqLMB+WWeKbGLVTmbIxXfOFe8nRMAM/knVeIE/HpRHRmlX9mEhhaDSwo3rdLbjw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c824b877-2b74-4eca-eb2f-08d56b30e33a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:05:09.1121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1025
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
index 658326f44df8..5e0267624d8d 100644
--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <mach-se/mach/se.h>
 #include <mach-se/mach/mrshpc.h>
 #include <asm/machvec.h>
@@ -114,6 +115,11 @@ static struct platform_device heartbeat_device =3D {
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
@@ -131,7 +137,7 @@ static struct platform_device sh_eth0_device =3D {
 	.name =3D "sh771x-ether",
 	.id =3D 0,
 	.dev =3D {
-		.platform_data =3D PHY_ID,
+		.platform_data =3D &sh_eth_plat,
 	},
 	.num_resources =3D ARRAY_SIZE(sh_eth0_resources),
 	.resource =3D sh_eth0_resources,
@@ -154,7 +160,7 @@ static struct platform_device sh_eth1_device =3D {
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
