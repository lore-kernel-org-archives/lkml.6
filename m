Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7AFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35D120870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35D120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeIJVuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:50:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2076 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727989AbeIJVuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:50:16 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 119755BBF255A;
        Mon, 10 Sep 2018 17:55:12 +0100 (IST)
Received: from FRAEML703-CAH.china.huawei.com (10.206.14.34) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.399.0; Mon, 10 Sep 2018 17:55:13 +0100
Received: from FRAEML521-MBX.china.huawei.com ([169.254.1.206]) by
 fraeml703-cah.china.huawei.com ([10.206.14.34]) with mapi id 14.03.0399.000;
 Mon, 10 Sep 2018 18:55:02 +0200
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "will.deacon@arm.com" <will.deacon@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "pabba@codeaurora.org" <pabba@codeaurora.org>,
        "vkilari@codeaurora.org" <vkilari@codeaurora.org>,
        "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "neil.m.leeder@gmail.com" <neil.m.leeder@gmail.com>
Subject: RE: [PATCH v2 4/4] perf/smmuv3: Add MSI irq support
Thread-Topic: [PATCH v2 4/4] perf/smmuv3: Add MSI irq support
Thread-Index: AQHUI0QE+k63fzhGCkW3TzgM8AJk0aTphtgAgACAI4A=
Date:   Mon, 10 Sep 2018 16:55:01 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8387859B3@FRAEML521-MBX.china.huawei.com>
References: <20180724114515.21764-1-shameerali.kolothum.thodi@huawei.com>
 <20180724114515.21764-5-shameerali.kolothum.thodi@huawei.com>
 <612e1c45-bfa8-b411-ba69-7e7d6047337d@arm.com>
