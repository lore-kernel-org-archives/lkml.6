Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92FEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7935A222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iteZfiEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfBLR2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:28:14 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:37418 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfBLR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:28:13 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 18A1310C1089;
        Tue, 12 Feb 2019 09:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549992493; bh=x3T3CwdHQeYUDbGxk79CilbO244f2fzElJ7UqBA+Iek=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iteZfiEvk5kbGuJQtluNuTeW7eljfYJ5cHb9k0QB1mjvrE1gnkD51OpDQmYF8PwQr
         xKmKGIx1cjoiX1XQKraCWgXcFLo0rbtA2tZ71bmoHi6OPCjsc8AjmOi+27PdYa0Y3s
         gGQP7T/bJeUdkIjsGD2vtaBywvYGBleSqDisxLXyPYcLlR2emrInn5IMNnXK9B/DTE
         f+8UbyZkt2+dHIUPt1co1a419n44vQ/p4JHKcJTvtw7qNoYFyxqZTPhOZdQ7n5On/F
         ncipgz1Kp1Vn03mnf+MWUiT+qV2xTS2lXvPySp4bvNOvUe35PFwLtGZHq70dt12fPX
         PREvJUjs7O6Sw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 07BBAA0096;
        Tue, 12 Feb 2019 17:28:13 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 12 Feb 2019 09:25:30 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 12 Feb 2019 18:25:28 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "clabbe@baylibre.com" <clabbe@baylibre.com>
