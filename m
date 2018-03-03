Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520120573-5-14816963633082576535
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
    t=1520120572; b=dvvnr4uFKB490hitPwKg5SiX7dS0HZQdJIBj/yXKEwifN8Z
    DteZ9EDF9TliZ0ZRyZKX8On+5sPqde7SrW4aSGbiiiXqJsUx08+uCTEKoeGmatBr
    k2GpYfWKIqrcugm8zBzEa3FYeVZjGXKuFjedkXmlnaY7LPyNzeS4mpofI6bFy00s
    ZQvmJqRZkVupVNfucOQT9VtCevVuRiOH7IWGEa3kqKHJPQfaO6RDSNWZpWyxsWg6
    bT/YUF0AkBtdnRwd4hnjM+G0p13qEtxX2DMb6R2gR1ZQCILxx/RZK6AgoIgDl9yE
    /ZqhJ1grwIzvA8qxMqm0JO16juMU4OgFzGGwzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520120572; bh=nLunRG
    9GlO+0FqCEjJtcnbVSsZu5lHa/4ouHUpjNlnc=; b=LMmbRTK6p1ISfqa0Ve+E04
    i5+bh4KJIzwRqrQdk2bwNrks8WalpIXD7rS/wFBxWab92mRsfKFTQu0Q/WMkSAg7
    xflzU+AVBpwjrDt9/43gJ9uqTGf2n0SLg9GyOjUKAYo0alHPb61KMTIMh6ZmOkDu
    SSzBs3YC1h9ZDxkjqyquAdmM0csRUlnEE44jWUL5tOm9iTwL3EBxlYhieCt5NXOX
    gvLVUlEQpMl6M7o/ZI7LwsFSJ4CzsIkEizGn5hJ7CKuPq8VWoejlb69Z/lgCdgRX
    68DGiy5QVwsJolMfq5YELQlmX3Q7if5b4Qy57Ay3X4GkqptcYBwKku6N5hw3zocA
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R0hAtVd6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=R0hAtVd6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeCCXmX (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:42:23 -0500
Received: from mail-by2nam03on0119.outbound.protection.outlook.com ([104.47.42.119]:12016
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934013AbeCCWex (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:34:53 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Liam Beguin <lbeguin@tycoint.com>,
        Sylvain Lemieux <slemieux@tycoint.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 127/219] video: ARM CLCD: fix dma allocation
 size
Thread-Topic: [PATCH AUTOSEL for 4.9 127/219] video: ARM CLCD: fix dma
 allocation size
Thread-Index: AQHTsz8MLcrdqcxaNUaaJAEsZXsgYA==
Date: Sat, 3 Mar 2018 22:29:09 +0000
Message-ID: <20180303222716.26640-127-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1068;7:GMvY4eOVs3gZTyXqx05L8rRjwFz/FcwWqmb1VZ4v/sfAKOG1BlC7IyAhnSsNzybbJ9PZvhItGojgs0IETk1WUR9PJDOONHtIviC3+niLH29SjVQCyC4/NZGcvtTEtMydp7iAjU6pB8KenRuq9zUYVNNOyxU1IRz4bJWwgy0xsPx2t3XbpSJgQD3CFGgtooSnGLnAaza5h3xYD3drrEi1D85fhBwL0je428inTs6me3AuUv6nXNV+VCxBvpSh/2nY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 330ae9a3-e0e5-4c6f-e222-08d58156f7da
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1068;
x-ms-traffictypediagnostic: MW2PR2101MB1068:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106889E332486568BAEB6CA8FBC40@MW2PR2101MB1068.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(224015291044879)(21532816269658)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1068;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1068;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(199004)(189003)(102836004)(6506007)(26005)(66066001)(4326008)(1076002)(105586002)(10290500003)(478600001)(72206003)(86612001)(14454004)(186003)(2906002)(2501003)(305945005)(7736002)(36756003)(3660700001)(5250100002)(25786009)(2950100002)(5660300001)(3846002)(2900100001)(3280700002)(6116002)(106356001)(22452003)(97736004)(316002)(81166006)(10090500001)(81156014)(8936002)(8676002)(76176011)(6436002)(110136005)(53936002)(6486002)(54906003)(6512007)(86362001)(107886003)(68736007)(99286004)(6666003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1068;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Qg7JLPeMcBZ1/YJ0AjAZzhsO5izupQBNc9NSmF103vAFgj37YFhVZP43UVgj2Mggoit3rQNVqa8NtyuY9QEWREoUWJhNdiXszo1Et0HVoEEWjhduFHl9aw9pJyYSanCI7p4NbUvALIFcuaBb9wg3aT5YcVwcQ8JxgK4hKgEpECo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330ae9a3-e0e5-4c6f-e222-08d58156f7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:09.9632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1068
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
index ec2671d98abc..89880b70cc28 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -892,8 +892,8 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
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
