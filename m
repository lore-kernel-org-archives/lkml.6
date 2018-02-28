Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3813331-1519806334-2-9969280412451991716
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
    t=1519806333; b=b9OXNghk8IQaJ9S5KD24KwF+Ksg1u2ZewECQfQSKOCOasCr
    JO01VsDFB5KDWiJBxsJJyadFaYyjbX2Z69b9X+WJMZGC1UHvf4SD6H8wP5/gClGB
    R5p62occBLNzYI3iwcxHCcPvlXreR8pDCrVBwt7RgSX1HqhXUXHIGzIBPJgUCjCx
    JH+aZlrZ9xuybZXv6lJ+NRPhxMk3YnlUGQTqpi4jgDkAvJ79v7ItIFSFgbckpkLB
    2PPCHE4cpswFmuTGQ4oO9kQqlZ6MWqb1SHGMl0nWP2ri5rbZbWskAlcyXh0z5Ygk
    iH2pKAjCAFiBpS47dwZApXXdZziPWM+y//P7AVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519806333; bh=hRl9+xDDWgKmntM8jLjUISH/4t6jaokyayocGekygy0=; b=F
    wmsPc3t5J/7AwHOlPrTI49iD6bvjtzsGOx0E54zskJmxveDwmfIvMDHDCLPX6+d0
    uh6pROo1vFqCvuVehBWAA2YKHq79sk3hsw74LQbaAXyq6YBdoKJq/5BS0v1C/e5H
    Q2EodEkDerQyrfvR6Gyv768H4TqS362jflrgW3ZdY2NYxz8eJeWkGN61F77bWMP/
    7huRtcGwq3TF+bl6wG3cDatSJyAgujsONM2lbZ0CwKKvoVrZraQ2pCRwEXidXUkg
    5waOFOicWibpNjsxrh7H63wub6soVdaSU7EOcPilZtYS7lkvhs39V7k3obL/YZrt
    LqmZI0gr1Q7UvvgrN54DQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=hxSd5Rp8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=hxSd5Rp8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeB1IZc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 03:25:32 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55828 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeB1IZb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 03:25:31 -0500
X-IronPort-AV: E=Sophos;i="5.47,404,1515456000";
   d="scan'208";a="668648056"
From: "Shah, Amit" <aams@amazon.de>
To: "roger.pau@citrix.com" <roger.pau@citrix.com>
CC: "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "shuo.a.liu@intel.com" <shuo.a.liu@intel.com>,
        "anoob.soman@citrix.com" <anoob.soman@citrix.com>,
        "Valentin, Eduardo" <eduval@lab126.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 2/2] xen: events: free irqs in error condition
Thread-Topic: [PATCH v2 2/2] xen: events: free irqs in error condition
Thread-Index: AQHTr+N3ya6twxWFfkm0peLZmzunHKO4eysAgAAHDQCAAPbYgIAAAoQA
Date: Wed, 28 Feb 2018 08:25:23 +0000
Message-ID: <1519806324.4965.25.camel@amazon.com>
References: <1519746958-52077-1-git-send-email-aams@amazon.com>
         <1519746958-52077-3-git-send-email-aams@amazon.com>
         <20180227170740.jcaxsvpepsn6eot2@MacBook-Pro-de-Roger.local>
         <1519752774.4965.23.camel@amazon.com>
         <20180228081623.umnyv4w67h2rsrwk@MacBook-Pro-de-Roger.local>
