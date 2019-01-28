Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68DBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACAC2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfA1II4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:08:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:42103 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfA1IIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:08:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2019 00:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,533,1539673200"; 
   d="scan'208";a="133685531"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga001.jf.intel.com with ESMTP; 28 Jan 2019 00:08:38 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 28 Jan 2019 00:08:38 -0800
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 28 Jan 2019 00:08:37 -0800
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.110]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.253]) with mapi id 14.03.0415.000;
 Mon, 28 Jan 2019 16:08:35 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Topic: [PATCH] KVM: x86: Sync the pending Posted-Interrupts
Thread-Index: AQHUrvgng1TGbq88YUCMNKU8aNpvOaW/01aAgAR9dGA=
Date:   Mon, 28 Jan 2019 08:08:35 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172CD3820@SHSMSX101.ccr.corp.intel.com>
References: <1547793240-9157-1-git-send-email-luwei.kang@intel.com>
 <a88ee1f8-ec49-f35f-5b97-65bb1ceb9ea4@redhat.com>
In-Reply-To: <a88ee1f8-ec49-f35f-5b97-65bb1ceb9ea4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjQzYmZmZjktNTI0ZC00Y2Q4LWI3YTUtMzhkYmZlOWRlNTk4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVDQ3TkM0NHRnWDlOTFJySGtrVzFIOVFST0JpNTJwWnljQ3R3K2xcL3VPNkIzelpVSmFKbVwvbmNqUXk5NFdMSGJsIn0=
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
ZXQgdGhlIGJpdCBvZiBQSVINCj4gPiAoUG9zdGVkIEludGVycnVwdCBSZXF1ZXN0cykgYnV0IE9O
IChPdXRzdGFuZGluZyBOb3RpZmljYXRpb24pLg0KPiA+IFNvIHRoaXMgaW50ZXJydXB0IGNhbid0
IGJlIHN5bmMgdG8gQVBJQyB2aXJ0dWFsaXphdGlvbiByZWdpc3RlciBhbmQNCj4gPiB3aWxsIG5v
dCBiZSBoYW5kbGVkIGJ5IEd1ZXN0IGJlY2F1c2UgT04gaXMgemVyby4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEx1d2VpIEthbmcgPGx1d2VpLmthbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+
ICBhcmNoL3g4Ni9rdm0vdm14L3ZteC5jIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9rdm0vdm14L3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC92bXguYyBpbmRleA0KPiA+IGY2OTE1
ZjEuLjgyMGEwM2IgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYva3ZtL3ZteC92bXguYw0KPiA+
ICsrKyBiL2FyY2gveDg2L2t2bS92bXgvdm14LmMNCj4gPiBAQCAtNjA0OCw3ICs2MDQ4LDcgQEAg
c3RhdGljIGludCB2bXhfc3luY19waXJfdG9faXJyKHN0cnVjdCBrdm1fdmNwdSAqdmNwdSkNCj4g
PiAgCWJvb2wgbWF4X2lycl91cGRhdGVkOw0KPiA+DQo+ID4gIAlXQVJOX09OKCF2Y3B1LT5hcmNo
LmFwaWN2X2FjdGl2ZSk7DQo+ID4gLQlpZiAocGlfdGVzdF9vbigmdm14LT5waV9kZXNjKSkgew0K
PiA+ICsJaWYgKCFiaXRtYXBfZW1wdHkoKHVuc2lnbmVkIGxvbmcgKil2bXgtPnBpX2Rlc2MucGly
LCBOUl9WRUNUT1JTKSkgew0KPiA+ICAJCXBpX2NsZWFyX29uKCZ2bXgtPnBpX2Rlc2MpOw0KPiA+
ICAJCS8qDQo+ID4gIAkJICogSU9NTVUgY2FuIHdyaXRlIHRvIFBJUi5PTiwgc28gdGhlIGJhcnJp
ZXIgbWF0dGVycyBldmVuIG9uIFVQLg0KPiA+DQo+IA0KPiBUaGlzIGlzIGEgdmVyeSBkZWxpY2F0
ZSBwYXRoLiAgVGhlIGJpdG1hcCBjaGVjayBoZXJlIGlzIG9yZGVyZWQgYWZ0ZXIgdGhlIHZjcHUt
Pm1vZGUgd3JpdGUgaW4gdmNwdV9lbnRlcl9ndWVzdCwgbWF0Y2hpbmcgdGhlIGNoZWNrIG9mDQo+
IHZjcHUtPm1vZGUgaW4gdm14X2RlbGl2ZXJfcG9zdGVkX2ludGVycnVwdCAod2hpY2ggY29tZXMg
YWZ0ZXIgYSB3cml0ZSBvZg0KPiBQSVIuT04pOg0KPiANCj4gCXNlbmRlcgkJCXJlY2VpdmVyDQo+
IAl3cml0ZSBQSVINCj4gCXdyaXRlIFBJUi5PTgkJdmNwdS0+bW9kZSA9IElOX0dVRVNUX01PREUN
Cj4gCXNtcF9tYigpCQlzbXBfbWIoKQ0KPiAJcmVhZCB2Y3B1LT5tb2RlCQlzeW5jX3Bpcl90b19p
cnINCj4gCQkJCSAgcmVhZCBQSVIuT04NCj4gDQo+IFdoYXQgeW91IGRpZCBzaG91bGQgd29yaywg
c2luY2UgUElSIGlzIHdyaXR0ZW4gYWZ0ZXIgUElSLk9OIGFueXdheS4NCg0KSGkgUGFvbG86DQog
ICAgSSB0aGluayB3aGF0IHlvdSBtZW50aW9uZWQgUElSLk9OIGhlcmUgaXMgUElELk9OOw0KICAg
IFBJRDogUG9zdGVkIEludGVycnVwdCBEZXNjcmlwdG9yIChhIHN0cnVjdHVyZSBmb3IgUEkgd2hp
Y2ggaW5jbHVkZSA1MTIgYml0cykNCiAgICBPTjogIE91dHN0YW5kaW5nIE5vdGlmaWNhdGlvbiAg
KG9uZSBiaXQgb2YgUElEKQ0KICAgIFBJUjogIFBvc3RlZCBJbnRlcnJ1cHQgUmVxdWVzdHMgKDI1
NiBiaXRzIGZvciBlYWNoIGludGVycnVwdCB2ZWN0b3IgaW4gUElEKQ0KDQogICAgQmVmb3JlIFZU
LWQgaXJxIHJlbWFwcGluZywgdGhlcmUganVzdCBoYXZlIFBJUiBhbmQgT04gaW4gUElELiBQb3N0
ZWQgaW50ZXJydXB0IGludHJvZHVjZWQgYnkgQVBJQ3YgY2FuIGJlIHVzZWQgZm9yIHNlbmQgSVBJ
LiBUaGUgd29ya2luZyBmbG93IG9mIHNlbnQgYSBwb3N0ZWQgaW50ZXJydXB0IHNob3cgaW4gdm14
X2RlbGl2ZXJfcG9zdGVkX2ludGVycnVwdCgpLg0KICAgIDEuIFNldCBQSVIgb2YgUElEDQogICAg
Mi4gU2V0IE9OIG9mIFBJRA0KICAgIDMuIFNlbmQgYSBJUEkgdG8gdGFyZ2V0IHZDUFUgd2l0aCBu
b3RpZmljYXRpb24gdmVjdG9yIChQT1NURURfSU5UUl9WRUNUT1IpIGlmIHRhcmdldCB2Q1BVIGlz
IFJ1bm5pbmcgb24gYSBwQ1BVOyBoYXZlIG5vIHZtLWV4aXQgYW5kIGhhbmRlZCBieSBndWVzdCBp
bnRlcnJ1cHQgaGFuZGxlciBkaXJlY3RseS4NCiAgICA0LiBpZiB0aGUgdGFyZ2V0IHZDUFUgaXMg
bm90IFJ1bm5pbmcgb24gcENQVSwgaW52b2tlIGt2bV92Y3B1X2tpY2soKSB0byB3YWtlIHVwIHRo
aXMgdkNQVSBvciBzZW5kIFJFU0NIRURVTEVfVkVDVE9SIElQSSB0byB0YXJnZXQgcENQVSB0byBt
YWtlIHRoZSB2Q1BVIHJ1bm5pbmcgYXMgc29vbiBhcyBwb3NzaWJsZS4NCiAgICA1LiBmb2xsb3cg
NC4gVGhlIHZDUFUgcHJlcGFyZSB0byBydW4gKHZjcHVfZW50ZXJfZ3Vlc3QpIGFuZCBzeW5jIHRo
ZSBwb3N0ZWQgaW50ZXJydXB0IG9mIE9OIGlzIHNldC4NCg0KICAgIEl0IGxvb2tzIGxpa2Ugd29y
ayB3ZWxsLiANCiAgICBWVC1kIGlycSByZW1hcHBpbmcgZmFjaWxpdHkgaW50cm9kdWNlIFNOLCBO
ViwgTkRTVCBpbiBQSUQuIFRoZXNlIGFyZSB1c2VkIGJ5IGlycSByZW1hcHBpbmcgZmFjaWxpdHkg
YW5kIENQVSBkb27igJl0IGNhcmUgdGhlc2UgZmxhZ3MuDQogICAgNi4gVGhlIGJpdCBvZiBTTiB3
aWxsIGJlIHNldCB3aGVuIHZDUFUgaWQgcHJlZW1wdGVkIChydW5uYWJsZSBidXQgbm90IHJ1bm5p
bmcpLg0KICAgICAgICAgY29tbWl0IDI4YjgzNWQ2MGZjYzI0OThlNzE3Y2Y1ZTZmMGMzNjkxYzI0
NTQ2ZjcNCiAgICAgICAgICBLVk06IFVwZGF0ZSBQb3N0ZWQtSW50ZXJydXB0cyBEZXNjcmlwdG9y
IHdoZW4gdkNQVSBpcyBwcmVlbXB0ZWQNCiAgICA3LiAgaWYgYSBpbnRlcnJ1cHQgY29taW5nIGF0
IHRoaXMgbW9tZW50LCBpcnEgcmVtYXBwaW5nIGZhY2lsaXR5IGp1c3Qgc2V0IFBJUiBidXQgKm5v
dCogc2V0IE9OIChWVC1kIHNwZWMgOS4xMikuDQogICAgU28sIGhlcmUsIHRoZSBpbnRlcnJ1cHQg
Y2FuJ3QgYmUgc3luYyB0byBJUlIgYmVjYXVzZSBPTiBpcyAwLg0KDQogICAgSSBhZGQgc29tZSBs
b2cgaGVyZSBhbmQgZm91bmQgc29tZSBpbnRlcnJ1cHQgcmVjb3JkZWQgaW4gUElSIGJ1dCBPTiBp
cyB6ZXJvLiBJdCB3aWxsIGltcGFjdCB0aGUgcGVyZm9ybWFuY2Ugb2YgcGFzcyB0aHJvdWdoIGRl
dmljZS4NCg0KPiBIb3dldmVyLCB5b3Ugc2hvdWxkIGF0IGxlYXN0IGNoYW5nZSB0aGUgY29tbWVu
dCBpbiB2Y3B1X2VudGVyX2d1ZXN0IHRvIG1lbnRpb24gImJlZm9yZSByZWFkaW5nIFBJUiIgaW5z
dGVhZCBvZiAiYmVmb3JlIHJlYWRpbmcNCj4gUElSLk9OIi4NCg0KV2lsbCBkbyB0aGF0LiBJIHRo
aW5rIHRoZSAiY2hlY2tpbmcgUElSLk9OIiBzaG91bGQgYmUgUElELk9OLiBJIHdpbGwgZml4IGl0
Lg0KDQo+IA0KPiBBbHRlcm5hdGl2ZWx5LCB3b3VsZCBpdCBiZSBwb3NzaWJsZSB0byBpbnN0ZWFk
IHNldCBPTiB3aGVuIFNOIGlzIGNsZWFyZWQ/ICBUaGUgY2xlYXJpbmcgb2YgU04gaXMgaW4gcGlf
Y2xlYXJfc24sIGFuZCB5b3Ugd291bGQgaGF2ZSBpbnN0ZWFkDQo+IHNvbWV0aGluZyBsaWtlDQoN
ClNOIGlzIGNsZWFyZWQgd2hlbiB0aGUgY29ycmVzcG9uZGluZyB2Q1BVIGlzIHJ1bm5pbmcgb24g
cENQVS4gSSB0aGluayB3ZSBjYW4ndCBzZXQgT04gd2hlbiBTTiBpcyBjbGVhcmVkLiAgQmVjYXVz
ZSB0aGVyZSBoYXZlIHNvbWUgd29yZHMgaW4gVlQtZCBzcGVjIDkuMTI6DQpJZiBPTiBpcyBzZXQg
YXQgdGhlIHRpbWUgb2YgaGFyZHdhcmUgcG9zdGluZyBhbiBpbnRlcnJ1cHQgdG8gUElSIGZpZWxk
LCBub3RpZmljYXRpb24gZXZlbnQgaXMgbm90IGdlbmVyYXRlZC4NCg0KPiANCj4gCVdSSVRFX09O
Q0UodTE2ICopJnBpX2Rlc2MtPm9uX3NuLCBQT1NURURfSU5UUl9PTik7DQoNCldlIGFscmVhZHkg
aGF2ZSBhIGZ1bmN0aW9uICAocGlfdGVzdF9vbikgdG8gY2hlY2sgdGhlIGJpdCBvZiBQT1NURURf
SU5UUl9PTi4gU28gSSB0aGluayBpdCBpcyB1bm5lY2Vzc2FyeS4NCg0KVGhhbmtzLA0KTHV3ZWkg
S2FuZw0KDQo+IA0KPiB3aGVyZSBvbl9zbiBpcyBhZGRlZCB0byBzdHJ1Y3QgcGlfZGVzYyBsaWtl
IHRoaXM6DQo+IA0KPiBAQCAtNjEsNCArNjAsNSBAQCBzdHJ1Y3QgcGlfZGVzYyB7DQo+ICAJCQl1
MzIJbmRzdDsNCj4gIAkJfTsNCj4gKwkJdTE2IG9uX3NuOw0KPiAgCQl1NjQgY29udHJvbDsNCj4g
IAl9Ow0KPiANCj4gUGFvbG8NCg==
