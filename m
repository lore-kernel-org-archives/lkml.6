Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACA9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E401E208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E401E208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeGPL3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 07:29:07 -0400
Received: from asrmicro.com ([210.13.118.86]:24521 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727775AbeGPL3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 07:29:07 -0400
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 16 Jul
 2018 19:01:34 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Mon, 16 Jul 2018 19:01:34 +0800
From:   =?utf-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= 
        <hongjiefang@asrmicro.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        Bastian Stender <bst@pengutronix.de>,
        Jin Qian <jinqian@google.com>, Chanho Min <chanho.min@lge.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Topic: [PATCH V2] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Index: AQHUGMNhtrBnhjWARU2PBNkn39YK8aSRIzQAgACSntA=
Date:   Mon, 16 Jul 2018 11:01:33 +0000
Message-ID: <d3ffea436c92408098e5e85fb0dd4cd8@mail2012.asrmicro.com>
References: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
 <CAPDyKFpv_zedwgDRmHTUadaDYb-xBQLFRV0sAk116YbjOhY+GA@mail.gmail.com>
In-Reply-To: <CAPDyKFpv_zedwgDRmHTUadaDYb-xBQLFRV0sAk116YbjOhY+GA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.170.195]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMSBKdWx5IDIwMTggYXQgMDU6MDAsIEhvbmdqaWUgRmFuZyA8aG9uZ2ppZWZhbmdAYXNy
bWljcm8uY29tPiB3cm90ZToNCj4gPiBtbWNfc2VsZWN0X2hzNDAwZXMoKSBjYWxscyBtbWNfc2Vs
ZWN0X2J1c193aWR0aCgpIHdoaWNoIHdpbGwgY29udGludWUNCj4gPiB0byBzZXQgNGJpdCB0cmFu
c2ZlciBtb2RlIGlmIGZhaWwgdG8gc2V0IDhiaXQgbW9kZS4gVGhlIGJ1cyB3aWR0aA0KPiA+IHNo
b3VsZCBub3QgYmUgc2V0IHRvIDRiaXQgaW4gSFM0MDBlcy4NCj4gPg0KPiA+IFdoZW4gZmFpbCB0
byBzZXQgOGJpdCBtb2RlLCBuZWVkIHJldHVybiBlcnJvciBkaXJlY3RseSBmb3IgSFM0MDBlcy4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvbmdqaWUgRmFuZyA8aG9uZ2ppZWZhbmdAYXNybWlj
cm8uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL21tYy5jIHwgNSArKysrLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYyBiL2RyaXZlcnMvbW1jL2Nv
cmUvbW1jLmMNCj4gPiBpbmRleCA0NDY2ZjVkLi40YmQ2YzA5IDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQo+
ID4gQEAgLTEwMjEsOCArMTAyMSwxMSBAQCBzdGF0aWMgaW50IG1tY19zZWxlY3RfYnVzX3dpZHRo
KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFWFRfQ1NEX0JVU19XSURUSCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBleHRfY3NkX2JpdHNbaWR4XSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjYXJkLT5leHRfY3NkLmdlbmVyaWNfY21kNl90aW1lKTsNCj4gPiAtICAgICAgICAgICAg
ICAgaWYgKGVycikNCj4gPiArICAgICAgICAgICAgICAgaWYgKGVycikgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGlmIChjYXJkLT5tbWNfYXZhaWxfdHlwZSAmIEVYVF9DU0RfQ0FSRF9U
WVBFX0hTNDAwRVMpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
ZXJyOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsgICAgICAg
ICAgICAgICB9DQo+IA0KPiBJIHdvdWxkIHJhdGhlciBsZXQgbW1jX3NlbGVjdF9oczQwMGVzKCkg
Y2hlY2sgdGhlIHJldHVybiBjb2RlIGZyb20NCj4gbW1jX3NlbGVjdF9idXNfd2lkdGgoKS4NCj4g
DQo+IFNvLCBpZiB0aGUgcmV0dXJuIGNvZGUgaXNuJ3QgTU1DX0JVU19XSURUSF84LCBtbWNfc2Vs
ZWN0X2hzNDAwZXMoKQ0KPiBzaG91bGQgYmFpbCBvdXQuDQoNClllYWgsIGl0IGlzIGJldHRlciB0
aGF0IGxldCBtbWNfc2VsZWN0X2hzNDAwZXMoKSBjaGVjayB0aGUgcmV0dXJuIHZhbHVlLg0KSSB3
aWxsIHVwZGF0ZSB0aGUgcGF0Y2guDQoNCj4gDQo+IFsuLi5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMN
Cj4gVWZmZQ0KDQoNCkImUg0KSG9uZ2ppZQ0K
