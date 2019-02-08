Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38424C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE42120855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rwv28wTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfBHPZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:25:57 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:13385 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbfBHPZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:25:56 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5d9f810000>; Fri, 08 Feb 2019 23:25:53 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 07:25:51 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 08 Feb 2019 07:25:51 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 15:25:49 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.55) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 8 Feb 2019 15:25:49 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3112.namprd12.prod.outlook.com (20.178.54.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Fri, 8 Feb 2019 15:25:46 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 15:25:46 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>, Peter Rosin <peda@axentia.se>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
Thread-Topic: [PATCH V15 3/6] i2c: tegra: fix maximum transfer size
Thread-Index: AQHUvy64Xk5T7Qvb/k6E8BAehLiagqXU5U+AgAAEVQCAAPC2AIAAF/GAgAAFcQCAAA29UA==
Date:   Fri, 8 Feb 2019 15:25:45 +0000
Message-ID: <BYAPR12MB339837F9232FBB0767869564C2690@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549576040-15907-1-git-send-email-skomatineni@nvidia.com>
 <1549576040-15907-3-git-send-email-skomatineni@nvidia.com>
 <1202cc91-cacf-673e-c32b-b4d1c78b71f2@gmail.com>
 <515cb722-c345-8dd6-dbe5-557dec0d1384@gmail.com>
 <a57f0374-8468-f24a-1743-b446b8260a46@gmail.com>
 <9e8f26bb-2159-6ca4-783e-91a73dac0823@axentia.se>
 <96a3955f-ef4f-e4df-4907-6ec760fad3fe@gmail.com>
In-Reply-To: <96a3955f-ef4f-e4df-4907-6ec760fad3fe@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3112;6:Fx+XecBRJdmYzYxdrl3IPyWM8AxfOQPek/1y+4GOVICiw/R9vIA169HtPHvrDj1LeLXCV+xvSVDIFHFFIiZbLUaDOKDaDLQI4E5UDXL+FOxw7dqosDKPyuZi0jbuaHJCQLWvf2Zp5jV7Gk2caCJxCplnY8smI0X6/9BwLrr7b941XVtU97ZpRBRJf+JYI4fvRFFRqg8TNr6jtFR8XVt7xrvyvsBbTsH6y83XkC2a8d00nU9rKh2tL1Vf+iQYDGxlYVCZreH2LtZOlIxNJd/+bkPsadgs1R+oPD6rCr1qGWeKA+8AbmVBT6jwBW0933QiJqm3Xu/CmiKvRUYfxdJv92XdbPekDHPLqyiS5sGgOWNPTMXiPVI4I5To4QFlkxT3abYDqXY3SFkFvWZtf/8WbUMhi6z0Q61jRxp7MdADJBasPuxBgMw9bsR6cksKgFSgBf1mm/efuDHM+7H1lZOcHw==;5:v/7iahhSgmjtwotfCJL8rU4EYGMUIDMsReDlffvczJqyj1hHGl52inKYgCTLENK05fMBS/udCfo6MWh0lVjnJSN2VQ5c9758v85SZjP08dxSXmh6iRXr3Ao8r8iJm8XuVc8CsNz7v069iZSr+1UxNddo0kSGUchTGPQqB2N2majmvmIKjdL7OBOVaKdHIEVeKrXqxi+dbLue5/J2XlvEfw==;7:h+zy8ezfBVWFV7Wh9gpu5lWTUcosSWpao4RjlcJbbyTcMzj9AEvIdcjF9WMDDzYp8TY6ekMfQ1V8/ADl1jE/tgKgMKX7xpo6A7Tmm11MfgBURNDSgzQGdxJ9ItUS9V6mJEwlbxQQUZo110H8JwV07Q==
x-ms-office365-filtering-correlation-id: 0807278d-0cb3-442a-208a-08d68dd9b27b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3112;
x-ms-traffictypediagnostic: BYAPR12MB3112:
x-microsoft-antispam-prvs: <BYAPR12MB3112FEA9DD91F3C38462D50CC2690@BYAPR12MB3112.namprd12.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(366004)(346002)(189003)(199004)(11346002)(33656002)(7736002)(106356001)(2501003)(105586002)(6506007)(8676002)(478600001)(6246003)(6636002)(305945005)(53546011)(316002)(81156014)(446003)(93886005)(486006)(76176011)(4326008)(6436002)(81166006)(71200400001)(25786009)(110136005)(54906003)(99286004)(476003)(71190400001)(229853002)(53936002)(86362001)(2906002)(68736007)(7696005)(66066001)(8936002)(186003)(26005)(102836004)(256004)(6116002)(74316002)(14454004)(9686003)(55016002)(3846002)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3112;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aDDu+udCIINpKITGeFT/uWBBbjiydcPQM5kGaDJ38k0kyy59pjNO+oI6Fr5c0VVsitN6MIdnKF0DFhCddvcWr+0Bqvpc69LhNJiwmmwrE8Z4F6ytzXLRldqnkik/CvvQOMc/z6dO0bI69QVPJjPtriwnhRyYujTVpQzby9Zie/CIri7LI6mIX7EIm4R4B0dBNPwAGqtqsxPJ0rgpkALWytsXaqo1BXJQ2TdNm/Q5AtmV3KFtQJXlmzFLyIVO9E5cKDCX21aHHdiwW1Ftr4YZMrLwkuyCubMSYzIuHkM3XrMkRvA4waCnW+ReB/5yIptlNropfXdKchxKKjSHBHBv3YQ8lRkGoIwfOvFewANKhQv/GOnII5bxgDtY8ILq1Sbuk3BVh10tqjJSSMosJehmbvN/8P4agyawEq0Q+hieJxM=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0807278d-0cb3-442a-208a-08d68dd9b27b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:25:45.8935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3112
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549639554; bh=SaxgIdPACTmjuGS9oopw9YnY9/dnkPvNWuVJlhW41Kg=;
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
        b=rwv28wTWVumbig9uet26FfWIQ4c+D1GkfkSthMBe/Oc7stqIbdpKy9/RkKX13f1pI
         YoBThjqvkpv9eyrjDa4VCJmFHHA94ThAaT4zngT4Dpc0LpLHdzS60Anp2Lziyf5Bc2
         p4r/scOmfOvW8pr81F40IhLk42VfU8D6xAUEDLS9/BDiBndtIymWSngUFcBD1HuozC
         37uFtpfX8SYFHeNrnNfgWin9JDGhIbgJeK+Bn/GnhkkwJZFqWOY3jpo/tqU6/5YsKv
         Ze3v2KZJK2Y113+bNSdaT/hpMrkFdEFJRyRIqcQybzu1Tk3ojV4u2qU1/DTBsaRWoS
         qlNfrLv+xOVNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAwOC4wMi4yMDE5IDE3OjEyLCBQZXRlciBSb3NpbiDQv9C40YjQtdGCOg0KPiA+IE9uIDIwMTkt
MDItMDggMTM6NDYsIERtaXRyeSBPc2lwZW5rbyB3cm90ZToNCj4gPj4gMDguMDIuMjAxOSAxOjI1
LCBEbWl0cnkgT3NpcGVua28g0L/QuNGI0LXRgjoNCj4gPj4+PiAwOC4wMi4yMDE5IDE6MTYsIFNv
d2phbnlhIEtvbWF0aW5lbmkg0L/QuNGI0LXRgjo+DQo+ID4+Pj4+PiBUaGlzIGlzIHdyb25nLCA2
NTUzNSA9IDY0ICogMTAyNCAtIDEuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gTGV0J3MganVzdCB1c2Ug
c2l6ZS1jb25zdGFudHMgcHJvdmlkZWQgYnkga2VybmVsOg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IHN0
YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2FkYXB0ZXJfcXVpcmtzIHRlZ3JhX2kyY19xdWlya3MgPSB7
DQo+ID4+Pj4+PiAJLmZsYWdzID0gSTJDX0FRX05PX1pFUk9fTEVOLA0KPiA+Pj4+Pj4gCS5tYXhf
cmVhZF9sZW4gPSBTWl80SywNCj4gPj4+Pj4+IAkubWF4X3dyaXRlX2xlbiA9IFNaXzRLIC0gSTJD
X1BBQ0tFVF9IRUFERVJfU0laRSwgfTsNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBzdGF0aWMgY29uc3Qg
c3RydWN0IGkyY19hZGFwdGVyX3F1aXJrcyB0ZWdyYTE5NF9pMmNfcXVpcmtzID0gew0KPiA+Pj4+
Pj4gCS5mbGFncyA9IEkyQ19BUV9OT19aRVJPX0xFTiwNCj4gPj4+Pj4+IAkubWF4X3JlYWRfbGVu
ID0gU1pfNjRLLA0KPiA+Pj4+Pj4gCS5tYXhfd3JpdGVfbGVuID0gU1pfNjRLIC0gSTJDX1BBQ0tF
VF9IRUFERVJfU0laRSwgfTsNCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSdsbCB0YWtl
IGEgbG9vayBhdCBvdGhlciBwYXRjaGVzIGxhdGVyIHRvZGF5LCBubyBuZWVkIHRvIHNlbmQgb3V0
IG5ldyB2ZXJzaW9uIHJpZ2h0IG5vdy4NCj4gPj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pg0KPiA+
Pj4+PiBTSVpFXzY0SyBpcyAweDAwMDEwMDAwICg2NTUzNikNCj4gPj4+Pj4NCj4gPj4+Pj4gbXNn
IGxlbiBpcyB1MTYgYW5kIG1heCB0aGF0IGNhbiBiZSBzZXQgdG8gbXNnLmxlbiBpcyA2NTUzNQ0K
PiA+Pj4NCj4gPj4+IEFoLCBva2F5LiBUaGVuIGl0IGxvb2tzIGFib3V0IHJpZ2h0LCBtYXliZSBp
dCdzIHRpbWUgdG8gY2hhbmdlIHUxNiB0byB1MzIgaW4gdGhlIEkyQyBjb3JlLg0KPiA+Pj4NCj4g
Pj4NCj4gPj4gSGVyZSBpcyBteSBzdWdnZXN0aW9uOg0KPiA+Pg0KPiA+PiAxKSBVc2UgU1pfNEsg
LyBTWl82NEsgdGhhdCBJIHN1Z2dlc3RlZCBhYm92ZS4NCj4gPj4NCj4gPj4gMikgU3F1YXNoIHRo
aXMgcGF0Y2ggaW50byB0aGUgRE1BLXBhdGNoLg0KPiA+Pg0KPiA+PiAzKSBBZGQgYW5vdGhlciBw
YXRjaCAoYmVmb3JlIHRoZSBETUEtcGF0Y2gpIHRoYXQgY2hhbmdlcyANCj4gPj4gbWF4X3JlYWRf
bGVuL21heF93cml0ZV9sZW4gdHlwZXMgdG8gdTMyIGluIHRoZSBpbmNsdWRlL2xpbnV4L2kyYy5o
DQo+ID4gDQo+ID4gVGhhdCBpcyBhIGJpdCBuYWl2ZSBhbmQgd2lsbCBub3QgZmx5IHNpbmNlIHRo
ZSBJMkMgY29yZSBoYXMgYSBtYXggDQo+ID4gbWVzc2FnZSBzaXplIG9mIDY1NTM1LiBXaGljaCBp
cyBleHBvc2VkIHRvIHVzZXIgc3BhY2UuLi4NCj4gPiANCj4gPiBHaXZlbiB0aGUgYWJvdmUsIHNh
eWluZyAubWF4X3JlYWRfbGVuID0gNjU1MzUgYSBOT1AgKGFuZCBpcyBpbiBmYWN0IA0KPiA+IG9t
aXR0ZWQgaW4gcGxhY2VzIHdoZXJlIGl0IHdvdWxkIGJlIG5lZWRlZCBpZiB0aGUgdHlwZSBpcyBj
aGFuZ2VkKS4gSSANCj4gPiBzdWdnZXN0IHRoYXQgaXQgaXMgb21pdHRlZCBoZXJlIGFzIHdlbGwu
IEJ1dCBTWl82NEsgLSANCj4gPiBJMkNfUEFDS0VUX0hFQURFUl9TSVpFIGlzIHN0aWxsIG5lZWRl
ZCBvZiBjb3Vyc2UuIEF0IGxlYXN0IGlmIA0KPiA+IEkyQ19QQUNLRVRfSEVBREVSX1NJWkUgaXMg
Z3VhcmFudGVlZCB0byBiZSBub24temVybz8NCj4NCj4gQWgsIEkgbWlzc2VkIHRoYXQgbWVzc2Fn
ZSBsZW4gaXMgYWxzbyB1MTYgYW5kIHRoZW4gd2UgaW5kZWVkIGNvdWxkIGp1c3QgZHJvcCB0aGUg
Im1heF9yZWFkX2xlbiIgZm9yIFQxOTQuIFRoYW5rIHlvdSBQZXRlci4NCj4NCj4gU293amFueWEs
IGdpdmVuIHRoZSBhYm92ZSwgaXQgcHJvYmFibHkgYmV0dGVyIHRvIGRlZmluZSBkbWFfYnVmIG1h
eC1zaXplIGluIHRoZSB0ZWdyYV9pMmNfaHdfZmVhdHVyZS4NCj4NCg0KSTJDX1BBQ0tFVF9IRUFE
RVJfU0laRSBpcyBhbHdheXMgZml4ZWQgMTIuIFNvIGluIHRoYXQgY2FzZSwgd2UgY2FuIGp1c3Qg
YWRkIG1heF93cml0ZV9sZW4gDQpJZiBubyBtYXhfcmVhZF9sZW4sIG1heCB3aWxsIGJlIDY1NTM1
IGFueXdheSByaWdodA0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IGkyY19hZGFwdGVyX3F1aXJrcyB0
ZWdyYTE5NF9pMmNfcXVpcmtzID0gew0KCS5mbGFncyA9IEkyQ19BUV9OT19aRVJPX0xFTiwNCgku
bWF4X3dyaXRlX2xlbiA9IFNaXzY0SyAtIEkyQ19QQUNLRVRfSEVBREVSX1NJWkUsIH07DQoNCg0K
c293amFueWENCg==
