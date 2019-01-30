Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A425C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A702184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfA3Knq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:43:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:34968 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfA3Knp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:43:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 02:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,540,1539673200"; 
   d="scan'208";a="113870142"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga008.jf.intel.com with ESMTP; 30 Jan 2019 02:43:45 -0800
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 30 Jan 2019 02:43:43 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.232]) with mapi id 14.03.0415.000;
 Wed, 30 Jan 2019 18:43:42 +0800
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
Thread-Index: AQHUuDc/JCDEt2PmwEi/JWQKAeKmNaXG9FYAgACJIZD//4kjgIAAl80QgAACS+A=
Date:   Wed, 30 Jan 2019 10:43:41 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD6156@SHSMSX101.ccr.corp.intel.com>
References: <1548809972-32100-1-git-send-email-luwei.kang@intel.com>
 <0e8444a1-39a3-d217-8602-ae175fedc8b2@redhat.com>
 <82D7661F83C1A047AF7DC287873BF1E172CD5EE4@SHSMSX101.ccr.corp.intel.com>
 <a876245b-6094-1767-ac63-dc8d31de9b84@redhat.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYzUyNTI0MTgtMmJiNy00OTdiLTlhNWMtZWE3ZDU0YTQzZDg4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTlA5NkJHdk1qYjFjQlk0a1E0MHlhQjJRc2JMY25PbVNpaStOUjk4QVZ1dTNRN1V2MEpQU3JQQUR5ZkV2bzhwWiJ9
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

