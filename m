Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3031579-1519138023-2-3150751649154034669
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519138022; b=DlRJzhFx7rSgewirxDBoppqeTDfGgytflhcpjsofBpv28fe
    RBmpTgkIIKUQ6cfitpIoLzwEp97wmSfEAPCvH7ZIrZW9HGcBTclXIXs4tU9gNT0q
    pi33riCg0ZBDhSThLXvaC0X0+WIeqarcwvB36XfTDcrbyiaiA08hPD345RMWcxrn
    nF8ThvaqmXjtuCDjthe8LJz7wB3wg4i/+4tgOERzjSNot09jVtFNJFQlc4A/Ae5p
    IX+PKLrnfdOYfQziv9gjYy3Nu/BxOgqhTtzn+lKGpzewJJUs3mOOs85Qv0SY3ATH
    dGcpXGBFGdr5ARB/px3UaiPw+IiqcfL2UMpQQww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1519138022; bh=84nBeCYYj8W1DTxSjhQbxSA8fR3yXYn5wk53s4
    tRt6o=; b=DnHVH6A8ICk/jzniR7FWkykYKdzAumjVM2j1oQycb/T2xmuFqRHj4o
    KWwFnqxKS47ZQqhyvOAsHxJx/NHJ1QN/GhaXb788LdEkNvThEcvTdlRsRrRC7oDS
    kBDI11yIAl51Te7rgEAJlTNCS5aXwdHPGsBtd9UYwnL1FCvMa2qRO99QFD28umUn
    vtFeKecxz9rsWo+JalhdMkOTUmv4bj9Qb38eVWz0LS30KpNZpaNCBskAdR2bGAK7
    AyjVrul6UJKPtGdwDhhJsYnvlHY/y54MngWQVfyxrAiyjx6uW8IPxqw6bF5Xk2T/
    pMArtgtmg8hcIQhpUbSRE7CmdeKPs7BA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeBTOqn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 09:46:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:49546 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751038AbeBTOqm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 09:46:42 -0500
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
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Topic: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Index: AQHTqkp3rnXPTZ4feU61xpBLtCmRWqOtQQQAgAAMt4A=
Date: Tue, 20 Feb 2018 14:46:07 +0000
Message-ID: <2ef38200-947c-1419-1c91-f033da390f74@st.com>
References: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
 <bfaa3001-d90f-7903-17e8-90af9a03c338@ti.com>
