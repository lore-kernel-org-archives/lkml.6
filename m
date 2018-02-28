Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3911302-1519809779-2-9534550321463954572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519809779; b=qgtsvgsLPNDyM88T11E6YExWkx3PNa/bHaQzCAiFheUJSWc
    8ZqX7PkbegKqcSaO+5TwqJcgmcex0QNRF025oixzlM5FEp4FU4mYIUySn+NZnNYy
    Gfkpa7BR/+ziIOPy/1+r2Hy3zjjljTJY7sr4N65+Iou7JnpNTswNIiytgX0XQskV
    L1g5cN6/nmXRYkcoe+78wcgY4ktIGPQX9YqcOSzK1Qo76d/K+GPqb1aUjXkNu2sr
    U3nXijKK91GlAc4XpG+4o+5XZyyYznI0lUrfkBSoC11gXcQAbgp+0C3Y8OR5i5QI
    AE6i1mwaemyHiRuN+8GWrZqjGJsiJmig2BbgkRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519809779; bh=RulZEfJpNjuoliVuXeHKfgLeXpfCUK8TAL6wZOaZy70=; b=c
    z4wIT8CZK7uCluTXcJv1ooGq4MgSXqy4OBifvm7ZlsNXNnZlqoZDBoo4s2VpZ4cL
    VRe+yidH01a57+K2dod0fEXqsAN6oi4yNbDYcRKsr01J/v+C/cp/Sds9LJDL8pgt
    hXZQhMygt3zpmzI3EnH4lQqv63hvzP2t1/o2vvyn9uHHez8BveL+nqkUPkxL+e6x
    4Q/s241trbjH9mj864KtGk6MLwHAq3A+BE72ySw6GaCi61xYYv97eXzItVqnSWP1
    XQFBtTJzF6TyszLtXwdVD2z8/YIJDuivBjQ9zeV7w5vNk0bF8nVol6mXTvNCfYaB
    pWC32GeXRnaadWyMO6j2g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=udWFa6wU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=udWFa6wU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbeB1JW5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 04:22:57 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:54148 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB1JWz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 04:22:55 -0500
X-IronPort-AV: E=Sophos;i="5.47,405,1515456000";
   d="scan'208";a="721989505"
From: "Shah, Amit" <aams@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] xen/pirq: fix error path cleanup when binding MSIs
Thread-Topic: [PATCH] xen/pirq: fix error path cleanup when binding MSIs
Thread-Index: AQHTsHU0jwsHO2BVC0WoTlOJqSC8JKO5inyA
Date: Wed, 28 Feb 2018 09:22:49 +0000
Message-ID: <1519809769.4965.26.camel@amazon.com>
References: <20180228091903.99889-1-roger.pau@citrix.com>
In-Reply-To: <20180228091903.99889-1-roger.pau@citrix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <326AC77F9113494DB6652194181A8839@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQpPbiBNaSwgMjAxOC0wMi0yOCBhdCAwOToxOSArMDAwMCwgUm9nZXIgUGF1IE1vbm5lIHdyb3Rl
Og0KPiBDdXJyZW50IGNsZWFudXAgaW4gdGhlIGVycm9yIHBhdGggb2YgeGVuX2JpbmRfcGlycV9t
c2lfdG9faXJxIGlzDQo+IHdyb25nLiBGaXJzdCBvZiBhbGwgdGhlcmUncyBhbiBvZmYtYnktb25l
IGluIHRoZSBjbGVhbnVwIGxvb3AsIHdoaWNoDQo+IGNhbiBsZWFkIHRvIHVuYmluZGluZyB3cm9u
ZyBJUlFzLg0KPiANCj4gU2Vjb25kbHkgSVJRcyBub3QgYm91bmQgd29uJ3QgYmUgZnJlZWQsIHRo
dXMgbGVha2luZyBJUlEgbnVtYmVycy4NCj4gDQo+IE5vdGUgdGhhdCB0aGVyZSdzIG5vIG5lZWQg
dG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIGJvdW5kIGFuZCB1bmJvdW5kDQo+IElSUXMgd2hlbiBm
cmVlaW5nIHRoZW0sIF9fdW5iaW5kX2Zyb21faXJxIHdpbGwgZGVhbCB3aXRoIGJvdGggb2YgdGhl
bQ0KPiBjb3JyZWN0bHkuDQo+IA0KPiBGaXhlczogNDg5MmM5YjRhZGE5ZjkgKCJ4ZW46IGFkZCBz
dXBwb3J0IGZvciBNU0kgbWVzc2FnZSBncm91cHMiKQ0KPiBSZXBvcnRlZC1ieTogSG9vbWFuIE1p
cmhhZGkgPG1pcmhhZGloQGFtYXpvbi5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFJvZ2VyIFBhdSBN
b25uw6kgPHJvZ2VyLnBhdUBjaXRyaXguY29tPg0KPiAtLS0NCj4gQ2M6IEJvcmlzIE9zdHJvdnNr
eSA8Ym9yaXMub3N0cm92c2t5QG9yYWNsZS5jb20+DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IENjOiBBbWl0IFNoYWggPGFhbXNAYW1hem9uLmNvbT4NCj4gQ0M6IHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IHhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9y
Zw0KPiAtLS0NCj4gwqBkcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyB8IDQgKystLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gYi9kcml2
ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPiBpbmRleCBiMjQxYmZhNTI5Y2UuLjE1OWZh
ZjEyNjlmYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMN
Cj4gKysrIGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gQEAgLTc2Myw4ICs3
NjMsOCBAQCBpbnQgeGVuX2JpbmRfcGlycV9tc2lfdG9faXJxKHN0cnVjdCBwY2lfZGV2ICpkZXYs
DQo+IHN0cnVjdCBtc2lfZGVzYyAqbXNpZGVzYywNCj4gwqAJbXV0ZXhfdW5sb2NrKCZpcnFfbWFw
cGluZ191cGRhdGVfbG9jayk7DQo+IMKgCXJldHVybiBpcnE7DQo+IMKgZXJyb3JfaXJxOg0KPiAt
CWZvciAoOyBpID49IDA7IGktLSkNCj4gLQkJX191bmJpbmRfZnJvbV9pcnEoaXJxICsgaSk7DQo+
ICsJd2hpbGUgKG52ZWMtLSkNCj4gKwkJX191bmJpbmRfZnJvbV9pcnEoaXJxICsgbnZlYyk7DQo+
IMKgCW11dGV4X3VubG9jaygmaXJxX21hcHBpbmdfdXBkYXRlX2xvY2spOw0KPiDCoAlyZXR1cm4g
cmV0Ow0KPiDCoH0NCg0KUmV2aWV3ZWQtYnk6IEFtaXQgU2hhaCA8YWFtc0BhbWF6b24uY29tPg0K
DQoNCgkJCQlBbWl0DQoNCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkJl
cmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAxMDEx
NyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4g
U2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQg
Q2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
