Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D1DC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F74C20856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 07:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WjgYUPlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F74C20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbeICLjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 07:39:48 -0400
Received: from mail-eopbgr20059.outbound.protection.outlook.com ([40.107.2.59]:27568
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeICLjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 07:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T0PzBqJRAdbLhkjWTNbDXYqdzCzZMfGM1bV9skTIPU=;
 b=WjgYUPlM/beUv3fefdOfLatE/T8XMZrEWKdb330Jj4FC/ax5kbLvdWf3KWbPUh/gVcMkU7FaUHfYwEXydMMqggepda68whOL91H5S7EhP3K7q1Yx0LMxrMkGAGM7kiKYnL65xBCQ9gRF4BCq+XguLq/xi7KebiTEYn7TIFNNJPw=
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com (52.133.30.10) by
 AM6PR0402MB3382.eurprd04.prod.outlook.com (52.133.19.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.16; Mon, 3 Sep 2018 07:20:53 +0000
Received: from AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::ccea:795:beb3:5637]) by AM6PR0402MB3911.eurprd04.prod.outlook.com
 ([fe80::ccea:795:beb3:5637%2]) with mapi id 15.20.1080.020; Mon, 3 Sep 2018
 07:20:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Topic: [PATCH 2/2] clk: imx: imx7d: remove clks_init_on array
Thread-Index: AQHULtJmBbQCL7E8lECcVaukjbrAoqS1i6SAgAAAVtCAB1yugIAcTbiAgABtsgCAAKaTAIAEBEiQ
Date:   Mon, 3 Sep 2018 07:20:53 +0000
Message-ID: <AM6PR0402MB391120110A289BA5FB6B9F0DF50C0@AM6PR0402MB3911.eurprd04.prod.outlook.com>
References: <1533703167-26583-1-git-send-email-Anson.Huang@nxp.com>
 <1533703167-26583-2-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4481FC2BAD71B75D7BE84C0788260@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F8BC381BBA01DB21D1C0F5260@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB44813C7A3E0AF4F3BCFFCF0088390@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <153567894721.93865.4092113232222931488@swboyd.mtv.corp.google.com>
 <a6489bda-703f-207c-0b24-60f4044fe89f@linaro.org>
 <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
