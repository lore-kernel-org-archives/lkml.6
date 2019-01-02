Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BB1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACE920651
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="URPvomrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfABWkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:40:11 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:14939 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfABWkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:40:10 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c2d3dc60000>; Thu, 03 Jan 2019 06:40:06 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 02 Jan 2019 14:40:04 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 02 Jan 2019 14:40:04 -0800
Received: from DRBGMAIL102.nvidia.com (10.18.16.21) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 22:40:03 +0000
Received: from HKMAIL101.nvidia.com (10.18.16.10) by DRBGMAIL102.nvidia.com
 (10.18.16.21) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 2 Jan
 2019 22:40:02 +0000
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (104.47.42.58) by
 HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 2 Jan 2019 22:40:01 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com (20.176.178.161) by
 BN7PR12MB2786.namprd12.prod.outlook.com (20.176.178.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Wed, 2 Jan 2019 22:39:59 +0000
Received: from BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e]) by BN7PR12MB2836.namprd12.prod.outlook.com
 ([fe80::4024:c208:f331:505e%3]) with mapi id 15.20.1495.005; Wed, 2 Jan 2019
 22:39:59 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Peter Rosin <peda@axentia.se>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>
CC:     "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH V1] i2c: tegra: Fix Maximum transfer size
Thread-Topic: [PATCH V1] i2c: tegra: Fix Maximum transfer size
Thread-Index: AQHUouTxth5PHmy5Ikqubbc88AD66qWciKoAgAAFBlA=
Date:   Wed, 2 Jan 2019 22:39:56 +0000
Message-ID: <BN7PR12MB283656FC1AA704474BC52728C28C0@BN7PR12MB2836.namprd12.prod.outlook.com>
References: <1546465721-12108-1-git-send-email-skomatineni@nvidia.com>
 <e0f6cea5-cd18-1ed1-f8ee-aa9c58198df2@axentia.se>
