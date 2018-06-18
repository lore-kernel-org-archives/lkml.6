Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0559BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE00C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE00C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936510AbeFRIZH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:25:07 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5940 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936245AbeFRIZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:25:00 -0400
Received: from DGGEMA404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id D142C47DC8C61;
        Mon, 18 Jun 2018 16:24:54 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.111]) by
 DGGEMA404-HUB.china.huawei.com ([10.3.20.45]) with mapi id 14.03.0382.000;
 Mon, 18 Jun 2018 16:24:52 +0800
From:   gengdongjiu <gengdongjiu@huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add
 KVM_GET/SET_VCPU_EVENTS
Thread-Topic: [PATCH RESEND v4 2/2] arm/arm64: KVM: Add
 KVM_GET/SET_VCPU_EVENTS
Thread-Index: AdQG3X7DTpSoV8flSG+bwC6w9hgRUQ==
Date:   Mon, 18 Jun 2018 08:24:51 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201CE5C72@DGGEMA503-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.62.8]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMi8wNi8xOCAxNTo1MCwgZ2VuZ2RvbmdqaXUgd3JvdGU6DQo+ID4gT24gMjAxOC82LzEx
IDIxOjM2LCBKYW1lcyBNb3JzZSB3cm90ZToNCj4gPj4gT24gMDgvMDYvMTggMjA6NDgsIERvbmdq
aXUgR2VuZyB3cm90ZToNCj4gPj4+IEZvciB0aGUgbWlncmF0aW5nIFZNcywgdXNlciBzcGFjZSBt
YXkgbmVlZCB0byBrbm93IHRoZSBleGNlcHRpb24NCj4gPj4+IHN0YXRlLiBGb3IgZXhhbXBsZSwg
aW4gdGhlIG1hY2hpbmUgQSwgS1ZNIG1ha2UgYW4gU0Vycm9yIHBlbmRpbmcsDQo+ID4+PiB3aGVu
IG1pZ3JhdGUgdG8gQiwgS1ZNIGFsc28gbmVlZHMgdG8gcGVuZCBhbiBTRXJyb3IuDQo+ID4+Pg0K
PiA+Pj4gVGhpcyBuZXcgSU9DVEwgZXhwb3J0cyB1c2VyLWludmlzaWJsZSBzdGF0ZXMgcmVsYXRl
ZCB0byBTRXJyb3IuDQo+ID4+PiBUb2dldGhlciB3aXRoIGFwcHJvcHJpYXRlIHVzZXIgc3BhY2Ug
Y2hhbmdlcywgdXNlciBzcGFjZSBjYW4gZ2V0L3NldA0KPiA+Pj4gdGhlIFNFcnJvciBleGNlcHRp
b24gc3RhdGUgdG8gZG8gbWlncmF0ZS9zbmFwc2hvdC9zdXNwZW5kLg0KPiANCj4gDQo+ID4+PiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vaW5jbHVkZS91YXBpL2FzbS9rdm0uaA0KPiA+Pj4gYi9hcmNo
L2FybS9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oIGluZGV4IGNhYWU0ODQuLmMzZTY5NzUgMTAwNjQ0
DQo+ID4+PiAtLS0gYS9hcmNoL2FybS9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+ID4+PiArKysg
Yi9hcmNoL2FybS9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+ID4+PiBAQCAtMTI0LDYgKzEyNCwx
OCBAQCBzdHJ1Y3Qga3ZtX3N5bmNfcmVncyB7ICBzdHJ1Y3QNCj4gPj4+IGt2bV9hcmNoX21lbW9y
eV9zbG90IHsgIH07DQo+ID4+Pg0KPiA+Pj4gKy8qIGZvciBLVk1fR0VUL1NFVF9WQ1BVX0VWRU5U
UyAqLw0KPiA+Pj4gK3N0cnVjdCBrdm1fdmNwdV9ldmVudHMgew0KPiA+Pj4gKwlzdHJ1Y3Qgew0K
PiA+Pj4gKwkJX191OCBzZXJyb3JfcGVuZGluZzsNCj4gPj4+ICsJCV9fdTggc2Vycm9yX2hhc19l
c3I7DQo+ID4+PiArCQkvKiBBbGlnbiBpdCB0byA4IGJ5dGVzICovDQo+ID4+PiArCQlfX3U4IHBh
ZFs2XTsNCj4gPj4+ICsJCV9fdTY0IHNlcnJvcl9lc3I7DQo+ID4+PiArCX0gZXhjZXB0aW9uOw0K
PiA+Pj4gKwlfX3UzMiByZXNlcnZlZFsxMl07DQo+ID4+PiArfTsNCj4gPj4+ICsNCj4gPj4NCj4g
Pj4gWW91IGhhdmVuJ3QgZGVmaW5lZCBfX0tWTV9IQVZFX1ZDUFVfRVZFTlRTIGZvciAzMmJpdCwg
c28gcHJlc3VtYWJseQ0KPiA+PiB0aGlzIHN0cnVjdCB3aWxsIG5ldmVyIGJlIHVzZWQuIFdoeSBp
cyBpdCBoZXJlPw0KPiANCj4gPiAgIGlmIG5vdCBhZGQgaXQgZm9yIDMyIGJpdHMuIHRoZSAzMiBh
cm0gcGxhdGZvcm0gd2lsbCBidWlsZCBGYWlsLCB3aGV0aGVyIHlvdSBoYXZlIGdvb2QNCj4gPiAg
ICBpZGVhIHRvIGF2b2lkIHRoaXMgRmFpbHVyZSBpZiBub3QgYWRkIHRoaXMgc3RydWN0IGZvciB0
aGUgMzIgYml0Pw0KPiANCj4gSG93IGRvZXMgdGhpcyAzMmJpdCBjb2RlIGJ1aWxkIHdpdGhvdXQg
dGhpcyBwYXRjaD8NCj4gSWYgZG8geW91IHByb3ZpZGUgdGhlIHN0cnVjdCwgaG93IHdpbGwgdGhh
dCBjb2RlIGJ1aWxkIHdpdGggb2xkZXIgaGVhZGVycz8NCj4gDQo+IEFzIGZhciBhcyBJIGNhbiBz
ZWUsIHRoaXMgaXMgd2hhdCB0aGUgX19LVk1fSEFWRV9WQ1BVX0VWRU5UUyBkZWZpbmUgaXMgZm9y
Lg0KPiANCj4gVGhpcyBzaG91bGQgYmUgYm90aCwgb3IgbmVpdGhlci4gSGF2aW5nIGp1c3QgdGhl
IHN0cnVjdCBpcyB1c2VsZXNzLg0KPiANCj4gDQo+ID4+PiAraW50IGt2bV9hcm1fdmNwdV9zZXRf
ZXZlbnRzKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSwNCj4gPj4+ICsJCQlzdHJ1Y3Qga3ZtX3ZjcHVf
ZXZlbnRzICpldmVudHMpDQo+ID4+PiArew0KPiA+Pj4gKwlib29sIHNlcnJvcl9wZW5kaW5nID0g
ZXZlbnRzLT5leGNlcHRpb24uc2Vycm9yX3BlbmRpbmc7DQo+ID4+PiArCWJvb2wgaGFzX2VzciA9
IGV2ZW50cy0+ZXhjZXB0aW9uLnNlcnJvcl9oYXNfZXNyOw0KPiA+Pj4gKw0KPiA+Pj4gKwlpZiAo
c2Vycm9yX3BlbmRpbmcgJiYgaGFzX2Vzcikgew0KPiA+Pj4gKwkJaWYgKCFjcHVzX2hhdmVfY29u
c3RfY2FwKEFSTTY0X0hBU19SQVNfRVhUTikpDQo+ID4+PiArCQkJcmV0dXJuIC1FSU5WQUw7DQo+
ID4+PiArDQo+ID4+PiArCQlrdm1fc2V0X3NlaV9lc3IodmNwdSwgZXZlbnRzLT5leGNlcHRpb24u
c2Vycm9yX2Vzcik7DQo+ID4+DQo+ID4+IGt2bV9zZXRfc2VpX2VzcigpIHdpbGwgc2lsZW50bHkg
ZGlzY2FyZCB0aGUgdG9wIDQwIGJpdHMgb2YNCj4gPj4gc2Vycm9yX2VzciwgKHdoaWNoIGlzIGNv
cnJlY3QsIHdlIHNob3VsZG4ndCBjb3B5IHRoZW0gaW50byBoYXJkd2FyZSB3aXRob3V0IGtub3cg
d2hhdCB0aGV5IGRvKS4NCj4gPj4NCj4gPj4gQ291bGQgd2UgcGxlYXNlIGZvcmNlIHVzZXItc3Bh
Y2UgdG8gemVybyB0aGVzZSBiaXRzLCB3ZSBjYW4gYWR2ZXJ0aXNlDQo+ID4+IGV4dHJhIENBUHMg
aWYgbmV3IGZlYXR1cmVzIHR1cm4gdXAgaW4gdGhhdCBzcGFjZSwgaW5zdGVhZCBvZg0KPiA+PiB1
c2VyLXNwYWNlIHBhc3NpbmcgPHNvbWV0aGluZz4gYW5kIHJlbHlpbmcgb24gdGhlIGtlcm5lbCB0
byByZW1vdmUgaXQuDQo+ID4NCj4gPiAgIHllcywgSSBjYW4gemVybyB0aGVzZSBiaXRzIGluIHRo
ZSAgdXNlci1zcGFjZSBhbmQgbm90IGRlcGVuZCBvbiBrZXJuZWwgdG8gcmVtb3ZlIGl0Lg0KPiAN
Cj4gQnV0IHRoZSBrZXJuZWwgbXVzdCBjaGVjayB0aGF0IHVzZXItc3BhY2UgZGlkIHplcm8gdGhv
c2UgYml0cy4gT3RoZXJ3aXNlIHVzZXItc3BhY2UgbWF5IHN0YXJ0IHVzaW5nIHRoZW0gd2hlbiBh
IGZ1dHVyZSB2ZXJzaW9uIG9mIHRoZQ0KDQpGb3IgdGhpcyBjb21tZW50cywgaG93IGFib3V0IGFk
ZCBiZWxvdyBrZXJuZWwgY2hlY2sgdGhhdCB1c2VyLXNwYWNlIGRpZCB6ZXJvIHRob3NlIGJpdHM/
IFRoYW5rcy4NCg0KKyAgICAgICAgICAgICAgIGlmICghKChldmVudHMtPmV4Y2VwdGlvbi5zZXJy
b3JfZXNyKSAmIH5FU1JfRUx4X0lTU19NQVNLKSkNCisgICAgICAgICAgICAgICAgICAgICAgIGt2
bV9zZXRfc2VpX2Vzcih2Y3B1LCBldmVudHMtPmV4Y2VwdGlvbi5zZXJyb3JfZXNyKTsNCisgICAg
ICAgICAgICAgICBlbHNlDQorICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsN
Cg0KDQo+IGFyY2hpdGVjdHVyZSBnaXZlcyB0aGVtIGEgbWVhbmluZywgYnV0IGFuIG9sZGVyIGtl
cm5lbCB2ZXJzaW9uIGRvZXNuJ3Qga25vdyBpdCBoYXMgdG8gZG8gZXh0cmEgd29yaywgYnV0IHN0
aWxsIGxldHMgdGhlIGJpdHMgZnJvbSB1c2VyLXNwYWNlDQo+IHRocm91Z2ggaW50byB0aGUgaGFy
ZHdhcmUuDQo+IA0KPiBJZiBuZXcgYml0cyBkbyB0dXJuIHVwLCB3ZSBjYW4gYWR2ZXJ0aXNlIGEg
Q0FQIHRoYXQgc2F5cyB0aGF0IEtWTSBzdXBwb3J0cyB3aGF0ZXZlciB0aGF0IGZlYXR1cmUgaXMu
DQo+IA0KPiANCj4gPj4gKEJhY2tncm91bmQ6IFZTRVNSIGlzIGEgNjRiaXQgcmVnaXN0ZXIgdGhh
dCBob2xkcyB0aGUgdmFsdWUgdG8gZ28gaW4NCj4gPj4gYSAzMmJpdCByZWdpc3Rlci4gSSBzdXNw
ZWN0IHRoZSB0b3AtaGFsZiBjb3VsZCBnZXQgcmUtdXNlZCBmb3INCj4gPj4gY29udHJvbCB2YWx1
ZXMgb3Igc29tZXRoaW5nIHdlIGRvbid0IHdhbnQgdG8gZ2l2ZSB1c2VyLXNwYWNlKQ0KPiANCj4g
PiAgIGRvIHlvdSBtZWFuIHdoZW4gdXNlci1zcGFjZSBnZXQgdGhlIFZTRVNSIHZhbHVlIHRocm91
Z2gNCj4gPiBLVk1fR0VUX1ZDUFVfRVZFTlRTIGl0IG9ubHkgcmV0dXJuIHRoZSBsb3ctaGFsZiAz
MiBiaXRzPw0KPiANCj4gTm8sIHRoZSBrZXJuZWwgd2lsbCBvbmx5IGV2ZXIgc2V0IGEgMjRiaXQg
dmFsdWUgaGVyZS4gSWYgd2UgZm9yY2UgdXNlci1zcGFjZSB0byBvbmx5IHByb3ZpZGUgYSAyNGJp
dCB2YWx1ZSB0aGVuIHdlIGRvbid0IG5lZWQgdG8gY2hlY2sgaXQgb24NCj4gcmVhZC4gV2UgbmV2
ZXIgcmVhZCB0aGUgdmFsdWUgYmFjayBmcm9tIGhhcmR3YXJlLg0KPiANCj4gVGhlc2UgaGlnaCBi
aXRzIGFyZSBSRVMwIGF0IHRoZSBtb21lbnQsIHRoZXkgbWF5IGdldCB1c2VkIGZvciBzb21ldGhp
bmcgaW4gdGhlIGZ1dHVyZS4gQXMgd2UgYXJlIGV4cG9zaW5nIHRoaXMgdmlhIGEgdXNlci1zcGFj
ZSBBQkkgd2UNCj4gbmVlZCB0byBtYWtlIHN1cmUgd2Ugb25seSBleHBvc2UgdGhlIGJpdHMgd2Ug
dW5kZXJzdGFuZCB0b2RheS4NCg0KT2sNCg0KPiANCj4gDQo+IFRoYW5rcywNCj4gDQo+IEphbWVz
DQo=
