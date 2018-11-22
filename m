Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE96C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E267620672
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="kDGySzDT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E267620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405889AbeKWCyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:54:41 -0500
Received: from mail-eopbgr20104.outbound.protection.outlook.com ([40.107.2.104]:15232
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730352AbeKWCyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:54:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrDs/42dqsxCAakvQRta+7z1jdzloNqI0NhDgp+Gztc=;
 b=kDGySzDT15YQ2qDIm+xSssVmZZGQ34vV3nI0E3f7w2Bpkl3soPVYY2JOnVo2OexSDQsof0GHdp1jgptUWXBYB0+eTjVmCIRAJDL1x2j3a1+gJC/b3SNFIsiVjg9BbmXX8P0OagZ/H41YpjebpBRGyNjeinkDEebtRT2Vqn56Y7c=
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com (10.168.188.135) by
 HE1PR0701MB2795.eurprd07.prod.outlook.com (10.168.189.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.6; Thu, 22 Nov 2018 16:14:34 +0000
Received: from HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77]) by HE1PR0701MB2729.eurprd07.prod.outlook.com
 ([fe80::35b1:90ba:fa:3c77%9]) with mapi id 15.20.1361.013; Thu, 22 Nov 2018
 16:14:34 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Topic: [PATCH] mtd: spi-nor: fix erase_type array to indicate current
 map conf
