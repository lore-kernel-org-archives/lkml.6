Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A983C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B51207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="rRn7gIlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfBUNm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:42:28 -0500
Received: from mail-eopbgr140139.outbound.protection.outlook.com ([40.107.14.139]:61956
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfBUNm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rWd3j5k899gNJ7e0RV/VYj1cRcLIatF5eL9YwlAO0g=;
 b=rRn7gIlI15oa0H1xQORlnb71ewZkJ8JXeN+sTZhfuA34io597SH/RvHZTKw9xa8rsjwCb1etfMtcRE8j1rD+sVHy26H+h9e+k9jl7+Xnb2Kcovm28Ica4TUDXgMvthvopQ1827wGs/nNd/MlXDQnkv7QSyEmXzi0TXqO4EH1ZaU=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3231.eurprd02.prod.outlook.com (10.170.237.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Thu, 21 Feb 2019 13:42:22 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::a1f1:5dc8:99c1:c590%5]) with mapi id 15.20.1622.020; Thu, 21 Feb 2019
 13:42:22 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUyeOzPrJOZ7UkNky2yNQN5dmaTqXqQsEA
Date:   Thu, 21 Feb 2019 13:42:22 +0000
Message-ID: <70f7fa07-9643-a302-2162-362afbe123d6@axentia.se>
References: <20190221181230.4892-1-pankaj.bansal@nxp.com>
In-Reply-To: <20190221181230.4892-1-pankaj.bansal@nxp.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0192.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::16) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb25e5ab-80e9-42a3-3d16-08d6980267fb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600110)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3231;
x-ms-traffictypediagnostic: VI1PR02MB3231:
x-microsoft-antispam-prvs: <VI1PR02MB3231399EC88242854B13A185BC7E0@VI1PR02MB3231.eurprd02.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39830400003)(366004)(396003)(376002)(189003)(199004)(81156014)(476003)(53936002)(74482002)(6506007)(97736004)(65956001)(106356001)(386003)(6436002)(66066001)(53546011)(65806001)(26005)(71190400001)(14454004)(71200400001)(8676002)(76176011)(52116002)(105586002)(2616005)(31686004)(508600001)(65826007)(102836004)(486006)(81166006)(5660300002)(25786009)(8936002)(11346002)(36756003)(6512007)(446003)(14444005)(86362001)(3846002)(64126003)(58126008)(186003)(316002)(256004)(6486002)(4326008)(229853002)(305945005)(2906002)(6246003)(68736007)(6116002)(110136005)(7736002)(31696002)(99286004)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3231;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjAyTUIzMjMxOzIzOnM2cjNmVFJFTE1XczljeGVyRDludGZQaURK?=
 =?utf-8?B?bm5VL2dxRE91akNseUEycXQ2ckkyMzZwb1ViR0lsVTZrSHhYbFNWL202eG9C?=
 =?utf-8?B?WExVRTF0REw1ZitMZkIyU3Q2ajFiM240RVVXTlIxK1ZYOVNvS0V3OHRGa29T?=
 =?utf-8?B?eXNDZDA5aDlvV3JhejNKODk1bjF1dkdxWGNSaXRYRHg0TTdoRG1FRXRQekxl?=
 =?utf-8?B?RW5Gb2RTbGw4QXZuS2lsdVA2cUthK0V3WUZWZ0VaYWNaK1k4cG13TTg3VTEz?=
 =?utf-8?B?ZzlnUU5yL3ZhSG1pZHdoYXYzTHYyeUJWR2VOODRiZEljU2o1R3Nxa0ZkYkdy?=
 =?utf-8?B?UnZUWXBUZFQ2K25mODhSeU81OE9HcVBLTW1NMWx1R2ZNTEVDNHZaWWRrVHFs?=
 =?utf-8?B?RTVKR0ZldEthWStyNDdFNDdkVHkycjNuYVplZVFRUnE5V2JXS3ozSW1GVHJX?=
 =?utf-8?B?Y2laa05GU3d0UkF5MDgrWXlaVDlYdzdQY29RODFxNUFDa2JUUVQ0MjF2a1FC?=
 =?utf-8?B?cjU1d2IzVGxVUGZiNVRrbHVsM2FTWjRxSkFBOWlpeXNuSXZ2bXZsWmNUWU9C?=
 =?utf-8?B?VnRvSDVaRWlBSGs4cE1CRmtOMjdpOEZRTXRNc0g3R1pBWlJYQVpweENSazFk?=
 =?utf-8?B?TVpEUFpaRWZHTjZvNWNsOUI1a0ZQSTlzTS9FWkxlODIyeVJEVExYb0V5blJp?=
 =?utf-8?B?S3lXUGZxaTVTSjdvaXlQdFFKZ2FTY241RnIzMk4yWW5tUG52OVZ5VzZTblE4?=
 =?utf-8?B?NFVoTjBNWThJY2xGaCs5L2Qxa1dWY0p5SkRhS0xjY2YrTlhKczE2b3dYOEow?=
 =?utf-8?B?V0dpNkZMU25ndmd5QnZFUHlOL0VMSU1vTzJRaFl2dG9nU0pxZGN6V3lob0Rm?=
 =?utf-8?B?cU9ZTE51b1FNMGRUR3BicWlObXE2M1RLK3YyaTc2T2tEdXBvVjUwQWhVdjds?=
 =?utf-8?B?U2VvOFYrcWRRblE4Vmh3SVRPMy9UOGxTZnpSamRpb0plUCt5a3ZMNU50azFW?=
 =?utf-8?B?aklXb2cwZnFqU1QvY0d3bUdZU1hBWkhnQm42LzdlNFNUUWtPL2I1cGYvOXNP?=
 =?utf-8?B?bnV4bEU2TDV2UERmQVUrN1J5RlNhaHloR2t3UGdRWGQzQWc3ZGVuWGVheFRs?=
 =?utf-8?B?QjNkYVhlTVhWKzN2YXhTbi9JckxtS1M2ZlpUWWpIaVU5cERMaWJXdDE4ZmhC?=
 =?utf-8?B?WUx3MC9iaEJHNnVCYURqNzNNTVpadlFMZUdRWTFBTThmZ0dFTVNTUzBmUWl6?=
 =?utf-8?B?UXFtRitKYktGSk5BRWc3YXErVE1TbnVCY1hTQklxK2x4TlM4T3Y1bFpWeEhV?=
 =?utf-8?B?VEM5Um1rZWtkelM3NWFhT3o2clE3YUFBQitpQ1FhQXk4YWpwcnljNEdPSWlF?=
 =?utf-8?B?bnBILzFxK2pNaVozNEUzKzZkKzJ6VGZpRS9rRzVhek5yV0dpTk54U3pPUXNs?=
 =?utf-8?B?Zk5vTkVpQU9yZzVOc2ZEd3ZUS2R5Z0UyTi93ZnRDcEdHbTJwSEZlQlpQYm9I?=
 =?utf-8?B?VHZKZytlanR3MWZPYmhheVBCQ0ZFYWlkVGxQSDlXRGJreEVCbW9Ga04vZXlT?=
 =?utf-8?B?VVphU1dHRWhiaXV4WWhxYVJoNU5ISmhNcWN4TVV5RjhYakUvSlVaZHRBai9m?=
 =?utf-8?B?UlhtdmxvdE9IMW5hM2FsQzUrejZpa0dEVmc5WVJoamZ4V2hDdWppN0xNVnhM?=
 =?utf-8?B?MExkWHdnOFFlT2p6NXJWUjQza0hDczQyamJJMDY1WnpuUThCY0VuYVFiVzVP?=
 =?utf-8?B?RkVITnZuTG9Ha0RmYUQzdEdyRFAwMHA1NEZqN0xPS1J0Ym93Ymg0S09BbXdm?=
 =?utf-8?B?WXRvWVJ5Y1U3N1B2eTRsVU5rc1JBSUQya050MnFtTFpYNlFSemFpZmlZcVZE?=
 =?utf-8?B?RUd2UE5ISU9Uc2lOZmFFU3hMbW5IYklsVzMvdEZyeVJVSGZjaHJtY1ZmcHg4?=
 =?utf-8?B?aHV3M09TKzR3PT0=?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: F5mfn9lC9TjGzwMaU2Jl6RFzc/nlzsvIFeljxUhyksp+oELSZVb5oWz06SvvpEsax6fM6vv7weFyybnceB8XRuhcmiU23OiYlCo75KO5YzmMiPAIcLngmTi7elyoYQVZgz3aG2V8ayRm+lXMKW/m10HmS9/ydLSbCNN0QsvsPUPOGAKPNzJAYBMsXY9Tv2cqJSuJflR1xhkkwfBd8gzAHIYRrZGgjKictNBZ5Bwfk7e4wAU2/aonUVvGx0H07ATeyfOAK/VGYtsbuwO4govbCiS6La+DSsuyFsTZN8j9UPZxoelqssN4VUQ1AcnS7LFUU/r7wGhuRaLcYRcfXcykUev179QYdiBB5zo+ACkTeu+OVLR1hWqyJGl6ghTm5puPmf66bAp0WXXbtHdDfGeV72qL4QWsWoXsA/taTxJntys=
