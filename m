Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2928668-1519134562-2-1148414625268145778
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
    t=1519134561; b=CtKtQ3bVJ3poHyKp+Jj8xdhbN5FjM/Mybs8CJF1zLhr45ok
    Ew/+xVSXhditWZQZ62Dmek1ZOIbxTBXwoF+lghBk/UfM/nuYQybGDNj8f8D8BF9q
    J/8GROk8x16JxKeaJ5TdmtLYktawI/pQmVHhtB1o8vY5ZlcKhi7bf6l3w3uEXmDL
    g6PiPku1gsYZeOB+YbptQkPrv493KncmTvtMRsWG+2/wBAS6iaqVzFvaqs/iow4E
    Kk4BxU980gY6I303LCussE6J13bY3gDtcrEFcMxmMLzsJ5tw3l7AediCiZpejzfT
    AS+zOHGKMC9kdWyjHtOpWj2v8h2pp07AQNZUcig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1519134561; bh=9LGc1oZvZUe4GuEQXCqDdyQZPx+PNjDevlXhqn
    PAr8E=; b=J08MFqTZeIFqiZ3quwZi6OU0zH0zdS3KwNQ4QfGYr1cERyCJLyMvzj
    1p7XiPKaqfYokExcQXnlEuffb+r4Mx1icE5re162W8+ZvDeikS8noNdmOxN50JxR
    i7RMFKdkfFSZdE43DHc3+ziUsgyXCJa6uWxNuucoRvU0npc24Nt40ycDVlns4BhU
    xse9vqUqDMzaqTsusENh2CCuzard+dH7ABpgiadYKv3jLw/8a7GSkfl9tU3adHTv
    CAb8hDuBuGWZMslpTIR4tuP+1zukU35lAloKckMO6eZuNfhy6SB5uusUhbW9BHZ/
    YL/KC9FNkFgkmS4EVM5JzfB7bNva3D8Q==
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
        id S1750786AbeBTNsz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 08:48:55 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59098 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750733AbeBTNsy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 20 Feb 2018 08:48:54 -0500
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roger Quadros <rogerq@ti.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Topic: [PATCH v2] usb: host: ehci-platform: add support for optional
 external vbus supply
Thread-Index: AQHTqkp3rnXPTZ4feU61xpBLtCmRWqOtMNWAgAAMvoA=
Date: Tue, 20 Feb 2018 13:48:18 +0000
Message-ID: <a34d376e-45c2-0791-7c69-d6647170aff9@st.com>
References: <1519131492-27913-1-git-send-email-amelie.delaunay@st.com>
 <87h8qbq0em.fsf@linux.intel.com>