Thread-Index: AQHUgn5yRuGauPbUmUaN5hsWx0CViA==
Date:   Thu, 22 Nov 2018 16:14:34 +0000
Message-ID: <f05c60c9-7b19-29d6-0ad2-b1593da11263@nokia.com>
References: <20181122123552.15756-1-tudor.ambarus@microchip.com>
In-Reply-To: <20181122123552.15756-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.2.18]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
x-clientproxiedby: HE1PR0102CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::31) To HE1PR0701MB2729.eurprd07.prod.outlook.com
 (2603:10a6:3:99::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0701MB2795;6:EdxkcygqN4oZ6NikW1hlJoqMNfEmPotn2YMH0CYlelb2bgP84N4iv1wlt3SEtIFlf/kGMNOFatlgBFlQRrWt/6HoSG77Aw4fykA2Tu7rCuxbAwD1ce8DDcpc1p0LwJjvsMQKddFL/U2ru4cHPLSQgYg8pdUtQc9LfEmmRvKTPX6gxNidHMkdL12+FvIraYxkykgccSJoBv1u7pE2rHyJ0bFEFn6y+0pcJs7GIZSH0hVEhL/fU2GT050gda53bNtGm+bGxrL7cF4vxFk6uCk9oVB34okim6C1efrLjGlIr+HwA1zVAxbYvEGeXzjbWB3qq7RyHVk6Vyluc2PFeVqM/nu+LpRx2IhnV076BX2digb7hfHKZsHWqN/Kq9D0YlNLl8ET9RMT/yf67ELB04T7gL0F5Uq+lVv5G4LxMoReUUyjqajD+1wRoVtMP+SJ9zimhYmA+QBvmImYbo8c15H8+Q==;5:OT8/5xjrvSfC+xNrBpC+ojQaKWCCl1y3DQLFE6dREONGs5kMSyoKfX3omwnmMtgRcOgHTcTSyGWygDlkpGPKmL3E2MXsXmuqB/F5DDe+Jp8/Me8nXIbvyaF+3Otvl/qlOe2gl27g9t2cpxxUGpR41+lYZGRQ95CFpze7K/sDBpI=;7:cXVRnQ8uZf7xwi4UsPjPrqhyT7EEldYAFyMxOmjTcCt9fSrvz3lVB8ose6KxXMrXKCRxJesD8cLB8rBg7R3cLyZXZ1k6lj6jaBIzL1j7zmB4b39bDtsVf/VZPQfTbQSRdzxiFMrNtVurqU/0HMNaAw==
x-ms-office365-filtering-correlation-id: 607449a2-eb91-4cf7-2e30-08d650959715
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR0701MB2795;
x-ms-traffictypediagnostic: HE1PR0701MB2795:
x-microsoft-antispam-prvs: <HE1PR0701MB27959DBBB508F786C0146A0B88DB0@HE1PR0701MB2795.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231442)(11241501184)(806099)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR0701MB2795;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2795;
x-forefront-prvs: 0864A36BBF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(7736002)(106356001)(97736004)(54906003)(71190400001)(71200400001)(58126008)(105586002)(256004)(110136005)(14444005)(316002)(2616005)(446003)(11346002)(476003)(486006)(68736007)(6506007)(386003)(186003)(99286004)(52116002)(76176011)(102836004)(53546011)(36756003)(5660300001)(14454004)(8936002)(31686004)(81156014)(8676002)(39060400002)(64126003)(81166006)(4326008)(26005)(6512007)(53936002)(6246003)(65956001)(31696002)(478600001)(65806001)(6116002)(2501003)(66066001)(86362001)(6486002)(3846002)(6436002)(25786009)(65826007)(2906002)(305945005)(2201001)(2900100001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2795;H:HE1PR0701MB2729.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VQwkVyeeJfMIfOPfcywmkczNaRc72of9LY61NJWZpM5/SSd3Cwbarq5MSB+YS++VAxxjnk/nDeGb9Z3Nu1hhugY6j9ibuXX1oP9hunhkKGPNUNhO8yf6qLAdrSaTCuzAr9crKjNLg8k4KvwyYZ42AWoLD10oU4mkAXQ2GHtOGHm/8tqxrunhKU4GRqxw30pDxH4272et7IMOQsVHHjMHT32DwyvoOGAlnmjUqL2h19ScP+5Y+qa3M5USY48MIYSPHsU7rY8E6nXxLUSC9Ku02iceCTTRVBtllRjFjrta9NWjSHOIY3AuD/akCAQsTMgf/SosnvepBHMhb5hv85d/x21uo62DR8C6C0O2zXxkM7U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C51FE360355EA48819EA3916A1DEAC7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607449a2-eb91-4cf7-2e30-08d650959715
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2018 16:14:34.1986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCk9uIDIyLzExLzIwMTggMTM6MzYsIFR1ZG9yLkFtYmFydXNAbWljcm9j
aGlwLmNvbSB3cm90ZToNCj4gRnJvbTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNy
b2NoaXAuY29tPg0KPiANCj4gQnVnIHJlcG9ydGVkIGZvciB0aGUgb3V0LW9mLXRyZWUgUzI1RlMx
MjhTIGZsYXNoIG1lbW9yeS4NCj4gDQo+IEJGUFQgdGFibGUgYWR2ZXJ0aXNlcyBhbGwgdGhlIGVy
YXNlIHR5cGVzIHN1cHBvcnRlZCBieSBhbGwgdGhlDQo+IHBvc3NpYmxlIG1hcCBjb25maWd1cmF0
aW9ucy4gVXBkYXRlIHRoZSBlcmFzZV90eXBlIGFycmF5IHRvIGluZGljYXRlDQo+IHdoaWNoIGVy
YXNlIHR5cGVzIGFyZSBhcHBsaWNhYmxlIHRvIHRoZSBjdXJyZW50IG1hcCBjb25maWd1cmF0aW9u
Lg0KPiANCj4gQmFja3dhcmQgY29tcGF0aWJpbGl0eSB0ZXN0IGRvbmUgb24gc3N0MjZ2ZjA2NGIu
DQo+IA0KPiBGaXhlczogYjAzOGU4ZTNiZTcyICgibXRkOiBzcGktbm9yOiBwYXJzZSBTRkRQIFNl
Y3RvciBNYXAgUGFyYW1ldGVyIFRhYmxlIikNCj4gUmVwb3J0ZWQtYnk6IEFsZXhhbmRlciBTdmVy
ZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQG5va2lhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2ZXJz
L210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPiBpbmRleCA5M2M5YmM4OTMxZmMuLmE3MWFkY2Q2ZGRm
YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4gQEAgLTMwMDAsNyArMzAwMCw4IEBAIHN0
YXRpYyBpbnQgc3BpX25vcl9pbml0X25vbl91bmlmb3JtX2VyYXNlX21hcChzdHJ1Y3Qgc3BpX25v
ciAqbm9yLA0KPiAgCXU2NCBvZmZzZXQ7DQo+ICAJdTMyIHJlZ2lvbl9jb3VudDsNCj4gIAlpbnQg
aSwgajsNCj4gLQl1OCBlcmFzZV90eXBlLCB1bmlmb3JtX2VyYXNlX3R5cGU7DQo+ICsJdTggdW5p
Zm9ybV9lcmFzZV90eXBlLCBzYXZlX3VuaWZvcm1fZXJhc2VfdHlwZTsNCj4gKwl1OCBlcmFzZV90
eXBlLCByZWdpb25zX2VyYXNlX3R5cGU7DQo+ICANCj4gIAlyZWdpb25fY291bnQgPSBTTVBUX01B
UF9SRUdJT05fQ09VTlQoKnNtcHQpOw0KPiAgCS8qDQo+IEBAIC0zMDE0LDYgKzMwMTUsNyBAQCBz
dGF0aWMgaW50IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9ybV9lcmFzZV9tYXAoc3RydWN0IHNwaV9u
b3IgKm5vciwNCj4gIAltYXAtPnJlZ2lvbnMgPSByZWdpb247DQo+ICANCj4gIAl1bmlmb3JtX2Vy
YXNlX3R5cGUgPSAweGZmOw0KPiArCXJlZ2lvbnNfZXJhc2VfdHlwZSA9IDA7DQo+ICAJb2Zmc2V0
ID0gMDsNCj4gIAkvKiBQb3B1bGF0ZSByZWdpb25zLiAqLw0KPiAgCWZvciAoaSA9IDA7IGkgPCBy
ZWdpb25fY291bnQ7IGkrKykgew0KPiBAQCAtMzAzMCwxMyArMzAzMiwzOCBAQCBzdGF0aWMgaW50
IHNwaV9ub3JfaW5pdF9ub25fdW5pZm9ybV9lcmFzZV9tYXAoc3RydWN0IHNwaV9ub3IgKm5vciwN
Cj4gIAkJICovDQo+ICAJCXVuaWZvcm1fZXJhc2VfdHlwZSAmPSBlcmFzZV90eXBlOw0KPiAgDQo+
ICsJCS8qDQo+ICsJCSAqIHJlZ2lvbnNfZXJhc2VfdHlwZSBtYXNrIHdpbGwgaW5kaWNhdGUgYWxs
IHRoZSBlcmFzZSB0eXBlcw0KPiArCQkgKiBzdXBwb3J0ZWQgaW4gdGhpcyBjb25maWd1cmF0aW9u
IG1hcC4NCj4gKwkJICovDQo+ICsJCXJlZ2lvbnNfZXJhc2VfdHlwZSB8PSBlcmFzZV90eXBlOw0K
PiArDQo+ICAJCW9mZnNldCA9IChyZWdpb25baV0ub2Zmc2V0ICYgflNOT1JfRVJBU0VfRkxBR1Nf
TUFTSykgKw0KPiAgCQkJIHJlZ2lvbltpXS5zaXplOw0KPiAgCX0NCj4gIA0KPiArCXNhdmVfdW5p
Zm9ybV9lcmFzZV90eXBlID0gbWFwLT51bmlmb3JtX2VyYXNlX3R5cGU7DQo+ICAJbWFwLT51bmlm
b3JtX2VyYXNlX3R5cGUgPSBzcGlfbm9yX3NvcnRfZXJhc2VfbWFzayhtYXAsDQo+ICAJCQkJCQkJ
ICB1bmlmb3JtX2VyYXNlX3R5cGUpOw0KPiAgDQo+ICsJaWYgKCFyZWdpb25zX2VyYXNlX3R5cGUp
IHsNCj4gKwkJLyoNCj4gKwkJICogUm9sbCBiYWNrIHRvIHRoZSBwcmV2aW91cyB1bmlmb3JtX2Vy
YXNlX3R5cGUgbWFzaywgU01QVCBpcw0KPiArCQkgKiBicm9rZW4uDQo+ICsJCSAqLw0KPiArCQlt
YXAtPnVuaWZvcm1fZXJhc2VfdHlwZSA9IHNhdmVfdW5pZm9ybV9lcmFzZV90eXBlOw0KPiArCQly
ZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4gKwkvKg0KPiArCSAqIEJGUFQgdGFibGUgYWR2
ZXJ0aXNlcyBhbGwgdGhlIGVyYXNlIHR5cGVzIHN1cHBvcnRlZCBieSBhbGwgdGhlDQo+ICsJICog
cG9zc2libGUgbWFwIGNvbmZpZ3VyYXRpb25zLiBVcGRhdGUgdGhlIGVyYXNlX3R5cGUgYXJyYXkg
dG8gaW5kaWNhdGUNCj4gKwkgKiB3aGljaCBlcmFzZSB0eXBlcyBhcmUgYXBwbGljYWJsZSB0byB0
aGUgY3VycmVudCBtYXAgY29uZmlndXJhdGlvbi4NCj4gKwkgKi8NCj4gKwlmb3IgKGkgPSAwOyBp
IDwgU05PUl9FUkFTRV9UWVBFX01BWDsgaSsrKQ0KPiArCQlpZiAoIShyZWdpb25zX2VyYXNlX3R5
cGUgJiBCSVQoZXJhc2VbaV0uaWR4KSkpDQo+ICsJCQlzcGlfbm9yX3NldF9lcmFzZV90eXBlKCZl
cmFzZVtpXSwgMCwgMHhGRik7DQoNCmhhdmUgeW91IG5vdGljZWQgdGhlIGZvbGxvd2luZzoNCg0K
Li4uL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jOiBJbiBmdW5jdGlvbiDigJhzcGlfbm9y
X2luaXRfbm9uX3VuaWZvcm1fZXJhc2VfbWFw4oCZOg0KLi4uL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
c3BpLW5vci5jOjI5NDA6Mjc6IGVycm9yOiBwYXNzaW5nIGFyZ3VtZW50IDEgb2Yg4oCYc3BpX25v
cl9zZXRfZXJhc2VfdHlwZeKAmSBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXINCiBmcm9t
IHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZXJyb3I9ZGlzY2FyZGVkLXF1YWxpZmllcnNdDQogICAg
c3BpX25vcl9zZXRfZXJhc2VfdHlwZSgmZXJhc2VbaV0sIDAsIDB4RkYpOw0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXg0KLi4uL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3BpLW5vci5jOjIzNjg6
MTM6IG5vdGU6IGV4cGVjdGVkIOKAmHN0cnVjdCBzcGlfbm9yX2VyYXNlX3R5cGUgKuKAmSBidXQg
YXJndW1lbnQgaXMgb2YgdHlwZSDigJhjb25zdCBzdHJ1DQpjdCBzcGlfbm9yX2VyYXNlX3R5cGUg
KuKAmQ0KIHN0YXRpYyB2b2lkIHNwaV9ub3Jfc2V0X2VyYXNlX3R5cGUoc3RydWN0IHNwaV9ub3Jf
ZXJhc2VfdHlwZSAqZXJhc2UsDQogICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0K
DQo+ICsNCj4gIAlzcGlfbm9yX3JlZ2lvbl9tYXJrX2VuZCgmcmVnaW9uW2kgLSAxXSk7DQo+ICAN
Cj4gIAlyZXR1cm4gMDsNCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpBbGV4YW5kZXIgU3ZlcmRsaW4u
DQo=
