Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66495C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6FE2408B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 06:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D6FE2408B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeGFG0K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 02:26:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:32885 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754035AbeGFG0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 02:26:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2018 23:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,314,1526367600"; 
   d="scan'208";a="64633837"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2018 23:26:08 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 5 Jul 2018 23:26:08 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 5 Jul 2018 23:25:19 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.17]) with mapi id 14.03.0319.002;
 Fri, 6 Jul 2018 14:25:17 +0800
From:   "Tian, Baofeng" <baofeng.tian@intel.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] watchdog: add module parameter "force_no_reboot" for
 iTCO
Thread-Topic: [PATCH] watchdog: add module parameter "force_no_reboot" for
 iTCO
Thread-Index: AdQRzERd39h1dwuYSseIPoq6rlU1ggACTz7Q///d1oD/+zcZQIAJe3oA//5Zl8A=
Date:   Fri, 6 Jul 2018 06:25:17 +0000
Message-ID: <EEBA739CCF11FE49B73E1FB4690F5EE649E2A1C0@SHSMSX101.ccr.corp.intel.com>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
 <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E29D27@SHSMSX101.ccr.corp.intel.com>
 <b83a8cd9-b81e-cce3-1b34-f88d38fe414e@roeck-us.net>
In-Reply-To: <b83a8cd9-b81e-cce3-1b34-f88d38fe414e@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2IwODk3MmYtNDQ2YS00OTUxLWE4NzItZjMwYTUzMTdiMzQ5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiY0FVQkNUVnB6M1Z5SzlDYlduM3FwN09TM2xvZWRtQW0zVW9uU3BqWWNzXC9LNFVpK080QjB3b0hEYmhFa1Y4bEoifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvZWNrDQoNClRoaXMgaXMgYW4gaW50ZXJmYWNlIGZyb20gYW5kcm9pZCwgd2l0aCB0aGlz
IGludGVyZmFjZSwgYW5kcm9pZCBjYW4gYXZvaWQgcmVib290IGlmIHVzZXIgd2FudCB0byBtYWtl
IGl0Lg0KdGhlIHdhdGNoZG9nIHVzZSBzcGFjZSBkYWVtb24geW91IG1lbnRpb25lZCBpcyBhbHdh
eXMgdGhlcmUgaW4gYW5kcm9pZCwgYW5kIGlmIHJlbW92ZS9kaXNhYmxlIHRoaXMgZGFlbW9uIHN5
c3RlbSB3aWxsIHJlYm9vdC4NCg0KS2VlcCB0aGlzIHNpbXBsZSBpbnRlcmZhY2UgY2FuIG1ha2Ug
ImRpc2FibGUgcmVib290IiBlYXNpbHkuDQoNClRoYW5rcw0KVGltDQoNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEd1ZW50ZXIgUm9lY2sgW21haWx0bzpncm9lY2s3QGdtYWls
LmNvbV0gT24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNClNlbnQ6IFRodXJzZGF5LCBKdWx5IDUs
IDIwMTggOTowNSBQTQ0KVG86IFRpYW4sIEJhb2ZlbmcgPGJhb2ZlbmcudGlhbkBpbnRlbC5jb20+
OyB3aW1AbGludXgtd2F0Y2hkb2cub3JnOyBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdhdGNo
ZG9nOiBhZGQgbW9kdWxlIHBhcmFtZXRlciAiZm9yY2Vfbm9fcmVib290IiBmb3IgaVRDTw0KDQpP
biAwNy8wNC8yMDE4IDExOjI4IFBNLCBUaWFuLCBCYW9mZW5nIHdyb3RlOg0KPiBIaSwgUm9lY2sN
Cj4gDQo+IFllcywgdGhpcyBwYXRjaCBpcyBmb3IgYWRkIGEgcGFyYW1ldGVyIHRvIFRDTyB0byBw
cmV2ZW50IHJlYm9vdCBoYXBwZW4gDQo+IGlmIHlvdSBkb24ndCB3YW50IHRvIHJlYm9vdCBzeXN0
ZW0gYW5kIHdhbnQgdG8gc3RheSBoZXJlIHRvIGNoZWNrIHNvbWUgSFcgc3RhdHVzLCBsb2dzLCBl
dGMgZm9yIGRlYnVnIHB1cnBvc2UuDQo+IA0KPiBVbmRlciBzb21lIGFuZHJvaWQgcmVsYXRlZCBz
dGFiaWxpdHkgdGVzdCwgZGV2ZWxvcGVyIHdhbnQgdG8gc3RheSBhdCANCj4gdGhlIGNyYXNoIGFu
ZCB1c2UgZGVidWcgdG9vbHMoTFRCKSB0byBjaGVjayBtb3JlIGluZm9ybWF0aW9uLCB0aGlzIGlz
IHRoZSBwdXJwb3NlIG9mIHRoaXMgcGF0Y2guDQo+IA0KVGhlIHdhdGNoZG9nIGRvZXNuJ3QgZXZl
biBzdGFydCB3aXRoIHRoZSBtb2R1bGUgcGFyYW1ldGVyIHNldC4NCklmIHRoZSBwdXJwb3NlIGlz
IHRvIGRpc2FibGUgdGhlIHdhdGNoZG9nLCBqdXN0IHN0b3AgaXQgYnkgY2xvc2luZyB0aGUgd2F0
Y2hkb2cgZGFlbW9uLCBvciBkb24ndCBydW4gdGhlIHdhdGNoZG9nIGRhZW1vbiBpbiB0aGUgZmly
c3QgcGxhY2UsIG9yIGJsYWNrbGlzdCB0aGUgbW9kdWxlLg0KDQpHdWVudGVyDQoNCj4gVGhhbmtz
DQo+IFRpbQ0KPiANCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRl
ciBSb2VjayBbbWFpbHRvOmdyb2VjazdAZ21haWwuY29tXSBPbiBCZWhhbGYgT2YgR3VlbnRlciAN
Cj4gUm9lY2sNCj4gU2VudDogTW9uZGF5LCBKdWx5IDIsIDIwMTggOToyMSBQTQ0KPiBUbzogVGlh
biwgQmFvZmVuZyA8YmFvZmVuZy50aWFuQGludGVsLmNvbT47IHdpbUBsaW51eC13YXRjaGRvZy5v
cmc7IA0KPiBsaW51eC13YXRjaGRvZ0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gd2F0Y2hkb2c6IGFkZCBtb2R1bGUg
cGFyYW1ldGVyICJmb3JjZV9ub19yZWJvb3QiIA0KPiBmb3IgaVRDTw0KPiANCj4gT24gMDcvMDIv
MjAxOCAxMjozMCBBTSwgVGlhbiwgQmFvZmVuZyB3cm90ZToNCj4+IEZyb206ICJUaWFuLCBCYW9m
ZW5nIiA8YmFvZmVuZy50aWFuQGludGVsLmNvbSANCj4+IDxtYWlsdG86YmFvZmVuZy50aWFuQGlu
dGVsLmNvbT4+DQo+PiBTdWJqZWN0OiBbUEFUQ0hdIHdhdGNoZG9nOiBhZGQgbW9kdWxlIHBhcmFt
ZXRlciAiZm9yY2Vfbm9fcmVib290IiBmb3IgDQo+PiBpVENPDQo+Pg0KPj4gU2V0dGluZyAiZm9y
Y2Vfbm9fcmVib290IiBwYXJhbWV0ZXIgdG8gdHJ1ZSAoeS9ZLzEpIHdpbGwgaGF2ZSB0aGUgDQo+
PiBlZmZlY3QgdG8gcHJldmVudCB0byByZXNldCB0aGUgTk9fUkVCT09UIGZsYWcgdGh1cyBwcmV2
ZW50aW5nIHRoZSANCj4+IGlUQ08gdG8gcmVib290IHRoZSBwbGF0Zm9ybSwgaWYgbm90IHNldCBv
ciBzZXQgdG8gZmFsc2UsIHRoZW4gc3lzdGVtIA0KPj4gd2lsbCByZWJvb3QgYWZ0ZXIgYWJvdXQg
MzBzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFRpYW4sIEJhb2ZlbmcgPGJhb2ZlbmcudGlhbkBp
bnRlbC5jb20gDQo+PiA8bWFpbHRvOmJhb2ZlbmcudGlhbkBpbnRlbC5jb20+Pg0KPiANCj4gWW91
ciBlLW1haWwgYWRkcmVzcyBpcyBtZXNzZWQgdXAuDQo+IA0KPj4gLS0tDQo+PiAgIMKgZHJpdmVy
cy93YXRjaGRvZy9pVENPX3dkdC5jIHwgMTEgKysrKysrKysrKy0NCj4+ICAgwqAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3dhdGNoZG9nL2lUQ09fd2R0LmMgDQo+PiBiL2RyaXZlcnMvd2F0Y2hkb2cvaVRD
T193ZHQuYyBpbmRleCAzNDdmMDM4Li4yNTUzMThiIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy93
YXRjaGRvZy9pVENPX3dkdC5jDQo+PiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL2lUQ09fd2R0LmMN
Cj4+IEBAIC0xMzEsNiArMTMxLDExIEBAIG1vZHVsZV9wYXJhbSh0dXJuX1NNSV93YXRjaGRvZ19j
bGVhcl9vZmYsIGludCwgDQo+PiAwKTsNCj4+ICAgwqBNT0RVTEVfUEFSTV9ERVNDKHR1cm5fU01J
X3dhdGNoZG9nX2NsZWFyX29mZiwNCj4+ICAgwqDCoMKgwqDCoCAiVHVybiBvZmYgU01JIGNsZWFy
aW5nIHdhdGNoZG9nIChkZXBlbmRzIG9uIA0KPj4gVENPLXZlcnNpb24pKGRlZmF1bHQ9MSkiKTsN
Cj4+DQo+PiArc3RhdGljIGJvb2wgZm9yY2Vfbm9fcmVib290Ow0KPj4gK21vZHVsZV9wYXJhbShm
b3JjZV9ub19yZWJvb3QsIGJvb2wsIDApOyANCj4+ICtNT0RVTEVfUEFSTV9ERVNDKGZvcmNlX25v
X3JlYm9vdCwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAiUHJldmVudHMgdGhlIHdhdGNoZG9n
IHJlYm9vdGluZyB0aGUgcGxhdGZvcm0gDQo+PiArKGRlZmF1bHQ9MCkiKTsNCj4+ICsNCj4+ICAg
wqAvKg0KPj4gICDCoCAqIFNvbWUgVENPIHNwZWNpZmljIGZ1bmN0aW9ucw0KPj4gICDCoCAqLw0K
Pj4gQEAgLTI0Myw2ICsyNDgsMTAgQEAgc3RhdGljIGludCBpVENPX3dkdF9zdGFydChzdHJ1Y3Qg
d2F0Y2hkb2dfZGV2aWNlDQo+PiAqd2RfZGV2KQ0KPj4gICDCoMKgwqDCoMKgIHN0cnVjdCBpVENP
X3dkdF9wcml2YXRlICpwID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEod2RfZGV2KTsNCj4+ICAgwqDC
oMKgwqDCoCB1bnNpZ25lZCBpbnQgdmFsOw0KPj4NCj4+ICvCoMKgwqDCoCAvKiBmb3JjZV9ub19y
ZWJvb3Qgd2lsbCBwcmV2ZW50IHRvIHVuc2V0IE5PX1JFQk9PVCBiaXQgKi8NCj4+ICvCoMKgwqDC
oCBpZiAoZm9yY2Vfbm9fcmVib290KQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RUlPOw0KPj4gKw0KPiBJdCBzZWVtcyB0byBtZSB0aGF0IHRoaXMgZmxhZyBwcmV2ZW50cyB0aGUg
d2F0Y2hkb2cgZnJvbSBiZWluZyBzdGFydGVkLCBhbmQgb24gdG9wIGl0IHdvdWxkIHJldHVybiBh
biB1bnJlYXNvbmFibGUgZXJyb3IgKC1FSU8pLg0KPiANCj4gSSBkb24ndCBzZWUgdGhlIHBvaW50
IG9mIHRoaXMgcGF0Y2gsIHNvcnJ5Lg0KPiANCj4gR3VlbnRlcg0KPiANCj4+ICAgwqDCoMKgwqDC
oCBzcGluX2xvY2soJnAtPmlvX2xvY2spOw0KPj4NCj4+ICAgwqDCoMKgwqDCoCBpVENPX3ZlbmRv
cl9wcmVfc3RhcnQocC0+c21pX3Jlcywgd2RfZGV2LT50aW1lb3V0KTsgQEAgLTI1MCw3DQo+PiAr
MjU5LDcgQEAgc3RhdGljIGludCBpVENPX3dkdF9zdGFydChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNl
ICp3ZF9kZXYpDQo+PiAgIMKgwqDCoMKgwqAgLyogZGlzYWJsZSBjaGlwc2V0J3MgTk9fUkVCT09U
IGJpdCAqLw0KPj4gICDCoMKgwqDCoMKgIGlmIChwLT51cGRhdGVfbm9fcmVib290X2JpdChwLT5u
b19yZWJvb3RfcHJpdiwgZmFsc2UpKSB7DQo+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bp
bl91bmxvY2soJnAtPmlvX2xvY2spOw0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgIHByX2Vycigi
ZmFpbGVkIHRvIHJlc2V0IE5PX1JFQk9PVCBmbGFnLCByZWJvb3QgZGlzYWJsZWQgDQo+PiBieSBo
YXJkd2FyZS9CSU9TXG4iKTsNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcl9lcnIoImZhaWxl
ZCB0byByZXNldCBOT19SRUJPT1QgZmxhZywgcmVib290IGRpc2FibGVkIA0KPj4gK2J5IGhhcmR3
YXJlL0JJT1MvcmNfY21kXG4iKTsNCj4+ICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4g
LUVJTzsNCj4+ICAgwqDCoMKgwqDCoCB9DQo+Pg0KPj4gLS0NCj4+IDIuNy40DQo+Pg0KPiANCj4g
LS0NCj4gVG8gdW5zdWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vi
c2NyaWJlIA0KPiBsaW51eC13YXRjaGRvZyIgaW4gdGhlIGJvZHkgb2YgYSBtZXNzYWdlIHRvIG1h
am9yZG9tb0B2Z2VyLmtlcm5lbC5vcmcgDQo+IE1vcmUgbWFqb3Jkb21vIGluZm8gYXQgIGh0dHA6
Ly92Z2VyLmtlcm5lbC5vcmcvbWFqb3Jkb21vLWluZm8uaHRtbA0KPiANCg0K
