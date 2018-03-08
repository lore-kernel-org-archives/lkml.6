Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488224-2-11713787663966522475
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
    t=1520488224; b=UosEq5GqkxkkZ4U1wpDKk/Zfl6jSgnoFD88CViIOVxuVSWd
    idapWadr+cj7CNXgdxl+4nvFUWkRX1otRsaERC4DB/lw2YLQsCr5HKBTgbpm8zPm
    CBvRm2x2nlVjX2jhA8gMr6SIza7/XVUFQlavpKDicJ32TlM62EFqEpoBs9C8RqIB
    Nmuk+9pqFWlEu6V9iI41q/EsqbKw69DQ/5kU1HfUZzQz9nKNDHc3O/1usKqzMGu8
    f/dOdqVSFXl4jvvt0OKviOgHdqmPdMe3qZXmM/+TNCdYRwL0fgb14OKpYNM4yYD5
    eqSt2tbP8EUbyt9dWN+SaTCUumoYsDcJm17OhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488224; bh=PpKh7k
    ebZja7zaRZYm06WLE9iL1M6E8xAIYmZTFMWvU=; b=sRIqoVod2T6Kz7C6Rmy4/A
    5zfhXNUfR57V4GeC+Di7dZzVoZjx2FECW+SjspFWZ3l4xObyJt3yMm7ZxXmcOLK3
    mzqnhKZQoRZuDDtQXEVDjEvrAPzClcjdRcoUZk+erK0Dkg3ByuEI1vppBgCcja/5
    yYgqp5f/gVHKYSx4l6nFiY9srOxAn5igk7IJWBwRpQkzQHMSuwfbuc/ixkh7kEVy
    VUy5LZaGNlEaWWcyxgf2peThQRdHG834mr5UY/Q4DGaRA1u6FUCfKDAHss96/sx7
    NVq7xqahBw1BuTh9icGA3gYm/fV7PilRGhMKHkgpTN15Y1e3kLm251OhBYHrdQ/w
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eOIZKtFQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=eOIZKtFQ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966594AbeCHFt4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:49:56 -0500
Received: from mail-co1nam03on0138.outbound.protection.outlook.com ([104.47.40.138]:38775
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935427AbeCHFEV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 175/190] vgacon: Set VGA struct resource types
Thread-Topic: [PATCH AUTOSEL for 4.9 175/190] vgacon: Set VGA struct resource
 types
Thread-Index: AQHTtppVUgokl25qSE27ouueT8WZqQ==
Date: Thu, 8 Mar 2018 05:00:09 +0000
Message-ID: <20180308045810.8041-175-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:RREgD2Qliv44N14/fwN4SK35tnY3HlX0mpjmuXJ8yb6DHRNoheP0DbkbQSrIZPQ5xLNNLNg4HMJptnpWvYPMjmwmFp7WnfU38QoviAH0nAmk69Ebs5lVj6Hb15qp6d2TzfJVvKfdDpdaJi3mOA17l6pSAWWPRgAoz+ooB0zAGe19sfpNWudjBaoxde25YV93qhqNsAokRqWUfiRwrYabV2w9hh6jh+Shs2X9qByVWdlMphEOeZhg+MwYUXpeNRkq;20:Q2R44NxNwka/lM2IVrT0dbqnAinD6VaFI5nLz1g2KKirVMiY0DtX5oOXN5ItUqWowwqIJE/3HH6XZbyHPcztF2f5j5H/GLN+5mIELTqbckQzqbuhdU0k/RPuCo4qft5jMRgfmX28Z4EGtr0qfVvPZN8UIxuhn3fS/xxKRUZpo/k=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8112cb71-7105-4b27-2abb-08d584b20cbe
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09191B69A408A6D9AD59A892FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(59450400001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: J2gsBsDi5tTwrP0cDjxpqwAJJ0YSXMXtdgbY9d6CG7S00Y6kZQP1Op16ZXF5HDYT2a+vav/5pTf+eXI+w6BxzdO6qoFSGNBX50WuJNYfrpAqdquv4D2H6cdbkw1CJES+7cXO9w3yJHcbSP6DHXY7v+hxZC64qME0H11ABMEZHVQrbZ6iQ6SL+P4XWdQWuSIPRQUSZ31oAy+sD/DSKAys3sPw0slAazaCxVrBkDh9FKePr4ofJ4THEI+FbLwcwcGRM4FYkUwq60FCxHtj2lRzn3BQCuHrz98iuzdtu0/SzKnoUO7GU1U9mDn+F920YDXI5Hrk9UGS81FdzsygUoSYuw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8112cb71-7105-4b27-2abb-08d584b20cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:09.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
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
index 11576611a974..dda1c4b3a229 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -405,7 +405,10 @@ static const char *vgacon_startup(void)
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
@@ -413,9 +416,15 @@ static const char *vgacon_startup(void)
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
@@ -437,15 +446,21 @@ static const char *vgacon_startup(void)
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
@@ -489,7 +504,10 @@ static const char *vgacon_startup(void)
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
