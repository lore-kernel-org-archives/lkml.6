Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BFEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A2E2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ur9epWLd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A2E2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbeKHXe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:34:27 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:60191 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbeKHXe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:34:27 -0500
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="23007730"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Nov 2018 06:58:50 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 8 Nov 2018 06:58:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx9CrY5prPlq/TBpC8VQRxonEhsaXLBm9KbRGzQ8osQ=;
 b=ur9epWLdfj54yK8Z4iTCQERfCtM+BAliK2hl0FcF/yz8qj0O7Vye9aGsBfYW0jmu3Ia4qa+Hd5Iyr5OwhFd8XTgaknBJ81sRqwVqFFt47EiwVZKlUwicvRnq9bx53lHcKYTb29Ph7giklca9suH/VsTsHwgjmNxm2UKvSKdpXl8=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1554.namprd11.prod.outlook.com (10.172.22.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Thu, 8 Nov 2018 13:58:46 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::11b7:21db:803a:7cfa%5]) with mapi id 15.20.1294.034; Thu, 8 Nov 2018
 13:58:46 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@bootlin.com>
CC:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH 3/7] mtd: spi-nor: add restriction for nmaps in smpt
 parser
Thread-Topic: [PATCH 3/7] mtd: spi-nor: add restriction for nmaps in smpt
 parser
Thread-Index: AQHUd1My2DY7uJrddEu3eJNAMbNdY6VF1c6AgAAR3gA=
Date:   Thu, 8 Nov 2018 13:58:45 +0000
Message-ID: <86d16e39-15df-c12c-7bf3-25996db0c3a9@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
 <20181108110653.21063-4-tudor.ambarus@microchip.com>
 <20181108135447.36a0314c@bbrezillon>
