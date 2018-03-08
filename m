Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-966195-1520486633-2-3346794531609511660
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
    t=1520486633; b=I5RPxGE3cxP0zJ5h8zFFurQiCFKlNeKTmUXn8YbM7a2eoot
    jGRj+Ath3sQjd2ptkoqbCkiDDceqitrmXgilD2RpA7kPyGCHMRbCiOoFs1JMr1ga
    vUgs6Q2/x7DY5WU+GFAi3v6A+NZCWgbsVPOf5UL71Z29nmtwPJ9IY18fb6egaUZn
    SNk+RKz10a28bEiKN15qoMN9RmAyythlPBWtemHhexArRMnL4PcNkmjeHjuq5xY4
    ekEvK7VelqQSNxinM7LKcBOAwutZkbzY3HrQBr77UBMahp6hZ2SW3jPN7R0Ujnf+
    Y1DePciG6aHA1GVljuOE9Kg7lswHczOjVjcqRTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486633; bh=7WD48J
    GT2Jj6PB6GfFvF8mHU9jJy06dDp7kr/885ES4=; b=HVjPxXgh4Mk0i77CdwGMpT
    9u+Z2VNVtchShNxLX/HnPzRJiyDdK3uMquDFk8d3xr7H6Eiswy8VeSdT6JWDMS17
    2hRuDgeq3oiVzJt/Gf/r1iD5ytbIZQFJ5+5K+roVE7LNizbPJ6f6X/RYJmD7oqBS
    GPfnxTxQvTRedrhIMmD2OiDry4hREAqqjSJs0aq90PwT6Sb8mqRxYg1awWWHARdt
    ojeoP0V1bpGrB1w+81FbH5dI39sk8UqMcNuqPQV5/nNiGDk9ad3BjGcfdkgWulTw
    wLbfNDm4uD/7NEIrlR6od/UL1alrND8olzfFOuyNcNV2FkxsPFETstDOx9Lr3/aQ
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GFDpNv7F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GFDpNv7F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966660AbeCHFIA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:08:00 -0500
Received: from mail-bl2nam02on0095.outbound.protection.outlook.com ([104.47.38.95]:56636
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966608AbeCHFHy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:07:54 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 091/101] vgacon: Set VGA struct resource types
Thread-Topic: [PATCH AUTOSEL for 4.4 091/101] vgacon: Set VGA struct resource
 types
Thread-Index: AQHTtpqe43D3eDL7OUiqysyGERtdwg==
Date: Thu, 8 Mar 2018 05:02:13 +0000
Message-ID: <20180308050023.8548-91-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:H29rkueXTNrX89sQuVT3oDMVGgkteiPsx8QRq7UWadFXEKiFUFHsJ++PvUI7C92jvXjg5ivsE0cJD2P32eLX8KxC5kEniSNnxJ11sudopFcLjsOy6VXb6P41XoLZqBlrya6oY5+yiCVTBGhdkUdaXlBaF0D30oREzBr3TByeIqqlJluWcFbMGERNjX0+RhbKpqVKv4N0uFfNdVa7v8WH+5jfCOoNKeoRDPuj/nQ6DFFR8CdJF6633w+valACuiWL;20:+9Hp+TL9wYC4G/oZ9f1MAktQ9S295nmSnrALtQsBVpuiKaxXKgwTSmr6G6Go/dvVORZjYROSa5c+aiTNXl+stz6vh9/lwymHREaNoc9MiVwy9x0SjLqNXurmiR1K46JfyrpbZUqhnzP2lxXxyaRLWNFF/IpXcsZSkbXXVoYTiQk=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b83855a-195f-4610-dbb0-08d584b2894a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0727EFBA12BDFAF9148CAE87FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211936372134217)(153496737603132);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: FPjjkCkLpeFuARtb9SU1Jn8QDHfPdRvfvqpioP+dMKws++6wM3kdus06lDwljoas0XTXmlW9SHKvu9dY5PucAdAASgfDaiFAhcNIWI1iZskNBzbZI1F4mluosiKxuQeurzzrgwVGZuiNS1+KOJhVki9qTwderHpkJkrtcRh/juyVnFXr2kx3gm+OWItY8I4MP8ycL/XcpixCkF/3x3lcY9wbFLysjvVJ8BegYfElVYjyNqmCrtIdx9tPZL93tQEtJNQcMsrZd7aoCZ28z2JRU2BKYL08tdpRAFDdtBPkKhIV0on3KqfbMUbsTWmxus/EmEGd1osxALPz9XqQt9TJFQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b83855a-195f-4610-dbb0-08d584b2894a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:13.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
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
