Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE970C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737C5218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="farRO0an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbfAYX3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:29:52 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:5938 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfAYX3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:29:52 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b9bef0000>; Sat, 26 Jan 2019 07:29:51 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 15:29:48 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 25 Jan 2019 15:29:48 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 23:29:47 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.56) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Fri, 25 Jan 2019 23:29:47 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3126.namprd12.prod.outlook.com (20.178.54.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Fri, 25 Jan 2019 23:29:44 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.021; Fri, 25 Jan 2019
 23:29:44 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Topic: [PATCH V2 3/4] i2c: tegra: Add DMA Support
Thread-Index: AQHUtCaoqz5N11EqJkeckmeQlifKWKXAYa0AgAANI4CAAAUtAIAAAiXggAAn8oCAAASNEA==
Date:   Fri, 25 Jan 2019 23:29:43 +0000
Message-ID: <BYAPR12MB33989F7CC9FCB45AE0BFC561C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548363113-25969-1-git-send-email-skomatineni@nvidia.com>
 <1548363113-25969-3-git-send-email-skomatineni@nvidia.com>
 <dcc1e094-638e-5b04-7a61-bdbc24ee068f@gmail.com>
 <BYAPR12MB339829FC6F2F95F833FE45A1C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <ad177c2e-3801-ddad-b359-ac83530ee1d6@gmail.com>
 <BYAPR12MB33982ED3A9EC34819D2490F8C29B0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190125231040.GA2013@mithrandir>
