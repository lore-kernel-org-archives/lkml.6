Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA11CC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824902084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfAUIvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:51:36 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:56870 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727993AbfAUIvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:51:35 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 105C3AF6A74F3248ACCC;
        Mon, 21 Jan 2019 16:51:33 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.226]) by
 DGGEMM402-HUB.china.huawei.com ([10.3.20.210]) with mapi id 14.03.0415.000;
 Mon, 21 Jan 2019 16:51:27 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC
 endpoint
Thread-Topic: [PATCH] usb: dwc3: gadget: issue a stop command for ISOC
 endpoint
Thread-Index: AQHUsS0bILgDDiUg2U+K9CAPb70X5qW42uCAgACOmDA=
Date:   Mon, 21 Jan 2019 08:51:26 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED24E4CEE3@dggemm526-mbx.china.huawei.com>
References: <1548064976-30196-1-git-send-email-prime.zeng@hisilicon.com>
 <87tvi2juh4.fsf@linux.intel.com>
In-Reply-To: <87tvi2juh4.fsf@linux.intel.com>
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
LCBKYW51YXJ5IDIxLCAyMDE5IDQ6MTcgUE0NCj5UbzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdA
aGlzaWxpY29uLmNvbT4NCj5DYzogWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlzaWxpY29uLmNv
bT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IGxp
bnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHVzYjogZHdjMzogZ2FkZ2V0OiBpc3N1ZSBhIHN0b3AgY29t
bWFuZCBmb3IgSVNPQw0KPmVuZHBvaW50DQo+DQo+KiBQR1AgU2lnbmVkIGJ5IGFuIHVua25vd24g
a2V5DQo+DQo+DQo+SGksDQo+DQo+WmVuZyBUYW8gPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT4g
d3JpdGVzOg0KPj4gRm9yIElTT0MgdHJhbnNmZXJzLCBpZiB0aGVyZSBpcyBubyBhdmFpbGFibGUg
ZGF0YSBmb3IgYSBwZXJpb2QsIHdlDQo+PiBuZWVkIHRvIHN0b3AgdGhlIHRyYW5zZmVyIGJ5IGlz
c3VlIGEgc3RvcCBjb21tYW5kLCBvdGhlcndpc2UsIGFsbCB0aGUNCj4+IHVwY29taW5nIHRyYW5z
ZmVycyB3aWxsIHN0YXJ0ZWQgYnkgdXBkYXRlIHRyYW5zZmVyIGNvbW1hbmQsIGFuZCB3aWxsDQo+
PiBiZSBkcm9wcGVkIHdpdGggTUlTUyBJU09DIGVycm9ycy4NCj4NCj5XZSwgYWN0dWFsbHksIGhh
dmUgY29kZSB0byBoYW5kbGUgbWlzc2VkIGlzb2MgZXJyb3JzIG5vdy4gSGF2ZSB5b3UgdGVzdGVk
DQo+d2l0aCB0aGF0IGFwcGxpZWQ/IFdoaWNoIGtlcm5lbCBhcmUgeW91IHVzaW5nPyBDYW4geW91
IHNoYXJlIHRyYWNlcG9pbnRzDQo+Y2FwdHVyZWQgd2l0aCB2NS4wLXJjMz8NCj4NCg0KTm90IHY1
LjAtcmMzLCBidXQgSSB0ZXN0ZWQgaXQgYmFzZWQgb24gNC45IHdpdGggYmFja3BvcnRlZCBkd2Mz
IGRyaXZlci4gQW5kIHdpdGgNClVWQyBhcHBsaWNhdGlvbiwgaXQncyB2ZXJ5IGVhc3kgdG8gcmVw
cm9kdWNlIGl0Lg0KDQo+LS0NCj5iYWxiaQ0KPg0KPiogVW5rbm93biBLZXkNCj4qIDB4RTExQTk5
MDYNCg==
