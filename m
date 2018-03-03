Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118620-2-4337063102653079387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520118619; b=QaEgIMqGF8J/0hlqEv8dAMCZzYpc/raR9j9gIs2ibUw8mSN
    uLVJuF7v3JViElcYJJIbCz2mS5hsZO5TcA4MWMrHIn0m/ZMiJtHNj588xMeEnEBm
    wktdY2bmIo4wQgKswCcjlS4M0Drw1kfIPyNNIUTaxve8/YLga5yqusuAQt0N1yow
    7g0CYumE8WyucVLFg48UuB+cNSOB5LD0gfnku3mqingzKQr2KxlGk0Tzph9mPQzR
    LNUZLNlV+R+tnDAfVNgjh4K8eAyc/2IWC2HeFXJjgPJ1vlgWUxwPRN8BFr16R/A+
    KBrm3lzj3fd0kOqA9UXPyNOdWyQss9PjMVaA8gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118619; bh=S0f+qT
    vCN6YfLN9wRBHManjzSjTWv+9nI7OMuajPrfo=; b=Xz0afx7R0ZP95ae+6HYcm/
    kuxd33lSijNWq0c2AL7FPehtmdRT79zSlOpsoDKZ8gd0brL3/17V7u5r/Em3MrFu
    2WHHOFIuWqWCY7KvqoMaHZ4Y45CZ/L0Br9RVolvRkRclCWAA3OvrlDxkYe3UEY1d
    xtIpX25SO3UJmAEy4Ttqzq6AzN/AAWfhPNwF+GwesquwYQ/TgqwKiTBGxxudy+Ie
    wHmWTp4bhKWhY55GD3c0dd8ffS8Chl58x6dUyFYohreGAWJ5NmK+YJF8qSghDiiw
    f0/T/mSNNF27jzkfOlShnYW8MdEkNICd4pMCoZYTFTPO29mQYvrbSQmKJhbxd6rQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i2blHvBI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=i2blHvBI x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935101AbeCCXIo (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:08:44 -0500
Received: from mail-co1nam03on0096.outbound.protection.outlook.com ([104.47.40.96]:45422
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934960AbeCCWjz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:39:55 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liam Beguin <lbeguin@tycoint.com>,
        Sylvain Lemieux <slemieux@tycoint.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 063/115] video: ARM CLCD: fix dma allocation
 size
Thread-Topic: [PATCH AUTOSEL for 4.4 063/115] video: ARM CLCD: fix dma
 allocation size
Thread-Index: AQHTsz9d3MY32XLNe0OlWO8o7NRALw==
Date: Sat, 3 Mar 2018 22:31:25 +0000
Message-ID: <20180303223010.27106-63-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1113;7:vYuhiSHQ+3WdVUntuAZ/sEeO+mQSdaLxYXcfRoF53HeH/6tYvNlE9XKmubM0drfQU1fPoXDLfMEctyJ1lcpUkeOzzl/bDUIAm/THqhfkN1di8inRBKUNpOXsxvduoqqZFcqLtVH/aUyt9MdngFZ0qWejd4c5s+TVLB0wyqt8jhYuGJpDh2pj9SkDZAafy9Qp4reUi2/Ps46ObiJ/y1r+2G9mn/aPk6kIV1cAil3AwU/VVfdCH6JgAoAqAM5MCkDD
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8441b9f-9a74-4831-8e7e-08d58157ae7d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1113;
x-ms-traffictypediagnostic: MW2PR2101MB1113:
x-microsoft-antispam-prvs: <MW2PR2101MB11131525B62003F7B4C62C79FBC40@MW2PR2101MB1113.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(224015291044879)(21532816269658)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1113;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1113;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(39860400002)(396003)(376002)(199004)(189003)(68736007)(7736002)(10090500001)(6116002)(3846002)(1076002)(2906002)(5250100002)(6486002)(2501003)(6436002)(76176011)(86362001)(22452003)(6512007)(53936002)(66066001)(86612001)(99286004)(2900100001)(316002)(36756003)(54906003)(106356001)(110136005)(6506007)(102836004)(186003)(97736004)(26005)(6346003)(14454004)(3660700001)(8936002)(107886003)(10290500003)(5660300001)(81166006)(478600001)(3280700002)(105586002)(8676002)(81156014)(4326008)(72206003)(6666003)(2950100002)(305945005)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1113;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: V8UcyLUMgUKURe/8bj5iGxm/TGYlpZrnO3+toy9rupToAEKH1NRSGHsK93l6VpuH13/MRNDEQ9ElE/rcbJYYD25RLS/9bhYSHMNv4cGNhFuNbuDpI9onGuxsZmV5I4Oqp6vtEjb2fXiQKjLQpHQvsQLJKxHaWMPcLHTu1KgSb9I=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8441b9f-9a74-4831-8e7e-08d58157ae7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:25.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1113
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Liam Beguin <lbeguin@tycoint.com>

[ Upstream commit 9a1c779e6b06855e41099caa6f15b3b584dfa88c ]

This patch forces the frambuffer size to be aligned on kernel pages.

During the board startup, the splash screed did appear;
the "ts_test" program or our application were not able to start.

The following error message was reported:
error: failed to map framebuffer device to memory.
LinuxFB: driver cannot connect

The issue was discovered, on the LPC32xx platform, during the migration
of the LCD definition from the board file to the device tree.

Signed-off-by: Liam Beguin <lbeguin@tycoint.com>
Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/amba-clcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clc=
d.c
index 9362424c2340..924b3d6c3e9b 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -759,8 +759,8 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
 	if (err)
 		return err;
=20
-	framesize =3D fb->panel->mode.xres * fb->panel->mode.yres *
-			fb->panel->bpp / 8;
+	framesize =3D PAGE_ALIGN(fb->panel->mode.xres * fb->panel->mode.yres *
+			fb->panel->bpp / 8);
 	fb->fb.screen_base =3D dma_alloc_coherent(&fb->dev->dev, framesize,
 			&dma, GFP_KERNEL);
 	if (!fb->fb.screen_base)
--=20
2.14.1
