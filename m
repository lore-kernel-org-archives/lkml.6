Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C1DC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D352420BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D352420BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbeGLBHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:07:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733236AbeGLBHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:07:36 -0400
Received: from DGGEMA401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id D047F6CD5459F;
        Thu, 12 Jul 2018 09:00:34 +0800 (CST)
Received: from DGGEMA422-HUB.china.huawei.com (10.1.198.155) by
 DGGEMA401-HUB.china.huawei.com (10.3.20.42) with Microsoft SMTP Server (TLS)
 id 14.3.382.0; Thu, 12 Jul 2018 09:00:36 +0800
Received: from DGGEMA525-MBX.china.huawei.com ([169.254.6.69]) by
 dggema422-hub.china.huawei.com ([10.1.198.155]) with mapi id 14.03.0382.000;
 Thu, 12 Jul 2018 09:00:26 +0800
From:   "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Wangbinghui <wangbinghui@hisilicon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Kongfei <kongfei@hisilicon.com>,
        "chenyao (F)" <chenyao11@huawei.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIHY3IDEvMV0gUENJOiBraXJpbjogQWRkIE1TSSBzdXBw?=
 =?gb2312?Q?ort?=
Thread-Topic: [PATCH v7 1/1] PCI: kirin: Add MSI support
Thread-Index: AQHUGO6PA45Gy6FIEku6EeNhdo92bKSJXfmAgAFmRIA=
Date:   Thu, 12 Jul 2018 01:00:25 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C5412D982C@dggema525-mbx.china.huawei.com>
References: <20180711080946.14942-1-songxiaowei@hisilicon.com>
 <20180711080946.14942-2-songxiaowei@hisilicon.com>
 <20180711113323.GA17546@red-moon>
In-Reply-To: <20180711113323.GA17546@red-moon>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.52.233]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGEgbG90Lg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvd2VpIFNv
bmcuDQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogTG9yZW56byBQaWVyYWxpc2kg
W21haWx0bzpsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tXQ0KPiC3osvNyrG85DogMjAxOMTqN9TC
MTHI1SAxOTozMw0KPiDK1bz+yMs6IFNvbmd4aWFvd2VpIChLaXJpbl9EUlYpIDxzb25neGlhb3dl
aUBoaXNpbGljb24uY29tPg0KPiCzrcvNOiBXYW5nYmluZ2h1aSA8d2FuZ2JpbmdodWlAaGlzaWxp
Y29uLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4g
U3V6aHVhbmdsdWFuIDxzdXpodWFuZ2x1YW5AaGlzaWxpY29uLmNvbT47IGFuZHkuc2hldmNoZW5r
b0BnbWFpbC5jb207DQo+IEtvbmdmZWkgPGtvbmdmZWlAaGlzaWxpY29uLmNvbT47IGNoZW55YW8g
KEYpIDxjaGVueWFvMTFAaHVhd2VpLmNvbT4NCj4g1vfM4jogUmU6IFtQQVRDSCB2NyAxLzFdIFBD
SToga2lyaW46IEFkZCBNU0kgc3VwcG9ydA0KPiANCj4gT24gV2VkLCBKdWwgMTEsIDIwMTggYXQg
MDQ6MDk6NDZQTSArMDgwMCwgWGlhb3dlaSBTb25nIHdyb3RlOg0KPiA+IEFkZCBzdXBwb3J0IGZv
ciBNU0kNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgU29uZyA8c29uZ3hpYW93ZWlA
aGlzaWxpY29uLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZYW8gQ2hlbiA8Y2hlbnlhbzExQGh1
YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2R3Yy9wY2llLWtpcmluLmMgfCAy
OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBp
bnNlcnRpb25zKCspDQo+IA0KPiBBcHBsaWVkIHRvIHBjaS9kd2MgZm9yIHY0LjE5LCB0aGFua3Mu
DQo+IA0KPiBMb3JlbnpvDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9kd2MvcGNp
ZS1raXJpbi5jDQo+ID4gYi9kcml2ZXJzL3BjaS9kd2MvcGNpZS1raXJpbi5jIGluZGV4IGQyOTcw
YTAwOWViNS4uNTM1MmUwYzNiZTgyDQo+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2R3
Yy9wY2llLWtpcmluLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9kd2MvcGNpZS1raXJpbi5jDQo+
ID4gQEAgLTQzMCw2ICs0MzAsOSBAQCBzdGF0aWMgaW50IGtpcmluX3BjaWVfaG9zdF9pbml0KHN0
cnVjdCBwY2llX3BvcnQNCj4gPiAqcHApICB7DQo+ID4gIAlraXJpbl9wY2llX2VzdGFibGlzaF9s
aW5rKHBwKTsNCj4gPg0KPiA+ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BDSV9NU0kpKQ0KPiA+
ICsJCWR3X3BjaWVfbXNpX2luaXQocHApOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9
DQo+ID4NCj4gPiBAQCAtNDQ1LDkgKzQ0OCwzNCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGR3X3Bj
aWVfaG9zdF9vcHMNCj4ga2lyaW5fcGNpZV9ob3N0X29wcyA9IHsNCj4gPiAgCS5ob3N0X2luaXQg
PSBraXJpbl9wY2llX2hvc3RfaW5pdCwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgaW50IGtp
cmluX3BjaWVfYWRkX21zaShzdHJ1Y3QgZHdfcGNpZSAqcGNpLA0KPiA+ICsJCQkJc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsJaW50IGlycTsNCj4gPiArDQo+ID4g
KwlpZiAoSVNfRU5BQkxFRChDT05GSUdfUENJX01TSSkpIHsNCj4gPiArCQlpcnEgPSBwbGF0Zm9y
bV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ICsJCWlmIChpcnEgPCAwKSB7DQo+ID4gKwkJCWRldl9l
cnIoJnBkZXYtPmRldiwNCj4gPiArCQkJCSJmYWlsZWQgdG8gZ2V0IE1TSSBJUlEgKCVkKVxuIiwg
aXJxKTsNCj4gPiArCQkJcmV0dXJuIGlycTsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXBjaS0+
cHAubXNpX2lycSA9IGlycTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiAr
fQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBfX2luaXQga2lyaW5fYWRkX3BjaWVfcG9ydChzdHJ1
Y3QgZHdfcGNpZSAqcGNpLA0KPiA+ICAJCQkJICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikgIHsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0ga2lyaW5fcGNpZV9h
ZGRfbXNpKHBjaSwgcGRldik7DQo+ID4gKwlpZiAocmV0KQ0KPiA+ICsJCXJldHVybiByZXQ7DQo+
ID4gKw0KPiA+ICAJcGNpLT5wcC5vcHMgPSAma2lyaW5fcGNpZV9ob3N0X29wczsNCj4gPg0KPiA+
ICAJcmV0dXJuIGR3X3BjaWVfaG9zdF9pbml0KCZwY2ktPnBwKTsNCj4gPiAtLQ0KPiA+IDIuMTEu
R0lUDQo+ID4NCg==
