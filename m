Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABADC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B1220870
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbfA3JB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:01:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:10817 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfA3JB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:01:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 01:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="134361625"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 30 Jan 2019 01:01:27 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 01:01:26 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 01:01:25 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.232]) with mapi id 14.03.0415.000;
 Wed, 30 Jan 2019 17:01:24 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] KVM: x86: Sync the pending Posted-Interrupts
Thread-Topic: [PATCH v2] KVM: x86: Sync the pending Posted-Interrupts
Thread-Index: AQHUuDc/JCDEt2PmwEi/JWQKAeKmNaXG9FYAgACJIZA=
Date:   Wed, 30 Jan 2019 09:01:23 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD5EE4@SHSMSX101.ccr.corp.intel.com>
References: <1548809972-32100-1-git-send-email-luwei.kang@intel.com>
 <0e8444a1-39a3-d217-8602-ae175fedc8b2@redhat.com>
In-Reply-To: <0e8444a1-39a3-d217-8602-ae175fedc8b2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTkxMzU0ZGYtMDA2OC00OGQ0LTgyMTYtZWMzMzVlNzVmMGUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaE5MV2NtelZQZFNCWnhrTUlUbCtUWnplTXo1UmUxRjJRTis3NUVDakxoc0Z0dDErNjhDTWVjR0dSMnJhUVRmOSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
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
IGlzIHByZWVtcHRlZCAodkNQVSBpbiBLVk1fTVBfU1RBVEVfUlVOTkFCTEUNCj4gPiBzdGF0ZSBi
dXQgbm90IHJ1bm5pbmcgb24gcGh5c2ljYWwgQ1BVKS4gSWYgYSBwb3N0ZWQgaW50ZXJydXB0IGNv
bWluZw0KPiA+IGF0IHRoaXMgdGltZSwgdGhlIGlycSByZW1tYXBpbmcgZmFjaWxpdHkgd2lsbCBz
ZXQgdGhlIGJpdCBvZiBQSVINCj4gPiAoUG9zdGVkIEludGVycnVwdCBSZXF1ZXN0cykgd2l0aG91
dCBPTiAoT3V0c3RhbmRpbmcgTm90aWZpY2F0aW9uKS4NCj4gPiBTbyB0aGlzIGludGVycnVwdCBj
YW4ndCBiZSBzeW5jIHRvIEFQSUMgdmlydHVhbGl6YXRpb24gcmVnaXN0ZXIgYW5kDQo+ID4gd2ls
bCBub3QgYmUgaGFuZGxlZCBieSBHdWVzdCBiZWNhdXNlIE9OIGlzIHplcm8uDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBMdXdlaSBLYW5nIDxsdXdlaS5rYW5nQGludGVsLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgYXJjaC94ODYva3ZtL3ZteC92bXguYyB8IDIgKy0NCj4gPiAgYXJjaC94ODYva3ZtL3g4
Ni5jICAgICB8IDIgKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC92bXgu
YyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMgaW5kZXgNCj4gPiBmNjkxNWYxLi44MjBhMDNiIDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCj4gPiArKysgYi9hcmNoL3g4
Ni9rdm0vdm14L3ZteC5jDQo+ID4gQEAgLTYwNDgsNyArNjA0OCw3IEBAIHN0YXRpYyBpbnQgdm14
X3N5bmNfcGlyX3RvX2lycihzdHJ1Y3Qga3ZtX3ZjcHUgKnZjcHUpDQo+ID4gIAlib29sIG1heF9p
cnJfdXBkYXRlZDsNCj4gPg0KPiA+ICAJV0FSTl9PTighdmNwdS0+YXJjaC5hcGljdl9hY3RpdmUp
Ow0KPiA+IC0JaWYgKHBpX3Rlc3Rfb24oJnZteC0+cGlfZGVzYykpIHsNCj4gPiArCWlmICghYml0
bWFwX2VtcHR5KCh1bnNpZ25lZCBsb25nICopdm14LT5waV9kZXNjLnBpciwgTlJfVkVDVE9SUykp
IHsNCj4gPiAgCQlwaV9jbGVhcl9vbigmdm14LT5waV9kZXNjKTsNCj4gPiAgCQkvKg0KPiA+ICAJ
CSAqIElPTU1VIGNhbiB3cml0ZSB0byBQSVIuT04sIHNvIHRoZSBiYXJyaWVyIG1hdHRlcnMgZXZl
biBvbiBVUC4NCj4gDQo+IFRoaXMgaXMgbm90IHdoYXQgSSBhc2tlZC4gIFlvdSBzaG91bGQgaW5z
dGVhZCBkbyB0aGUgY2hlY2sgYWZ0ZXIgcGlfY2xlYXJfc24uDQo+IA0KDQpJIHRoaW5rIHRoZSBT
TiBoYXMgYmVlbiBjbGVhcmVkIGhlcmUgYmVmb3JlIHRlc3QgdGhlIGJpdG1hcC4NClRoZSBTTiB3
aWxsIGJlIHNldCB3aGVuIHRoZSAgdkNQVSBpcyBzY2hlZHVsZSBvdXQuIElEOiAyOGI4MzVkNjBm
Y2MyNDk4ZTcxN2NmNWU2ZjBjMzY5MWMyNDU0NmY3DQpCdXQgU04gd2lsbCBiZSBjbGVhcmVkIHdo
ZW4gc2NoZWQgaW4uDQoNCkFub3RoZXIgcGxhY2UgaXMgd2hlbiB2Q1BVIHJ1biBvdXQgb2YgdGhl
IHZjcHVfcnVuKCkgZnVuY3Rpb246DQogICAgIGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKCkNCiAg
ICAgICAgIHZjcHVfbG9hZCh2Y3B1KTsgLT4ga3ZtX2FyY2hfdmNwdV9sb2FkIC0+IHZteF92Y3B1
X2xvYWQgLT4gdm14X3ZjcHVfcGlfbG9hZCAtPiBuZXcuc24gPSAwOw0KICAgICAgICAgdmNwdV9y
dW4odmNwdSk7DQogICAgICAgICAgICAgZm9yKDs7KQ0KICAgICAgICAgdmNwdV9wdXQodmNwdSk7
IC0+IGt2bV9hcmNoX3ZjcHVfcHV0IC0+IHZteF92Y3B1X3B1dCAtPiB2bXhfdmNwdV9waV9wdXQg
LT4gcGlfc2V0X3NuKCkNCkJ1dCBTTiB3aWxsIGJlIGNsZWFyZWQgaW4gdmNwdV9sb2FkKCkgYmVm
b3JlIGJhY2sgdG8gdmNwdV9ydW4oKQ0KDQpUaGFua3MsDQpMdXdlaSBLYW5nDQoNCg==
