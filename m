Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299FCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5A520B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="NVQNyC1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfBFNaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:30:03 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:22443 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfBFNaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:30:03 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5ae1560000>; Wed, 06 Feb 2019 21:29:58 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 06 Feb 2019 05:29:58 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 06 Feb 2019 05:29:58 -0800
Received: from HKMAIL102.nvidia.com (10.18.16.11) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 6 Feb
 2019 13:29:56 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 HKMAIL102.nvidia.com (10.18.16.11) with Microsoft SMTP Server (TLS) id
 15.0.1395.4 via Frontend Transport; Wed, 6 Feb 2019 13:29:56 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3000.namprd12.prod.outlook.com (20.178.53.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Wed, 6 Feb 2019 13:29:53 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::5c0f:3413:bd4c:3dd3%5]) with mapi id 15.20.1601.016; Wed, 6 Feb 2019
 13:29:53 +0000
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
Thread-Index: AQHUvaSihB2vPasFV02HZ/JY13Td7aXSqkqAgAAR9ACAAADL4IAAARIAgAAANpCAAASogIAAAKAg
Date:   Wed, 6 Feb 2019 13:29:53 +0000
Message-ID: <BYAPR12MB3398B4A862E4BFA5344AE461C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <c4f67e39-df72-cc56-216b-8e6014891b52@gmail.com>
 <BYAPR12MB3398E50ED1C6909D6BCB0DDFC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <304c1916-e836-fa95-5cec-887fef8f3eb2@gmail.com>
 <BYAPR12MB33986680570EB919369000F3C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <82f38909-94f1-7984-2b0f-df6231aee58f@gmail.com>
