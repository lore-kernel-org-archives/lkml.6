Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AB5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B161F20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="euxiKZ6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730900AbfBFNZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:25:25 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2478 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbfBFNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:25:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ae0340000>; Wed, 06 Feb 2019 05:25:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 05:25:21 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 05:25:21 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:25:20 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 13:25:20 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3350.namprd12.prod.outlook.com (20.178.55.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 13:25:18 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:25:18 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAUt4CAAAEfAIAAAXOAgAAAhsA=
Date:   Wed, 6 Feb 2019 13:25:17 +0000
Message-ID: <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
In-Reply-To: <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3350;6:Pr9RKHW+fIclzI1g8eRMRHdqJftmujG3SrYKoxT4uSmVvBsE6yKiYgCJ3i0w+vsj0zlU2R43d8Y3EZ1VGC3oemDY++yGZcDytEWIiEqNFM6PHL6vFp37PAdtoCAccAhBMpEbBloRRkNXYOLB4bN0mKd5Abq0yHGGJ7dDqS0GsxXUNlhzKG42KvWX1VUsuyYPO4vanjxQAkcOMeGINb0ZlPnVvlJ2tWG8uNV1pni9FnYB3WhuHI2k4Y5sUqHx+PXdFjohgtk70+s/cy5ptpCxCFb6hosa4ufuhoZfekBU5DwRhdgcB0UFgdMTwkuajPinHPl0yTgAZFMlH3SKi/+cojzjPqTuXVSMMLyt4hJQm3VM/wtQ2TMQLw9YUvN24TztkQ+zsSpNlu6ByVLqmo+hgiUM31lq7+s6ZgBmZi+fEAekoJQJnayeaPXRXc+7cb1Kh99noGlGGwtiGiSDxmAvFA==;5:HLWZx0Gf2XcPznRhovJmkILxq6+sRav2ehZmM+Ipi+mo1WM8xVHJpDfaB8tnhvfkNzy6UQPgBK4Trqk9DzjtC3LYxlLRw7x4BCVJN4GO/uufIHT04kHZDiN3UV/ljaftsSZoxeeO/4RgwvVF1k42sdAVndiQcJqJut1eOVWGAtT79FSlg0OqYHjxCFFHq1CMS8IlZ9XdiJ+N3OlRAhSIiw==;7:VrpFYIGtwxUOxjE7schQeFeVceZMDZ6Oxx8dTd8rNS/8eYsCUStrXBBc50yi0YyGWtMPpKIF0pLu7S878fT8gHSHViTgHQ0Q2SGCUhlWeslHAtVN+R3TIS0WvmrgfunqgK7TjLtJoLjQeREG7TvaLg==
x-ms-office365-filtering-correlation-id: 90cd6ace-d2a4-4ba2-beef-08d68c368961
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3350;
x-ms-traffictypediagnostic: BYAPR12MB3350:
x-microsoft-antispam-prvs: <BYAPR12MB3350D32E2E2024030793C8A1C26F0@BYAPR12MB3350.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(376002)(346002)(199004)(189003)(55016002)(186003)(4326008)(76176011)(81156014)(9686003)(478600001)(99286004)(81166006)(106356001)(66066001)(68736007)(74316002)(256004)(93886005)(6246003)(97736004)(26005)(6436002)(2906002)(8936002)(476003)(486006)(8676002)(316002)(11346002)(446003)(102836004)(305945005)(86362001)(6506007)(53936002)(7736002)(54906003)(6116002)(71200400001)(229853002)(33656002)(14454004)(105586002)(25786009)(110136005)(3846002)(7696005)(71190400001)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3350;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j44lGWZhDtXIlgZ28y/LdrAATRIyrdGRVwxbilWsLr/tJ2EO/OoMTAUrqX6AxhsWuAtQxXogSk524gTsm/tcnsr4RmrDgEAoP/2Jq0XwYtt0ClRU+65EFPihMPwAbfDg/7mmrjmMOkJEnYvw8QmtdUh9dvho4ks9cq2CE7K8c7Eao+cUBaaQzwkxAYhA2aWCNNGgZZQCMc0wcAaG49h8UwqI2dwNy3XGb0+N89nJRUqrF4LyT5QlfT599S022xfKJ4awwOiaJoTx3EN9aFqsy0+QWLn32ktnpNNifIcjujBx7aklc93VUAmW90yoaiv9O65WyR/OYADrxwk2oZ2wV2nd6NJjbzRliRtifu1FBmhhhS1e7rJR9NEYSeguBcUCsCy35mnH/wpZiO2AIW/SBTK3dv7GrkGq/87w3GYyGUM=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cd6ace-d2a4-4ba2-beef-08d68c368961
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:25:17.8689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3350
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549459508; bh=SKi+nZ8Usp3ebeJSr1eWaBJexgkeQZY3e4f2gWplW0k=;
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
        b=euxiKZ6UI4B9DaROa1uV3UYhX8pdqXZn+dKTNC2HzSM9tReDRLgosdQUpU2Ysfb0f
         +zD6zYedVIW8wc+B5HiNacSuuBTOz6nX1Z+tkC/Ml9YOkQIMncfcplMroHfQklGqjj
         EAkopYGmlWkkSeJYv7rXRneCiTVzT9Xmv9Ea3bnYJ+TJNvEe799Fwbs/FcW45kU7/g
         deE6uGwJZVJRwDvg4MCOQiGkr3VAV5Pyf6ZhQreDE11NvIKBFy6uK0uP8IfAlbPGJP
         CORIzx4Se6ixb2v8RZ7MzcbdAEZpJycdY4BZe1A4plbfDS35XNPZVtvdRR/MB3Wbcl
         K2Ixe7i/1EBBw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4gVGhhdCdzIG9kZCBiZWNhdXNlIGl0IHN1Z2dlc3RzIHRoYXQgRE1BIGFjdHVhbGx5
