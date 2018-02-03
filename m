Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1483324-1517681266-3-12610343508048037774
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
    t=1517681266; b=D0fRpaKPJqKOp9A9bX7TsCKS4gpggOg6dSZ9zgQDfRwJ0BQ
    D+8rQAf15xvZBQOdPyQzxeuZaAFGAGk6jjkaZmNJ6WzfutE5wqgYPJvFlXe8dnmI
    91+qiBlk4LYXRziu2GAucA77dwiKxl8V/3y+NoQTMqXBPajw9z3bSRv3J4rIGrA0
    RwvTbfOlPvXelhxgmXI8FndhKp3+I9gNI/Se0Pd/dA7VgRRpORUO3KV7D/x6sL/c
    p1qPtGUN1WzsdMaAiyu18V82nsGT4GxJtlS/S8BBawNDinxwoPrSzVeloS/BFa4g
    y84tHXfCXNNo1wvFWKeUIOL9wH2B3WlTFa/Wxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517681266; bh=tKndLO
    tyXxpRQ86VAVFec/0hkJUsh5vGIwzek94mY30=; b=cbb82XNOG11HDZzpiATi9h
    9wwhWFuFjmrir4xzWlVNKyY6J6tn0ZiA4jC1AHdXaWNSoTWCc1YnLlcANtNESKBB
    M+zICaQZnc6kWBc+9s+Kg3nAQVcwnAA1UCuM/AveYTbn/XSbIs7GUh/nRMljLchy
    q+MBsfHhdsMre6vqo50T/NycGZxe2svbTHE6kPNSjBI8sSEeh3aBixDVk7oueA86
    bdwo6OeZi/8zN+0MddCLRZBH4M7KKkediS9xy9gcR3FBfiy4jtUF3KeLzq2V2E7q
    bGgLLhJVZavJlg/OPd+NmUXLXDpmfUAZIiyNKPdCce1o02DXuFDF59FhAnzoeJoA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RXt9WEkl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RXt9WEkl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeBCSHn (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:07:43 -0500
Received: from mail-by2nam03on0126.outbound.protection.outlook.com ([104.47.42.126]:45078
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753162AbeBCSFJ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:05:09 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 48/52] SolutionEngine771x: fix Ether platform
 data
Thread-Topic: [PATCH AUTOSEL for 4.9 48/52] SolutionEngine771x: fix Ether
 platform data
Thread-Index: AQHTnRldq6ihm1p2AkuOyhp1F1LyYQ==
Date: Sat, 3 Feb 2018 18:03:59 +0000
Message-ID: <20180203180303.8490-48-alexander.levin@microsoft.com>
References: <20180203180303.8490-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180303.8490-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1089;7:/D9qbUE3dvJ7XpSGxPHcDOIQ6ca0alR7ZoPox5Th+kMTCgXaSvbO5Ka6szhDFzwUnDNuRMOEyA8qhSrwAgX4Ut6xYYFxRf1zQkWs0kjWjZCbzFXOpMnGQ3CPMGTKoNQ0dvutWILfgNxYz9wheoIZr2LJwhmvG5nA5uxW25F5DfbRUllkeYgKaNrK8H6eP/9pqU1KG0YrHGf6c37KtDceqsLJUh1+YXs/3xZ86k0uCOVFh15/4trIe9Isni6+jrsq
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a82898df-996d-49a3-059e-08d56b30a2f8
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB1089;
x-ms-traffictypediagnostic: BL0PR2101MB1089:
x-microsoft-antispam-prvs: <BL0PR2101MB108909FC288A48C351AE2A21FBF80@BL0PR2101MB1089.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB1089;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1089;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(39860400002)(376002)(366004)(346002)(199004)(189003)(86362001)(106356001)(22452003)(4326008)(97736004)(25786009)(2950100002)(5660300001)(2906002)(81156014)(105586002)(3280700002)(8676002)(8936002)(6116002)(68736007)(81166006)(3660700001)(86612001)(2900100001)(107886003)(3846002)(1076002)(102836004)(26005)(6346003)(66066001)(10090500001)(76176011)(6506007)(10290500003)(15760500003)(186003)(6486002)(14454004)(59450400001)(6436002)(53936002)(72206003)(316002)(305945005)(7736002)(99286004)(54906003)(110136005)(36756003)(2501003)(5250100002)(6512007)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1089;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: CEwRvijmuHPwIDxGhs/qTQ4Xpik5rhuXSx+YPXwdHax87kI1D5KKV2QzTe8PVyu2oi6NnqqwNxcJf4t+DSscGw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82898df-996d-49a3-059e-08d56b30a2f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:03:59.5964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1089
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
