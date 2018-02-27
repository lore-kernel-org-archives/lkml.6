Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1809615-1519746372-2-10752835291766050583
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
    t=1519746371; b=ih9WIoP2RpNwRGtOdh+BssuToJh5CONknrZi4AtMipdb05M
    iLok54n/OIfUaAt3dzTDmApXiWS5DybwEWSrkpuFlKZcDMLOVVnzafExquwFvuJn
    UyWa1N9/xe+zCeY2as96hGdScr5Oc/tIifbIQNBN6ufFslKokvnbY4kllmYauvGH
    tzjoSmQconkPMusIRMgXruMZMn4N2uJDNXvDlwZl/J0BzcmA5NWzQj4igP7BoSE2
    pdXVyVh0O9jFerHXe6VJak3RYWTSFR3T96f8IwTwl6HPOOj9sII/RX/zvPQtDAXE
    8fl04nCsomOGI9Sk5mhu0xOn8yQ80RAUweKErrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519746371; bh=CfKHPJ2+ZkYGBTXxRIAoAWZCM/O5TF3TzDwTMwDnq/s=; b=b
    B/3S7RzmMhuWK7WUnhY2sTexk+vhQexaMVi4vg/q7XNR8CHBqtZlJbIk99X6I4o8
    MVZs9jhOE/b3yh6nJ8NhcZJzQ5MziOLoLRf2S9Jnw+rcgFrSCbdvMJNHzTu+BpBP
    AplsCeokm+rMI099f7K+mYYrUz77KkL1Dh9nHmiupL2FK5XFV/jMtj5PVf58FLl8
    sAnE9Y0VuUqKjAiHCFZ3wq42b5GA9fqWqbP0IHoddoIjJm+tZSnXn4XQN+Wv70up
    Wo54oIDV8aE5ebJQrBIUWVTvtRYSpZRcPHYx3TpinPcLrJBsp/XMTPNbgSplyFMS
    vdeeaIeDX339N73g/totw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=gdiK18LF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=gdiK18LF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753940AbeB0PqI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 10:46:08 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:24438 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753780AbeB0PqH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 10:46:07 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515456000";
   d="scan'208";a="333626872"
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
Subject: Re: [PATCH 2/2] xen: events: free irqs in error condition
Thread-Topic: [PATCH 2/2] xen: events: free irqs in error condition
Thread-Index: AQHTryhftX/ngFa1ckq0OLhcNpkNRaO2/QOAgAAL2YCAAN7DgIAAfjEA
Date: Tue, 27 Feb 2018 15:46:00 +0000
Message-ID: <1519746360.4965.21.camel@amazon.com>
References: <1519666595-41362-1-git-send-email-aams@amazon.com>
         <1519666595-41362-3-git-send-email-aams@amazon.com>
         <20180226181439.zbdtzbv7wifjst2l@MacBook-Pro-de-Roger.local>
         <1519671423.4965.11.camel@amazon.com>
         <20180227081421.i2x3vcw6imrreshv@MacBook-Pro-de-Roger.local>