Subject: Re: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Topic: [PATCH 1/2] ARC: U-boot: check arguments paranoidly
Thread-Index: AQHUwuky4+Unt9C270mQi3IiF/O/oqXcWUwA
Date:   Tue, 12 Feb 2019 17:25:27 +0000
Message-ID: <1549992326.27724.98.camel@synopsys.com>
References: <20190212153932.28371-1-Eugeniy.Paltsev@synopsys.com>
         <20190212153932.28371-2-Eugeniy.Paltsev@synopsys.com>
         <C2D7FE5348E1B147BCA15975FBA23075014643364E@US01WEMBX2.internal.synopsys.com>
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075014643364E@US01WEMBX2.internal.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.62]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B78BF2FB38C9CC4B964C06BB2F691ED0@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTEyIGF0IDE2OjQ1ICswMDAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDIvMTIvMTkgNzozOSBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiA+IEhhbmRsZSBV
LWJvb3QgYXJndW1lbnRzIHBhcmFub2lkbHk6DQo+ID4gICogZG9uJ3QgYWxsb3cgdG8gcGFzcyB1
bmtub3duIHRhZy4NCj4gPiAgKiB0cnkgdG8gdXNlIGV4dGVybmFsIGRldmljZSB0cmVlIGJsb2Ig
b25seSBpZiBjb3JyZXNwb25kaW5nIHRhZw0KPiA+ICAgIChUQUdfRFRCKSBpcyBzZXQuDQo+ID4g
ICogY2hlY2sgdGhhdCBtYWdpYyBudW1iZXIgaXMgY29ycmVjdC4NCj4gPiAgKiBkb24ndCBjaGVj
ayB1Ym9vdF90YWcgaWYga2VybmVsIGJ1aWxkIHdpdGggbm8gQVJDX1VCT09UX1NVUFBPUlQuDQo+
ID4gDQo+ID4gTk9URToNCj4gPiBJZiBVLWJvb3QgYXJncyBhcmUgaW52YWxpZCB3ZSBza2lwIHRo
ZW0gYW5kIHRyeSB0byB1c2UgZW1iZWRkZWQgZGV2aWNlDQo+ID4gdHJlZSBibG9iLiBXZSBjYW4n
dCBwYW5pYyBvbiBpbnZhbGlkIFUtYm9vdCBhcmdzIGFzIHdlIHJlYWxseSBwYXNzDQo+ID4gaW52
YWxpZCBhcmdzIGR1ZSB0byBidWcgaW4gVS1ib290IGNvZGUuDQo+ID4gVGhpcyBoYXBwZW5zIGlm
IHdlIGRvbid0IHByb3ZpZGUgZXh0ZXJuYWwgRFRCIHRvIFUtYm9vdCBhbmQNCj4gPiBkb24ndCBz
ZXQgJ2Jvb3RhcmdzJyBVLWJvb3QgZW52aXJvbm1lbnQgdmFyaWFibGUgKHdoaWNoIGlzIGRlZmF1
bHQNCj4gPiBjYXNlIGF0IGxlYXN0IGZvciBIU0RLIGJvYXJkKSBJbiB0aGF0IGNhc2Ugd2Ugd2ls
bCBwYXNzDQo+ID4ge3IwID0gMSAoYm9vdGFyZ3MgaW4gcjIpOyByMSA9IDA7IHIyID0gMDt9IHRv
IGxpbnV4IHdoaWNoIGlzIGludmFsaWQuDQo+ID4gDQo+ID4gTk9URToNCj4gPiBXZSBjYW4gc2Fm
ZWx5IGNoZWNrIFUtYm9vdCBtYWdpYyB2YWx1ZSAoMHgwKSBpbiBsaW51eCBwYXNzZWQgdmlhDQo+
ID4gcjEgcmVnaXN0ZXIgYXMgVS1ib290IHBhc3MgaXQgZnJvbSB0aGUgYmVnaW5uaW5nLg0KPiA+
IA0KPiA+IFdoaWxlIEknbSBhdCBpdCByZWZhY3RvciBVLWJvb3QgYXJndW1lbnRzIGhhbmRsaW5n
IGNvZGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRXVnZW5peSBQYWx0c2V2IDxFdWdlbml5
LlBhbHRzZXZAc3lub3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FyYy9rZXJuZWwvaGVh
ZC5TICB8ICA1ICstLQ0KPiA+ICBhcmNoL2FyYy9rZXJuZWwvc2V0dXAuYyB8IDkyICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAgMiBmaWxlcyBj
aGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcmMva2VybmVsL2hlYWQuUyBiL2FyY2gvYXJjL2tlcm5lbC9oZWFkLlMN
Cj4gPiBpbmRleCA4YjkwZDI1YTE1Y2MuLmZjY2VhMzYxZTg5NiAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FyYy9rZXJuZWwvaGVhZC5TDQo+ID4gKysrIGIvYXJjaC9hcmMva2VybmVsL2hlYWQuUw0K
PiA+IEBAIC05MywxMCArOTMsMTEgQEAgRU5UUlkoc3RleHQpDQo+ID4gICNpZmRlZiBDT05GSUdf
QVJDX1VCT09UX1NVUFBPUlQNCj4gPiAgCTsgVWJvb3QgLSBrZXJuZWwgQUJJDQo+ID4gIAk7ICAg
IHIwID0gWzBdIE5vIHVib290IGludGVyYWN0aW9uLCBbMV0gY21kbGluZSBpbiByMiwgWzJdIERU
QiBpbiByMg0KPiA+IC0JOyAgICByMSA9IG1hZ2ljIG51bWJlciAoYm9hcmQgaWRlbnRpdHksIHVu
dXNlZCBhcyBvZiBub3cNCj4gPiArCTsgICAgcjEgPSBtYWdpYyBudW1iZXIgKGFsd2F5cyB6ZXJv
IGFzIG9mIG5vdykNCj4gDQo+IFRoaXMgaXMgdGVjaG5pY2FsbHkgY2hhbmdpbmcgdGhlIEFCSSAt
IEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBlbmZvcmNlIHRoaXMgLQ0KPiBrZWVwIGlnbm9yaW5n
IHRoaXMNCg0KSSB0aGluayBpdCdzIGJldHRlciB0byBhZGQgdGhpcyBjaGVjazoNCiAqIFRoaXMg
Y2hlY2sgZG9lc24ndCBicmVhayBiYWNrd2FyZCBjb21wYXRpYmlsaXR5LiBBUkMgVS1ib290IHBh
c3MgemVybyB0byByMQ0KICAgZnJvbSB0aGUgYmVnaW5uaW5ncywgSSBzcGVjaWFsbHkgY2hlY2tl
ZCB0aGlzLiBTbyB3ZSBkb2Vzbid0IGNoYW5nZSBBQkksDQogICB3ZSBvbmx5IGRvY3VtZW50IGl0
IDspIA0KICogQnkgYWRkaW5nIHRoaXMgY2hlY2sgd2UgY2FuIGNoZWFwIGFuZCBlYXNpbHkgbWlu
aW1pemUgcHJvYmxlbXMgaW4gSlRBRyBjYXNlLg0KDQo+ID4gKw0KPiA+ICsJaWYgKHVzZV9lbWJl
ZGRlZF9kdGIpIHsNCj4gPiAgCQltYWNoaW5lX2Rlc2MgPSBzZXR1cF9tYWNoaW5lX2ZkdChfX2R0
Yl9zdGFydCk7DQo+ID4gIAkJaWYgKCFtYWNoaW5lX2Rlc2MpDQo+ID4gIAkJCXBhbmljKCJFbWJl
ZGRlZCBEVCBpbnZhbGlkXG4iKTsNCj4gPiArCX0NCj4gPiAgDQo+ID4gLQkJLyoNCj4gPiAtCQkg
KiBJZiB3ZSBhcmUgaGVyZSwgaXQgaXMgZXN0YWJsaXNoZWQgdGhhdCBAdWJvb3RfYXJnIGRpZG4n
dA0KPiA+IC0JCSAqIHBvaW50IHRvIERUIGJsb2IuIEluc3RlYWQgaWYgdS1ib290IHNheXMgaXQg
aXMgY21kbGluZSwNCj4gPiAtCQkgKiBhcHBlbmQgdG8gZW1iZWRkZWQgRFQgY21kbGluZS4NCj4g
PiAtCQkgKiBzZXR1cF9tYWNoaW5lX2ZkdCgpIHdvdWxkIGhhdmUgcG9wdWxhdGVkIEBib290X2Nv
bW1hbmRfbGluZQ0KPiA+IC0JCSAqLw0KPiANCj4gRG9uJ3QgZHJvcCB0aGlzIGNvbW1lbnQsIHNw
ZWNpYWxseSB0aGUgbGFzdCBsaW5lLiBJZiB3YXMgdGVtcHRlZCB0byBtb3ZlIHRoZSBjbWQNCj4g
bGluZSBwcm9jZXNzaW5nIGJlZm9yZSBidXQgdGhpcyBzYXZlZCBtZSBzaW5jZSB3ZSByZWx5IG9u
IHNldHVwX21hY2hpbmVfZmR0KCkNCj4gYmVpbmcgY2FsbGVkIGFwcmlvaXJpLg0KDQpPaywgd2ls
bCBmaXggaW4gdjINCg0KPiA+IC0JCWlmICh1Ym9vdF90YWcgPT0gMSkgew0KPiA+IC0JCQkvKiBF
bnN1cmUgYSB3aGl0ZXNwYWNlIGJldHdlZW4gdGhlIDIgY21kbGluZXMgKi8NCj4gPiAtCQkJc3Ry
bGNhdChib290X2NvbW1hbmRfbGluZSwgIiAiLCBDT01NQU5EX0xJTkVfU0laRSk7DQo+ID4gLQkJ
CXN0cmxjYXQoYm9vdF9jb21tYW5kX2xpbmUsIHVib290X2FyZywNCj4gPiAtCQkJCUNPTU1BTkRf
TElORV9TSVpFKTsNCj4gPiAtCQl9DQo+ID4gKwlpZiAoYXBwZW5kX2NtZGxpbmUpIHsNCj4gPiAr
CQkvKiBFbnN1cmUgYSB3aGl0ZXNwYWNlIGJldHdlZW4gdGhlIDIgY21kbGluZXMgKi8NCj4gPiAr
CQlzdHJsY2F0KGJvb3RfY29tbWFuZF9saW5lLCAiICIsIENPTU1BTkRfTElORV9TSVpFKTsNCj4g
PiArCQlzdHJsY2F0KGJvb3RfY29tbWFuZF9saW5lLCAoY2hhciAqKXVib290X2FyZywgQ09NTUFO
RF9MSU5FX1NJWkUpOw0KPiA+ICAJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICt2b2lkIF9faW5pdCBz
ZXR1cF9hcmNoKGNoYXIgKipjbWRsaW5lX3ApDQo+ID4gK3sNCj4gPiArCWhhbmRsZV91Ym9vdF9h
cmdzKCk7DQo+ID4gIA0KPiA+ICAJLyogU2F2ZSB1bnBhcnNlZCBjb21tYW5kIGxpbmUgY29weSBm
b3IgL3Byb2MvY21kbGluZSAqLw0KPiA+ICAJKmNtZGxpbmVfcCA9IGJvb3RfY29tbWFuZF9saW5l
Ow0KPiANCj4gDQotLSANCiBFdWdlbml5IFBhbHRzZXY=