In-Reply-To: <82f38909-94f1-7984-2b0f-df6231aee58f@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [24.176.232.13]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB3000;6:Pf8GOI/ClCH0F8Gdb+9yeHjY1a9cTBeWExgUg2BLCWQMUUqJ2PmlMHb4mZY2ZFfy34qsmgLT13yFxPS/OrF+KjmvTRI2w5r+NBhWZx5CrBWzKfwtlhe7PsXFziBPxTuwJLGTfncfIX4lkVFnv94RzB1fEBRfoIRWn8TvJ1afAO3il97HaAyK2cr+A1PhzViP196vrtao6ITbIHxxbQpUW82RwXzEAO/snU7R7vJAIflGXP3a5aCRWZesCz4Ne4wZqmovYk/ftbOyEXYw9+T8dNmAc0aEZ876BMt0CIen25ECz362rzx36w/jIJ159T2V46ddrzpu4ttae/JRZWvdBeX9V2zE0gZxtNkfBoQyixIW/nAYJxQO1LVWcu8yIUMHb7NLJLkPOCfo1aiurXLmJaulSoM7NHhIC0sbdv2XHELdnHG/OmDtNNrTfwEY1O6inUN38oZgnxI9Y0rCemxvlw==;5:Zhp6OC/bxmgdVjRtNELH/1YNpVY0a3xZ3KB1lhVF2N3FdYycR5UY+W0Yadvmpr5+EHTCo66U+b8ZLlwRwy+VKGYn/P3O2KPr6HwXEX9Z5A3qynX3qWD8j/GE5DV4pkXlk90O1zhhJ3kHvt/dE8LTQjw8AHZMJc/xcNVY17anZ0wKhv2DInQGNjhxxGpSYbH8la0CxDRtDYTC5CshAq6yTQ==;7:Wa845DgIvPMuGejosLeJyII4qPWSFxCbsAxIOKZK2HSuUmMi+LLGC0WiOUGixj6x63WWcrO9coUdthtOmwDvpV54Jno29fjH4wzVLh18Q0uavy8ATES9K+4+GB0G8hnF24zTTgDUaTCQ6r1gAK/bUA==
x-ms-office365-filtering-correlation-id: 29328642-ad5d-4189-44a6-08d68c372d77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB3000;
x-ms-traffictypediagnostic: BYAPR12MB3000:
x-microsoft-antispam-prvs: <BYAPR12MB3000E7CBC4B9FA8C29CBFFD8C26F0@BYAPR12MB3000.namprd12.prod.outlook.com>
x-forefront-prvs: 0940A19703
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(366004)(396003)(199004)(189003)(54906003)(316002)(186003)(71190400001)(110136005)(71200400001)(25786009)(6246003)(6436002)(97736004)(53936002)(102836004)(7696005)(93886005)(76176011)(4326008)(26005)(105586002)(106356001)(6506007)(99286004)(2501003)(478600001)(14454004)(256004)(66066001)(14444005)(2906002)(68736007)(55016002)(33656002)(9686003)(6636002)(74316002)(476003)(229853002)(7736002)(305945005)(486006)(86362001)(3846002)(6116002)(8676002)(81156014)(81166006)(8936002)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3000;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lE4/vFsjW4pdnLEt75gtJ37iMRwFKsRgRk/93zNopJ5JfOrPWjvexE7A/FED7Lr3d1b+j/WlranImFnvPJSyW0mET7N4tbEwOluI/jN8pk/Qxt/E0JYKU6Hjv9r68CSIKnpivt7v2nRSHoNthTCDvLutf5WAFHMfszYFxnFMuq8RrKdqQNYYxdwMB+N9SlAc4QJB8yKE2ltuQl+xolL08JIIWpUPoD4Xk1t7RB7BJtkY7V7dDVr4hF04G62HEjc6KvZPuETJxtvJmHBmJJzrsxn/bdM6CVmVdbSrPaSmk9sd3ofV79fglfEWX7NB9HGoKoaNP+tZmwSet2hDMUWOLqpV5Ph0sQUDOPlqYxrz4blqDua8aTmb+CGHiJC9xa+sHa2kYSPT8QMv98DnLJQWnWJb+6F64JLoBBB5RCajOSg=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 29328642-ad5d-4189-44a6-08d68c372d77
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2019 13:29:53.1563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3000
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549459798; bh=3i60BW0MK4H2jfIqVo4rSlNh1Iq9BjpqEkENSDVhuoM=;
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
        b=NVQNyC1gI25z6DjOpL78RW1ZvzjZWl24hjXh5xw1nhj+CxJtwXDi6dPweMV1VNrAj
         x4kD7z9cbemOtu1y2uNpMSkC8TPlg9IBQJ+VKDGL8lzH7N6O5hyXImqeyIwufC1A2h
         VJez2LdFcD60iVFFHm1m5tvwKAIkMUYrTEySoj1D2N/gkZ5gmLFokWFFSgXTbbKjEY
         AgWi4272wORoPBJ3toxsERkyx64iukSdMTTLKmVV8IjUmepi1B0JPx7mfebJMoUVRN
         bC1/v1M535f1FM3myVFuv6oR0tCGqvrQuCGyGmxCgBaYkmOibNV+rrQzCD49uKQREy
         miEaCNm4OAvIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gDQo+ID4+Pj4gQlRXLCBJJ20gc2VlaW5nICJhdG1lbF9teHRfdHMgMC0wMDRjOiBXYXJu
