Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3594401-1519671434-2-36147367289385110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519671433; b=Yu1yJqqeBcCfw8aWIn9HXD4GBRtfDjKryStqSOwCYWtfVi+
    tAK1dyQq85UHCech5ERDomyDdJeO0dRtipYi7kFdEKezASA+EVxNiw6eiWY+FzvU
    a3UWAetO6pu/bM0eB5WsEowaUeVvl8iy86v5smXLrBtfBD2e59PVySWpmVCLsLXN
    Ar515oDVKbNuqpbeXHEFhUOCI+6c0xBFl6eD6o7XQF6PtLC81weYMDDYZ8k4re0H
    eXImTEjViCrkGv8tQrZyibvME6R/MKZFQYqiJI+dFQjFifSOfuH4T46LAVgW4el6
    dCTrT3mcmCNtLvkWctOD8K+6EPmUKK/ixR0z4Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519671433; bh=Hyu67VKlQLzRmnoMajmtfFV9Tds5sSdpEwjSoP1T3Tk=; b=a
    UWjwaodkLWRyS/w290BfPHIwxYDiETyXJ5r7fvl+TSG+adijAXJVY8zRxvi9GqOa
    e5Z59gYZicicVSV5H8ePZEZAKZBOyY1aSLnRzZFFEuv9o9WkOe5qBXyRcboJEesD
    /MxAD7hO9QQwBdAbRoR0bFA+0Zr/bX7CqO0bMR7UIHpPupmCHhWl4T/zelkVUZYq
    3O8ZxwEuuaVPUxqfyPwSIJ1FEPXbDza0OF40r6z1xZKaeIA/fL5OreDn6eT5RJki
    +F7uH7jgft3YkPoshuiRxFPMAHvQzh1MZTiAWA+LeoRJ2vwVsrJcasBy6q/NXqSV
    LKf2TE1QG/0pURcfZ4l8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=cHnP1dJ8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=pass (ADSP policy from amazon.de);
    dkim=pass (1024-bit rsa key sha256) header.d=amazon.de header.i=@amazon.de header.b=cHnP1dJ8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=amazon201209;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=amazon.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amazon.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeBZS5M (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 13:57:12 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:52844 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeBZS5L (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 13:57:11 -0500
X-IronPort-AV: E=Sophos;i="5.47,397,1515456000";
   d="scan'208";a="668427713"
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
Subject: Re: [PATCH 2/2] xen: events: free irqs in error condition
Thread-Topic: [PATCH 2/2] xen: events: free irqs in error condition
Thread-Index: AQHTryhftX/ngFa1ckq0OLhcNpkNRaO2/QOAgAAL2YA=
Date: Mon, 26 Feb 2018 18:57:03 +0000
Message-ID: <1519671423.4965.11.camel@amazon.com>
References: <1519666595-41362-1-git-send-email-aams@amazon.com>
         <1519666595-41362-3-git-send-email-aams@amazon.com>
         <20180226181439.zbdtzbv7wifjst2l@MacBook-Pro-de-Roger.local>
In-Reply-To: <20180226181439.zbdtzbv7wifjst2l@MacBook-Pro-de-Roger.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <69124275343F27459C35008ACEA0310B@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DQpPbiBNbywgMjAxOC0wMi0yNiBhdCAxODoxNCArMDAwMCwgUm9nZXIgUGF1IE1vbm7DqSB3cm90
ZToNCj4gT24gTW9uLCBGZWIgMjYsIDIwMTggYXQgMDU6MzY6MzVQTSArMDAwMCwgQW1pdCBTaGFo
IHdyb3RlOg0KPiA+IA0KPiA+IEluIGNhc2Ugb2YgZXJyb3JzIGluIGlycSBzZXR1cCBmb3IgTVNJ
LCBmcmVlIHVwIHRoZSBhbGxvY2F0ZWQgaXJxcy4NCj4gPiANCj4gPiBGaXhlczogNDg5MmM5YjRh
ZGE5ZjkgKCJ4ZW46IGFkZCBzdXBwb3J0IGZvciBNU0kgbWVzc2FnZSBncm91cHMiKQ0KPiA+IFJl
cG9ydGVkLWJ5OiBIb29tYW4gTWlyaGFkaSA8bWlyaGFkaWhAYW1hem9uLmNvbT4NCj4gPiBDQzog
PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gQ0M6IFJvZ2VyIFBhdSBNb25uw6kgPHJvZ2Vy
LnBhdUBjaXRyaXguY29tPg0KPiA+IENDOiBEYXZpZCBWcmFiZWwgPGRhdmlkLnZyYWJlbEBjaXRy
aXguY29tPg0KPiA+IENDOiBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNreUBvcmFjbGUu
Y29tPg0KPiA+IENDOiBFZHVhcmRvIFZhbGVudGluIDxlZHV2YWxAYW1hem9uLmNvbT4NCj4gPiBD
QzogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiA+IENDOiBUaG9tYXMgR2xlaXhu
ZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gPiBDQzogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNA
bWljcm9zb2Z0LmNvbT4NCj4gPiBDQzogTGl1IFNodW8gPHNodW8uYS5saXVAaW50ZWwuY29tPg0K
PiA+IENDOiBBbm9vYiBTb21hbiA8YW5vb2Iuc29tYW5AY2l0cml4LmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbWl0IFNoYWggPGFhbXNAYW1hem9uLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZl
cnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jIHwgMSArDQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy94ZW4vZXZlbnRz
L2V2ZW50c19iYXNlLmMNCj4gPiBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+
ID4gaW5kZXggYjZiOGIyOS4uOTZhYTU3NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3hlbi9l
dmVudHMvZXZlbnRzX2Jhc2UuYw0KPiA+ICsrKyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNf
YmFzZS5jDQo+ID4gQEAgLTc1OCw2ICs3NTgsNyBAQCBpbnQgeGVuX2JpbmRfcGlycV9tc2lfdG9f
aXJxKHN0cnVjdCBwY2lfZGV2DQo+ID4gKmRldiwgc3RydWN0IG1zaV9kZXNjICptc2lkZXNjLA0K
PiA+IMKgZXJyb3JfaXJxOg0KPiA+IMKgCWZvciAoOyBpID49IDA7IGktLSkNCj4gPiDCoAkJX191
bmJpbmRfZnJvbV9pcnEoaXJxICsgaSk7DQo+ID4gKwl4ZW5fZnJlZV9pcnEoaXJxKTsNCj4gSG0s
IHhlbl9mcmVlX2lycSBjYWxscyBpcnFfZnJlZV9kZXNjLCB3aGljaCBpcyBpcnFfZnJlZV9kZXNj
cyhpcnEsDQo+IDEpLA0KDQpFci4uLiDCoHJpZ2h0Lg0KDQo+IEkgdGhpbmsgeW91IHdpbGwgaGF2
ZSB0byBpbnRyb2R1Y2UgYSBuZXcgZnJlZSBmdW5jdGlvbjoNCj4gDQo+IHhlbl9mcmVlX2lycXMo
dW5zaWduZWQgaXJxLCB1bnNpZ25lZCBpbnQgbnIpDQo+IA0KPiBUaGF0IGNhbGxzIGlycV9mcmVl
X2Rlc2NzKGlycSwgbnIpDQoNCkFjdHVhbGx5LCB4ZW5fZnJlZV9pcnEoKSBpcyBhbHJlYWR5IGRv
bmUgaW4gX191bmJpbmRfZnJvbV9pcnEoKSwgc28NCnRoaXMgcGF0Y2ggaXMgYWN0dWFsbHkgd3Jv
bmcgYW5kIG5vdCBuZWVkZWQuDQoNCg0KCQkJCUFtaXQNCkFtYXpvbiBEZXZlbG9wbWVudCBDZW50
ZXIgR2VybWFueSBHbWJICkJlcmxpbiAtIERyZXNkZW4gLSBBYWNoZW4KbWFpbiBvZmZpY2U6IEty
YXVzZW5zdHIuIDM4LCAxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhyZXI6IERyLiBSYWxmIEhl
cmJyaWNoLCBDaHJpc3RpYW4gU2NobGFlZ2VyClVzdC1JRDogREUyODkyMzc4NzkKRWluZ2V0cmFn
ZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0OTE3MyBCCg==
