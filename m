Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44D7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D62177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfAJPmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:42:02 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:6530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728643AbfAJPmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:42:01 -0500
Received: from DGGEMA401-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 19B0056BF031F82B2727;
        Thu, 10 Jan 2019 23:41:56 +0800 (CST)
Received: from DGGEMA422-HUB.china.huawei.com (10.1.198.155) by
 DGGEMA401-HUB.china.huawei.com (10.3.20.42) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 10 Jan 2019 23:41:55 +0800
Received: from DGGEMA523-MBX.china.huawei.com ([169.254.5.180]) by
 dggema422-hub.china.huawei.com ([10.1.198.155]) with mapi id 14.03.0399.000;
 Thu, 10 Jan 2019 23:41:50 +0800
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
Thread-Index: AdSo8Hp33+98LQYESeSIe29UjvqzCwACkt3A
Date:   Thu, 10 Jan 2019 15:41:49 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F202045458@dggema523-mbx.china.huawei.com>
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
aW4gaWRlYSwgSmFtZXMgdGhpbmsgUUVNVSBkb2VzIG5vdCANCj4gPiBuZWVkcyB0byBjaGVjayAq
c29tZXRoaW5nKiBpZiBRZW11IHN1cHBvcnQgZmlybXdhcmUtZmlyc3QuDQo+ID4gV2hhdCBkbyB3
ZSBkbyBmb3IgeW91ciBjb21tZW50cz8NCj4gDQo+IFVubGVzcyBJJ20gbWlzc2luZyBzb21ldGhp
bmcsIHRoZSBjb2RlIGluIHlvdXIgbW9zdCByZWNlbnQgcGF0Y2hzZXQgDQo+IGF0dGVtcHRzIHRv
IHVwZGF0ZSBhbiBBQ1BJIHRhYmxlIHdoZW4gaXQgZ2V0cyB0aGUgU0lHQlVTIGZyb20gdGhlIGhv
c3QgDQo+IGtlcm5lbCB3aXRob3V0IGRvaW5nIGFueXRoaW5nIHRvIGNoZWNrIHdoZXRoZXIgaXQg
aGFzIGV2ZXIgY3JlYXRlZCB0aGUgQUNQSSB0YWJsZSAoYW5kIHNldCB1cCB0aGUgUUVNVSBnbG9i
YWwgdmFyaWFibGUgdGhhdCB0ZWxscyB0aGUgY29kZSB3aGVyZSBpdCBpcyBpbiB0aGUgZ3Vlc3Qg
bWVtb3J5KSBpbiB0aGUgZmlyc3QgcGxhY2UuDQoNCndoZW4gUUVNVSB2ZXJzaW9uIGlzIGdyZWF0
ZXIgdGhhbiBzb21lIHZlcnNpb24sIGl0IHdpbGwgZGVmYXVsdCBjcmVhdGUgdGhlIEFQRUkgdGFi
bGUuIEJ1dCBvbmx5IHdoZW4gdGhlIGd1ZXN0IGlzIGJvb3RlZCBieSBVRUZJLCBpdCB3aWxsIHN1
cHBvcnQgdG8gcmVjb3JkIHRoZSBDUEVSIHRvIGd1ZXN0IG1lbW9yeS4gDQpJbiBteSB0ZXN0LCBJ
IGJvb3QgZ3Vlc3QgdXNpbmcgVUVGSSwgc28gaXQgaXMgbm8gcHJvYmxlbSwgSSB3aWxsIGNoZWNr
IHdoZXRoZXIgdGhpcyBib290aW5nIHVzZXMgVUVGSSBiZWZvcmUgdXBkYXRlIHRoZSBBQ1BJIHRh
YmxlLg0KDQo+IEkgZG9uJ3Qgc2VlIGhvdyB0aGF0IGNhbiB3b3JrLgkNCj4gDQo+ID4gPj4gSSB0
aGluayBvbmUgcXVlc3Rpb24gaGVyZSB3aGljaCBpdCB3b3VsZCBiZSBnb29kIHRvIGFuc3dlciBp
czoNCj4gPiA+PiBpZiB3ZSBhcmUgbW9kZWxsaW5nIGEgZ3Vlc3QgYW5kIHdlIGhhdmVuJ3Qgc3Bl
Y2lmaWNhbGx5IHByb3ZpZGVkIA0KPiA+ID4+IGl0IGFuIEFDUEkgdGFibGUgdG8gdGVsbCBpdCBh
Ym91dCBtZW1vcnkgZXJyb3JzLCB3aGF0IGRvIHdlIGRvIA0KPiA+ID4+IHdoZW4gd2UgZ2V0IGEg
c2lnYnVzIGZyb20gdGhlIGhvc3Q/IFdlIGhhdmUgYmFzaWNhbGx5IHR3byBjaG9pY2VzOg0KPiA+
ID4+ICAoMSkgc2VuZCB0aGUgZ3Vlc3QgYW4gU0Vycm9yIChha2EgYXN5bmNocm9ub3VzIGV4dGVy
bmFsIGFib3J0KQ0KPiA+ID4+ICAgICAgYW55d2F5ICh3aXRoIG5vIGZ1cnRoZXIgaW5mbyBhYm91
dCB3aGF0IHRoZSBtZW1vcnkgZXJyb3IgaXMpDQo+ID4gPg0KPiA+ID4gRm9yIGFuIEFSIHNpZ25h
bCBhbiBleHRlcm5hbCBhYm9ydCBpcyB2YWxpZC4gSXRzIHVwIHRvIHRoZSANCj4gPiA+IGltcGxl
bWVudGF0aW9uIHdoZXRoZXIgdGhlc2UgYXJlIHN5bmNocm9ub3VzIG9yIGFzeW5jaHJvbm91cy4g
UWVtdSANCj4gPiA+IGNhbiBvbmx5IHRha2UgYSBzaWduYWwgZm9yIHNvbWV0aGluZyB0aGF0IHdh
cyBzeW5jaHJvbm91cywgc28geW91IGNhbiBjaG9vc2UgYmV0d2VlbiB0aGUgdHdvLg0KPiA+ID4g
U3luY2hyb25vdXMgZXh0ZXJuYWwgYWJvcnQgaXMgbWFyZ2luYWxseSBiZXR0ZXIgYXMgYW4gdW5h
d2FyZSBPUyANCj4gPiA+IGtub3dzIGl0cyBhZmZlY3RzIHRoaXMgdGhyZWFkLCBhbmQgbWF5IGJl
IGFibGUgdG8ga2lsbCBpdC4NCj4gPiA+IFNFcnJvciB3aXRoIGFuIGltcC1kZWYgRVNSIGlzIGlu
ZGlzdGluZ3Vpc2hhYmxlIGZyb20gJ3BhcnQgb2YgdGhlIA0KPiA+ID4gc29jIGZlbGwgb3V0Jywg
YW5kIHNob3VsZCBhbHdheXMgcmVzdWx0IGluIGEgcGFuaWMoKS4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4+ICAoMikganVzdCBzdG9wIFFFTVUgKGFzIHdlIHdvdWxkIGZvciBhIG1lbW9yeSBlcnJvciBp
biBRRU1VJ3MNCj4gPiA+PiAgICAgIG93biBtZW1vcnkpDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBh
bHNvIHZhbGlkLiBBIG1hY2hpbmUgbWF5IHRha2UgZXh0ZXJuYWwtYWJvcnQgdG8gRUwzIGFuZCAN
Cj4gPiA+IHRoZW4gcmVib290L2NyYXNoL2J1cm4uDQo+IA0KPiBXZSBzaG91bGQgZGVjaWRlIHdo
aWNoIG9mIHRoZXNlIHdlIHdhbnQgdG8gZG8sIGFuZCBoYXZlIGEgY29tbWVudCANCj4gZXhwbGFp
bmluZyB3aGF0IHdlJ3JlIGRvaW5nLiBJZiBJJ20gcmVhZGluZyB5b3VyIGN1cnJlbnQgcGF0Y2hz
ZXQgY29ycmVjdGx5LCBpdCBkb2VzIG5laXRoZXIgLS0gaWYgaXQgY2FuJ3QgcmVjb3JkIHRoZSBm
YXVsdCBpbiB0aGUgQUNQSSB0YWJsZSBpdCBqdXN0IGlnbm9yZXMgaXQgd2l0aG91dCBlaXRoZXIg
c3RvcHBpbmcgUUVNVSBvciBkZWxpdmVyaW5nIGFuIFNFcnJvci4NCg0KSmFtZXMgbWF5IG5vdCBr
bm93IG15IGRldGFpbGVkIGltcGxlbWVudGF0aW9uIGluIHRoZSBRRU1VLiBJbiBteSBwYXRjaCwg
SSBvbmx5IGhhbmRsZSB0aGUgQlVTX01DRUVSUl9BUiBTSUdCVVMgc2lnbmFsKHN5bmNocm9ub3Vz
IHNpZ25hbCkuIHdoZW4gdGhlIFNJR0JVUyBpcyBCVVNfTUNFRVJSX0FSLCBpdCB3aWxsIGRlbGl2
ZXIgYSBzeW5jaHJvbm91cyBleGNlcHRpb24gYWJvcnQuDQpKYW1lcyBzYWlkIGl0IG5lZWRzIHRv
IGRlbGl2ZXIgYW4gU0Vycm9yIHdoZW4gdGhlIEJVU19NQ0VFUlJfT1IgU0lHQlVTIHNpZ25hbChh
c3luY2hyb25vdXMgc2lnbmFsKSwgYnV0IEkgZG8gbm90IGhhbmRsZSB0aGUgdGhpcyBjYXNlIGJl
Y2F1c2UgUUVNVSBtYWluIHRocmVhZCB3aWxsIG1hc2sgdGhpcyBhc3luY2hyb25vdXMgc2lnbmFs
Lg0KDQpJZiB0aGUgbWVtb3J5IGVycm9yIGlzIGJlbG9uZyB0byBRRU1VIGl0c2VsZiwgSSBqdXN0
IHByaW50IGFuIGVycm9yIGxvZ1syXS4gSWYgeW91IHRoaW5rLCBpdCBzaG91bGQgc3RvcCBRRU1V
IGZvciB0aGlzIGNhc2UsIEkgd2lsbCBjaGFuZ2UgaXQuDQoNCnZvaWQga3ZtX2FyY2hfb25fc2ln
YnVzX3ZjcHUoQ1BVU3RhdGUgKmMsIGludCBjb2RlLCB2b2lkICphZGRyKSB7DQoJLi4uLi4uLi4u
Li4uLi4uLi4uDQogICAJaWYgKGNvZGUgPT0gQlVTX01DRUVSUl9BUikgew0KICAgIAlrdm1fY3B1
X3N5bmNocm9uaXplX3N0YXRlKGMpOw0KICAgICAgIAlpZiAoZ2hlc19yZWNvcmRfZXJyb3JzKEFD
UElfSEVTVF9OT1RJRllfU0VBLCBwYWRkcikpIHsNCiAgICAgCQlrdm1faW5qZWN0X2FybV9zZWEo
Yyk7DQogICAgIAl9IGVsc2Ugew0KICAgICAgIAkJZnByaW50ZihzdGRlcnIsICJmYWlsZWQgdG8g
cmVjb3JkIHRoZSBlcnJvclxuIik7DQogICAgICAgCX0NCgl9DQpbMl0JZnByaW50ZihzdGRlcnIs
ICJIYXJkd2FyZSBtZW1vcnkgZXJyb3IgZm9yIG1lbW9yeSB1c2VkIGJ5ICINCiAgICAgICAgICAg
ICAgICAiUUVNVSBpdHNlbGYgaW5zdGVhZCBvZiBndWVzdCBzeXN0ZW0hXG4iKTsgDQp9DQoNCj4g
DQo+IEkgdGhpbmsgSSBmYXZvdXIgb3B0aW9uICgyKSBoZXJlLg0KPiANCj4gdGhhbmtzDQo+IC0t
IFBNTQ0K