In-Reply-To: <20180228081623.umnyv4w67h2rsrwk@MacBook-Pro-de-Roger.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE479E4A7C8A0B45BE6E00F788D21CE2@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQpPbiBNaSwgMjAxOC0wMi0yOCBhdCAwODoxNiArMDAwMCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90
ZToNCj4gT24gVHVlLCBGZWIgMjcsIDIwMTggYXQgMDU6MzI6NTNQTSArMDAwMCwgU2hhaCwgQW1p
dCB3cm90ZToNCj4gPiANCj4gPiANCj4gPiBPbiBEaSwgMjAxOC0wMi0yNyBhdCAxNzowNyArMDAw
MCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gT24gVHVlLCBGZWIgMjcs
IDIwMTggYXQgMDM6NTU6NThQTSArMDAwMCwgQW1pdCBTaGFoIHdyb3RlOg0KPiA+ID4gPiANCj4g
PiA+ID4gDQo+ID4gPiA+IEluIGNhc2Ugb2YgZXJyb3JzIGluIGlycSBzZXR1cCBmb3IgTVNJLCBm
cmVlIHVwIHRoZSBhbGxvY2F0ZWQNCj4gPiA+ID4gaXJxcy4NCj4gPiA+ID4gDQo+ID4gPiA+IEZp
eGVzOiA0ODkyYzliNGFkYTlmOSAoInhlbjogYWRkIHN1cHBvcnQgZm9yIE1TSSBtZXNzYWdlDQo+
ID4gPiA+IGdyb3VwcyIpDQo+ID4gPiA+IFJlcG9ydGVkLWJ5OiBIb29tYW4gTWlyaGFkaSA8bWly
aGFkaWhAYW1hem9uLmNvbT4NCj4gPiA+ID4gQ0M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0K
PiA+ID4gPiBDQzogUm9nZXIgUGF1IE1vbm7DqSA8cm9nZXIucGF1QGNpdHJpeC5jb20+DQo+ID4g
PiA+IENDOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPg0KPiA+
ID4gPiBDQzogRWR1YXJkbyBWYWxlbnRpbiA8ZWR1dmFsQGFtYXpvbi5jb20+DQo+ID4gPiA+IEND
OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+ID4gPiA+IENDOiBUaG9tYXMgR2xl
aXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiA+ID4gQ0M6ICJLLiBZLiBTcmluaXZhc2Fu
IiA8a3lzQG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IENDOiBMaXUgU2h1byA8c2h1by5hLmxpdUBp
bnRlbC5jb20+DQo+ID4gPiA+IENDOiBBbm9vYiBTb21hbiA8YW5vb2Iuc29tYW5AY2l0cml4LmNv
bT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBTaGFoIDxhYW1zQGFtYXpvbi5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiDCoGRyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jIHwg
NSArKysrLQ0KPiA+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3hlbi9ldmVu
dHMvZXZlbnRzX2Jhc2UuYw0KPiA+ID4gPiBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFz
ZS5jDQo+ID4gPiA+IGluZGV4IGM4NmQxMGUuLmEyOTk1ODYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBh
L2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
eGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+ID4gPiA+IEBAIC03NTAsMTEgKzc1MCwxNCBAQCBp
bnQgeGVuX2JpbmRfcGlycV9tc2lfdG9faXJxKHN0cnVjdA0KPiA+ID4gPiBwY2lfZGV2DQo+ID4g
PiA+ICpkZXYsIHN0cnVjdCBtc2lfZGVzYyAqbXNpZGVzYywNCj4gPiA+ID4gwqANCj4gPiA+ID4g
wqAJcmV0ID0gaXJxX3NldF9tc2lfZGVzYyhpcnEsIG1zaWRlc2MpOw0KPiA+ID4gPiDCoAlpZiAo
cmV0IDwgMCkNCj4gPiA+ID4gLQkJZ290byBlcnJvcl9pcnE7DQo+ID4gPiA+ICsJCWdvdG8gZXJy
b3JfZGVzYzsNCj4gPiA+ID4gwqBvdXQ6DQo+ID4gPiA+IMKgCW11dGV4X3VubG9jaygmaXJxX21h
cHBpbmdfdXBkYXRlX2xvY2spOw0KPiA+ID4gPiDCoAlyZXR1cm4gaXJxOw0KPiA+ID4gPiDCoGVy
cm9yX2lycToNCj4gPiA+ID4gKwl3aGlsZSAoLS1udmVjID49IGkpDQo+ID4gPiA+ICsJCXhlbl9m
cmVlX2lycShpcnEgKyBudmVjKTsNCj4gPiA+ID4gK2Vycm9yX2Rlc2M6DQo+ID4gPiA+IMKgCXdo
aWxlIChpID4gMCkgew0KPiA+ID4gPiDCoAkJaS0tOw0KPiA+ID4gPiDCoAkJX191bmJpbmRfZnJv
bV9pcnEoaXJxICsgaSk7DQo+ID4gPiBJdCBzZWVtcyBwb2ludGxlc3MgdG8gaW50cm9kdWNlIGFu
b3RoZXIgbGFiZWwgYW5kIGFub3RoZXIgbG9vcCB0bw0KPiA+ID4gZml4DQo+ID4gPiBzb21ldGhp
bmcgdGhhdCBjYW4gYmUgZml4ZWQgd2l0aCBhIHNpbmdsZSBsYWJlbCBhbmQgYSBzaW5nbGUNCj4g
PiA+IGxvb3AsDQo+ID4gPiB0aGlzIGp1c3QgbWFrZXMgdGhlIGNvZGUgbW9yZSBjb21wbGV4IGZv
ciBubyByZWFzb24uDQo+ID4gSSBkaXNhZ3JlZSwganVzdCBiZWNhdXNlIHRoZXJlIGFyZSB0d28g
ZGlmZmVyZW50IGNsZWFudXBzIHRvIGJlDQo+ID4gbWFkZQ0KPiA+IGZvciB0d28gZGlmZmVyZW50
IGlzc3VlczsgaXQncyBub3QgYXMgaWYgdGhlIGlmLi4gYW5kIGVsc2UNCj4gPiBjb25kaXRpb25z
DQo+ID4gYXJlIGdvaW5nIHRvIGJlIGludGVybGVhdmVkLg0KPiBPaCwgSSBkb24ndCBtaW5kIHNv
IG11Y2ggd2hldGhlciBpdCBlbmRzIHVwIGJlaW5nIHR3byBwYXRjaGVzIG9yIGENCj4gc2luZ2xl
IG9uZSwgYnV0IElNSE8gdGhlIGNvZGUgc2hvdWxkIGVuZCB1cCBsb29raW5nIHNpbWlsYXIgdG8g
d2hhdCBJDQo+IHByb3Bvc2VkLCBJIHdvdWxkIGxpa2UgdG8gYXZvaWQgaGF2aW5nIHR3byBsb29w
cyBhbmQgdHdvIGxhYmVscy4NCj4gDQo+IENvdWxkIHlvdSByZXdvcmsgdGhlIHNlcmllcyBzbyB0
aGF0IHRoZSBlbmQgcmVzdWx0IHVzZXMgYSBzaW5nbGUgbG9vcA0KPiAoYW5kIGxhYmVsKT8NCg0K
VGhhdCB3YXMgdGhlIHBhcnQgSSBkaWRuJ3QgbGlrZSBtdWNoLCBzbyBpdCB3b3VsZCBiZSBiZXR0
ZXIgaWYgdGhlDQpwYXRjaCBjYW1lIGZyb20geW91IDopDQoNCgkJCQlBbWl0DQoNCkFtYXpvbiBE
ZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4K
bWFpbiBvZmZpY2U6IEtyYXVzZW5zdHIuIDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhy
ZXI6IERyLiBSYWxmIEhlcmJyaWNoLCBDaHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUyODky
Mzc4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3
MyBCCg==
