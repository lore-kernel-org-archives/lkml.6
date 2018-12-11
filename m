Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B276C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B482A20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ewOy54X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B482A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbeLKDnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:43:51 -0500
Received: from mail-eopbgr00084.outbound.protection.outlook.com ([40.107.0.84]:52352
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729863AbeLKDnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqznE78KrTplrkwN05XQujP+S5qZoSiDnkt3beCxG9I=;
 b=ewOy54X4TARJz0GUFFIJdtgTCLIs66QJNoV9r88cP/dFfj3LZoIJt9jPgceI9gIg3xufCtaLU7AOqJ22bbz4HyiFRisUtqh5CbpQQLDVal65USa50MPuGQc4QF2HNaUhZF3LyCSAiZ4NcxtBAjwHfmkKk+EUc6iuw8NiRXQ2oJo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3673.eurprd04.prod.outlook.com (52.134.70.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 03:43:47 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 03:43:47 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Phil Reid <preid@electromag.com.au>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
Thread-Topic: [PATCH V4 2/2] iio: light: isl29018: add optional vdd/vdda
 regulator operation support
Thread-Index: AQHUkQD7YnUpJgt5iEONteRFHRrUpKV441EAgAAB1+A=
Date:   Tue, 11 Dec 2018 03:43:46 +0000
Message-ID: <DB3PR0402MB39161ED492C863BB48D48E2FF5A60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1544498291-2716-1-git-send-email-Anson.Huang@nxp.com>
 <1544498291-2716-2-git-send-email-Anson.Huang@nxp.com>
 <d07b5970-5825-2ea6-9e27-538386927923@electromag.com.au>
In-Reply-To: <d07b5970-5825-2ea6-9e27-538386927923@electromag.com.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3673;6:YuLPYnvPjHagUafvZUAiO/OJfHucniunYw8B2Y4n3782Tekq0Wvh1y+NVjKvqYsk9Iipv4TAtzdUwWxdYJYNXbJkUkTCQf3GGnEUrjY79OBuvNFkjPGplbugRE4ZgwhdaPRUHYLLsMcXMaHu9Z5vSvWylGbYqxd06mNN5tJnYS7J5932uAmX+DnWQhNOQPr56sVmEJgFGoWqj6Gaad1uQQHTcF7sitBlMwyamVQiaZ0dFeSXPXLtroPoBHxz9OYmxBtendHSCZ59tjg+6MdhRJte600pbJC5VPXtcUoyP0pvCLEQS6uhd8T/x5qidun+CX9Q31DIFCtIW1PJtHkQX6rIufR0MpeXbeavZYQ61TKczHLjkSMPIXUHNUXHA8Datm7ntMFxU17tNJ+V4I7DL5uRoAS/r5VyJ+QCsQyySIrv2d+ZFtrOQAmOaTULDSUCpo2DIVESc61A374DCTpmBw==;5:wcYkFLTMTUoWlSpZCS1T4SnwcIQ8PP5044ck9GBdkXgKQH4Rhb0AvKWl5aRl2ecMMbjZlHuU1lUVUrqW2oTzUmj3w9E+AuBd13BYbfMB+e/YxVYLGK6CRwc85iCM131d4A1ixOOLdfjjXk7wSveRud6GyaoWQbm83nS5lbjaBq0=;7:ZbEgn67ZsgPLC10+vguxwfKMJg3iThqMFIhzjtPzR1+WR84vIq5dI4n/lknLomlmLUN3cktbA1eJg5yl6ljaldruEQTQkoeNnDK2N5ZDqq4CUTTNf1uA8poakQODaQDAH+sHtUZtJp+PWOc79dSnXA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e63f6537-1623-4a31-f899-08d65f1adb31
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3673;
x-ms-traffictypediagnostic: DB3PR0402MB3673:
x-microsoft-antispam-prvs: <DB3PR0402MB36733A9097F5DBBF0A640FD0F5A60@DB3PR0402MB3673.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230017)(999002)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231472)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3673;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3673;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(54534003)(13464003)(189003)(199004)(71200400001)(7416002)(4326008)(71190400001)(105586002)(2906002)(5660300001)(25786009)(66066001)(316002)(53546011)(110136005)(7696005)(86362001)(106356001)(6506007)(256004)(97736004)(2501003)(186003)(14444005)(102836004)(14454004)(2201001)(99286004)(26005)(478600001)(39060400002)(74316002)(6116002)(446003)(68736007)(9686003)(3846002)(81156014)(81166006)(76176011)(476003)(8936002)(55016002)(229853002)(11346002)(6436002)(44832011)(7736002)(8676002)(53936002)(33656002)(305945005)(486006)(6246003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3673;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 771HEQOAccc6qxRs7hz7xjBB974+soC9UA2dSLxX5pNun6Y5SKylFNxKebhiGteXCrs6f7ze1BgirfxJGnMIM9csQBuGOdn3lTvWtQwoQL0XzTJMyubkgrV/v/diblCQrXFkWscK5RRjkytg+AL4I0F3c6UHw9FE/9n1a+u0JLR5+9l9Ms9X3NywxeBNo87juk+J6BS98bn5WcNLynIIUsJBViMT37jDs9U9Dz6U5XHZpUhlEX9iClqhUQaCHVEeS48ilRXtDza689M8PkmfEnzdh74kJaIYnXmXuiD0gIQJzhI/X+lTxzr6maLms8Jc
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63f6537-1623-4a31-f899-08d65f1adb31
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 03:43:46.9946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWwNCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsIFJlaWQgW21haWx0bzpwcmVpZEBlbGVjdHJvbWFn
LmNvbS5hdV0NCj4gU2VudDogMjAxOOW5tDEy5pyIMTHml6UgMTE6MzYNCj4gVG86IEFuc29uIEh1
YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgamljMjNAa2VybmVsLm9yZzsNCj4ga25hYWNrLmhA
Z214LmRlOyBsYXJzQG1ldGFmb28uZGU7IHBtZWVyd0BwbWVlcncubmV0Ow0KPiByb2JoK2R0QGtl
cm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC1paW9Admdlci5rZXJuZWwub3Jn
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY0IDIvMl0gaWlvOiBsaWdodDogaXNs
MjkwMTg6IGFkZCBvcHRpb25hbCB2ZGQvdmRkYQ0KPiByZWd1bGF0b3Igb3BlcmF0aW9uIHN1cHBv
cnQNCj4gDQo+IE9uIDExLzEyLzIwMTggMTE6MjQgYW0sIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+
IFRoZSBsaWdodCBzZW5zb3IncyBwb3dlciBzdXBwbHkgY291bGQgYmUgY29udHJvbGxlZCBieSBy
ZWd1bGF0b3Igb24NCj4gPiBzb21lIHBsYXRmb3Jtcywgc3VjaCBhcyBpLk1YNlEtU0FCUkVTRCBi
b2FyZCwgdGhlIGxpZ2h0IHNlbnNvcg0KPiA+IGlzbDI5MDIzJ3MgcG93ZXIgc3VwcGx5IGlzIGNv
bnRyb2xsZWQgYnkgYSBHUElPIGZpeGVkIHJlZ3VsYXRvciwgbmVlZA0KPiA+IHRvIG1ha2Ugc3Vy
ZSB0aGUgcmVndWxhdG9yIGlzIGVuYWJsZWQgYmVmb3JlIGFueSBvcGVyYXRpb24gb2Ygc2Vuc29y
LA0KPiA+IHRoaXMgcGF0Y2ggYWRkcyBvcHRpb25hbCB2ZGQvdmRkYSByZWd1bGF0b3Igb3BlcmF0
aW9uIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VMb2cgc2luY2UgVjM6DQo+ID4gCS0g
aW1wcm92ZSB0aGUgZXJyb3IgaGFuZGxpbmcgb2YgZGV2bV9yZWd1bGF0b3JfZ2V0X29wdGlvbmFs
Ow0KPiA+IAktIG1ha2Ugc3VyZSByZWd1bGF0b3JzIGFyZSBkaXNhYmxlZCBpbiBlcnJvciBwYXRo
Lg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9paW8vbGlnaHQvaXNsMjkwMTguYyB8IDgzDQo+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lpby9saWdodC9pc2wyOTAxOC5jDQo+ID4gYi9kcml2ZXJzL2lpby9s
aWdodC9pc2wyOTAxOC5jIGluZGV4IGI0NTQwMGYuLmEyMTY1MmIgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9paW8vbGlnaHQvaXNsMjkwMTguYw0KPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2xpZ2h0
L2lzbDI5MDE4LmMNCj4gPiBAQCAtMjMsNiArMjMsNyBAQA0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4
L211dGV4Lmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiAgICNpbmNsdWRl
IDxsaW51eC9yZWdtYXAuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1l
ci5oPg0KPiA+ICAgI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51
eC9paW8vaWlvLmg+DQo+ID4gICAjaW5jbHVkZSA8bGludXgvaWlvL3N5c2ZzLmg+DQo+ID4gQEAg
LTk1LDYgKzk2LDggQEAgc3RydWN0IGlzbDI5MDE4X2NoaXAgew0KPiA+ICAgCXN0cnVjdCBpc2wy
OTAxOF9zY2FsZQlzY2FsZTsNCj4gPiAgIAlpbnQJCQlwcm94X3NjaGVtZTsNCj4gPiAgIAlib29s
CQkJc3VzcGVuZGVkOw0KPiA+ICsJc3RydWN0IHJlZ3VsYXRvcgkqdmRkX3JlZzsNCj4gPiArCXN0
cnVjdCByZWd1bGF0b3IJKnZkZGFfcmVnOw0KPiA+ICAgfTsNCj4gPg0KPiA+ICAgc3RhdGljIGlu
dCBpc2wyOTAxOF9zZXRfaW50ZWdyYXRpb25fdGltZShzdHJ1Y3QgaXNsMjkwMThfY2hpcCAqY2hp
cCwNCj4gPiBAQCAtNzM1LDYgKzczOCwzNCBAQCBzdGF0aWMgaW50IGlzbDI5MDE4X3Byb2JlKHN0
cnVjdCBpMmNfY2xpZW50DQo+ID4gKmNsaWVudCwNCj4gPg0KPiA+ICAgCW11dGV4X2luaXQoJmNo
aXAtPmxvY2spOw0KPiA+DQo+ID4gKwljaGlwLT52ZGRfcmVnID0gZGV2bV9yZWd1bGF0b3JfZ2V0
X29wdGlvbmFsKCZjbGllbnQtPmRldiwgInZkZCIpOw0KPiA+ICsJaWYgKCFJU19FUlIoY2hpcC0+
dmRkX3JlZykpIHsNCj4gPiArCQllcnIgPSByZWd1bGF0b3JfZW5hYmxlKGNoaXAtPnZkZF9yZWcp
Ow0KPiA+ICsJCWlmIChlcnIpIHsNCj4gPiArCQkJZGV2X2VycigmY2xpZW50LT5kZXYsICJmYWls
ZWQgdG8gZW5hYmxlIFZERCByZWd1bGF0b3JcbiIpOw0KPiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+
ICsJCX0NCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZXJyID0gUFRSX0VSUihjaGlwLT52ZGRfcmVn
KTsNCj4gPiArCQlpZiAoZXJyICE9IC1FTk9ERVYpDQo+ID4gKwkJCXJldHVybiBlcnI7DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJY2hpcC0+dmRkYV9yZWcgPSBkZXZtX3JlZ3VsYXRvcl9nZXRfb3B0
aW9uYWwoJmNsaWVudC0+ZGV2LCAidmRkYSIpOw0KPiA+ICsJaWYgKCFJU19FUlIoY2hpcC0+dmRk
YV9yZWcpKSB7DQo+ID4gKwkJZXJyID0gcmVndWxhdG9yX2VuYWJsZShjaGlwLT52ZGRhX3JlZyk7
DQo+ID4gKwkJaWYgKGVycikgew0KPiA+ICsJCQlkZXZfZXJyKCZjbGllbnQtPmRldiwgImZhaWxl
ZCB0byBlbmFibGUgVkREQSByZWd1bGF0b3JcbiIpOw0KPiA+ICsJCQlpZiAoIUlTX0VSUihjaGlw
LT52ZGRfcmVnKSkNCj4gPiArCQkJCXJlZ3VsYXRvcl9kaXNhYmxlKGNoaXAtPnZkZF9yZWcpOw0K
PiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+ICsJCX0NCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJZXJy
ID0gUFRSX0VSUihjaGlwLT52ZGRhX3JlZyk7DQo+ID4gKwkJaWYgKGVyciAhPSAtRU5PREVWKQ0K
PiA+ICsJCQlyZXR1cm4gZXJyOw0KPiBtYXliZSBnb3RvIGRpc2FibGVfcmVndWxhdG9yczsgdG8g
ZGlzYWJsZSB2ZGQuDQoNCkFncmVlLCBJIHdpbGwgdXNlICIgZ290byBkaXNhYmxlX3JlZ3VsYXRv
cnM7IiBpbiBib3RoIGhlcmUgYW5kIHVwcGVyIHJlZ3VsYXRvciBlbmFibGUgZmFpbCBjYXNlLg0K
UGxlYXNlIGhlbHAgcmV2aWV3IFY1LCB0aGFua3MuDQoNCkFuc29uDQoNCj4gDQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICAgCWNoaXAtPnR5cGUgPSBkZXZfaWQ7DQo+ID4gICAJY2hpcC0+Y2FsaWJzY2Fs
ZSA9IDE7DQo+ID4gICAJY2hpcC0+dWNhbGlic2NhbGUgPSAwOw0KPiA+IEBAIC03NDcsMTIgKzc3
OCwxMiBAQCBzdGF0aWMgaW50IGlzbDI5MDE4X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGll
bnQsDQo+ID4gICAJaWYgKElTX0VSUihjaGlwLT5yZWdtYXApKSB7DQo+ID4gICAJCWVyciA9IFBU
Ul9FUlIoY2hpcC0+cmVnbWFwKTsNCj4gPiAgIAkJZGV2X2VycigmY2xpZW50LT5kZXYsICJyZWdt
YXAgaW5pdGlhbGl6YXRpb24gZmFpbHM6ICVkXG4iLCBlcnIpOw0KPiA+IC0JCXJldHVybiBlcnI7
DQo+ID4gKwkJZ290byBkaXNhYmxlX3JlZ3VsYXRvcnM7DQo+ID4gICAJfQ0KPiA+DQo+ID4gICAJ
ZXJyID0gaXNsMjkwMThfY2hpcF9pbml0KGNoaXApOw0KPiA+ICAgCWlmIChlcnIpDQo+ID4gLQkJ
cmV0dXJuIGVycjsNCj4gPiArCQlnb3RvIGRpc2FibGVfcmVndWxhdG9yczsNCj4gPg0KPiA+ICAg
CWluZGlvX2Rldi0+aW5mbyA9IGlzbDI5MDE4X2NoaXBfaW5mb190YmxbZGV2X2lkXS5pbmRpb19p
bmZvOw0KPiA+ICAgCWluZGlvX2Rldi0+Y2hhbm5lbHMgPSBpc2wyOTAxOF9jaGlwX2luZm9fdGJs
W2Rldl9pZF0uY2hhbm5lbHM7DQo+ID4gQEAgLTc2MSwxMyArNzkyLDI0IEBAIHN0YXRpYyBpbnQg
aXNsMjkwMThfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCj4gPiAgIAlpbmRpb19k
ZXYtPmRldi5wYXJlbnQgPSAmY2xpZW50LT5kZXY7DQo+ID4gICAJaW5kaW9fZGV2LT5tb2RlcyA9
IElORElPX0RJUkVDVF9NT0RFOw0KPiA+DQo+ID4gLQlyZXR1cm4gZGV2bV9paW9fZGV2aWNlX3Jl
Z2lzdGVyKCZjbGllbnQtPmRldiwgaW5kaW9fZGV2KTsNCj4gPiArCWVyciA9IGRldm1faWlvX2Rl
dmljZV9yZWdpc3RlcigmY2xpZW50LT5kZXYsIGluZGlvX2Rldik7DQo+ID4gKwlpZiAoIWVycikN
Cj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2Rpc2FibGVfcmVndWxhdG9yczoNCj4gPiAr
CWlmICghSVNfRVJSKGNoaXAtPnZkZF9yZWcpKQ0KPiA+ICsJCXJlZ3VsYXRvcl9kaXNhYmxlKGNo
aXAtPnZkZF9yZWcpOw0KPiA+ICsJaWYgKCFJU19FUlIoY2hpcC0+dmRkYV9yZWcpKQ0KPiA+ICsJ
CXJlZ3VsYXRvcl9kaXNhYmxlKGNoaXAtPnZkZGFfcmVnKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
ZXJyOw0KPiA+ICAgfQ0KPiA+DQo+IFtzbmlwXQ0KPiANCj4gLS0NCj4gUmVnYXJkcw0KPiBQaGls
DQo=