In-Reply-To: <bfaa3001-d90f-7903-17e8-90af9a03c338@ti.com>
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
Content-ID: <2753CB0B96FF3C4584ACEF41C723FBDA@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGksDQoNCk9uIDAyLzIwLzIwMTggMDM6MDAgUE0sIFJvZ2VyIFF1YWRyb3Mgd3JvdGU6DQo+IEhp
LA0KPiANCj4gT24gMjAvMDIvMTggMTQ6NTgsIEFtZWxpZSBEZWxhdW5heSB3cm90ZToNCj4+IE9u
IHNvbWUgYm9hcmRzLCBlc3BlY2lhbGx5IHdoZW4gdmJ1cyBzdXBwbHkgcmVxdWlyZXMgbGFyZ2Ug
Y3VycmVudCwNCj4+IGFuZCB0aGUgY2hhcmdlIHB1bXAgb24gdGhlIFBIWSBpc24ndCBlbm91Z2gs
IGFuIGV4dGVybmFsIHZidXMgcG93ZXIgc3dpdGNoDQo+PiBtYXkgYmUgdXNlZC4NCj4+IEFkZCBz
dXBwb3J0IGZvciB0aGlzIG9wdGlvbmFsIGV4dGVybmFsIHZidXMgc3VwcGx5IGluIGVoY2ktcGxh
dGZvcm0uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVs
YXVuYXlAc3QuY29tPg0KPj4NCj4+IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+ICAgKiBBZGRy
ZXNzIFJvZ2VyIFF1YWRyb3MgY29tbWVudHM6IG1vdmUgcmVndWxhdG9yX2VuYWJsZS9kaXNhYmxl
IGZyb20NCj4+IGVoY2lfcGxhdGZvcm1fcG93ZXJfb24vb2ZmIHRvIGVoY2lfcGxhdGZvcm1fcG9y
dF9wb3dlci4NCj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
dXNiL3VzYi1laGNpLnR4dCB8ICAxICsNCj4+ICAgZHJpdmVycy91c2IvaG9zdC9laGNpLXBsYXRm
b3JtLmMgICAgICAgICAgICAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1laGNpLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWVoY2kudHh0DQo+PiBpbmRleCAz
ZWZkZTEyLi5mYzQ4MGNkIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3VzYi91c2ItZWhjaS50eHQNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy91c2IvdXNiLWVoY2kudHh0DQo+PiBAQCAtMTksNiArMTksNyBAQCBPcHRp
b25hbCBwcm9wZXJ0aWVzOg0KPj4gICAgLSBwaHlzIDogcGhhbmRsZSArIHBoeSBzcGVjaWZpZXIg
cGFpcg0KPj4gICAgLSBwaHktbmFtZXMgOiAidXNiIg0KPj4gICAgLSByZXNldHMgOiBwaGFuZGxl
ICsgcmVzZXQgc3BlY2lmaWVyIHBhaXINCj4+ICsgLSB2YnVzLXN1cHBseSA6IHBoYW5kbGUgb2Yg
cmVndWxhdG9yIHN1cHBseWluZyB2YnVzDQo+PiAgIA0KPiANCj4gQ2FuIHBsYXRmb3JtcyBoYXZl
IG1vcmUgdGhhbiBvbmUgcmVndWxhdG9yIGUuZy4gb25lIHJlZ3VsYXRvciBwZXIgcG9ydD8NCj4g
DQoNCkkgaW1hZ2luZSB0aGF0IHllcywgcGxhdGZvcm1zIGNvdWxkIGhhdmUgb25lIHJlZ3VsYXRv
ciBwZXIgcG9ydC4NClJlZ3VsYXRvciBjb25zdW1lcnMgYmluZGluZ3MgaW1wb3NlIGEgPG5hbWU+
LXN1cHBseSBwcm9wZXJ0eSBwZXIgDQpyZWd1bGF0b3IsIHNvLCB3aGF0IGRvIHlvdSB0aGluayBh
Ym91dCA6DQp2YnVzMC1zdXBwbHkgZm9yIHBvcnQjMA0KdmJ1czEtc3VwcGx5IGZvciBwb3J0IzEN
Ci4uLg0KdmJ1c04tc3VwcGx5IGZvciBwb3J0I04NCg0KQW5kIHRoZW4gaW4gcHJvYmUsIGFsbG9j
YXRlICdzdHJ1Y3QgcmVndWxhdG9yICp2YnVzX3N1cHBsaWVzJyB3aXRoIGEgDQpzaXplIGNvcnJl
c3BvbmRpbmcgdG8gJ0hDU19OX1BPUlRTKGVoY2ktPmhjc19wYXJhbXMpICogc2l6ZW9mKHN0cnVj
dCANCnJlZ3VsYXRvciAqKScuDQpBbmQgbG9vcCB0byBnZXQgb3B0aW9uYWwgcmVndWxhdG9yIHZi
dXMwLCB2YnVzMSwuLi4sIHZidXNOLg0KQW5kIHRoZW4gZW5hYmxlL2Rpc2FibGUgdGhlIGNvcnJl
c3BvbmRpbmcgcmVndWxhdG9yIGluIA0KZWhjaV9wbGF0Zm9ybV9wb3J0X3Bvd2VyIHRoYW5rcyB0
byBwb3J0bnVtLg0KDQo+PiAgIEV4YW1wbGUgKFNlcXVvaWEgNDQwRVB4KToNCj4+ICAgICAgIGVo
Y2lAZTAwMDAzMDAgew0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1wbGF0
Zm9ybS5jIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLXBsYXRmb3JtLmMNCj4+IGluZGV4IGIwNjVh
OTYuLjA1YmUxMDAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L2VoY2ktcGxhdGZv
cm0uYw0KPj4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9laGNpLXBsYXRmb3JtLmMNCj4+IEBAIC0y
OSw2ICsyOSw3IEBADQo+PiAgICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPj4gICAjaW5jbHVkZSA8
bGludXgvcGh5L3BoeS5oPg0KPj4gICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+
DQo+PiArI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KPj4gICAjaW5jbHVk
ZSA8bGludXgvcmVzZXQuaD4NCj4+ICAgI2luY2x1ZGUgPGxpbnV4L3VzYi5oPg0KPj4gICAjaW5j
bHVkZSA8bGludXgvdXNiL2hjZC5oPg0KPj4gQEAgLTQ2LDYgKzQ3LDcgQEAgc3RydWN0IGVoY2lf
cGxhdGZvcm1fcHJpdiB7DQo+PiAgIAlzdHJ1Y3QgcmVzZXRfY29udHJvbCAqcnN0czsNCj4+ICAg
CXN0cnVjdCBwaHkgKipwaHlzOw0KPj4gICAJaW50IG51bV9waHlzOw0KPj4gKwlzdHJ1Y3QgcmVn
dWxhdG9yICp2YnVzX3N1cHBseTsNCj4+ICAgCWJvb2wgcmVzZXRfb25fcmVzdW1lOw0KPj4gICB9
Ow0KPj4gICANCj4+IEBAIC03Niw2ICs3OCwyNSBAQCBzdGF0aWMgaW50IGVoY2lfcGxhdGZvcm1f
cmVzZXQoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4+ICAgCXJldHVybiAwOw0KPj4gICB9DQo+PiAg
IA0KPj4gK3N0YXRpYyBpbnQgZWhjaV9wbGF0Zm9ybV9wb3J0X3Bvd2VyKHN0cnVjdCB1c2JfaGNk
ICpoY2QsIGludCBwb3J0bnVtLA0KPj4gKwkJCQkgICAgYm9vbCBlbmFibGUpDQo+PiArew0KPj4g
KwlzdHJ1Y3QgZWhjaV9wbGF0Zm9ybV9wcml2ICpwcml2ID0gaGNkX3RvX2VoY2lfcHJpdihoY2Qp
Ow0KPj4gKwlpbnQgcmV0ID0gMDsNCj4+ICsNCj4+ICsJaWYgKHByaXYtPnZidXNfc3VwcGx5KSB7
DQo+PiArCQlpZiAoZW5hYmxlKQ0KPj4gKwkJCXJldCA9IHJlZ3VsYXRvcl9lbmFibGUocHJpdi0+
dmJ1c19zdXBwbHkpOw0KPj4gKwkJZWxzZQ0KPj4gKwkJCXJldCA9IHJlZ3VsYXRvcl9kaXNhYmxl
KHByaXYtPnZidXNfc3VwcGx5KTsNCj4+ICsJCWlmIChyZXQpDQo+PiArCQkJZGV2X2VycihoY2Qt
PnNlbGYuY29udHJvbGxlciwNCj4+ICsJCQkJImZhaWxlZCB0byAlcyB2YnVzIHN1cHBseTogJWRc
biIsDQo+PiArCQkJCWVuYWJsZSA/ICJlbmFibGUiIDogImRpc2FibGUiLCByZXQpOw0KPj4gKwl9
DQo+PiArCXJldHVybiByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50IGVoY2lfcGxh
dGZvcm1fcG93ZXJfb24oc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KPj4gICB7DQo+PiAg
IAlzdHJ1Y3QgdXNiX2hjZCAqaGNkID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsNCj4+IEBA
IC0xMzQsNiArMTU1LDcgQEAgc3RhdGljIHN0cnVjdCBoY19kcml2ZXIgX19yZWFkX21vc3RseSBl
aGNpX3BsYXRmb3JtX2hjX2RyaXZlcjsNCj4+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBlaGNpX2Ry
aXZlcl9vdmVycmlkZXMgcGxhdGZvcm1fb3ZlcnJpZGVzIF9faW5pdGNvbnN0ID0gew0KPj4gICAJ
LnJlc2V0ID0JCWVoY2lfcGxhdGZvcm1fcmVzZXQsDQo+PiAgIAkuZXh0cmFfcHJpdl9zaXplID0J
c2l6ZW9mKHN0cnVjdCBlaGNpX3BsYXRmb3JtX3ByaXYpLA0KPj4gKwkucG9ydF9wb3dlciA9CQll
aGNpX3BsYXRmb3JtX3BvcnRfcG93ZXIsDQo+PiAgIH07DQo+PiAgIA0KPj4gICBzdGF0aWMgc3Ry
dWN0IHVzYl9laGNpX3BkYXRhIGVoY2lfcGxhdGZvcm1fZGVmYXVsdHMgPSB7DQo+PiBAQCAtMjQ3
LDYgKzI2OSwxNSBAQCBzdGF0aWMgaW50IGVoY2lfcGxhdGZvcm1fcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqZGV2KQ0KPj4gICAJaWYgKGVycikNCj4+ICAgCQlnb3RvIGVycl9wdXRfY2xr
czsNCj4+ICAgDQo+PiArCXByaXYtPnZidXNfc3VwcGx5ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29w
dGlvbmFsKCZkZXYtPmRldiwgInZidXMiKTsNCj4+ICsJaWYgKElTX0VSUihwcml2LT52YnVzX3N1
cHBseSkpIHsNCj4+ICsJCWVyciA9IFBUUl9FUlIocHJpdi0+dmJ1c19zdXBwbHkpOw0KPj4gKwkJ
aWYgKGVyciA9PSAtRU5PREVWKQ0KPj4gKwkJCXByaXYtPnZidXNfc3VwcGx5ID0gTlVMTDsNCj4+
ICsJCWVsc2UNCj4+ICsJCQlnb3RvIGVycl9yZXNldDsNCj4+ICsJfQ0KPj4gKw0KPj4gICAJaWYg
KHBkYXRhLT5iaWdfZW5kaWFuX2Rlc2MpDQo+PiAgIAkJZWhjaS0+YmlnX2VuZGlhbl9kZXNjID0g
MTsNCj4+ICAgCWlmIChwZGF0YS0+YmlnX2VuZGlhbl9tbWlvKQ0KPj4NCj4g
