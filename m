Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517681834-2-4183859914846545342
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
    t=1517681834; b=Fxid66p/vxO+NTzi0unmGCpmpv9yxc6TBkTzLFV3iQ16qk7
    4WaiIvN4gdhLZFJQJp9BQTqkLbFEcDSCgNR9EelVNwy+CuxA8JXSpFth/1aIjw0v
    ohM/b0LOBG2z5WsQ7Q2wDluq/czQIAy1W2haonZxnRe2A7boah+ZZ70hanI4yRrW
    UyXfArSVYdWqtJmdftRkSk1Xj1huY4GGR07YClVXaIO8Wdo+LwHlPMbDhmhZ8QQe
    CIJJvMhIVw3IakbvB9ARitjLF5OnYyjLFNdOmdwQkYXZBaFzF6NfPPBp8j+YhqiR
    4Q48IQvsC6ThuWXa7QzDtVHwrK9XPsGkD/hCxJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681834; bh=tKndLO
    tyXxpRQ86VAVFec/0hkJUsh5vGIwzek94mY30=; b=JkklIz8ZIfZMKvHQtlfUQU
    PzzPfeOYP4hAbXFEZP5r5xgKpFeeAqJIXKh49jnUrm9BChhl3jcc+wmBJAUc2END
    zMCD79rf25EUrluZSFpThY264hnjbI2xIpkO0DAdnOjkTtPc56NeVBDOQUWLFRuA
    B2+wL6DzSWBbgdjBFCexpoj/MYv/PYKl1Qji9X2o4kvKGzJJsirseoJTAZ1kXf1i
    Z8RZu+Mtca6216WgGXcGdkO4nj3te4s7JdvCe+7iTrVRRarkK7oQstLeNTc706oN
    u1jPkgSFzAJREr7+vDZPMiiO4Wa8u/KKaU5PT2+AD+73SqKtWjhIRyW1MU7aunBQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaZQ0Dcm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ZaZQ0Dcm x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753799AbeBCSQ5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:16:57 -0500
Received: from mail-sn1nam02on0093.outbound.protection.outlook.com ([104.47.36.93]:35549
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753056AbeBCSG7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:06:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 28/32] SolutionEngine771x: fix Ether platform
 data
Thread-Topic: [PATCH AUTOSEL for 4.4 28/32] SolutionEngine771x: fix Ether
 platform data
Thread-Index: AQHTnRl1dTmm725KhkKnpftk0PSb4g==
Date: Sat, 3 Feb 2018 18:04:39 +0000
Message-ID: <20180203180413.7438-28-alexander.levin@microsoft.com>
References: <20180203180413.7438-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180413.7438-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1009;7:9DVIuDE8omTV/KX4+lPqBm8iii7WzOliHwMugstd3zLwa+qN8nDh9W0RJxwmsOUhNe9Btz0zoRZBZ+zbpmGKQx7MclPVv25aRKsqUMhwJNQkReieqed1ZM1NhXfK/c73Q+pDCFOzeHuR6Nt5wGUmBcdWBqZf7hCXGlMjFfUCa6g3wXPGMusJsAfU3vzBS0lUqxU1uRAM0iwt5lNS5p668FA3kWS6f6MNA3vazmmKubSu6hidf+TtwEua4qR/YVxn
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a92a47a-e19e-4d17-895b-08d56b30c85c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1009;
x-ms-traffictypediagnostic: BL0PR2101MB1009:
x-microsoft-antispam-prvs: <BL0PR2101MB1009EBDBB47FC62948660300FBF80@BL0PR2101MB1009.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BL0PR2101MB1009;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1009;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(39860400002)(346002)(396003)(376002)(189003)(199004)(6346003)(1076002)(26005)(107886003)(186003)(25786009)(6116002)(3846002)(3660700001)(105586002)(2501003)(10290500003)(99286004)(2906002)(3280700002)(5250100002)(4326008)(15760500003)(66066001)(36756003)(81166006)(81156014)(97736004)(8676002)(8936002)(54906003)(110136005)(72206003)(6666003)(86612001)(22452003)(53936002)(478600001)(59450400001)(68736007)(5660300001)(76176011)(6486002)(316002)(6506007)(102836004)(6436002)(2900100001)(14454004)(305945005)(106356001)(10090500001)(86362001)(6512007)(2950100002)(7736002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1009;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: jZ7iEkt9DPZQ3YbEjwxvVGQoIR1mgCt77QV7SVYCdzgd2ueA33YrXvsYIVd+gqxe84XRTpmr6mCkw2yMMgG/tA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a92a47a-e19e-4d17-895b-08d56b30c85c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:04:39.9714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1009
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
