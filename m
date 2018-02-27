Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519752783-2-10598223771422353595
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
    t=1519752782; b=ZBeC8OaNS8YslazBkHWm02LP5kX2eTqvv7gRfvu8AMDiipa
    xnG7IuGglh1QDQqYxp5XCR5wD3PPgVTjK8Uv4QjdzB+hpRDgD6Dv4xM6ZIoUxvc4
    H9bfy+/1KOzFH0MBxkD/hXR/1HPPSwglzhSXdJ8aSSng6gJyjOxy24iBEbYtly6K
    qdZOos57EyJpHgxWhFEXgdUdZulAcj8TXci6nVEe4ojLl493a08FKRhBpw5z878g
    lfP6aUDf8emPZ4wsQ3aDZN+Jun7ihKKIdNa3AQuTcywdRHwS7B6hRJVWoEPpzlKm
    NPfCgDXan7v5QcWxtWyqn3awQJnoNjpDDmKC+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519752782; bh=2R/tXzK1c0NPAJ2jRDSi5jcO3pd8Liwj1g2JgsyJaOg=; b=k
    6rYjuEhQePfxRiBJ4s4a1f/XBW6ka7kSaFSzW4sfM64iAmozSojUP2VtkC2TSkqT
    ixzDBJBMVXfgmvJVNJnHpIBD09X+BAERspsBZlg30ZfXQl03Y+sufCvUibCZ1gpI
    sAeeYonNN4JHRgCIhBwN8ZUAbCiID6ueIifQ4bswZh/1IaZhMGdvLCtPRAxdsuh3
    2ot0VfHN6fbjBL7y5i2QFoNWMRrIM3l7ItZJvSeEftqIAOSmvO2ZBWw6Z0TxoRXv
    6zzeeYDrFQulo6O9dMXcs/WkuYHfH6YeWqdbM5ll+hKFomwdMLGB4IUXZPLoKQVw
    pgYSWBQq/GV3Ri30b24Yg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=C5ZxWT16 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=C5ZxWT16 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeB0RdB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:33:01 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:53709 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeB0RdA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 12:33:00 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515456000";
   d="scan'208";a="333705625"
From: "Shah, Amit" <aams@amazon.de>
To: "roger.pau@citrix.com" <roger.pau@citrix.com>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "Valentin, Eduardo" <eduval@lab126.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "shuo.a.liu@intel.com" <shuo.a.liu@intel.com>,
        "anoob.soman@citrix.com" <anoob.soman@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 2/2] xen: events: free irqs in error condition
Thread-Topic: [PATCH v2 2/2] xen: events: free irqs in error condition
Thread-Index: AQHTr+N3ya6twxWFfkm0peLZmzunHKO4eysAgAAHDQA=
Date: Tue, 27 Feb 2018 17:32:53 +0000
Message-ID: <1519752774.4965.23.camel@amazon.com>
References: <1519746958-52077-1-git-send-email-aams@amazon.com>
         <1519746958-52077-3-git-send-email-aams@amazon.com>
         <20180227170740.jcaxsvpepsn6eot2@MacBook-Pro-de-Roger.local>
