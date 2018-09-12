Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C0C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7377920866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 09:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYvXk1VC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7377920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeILOpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 10:45:20 -0400
Received: from mail-ve1eur01on0052.outbound.protection.outlook.com ([104.47.1.52]:59803
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726138AbeILOpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 10:45:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqtKrWJy8C+sPP4FGHeVo6lhyjmF3N9FOlcgW9xNaFI=;
 b=UYvXk1VCl9uni3lK/JR18ty4A4dfRVDLPIS1Gm190ETneG6a0xBNUdbv2GUciv1roZgJ6DxHw5fT13Neei0UOm3dKn+UyLzC59QumKX1lI7kxqqUpbZN+Ia1Oa1zBfqIi8vwAK1EW5UgF0LDjX0szWvXEhBRgMopjNX4FeVW7FA=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3397.eurprd04.prod.outlook.com (52.133.19.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.16; Wed, 12 Sep 2018 09:41:31 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::918c:7f25:5892:764%2]) with mapi id 15.20.1122.020; Wed, 12 Sep 2018
 09:41:31 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>, Leo Li <leoyang.li@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] bus: fsl-mc: add support for dpseci device type
Thread-Topic: [PATCH v2 01/12] bus: fsl-mc: add support for dpseci device type
Thread-Index: AQHUSnb6Nbm1R/tmjEO1jrgniPFxxKTsZKIA
Date:   Wed, 12 Sep 2018 09:41:31 +0000
Message-ID: <1d9bd63f-7170-d64a-71bf-07401fde32d3@nxp.com>
References: <20180912085937.22489-1-horia.geanta@nxp.com>
 <20180912085937.22489-2-horia.geanta@nxp.com>