In-Reply-To: <20190125231040.GA2013@mithrandir>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3126;6:70DiD6TbTdsV05binyGQWxGYzU03mtmrq9DfAnU2CE30g64Ib4piL/CA7Q7iyCTzovTCL8LB+LqRFyiwN1qX7p5d8pCX72nzSWRSRkZq8io/x7H3OYPRTOhqxgUjSmqmqBiphbzyUeRE/b28zvKDDpw9KqQGvbcFUjV6qoFgnOXtW7zbD7i5FILO8kjrd4wdAkbei+nFwaoLyfq7RH5Zi9LcwcFxgU1VHdLoCqmjjpWoHF6dcQgdxvPbSX0GzTTDTy3LAzna5v2GLQEsLVi7iOnbI+otjDfh5vUhDcgrTDa1BuzrXdMNTmTmkVW754otNmfxLcMgXAt/Ic8z0uN6t66kZLbJ+rVXoNcb5vP3l60RxjTZj/mMc66D/vQYp/PeG5cw1vfFDcuJ+pwtAgTgXHJlUbFMmnC3kmIE05j4PXWlJ2KsLq/fW4P7Q9IT9JxSC1YrSam7wMpIukqqBAFjyQ==;5:/+vP9SCmSJ7muJvN7jsCLcPmbqMi7HX3F3bkc5wN/bQCzg1GC/piAYenVdjL4klXJp7491nfLSaKvWitAltn43b9FFYKt/8/EM6lr6Ihq054yK3k7lVv2aCN5BUWhGyMshFGBuwHmbGYYKhou0Fd5qH20fzVFuki+CJmjCCLcLSDVkVXgTIqdEtgIWsqa2a+ivvzAgBESLUjtgp9fCIW6w==;7:O57w/0DQFimP0ZcAviTTAO2+NZkvTcBFsCgi8c6UzSOayp04BbG/zpDyNoC0sr3ki6Ki4ucimKKFnHVozc4eQW6ijRm6c3BslNhwxVXZwyOirlorzCS+rnilz6dOi+jTPxsUzYrpAFBVHiPYNL856A==
x-ms-office365-filtering-correlation-id: 3ec1bab9-976d-42d6-fbe1-08d6831cfcbc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3126;
x-ms-traffictypediagnostic: BYAPR12MB3126:
x-microsoft-antispam-prvs: <BYAPR12MB31263CF3D264A8B30A0D0CE5C29B0@BYAPR12MB3126.namprd12.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(189003)(55016002)(478600001)(25786009)(71190400001)(71200400001)(6916009)(186003)(53936002)(6246003)(9686003)(4326008)(74316002)(106356001)(39060400002)(446003)(105586002)(68736007)(99286004)(316002)(305945005)(54906003)(229853002)(7736002)(14454004)(102836004)(26005)(66066001)(486006)(3846002)(97736004)(6436002)(6506007)(14444005)(81166006)(256004)(6116002)(81156014)(33656002)(76176011)(8936002)(93886005)(2906002)(11346002)(8676002)(7696005)(86362001)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3126;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iHPuur+VtHJUBgdUVcJUDg9O5iV/ZkOJrR5Wiv6HH5ibQyFWFKTuwTNrlPfogV/Pu7q8G9c/bHdcLq2J9jSsjMx0l9IXFpwAA9hLWtZmzP3qZpOZEmyXOQ8mE7mNmI5Fwx0FWti01wmmdRCHWWaGgfBr+iiuCUBLR+3xlLJFZjY+KTTRpFnj7lmhq0wrKKfCk3LpwqqiOpJwjldp+LhMg+pky0QH3HvivSz9v9Yo7ctKVk+b3ew6DYQeLdsR/4YZmzo0iWhUQK+Sbwr3RtBolrVgVV1zn8io4i/+2Bydtc75yUCr4Ol61W/+uvQoyCVYs80+cfQ3yPhwF3P625YU71XlLSo9TRtJsED9gWX1NCnm0B2DJPi3/Y+J11mQqfUMg7i2YLNJ8R6HE0C6tMo9x6TUUlI2Qzl+sSFfB4OvkKg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec1bab9-976d-42d6-fbe1-08d6831cfcbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 23:29:44.0179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3126
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548458991; bh=FvdvFrU0Nr4cxRYPK9k+g06coOc7Z+jg4TKK+a7K4HI=;
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
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=farRO0anhKDCTFM427GCHjeQ2o8zVRdfgbSpdU+RELYlOSEA/ST/vDa9cyz9ArpzX
         FHIMhTpEFgax7wzSJvnuS0pX1T8POpCze7Ahp9LPeIcxcGlAdikW8kxUW2pH+Wons8
         pN+eR4nAyBYmIMj957jY6/9aUL35wI08J2bJJkg/L/PEWzzwcQROIS7CA9vVaMIgS/
         DeittaOmz1e/QHGZrgkl37nbPcCAsjed8A4nVu8vRj8K9wYrMVwA5JA8AH7W0gInzI
         EGNyk1sLSmzB12JaOmNndtbkY9/9aMUmFSJCcAmlqBg2uS7J5LvZTTGKCuf5TmY8Ho
         W1bEEpU2q/fag==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiA+ID4+PiArCWlmIChpMmNfZGV2LT5oYXNfZG1hKSB7DQo+ID4gPiA+Pj4gKwkJcmV0
