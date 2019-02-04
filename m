Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312D4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F086D2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfBDW3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:29:38 -0500
Received: from mga03.intel.com ([134.134.136.65]:13526 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfBDW3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:29:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 14:29:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="140652615"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2019 14:29:34 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.248]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.158]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 14:29:34 -0800
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Leif Lindholm" <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>
Subject: RE: [PATCH 02/10] x86/efi: Return error status if mapping EFI
 regions fail
Thread-Topic: [PATCH 02/10] x86/efi: Return error status if mapping EFI
 regions fail
Thread-Index: AQHUutt7LSE8klPKh0KE/vBXB1rXuqXPw/SAgAACwwCAAHQnQA==
Date:   Mon, 4 Feb 2019 22:29:34 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F486FF4C3@ORSMSX114.amr.corp.intel.com>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
 <20190202094119.13230-3-ard.biesheuvel@linaro.org>
 <20190204071809.GA115714@gmail.com>
 <CAKv+Gu-vxV_U03jdMY0N1UMDWcB1jZLKj-ONV2rsw3UTeimhBg@mail.gmail.com>
In-Reply-To: <CAKv+Gu-vxV_U03jdMY0N1UMDWcB1jZLKj-ONV2rsw3UTeimhBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTQwY2Q5OTAtNDFlZi00NWViLThkODMtNzQ0MDIwMTg3MTBhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieGpjZUpPZkpMK3dRWjdmTDBrSXpxTDJqeG91MEZRWHR5dXFuK1htdlg1cWdldjdkZDk0eHFJU0RhQVh1Yk12ViJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gZWZpX21hcF9yZWdpb24oKSBjcmVhdGVzIFZBIG1hcHBpbmdzIGZvciBhbiBnaXZlbiBF
RkkgcmVnaW9uIHVzaW5nDQo+ID4gPiBhbnkgb25lIG9mIHRoZSB0d28gaGVscGVyIGZ1bmN0aW9u
cyAobmFtZWx5IF9fbWFwX3JlZ2lvbigpIGFuZA0KPiBvbGRfbWFwX3JlZ2lvbigpKS4NCj4gPiA+
IFRoZXNlIGhlbHBlciBmdW5jdGlvbnMgKmNvdWxkKiBmYWlsIHdoaWxlIGNyZWF0aW5nIG1hcHBp
bmdzIGFuZA0KPiA+ID4gcHJlc2VudGx5IHRoZWlyIHJldHVybiB2YWx1ZSBpcyBub3QgY2hlY2tl
ZC4gTm90IGNoZWNraW5nIGZvciB0aGUNCj4gPiA+IHJldHVybiB2YWx1ZSBvZiB0aGVzZSBmdW5j
dGlvbnMgbWlnaHQgY3JlYXRlIGlzc3VlcyBiZWNhdXNlIGFmdGVyDQo+ID4gPiB0aGVzZSBmdW5j
dGlvbnMgcmV0dXJuICJtZC0+dmlydF9hZGRyIiBpcyBzZXQgdG8gdGhlIHJlcXVlc3RlZA0KPiA+
ID4gdmlydHVhbCBhZGRyZXNzIChzbyBpdCdzIGFzc3VtZWQgdGhhdCB0aGVzZSBmdW5jdGlvbnMg
YWx3YXlzIHN1Y2NlZWQNCj4gPiA+IHdoaWNoIGlzIG5vdCBxdWl0ZSB0cnVlKS4gVGhpcyBhc3N1
bXB0aW9uIGxlYWRzIHRvICJtZC0+dmlydF9hZGRyIg0KPiA+ID4gaGF2aW5nIGludmFsaWQgbWFw
cGluZyBzaG91bGQgYW55IG9mDQo+ID4gPiBfX21hcF9yZWdpb24oKSBvciBvbGRfbWFwX3JlZ2lv
bigpIGZhaWwuDQo+ID4gPg0KPiA+ID4gSGVuY2UsIGNoZWNrIGZvciB0aGUgcmV0dXJuIHZhbHVl
IG9mIHRoZXNlIGZ1bmN0aW9ucyBhbmQgaWYgaW5kZWVkDQo+ID4gPiB0aGV5IGZhaWwsIHR1cm4g
b2ZmIEVGSSBSdW50aW1lIFNlcnZpY2VzIGZvcmV2ZXIgYmVjYXVzZSBrZXJuZWwNCj4gPiA+IGNh
bm5vdCBwcmlvcml0aXplIGFtb25nIEVGSSByZWdpb25zLg0KPiA+ID4NClsuLi4uLi4uLi4uLi4u
Li4uLi4uXQ0KPiA+ID4gLXZvaWQgX19pbml0IG9sZF9tYXBfcmVnaW9uKGVmaV9tZW1vcnlfZGVz
Y190ICptZCkNCj4gPiA+ICtpbnQgX19pbml0IG9sZF9tYXBfcmVnaW9uKGVmaV9tZW1vcnlfZGVz
Y190ICptZCkNCj4gPiA+ICB7DQo+ID4gPiAgICAgICB1NjQgc3RhcnRfcGZuLCBlbmRfcGZuLCBl
bmQ7DQo+ID4gPiAgICAgICB1bnNpZ25lZCBsb25nIHNpemU7DQo+ID4gPiBAQCAtNjAxLDEwICs2
MDEsMTQgQEAgdm9pZCBfX2luaXQgb2xkX21hcF9yZWdpb24oZWZpX21lbW9yeV9kZXNjX3QNCj4g
Km1kKQ0KPiA+ID4gICAgICAgICAgICAgICB2YSA9IGVmaV9pb3JlbWFwKG1kLT5waHlzX2FkZHIs
IHNpemUsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWQtPnR5cGUsIG1k
LT5hdHRyaWJ1dGUpOw0KPiA+ID4NCj4gPiA+IC0gICAgIG1kLT52aXJ0X2FkZHIgPSAodTY0KSAo
dW5zaWduZWQgbG9uZykgdmE7DQo+ID4gPiAtICAgICBpZiAoIXZhKQ0KPiA+ID4gKyAgICAgaWYg
KCF2YSkgew0KPiA+ID4gICAgICAgICAgICAgICBwcl9lcnIoImlvcmVtYXAgb2YgMHglbGxYIGZh
aWxlZCFcbiIsDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZyBsb25n
KW1kLT5waHlzX2FkZHIpOw0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4g
PiA+ICsgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICsgICAgIG1kLT52aXJ0X2FkZHIgPSAodTY0KSh1
bnNpZ25lZCBsb25nKXZhOw0KPiA+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiBKdXN0IHdv
bmRlcmluZywgc2hvdWxkbid0IHRoZSBmYWlsdXJlIHBhdGggc2V0IC0+dmlydF9hZGRyIHRvDQo+
ID4gc29tZXRoaW5nIHNhZmUsIGp1c3QgaW4gY2FzZSBhIGNhbGxlciBkb2Vzbid0IGNoZWNrIHRo
ZSBlcnJvciBhbmQgcmVsaWVzIG9uIGl0Pw0KPiA+DQo+ID4gVGhhdCdzIGJlY2F1c2UgaW4gdGhp
cyBjb21taXQgd2UndmUgbm93IGNoYW5nZWQgaXQgZnJvbSAwIHRvIHVuZGVmaW5lZC4NCj4gPg0K
PiANCj4gSW5kZWVkLiBXZSBkb24ndCB1c3VhbGx5IHJlbHkgb24gdGhlIHZhbHVlIG9mIC0+dmly
dF9hZGRyIHdoZW4NCj4gRUZJX1JVTlRJTUVfU0VSVklDRVMgaXMgdW5zZXQsIGJ1dCB0aGVyZSBp
cyBzb21lIHN5c2ZzIGNvZGUsIGFuZCBwZXJoYXBzDQo+IHNvbWUgb3RoZXIgcGxhY2VzIHdoZXJl
IHdlIGRvIHJlZmVyZW5jZSAtPnZpcnRfYWRkciwgYW5kIG5vdCBhc3NpZ25pbmcgaXQgYXQgYWxs
DQo+IGlzIG9idmlvdXNseSB3cm9uZywgYW5kIHBvdGVudGlhbGx5IGhhemFyZG91cy4NCj4NCg0K
T2suLiBtYWtlcyBzZW5zZS4NCkRvIHlvdSB0aGluayBtZC0+dmlydF9hZGRyID0gMCBmb3IgZmFp
bCBjYXNlIGlzIG9rPw0KDQo+ID4gPiAraW50IF9faW5pdCBlZmlfbWFwX3JlZ2lvbl9maXhlZChl
ZmlfbWVtb3J5X2Rlc2NfdCAqbWQpIHsgcmV0dXJuIDA7DQo+ID4gPiArfQ0KPiA+DQo+ID4gSW5s
aW5lIGZ1bmN0aW9ucyBzaG91bGQgYmUgbWFya2VkIGlubGluZSAuLi4NCj4gPg0KPiA+ID4gICAg
ICAgaWYgKGVmaV92YSA8IEVGSV9WQV9FTkQpIHsNCj4gPiA+IC0gICAgICAgICAgICAgcHJfd2Fy
bihGV19XQVJOICJWQSBhZGRyZXNzIHJhbmdlIG92ZXJmbG93IVxuIik7DQo+ID4gPiAtICAgICAg
ICAgICAgIHJldHVybjsNCj4gPiA+ICsgICAgICAgICAgICAgcHJfZXJyKEZXX1dBUk4gIlZBIGFk
ZHJlc3MgcmFuZ2Ugb3ZlcmZsb3chXG4iKTsNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1F
Tk9NRU07DQo+ID4gPiAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgLyogRG8gdGhlIFZBIG1h
cCAqLw0KPiA+ID4gLSAgICAgX19tYXBfcmVnaW9uKG1kLCBlZmlfdmEpOw0KPiA+ID4gKyAgICAg
aWYgKF9fbWFwX3JlZ2lvbihtZCwgZWZpX3ZhKSkNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQo+ID4gPiArDQo+ID4gPiAgICAgICBtZC0+dmlydF9hZGRyID0gZWZpX3ZhOw0K
PiA+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiBTYW1lIGVycm9yIHJldHVybiBwcm9ibGVt
IG9mIGxlYXZpbmcgLT52aXJ0X2FkZHIgdW5kZWZpbmVkLg0KPiA+DQoNClN1cmUhIFdpbGwgZml4
IGl0IGluIFYyLg0KDQo+ID4gTm90ZSB0aGF0IEkgYWxzbyBmaXhlZCB1cCB0aGUgZ3JhbW1hciBh
bmQgcmVhZGFiaWxpdHkgb2YgdGhlIGNoYW5nZWxvZw0KPiA+IC0gc2VlIHRoZSB1cGRhdGVkIHZl
cnNpb24gYmVsb3cuDQoNClRoYW5rcyBmb3IgZml4aW5nIDopDQoNCj4gPg0KPiA+IFRoYW5rcywN
Cj4gPg0KPiA+ICAgICAgICAgSW5nbw0KPiA+DQo+ID4gPT09PT09PT09PT09PT4NCj4gPiBTdWJq
ZWN0OiB4ODYvZWZpOiBSZXR1cm4gZXJyb3Igc3RhdHVzIGlmIG1hcHBpbmcgb2YgRUZJIHJlZ2lv
bnMgZmFpbHMNCj4gPiBGcm9tOiBBcmQgQmllc2hldXZlbCA8YXJkLmJpZXNoZXV2ZWxAbGluYXJv
Lm9yZz4NCj4gPiBEYXRlOiBTYXQsIDIgRmViIDIwMTkgMTA6NDE6MTEgKzAxMDANCj4gPg0KPiA+
IEZyb206IFNhaSBQcmFuZWV0aCBQcmFraHlhIDxzYWkucHJhbmVldGgucHJha2h5YUBpbnRlbC5j
b20+DQo+ID4NCj4gPiBlZmlfbWFwX3JlZ2lvbigpIGNyZWF0ZXMgVkEgbWFwcGluZ3MgZm9yIGEg
Z2l2ZW4gRUZJIHJlZ2lvbiB1c2luZyBvbmUNCj4gPiBvZiB0aGUgdHdvIGhlbHBlciBmdW5jdGlv
bnMgKG5hbWVseSBfX21hcF9yZWdpb24oKSBhbmQgb2xkX21hcF9yZWdpb24oKSkuDQo+ID4NCj4g
PiBUaGVzZSBoZWxwZXIgZnVuY3Rpb25zIGNvdWxkIGZhaWwgd2hpbGUgY3JlYXRpbmcgbWFwcGlu
Z3MgYW5kDQo+ID4gcHJlc2VudGx5IHRoZWlyIHJldHVybiB2YWx1ZSBpcyBub3QgY2hlY2tlZC4N
Cj4gPg0KPiA+IE5vdCBjaGVja2luZyBmb3IgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGVzZSBmdW5j
dGlvbnMgbWlnaHQgY3JlYXRlDQo+ID4gYnVncywgYmVjYXVzZSBhZnRlciB0aGVzZSBmdW5jdGlv
bnMgcmV0dXJuICJtZC0+dmlydF9hZGRyIiBpcyBzZXQgdG8NCj4gPiB0aGUgcmVxdWVzdGVkIHZp
cnR1YWwgYWRkcmVzcyAoc28gaXQncyBhc3N1bWVkIHRoYXQgdGhlc2UgZnVuY3Rpb25zDQo+ID4g
YWx3YXlzIHN1Y2NlZWQgd2hpY2ggaXMgbm90IHF1aXRlIHRydWUpLiBUaGlzIGFzc3VtcHRpb24g
bGVhZHMgdG8NCj4gPiAibWQtPnZpcnRfYWRkciIgaGF2aW5nIGludmFsaWQgbWFwcGluZywgc2hv
dWxkIGFueSBvZiBfX21hcF9yZWdpb24oKQ0KPiA+IG9yIG9sZF9tYXBfcmVnaW9uKCkgZmFpbC4N
Cj4gPg0KPiA+IEhlbmNlLCBjaGVjayBmb3IgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGVzZSBmdW5j
dGlvbnMgYW5kIGlmIGluZGVlZA0KPiA+IHRoZXkgZmFpbCwgdHVybiBvZmYgRUZJIFJ1bnRpbWUg
U2VydmljZXMgZm9yZXZlciBiZWNhdXNlIGtlcm5lbCBjYW5ub3QNCj4gPiBwcmlvcml0aXplIGFt
b25nIEVGSSByZWdpb25zLg0KPiA+DQo+ID4gVGhpcyBhbHNvIGZpeGVzIHRoZSBjb21tZW50ICJG
SVhNRTogYWRkIGVycm9yIGhhbmRsaW5nIiBpbg0KPiA+IGtleGVjX2VudGVyX3ZpcnR1YWxfbW9k
ZSgpLg0KPiA+DQo+IA0KPiBUaGFua3MgSW5nby4NCj4gDQo+IFNhaSwgY291bGQgeW91IHBsZWFz
ZSByZXNwaW4gdGhpcyBhbmQgdXNlIEluZ28ncyB1cGRhdGVkIHZlcnNpb24gb2YgdGhlIGNvbW1p
dA0KPiBsb2c/DQoNClN1cmUhIEkgd2lsbCBzZW5kIGEgVjIgd2l0aCB0aGUgbWVudGlvbmVkIGNo
YW5nZXMuDQoNClJlZ2FyZHMsDQpTYWkNCg==
