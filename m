Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0A9C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F2621872
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfAJPaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:30:18 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:6928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729162AbfAJPaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:30:17 -0500
Received: from DGGEMA406-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id AD2DB6E2AB425ED23186;
        Thu, 10 Jan 2019 23:30:12 +0800 (CST)
Received: from DGGEMA423-HUB.china.huawei.com (10.1.198.156) by
 DGGEMA406-HUB.china.huawei.com (10.3.20.47) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 10 Jan 2019 23:30:12 +0800
Received: from DGGEMA523-MBX.china.huawei.com ([169.254.5.180]) by
 dggema423-hub.china.huawei.com ([10.1.198.156]) with mapi id 14.03.0415.000;
 Thu, 10 Jan 2019 23:30:08 +0800
From:   gengdongjiu <gengdongjiu@huawei.com>
To:     Peter Maydell <peter.maydell@linaro.org>
CC:     James Morse <james.morse@arm.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
Thread-Topic: [RFC RESEND PATCH] kvm: arm64: export memory error recovery
 capability to user space
Thread-Index: AdSo8Hp33+98LQYESeSIe29UjvqzCw==
Date:   Thu, 10 Jan 2019 15:30:08 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F2020453D5@dggema523-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.56.182]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gVGh1LCAxMCBKYW4gMjAxOSBhdCAxMjowOSwgZ2VuZ2RvbmdqaXUgPGdlbmdkb25n
aml1QGh1YXdlaS5jb20+IHdyb3RlOg0KPiA+IFBldGVyLCBJIHN1bW1hcml6ZSBKYW1lcydzIG1h
aW4gaWRlYSwgSmFtZXMgdGhpbmsgUUVNVSBkb2VzIG5vdCBuZWVkcw0KPiA+IHRvIGNoZWNrICpz
b21ldGhpbmcqIGlmIFFlbXUgc3VwcG9ydCBmaXJtd2FyZS1maXJzdC4NCj4gPiBXaGF0IGRvIHdl
IGRvIGZvciB5b3VyIGNvbW1lbnRzPw0KPiANCj4gVW5sZXNzIEknbSBtaXNzaW5nIHNvbWV0aGlu
ZywgdGhlIGNvZGUgaW4geW91ciBtb3N0IHJlY2VudCBwYXRjaHNldCBhdHRlbXB0cyB0byB1cGRh
dGUgYW4gQUNQSSB0YWJsZSB3aGVuIGl0IGdldHMgdGhlIFNJR0JVUyBmcm9tIHRoZQ0KPiBob3N0
IGtlcm5lbCB3aXRob3V0IGRvaW5nIGFueXRoaW5nIHRvIGNoZWNrIHdoZXRoZXIgaXQgaGFzIGV2
ZXIgY3JlYXRlZCB0aGUgQUNQSSB0YWJsZSAoYW5kIHNldCB1cCB0aGUgUUVNVSBnbG9iYWwgdmFy
aWFibGUgdGhhdCB0ZWxscyB0aGUNCj4gY29kZSB3aGVyZSBpdCBpcyBpbiB0aGUgZ3Vlc3QgbWVt
b3J5KSBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNCndoZW4gUUVNVSB2ZXJzaW9uIGlzIGdyZWF0ZXIg
dGhhbiBzb21lIHZlcnNpb24sIGl0IHdpbGwgZGVmYXVsdCBjcmVhdGUgdGhlIEFQRUkgdGFibGUu
IEJ1dCBvbmx5IHdoZW4gdGhlIGd1ZXN0IGlzIGJvb3RlZCBieSBVRUZJLCBpdCB3aWxsIHN1cHBv
cnQgdG8gcmVjb3JkIHRoZSBDUEVSIHRvIGd1ZXN0IG1lbW9yeS4gDQpJbiBteSB0ZXN0LCBJIGJv
b3QgZ3Vlc3QgdXNpbmcgVUVGSSwgc28gaXQgaXMgbm8gcHJvYmxlbSwgSSB3aWxsIGNoZWNrIHdo
ZXRoZXIgdGhpcyBib290aW5nIHVzZXMgVUVGSSBiZWZvcmUgdXBkYXRlIHRoZSBBQ1BJIHRhYmxl
Lg0KDQo+IEkgZG9uJ3Qgc2VlIGhvdyB0aGF0IGNhbiB3b3JrLgkNCj4gDQo+ID4gPj4gSSB0aGlu
ayBvbmUgcXVlc3Rpb24gaGVyZSB3aGljaCBpdCB3b3VsZCBiZSBnb29kIHRvIGFuc3dlciBpczoN
Cj4gPiA+PiBpZiB3ZSBhcmUgbW9kZWxsaW5nIGEgZ3Vlc3QgYW5kIHdlIGhhdmVuJ3Qgc3BlY2lm
aWNhbGx5IHByb3ZpZGVkIGl0DQo+ID4gPj4gYW4gQUNQSSB0YWJsZSB0byB0ZWxsIGl0IGFib3V0
IG1lbW9yeSBlcnJvcnMsIHdoYXQgZG8gd2UgZG8gd2hlbiB3ZQ0KPiA+ID4+IGdldCBhIHNpZ2J1
cyBmcm9tIHRoZSBob3N0PyBXZSBoYXZlIGJhc2ljYWxseSB0d28gY2hvaWNlczoNCj4gPiA+PiAg
KDEpIHNlbmQgdGhlIGd1ZXN0IGFuIFNFcnJvciAoYWthIGFzeW5jaHJvbm91cyBleHRlcm5hbCBh
Ym9ydCkNCj4gPiA+PiAgICAgIGFueXdheSAod2l0aCBubyBmdXJ0aGVyIGluZm8gYWJvdXQgd2hh
dCB0aGUgbWVtb3J5IGVycm9yIGlzKQ0KPiA+ID4NCj4gPiA+IEZvciBhbiBBUiBzaWduYWwgYW4g
ZXh0ZXJuYWwgYWJvcnQgaXMgdmFsaWQuIEl0cyB1cCB0byB0aGUNCj4gPiA+IGltcGxlbWVudGF0
aW9uIHdoZXRoZXIgdGhlc2UgYXJlIHN5bmNocm9ub3VzIG9yIGFzeW5jaHJvbm91cy4gUWVtdQ0K
PiA+ID4gY2FuIG9ubHkgdGFrZSBhIHNpZ25hbCBmb3Igc29tZXRoaW5nIHRoYXQgd2FzIHN5bmNo
cm9ub3VzLCBzbyB5b3UgY2FuIGNob29zZSBiZXR3ZWVuIHRoZSB0d28uDQo+ID4gPiBTeW5jaHJv
bm91cyBleHRlcm5hbCBhYm9ydCBpcyBtYXJnaW5hbGx5IGJldHRlciBhcyBhbiB1bmF3YXJlIE9T
DQo+ID4gPiBrbm93cyBpdHMgYWZmZWN0cyB0aGlzIHRocmVhZCwgYW5kIG1heSBiZSBhYmxlIHRv
IGtpbGwgaXQuDQo+ID4gPiBTRXJyb3Igd2l0aCBhbiBpbXAtZGVmIEVTUiBpcyBpbmRpc3Rpbmd1
aXNoYWJsZSBmcm9tICdwYXJ0IG9mIHRoZQ0KPiA+ID4gc29jIGZlbGwgb3V0JywgYW5kIHNob3Vs
ZCBhbHdheXMgcmVzdWx0IGluIGEgcGFuaWMoKS4NCj4gPiA+DQo+ID4gPg0KPiA+ID4+ICAoMikg
anVzdCBzdG9wIFFFTVUgKGFzIHdlIHdvdWxkIGZvciBhIG1lbW9yeSBlcnJvciBpbiBRRU1VJ3MN
Cj4gPiA+PiAgICAgIG93biBtZW1vcnkpDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBhbHNvIHZhbGlk
LiBBIG1hY2hpbmUgbWF5IHRha2UgZXh0ZXJuYWwtYWJvcnQgdG8gRUwzIGFuZA0KPiA+ID4gdGhl
biByZWJvb3QvY3Jhc2gvYnVybi4NCj4gDQo+IFdlIHNob3VsZCBkZWNpZGUgd2hpY2ggb2YgdGhl
c2Ugd2Ugd2FudCB0byBkbywgYW5kIGhhdmUgYSBjb21tZW50IGV4cGxhaW5pbmcgd2hhdCB3ZSdy
ZSBkb2luZy4gSWYgSSdtIHJlYWRpbmcgeW91ciBjdXJyZW50IHBhdGNoc2V0DQo+IGNvcnJlY3Rs
eSwgaXQgZG9lcyBuZWl0aGVyIC0tIGlmIGl0IGNhbid0IHJlY29yZCB0aGUgZmF1bHQgaW4gdGhl
IEFDUEkgdGFibGUgaXQganVzdCBpZ25vcmVzIGl0IHdpdGhvdXQgZWl0aGVyIHN0b3BwaW5nIFFF
TVUgb3IgZGVsaXZlcmluZyBhbiBTRXJyb3IuDQoNCkphbWVzIG1heSBub3Qga25vdyBteSBkZXRh
aWxlZCBpbXBsZW1lbnRhdGlvbiBpbiB0aGUgUUVNVS4gSW4gbXkgcGF0Y2gsIEkgb25seSBoYW5k
bGUgdGhlIEJVU19NQ0VFUlJfQVIgU0lHQlVTIHNpZ25hbChzeW5jaHJvbm91cyBzaWduYWwpLiB3
aGVuIHRoZSBTSUdCVVMgaXMgQlVTX01DRUVSUl9BUiwgaXQgd2lsbCBkZWxpdmVyIGEgc3luY2hy
b25vdXMgZXhjZXB0aW9uIGFib3J0Lg0KSmFtZXMgc2FpZCBpdCBuZWVkcyB0byBkZWxpdmVyIGFu
IFNFcnJvciB3aGVuIHRoZSBCVVNfTUNFRVJSX09SIFNJR0JVUyBzaWduYWwoc3luY2hyb25vdXMg
c2lnbmFsKSwgYnV0IEkgZG8gbm90IGhhbmRsZSB0aGUgdGhpcyBjYXNlIGJlY2F1c2UgUUVNVSBt
YWluIHRocmVhZCB3aWxsIG1hc2sgdGhpcyBhc3luY2hyb25vdXMgc2lnbmFsLg0KDQpJZiB0aGUg
bWVtb3J5IGVycm9yIGlzIGJlbG9uZyB0byBRRU1VIGl0c2VsZiwgSSBqdXN0IHByaW50IGFuIGVy
cm9yIGxvZ1syXS4gSWYgeW91IHRoaW5rLCBpdCBzaG91bGQgc3RvcCBRRU1VIGZvciB0aGlzIGNh
c2UsIEkgd2lsbCBjaGFuZ2UgaXQuDQoNCnZvaWQga3ZtX2FyY2hfb25fc2lnYnVzX3ZjcHUoQ1BV
U3RhdGUgKmMsIGludCBjb2RlLCB2b2lkICphZGRyKSB7DQoJLi4uLi4uLi4uLi4uLi4uLi4uDQog
ICAJaWYgKGNvZGUgPT0gQlVTX01DRUVSUl9BUikgew0KICAgIAlrdm1fY3B1X3N5bmNocm9uaXpl
X3N0YXRlKGMpOw0KICAgICAgIAlpZiAoZ2hlc19yZWNvcmRfZXJyb3JzKEFDUElfSEVTVF9OT1RJ
RllfU0VBLCBwYWRkcikpIHsNCiAgICAgCQlrdm1faW5qZWN0X2FybV9zZWEoYyk7DQogICAgIAl9
IGVsc2Ugew0KICAgICAgIAkJZnByaW50ZihzdGRlcnIsICJmYWlsZWQgdG8gcmVjb3JkIHRoZSBl
cnJvclxuIik7DQogICAgICAgCX0NCgl9DQpbMl0JZnByaW50ZihzdGRlcnIsICJIYXJkd2FyZSBt
ZW1vcnkgZXJyb3IgZm9yIG1lbW9yeSB1c2VkIGJ5ICINCiAgICAgICAgICAgICAgICAiUUVNVSBp
dHNlbGYgaW5zdGVhZCBvZiBndWVzdCBzeXN0ZW0hXG4iKTsNCn0NCj4gDQo+IEkgdGhpbmsgSSBm
YXZvdXIgb3B0aW9uICgyKSBoZXJlLg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K
