Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B291C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FC6218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="Q3R8bTjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfBCNyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:44 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:53655 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfBCNyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,556,1539673200"; 
   d="scan'208";a="25801591"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 03 Feb 2019 06:54:20 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Sun, 3 Feb 2019 06:54:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kli03iGnI4XvlF6jyUxqgNvmC7VgUyqHnDwTf/t+6Bk=;
 b=Q3R8bTjkHY7pzOuIHQ1WFb7ecfhNo2PL6F7pgTYvoNDrNEZRvUtv76WerSlVihSUyiT9Y9IM1EYjSu4Rtm8NTjATjh/1KXZ/Z/0UsIegKNj+X/GHYsupvNw8lOIKBrhYf6hsJcy138IIc5GV0mnzLli9JChcso8ewvGQLDzGWS0=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1796.namprd11.prod.outlook.com (10.175.99.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.20; Sun, 3 Feb 2019 13:54:17 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::847:4296:13b9:fc9f%8]) with mapi id 15.20.1580.019; Sun, 3 Feb 2019
 13:54:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <frieder.schrempf@kontron.de>, <marek.vasut@gmail.com>
CC:     <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <bbrezillon@kernel.org>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: Add support for MX25V8035F
Thread-Topic: [PATCH 2/2] mtd: spi-nor: Add support for MX25V8035F
Thread-Index: AQHUsvE/uLZcIdsdoEKja5e7vSOivaXOKf0A
Date:   Sun, 3 Feb 2019 13:54:17 +0000
Message-ID: <4afac3e0-36f7-86a8-bdae-a6a9dcca5d90@microchip.com>
References: <20190123075538.12681-1-frieder.schrempf@kontron.de>
 <20190123075538.12681-2-frieder.schrempf@kontron.de>
In-Reply-To: <20190123075538.12681-2-frieder.schrempf@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0208.eurprd08.prod.outlook.com
 (2603:10a6:802:15::17) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.121.188.150]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1796;6:6QEtHeEXYrh20pUc6M4jMonRG9blZfWmmdlCFmk7xFLQ8V9UYHPZ0TJHVnBIYVwA+s7JZxEbJPXq2pALUvEXGyNX5eWa5pk4vV85n/EHU2A5NYyAm+CPBnEWtNtANgE4a36DCyfB2SVjlCN3dPFcsNuekBtOOz5QcBe3OHG8q16jqWqpVawWhEM3drv8VZilFYZQlyY6aTemgDL7KfgnaZokutUgmQPGrKwxraeLTIevmM5iomUhiSJ4yj+qldH9QQptiYuJFLs3Q9vheLuJFHBzI2uu3PDcUemyFUh1899pI/i+V0wSBqiyVsEW64zEs1gjPhXe2MuB25ujWPyKxEAxOKrZTTpOVdPJh+wfWdUoOKOjy5KSXRuw5Aldtb1dug5iYtzrJasFgOIcPL1cBiN1cmATy8sDsfTJgbSA6ist7oEQ0zhW5Doj6T5o67M3dBrxDX+emkq5JUC6MA27zQ==;5:zxyTvR1kCxeM4w3PRGl9R+AmLjeUDy61xGM4YblMWeX3jcA9BWW/pvMIUghJp9ESl3yoBAj/r+OfcO7f6KSeObONOfP81+dD03UgWFjDlVDBN025Ye2ni1o1gmBzyNoqBMg/CafK487vetId7y0m0prX7WOuwSzSZa53dfCvUE2Eh7OfXVG2FveFchtluO8bSY+UwHOjtWlwOlfv+WLXWQ==;7:1cGkfPMc2kBnzIe8AiMkl+yyFHH7zszyJh2D7C+OEfnJqzt8f2nKOkHVaw60IIYP2sTXI0RE8kVN2k34cNs1sYw092tXRZewqwxOj9hsqI1Xy1B+RCx41IYIb6h/Jz9tjhFJ5LeozgbaWKZzVvBv2g==