In-Reply-To: <153573827629.93865.6200966443862432044@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3382;6:VDQwWHY6LssG0GmS7BPmJ4d22ohB7XReCSOTeBYB9jcbXikf/Eaqw+RiBMkNFRMmjFiAslZgEd/Xpsd6UH2zz9p7yLRDtTw36ZbjRNKUX2YF5hkZA4bHXdj+mSByyp5Nc+3cUgz/DtLCAGn9nOMkclolpExCwV9neGFxdakJncjiVB6pRdnJ7oP6FQuV6dsjpkpi9M/A+D94RkuXkrku14uWWYttbPIJWHpxPQXvdGdityAUB6LvlrEA1xxtf/Kq9wvyMPafRVV6X0FKR8abFBDV2khTvsZ3LMVLIoeHpsZtAo0D6Ws3GiBqkfEjhj7ANoMEkOl6U8x1N2fY+TVmkxM5+gRnr6OLdhaVkdyT6GKvK+XM2Puy/bIWd4xWfpiaZg2woshumTa2N3IxjBFE/7cjfL85e5320S5KMjQ2KWwiiIawfiT/KHnsRQ5sKIL6O9lGcqPFd/f0MG51B8uXTQ==;5:3/bFCEnFoZmPN5f08C1DWj3QBsZtL1wf6ZwSoC8h/zNejiwdaCP5QlBuXLe0I3Mi7w2wI2/UOO2DQI8Bp6LiUm5mbqrbAb2HkhdZZXxyL/OV7gMtcZO5HqwpYfh0kie/Jit8E8L6MLVwCZxWuKOGI/k4m3Dpi+l0FFb1wDseJ/M=;7:LgpEhLp7rhhoFGYvwczYEJn8NQGcJmZNnVtBGnJGLWvmbCZom19byMkr6aWQ86A0jIg72vYdsj+ZgMp2uOi3aU5X0m+qQgSsSG3KvcXtXAhvSACh/jTo2ssTE6Li3dHpZO+xIRC9fS1r+FlMKx1Y1VhdOrbECfSTlBdHFQv2rX57c+96jiI98h9aVBqxiISi51XwhPO9wVM175hTzTkgGnUndDCEHMeJzUnosq79SnhWs/Qfz9s3Kw7KVS7O+x4E
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 9b4a5a38-1c85-4ccc-47dc-08d6116dc898
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3382;
x-ms-traffictypediagnostic: AM6PR0402MB3382:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <AM6PR0402MB3382EEA10697946DD554753FF50C0@AM6PR0402MB3382.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:AM6PR0402MB3382;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3382;
x-forefront-prvs: 0784C803FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(366004)(13464003)(189003)(199004)(53546011)(478600001)(66066001)(229853002)(2906002)(2201001)(6506007)(6116002)(8936002)(7696005)(14454004)(102836004)(81156014)(3846002)(86362001)(55016002)(2900100001)(9686003)(8676002)(81166006)(105586002)(2501003)(186003)(76176011)(6246003)(106356001)(4326008)(7416002)(446003)(305945005)(93886005)(11346002)(97736004)(316002)(110136005)(44832011)(5660300001)(26005)(99286004)(53936002)(5250100002)(14444005)(68736007)(476003)(6436002)(33656002)(25786009)(7736002)(486006)(74316002)(256004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3382;H:AM6PR0402MB3911.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: q1tlJDZmAImoU3hz6gnLAWUHwSyS5zO/VJAXR3gJh5GY7fAH+EmrkR9AivmqZgGXhRKAEuiKURyqdq+RC16eNBcGw//C5mxNt7KVFYVmGrSTxNPK3EuiN+00tyhueE8/3w0BQKTp71bwwyseKl0cZ+hUumCIpmk8bM1Z10p1kz7XbHrRgSYA5r2yTCQBhBU4MqFauXvuPdUshBJSXa5pMc3LT+JEY+5a+8yjWJvwcEq9EtgOqSGkrvEbx7tsjARXkTmL41SXHyjgAjJh7Fqv0HpX+DyTF11UOofLY83GBEi1iB7L2unhI4JehEkCUDeFZFPvvrRbLECAL5wupu71ayjH3QA70+JaxvQ1+24mjqI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4a5a38-1c85-4ccc-47dc-08d6116dc898
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2018 07:20:53.3096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6
IFNhdHVyZGF5LCBTZXB0ZW1iZXIgMSwgMjAxOCAxOjU4IEFNDQo+IFRvOiBrZXJuZWxAcGVuZ3V0
cm9uaXguZGU7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbXR1
cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IHNoYXduZ3VvQGtl
cm5lbC5vcmc7DQo+IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgRmFiaW8gRXN0
ZXZhbQ0KPiA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgSmVyb21lIEZvcmlzc2llciA8amVyb21l
LmZvcmlzc2llckBsaW5hcm8ub3JnPjsNCj4gUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+OyBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGNsazogaW14OiBpbXg3ZDog
cmVtb3ZlIGNsa3NfaW5pdF9vbiBhcnJheQ0KPiANCj4gUXVvdGluZyBKZXJvbWUgRm9yaXNzaWVy
ICgyMDE4LTA4LTMxIDAxOjAxOjQ0KQ0KPiA+DQo+ID4NCj4gPiBPbiAwOC8zMS8yMDE4IDAzOjI5
IEFNLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+ID4gPiBRdW90aW5nIFBlbmcgRmFuICgyMDE4LTA4
LTEyIDE4OjE1OjQxKQ0KPiA+ID4+IEhpIEFuc29uLA0KPiA+ID4+DQo+ID4gPj4+Pj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+Pj4+PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiA+ID4+
Pj4+IFNlbnQ6IDIwMTjlubQ45pyIOOaXpSAxMjozOQ0KPiA+ID4+Pj4+IFRvOiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4+Pj4+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsNCj4gPiA+
Pj4+PiBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsNCj4gPiA+Pj4+
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPj4+Pj4gbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4+
Pj4+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiA+ID4+Pj4+IFN1Ympl
Y3Q6IFtQQVRDSCAyLzJdIGNsazogaW14OiBpbXg3ZDogcmVtb3ZlIGNsa3NfaW5pdF9vbiBhcnJh
eQ0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gQ2xvY2sgZnJhbWV3b3JrIHdpbGwgZW5hYmxlIHRob3Nl
IGNsb2NrcyByZWdpc3RlcmVkIHdpdGgNCj4gPiA+Pj4+PiBDTEtfSVNfQ1JJVElDQUwgZmxhZywg
c28gbm8gbmVlZCB0byBoYXZlIGNsa3NfaW5pdF9vbiBhcnJheQ0KPiA+ID4+Pj4+IGR1cmluZyBj
bG9jaw0KPiA+ID4+Pj4gaW5pdGlhbGl6YXRpb24gbm93Lg0KPiA+ID4+Pj4NCj4gPiA+Pj4+IFdp
bGwgaXQgYmUgbW9yZSBmbGV4aWJsZSB0byBwYXJzZSBkdHMgc2F5aW5nICJjcml0aWNhbC1jbG9j
a3MgPSA8eHh4PiINCj4gPiA+Pj4+IG9yICJpbml0LW9uLWFycmFyeT08eHh4PiINCj4gPiA+Pj4+
IGFuZCBlbmFibGUgdGhvc2UgY2xvY2tzPw0KPiA+ID4+Pg0KPiA+ID4+PiBQYXJzaW5nIHRoZSBj
bG9ja3MgYXJyYXlzIGZyb20gZHRiIGlzIGFub3RoZXIgd2F5IG9mIGVuYWJsaW5nDQo+ID4gPj4+
IGNyaXRpY2FsIGNsb2NrcywgYnV0IGZvciBjdXJyZW50IGkuTVg2LzcgcGxhdGZvcm1zLCB3ZSBp
bXBsZW1lbnQNCj4gPiA+Pj4gaXQgaW4gc2FtZSB3YXkgYXMgbW9zdCBvZiBvdGhlciBTb0NzLCBj
dXJyZW50bHkgSSBkaWQgTk9UIHNlZSBhbnkNCj4gPiA+Pj4gbmVjZXNzaXR5IG9mIHB1dHRpbmcg
dGhlbSBpbiBkdGIsIGp1c3QgYWRkaW5nIGZsYWcgZHVyaW5nIGNsb2NrDQo+ID4gPj4+IHJlZ2lz
dGVyaW5nIGlzIG1vcmUgc2ltcGxlLCBpZiB0aGVyZSBpcyBhbnkgc3BlY2lhbCByZXF1aXJlbWVu
dA0KPiA+ID4+PiBmb3IgZGlmZmVyZW50IGNsb2NrcyBzZXQgdG8gYmUgZW5hYmxlZCwgdGhlbiB3
ZSBjYW4gYWRkIHN1cHBvcnQgdG8gZW5hYmxlDQo+IHRoZSBtZXRob2Qgb2YgcGFyc2luZyBjcml0
aWNhbC1jbG9ja3MgZnJvbSBkdGIuIEp1c3QgbXkgdHdvIGNlbnRzLg0KPiA+ID4+DQo+ID4gPj4g
VGhpbmtpbmcgYWJvdXQgT1AtVEVFIHdhbnQgdG8gdXNlIG9uZSBkZXZpY2UsIGJ1dCBpdCdzIGNs
b2NrcyBhcmUNCj4gPiA+PiByZWdpc3RlcmVkIGJ5IExpbnV4LCBiZWNhdXNlIHRoZXJlIGlzIG5v
IG1vZHVsZSBpbiBMaW51eCBzaWRlIHVzZQ0KPiA+ID4+IGl0LCBpdCB3aWxsIHNodXRkb3duIHRo
ZSBjbG9jaywgd2hpY2ggY2F1c2UgT1AtVEVFIGNvdWxkIG5vdCBhY2Nlc3MgdGhlDQo+IGRldmlj
ZS4NCj4gPiA+Pg0KPiA+ID4+IFRoZW4gcGVvcGxlIGhhdmUgdG8gbW9kaWZ5IGNsayBjb2RlIHRv
IGFkZCBDTEtfSVNfQ1JJVElDQUwgZmxhZyB0bw0KPiA+ID4+IG1ha2Ugc3VyZSB0aGUgY2xvY2tz
IGFyZSBub3Qgc2h1dGRvd24gYnkgTGludXguDQo+ID4gPj4NCj4gPiA+PiBIb3dldmVyIGFkZGlu
ZyBhIG5ldyBwcm9wZXJ0eSBpbiBjbGsgbm9kZSBhbmQgbGV0IGRyaXZlciBjb2RlIHBhcnNlDQo+
ID4gPj4gdGhlIGR0cywgdGhlcmUgaXMgbm8gbmVlZCB0byBtb2RpZnkgY2xrIGRyaXZlciBjb2Rl
IHdoZW4gT1AtVEVFIG5lZWRzDQo+IGFub3RoZXIgZGV2aWNlIGNsb2NrLg0KPiA+ID4+DQo+ID4g
Pg0KPiA+ID4gSWYgT1AtVEVFIG5lZWRzIGxpbnV4IHRvIGtlZXAgdGhpbmdzIG9uIHRoZW4gd2h5
IGNhbid0IHRoZSBPUC1URUUNCj4gPiA+IGRyaXZlciBpbiBMaW51eCBwcm9iZSwgYWNxdWlyZSBj
bG9ja3MsIGFuZCBrZWVwIHRoZSBjbGtzIGVuYWJsZWQgZm9yZXZlcj8NCj4gPg0KPiA+IFNvdW5k
cyByZWFzb25hYmxlLCBidXQgaG93IGNvdWxkIHRoaXMgYmUgZG9uZSB3aXRob3V0IGludHJvZHVj
aW5nDQo+ID4gcGxhdGZvcm0tc3BlY2lmaWMgc3R1ZmYgaW4gdGhlIE9QLVRFRSBkcml2ZXI/DQo+
ID4NCj4gDQo+IFdoeSBpcyB0aGF0IGEgZ29hbD8NCiANCkkgZG8gTk9UIHRoaW5rIHdlIHNob3Vs
ZCBjb25zaWRlciBzdWNoIGNhc2UgaW4gdGhpcyBwYXRjaCBzZXJpZXMsIHdoYXRldmVyIE9QLVRF
RSBuZWVkcyBmb3IgaXRzIG93bg0KZmVhdHVyZSwgaXQgc2hvdWxkIGRvIG5lY2Vzc2FyeSBvcGVy
YXRpb25zIGVpdGhlciBpbiBpdHMgZHJpdmVyIG9yIHNvbWV3aGVyZSBlbHNlIGJ5IGFkZGluZyBu
ZXcgcGF0Y2guDQoNCkFuc29uLg0KDQo=
