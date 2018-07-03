Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA97C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF5824ED6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zj8rpSIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF5824ED6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753824AbeGCCNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:13:21 -0400
Received: from mail-eopbgr60061.outbound.protection.outlook.com ([40.107.6.61]:41493
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753608AbeGCCNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pv5G8WJVkGXO9m7I0l13jQxtnLF26fJWAJc8On+Dl2A=;
 b=Zj8rpSIZKvFhNYpFEPwnkQl935p4AG+yJ6Kc+MSQp1HgrNNPgWpwERtraWJRiLX52W7mS9GciXSDm28MscRCB95JcQF99Juaej2i6mkUcPe3sR90mXGBb1nf/SIsRgp45S81OccC+RHM8EWBczOhotxElVJxAZe+gK6WZSPlo04=
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com (10.163.7.13) by
 AM3PR04MB1473.eurprd04.prod.outlook.com (10.163.186.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.23; Tue, 3 Jul 2018 02:13:15 +0000
Received: from AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7]) by AM3PR04MB1315.eurprd04.prod.outlook.com
 ([fe80::a024:25ab:f457:64c7%7]) with mapi id 15.20.0906.026; Tue, 3 Jul 2018
 02:13:14 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio
 struct
Thread-Topic: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio
 struct
Thread-Index: AQHUEaR/HQsAfbLGPUuI4OYpOv9hDKR70DYAgADta/A=
Date:   Tue, 3 Jul 2018 02:13:14 +0000
Message-ID: <AM3PR04MB1315FEF9C8833B30DA665E7DF5420@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com>
 <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
