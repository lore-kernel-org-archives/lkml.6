Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2663489-1520409728-2-11167406372177559407
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520409727; b=R6JVt8LFfC8E/uFYRhlLplQokLsi5sH8aqtIvHpJ5GDTVi6
    T4YcYCM8onTp429/3Qu+ap7RNNQRCzNfPhR14DiW+rmCkVscUeD2VEiofCCZ5iCc
    VAdhCk33vjFAVxp/5zXoCA81mAqCzFR+02A+HII/056H6uHcimvQEggHJ23dLxCm
    FjFtzVjkCdw4K0nxRkwDbZu+8lsUjsxE1ICRQ77T5FCITHJL+Tblg8sv/OHCG6B5
    ++D6wd4MPEcE1Wvk2FEWgLLKzsz5Oh3d8W/P552LaT6wf8JBREVXYqf5T66akZLC
    CwMndmsjE6zsQMOMlZIL5P9izNRlXIcbxUYolVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520409727; bh=j0D51HUHyUiuFR8I8D/3U/U93JjA3kskSBkXwA
    JO5Q0=; b=ocWA7EIblfXAIRucg32tpdlniCzglI8Axm9PwSmie6frP/+q/5/t6L
    meZDfJWn7eWq6T7ZZNpJAeemL/claTYi8DiZXtd5spPJoICYzJ58JkN7L1b6eTbB
    QtH0k510Z0xrqXifc49KydksQlFXGafyD1cm0yiBJjh5OveQ0s4jjIqNUg9IkN5q
    1tep1hc6uRZlPUPVzM2JeWr2u1ubW90S76n3ojKQanweAF43RcLSjWrHFCYhWTmq
    WVE/+X17zlnLX/zboMSOdF1I/s5PVRXSvwdR9dXIlSvuZfNni3X7/10teo9rmIj5
    AqBIYEtrFPngrcz25L59p3kK4cdauqUw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbeCGICG (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:02:06 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9415 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750989AbeCGICF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 03:02:05 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] tty: st-asc: Update tty alias
Thread-Topic: [PATCH v2 3/3] tty: st-asc: Update tty alias
Thread-Index: AQHTtSIx63R6sAG2y0+76ke43Y9zY6PDIzWAgAE2rIA=
Date: Wed, 7 Mar 2018 08:01:11 +0000
Message-ID: <394e92bd-3e6c-6163-4a9f-66182e41238b@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
 <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
 <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
In-Reply-To: <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BB7B316A774A240B77F1D5227A15AF9@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

SGkgUm9iDQoNCk9uIDAzLzA2LzIwMTggMDI6MjkgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBP
biBUdWUsIE1hciA2LCAyMDE4IGF0IDI6MDcgQU0sICA8cGF0cmljZS5jaG90YXJkQHN0LmNvbT4g
d3JvdGU6DQo+PiBGcm9tOiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+
DQo+Pg0KPj4gU2luY2UgZHRjIHYxLjQuNi05LWdhYWRkMGI2NWM5ODcsIGFsaWFzZXMgcHJvcGVy
dHkgbmFtZQ0KPj4gbXVzdCBpbmNsdWRlIG9ubHkgbG93ZXJjYXNlIGFuZCAnLScuDQo+Pg0KPj4g
QWZ0ZXIgaGF2aW5nIHVwZGF0ZWQgYWxsIFNUaSBib2FyZHMgc2VyaWFsIGFsaWFzZXMgZnJvbSAi
dHR5QVNOIg0KPj4gdG8gInNlcmlhbE4iLCBzdC1hc2MgZHJpdmVyIG5lZWQgdG8gYmUgdXBkYXRl
ZCBhY2NvcmRpbmdseSBhcyB0dHkNCj4+IGFsaWFzZXMgaWQgaXMgcmV0cmlldmVkIHVzaW5nIG9m
X2FsaWFzX2dldF9pZChucCwgQVNDX1NFUklBTF9OQU1FKTsNCj4gDQo+IEFnYWluLCBjaGFuZ2lu
ZyB0aGUgdHR5IG5hbWUgYnJlYWtzIHVzZXJzcGFjZS4gWW91IGNhbid0IGRvIHRoYXQuDQo+IA0K
PiBZb3UgbmVlZCB0byBkbyBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdHR5L3NlcmlhbC9zdC1hc2MuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdC1hc2Mu
Yw0KPiBpbmRleCBjNzYzMjUzNTE0ZTkuLjVmOWYwMWZhYzZkZCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3N0LWFzYy5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zdC1h
c2MuYw0KPiBAQCAtNzgyLDcgKzc4Miw5IEBAIHN0YXRpYyBzdHJ1Y3QgYXNjX3BvcnQgKmFzY19v
Zl9nZXRfYXNjX3BvcnQoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAgICAg
ICAgaWYgKCFucCkNCj4gICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gDQo+IC0gICAg
ICAgaWQgPSBvZl9hbGlhc19nZXRfaWQobnAsIEFTQ19TRVJJQUxfTkFNRSk7DQo+ICsgICAgICAg
aWQgPSBvZl9hbGlhc19nZXRfaWQobnAsICJzZXJpYWwiKTsNCj4gKyAgICAgICBpZiAoaWQgPCAw
KQ0KPiArICAgICAgICAgICAgICAgaWQgPSBvZl9hbGlhc19nZXRfaWQobnAsIEFTQ19TRVJJQUxf
TkFNRSk7DQo+IA0KPiAgICAgICAgICBpZiAoaWQgPCAwKQ0KPiAgICAgICAgICAgICAgICAgIGlk
ID0gMDsNCj4gDQpJIHdpbGwgZml4IHRoaXMgdG9vDQoNClBhdHJpY2U=
