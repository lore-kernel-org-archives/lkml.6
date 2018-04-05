Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2765921-1522932852-2-14977402565660671513
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522932851; b=rrcluqyzn5Oe/mzr1NsMIIdoLX0jWfma+fR+TiK8gAqzcUa2DD
    kC+jwkvObWuUP9BNZYJGo+uxINqJldVh0NTUnOeE3q6JcO7Jyw3OIQ7Dlv0Ab9md
    MUfOp2AUhhoMQyDl6iqnOrorFb3RjoaPbhDstT+BE80rgyg+nQfBgS/Eja/S4Eoh
    O7lHs/9qJMUSVl8TAbNTIBw3frnB7oNXWmOuE6ivAV5Aa+oRA5YD5Yw+1VdNbcJE
    jpJvvFvvz4GRiKyjlL5W5DCpD/y9dF/eGFFQ2dAY49aBJJEfOjRtrwsIWkHyq1pq
    HWgZckH8ou3h1rRlmm0ur/j2HUsXOZStcjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1522932851; bh=c6K037JagOR9R55Gz8aHXRIyJPGWjJNqHkimJOqb4rk=; b=
    NgyBwMJLs/KU6Txb1o1I4IZqjtQrTwfCd+p87bWBkoRFUJ9/VqvJHwPIo0Eq3YLV
    h5sfF7rRYsn8lH2BPNtrfdQrwqRUglrv/I5q3U+vVDMG+wCFVkBeUJJisO8WDq5R
    CSObA+iWFKnmzpcNBHaeiex8wIfK7V1aZd+rkdIzxFF+xiOrLzPleWXDDddUNI1X
    Y2yhcc5KsCt7N4Ptf5EiqGgRR7VbAJ3DniTo76bUsKs84xPEj4rC8BzqXpKmVD3f
    2IG7cKO7wEzL941QUScJWy4bDTgyb/o0tuAzf3N03FezpgTMDGmbJ59+uxiQYHHo
    Mw7gvsXAFDPlBJ35rDzPeQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE3YQO811s6PCO1sqWso8SuW0zKXHaH2yvvJBgfNDwwCZpcmpQ5y9w4bcc+nu6NRItSXjDc1LtbEv5HmUjrQkuNs6SdDRJebWjFk+l/sJxkBACAkdm9u
    WYF8b8OQ0CqZplHIxQVRg0kPX2mv5BW5DpVn+6s87gqGTQTYbWdjL/ggrA93zsyzqjV6eFk/ApRzq60xsN5JuISuzmFxF8MUZ2QzqIPUSjtagK7UaEClpeUD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=vPBPsFTO9Q0A:10 a=IkcTkHD0fZMA:10
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=pGLkceISAAAA:8 a=i3X5FwGiAAAA:8
    a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8
    a=YeZvSj_4ZK-LcE0HaWsA:9 a=QEXdDO2ut3YA:10 a=kGx2xdnZ_AYA:10
    a=mmqRlSCDY2ywfjPLJ4af:22 a=cvBusfyB2V15izCimMoJ:22 a=T3LWEMljR5ZiDmsYVIUa:22
    a=Vxmtnl_E_bksehYqCbjh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeDEMyK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 08:54:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36829 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751097AbeDEMyJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 5 Apr 2018 08:54:09 -0400
From: Philippe CORNU <philippe.cornu@st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Oliver O'Halloran" <oohall@gmail.com>
CC: "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Vincent ABRIOU" <vincent.abriou@st.com>
Subject: Re: [PATCH] drm/sti: Depend on OF rather than selecting it
Thread-Topic: [PATCH] drm/sti: Depend on OF rather than selecting it
Thread-Index: AQHTzNBNwDMYlw6l6kOsWDIgTSjWZKPx/yEA
Date: Thu, 5 Apr 2018 12:53:56 +0000
Message-ID: <24f85eb5-b6fc-5c4c-fe31-979d13df8924@st.com>
References: <20180403053401.30045-1-oohall@gmail.com>
 <CA+M3ks4RPe_jo-LKKCNU22fzQWO3nvJEiZYg_mB6tSVd9PgqZA@mail.gmail.com>
