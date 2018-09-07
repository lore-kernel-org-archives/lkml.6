Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312FBC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24A22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FAxAsDqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24A22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeIGFOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:52 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727770AbeIGFOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63gbotlpCfBMasCP4jL/Eax6743EllK2KzXd3Nk8hkY=;
 b=FAxAsDqS1EvJDj3YXtaddHCr61FbNwUC2vtHme1myAq6+TdfYIv0ED0YKIe1zUmz++wQ+Z7tPgzGKEwV/j/NV94IMrKYJ81SqfUap7qbWnh9rLpBqcFC1VM3GCRNrmQOF26wZN9nITycrqL+Ng+rgGlZqIiUM2ZBaFf7zQ4HBJQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 31/88] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Topic: [PATCH AUTOSEL 4.18 31/88] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Index: AQHURkLIX3d4WE33qk+zFgfqvSMi9g==
Date:   Fri, 7 Sep 2018 00:36:14 +0000
Message-ID: <20180907003547.57567-31-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:wFQifEeQrK1U0MItFssyA1i8OQdSbomewPKnOsrmHfRZ4E0t+yHIUh0MbqoR0E/eGX2meVqtyuXbKT4TlwtpFjO6YA8bC7h2Bd6JkhCNAsW6XMUwSQi2Iw6nadIlIB/6LSPc3C1Oc5Ggo9mMKmyQEZPX0ujVkQuzv+cBtRNKkU1OwMaT4J+ZpeDB925HXxwGOiD+lUuh7JBTyqZfUbLZu04yE9ovZslmHbj3xFNvM0sr31vjdUazdQn/B/rZjrsHyDJnhKZLx4Iru91PDtbCgg6wLKmfvg0ke+pbxonttn6nrWqlDqn2NQ1T/2fJY4GzIABkjCpKMaOI8G/o7QGCb5UL5n1QiJx0Wjicv00y2v9+xebbvyIVeT1/znysd7kf6Yf8Oe7KeEdjKdd6SGtprSn3mX0XK3WTm0U3nP0fB/npLyVpIUAP+JO6HLJYyhRk/qrvlKTrwcRsFhC9JpcaMg==;5:7imnbWRlnbp1aga97TR6Nh8YKy6HoJrK7IslfL5BrT3lYl8lG45UYQWQGXvbzbZ7lxwAAls6/ZjxHm1sZgMiM8glVfPY5sDMRzax8uZ4F9yOYnU8mjjI59Fw3DJ2Sb7giF8NjTTQGq6ir/zlOBxuJG9fb7fFaXAJkwG6Xetai48=;7:cky6t4HYdkaRkVoe6+kqffmrOMo+cl01A3hhREWbTXOFXOuoaql/qTCeo2qjX2Uu7eWbWtEYunBqB5Yy0mJ3snPPtF4uav9i62RUbI5/UZ/gyGLaj/2vUiRZJzUGWwQpU3cMI+C16NCrwEEjzICRbOdHuEXFV1m8HNFGOwcD2SGUytCx6yoJwZNvUOFEyzbJxnOaq1TPCoVu3j5fp/NEcKCNRmR2G0vyXL4ByqbsC0tXv/A0Pac5OddIJfAleiBs
x-ms-office365-filtering-correlation-id: ec74265e-2495-48c3-e1dd-08d61459fccf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469C0619F7DEC0E598FD92FFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(14444005)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(39060400002)(7416002)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: y3PB88uG+NL2sEG9IfJMHZA50JqO79Kh7CaSOTm+FY2xxrE6jCsq3ILPb6j/zA1s0KTnw0klP6cYuU2wY8BoWxCxeiUmxBRsDuGahF0R6j2jE7E023mOltHjwJ4tsBL8fhTIyzRzXrU7xuS8EDrQb4Av0ssyDJnD+jqq2+QiSkwIf3xlLimLn2vDCD5tN4cx8yxvNAuoFXpjda/Up0io8oOPxukn3Mse1h/zChzMk+cnwFGf2wuAdvdLh29uNvnyXly4JgVhhYSqNA9H9fuEX/d5/dUXDmCGuvEDoy2gjQvVH9vt8Y38I9wRn03hE01vUgKTdjmvKk0JNWaLZEaLX4LxdAEe4ppJ1YZpUGyAseI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec74265e-2495-48c3-e1dd-08d61459fccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:14.2979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 1d25e3eeed1d987404e2d2e451eebac8c15cecc1 ]

Fix 2 printk format warnings (this driver is currently only used by
arch/sh/) by using "%pap" instead of "%lx".

Fixes these build warnings:

../drivers/mtd/maps/solutionengine.c: In function 'init_soleng_maps':
../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument=
 of type 'long unsigned int', but argument 2 has type 'resource_size_t' {ak=
a 'unsigned int'} [-Wformat=3D]
../drivers/mtd/maps/solutionengine.c:62:54: note: format string is defined =
here
  printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n=
",
                                                  ~~~~^
                                                  %08x
../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument=
 of type 'long unsigned int', but argument 3 has type 'resource_size_t' {ak=
a 'unsigned int'} [-Wformat=3D]
../drivers/mtd/maps/solutionengine.c:62:72: note: format string is defined =
here
  printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n=
",
                                                                    ~~~~^
                                                                    %08x

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/maps/solutionengine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/maps/solutionengine.c b/drivers/mtd/maps/solutione=
ngine.c
index bb580bc16445..c07f21b20463 100644
--- a/drivers/mtd/maps/solutionengine.c
+++ b/drivers/mtd/maps/solutionengine.c
@@ -59,9 +59,9 @@ static int __init init_soleng_maps(void)
 			return -ENXIO;
 		}
 	}
-	printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n=
",
-	       soleng_flash_map.phys & 0x1fffffff,
-	       soleng_eprom_map.phys & 0x1fffffff);
+	printk(KERN_NOTICE "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
+	       &soleng_flash_map.phys,
+	       &soleng_eprom_map.phys);
 	flash_mtd->owner =3D THIS_MODULE;
=20
 	eprom_mtd =3D do_map_probe("map_rom", &soleng_eprom_map);
--=20
2.17.1