x-ms-office365-filtering-correlation-id: 5c53a142-4872-4c47-286e-08d689df169d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1796;
x-ms-traffictypediagnostic: BN6PR11MB1796:
x-microsoft-antispam-prvs: <BN6PR11MB1796AE5898B4283AB9534FBBF06C0@BN6PR11MB1796.namprd11.prod.outlook.com>
x-forefront-prvs: 0937FB07C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(346002)(366004)(136003)(396003)(199004)(189003)(478600001)(53936002)(54906003)(446003)(11346002)(3846002)(6116002)(110136005)(316002)(305945005)(2616005)(7736002)(476003)(186003)(52116002)(6436002)(4326008)(76176011)(229853002)(256004)(53546011)(6506007)(386003)(102836004)(6486002)(26005)(71200400001)(25786009)(71190400001)(72206003)(99286004)(2906002)(14454004)(66066001)(6512007)(31696002)(105586002)(6246003)(39060400002)(97736004)(86362001)(81166006)(8936002)(81156014)(68736007)(31686004)(106356001)(36756003)(486006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1796;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0QkyjmvW9tI0dWPghVUCOE0vih70UxikexW1cDfi8/+avcGvf//38F3qVUqwkM5ieEf+O6kh0Icz/yOmuiQogXIUKl2Yhcvo3geTI4CatCBAHe1mwV0B1balPC+z4x7BtPFUshN0oh18wyVzyWtPP7S3EP7TW4412PCusx5Z63HALcxccXPQSknkEaoSNBpZegFfVJLBxauQwRj/GnPtVN6ATCiXJfyE5kXdoReqm6vXkUPKNzxpOGLoBTstSLUtYLsrTCT8ME81IUhdneNY60Y1vJDXxdX4HeMQ9I3Abmz1qy7KHEvwdbwd/+8umrr7G420JJ+Vt+Hqc1Q0Y0RO7Exbn1ofuzp/OxM1y5I4dzjOJlxdUs00YHOw++6yPv6HCZ4pAzMxiVPPdao8tPX3JP+ILtIs7T13203bsdDmf2A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C065F2647F96C45A7701E5818EF5840@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c53a142-4872-4c47-286e-08d689df169d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2019 13:54:15.6163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1796
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAxLzIzLzIwMTkgMDk6NTYgQU0sIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+IEZy
b206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gDQo+
IFRoaXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgTWFjcm9uaXggTVgyNVY4MDM1RiwgYSA4TWIgU1BJ
IE5PUiBjaGlwLg0KDQpQbGVhc2Ugc2F5IHdobyB1c2VzIGl0IGFuZCBob3cgeW91IHRlc3RlZCBp
dC4gTG9va3MgZ29vZCBvdGhlcndpc2UuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIg
U2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gLS0tDQo+ICBkcml2ZXJz
L210ZC9zcGktbm9yL3NwaS1ub3IuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3Iu
YyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jDQo+IGluZGV4IGFhOGEwNDI5M2EyNS4u
ZjA4ZWE5Y2Y4NmI2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3Iu
Yw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiBAQCAtMTg0OSw2ICsx
ODQ5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHNwaV9ub3JfaWRzW10gPSB7
DQo+ICAJCQkgU1BJX05PUl9EVUFMX1JFQUQgfCBTUElfTk9SX1FVQURfUkVBRCkNCj4gIAkJCSAu
Zml4dXBzID0gJm14MjVsMjU2MzVfZml4dXBzIH0sDQo+ICAJeyAibXgyNXUyNTYzNWYiLCBJTkZP
KDB4YzIyNTM5LCAwLCA2NCAqIDEwMjQsIDUxMiwgU0VDVF80SyB8IFNQSV9OT1JfNEJfT1BDT0RF
UykgfSwNCj4gKwl7ICJteDI1djgwMzVmIiwgIElORk8oMHhjMjIzMTQsIDAsIDY0ICogMTAyNCwg
IDE2LA0KPiArCQkJIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9S
RUFEKSB9LA0KPiAgCXsgIm14MjVsMjU2NTVlIiwgSU5GTygweGMyMjYxOSwgMCwgNjQgKiAxMDI0
LCA1MTIsIDApIH0sDQo+ICAJeyAibXg2Nmw1MTIzNWwiLCBJTkZPKDB4YzIyMDFhLCAwLCA2NCAq
IDEwMjQsIDEwMjQsIFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQgfCBTUElf
Tk9SXzRCX09QQ09ERVMpIH0sDQo+ICAJeyAibXg2NnU1MTIzNWYiLCBJTkZPKDB4YzIyNTNhLCAw
LCA2NCAqIDEwMjQsIDEwMjQsIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1Jf
UVVBRF9SRUFEIHwgU1BJX05PUl80Ql9PUENPREVTKSB9LA0KPiANCg==
