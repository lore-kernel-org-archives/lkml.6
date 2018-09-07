Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A31C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F0C2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BL04BZl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F0C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbeIGFTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:19:55 -0400
Received: from mail-bl2nam02on0090.outbound.protection.outlook.com ([104.47.38.90]:11972
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731032AbeIGFTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63gbotlpCfBMasCP4jL/Eax6743EllK2KzXd3Nk8hkY=;
 b=BL04BZl8uWjqo9Sd8MmhLnuXuaxF8xsnQkttA52sI00zjE8AcLGW9w9duK7MQ8xzDPjXvQrX+3CPd5EhdJ4IcWL8eIyISSh8ZB4ljojJPU7Q+kTJy2/3viCrGCyhYrAuaIVygwhSdO6Xx/o298KvsF4R+bqs8TG6A7z4koic2DU=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:41:29 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:41:29 +0000
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
Subject: [PATCH AUTOSEL 4.4 12/30] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Topic: [PATCH AUTOSEL 4.4 12/30] mtd/maps: fix solutionengine.c printk
 format warnings
Thread-Index: AQHURkMtPAbrOe/D1kuFWxrlrWvxPA==
Date:   Fri, 7 Sep 2018 00:39:04 +0000
Message-ID: <20180907003853.57942-12-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:5YPqUqDKze0/n/qXfbm+9ra8MdB0IozL9YmDMgtUMoWf3ktcS8glZN7luXoVs5JJTINLINFxrEvPBJkbFGonykeLtjz+KWIB4xLzd5glZHqPH/AuaBSMVKwo0jrNFyUMG0RjdFKDhEB2EKlU0+d4KBD/fDoKGmXjcADS1OoNFMoVYCy/Cxf/51AvlbQA4ZCtFKJz/JKn6mvmdP8BrxGaSiGcbaobAMG/gI6/213GiIztOc+DS3r4R/PTKbrCWAfRTQ3iNAoaQBMTKjLQqpRaP/Vr+N6rdV6SLRUQV0NDffIb5xcIl3e/rPZbrgRH4oxMlDphv6j3HK59M4riLp3Pjf2UjEHphZFcNIl9DMqJFH4JFjg4ZiBOEWS7drZ1s20le1K03A19SWAITjfIHRZ8BDKPSj2atJgbMpNDCUkJFSbRa7VW3Wne7p98JD7/5MuRchFtclrIguZMverZ0zggoQ==;5:DsM04JH//GOU41P+jU5gi9jIhpPERW/zse3ao0YF1oYfEMVnOM7yE34vLtOPqjoryJzUuuSjvLlkOu+lp2M6f0yVeKjdcqLjYukIPqCh4tHL+/nOffQFgv+yJ0IPkkITZPjtCuJLEPFAVGjyG+p8p1N2bcdMv++uLeK+NfVJjTk=;7:vUvLfoiCHNXsEkUZTRn4k2lE8e1/HqjxYV5ZtDaRx1rY19dt77UKHNXb3HwzCakhy37a5hKsQvxMgRD6kdzFe9X6JGkWUToC8gkg+v4UmTayiNUsHR40USXAAlCsmFJGW0CH6bJOEtjkS7/Ab0FeKnMpoPpQJ3WjbQZW+cK7LDCWMD+JqwpD21kfwTSUHUbHQQ5z0tp5j0VxpdsMl8RElmPpO811slq+YVAhNcT9kxdyrhsVuho/vd8FUP/Qjvc/
x-ms-office365-filtering-correlation-id: 6ca24ecd-d0c2-4f46-88cd-08d6145aa6e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757A610B924C99DB7E152B6FB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(39060400002)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(14444005)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(7416002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: BxxNkca0wmw8lqD3phTfjZ+H+Zf6RRoRTz1LybLQj8i2fSig6kM66zM789RS1SmMgxKkL5Oc8YSPSLxk5SG1J/GVnzwxSG851XqlqHgh3qdixnVHfajhhnkTJL1KCWaeOSv1m5juDGrndLSY2d36p+B1P2kj47kjhWM/lpvFBTkLVV6rIuE3qtchSPXWLFEfkQifNi/Q8Qx3HNuC7TRvXEb7tqkf71MaE6BEttCcsbgNqGNHxGqvWVRGlmYITB7T/E2t6SLZWLWbq3lVf1vhfcl8NegZQ9BFV2+VG+IqCEPxlRb+3ZMdJcDwim98nvA84VkcNUQ62VdxCcEXYeM89GRyE0sdpVL9lbhNXB+HN1Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca24ecd-d0c2-4f46-88cd-08d6145aa6e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:04.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
