Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72426C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321A420870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="apk4nhj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfAVX0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:26:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6081 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfAVX0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:26:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c47a6810000>; Tue, 22 Jan 2019 15:25:53 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 22 Jan 2019 15:26:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 22 Jan 2019 15:26:11 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 22 Jan
 2019 23:26:10 +0000
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.56) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Tue, 22 Jan 2019 23:26:10 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3335.namprd12.prod.outlook.com (20.178.55.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 23:26:08 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::e4f9:9814:247a:d064%5]) with mapi id 15.20.1558.016; Tue, 22 Jan 2019
 23:26:08 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Shardar Mohammed" <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V3] i2c: tegra: Add Bus Clear Master Support
Thread-Topic: [PATCH V3] i2c: tegra: Add Bus Clear Master Support
Thread-Index: AQHUso1kdg7Gzt/H6Ea7kfGg9tns/6W7uGMAgAAUOsCAABVKAIAABcaQ
Date:   Tue, 22 Jan 2019 23:26:08 +0000
Message-ID: <BYAPR12MB33986390C45475180381713FC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1548187338-6807-1-git-send-email-skomatineni@nvidia.com>
        <5405e9aa-d974-ca9d-dec1-32f8631a045d@gmail.com>
        <BYAPR12MB33984356AE1E279C7E0E880CC2980@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190123014042.6d64ee29@dimatab>