Content-Type: text/plain; charset="utf-8"
Content-ID: <464996175F45A649B08C310BDB764B68@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: eb25e5ab-80e9-42a3-3d16-08d6980267fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 13:42:21.7326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNCk11Y2ggYmV0dGVyLCB0aGFua3MhIE9uZSBuaXQgYmVsb3c6DQoNCk9uIDIwMTktMDIt
MjEgMTM6NDgsIFBhbmthaiBCYW5zYWwgd3JvdGU6DQo+IEdlbmVyaWMgcmVnaXN0ZXIgYml0Zmll
bGQtYmFzZWQgbXVsdGlwbGV4ZXIgdGhhdCBjb250cm9scyB0aGUgbXVsdGlwbGV4ZXINCj4gcHJv
ZHVjZXIgZGVmaW5lZCB1bmRlciBhIHBhcmVudCBub2RlLg0KPiBUaGUgZHJpdmVyIGNvcnJlc3Bv
bmRpbmcgdG8gcGFyZW50IG5vZGUgcHJvdmlkZXMgcmVnaXN0ZXIgcmVhZC93cml0ZQ0KPiBjYXBh
YmlsaXRpZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQYW5rYWogQmFuc2FsIDxwYW5rYWouYmFu
c2FsQG54cC5jb20+DQo+IC0tLQ0KPiANCj4gTm90ZXM6DQo+ICAgICBWMjoNCj4gICAgIC0gcmVt
b3ZlZCBzZXBlcmF0ZSBkcml2ZXIgcmVnbWFwLmMgYW5kIGFkZGVkIHRoZSByZWdtYXAgZnVuY3Rp
b24gaW4gbW1pby5jDQo+ICAgICAgIGJhc2VkIG9uIGNvbXBhdGlibGUgZmllbGQsIHRoZSBzeXNj
b24gb3IgcmVnbWFwIGZ1bmN0aW9uIHdvdWxkIGJlIGNhbGxlZA0KPiAgICAgLSBNb2RpZmllZCB0
aGUgS0NvbmZpZyBhcyBwZXIgUGV0ZXIncyBjb21tZW50cw0KPiANCj4gIGRyaXZlcnMvbXV4L0tj
b25maWcgfCAxMiArKysrKystLS0tLS0NCj4gIGRyaXZlcnMvbXV4L21taW8uYyAgfCAgNiArKysr
Ky0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL211eC9LY29uZmlnIGIvZHJpdmVycy9tdXgvS2Nv
bmZpZw0KPiBpbmRleCA3NjU5ZDZjNWY3MTguLmU1YzU3MWZkMjMyYyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tdXgvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL211eC9LY29uZmlnDQo+IEBAIC00
NiwxNCArNDYsMTQgQEAgY29uZmlnIE1VWF9HUElPDQo+ICAJICBiZSBjYWxsZWQgbXV4LWdwaW8u
DQo+ICANCj4gIGNvbmZpZyBNVVhfTU1JTw0KPiAtCXRyaXN0YXRlICJNTUlPIHJlZ2lzdGVyIGJp
dGZpZWxkLWNvbnRyb2xsZWQgTXVsdGlwbGV4ZXIiDQo+IC0JZGVwZW5kcyBvbiAoT0YgJiYgTUZE
X1NZU0NPTikgfHwgQ09NUElMRV9URVNUDQo+ICsJdHJpc3RhdGUgIk1NSU8vUmVnbWFwIHJlZ2lz
dGVyIGJpdGZpZWxkLWNvbnRyb2xsZWQgTXVsdGlwbGV4ZXIiDQo+ICsJZGVwZW5kcyBvbiBPRiB8
fCBDT01QSUxFX1RFU1QNCj4gIAloZWxwDQo+IC0JICBNTUlPIHJlZ2lzdGVyIGJpdGZpZWxkLWNv
bnRyb2xsZWQgTXVsdGlwbGV4ZXIgY29udHJvbGxlci4NCj4gKwkgIE1NSU8vUmVnbWFwIHJlZ2lz
dGVyIGJpdGZpZWxkLWNvbnRyb2xsZWQgTXVsdGlwbGV4ZXIgY29udHJvbGxlci4NCj4gIA0KPiAt
CSAgVGhlIGRyaXZlciBidWlsZHMgbXVsdGlwbGV4ZXIgY29udHJvbGxlcnMgZm9yIGJpdGZpZWxk
cyBpbiBhIHN5c2Nvbg0KPiAtCSAgcmVnaXN0ZXIuIEZvciBOIGJpdCB3aWRlIGJpdGZpZWxkcywg
dGhlcmUgd2lsbCBiZSAyXk4gcG9zc2libGUNCj4gLQkgIG11bHRpcGxleGVyIHN0YXRlcy4NCj4g
KwkgIFRoZSBkcml2ZXIgYnVpbGRzIG11bHRpcGxleGVyIGNvbnRyb2xsZXJzIGZvciBiaXRmaWVs
ZHMgaW4gZWl0aGVyDQo+ICsJICBhIHN5c2NvbiByZWdpc3RlciBvciBhIGRyaXZlciByZWdtYXAg
cmVnaXN0ZXIuIEZvciBOIGJpdCB3aWRlDQo+ICsJICBiaXRmaWVsZHMsIHRoZXJlIHdpbGwgYmUg
Ml5OIHBvc3NpYmxlIG11bHRpcGxleGVyIHN0YXRlcy4NCj4gIA0KPiAgCSAgVG8gY29tcGlsZSB0
aGUgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUgbW9kdWxlIHdpbGwNCj4g
IAkgIGJlIGNhbGxlZCBtdXgtbW1pby4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXV4L21taW8u
YyBiL2RyaXZlcnMvbXV4L21taW8uYw0KPiBpbmRleCA5MzVhYzQ0YWEyMDkuLjM3ZmJjZGU3ZjFm
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdXgvbW1pby5jDQo+ICsrKyBiL2RyaXZlcnMvbXV4
L21taW8uYw0KPiBAQCAtMjgsNiArMjgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG11eF9jb250
cm9sX29wcyBtdXhfbW1pb19vcHMgPSB7DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIG11eF9tbWlvX2R0X2lkc1tdID0gew0KPiAgCXsgLmNvbXBhdGlibGUgPSAibW1p
by1tdXgiLCB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAicmVnLW11eCIsIH0sDQo+ICAJeyAvKiBz
ZW50aW5lbCAqLyB9DQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXV4X21taW9f
ZHRfaWRzKTsNCj4gQEAgLTQzLDcgKzQ0LDEwIEBAIHN0YXRpYyBpbnQgbXV4X21taW9fcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAlpbnQgcmV0Ow0KPiAgCWludCBpOw0K
PiAgDQo+IC0JcmVnbWFwID0gc3lzY29uX25vZGVfdG9fcmVnbWFwKG5wLT5wYXJlbnQpOw0KPiAr
CWlmIChvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgIm1taW8tbXV4IikpDQo+ICsJCXJlZ21h
cCA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChucC0+cGFyZW50KTsNCj4gKwllbHNlDQo+ICsJCXJl
Z21hcCA9IGRldl9nZXRfcmVnbWFwKGRldi0+cGFyZW50LCBOVUxMKTsNCg0KZGV2X2dldF9yZWdt
YXAoKSByZXR1cm5zIE5VTEwgb24gZmFpbHVyZSwgc28gSSB0aGluayB5b3UgbmVlZCBzb21ldGhp
bmcgbGlrZToNCg0KCQlyZWdtYXAgPSBkZXZfZ2V0X3JlZ21hcChkZXYtPnBhcmVudCwgTlVMTCkg
PzogRVJSX1BUUigtRUlOVkFMKTsNCg0KT3IgcGVyaGFwcyAtRU5PREVWLCAtRU5PVFNVUFAgb3Ig
c29tZXRoaW5nLCBub3Qgc3VyZT8NCg0KQ2hlZXJzLA0KUGV0ZXINCg0KPiAgCWlmIChJU19FUlIo
cmVnbWFwKSkgew0KPiAgCQlyZXQgPSBQVFJfRVJSKHJlZ21hcCk7DQo+ICAJCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGdldCByZWdtYXA6ICVkXG4iLCByZXQpOw0KPiANCg0K