aW5nOiBJbmZvIENSQyBlcnJvciAtIGRldmljZT0weEY0MzZEQyBmaWxlPTB4MDAwMDAwIiB3aGl0
aG91dCBtYWtpbmcgYW55IG1vZGlmaWNhdGlvbnMgdG8gdGhlIG9yaWdpbmFsIHBhdGNoIGFzIHdl
bGwgYW5kIGl0IHNoYWxsIG5vdCBoYXBwZW4sIGhlbmNlIHRoZXJlIGlzIGJ1ZyBzb21ld2hlcmUu
IFByb2JhYmx5IEZJRk8gdHJpZ2dlcnMgYXJlIHN0aWxsIG5vdCBzZXQgdXAgY29ycmVjdGx5Li4u
ID8NCj4gPj4+Pg0KPiA+Pj4+DQo+ID4+PiBJbiBzbmlwcGV0IHlvdSBzZW50LCBJIHNlZSB5b3Ug
YXJlIGZvcmNpbmcgZG1hX2J1cnN0IHRvIDEgYWx3YXlzIHdoaWNoIGlzIHdoYXQgc2V0IGZvciBm
aWZvIHRyaWdnZXIgbGV2ZWxzIGFzIHdlbGwgYW5kIGFsc28geW91IGFyZSBmb3JjaW5nIGRtYSBh
bGwgdGhlIHRpbWUuDQo+ID4+PiBTbyBhbHdheXMgaXQgd2lsbCBiZSAxIHdvcmQgZG1hIGJ1cnN0
IGFuZCAxIHdvcmQgdHJpZ2dlciBsZXZlbCBhbmQgdGhhdCBzaG91bGQgbm90IGJlIGFuIGlzc3Vl
Lg0KPiA+Pj4NCj4gPj4NCj4gPj4gSSByZXZlcnRlZCB0aGF0IHNuaXBwZXQsIHRoaXMgbG9nIGlz
IGNvbGxlY3RlZCB3aXRoIHRoZSB5b3VycyBvcmlnaW5hbCBwYXRjaC4NCj4gPj4NCj4gPiBGcm9t
IGF0bWVsIGRyaXZlciwgbG9va3MgbGlrZSB0aGlzIHdhcm5pbmcgaXMgZnJvbSBtYXh0X3VwZGF0
ZV9jZmcgYW5kIA0KPiA+IGR1ZSB0byBDUkMgbWlzbWF0Y2ggYW5kIGFib3ZlIHZhbHVlcyBzaG93
cyByZWFkIGRhdGEgQ1JDIGlzIDBYZjQzNmRjIHdoaWNoIGlzIGNvbXBhcmVkIGFnYWluc3QgaW5m
b19jcmMgb2YgYWxsIDAncyBJbmZvX2NyYyBpcyBiYXNlZCBvbiByYXcgY29uZmlnIGZpbGUgYW5k
IHNvbWVob3cgaXRzIGFsbCAwJ3MuIHRoaXMgaXMgbm90IGJhc2VkIG9uIGRhdGEgcmVhZCB0aHJ1
IGkyYy4NCj4gPiBkYXRhLT5pbmZvX2NyYyBjb21wdXRlZCBvbiBkYXRhIHJlYWQgaXMgMFhmNDM2
ZGMNCj4gPiANCj4gPiBUaGlzIHdhcm5pbmcgaXMgbm90IHJlbGF0ZWQgdG8gSTJDIHRyYW5zZmVy
DQo+ID4gDQo+DQo+IEl0IGRvZXNuJ3QgaGFwcGVuIHdpdGggdGhlIEkyQyBQSU8gbW9kZS4gU2Vl
bXMgaXQgbWVhbnMgdGhhdCB0aGUgSTJDIHJlYWRzIG91dCB0aGUgMHhGNDM2REMgdmFsdWUgaW5z
dGVhZCBvZiAweDAwMDAwMC4uIGlmIEknbSBub3QgbWlzc2luZyBhbnl0aGluZy4NCj4NCkxvZyB0
aGF0IHlvdSBzaGFyZWQgdGhpcyB3YXJuaW5nLCBkb2VzbuKAmXQgc2hvdyBhbnkgaTJjIGZhaWx1
cmVzIHdpdGggYXRtZWwgYW5kIENSQyBiYXNlZCBvbiBpMmMgcmVhZCAgZGF0YSBpcyAwWGY0MzZk
Yy4NCkR1cmluZyB0aGlzIGxvZywgdGhlcmUgYXJlIG5vdCBETUEgdGltZW91dHMgYXNzb2NpYXRl
ZCBkdXJpbmcgdGhpcyB3YXJuaW5nIHRpbWVmcmFtZS4gU28gaTJjIHJlYWQgZGF0YSBpcyB0aHJ1
IERNQSB3aGljaCBpcyBub24temVyby4NCg==
