Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B00ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94B820856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 05:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94B820856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbeGXGyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 02:54:47 -0400
Received: from asrmicro.com ([210.13.118.86]:30163 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388140AbeGXGyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 02:54:47 -0400
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Tue, 24 Jul
 2018 13:49:35 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Tue, 24 Jul 2018 13:49:35 +0800
From:   =?gb2312?B?RmFuZyBIb25namllKLe9uum93Ck=?= 
        <hongjiefang@asrmicro.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "bst@pengutronix.de" <bst@pengutronix.de>,
        "chanho.min@lge.com" <chanho.min@lge.com>,
        "kyle.roeschley@ni.com" <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Topic: [PATCH V4] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Index: AQHUHa6Q5J90UE+Wwk2Pg6L0ADJKGKSd5zVQ
Date:   Tue, 24 Jul 2018 05:49:34 +0000
Message-ID: <155c45c3b69d487ab204398becdaf677@mail2012.asrmicro.com>
References: <1531818865-7387-1-git-send-email-hongjiefang@asrmicro.com>
In-Reply-To: <1531818865-7387-1-git-send-email-hongjiefang@asrmicro.com>
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

PiBtbWNfc2VsZWN0X2hzNDAwZXMoKSBjYWxscyBtbWNfc2VsZWN0X2J1c193aWR0aCgpIHdoaWNo
IHdpbGwgY29udGludWUNCj4gdG8gc2V0IDRiaXQgdHJhbnNmZXIgbW9kZSBpZiBmYWlsIHRvIHNl
dCA4Yml0IG1vZGUuIFRoZSBidXMgd2lkdGgNCj4gc2hvdWxkIG5vdCBiZSBzZXQgdG8gNGJpdCBp
biBIUzQwMGVzLg0KPiANCj4gV2hlbiBmYWlsIHRvIHNldCA4Yml0IG1vZGUsIG5lZWQgcmV0dXJu
IGVycm9yIGRpcmVjdGx5IGZvciBIUzQwMGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSG9uZ2pp
ZSBGYW5nIDxob25namllZmFuZ0Bhc3JtaWNyby5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMv
Y29yZS9tbWMuYyB8IDYgKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMu
YyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gaW5kZXggNDQ2NmY1ZC4uMGRiYzUxMiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiArKysgYi9kcml2ZXJzL21tYy9j
b3JlL21tYy5jDQo+IEBAIC0xMzM4LDggKzEzMzgsMTIgQEAgc3RhdGljIGludCBtbWNfc2VsZWN0
X2hzNDAwZXMoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiAgCQlnb3RvIG91dF9lcnI7DQo+IA0K
PiAgCWVyciA9IG1tY19zZWxlY3RfYnVzX3dpZHRoKGNhcmQpOw0KPiAtCWlmIChlcnIgPCAwKQ0K
PiArCWlmIChlcnIgIT0gTU1DX0JVU19XSURUSF84KSB7DQo+ICsJCXByX2VycigiJXM6IHN3aXRj
aCB0byA4Yml0IGJ1cyB3aWR0aCBmYWlsZWQsIGVycjolZFxuIiwNCj4gKwkJCW1tY19ob3N0bmFt
ZShob3N0KSwgZXJyKTsNCj4gKwkJZXJyID0gLUVJTzsNCj4gIAkJZ290byBvdXRfZXJyOw0KPiAr
CX0NCj4gDQo+ICAJLyogU3dpdGNoIGNhcmQgdG8gSFMgbW9kZSAqLw0KPiAgCWVyciA9IF9fbW1j
X3N3aXRjaChjYXJkLCBFWFRfQ1NEX0NNRF9TRVRfTk9STUFMLA0KPiAtLQ0KPiAxLjkuMQ0KDQpQ
aW5nLg0KQW55IHN1Z2dlc3Rpb24gZm9yIGl0Pw0KDQpCJlINCkhvbmdqaWUNCg==
