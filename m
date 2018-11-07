Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68718C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFD02086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N0pcYHKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFD02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKGWb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:31:27 -0500
Received: from mail-eopbgr40074.outbound.protection.outlook.com ([40.107.4.74]:4025
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727430AbeKGWb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgscAZvAbGTzjaMlfAchxzgf/IJUqfgW0mYH9hbHGa8=;
 b=N0pcYHKsgur0Il0aaIjLL2kLYIWPLVPMSaID/Zo3J7WxQwBbFijPRBAupgxWcXbDX+iVT+tAuf2CyA+BZ+7gUEGhFl1IrkcCs5zAeYStq2T6ehuMs3K21QgGx18MnLybkrhCqrCo9ojYJ8I4rZtDL+7H3EshmEl5Wjz09xUzMZ4=
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com (52.133.29.151) by
 AM6PR0402MB3400.eurprd04.prod.outlook.com (52.133.19.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.25; Wed, 7 Nov 2018 13:01:03 +0000
Received: from AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5b4:a289:51c4:e3fd]) by AM6PR0402MB3864.eurprd04.prod.outlook.com
 ([fe80::5b4:a289:51c4:e3fd%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 13:01:03 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Roy Pledge <roy.pledge@nxp.com>,
        "stuyoder@gmail.com" <stuyoder@gmail.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Youri Querry <youri.querry_1@nxp.com>
Subject: Re: [PATCH v1 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Topic: [PATCH v1 1/2] bus: mc-bus: Add support for mapping shareable
 portals
Thread-Index: AQHUcI9rFEMxwzn5Ake0lcQUSuJFKKVEUsGA
Date:   Wed, 7 Nov 2018 13:01:03 +0000
Message-ID: <85808a79-0b56-bbb7-5ee9-635beae497d6@nxp.com>
References: <1540931418-10697-1-git-send-email-roy.pledge@nxp.com>
 <1540931418-10697-2-git-send-email-roy.pledge@nxp.com>
In-Reply-To: <1540931418-10697-2-git-send-email-roy.pledge@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3400;6:MeVS/78Tc79LtUOLZLBg3NgKePqq1bOGAu0gU0VYNQEKvGL09Ae/vcNHVidQsPaawdOr5JMg2i1nE9G2hcId3MM+rxRRkVe3wXm1dGdC2psM61IELEo4I7hfM/YchhYWVAuVaGKWrtSYFrclZc/PyBtBDZkXHtsd7Eo6LpbHcXTTEzvjuVfjfzXx8RXTL4xjHEh3nrSBTlYNqbA0IOy0uV3lSc7X32oPVk6goRYuRLK/6kXCca9Rj/d++E/y5nLcPVaMAqhhpuYVdTNdzfOb5vcNDJeUfHzzljMUTsAWGB/QDvPQZa9nZ5N2NzSUH2tUCai72kj1S02a1i6Cx6aDxM4eaapEkUSgsrAM54E0jAYe9vij355DMvdnisU7U49aJQLW3mpqE/2YiMXdawChSfEHpgOeF2U38KFXgodFXPVDaUcgZNtUinwg+a6g3GR4bMY52kHqbQFkKP3NsS/5ug==;5:+SBrps2gajmlnrZAIGJR7XL+PjYMJcU22J790hoQBbtE8mJrkXgSTqobjyEl9Q3f6HNHay6HiABmIXjEUW6ty3ni8RYcvuIY+WCiCPoRrtqqjsPf9985j4DgRqiZ5fZ3HE/vtbP15/5dpyFfCdRkX6b3hbYrGEqjK4UgSKagwi0=;7:tE/1f6itYD6hLBQHqprCGfHjEhnG4URajidh5HOcAksc/x+pTs0+peznvzgTjJXamGsIzVbUsTT1hKDshIZvTBDlCSWsP4CAixZdClXn/jsCm7svLFM6uLozVQYf2Ci3ZAISaXRUiI0vPymMpZjwJw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 6fc30cc1-1ae2-4d50-6363-08d644b112ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3400;
x-ms-traffictypediagnostic: AM6PR0402MB3400:
x-microsoft-antispam-prvs: <AM6PR0402MB340067DA0078431144DD2944ECC40@AM6PR0402MB3400.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(227817650892897)(275809806118684)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3400;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3400;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(366004)(199004)(189003)(6506007)(7736002)(36756003)(53546011)(99286004)(2906002)(81156014)(81166006)(8676002)(68736007)(229853002)(5660300001)(76176011)(478600001)(6436002)(8936002)(102836004)(6512007)(6486002)(26005)(66066001)(2201001)(6246003)(86362001)(71200400001)(2900100001)(53936002)(31696002)(305945005)(71190400001)(14454004)(3846002)(6116002)(97736004)(186003)(11346002)(446003)(39060400002)(25786009)(256004)(476003)(2616005)(2501003)(105586002)(316002)(14444005)(4326008)(486006)(110136005)(44832011)(31686004)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3400;H:AM6PR0402MB3864.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /ZFwI4rn4hTjw3FB6EuL/aGSG9aIKgGmwriT3cM4JdV5c73nVTkJrMlbpGAwjp4xglFr09oLIDx43QUy3bzgt+DwIwY28c/iyGwg89laAhnGhwmWTVhRaTAhjxW0E5P9o/H1QvoEWTQfw9Dcgweqondb2nZv6WyIUgTOcJSP3/2AjpoTkPTMbeH4MPKWmmhDAyJwc3oM2HGQpuM45QxfR4G0TeXD6lVUaSCtjZGYtg1bbSLv9WzKHIi/6hhitQ/KjGu22n7SXpE0OHSKk94Xes1qMsFYD6dDTDxb3S59rMv+5PwKhC2YDHA/VB4OfyAjeeMulLzp/CsnpALLXdpohobv8/1ckyso6ZRZmTIuxAY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <775BA8EF92BB984CA88F02D2D7EF362F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc30cc1-1ae2-4d50-6363-08d644b112ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 13:01:03.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm95LA0KT24gMzAuMTAuMjAxOCAyMjozMCwgUm95IFBsZWRnZSB3cm90ZToNCj4gU3RhcnRp
bmcgd2l0aCB2NSBvZiBOWFAgUUJNYW4gZGV2aWNlcyB0aGUgaGFyZHdhcmUgc3VwcG9ydHMgdXNp
bmcNCj4gcmVndWxhciBjYWNoZWFibGUvc2hhcmVhYmxlIG1lbW9yeSBhcyB0aGUgYmFja2luZyBz
dG9yZSBmb3IgdGhlDQo+IHBvcnRhbHMuDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBm
b3IgdGhlIG5ldyBwb3J0YWwgbW9kZSBieSBzd2l0Y2hpbmcgdG8NCj4gdXNlIHRoZSBEUFJDIGdl
dCBvYmplY3QgcmVnaW9uIHYyIGNvbW1hbmQgd2hpY2ggcmV0dXJucyBib3RoDQo+IGEgYmFzZSBh
ZGRyZXNzIGFuZCBvZmZzZXQgZm9yIHRoZSBwb3J0YWwgbWVtb3J5LiBUaGUgbmV3IHBvcnRhbA0K
PiByZWdpb24gaXMgaWRlbnRpZmllZCBhcyBzaGFyZWFibGUgdGhyb3VnaCB0aGUgYWRkaXRpb24g
b2YgYSBuZXcNCj4gZmxhZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJveSBQbGVkZ2UgPHJveS5w
bGVkZ2VAbnhwLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9idXMvZnNsLW1jL2RwcmMuYyAgICAg
ICAgICAgfCAgMyArKy0NCj4gICBkcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLWJ1cy5jICAgICB8
IDE0ICsrKysrKysrKysrKy0tDQo+ICAgZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1tYy1wcml2YXRl
LmggfCAxNyArKysrKysrKysrKysrKy0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjggaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9m
c2wtbWMvZHByYy5jIGIvZHJpdmVycy9idXMvZnNsLW1jL2RwcmMuYw0KPiBpbmRleCAxYzNmNjIx
Li5iZGU4NTZkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2J1cy9mc2wtbWMvZHByYy5jDQo+ICsr
KyBiL2RyaXZlcnMvYnVzL2ZzbC1tYy9kcHJjLmMNCj4gQEAgLTQ2MSw4ICs0NjEsOSBAQCBpbnQg
ZHByY19nZXRfb2JqX3JlZ2lvbihzdHJ1Y3QgZnNsX21jX2lvICptY19pbywNCj4gICANCj4gICAJ
LyogcmV0cmlldmUgcmVzcG9uc2UgcGFyYW1ldGVycyAqLw0KPiAgIAlyc3BfcGFyYW1zID0gKHN0
cnVjdCBkcHJjX3JzcF9nZXRfb2JqX3JlZ2lvbiAqKWNtZC5wYXJhbXM7DQo+IC0JcmVnaW9uX2Rl
c2MtPmJhc2Vfb2Zmc2V0ID0gbGU2NF90b19jcHUocnNwX3BhcmFtcy0+YmFzZV9hZGRyKTsNCj4g
KwlyZWdpb25fZGVzYy0+YmFzZV9vZmZzZXQgPSBsZTY0X3RvX2NwdShyc3BfcGFyYW1zLT5iYXNl
X29mZnNldCk7DQo+ICAgCXJlZ2lvbl9kZXNjLT5zaXplID0gbGUzMl90b19jcHUocnNwX3BhcmFt
cy0+c2l6ZSk7DQo+ICsJcmVnaW9uX2Rlc2MtPmJhc2VfYWRkcmVzcyA9IGxlNjRfdG9fY3B1KHJz
cF9wYXJhbXMtPmJhc2VfYWRkcik7DQo+ICAgDQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVzLmMgYi9kcml2ZXJzL2J1cy9m
c2wtbWMvZnNsLW1jLWJ1cy5jDQo+IGluZGV4IGYwNDA0YzYuLjI1YWQ0MjIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvYnVzL2ZzbC1tYy9mc2wtbWMtYnVzLmMNCj4gKysrIGIvZHJpdmVycy9idXMv
ZnNsLW1jL2ZzbC1tYy1idXMuYw0KPiBAQCAtNDg3LDEwICs0ODcsMTggQEAgc3RhdGljIGludCBm
c2xfbWNfZGV2aWNlX2dldF9tbWlvX3JlZ2lvbnMoc3RydWN0IGZzbF9tY19kZXZpY2UgKm1jX2Rl
diwNCj4gICAJCQkJImRwcmNfZ2V0X29ial9yZWdpb24oKSBmYWlsZWQ6ICVkXG4iLCBlcnJvcik7
DQo+ICAgCQkJZ290byBlcnJvcl9jbGVhbnVwX3JlZ2lvbnM7DQo+ICAgCQl9DQo+IC0NCj4gLQkJ
ZXJyb3IgPSB0cmFuc2xhdGVfbWNfYWRkcihtY19kZXYsIG1jX3JlZ2lvbl90eXBlLA0KPiArCQkv
KiBPbGRlciBNQyBvbmx5IHJldHVybmVkIHJlZ2lvbiBvZmZzZXQgYW5kIG5vIGJhc2UgYWRkcmVz
cw0KPiArCQkgKiBJZiBiYXNlIGFkZHJlc3MgaXMgaW4gdGhlIHJlZ2lvbl9kZXNjIHVzZSBpdCBv
dGhlcndpc2UNCj4gKwkJICogcmV2ZXJ0IHRvIG9sZCBtZWNoYW5pc20NCj4gKwkJICovDQo+ICsJ
CWlmIChyZWdpb25fZGVzYy5iYXNlX2FkZHJlc3MpDQo+ICsJCQlyZWdpb25zW2ldLnN0YXJ0ID0g
cmVnaW9uX2Rlc2MuYmFzZV9hZGRyZXNzICsNCj4gKwkJCQkJCXJlZ2lvbl9kZXNjLmJhc2Vfb2Zm
c2V0Ow0KPiArCQllbHNlDQo+ICsJCQllcnJvciA9IHRyYW5zbGF0ZV9tY19hZGRyKG1jX2Rldiwg
bWNfcmVnaW9uX3R5cGUsDQo+ICAgCQkJCQkgIHJlZ2lvbl9kZXNjLmJhc2Vfb2Zmc2V0LA0KPiAg
IAkJCQkJICAmcmVnaW9uc1tpXS5zdGFydCk7DQo+ICsNCj4gICAJCWlmIChlcnJvciA8IDApIHsN
Cj4gICAJCQlkZXZfZXJyKHBhcmVudF9kZXYsDQo+ICAgCQkJCSJJbnZhbGlkIE1DIG9mZnNldDog
JSN4IChmb3IgJXMuJWRcJ3MgcmVnaW9uICVkKVxuIiwNCj4gQEAgLTUwNCw2ICs1MTIsOCBAQCBz
dGF0aWMgaW50IGZzbF9tY19kZXZpY2VfZ2V0X21taW9fcmVnaW9ucyhzdHJ1Y3QgZnNsX21jX2Rl
dmljZSAqbWNfZGV2LA0KPiAgIAkJcmVnaW9uc1tpXS5mbGFncyA9IElPUkVTT1VSQ0VfSU87DQo+
ICAgCQlpZiAocmVnaW9uX2Rlc2MuZmxhZ3MgJiBEUFJDX1JFR0lPTl9DQUNIRUFCTEUpDQo+ICAg
CQkJcmVnaW9uc1tpXS5mbGFncyB8PSBJT1JFU09VUkNFX0NBQ0hFQUJMRTsNCj4gKwkJaWYgKHJl
Z2lvbl9kZXNjLmZsYWdzICYgRFBSQ19SRUdJT05fU0hBUkVBQkxFKQ0KPiArCQkJcmVnaW9uc1tp
XS5mbGFncyB8PSBJT1JFU09VUkNFX01FTTsNCj4gICAJfQ0KPiAgIA0KPiAgIAltY19kZXYtPnJl
Z2lvbnMgPSByZWdpb25zOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9idXMvZnNsLW1jL2ZzbC1t
Yy1wcml2YXRlLmggYi9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLXByaXZhdGUuaA0KPiBpbmRl
eCBlYTExYjRmLi4yOGU0MGQxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2J1cy9mc2wtbWMvZnNs
LW1jLXByaXZhdGUuaA0KPiArKysgYi9kcml2ZXJzL2J1cy9mc2wtbWMvZnNsLW1jLXByaXZhdGUu
aA0KPiBAQCAtNzksOSArNzksMTEgQEAgaW50IGRwbWNwX3Jlc2V0KHN0cnVjdCBmc2xfbWNfaW8g
Km1jX2lvLA0KPiAgIA0KPiAgIC8qIERQUkMgY29tbWFuZCB2ZXJzaW9uaW5nICovDQo+ICAgI2Rl
ZmluZSBEUFJDX0NNRF9CQVNFX1ZFUlNJT04JCQkxDQo+ICsjZGVmaW5lIERQUkNfQ01EXzJORF9W
RVJTSU9OCQkJMg0KPiAgICNkZWZpbmUgRFBSQ19DTURfSURfT0ZGU0VUCQkJNA0KPiAgIA0KPiAg
ICNkZWZpbmUgRFBSQ19DTUQoaWQpCSgoKGlkKSA8PCBEUFJDX0NNRF9JRF9PRkZTRVQpIHwgRFBS
Q19DTURfQkFTRV9WRVJTSU9OKQ0KPiArI2RlZmluZSBEUFJDX0NNRF9WMihpZCkJKCgoaWQpIDw8
IERQUkNfQ01EX0lEX09GRlNFVCkgfCBEUFJDX0NNRF8yTkRfVkVSU0lPTikNCj4gICANCj4gICAv
KiBEUFJDIGNvbW1hbmQgSURzICovDQo+ICAgI2RlZmluZSBEUFJDX0NNRElEX0NMT1NFICAgICAg
ICAgICAgICAgICAgICAgICAgRFBSQ19DTUQoMHg4MDApDQo+IEBAIC05OSw3ICsxMDEsNyBAQCBp
bnQgZHBtY3BfcmVzZXQoc3RydWN0IGZzbF9tY19pbyAqbWNfaW8sDQo+ICAgI2RlZmluZSBEUFJD
X0NNRElEX0dFVF9DT05UX0lEICAgICAgICAgICAgICAgICAgRFBSQ19DTUQoMHg4MzApDQo+ICAg
I2RlZmluZSBEUFJDX0NNRElEX0dFVF9PQkpfQ09VTlQgICAgICAgICAgICAgICAgRFBSQ19DTUQo
MHgxNTkpDQo+ICAgI2RlZmluZSBEUFJDX0NNRElEX0dFVF9PQkogICAgICAgICAgICAgICAgICAg
ICAgRFBSQ19DTUQoMHgxNUEpDQo+IC0jZGVmaW5lIERQUkNfQ01ESURfR0VUX09CSl9SRUcgICAg
ICAgICAgICAgICAgICBEUFJDX0NNRCgweDE1RSkNCj4gKyNkZWZpbmUgRFBSQ19DTURJRF9HRVRf
T0JKX1JFRyAgICAgICAgICAgICAgICAgIERQUkNfQ01EX1YyKDB4MTVFKQ0KDQpJIHNlZSB5b3Un
cmUgYnVtcGluZyB0aGlzIGNvbW1hbmQncyB2ZXJzaW9uIHRvIHYyLiBXaWxsIHdlIHN0aWxsIGJl
IA0KY29tcGF0aWJsZSB3aXRoIG9sZGVyIE1DIGZpcm13YXJlIHZlcnNpb25zPw0KDQotLS0NCkJl
c3QgUmVnYXJkcywgTGF1cmVudGl1
