Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1512C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529C32083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NcJs1C5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529C32083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbeIGFcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:32:13 -0400
Received: from mail-cys01nam02on0116.outbound.protection.outlook.com ([104.47.37.116]:29216
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729841AbeIGFQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63gbotlpCfBMasCP4jL/Eax6743EllK2KzXd3Nk8hkY=;
 b=NcJs1C5xvF+RwvC+Wskv/HGttsmSaUG2evWTRblopNHAfrAA/padKAC+SW5XkpTr1Lc5dDNgFjX99JCbLcddPOLMEPq0O3pDf+U4t2/UtwdTZDOpLNwFvKCk2DHmL1cUTmvavHjCFvMLkz30j1oG4wplFKa4PG6La3eAACx5eGc=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0840.namprd21.prod.outlook.com (10.173.192.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:38:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:21 +0000
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
Subject: [PATCH AUTOSEL 4.14 23/67] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Topic: [PATCH AUTOSEL 4.14 23/67] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Index: AQHURkL5cvXfFo5ZIkiZbxEd+vIwdg==
Date:   Fri, 7 Sep 2018 00:37:36 +0000
Message-ID: <20180907003716.57737-23-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0840;6:jd3oRCL+FjI8zBrupavYkOJ/7X2M1b887rarLiO8t/u4SOPRO4fYtrGmavPWSS5Cm6SVtrRCKgbrdYciwzCKBHLsAL0dahcDLWobRVDWCYbtX9H1OV0q6twjQHPXfDT/8UFv3jKA4JUjzM2GBO+szMWX+YhbqwJCIWfWNHctvfnzScMIpv4kkE6/cEf797bG7O5DXsFOko/6HqV6Gzy5tCihRyo1Kte58YxTPZqgGt4okErspbkYJRhRA7LiDzeoF19hCAeCbVKQ/rSA++e6R1wOdjXuNlEgf9WthkNpjHo6L7iR0Vrq5Bd9mmzhmW4eH63U2Gg6AXByzsTPy9+5Sh/C1rFzuGO1YBlaK/G8PszQO+oAUENxvUMdrIvpw46a0pfNBU4Qd8l3mX6GmGoyMDskF0M5LHc3SNoCoHcid+kgRpMaCA+QA8SGG7FATzupe0wv7wnFK0HQjktTbSuXzQ==;5:jHXO5KowNspnQgajCHiIFw/pbz7BSorkt8UdKaQz6wIi2PBAS/IZJIUTHhkjZRhhOlJfofEEdKhh4ikNlhNJTJTi/kEHjjC2CRWLqofWMKKCD04ZTFi3thu+dfVgbhCgvGJLjmlT0ZdT/KJMJQ/IPEVLXFzT0Z4N5w0D5LGL0Dg=;7:5W0An8BHZJ9pKw2ZPPy9BtDV1WREH0VCS1fh6hsnaz8QEcdUVv4ll33Ifdk0EjoH0kxCzDZqRmtZCTSHFO35yTkLu8TmCJuV9gL7Uo6y+qE2smh9zHGzJ8v3BZm/jI2NBgDdC+N9Act6vnedznLK0ynyjSZiBaJwqr490TNbNEXS9u0Fm+P1DRKr987V0/30vReKHnxvPcjtWrxi/W5CsTFga6oDg3YiuxbSK923M0fJSv1WC/zpzgO+Wn/C4N1J
x-ms-office365-filtering-correlation-id: cd85682f-8e4a-4855-2003-08d6145a364e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0840;
x-ms-traffictypediagnostic: CY4PR21MB0840:
x-microsoft-antispam-prvs: <CY4PR21MB0840DA80501F2F53B0E1380BFB000@CY4PR21MB0840.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0840;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0840;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(39860400002)(396003)(136003)(189003)(199004)(66066001)(186003)(99286004)(26005)(8936002)(76176011)(102836004)(81166006)(81156014)(5250100002)(54906003)(6506007)(110136005)(11346002)(446003)(316002)(476003)(2616005)(106356001)(6486002)(86362001)(6436002)(105586002)(86612001)(97736004)(486006)(6346003)(53936002)(6512007)(68736007)(10090500001)(2501003)(1076002)(22452003)(6116002)(3846002)(36756003)(4326008)(8676002)(10290500003)(2900100001)(25786009)(39060400002)(256004)(14444005)(305945005)(7416002)(72206003)(7736002)(478600001)(14454004)(217873002)(6666003)(5660300001)(107886003)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0840;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Ujrr3iH35qE4RcBZh59a0pTbfw6S1SM+AzNfrJ37QhDjLV8Uw/BMewhT124LmAM8U1RNCUbLzhWmsnfLTqNtgg9/sRkxsiHS7yHRu+u+vUGD8YhdS7zpAGaKc+OnzAOGlq/7SdjI3AfSdKOAAflKh3gbFjCBm0sNviVoV3/EZnW+EsDtBFIQb9pWUyfIaOq6GDq1l/fh4Zo1ZILn6DRrItL1Nj2SZo0XrGP7GuX0b6CTIfp5V2tZRaV8BBnafkBIXdIlak+LvHEmF+z3g3LPDzY4UB3NugxGQPZaid3++VVMbIIR3P2HjPhBkuL/1cE/fLfNcvGKdClEINd3MG3RsRHgwPu2mJYJ4Bklu7RMtlg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd85682f-8e4a-4855-2003-08d6145a364e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:36.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0840
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
