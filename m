Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDC9ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0357D20779
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0357D20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeGPIui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:50:38 -0400
Received: from asrmicro.com ([210.13.118.86]:25650 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbeGPIui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:50:38 -0400
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 16 Jul
 2018 16:24:00 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Mon, 16 Jul 2018 16:24:00 +0800
From:   =?gb2312?B?RmFuZyBIb25namllKLe9uum93Ck=?= 
        <hongjiefang@asrmicro.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "bst@pengutronix.de" <bst@pengutronix.de>,
        "jinqian@google.com" <jinqian@google.com>,
        "chanho.min@lge.com" <chanho.min@lge.com>,
        "kyle.roeschley@ni.com" <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Topic: [PATCH V2] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Index: AQHUGMNhtrBnhjWARU2PBNkn39YK8aSRiRRw
Date:   Mon, 16 Jul 2018 08:23:59 +0000
Message-ID: <ec4d793a90ed43af998c89b86b024e10@mail2012.asrmicro.com>
References: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
In-Reply-To: <1531278049-22213-1-git-send-email-hongjiefang@asrmicro.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.170.195]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IG1tY19zZWxlY3RfaHM0MDBlcygpIGNhbGxzIG1tY19zZWxlY3RfYnVzX3dpZHRoKCkgd2hp
Y2ggd2lsbCBjb250aW51ZQ0KPiB0byBzZXQgNGJpdCB0cmFuc2ZlciBtb2RlIGlmIGZhaWwgdG8g
c2V0IDhiaXQgbW9kZS4gVGhlIGJ1cyB3aWR0aA0KPiBzaG91bGQgbm90IGJlIHNldCB0byA0Yml0
IGluIEhTNDAwZXMuDQo+IA0KPiBXaGVuIGZhaWwgdG8gc2V0IDhiaXQgbW9kZSwgbmVlZCByZXR1
cm4gZXJyb3IgZGlyZWN0bHkgZm9yIEhTNDAwZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBIb25n
amllIEZhbmcgPGhvbmdqaWVmYW5nQGFzcm1pY3JvLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL21t
Yy9jb3JlL21tYy5jIHwgNSArKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1j
LmMgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQo+IGluZGV4IDQ0NjZmNWQuLjRiZDZjMDkgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gKysrIGIvZHJpdmVycy9tbWMv
Y29yZS9tbWMuYw0KPiBAQCAtMTAyMSw4ICsxMDIxLDExIEBAIHN0YXRpYyBpbnQgbW1jX3NlbGVj
dF9idXNfd2lkdGgoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiAgCQkJCSBFWFRfQ1NEX0JVU19X
SURUSCwNCj4gIAkJCQkgZXh0X2NzZF9iaXRzW2lkeF0sDQo+ICAJCQkJIGNhcmQtPmV4dF9jc2Qu
Z2VuZXJpY19jbWQ2X3RpbWUpOw0KPiAtCQlpZiAoZXJyKQ0KPiArCQlpZiAoZXJyKSB7DQo+ICsJ
CQlpZiAoY2FyZC0+bW1jX2F2YWlsX3R5cGUgJiBFWFRfQ1NEX0NBUkRfVFlQRV9IUzQwMEVTKQ0K
PiArCQkJCXJldHVybiBlcnI7DQo+ICAJCQljb250aW51ZTsNCj4gKwkJfQ0KPiANCj4gIAkJYnVz
X3dpZHRoID0gYnVzX3dpZHRoc1tpZHhdOw0KPiAgCQltbWNfc2V0X2J1c193aWR0aChob3N0LCBi
dXNfd2lkdGgpOw0KPiAtLQ0KPiAxLjkuMQ0KDQpQaW5nLg0KQW55IHN1Z2dlc3Rpb24gZm9yIHRo
aXMgcGF0Y2ggPw0KDQoNCkImUg0KSG9uZ2ppZQ0K