In-Reply-To: <20180227170740.jcaxsvpepsn6eot2@MacBook-Pro-de-Roger.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.199]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE85F60956298047AE4E75EFBE557198@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQpPbiBEaSwgMjAxOC0wMi0yNyBhdCAxNzowNyArMDAwMCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90
ZToNCj4gT24gVHVlLCBGZWIgMjcsIDIwMTggYXQgMDM6NTU6NThQTSArMDAwMCwgQW1pdCBTaGFo
IHdyb3RlOg0KPiA+IA0KPiA+IEluIGNhc2Ugb2YgZXJyb3JzIGluIGlycSBzZXR1cCBmb3IgTVNJ
LCBmcmVlIHVwIHRoZSBhbGxvY2F0ZWQgaXJxcy4NCj4gPiANCj4gPiBGaXhlczogNDg5MmM5YjRh
ZGE5ZjkgKCJ4ZW46IGFkZCBzdXBwb3J0IGZvciBNU0kgbWVzc2FnZSBncm91cHMiKQ0KPiA+IFJl
cG9ydGVkLWJ5OiBIb29tYW4gTWlyaGFkaSA8bWlyaGFkaWhAYW1hem9uLmNvbT4NCj4gPiBDQzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gQ0M6IFJvZ2VyIFBhdSBNb25uw6kgPHJvZ2Vy
LnBhdUBjaXRyaXguY29tPg0KPiA+IENDOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNr
eUBvcmFjbGUuY29tPg0KPiA+IENDOiBFZHVhcmRvIFZhbGVudGluIDxlZHV2YWxAYW1hem9uLmNv
bT4NCj4gPiBDQzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiA+IENDOiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiBDQzogIksuIFkuIFNyaW5pdmFz
YW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gPiBDQzogTGl1IFNodW8gPHNodW8uYS5saXVAaW50
ZWwuY29tPg0KPiA+IENDOiBBbm9vYiBTb21hbiA8YW5vb2Iuc29tYW5AY2l0cml4LmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbWl0IFNoYWggPGFhbXNAYW1hem9uLmNvbT4NCj4gPiAtLS0NCj4g
PiDCoGRyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jIHwgNSArKysrLQ0KPiA+IMKgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPiA+IGIvZHJpdmVy
cy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gPiBpbmRleCBjODZkMTBlLi5hMjk5NTg2IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+ID4gKysr
IGIvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gPiBAQCAtNzUwLDExICs3NTAs
MTQgQEAgaW50IHhlbl9iaW5kX3BpcnFfbXNpX3RvX2lycShzdHJ1Y3QgcGNpX2Rldg0KPiA+ICpk
ZXYsIHN0cnVjdCBtc2lfZGVzYyAqbXNpZGVzYywNCj4gPiDCoA0KPiA+IMKgCXJldCA9IGlycV9z
ZXRfbXNpX2Rlc2MoaXJxLCBtc2lkZXNjKTsNCj4gPiDCoAlpZiAocmV0IDwgMCkNCj4gPiAtCQln
b3RvIGVycm9yX2lycTsNCj4gPiArCQlnb3RvIGVycm9yX2Rlc2M7DQo+ID4gwqBvdXQ6DQo+ID4g
wqAJbXV0ZXhfdW5sb2NrKCZpcnFfbWFwcGluZ191cGRhdGVfbG9jayk7DQo+ID4gwqAJcmV0dXJu
IGlycTsNCj4gPiDCoGVycm9yX2lycToNCj4gPiArCXdoaWxlICgtLW52ZWMgPj0gaSkNCj4gPiAr
CQl4ZW5fZnJlZV9pcnEoaXJxICsgbnZlYyk7DQo+ID4gK2Vycm9yX2Rlc2M6DQo+ID4gwqAJd2hp
bGUgKGkgPiAwKSB7DQo+ID4gwqAJCWktLTsNCj4gPiDCoAkJX191bmJpbmRfZnJvbV9pcnEoaXJx
ICsgaSk7DQo+IEl0IHNlZW1zIHBvaW50bGVzcyB0byBpbnRyb2R1Y2UgYW5vdGhlciBsYWJlbCBh
bmQgYW5vdGhlciBsb29wIHRvIGZpeA0KPiBzb21ldGhpbmcgdGhhdCBjYW4gYmUgZml4ZWQgd2l0
aCBhIHNpbmdsZSBsYWJlbCBhbmQgYSBzaW5nbGUgbG9vcCwNCj4gdGhpcyBqdXN0IG1ha2VzIHRo
ZSBjb2RlIG1vcmUgY29tcGxleCBmb3Igbm8gcmVhc29uLg0KDQpJIGRpc2FncmVlLCBqdXN0IGJl
Y2F1c2UgdGhlcmUgYXJlIHR3byBkaWZmZXJlbnQgY2xlYW51cHMgdG8gYmUgbWFkZQ0KZm9yIHR3
byBkaWZmZXJlbnQgaXNzdWVzOyBpdCdzIG5vdCBhcyBpZiB0aGUgaWYuLiBhbmQgZWxzZSBjb25k
aXRpb25zDQphcmUgZ29pbmcgdG8gYmUgaW50ZXJsZWF2ZWQuDQoNCkFueXdheSBpdCdzIGEgbWF0
dGVyIG9mIHRhc3RlLg0KDQpTaW5jZSB5b3UndmUgYWxyZWFkeSBwcm9wb3NlZCB0aGUgcGF0Y2gs
IHdvdWxkIHlvdSBtaW5kIGJha2luZyBhIHByb3Blcg0Kb25lIGFuZCBwb3N0aW5nIGl0Pw0KDQpU
aGFua3MhDQoNCg0KPiBJTUhPIHRoZSB3YXkgdG8gc29sdmUgdGhpcyBpc3N1ZSBpczoNCj4gDQo+
IHdoaWxlIChudmVjLS0pIHsNCj4gCWlmIChudmVjID49IGkpDQo+IAkJeGVuX2ZyZWVfaXJxKGly
cSArIG52ZWMpOw0KPiAJZWxzZQ0KPiAJCV9fdW5iaW5kX2Zyb21faXJxKGlycSArIG52ZWMpOw0K
PiB9DQoNCgkJCQlBbWl0DQoNCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJI
CkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAx
MDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3Rp
YW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmlj
aHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
