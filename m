Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBD6ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1720844
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D1720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbeGPMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:10:56 -0400
Received: from asrmicro.com ([210.13.118.86]:6005 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbeGPMK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:10:56 -0400
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 16 Jul
 2018 19:43:37 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Mon, 16 Jul 2018 19:43:37 +0800
From:   =?utf-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= 
        <hongjiefang@asrmicro.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
        Bastian Stender <bst@pengutronix.de>,
        Chanho Min <chanho.min@lge.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Topic: [PATCH V3] mmc: core: improve reasonableness of bus width
 setting for HS400es
Thread-Index: AQHUHPXR9qvT7QD0P0m03/RlNUVSwqSRLZmAgACJcxA=
Date:   Mon, 16 Jul 2018 11:43:37 +0000
Message-ID: <2912293cd9e648dc8a0638debc129228@mail2012.asrmicro.com>
References: <1531739517-23108-1-git-send-email-hongjiefang@asrmicro.com>
 <CAPDyKFqU+_zPFw7f4FGWPe9OPpsDDtdF7JUxMA8ejTB0RyUCCw@mail.gmail.com>
In-Reply-To: <CAPDyKFqU+_zPFw7f4FGWPe9OPpsDDtdF7JUxMA8ejTB0RyUCCw@mail.gmail.com>
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

DQo+IE9uIDE2IEp1bHkgMjAxOCBhdCAxMzoxMSwgSG9uZ2ppZSBGYW5nIDxob25namllZmFuZ0Bh
c3JtaWNyby5jb20+IHdyb3RlOg0KPiA+IG1tY19zZWxlY3RfaHM0MDBlcygpIGNhbGxzIG1tY19z
ZWxlY3RfYnVzX3dpZHRoKCkgd2hpY2ggd2lsbCBjb250aW51ZQ0KPiA+IHRvIHNldCA0Yml0IHRy
YW5zZmVyIG1vZGUgaWYgZmFpbCB0byBzZXQgOGJpdCBtb2RlLiBUaGUgYnVzIHdpZHRoDQo+ID4g
c2hvdWxkIG5vdCBiZSBzZXQgdG8gNGJpdCBpbiBIUzQwMGVzLg0KPiA+DQo+ID4gV2hlbiBmYWls
IHRvIHNldCA4Yml0IG1vZGUsIG5lZWQgcmV0dXJuIGVycm9yIGRpcmVjdGx5IGZvciBIUzQwMGVz
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG9uZ2ppZSBGYW5nIDxob25namllZmFuZ0Bhc3Jt
aWNyby5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvbW1jLmMgfCA1ICsrKyst
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMv
Y29yZS9tbWMuYw0KPiA+IGluZGV4IDQ0NjZmNWQuLmIyZTFlYjYgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMN
Cj4gPiBAQCAtMTMzOCw4ICsxMzM4LDExIEBAIHN0YXRpYyBpbnQgbW1jX3NlbGVjdF9oczQwMGVz
KHN0cnVjdCBtbWNfY2FyZCAqY2FyZCkNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRfZXJy
Ow0KPiA+DQo+ID4gICAgICAgICBlcnIgPSBtbWNfc2VsZWN0X2J1c193aWR0aChjYXJkKTsNCj4g
PiAtICAgICAgIGlmIChlcnIgPCAwKQ0KPiA+ICsgICAgICAgaWYgKGVyciAhPSBNTUNfQlVTX1dJ
RFRIXzgpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJfZXJyKCIlczogc3dpdGNoIHRvIDhiaXQg
YnVzIHdpZHRoIGZhaWxlZCwgZXJyOiVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IG1tY19ob3N0bmFtZShob3N0KSwgZXJyKTsNCj4gPiAgICAgICAgICAgICAgICAgZ290byBvdXRf
ZXJyOw0KPiANCj4gWW91IG5lZWQgdG8gc2V0IGVyciB0byBhIHByb3BlciBlcnJvciBjb2RlLCBl
bHNlIHlvdSBtYXkgcmV0dXJuIGENCj4gbm9uLWVycm9yIGNvZGUgZnJvbSB0aGUgb3V0X2VyciBs
YWJlbC4NCg0KSG93IGFib3V0IHVzaW5nIHRoZSBFSU8gb3IgRU5PVFNVUFA/DQoNCj4gDQo+IFsu
Li5dDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQpCJlINCkhvbmdqaWUNCg==
