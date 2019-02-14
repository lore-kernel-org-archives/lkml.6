Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C9CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D132222DE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="nQSIHEvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502712AbfBNQZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:25:24 -0500
Received: from mail-eopbgr40055.outbound.protection.outlook.com ([40.107.4.55]:60976
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388556AbfBNQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:25:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy6ApDFsMeltG+dQ0FfP/vq+4248FqjFtA1z2eX8kiQ=;
 b=nQSIHEvHB2yyC4yy+Xr3OvNMOEzq4Y5thOGCl03EgaF0SlkyRnRFIPHbfGqUxIglqUl3d/njZUm/8/f+Ubs/TF/OoApRmKiI6D6dRB/bAbwhqYdKv1uRFGniLdsYMEdjblE+d6cz/9nEpbK1JwAQHP43MYf2Ye+DXfWS41WhT/w=
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com (10.175.232.149) by
 DB6PR05MB3287.eurprd05.prod.outlook.com (10.170.222.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Thu, 14 Feb 2019 16:25:18 +0000
Received: from DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320]) by DB6PR05MB3223.eurprd05.prod.outlook.com
 ([fe80::d935:9a6c:c7a3:1320%2]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 16:25:18 +0000
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     David Woods <dwoods@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH v9] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Topic: [PATCH v9] platform/mellanox: Add TmFifo driver for Mellanox
 BlueField Soc
Thread-Index: AQHUw5/qnLd7C7RaL02gLOSwPUA5iqXeB7OAgAFn6AA=
Date:   Thu, 14 Feb 2019 16:25:18 +0000
Message-ID: <DB6PR05MB3223807EED81DC23B5CC7B06A1670@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1550064437-1363-1-git-send-email-lsun@mellanox.com>
 <CAHp75VeasVqg0MJ9_WSGLocd16m1iu32xHd9KYvNu0+kQ9MfVA@mail.gmail.com>
In-Reply-To: <CAHp75VeasVqg0MJ9_WSGLocd16m1iu32xHd9KYvNu0+kQ9MfVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=lsun@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 296d7ed3-3658-47c4-6355-08d69299025a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR05MB3287;
x-ms-traffictypediagnostic: DB6PR05MB3287:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtEQjZQUjA1TUIzMjg3OzIzOkgrNVJMM3UyVFhHTEFlM3BncnlnajlhQ3ZL?=
 =?utf-8?B?WVJiWTlDaml1bUxMSnl0eWxaNW5COXVLcE9zbUZlMThOWG5FV2IvQTZXamZO?=
 =?utf-8?B?NDM4K1NEUG1BU0ZnRjdBUWY4ZUx5N3duanBEWWJsZnk0dCtKcU9hWkJEVUtJ?=
 =?utf-8?B?bWk0a2YyTUxacjQ1Q3FOUXQ4clNpZFIxSjYzT0p2SnNJRG1IT0o5N3kreWdP?=
 =?utf-8?B?M3ByYXZDTTNubTRTdTVaOGw1OVFIb0lxQkVNNXBYa0pSNGVxYlhXcTdmbElo?=
 =?utf-8?B?RWZrQUNodFdaU3dicm54UzlLblhJWnd6U0RLalZnbjhoTldtODVHbTcrL3U4?=
 =?utf-8?B?VFpxRi80UjRxQlpObXMrZ3NUTm5EWFBpc0ZJQ3Fnc0Z3eEpZcGRSRGhSRmV5?=
 =?utf-8?B?bGJUV2ZvaU50dkxiVVVRSU5NREFwQkcwUTRPYmV1RmpKSnJuaU1tNGhacFgw?=
 =?utf-8?B?ZktwYitTalFnOUhrTUdtdWdRZnhQSjIxVzNzb051YWZMUDdvMy9RT2hJa0xv?=
 =?utf-8?B?dlphK1pWV2RUTVpPemg3MncvUDdSc3ovL0RaNlMwek9Kb0N2WHFwUWVocjVa?=
 =?utf-8?B?N0RRbE5mVnd3ZEhtbGRQdlhjZDB3bmlXeUdGaWlhOTFLcE5Rc1VTMmI4RFR1?=
 =?utf-8?B?RmxkRHNzZUtxZmgxU0NyakZrazlzRDRvb2FBTFpObHFJZjFFT3VUNEY3TEs0?=
 =?utf-8?B?aWZzOFZyK1ozNGxqd1ZoMmV2elZ4K0JNdVNSRmVuT3E3TWphRTlIVHVhcWpt?=
 =?utf-8?B?cXAzTlhUQ3EzQ2dlVUlzSGFmNmtvdTcxSHFGRGxjMzdmZ09keXZISUNHRUpY?=
 =?utf-8?B?dzdFOEowUDZoS0JzS3pMVm81SzkrT21MRHlSOGNwVm9ZM2FOYmNlUUwzNzhs?=
 =?utf-8?B?YjdZQ3Rwc244OS9nTGJZcHZDblhQT2V1dVZNeGZHd01mcldhTXBrbmROQmtw?=
 =?utf-8?B?OVdpcG5xNVBTbUFRWldiK3lUNWhBMkFUUGlRQThJeTVLMXR4WFppOUtRbHBZ?=
 =?utf-8?B?ZnV2V1FuZC84cnVIaW5xRVRQek9iWTlEMkNNbDFLMms3TVZFKzR5VkFyRTZ5?=
 =?utf-8?B?Rng2Sm1HbTgvTEZUK3AwM1hPRmhmTUlzUitydGo0TTBZdG5sUXZHeVVXN0Yy?=
 =?utf-8?B?VEdsTTJoem8vK2oxcFlMSFlDaWYxUlhqNmVqMU40UFpRVk5JSFlUMHpuK3Yy?=
 =?utf-8?B?eEdwZHlEbjFoMWVCZENYUTN0SmpOa0FEQ3phYVhTdWZzT3U4QXcwL0ZPbklP?=
 =?utf-8?B?TEFmTlQ1ejlreWtxRFNxWWwyQk9DOWhySUhBZ2FwMjZqak55cWF3clBoclNs?=
 =?utf-8?B?Ym96Q3dtemptUjVnbll0bjRoajNtdXRVdGNxMHZOZksvOSs5UWhhL0Rkazk2?=
 =?utf-8?B?cWJySEFMRjMreDhXZFM2Wm5STkViR3FRZEFqR1NoNmp4L3dPVjJ2Z2cvL2Ji?=
 =?utf-8?B?ZDV5WjY2SExQbi9XQ1R0VWJaeGJRV2ZuVDN4WG1tckp5Zll5SE42NXhQbmth?=
 =?utf-8?B?ZjFCME5IS1JIdjJSQVVsN0tzcDVMdHoyZkVNWVRXdlJ3bzJXRmVDWTB1Z0Jp?=
 =?utf-8?B?L1BmVmREUG9WbXlTNnVJRkp6QVJjVWw1Sjdhb05odEtWQTc5bXYrNkJmVThm?=
 =?utf-8?B?cSt6WmhHb2JvSjZycWNCcUpkTWN1L2Q4MEVRK1RaVHg4U0ljdTZMU1ZBPT0=?=
