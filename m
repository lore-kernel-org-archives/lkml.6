Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7168AC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB42086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 01:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFB42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933388AbeFQBah (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 21:30:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932418AbeFQBaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 21:30:35 -0400
Received: from DGGEMA406-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 69C1AD8596F21;
        Sun, 17 Jun 2018 09:30:20 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.111]) by
 DGGEMA406-HUB.china.huawei.com ([10.3.20.47]) with mapi id 14.03.0382.000;
 Sun, 17 Jun 2018 09:30:21 +0800
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
Thread-Index: AdQF2PP8MBanP2tNQqWU0qZjd6ZgSw==
Date:   Sun, 17 Jun 2018 01:30:20 +0000
Message-ID: <0184EA26B2509940AA629AE1405DD7F201CE33F0@DGGEMA503-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.45.61.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Pj4+PiAtLS0gYS9hcmNoL2FybS9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+ID4+Pj4+ICsr
KyBiL2FyY2gvYXJtL2luY2x1ZGUvdWFwaS9hc20va3ZtLmgNCj4gPj4+Pj4gQEAgLTEyNCw2ICsx
MjQsMTggQEAgc3RydWN0IGt2bV9zeW5jX3JlZ3MgeyAgc3RydWN0DQo+ID4+Pj4+IGt2bV9hcmNo
X21lbW9yeV9zbG90IHsgIH07DQo+ID4+Pj4+DQo+ID4+Pj4+ICsvKiBmb3IgS1ZNX0dFVC9TRVRf
VkNQVV9FVkVOVFMgKi8gc3RydWN0IGt2bV92Y3B1X2V2ZW50cyB7DQo+ID4+Pj4+ICsJc3RydWN0
IHsNCj4gPj4+Pj4gKwkJX191OCBzZXJyb3JfcGVuZGluZzsNCj4gPj4+Pj4gKwkJX191OCBzZXJy
b3JfaGFzX2VzcjsNCj4gPj4+Pj4gKwkJLyogQWxpZ24gaXQgdG8gOCBieXRlcyAqLw0KPiA+Pj4+
PiArCQlfX3U4IHBhZFs2XTsNCj4gPj4+Pj4gKwkJX191NjQgc2Vycm9yX2VzcjsNCj4gPj4+Pj4g
Kwl9IGV4Y2VwdGlvbjsNCj4gPj4+Pj4gKwlfX3UzMiByZXNlcnZlZFsxMl07DQo+ID4+Pj4+ICt9
Ow0KPiA+Pj4+PiArDQo+ID4+Pj4NCj4gPj4+PiBZb3UgaGF2ZW4ndCBkZWZpbmVkIF9fS1ZNX0hB
VkVfVkNQVV9FVkVOVFMgZm9yIDMyYml0LCBzbyBwcmVzdW1hYmx5DQo+ID4+Pj4gdGhpcyBzdHJ1
Y3Qgd2lsbCBuZXZlciBiZSB1c2VkLiBXaHkgaXMgaXQgaGVyZT8NCj4gPj4NCj4gPj4+ICAgaWYg
bm90IGFkZCBpdCBmb3IgMzIgYml0cy4gdGhlIDMyIGFybSBwbGF0Zm9ybSB3aWxsIGJ1aWxkIEZh
aWwsIHdoZXRoZXIgeW91IGhhdmUgZ29vZA0KPiA+Pj4gICAgaWRlYSB0byBhdm9pZCB0aGlzIEZh
aWx1cmUgaWYgbm90IGFkZCB0aGlzIHN0cnVjdCBmb3IgdGhlIDMyIGJpdD8NCj4gPj4NCj4gPj4g
SG93IGRvZXMgdGhpcyAzMmJpdCBjb2RlIGJ1aWxkIHdpdGhvdXQgdGhpcyBwYXRjaD8NCj4gPj4g
SWYgZG8geW91IHByb3ZpZGUgdGhlIHN0cnVjdCwgaG93IHdpbGwgdGhhdCBjb2RlIGJ1aWxkIHdp
dGggb2xkZXIgaGVhZGVycz8NCj4gPj4NCj4gPj4gQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhpcyBp
cyB3aGF0IHRoZSBfX0tWTV9IQVZFX1ZDUFVfRVZFTlRTIGRlZmluZSBpcyBmb3IuDQo+ID4+DQo+
ID4+IFRoaXMgc2hvdWxkIGJlIGJvdGgsIG9yIG5laXRoZXIuIEhhdmluZyBqdXN0IHRoZSBzdHJ1
Y3QgaXMgdXNlbGVzcy4NCj4gPiBJdCBiZWNhdXNlIHRoZSBjYWxsZXIgb2Yga3ZtX2FybV92Y3B1
X2dldC9zZXRfZXZlbnRzKCkgaXMgaW4gInZpcnQva3ZtL2FybS9hcm0uYyIuDQo+ID4gdGhlIHZp
cnQva3ZtL2FybS9hcm0uYyB3aWxsIHVzZWQgYnkgYm90aCBhcm02NCBhbmQgYXJtLg0KPiA+IHNv
IEl0IG5lZWRzIHRvIGFkZCBrdm1fYXJtX3ZjcHVfZ2V0L3NldF9ldmVudHMoKSBmb3IgdGhlIDMy
IGJpdHMsDQo+ID4gaG93ZXZlciwga3ZtX2FybV92Y3B1X2dldC9zZXRfZXZlbnRzKCkgd2lsbCBk
aXJlY3RseSByZXR1cm4sDQo+IA0KPiBTbyB5b3UgYXJlIGFkZGluZyBhIHVhcGkgc3RydWN0IHRo
YXQgdXNlci1zcGFjZSBjYW4ndCBhY3R1YWxseSB1c2UsIHRvIGF2b2lkIGEga2VybmVsIGJ1aWxk
LWVycm9yLiBGaW5lLCBpdCBqdXN0IGxvb2tzIHJlYWxseSBzdHJhbmdlLg0KPiANCj4gMzJiaXQg
dXNlci1zcGFjZSBzaG91bGRuJ3QgdHJ5IHRvIGNhbGwgdGhpcyBhcyBjaGVjay1leHRlbnNpb24g
cmVwb3J0cyBpdCBhcyBub3QgcHJlc2VudC4gSWYgaXQgZG9lcywgaXQgZ2V0cyAtRUlOVkFMIGJh
Y2ssIHdoaWNoIGlzIGFsc28gdGhlDQo+IGRlZmF1bHQgZm9yIGt2bV9hcmNoX3ZjcHVfaW9jdGwo
KS4NCg0KSXQgaW5kZWVkIGxvb2tzIHN0cmFuZ2UuIEJlY2F1c2UgInZpcnQva3ZtL2FybS9hcm0u
YyIgaXMgc2hhcmVkIGJ5IGFybTY0IGFuZCBhcm0zMiwgaWYgbm90IGFkZGluZywgaXQgd2lsbCBi
dWlsZC1lcnJvci4gRG8geW91IGhhdmUgYSBiZXR0ZXIgaWRlYSB0byBhdm9pZCBhZGRpbmcgaW4g
YXJtMzI/IA0KSSBzdGlsbCBub3QgdGhpbmsgb3V0IGEgZ29vZCBtZXRob2QuIDMyIHVzZXItc3Bh
Y2Ugd2lsbCBub3QgY2FsbCB0aGlzIEtWTV9HRVQvU0VUX1ZDUFVfRVZFTlRTIElPQ1RMIGFzIGNo
ZWNrLWV4dGVuc2lvbiByZXBvcnRzIGl0IGFzIG5vdCBwcmVzZW50Lg0KDQo+IA0KPiANCj4gVGhh
bmtzLA0KPiANCj4gSmFtZXMNCg==