In-Reply-To: <20190123014042.6d64ee29@dimatab>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3335;6:VNXKXTWmwel1tr/yPbZuifDKYxuG8AvEfux7/Hgmkaodd52iwRo0aLAhK0M/VOze6r/z9qOp68ajzfzyvJIvKZkiTWUDHk2DF5ZeFZPdvkErOgHrL35U24uUa4KBMLZJGjt88vbnFpuQ2VZA/4vcGS6A66J717+8gbZea/wamih8UfM5EPxPRY6P8XKH7npmK/wESkqu7EAJj34qjxk9/yi2/XYoJvNn/skjyZfoG5E2yHs4+nTOm+F68gA40w1GciZDWACBqtCYmfXBeGDMMmQ+fIwkHn6fXmN/9S2I5tZ3BvDJ2JDEozJbDRj+687QUqQdBzGJwTh16OwaMhjfzKdekgIGUgKXHkMGi5F5Zg9LYEbGzimXC2vCrbZgQAQi5IV5jzyLHmSt3j8GotOPz2MejXepjmq56uk27rOga1OiP0B6cQdoTy0A5g7gOFSpVkXjMzSocY7ylMche1iiyA==;5:fmwUIQ68cEsHIi4gCsVEGimUk0tZfIh737cgVTc2InpcZ59FGeZE746dwce0Zvat//BRol6LrhD4eJbkh8LmA8EEVEhUsv6wrpnTDTt2KR5roC/qKWMclSTlu71ixsxFsT+/yeHmKSHLt8vnYgiOGhpBUlSYtPk3X0L9/R196VwjUsCCGXCqaKDUvF2aQ6L7YPQje69Mn2WDLv+L+YtiSw==;7:ttmep3PpOr0zScJ401VgxMuK4uJBTX6NT/2aMMp4vFHZ+mrikCVZBuWiEEZdHl1Sge0q/i9D0rJLPJ3mO608PyPp4nORjYTP85O6xhQfbQkIzJnDel3o3HLKNPXIX2lNPQF5t2i6ymABmb3DyudLTw==
x-ms-office365-filtering-correlation-id: be995e02-1761-4293-5979-08d680c0fcc9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3335;
x-ms-traffictypediagnostic: BYAPR12MB3335:
x-microsoft-antispam-prvs: <BYAPR12MB3335344EEFAC0FFB5EE3129FC2980@BYAPR12MB3335.namprd12.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(189003)(199004)(478600001)(68736007)(4326008)(966005)(6246003)(53936002)(446003)(11346002)(3846002)(6116002)(476003)(486006)(25786009)(1411001)(6506007)(81166006)(81156014)(8676002)(86362001)(14454004)(186003)(102836004)(39060400002)(8936002)(66066001)(26005)(229853002)(33656002)(6916009)(76176011)(54906003)(55016002)(256004)(6306002)(14444005)(2906002)(7696005)(9686003)(99286004)(106356001)(105586002)(316002)(71190400001)(71200400001)(97736004)(7736002)(93886005)(74316002)(305945005)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3335;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d0Y+qeZ6ew9jywHdFY8qDwJVYIYXduwRg+Q/upoKzt3FMxLcmC4ruK5dOi0axG3Grbc+d7TaxUclWHV+Buus6gOzO6kVSF46dffACvFjr6y3FeZjXqGV3Iihy7bR1ooyu3whQ0ZEmU068lb4Xe3/GNEpaEEyHOdp7b/VXHNgI44T1r/q8sRQ7fgJzPZitttTmP3of53HZT923b4KP6nvHmXt+ptAlfbnn6DeX2Lox7F8+6tOuaRcPndxeLwwKKvBalF5YUJfstmxERjH1eRQ4KErc4gU0CNHW8xPZPtiX2t19cGGu3/b0UOOi520EcxpR91jnqPAgfAJve2PJ8TNVy6n3bvL+d8GgNQ8Akia5UCuDZKzl3wRIyrgDl7vPPXcqM2zb4NcL0xYaqzxbhHZU1tViovHvv4vnJsAz5Ri+pk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be995e02-1761-4293-5979-08d680c0fcc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 23:26:08.0562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548199553; bh=/txTVm/NkdQcXJIcsFnv/OdA43eiRJpssUMV1PvweNE=;
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
        b=apk4nhj9uftJ0vrIA/ISouwa2lneV2H1YWGLPnipPxJlRXDc06FKxBIlWYk06tcFM
         Em12Od6FpLWk+iYKQvGy+wS7hweudZ1EhB8q1Xk0KGTMtbfINMlJY2O7BWbH+G3mhI
         dVxA/uh+4xgGNqQ10of8Hzq1aHu4au+atcmFvz1BghYs8/oV8c629IyjInIjpP9GkQ
         VsCPc2EEqp6r992lEAHNI1PNf33d5rlxMHPGBPVTkB+tFdFt66CpqFC9RmCvb/35Bi
         cTjC/IBcMnoztMxSIQzrgWxJ+Mn8S/uwdw5Gg2CMaJiTa2FKAGAGnz7oBS1cg8RnhY
         PFz2qnVK4vksQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4+ID4+ICsJaWYgKGkyY19kZXYtPm1zZ19lcnIgPT0gSTJDX0VSUl9BUkJJVFJBVElPTl9M