In-Reply-To: <87h8qbq0em.fsf@linux.intel.com>
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
Content-ID: <B926517B6812714298BA59338EE82C50@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-20_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGksDQoNCk9uIDAyLzIwLzIwMTggMDI6MDIgUE0sIEZlbGlwZSBCYWxiaSB3cm90ZToNCj4gDQo+
IEhpLA0KPiANCj4gQW1lbGllIERlbGF1bmF5IDxhbWVsaWUuZGVsYXVuYXlAc3QuY29tPiB3cml0
ZXM6DQo+PiBPbiBzb21lIGJvYXJkcywgZXNwZWNpYWxseSB3aGVuIHZidXMgc3VwcGx5IHJlcXVp
cmVzIGxhcmdlIGN1cnJlbnQsDQo+PiBhbmQgdGhlIGNoYXJnZSBwdW1wIG9uIHRoZSBQSFkgaXNu
J3QgZW5vdWdoLCBhbiBleHRlcm5hbCB2YnVzIHBvd2VyIHN3aXRjaA0KPj4gbWF5IGJlIHVzZWQu
DQo+PiBBZGQgc3VwcG9ydCBmb3IgdGhpcyBvcHRpb25hbCBleHRlcm5hbCB2YnVzIHN1cHBseSBp
biBlaGNpLXBsYXRmb3JtLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFtZWxpZSBEZWxhdW5heSA8
YW1lbGllLmRlbGF1bmF5QHN0LmNvbT4NCj4+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjI6DQo+
PiAgICogQWRkcmVzcyBSb2dlciBRdWFkcm9zIGNvbW1lbnRzOiBtb3ZlIHJlZ3VsYXRvcl9lbmFi
bGUvZGlzYWJsZSBmcm9tDQo+PiBlaGNpX3BsYXRmb3JtX3Bvd2VyX29uL29mZiB0byBlaGNpX3Bs
YXRmb3JtX3BvcnRfcG93ZXIuDQo+PiAtLS0NCj4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3VzYi91c2ItZWhjaS50eHQgfCAgMSArDQo+PiAgIGRyaXZlcnMvdXNiL2hvc3Qv
ZWhjaS1wbGF0Zm9ybS5jICAgICAgICAgICAgICAgICAgIHwgMzEgKysrKysrKysrKysrKysrKysr
KysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItZWhjaS50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1laGNpLnR4dA0K
Pj4gaW5kZXggM2VmZGUxMi4uZmM0ODBjZCAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWVoY2kudHh0DQo+PiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1laGNpLnR4dA0KPj4gQEAgLTE5LDYgKzE5
LDcgQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4+ICAgIC0gcGh5cyA6IHBoYW5kbGUgKyBwaHkg
c3BlY2lmaWVyIHBhaXINCj4+ICAgIC0gcGh5LW5hbWVzIDogInVzYiINCj4+ICAgIC0gcmVzZXRz
IDogcGhhbmRsZSArIHJlc2V0IHNwZWNpZmllciBwYWlyDQo+PiArIC0gdmJ1cy1zdXBwbHkgOiBw
aGFuZGxlIG9mIHJlZ3VsYXRvciBzdXBwbHlpbmcgdmJ1cw0KPj4gICANCj4+ICAgRXhhbXBsZSAo
U2VxdW9pYSA0NDBFUHgpOg0KPj4gICAgICAgZWhjaUBlMDAwMDMwMCB7DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvaG9zdC9laGNpLXBsYXRmb3JtLmMgYi9kcml2ZXJzL3VzYi9ob3N0L2Vo
Y2ktcGxhdGZvcm0uYw0KPj4gaW5kZXggYjA2NWE5Ni4uMDViZTEwMCAxMDA2NDQNCj4+IC0tLSBh
L2RyaXZlcnMvdXNiL2hvc3QvZWhjaS1wbGF0Zm9ybS5jDQo+PiArKysgYi9kcml2ZXJzL3VzYi9o
b3N0L2VoY2ktcGxhdGZvcm0uYw0KPj4gQEAgLTI5LDYgKzI5LDcgQEANCj4+ICAgI2luY2x1ZGUg
PGxpbnV4L29mLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9waHkvcGh5Lmg+DQo+PiAgICNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcmVndWxh
dG9yL2NvbnN1bWVyLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPj4gICAjaW5j
bHVkZSA8bGludXgvdXNiLmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC91c2IvaGNkLmg+DQo+PiBA
QCAtNDYsNiArNDcsNyBAQCBzdHJ1Y3QgZWhjaV9wbGF0Zm9ybV9wcml2IHsNCj4+ICAgCXN0cnVj
dCByZXNldF9jb250cm9sICpyc3RzOw0KPj4gICAJc3RydWN0IHBoeSAqKnBoeXM7DQo+PiAgIAlp
bnQgbnVtX3BoeXM7DQo+PiArCXN0cnVjdCByZWd1bGF0b3IgKnZidXNfc3VwcGx5Ow0KPj4gICAJ
Ym9vbCByZXNldF9vbl9yZXN1bWU7DQo+PiAgIH07DQo+PiAgIA0KPj4gQEAgLTc2LDYgKzc4LDI1
IEBAIHN0YXRpYyBpbnQgZWhjaV9wbGF0Zm9ybV9yZXNldChzdHJ1Y3QgdXNiX2hjZCAqaGNkKQ0K
Pj4gICAJcmV0dXJuIDA7DQo+PiAgIH0NCj4+ICAgDQo+PiArc3RhdGljIGludCBlaGNpX3BsYXRm
b3JtX3BvcnRfcG93ZXIoc3RydWN0IHVzYl9oY2QgKmhjZCwgaW50IHBvcnRudW0sDQo+PiArCQkJ
CSAgICBib29sIGVuYWJsZSkNCj4+ICt7DQo+PiArCXN0cnVjdCBlaGNpX3BsYXRmb3JtX3ByaXYg
KnByaXYgPSBoY2RfdG9fZWhjaV9wcml2KGhjZCk7DQo+PiArCWludCByZXQgPSAwOw0KPj4gKw0K
Pj4gKwlpZiAocHJpdi0+dmJ1c19zdXBwbHkpIHsNCj4gDQo+IHlvdSBjYW4gcmVkdWNlIGluZGVu
dGF0aW9uIGhlcmU6DQo+IA0KPiAJaWYgKCFwcml2LT52YnVzX3N1cHBseSkNCj4gICAgICAgICAg
CXJldHVybiAwOw0KPiANCg0KWW91J3JlIHJpZ2h0LCB0aGFua3MhIEkgd2lsbCBmaXggaXQgaW4g
dXBjb21pbmcgdjMsIHdhaXRpbmcgZm9yIG90aGVyIA0KYWRkaXRpb25hbCBjb21tZW50cy4NCkFt
ZWxpZQ==