ID0gdGVncmFfaTJjX2luaXRfZG1hX3BhcmFtKGkyY19kZXYsIHRydWUpOw0KPiA+ID4gPj4+ICsJ
CWlmIChyZXQgPT0gLUVQUk9CRV9ERUZFUikNCj4gPiA+ID4+PiArCQkJZ290byBkaXNhYmxlX2Rp
dl9jbGs7DQo+ID4gPiA+Pj4gKwkJcmV0ID0gdGVncmFfaTJjX2luaXRfZG1hX3BhcmFtKGkyY19k
ZXYsIGZhbHNlKTsNCj4gPiA+ID4+PiArCQlpZiAocmV0ID09IC1FUFJPQkVfREVGRVIpDQo+ID4g
PiA+Pj4gKwkJCWdvdG8gZGlzYWJsZV9kaXZfY2xrOw0KPiA+ID4gPj4NCj4gPiA+ID4+IFNvIHRl
Z3JhX2kyY19pbml0X2RtYV9wYXJhbSgpIGNvdWxkIGZhaWwsIHByaW50aW5nIGEgZXJyb3IgDQo+
ID4gPiA+PiBtZXNzYWdlLCBhbmQgcHJvYmUgd2lsbCBzdWNjZWVkPyBJZiBhbGxvY2F0aW9uIGZh
aWxzIGR1cmluZyB0aGUgDQo+ID4gPiA+PiBkcml2ZXIncyBwcm9iZSwgdGhlbiBqdXN0IGZhaWwg
dGhlIHByb2JlLiBQbGVhc2UgZ2l2ZSB0aGUgDQo+ID4gPiA+PiByYXRpb25hbGUuDQo+ID4gPiA+
IA0KPiA+ID4gPiBJZiBBUEIgRE1BIHByb2JlIGRvZXNu4oCZdCBoYXBwZW4gcHJpb3IgdG8gdGVn
cmEgaTJjLCBETUEgaXMgbm90IA0KPiA+ID4gPiBhdmFpbGFibGUgYnkgdGhlIHRpbWUgdGVncmFf
aW5pdF9kbWFfcGFyYW0gdHJpZXMgdG8gcmVxdWVzdCBzbGF2ZSANCj4gPiA+ID4gY2hhbm5lbCBh
bmQgaW4gdGhvc2UgY2FzZXMgZG1hX3JlcXVlc3Rfc2xhdmVfY2hhbm5lbF9yZWFzb24gd2lsbCAN
Cj4gPiA+ID4gcmV0dXJuIEVQUk9CRV9ERUZFUiBmb3IgdGVncmEgSTJDIHByb2JlIHRvIHJldHJ5
DQo+ID4gPiA+IA0KPiA+ID4gPiBJbiBjYXNlIGlmIERNQSBpcyBhdmFpbGFibGUgYnV0IERNQSBi
dWZmZXIgYWxsb2NhdGlvbiBmYWlscywgdGhlbiANCj4gPiA+ID4gdGVncmFfaTJjX2luaXRfZG1h
X3BhcmFtIHJldHVybnMgRU5PTUVNIGFuZCBwcm9iZSBhbHNvIGZhaWxzIA0KPiA+ID4gPiByZXR1
cm5pbmcgc2FtZSBFTk9NRU0NCj4gPiA+DQo+ID4gPiBJcyB0aGF0IHdoYXQgeW91J3JlIGdvaW5n
IHRvIGNoYW5nZSBpbiB0aGUgbmV4dCB2ZXJzaW9uPyBZb3VyIA0KPiA+ID4gY3VycmVudCB2YXJp
YW50IG9mIHRoZSBjb2RlIGRvZXNuJ3QgZmFpbCB0aGUgcHJvYmUgb24gRU5PTUVNIGFuZCANCj4g
PiA+IHRoZXJlIGlzIGR1cGxpY2F0ZWQgYXR0ZW1wdCB0byBpbnZva2UgdGVncmFfaTJjX2luaXRf
ZG1hX3BhcmFtKCkgDQo+ID4gPiBkdXJpbmcgdGhlIHRyYW5zZmVyLg0KPiA+IA0KPiA+IFNvcnJ5
IGNvcnJlY3Rpb24gdG8gbXkgcHJldmlvdXMgcmVwbHkuICBJZiBETUEgYnVmZmVyIGFsbG9jYXRp
b24gDQo+ID4gZmFpbHMsIHRlZ3JhX2kyY19pbml0X2RtYV9wYXJhbSByZXR1cm5zIEVOT01FTSBi
dXQgcHJvYmUgd2lsbCBzdWNjZWVkIA0KPiA+IGFzIGkyYyB0cmFuc2FjdGlvbiBuZWVkIHRvIGhh
cHBlbiBkdXJpbmcgIGJvb3QgZm9yIHNvbWUgcGxhdGZvcm0gDQo+ID4gZGV2aWNlIHByb2dyYW1t
aW5nIGZvciBzdWNjZXNzZnVsIGJvb3QgYW5kIHRoZXkgdXNlIFBJTyBtb2RlIGFzIHhmZXIgDQo+
ID4gYnl0ZXMgaXMgbGVzcyBhbmQgZGVmZXJyaW5nIGkyYyBwcm9iZSBmb3IgRU5PTUVNIGNhdXNl
cyBib290IHRvIGZhaWwgDQo+ID4gc28gZHVyaW5nIHByb2JlIEVQUk9CRV9ERUZFUiBpcyBvbmx5
IHRha2VuIGNhcmUuDQo+ID4gDQo+ID4gUmUtYXR0ZW1wdCBvZiB0ZWdyYV9pMmNfaW5pdF9kbWFf
cGFyYW0gaW4geGZlciBoYXBwZW5zIG9ubHkgaWYgbm8gDQo+ID4gc3VjY2Vzc2Z1bCBETUEgY2hh
bm5lbCBhbGxvY2F0aW9uIGhhcHBlbnMgcHJpb3IgdG8gdGhhdCAoIGR1cmluZyBwcm9iZSANCj4g
PiBpbiBjYXNlIG9mIEVOT01FTSkuDQo+ID4gRE1BIG1vZGUgaXMgbWFpbmx5IGZvciBsYXJnZSB0
cmFuc2ZlciwgYW5kIGkyYyB4ZmVyIHJldHVybmluZyBmYWlsdXJlIA0KPiA+IGR1ZSB0byBmYWls
aW5nIERNQSBidWZmZXIgYWxsb2NhdGlvbiBjYXVzZXMgYm9vdCB0byBoYW5nIGFzIHBsYXRmb3Jt
IA0KPiA+IGRldmljZSBwcm9ncmFtbWluZyBuZWVkIHRvIGhhcHBlbiB3aGljaCBkb2VzbuKAmXQg
bmVlZCB0byB1c2UgRE1BLg0KPiA+IFdpbGwgZml4IHRoaXMgYW5kIHdpbGwgc2VuZCB1cGRhdGVk
IHBhdGNoIHRvIHJlYXR0ZW1wdCBETUEgcmVxdWVzdCBhbmQgDQo+ID4gYnVmZmVyIGFsbG9jYXRp
b24gZHVyaW5nIERNQSBtb2RlIHRyYW5zZmVyIGFuZCB3aWxsIHJldHVybiBmYWlsIGZvciANCj4g
PiBETUEgbW9kZSBJMkMgdHJhbnNmZXIuLi4NCj4NCj4gSSdtIHdvbmRlcmluZyBpZiB3ZSBzaG91
bGRuJ3QgZ3JhY2VmdWxseSB0byBQSU8gaWYgd2UgZmFpbCB0byBhbGxvY2F0ZSBETUEgYnVmZmVy
cy4gRXZlbiBpZiBpdCBpcyB1bmxpa2VseSB0aGF0IGxhcmdlIHRyYW5zZmVycyAoPiB0aGFuIHRo
ZSB0aHJlc2hvbGQgdGhhdCBhY3RpdmF0ZXMgdGhlIERNQSBwYXRocykgd2lsbCBiZSBuZWVkZWQg
YnkgY3JpdGljYWwgSTJDIGNsaWVudHMsIHRoZXJlJ3MgcmVhbGx5IG5vIHJlYXNvbiB3aHkgd2Ug
Y2FuJ3QgZG8gUElPIGlmIERNQSA+IGRvZXNuJ3Qgd29yayBmb3Igc29tZSByZWFzb24uDQo+DQo+
IFRoaWVycnkNCg0KWWVzIHdlIGNhbiBmYWxsIGJhY2sgdG8gUElPIG1vZGUgaW5jYXNlIG9mIERN
QSBidWZmZXIgYWxsb2NhdGlvbiBmYWlsdXJlLiBXaWxsIGFkZCB0aGlzIGluIG5leHQgcmV2aXNl
ZCBwYXRjaA0KDQpTb3dqYW55YQ0K