In-Reply-To: <e0f6cea5-cd18-1ed1-f8ee-aa9c58198df2@axentia.se>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2786;6:kB2TbQVd+DI9HulRgfPRL0ZlQJfQQzGET0xXnEWQzCz0bEZW78qSBnjOdc/Zv1VI+TInZekEDXUoiAY7mJkWpcpxF0Eh8D4v4X5QBiEpDcH4hqxbJICzLikJy+3H5/6zYKuNR1ulkPA+6CbUC6Q3vsqqqHeFNw73XV5Jcr9MCWNfwF12EfZETML/itSvmHcBir3cqaqt2VfcixJHM6pBRETBSN0iUsBDm8BXQbG2HpI5QI+he1fImK4+WNfeSQEJtM1IEEooo6b7eJhFSKg9IA0hql0EWOxQfvONCkrjymFBiDXqCFYCS0+Htv7F7GtJ6NFl5y2ZR6WvzhReIORmofKHKIfD4qRZ/7A4QYe5qPXO3KxXT7r08XifYNBOW5PDs+j2AcMnJBlPF540RaMZjXFGWTgzrq9ifdWhi+ukjqAfZC1fWHBF3tT63TnAwDsMD2pvXWoYP5nIRdk7bgePDw==;5:ZiqHmJag/dMDy7PBwZrhGGM0ErykZDjWKchfYJaVPlTGVZOJRZnXNJVhKM3ugTcKJiijE0ipYmr26/ilOL1FFe+YkSI3xfej9nNSOvWw0isKwqrQ8vd43EW8lntuM7VMYuCwqv8ui5gaOLxabpnG3oAUImjGfSmvbKYh3z57vFAUN2EBpfgECiDRkEWDSWrnwFrHnA7aAA7blep0C0K80w==;7:e7mINtfndDRdj/8sYLMYR8ooxG+L/aK/9ccAXpLK0Mt6vQWOJhVvl5TOCmze1qx+SglYh/xRu1ein7rR3DYHAE2/junAPD7JOJ8X9mmtpYuNHT3GGEZHvVOgixPf4gV77FNYRAAM8Lucs2fRj9YBjg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(366004)(39860400002)(189003)(199004)(97736004)(6636002)(6436002)(25786009)(74316002)(26005)(186003)(6506007)(39060400002)(6666004)(53936002)(86362001)(575784001)(106356001)(105586002)(99286004)(2906002)(5660300001)(55016002)(66066001)(305945005)(486006)(14444005)(256004)(71200400001)(316002)(81166006)(81156014)(6246003)(14454004)(8676002)(8936002)(478600001)(9686003)(33656002)(110136005)(68736007)(71190400001)(476003)(102836004)(446003)(11346002)(2501003)(229853002)(7736002)(3846002)(7696005)(54906003)(6116002)(4326008)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2786;H:BN7PR12MB2836.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: dcc2c102-8b80-421a-302f-08d6710339fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2786;
x-ms-traffictypediagnostic: BN7PR12MB2786:
x-microsoft-antispam-prvs: <BN7PR12MB278696AB5A9FDEEE2DF64959C28C0@BN7PR12MB2786.namprd12.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231475)(944501520)(52105112)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN7PR12MB2786;BCL:0;PCL:0;RULEID:;SRVR:BN7PR12MB2786;
x-forefront-prvs: 0905A6B2C7
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kfV3VOgDLQtGu71NDhL9B/KZYrjsbAfCZFRCpg5bgce0CKgv6WfIG2O8U3TPsUh0w5Aa3A94Z9Bb6PhUnuBHUhRfjmEyp0GxZLMgE7RUXiXe2tgoQ/fIw9jjM2DnrF/E/nggGVVH/L2/564tzg/TcE95GNtIpvzRK8Oz6f/WaFiOeHTzzuxUCyQPKO4jNJdtmZjQ486nUwZVVpbpyL8UJk/61gi8iQuGhlbUPKLDvfgrKDRa/M30FKoFjMWs3Ts95nRQ9njl0orJJE41fPfRKGpUPlh1+NZjQCADW86JrxPacR8R8z854+ASPW2jq3tl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc2c102-8b80-421a-302f-08d6710339fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2019 22:39:57.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2786
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1546468806; bh=Wf8rixmnCWHFxRcwHBSqCaiyblcIW8+ZoQIie4FoFEQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-microsoft-exchange-diagnostics:
         x-ms-exchange-antispam-srfa-diagnostics:
         x-forefront-antispam-report:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-exchange-antispam-report-cfa-test:x-forefront-prvs:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         spamdiagnosticoutput:spamdiagnosticmetadata:MIME-Version:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=URPvomrnD20k2Nv22jYAgprTAPY37yKLrCg66Gwi4SANAqxjv8ekzqbjIRgjldvgk
         k878bJy7sXiMAkJTwXCrWf3sn9JTLCmIFc2x4H9o6pXbTrD4FEx5jTNdFg+ODSirQ9
         /FHY+B/fxI5iMG75u7nx1MeIFL+nBcAhlh0dGYklNy89GlqsDUeSgnj594hqRUCCGb
         S4IxabLRZgHN8h128feXZPZpANrtwbZsiRBFgEbXK3uSzko7dDbpJ1AGEV1GklRqjc
         qWhMcui7XXZS9Zr+pNFjHy7zYUB/14XH3Zf5ffmM+ZRKFPq/aCoAxG+es/OYBVTaFs
         z7vuWEP7kkHqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIFBldGVyLg0KDQo+PiBUZWdyYTE5NCBzdXBwb3J0cyBtYXhpbXVtIDY0SyBCeXRlcyB0