In-Reply-To: <20180227081421.i2x3vcw6imrreshv@MacBook-Pro-de-Roger.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9B6C1F184DC7B4DAFB477ECDA389351@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQoNCk9uIERpLCAyMDE4LTAyLTI3IGF0IDA4OjE0ICswMDAwLCBSb2dlciBQYXUgTW9ubsOpIHdy
b3RlOg0KPiBPbiBNb24sIEZlYiAyNiwgMjAxOCBhdCAwNjo1NzowM1BNICswMDAwLCBTaGFoLCBB
bWl0IHdyb3RlOg0KPiA+IA0KPiA+IA0KPiA+IE9uIE1vLCAyMDE4LTAyLTI2IGF0IDE4OjE0ICsw
MDAwLCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBNb24sIEZlYiAy
NiwgMjAxOCBhdCAwNTozNjozNVBNICswMDAwLCBBbWl0IFNoYWggd3JvdGU6DQo+ID4gPiA+IA0K
PiA+ID4gPiANCj4gPiA+ID4gSW4gY2FzZSBvZiBlcnJvcnMgaW4gaXJxIHNldHVwIGZvciBNU0ks
IGZyZWUgdXAgdGhlIGFsbG9jYXRlZA0KPiA+ID4gPiBpcnFzLg0KPiA+ID4gPiANCj4gPiA+ID4g
Rml4ZXM6IDQ4OTJjOWI0YWRhOWY5ICgieGVuOiBhZGQgc3VwcG9ydCBmb3IgTVNJIG1lc3NhZ2UN
Cj4gPiA+ID4gZ3JvdXBzIikNCj4gPiA+ID4gUmVwb3J0ZWQtYnk6IEhvb21hbiBNaXJoYWRpIDxt
aXJoYWRpaEBhbWF6b24uY29tPg0KPiA+ID4gPiBDQzogPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+
DQo+ID4gPiA+IENDOiBSb2dlciBQYXUgTW9ubsOpIDxyb2dlci5wYXVAY2l0cml4LmNvbT4NCj4g
PiA+ID4gQ0M6IERhdmlkIFZyYWJlbCA8ZGF2aWQudnJhYmVsQGNpdHJpeC5jb20+DQo+ID4gPiA+
IENDOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUuY29tPg0KPiA+ID4g
PiBDQzogRWR1YXJkbyBWYWxlbnRpbiA8ZWR1dmFsQGFtYXpvbi5jb20+DQo+ID4gPiA+IENDOiBK
dWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+ID4gPiA+IENDOiBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiA+ID4gQ0M6ICJLLiBZLiBTcmluaXZhc2FuIiA8
a3lzQG1pY3Jvc29mdC5jb20+DQo+ID4gPiA+IENDOiBMaXUgU2h1byA8c2h1by5hLmxpdUBpbnRl
bC5jb20+DQo+ID4gPiA+IENDOiBBbm9vYiBTb21hbiA8YW5vb2Iuc29tYW5AY2l0cml4LmNvbT4N
Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBTaGFoIDxhYW1zQGFtYXpvbi5jb20+DQo+ID4g
PiA+IC0tLQ0KPiA+ID4gPiDCoGRyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jIHwgMSAr
DQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPiA+IA0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMNCj4gPiA+
ID4gYi9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPiA+ID4gPiBpbmRleCBiNmI4
YjI5Li45NmFhNTc1IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3hlbi9ldmVudHMvZXZl
bnRzX2Jhc2UuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2Uu
Yw0KPiA+ID4gPiBAQCAtNzU4LDYgKzc1OCw3IEBAIGludCB4ZW5fYmluZF9waXJxX21zaV90b19p
cnEoc3RydWN0IHBjaV9kZXYNCj4gPiA+ID4gKmRldiwgc3RydWN0IG1zaV9kZXNjICptc2lkZXNj
LA0KPiA+ID4gPiDCoGVycm9yX2lycToNCj4gPiA+ID4gwqAJZm9yICg7IGkgPj0gMDsgaS0tKQ0K
PiA+ID4gPiDCoAkJX191bmJpbmRfZnJvbV9pcnEoaXJxICsgaSk7DQo+ID4gPiA+ICsJeGVuX2Zy
ZWVfaXJxKGlycSk7DQo+ID4gPiBIbSwgeGVuX2ZyZWVfaXJxIGNhbGxzIGlycV9mcmVlX2Rlc2Ms
IHdoaWNoIGlzDQo+ID4gPiBpcnFfZnJlZV9kZXNjcyhpcnEsDQo+ID4gPiAxKSwNCj4gPiBFci4u
LiDCoHJpZ2h0Lg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHlvdSB3aWxsIGhhdmUgdG8g
aW50cm9kdWNlIGEgbmV3IGZyZWUgZnVuY3Rpb246DQo+ID4gPiANCj4gPiA+IHhlbl9mcmVlX2ly
cXModW5zaWduZWQgaXJxLCB1bnNpZ25lZCBpbnQgbnIpDQo+ID4gPiANCj4gPiA+IFRoYXQgY2Fs
bHMgaXJxX2ZyZWVfZGVzY3MoaXJxLCBucikNCj4gPiBBY3R1YWxseSwgeGVuX2ZyZWVfaXJxKCkg
aXMgYWxyZWFkeSBkb25lIGluIF9fdW5iaW5kX2Zyb21faXJxKCksIHNvDQo+ID4gdGhpcyBwYXRj
aCBpcyBhY3R1YWxseSB3cm9uZyBhbmQgbm90IG5lZWRlZC4NCj4gWW91IHN0aWxsIG5lZWQgdG8g
ZnJlZSB1bmJvdW5kIElSUXMsIEFGQUlDVCB5b3UgY291bGQgZml4IHRoZSBpc3N1ZQ0KPiB3aXRo
IGEgc2luZ2xlIHBhdGNoLCBsaWtlOg0KPiANCj4gd2hpbGUgKG52ZWMtLSkgew0KPiAJaWYgKG52
ZWMgPj0gaSkNCj4gCQl4ZW5fZnJlZV9pcnEoaXJxICsgaSk7DQo+IAllbHNlDQo+IAkJX191bmJp
bmRfZnJvbV9pcnEoaXJxICsgaSk7DQo+IH0NCg0KQWdyZWVkLg0KDQpIb3dldmVyLCBzaW5jZSB0
aGVzZSBhcmUgdHdvIGRpZmZlcmVudCB0aGluZ3MsIEknZCBzdGlsbCBsaWtlIHRvDQpzZXBhcmF0
ZSBvdXQgaW50byB0d28gcGF0Y2hlcywgYW5kIHR3byBwYXRocyBzbyBpdCdzIGVhc2llciB0byBz
ZWUNCndoYXQncyBiZWluZyBkb25lLg0KDQpTZW5kaW5nIHYyIGluIGEgYml0Lg0KDQrCoCDCoCBB
bWl0DQoNCg0KQW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKQmVybGluIC0g
RHJlc2RlbiAtIEFhY2hlbgptYWluIG9mZmljZTogS3JhdXNlbnN0ci4gMzgsIDEwMTE3IEJlcmxp
bgpHZXNjaGFlZnRzZnVlaHJlcjogRHIuIFJhbGYgSGVyYnJpY2gsIENocmlzdGlhbiBTY2hsYWVn
ZXIKVXN0LUlEOiBERTI4OTIzNzg3OQpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90
dGVuYnVyZyBIUkIgMTQ5MTczIEIK
