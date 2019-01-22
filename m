Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE56C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4B21726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aqVD30a9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfAVWOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:14:45 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:21381 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfAVWOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:14:44 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4795b80001>; Wed, 23 Jan 2019 06:14:16 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 14:14:15 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 22 Jan 2019 14:14:15 -0800
Received: from DRBGMAIL104.nvidia.com (10.18.16.23) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 22:14:14 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by DRBGMAIL104.nvidia.com
 (10.18.16.23) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 22:14:13 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 22 Jan 2019 22:14:12 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3624.namprd12.prod.outlook.com (20.178.54.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 22:13:53 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 22:13:53 +0000
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
Subject: RE: [PATCH V3] i2c: tegra: Add Bus Clear Master Support
Thread-Topic: [PATCH V3] i2c: tegra: Add Bus Clear Master Support
Thread-Index: AQHUso1kdg7Gzt/H6Ea7kfGg9tns/6W7uGMAgAAUOsA=
Date:   Tue, 22 Jan 2019 22:13:53 +0000
Message-ID: <BYAPR12MB33984356AE1E279C7E0E880CC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548187338-6807-1-git-send-email-skomatineni@nvidia.com>
 <5405e9aa-d974-ca9d-dec1-32f8631a045d@gmail.com>
In-Reply-To: <5405e9aa-d974-ca9d-dec1-32f8631a045d@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3624;6:OxIsFfNGkwtgpLjPK4Hx4W9OqjBLrL9JRhD7GFS1rHHlTBLQcFlIDe2ja9weKac6KkbUescj2UDmiCNRVGShe2KKUMimrdNn8Ch6mRhk7VxaWXeEa12vr2PieuxTV7MpkPSRxD5NEpIwo9rvkQhoM2CXlgtgUDQTHFIRhG2yURnwjL3Gu4ISQBZzYy7ea87G952m0UMbYbCq8cGwWIXm+rdwg8KvKEdKo296UMhn0ZfaA2QTeU4kdfh0VhRzOikKvEmTFMr6HmAymhmmDhi7JHRSzPp2de9i4tTXMiMEEW+Di0hZdEwVKSsBQHWfCueIGZh9b5zwVS9i7L+AAd8gL82Q8Qv5yZ7Hoa61Afl3d1ML/6Ygrw84JbDa70Cau2rC3S/vyYlFUUiRoaILmfjupsYG8ynWiSTwhAta9gl/kB9bqzkBeD4ynn4oIwVoCf1TVZDvm4XVbsGMcbeEaGwX1g==;5:RhUJ5yzi5x2A+qyaGtYx6ftKa8232BvNryHBlzvbmE0sqephtongcHlvAEwfix2CsPnSOwZNTRV21ZS4P8jbFGT0I80gi7F9Wn0oS52HHmQ4ribFTLA9c8JkKd3NM/9qgqZg0U39Fx4KifYDEKJdUtFkXyuUmmR+aHdPJ8sgeVQNqzch3PEo37erJ9ojWNji3227XhQqW72vzPEmnWMP9w==;7:arazuJqH7Ij2nJO9VEqIrHemvFM75YN/Aydfk0M/MoowyDPRhxuP3SCi8tLbv/sAyD3sJq7R8iX7+kDHmsLWgsBEGVz8FWYMJp6phanGyAWA+Wlg1b1hhycYbFln09FBfZp4ih2Mdytz9DB2+pcS5A==
x-ms-office365-filtering-correlation-id: 811d0415-2341-49c0-87a7-08d680b6e50b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3624;
x-ms-traffictypediagnostic: BYAPR12MB3624:
x-microsoft-antispam-prvs: <BYAPR12MB36246448FF11221B039322FBC2980@BYAPR12MB3624.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(396003)(39860400002)(376002)(199004)(189003)(66066001)(8936002)(6246003)(26005)(6506007)(81166006)(81156014)(8676002)(39060400002)(305945005)(53936002)(76176011)(25786009)(4326008)(446003)(7736002)(9686003)(11346002)(2501003)(68736007)(186003)(74316002)(476003)(102836004)(86362001)(3846002)(6116002)(7696005)(55016002)(14444005)(256004)(486006)(14454004)(99286004)(71190400001)(6436002)(2906002)(478600001)(33656002)(71200400001)(316002)(6636002)(105586002)(110136005)(54906003)(106356001)(97736004)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3624;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qXgNi349FmOq06fdljvfF68M8qDNTPsrnDezIw2YmSP3DeMsV9GTeKdwbVV3GQyjM5deInvO9qQbvvMq7/l+wbvfGLCOeDc0MNjpinuOcimrynukofNrBYwKC0FIjRTjBwpAglbHAJ8qL2KrKlO6/PEYeFHqbWSY8FaRgpmSh6uE4jn4JpuKI8o7WTlXLMgKAY9pAnF5bemsnFjvBvEQdbXKYPZw0yMdYETe6JnHxblJrOif4Em6vXVAtbIsXseae80SrokobAOkVf5ASVu45+dpOlpOSd3jXj8x+O9LJ9CY/tsRJByRy1pM6w5FxXPamLnBTwGZvD1Vdoom6tNkJSr56SbkfJoZu8CV3dZVZsNQE839jgJKOm7Vo9KryqTkLIhSIHcuMyZ5HzZQZkRrHx3MN40ly1Dx2js5xxwIVXk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 811d0415-2341-49c0-87a7-08d680b6e50b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 22:13:53.2723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3624
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548195281; bh=sndq+WL163sm2GppPg2mtVDcqfgM59CAaAVrIGos8m8=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=aqVD30a9s80yZzpdJcwCKZXs0KCAxV8Ewmq2jzEkHBHOVTn/Qjurz0ZwhM0saq2Lp
         SfZVOvMMhvwtB1VRkXb/9c42KijxvsE6kssvTNpFZlsrmA1OE8fuvw2wx13wHc+594
         6iq8m8HQDWht0VsY95bpTjmbwq+xg2Rtyr5va6ywqZXGq6HGUi1Xt00Rw7uhV+VKFo
         gX3c7J3AiRJaP2ygkpD3I8alXdnrn5dEoQfSqDMeSrC7x+WcraxfsQ0yeTPNHuw3h9
         WAeACLMNcoKiOrFYqevobjTHog2+emzs103Xuyb4s2iVSVX24zKlduhSE+5trBQQhP
         ms+12VzZJmMjg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4+IEJ1cyBjbGVhciBmZWF0dXJlIG9mIHRlZ3JhIGkyYyBjb250cm9sbGVyIGhlbHBzIHRv
IHJlY292ZXIgZnJvbSBidXMgDQo+PiBoYW5nIHdoZW4gaTJjIG1hc3RlciBsb3NlcyB0aGUgYnVz
IGFyYml0cmF0aW9uIGR1ZSB0byB0aGUgc2xhdmUgZGV2aWNlIA0KPj4gaG9sZGluZyBTREEgTE9X
IGNvbnRpbnVvdXNseSBmb3Igc29tZSB1bmtub3duIHJlYXNvbnMuDQo+PiANCj4+IFBlciBJMkMg
c3BlY2lmaWNhdGlvbiwgdGhlIGRldmljZSB0aGF0IGhlbGQgdGhlIGJ1cyBMT1cgc2hvdWxkIHJl
bGVhc2UgDQo+PiBpdCB3aXRoaW4gOSBjbG9jayBwdWxzZXMuDQo+PiANCj4+IER1cmluZyBidXMg
Y2xlYXIgb3BlcmF0aW9uLCBUZWdyYSBJMkMgY29udHJvbGxlciBzZW5kcyA5IGNsb2NrIHB1bHNl
cyANCj4+IGFuZCB0ZXJtaW5hdGVzIHRoZSB0cmFuc2FjdGlvbiB3aXRoIFNUT1AgY29uZGl0aW9u
Lg0KPj4gVXBvbiBzdWNjZXNzZnVsIGJ1cyBjbGVhciBvcGVyYXRpb24sIGJ1cyBnb2VzIHRvIGlk
bGUgc3RhdGUgYW5kIGRyaXZlciANCj4+IHJldHJpZXMgdGhlIHRyYW5zYWN0aW9uLg0KPj4gDQo+
PiBTaWduZWQtb2ZmLWJ5OiBTb3dqYW55YSBLb21hdGluZW5pIDxza29tYXRpbmVuaUBudmlkaWEu
Y29tPg0KPj4gLS0tDQo+PiAgW1YzXTogVXBkYXRlZCBjb21tZW50cyBhbmQgY29tbWl0IG1lc3Nh
Z2UgdG8gYmUgY2xlYXIgb24gdGhlIGNoYW5nZQ0KPj4gIFtWMl06IFNhbWUgYXMgVjEgcmViYXNl
ZCB0byA1LjAtcmMxDQo+PiANCj4+ICBkcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMgfCA3
MCANCj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCA3MCBpbnNlcnRpb25zKCspDQo+PiANCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMgDQo+PiBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMt
dGVncmEuYyBpbmRleCBlNDE3ZWJmNzYyOGMuLmIxYjkyMGI0YTIwMyANCj4+IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+PiArKysgYi9kcml2ZXJzL2ky
Yy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4+IEBAIC01NCw2ICs1NCw3IEBADQo+PiAgI2RlZmluZSBJ
MkNfRklGT19TVEFUVVNfUlhfU0hJRlQJCTANCj4+ICAjZGVmaW5lIEkyQ19JTlRfTUFTSwkJCQkw
eDA2NA0KPj4gICNkZWZpbmUgSTJDX0lOVF9TVEFUVVMJCQkJMHgwNjgNCj4+ICsjZGVmaW5lIEky
Q19JTlRfQlVTX0NMUl9ET05FCQkJQklUKDExKQ0KPj4gICNkZWZpbmUgSTJDX0lOVF9QQUNLRVRf
WEZFUl9DT01QTEVURQkJQklUKDcpDQo+PiAgI2RlZmluZSBJMkNfSU5UX0FMTF9QQUNLRVRTX1hG
RVJfQ09NUExFVEUJQklUKDYpDQo+PiAgI2RlZmluZSBJMkNfSU5UX1RYX0ZJRk9fT1ZFUkZMT1cJ
CUJJVCg1KQ0KPj4gQEAgLTk2LDYgKzk3LDE1IEBADQo+PiAgI2RlZmluZSBJMkNfSEVBREVSX01B
U1RFUl9BRERSX1NISUZUCQkxMg0KPj4gICNkZWZpbmUgSTJDX0hFQURFUl9TTEFWRV9BRERSX1NI
SUZUCQkxDQo+PiAgDQo+PiArI2RlZmluZSBJMkNfQlVTX0NMRUFSX0NORkcJCQkweDA4NA0KPj4g
KyNkZWZpbmUgSTJDX0JDX1NDTEtfVEhSRVNIT0xECQkJOQ0KPj4gKyNkZWZpbmUgSTJDX0JDX1ND
TEtfVEhSRVNIT0xEX1NISUZUCQkxNg0KPj4gKyNkZWZpbmUgSTJDX0JDX1NUT1BfQ09ORAkJCUJJ
VCgyKQ0KPj4gKyNkZWZpbmUgSTJDX0JDX1RFUk1JTkFURQkJCUJJVCgxKQ0KPj4gKyNkZWZpbmUg
STJDX0JDX0VOQUJMRQkJCQlCSVQoMCkNCj4+ICsjZGVmaW5lIEkyQ19CVVNfQ0xFQVJfU1RBVFVT
CQkJMHgwODgNCj4+ICsjZGVmaW5lIEkyQ19CQ19TVEFUVVMJCQkJQklUKDApDQo+PiArDQo+PiAg
I2RlZmluZSBJMkNfQ09ORklHX0xPQUQJCQkJMHgwOEMNCj4+ICAjZGVmaW5lIEkyQ19NU1RSX0NP
TkZJR19MT0FECQkJQklUKDApDQo+PiAgI2RlZmluZSBJMkNfU0xWX0NPTkZJR19MT0FECQkJQklU
KDEpDQo+PiBAQCAtMTU1LDYgKzE2NSw4IEBAIGVudW0gbXNnX2VuZF90eXBlIHsNCj4+ICAgKiBA
aGFzX21zdF9maWZvOiBUaGUgSTJDIGNvbnRyb2xsZXIgY29udGFpbnMgdGhlIG5ldyBNU1QgRklG
TyBpbnRlcmZhY2UgdGhhdA0KPj4gICAqCQlwcm92aWRlcyBhZGRpdGlvbmFsIGZlYXR1cmVzIGFu
ZCBhbGxvd3MgZm9yIGxvbmdlciBtZXNzYWdlcyB0bw0KPj4gICAqCQliZSB0cmFuc2ZlcnJlZCBp
biBvbmUgZ28uDQo+PiArICogQHN1cHBvcnRzX2J1c19jbGVhcjogQnVzIENsZWFyIHN1cHBvcnQg
dG8gcmVjb3ZlciBmcm9tIGJ1cyBoYW5nIGR1cmluZw0KPj4gKyAqCQlTREEgc3R1Y2sgbG93IGZy
b20gZGV2aWNlIGZvciBzb21lIHVua25vd24gcmVhc29ucy4NCj4+ICAgKi8NCj4+ICBzdHJ1Y3Qg
dGVncmFfaTJjX2h3X2ZlYXR1cmUgew0KPj4gIAlib29sIGhhc19jb250aW51ZV94ZmVyX3N1cHBv
cnQ7DQo+PiBAQCAtMTY3LDYgKzE3OSw3IEBAIHN0cnVjdCB0ZWdyYV9pMmNfaHdfZmVhdHVyZSB7
DQo+PiAgCWJvb2wgaGFzX211bHRpX21hc3Rlcl9tb2RlOw0KPj4gIAlib29sIGhhc19zbGNnX292
ZXJyaWRlX3JlZzsNCj4+ICAJYm9vbCBoYXNfbXN0X2ZpZm87DQo+PiArCWJvb2wgc3VwcG9ydHNf
YnVzX2NsZWFyOw0KPj4gIH07DQo+PiAgDQo+PiAgLyoqDQo+PiBAQCAtNjM5LDYgKzY1MiwxMiBA
QCBzdGF0aWMgaXJxcmV0dXJuX3QgdGVncmFfaTJjX2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQp
DQo+PiAgCQkJaTJjX2Rldi0+bXNnX2VyciB8PSBJMkNfRVJSX0FSQklUUkFUSU9OX0xPU1Q7DQo+
PiAgCQlnb3RvIGVycjsNCj4+ICAJfQ0KPj4gKwkvKg0KPj4gKwkgKiBJMkMgdHJhbnNmZXIgaXMg
dGVybWluYXRlZCBkdXJpbmcgdGhlIGJ1cyBjbGVhciBzbyBza2lwDQo+PiArCSAqIHByb2Nlc3Np
bmcgdGhlIG90aGVyIGludGVycnVwdHMuDQo+PiArCSAqLw0KPj4gKwlpZiAoaTJjX2Rldi0+aHct
PnN1cHBvcnRzX2J1c19jbGVhciAmJiAoc3RhdHVzICYgSTJDX0lOVF9CVVNfQ0xSX0RPTkUpKQ0K
Pj4gKwkJZ290byBlcnI7DQo+PiAgDQo+PiAgCWlmIChpMmNfZGV2LT5tc2dfcmVhZCAmJiAoc3Rh
dHVzICYgSTJDX0lOVF9SWF9GSUZPX0RBVEFfUkVRKSkgew0KPj4gIAkJaWYgKGkyY19kZXYtPm1z
Z19idWZfcmVtYWluaW5nKQ0KPj4gQEAgLTY2OCw2ICs2ODcsOCBAQCBzdGF0aWMgaXJxcmV0dXJu
X3QgdGVncmFfaTJjX2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+PiAgCXRlZ3JhX2kyY19t
YXNrX2lycShpMmNfZGV2LCBJMkNfSU5UX05PX0FDSyB8IEkyQ19JTlRfQVJCSVRSQVRJT05fTE9T
VCB8DQo+PiAgCQlJMkNfSU5UX1BBQ0tFVF9YRkVSX0NPTVBMRVRFIHwgSTJDX0lOVF9UWF9GSUZP
X0RBVEFfUkVRIHwNCj4+ICAJCUkyQ19JTlRfUlhfRklGT19EQVRBX1JFUSk7DQo+PiArCWlmIChp
MmNfZGV2LT5ody0+c3VwcG9ydHNfYnVzX2NsZWFyKQ0KPj4gKwkJdGVncmFfaTJjX21hc2tfaXJx
KGkyY19kZXYsIEkyQ19JTlRfQlVTX0NMUl9ET05FKTsNCj4+ICAJaTJjX3dyaXRlbChpMmNfZGV2
LCBzdGF0dXMsIEkyQ19JTlRfU1RBVFVTKTsNCj4+ICAJaWYgKGkyY19kZXYtPmlzX2R2YykNCj4+
ICAJCWR2Y193cml0ZWwoaTJjX2RldiwgRFZDX1NUQVRVU19JMkNfRE9ORV9JTlRSLCBEVkNfU1RB
VFVTKTsgQEAgDQo+PiAtNjc4LDYgKzY5OSw0MyBAQCBzdGF0aWMgaXJxcmV0dXJuX3QgdGVncmFf
aTJjX2lzcihpbnQgaXJxLCB2b2lkICpkZXZfaWQpDQo+PiAgCXJldHVybiBJUlFfSEFORExFRDsN
Cj4+ICB9DQo+PiAgDQo+PiArc3RhdGljIGludCB0ZWdyYV9pMmNfaXNzdWVfYnVzX2NsZWFyKHN0
cnVjdCB0ZWdyYV9pMmNfZGV2ICppMmNfZGV2KSB7DQo+PiArCWludCBlcnI7DQo+PiArCXVuc2ln
bmVkIGxvbmcgdGltZV9sZWZ0Ow0KPj4gKwl1MzIgcmVnOw0KPj4gKw0KPj4gKwlpZiAoaTJjX2Rl
di0+aHctPnN1cHBvcnRzX2J1c19jbGVhcikgew0KPj4gKwkJcmVpbml0X2NvbXBsZXRpb24oJmky
Y19kZXYtPm1zZ19jb21wbGV0ZSk7DQo+PiArCQlyZWcgPSAoSTJDX0JDX1NDTEtfVEhSRVNIT0xE
IDw8IEkyQ19CQ19TQ0xLX1RIUkVTSE9MRF9TSElGVCkgfA0KPj4gKwkJICAgICAgSTJDX0JDX1NU
T1BfQ09ORCB8IEkyQ19CQ19URVJNSU5BVEU7DQo+PiArCQlpMmNfd3JpdGVsKGkyY19kZXYsIHJl
ZywgSTJDX0JVU19DTEVBUl9DTkZHKTsNCj4+ICsJCWlmIChpMmNfZGV2LT5ody0+aGFzX2NvbmZp
Z19sb2FkX3JlZykgew0KPj4gKwkJCWVyciA9IHRlZ3JhX2kyY193YWl0X2Zvcl9jb25maWdfbG9h
ZChpMmNfZGV2KTsNCj4+ICsJCQlpZiAoZXJyKQ0KPj4gKwkJCQlyZXR1cm4gZXJyOw0KPj4gKwkJ
fQ0KPj4gKwkJcmVnIHw9IEkyQ19CQ19FTkFCTEU7DQo+PiArCQlpMmNfd3JpdGVsKGkyY19kZXYs
IHJlZywgSTJDX0JVU19DTEVBUl9DTkZHKTsNCj4+ICsJCXRlZ3JhX2kyY191bm1hc2tfaXJxKGky
Y19kZXYsIEkyQ19JTlRfQlVTX0NMUl9ET05FKTsNCj4+ICsNCj4+ICsJCXRpbWVfbGVmdCA9IHdh
aXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmaTJjX2Rldi0+bXNnX2NvbXBsZXRlLA0KPj4gKwkJ
CQkJCQlURUdSQV9JMkNfVElNRU9VVCk7DQo+PiArCQlpZiAodGltZV9sZWZ0ID09IDApIHsNCj4+
ICsJCQlkZXZfZXJyKGkyY19kZXYtPmRldiwgInRpbWVkIG91dCBmb3IgYnVzIGNsZWFyXG4iKTsN
Cj4+ICsJCQlyZXR1cm4gLUVUSU1FRE9VVDsNCj4+ICsJCX0NCj4+ICsJCXJlZyA9IGkyY19yZWFk
bChpMmNfZGV2LCBJMkNfQlVTX0NMRUFSX1NUQVRVUyk7DQo+PiArCQlpZiAoIShyZWcgJiBJMkNf
QkNfU1RBVFVTKSkgew0KPj4gKwkJCWRldl9lcnIoaTJjX2Rldi0+ZGV2LA0KPj4gKwkJCQkiVW4t
cmVjb3ZlcmVkIGFyYml0cmF0aW9uIGxvc3RcbiIpOw0KPj4gKwkJCXJldHVybiAtRUlPOw0KPj4g
KwkJfQ0KPj4gKwl9DQo+PiArDQo+PiArCXJldHVybiAtRUFHQUlOOw0KPj4gK30NCj4+ICsNCj4+
ICBzdGF0aWMgaW50IHRlZ3JhX2kyY194ZmVyX21zZyhzdHJ1Y3QgdGVncmFfaTJjX2RldiAqaTJj
X2RldiwNCj4+ICAJc3RydWN0IGkyY19tc2cgKm1zZywgZW51bSBtc2dfZW5kX3R5cGUgZW5kX3N0
YXRlKSAgeyBAQCAtNzU5LDYgDQo+PiArODE3LDEyIEBAIHN0YXRpYyBpbnQgdGVncmFfaTJjX3hm
ZXJfbXNnKHN0cnVjdCB0ZWdyYV9pMmNfZGV2ICppMmNfZGV2LA0KPj4gIAkJcmV0dXJuIDA7DQo+
PiAgDQo+PiAgCXRlZ3JhX2kyY19pbml0KGkyY19kZXYpOw0KPj4gKwkvKiBzdGFydCByZWNvdmVy
eSB1cG9uIGFyYml0cmF0aW9uIGxvc3MgaW4gc2luZ2xlIG1hc3RlciBtb2RlICovDQo+PiArCWlm
IChpMmNfZGV2LT5tc2dfZXJyID09IEkyQ19FUlJfQVJCSVRSQVRJT05fTE9TVCkgew0KPj4gKwkJ
aWYgKCFpMmNfZGV2LT5pc19tdWx0aW1hc3Rlcl9tb2RlKQ0KPj4gKwkJCXJldHVybiB0ZWdyYV9p
MmNfaXNzdWVfYnVzX2NsZWFyKGkyY19kZXYpOw0KPj4gKwkJcmV0dXJuIC1FQUdBSU47DQo+DQo+
VGhpcyBjaGFuZ2VzIHRoZSByZXR1cm5lZCBlcnJubyBmcm9tIC1FSU8gdG8gLUVBR0FJTiBmb3Ig
dGhlIHN1cHBvcnRzX2J1c19jbGVhcj1mYWxzZSBjYXNlLCBpcyBpdCBva2F5IGFuZCBpbnRlbnRp
b25hbD8NCj4NCg0KWWVzIEVBR0FJTiBpcyBpbnRlbnRpb25hbCB0byBhbGxvdyBmb3IgdHJhbnNm
ZXIgcmV0cnkuDQpEdXJpbmcgc2luZ2xlIG1hc3RlciBtb2RlLCBBUkJJVFJBVElPTiBMT1NUIG5v
dGlmaWNhdGlvbiBoYXBwZW5zIHdoZW4gDQoxLiBJMkMgTWFzdGVyIHNlZXMgdGhlIGJ1cyBpcyBv
Y2N1cGllZCBieSBzb21lIG90aGVyIGRldmljZSB3aGVuIGEgdHJhbnNmZXIgaXMgaW5pdGlhdGVk
IA0KMi4gSTJDIE1hc3RlciBsb3N0IHRoZSBidXMgZHVyaW5nIGFyYml0cmF0aW9uIGluY2FzZSBp
ZiBzbGF2ZSBkZXZpY2UgcHVsbHMgU0RBIGxpbmUgbG93IGNvbnRpbnVvdXNseSBmb3Igc29tZSB1
bmtub3duIHJlYXNvbg0KSWYgYXJiaXRyYXRpb24gbG9zdCBpcyBkdWUgdG8gY2F1c2UgMSwgcmV0
cnkgaGVscHMgdG8gY29udGludWUgd2l0aCB0cmFuc2ZlciBvbmNlIGJ1cyBpcyByZWxlYXNlZCBi
eSB0aGUgc2xhdmUgYW5kIGl0IGp1c3QgYWRkZWQgZGVsYXkgaW4gY29tbXVuaWNhdGlvbiBkdWUg
dG8gYnVzIHJlbGVhc2UgZGVsYXkgYnkgc2xhdmUuDQpJbiBjYXNlIG9mIDJuZCBjYXVzZSwgcmV0
cnkgbmV2ZXIgc3VjY2VlZHMgaW4gY2FzZXMgd2hlcmUgYnVzIGNsZWFyIGlzIG5vdCBzdXBwb3J0
ZWQuDQoNClRoYW5rcw0KU293amFueWENCg==