IGNvbXBsZXRlZCwgYnV0IHRoZSANCj4gPj4gbWVzc2FnZSBkaWRuJ3QuDQo+ID4+DQo+ID4+IEkn
bSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgaG93IHRoYXQgY291bGQgaGFwcGVuLg0KPiA+Pg0KPiA+
PiBXaGF0J3MgYWxzbyB3ZWlyZCBhYm92ZSBpcyB0aGF0IHRoZXJlIGRvZXNuJ3Qgc2VlbSB0byBi
ZSBhIERNQSB0aGF0IA0KPiA+PiBpcyBzdGFydGVkIGZvciB0aGF0IHBhcnRpY3VsYXIgbWVzc2Fn
ZS4gT3IgaXMgdGhlIHRpbWVvdXQgbWVzc2FnZSBhIA0KPiA+PiByZXNwb25zZSB0byB0aGUgcHJp
b3IgdHJhbnNmZXIgKGxlbmd0aCAxMCk/IFNlZW1zIGxpa2UgdGhhdCBzaG91bGQgDQo+ID4+IG5v
dCBiZSBwb3NzaWJsZSBiZWNhdXNlIHdlIGdldCB0aGUgInRyYW5zZmVyIGNvbXBsZXRlIiBtZXNz
YWdlLg0KPiA+IA0KPiA+IFdhaXQsIHRob3NlIGFyZSBhY3R1YWxseSBkaWZmZXJlbnQgaW5zdGFu
Y2VzIG9mIHRoZSBJMkMgY29udHJvbGxlciwgc28gDQo+ID4gdGhlIHJlbGV2YW50IGxvZyBlbnRy
aWVzIGFyZSB0aGVzZToNCj4gPiANCj4gPiAJWyAgICAwLjk0NTQ0NV0gdGVncmEtaTJjIDcwMDBk
MDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDE2DQo+ID4gCVsgICAgMC45NDU0NTZd
IHRlZ3JhLWkyYyA3MDAwZDAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPiAJLi4uDQo+ID4g
CVsgICAgMS4wNDkyMjRdIHRlZ3JhLWkyYyA3MDAwZDAwMC5pMmM6IGkyYyB0cmFuc2ZlciB0aW1l
ZCBvdXQNCj4gPiANCj4gPiBBbmQgdGhlc2UgZG9uJ3QgaGFwcGVuIGlmIHlvdSB1c2UgaGlnaGVy
IGJ1cnN0IHNpemVzIG9yIGJlZm9yZSB0aGUgRE1BIA0KPiA+IHNlcmllcz8NCj4NCj4gSSB0cmll
ZCB0byBlbmZvcmNlIERNQSB3aXRob3V0IGNoYW5naW5nIGJ1cnN0czoNCj4NCj4gLS0tLS0tLS0t
LQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIGluZGV4IGM1MzhlZDVmOGUyYy4uNWQxYzU0Y2U3ODAw
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4gKysrIGIv
ZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+IEBAIC02LDYgKzYsOCBAQA0KPiAgICog
QXV0aG9yOiBDb2xpbiBDcm9zcyA8Y2Nyb3NzQGFuZHJvaWQuY29tPg0KPiAgICovDQo+ICANCj4g
KyNkZWZpbmUgREVCVUcNCj4gKw0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiAgI2luY2x1
ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvZG1hZW5naW5lLmg+DQo+IEBA
IC0xMDQ2LDggKzEwNDgsNyBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY194ZmVyX21zZyhzdHJ1Y3Qg
dGVncmFfaTJjX2RldiAqaTJjX2RldiwNCj4gICAgICAgICAgICAgICAgIHhmZXJfc2l6ZSA9IG1z
Zy0+bGVuICsgSTJDX1BBQ0tFVF9IRUFERVJfU0laRTsNCj4gIA0KPiAgICAgICAgIHhmZXJfc2l6
ZSA9IEFMSUdOKHhmZXJfc2l6ZSwgQllURVNfUEVSX0ZJRk9fV09SRCk7DQo+IC0gICAgICAgaTJj
X2Rldi0+aXNfY3Vycl9kbWFfeGZlciA9ICh4ZmVyX3NpemUgPiBJMkNfUElPX01PREVfTUFYX0xF
TikgJiYNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaTJjX2Rldi0+ZG1h
X2J1ZjsNCj4gKyAgICAgICBpMmNfZGV2LT5pc19jdXJyX2RtYV94ZmVyID0gISFpMmNfZGV2LT5k
bWFfYnVmOw0KPiAgICAgICAgIHRlZ3JhX2kyY19jb25maWdfZmlmb190cmlnKGkyY19kZXYsIHhm
ZXJfc2l6ZSk7DQo+ICAgICAgICAgZG1hID0gaTJjX2Rldi0+aXNfY3Vycl9kbWFfeGZlcjsNCj4g
LS0tLS0tLS0tLQ0KPg0KPiBIZXJlIGlzIHRoZSBsb2cgd2l0aCB0aGlzIGNoYW5nZToNCj4NCj4g
WyAgICAwLjc2MDc5Nl0gdGVncmFfcnRjIDcwMDBlMDAwLnJ0YzogcmVnaXN0ZXJlZCBhcyBydGMx
DQo+IFsgICAgMC43NjA4NTBdIHRlZ3JhX3J0YyA3MDAwZTAwMC5ydGM6IFRlZ3JhIGludGVybmFs
IFJlYWwgVGltZSBDbG9jaw0KPiBbICAgIDAuNzYxMDUwXSBpMmMgL2RldiBlbnRyaWVzIGRyaXZl
cg0KPiBbICAgIDAuOTE4OTI4XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEg
Zm9yIGxlbmd0aDogMTYNCj4gWyAgICAwLjkxODk0MF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzog
dW5tYXNrZWQgaXJxOiAwYw0KPiBbICAgIDAuOTE5MDQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJj
OiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+IFsgICAgMC45MTkwNTBdIHRlZ3JhLWkyYyA3
MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiA4DQo+IFsgICAgMC45MTkwNTld
IHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gWyAgICAwLjkxOTMy
Ml0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0KPiBb
ICAgIDAuOTE5MzM1XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxl
bmd0aDogMTYNCj4gWyAgICAwLjkxOTM0M10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNr
ZWQgaXJxOiAwYw0KPiBbICAgIDAuOTE5NDQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFu
c2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+IFsgICAgMC45MTk0NDhdIHRlZ3JhLWkyYyA3MDAwYzAw
MC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxMTINCj4gWyAgICAwLjkxOTQ1Nl0gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiBbICAgIDAuOTIyODE4XSB0
ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTEgMCAwDQo+IFsgICAg
MC45MjI4MjldIGF0bWVsX214dF90cyAwLTAwNGM6IEZhbWlseTogMTYwIFZhcmlhbnQ6IDAgRmly
bXdhcmUgVjEuMC5BQSBPYmplY3RzOiAxOA0KPiBbICAgIDAuOTIyODg2XSB0ZWdyYS1pMmMgNzAw
MGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYNCj4gWyAgICAwLjkyMjg5NV0g
dGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiBbICAgIDAuOTIyOTkz
XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+IFsg
ICAgMC45MjMwMDJdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVu
Z3RoOiAyMjQNCj4gWyAgICAwLjkyMzAxMV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNr
ZWQgaXJxOiAwYw0KPiBbICAgIDAuOTMzMjUzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFu
c2ZlciBjb21wbGV0ZTogMTEgMCAwDQo+IFsgICAgMC45MzMyODddIHRlZ3JhLWkyYyA3MDAwYzAw
MC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxNg0KPiBbICAgIDAuOTMzMjk3XSB0ZWdy
YS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+IFsgICAgMC45MzM0NzhdIHRl
Z3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDANCj4gWyAgICAw
LjkzMzQ4N10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6
IDEyDQo+IFsgICAgMC45MzM0OTZdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGly
cTogMGMNCj4gWyAgICAwLjk0NTEyMF0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogc3RhcnRpbmcg
RE1BIGZvciBsZW5ndGg6IDE2DQo+IFsgICAgMC45NDUxMzBdIHRlZ3JhLWkyYyA3MDAwZDAwMC5p
MmM6IHVubWFza2VkIGlycTogMGMNCj4gWyAgICAxLjAzODkxN10gdGVncmEtaTJjIDcwMDBjMDAw
LmkyYzogRE1BIHRyYW5zZmVyIHRpbWVvdXQNCj4gWyAgICAxLjAzODk4Ml0gYXRtZWxfbXh0X3Rz
IDAtMDA0YzogX19teHRfcmVhZF9yZWc6IGkyYyB0cmFuc2ZlciBmYWlsZWQgKC0xMTApDQo+IFsg
ICAgMS4wMzkwMDBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVu
Z3RoOiAxNg0KPiBbICAgIDEuMDM5MDA2XSBhdG1lbF9teHRfdHMgMC0wMDRjOiBGYWlsZWQgdG8g
cmVhZCBUNDQgYW5kIFQ1ICgtMTEwKQ0KPiBbICAgIDEuMDM5MDA5XSB0ZWdyYS1pMmMgNzAwMGMw
MDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+IFsgICAgMS4wMzkxNDhdIHRlZ3JhLWkyYyA3MDAw
YzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDANCj4gWyAgICAxLjAzOTE1N10gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDQNCj4gWyAgICAx
LjAzOTE2Nl0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiBbICAg
IDEuMDM5MzA0XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAg
MCAwDQo+IFsgICAgMS4wMzkzNDBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERN
QSBmb3IgbGVuZ3RoOiAxNg0KPiBbICAgIDEuMDM5MzQ5XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJj
OiB1bm1hc2tlZCBpcnE6IDBjDQo+IFsgICAgMS4wMzk1MzVdIHRlZ3JhLWkyYyA3MDAwYzAwMC5p
MmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDANCj4gWyAgICAxLjAzOTU0NF0gdGVncmEtaTJj
IDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDEyDQo+IFsgICAgMS4wMzk1
NTJdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gWyAgICAxLjA0
MDA1NV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0K
PiBbICAgIDEuMDQwMDgzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9y
IGxlbmd0aDogMTYNCj4gWyAgICAxLjA0MDA5Ml0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5t
YXNrZWQgaXJxOiAwYw0KPiBbICAgIDEuMDQwMzAxXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0
cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+IFsgICAgMS4wNDg5MzRdIHRlZ3JhLWkyYyA3MDAw
ZDAwMC5pMmM6IGkyYyB0cmFuc2ZlciB0aW1lZCBvdXQNCg0KVGhpcyBsb2cgc2hvd3MgRE1BIHRy
YW5zZmVyIHRpbWVvdXQgZm9yIGF0bWVsIHJlYWQuDQpEbyB5b3Ugc2VlIGlzc3VlIGlmIHlvdSBk
b27igJl0IGVuZm9yY2UgZG1hIGFsbCB0aW1lIGFuZCBsZXQgaXQgY2hvb3NlIFBJTyBWcyBETUE/
DQo=
