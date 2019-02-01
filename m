Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B3AC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7DF218FC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfBAFom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:44:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:13629 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfBAFol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:44:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 21:44:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,547,1539673200"; 
   d="scan'208";a="111545264"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2019 21:44:40 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 31 Jan 2019 21:44:11 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 31 Jan 2019 21:44:10 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.232]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 13:44:09 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3] KVM: x86: Sync the pending Posted-Interrupts
Thread-Topic: [PATCH V3] KVM: x86: Sync the pending Posted-Interrupts
Thread-Index: AQHUuUJRjLIQOcS2Ek2942IJLMQAm6XIlSgAgAHZSfA=
Date:   Fri, 1 Feb 2019 05:44:08 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD9337@SHSMSX101.ccr.corp.intel.com>
References: <1548924722-64060-1-git-send-email-luwei.kang@intel.com>
 <f5011173-2732-654e-0e0c-a5a853b1821c@redhat.com>
In-Reply-To: <f5011173-2732-654e-0e0c-a5a853b1821c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFNvbWUgUG9zdGVkLUludGVycnVwdHMgZnJvbSBwYXNzdGhyb3VnaCBkZXZpY2VzIG1heSBi
ZSBsb3N0IG9yDQo+ID4gb3ZlcndyaXR0ZW4gd2hlbiB0aGUgdkNQVSBpcyBpbiBydW5uYWJsZSBz
dGF0ZS4NCj4gPg0KPiA+IFRoZSBTTiAoU3VwcHJlc3MgTm90aWZpY2F0aW9uKSBvZiBQSUQgKFBv
c3RlZCBJbnRlcnJ1cHQgRGVzY3JpcHRvcikNCj4gPiB3aWxsIGJlIHNldCB3aGVuIHRoZSB2Q1BV
IGlzIHByZWVtcHRlZCAodkNQVSBpbg0KPiBLVk1fTVBfU1RBVEVfUlVOTkFCTEUNCj4gPiBzdGF0
ZSBidXQgbm90IHJ1bm5pbmcgb24gcGh5c2ljYWwgQ1BVKS4gSWYgYSBwb3N0ZWQgaW50ZXJydXB0
IGNvbWluZw0KPiA+IGF0IHRoaXMgdGltZSwgdGhlIGlycSByZW1tYXBpbmcgZmFjaWxpdHkgd2ls
bCBzZXQgdGhlIGJpdCBvZiBQSVINCj4gPiAoUG9zdGVkIEludGVycnVwdCBSZXF1ZXN0cykgd2l0
aG91dCBPTiAoT3V0c3RhbmRpbmcgTm90aWZpY2F0aW9uKS4NCj4gPiBTbyB0aGlzIGludGVycnVw
dCBjYW4ndCBiZSBzeW5jIHRvIEFQSUMgdmlydHVhbGl6YXRpb24gcmVnaXN0ZXIgYW5kDQo+ID4g
d2lsbCBub3QgYmUgaGFuZGxlZCBieSBHdWVzdCBiZWNhdXNlIE9OIGlzIHplcm8uDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBMdXdlaSBLYW5nIDxsdXdlaS5rYW5nQGludGVsLmNvbT4NCj4gPiAt
LS0NCj4gPiAgYXJjaC94ODYva3ZtL3ZteC92bXguYyB8IDUgKysrKysNCj4gPiAgYXJjaC94ODYv
a3ZtL3g4Ni5jICAgICB8IDIgKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rdm0vdm14
L3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYyBpbmRleA0KPiA+IDQzNDExNzUuLjhlZDk2
MzQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguYw0KPiA+ICsrKyBiL2Fy
Y2gveDg2L2t2bS92bXgvdm14LmMNCj4gPiBAQCAtMTIyMSw2ICsxMjIxLDExIEBAIHN0YXRpYyB2
b2lkIHZteF92Y3B1X3BpX2xvYWQoc3RydWN0IGt2bV92Y3B1DQo+ICp2Y3B1LCBpbnQgY3B1KQ0K
PiA+ICAJCW5ldy5zbiA9IDA7DQo+ID4gIAl9IHdoaWxlIChjbXB4Y2hnNjQoJnBpX2Rlc2MtPmNv
bnRyb2wsIG9sZC5jb250cm9sLA0KPiA+ICAJCQkgICBuZXcuY29udHJvbCkgIT0gb2xkLmNvbnRy
b2wpOw0KPiA+ICsNCj4gDQo+IAkvKg0KPiAJICogQ2xlYXIgU04gYmVmb3JlIHJlYWRpbmcgdGhl
IGJpdG1hcC4gIFRoZSBWVC1kIGZpcm13YXJlDQo+IAkgKiB3cml0ZXMgdGhlIGJpdG1hcCBhbmQg
cmVhZHMgU04gYXRvbWljYWxseSAoNS4yLjMgaW4gdGhlDQo+IAkgKiBzcGVjKSwgc28gaXQgZG9l
c24ndCByZWFsbHkgaGF2ZSBhIG1lbW9yeSBiYXJyaWVyIHRoYXQNCj4gCSAqIHBhaXJzIHdpdGgg
dGhpcywgYnV0IHdlIGNhbm5vdCBkbyB0aGF0IGFuZCB3ZSBuZWVkIG9uZS4NCj4gCSAqLw0KPiAN
Cj4gPiArCXNtcF9tYl9fYWZ0ZXJfYXRvbWljKCk7DQo+ID4gKw0KPiA+ICsJaWYgKCFiaXRtYXBf
ZW1wdHkoKHVuc2lnbmVkIGxvbmcgKilwaV9kZXNjLT5waXIsIE5SX1ZFQ1RPUlMpKQ0KPiA+ICsJ
CXBpX3Rlc3RfYW5kX3NldF9vbihwaV9kZXNjKTsNCj4gDQo+IFlvdSBjYW4gYWRkIHBpX3NldF9v
biBmb3IgdXNlIGhlcmUuICBUaGUgZmFzdCBwYXRoIHdpdGggcGlfY2xlYXJfc24gc2hvdWxkDQo+
IGFsc28gYmUgcmVtb3ZlZC4NCg0KDQpEbyB5b3UgbWVhbiByZW1vdmUgdGhlIGJsb3cgY29kZSBp
biB2bXhfdmNwdV9waV9sb2FkKCkgZnVuY3Rpb24gdG8gbWFrZSB0aGUgT04gY2FuIGJlIHNldCBp
ZiBQSVIgaXMgbm90IHplcm8/DQoNCi0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCisrKyBi
L2FyY2gveDg2L2t2bS92bXgvdm14LmMNCkBAIC0xMTkyLDIxICsxMTkyLDYgQEAgc3RhdGljIHZv
aWQgdm14X3ZjcHVfcGlfbG9hZChzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUsIGludCBjcHUpDQogICAg
ICAgIGlmICghcGlfdGVzdF9zbihwaV9kZXNjKSAmJiB2Y3B1LT5jcHUgPT0gY3B1KQ0KICAgICAg
ICAgICAgICAgIHJldHVybjsNCg0KLSAgICAgICAvKg0KLSAgICAgICAgKiBGaXJzdCBoYW5kbGUg
dGhlIHNpbXBsZSBjYXNlIHdoZXJlIG5vIGNtcHhjaGcgaXMgbmVjZXNzYXJ5OyBqdXN0DQotICAg
ICAgICAqIGFsbG93IHBvc3Rpbmcgbm9uLXVyZ2VudCBpbnRlcnJ1cHRzLg0KLSAgICAgICAgKg0K
LSAgICAgICAgKiBJZiB0aGUgJ252JyBmaWVsZCBpcyBQT1NURURfSU5UUl9XQUtFVVBfVkVDVE9S
LCBkbyBub3QgY2hhbmdlDQotICAgICAgICAqIFBJLk5EU1Q6IHBpX3Bvc3RfYmxvY2sgd2lsbCBk
byBpdCBmb3IgdXMgYW5kIHRoZSB3YWtldXBfaGFuZGxlcg0KLSAgICAgICAgKiBleHBlY3RzIHRo
ZSBWQ1BVIHRvIGJlIG9uIHRoZSBibG9ja2VkX3ZjcHVfbGlzdCB0aGF0IG1hdGNoZXMNCi0gICAg
ICAgICogUEkuTkRTVC4NCi0gICAgICAgICovDQotICAgICAgIGlmIChwaV9kZXNjLT5udiA9PSBQ
T1NURURfSU5UUl9XQUtFVVBfVkVDVE9SIHx8DQotICAgICAgICAgICB2Y3B1LT5jcHUgPT0gY3B1
KSB7DQotICAgICAgICAgICAgICAgcGlfY2xlYXJfc24ocGlfZGVzYyk7DQotICAgICAgICAgICAg
ICAgcmV0dXJuOw0KLSAgICAgICB9DQoNClRoYW5rcywNCkx1d2VpIEthbmcNCg==
