Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BEEC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345CD20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bYz2QxA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfBFOKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:10:17 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7380 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfBFOKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:10:16 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5aeaa80000>; Wed, 06 Feb 2019 06:09:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 06:10:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 06 Feb 2019 06:10:15 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 14:10:14 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 14:10:14 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3461.namprd12.prod.outlook.com (20.178.196.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 14:10:13 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 14:10:13 +0000
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
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAUt4CAAAEfAIAAAXOAgAAAhsCAAAYqgIAAADAAgAACQDCAAAL7gIAAAlYw
Date:   Wed, 6 Feb 2019 14:10:13 +0000
Message-ID: <BYAPR12MB339834E29DAC1054F46AB58CC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo> <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
 <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
 <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33989329D0E0C0049F1DEA6EC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <20190206140141.GO21676@ulmo>
In-Reply-To: <20190206140141.GO21676@ulmo>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3461;6:eP5A2/8ei4eVwybMlnqkdMb25qLGE/aPw2nnLI6Q+ZKRUOL+RQh8vAX3qe73BDnUbhEZtji0WVyz+LpxxW3X7Hdoz/jjPCjumw9NIqa7iy8tfdR4mjAH8T2G0aaToDuKFPFiREOXioUdPofuA/33OnK/3CibtR+f8RI6ARVDbpuqnvFT9SaXUIdI80W9pBATP4ABIy0lpVpaIn/HQVGGfoYgtPp/98JhA6JXyv8gVB+txIKr5uMl3+arPLPbwz6TM66MlCQRoKRBuW01XT5Z9be90bePiUeIN982jfGAe7w0nx9141aKLqifn1L1CQ8DgMX9pl8S3ABPLiWxy/2D0B5Zgwnnnbw/AZssh/p2v4MqAaxZ7juNjchxFDGvpKc0SiOQjvOdZXRANZuKM1AN+n0ER4pLhBIMXw3OH/yYbCPHT5Tk6+OuPnqPlz/3kKkLndfmOosniSkSkshefTZJqw==;5:Sev8od2O+iCy1tXNMzTsmWXbxGNkyVFnBk93NU7D+mtaYWzxP8N9bG+F2o5T2Vmf3+udRv3p2J6fBxfWr65pYrFyQzs0d54zG5UI76k584rJFhNBOhlOnaiynghd4lDm3ckFhKs5+4Ojd6qVzvRi5S4tdxBrzcnZAY3pceGD9iTxicZF87MPzx63hUHdOR/XjHSNnxemrHi9fiMqzN+7sw==;7:gG1cCzXsZ+ETkxo1lWyyTkqETEMKZeF87OUbRB8aFS41iCQxeNk8L/dbXfR5erpXwnHXGk6vuCM5JhUv+UhV/caV5OtUJkxH94x0wHnUrQ0v2CCAEcCpttiL/mIuuH8nJ8FN29e1DHMWNJPlJdHyUQ==
x-ms-office365-filtering-correlation-id: 85d25c33-3be2-4fd9-2e44-08d68c3cd011
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3461;
x-ms-traffictypediagnostic: BYAPR12MB3461:
x-microsoft-antispam-prvs: <BYAPR12MB346105B2C3825CE595A1B958C26F0@BYAPR12MB3461.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(3846002)(6916009)(86362001)(7736002)(305945005)(54906003)(25786009)(2906002)(66066001)(76176011)(7696005)(6436002)(229853002)(26005)(6506007)(102836004)(186003)(9686003)(486006)(55016002)(74316002)(6246003)(93886005)(71200400001)(446003)(476003)(11346002)(71190400001)(68736007)(106356001)(81166006)(81156014)(99286004)(8676002)(256004)(14444005)(53936002)(4326008)(6116002)(97736004)(478600001)(316002)(8936002)(33656002)(14454004)(105586002)(309714004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3461;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V+sjBqU0BzO860n19OjdBBZsm1FfVc3Huhd9v+xxQkj8Z6iDUmt6/XMr0+HjeiK7hWzMjYTJcD60y1yWMLxQckD4YOwDsSOJBAvb/5lCaL3iZfgUya7kH2bbcnVgmlPHMu9T/Y5Rd2X7Fz4cHxsAVxchm5RsWYCHd85zH52NbqJiyygMYgG5DDnhnJYRzOjpI8D/EJHo3VHxHyihNqaLvCDJ3VEChC+ncRb31rPWsScNKLrYT3kCWi/GOWrAx69pxkZBmYFiw8lusCNfZ8rG6MGVedAgsY/66i/05gFdEWL7zpiZviomhGuTtSeli3JxAjCYBlU7R14rLIvyl/PysTLszHC4QTOHsHVL0AGKwkuNq6kOLUJMDFV6Jo8DKcQs6GkhOk0xt4OBdRMdpE7BYmwkow+2worosnKJIS/QKVA=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d25c33-3be2-4fd9-2e44-08d68c3cd011
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 14:10:13.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3461
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549462184; bh=fC0YgjWftF5fKfxEQuujEBaqRrHvamc3AXSky4mlBGc=;
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
        b=bYz2QxA0cZ0li6KvlqJbYO8m25Zw1/jAE7R3yQIi1Nqn33jRDCidIO/BrEq7qNTca
         hVNdmUrzm7OBUNKkLtMtNmhWzJr358IR96zCv2wynKDqzMwuz3SKwqqDqdcq8ll6vm
         Zxxzv0pHsyYcWFehedWTgbAnlzvoQ6oImamj49rfvXdDmhpYpEk7bjyqgVamwvdXFx
         ocIoPvsTkLcNrQKCioqbh1Hc/hMXXYkSTzcRzs+9tlBhq89aQqjv8IrXERVi7G38aV
         pvOJ0nSaC9QCS/vUdvpZ/Htkv4qJTDwFqfkJkN4nXj90Xm7waaBBTJfm034fG7CKRi
         PEbrFGrPoBm7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPiA+Pj4+IFRoYXQncyBvZGQgYmVjYXVzZSBpdCBzdWdnZXN0cyB0aGF0IERNQSBhY3R1
YWxseSBjb21wbGV0ZWQsIGJ1dCANCj4gPiA+ID4+Pj4gdGhlIG1lc3NhZ2UgZGlkbid0Lg0KPiA+
ID4gPj4+Pg0KPiA+ID4gPj4+PiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGhvdyB0aGF0IGNv
dWxkIGhhcHBlbi4NCj4gPiA+ID4+Pj4NCj4gPiA+ID4+Pj4gV2hhdCdzIGFsc28gd2VpcmQgYWJv
dmUgaXMgdGhhdCB0aGVyZSBkb2Vzbid0IHNlZW0gdG8gYmUgYSBETUEgDQo+ID4gPiA+Pj4+IHRo
YXQgaXMgc3RhcnRlZCBmb3IgdGhhdCBwYXJ0aWN1bGFyIG1lc3NhZ2UuIE9yIGlzIHRoZSB0aW1l
b3V0IA0KPiA+ID4gPj4+PiBtZXNzYWdlIGEgcmVzcG9uc2UgdG8gdGhlIHByaW9yIHRyYW5zZmVy
IChsZW5ndGggMTApPyBTZWVtcyANCj4gPiA+ID4+Pj4gbGlrZSB0aGF0IHNob3VsZCBub3QgYmUg
cG9zc2libGUgYmVjYXVzZSB3ZSBnZXQgdGhlICJ0cmFuc2ZlciBjb21wbGV0ZSIgbWVzc2FnZS4N
Cj4gPiA+ID4+Pg0KPiA+ID4gPj4+IFdhaXQsIHRob3NlIGFyZSBhY3R1YWxseSBkaWZmZXJlbnQg
aW5zdGFuY2VzIG9mIHRoZSBJMkMgDQo+ID4gPiA+Pj4gY29udHJvbGxlciwgc28gdGhlIHJlbGV2
YW50IGxvZyBlbnRyaWVzIGFyZSB0aGVzZToNCj4gPiA+ID4+Pg0KPiA+ID4gPj4+IAlbICAgIDAu
OTQ1NDQ1XSB0ZWdyYS1pMmMgNzAwMGQwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDog
MTYNCj4gPiA+ID4+PiAJWyAgICAwLjk0NTQ1Nl0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogdW5t
YXNrZWQgaXJxOiAwYw0KPiA+ID4gPj4+IAkuLi4NCj4gPiA+ID4+PiAJWyAgICAxLjA0OTIyNF0g
dGVncmEtaTJjIDcwMDBkMDAwLmkyYzogaTJjIHRyYW5zZmVyIHRpbWVkIG91dA0KPiA+ID4gPj4+
DQo+ID4gPiA+Pj4gQW5kIHRoZXNlIGRvbid0IGhhcHBlbiBpZiB5b3UgdXNlIGhpZ2hlciBidXJz
dCBzaXplcyBvciBiZWZvcmUgDQo+ID4gPiA+Pj4gdGhlIERNQSBzZXJpZXM/DQo+ID4gPiA+Pg0K
PiA+ID4gPj4gSSB0cmllZCB0byBlbmZvcmNlIERNQSB3aXRob3V0IGNoYW5naW5nIGJ1cnN0czoN
Cj4gPiA+ID4+DQo+ID4gPiA+PiAtLS0tLS0tLS0tDQo+ID4gPiA+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jIA0KPiA+ID4gPj4gYi9kcml2ZXJzL2kyYy9idXNz
ZXMvaTJjLXRlZ3JhLmMgaW5kZXggYzUzOGVkNWY4ZTJjLi41ZDFjNTRjZTc4MDANCj4gPiA+ID4+
IDEwMDY0NA0KPiA+ID4gPj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+
ID4gPiA+PiArKysgYi9kcml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4gPiA+ID4+IEBA
IC02LDYgKzYsOCBAQA0KPiA+ID4gPj4gICAqIEF1dGhvcjogQ29saW4gQ3Jvc3MgPGNjcm9zc0Bh
bmRyb2lkLmNvbT4NCj4gPiA+ID4+ICAgKi8NCj4gPiA+ID4+ICANCj4gPiA+ID4+ICsjZGVmaW5l
IERFQlVHDQo+ID4gPiA+PiArDQo+ID4gPiA+PiAgI2luY2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+
ID4gPj4gICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ID4gPj4gICNpbmNsdWRlIDxsaW51
eC9kbWFlbmdpbmUuaD4NCj4gPiA+ID4+IEBAIC0xMDQ2LDggKzEwNDgsNyBAQCBzdGF0aWMgaW50
IHRlZ3JhX2kyY194ZmVyX21zZyhzdHJ1Y3QgdGVncmFfaTJjX2RldiAqaTJjX2RldiwNCj4gPiA+
ID4+ICAgICAgICAgICAgICAgICB4ZmVyX3NpemUgPSBtc2ctPmxlbiArIEkyQ19QQUNLRVRfSEVB
REVSX1NJWkU7DQo+ID4gPiA+PiAgDQo+ID4gPiA+PiAgICAgICAgIHhmZXJfc2l6ZSA9IEFMSUdO
KHhmZXJfc2l6ZSwgQllURVNfUEVSX0ZJRk9fV09SRCk7DQo+ID4gPiA+PiAtICAgICAgIGkyY19k
ZXYtPmlzX2N1cnJfZG1hX3hmZXIgPSAoeGZlcl9zaXplID4gSTJDX1BJT19NT0RFX01BWF9MRU4p
ICYmDQo+ID4gPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpMmNfZGV2
LT5kbWFfYnVmOw0KPiA+ID4gPj4gKyAgICAgICBpMmNfZGV2LT5pc19jdXJyX2RtYV94ZmVyID0g
ISFpMmNfZGV2LT5kbWFfYnVmOw0KPiA+ID4gPj4gICAgICAgICB0ZWdyYV9pMmNfY29uZmlnX2Zp
Zm9fdHJpZyhpMmNfZGV2LCB4ZmVyX3NpemUpOw0KPiA+ID4gPj4gICAgICAgICBkbWEgPSBpMmNf
ZGV2LT5pc19jdXJyX2RtYV94ZmVyOw0KPiA+ID4gPj4gLS0tLS0tLS0tLQ0KPiA+ID4gPj4NCj4g
PiA+ID4+IEhlcmUgaXMgdGhlIGxvZyB3aXRoIHRoaXMgY2hhbmdlOg0KPiA+ID4gPj4NCj4gPiA+
ID4+IFsgICAgMC43NjA3OTZdIHRlZ3JhX3J0YyA3MDAwZTAwMC5ydGM6IHJlZ2lzdGVyZWQgYXMg
cnRjMQ0KPiA+ID4gPj4gWyAgICAwLjc2MDg1MF0gdGVncmFfcnRjIDcwMDBlMDAwLnJ0YzogVGVn
cmEgaW50ZXJuYWwgUmVhbCBUaW1lIENsb2NrDQo+ID4gPiA+PiBbICAgIDAuNzYxMDUwXSBpMmMg
L2RldiBlbnRyaWVzIGRyaXZlcg0KPiA+ID4gPj4gWyAgICAwLjkxODkyOF0gdGVncmEtaTJjIDcw
MDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDE2DQo+ID4gPiA+PiBbICAgIDAu
OTE4OTQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4gPiA+
PiBbICAgIDAuOTE5MDQwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0
ZTogMTAgMCAwDQo+ID4gPiA+PiBbICAgIDAuOTE5MDUwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJj
OiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogOA0KPiA+ID4gPj4gWyAgICAwLjkxOTA1OV0gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+ID4gPj4gWyAgICAwLjkx
OTMyMl0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0K
PiA+ID4gPj4gWyAgICAwLjkxOTMzNV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcg
RE1BIGZvciBsZW5ndGg6IDE2DQo+ID4gPiA+PiBbICAgIDAuOTE5MzQzXSB0ZWdyYS1pMmMgNzAw
MGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4gPiA+PiBbICAgIDAuOTE5NDQwXSB0ZWdy
YS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4gPiA+PiBb
ICAgIDAuOTE5NDQ4XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxl
bmd0aDogMTEyDQo+ID4gPiA+PiBbICAgIDAuOTE5NDU2XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJj
OiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4gPiA+PiBbICAgIDAuOTIyODE4XSB0ZWdyYS1pMmMgNzAw
MGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTEgMCAwDQo+ID4gPiA+PiBbICAgIDAuOTIy
ODI5XSBhdG1lbF9teHRfdHMgMC0wMDRjOiBGYW1pbHk6IDE2MCBWYXJpYW50OiAwIEZpcm13YXJl
IFYxLjAuQUEgT2JqZWN0czogMTgNCj4gPiA+ID4+IFsgICAgMC45MjI4ODZdIHRlZ3JhLWkyYyA3
MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxNg0KPiA+ID4gPj4gWyAgICAw
LjkyMjg5NV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+ID4g
Pj4gWyAgICAwLjkyMjk5M10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxl
dGU6IDEwIDAgMA0KPiA+ID4gPj4gWyAgICAwLjkyMzAwMl0gdGVncmEtaTJjIDcwMDBjMDAwLmky
Yzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDIyNA0KPiA+ID4gPj4gWyAgICAwLjkyMzAxMV0g
dGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+ID4gPj4gWyAgICAw
LjkzMzI1M10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDExIDAg
MA0KPiA+ID4gPj4gWyAgICAwLjkzMzI4N10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRp
bmcgRE1BIGZvciBsZW5ndGg6IDE2DQo+ID4gPiA+PiBbICAgIDAuOTMzMjk3XSB0ZWdyYS1pMmMg
NzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4gPiA+PiBbICAgIDAuOTMzNDc4XSB0
ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4gPiA+
PiBbICAgIDAuOTMzNDg3XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9y
IGxlbmd0aDogMTINCj4gPiA+ID4+IFsgICAgMC45MzM0OTZdIHRlZ3JhLWkyYyA3MDAwYzAwMC5p
MmM6IHVubWFza2VkIGlycTogMGMNCj4gPiA+ID4+IFsgICAgMC45NDUxMjBdIHRlZ3JhLWkyYyA3
MDAwZDAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxNg0KPiA+ID4gPj4gWyAgICAw
Ljk0NTEzMF0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+ID4g
Pj4gWyAgICAxLjAzODkxN10gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogRE1BIHRyYW5zZmVyIHRp
bWVvdXQNCj4gPiA+ID4+IFsgICAgMS4wMzg5ODJdIGF0bWVsX214dF90cyAwLTAwNGM6IF9fbXh0
X3JlYWRfcmVnOiBpMmMgdHJhbnNmZXIgZmFpbGVkICgtMTEwKQ0KPiA+ID4gPj4gWyAgICAxLjAz
OTAwMF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDE2
DQo+ID4gPiA+PiBbICAgIDEuMDM5MDA2XSBhdG1lbF9teHRfdHMgMC0wMDRjOiBGYWlsZWQgdG8g
cmVhZCBUNDQgYW5kIFQ1ICgtMTEwKQ0KPiA+IA0KPiA+IA0KPiA+IA0KPiA+ID4gPj4gWyAgICAx
LjAzOTAwOV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+ID4g
Pj4gWyAgICAxLjAzOTE0OF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxl
dGU6IDEwIDAgMA0KPiA+ID4gPj4gWyAgICAxLjAzOTE1N10gdGVncmEtaTJjIDcwMDBjMDAwLmky
Yzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDQNCj4gPiA+ID4+IFsgICAgMS4wMzkxNjZdIHRl
Z3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGlycTogMGMNCj4gPiA+ID4+IFsgICAgMS4w
MzkzMDRdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDAN
Cj4gPiA+ID4+IFsgICAgMS4wMzkzNDBdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5n
IERNQSBmb3IgbGVuZ3RoOiAxNg0KPiA+ID4gPj4gWyAgICAxLjAzOTM0OV0gdGVncmEtaTJjIDcw
MDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiA+ID4gPj4gWyAgICAxLjAzOTUzNV0gdGVn
cmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIgY29tcGxldGU6IDEwIDAgMA0KPiA+ID4gPj4g
WyAgICAxLjAzOTU0NF0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBs
ZW5ndGg6IDEyDQo+ID4gPiA+PiBbICAgIDEuMDM5NTUyXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJj
OiB1bm1hc2tlZCBpcnE6IDBjDQo+ID4gPiA+PiBbICAgIDEuMDQwMDU1XSB0ZWdyYS1pMmMgNzAw
MGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+ID4gPiA+PiBbICAgIDEuMDQw
MDgzXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYN
Cj4gPiA+ID4+IFsgICAgMS4wNDAwOTJdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2Vk
IGlycTogMGMNCj4gPiA+ID4+IFsgICAgMS4wNDAzMDFdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6
IHRyYW5zZmVyIGNvbXBsZXRlOiAxMCAwIDANCj4gPiA+ID4+IFsgICAgMS4wNDg5MzRdIHRlZ3Jh
LWkyYyA3MDAwZDAwMC5pMmM6IGkyYyB0cmFuc2ZlciB0aW1lZCBvdXQNCj4gPiA+ID4gDQo+ID4g
PiA+IFRoaXMgbG9nIHNob3dzIERNQSB0cmFuc2ZlciB0aW1lb3V0IGZvciBhdG1lbCByZWFkLg0K
PiA+ID4gPiBEbyB5b3Ugc2VlIGlzc3VlIGlmIHlvdSBkb27igJl0IGVuZm9yY2UgZG1hIGFsbCB0
aW1lIGFuZCBsZXQgaXQgY2hvb3NlIFBJTyBWcyBETUE/DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4g
PiBObywgdGhlcmUgYXJlIG5vIHRpbWVvdXQgZXJyb3JzIGluIFBJTyBtb2RlLiBJIGNvdWxkIHBv
c3QgZnVsbCBsb2cgd2l0aCB0aGUgUElPLW9ubHkgbW9kZSBpZiB5b3Ugd2FudC4NCj4gPiA+DQo+
ID4gWWVzIHBsZWFzZSBwb3N0IGZ1bGwgbG9nIG9mIFBJTyBvbmx5IGFuZCBETUEgb25seSBBbHNv
LCBpbiBhYm92ZSBsb2csIA0KPiA+IGxvdHMgb2YgRE1BIHRyYW5zZmVyIHdlbnQgdGhydSBmaW5l
IGV4Y2VwdCB0aGlzIG9uZSB0cmFuc2ZlciB3aGVyZSBETUEgDQo+ID4gdGltZWQgb3V0Lg0KPiA+
IERNQSBjb21wbGV0aW9uIGRvZXNudCBoYXBwZW4gb24gRE1BIHN1Ym1pdCBkdXJpbmcgdGhpcyBw
YXJ0aWN1bGFyIA0KPiA+IHRyYW5zYWN0aW9uIHRpbWVmcmFtZSBmb3Igc29tZSByZWFzb24uDQo+
IA0KPiBEbWl0cnksIGNhbiB5b3UgcHJvdmlkZSBzb21lIGJhY2tncm91bmQgaW5mb3JtYXRpb24g
b24gdGhlIHNldHVwIHRoYXQgeW91J3JlIHVzaW5nPyBJIHZhZ3VlbHkgcmVtZW1iZXIgc29tZXRo
aW5nIGFib3V0IGkyY0A3MDAwZDAwMCBiZWluZyBzcGVjaWFsIG9uID4gb2xkZXIgVGVncmEgZGV2
aWNlcy4gUGVyaGFwcyB0aGVyZSdzIHNvbWV0aGluZyBhZGRpdGlvbmFsIHRoYXQgd2UgbmVlZCB0
byB0YWtlIGludG8gYWNjb3VudD8NCj4gDQo+IEFoYSEgTG9vayBhdCB0ZWdyYV9pMmNfcmVnX2Fk
ZHIoKSB3aGljaCBzcGVjaWFsLWNhc2VzIEkyQ19UWF9GSUZPIG9uIHRoZSBEVkMgdmFyaWFudCBv
ZiB0aGUgY29udHJvbGxlciwgd2hpY2ggaXMgZXhhY3RseSB0aGUgb25lIHRoYXQgeW91IGFyZSBz
ZWVpbmcgPiB0aGUgdGltZW91dHMgb24gYW5kIGl0J3MgZXhhY3RseSB0aGUgcmVnaXN0ZXIgdGhh
dCB3ZSB1c2UgYXMgZGVzdGluYXRpb24gZm9yIHRoZSBETUEgdHJhbnNmZXIuDQo+IA0KPiBJIHRo
aW5rIHdlIG5lZWQgdG8gZG8gc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IAlzbHZfY29uZmln
LmRzdF9hZGRyID0gaTJjX2Rldi0+YmFzZV9waHlzICsgdGVncmFfaTJjX3JlZ19hZGRyKGkyY19k
ZXYsIEkyQ19UWF9GSUZPKTsNCj4gDQo+IHRvIG1ha2Ugc3VyZSB3ZSBwYXNzIHRoZSByaWdodCBG
SUZPIHJlZ2lzdGVyIGFkZHJlc3MgdG8gRE1BLg0KPiANCj4gVGhpZXJyeQ0KPiANClllYWggRFZD
IEZJRk8gcmVnaXN0ZXIgb2Zmc2V0IGlzIGRpZmZlcmVudC4gWWVzIHdlIG5lZWQgdG8gdXNlIHRl
Z3JhX2kyY19yZWdfYWRkciB3aGljaCB0YWtlcyBjYXJlIG9mIERWQyBGSUZPIGFkZHJlc3MuIFdp
bGwgZml4IGl0Lg0KDQpBdG1lbCB0b3VjaCBpcyBvbiBJMkMxICg3MDAwQzAwMCkuIERNQSBUaW1l
b3V0IGhhcHBlbmVkIGZvciBvbmx5IDEgdHJhbnNhY3Rpb24gZm9yIHRoaXMgZGV2aWNlIGFuZCBs
b3RzIG9mIG90aGVyIHRyYW5zZmVycyB0byB0aGlzIGRldmljZSBhcmUgZmluZS4NCmluIG90aGVy
IGxvZyBkbWl0cnkgc2VudCwgd2Ugc2VlIG9uZSB0cmFuc2ZlciB0aW1lb3V0IGZyb20gNzAwMEQw
MDAgYW5kIHRoaXMgY291bGQgYmUgZHVlIHRvIEZJRk8gQWRkcmVzc2VzLg0KDQpTb3dqYW55YQ0K