In-Reply-To: <20180912085937.22489-2-horia.geanta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3397;6:cr4zqeJAMlKxHgiJIYxNctBFgmmz268naKfziSEF55hZEOC9OHT50eEL6lKYBQO9QQaD8vgfJoPKGNSVUddybo7znvkup1YwIk/nT8uTpYh5nkY6Tgo98L3Lk5Zi4arIN1P8YrTU5E3N6RioUDD+BABgkl4VJ7XuBghQYG+icS77wd1EXDftwAF0SHc96nMdiw0XpKM7swrFOM6TMgKcY5Vb9h9Ml9QlC+T8krdKLQM6J0XlzeeES0xHK4DHCQFDbAyZd1JNLf++K38gI/rzBjXiFPHKvM4c7HedqVl9l9c2MHXBQqlVCVDvr1/0R1TUsw7R/snHncw2TxHCbLWpsn+rCNwR/v6v6xxxtU+E9Ok9nIHgvF9MNi1v0fo8kCMuCZZndDu497TTm6PMxohACsMt5lLuzJrdFP2Ebc4RY96H+wjWeOD4Lwz5XRnRWwcR//RX9Hxkh7TLhY8dhs6Xug==;5:To7GpO2EheETbYV5AJRdX5khWcI57+SV6ML/JWCV7dSENKpyZxvLZN+aI4GcCZqJSFZzDILKmBW9pKkO+FNVR95OwOtOAtTaU0Zm8H4LYKG8DNsu8Zcgts9gvApbn8E+Lo5KpY8vyIjmJFb98sgt83CVtfDzzFvsAP+RM7xNDF8=;7:GUO3Yq4uvTDTskZqnFoK+m3JyCkqwcuDBnkb0gcnriiEIyNXKVpEAYXVftxB36fUhlYB/GT99br83Y9Ani8hON180W4hEI+Nb0VquKjOkbeu7Mq7jSNvfYRUE6FgWzcvUMyuaWrehsnnJmtXngIw7XH0sVFNux4/jDtZh6ElYktAw8asiLA/2o0uiAp0E1BabBSR9e6eRVB/LhnXav3XHQIdunr+ZVaICuEB+0apVxMIyeyE3pGTaN8OXIWINA2U
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 25ce43c7-30c1-43d5-f0ef-08d61893ebad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3397;
x-ms-traffictypediagnostic: AM6PR0402MB3397:
x-microsoft-antispam-prvs: <AM6PR0402MB33976566D4029B2E27970FE3EC1B0@AM6PR0402MB3397.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM6PR0402MB3397;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3397;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(366004)(396003)(136003)(346002)(199004)(189003)(5660300001)(31686004)(105586002)(106356001)(53936002)(99286004)(76176011)(110136005)(54906003)(8936002)(5250100002)(81166006)(81156014)(2906002)(316002)(446003)(476003)(44832011)(2616005)(486006)(478600001)(11346002)(6116002)(14454004)(6512007)(2900100001)(6246003)(97736004)(53546011)(6506007)(39060400002)(66066001)(26005)(102836004)(4326008)(25786009)(36756003)(305945005)(86362001)(31696002)(6436002)(256004)(3846002)(7736002)(229853002)(8676002)(6486002)(68736007)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3397;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: dTJcegoPs9hGTzhC5/kRP1Z4beosKPukjJNutl/RgS6ahjOcWxUlfQfcXF4P3a3CkXjKk5dl9XAuvSy+u6oDbs5KZdfVp+pY4nvy0BneHQUi+71kGfF9fKelo2N2GfeooBBZOY1OCVAh2jz0fe3zzbW5WgXIlDpzCZ2Jf8C0F6moo799Cc3rw8UoBtqRbmntnn6l8vfG+knfIkl5fqc5TGgNgRTqsHcjw2p56YThH/afIPTmvkRf6RNTgseaBlpMOZPkW5WFC3e6OR5TWB3iavJq8wrYu0pHfVGPQiudpM1mYoZbt9n5us6R/6Y/hXUkOVWqhEBaHTafh2py094iRCFEHbPVkqnQpH0KlCFVg8U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C7E84BA29B47B44BBA8AB945B207911@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ce43c7-30c1-43d5-f0ef-08d61893ebad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 09:41:31.1467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDEyLjA5LjIwMTggMTE6NTksIEhvcmlhIEdlYW50xIMgd3JvdGU6DQo+IFNpZ25lZC1v
ZmYtYnk6IEhvcmlhIEdlYW50xIMgPGhvcmlhLmdlYW50YUBueHAuY29tPg0KDQpBY2tlZC1ieTog
TGF1cmVudGl1IFR1ZG9yIDxsYXVyZW50aXUudHVkb3JAbnhwLmNvbT4NCg0KPiAtLS0NCj4gICBk
cml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jIHwgNSArKysrKw0KPiAgIGluY2x1ZGUvbGlu
dXgvZnNsL21jLmggICAgICAgICAgfCA2ICsrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wt
bWMtYnVzLmMgYi9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jDQo+IGluZGV4IDVkODI2
NmM2NTcxZi4uNDU1MmIwNmZlNjAxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2J1cy9mc2wtbWMv
ZnNsLW1jLWJ1cy5jDQo+ICsrKyBiL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVzLmMNCj4g
QEAgLTE4OCw2ICsxODgsMTAgQEAgc3RydWN0IGRldmljZV90eXBlIGZzbF9tY19idXNfZHBydGNf
dHlwZSA9IHsNCj4gICAJLm5hbWUgPSAiZnNsX21jX2J1c19kcHJ0YyINCj4gICB9Ow0KPiAgIA0K
PiArc3RydWN0IGRldmljZV90eXBlIGZzbF9tY19idXNfZHBzZWNpX3R5cGUgPSB7DQo+ICsJLm5h
bWUgPSAiZnNsX21jX2J1c19kcHNlY2kiDQo+ICt9Ow0KPiArDQo+ICAgc3RhdGljIHN0cnVjdCBk
ZXZpY2VfdHlwZSAqZnNsX21jX2dldF9kZXZpY2VfdHlwZShjb25zdCBjaGFyICp0eXBlKQ0KPiAg
IHsNCj4gICAJc3RhdGljIGNvbnN0IHN0cnVjdCB7DQo+IEBAIC0yMDMsNiArMjA3LDcgQEAgc3Rh
dGljIHN0cnVjdCBkZXZpY2VfdHlwZSAqZnNsX21jX2dldF9kZXZpY2VfdHlwZShjb25zdCBjaGFy
ICp0eXBlKQ0KPiAgIAkJeyAmZnNsX21jX2J1c19kcG1jcF90eXBlLCAiZHBtY3AiIH0sDQo+ICAg
CQl7ICZmc2xfbWNfYnVzX2RwbWFjX3R5cGUsICJkcG1hYyIgfSwNCj4gICAJCXsgJmZzbF9tY19i
dXNfZHBydGNfdHlwZSwgImRwcnRjIiB9LA0KPiArCQl7ICZmc2xfbWNfYnVzX2Rwc2VjaV90eXBl
LCAiZHBzZWNpIiB9LA0KPiAgIAkJeyBOVUxMLCBOVUxMIH0NCj4gICAJfTsNCj4gICAJaW50IGk7
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzbC9tYy5oIGIvaW5jbHVkZS9saW51eC9m
c2wvbWMuaA0KPiBpbmRleCBmMjdjYjE0MDg4YTQuLjUxNjBmMDZmZmJhYyAxMDA2NDQNCj4gLS0t
IGEvaW5jbHVkZS9saW51eC9mc2wvbWMuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2ZzbC9tYy5o
DQo+IEBAIC00MDUsNiArNDA1LDcgQEAgZXh0ZXJuIHN0cnVjdCBkZXZpY2VfdHlwZSBmc2xfbWNf
YnVzX2RwY29uX3R5cGU7DQo+ICAgZXh0ZXJuIHN0cnVjdCBkZXZpY2VfdHlwZSBmc2xfbWNfYnVz
X2RwbWNwX3R5cGU7DQo+ICAgZXh0ZXJuIHN0cnVjdCBkZXZpY2VfdHlwZSBmc2xfbWNfYnVzX2Rw
bWFjX3R5cGU7DQo+ICAgZXh0ZXJuIHN0cnVjdCBkZXZpY2VfdHlwZSBmc2xfbWNfYnVzX2RwcnRj
X3R5cGU7DQo+ICtleHRlcm4gc3RydWN0IGRldmljZV90eXBlIGZzbF9tY19idXNfZHBzZWNpX3R5
cGU7DQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSBib29sIGlzX2ZzbF9tY19idXNfZHByYyhjb25z
dCBzdHJ1Y3QgZnNsX21jX2RldmljZSAqbWNfZGV2KQ0KPiAgIHsNCj4gQEAgLTQ1MSw2ICs0NTIs
MTEgQEAgc3RhdGljIGlubGluZSBib29sIGlzX2ZzbF9tY19idXNfZHBydGMoY29uc3Qgc3RydWN0
IGZzbF9tY19kZXZpY2UgKm1jX2RldikNCj4gICAJcmV0dXJuIG1jX2Rldi0+ZGV2LnR5cGUgPT0g
JmZzbF9tY19idXNfZHBydGNfdHlwZTsNCj4gICB9DQo+ICAgDQo+ICtzdGF0aWMgaW5saW5lIGJv
b2wgaXNfZnNsX21jX2J1c19kcHNlY2koY29uc3Qgc3RydWN0IGZzbF9tY19kZXZpY2UgKm1jX2Rl
dikNCj4gK3sNCj4gKwlyZXR1cm4gbWNfZGV2LT5kZXYudHlwZSA9PSAmZnNsX21jX2J1c19kcHNl
Y2lfdHlwZTsNCj4gK30NCj4gKw0KPiAgIC8qDQo+ICAgICogRGF0YSBQYXRoIEJ1ZmZlciBQb29s
IChEUEJQKSBBUEkNCj4gICAgKiBDb250YWlucyBpbml0aWFsaXphdGlvbiBBUElzIGFuZCBydW50
aW1lIGNvbnRyb2wgQVBJcyBmb3IgRFBCUA0KPiA=
