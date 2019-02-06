Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA476C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC9E217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H05N2/nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbfBFNv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:51:26 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:29786 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfBFNvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:51:25 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ae6570000>; Wed, 06 Feb 2019 21:51:19 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 05:51:17 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 06 Feb 2019 05:51:17 -0800
Received: from DRBGMAIL104.nvidia.com (10.18.16.23) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:51:16 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by DRBGMAIL104.nvidia.com
 (10.18.16.23) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:51:15 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.55) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 13:51:15 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3271.namprd12.prod.outlook.com (20.179.93.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.22; Wed, 6 Feb 2019 13:51:12 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:51:12 +0000
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
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAUt4CAAAEfAIAAAXOAgAAAhsCAAAYqgIAAADAAgAACQDA=
Date:   Wed, 6 Feb 2019 13:51:12 +0000
Message-ID: <BYAPR12MB33989329D0E0C0049F1DEA6EC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
 <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
 <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3271;6:O1n61v4SYqxTtV8Yh5ieaHQDSCbTHLeE8IkO1rOniFZEtMHBrnXF45YwBuYGuf8mP+GrG8d2DvzNWJbiwdHtHWP/WLw0KRjvngx4sZKe8dYZl+UjSqSq38jK04byBGICB/WMn8n3r4ehgSvVJJZajmVIXZ3viP9mMoPMumm9WXExD4Hk/ONhRD1Z08yM55MsvvCj0n0Ar4QiH73+uY+WhlRcas13JPvNImgOJn7wzLa8JQc0DVKWd5AWzroyFg1b1fAabmjo4WVvOKzdASLLnszsSlJ+4q+874dYbG9SNCs7cM9zE3Pkcj52ny3IkdhwIOHMPk6L2uUP6JzVbPEgBXbFPFYJYRgmbYAnNb7d2oNKaJJvm/8KoUWopN2t8r1bI+4ne6T1r6rLsct9RdugoTeYg9+RmNi/jnyr4bOj3QUxnyyEMrhh6kh1rBfPYNbci0QElZ8gNKdNaFXjsCVHpw==;5:hT3o8foFoIjR/AQjKFBtmcpHJ9v6ZaHRtS8cghAgHNE/kF/mp9q82S0lp+othvcrVE8jqT0TGMpSKi+CjijNLZKes403FVuRahoStBEC6gkrNnHtB6NrNPAlhkNf26kJYAG2cFK7n2m8Dt5q8VwuTxpkeejDDIzV8Vs+sD6whPPDSTnHf5Sise5XmjX/xamj+HeBiSk0x6GoDOUA+0MyBA==;7:pn9ccGvDkPrSXbsKcMcB8d37TFHIiL4eR0HRGS3WuUjBfNMQT6ABTSHGrQijnNrOa6Q7q5vRDwHSFgV4KnT6UcmcoFgTl2B8hRY9zoLIgPHrOY9aDZW3+MwTxg1SwHDMeBTnDPZ2odQg5445EBjDWQ==
x-ms-office365-filtering-correlation-id: 67f02e63-e0e1-4b45-5203-08d68c3a27fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3271;
x-ms-traffictypediagnostic: BYAPR12MB3271:
x-microsoft-antispam-prvs: <BYAPR12MB3271F854C0918F568281CB62C26F0@BYAPR12MB3271.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(8676002)(476003)(6436002)(81166006)(71200400001)(26005)(256004)(4326008)(76176011)(186003)(71190400001)(6116002)(55016002)(9686003)(7736002)(99286004)(68736007)(2906002)(486006)(3846002)(305945005)(97736004)(7696005)(93886005)(14454004)(25786009)(229853002)(316002)(110136005)(93156006)(446003)(33656002)(86362001)(54906003)(102836004)(478600001)(106356001)(6506007)(74316002)(66066001)(6246003)(11346002)(8936002)(105586002)(81156014)(53936002)(2940100002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3271;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EgSZdub13UR/fp15wv0q6WGhb96YkK86L6IwNAfuOshk/6h6QGOBzvAU7gciclAwY1mFiB5xG6uRXtZw6LxHDyiCnIP9XtO8SKeLN3f4bID6obEM/Fg2pMG6jPO5vF/XN0pP5ICrWpbRQFyDw1VcWZG1FtNIL06zrdbHBxH3BPzwyRlSKsW4Qd8mBdTGIpqlPvcElgob6r91jmmcuhf7JQ/X1+t/uf875FOYY/GUpeAPIddw3OIZUY3g0XBzi5T5chhEOopW9LuYjI2HZxwJRkZ8JCt/ja/ZJS/bT20xBvb7377rWUg5fmCeXC7n95jT2938sOt+HIUJAhk0QPzNDM33rjWiNp5t9bTbYpBm1HQXHgcpZqWkwQCHUpAkkLKyAeRBIBRHVWFGzPCFIA6+t/sHrrYuluiRNQcATtKD7Po=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 67f02e63-e0e1-4b45-5203-08d68c3a27fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:51:12.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549461079; bh=vG2m3rEVPMJGaA2Iv5OM//kzVSr5pO87Ig0c05PCw0o=;
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
        b=H05N2/nQfI1Al/GAP8MCfXslYLJBoDlpQIzhaSvcS9hyEHYfXV59YT+ehomy6EOXw
         dZRDk8qMIZ9qGpFQ+XOgZVRXj6RwqpChd45tzesWag8EDbDh7wIy6cy7reoEP6QZ8v
         DU2skapwz7QTwHnr/rX5y0cWiLWm/rq61s5CdBDopyhxbcl2wceJB2jbvkxsED5H9r
         egP2qoKwk2kVw01gkCj+sAAgJXHTZ+zlpA9J5q77TOOPaq/DFK9BEgo12rYYiJ9FHN
         IZ9l5ZLBApxpOp9UWeGJGCI8Bx0IqUjwrKvR5v6AMgxhwn3yXLYBMPoWjv2qMQmMkh
         C0fjPSmxY3LAg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4+Pj4gVGhhdCdzIG9kZCBiZWNhdXNlIGl0IHN1Z2dlc3RzIHRoYXQgRE1BIGFjdHVhbGx5
IGNvbXBsZXRlZCwgYnV0IA0KPiA+Pj4+IHRoZSBtZXNzYWdlIGRpZG4ndC4NCj4gPj4+Pg0KPiA+
Pj4+IEknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgaG93IHRoYXQgY291bGQgaGFwcGVuLg0KPiA+
Pj4+DQo+ID4+Pj4gV2hhdCdzIGFsc28gd2VpcmQgYWJvdmUgaXMgdGhhdCB0aGVyZSBkb2Vzbid0
IHNlZW0gdG8gYmUgYSBETUEgDQo+ID4+Pj4gdGhhdCBpcyBzdGFydGVkIGZvciB0aGF0IHBhcnRp
Y3VsYXIgbWVzc2FnZS4gT3IgaXMgdGhlIHRpbWVvdXQgDQo+ID4+Pj4gbWVzc2FnZSBhIHJlc3Bv
bnNlIHRvIHRoZSBwcmlvciB0cmFuc2ZlciAobGVuZ3RoIDEwKT8gU2VlbXMgbGlrZSANCj4gPj4+
PiB0aGF0IHNob3VsZCBub3QgYmUgcG9zc2libGUgYmVjYXVzZSB3ZSBnZXQgdGhlICJ0cmFuc2Zl
ciBjb21wbGV0ZSIgbWVzc2FnZS4NCj4gPj4+DQo+ID4+PiBXYWl0LCB0aG9zZSBhcmUgYWN0dWFs
bHkgZGlmZmVyZW50IGluc3RhbmNlcyBvZiB0aGUgSTJDIA0KPiA+Pj4gY29udHJvbGxlciwgc28g
dGhlIHJlbGV2YW50IGxvZyBlbnRyaWVzIGFyZSB0aGVzZToNCj4gPj4+DQo+ID4+PiAJWyAgICAw
Ljk0NTQ0NV0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6
IDE2DQo+ID4+PiAJWyAgICAwLjk0NTQ1Nl0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogdW5tYXNr
ZWQgaXJxOiAwYw0KPiA+Pj4gCS4uLg0KPiA+Pj4gCVsgICAgMS4wNDkyMjRdIHRlZ3JhLWkyYyA3
MDAwZDAwMC5pMmM6IGkyYyB0cmFuc2ZlciB0aW1lZCBvdXQNCj4gPj4+DQo+ID4+PiBBbmQgdGhl
c2UgZG9uJ3QgaGFwcGVuIGlmIHlvdSB1c2UgaGlnaGVyIGJ1cnN0IHNpemVzIG9yIGJlZm9yZSB0
aGUgDQo+ID4+PiBETUEgc2VyaWVzPw0KPiA+Pg0KPiA+PiBJIHRyaWVkIHRvIGVuZm9yY2UgRE1B
IHdpdGhvdXQgY2hhbmdpbmcgYnVyc3RzOg0KPiA+Pg0KPiA+PiAtLS0tLS0tLS0tDQo+ID4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMgDQo+ID4+IGIvZHJpdmVy
cy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIGluZGV4IGM1MzhlZDVmOGUyYy4uNWQxYzU0Y2U3ODAw
DQo+ID4+IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMN
Cj4gPj4gKysrIGIvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+ID4+IEBAIC02LDYg
KzYsOCBAQA0KPiA+PiAgICogQXV0aG9yOiBDb2xpbiBDcm9zcyA8Y2Nyb3NzQGFuZHJvaWQuY29t
Pg0KPiA+PiAgICovDQo+ID4+ICANCj4gPj4gKyNkZWZpbmUgREVCVUcNCj4gPj4gKw0KPiA+PiAg
I2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+PiAgI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+DQo+
ID4+ICAjaW5jbHVkZSA8bGludXgvZG1hZW5naW5lLmg+DQo+ID4+IEBAIC0xMDQ2LDggKzEwNDgs
NyBAQCBzdGF0aWMgaW50IHRlZ3JhX2kyY194ZmVyX21zZyhzdHJ1Y3QgdGVncmFfaTJjX2RldiAq
aTJjX2RldiwNCj4gPj4gICAgICAgICAgICAgICAgIHhmZXJfc2l6ZSA9IG1zZy0+bGVuICsgSTJD
X1BBQ0tFVF9IRUFERVJfU0laRTsNCj4gPj4gIA0KPiA+PiAgICAgICAgIHhmZXJfc2l6ZSA9IEFM
SUdOKHhmZXJfc2l6ZSwgQllURVNfUEVSX0ZJRk9fV09SRCk7DQo+ID4+IC0gICAgICAgaTJjX2Rl
di0+aXNfY3Vycl9kbWFfeGZlciA9ICh4ZmVyX3NpemUgPiBJMkNfUElPX01PREVfTUFYX0xFTikg
JiYNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaTJjX2Rldi0+ZG1h
X2J1ZjsNCj4gPj4gKyAgICAgICBpMmNfZGV2LT5pc19jdXJyX2RtYV94ZmVyID0gISFpMmNfZGV2
LT5kbWFfYnVmOw0KPiA+PiAgICAgICAgIHRlZ3JhX2kyY19jb25maWdfZmlmb190cmlnKGkyY19k
ZXYsIHhmZXJfc2l6ZSk7DQo+ID4+ICAgICAgICAgZG1hID0gaTJjX2Rldi0+aXNfY3Vycl9kbWFf
eGZlcjsNCj4gPj4gLS0tLS0tLS0tLQ0KPiA+Pg0KPiA+PiBIZXJlIGlzIHRoZSBsb2cgd2l0aCB0
aGlzIGNoYW5nZToNCj4gPj4NCj4gPj4gWyAgICAwLjc2MDc5Nl0gdGVncmFfcnRjIDcwMDBlMDAw
LnJ0YzogcmVnaXN0ZXJlZCBhcyBydGMxDQo+ID4+IFsgICAgMC43NjA4NTBdIHRlZ3JhX3J0YyA3
MDAwZTAwMC5ydGM6IFRlZ3JhIGludGVybmFsIFJlYWwgVGltZSBDbG9jaw0KPiA+PiBbICAgIDAu
NzYxMDUwXSBpMmMgL2RldiBlbnRyaWVzIGRyaXZlcg0KPiA+PiBbICAgIDAuOTE4OTI4XSB0ZWdy
YS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYNCj4gPj4gWyAg
ICAwLjkxODk0MF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+
PiBbICAgIDAuOTE5MDQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0
ZTogMTAgMCAwDQo+ID4+IFsgICAgMC45MTkwNTBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0
YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiA4DQo+ID4+IFsgICAgMC45MTkwNTldIHRlZ3JhLWkyYyA3
MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPj4gWyAgICAwLjkxOTMyMl0gdGVncmEt
aTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0KPiA+PiBbICAgIDAu
OTE5MzM1XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDog
MTYNCj4gPj4gWyAgICAwLjkxOTM0M10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQg
aXJxOiAwYw0KPiA+PiBbICAgIDAuOTE5NDQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFu
c2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMC45MTk0NDhdIHRlZ3JhLWkyYyA3MDAw
YzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxMTINCj4gPj4gWyAgICAwLjkxOTQ1
Nl0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+PiBbICAgIDAu
OTIyODE4XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTEgMCAw
DQo+ID4+IFsgICAgMC45MjI4MjldIGF0bWVsX214dF90cyAwLTAwNGM6IEZhbWlseTogMTYwIFZh
cmlhbnQ6IDAgRmlybXdhcmUgVjEuMC5BQSBPYmplY3RzOiAxOA0KPiA+PiBbICAgIDAuOTIyODg2
XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYNCj4g
Pj4gWyAgICAwLjkyMjg5NV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAw
Yw0KPiA+PiBbICAgIDAuOTIyOTkzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBj
b21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMC45MjMwMDJdIHRlZ3JhLWkyYyA3MDAwYzAwMC5p
MmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAyMjQNCj4gPj4gWyAgICAwLjkyMzAxMV0gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+PiBbICAgIDAuOTMzMjUz
XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTEgMCAwDQo+ID4+
IFsgICAgMC45MzMyODddIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3Ig
bGVuZ3RoOiAxNg0KPiA+PiBbICAgIDAuOTMzMjk3XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1
bm1hc2tlZCBpcnE6IDBjDQo+ID4+IFsgICAgMC45MzM0NzhdIHRlZ3JhLWkyYyA3MDAwYzAwMC5p
MmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDANCj4gPj4gWyAgICAwLjkzMzQ4N10gdGVncmEt
aTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDEyDQo+ID4+IFsgICAg
MC45MzM0OTZdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPj4g
WyAgICAwLjk0NTEyMF0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBs
ZW5ndGg6IDE2DQo+ID4+IFsgICAgMC45NDUxMzBdIHRlZ3JhLWkyYyA3MDAwZDAwMC5pMmM6IHVu
bWFza2VkIGlycTogMGMNCj4gPj4gWyAgICAxLjAzODkxN10gdGVncmEtaTJjIDcwMDBjMDAwLmky
YzogRE1BIHRyYW5zZmVyIHRpbWVvdXQNCj4gPj4gWyAgICAxLjAzODk4Ml0gYXRtZWxfbXh0X3Rz
IDAtMDA0YzogX19teHRfcmVhZF9yZWc6IGkyYyB0cmFuc2ZlciBmYWlsZWQgKC0xMTApDQo+ID4+
IFsgICAgMS4wMzkwMDBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3Ig
bGVuZ3RoOiAxNg0KPiA+PiBbICAgIDEuMDM5MDA2XSBhdG1lbF9teHRfdHMgMC0wMDRjOiBGYWls
ZWQgdG8gcmVhZCBUNDQgYW5kIFQ1ICgtMTEwKQ0KDQoNCg0KPiA+PiBbICAgIDEuMDM5MDA5XSB0
ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4+IFsgICAgMS4wMzkx
NDhdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDANCj4g
Pj4gWyAgICAxLjAzOTE1N10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZv
ciBsZW5ndGg6IDQNCj4gPj4gWyAgICAxLjAzOTE2Nl0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzog
dW5tYXNrZWQgaXJxOiAwYw0KPiA+PiBbICAgIDEuMDM5MzA0XSB0ZWdyYS1pMmMgNzAwMGMwMDAu
aTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMS4wMzkzNDBdIHRlZ3Jh
LWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxNg0KPiA+PiBbICAg
IDEuMDM5MzQ5XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4+
IFsgICAgMS4wMzk1MzVdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRl
OiAxMCAwIDANCj4gPj4gWyAgICAxLjAzOTU0NF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3Rh
cnRpbmcgRE1BIGZvciBsZW5ndGg6IDEyDQo+ID4+IFsgICAgMS4wMzk1NTJdIHRlZ3JhLWkyYyA3
MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPj4gWyAgICAxLjA0MDA1NV0gdGVncmEt
aTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0KPiA+PiBbICAgIDEu
MDQwMDgzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDog
MTYNCj4gPj4gWyAgICAxLjA0MDA5Ml0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQg
aXJxOiAwYw0KPiA+PiBbICAgIDEuMDQwMzAxXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFu
c2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4+IFsgICAgMS4wNDg5MzRdIHRlZ3JhLWkyYyA3MDAw
ZDAwMC5pMmM6IGkyYyB0cmFuc2ZlciB0aW1lZCBvdXQNCj4gPiANCj4gPiBUaGlzIGxvZyBzaG93
cyBETUEgdHJhbnNmZXIgdGltZW91dCBmb3IgYXRtZWwgcmVhZC4NCj4gPiBEbyB5b3Ugc2VlIGlz
c3VlIGlmIHlvdSBkb27igJl0IGVuZm9yY2UgZG1hIGFsbCB0aW1lIGFuZCBsZXQgaXQgY2hvb3Nl
IFBJTyBWcyBETUE/DQo+ID4gDQo+IA0KPiBObywgdGhlcmUgYXJlIG5vIHRpbWVvdXQgZXJyb3Jz
IGluIFBJTyBtb2RlLiBJIGNvdWxkIHBvc3QgZnVsbCBsb2cgd2l0aCB0aGUgUElPLW9ubHkgbW9k
ZSBpZiB5b3Ugd2FudC4NCj4NClllcyBwbGVhc2UgcG9zdCBmdWxsIGxvZyBvZiBQSU8gb25seSBh
bmQgRE1BIG9ubHkNCkFsc28sIGluIGFib3ZlIGxvZywgbG90cyBvZiBETUEgdHJhbnNmZXIgd2Vu
dCB0aHJ1IGZpbmUgZXhjZXB0IHRoaXMgb25lIHRyYW5zZmVyIHdoZXJlIERNQSB0aW1lZCBvdXQu
DQpETUEgY29tcGxldGlvbiBkb2VzbnQgaGFwcGVuIG9uIERNQSBzdWJtaXQgZHVyaW5nIHRoaXMg
cGFydGljdWxhciB0cmFuc2FjdGlvbiB0aW1lZnJhbWUgZm9yIHNvbWUgcmVhc29uLg0K
