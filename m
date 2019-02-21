Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA1C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="di0p058y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfBUORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:17:24 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:40672
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbfBUORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kOfndGeT7CCLZRRBM0gshmGxC3C1sjfDDc8ipqaJ/bg=;
 b=di0p058yDTQkDR/OMZJl5bdJyn6Nvlon4OBcenONLS6xqq2ivZXLW/lPtJUzUGggnwztBeubl8ytIesNiz2F+/qo+Epzx7aUeyjJ2kkZH5fXK6hGG+iicYykvMYCFX1qsLlF3lU3+ZxZzTpFjxVsI9rehKlVuZUiDPSqy4/WDyk=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB1934.eurprd04.prod.outlook.com (10.166.140.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 21 Feb 2019 14:17:17 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::208f:755e:b057:2cfe%8]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 14:17:17 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Peter Rosin <peda@axentia.se>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUyeOzPrJOZ7UkNky2yNQN5dmaTqXqQsEAgAAJnuA=
Date:   Thu, 21 Feb 2019 14:17:17 +0000
Message-ID: <VI1PR0401MB24962C5D61CB8B4BA08DA491F17E0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190221181230.4892-1-pankaj.bansal@nxp.com>
 <70f7fa07-9643-a302-2162-362afbe123d6@axentia.se>
