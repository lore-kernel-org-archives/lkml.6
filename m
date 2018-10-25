Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D54ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0110A20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0110A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJYJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:05:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:62354 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbeJYJFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:05:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 17:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,422,1534834800"; 
   d="scan'208";a="85370688"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 24 Oct 2018 17:35:14 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 24 Oct 2018 17:35:14 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.102]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.84]) with mapi id 14.03.0415.000;
 Thu, 25 Oct 2018 08:35:12 +0800
From:   "Kang, Luwei" <luwei.kang@intel.com>
To:     Jim Mattson <jmattson@google.com>
CC:     kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Marc Orr <marcorr@google.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: RE: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
Thread-Topic: [PATCH v13 06/12] KVM: x86: Add Intel PT virtualization work
 mode
Thread-Index: AQHUa3CrSmGUmyBSyUy4MzZKiwm0DqUuDVQAgAEJRcA=
Date:   Thu, 25 Oct 2018 00:35:11 +0000
Message-ID: <82D7661F83C1A047AF7DC287873BF1E172BD64F1@SHSMSX101.ccr.corp.intel.com>
References: <1540368316-12998-1-git-send-email-luwei.kang@intel.com>
 <1540368316-12998-7-git-send-email-luwei.kang@intel.com>
 <CALMp9eSNr_AedOLv+gcqayFQSpwxQnVdsJQSWG1qixwNUmQXzw@mail.gmail.com>
In-Reply-To: <CALMp9eSNr_AedOLv+gcqayFQSpwxQnVdsJQSWG1qixwNUmQXzw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2Q2Mjc4NDUtMWU4ZC00ZjUyLTkzODAtMWEyNGVjYTBiNzZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiXC9oRm5RVksyR2tcLzJhWHV6WWsreWRsWFE5ckJxZ1ZlenVvbUZjem83VFoxVldONDdiZlZ6MTZITDJUYmxKeW1cLyJ9
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

