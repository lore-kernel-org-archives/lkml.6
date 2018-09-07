Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74555C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D63620844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PyYdC3tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D63620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeIGF1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:27:05 -0400
Received: from mail-eopbgr700105.outbound.protection.outlook.com ([40.107.70.105]:7696
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730686AbeIGFSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63gbotlpCfBMasCP4jL/Eax6743EllK2KzXd3Nk8hkY=;
 b=PyYdC3tccy23lbPgcsyk3uxuNcPlztya+NXa9X/U5KhqdQbLAarrO/YNtVHY30H4rV6xtsvZCYHJRV2QclZRQ5pMbhFxvYQnWAlwbHoEbJnyv6VD9tgbCGHc9GrsraocOTgk7OMxJUI+etWmNi2s+rlHFeVIQR2cHgKXyfwrjpk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0149.namprd21.prod.outlook.com (10.173.189.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.7; Fri, 7 Sep 2018 00:40:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:40:42 +0000
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
Subject: [PATCH AUTOSEL 4.9 15/43] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Topic: [PATCH AUTOSEL 4.9 15/43] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Index: AQHURkMYSmCefvi2DkaVtvUKsJpOnw==
Date:   Fri, 7 Sep 2018 00:38:29 +0000
Message-ID: <20180907003816.57852-15-alexander.levin@microsoft.com>
References: <20180907003816.57852-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003816.57852-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0149;6:nERjt923oRbHw5RDJlQ7FDKozOIRn3dnuEo5eMmw9JcWYqaKbIZz9jTIRgKF2tymkh7cDQh00iTT+TCWeA/uRd9x0FE1hgTd9vM7qcWxXTWOJ8LhWicSXhxjbjtsDUWgNf3cVVjuNg0WXmYdTZZGLzAzAmPO0gHUYwgnP54hg3cEehFTj9reWd0CrPxf8SoIUqYaQPdkX5QpZtpQAD7hR1IPqnrdI6FbQacmdmEUbGpdXOm5Pz2txOjiVkla70hiYYx3l18YNg0e46JysvOTDUzT/b792IGD+VBYRnTx0aTD2sjXOiARn7nHzZOk6kq0840g4++rISRhSa8AkvYm/UA/TiMPJG2H963mDz56LCFEp02h2i9vfR/RCjdBXA7EtfgNc3f/pY3spbb8QSMBAmC56nKtIswosDUhZfPo8YrgOYxjZbPwlCLMtX4bR1Z/APk/zRs9Bg/YmyOvJGwtNw==;5:VMX1SQr2A4JAeF7mM4mDNETiv4YztrJGUSvOndtM4zoznRFlkBHzZ5ne5i4FPvIzFs+Z2WfIWPkFZAAlzuHL+BuNpwyTWanlx67iz8yWxdencaJBUmWJIzcViejibJleiB5iK3s9CcJTwhcXV/aP5xdVcyRgmlu8Tz7t8OQzoOw=;7:63h+0+ryvvg+PuLm6ZjLy/3W4p6Dlu/hTyw1psLE328d5mqnh+tGqBd29vmeTRzwxRCifRKb1LewSuJlA/UJTqULtmnxA9JirKAE3Fe+y2XfsAx8o4HA99qdxVpW9hiPgVwh8GZM1WzSxGVkYonrNyq/KtA25cdvVEkQI1GGuJJshUnkK4vQmeCP6gp5sMEftfJbGruwclNS4xLklEfCdJaSPL0i4XH8foSVAQlapGqub9oLlu/GiXYsf6pe9VZk
x-ms-office365-filtering-correlation-id: 43a619d2-ffcc-4b65-f88c-08d6145a8aa7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB014934FEE23054C7E9D65A1BFB000@CY4PR21MB0149.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0149;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0149;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(189003)(199004)(476003)(2616005)(105586002)(76176011)(446003)(486006)(14444005)(6666003)(2900100001)(256004)(217873002)(66066001)(22452003)(1076002)(6346003)(316002)(86362001)(25786009)(4326008)(26005)(110136005)(102836004)(54906003)(86612001)(107886003)(39060400002)(6116002)(11346002)(7416002)(5660300001)(6506007)(2501003)(6486002)(5250100002)(14454004)(7736002)(8936002)(68736007)(3846002)(53936002)(97736004)(6436002)(10090500001)(6512007)(305945005)(478600001)(99286004)(106356001)(81156014)(2906002)(10290500003)(36756003)(81166006)(186003)(8676002)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: dYQYBU+XnE6jEG+KkICkxnpXMGpwLpnBZ8EjgDpLW0ooOxj01IC3a0BrkXNaDe/544J9Yeupiy0ldupFfm3QQYLjom2lkh4tHW4CSfy+5Lfg+UZ88vfI2N5x1l1ZpwKXXIIrOTLzUtBZERamIQGSEt0B/JJqjgF9ZKCEPIrAoMTcQcAYW7Amls5ZG1K8S0a0BFBWTnfo85TjZk7Igz/kd5GkxajXZriyzyRRqLUWT/RMycNbTKPigAocUlN+Tu+OP+DykS99UzetsTUGOS015KBXBhZRSq1dJlfkFMZmZvgLtAMDwKwBH4Yj5qe0aNPo6zbf1Ad1YTMt7L+0+HSHJKQDzLoaKtWCw7cNit3wF4U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a619d2-ffcc-4b65-f88c-08d6145a8aa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:29.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
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
