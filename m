Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490E3ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E00DC206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="FXxK99H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E00DC206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeIOGxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:53:01 -0400
Received: from mail-sn1nam01on0097.outbound.protection.outlook.com ([104.47.32.97]:53808
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729020AbeIOGxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txV1NNJ67b7tGm3RS53IgMkIFQVmtuXSCRsSOl7hGAQ=;
 b=FXxK99H6UUdhvUKqXjXs0FYJX/yKja0wzniCdQrIG3JFeCXUyfV9bYYsFy7pzrmDTE5rZM/NyfuKhV4DLfjcDan0ys25eYenVnkUzQ3kLu0eJHJYkhcHaFhXdlJp6NHA2rTBiLWtTth8e25ATTaGuvCWL62EKgPmyGC4a/id8wM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0280.namprd21.prod.outlook.com (10.173.193.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.5; Sat, 15 Sep 2018 01:35:59 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:59 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 07/11] parport: sunbpp: fix error return code
Thread-Topic: [PATCH AUTOSEL 3.18 07/11] parport: sunbpp: fix error return
 code
Thread-Index: AQHUTJRihrOgUfWlrk237YxP5jlO5Q==
Date:   Sat, 15 Sep 2018 01:35:29 +0000
Message-ID: <20180915013521.180178-7-alexander.levin@microsoft.com>
References: <20180915013521.180178-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013521.180178-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0280;6:rE1i0l8SlDa1f53PYywJS7FfZisRUXCAQHHEDQwLoxbat79TU1AHZfgLyMhVrdfZw4/GW5cXYEuEk8CD3oOJYXoLWyA6lbpISMqlTjgnVruvU2kzDluwt6x1sRX0B6aRNRKhfpjq9uBH+9GRlPT/uvWD2TNSmpKaHw/TKoFiIV2E5K4mwwX/30JjhZSWi9q0ZwntHP3lOqopF5rYdWAtBD+Dt9wMauX/Q1HKu/q8t8jfNDH08bb4ZcF2b9ZOlLo0jXpp25ZYvRrTYba0/uZPXA65LEy71Z6aGR5owOanZnOKUUSLpSwl7RameJFxzLP4KNtkmhe/S89pdtM4d0WLqqjmsGKMssN09kClkgaPJ7UbUh7r7R+WTJrNYdKX5Z1tZ6H9I2/oBHvfQkMRaKelQ+44uFau2u5tY9QHobzlAy6L1OMmCZo5WdLJ5syhhxeiWd54ziKLdnZqVbgfmLtphg==;5:7HW61l2wYYplaOAfIEM+En2Td9/qKGtCwXXsWYP6yG/OCEzOHFhVqbRNF5uYuWxsSpKnY3Xr3f55D1MVHQDcOUxVT1hB0+6Xx0H2mMqdtsjgEhB/ykiXba0VJ3PZlpj82PIAkw8C4US6by5ElP0QEpzA6lDeFMy+hS6tbBGb+fI=;7:xaIlBm3LTXu40ZXBiFgqBUXMtic2QOn5U3RV6v0DG4EFj2aiiq+2vt3iWjPopAqNz6+pn13ohVLjxW4LCvWU5GKTNNl0ehkaLo0xxknwJhB8gybNl8n4JPcMFd/Sn0oElRuARz1NudFskSCj5kOqyb3bJhdCz+SG25oB8/3cTGCgUfYHKW3m5vuq4U80XWXSACRmvyXYq+7iQ1MrBMQGF1l9u/mcvf+Fj/b1lL3uTP0P8aPfrR1rDcoB+WnbFgCF
x-ms-office365-filtering-correlation-id: 53e1b59c-0cd1-44c6-56ea-08d61aab96d9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0280;
x-ms-traffictypediagnostic: CY4PR21MB0280:
x-microsoft-antispam-prvs: <CY4PR21MB028046F244F9FB8364494985FB180@CY4PR21MB0280.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0280;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0280;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(39860400002)(396003)(199004)(189003)(25786009)(14454004)(10290500003)(2906002)(4326008)(6436002)(39060400002)(107886003)(72206003)(14444005)(256004)(217873002)(478600001)(5660300001)(6666003)(6512007)(5250100002)(2501003)(97736004)(53936002)(6116002)(3846002)(8676002)(7736002)(305945005)(1076002)(6486002)(36756003)(105586002)(10090500001)(106356001)(22452003)(11346002)(2616005)(476003)(2900100001)(486006)(446003)(66066001)(76176011)(99286004)(316002)(54906003)(110136005)(6346003)(68736007)(26005)(186003)(86612001)(6506007)(102836004)(575784001)(86362001)(8936002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0280;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ggbjtDzid4ibEuvdp+FH0gEQwqTY5t2zszxrKB9qzgI8UiUgMbdX4iE1BdhgCO7u/zZlo+21Wy5/6/9KPnXFSspPk7fEOvIVwHREYQ6ODTxi5ehd3SXaBksB6i3/nIElPyV3I4fWzTFsNbKnoZgYw6thb7f5kaATTplJ9t04/FxuhPdUjlML05aTiPDEB30C8ZXQRqC0xUDPzOG81UgbVTn9AFqUMKFUzVxkY+2j90VuRKSvZFFOc/dS0Q/27WzF18U1oqIZ4PZxaPfxXAHAybhxRUwM7tmNCtXRrKPObDRq5qNm1ThgHtssj3bzXKfhhJzxWjR3gpytYNnK23fnNZ7IT26q10k1y/FqNFBXPM4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53e1b59c-0cd1-44c6-56ea-08d61aab96d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:29.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0280
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
index dffd6d0bd15b..634a243734e3 100644
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
