Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27712C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5718216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5718216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=asrmicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbeKLRa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:30:29 -0500
Received: from asrmicro.com ([210.13.118.86]:19157 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeKLRa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:30:29 -0500
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 12 Nov
 2018 15:38:08 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Mon, 12 Nov 2018 15:38:08 +0800
From:   =?utf-8?B?WmhhbmcgWmhpemhvdSjlvKDmsrvmtLIp?= 
        <zhizhouzhang@asrmicro.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "alex.popov@linux.com" <alex.popov@linux.com>,
        "labbott@redhat.com" <labbott@redhat.com>,
        "panand@redhat.com" <panand@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "zhizhouzh@gmail.com" <zhizhouzh@gmail.com>
Subject: RE: [PATCH] arm64: disable KASAN for save_trace()
Thread-Topic: [PATCH] arm64: disable KASAN for save_trace()
Thread-Index: AQHUeXQV+mmG97pyY06Fhxt0/hB/3qVKTYaAgAFrUoA=
Date:   Mon, 12 Nov 2018 07:38:07 +0000
Message-ID: <28fb310518294fbebf82ce22e4620cd3@mail2012.asrmicro.com>
References: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
 <20181111172333.ov25gdmlsmhc6ysp@salmiak>
In-Reply-To: <20181111172333.ov25gdmlsmhc6ysp@salmiak>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.170.214]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyayBSdXRsYW5kIFtt
YWlsdG86bWFyay5ydXRsYW5kQGFybS5jb21dDQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMTIs
IDIwMTggMToyNCBBTQ0KPiBUbzogWmhhbmcgWmhpemhvdSjlvKDmsrvmtLIpIDx6aGl6aG91emhh
bmdAYXNybWljcm8uY29tPg0KPiBDYzogY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVh
Y29uQGFybS5jb207DQo+IG1wYXRvY2thQHJlZGhhdC5jb207IGFsZXgucG9wb3ZAbGludXguY29t
OyBsYWJib3R0QHJlZGhhdC5jb207DQo+IHBhbmFuZEByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyB6aGl6aG91emhAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkaXNh
YmxlIEtBU0FOIGZvciBzYXZlX3RyYWNlKCkNCj4gDQo+IE9uIFN1biwgTm92IDExLCAyMDE4IGF0
IDA4OjA3OjE2UE0gKzA4MDAsIFpoaXpob3UgWmhhbmcgd3JvdGU6DQo+ID4gc2F2ZV90cmFjZSgp
IHdoaWNoIGlzIGNhbGxlZCBmcm9tIHdhbGtfc3RhY2tmcmFtZSgpIGFsd2F5cyB0cnkgdG8NCj4g
PiByZWFkL3dyaXRlIGNhbGxlcidzIHN0YWNrLiBUaGlzIHJlc3VsdHMgS0FTQU4gc3RhY2stb3V0
LW9mLWJvdW5kcw0KPiA+IHdhcm5pbmcuIFNvIG11dGUgaXQuDQo+IA0KPiBUaGUgc2F2ZV90cmFj
ZSgpIGZ1bmN0aW9uIHNob3VsZCBuZXZlciBwZXJmb3JtIGFuIG91dC1vZi1ib3VuZHMgYWNjZXNz
IG9uDQo+IHRoZSBjYWxsZXIncyBzdGFjaywgc28gdGhpcyBpcyBwYXBlcmluZyBvdmVyIGEgYnVn
IGVsc2V3aGVyZS4NCj4gDQo+IENhbiB5b3UgcGxlYXNlIGdpdmVuIGFuIGV4YW1wbGUgcmVwb3J0
IGZyb20gS0FTQU4/DQo+IA0KSSdtIHNvcnJ5LCBJIGRvbid0IGhhdmUgYSBkZXZpY2Ugd2l0aCB0
aGUgbmV3ZXN0IGtlcm5lbCBvbiBoYW5kLiBTbyBteSB0ZXN0IGlzIGJhc2VkIG9uIDQuNC4xNDUu
IFRoZSBzdGFjayBpcyBzaG93biBiZWxvdzoNCg0KYzQgMCAoc3dhcHBlci80KSA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0N
CmM0IDAgKHN3YXBwZXIvNCkgQlVHOiBLQVNBTjogc3RhY2stb3V0LW9mLWJvdW5kcyBpbiBzYXZl
X3RyYWNlKzB4OTgvMHgxMzANCmM0IDAgKHN3YXBwZXIvNCkgV3JpdGUgb2Ygc2l6ZSA4IGF0IGFk
ZHIgZmZmZmZmYzA5YjA0ZmJlMCBieSB0YXNrIHN3YXBwZXIvNC8wDQpjNCAwIChzd2FwcGVyLzQp
IA0KYzQgMCAoc3dhcHBlci80KSBDUFU6IDQgUElEOiAwIENvbW06IHN3YXBwZXIvNCBOb3QgdGFp
bnRlZCA0LjQuMTQ1KyAjMg0KYzQgMCAoc3dhcHBlci80KSBIYXJkd2FyZSBuYW1lOiBBU1IgQVFV
SUxBQyBFVkIgKERUKQ0KYzQgMCAoc3dhcHBlci80KSBDYWxsIHRyYWNlOg0KYzQgMCAoc3dhcHBl
ci80KSBbPGZmZmZmZjkwMDgwOTFhNTA+XSBkdW1wX2JhY2t0cmFjZSsweDAvMHg0MTgNCmM0IDAg
KHN3YXBwZXIvNCkgWzxmZmZmZmY5MDA4MDkxZTkwPl0gc2hvd19zdGFjaysweDI4LzB4MzgNCmM0
IDAgKHN3YXBwZXIvNCkgWzxmZmZmZmY5MDA4NjI1MmE0Pl0gZHVtcF9zdGFjaysweGU4LzB4MTNj
DQpjNCAwIChzd2FwcGVyLzQpIFs8ZmZmZmZmOTAwODMxYzE2ND5dIHByaW50X2FkZHJlc3NfZGVz
Y3JpcHRpb24rMHg4Yy8weDJiMA0KYzQgMCAoc3dhcHBlci80KSBbPGZmZmZmZjkwMDgzMWM2OTA+
XSBrYXNhbl9yZXBvcnQrMHgyMTAvMHgzMzANCmM0IDAgKHN3YXBwZXIvNCkgWzxmZmZmZmY5MDA4
MzFhYzQ0Pl0gX19hc2FuX3N0b3JlOCsweDg0LzB4OTgNCmM0IDAgKHN3YXBwZXIvNCkgWzxmZmZm
ZmY5MDA4MDkwY2QwPl0gc2F2ZV90cmFjZSsweDk4LzB4MTMwDQpjNCAwIChzd2FwcGVyLzQpIFs8
ZmZmZmZmOTAwODA5MTE3ND5dIHdhbGtfc3RhY2tmcmFtZSsweDRjLzB4NjgNCmM0IDAgKHN3YXBw
ZXIvNCkgWzxmZmZmZmY5MDA4MDkxMmNjPl0gc2F2ZV9zdGFja190cmFjZV90c2srMHgxM2MvMHgx
ZjgNCmM0IDAgKHN3YXBwZXIvNCkgWzxmZmZmZmY5MDA4MDkxM2IwPl0gc2F2ZV9zdGFja190cmFj
ZSsweDI4LzB4MzgNCmM0IDAgKHN3YXBwZXIvNCkgWzxmZmZmZmY5MDA4MzFiOTc4Pl0ga2FzYW5f
c2xhYl9mcmVlKzB4ODgvMHgxYTANCmM0IDAgKHN3YXBwZXIvNCkgWzxmZmZmZmY5MDA4MzE3YmZj
Pl0ga21lbV9jYWNoZV9mcmVlKzB4YWMvMHgzZjgNCmM0IDAgKHN3YXBwZXIvNCkgWzxmZmZmZmY5
MDA4MGI3NmYwPl0gX19wdXRfdGFza19zdHJ1Y3QrMHhhOC8weDFmMA0KYzQgMCAoc3dhcHBlci80
KSBbPGZmZmZmZjkwMDgxMTE2YzQ+XSBmaW5pc2hfdGFza19zd2l0Y2grMHgyMWMvMHgyYTANCmM0
IDAgKHN3YXBwZXIvNCkgWzxmZmZmZmY5MDA5MmRjNTBjPl0gX19zY2hlZHVsZSsweDRjYy8weGU4
MA0KYzQgMCAoc3dhcHBlci80KSBbPGZmZmZmZjkwMDkyZGQxOTg+XSBzY2hlZHVsZSsweDcwLzB4
MTEwDQpjNCAwIChzd2FwcGVyLzQpIFs8ZmZmZmZmOTAwOTJkZDU1ND5dIHNjaGVkdWxlX3ByZWVt
cHRfZGlzYWJsZWQrMHgyNC8weDcwDQpjNCAwIChzd2FwcGVyLzQpIFs8ZmZmZmZmOTAwODE1MWRj
MD5dIGNwdV9zdGFydHVwX2VudHJ5KzB4MTk4LzB4NTM4DQpjNCAwIChzd2FwcGVyLzQpIFs8ZmZm
ZmZmOTAwODA5OWYzOD5dIHNlY29uZGFyeV9zdGFydF9rZXJuZWwrMHgyNTgvMHgyZjANCmM0IDAg
KHN3YXBwZXIvNCkgWzwwMDAwMDAwMTAzMmU2MDNjPl0gMHgxMDMyZTYwM2MNCmM0IDAgKHN3YXBw
ZXIvNCkgDQpjNCAwIChzd2FwcGVyLzQpIFRoZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhl
IHBhZ2U6DQpjNCAwIChzd2FwcGVyLzQpIHBhZ2U6ZmZmZmZmYmRjMjZjMTNjMCBjb3VudDowIG1h
cGNvdW50OjAgbWFwcGluZzogICAgICAgICAgKG51bGwpNS4wOTEyOTddIGM0IDAgKHN3YXBwZXIv
NCkgDQpjNCAwIChzd2FwcGVyLzQpIE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJl
c3M6DQpjNCAwIChzd2FwcGVyLzQpICBmZmZmZmZjMDliMDRmYTgwOiAwMCAwMCBmMiBmMiBmMiBm
MiBmMiBmMiAwMCAwMCAwMCAwMCBmMyBmMyBmMyBmMw0KYzQgMCAoc3dhcHBlci80KSAgZmZmZmZm
YzA5YjA0ZmIwMDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDANCmM0IDAgKHN3YXBwZXIvNCkgPmZmZmZmZmMwOWIwNGZiODA6IDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwDQogICAgICBzd2FwcGVyLzQpICBmZmZmZmZjMDliMDRmYzAwOiAwMCAw
MCAwMCAwMCBmMyBmMyBmMyBmMyAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMA0KYzQgMCAoc3dhcHBl
ci80KSAgZmZmZmZmYzA5YjA0ZmM4MDogMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDANCmM0IDAgKHN3YXBwZXIvNCkgPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQoNCk1heWJlIHRoaXMg
aXNzdWUgaGFzIGJlZW4gZml4ZWQgaW4gdGhlIGxhdGVzdCBrZXJuZWwsIEkgaGF2ZSBubyBpZGVh
IGFib3V0IHRoYXQuIFRob3VnaCBzb21lIGZ1bmN0aW9uIGhhcyBiZWVuIGNoYW5nZWQsIGJ1dCBJ
IGZvdW5kIHRoZSBjYWxsaW5nIGZsb3cgZG9lc24ndCBjaGFuZ2UgYSBsb3QgaW4gdGhlIGxhdGVz
dCBrZXJuZWwuIENvdWxkIHlvdSBoZWxwIG1lIHRvIGZpZ3VyZSBvdXQgd2hhdCdzIHdyb25nIHdp
dGggaXQ/DQoNClRoYW5rcywNCnpoaXpob3UNCg0KPiBUaGFua3MsDQo+IE1hcmsuDQo+IA0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogWmhpemhvdSBaaGFuZyA8emhpemhvdXpoYW5nQGFzcm1pY3Jv
LmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9rZXJuZWwvc3RhY2t0cmFjZS5jIHwgMiAr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2tlcm5lbC9zdGFja3RyYWNlLmMNCj4gPiBi
L2FyY2gvYXJtNjQva2VybmVsL3N0YWNrdHJhY2UuYyBpbmRleCA0OTg5ZjdlLi5lOTNjYTY3IDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQva2VybmVsL3N0YWNrdHJhY2UuYw0KPiA+ICsrKyBi
L2FyY2gvYXJtNjQva2VybmVsL3N0YWNrdHJhY2UuYw0KPiA+IEBAIC0xMDcsNyArMTA3LDcgQEAg
c3RydWN0IHN0YWNrX3RyYWNlX2RhdGEgew0KPiA+ICAJdW5zaWduZWQgaW50IHNraXA7DQo+ID4g
IH07DQo+ID4NCj4gPiAtc3RhdGljIGludCBzYXZlX3RyYWNlKHN0cnVjdCBzdGFja2ZyYW1lICpm
cmFtZSwgdm9pZCAqZCkNCj4gPiArc3RhdGljIGludCBfX25vX3Nhbml0aXplX2FkZHJlc3Mgc2F2
ZV90cmFjZShzdHJ1Y3Qgc3RhY2tmcmFtZSAqZnJhbWUsDQo+ID4gK3ZvaWQgKmQpDQo+ID4gIHsN
Cj4gPiAgCXN0cnVjdCBzdGFja190cmFjZV9kYXRhICpkYXRhID0gZDsNCj4gPiAgCXN0cnVjdCBz
dGFja190cmFjZSAqdHJhY2UgPSBkYXRhLT50cmFjZTsNCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4N
Cj4gPg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+ID4gbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg==
