Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E90C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746572070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="F7+HanbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbfAGRyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:54:19 -0500
Received: from mail-eopbgr10077.outbound.protection.outlook.com ([40.107.1.77]:10409
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbfAGRyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:54:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ8QUAvEhvRqBG/RyspNdL62osYc4rQyUJtgHL+OSZM=;
 b=F7+HanbZhbf4MouhIZBdkYEopvsc+g51OVjmPnGWrnu+dkSzJXAM4si6KuvEIe6h7McOGH6zvkKp/jxNx89l+hDHpKog2pKKT2WIVZGONpxfj4Vu2ZlK5vb+LJUZ6m3elwLKKCoqPDxkd3zUYGODMMPP+z/iXvlikXvcibSZljE=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB4666.eurprd05.prod.outlook.com (20.176.163.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 17:54:15 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::75a0:a89d:1227:7ed3%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 17:54:15 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH] phy: ti: Fix compilation failures without REGMAP
Thread-Topic: [PATCH] phy: ti: Fix compilation failures without REGMAP
Thread-Index: AQHUprIATVplYL2t6kWu4mmzAnbAag==
Date:   Mon, 7 Jan 2019 17:54:14 +0000
Message-ID: <20190107175407.GA5612@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0084.namprd02.prod.outlook.com
 (2603:10b6:301:75::25) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB4666;6:zgEKPSMWkELN4PlZN+0913pVivp3lrec/sCZWnsLnDuiUVLxodgZ4T78edWj8/jDQOlBtGtW8a2Hv/SgSGobiFoxwOTjjdD+GAQ7mxsEjxXyDj+aHHNQOX5vAMHVKilHE7hyLo8xzUU4IPP0mP9VS8IarxiK+2IgdG0Ak8lcevRG/VkFS1y6jd9Uqf8VqGfFyfg5A1REjMjujRHSIPWqIFgmjvyW4e75eVG9oHzLjJwhim3PoLtl/iF+LCfafCQ8oLmFLrSJdaSQTHk/cTyR5rUjU4N1O+V/ayOhZyqhpGbHWJRpmACik2cHF+jT9pdzdKLMReKAiKd3gsUHgODOdB5L6be8Rzn4/nEN8WONvtJESt1sZ98EjProvUQ5ea+to4CxNHgtnwS8rV9Xr+ZindkAM7WQmyiNn5Eq6yx4gWvhWfdST5De84dQnQgwnG80/y0+e9xVgGoFJg6QErdCcg==;5:uhgf95978OFG5JS+8ExwhhHolbJzbtVIo+uM16FA+GTj08VrvXuAzoki6Km5jjBNjv5v0qcGtokJN7z8N56WjQNkEZJBjJ4hEIgUnuc4JpaNXKxajMY8DFF597QGtm+yExWHZGbEnzZbl285VwJz6GDd3MLdyOW/1iTTudqAwRtu0PmlOQ7bKV2N64ctwfsjvRoNHgl0XhpMnABczXM0EQ==;7:kvctJ+LmZ/RHvPxbIExHj/pjTkYaqOF09g0+9XwY60AlTJfDnML8cyhauQmqGYI0pPGGYcAo6pz8ZWMRjO9bMTtkB4dvojyFZquNHU/NWIPYZJQYmVHdJXikopuozytu+Ur+/ecfpUXFABEy6Lpfyw==
x-ms-office365-filtering-correlation-id: 7da5f254-7e1c-41f0-1416-08d674c92330
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4666;
x-ms-traffictypediagnostic: HE1PR05MB4666:
x-microsoft-antispam-prvs: <HE1PR05MB4666E42F76A66D0F9807AD1ECF890@HE1PR05MB4666.eurprd05.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR05MB4666;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4666;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(316002)(66066001)(7736002)(26005)(186003)(478600001)(54906003)(33656002)(476003)(256004)(110136005)(2906002)(9686003)(6512007)(8936002)(14454004)(53936002)(68736007)(71190400001)(71200400001)(36756003)(25786009)(81156014)(52116002)(106356001)(8676002)(81166006)(486006)(102836004)(105586002)(33896004)(386003)(6506007)(3846002)(6116002)(6486002)(5660300001)(6436002)(305945005)(4326008)(99286004)(86362001)(1076003)(97736004)(575784001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4666;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AbOK3kFLlbidxNhYLpQN+BfcPlkCMRNuz9tb3ZVzRaCRbE23dsY7F+1yGjfn0H214E7+cfsIkTqntLYIRjQ/IOg9Ptglg+H1Fvc4B6j3wVdjRb/2oeq9yZPB6q5IJZU5xcGbQoNErW5mVK6V4mX3rKahGMva0Ugsvja4OwXcg55T/JxRCNfCT2NRetG6KX677mMe2F8UDUHhC9B0OSc1wD7sd1EriSsxe2QijXBgpO0oHFJ/BQNmsOoR494G2psS9EPruxvzGnckIcxx5Dx2eyGB6b17Nts+nUFmCuxm6qaz2FNR4ygOChe1O/9pitic
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <9790CC68D3AC5C418CAA0A123E1BA1F8@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da5f254-7e1c-41f0-1416-08d674c92330
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 17:54:14.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBkcml2ZXIgcmVxdWlyZXMgcmVnbWFwIG9yIHRoZSBjb21waWxlIGZhaWxzOg0KDQpkcml2
ZXJzL3BoeS90aS9waHktZ21paS1zZWwuYzo0MzoyNzogZXJyb3I6IGFycmF5IHR5cGUgaGFzIGlu
Y29tcGxldGUgZWxlbWVudCB0eXBlIOKAmHN0cnVjdCByZWdfZmllbGTigJkNCiAgY29uc3Qgc3Ry
dWN0IHJlZ19maWVsZCAoKnJlZ2ZpZWxkcylbUEhZX0dNSUlfU0VMX0xBU1RdOw0KDQpBZGQgaXQg
dG8ga2NvbmZpZy4NCg0KU2lnbmVkLW9mZi1ieTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVsbGFu
b3guY29tPg0KLS0tDQogZHJpdmVycy9waHkvdGkvS2NvbmZpZyB8IDEgKw0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KDQouLiBhbmQgdGhpcyBpcyB3aHkgSSdtIGV2ZW4gY29tcGls
aW5nIHRoaXMgdGhpbmcgd2hlbiBJJ20gbm90IGRvaW5nDQphbnl0aGluZyB3aXRoIENQU1cgLi4N
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3RpL0tjb25maWcgYi9kcml2ZXJzL3BoeS90aS9L
Y29uZmlnDQppbmRleCBmMTM3ZTAxMDc3NjQ2My4uYzQ3MDllZDdmYjBlNzIgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL3BoeS90aS9LY29uZmlnDQorKysgYi9kcml2ZXJzL3BoeS90aS9LY29uZmlnDQpA
QCAtODIsNiArODIsNyBAQCBjb25maWcgUEhZX1RJX0dNSUlfU0VMDQogCWRlZmF1bHQgeSBpZiBU
SV9DUFNXPXkNCiAJZGVwZW5kcyBvbiBUSV9DUFNXIHx8IENPTVBJTEVfVEVTVA0KIAlzZWxlY3Qg
R0VORVJJQ19QSFkNCisJc2VsZWN0IFJFR01BUA0KIAlkZWZhdWx0IG0NCiAJaGVscA0KIAkgIFRo
aXMgZHJpdmVyIHN1cHBvcnRzIGNvbmZpZ3VyaW5nIG9mIHRoZSBUSSBDUFNXIFBvcnQgbW9kZSBk
ZXBlbmRpbmcgb24NCi0tIA0KMi4yMC4xDQoNCg==
