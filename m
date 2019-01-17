Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D936C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FB620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jdql8jV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfAQG2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:28:34 -0500
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:62592
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726795AbfAQG2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0/kua0r4X/CTiLdGPegFp77FHhOj1Ts+puAyqqfw/8=;
 b=jdql8jV9b0kcCmYMrjrvrIal04XX1vjvm1ojSJsWxG8xFzPyRGSFLN/WUPMYJ1Xd4hRZO9EBkhggAOoHfzSQaF/F1JV3lkBbMyv7zUFAeUS6MdW2OktW+ik8oSekDhnb3aKm55DjlkBDbRIHU1xCIg0Hq9EtCnxUXaCGGqdCuJs=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4540.eurprd04.prod.outlook.com (52.135.138.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Thu, 17 Jan 2019 06:28:28 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b5b6:9a7a:7970:ffec]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::b5b6:9a7a:7970:ffec%4]) with mapi id 15.20.1516.019; Thu, 17 Jan 2019
 06:28:28 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/3] can: flexcan: add imx8qm support
Thread-Topic: [PATCH 0/3] can: flexcan: add imx8qm support
Thread-Index: AQHUl3ZIyDiPbeOVSkuQb8q6fDKkQqWzLKAQ
Date:   Thu, 17 Jan 2019 06:28:28 +0000
Message-ID: <DB7PR04MB46187B4AABF3607876DA30D4E6830@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181219083637.641-1-qiangqing.zhang@nxp.com>
In-Reply-To: <20181219083637.641-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4540;6:6PsAWj37O8IgMa0bJb+hXnBeFKN2KUtoy1QZZWcoxwsN2at2LHaWQsna4PedlR/ZDUdcBxt+ol83HCKSvIxhFD02sYZ/l8uaf/hf9qE7UI5RHFo8V6UuE4UIPOTnbq1i/upotTKLVwQJBF2sIOKWl0ls6zhmiKAEG8VrYEnTDi/oPI8BWS7rtPpWJD5LTRUmWth1t3HlQcxBFls/5fwNYepyqixy/UUvqry+BF09FYcfrJcoxDqCSvTezGN9MPhaNd66VDRzqnknObHrtzzR9ofrOKjT/QBNRGEEAs7i3yW5z5emn9x+ZGR2Wrt67QkqlX4YZpQ4Y6DPqjhM47WzRyVm2iCX0oa2t/DybfWGMmgZNJwuvOioKah2cAmdYhBwAg8eEI09LrkJTnvmZj9ZJ3wUzmr7dPzA2zhpwqlCQK3Re/DuVvuPlB8vWVbi8LuR68ir6ifbLrcQhjChMP/Qkw==;5:BHDOIzEGI5APv3uE3pbJpIHXbTOyFmFMusYqklumQPNGzVajD0gBiCbFWnTtlTjR+CJWh9Q4I7J/XR+Q1HrE6bIFtOa282a3/JN2voE1QUpoNuxZITlJfMXxtqRYvI2OJE+Iu7Fv85Vd0Qbfxm2+9iGsdJlw/JLlMk14Bp/ekepCOp+HQEblSeLWZFazd7UQq76O9EpdsAFCf+vYndNklQ==;7:i+xcZnpq9OzObJFbONfT4jJGnUMIN/lu799fcO2vEX4NtFiy0wWp360JUEdGkSZAew2GreKhTRP/n7SS88K+knKFpG7oxnh7+eCT5NhqKyQXG6I9WITJ/s7hi11FmbDL///odOEEXGsqVNmjnZ9CFQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 178a68f3-7d94-48d7-8b04-08d67c44fe5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4540;
x-ms-traffictypediagnostic: DB7PR04MB4540:
x-microsoft-antispam-prvs: <DB7PR04MB4540CE66CDFC97AC4D5080A2E6830@DB7PR04MB4540.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(346002)(396003)(136003)(13464003)(199004)(189003)(11346002)(446003)(8936002)(71190400001)(68736007)(6116002)(3846002)(71200400001)(476003)(305945005)(7736002)(7696005)(74316002)(486006)(569044001)(76176011)(81166006)(6436002)(55016002)(8676002)(81156014)(97736004)(66066001)(478600001)(5660300001)(4326008)(9686003)(33656002)(229853002)(86362001)(2906002)(53936002)(25786009)(6246003)(316002)(26005)(102836004)(14454004)(256004)(53546011)(6506007)(54906003)(110136005)(105586002)(106356001)(99286004)(2501003)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4540;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JVilLH6Pl1Mcjs8VyOHfrp5nE+PC+w1vXMR0gnrBVGaiZWZVO6NFCfmsj4fQJ68SMCy3wMJ9HT/glSvYSefQWcWQOE3UnH7hQBCG+tT6uCDO4nmw4Kg6yCxWrPN0uqGE/Y86IKp6B8G3KaeiiU6NUubf3kksounpxYIV68P5p2IBldQhQ/0C8dX3MQ2WU3XV/S4VQkgiR/tVXOslsLXkWuuUrzg5JIrQeJ1L1PPshpWhgPZGVTkidGDuPBlTi8TZZS3Eq64w2y12q39lqRmQJUXF8uAbvFvI+Sz0UwQ1TJf//vXzSZHulbkAXOAndgDRZL8vlnqx4bs8JIyYEGvsu5xIUP3K1elnzkQysoXZ9ZbRLUPrhh1gMoK0gS8jAPKRww7KikhmracqltrBBMk33Prmaw2oGdopHnRb5xjFV28=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178a68f3-7d94-48d7-8b04-08d67c44fe5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 06:28:28.5160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpLaW5kbHkgUGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gWmhhbmcNCj4gU2VudDogMjAx
OMTqMTLUwjE5yNUgMTY6MzkNCj4gVG86IG1rbEBwZW5ndXRyb25peC5kZTsgbGludXgtY2FuQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogd2dAZ3JhbmRlZ2dlci5jb207IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGlu
dXgtaW14QG54cC5jb20+OyBKb2FraW0NCj4gWmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0ggMC8zXSBjYW46IGZsZXhjYW46IGFkZCBpbXg4cW0gc3VwcG9y
dA0KPiANCj4gVGhpcyBwYXRjaCBzZXQgaW50ZW5kcyB0byBhZGQgRmxleGNhbiBzdXBwb3J0IGZv
ciBpLk1YOFFNIHBsYXRmb3JtIHdoaWNoDQo+IGRlZmF1bHRseSBzdXBwb3J0cyBDQU4gRkQgcHJv
dG9jb2wuIEFsdGhvdWdoIEJSUyBlbmFibGVkIGJ5IHN5c3RlbSByZXNldA0KPiB3aGVuIHRoZSBk
cml2ZXIgc2V0cyBDQU4gRkQgbW9kZSwgbm93IHRoaXMgcGF0Y2ggc2VyaWFsIGRvZXMgbm90IHN1
cHBvcnQgQlJTDQo+IGluIHRoZSBkcml2ZXIuIEFuZCB0aGVuIEkgd2lsbCBzZW5kIHBhdGNoIHRv
IGVuYWJsZSBCUlMgYnkgY2hhbmdpbmcgdGhlIHJlZ2lzdGVyDQo+IHRvIHNldCBiaXQgdGltaW5n
Lg0KPiANCj4gRG9uZyBBaXNoZW5nICgzKToNCj4gICBjYW46IHJ4LW9mZmxvYWQ6IGFkZCBDQU5G
RCBzdXBwb3J0IGJhc2VkIG9uIG9mZmxvYWQNCj4gICBjYW46IGZsZXhjYW46IGFkZCBDQU4gRkQg
bW9kZSBzdXBwb3J0DQo+ICAgY2FuOiBmbGV4Y2FuOiBhZGQgaW14OHFtIHN1cHBvcnQNCj4gDQo+
ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jICAgICAgfCAxMTQgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tDQo+ICBkcml2ZXJzL25ldC9jYW4vcngtb2ZmbG9hZC5jICAgfCAgMTYg
KysrLS0NCj4gIGluY2x1ZGUvbGludXgvY2FuL3J4LW9mZmxvYWQuaCB8ICAgNCArLQ0KPiAgMyBm
aWxlcyBjaGFuZ2VkLCAxMTcgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+IA0KPiAt
LQ0KPiAyLjE3LjENCg0K
