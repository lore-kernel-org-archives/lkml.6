Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC707ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CDB208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i3JReguc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CDB208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbeIOGwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:31 -0400
Received: from mail-dm3nam03on0128.outbound.protection.outlook.com ([104.47.41.128]:36672
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729846AbeIOGw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuI35dqrTn8fmVlifC1iLxg5pp3LzKnfQ/s4b9+6GxY=;
 b=i3JReguceYvUbqe3cQD4Lb/HK/UFH4l+Dkwu/q6Wx/h7P41vOA4XIhXvIQ3nRlyjfnrQA+FDuHAXlcS+ZSpsP5w150fd9RxDOR5+ulK7anUBIKpVCIf55ui3ml1aYIgR/ueSJzm/B3/my2yzhs+gUN8Lb/66NXrSA7PELlefoBM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:20 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:20 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 10/20] parport: sunbpp: fix error return code
Thread-Topic: [PATCH AUTOSEL 4.4 10/20] parport: sunbpp: fix error return code
Thread-Index: AQHUTJRXMAeZB++Jn0CCw6tfV369Kw==
Date:   Sat, 15 Sep 2018 01:35:11 +0000
Message-ID: <20180915013502.180110-10-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:IQuH6KbJU+Hsx4KfLHRDRdYdUQwEYPdUyrNpR/tOm0v1vLH0/uoAa9Eoc/6jv40EIHrBGqd75Snb6+d8z2/ISmwtx5+Z3AktrMMXbzAsMDiTe78UWUY62OyFTfcmI5vy02PBCHQMtdsnVpTQauEHET/TfZdBcnF3Oj82yzmQ0dFVuuFCxf2wHzf7rYmugL6k4MjTnHcg8RZvAKfQkp+01KcC4ATLvvaPqLItXZBfdCZE/2oShdlSC0cPMMa9fq+Vu7pKc7zA9hS0EvTAcat+fun9GUp7JD8S8cGRrUo5GG9LYf+Qs4feA1SqYXFTC6/mzvW32RiO+s9MPczFWTK6MNFwhGqGiNiMU0j66MXPK0MhlMOD4veZJPuBouAYixwV5m7Ed++7uvYUCjzZ56PyqGZ2a+kF4Ow18a7foCkQWQaIzp/dvLuxBl8YwLw/JFOIgL8Zb9wJlvAcZZ/P53PwVA==;5:XE1nWhMUJDPvUEzbjj8UJrI+qSwHWqZdqLDUkzb63Upr83d6n9SEFlR9zNn060HOzP0AXfm59YJTy8xeB4XCOVR3wCiQMBNanmSbVVhds79w5crUrgXBusjBXsntMoqOSJWq0VXFzxxVBLu8Dmbiy1vGKLJrMvupH36YAhsivkY=;7:FmZa8GbztUrG4B7gfyVte3xVDuWLixzFH0/u0Wym3doBekJb1ox9UlABwOCsd6APY7YnYQye0eaoNC/h9ghrYeAM1x50qJ4GQBtyIzYh1bEF9SiHs6nNXd1iaHE+LZzqBM3cjtDl+KS+HsbCFyv/ugr88DVV8SEN+75X8EYdIP0Fx2/ng604tKLTsvv7JQNCofokIp7eZJoV4in8e4XU0cEREHZwVN+v+swO7IOItb0XcYHYQsMwKv0Af1vhuVn7
x-ms-office365-filtering-correlation-id: 4562a223-aa80-417a-f01b-08d61aab7fda
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB018109C62F945042F897F9EEFB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(39060400002)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: vOGnXI1MEb41PWUMUCK/yBM0zacixDj9PwTEguktk5tdsYzpjV7iM85i09uHQxavomg7/U0x+NS1hYPDkynNhFtND6MsD8Fj4zEkn6ZWl6ucpD4FMQsJ7zI7EUU3XQ51UXNQNcB22TNFRBS9/DYcgK/ZefNZ8d+Rj6xoRjNfe8Ht3M4R3SswPkw6UOo3I7UegC4Fd+uCtbZ+abddvNfDo65SWW4aBbRcZ1hmbnxYTswOCf3k69k0PG+q1CevdFGUI+zgj+GxirgL4ddBt9HkHhXkSFTeRbLPoe8PDyJ6lqkkIeAw2D17gH5nmI3F9YYoHMEypCwdX8J6v6A8auwY7BhhuiT5lchGyIyNy9BaxME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4562a223-aa80-417a-f01b-08d61aab7fda
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:11.3790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
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
