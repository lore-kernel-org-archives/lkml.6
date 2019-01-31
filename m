Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A594C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FBF20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 01:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nlrNj8W/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfAaBTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 20:19:23 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:17303 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfAaBTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 20:19:22 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c524d160000>; Thu, 31 Jan 2019 09:19:18 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 17:19:18 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 30 Jan 2019 17:19:18 -0800
Received: from DRBGMAIL101.nvidia.com (10.18.16.20) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 01:19:17 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL101.nvidia.com
 (10.18.16.20) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 01:19:16 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.50) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Thu, 31 Jan 2019 01:19:15 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB2983.namprd12.prod.outlook.com (20.178.53.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Thu, 31 Jan 2019 01:19:13 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 01:19:13 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V7 3/5] i2c: tegra: Add DMA Support
Thread-Index: AQHUuLUl2B5DD2NSpkOCYYJBIhpJsKXIgAUAgAANcMA=
Date:   Thu, 31 Jan 2019 01:19:13 +0000
Message-ID: <BYAPR12MB3398B845E97674BE93CCD7D9C2910@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
In-Reply-To: <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2983;6:28xvglewj/CfaiHF8HQvOOa64w4N8Vz3ORXyIu5dIL8DIVf7vYmnKuSm8mihBWGusFkkmve65JLKPHL+mGGX9ynwuiKFvkItXW3YTUS3kt1z1ijBjxcYPavBEYwuFbymlBk+TGKBzzM2noyxj+lGxYz3AuV3Sbg248nn8rSmrCejwJusgAsIcMjA2SzViok+yOZ0NkpO13NNG3kXlQW+fAIsB7DUq3egrAj7MzY0qZPgV6SNrvPaRE0wUdBllki4ITgaln0WCCBomXAmP/ag6lPNc052gTXgNfKRpIhEgolvLdI+AJq2SIF78PCWadrb97XdOQnXqfHwCasuT0MrQS8BzbIoEN572wKxIAPlfBFtkSGpzs0h16wTJKj5sNrNzXQ+ca0HoyId6z+sHln7sAAHlVNBzJEtgXMw9d/5MPL8H36/+O9ZZILiKgXW+YRKN0cqp07qukVg9Vs1kJzImA==;5:dxsa/utKvtdmG7Xil5tHsV+dWMUpYV2SX9NDS5GAEzp5n840+B9ZS1tGSl0oDC21CHv1/rB4P0pYyLFGSS9c/MeZ/zwB78bulrnF/1Ue6r7kBQN13LifQy4navmdDtji+tNGi4z5mgSTFoMOhXpbmTnQZX01IqInRzCpw1FBqewp99Klh32LbPesVT04GQHQM87E3egc20nTIZAYgQTu2A==;7:pmrisdXTeDti0FBBSUajhaWM8Id6d+lnPXwpP6GG45TvrP/j5zzbFOTL7v3/4HFoXGMYBcypxED7OsMWsJW481gtTMdmvmGnRLfp0bH4+hkx7LXztEN5iNW1y5JY6ndZvR1n51l5a7MmOViEFVAtpQ==
x-ms-office365-filtering-correlation-id: 5e9f7921-1bf3-4225-89b8-08d6871a1c76
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2983;
x-ms-traffictypediagnostic: BYAPR12MB2983:
x-microsoft-antispam-prvs: <BYAPR12MB298392369761DAC87EE53334C2910@BYAPR12MB2983.namprd12.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(396003)(136003)(199004)(189003)(66066001)(106356001)(105586002)(6436002)(71190400001)(71200400001)(2906002)(6506007)(25786009)(256004)(39060400002)(7696005)(76176011)(33656002)(4326008)(9686003)(14454004)(99286004)(53936002)(68736007)(6246003)(6116002)(3846002)(476003)(8676002)(55016002)(11346002)(102836004)(478600001)(14444005)(81156014)(81166006)(26005)(486006)(446003)(2501003)(110136005)(8936002)(74316002)(54906003)(316002)(86362001)(305945005)(97736004)(186003)(229853002)(7736002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2983;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DJ6Yuctrv2c3Lfo6QRO9MCDfXaxi3SLGwu+xIRo+6tqJOwGRLZY3boO2pWBaiDveziomRosUsQuWnU5WOiL5+28HA8rbq5Ey+hPogCz4DOcJsUeLqqXW0oWM5M7eQWsuhdsHY3hp/DFZfh255tcc6ahdJdHPb0WF1RD6SbyR2I+13BliNBElmjqDRGJCZdJrEWq3qg2o9vQrFOa+KBWx2DT5d8WlkF9Jy2HQfhiiMvCbV6EWSNXOB0VSh2aZ7VSpMYQEJT5xS7xV3+l95EVeKSyvHovpqzXnK/PLj3frr6/zKELWI3jy7Gpv7HG5b0pd2CS4ywoKVEhrYRXbhswa5xRvyk+Y+Yjz43hUYx7DbHnBkz3Zd37Y7AwJWvDmw4xG5ONkLU32UsvGlfz8QT62DvV0SEzmWWp0JufeqinXWZk=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9f7921-1bf3-4225-89b8-08d6871a1c76
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 01:19:13.4502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2983
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548897559; bh=nw/26cjH2HYcQYpKarRTPit1lT0GALI5KGRvM8NwwG4=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=nlrNj8W/q8Chv0SiCjct7sANf1FmP7GHDqA47mYrwxO1/vQFbF62HbTHXvvzneWY0
         fRJGTOuYPzwG/AfpadavHrkzT+pHl+lfRxTgTyR7qF3Ts7MGuHa0BmKGZeh+fg72Ex
         cYm/p0Nivyu5slBFULrqgDudZ3StkqeDx9X6W43aTI1JnHvRN5DV8va8ksFdmWI5XD
         aSUxPnmoEy5qMFgCh8odUhhChuQwabnsPbeYlZLRO5K8XOyg2vrPmfF//wiucQT5YO
         2d9s6cuLNKrtE9t6vzfTZgyPl8F0E9LtMpo1d3Splun74YRNNz4g9v6EXygx+FaImB
         uqUSRLFn2DuOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsJCQlkbWFfc3luY19zaW5nbGVfZm9yX2RldmljZShpMmNfZGV2LT5kZXYsDQo+ID4gKwkJ
CQkJCSAgIGkyY19kZXYtPmRtYV9waHlzLA0KPiA+ICsJCQkJCQkgICB4ZmVyX3NpemUsDQo+ID4g
KwkJCQkJCSAgIERNQV9GUk9NX0RFVklDRSk7DQo+ID4gKwkJCXJldCA9IHRlZ3JhX2kyY19kbWFf
c3VibWl0KGkyY19kZXYsIHhmZXJfc2l6ZSk7DQo+ID4gKwkJCWlmIChyZXQgPCAwKSB7DQo+ID4g
KwkJCQlkZXZfZXJyKGkyY19kZXYtPmRldiwNCj4gPiArCQkJCQkiU3RhcnRpbmcgUlggRE1BIGZh
aWxlZCwgZXJyICVkXG4iLA0KPiA+ICsJCQkJCXJldCk7DQo+ID4gKwkJCQlnb3RvIGV4aXQ7DQo+
ID4gKwkJCX0NCj4gPiArCQl9IGVsc2Ugew0KPiA+ICsJCQljaGFuID0gaTJjX2Rldi0+dHhfZG1h
X2NoYW47DQo+ID4gKwkJCXRlZ3JhX2kyY19jb25maWdfZmlmb190cmlnKGkyY19kZXYsIHhmZXJf
c2l6ZSwNCj4gPiArCQkJCQkJICAgREFUQV9ETUFfRElSX1RYKTsNCj4gPiArCQkJLyogTWFrZSB0
aGUgZG1hIGJ1ZmZlciB0byByZWFkIGJ5IGNwdSAqLz4gKwkJCWRtYV9zeW5jX3NpbmdsZV9mb3Jf
Y3B1KGkyY19kZXYtPmRldiwNCj4gPiArCQkJCQkJaTJjX2Rldi0+ZG1hX3BoeXMsDQo+ID4gKwkJ
CQkJCXhmZXJfc2l6ZSwNCj4gPiArCQkJCQkJRE1BX1RPX0RFVklDRSk7DQo+DQo+IFRoaXMgaXMg
bm90IGNvcnJlY3QsIHlvdSBuZWVkIHRvIGNhbGwgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUoKSBh
ZnRlciBjb21wbGV0aW9uIG9mIHRoZSB0cmFuc2ZlciB0byBnaXZlIGJhY2sgZG1hIGJ1ZmZlciBv
d25lcnNoaXAgdG8gQ1BVLCBzZWUgYmVsb3cuIFRoaXMgZG1hX3N5bmNfc2luZ2xlX2Zvcl9jcHUo
KSBpbnZvY2F0aW9uIHNob3VsZCBiZSByZW1vdmVkLg0KDQpUcmFuc2ZlciBpcyBub3QgZG9uZSB5
ZXQuIERtYSBidWZmZXIgb3duZXJzaGlwIGlzIGdpdmVuIHRvIENQVSBoZXJlIGJlZm9yZSBjb3B5
aW5nIGhlYWRlciBieXRlcyBhbmQgbXNnIGJ5dGVzIGludG8gZG1hIGJ1ZmZlciBiZWZvcmUgYWN0
dWFsbHkgdHJhbnNtaXR0aW5nDQoNCj4gPiArDQo+ID4gKwkJaWYgKGkyY19kZXYtPm1zZ19yZWFk
KSB7DQo+ID4gKwkJCWlmIChsaWtlbHkoaTJjX2Rldi0+bXNnX2VyciA9PSBJMkNfRVJSX05PTkUp
KSB7DQo+ID4gKwkJCQlkbWFfc3luY19zaW5nbGVfZm9yX2NwdShpMmNfZGV2LT5kZXYsDQo+ID4g
KwkJCQkJCQlpMmNfZGV2LT5kbWFfcGh5cywNCj4gPiArCQkJCQkJCXhmZXJfc2l6ZSwNCj4gPiAr
CQkJCQkJCURNQV9GUk9NX0RFVklDRSk7DQo+ID4gKw0KPiA+ICsJCQkJbWVtY3B5KGkyY19kZXYt
Pm1zZ19idWYsIGkyY19kZXYtPmRtYV9idWYsDQo+ID4gKwkJCQkJbXNnLT5sZW4pOw0KPiA+ICsJ
CQl9DQo+ID4gKwkJfQ0KPg0KPiBIZXJlIHlvdSBzaG91bGQgZ2l2ZSBiYWNrIGRtYSBidWZmZXIg
b3duZXJzaGlwIHRvIENQVToNCg0KQWZ0ZXIgdHJhbnNmZXIgaXMgZG9uZSwgZm9yIG1zZyByZWFk
cywgZG1hIGJ1ZmZlciBvd25lcnNoaXAgaXMgZ2l2ZW4gdG8gQ1BVIGFuZCByZWFkIGRhdGEgZnJv
bSBkbWEgYnVmZmVyIGlzIGNvcGllZCB0byBtc2cgYnVmZmVyDQpGb3IgbXNnIHdyaXRlcywgbm8g
bmVlZCBvZiBvd25lcnNoaXAgdG8gQ1BVLg0KPiA+DQo+ID4JCWVsc2Ugew0KPiA+CQkJZG1hX3N5
bmNfc2luZ2xlX2Zvcl9jcHUoaTJjX2Rldi0+ZGV2LA0KPiA+CQkJCQkJaTJjX2Rldi0+ZG1hX3Bo
eXMsDQo+ID4JCQkJCQl4ZmVyX3NpemUsDQo+ID4JCQkJCQlETUFfVE9fREVWSUNFKTsNCj4gPgkJ
fQ0KPg0KPiA+ICAJdGltZV9sZWZ0ID0gd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCZpMmNf
ZGV2LT5tc2dfY29tcGxldGUsDQo+ID4gIAkJCQkJCVRFR1JBX0kyQ19USU1FT1VUKTsNCj4gPiAg
CXRlZ3JhX2kyY19tYXNrX2lycShpMmNfZGV2LCBpbnRfbWFzayk7DQo+ID4gIA0KPiA+ICAJaWYg
KHRpbWVfbGVmdCA9PSAwKSB7DQo+ID4gIAkJZGV2X2VycihpMmNfZGV2LT5kZXYsICJpMmMgdHJh
bnNmZXIgdGltZWQgb3V0XG4iKTsNCj4gPiArCQlpZiAoZG1hKSB7DQo+ID4gKwkJCWRtYWVuZ2lu
ZV90ZXJtaW5hdGVfYWxsKGNoYW4pOw0KPiA+ICsJCQljb21wbGV0ZSgmaTJjX2Rldi0+ZG1hX2Nv
bXBsZXRlKTsNCj4gPiArCQl9DQo+DQo+IERNQSB0cmFuc2ZlciBoYXMgYmVlbiBjb21wbGV0ZWQg
YXQgdGhpcyBwb2ludCwgaGVuY2UgdGhpcyBodW5rIGlzbid0IG5lZWRlZC4gUGxlYXNlIHJlbW92
ZSBpdC4NCg0KRE1BIGNvbXBsZXRlIGFsb25lIGRvZXNu4oCZdCBndWFyYW50ZWUgdGhlIHRyYW5z
ZmVyLiBQYWNrZXRzL0FsbCBwYWNrZXRzIHhmZXIgaW50ZXJydXB0IGZyb20gSTJDIGNvbmZpcm1z
IGNvbXBsZXRlIHRyYW5zYWN0aW9uIGFsb25nIHdpdGggZG1hIGNvbXBsZXRlIGNoZWNrLg0KU28g
c3RpbGwgbmVlZCB0byBjaGVjayBmb3IgbXNnX2NvbXBsZXRlIHRpbWVvdXQuIA0KDQo+ID4gQEAg
LTc0MCw2ICs5MjUsMzIgQEAgc3RhdGljIGludCB0ZWdyYV9pMmNfeGZlcl9tc2coc3RydWN0IHRl
Z3JhX2kyY19kZXYgKmkyY19kZXYsDQo+ID4gIAl1MzIgaW50X21hc2s7DQo+ID4gIAl1bnNpZ25l
ZCBsb25nIHRpbWVfbGVmdDsNCj4gPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKwlzaXpl
X3QgeGZlcl9zaXplOw0KPiA+ICsJdTMyICpidWZmZXIgPSAwOw0KPiA+ICsJaW50IHJldCA9IDA7
DQo+ID4gKwlib29sIGRtYSA9IGZhbHNlOw0KPiA+ICsNCj4gPiArCWlmIChtc2ctPmZsYWdzICYg
STJDX01fUkQpDQo+ID4gKwkJeGZlcl9zaXplID0gbXNnLT5sZW47DQo+ID4gKwllbHNlDQo+ID4g
KwkJeGZlcl9zaXplID0gbXNnLT5sZW4gKyBJMkNfUEFDS0VUX0hFQURFUl9TSVpFOw0KPiA+ICsN
Cj4gPiArCXhmZXJfc2l6ZSA9IEFMSUdOKHhmZXJfc2l6ZSwgQllURVNfUEVSX0ZJRk9fV09SRCk7
DQo+ID4gKwlkbWEgPSAoeGZlcl9zaXplID4gSTJDX1BJT19NT0RFX01BWF9MRU4pOw0KPiA+ICsJ
aWYgKGRtYSkgew0KPiA+ICsJCWlmICgobXNnLT5mbGFncyAmIEkyQ19NX1JEKSAmJiAhaTJjX2Rl
di0+cnhfZG1hX2NoYW4pDQo+ID4gKwkJCXJldCA9IHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbShp
MmNfZGV2LCB0cnVlKTsNCj4gPiArCQllbHNlIGlmICghaTJjX2Rldi0+dHhfZG1hX2NoYW4pDQo+
ID4gKwkJCXJldCA9IHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbShpMmNfZGV2LCBmYWxzZSk7DQo+
DQo+IEluIHRoZSBjb21tZW50IHRvIFYzIEkgbWVudGlvbmVkIHRoYXQgaXQncyBub3QgYSBnb29k
IGlkZWEgdG8gcmVxdWVzdCBjaGFubmVscyBkeW5hbWljYWxseSBiZWNhdXNlIHN1c3BlbmQtcmVz
dW1lIG9yZGVyIGlzIGJhc2VkIG9uIGRldmljZXMgcmVnaXN0cmF0aW9uIG9yZGVyLCBpbiB0aGlz
IGNhc2UgQVBCIERNQSBtdXN0IGJlIHByb2JlZCBiZWZvcmUgSTJDLiBQbGVhc2UgbW92ZSBjaGFu
bmVscyBhbGxvY2F0aW9uIGludG8gdGhlIHByb2JlLg0KPg0KPiBUaGlzIGFsc28gcmFpc2VzIHRo
ZSBxdWVzdGlvbiBhYm91dCB0aGUgbmVlZCB0byByZWdpc3RlciBJMkMgZHJpdmVyIGZyb20gdGhl
IHN1YnN5cy1pbml0IGxldmVsIGJlY2F1c2UgQVBCIGRyaXZlciBpcyBnZXR0aW5nIHJlZ2lzdGVy
ZWQgZnJvbSB0aGUgbW9kdWxlLWluaXQgbGV2ZWwgYW5kIGhlbmNlIEkyQyBwcm9iaW5nIHdpbGwg
YmUgZGVmZXJyZWQgdW50aWwgQVBCIERNQSBkcml2ZXIgaXMgcmVnaXN0ZXJlZC4gSXQgbG9va3Mg
dG8gbWUgdGhhdCB0aGUgc3Vic3lzLWluaXQgaXMgYSByZWxpY3Qgb2YgdGhlIHBhc3QgYW5kIGl0
IHNob3VsZCBiZSBmaW5lIHRvIG1vdmUgSTJDIGRyaXZlciByZWdpc3RyYXRpb24gaW50byB0aGUg
bW9kdWxlLWluaXQgbGV2ZWwsIG9mIGNvdXJzZSBpdCdzIG5vdCBzdHJpY3RseSBuZWNlc3Nhcnkg
YW5kIGNvdWxkIGJlIGRvbmUgbGF0ZXIgb24gaWYgZGVzaXJlZC4NCj4NCj4gPiArCQlpZiAocmV0
IDwgMCkgew0KPiA+ICsJCQlkZXZfZGJnKGkyY19kZXYtPmRldiwgIlN3aXRjaGluZyB0byBQSU8g
bW9kZVxuIik7DQo+ID4gKwkJCWRtYSA9IGZhbHNlOw0KPiA+ICsJCQlyZXQgPSAwOw0KPiA+ICsJ
CX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpMmNfZGV2LT5pc19jdXJyX2RtYV94ZmVyID0gZG1h
Ow0KPg0KPg0KU2luY2UgeW91ciBwcmV2aW91cyBmZWVkYmFjayBzdWdnZXN0ICJsZXQncyBwb3N0
cG9uZSBjaGFubmVscyByZXF1ZXN0aW5nIGFuZCBkbWFfYnVmIGFsbG9jYXRpb24gdW50aWwgdGhl
eSBhcmUgcmVhbGx5IG5lZWRlZCIsIEkgdGhvdWdodCBpdCBtYWtlIHNlbnNlIHRvIG5vdCByZXF1
ZXN0IGNoYW5uZWxzIGFuZCBhbGxvY2F0ZSB0aWxsIERNQSBpcyBuZWVkZWQuDQpTbyBtb3ZlZCBm
cm9tIHByb2JlIHRvIHhmZXJfbXNnIGZ1bmN0aW9uLiBCeSB0aGUgdGltZSBpdCBnZXRzIHRvIHhm
ZXIgbXNnIGZ1bmN0aW9uLCBkZXZpY2VzIHJlZ2lzdHJhdGlvbiBzaG91bGQgYmUgZG9uZSBhbHJl
YWR5IGFsb25nIHdpdGggYXBiIGRtYSBwcm9iZS4NCg0KDQo=
