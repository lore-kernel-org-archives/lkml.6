Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4D2C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDF2204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="mw7D0a3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDF2204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeIBRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:22:23 -0400
Received: from mail-eopbgr680128.outbound.protection.outlook.com ([40.107.68.128]:38064
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728944AbeIBRWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEwB4BKU+PqkRmwsYHISjS72NpqUWhYRgAIHWkxvhgk=;
 b=mw7D0a3cEB2tI58o8S07SM6BjXCM1kbju40ht/9EL1DJo62Yo5wTz1z8fLfh+6uE4dD/TIng+FFVkssYc2ZjCRDkSD1N/0Icrkyg/vMOSomjVyQe6DmjNZxUesDG2tZ6A81T8VkFp3pxD7Hf7ioHL1wsB3q8METuChzC1Su6T0U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0629.namprd21.prod.outlook.com (10.175.115.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Sun, 2 Sep 2018 13:06:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:06:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 19/89] gpu: ipu-v3: default to id 0 on missing OF
 alias
Thread-Topic: [PATCH AUTOSEL 4.14 19/89] gpu: ipu-v3: default to id 0 on
 missing OF alias
Thread-Index: AQHUQr3EatwE2zKTvUaO2eF0unKYIQ==
Date:   Sun, 2 Sep 2018 13:06:31 +0000
Message-ID: <20180902064918.183387-19-alexander.levin@microsoft.com>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064918.183387-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0629;6:tnOSyWhJ0s7TwUD8IenjKXR0BUgvYMsUwEQVUcIN0Nxf2OdAk/yWqkIHothcvYap6+xy6vyiqamw4NKP3XbaWZTolbmd1xbVzGlEt67M8Xmd3eYdDkIyoqMcKduioBktKV9EEsbRwBQqvU0fjy0JtvXCtiVqZKibgWmQK7vsJHjx8KiJCssOlt6H55EZclis0JmghAxmOSrAY9pDi/yissQ3B02A+WQSJKreq45lxY+v98TPeO2ZXwuVRgzHNITOZbdCNr+NSiAorJHwtf5zvDo+CLsuVcpWgtFL5AfskrcQZk+HZBZQoKMUulWjw2WLWqirbB4w4rS01A87VqRJn7mU0MwLKtzeBSuEeAsalZw0D/PFYBMuLgN3Q++N6+UNzHIAuOX5P03KXCkPIatCfY4lM7yYiDFqhj/O5OFagVdWzrvO7Uug9yFZ/IxslBZ5pBsNLV1DVL4Surqj1xg3dA==;5:e3eUlBc1KLhgf/pZXNCg4v8X9I4wJ3dqfECbw2V0vDLUHhil0wELdFtmcJoKUoIdQGiGQ7jcxG2SnJj3Xy9l9x7mb+VhmexDuExao6KeXEsJ3KsUjZzAuowv4c3ulfDnAop6hAVbHef4JHpkCVTO/pJC0Q+/9r6nbg/EED/nZyY=;7:5il0BUIa4Zgnt+9emVuY/n5scnPeZJusVJg+Cr/UA/H6AW9NsyUP+yz3CrliVUG7lrvZzc69Jwdv/FSXyjQwaA1sFMP5+ck/8fuF73/YN9npV1X9cVFu3goQsX6ku+ESegiyS2vsLop1DodCUksfOckIp7xaw30F7FpG0/2RlghefngIWHaSLM6jomO/vgw65AD0W56wXz8Er1MDM6SdppQtsipmzaGNc9sTHiyzxLeD1VSBKvBf8ax0FvZiNJDy
x-ms-office365-filtering-correlation-id: 181eb074-2202-4ea1-b99f-08d610d4e73d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0629;
x-ms-traffictypediagnostic: CY4PR21MB0629:
x-microsoft-antispam-prvs: <CY4PR21MB0629BCBC67E933AC42387C41FB0D0@CY4PR21MB0629.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0629;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0629;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(6486002)(8936002)(6512007)(22452003)(53936002)(6436002)(66066001)(4326008)(186003)(25786009)(86362001)(2900100001)(107886003)(76176011)(486006)(68736007)(36756003)(99286004)(2501003)(5250100002)(110136005)(54906003)(106356001)(316002)(105586002)(10290500003)(72206003)(10090500001)(8676002)(478600001)(14454004)(5660300001)(476003)(1076002)(3846002)(305945005)(446003)(6116002)(217873002)(6346003)(11346002)(97736004)(81156014)(7736002)(81166006)(2906002)(102836004)(86612001)(26005)(6506007)(256004)(2616005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0629;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +uQo4eY2LN6jqbA6yPCvdyqMIF50VjXNHjE8iukT4HvmNJUShgd4303OtHBBeQoZQBd8Vh5K9JTtoXLRCpJH2ZwMZaYs79sY791rHAGA+Dr9gd6Yz56EGncuGPfUXhU4h3MVzamV7fCw+qWKY8DrtfZYWcJhn09pWpcDhtxT3MYrn81zjUC8N8PeGgwVb1hy+F94nTDYdUhV1MyAKxcB1YuzrgLZjE5oFOXgIFdGV3XD19GXnnQz5OlIi17FT4uJZBYdKbj+SqK+tmmDVlrOs7+8Oh/42jzLhCeI5Ki105GUUoYz8I8sFXliiDplmXSu/vqT8MuSn/6RBr5laPe6PjT4foURlGUILiC5tixIA2E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181eb074-2202-4ea1-b99f-08d610d4e73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:06:31.6255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0629
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

[ Upstream commit 2d87e6c1b99c402360fdfe19ce4f579ab2f96adf ]

This is better than storing -ENODEV in the id number. This fixes SoCs
with only one IPU that don't specify an IPU alias in the device tree.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/ipu-v3/ipu-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-commo=
n.c
index 658fa2d3e40c..2c8411b8d050 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -1401,6 +1401,8 @@ static int ipu_probe(struct platform_device *pdev)
 		return -ENODEV;
=20
 	ipu->id =3D of_alias_get_id(np, "ipu");
+	if (ipu->id < 0)
+		ipu->id =3D 0;
=20
 	if (of_device_is_compatible(np, "fsl,imx6qp-ipu") &&
 	    IS_ENABLED(CONFIG_DRM)) {
--=20
2.17.1