PiA+ID4+IFRoaXMgaXMgbm90IHdoYXQgSSBhc2tlZC4gIFlvdSBzaG91bGQgaW5zdGVhZCBkbyB0
aGUgY2hlY2sgYWZ0ZXIgcGlfY2xlYXJfc24uDQo+ID4gPj4NCj4gPiA+DQo+ID4gPiBJIHRoaW5r
IHRoZSBTTiBoYXMgYmVlbiBjbGVhcmVkIGhlcmUgYmVmb3JlIHRlc3QgdGhlIGJpdG1hcC4NCj4g
PiA+IFRoZSBTTiB3aWxsIGJlIHNldCB3aGVuIHRoZSAgdkNQVSBpcyBzY2hlZHVsZSBvdXQuIElE
Og0KPiA+ID4gMjhiODM1ZDYwZmNjMjQ5OGU3MTdjZjVlNmYwYzM2OTFjMjQ1NDZmNw0KPiA+ID4g
QnV0IFNOIHdpbGwgYmUgY2xlYXJlZCB3aGVuIHNjaGVkIGluLg0KPiA+ID4NCj4gPiA+IEFub3Ro
ZXIgcGxhY2UgaXMgd2hlbiB2Q1BVIHJ1biBvdXQgb2YgdGhlIHZjcHVfcnVuKCkgZnVuY3Rpb246
DQo+ID4gPiAgICAgIGt2bV9hcmNoX3ZjcHVfaW9jdGxfcnVuKCkNCj4gPiA+ICAgICAgICAgIHZj
cHVfbG9hZCh2Y3B1KTsgLT4ga3ZtX2FyY2hfdmNwdV9sb2FkIC0+IHZteF92Y3B1X2xvYWQgLT4g
dm14X3ZjcHVfcGlfbG9hZCAtPiBuZXcuc24gPSAwOw0KPiA+ID4gICAgICAgICAgdmNwdV9ydW4o
dmNwdSk7DQo+ID4gPiAgICAgICAgICAgICAgZm9yKDs7KQ0KPiA+ID4gICAgICAgICAgdmNwdV9w
dXQodmNwdSk7IC0+IGt2bV9hcmNoX3ZjcHVfcHV0IC0+IHZteF92Y3B1X3B1dCAtPg0KPiA+ID4g
dm14X3ZjcHVfcGlfcHV0IC0+IHBpX3NldF9zbigpIEJ1dCBTTiB3aWxsIGJlIGNsZWFyZWQgaW4g
dmNwdV9sb2FkKCkNCj4gPiA+IGJlZm9yZSBiYWNrIHRvIHZjcHVfcnVuKCkNCj4gPg0KPiA+IFll
cywgYnV0IHlvdSdyZSBjaGFuZ2luZyB0aGUgd3JvbmcgcGF0aC4gIFRoZSBwYXRjaCBpcyBhZmZl
Y3RpbmcgX2FsbF8gdm1lbnRyaWVzLCBub3QganVzdCB0aG9zZSBhZnRlciBQSUQuU04gaGFzIGJl
ZW4gY2xlYXJlZC4NCj4gPg0KPiA+IEFzIEkgbWVudGlvbmVkIGluIHRoZSBwcmV2aW91cyBlbWFp
bCwgS1ZNIHJlbGllcyBvbiB0aGUgU0RNJ3MNCj4gPiBpbnZhcmlhbnQgdGhhdCBPTiB3aGVyZSBQ
SUQuT049MSB3aGVuZXZlciBQSUQuUElSIT0wLiAgSW52YXJpYW50cyBhcmUgeW91ciBiZXN0IGZy
aWVuZCB3aGVuIGRlYWxpbmcgd2l0aCBjb21wbGljYXRlZCBtdWx0aS1wcm9jZXNzb3INCj4gY29k
ZSBzbyBJIGRvbid0IHdhbnQgdG8gY2hhbmdlIHRoYXQuDQo+ID4NCj4gPiBJdCdzIHRoZSBWVC1k
IHBpX2NsZWFyX3NuIHBhdGggdGhhdCBJIHdhbnQgdG8gYmUgY2hhbmdlZCwgYmVjYXVzZSBpdCdz
DQo+ID4gVlQtZCBhbmQgc3BlY2lmaWNhbGx5IFNOIHRoYXQgY29tcGxpY2F0ZXMgdGhlIHZlcnkg
c2ltcGxlIGRlZmluaXRpb24gaW4gdGhlIFNETS4gIEJ5IG1vZGlmeWluZyB0aGUgcGlfY2xlYXJf
c24gcGF0aCwgeW91IGVuc3VyZSB0aGUNCj4gaW52YXJpYW50IGlzIHJlc3BlY3RlZCBhbmQgZXZl
cnlvbmUgaXMgaGFwcHkuDQo+IA0KPiBIaSBQYW9sbywNCj4gICAgIEhvdyBhYm91dCBsaWtlIHRo
aXM6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC92bXguYyBiL2FyY2gveDg2
L2t2bS92bXgvdm14LmMgaW5kZXggODIwYTAzYi4uZGZjNWUzZCAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYva3ZtL3ZteC92bXguYw0KPiArKysgYi9hcmNoL3g4Ni9rdm0vdm14L3ZteC5jDQo+IEBA
IC0xMjE5LDYgKzEyMTksOSBAQCBzdGF0aWMgdm9pZCB2bXhfdmNwdV9waV9sb2FkKHN0cnVjdCBr
dm1fdmNwdSAqdmNwdSwgaW50IGNwdSkNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbmV3Lm5k
c3QgPSAoZGVzdCA8PCA4KSAmIDB4RkYwMDsNCj4gDQo+ICAgICAgICAgICAgICAgICBuZXcuc24g
PSAwOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAoIWJpdG1hcF9lbXB0eSgodW5zaWduZWQg
bG9uZyAqKW5ldy5waXIsIE5SX1ZFQ1RPUlMpKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBu
ZXcub24gPSAxOw0KDQpTb3JyeSwgc2hvdWxkIGJlOg0KKyAgICAgICAgICAgICAgIGlmICghYml0
bWFwX2VtcHR5KCh1bnNpZ25lZCBsb25nICopcGlfZGVzYy0+cGlyLCBOUl9WRUNUT1JTKSkNCg0K
THV3ZWkgS2FuZw0KDQo+ICAgICAgICAgfSB3aGlsZSAoY21weGNoZzY0KCZwaV9kZXNjLT5jb250
cm9sLCBvbGQuY29udHJvbCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgbmV3LmNvbnRy
b2wpICE9IG9sZC5jb250cm9sKTsgIH0NCj4gDQo+IFRoYW5rcywNCj4gTHV3ZWkgS2FuZw0K