In-Reply-To: <70f7fa07-9643-a302-2162-362afbe123d6@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [49.36.128.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25f8b4eb-ccf4-4ea8-3e13-08d698074936
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0401MB1934;
x-ms-traffictypediagnostic: VI1PR0401MB1934:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDFNQjE5MzQ7MjM6SC82ZmhpeE5GemZiK1pLakxTTUN6VEM3?=
 =?utf-8?B?a2xtKzhJZE0vNnpxVWpYeUxsMHlRNEgybXJhcFB1Qk1WRFRXVlJmdktid2Uv?=
 =?utf-8?B?MVQxaktpaENpY1VxeDJJRmlic2EweXdCdWJzbE1xSmcrZVZGWUVlRmN6RFRS?=
 =?utf-8?B?MVF0MHNaMGxtKzNUaXFyZm5qekNVK3BTdkR2Qmd2dmVvUWxuaHBibHorOHpz?=
 =?utf-8?B?U1pTUGpHdi9kTzBjSDdKQ1hRR2JoaXh1SDFMV2VBMlhVYkRmN3J2ek9oSmEv?=
 =?utf-8?B?RmhnWG9RUkJTRTQwSXprREFMa2hadG9kcExkaGhPZ1BqcmsxTTFyanRDeFpX?=
 =?utf-8?B?RUUya1VVcWNZSGdaT01iYlNQVXRKVkQvNk1sTWFJZmFwcXEybWwyMTdZSlBu?=
 =?utf-8?B?cGtUNDYzWEw1Q01ITys5UE9SZWdacDNqV2JEaSt6Wkk4NE1xZE1kS3k4S3lv?=
 =?utf-8?B?UDYwMHpBTlh4UEE0WEZKRUdJWS8vb2JnM3U1Y0tMcFkyTXYyU2pXYnprdFRK?=
 =?utf-8?B?Qng4a010OElCTG1TR0h2dzY2ejQvZ1ZhckVJVU5TSDRCYk1tMHNLdVNVRzkx?=
 =?utf-8?B?MzMrUVZhc2VpczJ5SjdSdXJIT2VMMy8zVDFENXVKaGcvRmsvMjRvekdVTzY3?=
 =?utf-8?B?ZzFWYlZXU3grdzN2QUhiaFcrSUFhQjBqTHRDVFp2cEhMOE90eGpDelN3S0hq?=
 =?utf-8?B?M2dJc1I3QjVJaE5jL2tONm5adWlxV3o4elF5SlpsS08vTkJKdE9YcWVPRElK?=
 =?utf-8?B?b0VPTnoreE9HWVhycHNDSU5WUmc2UGJ5Q3c3ckJhcmVCb0IrOEtYaUlYazg3?=
 =?utf-8?B?aGdaMVhnT3VSNnpaRHBxejBFNE9JVGt4WVhMOWNyRVBHMVdGbENaL0tPazN3?=
 =?utf-8?B?V3IyVlVraFMxTVpNdmcyTjdtY0VCWVlvclZVd2JvS21NQ0dwS3VXRVcxT1kr?=
 =?utf-8?B?UzFFdDFNbVJVbTRPR2RVbHpoU3VCR1NtdHZ1VWowVGU1MW1ZUzZkenBIWVM2?=
 =?utf-8?B?Y2g2S0YxYVNDeFMwZTRUWHQ3aG0rRVhmYXVIVUk2Sjh0OTZvc1VzVzhsVUdO?=
 =?utf-8?B?UElLZjRlOWt5eE1XVmVyQnIraENZbkduMzJzQWg4cXN5bitmSEdQU25QS3Yw?=
 =?utf-8?B?RnNwOThFeTM2ekx0cng1L3hNakNFZXB2MXVhUHV4QzJTU3NqU3U2aTQwWnZL?=
 =?utf-8?B?OHpiZGVHSFZwL2lUVFJCbHJkclN5ek9CbCtzR3FvalZIMUJkdS9vb3QxYVNp?=
 =?utf-8?B?YzBrQjFhTEVTQUkwM1BybXRIalA1R2ExYnVhUkpRUmV5STlkWVNYdllzV1pi?=
 =?utf-8?B?MUk3aUZnMlE4cmJuM3owOFdBS09PQVVqUllSUzFRM2duNzYvWlV3TmRGS0lQ?=
 =?utf-8?B?RXd4T05JeE1GRENNbEdWOE9LQ2FEM3RFUW5lZ3o5a0R4eXhhczBtZXpEbWIz?=
 =?utf-8?B?d2RHY1BtQitxc0g2a3NTanQ1L3NwL1h1L2twbEpjdjUxOTNLNFdjTjBURlF0?=
 =?utf-8?B?MGJjQkp1RTg2TDhjajBPTkZwTERJMXlBakIxL2tjRk9jc2hQelhWTmMwSmo0?=
 =?utf-8?B?TWs2S0tSeHVJSEJpWGFKNGpqeWo1dGtmd0p4WGNZa2xkemhsR2pid0RYSUI4?=
 =?utf-8?B?ejRnTzBsTHRhWjRYRTcxZEQ5dFFRY2xETjhuejRqRTFycTYxZjZYbWc5ak1L?=
 =?utf-8?B?Ry9ZalBwLy9Oa2NLSEtnTkxRQVNzM1dIR3BLL2o2TFJhL1NKRkdUcGl2YjhE?=
 =?utf-8?B?ZURRTmFiUjhiUjBLZ3NrQXVnPT0=?=
x-microsoft-antispam-prvs: <VI1PR0401MB19342DD01F765A4C19E1DE92F17E0@VI1PR0401MB1934.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(13464003)(86362001)(106356001)(25786009)(81156014)(6506007)(76176011)(2906002)(74316002)(7696005)(6246003)(316002)(53546011)(81166006)(186003)(33656002)(26005)(110136005)(99286004)(102836004)(305945005)(5660300002)(4326008)(68736007)(105586002)(8676002)(8936002)(7736002)(478600001)(44832011)(71190400001)(71200400001)(3846002)(6636002)(6116002)(97736004)(6436002)(14454004)(446003)(476003)(229853002)(66066001)(9686003)(486006)(14444005)(55016002)(256004)(53936002)(11346002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB1934;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GQA6nEcXSNhZKvjvLWRz5KUqtmkGwwG+Vcwvq0i/EbwfrxUyg7ep08jL70ZjMyj2g8suY2AUSMxpvaXjMrF2pILrLo318TZDehbkEgt4GI/jhas9pWu0vFVLYFpbsGjtUtuj77MPqXukwsMQsmddw/LddtTXHS3/szFpngbxEspiIKugjun1AMUl73FLgUzKnSQ22VF8+037J5edOd6vs4vPuVrThgvf7MBF4mVz3x21FDci9oyCM5hx5YqCzydJj1DP24Z/fMVCkybFzj8jLNouObweZ+gV1VXG7ocOpiyEUV2ZN+enSnHLopYlPHSvT4c3aF1ryFZXQF88ZsOMzfG3iujqessRENkE9y2BwdomEi2lDFMTYttXJO1e4S+skYSE9O009D3/fqAcOrUxpqcJTIQ0J1FWSZK8E+hKQOI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25f8b4eb-ccf4-4ea8-3e13-08d698074936
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 14:17:17.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB1934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIgUm9zaW4gW21h
aWx0bzpwZWRhQGF4ZW50aWEuc2VdDQo+IFNlbnQ6IFRodXJzZGF5LCAyMSBGZWJydWFyeSwgMjAx
OSAwNzoxMiBQTQ0KPiBUbzogUGFua2FqIEJhbnNhbCA8cGFua2FqLmJhbnNhbEBueHAuY29tPjsg
TGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRyaXZlcnM6IG11eDogQWRkIEdlbmVy
aWMgcmVnbWFwIGJpdGZpZWxkLWJhc2VkDQo+IG11bHRpcGxleGVyIGluIG1taW8tbXV4DQo+IA0K
PiBIaSENCj4gDQo+IE11Y2ggYmV0dGVyLCB0aGFua3MhIE9uZSBuaXQgYmVsb3c6DQo+IA0KPiBP
biAyMDE5LTAyLTIxIDEzOjQ4LCBQYW5rYWogQmFuc2FsIHdyb3RlOg0KPiA+IEdlbmVyaWMgcmVn
aXN0ZXIgYml0ZmllbGQtYmFzZWQgbXVsdGlwbGV4ZXIgdGhhdCBjb250cm9scyB0aGUNCj4gPiBt
dWx0aXBsZXhlciBwcm9kdWNlciBkZWZpbmVkIHVuZGVyIGEgcGFyZW50IG5vZGUuDQo+ID4gVGhl
IGRyaXZlciBjb3JyZXNwb25kaW5nIHRvIHBhcmVudCBub2RlIHByb3ZpZGVzIHJlZ2lzdGVyIHJl
YWQvd3JpdGUNCj4gPiBjYXBhYmlsaXRpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYW5r
YWogQmFuc2FsIDxwYW5rYWouYmFuc2FsQG54cC5jb20+DQo+ID4gLS0tDQo+ID4NCj4gPiBOb3Rl
czoNCj4gPiAgICAgVjI6DQo+ID4gICAgIC0gcmVtb3ZlZCBzZXBlcmF0ZSBkcml2ZXIgcmVnbWFw
LmMgYW5kIGFkZGVkIHRoZSByZWdtYXAgZnVuY3Rpb24gaW4NCj4gbW1pby5jDQo+ID4gICAgICAg
YmFzZWQgb24gY29tcGF0aWJsZSBmaWVsZCwgdGhlIHN5c2NvbiBvciByZWdtYXAgZnVuY3Rpb24g
d291bGQgYmUgY2FsbGVkDQo+ID4gICAgIC0gTW9kaWZpZWQgdGhlIEtDb25maWcgYXMgcGVyIFBl
dGVyJ3MgY29tbWVudHMNCj4gPg0KPiA+ICBkcml2ZXJzL211eC9LY29uZmlnIHwgMTIgKysrKysr
LS0tLS0tICBkcml2ZXJzL211eC9tbWlvLmMgIHwgIDYNCj4gPiArKysrKy0NCj4gPiAgMiBmaWxl
cyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXV4L0tjb25maWcgYi9kcml2ZXJzL211eC9LY29uZmlnIGluZGV4
DQo+ID4gNzY1OWQ2YzVmNzE4Li5lNWM1NzFmZDIzMmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tdXgvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvbXV4L0tjb25maWcNCj4gPiBAQCAtNDYs
MTQgKzQ2LDE0IEBAIGNvbmZpZyBNVVhfR1BJTw0KPiA+ICAJICBiZSBjYWxsZWQgbXV4LWdwaW8u
DQo+ID4NCj4gPiAgY29uZmlnIE1VWF9NTUlPDQo+ID4gLQl0cmlzdGF0ZSAiTU1JTyByZWdpc3Rl
ciBiaXRmaWVsZC1jb250cm9sbGVkIE11bHRpcGxleGVyIg0KPiA+IC0JZGVwZW5kcyBvbiAoT0Yg
JiYgTUZEX1NZU0NPTikgfHwgQ09NUElMRV9URVNUDQo+ID4gKwl0cmlzdGF0ZSAiTU1JTy9SZWdt
YXAgcmVnaXN0ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciINCj4gPiArCWRlcGVu
ZHMgb24gT0YgfHwgQ09NUElMRV9URVNUDQo+ID4gIAloZWxwDQo+ID4gLQkgIE1NSU8gcmVnaXN0
ZXIgYml0ZmllbGQtY29udHJvbGxlZCBNdWx0aXBsZXhlciBjb250cm9sbGVyLg0KPiA+ICsJICBN
TUlPL1JlZ21hcCByZWdpc3RlciBiaXRmaWVsZC1jb250cm9sbGVkIE11bHRpcGxleGVyIGNvbnRy
b2xsZXIuDQo+ID4NCj4gPiAtCSAgVGhlIGRyaXZlciBidWlsZHMgbXVsdGlwbGV4ZXIgY29udHJv
bGxlcnMgZm9yIGJpdGZpZWxkcyBpbiBhIHN5c2Nvbg0KPiA+IC0JICByZWdpc3Rlci4gRm9yIE4g
Yml0IHdpZGUgYml0ZmllbGRzLCB0aGVyZSB3aWxsIGJlIDJeTiBwb3NzaWJsZQ0KPiA+IC0JICBt
dWx0aXBsZXhlciBzdGF0ZXMuDQo+ID4gKwkgIFRoZSBkcml2ZXIgYnVpbGRzIG11bHRpcGxleGVy
IGNvbnRyb2xsZXJzIGZvciBiaXRmaWVsZHMgaW4gZWl0aGVyDQo+ID4gKwkgIGEgc3lzY29uIHJl
Z2lzdGVyIG9yIGEgZHJpdmVyIHJlZ21hcCByZWdpc3Rlci4gRm9yIE4gYml0IHdpZGUNCj4gPiAr
CSAgYml0ZmllbGRzLCB0aGVyZSB3aWxsIGJlIDJeTiBwb3NzaWJsZSBtdWx0aXBsZXhlciBzdGF0
ZXMuDQo+ID4NCj4gPiAgCSAgVG8gY29tcGlsZSB0aGUgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9v
c2UgTSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwNCj4gPiAgCSAgYmUgY2FsbGVkIG11eC1tbWlvLg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL211eC9tbWlvLmMgYi9kcml2ZXJzL211eC9tbWlvLmMg
aW5kZXgNCj4gPiA5MzVhYzQ0YWEyMDkuLjM3ZmJjZGU3ZjFmYyAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL211eC9tbWlvLmMNCj4gPiArKysgYi9kcml2ZXJzL211eC9tbWlvLmMNCj4gPiBAQCAt
MjgsNiArMjgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG11eF9jb250cm9sX29wcyBtdXhfbW1p
b19vcHMgPSB7DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXV4
X21taW9fZHRfaWRzW10gPSB7DQo+ID4gIAl7IC5jb21wYXRpYmxlID0gIm1taW8tbXV4IiwgfSwN
Cj4gPiArCXsgLmNvbXBhdGlibGUgPSAicmVnLW11eCIsIH0sDQo+ID4gIAl7IC8qIHNlbnRpbmVs
ICovIH0NCj4gPiAgfTsNCj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXV4X21taW9fZHRf
aWRzKTsgQEAgLTQzLDcgKzQ0LDEwIEBADQo+IHN0YXRpYw0KPiA+IGludCBtdXhfbW1pb19wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJaW50IHJldDsNCj4gPiAgCWlu
dCBpOw0KPiA+DQo+ID4gLQlyZWdtYXAgPSBzeXNjb25fbm9kZV90b19yZWdtYXAobnAtPnBhcmVu
dCk7DQo+ID4gKwlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsICJtbWlvLW11eCIpKQ0K
PiA+ICsJCXJlZ21hcCA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChucC0+cGFyZW50KTsNCj4gPiAr
CWVsc2UNCj4gPiArCQlyZWdtYXAgPSBkZXZfZ2V0X3JlZ21hcChkZXYtPnBhcmVudCwgTlVMTCk7
DQo+IA0KPiBkZXZfZ2V0X3JlZ21hcCgpIHJldHVybnMgTlVMTCBvbiBmYWlsdXJlLCBzbyBJIHRo
aW5rIHlvdSBuZWVkIHNvbWV0aGluZyBsaWtlOg0KPiANCj4gCQlyZWdtYXAgPSBkZXZfZ2V0X3Jl
Z21hcChkZXYtPnBhcmVudCwgTlVMTCkgPzogRVJSX1BUUigtDQo+IEVJTlZBTCk7DQo+IA0KPiBP
ciBwZXJoYXBzIC1FTk9ERVYsIC1FTk9UU1VQUCBvciBzb21ldGhpbmcsIG5vdCBzdXJlPw0KDQpI
b3cgYWJvdXQgSVNfRVJSX09SX05VTEwganVzdCBiZWxvdyB0aGlzLCB3aGVyZSByaWdodCBub3cg
SVNfRVJSIGlzIGJlaW5nIHVzZWQgPw0KDQo+IA0KPiBDaGVlcnMsDQo+IFBldGVyDQo+IA0KPiA+
ICAJaWYgKElTX0VSUihyZWdtYXApKSB7DQo+ID4gIAkJcmV0ID0gUFRSX0VSUihyZWdtYXApOw0K
PiA+ICAJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCByZWdtYXA6ICVkXG4iLCByZXQpOw0K
PiA+DQoNCg==
