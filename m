Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA29C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D69B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfAUJe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:34:28 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfAUJe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:34:27 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 38FCA3C17F9CF549A595;
        Mon, 21 Jan 2019 09:49:09 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.226]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0415.000;
 Mon, 21 Jan 2019 09:49:07 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: don't remove the request if
 bus-expired
Thread-Topic: [PATCH] usb: dwc3: gadget: don't remove the request if
 bus-expired
Thread-Index: AQHUmGKjk/rakpJo0kSHw+luMI/lKaWuCwcAgAsZUHA=
Date:   Mon, 21 Jan 2019 01:49:07 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24E49C55@dggemm526-mbx.china.huawei.com>
References: <1545339230-10520-1-git-send-email-prime.zeng@hisilicon.com>
 <87won7mzcn.fsf@linux.intel.com>
In-Reply-To: <87won7mzcn.fsf@linux.intel.com>
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

SGkgYmFsYmk6DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEZlbGlwZSBC
YWxiaSBbbWFpbHRvOmZlbGlwZS5iYWxiaUBsaW51eC5pbnRlbC5jb21dDQo+U2VudDogTW9uZGF5
LCBKYW51YXJ5IDE0LCAyMDE5IDQ6MTMgUE0NCj5UbzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdA
aGlzaWxpY29uLmNvbT4NCj5DYzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNv
bT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxp
bnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzogZ2FkZ2V0OiBkb24ndCByZW1vdmUgdGhl
IHJlcXVlc3QgaWYNCj5idXMtZXhwaXJlZA0KPg0KPiogUEdQIFNpZ25lZCBieSBhbiB1bmtub3du
IGtleQ0KPg0KPg0KPkhpLA0KPg0KPlplbmcgVGFvIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+
IHdyaXRlczoNCj4+IFdlIGhhdmUgYWxyZWFkeSByZXR1cm5lZCBFQUdBSU4gZm9yIGJ1cy1leHBp
cnksIGFuZCBpdCdzIGRlc2lnbmVkIHRvDQo+PiBzdGFydCB3aXRoIGEgZnV0dXJlIEZyYW1lIG51
bWJlciBhbmQgc3RhcnQgdGhlIHRyYW5zZmVyIGFnYWluLiBTbyB3ZQ0KPj4gc2hvdWxkIG5vdCBy
ZW1vdmUgdGhlIHJlcXVlc3QgZm9yIHRoYXQgY2FzZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBa
ZW5nIFRhbyA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KPg0KPkRvIHdlIG5lZWQgYSBGaXhl
cyB0YWcgaGVyZT8gSG93IGFib3V0IENjIHN0YWJsZT8gQ2FuIHlvdSBzaGFyZQ0KPnRyYWNlcG9p
bnRzIGV4cG9zaW5nIHRoZSBwcm9ibGVtPw0KPg0KDQpJIGFtIG5vdCBzdXJlIHRoYXQgd2UgbmVl
ZCB0byBGaXhlcyB0YWcsIGl0J3Mgbm90IHJlbGF0ZWQgdG8gYW55IHNpbmdsZSBwYXRjaCwgYnV0
DQp0aGVyZSBpcyBkZWZpbml0ZWx5IHNvbWV0aGluZyB3cm9uZywgYWZ0ZXIgcmV0aGlua2luZyBp
dCBhZ2FpbiwgSSBmb3VuZCB0aGF0IHRoZXJlDQphcmUgc3RpbGwgc29tZSBwcm9ibGVtcyBmb3Ig
dGhpcyBwYXRjaCwgZm9yIHRoZSByZXRpZXMgaW5zaWRlIHRoZSBkcml2ZXIsIHdlIHNob3VsZCBu
b3QNCnJlbW92ZSB0aGUgcmVxdWVzdCwgYnV0IGlmIHdlIHJldHVybiAtRUFHQUlOIHRvIHRoZSBn
YWRnZXQgbGF5ZXIsIHdlIHNob3VsZCBiZWNhdXNlDQp0aGUgZ2FkZ2V0IHdpbGwgcmVxdWV1ZSB0
aGUgcmVxdWVzdCBhZ2FpbiBpZiB3ZSByZXR1cm4gLUVBR0FJTi4NCg0KQW55IHN1Z2dlc3Rpb25z
LiANCg0KPg0KPnRoYW5rcw0KPg0KPi0tDQo+YmFsYmkNCj4NCj4qIFVua25vd24gS2V5DQo+KiAw
eEUxMUE5OTA2DQo=