In-Reply-To: <612e1c45-bfa8-b411-ba69-7e7d6047337d@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IDEwIFNlcHRlbWJlciAyMDE4IDEy
OjE1DQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVt
LnRob2RpQGh1YXdlaS5jb20+Ow0KPiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tDQo+IENjOiB3
aWxsLmRlYWNvbkBhcm0uY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgR3VvaGFuanVuIChIYW5q
dW4gR3VvKQ0KPiA8Z3VvaGFuanVuQGh1YXdlaS5jb20+OyBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5
QGh1YXdlaS5jb20+Ow0KPiBwYWJiYUBjb2RlYXVyb3JhLm9yZzsgdmtpbGFyaUBjb2RlYXVyb3Jh
Lm9yZzsgcnJ1aWdyb2tAY29kZWF1cm9yYS5vcmc7DQo+IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47DQo+IG5l
aWwubS5sZWVkZXJAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgNC80XSBwZXJm
L3NtbXV2MzogQWRkIE1TSSBpcnEgc3VwcG9ydA0KPiANCj4gT24gMjAxOC0wNy0yNCAxMjo0NSBQ
TSwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgTVNJ
IGJhc2VkIGNvdW50ZXIgb3ZlcmZsb3cgaW50ZXJydXB0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2hhbWVlciBLb2xvdGh1bSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMgfCAxMDUNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgODQgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMNCj4gYi9kcml2ZXJzL3BlcmYv
YXJtX3NtbXV2M19wbXUuYw0KPiA+IGluZGV4IGIzZGMzOTQuLmNhNjk4MTMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wZXJmL2FybV9zbW11djNfcG11LmMNCj4gPiArKysgYi9kcml2ZXJzL3Bl
cmYvYXJtX3NtbXV2M19wbXUuYw0KPiA+IEBAIC05NCw2ICs5NCwxMCBAQA0KPiA+ICAgI2RlZmlu
ZSBTTU1VX1BNQ0dfSVJRX0NGRzIgICAgICAgICAgICAgIDB4RTY0DQo+ID4gICAjZGVmaW5lIFNN
TVVfUE1DR19JUlFfU1RBVFVTICAgICAgICAgICAgMHhFNjgNCj4gPg0KPiA+ICsvKiBNU0kgY29u
ZmlnIGZpZWxkcyAqLw0KPiA+ICsjZGVmaW5lIE1TSV9DRkcwX0FERFJfTUFTSyAgICAgICAgICAg
ICAgR0VOTUFTS19VTEwoNTEsIDIpDQo+ID4gKyNkZWZpbmUgTVNJX0NGRzJfTUVNQVRUUl9ERVZJ
Q0VfbkduUkUgICAweDENCj4gPiArDQo+ID4gICAjZGVmaW5lIFNNTVVfQ09VTlRFUl9SRUxPQUQg
ICAgICAgICAgICAgQklUKDMxKQ0KPiA+ICAgI2RlZmluZSBTTU1VX0RFRkFVTFRfRklMVEVSX1NF
QyAgICAgICAgIDANCj4gPiAgICNkZWZpbmUgU01NVV9ERUZBVUxUX0ZJTFRFUl9TUEFOICAgICAg
ICAxDQo+ID4gQEAgLTY1NywxNCArNjYxLDg5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBzbW11X3Bt
dV9oYW5kbGVfaXJxKGludA0KPiBpcnFfbnVtLCB2b2lkICpkYXRhKQ0KPiA+ICAgCXJldHVybiBJ
UlFfSEFORExFRDsNCj4gPiAgIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBzbW11X3BtdV9mcmVl
X21zaXModm9pZCAqZGF0YSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gZGF0
YTsNCj4gPiArDQo+ID4gKwlwbGF0Zm9ybV9tc2lfZG9tYWluX2ZyZWVfaXJxcyhkZXYpOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBzbW11X3BtdV93cml0ZV9tc2lfbXNnKHN0cnVj
dCBtc2lfZGVzYyAqZGVzYywgc3RydWN0DQo+IG1zaV9tc2cgKm1zZykNCj4gPiArew0KPiA+ICsJ
cGh5c19hZGRyX3QgZG9vcmJlbGw7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtc2lfZGVz
Y190b19kZXYoZGVzYyk7DQo+ID4gKwlzdHJ1Y3Qgc21tdV9wbXUgKnBtdSA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOw0KPiA+ICsNCj4gPiArCWRvb3JiZWxsID0gKCgodTY0KW1zZy0+YWRkcmVzc19o
aSkgPDwgMzIpIHwgbXNnLT5hZGRyZXNzX2xvOw0KPiA+ICsJZG9vcmJlbGwgJj0gTVNJX0NGRzBf
QUREUl9NQVNLOw0KPiA+ICsNCj4gPiArCXdyaXRlcV9yZWxheGVkKGRvb3JiZWxsLCBwbXUtPnJl
Z19iYXNlICsgU01NVV9QTUNHX0lSUV9DRkcwKTsNCj4gPiArCXdyaXRlbF9yZWxheGVkKG1zZy0+
ZGF0YSwgcG11LT5yZWdfYmFzZSArDQo+IFNNTVVfUE1DR19JUlFfQ0ZHMSk7DQo+ID4gKwl3cml0
ZWxfcmVsYXhlZChNU0lfQ0ZHMl9NRU1BVFRSX0RFVklDRV9uR25SRSwNCj4gPiArCQkJCXBtdS0+
cmVnX2Jhc2UgKyBTTU1VX1BNQ0dfSVJRX0NGRzIpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgdm9pZCBzbW11X3BtdV9zZXR1cF9tc2koc3RydWN0IHNtbXVfcG11ICpwbXUpDQo+ID4gK3sN
Cj4gPiArCXN0cnVjdCBtc2lfZGVzYyAqZGVzYzsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9
IHBtdS0+ZGV2Ow0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwkvKiBDbGVhciBNU0kgYWRk
cmVzcyByZWcgKi8NCj4gPiArCXdyaXRlcV9yZWxheGVkKDAsIHBtdS0+cmVnX2Jhc2UgKyBTTU1V
X1BNQ0dfSVJRX0NGRzApOw0KPiA+ICsNCj4gPiArCS8qIE1TSSBzdXBwb3J0ZWQgb3Igbm90ICov
DQo+ID4gKwlpZiAoIShyZWFkbChwbXUtPnJlZ19iYXNlICsgU01NVV9QTUNHX0NGR1IpICYNCj4g
U01NVV9QTUNHX0NGR1JfTVNJKSkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJcmV0ID0g
cGxhdGZvcm1fbXNpX2RvbWFpbl9hbGxvY19pcnFzKGRldiwgMSwNCj4gc21tdV9wbXVfd3JpdGVf
bXNpX21zZyk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X3dhcm4oZGV2LCAiZmFpbGVk
IHRvIGFsbG9jYXRlIE1TSXNcbiIpOw0KPiA+ICsJCXJldHVybjsNCj4gPiArCX0NCj4gPiArDQo+
ID4gKwlkZXNjID0gZmlyc3RfbXNpX2VudHJ5KGRldik7DQo+ID4gKwlpZiAoZGVzYykNCj4gPiAr
CQlwbXUtPmlycSA9IGRlc2MtPmlycTsNCj4gPiArDQo+ID4gKwkvKiBBZGQgY2FsbGJhY2sgdG8g
ZnJlZSBNU0lzIG9uIHRlYXJkb3duICovDQo+ID4gKwlkZXZtX2FkZF9hY3Rpb24oZGV2LCBzbW11
X3BtdV9mcmVlX21zaXMsIGRldik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc21t
dV9wbXVfc2V0dXBfaXJxKHN0cnVjdCBzbW11X3BtdSAqcG11KQ0KPiA+ICt7DQo+ID4gKwlpbnQg
aXJxLCByZXQgPSAtRU5YSU87DQo+ID4gKw0KPiA+ICsJc21tdV9wbXVfc2V0dXBfbXNpKHBtdSk7
DQo+ID4gKw0KPiA+ICsJaXJxID0gcG11LT5pcnE7DQo+ID4gKwlpZiAoaXJxKQ0KPiA+ICsJCXJl
dCA9IGRldm1fcmVxdWVzdF9pcnEocG11LT5kZXYsIGlycSwNCj4gc21tdV9wbXVfaGFuZGxlX2ly
cSwNCj4gPiArCQkJICAgICAgIElSUUZfTk9CQUxBTkNJTkcgfCBJUlFGX1NIQVJFRCB8DQo+IElS
UUZfTk9fVEhSRUFELA0KPiA+ICsJCQkgICAgICAgInNtbXUtdjMtcG11IiwgcG11KTsNCj4gPiAr
CXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgaW50IHNtbXVfcG11X3Jl
c2V0KHN0cnVjdCBzbW11X3BtdSAqc21tdV9wbXUpDQo+ID4gICB7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+ICsNCj4gPiAgIAkvKiBEaXNhYmxlIGNvdW50ZXIgYW5kIGludGVycnVwdCAqLw0KPiA+ICAg
CXdyaXRlcShzbW11X3BtdS0+Y291bnRlcl9wcmVzZW50X21hc2ssDQo+ID4gICAJCQlzbW11X3Bt
dS0+cmVnX2Jhc2UgKyBTTU1VX1BNQ0dfQ05URU5DTFIwKTsNCj4gPiAgIAl3cml0ZXEoc21tdV9w
bXUtPmNvdW50ZXJfcHJlc2VudF9tYXNrLA0KPiA+ICAgCQlzbW11X3BtdS0+cmVnX2Jhc2UgKyBT
TU1VX1BNQ0dfSU5URU5DTFIwKTsNCj4gPg0KPiA+ICsJcmV0ID0gc21tdV9wbXVfc2V0dXBfaXJx
KHNtbXVfcG11KTsNCj4gDQo+IFdoeSBhcmUgd2UgbW92aW5nIHRoaXMgb3V0IG9mIHByb2JlPyBX
ZSBtYXkgcGVyZm9ybSBhIHJlc2V0IG1vcmUgdGhhbg0KPiBvbmNlIChlLmcuIGlmIHdlIGdldCBy
b3VuZCB0byBzeXN0ZW0gUE0gc3VwcG9ydCksIGF0IHdoaWNoIHBvaW50IHRoaXMNCj4gbG9va3Mg
bG9naWNhbGx5IHdyb25nLg0KDQpJIGRpZG7igJl0IGNvbnNpZGVyIHRoYXQgc2NlbmFyaW8uIEkg
d2lsbCBtb2RpZnkgdGhpcyBpbiBuZXh0Lg0KDQpUaGFua3MsDQpTaGFtZWVyDQoNCj4gUm9iaW4u
DQo+IA0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoc21tdV9wbXUtPmRldiwgImZh
aWxlZCB0byBzZXR1cCBpcnFzXG4iKTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCS8qIFBpY2sgb25lIENQVSB0byBiZSB0aGUgcHJlZmVycmVkIG9uZSB0byB1c2Ug
Ki8NCj4gPiArCXNtbXVfcG11LT5vbl9jcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+ID4gKwlX
QVJOX09OKGlycV9zZXRfYWZmaW5pdHkoc21tdV9wbXUtPmlycSwgY3B1bWFza19vZihzbW11X3Bt
dS0NCj4gPm9uX2NwdSkpKTsNCj4gPiArDQo+ID4gICAJc21tdV9wbXVfZGlzYWJsZSgmc21tdV9w
bXUtPnBtdSk7DQo+ID4gICAJcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4gQEAgLTczOCwyNiArODE3
LDggQEAgc3RhdGljIGludCBzbW11X3BtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+
ICpwZGV2KQ0KPiA+ICAgCX0NCj4gPg0KPiA+ICAgCWlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRl
diwgMCk7DQo+ID4gLQlpZiAoaXJxIDwgMCkgew0KPiA+IC0JCWRldl9lcnIoZGV2LCAiRmFpbGVk
IHRvIGdldCB2YWxpZCBpcnEgZm9yIHNtbXUgQCVwYVxuIiwNCj4gPiAtCQkJJm1lbV9yZXNvdXJj
ZV8wLT5zdGFydCk7DQo+ID4gLQkJcmV0dXJuIGlycTsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQll
cnIgPSBkZXZtX3JlcXVlc3RfaXJxKGRldiwgaXJxLCBzbW11X3BtdV9oYW5kbGVfaXJxLA0KPiA+
IC0JCQkgICAgICAgSVJRRl9OT0JBTEFOQ0lORyB8IElSUUZfU0hBUkVEIHwNCj4gSVJRRl9OT19U
SFJFQUQsDQo+ID4gLQkJCSAgICAgICAic21tdS1wbXUiLCBzbW11X3BtdSk7DQo+ID4gLQlpZiAo
ZXJyKSB7DQo+ID4gLQkJZGV2X2VycihkZXYsDQo+ID4gLQkJCSJVbmFibGUgdG8gcmVxdWVzdCBJ
UlElZCBmb3IgU01NVSBQTVUNCj4gY291bnRlcnNcbiIsIGlycSk7DQo+ID4gLQkJcmV0dXJuIGVy
cjsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gLQlzbW11X3BtdS0+aXJxID0gaXJxOw0KPiA+IC0NCj4g
PiAtCS8qIFBpY2sgb25lIENQVSB0byBiZSB0aGUgcHJlZmVycmVkIG9uZSB0byB1c2UgKi8NCj4g
PiAtCXNtbXVfcG11LT5vbl9jcHUgPSBzbXBfcHJvY2Vzc29yX2lkKCk7DQo+ID4gLQlXQVJOX09O
KGlycV9zZXRfYWZmaW5pdHkoc21tdV9wbXUtPmlycSwgY3B1bWFza19vZihzbW11X3BtdS0NCj4g
Pm9uX2NwdSkpKTsNCj4gPiArCWlmIChpcnEgPiAwKQ0KPiA+ICsJCXNtbXVfcG11LT5pcnEgPSBp
cnE7DQo+ID4NCj4gPiAgIAlzbW11X3BtdS0+bnVtX2NvdW50ZXJzID0gZ2V0X251bV9jb3VudGVy
cyhzbW11X3BtdSk7DQo+ID4gICAJc21tdV9wbXUtPmNvdW50ZXJfcHJlc2VudF9tYXNrID0gR0VO
TUFTSyhzbW11X3BtdS0NCj4gPm51bV9jb3VudGVycyAtIDEsIDApOw0KPiA+IEBAIC03NjUsNyAr
ODI2LDkgQEAgc3RhdGljIGludCBzbW11X3BtdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+ICpwZGV2KQ0KPiA+ICAgCQkgICAgU01NVV9QTUNHX0NGR1JfU0laRV9NQVNLKSA+Pg0KPiBT
TU1VX1BNQ0dfQ0ZHUl9TSVpFX1NISUZUOw0KPiA+ICAgCXNtbXVfcG11LT5jb3VudGVyX21hc2sg
PSBHRU5NQVNLX1VMTChyZWdfc2l6ZSwgMCk7DQo+ID4NCj4gPiAtCXNtbXVfcG11X3Jlc2V0KHNt
bXVfcG11KTsNCj4gPiArCWVyciA9IHNtbXVfcG11X3Jlc2V0KHNtbXVfcG11KTsNCj4gPiArCWlm
IChlcnIpDQo+ID4gKwkJcmV0dXJuIGVycjsNCj4gPg0KPiA+ICAgCWVyciA9IGNwdWhwX3N0YXRl
X2FkZF9pbnN0YW5jZV9ub2NhbGxzKGNwdWhwX3N0YXRlX251bSwNCj4gPiAgIAkJCQkJICAgICAg
ICZzbW11X3BtdS0+bm9kZSk7DQo+ID4NCg==
