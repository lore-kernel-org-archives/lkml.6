Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117290-2-922736218310068540
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
    t=1520117290; b=DHMd72QsGAj/eX0HAaij626qxn4EQR1RDyF54PDtSZdJL1J
    +c0mGEMMgpUlNg6O6LVj+xiBCxswBnZzZLLq3lDdntxlZsnuhtR1z8WGAyOHOtBa
    rwI/4Ln9JtsnrPIM9Q/tHeVSKWe09CME86wdZhdLKzEdyH0UhrrnJPu1AR9M3N3A
    ZfnVsUN9ntcmZc9drk0QikSUS4bn6K+Oy/OOKPbYIMmuxXxJv+UBq6RxkbIpw/XY
    jJe8Iy1XZ/3z7xu59O+VWkoZH2FUJRYLd0H7gkCVIOmMStxzfhcHnsgjlROvDMXQ
    X+2tioZttcils1R4xOLMgpnaDZvbARSyVatcUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117290; bh=DU0WTe
    /wg+Z5+dSb3JBXyG/w81hv77Lg8pVkffHk7gU=; b=k1SUR7yXbaTMTbu+txgEx0
    BdLwLs/PmYdxE6FBtjWNHKQf63ISCDYzIRhLPXCq1AKraXWx4RxIQaUKIHd/RhyP
    nzJt4gg3m0e6ot4wPA1BFKrOq1mcs+ukJgC/bni7XA2HyYL61xK0/V4V/Lf2RJ0C
    mG0eAtRuRkBPdQ5rGDGdvna1AIkfLUotuXPJdNf+0Aud2fQYrNCej3YknBo66Gdl
    RXCo1DLUU88noAn/SC2mAWtO82zu6s77Vf3BLvaicwrMMYZe8hHh8+H270b/bolJ
    BaaMEtr3mvrPqj4aodtXXmKL4kg6n1B4jguVnGuG/+pLqmkk1fjMDa1ZNv0dRGNw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CrKGSSOe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=CrKGSSOe x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935522AbeCCWlw (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:41:52 -0500
Received: from mail-by2nam01on0129.outbound.protection.outlook.com ([104.47.34.129]:5824
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932258AbeCCWlq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:46 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liam Beguin <lbeguin@tycoint.com>,
        Sylvain Lemieux <slemieux@tycoint.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 35/63] video: ARM CLCD: fix dma allocation
 size
Thread-Topic: [PATCH AUTOSEL for 3.18 35/63] video: ARM CLCD: fix dma
 allocation size
Thread-Index: AQHTsz+oVlKBhoFcEkiXqe2QO+398g==
Date: Sat, 3 Mar 2018 22:33:30 +0000
Message-ID: <20180303223228.27323-35-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:BLaNKUm2HbNazHHrmvaV0isxyF6Z2yIuQEicTvSJU4zOQWemzjVV+/XuliKRdELmWgskuseTIi0T/k8u1b6gOyOcSWbi8wh2mi3dsrUhsVjFIrYGoYMnzDy+QPc7igwGEyB+05QQbjCQxdT5cO/5JTIVIWOukbp8+Bw+JBilLWwInBTT4JdVEn1kWrF3ng3GmZQxdKUkazOqLRKehMGOY2JxF6DWl8PDQ4FeSKs475oTaN4rI6gxiU8LgpxOjmFE
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 014261ac-d8e0-4a1e-478a-08d58157f077
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB065A5C7BB14345041F00B8FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(224015291044879)(21532816269658)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(6666003)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: cDuDKd7bPsDVUNRR8X1N6/zZgCpeqSRSTGboR6KfO+2hWKEJvwvIA1R7LB8bwq4fh6JbYRLv8VH8KLBNc2V8YgzcMmfbd2AGL+drxxbXba+TNNWIgxyJu35GTRFikvPslSQ4uZW8/aUuInLE9T56Ka3WkNAsFAp2CV1CclD6L50=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 014261ac-d8e0-4a1e-478a-08d58157f077
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:30.7476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
index 6ad23bd3523a..7fd2f3f7ef7c 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -757,8 +757,8 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
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