x-microsoft-antispam-prvs: <DB6PR05MB32873C63ED31343E8059A0E1A1670@DB6PR05MB3287.eurprd05.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(39860400002)(136003)(366004)(376002)(346002)(396003)(189003)(199004)(13464003)(102836004)(68736007)(99286004)(2906002)(106356001)(55016002)(6506007)(105586002)(6436002)(53546011)(76176011)(25786009)(256004)(7696005)(9686003)(229853002)(71190400001)(54906003)(186003)(476003)(71200400001)(97736004)(446003)(11346002)(316002)(486006)(26005)(86362001)(33656002)(14454004)(7736002)(305945005)(74316002)(6916009)(8936002)(3846002)(53936002)(4326008)(6246003)(8676002)(66066001)(6116002)(478600001)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR05MB3287;H:DB6PR05MB3223.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sz+kl+okTxhcsKnHlkRjGFhzJ1Sz+fu0390x9PEA7A0Ab8lWhP8oOMbn/Z5ooo85d/TDsAE/eNzOZAmnMH10e5hh/9PD2w2wmmT0WKFT5qX8toN0ieR4m5fevHO7Dpn87ihYEEFrWyI3Xl/taLegcJUE0KuyvdvfUIEE1hBuQEE8YgPlxdqz6CpAR5+WEEfEQL27lpRUY3dJaq7nWsF68DGi7MF7jXiNyoU8Cp/CoIy9r9SeKf+R+icdW8Os4jPXty0dsy2iy8mA3s8Hx+rCdfo2wjVOvNZPfPyR7jPOhGEMK1gCM2qJO+FsIoMBRQUt7goId1jfbD4iUzGxmI5sclkmVw4wDEpVbWUOzuq6jvxGrGtEwOM5hHIruTJJ20Q4BCTvZpQT1fuiwtn7oxcvclIIU10PtrRYMPBx0kgBb1E=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296d7ed3-3658-47c4-6355-08d69299025a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 16:25:18.4412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR05MB3287
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIEFuZHkuIFBsZWFzZSBzZWUgbXkgcmVzcG9uc2UgYW5kIHF1ZXN0aW9ucyBvbiBzb21l
IG9mIHRoZSBjb21tZW50cyBiZWxvdy4NCg0KUmVnYXJkcywNCkxpbWluZw0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxMywgMjAxOSAxOjEx
IFBNDQo+IFRvOiBMaW1pbmcgU3VuIDxsc3VuQG1lbGxhbm94LmNvbT4NCj4gQ2M6IERhdmlkIFdv
b2RzIDxkd29vZHNAbWVsbGFub3guY29tPjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5QGluZnJhZGVh
ZC5vcmc+OyBEYXJyZW4gSGFydCA8ZHZoYXJ0QGluZnJhZGVhZC5vcmc+OyBWYWRpbQ0KPiBQYXN0
ZXJuYWsgPHZhZGltcEBtZWxsYW5veC5jb20+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgUGxhdGZvcm0gRHJpdmVyIDxwbGF0Zm9ybS1k
cml2ZXItDQo+IHg4NkB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjld
IHBsYXRmb3JtL21lbGxhbm94OiBBZGQgVG1GaWZvIGRyaXZlciBmb3IgTWVsbGFub3ggQmx1ZUZp
ZWxkIFNvYw0KPiANCj4gT24gV2VkLCBGZWIgMTMsIDIwMTkgYXQgMzoyNyBQTSBMaW1pbmcgU3Vu
IDxsc3VuQG1lbGxhbm94LmNvbT4gd3JvdGU6DQo+ID4NCj4gLi4uDQo+IA0KPiA+ICsvKiBVc2Ug
YSB1bmlvbiBzdHJ1Y3Rpb24gZm9yIDY0LWJpdCBsaXR0bGUvYmlnIGVuZGlhbi4gKi8NCj4gDQo+
IFdoYXQgZG9lcyB0aGlzIG1lYW4/DQo+IA0KPiA+ICt1bmlvbiBtbHhiZl90bWZpZm9fZGF0YV82
NGJpdCB7DQo+ID4gKyAgICAgICB1NjQgZGF0YTsNCj4gPiArICAgICAgIF9fbGU2NCBkYXRhX2xl
Ow0KPiA+ICt9Ow0KDQpUaGUgcHVycG9zZSBpcyB0byBzZW5kIDggYnl0ZXMgaW50byB0aGUgRklG
TyB3aXRob3V0IGRhdGEgY2FzdGluZyBpbiB3cml0ZXEoKS4NCg0KQmVsb3cgaXMgdGhlIGV4YW1w
bGUgd2l0aCB0aGUgY2FzdC4NCg0KdTY0IGRhdGEgPSAweDEyMzQ7DQpfX2xlNjQgZGF0YV9sZTsN
CmRhdGFfbGUgPSBjcHVfdG9fbGU2NChkYXRhKQ0Kd3JpdGVxKCoodTY0ICopJmRhdGFfbGUsIGZp
Zm8tPnR4X2Jhc2UgKyBNTFhCRl9UTUZJRk9fVFhfREFUQSk7DQoNCkJlbG93IGlzIHRoZSBhbHRl
cm5hdGl2ZSB0cnlpbmcgdG8gdXNlIHVuaW9uIHRvIGF2b2lkIHRoZSBjYXN0Lg0KDQptbHhiZl90
bWZpZm9fZGF0YV82NGJpdCB1Ow0KdS5kYXRhID0gMHgxMjM0Ow0KdS4gZGF0YV9sZSA9IGNwdV90
b19sZTY0KHUuZGF0YSk7DQp3cml0ZXEodS5kYXRhX2xlLCBmaWZvLT50eF9iYXNlICsgTUxYQkZf
VE1GSUZPX1RYX0RBVEEpOw0KDQpXaGljaCB3YXkgbWlnaHQgYmUgYmV0dGVyIG9yIGFueSBvdGhl
ciBzdWdnZXN0aW9ucz8NCg0KPiA+ICsNCj4gPiArLyogTWVzc2FnZSBoZWFkZXIgdXNlZCB0byBk
ZW11eCBkYXRhIGluIHRoZSBUbUZpZm8uICovDQo+ID4gK3VuaW9uIG1seGJmX3RtZmlmb19tc2df
aGRyIHsNCj4gPiArICAgICAgIHN0cnVjdCB7DQo+ID4gKyAgICAgICAgICAgICAgIHU4IHR5cGU7
ICAgICAgICAgICAgICAgIC8qIG1lc3NhZ2UgdHlwZSAqLw0KPiA+ICsgICAgICAgICAgICAgICBf
X2JlMTYgbGVuOyAgICAgICAgICAgICAvKiBwYXlsb2FkIGxlbmd0aCAqLw0KPiA+ICsgICAgICAg
ICAgICAgICB1OCB1bnVzZWRbNV07ICAgICAgICAgICAvKiByZXNlcnZlZCwgc2V0IHRvIDAgKi8N
Cj4gPiArICAgICAgIH0gX19wYWNrZWQ7DQo+IA0KPiBJdCdzIGFscmVhZHkgcGFja2VkLiBObz8N
Cg0KVGhlICdfX3BhY2tlZCcgaXMgbmVlZGVkIGhlcmUuIFdpdGhvdXQgaXQgdGhlIGNvbXBpbGVy
IHdpbGwgbWFrZSB0aGUNCnN0cnVjdHVyZSBzaXplIGV4Y2VlZGluZyA4IGJ5dGVzIHdoaWNoIGlz
IG5vdCBkZXNpcmVkLg0KDQo+Li4uDQo+ID4gKyAgICAgICBpZiAodmRldl9pZCA9PSBWSVJUSU9f
SURfQ09OU09MRSkNCj4gDQo+ID4gKyAgICAgICAgICAgICAgIHRtX3ZkZXYtPnR4X2J1ZiA9IGRl
dm1fa21hbGxvYyhkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBNTFhCRl9UTUZJRk9fQ09OU19UWF9CVUZfU0laRSwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9LRVJORUwpOw0KPiANCj4g
QXJlIHlvdSBzdXJlIGRldm1fIHN1aXRzIGhlcmU/DQoNClRoZSAndHhfYnVmJyBhcmUgbm9ybWFs
IGJ1ZmZlciB0byBob2xkIHRoZSBjb25zb2xlIG91dHB1dC4gDQpJdCBzZWVtcyBvayB0byB1c2Ug
ZGV2bV9rbWFsbG9jIHNvIGl0IGNvdWxkIGF1dG9tYXRpY2FsbHkgZnJlZWQNCm9uIGRyaXZlciBk
ZXRhY2guIFBsZWFzZSBjb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQoNCj4+Li4uDQo+ID4gKw0K
PiA+ICsgICAgICAgZmlmby0+dHhfYmFzZSA9IGRldm1faW9yZW1hcCgmcGRldi0+ZGV2LCB0eF9y
ZXMtPnN0YXJ0LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXNv
dXJjZV9zaXplKHR4X3JlcykpOw0KPiA+ICsgICAgICAgaWYgKCFmaWZvLT50eF9iYXNlKQ0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+IFN3aXRjaCB0byBkZXZtX2lv
cmVtYXBfcmVzb3VyY2UoKS4NCj4gSG93ZXZlciwgSSB0aGluayB5b3UgcHJvYmFibHkgbmVlZCBt
ZW1yZW1hcCgpLg0KDQpUaGlzIGlzIGRldmljZSByZWdpc3RlcnMgYWNjZXNzZWQgYnkgYXJtNjQg
Y29yZS4NCkluIGFybTY0L2luY2x1ZGUvYXNtL2lvLmgsIHNldmVyYWwgYXBpcyBhcmUgZGVmaW5l
ZCB0aGUgc2FtZS4NCg0KI2RlZmluZSBpb3JlbWFwKGFkZHIsIHNpemUpCQlfX2lvcmVtYXAoKGFk
ZHIpLCAoc2l6ZSksIF9fcGdwcm90KFBST1RfREVWSUNFX25HblJFKSkNCiNkZWZpbmUgaW9yZW1h
cF9ub2NhY2hlKGFkZHIsIHNpemUpCV9faW9yZW1hcCgoYWRkciksIChzaXplKSwgX19wZ3Byb3Qo
UFJPVF9ERVZJQ0VfbkduUkUpKQ0KI2RlZmluZSBpb3JlbWFwX3d0KGFkZHIsIHNpemUpCQlfX2lv
cmVtYXAoKGFkZHIpLCAoc2l6ZSksIF9fcGdwcm90KFBST1RfREVWSUNFX25HblJFKSkNCg0KSG93
IGFib3V0IHVzaW5nIGRldm1faW9yZW1hcF9ub2NhY2hlKCk/DQpJdCBjb3VsZCB0YWtlIGFkdmFu
dGFnZSBvZiB0aGUgZGV2bV94eCgpIGFwaS4NCg0KPi4uLg0KPiBJcyBpdCBjb3JyZWN0Pw0KPiAN
Cj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K
