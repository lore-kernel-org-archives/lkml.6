Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485151-2-14775534499231854914
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
    t=1520485150; b=mZKtFvHDeP2SDa/g8VnErtCTf6SnSLFSMe65AfsL0zmOAME
    IVQNoUI2iM0rZV1bBzfaH/amxJ87RyiLQ5FbYxOB3WECNEwKqfdOgXS5ZYmzlKLa
    SjaRREE+2tKrjJ9bmbo2ajhkQXkfOX8rr9XQqqEsa1hIqPyf1b+47OGRpLzZuBXZ
    hvh7QQeUfZWV1ecg7XgNWqMoeiL0xPwb4WK3/E50hGmNWzrVjSBF0IvjrXIHsQ/Q
    MltrVP8DVzZFx07G1zdCDY8rM648wbe64Djt1QXLuFVme0fWGcGzxIGQM8JwbqlM
    /b6MsAhC57/CHSst2NwWqDsUV60iDzDA+mgPBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485150; bh=hv+Rj2
    8jMWPhNp2fd3NUblTZQGsEyY8tGJLrUOhHw3g=; b=LLHrs6yejuf1uJ3xrx9Ded
    Oeeua/yZBlASbFejNC2fWkW3BG5tXCVOE3UywYg544StP3kbskx7EasjaDmtuHQP
    jU/WZ5n7B3Fgi/x9H4g4o8fUbuRcpYEkzV4+7eC4KEd3RzGzT+uSskDcJIM4+M4u
    7vGJjniHXgIF+VlQmfaFjQG6d7H/87hb8lfxGwhtR/aObFvvw4E/VEfGTf+i76UD
    URtzF4TSMwPUHwSdDzaQAW3i08a7yszdz7G4W/MAp1nHmswJTILKnlwlycxTSCMa
    /cSJTrbrm6k4bJNgxGgutRpeqUfxdUY/Q71hc+kBFie2/wVDRLB/Y8sP9Z0D3Ecg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V9OSeY1/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=V9OSeY1/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935348AbeCHE7G (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 23:59:06 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:61147
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935357AbeCHE7B (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:59:01 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 40/67] vgacon: Set VGA struct resource types
Thread-Topic: [PATCH AUTOSEL for 4.14 40/67] vgacon: Set VGA struct resource
 types
Thread-Index: AQHTtpoBDOV2xT9m/kOS9QAvGUgG1w==
Date: Thu, 8 Mar 2018 04:57:49 +0000
Message-ID: <20180308045641.7814-40-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:61eHJCOlyiikz9d/lCZYaKXarZ3AwsFVlmlVruuDgTJWdKpM7eNT2uC3X7c7wHjlqP0JQnyiWK/hsaNxq4oOaNBX6YdP0Nl44S2OBmTMO8vjOkZDHTG061sIZ0an1spJxvez7Dkaw6U3gtp0iF5FnI6ZE8u8+TKRMPJJ3sgIjjwU3NtgoeUS1pbsNo9d5rjOqJs8qzWt4ohhZrtyHpyWf68smYOODQeYrL1jVH8xKCbNggmAnrfOqYQATXWI4Js6;20:/Hxy9IuBfoXo1+QPSjAZNrbKeuN65fK6L/STF20EHZ/LRycPv4C3ZJS6FWLrJ/xseNkRE5TjTSYxwV97NO2H0fFMWCuWy0YCEtw0PSW42Os2aGyli4f/R/lZCix/woksSUsHnaeobQe4beLgtZkeKEPF0IEpe1RiezI6MdxnTJw=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8940cf2d-3085-4ff4-a790-08d584b14d0a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101585E19A9716BB5E555BD1FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(59450400001)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: SbBEjW2kLsojt2J3a4J8GEIYj6ZxuMmRNTL8acB6TFbLrTmkPIgvt/AgAsKUWV8r/eRUMO2/AgZZrbgb6UcupWr7nh/XNSOmkSiKBF4SFdeTzIQEkeMQb0xiviXj3BAbhaGpLPWEfw/907N2wiDtqsaULFl1XGdc9FMgLWrN1E0x/SVEIT8qlXS4YUaF4sXPPcUowPqJqdA1P9Df+oU5Wtkyt1Hnhohhtwi91OFIRMaG+Ou1Rx5wTcqeGOF2LT5MMVrA6B6Cc3PFM7sat7gI2+DVfNd1X1th4udxS3arBKJG5xBkJn/taO0z4uBK85s0nTntcw1FR0zUSgVD4KlaXw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8940cf2d-3085-4ff4-a790-08d584b14d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:49.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
