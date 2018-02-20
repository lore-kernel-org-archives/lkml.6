Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2649694-1519124058-2-8981787393293727202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519124058; b=ZSO7vG5jF9CAXTrRZk4GB/VZYYyO5OjqKkYSlPjeBZAHbx9
    Z5LgkVqHzgrexez9TE/gTrQeJAsPZXdhQiKlsi9bvo7VSS4Ub/DXKDwQhQ/x4upA
    +k+7cLv4ft1hPHlZZ7NFqUiqB5SjePneWVEE0+TUdGM7kd7O604p0HLk6ICjBsBo
    sh9okmR2HVU5hoWYN6c7QfVc9MziJXKNZ9Sb+kJYRav1FuiQuzzsT4EEoIvkSUJh
    px+8+4lY/Z9xB0RXj0uzA+sS7WUAeX+hkdxdEtFw02g8vxvvhyI1GIlrJzx32w7B
    v7vp/c5mifkD/YtmivMHMO2WWlcImIzKV529wNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1519124058; bh=IAMt7lf+BNkZa+eJN37b29KyfKT9g5+iX1dtO4
    75Yq0=; b=V5d3IWEnBUZ7okQBHK+zw78HAYM5NyZUtZUaIkpC4J/Btr/i09p6/p
    yQG4AQ6tT46Tzj1Ob4SQA2yQ2uNya9Qq8cMwY2tE5By5TqvS3IepPLaMyzzy8i0u
    cJx4jq77GOXVTOOpMJypj17O5LR2+q9sjKCyKbs7Jo3ui/0gNzXE2lxk/HOR07oG
    CoNKaqPFpqGKFSkyiO7dGLS34P/GO0B3TEa7BeS1Fy2AfYtoZrz5hPjExW8jvDCI
    OpnWJGgO+TNb8Q3fDfHja58kwaN/lkIuoO+M+jHtRlyum/mI2m8KbYyxkGJVp0M9
    YEix/YLE/f1QpD2Hc3te0wraAJ0vqajw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeBTKxx (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 05:53:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41868 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751520AbeBTKxv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 05:53:51 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Roger Quadros <rogerq@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Topic: [PATCH] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Index: AQHTqirVm0SQYOzqsE6bymYd0rXch6Os9NIAgAAYD4A=
Date: Tue, 20 Feb 2018 10:53:07 +0000
Message-ID: <82affeaf-c42b-9e85-1b84-a2b25eb83bd0@st.com>
References: <1519117905-12095-1-git-send-email-amelie.delaunay@st.com>
 <9f1f49a0-4afd-a7f1-53bd-18f72abd4753@ti.com>
In-Reply-To: <9f1f49a0-4afd-a7f1-53bd-18f72abd4753@ti.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <53A5B156E6D32E42ADE4CC7F042814EF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_03:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGksDQoNCk9uIDAyLzIwLzIwMTggMTA6MjcgQU0sIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEhp
LA0KPiANCj4gT24gMjAvMDIvMTggMTE6MTEsIEFtZWxpZSBEZWxhdW5heSB3cm90ZToNCj4+IE9u
IHNvbWUgYm9hcmRzLCBlc3BlY2lhbGx5IHdoZW4gdmJ1cyBzdXBwbHkgcmVxdWlyZXMgbGFyZ2Ug
Y3VycmVudCwNCj4+IGFuZCB0aGUgY2hhcmdlIHB1bXAgb24gdGhlIFBIWSBpc24ndCBlbm91Z2gs
IGFuIGV4dGVybmFsIHZidXMgcG93ZXIgc3dpdGNoDQo+PiBtYXkgYmUgdXNlZC4NCj4+IEFkZCBz
dXBwb3J0IGZvciB0aGlzIG9wdGlvbmFsIGV4dGVybmFsIHZidXMgc3VwcGx5IGluIGVoY2ktcGxh
dGZvcm0uDQo+IA0KPiBJc24ndCB0aGlzIGdlbmVyaWMgZW5vdWdoIHRvIGJlIGRvbmUgZm9yIGFs
bCAqaGNpLXBsYXRmb3JtIGRyaXZlcnM/DQo+IA0KDQpJIGNhbiBvbmx5IHRlc3QgZWhjaS1wbGF0
Zm9ybSBvbiBteSBzZXR1cC4NCg0KPiBBbmQgaWYgdGhpcyBpcyBhIFZCVVMgc3VwcGx5IHRvIHRo
ZSBwb3J0LCB0aGUgcm9vdCBodWIgZHJpdmVyIHNob3VsZCBiZSBjb250cm9sbGluZyBpdA0KPiBi
YXNlZCBvbiBwb3J0IHBvd2VyIG9uL29mZiBjb21tYW5kcyB0byB0aGUgcG9ydCByaWdodD8NCj4g
DQoNCllvdSdyZSByaWdodC4NClRoaXMgbWVhbnMgdG8gb3ZlcmxvYWQgcGxhdGZvcm1fb3ZlcnJp
ZGVzIHdpdGgNCi5wb3J0X3Bvd2VyID0gZWhjaV9wbGF0Zm9ybV9wb3J0X3Bvd2VyLA0KDQphbmQg
bWFuYWdlIHZidXNfc3VwcGx5IGVuYWJsZS9kaXNhYmxlIGluIHRoaXMgZnVuY3Rpb24gaW5zdGVh
ZCBvZiANCmVoY2lfcGxhdGZvcm1fcG93ZXJfb24vb2ZmLg0KDQo+Pg0KPj4gU2lnbmVkLW9mZi1i
eTogQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlAc3QuY29tPg0KPj4gLS0tDQo+PiAg
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWVoY2kudHh0IHwgIDEg
Kw0KPj4gICBkcml2ZXJzL3VzYi9ob3N0L2VoY2ktcGxhdGZvcm0uYyAgICAgICAgICAgICAgICAg
ICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBp
bnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvdXNiLWVoY2kudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi91c2ItZWhjaS50eHQNCj4+IGluZGV4IDNlZmRlMTIuLmZjNDgwY2QgMTAwNjQ0
DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1laGNp
LnR4dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2It
ZWhjaS50eHQNCj4+IEBAIC0xOSw2ICsxOSw3IEBAIE9wdGlvbmFsIHByb3BlcnRpZXM6DQo+PiAg
ICAtIHBoeXMgOiBwaGFuZGxlICsgcGh5IHNwZWNpZmllciBwYWlyDQo+PiAgICAtIHBoeS1uYW1l
cyA6ICJ1c2IiDQo+PiAgICAtIHJlc2V0cyA6IHBoYW5kbGUgKyByZXNldCBzcGVjaWZpZXIgcGFp
cg0KPj4gKyAtIHZidXMtc3VwcGx5IDogcGhhbmRsZSBvZiByZWd1bGF0b3Igc3VwcGx5aW5nIHZi
dXMNCj4+ICAgDQo+PiAgIEV4YW1wbGUgKFNlcXVvaWEgNDQwRVB4KToNCj4+ICAgICAgIGVoY2lA
ZTAwMDAzMDAgew0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1wbGF0Zm9y
bS5jIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLXBsYXRmb3JtLmMNCj4+IGluZGV4IGIwNjVhOTYu
Ljc2Y2M3ODEgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktcGxhdGZvcm0u
Yw0KPj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLXBsYXRmb3JtLmMNCj4+IEBAIC0yOSw2
ICsyOSw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPj4gICAjaW5jbHVkZSA8bGlu
dXgvcGh5L3BoeS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
PiArI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KPj4gICAjaW5jbHVkZSA8
bGludXgvcmVzZXQuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3VzYi5oPg0KPj4gICAjaW5jbHVk
ZSA8bGludXgvdXNiL2hjZC5oPg0KPj4gQEAgLTQ2LDYgKzQ3LDcgQEAgc3RydWN0IGVoY2lfcGxh
dGZvcm1fcHJpdiB7DQo+PiAgIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0czsNCj4+ICAgCXN0
cnVjdCBwaHkgKipwaHlzOw0KPj4gICAJaW50IG51bV9waHlzOw0KPj4gKwlzdHJ1Y3QgcmVndWxh
dG9yICp2YnVzX3N1cHBseTsNCj4+ICAgCWJvb2wgcmVzZXRfb25fcmVzdW1lOw0KPj4gICB9Ow0K
Pj4gICANCj4+IEBAIC05OSw2ICsxMDEsMTUgQEAgc3RhdGljIGludCBlaGNpX3BsYXRmb3JtX3Bv
d2VyX29uKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldikNCj4+ICAgCQl9DQo+PiAgIAl9DQo+
PiAgIA0KPj4gKwlpZiAocHJpdi0+dmJ1c19zdXBwbHkpIHsNCj4+ICsJCXJldCA9IHJlZ3VsYXRv
cl9lbmFibGUocHJpdi0+dmJ1c19zdXBwbHkpOw0KPj4gKwkJaWYgKHJldCkgew0KPj4gKwkJCWRl
dl9lcnIoJmRldi0+ZGV2LA0KPj4gKwkJCQkiZmFpbGVkIHRvIGVuYWJsZSB2YnVzIHN1cHBseTog
JWRcbiIsIHJldCk7DQo+PiArCQkJZ290byBlcnJfZXhpdF9waHk7DQo+PiArCQl9DQo+PiArCX0N
Cj4+ICsNCj4+ICAgCXJldHVybiAwOw0KPj4gICANCj4+ICAgZXJyX2V4aXRfcGh5Og0KPj4gQEAg
LTExOSw2ICsxMzAsOSBAQCBzdGF0aWMgdm9pZCBlaGNpX3BsYXRmb3JtX3Bvd2VyX29mZihzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+PiAgIAlzdHJ1Y3QgZWhjaV9wbGF0Zm9ybV9wcml2
ICpwcml2ID0gaGNkX3RvX2VoY2lfcHJpdihoY2QpOw0KPj4gICAJaW50IGNsaywgcGh5X251bTsN
Cj4+ICAgDQo+PiArCWlmIChwcml2LT52YnVzX3N1cHBseSkNCj4+ICsJCXJlZ3VsYXRvcl9kaXNh
YmxlKHByaXYtPnZidXNfc3VwcGx5KTsNCj4+ICsNCj4gDQo+IElmIHdlIGRpc2FibGUgdGhlIFZC
VVMgaGVyZSwgd2hpY2ggaXMgYmVpbmcgY2FsbGVkIGR1cmluZyBlaGNpX3BsYXRmb3JtX3N1c3Bl
bmQoKSwNCj4gaG93IGNhbiB3ZSBleHBlY3QgcmVtb3RlIHdha2V1cCB0byB3b3JrPw0KPiBUaGlz
IGlzIHVuY29uZGl0aW9uYWxseSBwb3dlcmluZyBkb3duIHRoZSBwb3J0Lg0KPiANCg0KU3VyZS4g
V2l0aCAucG9ydF9wb3dlciwgaXQgd2lsbCBiZSBPSy4NCg0KVGhhbmtzIGZvciByZXZpZXcsDQpB
bWVsaWUNCg0KPj4gICAJZm9yIChwaHlfbnVtID0gMDsgcGh5X251bSA8IHByaXYtPm51bV9waHlz
OyBwaHlfbnVtKyspIHsNCj4+ICAgCQlwaHlfcG93ZXJfb2ZmKHByaXYtPnBoeXNbcGh5X251bV0p
Ow0KPj4gICAJCXBoeV9leGl0KHByaXYtPnBoeXNbcGh5X251bV0pOw0KPj4gQEAgLTI0Nyw2ICsy
NjEsMTUgQEAgc3RhdGljIGludCBlaGNpX3BsYXRmb3JtX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKmRldikNCj4+ICAgCWlmIChlcnIpDQo+PiAgIAkJZ290byBlcnJfcHV0X2Nsa3M7DQo+
PiAgIA0KPj4gKwlwcml2LT52YnVzX3N1cHBseSA9IGRldm1fcmVndWxhdG9yX2dldF9vcHRpb25h
bCgmZGV2LT5kZXYsICJ2YnVzIik7DQo+PiArCWlmIChJU19FUlIocHJpdi0+dmJ1c19zdXBwbHkp
KSB7DQo+PiArCQllcnIgPSBQVFJfRVJSKHByaXYtPnZidXNfc3VwcGx5KTsNCj4+ICsJCWlmIChl
cnIgPT0gLUVOT0RFVikNCj4+ICsJCQlwcml2LT52YnVzX3N1cHBseSA9IE5VTEw7DQo+PiArCQll
bHNlDQo+PiArCQkJZ290byBlcnJfcmVzZXQ7DQo+PiArCX0NCj4+ICsNCj4+ICAgCWlmIChwZGF0
YS0+YmlnX2VuZGlhbl9kZXNjKQ0KPj4gICAJCWVoY2ktPmJpZ19lbmRpYW5fZGVzYyA9IDE7DQo+
PiAgIAlpZiAocGRhdGEtPmJpZ19lbmRpYW5fbW1pbykNCj4+DQo+IA==
