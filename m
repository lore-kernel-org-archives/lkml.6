Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492373-2-13607061916525567694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520492373; b=WO6cXQIEG8H00IirMdF+KBLLXV60E7ZMY98EIfdijxB3FaA
    gjiCJFgFxkijXn1P1g7lZxJsr2eli43Cn1n8j2/USubXdh8tSS9nO+6r6rY6OPaC
    Aujfqv9la3DZdkWI4y0gs/0oXdJu/hZ2u/k9UQAUcNM/BqWrsv4DoGnxtvd5Bnfz
    YmqqUrr32j6KxoJygRr35WXPpylD8rjwnZWGcY7SKjxY4Fq3EksMPQz3TNcluE1A
    LCnIgLglQK+Jf1O7nDGwv0lJMHyUgpSUtrfBsGXgI9RlJQrWmM3Htb03wM415uvJ
    LaCtpOklv+NZJwrezr20IBsaTd5GKbwdvHHUVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492373; bh=hv+Rj2
    8jMWPhNp2fd3NUblTZQGsEyY8tGJLrUOhHw3g=; b=wFL3sQC0R9X1fGBBXqUsMR
    qTGrys6C+tWqwL/GeMEcnv6ZgRzk5t8UabYiDSBQimF2wpywtWG0u0ky5LMT7Gfx
    9/CsLqB2FmF2HzP05XBaNwrGspsz5Mt9TuHNCCnTVsKenA4HeLb+8qumYgLkHpMl
    HdyEnkk/Cz0reRbc63KK7dFhuKArGWuVcQNgiOkGz8diIuyOTilnO0OxVDqKwr54
    nNoyPzXP/5MuYPIaUVDtuVkk28qhnJ3kcdhUjvoReFdOkWeXDEplY912Q6Pz6E2H
    RV0s6ehVZLSE57SrJeobYugjFWqjSCJi+36t/0oWRpotNXI+YNKmgk8wIPUDWyWw
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CmxZmwNN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CmxZmwNN x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935005AbeCHG73 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:59:29 -0500
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com ([104.47.33.102]:13054
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934996AbeCHE5W (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:22 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 47/78] vgacon: Set VGA struct resource types
Thread-Topic: [PATCH AUTOSEL for 4.15 47/78] vgacon: Set VGA struct resource
 types
Thread-Index: AQHTtpnN6nzh2wXVu0a1clSHkQFCqg==
Date: Thu, 8 Mar 2018 04:56:22 +0000
Message-ID: <20180308045525.7662-47-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:d/2H6mGL/i73QCdFfEY/wO1x0Nyr0SV2eNS0XhyKG9hctQHjkapDMB9WUSjjFANqB7pXAE7PeRkLiQFrHhGq75kZs4w9PU7obvTt7RxLsHg6T9h6mNLP6yYr6bhEc229xn284DXo+odYk6oTkwQn+Kgwp0TVhz2reoKljeP/nE7JZN7MAA4DaV/modlIT0YT3Ec7JkyrlUhRdmzezWMflPV+vU+AYDGL5dl5/EwIae6ld1cntW4HzRH5nhjMrNkY;20:D2KekfnVXg+1tmLvSJC32xTRwp+0m+bkIiLuQYeMR0Rbb89PqkIbhERwtU4CicxY5252AUhSGr4SLlzn7BwzWK7FqyJjJ9SoWeGWo6C2pJVXOCrTDTOiEBVo0NT/nijnhRLZ9ucRs8CLK+8f4V+WutZ44q8sSp56+dMUA1s5TlQ=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c0695a7-7ae0-400b-ef67-08d584b10d9a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10796C7A83BEE77A90CBD121FBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(59450400001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 48eY+fbiWxRzssmyMMMAyYjIsXDxkn7v6VnuuFc/uSwBJgRSlBetSK3KOBCWMv+bcH4vpIibES3ZqPRMbkPLUwRdApYVRUFADE4u5TFTVvzdlzcfR57OyzUyBgVWbk2KSI1auQlCiXVT6t00BxBC45oxcodJ/2X1Pta8nSISYDj3hu2Mh/GyxxKOVs3MSBtSIE9aqiA0hDUWnvouwzH5479h/ifWucw5ukRRGN1G4gCWNuAiJqpQCH6aHVFEQgiPVjhxot1BBhLCd5lgS2KYqgaYitxFiO6d2wszgrHbaD0GagkIf31Z3yPAOD3Oa0rWjytjPUnnkrTBletGcfdx7g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0695a7-7ae0-400b-ef67-08d584b10d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:22.2524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit c82084117f79bcae085e40da526253736a247120 ]

Set the resource type when we reserve VGA-related I/O port resources.

The resource code doesn't actually look at the type, so it inserts
resources without a type in the tree correctly even without this change.
But if we ever print a resource without a type, it looks like this:

  vga+ [??? 0x000003c0-0x000003df flags 0x0]

Setting the type means it will be printed correctly as:

  vga+ [io  0x000003c0-0x000003df]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/alpha/kernel/console.c    |  1 +
 drivers/video/console/vgacon.c | 34 ++++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/console.c b/arch/alpha/kernel/console.c
index 8e9a41966881..5476279329a6 100644
--- a/arch/alpha/kernel/console.c
+++ b/arch/alpha/kernel/console.c
@@ -21,6 +21,7 @@
 struct pci_controller *pci_vga_hose;
 static struct resource alpha_vga =3D {
 	.name	=3D "alpha-vga+",
+	.flags	=3D IORESOURCE_IO,
 	.start	=3D 0x3C0,
 	.end	=3D 0x3DF
 };
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.=
c
index 445b1dc5d441..a17ba1465815 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -422,7 +422,10 @@ static const char *vgacon_startup(void)
 		vga_video_port_val =3D VGA_CRT_DM;
 		if ((screen_info.orig_video_ega_bx & 0xff) !=3D 0x10) {
 			static struct resource ega_console_resource =3D
-			    { .name =3D "ega", .start =3D 0x3B0, .end =3D 0x3BF };
+			    { .name	=3D "ega",
+			      .flags	=3D IORESOURCE_IO,
+			      .start	=3D 0x3B0,
+			      .end	=3D 0x3BF };
 			vga_video_type =3D VIDEO_TYPE_EGAM;
 			vga_vram_size =3D 0x8000;
 			display_desc =3D "EGA+";
@@ -430,9 +433,15 @@ static const char *vgacon_startup(void)
 					 &ega_console_resource);
 		} else {
 			static struct resource mda1_console_resource =3D
-			    { .name =3D "mda", .start =3D 0x3B0, .end =3D 0x3BB };
+			    { .name	=3D "mda",
+			      .flags	=3D IORESOURCE_IO,
+			      .start	=3D 0x3B0,
+			      .end	=3D 0x3BB };
 			static struct resource mda2_console_resource =3D
-			    { .name =3D "mda", .start =3D 0x3BF, .end =3D 0x3BF };
+			    { .name	=3D "mda",
+			      .flags	=3D IORESOURCE_IO,
+			      .start	=3D 0x3BF,
+			      .end	=3D 0x3BF };
 			vga_video_type =3D VIDEO_TYPE_MDA;
 			vga_vram_size =3D 0x2000;
 			display_desc =3D "*MDA";
@@ -454,15 +463,21 @@ static const char *vgacon_startup(void)
 			vga_vram_size =3D 0x8000;
=20
 			if (!screen_info.orig_video_isVGA) {
-				static struct resource ega_console_resource
-				    =3D { .name =3D "ega", .start =3D 0x3C0, .end =3D 0x3DF };
+				static struct resource ega_console_resource =3D
+				    { .name	=3D "ega",
+				      .flags	=3D IORESOURCE_IO,
+				      .start	=3D 0x3C0,
+				      .end	=3D 0x3DF };
 				vga_video_type =3D VIDEO_TYPE_EGAC;
 				display_desc =3D "EGA";
 				request_resource(&ioport_resource,
 						 &ega_console_resource);
 			} else {
-				static struct resource vga_console_resource
-				    =3D { .name =3D "vga+", .start =3D 0x3C0, .end =3D 0x3DF };
+				static struct resource vga_console_resource =3D
+				    { .name	=3D "vga+",
+				      .flags	=3D IORESOURCE_IO,
+				      .start	=3D 0x3C0,
+				      .end	=3D 0x3DF };
 				vga_video_type =3D VIDEO_TYPE_VGAC;
 				display_desc =3D "VGA+";
 				request_resource(&ioport_resource,
@@ -494,7 +509,10 @@ static const char *vgacon_startup(void)
 			}
 		} else {
 			static struct resource cga_console_resource =3D
-			    { .name =3D "cga", .start =3D 0x3D4, .end =3D 0x3D5 };
+			    { .name	=3D "cga",
+			      .flags	=3D IORESOURCE_IO,
+			      .start	=3D 0x3D4,
+			      .end	=3D 0x3D5 };
 			vga_video_type =3D VIDEO_TYPE_CGA;
 			vga_vram_size =3D 0x2000;
 			display_desc =3D "*CGA";
--=20
2.14.1