cmFuc2ZlciBwZXIgcGFja2V0Lg0KPj4gVGVncmExODYgYW5kIHByaW9yIHN1cHBvcnRzIG1heGlt
dW0gNEsgQnl0ZXMgdHJhbnNmZXIgcGVyIHBhY2tldC4NCj4+IA0KPj4gVGhpcyBwYXRjaCBmaXhl
cyB0aGlzIHBheWxvYWQgZGlmZmVyZW5jZSBiZXR3ZWVuIFRlZ3JhMTk0IGFuZCBwcmlvciANCj4+
IHRlZ3JhIGNoaXBzZXRzLg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBTb3dqYW55YSBLb21hdGlu
ZW5pIDxza29tYXRpbmVuaUBudmlkaWEuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9pMmMvYnVz
c2VzL2kyYy10ZWdyYS5jIHwgMTYgKysrKysrKysrKysrKysrLQ0KPj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMgDQo+PiBiL2RyaXZlcnMvaTJjL2J1c3Nlcy9p
MmMtdGVncmEuYyBpbmRleCA0MzcyOTRlYTJmMGEuLjBjMDhlZDhiNmM5NCANCj4+IDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9pMmMvYnVzc2VzL2kyYy10ZWdyYS5jDQo+PiArKysgYi9kcml2ZXJz
L2kyYy9idXNzZXMvaTJjLXRlZ3JhLmMNCj4+IEBAIC0xNjcsNiArMTY3LDcgQEAgc3RydWN0IHRl
Z3JhX2kyY19od19mZWF0dXJlIHsNCj4+ICAJYm9vbCBoYXNfbXVsdGlfbWFzdGVyX21vZGU7DQo+
PiAgCWJvb2wgaGFzX3NsY2dfb3ZlcnJpZGVfcmVnOw0KPj4gIAlib29sIGhhc19tc3RfZmlmbzsN
Cj4+ICsJc3RydWN0IGkyY19hZGFwdGVyX3F1aXJrcyAqcXVpcmtzOw0KPg0KPlRoaXMgY291bGQg
cGVyaGFwcyBiZSBhIHBvaW50ZXIgdG8gY29uc3Q/DQo+DQpZZXMsIGNvcnJlY3RlZCBpbiBWMi4N
Cj4+ICB9Ow0KPj4gIA0KPj4gIC8qKg0KPj4gQEAgLTgzMyw2ICs4MzQsMTIgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBpMmNfYWRhcHRlcl9xdWlya3MgdGVncmFfaTJjX3F1aXJrcyA9IHsNCj4+ICAJ
Lm1heF93cml0ZV9sZW4gPSA0MDk2LA0KPj4gIH07DQo+PiAgDQo+PiArc3RhdGljIGNvbnN0IHN0
cnVjdCBpMmNfYWRhcHRlcl9xdWlya3MgdGVncmExOTRfaTJjX3F1aXJrcyA9IHsNCj4+ICsJLmZs
YWdzID0gSTJDX0FRX05PX1pFUk9fTEVOLA0KPg0KPlRoaXMgaXMgbm90IG1lbnRpb25lZCBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UgYW5kIHRoZSBmbGFnIGlzIG5vdCBwcmVzZW50IGluIHRoZSBvbGQg
c3RydWN0IHRlZ3JhX2kyY19xdWlya3MgYWJvdmUuIEFyZSB5b3UgdHJ5aW5nIHRvIHNuZWFrIGNo
YW5nZXMgcGFzdCB0aGUgbWFpbnRhaW5lcnMsIG9yIHdhcyB0aGUgY2hhbmdlIHNpbXBseSBub3Qg
aW50ZW50aW9uYWw/DQpGbGFnIG9mIE5PX1pFUk9fTEVOIGlzIHByZXNlbnQgaW4gdGVncmFfaTJj
X3F1aXJrcyBhcyB3ZWxsLiBJIGhhdmUgYWRkZWQgc2VwYXJhdGUgcXVpcmsgd2l0aCBzYW1lIGZs
YWcgYW5kIHBheWxvYWQgY2hhbmdlIGZvciBUZWdyYTE5NA0KPj4gKwkubWF4X3JlYWRfbGVuID0g
NjU1MzYsDQo+PiArCS5tYXhfd3JpdGVfbGVuID0gNjU1MzYsDQo+DQo+VGhvc2UgYXJlIGhpZ2hs
eSBkdWJpb3VzIHdoZW4gLm1heF9yZWFkX2xlbiBhbmQgLm1heF93cml0ZV9sZW4gYXJlIG9mIHR5
cGUgdTE2LiBJIGJldCB5b3UgY291bGQganVzdCByZW1vdmUgdGhlbS4NClllcywgY29ycmVjdGVk
IGluIFYyLg0KPg0KPkNoZWVycywNCj5QZXRlcg0KPg0KPj4gK307DQo+PiArDQo+PiAgc3RhdGlj
IGNvbnN0IHN0cnVjdCB0ZWdyYV9pMmNfaHdfZmVhdHVyZSB0ZWdyYTIwX2kyY19odyA9IHsNCj4+
ICAJLmhhc19jb250aW51ZV94ZmVyX3N1cHBvcnQgPSBmYWxzZSwNCj4+ICAJLmhhc19wZXJfcGt0
X3hmZXJfY29tcGxldGVfaXJxID0gZmFsc2UsIEBAIC04NDQsNiArODUxLDcgQEAgc3RhdGljIA0K
Pj4gY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMjBfaTJjX2h3ID0gew0K
Pj4gIAkuaGFzX211bHRpX21hc3Rlcl9tb2RlID0gZmFsc2UsDQo+PiAgCS5oYXNfc2xjZ19vdmVy
cmlkZV9yZWcgPSBmYWxzZSwNCj4+ICAJLmhhc19tc3RfZmlmbyA9IGZhbHNlLA0KPj4gKwkucXVp
cmtzID0gJnRlZ3JhX2kyY19xdWlya3MsDQo+PiAgfTsNCj4+ICANCj4+ICBzdGF0aWMgY29uc3Qg
c3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMzBfaTJjX2h3ID0geyBAQCAtODU3LDYg
DQo+PiArODY1LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdyYV9pMmNfaHdfZmVhdHVyZSB0
ZWdyYTMwX2kyY19odyA9IHsNCj4+ICAJLmhhc19tdWx0aV9tYXN0ZXJfbW9kZSA9IGZhbHNlLA0K
Pj4gIAkuaGFzX3NsY2dfb3ZlcnJpZGVfcmVnID0gZmFsc2UsDQo+PiAgCS5oYXNfbXN0X2ZpZm8g
PSBmYWxzZSwNCj4+ICsJLnF1aXJrcyA9ICZ0ZWdyYV9pMmNfcXVpcmtzLA0KPj4gIH07DQo+PiAg
DQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdyYV9pMmNfaHdfZmVhdHVyZSB0ZWdyYTExNF9p
MmNfaHcgPSB7IEBAIA0KPj4gLTg3MCw2ICs4NzksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRl
Z3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTE0X2kyY19odyA9IHsNCj4+ICAJLmhhc19tdWx0aV9t
YXN0ZXJfbW9kZSA9IGZhbHNlLA0KPj4gIAkuaGFzX3NsY2dfb3ZlcnJpZGVfcmVnID0gZmFsc2Us
DQo+PiAgCS5oYXNfbXN0X2ZpZm8gPSBmYWxzZSwNCj4+ICsJLnF1aXJrcyA9ICZ0ZWdyYV9pMmNf
cXVpcmtzLA0KPj4gIH07DQo+PiAgDQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdyYV9pMmNf
aHdfZmVhdHVyZSB0ZWdyYTEyNF9pMmNfaHcgPSB7IEBAIA0KPj4gLTg4Myw2ICs4OTMsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTI0X2kyY19odyA9
IHsNCj4+ICAJLmhhc19tdWx0aV9tYXN0ZXJfbW9kZSA9IGZhbHNlLA0KPj4gIAkuaGFzX3NsY2df
b3ZlcnJpZGVfcmVnID0gdHJ1ZSwNCj4+ICAJLmhhc19tc3RfZmlmbyA9IGZhbHNlLA0KPj4gKwku
cXVpcmtzID0gJnRlZ3JhX2kyY19xdWlya3MsDQo+PiAgfTsNCj4+ICANCj4+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMjEwX2kyY19odyA9IHsgQEAgDQo+
PiAtODk2LDYgKzkwNyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGVncmFfaTJjX2h3X2ZlYXR1
cmUgdGVncmEyMTBfaTJjX2h3ID0gew0KPj4gIAkuaGFzX211bHRpX21hc3Rlcl9tb2RlID0gdHJ1
ZSwNCj4+ICAJLmhhc19zbGNnX292ZXJyaWRlX3JlZyA9IHRydWUsDQo+PiAgCS5oYXNfbXN0X2Zp
Zm8gPSBmYWxzZSwNCj4+ICsJLnF1aXJrcyA9ICZ0ZWdyYV9pMmNfcXVpcmtzLA0KPj4gIH07DQo+
PiAgDQo+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCB0ZWdyYV9pMmNfaHdfZmVhdHVyZSB0ZWdyYTE5
NF9pMmNfaHcgPSB7IEBAIA0KPj4gLTkwOSw2ICs5MjEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHRlZ3JhX2kyY19od19mZWF0dXJlIHRlZ3JhMTk0X2kyY19odyA9IHsNCj4+ICAJLmhhc19tdWx0
aV9tYXN0ZXJfbW9kZSA9IHRydWUsDQo+PiAgCS5oYXNfc2xjZ19vdmVycmlkZV9yZWcgPSB0cnVl
LA0KPj4gIAkuaGFzX21zdF9maWZvID0gdHJ1ZSwNCj4+ICsJLnF1aXJrcyA9ICZ0ZWdyYTE5NF9p
MmNfcXVpcmtzLA0KPj4gIH07DQo+PiAgDQo+PiAgLyogTWF0Y2ggdGFibGUgZm9yIG9mX3BsYXRm
b3JtIGJpbmRpbmcgKi8gQEAgLTk2MCw3ICs5NzMsNiBAQCBzdGF0aWMgDQo+PiBpbnQgdGVncmFf
aTJjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgCWkyY19kZXYtPmJh
c2UgPSBiYXNlOw0KPj4gIAlpMmNfZGV2LT5kaXZfY2xrID0gZGl2X2NsazsNCj4+ICAJaTJjX2Rl
di0+YWRhcHRlci5hbGdvID0gJnRlZ3JhX2kyY19hbGdvOw0KPj4gLQlpMmNfZGV2LT5hZGFwdGVy
LnF1aXJrcyA9ICZ0ZWdyYV9pMmNfcXVpcmtzOw0KPj4gIAlpMmNfZGV2LT5pcnEgPSBpcnE7DQo+
PiAgCWkyY19kZXYtPmNvbnRfaWQgPSBwZGV2LT5pZDsNCj4+ICAJaTJjX2Rldi0+ZGV2ID0gJnBk
ZXYtPmRldjsNCj4+IEBAIC05NzYsNiArOTg4LDggQEAgc3RhdGljIGludCB0ZWdyYV9pMmNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+ICAJaTJjX2Rldi0+aHcgPSBvZl9k
ZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+PiAgCWkyY19kZXYtPmlzX2R2YyA9
IG9mX2RldmljZV9pc19jb21wYXRpYmxlKHBkZXYtPmRldi5vZl9ub2RlLA0KPj4gIAkJCQkJCSAg
Im52aWRpYSx0ZWdyYTIwLWkyYy1kdmMiKTsNCj4+ICsJaTJjX2Rldi0+YWRhcHRlci5xdWlya3Mg
PSBpMmNfZGV2LT5ody0+cXVpcmtzOw0KPj4gKw0KPj4gIAlpbml0X2NvbXBsZXRpb24oJmkyY19k
ZXYtPm1zZ19jb21wbGV0ZSk7DQo+PiAgCXNwaW5fbG9ja19pbml0KCZpMmNfZGV2LT54ZmVyX2xv
Y2spOw0KPj4gIA0KPj4gDQo=
