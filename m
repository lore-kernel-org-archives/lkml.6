Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UtkRBaEVGVvAMgAAmS7hNA
	; Thu, 07 Jun 2018 11:23:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0517E608B8; Thu,  7 Jun 2018 11:23:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 41A03607E7;
	Thu,  7 Jun 2018 11:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41A03607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbeFGLXJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:23:09 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:19260 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753374AbeFGLXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:23:08 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520899200";
   d="scan'208";a="74295048"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [Xen-devel] [PATCH] xen/privcmd: fix static checker warning
Thread-Topic: [Xen-devel] [PATCH] xen/privcmd: fix static checker warning
Thread-Index: AQHT/klKRLnTAQbERkG5A0+JwhRXc6RUdnAAgAAwXkA=
Date: Thu, 7 Jun 2018 11:23:02 +0000
Message-ID: <d579dc06be7e4d08aae61050ed1cf816@AMSPEX02CL03.citrite.net>
References: <1528366873-25430-1-git-send-email-paul.durrant@citrix.com>
 <8666edd3-2d4a-82f5-8354-47ae0906681f@citrix.com>
In-Reply-To: <8666edd3-2d4a-82f5-8354-47ae0906681f@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgQ29vcGVyDQo+IFNl
bnQ6IDA3IEp1bmUgMjAxOCAxMToyOA0KPiBUbzogUGF1bCBEdXJyYW50IDxQYXVsLkR1cnJhbnRA
Y2l0cml4LmNvbT47IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZzsNCj4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29t
PjsgQm9yaXMgT3N0cm92c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IERhbiBD
YXJwZW50ZXINCj4gPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtY
ZW4tZGV2ZWxdIFtQQVRDSF0geGVuL3ByaXZjbWQ6IGZpeCBzdGF0aWMgY2hlY2tlciB3YXJuaW5n
DQo+IA0KPiBPbiAwNy8wNi8xOCAxMToyMSwgUGF1bCBEdXJyYW50IHdyb3RlOg0KPiA+IENvbW1p
dCAzYWQwODc2NTU0Y2EgKCJ4ZW4vcHJpdmNtZDogYWRkDQo+IElPQ1RMX1BSSVZDTURfTU1BUF9S
RVNPVVJDRSIpDQo+ID4gaW50cm9kdWNlZCBhIHN0YXRpYyBjaGVja2VyIHdhcm5pbmc6DQo+ID4N
Cj4gPiAgIGRyaXZlcnMveGVuL3ByaXZjbWQuYzo4MjcgcHJpdmNtZF9pb2N0bF9tbWFwX3Jlc291
cmNlKCkNCj4gPiAgIHdhcm46IHBhc3NpbmcgY2FzdGVkIHBvaW50ZXIgJ3BmbnMnIHRvICd4ZW5f
cmVtYXBfZG9tYWluX21mbl9hcnJheSgpJw0KPiA+ICAgICAgICAgNjQgdnMgMzIuDQo+ID4NCj4g
PiBjYXVzZWQgYnkgdGhpcyBjYXN0Og0KPiA+DQo+ID4gICAgODI3ICBudW0gPSB4ZW5fcmVtYXBf
ZG9tYWluX21mbl9hcnJheSh2bWEsDQo+ID4gICAgODI4ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBrZGF0YS5hZGRyICYgUEFHRV9NQVNLLA0KPiA+ICAgIDgyOSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcGZucywga2RhdGEubnVtLCAoaW50ICopcGZucywNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXl5eXl5eXl5eXl4NCj4gPg0KPiA+IFRoZSByZWFzb24gZm9yIHRoZSBjYXN0IGlzIHRoYXQg
eGVuX3JlbWFwX2RvbWFpbl9tZm5fYXJyYXkoKSByZXF1aXJlcw0KPiBhbg0KPiA+IGFycmF5IG9m
IGludHMgdG8gc3RvcmUgZXJyb3IgY29kZXMuIEl0IGlzIGFjdHVhbGx5IHNhZmUgdG8gcmUtdXNl
IHRoZQ0KPiA+IHBmbnMgYXJyYXkgZm9yIHRoaXMgcHVycG9zZSBidXQgaXQgZG9lcyBsb29rIG9k
ZCAoYXMgd2VsbCBhcyBsZWFkaW5nIHRvDQo+ID4gdGhlIHdhcm5pbmcpLiBJdCB3b3VsZCBhbHNv
IGJlIGVhc3kgZm9yIGEgZnV0dXJlIGltcGxlbWVudGF0aW9uIGNoYW5nZQ0KPiA+IHRvIG1ha2Ug
dGhpcyByZS11c2UgdW5zYWZlIHNvIHRoaXMgcGF0Y2ggbW9kaWZpZXMgcHJpdmNtZCB0byB1c2Ug
YQ0KPiA+IHNlcGFyYXRlbHkgYWxsb2NhdGVkIGFycmF5IGZvciBlcnJvciBjb2Rlcy4NCj4gPg0K
PiA+IFJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+
DQo+ID4gU2lnbmVkLW9mZi1ieTogUGF1bCBEdXJyYW50IDxwYXVsLmR1cnJhbnRAY2l0cml4LmNv
bT4NCj4gDQo+IEl0IG1heSBiZSBzYWZlIHRvIHJldXNlIHBmbnNbXSBhcyB0aGUgc3RvcmFnZSBz
cGFjZSBmb3IgdGhlIGVycnMgYXJyYXksDQo+IGJ1dCBjb2RlIGlzIGluY29ycmVjdCB3aGVuIHNp
emVvZihwZm4pICE9IHNpemVvZihpbnQpLsKgIEluIHN1Y2ggYSBjYXNlLA0KPiB5b3Ugc2tpcCBv
dmVyIGV2ZXJ5IG90aGVyIGVyciwgYW5kIHNlY29uZCBoYWxmIG9mIHBmbnNbXSBpcyBqdW5rIGZy
b20NCj4gdGhlIHBvaW50IG9mIHZpZXcgb2YgdGhlIGVycnMgbG9vcC4NCj4gDQoNClllcCwgdGhh
dCBpcyBpbmRlZWQgd2hhdCBoYXBwZW5zIHdpdGhvdXQgdGhpcyBwYXRjaC4NCg0KICBQYXVsDQoN
Cj4gfkFuZHJldw0KPiANCj4gPiAtLS0NCj4gPiBDYzogQm9yaXMgT3N0cm92c2t5IDxib3Jpcy5v
c3Ryb3Zza3lAb3JhY2xlLmNvbT4NCj4gPiBDYzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2Uu
Y29tPg0KPiA+IENjOiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQG9yYWNsZS5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMveGVuL3ByaXZjbWQuYyB8IDEzICsrKysrKysrKysrLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vcHJpdmNtZC5jIGIvZHJpdmVycy94ZW4vcHJp
dmNtZC5jDQo+ID4gaW5kZXggOGFlMDM0OS4uODUwN2MxMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3hlbi9wcml2Y21kLmMNCj4gPiArKysgYi9kcml2ZXJzL3hlbi9wcml2Y21kLmMNCj4gPiBA
QCAtODIyLDExICs4MjIsMTggQEAgc3RhdGljIGxvbmcgcHJpdmNtZF9pb2N0bF9tbWFwX3Jlc291
cmNlKHN0cnVjdA0KPiBmaWxlICpmaWxlLCB2b2lkIF9fdXNlciAqdWRhdGEpDQo+ID4gIAkJdW5z
aWduZWQgaW50IGRvbWlkID0NCj4gPiAgCQkJKHhkYXRhLmZsYWdzICYgWEVOTUVNX3JzcmNfYWNx
X2NhbGxlcl9vd25lZCkgPw0KPiA+ICAJCQlET01JRF9TRUxGIDoga2RhdGEuZG9tOw0KPiA+ICsJ
CWludCAqZXJyczsNCj4gPiAgCQlpbnQgbnVtOw0KPiA+DQo+ID4gKwkJZXJycyA9IGtjYWxsb2Mo
a2RhdGEubnVtLCBzaXplb2YoKmVycnMpLCBHRlBfS0VSTkVMKTsNCj4gPiArCQlpZiAoIWVycnMp
IHsNCj4gPiArCQkJcmMgPSAtRU5PTUVNOw0KPiA+ICsJCQlnb3RvIG91dDsNCj4gPiArCQl9DQo+
ID4gKw0KPiA+ICAJCW51bSA9IHhlbl9yZW1hcF9kb21haW5fbWZuX2FycmF5KHZtYSwNCj4gPiAg
CQkJCQkJIGtkYXRhLmFkZHIgJiBQQUdFX01BU0ssDQo+ID4gLQkJCQkJCSBwZm5zLCBrZGF0YS5u
dW0sIChpbnQgKilwZm5zLA0KPiA+ICsJCQkJCQkgcGZucywga2RhdGEubnVtLCBlcnJzLA0KPiA+
ICAJCQkJCQkgdm1hLT52bV9wYWdlX3Byb3QsDQo+ID4gIAkJCQkJCSBkb21pZCwNCj4gPiAgCQkJ
CQkJIHZtYS0+dm1fcHJpdmF0ZV9kYXRhKTsNCj4gPiBAQCAtODM2LDEyICs4NDMsMTQgQEAgc3Rh
dGljIGxvbmcgcHJpdmNtZF9pb2N0bF9tbWFwX3Jlc291cmNlKHN0cnVjdA0KPiBmaWxlICpmaWxl
LCB2b2lkIF9fdXNlciAqdWRhdGEpDQo+ID4gIAkJCXVuc2lnbmVkIGludCBpOw0KPiA+DQo+ID4g
IAkJCWZvciAoaSA9IDA7IGkgPCBudW07IGkrKykgew0KPiA+IC0JCQkJcmMgPSBwZm5zW2ldOw0K
PiA+ICsJCQkJcmMgPSBlcnJzW2ldOw0KPiA+ICAJCQkJaWYgKHJjIDwgMCkNCj4gPiAgCQkJCQli
cmVhazsNCj4gPiAgCQkJfQ0KPiA+ICAJCX0gZWxzZQ0KPiA+ICAJCQlyYyA9IDA7DQo+ID4gKw0K
PiA+ICsJCWtmcmVlKGVycnMpOw0KPiA+ICAJfQ0KPiA+DQo+ID4gIG91dDoNCg0K
