Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA9FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FE8205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FE8205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJQJ6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:58:49 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6041 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727099AbeJQJ6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:58:48 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 002A2CC160401;
        Wed, 17 Oct 2018 10:05:26 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.186]) by
 DGGEMM403-HUB.china.huawei.com ([10.3.20.211]) with mapi id 14.03.0399.000;
 Wed, 17 Oct 2018 10:05:26 +0800
From:   "Zengtao (B)" <prime.zeng@hisilicon.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] xhci: remove the unused sw_lpm_support
Thread-Topic: [PATCH] xhci: remove the unused sw_lpm_support
Thread-Index: AQHUZQDsmSH0ZR0Gu0CIq9XrUjcb66UhSMoAgAFoC5A=
Date:   Wed, 17 Oct 2018 02:05:25 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED1F18FF41@dggemm526-mbx.china.huawei.com>
References: <1539689828-35940-1-git-send-email-prime.zeng@hisilicon.com>
 <1545bbcc-ca1a-b1fe-7363-ad05cbc7245c@linux.intel.com>
In-Reply-To: <1545bbcc-ca1a-b1fe-7363-ad05cbc7245c@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.222.15]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgIE1hdGhpYXM6DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hdGhp
YXMgTnltYW4gW21haWx0bzptYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbV0NCj5TZW50OiBU
dWVzZGF5LCBPY3RvYmVyIDE2LCAyMDE4IDg6MzQgUE0NCj5UbzogWmVuZ3RhbyAoQikgPHByaW1l
LnplbmdAaGlzaWxpY29uLmNvbT47IG1hdGhpYXMubnltYW5AaW50ZWwuY29tOw0KPmdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnDQo+Q2M6IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogW1BBVENIXSB4aGNpOiByZW1v
dmUgdGhlIHVudXNlZCBzd19scG1fc3VwcG9ydA0KPg0KPk9uIDE2LjEwLjIwMTggMTQ6MzcsIFpl
bmcgVGFvIHdyb3RlOg0KPj4gSXQgaXMgaW50cm9kdWNlZCBmb3IgdGhlIHByZS0wLjk2IHhIQyBj
b250cm9sbGVycywgYW5kIHRoZSBkcml2ZXIgb25seQ0KPj4gc3VwcG9ydCBIVyBMUE0gZm9yIDEu
MCBhbmQgbGF0ZXIgY29udHJvbGxlcnMuSXQncyBub3QgYWN0dWFsbHkgdXNlZA0KPj4gbm93IGFu
ZCBpcyB0aG91Z2h0IG5vdCB0byBiZSB1c2VkIGluIHRoZSBmdXR1cmUgYW55IG1vcmUsIHNvIGp1
c3QNCj5yZW1vdmUgaXQuDQo+Pg0KPj4gQWNrZWQtYnk6IE1hdGhpYXMgTnltYW4gPG1hdGhpYXMu
bnltYW5AaW50ZWwuY29tPg0KPg0KPlBsZWFzZSBkb24ndCBhZGQgbXkgQWNrZWQtYnkgdG8gcGF0
Y2hlcyBJIGhhdmVuJ3Qgc2Vlbi4NCj4NCj4gRnJvbSBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3Vi
bWl0dGluZy1wYXRjaGVzLnJzdDoNCj4NClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IHRoZSB3cm9u
ZyB0YWcsIEkgbWVhbnQgdG8gYWRkIHN1Z2dlc3RlZC1ieSwgXl9eDQoNCj4iQWNrZWQtYnk6IGlz
IG5vdCBhcyBmb3JtYWwgYXMgU2lnbmVkLW9mZi1ieTouICBJdCBpcyBhIHJlY29yZCB0aGF0IHRo
ZSBhY2tlcg0KPmhhcyBhdCBsZWFzdCByZXZpZXdlZCB0aGUgcGF0Y2ggYW5kIGhhcyBpbmRpY2F0
ZWQgYWNjZXB0YW5jZS4iDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaZW5nIFRhbyA8cHJpbWUuemVu
Z0BoaXNpbGljb24uY29tPg0KPg0KPk90aGVyd2lzZSB0aGUgcGF0Y2ggbG9va3MgZ29vZCwgSSds
bCBxdWV1ZSBpdCwgYW5kIHJlbW92ZSB0aGUgZXh0cmENCj5BY2tlZC1ieQ0KPg0KSXQncyBvayBm
b3IgbWUsICB0aGFuayB5b3UuDQoNClJlZ2FyZHMNClplbmd0YW8gDQo=
