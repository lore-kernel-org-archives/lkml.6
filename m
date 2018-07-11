Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87578C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C9E2083C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C9E2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbeGKJpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:45:46 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:33599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726812AbeGKJpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:45:45 -0400
Received: from DGGEMA404-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id EAB7C9FF6F0A2;
        Wed, 11 Jul 2018 17:42:11 +0800 (CST)
Received: from DGGEMA525-MBX.china.huawei.com ([169.254.6.69]) by
 DGGEMA404-HUB.china.huawei.com ([10.3.20.45]) with mapi id 14.03.0382.000;
 Wed, 11 Jul 2018 17:42:02 +0800
From:   "Songxiaowei (Kirin_DRV)" <songxiaowei@hisilicon.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Wangbinghui <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>,
        "chenyao (F)" <chenyao11@huawei.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjcgMS8xXSBQQ0k6IGtpcmluOiBBZGQgTVNJIHN1?=
 =?utf-8?Q?pport?=
Thread-Topic: [PATCH v7 1/1] PCI: kirin: Add MSI support
Thread-Index: AQHUGO6PA45Gy6FIEku6EeNhdo92bKSJO5mAgACJJuA=
Date:   Wed, 11 Jul 2018 09:42:01 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C5412D7FFB@dggema525-mbx.china.huawei.com>
References: <20180711080946.14942-1-songxiaowei@hisilicon.com>
 <20180711080946.14942-2-songxiaowei@hisilicon.com>
 <CAHp75VccZtHqpoeWhVa=D=tc_Dj5cX8SXg=vYowWJ_RAiKdiCQ@mail.gmail.com>
In-Reply-To: <CAHp75VccZtHqpoeWhVa=D=tc_Dj5cX8SXg=vYowWJ_RAiKdiCQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.142.52.233]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmsgeW91IGEgbG90Lg0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvd2VpLg0K
DQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBBbmR5IFNoZXZjaGVua28g
W21haWx0bzphbmR5LnNoZXZjaGVua29AZ21haWwuY29tXQ0KPiDlj5HpgIHml7bpl7Q6IDIwMTjl
ubQ35pyIMTHml6UgMTc6MzANCj4g5pS25Lu25Lq6OiBTb25neGlhb3dlaSAoS2lyaW5fRFJWKSA8
c29uZ3hpYW93ZWlAaGlzaWxpY29uLmNvbT4NCj4g5oqE6YCBOiBXYW5nYmluZ2h1aSA8d2FuZ2Jp
bmdodWlAaGlzaWxpY29uLmNvbT47IEJqb3JuIEhlbGdhYXMNCj4gPGJoZWxnYWFzQGdvb2dsZS5j
b20+OyBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47DQo+IFJv
YiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3Jn
OyBMaW51eCBLZXJuZWwNCj4gTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsgU3V6aHVhbmdsdWFuDQo+IDxzdXpodWFuZ2x1YW5AaGlzaWxpY29uLmNvbT47IEtvbmdm
ZWkgPGtvbmdmZWlAaGlzaWxpY29uLmNvbT47IGNoZW55YW8NCj4gKEYpIDxjaGVueWFvMTFAaHVh
d2VpLmNvbT4NCj4g5Li76aKYOiBSZTogW1BBVENIIHY3IDEvMV0gUENJOiBraXJpbjogQWRkIE1T
SSBzdXBwb3J0DQo+IA0KPiBPbiBXZWQsIEp1bCAxMSwgMjAxOCBhdCAxMTowOSBBTSwgWGlhb3dl
aSBTb25nDQo+IDxzb25neGlhb3dlaUBoaXNpbGljb24uY29tPiB3cm90ZToNCj4gPiBBZGQgc3Vw
cG9ydCBmb3IgTVNJDQo+ID4NCj4gDQo+IEZXSVcsDQo+IFJldmlld2VkLWJ5OiBBbmR5IFNoZXZj
aGVua28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFhpYW93ZWkgU29uZyA8c29uZ3hpYW93ZWlAaGlzaWxpY29uLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBZYW8gQ2hlbiA8Y2hlbnlhbzExQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcGNpL2R3Yy9wY2llLWtpcmluLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9wY2kvZHdjL3BjaWUta2lyaW4uYw0KPiA+IGIvZHJpdmVycy9wY2kvZHdj
L3BjaWUta2lyaW4uYyBpbmRleCBkMjk3MGEwMDllYjUuLjUzNTJlMGMzYmU4Mg0KPiAxMDA2NDQN
Cj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9kd2MvcGNpZS1raXJpbi5jDQo+ID4gKysrIGIvZHJpdmVy
cy9wY2kvZHdjL3BjaWUta2lyaW4uYw0KPiA+IEBAIC00MzAsNiArNDMwLDkgQEAgc3RhdGljIGlu
dCBraXJpbl9wY2llX2hvc3RfaW5pdChzdHJ1Y3QgcGNpZV9wb3J0DQo+ID4gKnBwKSAgew0KPiA+
ICAgICAgICAga2lyaW5fcGNpZV9lc3RhYmxpc2hfbGluayhwcCk7DQo+ID4NCj4gPiArICAgICAg
IGlmIChJU19FTkFCTEVEKENPTkZJR19QQ0lfTVNJKSkNCj4gPiArICAgICAgICAgICAgICAgZHdf
cGNpZV9tc2lfaW5pdChwcCk7DQo+ID4gKw0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gIH0N
Cj4gPg0KPiA+IEBAIC00NDUsOSArNDQ4LDM0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNp
ZV9ob3N0X29wcw0KPiBraXJpbl9wY2llX2hvc3Rfb3BzID0gew0KPiA+ICAgICAgICAgLmhvc3Rf
aW5pdCA9IGtpcmluX3BjaWVfaG9zdF9pbml0LCAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgaW50IGtp
cmluX3BjaWVfYWRkX21zaShzdHJ1Y3QgZHdfcGNpZSAqcGNpLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsg
ICAgICAgaW50IGlycTsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoSVNfRU5BQkxFRChDT05GSUdf
UENJX01TSSkpIHsNCj4gPiArICAgICAgICAgICAgICAgaXJxID0gcGxhdGZvcm1fZ2V0X2lycShw
ZGV2LCAwKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGlycSA8IDApIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAiZmFpbGVkIHRvIGdldCBNU0kgSVJRICglZClcbiIsIGlycSk7DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGlycTsNCj4gPiArICAgICAgICAgICAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgcGNpLT5wcC5tc2lfaXJxID0gaXJxOw0K
PiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICBzdGF0aWMgaW50IF9faW5pdCBraXJpbl9hZGRfcGNpZV9wb3J0KHN0cnVjdCBkd19w
Y2llICpwY2ksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiB7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArICAgICAgIHJldCA9IGtpcmluX3BjaWVfYWRkX21zaShwY2ksIHBkZXYpOw0KPiA+
ICsgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiAr
DQo+ID4gICAgICAgICBwY2ktPnBwLm9wcyA9ICZraXJpbl9wY2llX2hvc3Rfb3BzOw0KPiA+DQo+
ID4gICAgICAgICByZXR1cm4gZHdfcGNpZV9ob3N0X2luaXQoJnBjaS0+cHApOw0KPiA+IC0tDQo+
ID4gMi4xMS5HSVQNCj4gPg0KPiANCj4gDQo+IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywN
Cj4gQW5keSBTaGV2Y2hlbmtvDQo=
