Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-912290-1520485920-2-2006454905246411406
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
    t=1520485919; b=JAZHDzlOwDoA5brDxZSLrlY/Fs0M32XY+S1sYnxGy8Q54R+
    h3uw/8njrUt41wm0lF5axDrErf2Xqt3fY/f93g6UDoD+5CEj/tzoJuMb8BwpxKE2
    Ztpc4cLV0qMI2nNGgM8EEpNtw9YtQUlSc0Pm4C1siwbXYf3eQfWsCVmgT+lrIXiG
    CoS4jIWeBLghPUs6roU1UbeAwExpvrP7uFstZM2OaT4qNm8JFRXLHsagjT9gdfG4
    wpR68yYSUO/mr36iccKy0nQOyFe+UAFROUwFQHOG2d15weok0zWOL/H8XMqi7BFR
    32ESONnZnWM32nKA/7dNJaXG1Ljs52l2A+vKhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520485919; bh=7WD48J
    GT2Jj6PB6GfFvF8mHU9jJy06dDp7kr/885ES4=; b=j6GcchWuzwefw/4uNhPl4C
    N25vtiATg2RSNpPQCCHHjbeTFPryvnc4jY2emcZF/LGeAJZPTDuyvqgrdJjaUSyp
    kFaxyfiOZi7IKZi2JstTS1mYzQ5QUMftRwF3z6O//TLmHr9WXWzDzXN6hu1sxngm
    9iZUo2p8DLh7GF2MTBDbbwuh9lymZNPJ3BAPOYPSJIM+w+PHk/0cXcZNwLI5sGtG
    sjSn7eI/zoTpEy8SBRpmkYtFCOpmOh4YUYOjIHKDfNZM+z2GKtM6L5JDTisgRv50
    Ems6Pdlcn4bVzkkJee+7BChtJx3ZyFJNV6YkVjhMZ9thFbk5tsRIHaFz8CeWagzA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VXMN0vm8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=VXMN0vm8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966954AbeCHFLy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:11:54 -0500
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com ([104.47.41.132]:45039
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966937AbeCHFLv (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:11:51 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 50/53] vgacon: Set VGA struct resource types
Thread-Topic: [PATCH AUTOSEL for 3.18 50/53] vgacon: Set VGA struct resource
 types
Thread-Index: AQHTtprMgxkQ0Hv2KUCfpShIeTt7xA==
Date: Thu, 8 Mar 2018 05:03:29 +0000
Message-ID: <20180308050230.8876-50-alexander.levin@microsoft.com>
References: <20180308050230.8876-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050230.8876-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:lNS95dvxo9SfkZbePsmdFS80m5wJOqZvuVi27OhdQMDapzKUHrUhTsy82XyXZF3ww0nBUlmSy7xqIQAO1XyRRQYH/VyDFkdfpm/FHwovKHCIIcOkkpZfeSdwekqwnimQMDesfYCx39N5Nn33n/tWK4ocwxXacHtuKnT4z27/FDobb0S+8MDgWdIzEjwtbuXt5tLd0mBAyzZKqVMcz4Wix38m7O4G9qk+cGf9xdX3+Z9S08JZUeAXJFSJN2bEvCUy;20:t1FSYQfln5YJ5K/rWhaTgQlzba5oQrojfwU2JCa1Vbq9uNP3gtplFQI/hJ0Iw8Rvw6J4TCheY3mFzyi30q0h2phOq5uDp5zd7KqKI5was1ZSXGuWHf4bA7fLWTPahZuJ+v4Q+e5FVWOoyV8rmLBkEjjeZSmQlz6ymP1R+WSgc64=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 470d189d-1fc6-4378-7d8a-08d584b31816
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1112C4ACBFCE4CD766EB8E24FBDF0@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(376002)(39380400002)(366004)(396003)(189003)(199004)(54906003)(81156014)(7736002)(86612001)(25786009)(81166006)(6512007)(6486002)(4326008)(3846002)(1076002)(6436002)(36756003)(305945005)(6116002)(8936002)(2900100001)(6666003)(97736004)(66066001)(2950100002)(105586002)(68736007)(14454004)(72206003)(3660700001)(478600001)(10290500003)(3280700002)(53936002)(106356001)(10090500001)(5660300001)(102836004)(107886003)(316002)(59450400001)(110136005)(22452003)(86362001)(2501003)(5250100002)(6506007)(76176011)(99286004)(2906002)(26005)(186003)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Iz7T0DN+aGmfSmiGp+c7mtjd96FTnQ49Q6ty3UmyA+MRDRrT0lP3jNOv7F+uS0PQa0KNpGCniba49wtZ5ThNnwFU+ttz1kKXSFMnMBWKAlXkep2CRVXHGoL5LBuJX6OzlQAbhDPRhZQEqgBTtM/O/ZC2V+yj2hGh121+ntPic5rqCB/cuSNckBY6cVWoU3PZSGqoP+aSLT6QkH0AGmA0cBfXihEBvDGFkefleEU3a8pqWAvoL8KOiu2yV8PUSIc1dA9ckYpcfAjhIe2zOEvGrzn1HNJUjLQsRSxLwVMp9Vo0M5ERqhQZMd6p2Yv3oT3XxFjJpQSSS/tDbVN5lbzE8Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470d189d-1fc6-4378-7d8a-08d584b31816
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:03:29.4582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
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
index 6a61deed4a85..ab228ed45945 100644
--- a/arch/alpha/kernel/console.c
+++ b/arch/alpha/kernel/console.c
@@ -20,6 +20,7 @@
 struct pci_controller *pci_vga_hose;
 static struct resource alpha_vga =3D {
 	.name	=3D "alpha-vga+",
+	.flags	=3D IORESOURCE_IO,
 	.start	=3D 0x3C0,
 	.end	=3D 0x3DF
 };
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.=
c
index 517f565b65d7..598ec7545e84 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -409,7 +409,10 @@ static const char *vgacon_startup(void)
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
@@ -417,9 +420,15 @@ static const char *vgacon_startup(void)
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
@@ -441,15 +450,21 @@ static const char *vgacon_startup(void)
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
@@ -493,7 +508,10 @@ static const char *vgacon_startup(void)
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
