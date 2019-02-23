Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2ADC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C94D206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBWJ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:26:10 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2091 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbfBWJ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:26:10 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 090C7743271CBDE5B1D5;
        Sat, 23 Feb 2019 17:26:07 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.222]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0415.000;
 Sat, 23 Feb 2019 17:26:05 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC
 endpoint
Thread-Topic: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC
 endpoint
Thread-Index: AQHUsS0bILgDDiUg2U+K9CAPb70X5qW42uCAgACRDOyAM+LzEA==
Date:   Sat, 23 Feb 2019 09:26:05 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24E7D8F2@dggemm526-mbx.china.huawei.com>
References: <1548064976-30196-1-git-send-email-prime.zeng@hisilicon.com>
 <87tvi2juh4.fsf@linux.intel.com>
 <678F3D1BB717D949B966B68EAEB446ED24E4CEE3@dggemm526-mbx.china.huawei.com>
 <87o98ajso9.fsf@linux.intel.com>
In-Reply-To: <87o98ajso9.fsf@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYmFsYmk6DQoNCkkgZ290IHRoaXMgaXNzdWUgaW4gdGhlIFVWQyBhcHBsaWNhdGlvbiwgYW5k
IEkgdGhpbmsgdGhpcyBpc3N1ZSBzdGlsbCBleGlzdCBpbiB0aGUgDQpsYXRlc3QgZHdjMyBkcml2
ZXIuDQoNCkFuZCB3ZSBzaG91bGQgaXNzdWUgYW4gc3RvcCBjb21tYW5kIGFuZCB0aGUgcXVldWUg
aXMgZW1wdHkgd2hlbiBpdCdzIA0KSVNPQyB0cmFuc2Zlciwgb3RoZXJ3aXNlIHdlIHdpbGwgZW5k
IHVwIHdpdGggTUlTUyBJU09DIGVycm9yIGZvciBhbGwgdGhlIA0KdXBjb21pbmcgdHJhbnNmZXJz
Lg0KDQpTbyBJIHRoaW5rIHlvdSBjYW4gdGVzdCB0aGUgVVZDIGFwcGxpY2F0aW9uIHdpdGggdGhl
IGxhdGVzdCBkcml2ZXIuDQoNClJlZ2FyZHMNClplbmd0YW8gDQoNCj4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPkZyb206IEZlbGlwZSBCYWxiaSBbbWFpbHRvOmZlbGlwZS5iYWxiaUBsaW51
eC5pbnRlbC5jb21dDQo+U2VudDogTW9uZGF5LCBKYW51YXJ5IDIxLCAyMDE5IDQ6NTYgUE0NCj5U
bzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT4NCj5DYzogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47DQo+bGludXgtdXNiQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGF1cmVudA0KPlBpbmNo
YXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+U3ViamVjdDogUkU6IFtQ
QVRDSF0gdXNiOiBkd2MzOiBnYWRnZXQ6IGlzc3VlIGEgc3RvcCBjb21tYW5kIGZvciBJU09DDQo+
ZW5kcG9pbnQNCj4NCj4qIFBHUCBTaWduZWQgYnkgYW4gdW5rbm93biBrZXkNCj4NCj4NCj5IaSwN
Cj4NCj4iWmVuZ3RhbyAoQikiIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+IHdyaXRlczoNCj4+
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj5Gcm9tOiBGZWxpcGUgQmFsYmkgW21haWx0
bzpmZWxpcGUuYmFsYmlAbGludXguaW50ZWwuY29tXQ0KPj4+U2VudDogTW9uZGF5LCBKYW51YXJ5
IDIxLCAyMDE5IDQ6MTcgUE0NCj4+PlRvOiBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGlj
b24uY29tPg0KPj4+Q2M6IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBH
cmVnIEtyb2FoLUhhcnRtYW4NCj4+PjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+Pj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+
Pj5TdWJqZWN0OiBSZTogW1BBVENIXSB1c2I6IGR3YzM6IGdhZGdldDogaXNzdWUgYSBzdG9wIGNv
bW1hbmQgZm9yDQo+SVNPQw0KPj4+ZW5kcG9pbnQNCj4+Pg0KPj4+PiBPbGQgU2lnbmVkIGJ5IGFu
IHVua25vd24ga2V5DQo+Pj4NCj4+Pg0KPj4+SGksDQo+Pj4NCj4+PlplbmcgVGFvIDxwcmltZS56
ZW5nQGhpc2lsaWNvbi5jb20+IHdyaXRlczoNCj4+Pj4gRm9yIElTT0MgdHJhbnNmZXJzLCBpZiB0
aGVyZSBpcyBubyBhdmFpbGFibGUgZGF0YSBmb3IgYSBwZXJpb2QsIHdlDQo+Pj4+IG5lZWQgdG8g
c3RvcCB0aGUgdHJhbnNmZXIgYnkgaXNzdWUgYSBzdG9wIGNvbW1hbmQsIG90aGVyd2lzZSwgYWxs
DQo+Pj4+IHRoZSB1cGNvbWluZyB0cmFuc2ZlcnMgd2lsbCBzdGFydGVkIGJ5IHVwZGF0ZSB0cmFu
c2ZlciBjb21tYW5kLA0KPmFuZA0KPj4+PiB3aWxsIGJlIGRyb3BwZWQgd2l0aCBNSVNTIElTT0Mg
ZXJyb3JzLg0KPj4+DQo+Pj5XZSwgYWN0dWFsbHksIGhhdmUgY29kZSB0byBoYW5kbGUgbWlzc2Vk
IGlzb2MgZXJyb3JzIG5vdy4gSGF2ZSB5b3UNCj4+PnRlc3RlZCB3aXRoIHRoYXQgYXBwbGllZD8g
V2hpY2gga2VybmVsIGFyZSB5b3UgdXNpbmc/IENhbiB5b3Ugc2hhcmUNCj4+PnRyYWNlcG9pbnRz
IGNhcHR1cmVkIHdpdGggdjUuMC1yYzM/DQo+Pj4NCj4+DQo+PiBOb3QgdjUuMC1yYzMsIGJ1dCBJ
IHRlc3RlZCBpdCBiYXNlZCBvbiA0Ljkgd2l0aCBiYWNrcG9ydGVkIGR3YzMNCj4+IGRyaXZlci4g
QW5kIHdpdGggVVZDIGFwcGxpY2F0aW9uLCBpdCdzIHZlcnkgZWFzeSB0byByZXByb2R1Y2UgaXQu
DQo+DQo+T2ssIHNvIGl0IGNvdWxkIGJlIHRoYXQgeW91IG1pc3NlZCBwYXRjaGVzIHdoaWxlIGJh
Y2twb3J0aW5nLCByaWdodD8NCj5Ib3cgY2FuIEkgcmVwcm9kdWNlIHRoaXM/IFdoYXQgZG8gSSBu
ZWVkPyBDYXJlIHRvIGdpdmUgZGV0YWlsZWQNCj5pbnN0cnVjdGlvbnM/DQo+DQo+LS0NCj5iYWxi
aQ0KPg0KPiogVW5rbm93biBLZXkNCj4qIDB4RTExQTk5MDYNCg==