In-Reply-To: <20181108135447.36a0314c@bbrezillon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::15) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1554;6:LrsJdiFj48xEhfrhcG+h5CfC+WNbbUNh7+Vo8pd1FBXXtKsdk/3/1d6TFBvYex14Cg5rOzeYZ9e5wOeDkQUBYMFWi8mWHwo8GpAIlY6qE+Q7jMnn5KrKotOBasZlf7vSxaZuI+Js093U4BmcczQIdYswS/selgf6sJuxtm43ghhQAuRw2F6JcD+ZQl9rSnn59czrT1SubgDxbQ4u2sIVqNBKYpGdTy0FCJL3yugux0/P3kxxInsLIyOjyt1xyvj2bhWl7ZoXwCZ3Mt83yH1YZenpKHpAxYsDtEtsv0CFzMfI0TmHee12N52hBnAAEzl3H43T86iUXKBuAay9mkw4Z+QWuqlcbXa97IH+zg9iMIsZI4xaIaCSewiO6nIs4n06/OAafS3nohCB1KGGArwYqsamNuyWmYzr+sM2/WSVTS1NYqB4lirz3C1WCn7PLChtDz8raDDgTUe1RzY+rDDjyw==;5:1tJobkedVJfcueRok4it6EpaEcdpWLakJT/UmbHUMcaGf6kpjuAm9lMo978tqRADHsLOC2FMVO4j/34tFTOag0v9jfOlqXncNvnU9KfWIoUrcmJH/NSHEEryWo4DPhGtpiN52a51UgPgpZlh665VAFxkXAZY4ym9xIksWqvC3rU=;7:CHyCee0oOIvrvF8u+kAVV0bJ5mzlqYlhNmhXqVEHV422o/MEerTQak/JJFZbAsvTzIiiD67jcrh2Ww9vxS758Y+p7amg99Jr7ta8Lp6wmiTfTiOAIbKwqYm1PUy0RH6Ojm0TC9TfcZK0m5MlGJ28ew==
x-ms-office365-filtering-correlation-id: 13b1a9c6-09ea-4bf5-5281-08d645824ca3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1554;
x-ms-traffictypediagnostic: BN6PR11MB1554:
x-microsoft-antispam-prvs: <BN6PR11MB1554A0BC1076F439C26768FCF0C50@BN6PR11MB1554.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231382)(944501410)(52105095)(93006095)(93001095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1554;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1554;
x-forefront-prvs: 0850800A29
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(376002)(366004)(39860400002)(199004)(189003)(6506007)(39060400002)(31686004)(86362001)(8936002)(81166006)(81156014)(229853002)(4326008)(2906002)(99286004)(256004)(486006)(14444005)(72206003)(5660300001)(53546011)(76176011)(6916009)(8676002)(31696002)(14454004)(53936002)(386003)(102836004)(68736007)(6512007)(105586002)(6486002)(25786009)(6436002)(2900100001)(6246003)(3846002)(6116002)(52116002)(316002)(106356001)(446003)(476003)(11346002)(54906003)(2616005)(478600001)(71190400001)(36756003)(71200400001)(26005)(305945005)(186003)(7736002)(66066001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1554;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vAlMOFSxdEREkNFQ2IR02No38r8eBEnbhhxn/oe7PCzXgTBnLdkGi0ST5cZwqb5QVTyo//ItKw85s7Bilns637c4GPSqNRxlasMMmNRSzJC0vyqD7mDEMdOkIPzJO3C5J87AL6OpPCrF1To7NMWvrsbLarT5gZgEYw9XMKYxpT+K1F5p7FqKreQ/zYUYOnw32FcM1mB5Wsk10R8fNH0n2FKS6S7Fj1ZjVz+xuDQVeRJur5KZfgXVb6/6g7LaGwxyKAixZkzDHbytbe0TAAQcnFYwhD+zy8MqcOCZNk/JLmxizMqgNwmMneJ3QJ+XajUGlTmWIQowTgcDHvhZo/J7nbhWlyqyziF3Qolg6HHWumM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <378FDC35138FF247887F0D08EC5BA9A7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b1a9c6-09ea-4bf5-5281-08d645824ca3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2018 13:58:45.9986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1554
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDExLzA4LzIwMTggMDI6NTQgUE0sIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24g
VGh1LCA4IE5vdiAyMDE4IDExOjA3OjExICswMDAwDQo+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hp
cC5jb20+IHdyb3RlOg0KPiANCj4+IFRoZSBtYXAgc2VsZWN0b3IgaXMgbGltaXRlZCB0byBhIG1h
eGltdW0gb2YgOCBiaXRzLCBhbGxvd2luZw0KPj4gZm9yIGEgbWF4aW11bSBvZiAyNTYgcG9zc2li
bGUgbWFwIGNvbmZpZ3VyYXRpb25zLiBUaGUgdG90YWwNCj4+IG51bWJlciBvZiBtYXAgY29uZmln
dXJhdGlvbnMgc2hvdWxkIGJlIGFkZHJlc3NhYmxlIGJ5IHRoZQ0KPj4gdG90YWwgbnVtYmVyIG9m
IGJpdHMgZGVzY3JpYmVkIGJ5IHRoZSBkZXRlY3Rpb24gY29tbWFuZHMuDQo+Pg0KPj4gRm9yIGV4
YW1wbGU6IGlmIHRoZXJlIGFyZSBmaXZlIHRvIGVpZ2h0IHBvc3NpYmxlIHNlY3RvciBtYXANCj4+
IGNvbmZpZ3VyYXRpb25zLCBhdCBsZWFzdCB0aHJlZSBjb25maWd1cmF0aW9uIGRldGVjdGlvbiBj
b21tYW5kcw0KPj4gd2lsbCBiZSBuZWVkZWQgdG8gZXh0cmFjdCB0aHJlZSBiaXRzIG9mIGNvbmZp
Z3VyYXRpb24gc2VsZWN0aW9uDQo+PiBpbmZvcm1hdGlvbiBmcm9tIHRoZSBkZXZpY2UgaW4gb3Jk
ZXIgdG8gaWRlbnRpZnkgd2hpY2ggY29uZmlndXJhdGlvbg0KPj4gaXMgY3VycmVudGx5IGluIHVz
ZS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9u
QGJvb3RsaW4uY29tPg0KPiANCj4gSSBkb24ndCByZW1lbWJlciBzdWdnZXN0aW5nIHRoaXMgOi0p
Lg0KDQpJIHNlZSB0aGlzIHdoZW4geW91IGRpc2N1c3NlZCB3aXRoIFlvZ2VzaDoNCg0KKyAgICAg
ICBmb3IgKG5tYXBzID0gMDsgaTwgc21wdF9sZW47IG5tYXBzKyspIHsNCisgICAgICAgICAgICAg
ICBpZighKHNtcHRbaV0gJiBTTVBUX0RFU0NfVFlQRV9NQVApKSB7DQorICAgICAgICAgICAgICAg
ICAgICAgICBpICs9IDI7DQorICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCisgICAg
ICAgICAgICAgICB9DQorDQorICAgICAgICAgICAgICAgaWYoIW1hcF9pZF9pc192YWxpZCkgew0K
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKG5tYXBzKSB7DQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IE5VTEw7DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOw0KKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KDQpJZiBJIHVuZGVyc3RhbmQgY29y
cmVjdGx5LCB5b3UgbWVhbnQgdGhhdCBpZiB0aGVyZSBhcmUgbm8gZGV0ZWN0aW9uIGNvbW1hbmRz
LA0KYW5kIG1vcmUgdGhhbiBhIGNvbmZpZ3VyYXRpb24gbWFwLCB0aGVuIHJldHVybiBhbiBlcnJv
ci4NCg0KVGhpcyBpcyBjb3JyZWN0IGluIG15IG9waW5pb24uIFdoYXQgSSBkaWQgd2FzIHRvIGdl
bmVyYWxpemUgdGhpcyBpZGVhLiBJZiBzbXRwDQpkZWZpbmVzIG1vcmUgbWFwcyB0aGFuIHlvdSBj
YW4gc2VsZWN0IHVzaW5nIGRldGVjdGlvbiBjb21tYW5kcywgcmV0dXJuIGVycm9yLg0KDQorDQor
ICAgICAgICAgICAgICAgICAgICAgICByZXQgPSBzbXB0K2k7DQorICAgICAgICAgICAgICAgfSBl
bHNlIGlmIChtYXBfaWQgPT0gU01QVF9NQVBfSUQoc21wdFtpXSkpIHsNCisgICAgICAgICAgICAg
ICAgICAgICAgIHJldCA9IHNtcHQraTsNCisgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0K
KyAgICAgICAgICAgICAgIH0NCisNCiAgICAgICAgICAgICAgICAvKiBpbmNyZW1lbnQgdGhlIHRh
YmxlIGluZGV4IHRvIHRoZSBuZXh0IG1hcCAqLw0KICAgICAgICAgICAgICAgIGkgKz0gU01QVF9N
QVBfUkVHSU9OX0NPVU5UKHNtcHRbaV0pICsgMTsNCiAgICAgICAgfQ0KDQo+IA0KPj4gU2lnbmVk
LW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KPj4g
LS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgfCAxNSArKysrKysrKysrKysr
LS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4gaW5kZXggNTlkY2VkYjA4NjkxLi5iZDE4NjZk
NzE0ZjIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwaS1ub3IuYw0KPj4g
KysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zcGktbm9yLmMNCj4+IEBAIC0yODY4LDcgKzI4Njgs
NyBAQCBzdGF0aWMgY29uc3QgdTMyICpzcGlfbm9yX2dldF9tYXBfaW5fdXNlKHN0cnVjdCBzcGlf
bm9yICpub3IsIGNvbnN0IHUzMiAqc21wdCwNCj4+ICAJY29uc3QgdTMyICpyZXQgPSBOVUxMOw0K
Pj4gIAl1MzIgYWRkcjsNCj4+ICAJaW50IGVycjsNCj4+IC0JdTggaTsNCj4+ICsJdTggaSwgbmNt
ZHMsIG5tYXBzOw0KPj4gIAl1OCBhZGRyX3dpZHRoLCByZWFkX29wY29kZSwgcmVhZF9kdW1teTsN
Cj4+ICAJdTggcmVhZF9kYXRhX21hc2ssIGRhdGFfYnl0ZSwgbWFwX2lkOw0KPj4gIA0KPj4gQEAg
LTI4NzcsNiArMjg3Nyw3IEBAIHN0YXRpYyBjb25zdCB1MzIgKnNwaV9ub3JfZ2V0X21hcF9pbl91
c2Uoc3RydWN0IHNwaV9ub3IgKm5vciwgY29uc3QgdTMyICpzbXB0LA0KPj4gIAlyZWFkX29wY29k
ZSA9IG5vci0+cmVhZF9vcGNvZGU7DQo+PiAgDQo+PiAgCW1hcF9pZCA9IDA7DQo+PiArCW5jbWRz
ID0gMDsNCj4+ICAJLyogRGV0ZXJtaW5lIGlmIHRoZXJlIGFyZSBhbnkgb3B0aW9uYWwgRGV0ZWN0
aW9uIENvbW1hbmQgRGVzY3JpcHRvcnMgKi8NCj4+ICAJZm9yIChpID0gMDsgaSA8IHNtcHRfbGVu
OyBpICs9IDIpIHsNCj4+ICAJCWlmIChzbXB0W2ldICYgU01QVF9ERVNDX1RZUEVfTUFQKQ0KPj4g
QEAgLTI4OTYsNiArMjg5Nyw3IEBAIHN0YXRpYyBjb25zdCB1MzIgKnNwaV9ub3JfZ2V0X21hcF9p
bl91c2Uoc3RydWN0IHNwaV9ub3IgKm5vciwgY29uc3QgdTMyICpzbXB0LA0KPj4gIAkJICogQ29u
ZmlndXJhdGlvbiB0aGF0IGlzIGN1cnJlbnRseSBpbiB1c2UuDQo+PiAgCQkgKi8NCj4+ICAJCW1h
cF9pZCA9IG1hcF9pZCA8PCAxIHwgISEoZGF0YV9ieXRlICYgcmVhZF9kYXRhX21hc2spOw0KPj4g
KwkJbmNtZHMrKzsNCj4+ICAJfQ0KPj4gIA0KPj4gIAkvKg0KPj4gQEAgLTI5MDUsNyArMjkwNywx
NiBAQCBzdGF0aWMgY29uc3QgdTMyICpzcGlfbm9yX2dldF9tYXBfaW5fdXNlKHN0cnVjdCBzcGlf
bm9yICpub3IsIGNvbnN0IHUzMiAqc21wdCwNCj4+ICAJICoNCj4+ICAJICogRmluZCB0aGUgbWF0
Y2hpbmcgY29uZmlndXJhdGlvbiBtYXAuDQo+PiAgCSAqLw0KPj4gLQl3aGlsZSAoaSA8IHNtcHRf
bGVuKSB7DQo+PiArCWZvciAobm1hcHMgPSAwOyBpIDwgc21wdF9sZW47IG5tYXBzKyspIHsNCj4+
ICsJCS8qDQo+PiArCQkgKiBUaGUgbWFwIHNlbGVjdG9yIGlzIGxpbWl0ZWQgdG8gYSBtYXhpbXVt
IG9mIDggYml0cywgYWxsb3dpbmcNCj4+ICsJCSAqIGZvciBhIG1heGltdW0gb2YgMjU2IHBvc3Np
YmxlIG1hcCBjb25maWd1cmF0aW9ucy4gVGhlIHRvdGFsDQo+PiArCQkgKiBudW1iZXIgb2YgbWFw
IGNvbmZpZ3VyYXRpb25zIHNob3VsZCBiZSBhZGRyZXNzYWJsZSBieSB0aGUNCj4+ICsJCSAqIHRv
dGFsIG51bWJlciBvZiBiaXRzIGRlc2NyaWJlZCBieSB0aGUgZGV0ZWN0aW9uIGNvbW1hbmRzLg0K
Pj4gKwkJICovDQo+PiArCQlpZiAobmNtZHMgJiYgbm1hcHMgPj0gKDEgPDwgKG5jbWRzICsgMSkp
KQ0KPj4gKwkJCWJyZWFrOw0KPj4gKw0KPiANCj4gTWF5YmUgSSBtaXNzZWQgc29tZXRoaW5nIGJ1
dCBpdCBzb3VuZHMgbGlrZSB0aGlzIGNoYW5nZSBpcyBqdXN0DQo+IG9wdGltaXppbmcgdGhlIFNQ
TVQgcGFyc2luZyBhIGJpdCwgYW5kIHRvIGJlIGhvbmVzdCwgSSdtIG5vdCBzdXJlIHRoaXMNCj4g
aXMgcmVhbGx5IG5lZWRlZC4gTW9zdCBvZiB0aGUgdGltZSwgc21wdF9sZW4gd2lsbCBiZSByYXRo
ZXIgc21hbGwsIHNvDQo+IHRyeWluZyB0byBiYWlsIG91dCBlYXJsaWVyIGlzIG5vdCBicmluZ2lu
ZyBtdWNoIHBlcmYgaW1wcm92ZW1lbnRzLg0KDQpJdCdzIHJhdGhlciBhIHNtdHAgdmFsaWRpdHkg
Y2hlY2suIEkgd2FudCB0byByZXR1cm4gYW4gZXJyb3IgaWYgdGhlcmUgYXJlIG5vdA0KZW5vdWdo
IGRldGVjdGlvbiBjb21tYW5kcyB0byBpZGVudGlmeSB0aGUgbWFwIGlkLg0KDQpDaGVlcnMsDQp0
YQ0K