T1NUKSB7DQo+PiA+PiArCQlpZiAoIWkyY19kZXYtPmlzX211bHRpbWFzdGVyX21vZGUpDQo+PiA+
PiArCQkJcmV0dXJuIHRlZ3JhX2kyY19pc3N1ZV9idXNfY2xlYXIoaTJjX2Rldik7DQo+PiA+PiAr
CQlyZXR1cm4gLUVBR0FJTjsNCj4+ID4NCj4+ID5UaGlzIGNoYW5nZXMgdGhlIHJldHVybmVkIGVy
cm5vIGZyb20gLUVJTyB0byAtRUFHQUlOIGZvciB0aGUgDQo+PiA+c3VwcG9ydHNfYnVzX2NsZWFy
PWZhbHNlIGNhc2UsIGlzIGl0IG9rYXkgYW5kIGludGVudGlvbmFsPw0KPj4gPiAgDQo+PiANCj4+
IFllcyBFQUdBSU4gaXMgaW50ZW50aW9uYWwgdG8gYWxsb3cgZm9yIHRyYW5zZmVyIHJldHJ5Lg0K
Pj4gRHVyaW5nIHNpbmdsZSBtYXN0ZXIgbW9kZSwgQVJCSVRSQVRJT04gTE9TVCBub3RpZmljYXRp
b24gaGFwcGVucyB3aGVuIA0KPj4gMS4gSTJDIE1hc3RlciBzZWVzIHRoZSBidXMgaXMgb2NjdXBp
ZWQgYnkgc29tZSBvdGhlciBkZXZpY2Ugd2hlbiBhIA0KPj4gdHJhbnNmZXIgaXMgaW5pdGlhdGVk
IDIuIEkyQyBNYXN0ZXIgbG9zdCB0aGUgYnVzIGR1cmluZyBhcmJpdHJhdGlvbiANCj4+IGluY2Fz
ZSBpZiBzbGF2ZSBkZXZpY2UgcHVsbHMgU0RBIGxpbmUgbG93IGNvbnRpbnVvdXNseSBmb3Igc29t
ZSANCj4+IHVua25vd24gcmVhc29uIElmIGFyYml0cmF0aW9uIGxvc3QgaXMgZHVlIHRvIGNhdXNl
IDEsIHJldHJ5IGhlbHBzIHRvIA0KPj4gY29udGludWUgd2l0aCB0cmFuc2ZlciBvbmNlIGJ1cyBp
cyByZWxlYXNlZCBieSB0aGUgc2xhdmUgYW5kIGl0IGp1c3QgDQo+PiBhZGRlZCBkZWxheSBpbiBj
b21tdW5pY2F0aW9uIGR1ZSB0byBidXMgcmVsZWFzZSBkZWxheSBieSBzbGF2ZS4gSW4gDQo+PiBj
YXNlIG9mIDJuZCBjYXVzZSwgcmV0cnkgbmV2ZXIgc3VjY2VlZHMgaW4gY2FzZXMgd2hlcmUgYnVz
IGNsZWFyIGlzIA0KPj4gbm90IHN1cHBvcnRlZC4NCj4NCj5JdCdzIHVuY2xlYXIgd2hldGhlciB0
aGUgIm5ldmVyIHN1Y2NlZWRzIHJldHJ5IiBtYXkgZmFpbCB3aXRoIHRoZSBFQUdBSU4sIGNhdXNp
bmcgYW4gZW5kbGVzcyByZXRyeS1sb29wLiBDb3VsZCB5b3UgcGxlYXNlIGNsYXJpZnkgdGhpcyBt
b21lbnQ/DQoNCmR1cmluZyBtYXN0ZXIgdHJhbnNtaXQgbW9kZSwgb24gYXJiaXRyYXRpb24gbG9z
dCBhbmQgaWYgbWFzdGVyIGRvZXNu4oCZdCBzdXBwb3J0IGJ1cyBjbGVhciB0byByZWNvdmVyIHRo
ZW4gdHJhbnNmZXIgd2lsbCByZXR1cm4gRUFHQUlOLg0KSTJjIGNvcmUgYmFzZSBkcml2ZXIgcGVy
Zm9ybXMgcmV0cmllcyBpZiByZXR1cm4gY29kZSBmcm9tIGkyY190cmFuc2ZlciBpcyBFQUdBSU4g
dXAgdG8gc3BlY2lmaWVkIHJldHJpZXMgaW4gaTJjIGFkYXB0ZXIgYW5kIHJldHVybnMgdGhlIHJl
dCBjb2RlIGZyb20gdGhlIGxhc3QgcmV0cnkuDQpSZXRyeSBpcyBub3QgZW5kbGVzcyBhcyBpMmMg
Y29yZSBiYXNlIHBlcmZvcm1zIHJldHJ5IG9ubHkgdXAgdG8gc3BlY2lmaWVkIGFkYXB0ZXIgcmV0
cmllcy4NCkZvbGxvd2luZyByZXR1cm4gY29kZSBmcm9tIGRvY3VtZW50YXRpb24NCmh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL0RvY3VtZW50YXRpb24vaTJjL2ZhdWx0LWNvZGVzDQoNCg0K
