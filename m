Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E137C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1E82086B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E1E82086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbeGKHjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:39:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:5997 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbeGKHjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:39:36 -0400
Received: from DGGEMA402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id C4510DF2366C7;
        Wed, 11 Jul 2018 15:36:37 +0800 (CST)
Received: from DGGEMA525-MBX.china.huawei.com ([169.254.6.69]) by
 DGGEMA402-HUB.china.huawei.com ([10.3.20.43]) with mapi id 14.03.0382.000;
 Wed, 11 Jul 2018 15:36:26 +0800
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
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjYgMS8xXSBQQ0k6IGtpcmluOiBBZGQgTVNJIHN1?=
 =?utf-8?Q?pport?=
Thread-Topic: [PATCH v6 1/1] PCI: kirin: Add MSI support
Thread-Index: AQHUGORyMNS4PSIcv0aZRcALGcOeqqSJGDoAgACIgQA=
Date:   Wed, 11 Jul 2018 07:36:26 +0000
Message-ID: <99B4C6BADD9E3241B25E52B02BA737C5412D7DD8@dggema525-mbx.china.huawei.com>
References: <20180711065724.128299-1-songxiaowei@hisilicon.com>
 <20180711065724.128299-2-songxiaowei@hisilicon.com>
 <CAHp75VfqGC5KNi4mCc3Q0bD0jXb4bkkdYFSv3LDQw5E=goc2Pg@mail.gmail.com>
In-Reply-To: <CAHp75VfqGC5KNi4mCc3Q0bD0jXb4bkkdYFSv3LDQw5E=goc2Pg@mail.gmail.com>
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

DQoNCj4gLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0KPiDlj5Hku7bkuro6IEFuZHkgU2hldmNoZW5r
byBbbWFpbHRvOmFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb21dDQo+IOWPkemAgeaXtumXtDogMjAx
OOW5tDfmnIgxMeaXpSAxNToyMw0KPiDmlLbku7bkuro6IFNvbmd4aWFvd2VpIChLaXJpbl9EUlYp
IDxzb25neGlhb3dlaUBoaXNpbGljb24uY29tPg0KPiDmioTpgIE6IFdhbmdiaW5naHVpIDx3YW5n
YmluZ2h1aUBoaXNpbGljb24uY29tPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29vZ2xl
LmNvbT47IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsNCj4g
Um9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5v
cmc7IExpbnV4IEtlcm5lbA0KPiBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+OyBTdXpodWFuZ2x1YW4NCj4gPHN1emh1YW5nbHVhbkBoaXNpbGljb24uY29tPjsgS29u
Z2ZlaSA8a29uZ2ZlaUBoaXNpbGljb24uY29tPjsgY2hlbnlhbw0KPiAoRikgPGNoZW55YW8xMUBo
dWF3ZWkuY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0ggdjYgMS8xXSBQQ0k6IGtpcmluOiBBZGQg
TVNJIHN1cHBvcnQNCj4gDQo+IE9uIFdlZCwgSnVsIDExLCAyMDE4IGF0IDk6NTcgQU0sIFhpYW93
ZWkgU29uZyA8c29uZ3hpYW93ZWlAaGlzaWxpY29uLmNvbT4NCj4gd3JvdGU6DQo+ID4gQWRkIHN1
cHBvcnQgZm9yIE1TSQ0KPiANCj4gPiArc3RhdGljIGludCBraXJpbl9wY2llX2FkZF9tc2koc3Ry
dWN0IGR3X3BjaWUgKnBjaSwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpIHsNCj4gPiArICAgICAgIGludCByZXQgPSAwOw0K
PiA+ICsNCj4gPiArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19QQ0lfTVNJKSkgew0KPiA+
ICsgICAgICAgICAgICAgICByZXQgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGRldl9lcnIoJnBkZXYtPmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJmYWlsZWQgdG8gZ2V0IE1TSSBJUlEgKCVkKVxuIiwgcmV0KTsNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+
ICsgICAgICAgICAgICAgICBwY2ktPnBwLm1zaV9pcnEgPSByZXQ7DQo+ID4gKyAgICAgICB9DQo+
ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiArfQ0KPiANCj4gTGlrZSBzb21lb25l
IGFscmVhZHkgbm90aWNlZCwgaXMgaXQgcmVhbGx5IElSUSBudW1iZXIgeW91IHdvdWxkIGxpa2Ug
dG8NCj4gcmV0dXJuPw0KPiANCj4gSWYgeW91IHJld3JpdGUgbGlrZQ0KPiANCj4gaW50IGlycTsN
Cj4gDQo+IGlmIChJU19FTkFCTEVEKC4uLikpIHsNCj4gIGlycSA9IC4uLg0KPiAgaWYgKGlycSA8
IDApDQo+ICAgIHJldHVybiBpcnE7DQo+IA0KPiAuLi4gPSBpcnE7DQo+IA0KPiB9DQo+IA0KPiBy
ZXR1cm4gMDsNCj4gDQo+IEl0IHdvdWxkIGJlIHNsaWdodGx5IG1vcmUgZXhwbGljaXQgd2hhdCB5
b3UgZG8gYW5kIHdoYXQgeW91IHJldHVybi4NCj4NCg0KSGkgQW5keQ0KSSB0aGluayBkaWQgbm90
IGdldCBMb3JlbnpvJ3MgbWVhbmluZyBiZWZvcmUsIHRoYW5rIHlvdSBzbyBtdWNoLCBhbmQgSSds
bCBtb2RpZnkgdGhlIHBhdGNoIGFzIHNvb24gYXMgcG9zc2libGUuDQpCZXN0IFJlZ2FyZHMsDQpY
aWFvd2VpIFNvbmcuDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVu
a28NCg==