In-Reply-To: <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR04MB1473;7:rXgzFOLMIEMym6Gy1rbY0TOj/2ugapZMXlK986vzJQ2TQs/IPJI6I9Suv+p0UmSXRPEYdf4MrzfU8cDVikbvm5drZhpSnrFBHi1e8Rafb3heDNF8S5QVrs0k+X3WMXP+ay6GnWAejFXB7Ph3ZaUx4DsSutnGtTpusCc4IUHAiNd/I+fgQYSqfbA/BKWqUMTMvx7LUxi1EnosFCpGoHDBW1MFDXjyL9i3DkfBgvr0eTeZGlnp25crfuOiBOLP0Oc1
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 628f2acc-dd18-4c8e-3567-08d5e08a88e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1473;
x-ms-traffictypediagnostic: AM3PR04MB1473:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-microsoft-antispam-prvs: <AM3PR04MB147343DD451E8C550D4FBAA0F5420@AM3PR04MB1473.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1473;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1473;
x-forefront-prvs: 0722981D2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(13464003)(6916009)(486006)(2900100001)(305945005)(229853002)(53936002)(105586002)(25786009)(6246003)(6436002)(33656002)(66066001)(55016002)(76176011)(476003)(446003)(106356001)(4326008)(11346002)(7696005)(9686003)(68736007)(74316002)(99286004)(54906003)(5660300001)(5250100002)(14454004)(8676002)(81156014)(81166006)(478600001)(8936002)(86362001)(26005)(53546011)(14444005)(256004)(102836004)(6506007)(6116002)(3846002)(2906002)(186003)(7736002)(316002)(97736004)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1473;H:AM3PR04MB1315.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: smX1awfItS4AYXrKNwvsSFh0kT98jYnIC+pysirmPAIvn/b6qFkXS/YBdG7tm7yReDEqx2viCSDGd+M5wwy9goOnq5SJyz6UJgLnWHGimVVUaXncEHo8XlbivAE1Oy/DWuLGUvoHbUBiBzUtuUaqH8dXCUZJI1yUGUyQVJibV/hUJUyM5XTXHnO35f5lOmeDYd/4LOLfVXAflHV63QC3hHWkruYlY96n1MBiHAneNpmX/skQPVeugHCV/HaNncNRL9w+UqhM/zK+arHXpCUgqGxG0XRvXJCP2Zt3I+khiX/nk6NJyn7NABwlGUqNLMjTBtTlled28VUfYIYZENBSCzDVEaykZRg0ujhp9UOM5mw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 628f2acc-dd18-4c8e-3567-08d5e08a88e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2018 02:13:14.8446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1473
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIExpbnVzDQoNCkFuc29uIEh1YW5nDQpCZXN0IFJlZ2FyZHMhDQoNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaW51cyBXYWxsZWlqIFttYWlsdG86bGludXMud2Fs
bGVpakBsaW5hcm8ub3JnXQ0KPiBTZW50OiBNb25kYXksIEp1bHkgMiwgMjAxOCA3OjQyIFBNDQo+
IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IFVsZiBIYW5zc29u
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgTWFzYWhpcm8gWWFtYWRhDQo+IDx5YW1hZGEubWFz
YWhpcm9Ac29jaW9uZXh0LmNvbT47IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50
ZWwuY29tPjsgZXZncmVlbkBjaHJvbWl1bS5vcmc7IFNoYXduIExpbg0KPiA8c2hhd24ubGluQHJv
Y2stY2hpcHMuY29tPjsgRmFiaW8gRXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsNCj4g
bGludXgtbW1jIDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCBWMl0gbW1jOiBjb3JlOiBjZF9sYWJlbCBtdXN0IGJlIGxhc3QgZW50cnkg
b2YgbW1jX2dwaW8NCj4gc3RydWN0DQo+IA0KPiBPbiBNb24sIEp1bCAyLCAyMDE4IGF0IDM6MzIg
QU0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiBj
b21taXQgYmZkNjk0ZDVlMjFjICgibW1jOiBjb3JlOiBBZGQgdHVuYWJsZSBkZWxheSBiZWZvcmUg
ZGV0ZWN0aW5nDQo+ID4gY2FyZCBhZnRlciBjYXJkIGlzIGluc2VydGVkIikgYWRkcw0KPiA+ICJ1
MzIgY2RfZGVib3VuY2VfZGVsYXlfbXMiIHRvIHRoZSBsYXN0IG9mIG1tY19ncGlvIHN0cnVjdCBh
bmQgY2F1c2UNCj4gPiAiY2hhciBjZF9sYWJlbFswXSIgTk9UIHdvcmsgYXMgc3RyaW5nIHBvaW50
ZXIgb2YgY2FyZCBkZXRlY3QgbGFiZWwsDQo+ID4gd2hlbiAiY2F0IC9wcm9jL2ludGVycnVwdHMi
LCB0aGUgZGV2bmFtZSBmb3IgY2FyZCBkZXRlY3QgZ3BpbyBpcw0KPiA+IGluY29ycmVjdCBhcyBi
ZWxvdzoNCj4gPg0KPiA+IDE0NDogICAgICAgICAgMCAgZ3Bpby1teGMgIDIyIEVkZ2UgICAgICDi
lpINCj4gPiAxNjE6ICAgICAgICAgIDAgIGdwaW8tbXhjICAgNyBFZGdlICAgICAg4paSDQo+ID4N
Cj4gPiBNb3ZlIHRoZSBjZF9sYWJlbCBmaWVsZCBkb3duIHRvIGZpeCB0aGlzLCBhbmQgZHJvcCB0
aGUgemVybyBmcm9tIHRoZQ0KPiA+IGFycmF5IHNpemUgdG8gcHJldmVudCBmdXR1cmUgc2ltaWxh
ciBidWdzLCB0aGUgcmVzdWx0IGlzIGNvcnJlY3QgYXMNCj4gPiBiZWxvdzoNCj4gPg0KPiA+IDE0
NDogICAgICAgICAgMCAgZ3Bpby1teGMgIDIyIEVkZ2UgICAgICAyMTk4MDAwLm1tYyBjZA0KPiA+
IDE2MTogICAgICAgICAgMCAgZ3Bpby1teGMgICA3IEVkZ2UgICAgICAyMTkwMDAwLm1tYyBjZA0K
PiA+DQo+ID4gRml4ZXM6IGJmZDY5NGQ1ZTIxYyAoIm1tYzogY29yZTogQWRkIHR1bmFibGUgZGVs
YXkgYmVmb3JlIGRldGVjdGluZw0KPiA+IGNhcmQgYWZ0ZXIgY2FyZCBpcyBpbnNlcnRlZCIpDQo+
ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4g
VGVzdGVkLWJ5OiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+DQo+IA0KPiBD
dXJpb3VzLg0KPiANCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3Nsb3QtZ3Bpby5jDQo+ID4g
KysrIGIvZHJpdmVycy9tbWMvY29yZS9zbG90LWdwaW8uYw0KPiA+IEBAIC0yNyw4ICsyNyw4IEBA
IHN0cnVjdCBtbWNfZ3BpbyB7DQo+ID4gICAgICAgICBib29sIG92ZXJyaWRlX2NkX2FjdGl2ZV9s
ZXZlbDsNCj4gPiAgICAgICAgIGlycXJldHVybl90ICgqY2RfZ3Bpb19pc3IpKGludCBpcnEsIHZv
aWQgKmRldl9pZCk7DQo+ID4gICAgICAgICBjaGFyICpyb19sYWJlbDsNCj4gPiAtICAgICAgIGNo
YXIgY2RfbGFiZWxbMF07DQo+ID4gICAgICAgICB1MzIgY2RfZGVib3VuY2VfZGVsYXlfbXM7DQo+
ID4gKyAgICAgICBjaGFyIGNkX2xhYmVsW107DQo+IA0KPiBOb3QgdGhhdCBJIGFtIHRoZSBzbWFy
dGVzdCBpbiB0aGUgd29ybGQgd2hlbiBpdCBjb21lcyB0byBob3cgdGhlIEMgY29tcGlsZXJzDQo+
IHdvcmsgdGhpcyBvdXQuDQo+IA0KPiBCdXQgaXNuJ3QgdGhhdCBlcXVpdmFsZW50IHRvOg0KPiBj
aGFyICpjZF9sYWJlbDsNCj4gPw0KDQpJIHRoaW5rIEMgY29tcGlsZXIgd2lsbCBjaGVjayBzdHJ1
Y3R1cmUgaWYgaXQgaGFzIGZsZXhpYmxlIGFycmF5LCB0aGUgZmxleGlibGUgYXJyYXkgbXVjaCBi
ZSBhdCBlbmQNCm9mIGEgc3RydWN0dXJlLCBhbmQgaXRzIHNpemUgY2FuIGJlIGR5bmFtaWMgY2hh
bmdlZCBieSBtYWxsb2NpbmcgYSBtZW1vcnkgZm9yIHRoaXMgc3RydWN0dXJlLA0KdGhlcmUgYXJl
IG1hbnkgc3VjaCBjYXNlIGluIGtlcm5lbC4gSWYgdGhlIGZsZXhpYmxlIGFycmF5IGlzIE5PVCBh
dCB0aGUgZW5kIG9mIGEgc3RydWN0LA0KZXJyb3IgIiBlcnJvcjogZmxleGlibGUgYXJyYXkgbWVt
YmVyIG5vdCBhdCBlbmQgb2Ygc3RydWN0IiB3aWxsIGNvbWUgb3V0IGJ5IEMgY29tcGlsZXIuDQoN
Cj4gDQo+IExvb2sgYXQgdGhpcyBmcm9tIGRyaXZlcnMvbW1jL2NvcmUvc2xvdC1ncGlvLmM6DQo+
IA0KPiBjdHgtPnJvX2xhYmVsID0gY3R4LT5jZF9sYWJlbCArIGxlbjsNCj4gY3R4LT5jZF9kZWJv
dW5jZV9kZWxheV9tcyA9IDIwMDsNCj4gc25wcmludGYoY3R4LT5jZF9sYWJlbCwgbGVuLCAiJXMg
Y2QiLCBkZXZfbmFtZShob3N0LT5wYXJlbnQpKTsNCj4gc25wcmludGYoY3R4LT5yb19sYWJlbCwg
bGVuLCAiJXMgcm8iLCBkZXZfbmFtZShob3N0LT5wYXJlbnQpKTsNCj4gaG9zdC0+c2xvdC5oYW5k
bGVyX3ByaXYgPSBjdHg7DQo+IGhvc3QtPnNsb3QuY2RfaXJxID0gLUVJTlZBTDsNCj4gDQo+IFNv
IG5vdyB0aGF0IHJvX2xhYmVsIGlzIGNoYXIgKiB0aGF0IHBvaW50cyBsZW4gY2hhcnMgaW50byB0
aGUgc3RydWN0IGFuZCB0aGF0IGlzIGFsbA0KPiBmaW5lIGFzIHRoZSBjdHggaXMgYWxsb2NhdGVk
IGxpa2UgdGhhdDoNCj4gDQo+IHN0cnVjdCBtbWNfZ3BpbyAqY3R4ID0gZGV2bV9remFsbG9jKGhv
c3QtPnBhcmVudCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZigqY3R4
KSArIDIgKiBsZW4sIEdGUF9LRVJORUwpOw0KPiANCj4gQW5kIEkndmUgc2VlbiB0aGlzIGJlaW5n
IGRvbmUgdG8gYWxsb2NhdGUgYSBzdGF0ZSB3aXRoIHNvbWUgZHluYW1pYyBzdHJpbmdzDQo+IGFm
dGVyIGl0Lg0KPiANCj4gQnV0IEkganVzdCBkb24ndCBsaWtlIHRoaXMsIGl0IHNlZW1zIGZyYWdp
bGUgYW5kIG5vdyBpdCBicm9rZS4NCiANCkkgdGhpbmsgdGhlIGRpZmZlcmVuY2Ugb2YgY3VycmVu
dCBpbXBsZW1lbnRhdGlvbiBhbmQgdXNpbmcgdHdvIHN0cmluZyBwb2ludGVycyBhcmUsDQpjdXJy
ZW50IGltcGxlbWVudGF0aW9uIGNhbiBvbmx5IGFsbG9jIG1lbW9yeSBmb3IgbW1jX2dwaW8gc3Ry
dWN0dXJlIG9uY2UsIHRoZSByb19sYWJlbCdzIGFkZHJlc3MNCmNhbiBiZSBnb3QgYnkgY2RfbGFi
ZWwncyBhZGRyZXNzLiBJZiB1c2luZyB0d28gc3RyaW5nIHBvaW50ZXJzIGZvciByb19sYWJlbCBh
bmQgY2RfbGFiZWwsDQp3ZSBoYXZlIHRvIGFsbG9jIHR3aWNlIGZvciB0aGVtIHNlcGFyYXRlbHku
DQoNCj4gDQo+IFdoYXQgYWJvdXQgdGhpczoNCj4gDQo+IEZyb20gZmFjYjM3OTlmNDc5YmZkNGRh
ZDk5YzI1YzljNWQ0Yzc3YjE0YzliMCBNb24gU2VwIDE3IDAwOjAwOjAwDQo+IDIwMDENCj4gRnJv
bTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5hcm8ub3JnPg0KPiBEYXRlOiBNb24s
IDIgSnVsIDIwMTggMTM6MzU6MDEgKzAyMDANCj4gU3ViamVjdDogW1BBVENIXSBtbWM6IHNsb3Qt
Z3BpbzogQWxsb2NhdGUgR1BJTyBsYWJlbHMgZHluYW1pY2FsbHkNCj4gDQo+IFRoZSB1c2Ugb2Yg
c3RyaW5nIHBvaW50ZXJzIGluIHRoZSBNTUMgc2xvdCBHUElPIGNvbnRleHQgaXMgcHJldHR5IGR1
YmlvdXMsDQo+IGFsbG9jYXRpbmcgc29tZSAyKmxlbiBleHRyYSBieXRlcyBmb3IgZWFjaCBsYWJl
bCBvZiB0aGUgcm8gYW5kIHdwIHBpbnMuDQo+IA0KPiBUaWR5IHRoaXMgdXAgdXNpbmcga2FzcHJp
bnRmKCkgd2l0aCBkeW5hbWljIGFsbG9jYXRpb24gb2YgbGFiZWxzIGZvciB0aGVzZSBzdHJpbmdz
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBsaW5h
cm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbW1jL2NvcmUvc2xvdC1ncGlvLmMgfCAxNSArKysr
KysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvc2xvdC1ncGlvLmMg
Yi9kcml2ZXJzL21tYy9jb3JlL3Nsb3QtZ3Bpby5jIGluZGV4DQo+IGVmMDVlMDAzOTM3OC4uYzQx
NzgwMWIzNjZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL3Nsb3QtZ3Bpby5jDQo+
ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2xvdC1ncGlvLmMNCj4gQEAgLTI3LDcgKzI3LDcgQEAg
c3RydWN0IG1tY19ncGlvIHsNCj4gICAgICBib29sIG92ZXJyaWRlX2NkX2FjdGl2ZV9sZXZlbDsN
Cj4gICAgICBpcnFyZXR1cm5fdCAoKmNkX2dwaW9faXNyKShpbnQgaXJxLCB2b2lkICpkZXZfaWQp
Ow0KPiAgICAgIGNoYXIgKnJvX2xhYmVsOw0KPiAtICAgIGNoYXIgY2RfbGFiZWxbMF07DQo+ICsg
ICAgY2hhciAqY2RfbGFiZWw7DQo+ICAgICAgdTMyIGNkX2RlYm91bmNlX2RlbGF5X21zOw0KPiAg
fTsNCj4gDQo+IEBAIC00NywxMyArNDcsMTggQEAgaW50IG1tY19ncGlvX2FsbG9jKHN0cnVjdCBt
bWNfaG9zdCAqaG9zdCkgIHsNCj4gICAgICBzaXplX3QgbGVuID0gc3RybGVuKGRldl9uYW1lKGhv
c3QtPnBhcmVudCkpICsgNDsNCiANCmxlbiBpcyBubyBuZWVkIGFueSBtb3JlLg0KDQo+ICAgICAg
c3RydWN0IG1tY19ncGlvICpjdHggPSBkZXZtX2t6YWxsb2MoaG9zdC0+cGFyZW50LA0KPiAtICAg
ICAgICAgICAgICAgIHNpemVvZigqY3R4KSArIDIgKiBsZW4sICAgIEdGUF9LRVJORUwpOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKCpjdHgpLCBHRlBfS0VSTkVMKTsNCj4gDQo+
ICAgICAgaWYgKGN0eCkgew0KPiAtICAgICAgICBjdHgtPnJvX2xhYmVsID0gY3R4LT5jZF9sYWJl
bCArIGxlbjsNCj4gICAgICAgICAgY3R4LT5jZF9kZWJvdW5jZV9kZWxheV9tcyA9IDIwMDsNCj4g
LSAgICAgICAgc25wcmludGYoY3R4LT5jZF9sYWJlbCwgbGVuLCAiJXMgY2QiLCBkZXZfbmFtZSho
b3N0LT5wYXJlbnQpKTsNCj4gLSAgICAgICAgc25wcmludGYoY3R4LT5yb19sYWJlbCwgbGVuLCAi
JXMgcm8iLCBkZXZfbmFtZShob3N0LT5wYXJlbnQpKTsNCj4gKyAgICAgICAgY3R4LT5jZF9sYWJl
bCA9IGRldm1fa2FzcHJpbnRmKGhvc3QtPnBhcmVudCwgR0ZQX0tFUk5FTCwNCj4gKyAgICAgICAg
ICAgICAgICAiJXMgY2QiLCBkZXZfbmFtZShob3N0LT5wYXJlbnQpKTsNCj4gKyAgICAgICAgaWYg
KCFjdHgtPmNkX2xhYmVsKQ0KPiArICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsgICAg
ICAgIGN0eC0+cm9fbGFiZWwgPSBkZXZtX2thc3ByaW50Zihob3N0LT5wYXJlbnQsIEdGUF9LRVJO
RUwsDQo+ICsgICAgICAgICAgICAgICAgIiVzIHJvIiwgZGV2X25hbWUoaG9zdC0+cGFyZW50KSk7
DQo+ICsgICAgICAgIGlmICghY3R4LT5yb19sYWJlbCkNCj4gKyAgICAgICAgICAgIHJldHVybiAt
RU5PTUVNOw0KPiAgICAgICAgICBob3N0LT5zbG90LmhhbmRsZXJfcHJpdiA9IGN0eDsNCj4gICAg
ICAgICAgaG9zdC0+c2xvdC5jZF9pcnEgPSAtRUlOVkFMOw0KPiAgICAgIH0NCj4gLS0NCj4gMi4x
Ny4wDQo+IA0KPiBJIGNhbiBzZW5kIGl0IGFzIGEgc2VwYXJhdGUgcGF0Y2ggaWYgeW91IGxpa2Ug
aXQuDQoNCkkgdGhpbmsgZWl0aGVyIHdheSBpcyBPSywgc2luY2UgZmxleGlibGUgYXJyYXkgaXMg
dXNlZCBpbiBrZXJuZWwgY29kZSBxdWl0ZSBjb21tb25seSwNCnNvIEkgcHJlZmVyIHRvIG1ha2Ug
Y29kZSBjaGFuZ2UgYXMgc21hbGwgYXMgcG9zc2libGUsIHRoZSBvcmlnaW5hbCBwYXRjaCBjYW4g
YWxzbyBwcmV2ZW50DQpzaW1pbGFyIGJ1ZyBpbiBmdXR1cmUuIEFuZCBsaWtlIGJlbG93IGNvbW1p
dCBGYWJpbyBwb2ludGVkIG91dCwgaXQgYWxzbyBoYXMgc2FtZSBraW5kDQpvZiBmaXg6IGExNTg1
MzFmM2M5MiAoImdwaW86IDc0eDE2NDogRml4IGNyYXNoIGR1cmluZyAucmVtb3ZlKCkiKS4gVGhh
bmtzLg0KDQpBbnNvbi4NCg0KPiANCj4gWW91cnMsDQo+IExpbnVzIFdhbGxlaWoNCg==
