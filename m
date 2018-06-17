Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A492C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E492A20895
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 02:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E492A20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933687AbeFQChX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 22:37:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5939 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756946AbeFQChT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 22:37:19 -0400
Received: from DGGEMA402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 758D7A4E07838;
        Sun, 17 Jun 2018 10:37:15 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.111]) by
 DGGEMA402-HUB.china.huawei.com ([10.3.20.43]) with mapi id 14.03.0382.000;
 Sun, 17 Jun 2018 10:37:13 +0800
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
Thread-Index: AdQF2PP8MBanP2tNQqWU0qZjd6ZgSwACoHwQ
Date:   Sun, 17 Jun 2018 02:37:12 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201CE36DC@DGGEMA503-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.50.98]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiA+Pj4+PiAtLS0gYS9hcmNoL2FybS9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+ID4g
Pj4+Pj4gKysrIGIvYXJjaC9hcm0vaW5jbHVkZS91YXBpL2FzbS9rdm0uaA0KPiA+ID4+Pj4+IEBA
IC0xMjQsNiArMTI0LDE4IEBAIHN0cnVjdCBrdm1fc3luY19yZWdzIHsgIHN0cnVjdA0KPiA+ID4+
Pj4+IGt2bV9hcmNoX21lbW9yeV9zbG90IHsgIH07DQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiArLyog
Zm9yIEtWTV9HRVQvU0VUX1ZDUFVfRVZFTlRTICovIHN0cnVjdCBrdm1fdmNwdV9ldmVudHMgew0K
PiA+ID4+Pj4+ICsJc3RydWN0IHsNCj4gPiA+Pj4+PiArCQlfX3U4IHNlcnJvcl9wZW5kaW5nOw0K
PiA+ID4+Pj4+ICsJCV9fdTggc2Vycm9yX2hhc19lc3I7DQo+ID4gPj4+Pj4gKwkJLyogQWxpZ24g
aXQgdG8gOCBieXRlcyAqLw0KPiA+ID4+Pj4+ICsJCV9fdTggcGFkWzZdOw0KPiA+ID4+Pj4+ICsJ
CV9fdTY0IHNlcnJvcl9lc3I7DQo+ID4gPj4+Pj4gKwl9IGV4Y2VwdGlvbjsNCj4gPiA+Pj4+PiAr
CV9fdTMyIHJlc2VydmVkWzEyXTsNCj4gPiA+Pj4+PiArfTsNCj4gPiA+Pj4+PiArDQo+ID4gPj4+
Pg0KPiA+ID4+Pj4gWW91IGhhdmVuJ3QgZGVmaW5lZCBfX0tWTV9IQVZFX1ZDUFVfRVZFTlRTIGZv
ciAzMmJpdCwgc28NCj4gPiA+Pj4+IHByZXN1bWFibHkgdGhpcyBzdHJ1Y3Qgd2lsbCBuZXZlciBi
ZSB1c2VkLiBXaHkgaXMgaXQgaGVyZT8NCj4gPiA+Pg0KPiA+ID4+PiAgIGlmIG5vdCBhZGQgaXQg
Zm9yIDMyIGJpdHMuIHRoZSAzMiBhcm0gcGxhdGZvcm0gd2lsbCBidWlsZCBGYWlsLCB3aGV0aGVy
IHlvdSBoYXZlIGdvb2QNCj4gPiA+Pj4gICAgaWRlYSB0byBhdm9pZCB0aGlzIEZhaWx1cmUgaWYg
bm90IGFkZCB0aGlzIHN0cnVjdCBmb3IgdGhlIDMyIGJpdD8NCj4gPiA+Pg0KPiA+ID4+IEhvdyBk
b2VzIHRoaXMgMzJiaXQgY29kZSBidWlsZCB3aXRob3V0IHRoaXMgcGF0Y2g/DQo+ID4gPj4gSWYg
ZG8geW91IHByb3ZpZGUgdGhlIHN0cnVjdCwgaG93IHdpbGwgdGhhdCBjb2RlIGJ1aWxkIHdpdGgg
b2xkZXIgaGVhZGVycz8NCj4gPiA+Pg0KPiA+ID4+IEFzIGZhciBhcyBJIGNhbiBzZWUsIHRoaXMg
aXMgd2hhdCB0aGUgX19LVk1fSEFWRV9WQ1BVX0VWRU5UUyBkZWZpbmUgaXMgZm9yLg0KPiA+ID4+
DQo+ID4gPj4gVGhpcyBzaG91bGQgYmUgYm90aCwgb3IgbmVpdGhlci4gSGF2aW5nIGp1c3QgdGhl
IHN0cnVjdCBpcyB1c2VsZXNzLg0KPiA+ID4gSXQgYmVjYXVzZSB0aGUgY2FsbGVyIG9mIGt2bV9h
cm1fdmNwdV9nZXQvc2V0X2V2ZW50cygpIGlzIGluICJ2aXJ0L2t2bS9hcm0vYXJtLmMiLg0KPiA+
ID4gdGhlIHZpcnQva3ZtL2FybS9hcm0uYyB3aWxsIHVzZWQgYnkgYm90aCBhcm02NCBhbmQgYXJt
Lg0KPiA+ID4gc28gSXQgbmVlZHMgdG8gYWRkIGt2bV9hcm1fdmNwdV9nZXQvc2V0X2V2ZW50cygp
IGZvciB0aGUgMzIgYml0cywNCj4gPiA+IGhvd2V2ZXIsIGt2bV9hcm1fdmNwdV9nZXQvc2V0X2V2
ZW50cygpIHdpbGwgZGlyZWN0bHkgcmV0dXJuLA0KPiA+DQo+ID4gU28geW91IGFyZSBhZGRpbmcg
YSB1YXBpIHN0cnVjdCB0aGF0IHVzZXItc3BhY2UgY2FuJ3QgYWN0dWFsbHkgdXNlLCB0byBhdm9p
ZCBhIGtlcm5lbCBidWlsZC1lcnJvci4gRmluZSwgaXQganVzdCBsb29rcyByZWFsbHkgc3RyYW5n
ZS4NCj4gPg0KPiA+IDMyYml0IHVzZXItc3BhY2Ugc2hvdWxkbid0IHRyeSB0byBjYWxsIHRoaXMg
YXMgY2hlY2stZXh0ZW5zaW9uIHJlcG9ydHMNCj4gPiBpdCBhcyBub3QgcHJlc2VudC4gSWYgaXQg
ZG9lcywgaXQgZ2V0cyAtRUlOVkFMIGJhY2ssIHdoaWNoIGlzIGFsc28gdGhlIGRlZmF1bHQgZm9y
IGt2bV9hcmNoX3ZjcHVfaW9jdGwoKS4NCg0KSnVzdCB0aGluayBvdXQgYSBtZXRob2QgdG8gYXZv
aWQgYWRkaW5nIHRoZSBzdHJ1Y3R1cmUgZm9yIHRoZSBhcm0zMi4NCg0KVXNpbmcgYmVsb3cgbWV0
aG9kczoNCg0KI0lmZGVmIF9fS1ZNX0hBVkVfVkNQVV9FVkVOVFMNCgl4eHh4eHh4eHh4eHh4eHh4
eHh4eHgNCiNlbHNlDQoJWHh4eHh4eHh4eHh4eHh4eA0KI2VuZGlmDQoNCj4gDQo+IEl0IGluZGVl
ZCBsb29rcyBzdHJhbmdlLiBCZWNhdXNlICJ2aXJ0L2t2bS9hcm0vYXJtLmMiIGlzIHNoYXJlZCBi
eSBhcm02NCBhbmQgYXJtMzIsIGlmIG5vdCBhZGRpbmcsIGl0IHdpbGwgYnVpbGQtZXJyb3IuIERv
IHlvdSBoYXZlIGEgYmV0dGVyDQo+IGlkZWEgdG8gYXZvaWQgYWRkaW5nIGluIGFybTMyPw0KPiBJ
IHN0aWxsIG5vdCB0aGluayBvdXQgYSBnb29kIG1ldGhvZC4gMzIgdXNlci1zcGFjZSB3aWxsIG5v
dCBjYWxsIHRoaXMgS1ZNX0dFVC9TRVRfVkNQVV9FVkVOVFMgSU9DVEwgYXMgY2hlY2stZXh0ZW5z
aW9uIHJlcG9ydHMgaXQgYXMgbm90DQo+IHByZXNlbnQuDQo+IA0KPiA+DQo+ID4NCj4gPiBUaGFu
a3MsDQo+ID4NCj4gPiBKYW1lcw0K
