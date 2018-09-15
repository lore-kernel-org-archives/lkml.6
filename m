Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B66FECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C931E21479
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TWaY8eXv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C931E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeIOHG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 03:06:27 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:63424
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728526AbeIOGrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuI35dqrTn8fmVlifC1iLxg5pp3LzKnfQ/s4b9+6GxY=;
 b=TWaY8eXvbQDaFHJox7n8njyjhtxljHhqFH/CsI7526u3F3hHyqaJhkg8KCNvomiDw+Sczb+bJw0yzqRgmYRt3i5XBKjZfA2tD71ejlv70sr3OqHWeaA7Xxe1T4YU/dfP8Cfm48P9gOsg+oSAMLcODZYh04alG3cS8oz7vkOfI5U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0856.namprd21.prod.outlook.com (10.173.192.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.6; Sat, 15 Sep 2018 01:30:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:30:48 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 45/92] parport: sunbpp: fix error return code
Thread-Topic: [PATCH AUTOSEL 4.18 45/92] parport: sunbpp: fix error return
 code
Thread-Index: AQHUTJOq00RmT4byKUGI2dp/yJuhnw==
Date:   Sat, 15 Sep 2018 01:30:20 +0000
Message-ID: <20180915012944.179481-44-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0856;6:ZSaQVwT3SLeS5N/JS4ImnNEsp7Qq9Gnp7PZjBkLDfdlPSeZy+7J5xflW4XAtDuarPjD62yaVvPfsmp1JkQKiPPDyPk3f8BLvZ312H0IZIN06SS8t5ESo+3N5mRB0aujlfdJe4lpu6FzV+5OkwxySdhGPd7k6j6tySKcUpa+EbnsL+LJAnKwNt48Hx8+Ks7d++Ir/q+tmZHG0COVOHUU25UQSaGnzoPM9UPc1vy2z0ALu1hPJnSOlyhev0KWfVv3iBfX8fgFtAtFwRFF/fIgnYta+vtKqMUw7GyQV0YBDqHpeyYOtINHzuULZM4uT/9wmFGxo4TlQ2GHzZOl1ttNR1umbOzkqgMsTJD5NWbkMaImLZe6W2BWdLU6lE70JhMGe+l3OlAHCGupl80fOffvi8dKHcOfmvN+LJo+Dck9KOW5It5Ont4qgiX310T4fUt1IyAz+i5Pjap5bJZS1f5bPJQ==;5:t9yfxY8bJdx32K0VQOBUoUM8ZhPDdAiM5SO63znDEt1uozu5hiu1tIip5OUMAzpIPJ0TMmk/dxaBZi1tGenuwCXP5Vdq1EdhvC8cIrhH7mJEaAPg8uJIxUhp7BeFprN6cocWMIxPX1FOz3Jj3UYvBUE9Po2UK1VTfOZ9H39g4ww=;7:Y6mV1b9H+J2frXizGLiL1bfgHu+pG57MZ/vJdMjAUYHpfAUsF7s1zcQNTUXwRiT7H7CEHEOF+2xbmU59WyzYFFWyqGYlu81vDs7PbUMm27VsTl8uhjn+ivuclknUXPbMSw1/rkOHf9mzaGJ5Hwd6Rgl3QyI+fe5vl1nXEYZK5ItvjdhZB8Hsxk96l3tZFv8bJq16VhhGJsw93m8igqKsBO7pCoirik9SgQDBNnNBTc4KtahDBW7l3OP+Oi8RKLkW
x-ms-office365-filtering-correlation-id: ffc22d8f-37e1-410d-20fa-08d61aaadd91
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0856;
x-ms-traffictypediagnostic: CY4PR21MB0856:
x-microsoft-antispam-prvs: <CY4PR21MB0856D51E477F50290A0B9CE2FB180@CY4PR21MB0856.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0856;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0856;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(36756003)(6116002)(486006)(316002)(3846002)(8936002)(22452003)(446003)(11346002)(2906002)(476003)(2616005)(6512007)(107886003)(53936002)(39060400002)(54906003)(1076002)(110136005)(25786009)(102836004)(66066001)(4326008)(217873002)(99286004)(14444005)(76176011)(68736007)(6666003)(86362001)(5660300001)(6346003)(8676002)(86612001)(256004)(186003)(81156014)(81166006)(6506007)(26005)(2900100001)(10290500003)(478600001)(7736002)(72206003)(305945005)(97736004)(10090500001)(14454004)(106356001)(105586002)(5250100002)(2501003)(6436002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0856;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 617yn9lbvfedf2CujzkBctGFnTVwmw12veI3wktM2qV3Epr2RVKKA18SxyHXIAE3rcfs/5dkPrMs0ZeNYRFrA6nmZlnZFp+G6pfV6qF5aHYbZQk05y0B9xdGmo0AjPTELQKc/HsxaZcaklBtQNwrTp955DP2f2nEJ8J8w9wTWRGZxg6NIz9iga801n8O4HEAzTih2jTAgoQoSj/C1NKUwEYVZxEUcpXvOnlExKEK0dka5fzqa7FjL2nzAcI+FWcyqoM85avvZ3FNqN8zRKePWOUeaiCJ3oK9Xd4QxWNRKFEDIksj9e0vVcjpAwQ0EyQbSbArILGthYseiCcaOv42kr8RWA22zvEAQOuTCIVIRvs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc22d8f-37e1-410d-20fa-08d61aaadd91
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:20.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0856
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

[ Upstream commit faa1a47388b33623e4d504c23569188907b039a0 ]

Return an error code on failure.  Change leading spaces to tab on the
first if.

Problem found using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/parport/parport_sunbpp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sun=
bpp.c
index 01cf1c1a841a..8de329546b82 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -286,12 +286,16 @@ static int bpp_probe(struct platform_device *op)
=20
 	ops =3D kmemdup(&parport_sunbpp_ops, sizeof(struct parport_operations),
 		      GFP_KERNEL);
-        if (!ops)
+	if (!ops) {
+		err =3D -ENOMEM;
 		goto out_unmap;
+	}
=20
 	dprintk(("register_port\n"));
-	if (!(p =3D parport_register_port((unsigned long)base, irq, dma, ops)))
+	if (!(p =3D parport_register_port((unsigned long)base, irq, dma, ops))) {
+		err =3D -ENOMEM;
 		goto out_free_ops;
+	}
=20
 	p->size =3D size;
 	p->dev =3D &op->dev;
--=20
2.17.1