PiA+IEZyb206IENoYW8gUGVuZyA8Y2hhby5wLnBlbmdAbGludXguaW50ZWwuY29tPg0KPiA+DQo+
ID4gSW50ZWwgUHJvY2Vzc29yIFRyYWNlIHZpcnR1YWxpemF0aW9uIGNhbiBiZSB3b3JrIGluIG9u
ZSBvZiAyIHBvc3NpYmxlDQo+ID4gbW9kZXM6DQo+ID4NCj4gPiBhLiBTeXN0ZW0tV2lkZSBtb2Rl
IChkZWZhdWx0KToNCj4gPiAgICBXaGVuIHRoZSBob3N0IGNvbmZpZ3VyZXMgSW50ZWwgUFQgdG8g
Y29sbGVjdCB0cmFjZSBwYWNrZXRzDQo+ID4gICAgb2YgdGhlIGVudGlyZSBzeXN0ZW0sIGl0IGNh
biBsZWF2ZSB0aGUgcmVsZXZhbnQgVk1YIGNvbnRyb2xzDQo+ID4gICAgY2xlYXIgdG8gYWxsb3cg
Vk1YLXNwZWNpZmljIHBhY2tldHMgdG8gcHJvdmlkZSBpbmZvcm1hdGlvbg0KPiA+ICAgIGFjcm9z
cyBWTVggdHJhbnNpdGlvbnMuDQo+ID4gICAgS1ZNIGd1ZXN0IHdpbGwgbm90IGF3YXJlIHRoaXMg
ZmVhdHVyZSBpbiB0aGlzIG1vZGUgYW5kIGJvdGgNCj4gPiAgICBob3N0IGFuZCBLVk0gZ3Vlc3Qg
dHJhY2Ugd2lsbCBvdXRwdXQgdG8gaG9zdCBidWZmZXIuDQo+ID4NCj4gPiBiLiBIb3N0LUd1ZXN0
IG1vZGU6DQo+ID4gICAgSG9zdCBjYW4gY29uZmlndXJlIHRyYWNlLXBhY2tldCBnZW5lcmF0aW9u
IHdoaWxlIGluDQo+ID4gICAgVk1YIG5vbi1yb290IG9wZXJhdGlvbiBmb3IgZ3Vlc3RzIGFuZCBy
b290IG9wZXJhdGlvbg0KPiA+ICAgIGZvciBuYXRpdmUgZXhlY3V0aW5nIG5vcm1hbGx5Lg0KPiA+
ICAgIEludGVsIFBUIHdpbGwgYmUgZXhwb3NlZCB0byBLVk0gZ3Vlc3QgaW4gdGhpcyBtb2RlLCBh
bmQNCj4gPiAgICB0aGUgdHJhY2Ugb3V0cHV0IHRvIHJlc3BlY3RpdmUgYnVmZmVyIG9mIGhvc3Qg
YW5kIGd1ZXN0Lg0KPiA+ICAgIEluIHRoaXMgbW9kZSwgdGh0IHN0YXR1cyBvZiBQVCB3aWxsIGJl
IHNhdmVkIGFuZCBkaXNhYmxlZA0KPiA+ICAgIGJlZm9yZSBWTS1lbnRyeSBhbmQgcmVzdG9yZWQg
YWZ0ZXIgVk0tZXhpdCBpZiB0cmFjZQ0KPiA+ICAgIGEgdmlydHVhbCBtYWNoaW5lLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQ2hhbyBQZW5nIDxjaGFvLnAucGVuZ0BsaW51eC5pbnRlbC5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogTHV3ZWkgS2FuZyA8bHV3ZWkua2FuZ0BpbnRlbC5jb20+DQo+
ID4gLS0tDQo+IA0KPiA+ICsjZGVmaW5lIFNFQ09OREFSWV9FWEVDX1BUX1VTRV9HUEEgICAgICAg
ICAgICAgIDB4MDEwMDAwMDANCj4gPiArI2RlZmluZSBWTV9FWElUX0NMRUFSX0lBMzJfUlRJVF9D
VEwgICAgICAgICAgICAweDAyMDAwMDAwDQo+ID4gKyNkZWZpbmUgVk1fRU5UUllfTE9BRF9JQTMy
X1JUSVRfQ1RMICAgICAgICAgICAgMHgwMDA0MDAwMA0KPiANCj4gV2hlcmUgYXJlIGFsbCBvZiB0
aGVzZSBiaXRzIGRvY3VtZW50ZWQ/IEknbSBsb29raW5nIGF0IHRoZSBsYXRlc3QgU0RNLCB2b2x1
bWUgMyAoMzI1Mzg0LTA2N1VTKSwgYW5kIG5vbmUgb2YgdGhlc2UgYml0cyBhcmVkb2N1bWVudGVk
DQo+IHRoZXJlLg0KDQpUaGlzIHBhcnQgaXMgaW4gdGhlICIgSW50ZWzCriBBcmNoaXRlY3R1cmUg
SW5zdHJ1Y3Rpb24gU2V0IEV4dGVuc2lvbnMgYW5kIEZ1dHVyZSBGZWF0dXJlcyBQcm9ncmFtbWlu
ZyBSZWZlcmVuY2UiDQpodHRwczovL3NvZnR3YXJlLmludGVsLmNvbS9zaXRlcy9kZWZhdWx0L2Zp
bGVzL21hbmFnZWQvYzUvMTUvYXJjaGl0ZWN0dXJlLWluc3RydWN0aW9uLXNldC1leHRlbnNpb25z
LXByb2dyYW1taW5nLXJlZmVyZW5jZS5wZGYNCg0KPiANCj4gPiArICAgICAgIEdVRVNUX0lBMzJf
UlRJVF9DVEwgICAgICAgICAgICAgPSAweDAwMDAyODE0LA0KPiA+ICsgICAgICAgR1VFU1RfSUEz
Ml9SVElUX0NUTF9ISUdIICAgICAgICA9IDB4MDAwMDI4MTUsDQo+IA0KPiBXaGVyZSBpcyB0aGlz
IFZNQ1MgZmllbGQgZG9jdW1lbnRlZD8NCj4gDQo+ID4gKy8qIERlZmF1bHQgaXMgU1lTVEVNIG1v
ZGUuICovDQo+ID4gK3N0YXRpYyBpbnQgX19yZWFkX21vc3RseSBwdF9tb2RlID0gUFRfTU9ERV9T
WVNURU07DQo+ID4gK21vZHVsZV9wYXJhbShwdF9tb2RlLCBpbnQsIFNfSVJVR08pOw0KPiANCj4g
QXMgYSBtb2R1bGUgcGFyYW1ldGVyLCB0aGlzIGRvZXNuJ3QgYWxsb3cgbXVjaCBmbGV4aWJpbGl0
eS4gSXMgaXQgcG9zc2libGUgdG8gbWFrZSB0aGlzIGRlY2lzaW9uIHBlci1WTSwgdXNpbmcgYSBW
TSBjYXBhYmlsaXR5IHRoYXQgY2FuIGJlIHNldA0KPiBieSB1c2Vyc3BhY2U/IChJbiB0aGF0IGNh
c2UsIGl0IG1heSBtYWtlIHNlbnNlIHRvIGhhdmUgYSBtb2R1bGUgcGFyYW1ldGVyIHdoaWNoIGFs
bG93cy9kaXNhbGxvd3MgdGhlIHBlci1WTSBjYXBhYmlsaXR5LikNCg0KSXQgaXMgYSBnb29kIGlk
ZWEgZnJvbSBteSBwb2ludCBvZiB2aWV3LCBJIHRoaW5rIGl0IG5lZWQgbW9yZSBkaXNjdXNzaW9u
IGFuZCBjYW4gYmUgaW1wbGVtZW50IGluIG5leHQgcGhhc2UgaWYgaGF2ZSBzdHJvbmcgcmVxdWly
ZW1lbnQuDQoNCj4gDQo+IA0KPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wgY3B1X2hhc192bXhfaW50
ZWxfcHQodm9pZCkgew0KPiA+ICsgICAgICAgdTY0IHZteF9tc3I7DQo+ID4gKw0KPiA+ICsgICAg
ICAgcmRtc3JsKE1TUl9JQTMyX1ZNWF9NSVNDLCB2bXhfbXNyKTsNCj4gPiArICAgICAgIHJldHVy
biAhISh2bXhfbXNyICYgTVNSX0lBMzJfVk1YX01JU0NfSU5URUxfUFQpOyB9DQo+IA0KPiBJbnN0
ZWFkIG9mIHRoZSByZG1zciBoZXJlLCB3b3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gY2FjaGUgdGhl
IElBMzJfVk1YX01JU0MgTVNSIGluIHZtY3NfY29uZmlnPw0KPiBOaXQ6IHRocm91Z2hvdXQgdGhp
cyBjaGFuZ2UsIHRoZSAnISEnIGlzbid0IG5lY2Vzc2FyeSB3aGVuIGNhc3RpbmcgYW4gaW50ZWdl
ciB0eXBlIHRvIGJvb2wuDQoNCk1TUl9JQTMyX1ZNWF9NSVNDIGlzIG5vdCByZWFkIGZyZXF1ZW5j
eSBhbmQganVzdCByZWFkIG9uY2UgaW4gdGhpcyBwYXRjaCBzZXQgZHVyaW5nIGluaXRpYWxpemF0
aW9uLg0KDQpUaGFua3MsDQpMdXdlaSBLYW5nDQoNCg==