In-Reply-To: <CA+M3ks4RPe_jo-LKKCNU22fzQWO3nvJEiZYg_mB6tSVd9PgqZA@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <311D2F362F69D64B83D8B3FFFB428090@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_06:,,
 signatures=0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIDA0LzA1LzIwMTggMDE6MDUgUE0sIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPiAy
MDE4LTA0LTAzIDc6MzQgR01UKzAyOjAwIE9saXZlciBPJ0hhbGxvcmFuIDxvb2hhbGxAZ21haWwu
Y29tPjoNCj4+IENvbW1pdCBjYzZiNzQxYzZmNjMgKCJkcm06IHN0aTogcmVtb3ZlIHVzZWxlc3Mg
ZmllbGRzIGZyb20gdnRnDQo+PiBzdHJ1Y3R1cmUiKSByZXdvcmtlZCBzb21lIGNvZGUgaW5zaWRl
IG9mIHRoaXMgZHJpdmVyIGFuZCBtYWRlIGl0IHNlbGVjdA0KPj4gQ09ORklHX09GLiBUaGlzIHJl
c3VsdHMgaW4gdGhlIGVudGlyZSBPRiBsYXllciBiZWluZyBlbmFibGVkIHdoZW4NCj4+IGJ1aWxk
aW5nIGFuIGFsbG1vZGNvbmZpZyBvbiBpYTY0LiBPRiBvbiBpYTY0IGlzIGNvbXBsZXRlbHkgdW5z
dXBwb3J0ZWQNCj4+IHNvIHRoaXMgaXNuJ3QgYSBncmVhdCBzdGF0ZSBvZiBhZmZhaXJzLg0KPj4N
Cj4+IFRoZSAwZGF5IHJvYm90IG5vdGljZWQgYSBsaW5rLXRpbWUgZmFpbHVyZSBvbiBpYTY0IGNh
dXNlZCBieQ0KPj4gdXNpbmcgb2Zfbm9kZV90b19uaWQoKSBpbiBhbiBvdGhlcndpc2UgdW5yZWxh
dGVkIGRyaXZlci4gVGhlDQo+PiBnZW5lcmljIGZhbGxiYWNrIGZvciBvZl9ub2RlX3RvX25pZCgp
IG9ubHkgZXhpc3RzIHdoZW46DQo+Pg0KPj4gICAgICAgICAgZGVmaW5lZChDT05GSUdfT0YpICYm
IGRlZmluZWQoQ09ORklHX05VTUEpID09IGZhbHNlDQo+Pg0KPj4gU2luY2UgQ09ORklHX05VTUEg
aXMgdXN1YWxseSBzZWxlY3RlZCBmb3IgSUE2NCB3ZSBnZXQgdGhlIGxpbmsgZmFpbHVyZS4NCj4+
IEZpeCB0aGlzIGJ5IG1ha2luZyB0aGUgZHJpdmVyIGRlcGVuZCBvbiBPRiByYXRoZXIgdGhhbiBz
ZWxlY3RpbmcgaXQsDQo+PiBvZGRzIGFyZSB0aGF0IHdhcyB0aGUgb3JpZ2luYWwgaW50ZW50Lg0K
Pj4NCj4+IExpbms6IGh0dHBzOi8vbGlzdHMuMDEub3JnL3BpcGVybWFpbC9rYnVpbGQtYWxsLzIw
MTgtTWFyY2gvMDQ1MTcyLmh0bWwNCj4+IEZpeGVzOiBjYzZiNzQxYzZmNjMgKCJkcm06IHN0aTog
cmVtb3ZlIHVzZWxlc3MgZmllbGRzIGZyb20gdnRnIHN0cnVjdHVyZSIpDQo+PiBDYzogQmVuamFt
aW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQGxpbmFyby5vcmc+DQo+PiBDYzogVmluY2Vu
dCBBYnJpb3UgPHZpbmNlbnQuYWJyaW91QHN0LmNvbT4NCj4+IENjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+DQo+PiBDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0K
Pj4gQ2M6IGxpbnV4LWlhNjRAdmdlci5rZXJuZWwub3JnDQo+PiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPj4gU2lnbmVkLW9mZi1ieTogT2xpdmVyIE8nSGFsbG9yYW4gPG9vaGFsbEBnbWFp
bC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdh
aWduYXJkQGxpbmFyby5vcmc+DQoNCkFwcGxpZWQgb24gZHJtLW1pc2MtbmV4dA0KDQpNYW55IHRo
YW5rcyBmb3IgeW91ciBwYXRjaCwNClBoaWxpcHBlIDotKQ0KDQo+IA0KPj4gLS0tDQo+PiBDY2Bl
ZCB0byBzdGFibGUgc2luY2UgdGhlIGlhNjQgZ3V5cyBtaWdodCB3YW50IGl0IGJhY2twb3J0ZWQu
IEknbSBub3QNCj4+IGJvdGhlcmVkIGlmIGl0IGp1c3QgZ29lcyBpbnRvIG1haW5saW5lLg0KPj4g
LS0tDQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9zdGkvS2NvbmZpZyB8IDMgKy0tDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL3N0aS9LY29uZmlnIGIvZHJpdmVycy9ncHUvZHJtL3N0aS9L
Y29uZmlnDQo+PiBpbmRleCBjY2E0YjNjOWFlYjUuLjE5NjNjYzFiMWNjNSAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9zdGkvS2NvbmZpZw0KPj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L3N0aS9LY29uZmlnDQo+PiBAQCAtMSw2ICsxLDYgQEANCj4+ICAgY29uZmlnIERSTV9TVEkNCj4+
ICAgICAgICAgIHRyaXN0YXRlICJEUk0gU3VwcG9ydCBmb3IgU1RNaWNyb2VsZWN0cm9uaWNzIFNv
QyBzdGlINHh4IFNlcmllcyINCj4+IC0gICAgICAgZGVwZW5kcyBvbiBEUk0gJiYgKEFSQ0hfU1RJ
IHx8IEFSQ0hfTVVMVElQTEFURk9STSkNCj4+ICsgICAgICAgZGVwZW5kcyBvbiBPRiAmJiBEUk0g
JiYgKEFSQ0hfU1RJIHx8IEFSQ0hfTVVMVElQTEFURk9STSkNCj4+ICAgICAgICAgIHNlbGVjdCBS
RVNFVF9DT05UUk9MTEVSDQo+PiAgICAgICAgICBzZWxlY3QgRFJNX0tNU19IRUxQRVINCj4+ICAg
ICAgICAgIHNlbGVjdCBEUk1fR0VNX0NNQV9IRUxQRVINCj4+IEBAIC04LDYgKzgsNSBAQCBjb25m
aWcgRFJNX1NUSQ0KPj4gICAgICAgICAgc2VsZWN0IERSTV9QQU5FTA0KPj4gICAgICAgICAgc2Vs
ZWN0IEZXX0xPQURFUg0KPj4gICAgICAgICAgc2VsZWN0IFNORF9TT0NfSERNSV9DT0RFQyBpZiBT
TkRfU09DDQo+PiAtICAgICAgIHNlbGVjdCBPRg0KPj4gICAgICAgICAgaGVscA0KPj4gICAgICAg
ICAgICBDaG9vc2UgdGhpcyBvcHRpb24gdG8gZW5hYmxlIERSTSBvbiBTVE0gc3RpSDR4eCBjaGlw
c2V0DQo+PiAtLQ0KPj4gMi45LjUNCj4+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+IGRyaS1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA0KPiA=
