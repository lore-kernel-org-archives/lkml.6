Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA926C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9A621773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 05:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="utpREXuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbeLTFcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 00:32:11 -0500
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:39040
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729161AbeLTFcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 00:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GNt4jwkOpu3O3rvMsF25xjHG/L7wF2JubpXOT3/vGk=;
 b=utpREXuTjxsA3QPgm+Nrr3MepnYW4OUPY2Gtr2eZOau1rnABPoHCLYa+0qlMdpbu19CWNAkYQU6Y/TI/REIju71Ol4Vq1OnvrPPXyBn41KPZCqJ/wTT8ye7HApr4tP34J1B6rbB2A6YahHHhxG5f1+kXG5Gw4adUJzhK+CPBceM=
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com (20.178.127.24) by
 VI1PR04MB5488.eurprd04.prod.outlook.com (20.178.122.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Thu, 20 Dec 2018 05:32:03 +0000
Received: from VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175]) by VI1PR04MB5726.eurprd04.prod.outlook.com
 ([fe80::d938:811:ed7:175%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 05:32:03 +0000
From:   Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
To:     Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 0/7] spi: add support for octal mode
Thread-Topic: [PATCH v6 0/7] spi: add support for octal mode
Thread-Index: AQHUl4M9zHZOcdwiAEaqBDYBME9P7qWGAesAgAEY9HA=
Date:   Thu, 20 Dec 2018 05:32:03 +0000
Message-ID: <VI1PR04MB5726D65958C532965E12EE4F99BF0@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1545214186-16987-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
In-Reply-To: <10b25865-b93d-382a-aa4d-b21fbd9c3ba9@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5488;6:2wsJIqgoPNyvmBg/w78yKK37fyce/J8jreSC2QRSRJUcVPSW64ZvOgot9KtSGq7GpZ7cRM54NFlIqLbYlbbmLiqYbH2BjNDm/fT0UgRIylpWsO2/yB7Od0geuiWnTHVCSUeAhjZ7ECxab+q3Uz9hk11EuwL5AXIWsqNeyKiQ7CX7EEBVPWT4Dk50O4hJvcnZXSYIOIVJi2jnK0P4y+saBS+HZ3Ogc46TU2pVLMu5yX2jjOiz7oR5zQMA3Yeq0yVYtmIRKohXSZ6LWxodEg41FYoYYA8UfYl1gv0hS4zeXub6ePshAM1Ea0S0ZJAzN1CYcua1coeU9U1jWcXfUYthNSou0wjr3AWMp/AOiNUSCoJCV4GdEms8vKTrwEF9a0ZyN5ft/H/NHviCgnZwmRaRL9FiInD6falv9M28mZqGAhwmfINTt/qtiA3aXrmDS0Bju55dx810kBfPVozVpWFWzg==;5:AQuBbhBv+koU6vV2lN/L8DyltVM2SvTFnvz1kITxzEn2OHjEneSulEbK+kzxaWKCK3ykOT26u2BVAwH5dk/wf6oZmFLBRTiHsV2ucc2ROPuGDQk93NyfTddAgT4HUbK3RDaFHQliZQBFFZPxsXKXrNDtj6jc0gfEmQMsJ/ejPLs=;7:m7pD7cMoAQ4n4PyIgbmP2XbiQwpB3q7sSfZ35lvOefZddJQSpcSUdy+t5M+3ISFnAVMgqG/G9BmAXUxf7Akb8LLHQr3AJ0zlgd4zHjKgua2Cy1147Pj1fwn8EUxeOnLVGr1HmdL2cOU/AOCTnjP7jA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e11dbf35-397a-4748-8879-08d6663c7903
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5488;
x-ms-traffictypediagnostic: VI1PR04MB5488:
x-microsoft-antispam-prvs: <VI1PR04MB5488216CD402A5C2891A7D8C99BF0@VI1PR04MB5488.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB5488;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5488;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(396003)(136003)(13464003)(199004)(189003)(71190400001)(54906003)(110136005)(8676002)(78486014)(486006)(8936002)(305945005)(4326008)(68736007)(66066001)(39060400002)(5660300001)(476003)(55236004)(45080400002)(6116002)(97736004)(3846002)(81156014)(74316002)(7736002)(478600001)(2201001)(71200400001)(6436002)(2906002)(11346002)(446003)(966005)(316002)(86362001)(256004)(105586002)(106356001)(25786009)(2501003)(14444005)(229853002)(14454004)(55016002)(7416002)(9686003)(6306002)(99286004)(7696005)(53936002)(26005)(33656002)(53546011)(6506007)(6246003)(186003)(81166006)(76176011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5488;H:VI1PR04MB5726.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XcTdwD2mK5AoSbVfM4gnqkMCnTrRrcUMQXLMTDJMdDJH5Adh4Dyccj4rP1TnqzDM416eexhaH7vx8qjFZzsOQUiu+6xaEu65/RUCMIWoxzCTT2ns2l2/C0ujQdC24P9/Quw4eLi9eLKOSQre4FeV8c+cR2shfPNt2UjNUEpwnpFAYDwRVG6Z8Taq+FQYCzvZJYvf5xVHwFVGRlNI/tmfEUqj+i0RRBF17KPJBFYgShvcQuWNH8KVLJelI5OAmtZKkyhgv3SGtMQ/mi5SqqKx2rtcSGqHt/lJ5wzyB0Vq2IPXnifhZRfazXSmdtjPcRxB
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11dbf35-397a-4748-8879-08d6663c7903
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 05:32:03.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5488
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlnbmVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBWaWdu
ZXNoIFIgW21haWx0bzp2aWduZXNockB0aS5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgRGVjZW1i
ZXIgMTksIDIwMTggNjoxNCBQTQ0KPiBUbzogWW9nZXNoIE5hcmF5YW4gR2F1ciA8eW9nZXNobmFy
YXlhbi5nYXVyQG54cC5jb20+OyBsaW51eC0NCj4gbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGJv
cmlzLmJyZXppbGxvbkBib290bGluLmNvbTsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBtYXJlay52
YXN1dEBnbWFpbC5jb207IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVA
dmdlci5rZXJuZWwub3JnDQo+IENjOiB0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb207IHJvYmhA
a2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gY29tcHV0ZXJzZm9ycGVh
Y2VAZ21haWwuY29tOyBmcmllZGVyLnNjaHJlbXBmQGV4Y2VldC5kZTsgbGludXgtDQo+IGtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwLzddIHNwaTogYWRk
IHN1cHBvcnQgZm9yIG9jdGFsIG1vZGUNCj4gDQo+IEhpLA0KPiANCj4gT24gMTkvMTIvMTggMzo0
MSBQTSwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3Igb2N0
YWwgbW9kZSBJTyBkYXRhIHRyYW5zZmVyLg0KPiA+IE1pY3JvbiBmbGFzaCwgbXQzNXh1NTEyYWJh
LCBzdXBwb3J0cyBvY3RhbCBtb2RlIGRhdGEgdHJhbnNmZXIgYW5kIE5YUA0KPiA+IEZsZXhTUEkg
Y29udHJvbGxlciBzdXBwb3J0cyA4IGRhdGEgbGluZXMgZm9yIGRhdGEgdHJhbnNmZXIgKFJ4L1R4
KS4NCj4gPg0KPiA+IFBhdGNoIHNlcmllcw0KPiA+ICogQWRkIHN1cHBvcnQgZm9yIG9jdGFsIG1v
ZGUgZmxhZ3MgYW5kIHBhcnNpbmcgb2Ygc2FtZSBpbiBzcGkgZHJpdmVyLg0KPiA+ICogQWRkIHBh
cnNpbmcgbG9naWMgZm9yIHNwaS1tZW0gZnJhbWV3b3JrIGFuZCBtMjVwODAuYyBkZXZpY2UgZmls
ZS4NCj4gPiAqIEFkZCBvcGNvZGVzIGZvciBvY3RhbCBJL08gY29tbWFuZHMgaW4gc3BpLW5vciBm
cmFtZXdvcmssIFJlYWQgYW5kIFdyaXRlDQo+IHByb3RvIGZvciAoMS0xLTgvMS04LTgpIG1vZGUu
DQo+ID4gICBPcGNvZGVzIGFyZSBhZGRlZCBhcyBwZXIgb2N0YWwgZGF0YSBJTyBjb21tYW5kcyBy
ZXF1aXJlZCBmb3INCj4gbXQzNXh1NTEyYWJhIFsxXSBmbGFzaC4NCj4gPiAqIEFkZCBtb2RlIGJp
dCByZXF1aXJlZCBmb3Igb2N0YWwgbW9kZSBpbiBueHAtZnNwaSBkcml2ZXIgWzJdLg0KPiA+ICog
RGVmaW5lIGJpbmRpbmcgcHJvcGVydHkgJ3NwaS1yeC90eC1idXMtd2lkdGgnIGZvciBMWDIxNjBB
UkRCIHRhcmdldCBbMl0uDQo+ID4NCj4gPiBUZXN0ZWQgb24gTFgyMTYwQVJEQiB0YXJnZXQgd2l0
aCBueHAtZnNwaSBkcml2ZXIsIGJlbG93IGFyZSBSZWFkDQo+ID4gcGVyZm9ybWFuY2UgbnVtYmVy
IG9mIDEtMS0xIGFuZCAxLTEtOCByZWFkIHByb3RvY29sLg0KPiA+DQo+ID4gIHJvb3RAbHh4eDp+
IyBjYXQgL3Byb2MvbXRkDQo+ID4gIGRldjogICAgc2l6ZSAgIGVyYXNlc2l6ZSAgbmFtZQ0KPiA+
ICBtdGQwOiAwNDAwMDAwMCAwMDAwMTAwMCAic3BpMC4wIg0KPiA+ICBtdGQxOiAwNDAwMDAwMCAw
MDAwMTAwMCAic3BpMC4xIg0KPiA+ICByb290QGx4eHg6fiMgdGltZSBtdGRfZGVidWcgcmVhZCAv
ZGV2L210ZDAgMHgwIDB4MTAwMDAwMCAwcmVhZA0KPiA+IENvcGllZCAxNjc3NzIxNiBieXRlcyBm
cm9tIGFkZHJlc3MgMHgwMDAwMDAwMCBpbiBmbGFzaCB0byAwcmVhZA0KPiA+DQo+ID4gIHJlYWwg
ICAgMG0yLjc5MnMNCj4gPiAgdXNlciAgICAwbTAuMDAwcw0KPiA+ICBzeXMgICAgIDBtMi43OTBz
DQo+ID4gIHJvb3RAbHh4eDp+IyB0aW1lIG10ZF9kZWJ1ZyByZWFkIC9kZXYvbXRkMSAweDAgMHgx
MDAwMDAwIDByZWFkDQo+ID4gQ29waWVkIDE2Nzc3MjE2IGJ5dGVzIGZyb20gYWRkcmVzcyAweDAw
MDAwMDAwIGluIGZsYXNoIHRvIDByZWFkDQo+ID4NCj4gPiAgcmVhbCAgICAwbTAuNDQxcw0KPiA+
ICB1c2VyICAgIDBtMC4wMDBzDQo+ID4gIHN5cyAgICAgMG0wLjQ0MHMNCj4gPiAgcm9vdEBsczEw
MTJhcmRiOn4jDQo+ID4NCj4gPg0KPiA+ICBGbGFzaCBkZXZpY2UgTVREMCBjb25maWd1cmVkIGlu
IDEtMS0xIHByb3RvY29sLg0KPiA+ICBGbGFzaCBkZXZpY2UgTVREMSBjb25maWd1cmVkIGluIDEt
MS04IHByb3RvY29sLg0KPiA+DQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdA0KPiA+IGNod29y
ay5vemxhYnMub3JnJTJGcHJvamVjdCUyRmxpbnV4LQ0KPiBtdGQlMkZsaXN0JTJGJTNGc2VyaWVz
JTNENzAzODQlMjZzDQo+ID4NCj4gdGF0ZSUzRComYW1wO2RhdGE9MDIlN0MwMSU3Q3lvZ2VzaG5h
cmF5YW4uZ2F1ciU0MG54cC5jb20lN0NhYzVjOQ0KPiBjYTRhZDANCj4gPg0KPiA4NGYxMDc2MjIw
OGQ2NjVhZjkxMzAlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwDQo+
ICU3QzYzNg0KPiA+DQo+IDgwODIwMjA2NDE4MTAzMiZhbXA7c2RhdGE9TENqbyUyQiUyRmhJcEVZ
eWdzTEhNRnpiNjVadFhqc0RkaEVBVlY0DQo+ICUyQmpRDQo+ID4gaXlVdEklM0QmYW1wO3Jlc2Vy
dmVkPTAgWzJdDQo+ID4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdA0KPiA+IGNod29yay5vemxhYnMub3JnJTJGcHJv
amVjdCUyRmxpbnV4LQ0KPiBtdGQlMkZsaXN0JTJGJTNGc2VyaWVzJTNENzY0MDImYW1wDQo+ID4g
O2RhdGE9MDIlN0MwMSU3Q3lvZ2VzaG5hcmF5YW4uZ2F1ciU0MG54cC5jb20lN0NhYzVjOWNhNGFk
MDg0ZjEwNw0KPiA2MjIwOGQNCj4gPg0KPiA2NjVhZjkxMzAlN0M2ODZlYTFkM2JjMmI0YzZmYTky
Y2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODA4MjAyDQo+IDA2NDE4MQ0KPiA+DQo+IDAzMiZh
bXA7c2RhdGE9QTloQVg0b1R5SlB6YzRKM3kzUHF3TmFnV0VxdnBHb2xmOFJFOVJ5WVYyOCUzRCZh
bQ0KPiBwO3Jlc2VyDQo+ID4gdmVkPTANCj4gPg0KPiA+IFlvZ2VzaCBHYXVyICg3KToNCj4gPiAg
IHNwaTogYWRkIHN1cHBvcnQgZm9yIG9jdGFsIG1vZGUgSS9PIGRhdGEgdHJhbnNmZXINCj4gPiAg
IHNwaTogc3BpLW1lbTogYWRkIHN1cHBvcnQgZm9yIG9jdGFsIG1vZGUgSS9PIGRhdGEgdHJhbnNm
ZXINCj4gDQo+IA0KPiBUaGVzZSB0d28gcGF0Y2hlcyBhcmUgYWxyZWFkeSBtZXJnZWQgYW5kIGlz
IG5vdyBwYXJ0IG9mIGxpbnV4LW5leHRbMV0uDQo+IEl0cyBwcmVmZXJyZWQgdG8gc2VuZCBwYXRj
aGVzIGJhc2VkIG9uIHRvcCBvZiBsYXRlc3QgbGludXgtbmV4dCBzbyBhcyB0byBhdm9pZA0KPiBy
ZXNlbmRpbmcgcGF0Y2hlcyB0aGF0IGhhdmUgYWxyZWFkeSBiZWVuIHBpY2tlZCB1cCBieSB0aGUg
bWFpbnRhaW5lci4NCj4gDQo+IFsxXQ0KPiBjb21taXQgNmIwMzA2MWY4ODJkZTQ5YjgzY2NmNDRi
ZWIzYTEyYzkyMGEyZGExYg0KPiBBdXRob3I6IFlvZ2VzaCBOYXJheWFuIEdhdXIgPHlvZ2VzaG5h
cmF5YW4uZ2F1ckBueHAuY29tPg0KPiBEYXRlOiAgIE1vbiBEZWMgMyAwODozOTowNiAyMDE4ICsw
MDAwDQo+IA0KPiAgICAgc3BpOiBhZGQgc3VwcG9ydCBmb3Igb2N0YWwgbW9kZSBJL08gZGF0YSB0
cmFuc2Zlcg0KPiANCj4gY29tbWl0IGIxMmEwODRjODcyOWVmNDIzMDg5YmI5YTVhMTQzZWVkMzlj
ZDk0ZTcNCj4gQXV0aG9yOiBZb2dlc2ggTmFyYXlhbiBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJA
bnhwLmNvbT4NCj4gRGF0ZTogICBNb24gRGVjIDMgMDg6Mzk6MTIgMjAxOCArMDAwMA0KPiANCj4g
ICAgIHNwaTogc3BpLW1lbTogYWRkIHN1cHBvcnQgZm9yIG9jdGFsIG1vZGUgSS9PIGRhdGEgdHJh
bnNmZXINCj4gDQo+IA0KSSBoYXZlIGNoZWNrZWQgb24gcmVwbyAiZ2l0Oi8vZ2l0LmluZnJhZGVh
ZC5vcmcvbGludXgtbXRkLmdpdCIgb24gYnJhbmNoICJzcGktbm9yL25leHQiIGFuZCBpbiB0aGF0
IGtlcm5lbCB2ZXJzaW9uIGlzIDQuMjAuLXJjNS4NCkluIHRoaXMgcmVwbyBhYm92ZSAyIHBhdGNo
ZXMgYXJlIG5vdCBwcmVzZW50IGFuZCBoZW5jZSBoYXMgc2VuZCB0aGUgcGF0Y2hlcyBieSBtb3Zp
bmcgdG8gdG9wIG9mIHRoaXMgcmVwby4NCg0KQ2FuIHlvdSBwbGVhc2UgbGV0IG1lIGtub3cgdGhl
IHJlcG8gb2YgbGludXgtbmV4dCBhbmQgYnJhbmNoIHRvIHVzZS4NCg0KLS0NClJlZ2FyZHMNCllv
Z2VzaCBHYXVyDQoNCj4gUmVnYXJkcw0KPiBWaWduZXNoDQo+IA0KPiA+ICAgbXRkOiBzcGktbm9y
OiBhZGQgb3Bjb2RlcyBmb3Igb2N0YWwgUmVhZC9Xcml0ZSBjb21tYW5kcw0KPiA+ICAgbXRkOiBz
cGktbm9yOiBhZGQgb2N0YWwgcmVhZCBmbGFnIGZvciBmbGFzaCBtdDM1eHU1MTJhYmENCj4gPiAg
IG10ZDogbTI1cDgwOiBhZGQgc3VwcG9ydCBvZiBvY3RhbCBtb2RlIEkvTyB0cmFuc2Zlcg0KPiA+
ICAgc3BpOiBueHAtZnNwaTogYWRkIG9jdGFsIG1vZGUgZmxhZyBiaXQgZm9yIG9jdGFsIHN1cHBv
cnQNCj4gPiAgIGFybTY0OiBkdHM6IGx4MjE2MGE6IHVwZGF0ZSBmc3BpIG5vZGUNCj4gPg0KPiA+
IENoYW5nZXMgZm9yIHY2Og0KPiA+IC0gQ29ycmVjdCBTLW8tYiB0YWcgd2l0aCBmdWxsIGF1dGhv
ciBuYW1lIGFzICdZb2dlc2ggTmFyYXlhbiBHYXVyJy4NCj4gPiAtIFJlYmFzZSBvbiB0b3Agb2Yg
djQuMjAtcmM1Lg0KPiA+IENoYW5nZXMgZm9yIHY1Og0KPiA+IC0gTW9kaWZpZWQgc3RyaW5nICdv
Y3RvJyBhcyAnb2N0YWwnIGluIGFsbCBwYXRjaGVzLg0KPiA+IENoYW5nZXMgZm9yIHY0Og0KPiA+
IC0gUmViYXNlIG9uIHRvcCBvZiB2NC4yMC1yYzIuDQo+ID4gLSBNb2RpZnkgb2N0byBlbnRyaWVz
IGVudW0gdmFsdWUgaW4gc3BpLmguDQo+ID4gQ2hhbmdlcyBmb3IgdjM6DQo+ID4gLSBBZGQgb2N0
byBtb2RlIHN1cHBvcnQgaW4gc3BpX3NldHVwKCkuDQo+ID4gLSBSZW5hbWUgYWxsIHBhdGNoZXMg
d2l0aCAnb2N0YWwnIHN0cmluZyBtb2RpZmllZCBhcyAnb2N0bycuDQo+ID4gQ2hhbmdlcyBmb3Ig
djI6DQo+ID4gLSBJbmNvcnBvcmF0ZWQgcmV2aWV3IGNvbW1lbnRzIG9mIEJvcmlzIGFuZCBWaWdu
ZXNoLg0KPiA+DQo+ID4gWW9nZXNoIEdhdXIgKDcpOg0KPiA+ICAgc3BpOiBhZGQgc3VwcG9ydCBm
b3Igb2N0YWwgbW9kZSBJL08gZGF0YSB0cmFuc2Zlcg0KPiA+ICAgc3BpOiBzcGktbWVtOiBhZGQg
c3VwcG9ydCBmb3Igb2N0YWwgbW9kZSBJL08gZGF0YSB0cmFuc2Zlcg0KPiA+ICAgbXRkOiBzcGkt
bm9yOiBhZGQgb3Bjb2RlcyBmb3Igb2N0YWwgUmVhZC9Xcml0ZSBjb21tYW5kcw0KPiA+ICAgbXRk
OiBzcGktbm9yOiBhZGQgb2N0YWwgcmVhZCBmbGFnIGZvciBmbGFzaCBtdDM1eHU1MTJhYmENCj4g
PiAgIG10ZDogbTI1cDgwOiBhZGQgc3VwcG9ydCBvZiBvY3RhbCBtb2RlIEkvTyB0cmFuc2Zlcg0K
PiA+ICAgc3BpOiBueHAtZnNwaTogYWRkIG9jdGFsIG1vZGUgZmxhZyBiaXQgZm9yIG9jdGFsIHN1
cHBvcnQNCj4gPiAgIGFybTY0OiBkdHM6IGx4MjE2MGE6IHVwZGF0ZSBmc3BpIG5vZGUNCj4gPg0K
PiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzIHwg
IDQgKysrKw0KPiA+ICBkcml2ZXJzL210ZC9kZXZpY2VzL20yNXA4MC5jICAgICAgICAgICAgICAg
ICAgICAgIHwgIDkgKysrKysrKystDQo+ID4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5j
ICAgICAgICAgICAgICAgICAgICAgfCAxOSArKysrKysrKysrKysrKysrLS0tDQo+ID4gIGRyaXZl
cnMvc3BpL3NwaS1tZW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgOSArKysrKysr
Ky0NCj4gPiAgZHJpdmVycy9zcGkvc3BpLW54cC1mc3BpLmMgICAgICAgICAgICAgICAgICAgICAg
ICB8ICA0ICsrLS0NCj4gPiAgZHJpdmVycy9zcGkvc3BpLmMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDEyICsrKysrKysrKystLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGkt
bm9yLmggICAgICAgICAgICAgICAgICAgICAgIHwgMTYgKysrKysrKysrKysrLS0tLQ0KPiA+ICBp
bmNsdWRlL2xpbnV4L3NwaS9zcGkuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKysr
LQ0KPiA+ICA4IGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQ0KPiA+DQo+IA0KPiAtLQ0KPiBSZWdhcmRzDQo+IFZpZ25lc2gNCg==
