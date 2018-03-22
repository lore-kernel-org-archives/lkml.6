Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2601871-1521721381-2-6941902627024008925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521721381; b=g/pivHEYLDHibBL3J+dgakBGzkGYUkw6RyvGWse7lDZr92o
    TOQq4TDF+wuDzUrg0fOr3lvD0qUqOWbI/yJx7MdjMviHIKNUMQIKOlQL+cjff4Y7
    T1ocv5tIjyqPXjbXhkkLfLEL8wdMRYrtQRvzt3CxTSr2AS8avzD1nMoOCz3ucpcu
    IdPo6lRJz5Xt/meMEprDNrRyZ9oFbe5buk7P/zVKlZwPAALqjyRFTf9JHjrKn+VA
    Oe7oMiFW2mfGcVobtEAYDcNmH2pxIbDxzNqw+mjItHa4T6NCMIH7xVf/PUSWpfx7
    uNM3t3AvxPIjLO2IjMmYb/4A9qI/4XePLEEPrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521721381; bh=oI6hP1B7qmU9daQfrKlmUW/SXJmUqjlj2X9SMa
    xpSDY=; b=kYzhpuiLtrFbrvdA9kjdpcU2uNjH5YwCcqPF7wIz5y5gsO9/hCODlB
    pHwiNdRAZpPw45g5H12lomnjFVhv7P8uN0g3lSsE+IFjZ+Ubn+R0lnqpepOBPtAU
    HttNFSAq4AaK9Osz/dqlhAvs5MH8egdWHlJLz+bCoaxJP1bLZkZG4iW2dtkQrslr
    l9W/Fb2WLTXubjlN6bziu5SkGKiqbzP33wWlN/uXbSV5wItt1+e0wPBjlrPMzNWx
    QhHajmj/IeC9fv62g1KcgjknZGwhM7CNiYZ3dTt8iEw1xQZrDBd/t2RaWvbyBXgg
    5sGWhnohuYOtiX0VZqylMcPGXg/s4Ozg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754272AbeCVMWr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 08:22:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47103 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751835AbeCVMWq (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 08:22:46 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: =?utf-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Felipe Balbi" <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Topic: [PATCH] usb: dwc2: dwc2_vbus_supply_init: fix error check
Thread-Index: AQHTwcHTIMjTpWUNYk2vfSjZYN5viKPcEIWAgAAArQCAAAsrAA==
Date: Thu, 22 Mar 2018 12:21:37 +0000
Message-ID: <4ff302fe-dc89-a7fc-5454-6a518256c912@st.com>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com>
 <1711886.RiDBCvOSMq@diego> <3806387.a3O5bOALIr@diego>
In-Reply-To: <3806387.a3O5bOALIr@diego>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B59D49F0FD9744F9B07538343F76CA5@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgSGVpa28sDQpIaSBUb21ldSwNCg0KT24gMDMvMjIvMjAxOCAxMjo0MSBQTSwgSGVpa28gU3TD
vGJuZXIgd3JvdGU6DQo+IEhpIFRvbWV1LA0KPiANCj4gQW0gRG9ubmVyc3RhZywgMjIuIE3DpHJ6
IDIwMTgsIDEyOjM5OjEzIENFVCBzY2hyaWViIEhlaWtvIFN0w7xibmVyOg0KPj4gQW0gRG9ubmVy
c3RhZywgMjIuIE3DpHJ6IDIwMTgsIDEwOjM5OjQzIENFVCBzY2hyaWViIFRvbWV1IFZpem9zbzoN
Cj4+PiBkZXZtX3JlZ3VsYXRvcl9nZXRfb3B0aW9uYWwgcmV0dXJucyAtRU5PREVWIGlmIHRoZSBy
ZWd1bGF0b3IgaXNuJ3QNCj4+PiB0aGVyZSwgc28gaWYgdGhhdCdzIHRoZSBjYXNlIHdlIGhhdmUg
dG8gbWFrZSBzdXJlIG5vdCB0byBsZWF2ZSAtRU5PREVWDQo+Pj4gaW4gdGhlIHJlZ3VsYXRvciBw
b2ludGVyLg0KPj4+DQo+Pj4gQWxzbywgbWFrZSBzdXJlIHdlIHJldHVybiAwIGluIHRoYXQgY2Fz
ZSwgYnV0IGNvcnJlY3RseSBwcm9wYWdhdGUgYW55DQo+Pj4gb3RoZXIgZXJyb3JzLiBBbHNvIHBy
b3BhZ2F0ZSB0aGUgZXJyb3IgZnJvbSBfZHdjMl9oY2Rfc3RhcnQuDQo+Pj4NCj4+PiBGaXhlczog
NTMxZWY1ZWJlYTk2ICgidXNiOiBkd2MyOiBhZGQgc3VwcG9ydCBmb3IgaG9zdCBtb2RlIGV4dGVy
bmFsIHZidXMNCj4+PiBzdXBwbHkiKSBDYzogQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVu
YXlAc3QuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFRvbWV1IFZpem9zbyA8dG9tZXUudml6b3Nv
QGNvbGxhYm9yYS5jb20+DQo+Pg0KPj4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGF0IG9vcHMgaW4g
eW91ciB0ZXN0cy4NCj4+IFJldmlld2VkLWJ5OiBIZWlrbyBTdHVlYm5lciA8aGVpa29Ac250ZWNo
LmRlPg0KPiANCj4gSSB0YWtlIHRoYXQgYmFjayA6LSkNCj4gc2VlIGJlbG93DQo+IA0KPj4+IC0t
LQ0KPj4+DQo+Pj4gICBkcml2ZXJzL3VzYi9kd2MyL2hjZC5jIHwgMTMgKysrKysrKystLS0tLQ0K
Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+
Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2Iv
ZHdjMi9oY2QuYw0KPj4+IGluZGV4IGRjZmRhNWViNGNhYy4uNGFlMjExZjY1ZTg1IDEwMDY0NA0K
Pj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4+PiArKysgYi9kcml2ZXJzL3VzYi9k
d2MyL2hjZC5jDQo+Pj4gQEAgLTM1OSw4ICszNTksMTMgQEAgc3RhdGljIHZvaWQgZHdjMl9ndXNi
Y2ZnX2luaXQoc3RydWN0IGR3YzJfaHNvdGcNCj4+PiAqaHNvdGcpIHN0YXRpYyBpbnQgZHdjMl92
YnVzX3N1cHBseV9pbml0KHN0cnVjdCBkd2MyX2hzb3RnICpoc290ZykNCj4+Pg0KPj4+ICAgew0K
Pj4+ICAgDQo+Pj4gICAJaHNvdGctPnZidXNfc3VwcGx5ID0gZGV2bV9yZWd1bGF0b3JfZ2V0X29w
dGlvbmFsKGhzb3RnLT5kZXYsICJ2YnVzIik7DQo+Pj4NCj4+PiAtCWlmIChJU19FUlIoaHNvdGct
PnZidXNfc3VwcGx5KSkNCj4+PiAtCQlyZXR1cm4gMDsNCj4+PiArCWlmIChJU19FUlIoaHNvdGct
PnZidXNfc3VwcGx5KSkgew0KPj4+ICsJCWhzb3RnLT52YnVzX3N1cHBseSA9IE5VTEw7DQo+Pj4g
KwkJaWYgKFBUUl9FUlIoaHNvdGctPnZidXNfc3VwcGx5KSA9PSAtRU5PREVWKQ0KPiANCj4gaHNv
dGctPnZidXNfc3VwcGx5IGlzIGFscmVhZHkgTlVMTCBoZXJlDQo+IA0KDQpUb21ldSBpcyByaWdo
dCwgaGVyZSwgaHNvdGctPnZidXNfc3VwcGx5ID0gRVJSX1BUUigtRU5PREVWKS4NCi8qKg0KICAq
IHJlZ3VsYXRvcl9nZXRfb3B0aW9uYWwgLSBvYnRhaW4gb3B0aW9uYWwgYWNjZXNzIHRvIGEgcmVn
dWxhdG9yLg0KICAqIC4uLg0KICAqIFJldHVybnMgYSBzdHJ1Y3QgcmVndWxhdG9yIGNvcnJlc3Bv
bmRpbmcgdG8gdGhlIHJlZ3VsYXRvciBwcm9kdWNlciwNCiAgKiBvciBJU19FUlIoKSBjb25kaXRp
b24gY29udGFpbmluZyBlcnJuby4NCiAgKiAuLi4NCiAgKi8NCg0KWW91IGNhbiBhZGQgbXkgUmV2
aWV3ZWQtYnk6IEFtZWxpZSBEZWxhdW5heSA8YW1lbGllLmRlbGF1bmF5QHN0LmNvbT4NCg0KVGhh
bmtzIGZvciB0aGUgZml4LA0KQW1lbGll
