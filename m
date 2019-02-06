Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E49C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE6A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Ekv0lApi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfBFMuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:50:11 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:50857 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfBFMuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:50:10 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ad7fd0000>; Wed, 06 Feb 2019 20:50:05 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 04:50:03 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 06 Feb 2019 04:50:03 -0800
Received: from DRBGMAIL102.nvidia.com (10.18.16.21) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 12:50:02 +0000
Received: from HKMAIL102.nvidia.com (10.18.16.11) by DRBGMAIL102.nvidia.com
 (10.18.16.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 12:50:01 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 12:50:00 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3048.namprd12.prod.outlook.com (20.178.53.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Wed, 6 Feb 2019 12:49:57 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 12:49:57 +0000
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
Subject: RE: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Topic: [PATCH V12 3/5] i2c: tegra: Add DMA support
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAB3xA=
Date:   Wed, 6 Feb 2019 12:49:56 +0000
Message-ID: <BYAPR12MB33983AF91EA28744B7614971C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
In-Reply-To: <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3048;6:jP6rKPAHgkboKwmGi5OgIlam0/Rqp89ip3YNmd0+mOHeSx6L9FlPc7pFTqP3eL8LW8CDwP78ohOijeiwCW5utEAiqt9qfFOCVd+7sCX7eRMhnrOXY0W0vfAxvhfCmriJzHreoaoh7fGU/XPzq8bjL86Qiwi2f8/zc6u8LzHtSF1pOePEEJ3pHPIwanS4zVLN+FYoNP414P7bf0I09EbDe6thLimORXx7vkKuCNGRj/d6k+W08R4+Bl1l+g3phJdqqy2IAK1+/gcCqNAaRpwlAgvvhT19zJM91ktKt2BOTxUj60eeaiqe7edEP1zTNoxJ/8yszfUW4kT3goAKaS+CaX7w7VlPgxfXl7ePPQzgPhIfoOhboTnevYJVk0FPGCA4IXHTp+YjTkX5AOkTDD16dzhk0LvN7VcZsiZ3HvQQovOrz/gfvgpa8vnSH2ORyGDk3Jpv37A6W2KLRw0QCNw8oA==;5:lt2MsQGHeFKRqUBrDq2BCcjUa2B0C+JlNHufZj8P2dsTora/AQHYpI7cKudl5/aDn4/uDQMFT9mP/8HnDEbXGrCofAoEk0jlbycJM0obn+dedeFmF8UCo0CKqQe8W3XavytkojtnDrADxlzdQ0KOHP8dQXBKtHEeoO2R4exMnNJppJQTb9TpdSw1w9f5sylInC2MdA3oOVlUKzL567YH4Q==;7:djOhz9tF83FN6BxltiVIqpI0sUpm84MkboU1W+J61IkzWgfDXLaD9hm3BmyWrE7wezeyQ2vdJZdccVbL28AhrMeZSADad/CVsmrMwnXezkcfoWzJbfSpz3aOXEtFRLnXfVrOoZFYLCOLgDqDVRmbJQ==
x-ms-office365-filtering-correlation-id: adc32706-0158-4501-a0ef-08d68c319925
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3048;
x-ms-traffictypediagnostic: BYAPR12MB3048:
x-microsoft-antispam-prvs: <BYAPR12MB3048E05A0100F9616A7B38DDC26F0@BYAPR12MB3048.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(199004)(189003)(53936002)(6636002)(55016002)(66066001)(9686003)(2906002)(99286004)(2501003)(8936002)(33656002)(316002)(110136005)(54906003)(8676002)(81156014)(81166006)(86362001)(14444005)(256004)(4326008)(74316002)(186003)(6506007)(26005)(25786009)(305945005)(7736002)(6436002)(229853002)(76176011)(68736007)(486006)(6246003)(14454004)(97736004)(3846002)(6116002)(7696005)(478600001)(476003)(11346002)(71200400001)(446003)(71190400001)(105586002)(106356001)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3048;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9kFCsKykfNelB1OFMXVqH+JE1GELsBQBqqGwdeJ1E8sOSYP7g7eKE1n3pq926R4nda7ByELUxwVnziz/q1m6b6YrbrCjhZqbK3dnqe3/Bi5sUisolJ3ATZ1nl25zx8lqDhM6fWK6XZQgpSGKICuBCHCYpI2WSJWbS1YHoyGTs3UwoBKX6S+eK4pSo8NimCY++FC8p9OKoWUvTeYVk8kAa95A5Z1s4E8VrrogN16h48G06fXBeTiwECwYgFh62vkLWi2a95GooJmEvBM0+UZAFbSNMpHn9NN6WmEGyfjgkae0yfYm2Z3QiXMuemyvxoYbeqPRJgWWEdhZ2vtQ8oLnpRKj0yNctoMqqiKkg4fQkC4Lf3EZxOOEAbc5/8XLQqGI+mGgdB9eT1VRA45gxksryck1VijCFMKc0v+jghpoP7s=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: adc32706-0158-4501-a0ef-08d68c319925
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 12:49:56.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3048
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549457405; bh=tLz9RhEMXAdtG/AKlQR/WecJ5Py7yYOXCpQC+cQSp0c=;
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
        b=Ekv0lApi8C/0+SG/yImvK0ncmJXyNf68ZRH2Phjblihgbk0qaelmEGes7ogQf5kfD
         qfAQ5Peuc3E7bMDJAlCx9wWZDwIIDZYmJV1xj2mHgOvirZH/eokjdJwbWJ9QUdk96w
         weA3q4YZzPQXFORdt6oR/J+oOAWnAQ2bU64EibUmhsBoJbVR0eL0fYmGpktqYsWkmc
         JiEddOSFGk/eTqw/HUtOQygV12pnjNTjvmdM0Ql/kvguoNtO2Ozf95HrUnD8pH4kOE
         SOhwyqGYwJhJdJT/EDCsDn1gUw3u3/mWZoDTLZEK8McOc5UoSZU+lRWHqkM7eMBmT6
         LiZCz6gD5UPmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IAkJVEVHUkFfSTJDX1RJTUVPVVQpOw0KPiA+ICAJdGVncmFfaTJjX21hc2tfaXJxKGkyY19k
ZXYsIGludF9tYXNrKTsgQEAgLTgxNCw2ICsxMTMzLDcgQEAgc3RhdGljIA0KPiA+IGludCB0ZWdy
YV9pMmNfeGZlcl9tc2coc3RydWN0IHRlZ3JhX2kyY19kZXYgKmkyY19kZXYsDQo+ID4gIAkJdGlt
ZV9sZWZ0LCBjb21wbGV0aW9uX2RvbmUoJmkyY19kZXYtPm1zZ19jb21wbGV0ZSksDQo+ID4gIAkJ
aTJjX2Rldi0+bXNnX2Vycik7DQo+ID4gIA0KPiA+ICsJaTJjX2Rldi0+aXNfY3Vycl9kbWFfeGZl
ciA9IGZhbHNlOw0KPg0KPiBUaGlzIGxpbmUgY291bGQgYmUgcmVtb3ZlZCBiZWNhdXNlIHRoZXJl
IGlzIG5vIG5lZWQgdG8gY2xlYXIgImlzX2N1cnJfZG1hX3hmZXIiIGF0IHRoaXMgcG9pbnQuDQo+
DQoNCkl0IGlzIG5lZWRlZCBiZWNhdXNlIGluIGNhc2Ugb2YgQVJCX0xPU1QsIHdlIHRlcm1pbmF0
ZSBkbWFlbmdpbmUgYW5kIHRoZW4gd2UgcGVyZm9ybSBidXMgY2xlYXIgb3BlcmF0aW9uLiANCk9u
IGJ1cyBjbGVhciBkb25lIGludGVycnVwdCwgaXQgYWdhaW4gZ29lcyB0aHJ1IEkyQyBlcnJvciBz
ZWN0aW9uIHRvIG1hc2sgYWxsIGludGVycnVwdHMgYW5kIHdoZW4gY3Vycl9kbWFfeGZlciBpcyB0
cnVlIGl0IGRvZXMgZG1hZW5naW5lIHRlcm1pbmF0ZSBhZ2FpbiBzbyBzZXR0aW5nIGN1cnJfZG1h
X3hmZXIgYXMgZmFsc2Ugd2hlbiB0cmFuc2ZlciBpbiBkbWEgbW9kZSBpcyBkb25lLg0KDQo+DQo+
DQo+U293amFueWEsIEkgdHJpZWQgdG8gZW5mb3JjZSBETUEgdHJhbnNmZXJyaW5nICsgc2V0dGlu
ZyBETUEgYnVyc3QgdG8gYSBvbmUgd29yZCBhbmQgdGhpcyBjb21iaW5hdGlvbiBkb2Vzbid0IHdv
cmsgd2VsbCB3aGlsZSBpdCBzaG91bGQsIGlmIEknbSBub3QgbWlzc2luZyBzb21ldGhpbmcuIENv
dWxkID55b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoZSBwcm9ibGVtIG9yIGV4cGxhaW4gd2h5
IHRoYXQgaGFwcGVucz8NCj4NCj4NCj4gWyAgICAxLjAxNzQ5Nl0gdGVncmEtaTJjIDcwMDBjMDAw
LmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6IDEyMA0KPiBbICAgIDEuMDE3NTA0XSB0ZWdy
YS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBjDQo+IFsgICAgMS4wMjA4OTZdIHRl
Z3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBsZXRlOiAxMSAwIDANCj4gWyAgICAx
LjAyMDkwOV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogc3RhcnRpbmcgRE1BIGZvciBsZW5ndGg6
IDE2DQo+IFsgICAgMS4wMjA5MThdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHVubWFza2VkIGly
cTogMGMNCj4gWyAgICAxLjAyMTA1NV0gdGVncmEtaTJjIDcwMDBjMDAwLmkyYzogdHJhbnNmZXIg
Y29tcGxldGU6IDEwIDAgMA0KPiBbICAgIDEuMDMyMjMwXSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJj
OiBzdGFydGluZyBETUEgZm9yIGxlbmd0aDogMTYNCj4gWyAgICAxLjAzMjIzOV0gdGVncmEtaTJj
IDcwMDBjMDAwLmkyYzogdW5tYXNrZWQgaXJxOiAwYw0KPiBbICAgIDEuMDMyMzU5XSB0ZWdyYS1p
MmMgNzAwMGMwMDAuaTJjOiB0cmFuc2ZlciBjb21wbGV0ZTogMTAgMCAwDQo+IFsgICAgMS4wMzIz
NjhdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHN0YXJ0aW5nIERNQSBmb3IgbGVuZ3RoOiAxMg0K
PiBbICAgIDEuMDMyMzc2XSB0ZWdyYS1pMmMgNzAwMGMwMDAuaTJjOiB1bm1hc2tlZCBpcnE6IDBj
DQo+IFsgICAgMS4wMzI3MDRdIHRlZ3JhLWkyYyA3MDAwYzAwMC5pMmM6IHRyYW5zZmVyIGNvbXBs
ZXRlOiAxMCAwIDANCj4gWyAgICAxLjA0OTIyNF0gdGVncmEtaTJjIDcwMDBkMDAwLmkyYzogaTJj
IHRyYW5zZmVyIHRpbWVkIG91dA0KPg0KPg0KSSBkb27igJl0IHNlZSBhbnkgaXNzdWUgd2l0aCBk
bWEgYnVyc3Qgb2YgMSB3b3JkIGlycmVzcGVjdGl2ZSBvZiB0cmFuc2ZlcnMgaW4gYWx3YXlzIGRt
YSBtb2RlLg0KT25lIHN0cmFuZ2UgdGhpbmcgaXMgaW4geW91ciBhYm92ZSBsb2csIGZvciBsYXN0
IHRyYW5zYWN0aW9uIGFmdGVyIHRyYW5zZmVyIGNvbXBsZXRlLCB0aGVyZSBpcyBpMmMgdHJhbnNm
ZXIgdGltZWQgd2hpY2ggZG9lc27igJl0IG1ha2Ugc2Vuc2UuDQpJZiB0cmFuc2ZlciB0aW1lb3V0
IGhhcHBlbnMsIGl0IHJldHVybnMgZnJvbSBpMmMgdHJhbnNmZXIgYnV0IHNob3VsZG7igJl0IGdv
IHRocnUgdHJhbnNmZXIgY29tcGxldGUNCg0KPg0KPg0KPg0KPiBJJ20gbm93IGFsc28gd29uZGVy
aW5nIHdoZXRoZXIgdGhhdCBwdXR0aW5nIHBhY2tldF9oZWFkZXIgaW50byB0aGUgZG1hX2J1ZiBp
cyByZWFsbHkgbmVlZGVkIGF0IGFsbC4uIElzbid0IHBvc3NpYmxlIHRvIHB1c2ggcGFja2V0X2hl
YWRlciB1c2luZyBQSU8gcmVnYXJkbGVzcyBvZiB3aGV0aGVyID4gdGhlIHJlc3Qgb2YgdGhlIHRy
YW5zZmVyIHdpbGwgYmUgaW4gRE1BIG9yIFBJTyBtb2Rlcz8NCj4NCj4gQWN0dWFsbHkgSSB0cmll
ZCB0byBhbHdheXMgcHVzaCBwYWNrZXRfaGVhZGVyIHVzaW5nIFBJTyBhbmQgYXBwYXJlbnRseSBE
TUEgd29ya3MganVzdCBmaW5lIHdpdGggdGhhdDoNCj4NCk9mY291cnNlIGl0IHdpbGwgd29yayB1
c2luZyBQSU8gZm9yIHBhY2tldCBoZWFkZXIgYW5kIGRtYSBvbmx5IGZvciBkYXRhIGJ5dGVzLiBC
dXQgcGFja2V0IGhlYWRlciBpcyBqdXN0IDEyIGJ5dGVzIHNvIHdoeSBub3Qgd2UgdHJhbnNmZXIg
aXQgYWxvbmcgd2l0aCBkYXRhIHRvZ2V0aGVyIHRocnUgZG1hLg0KDQo=
