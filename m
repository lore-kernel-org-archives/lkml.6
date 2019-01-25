Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC4C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428732087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="ehYsEp52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfAYS27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:28:59 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:56243 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfAYS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1548440938; x=1579976938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=anbKUE4unBMH/gCuZYEMPsE0/w0pPj8cB2+DdwpgBrI=;
  b=ehYsEp52v8CjbGmVRlEKrDuuUD6qj1Yi1ZBL7OvOyBhpHeg4YWV656h0
   UeClzWrfuvvRVbm+02erwPgWg7rV7hmu6hTb8sIwzL23P+3me2akRX5Dm
   rst6TTUNAH4qiwZ2vemq8NHOPiypos1XGPBrHPpkNa5Cedwz+y6D505VL
   o=;
X-IronPort-AV: E=Sophos;i="5.56,522,1539648000"; 
   d="scan'208";a="383578747"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 25 Jan 2019 18:28:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x0PIStla039079
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 25 Jan 2019 18:28:56 GMT
Received: from EX13D01EUB004.ant.amazon.com (10.43.166.180) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:28:54 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB004.ant.amazon.com (10.43.166.180) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 25 Jan 2019 18:28:54 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Fri, 25 Jan 2019 18:28:53 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH v5 00/13] KVM/X86: Introduce a new guest mapping interface
Thread-Topic: [PATCH v5 00/13] KVM/X86: Introduce a new guest mapping
 interface
Thread-Index: AQHUp/+dPJ/o/42K00OzVQHcAWMqaaW9P5GAgAMoFAA=
Date:   Fri, 25 Jan 2019 18:28:52 +0000
Message-ID: <1548440932.17444.29.camel@amazon.de>
References: <1547026933-31226-1-git-send-email-karahmed@amazon.de>
         <20190123181636.GR19289@Konrads-MacBook-Pro.local>
In-Reply-To: <20190123181636.GR19289@Konrads-MacBook-Pro.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.122]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF81D82EA4F2FE43A209453F5F8BADAC@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAxLTIzIGF0IDEzOjE2IC0wNTAwLCBLb25yYWQgUnplc3p1dGVrIFdpbGsg
d3JvdGU6DQo+IE9uIFdlZCwgSmFuIDA5LCAyMDE5IGF0IDEwOjQyOjAwQU0gKzAxMDAsIEthcmlt
QWxsYWggQWhtZWQgd3JvdGU6DQo+ID4gDQo+ID4gR3Vlc3QgbWVtb3J5IGNhbiBlaXRoZXIgYmUg
ZGlyZWN0bHkgbWFuYWdlZCBieSB0aGUga2VybmVsIChpLmUuIGhhdmUgYSAic3RydWN0DQo+ID4g
cGFnZSIpIG9yIHRoZXkgY2FuIHNpbXBseSBsaXZlIG91dHNpZGUga2VybmVsIGNvbnRyb2wgKGku
ZS4gZG8gbm90IGhhdmUgYQ0KPiA+ICJzdHJ1Y3QgcGFnZSIpLiBLVk0gbW9zdGx5IHN1cHBvcnQg
dGhlc2UgdHdvIG1vZGVzLCBleGNlcHQgaW4gYSBmZXcgcGxhY2VzDQo+ID4gd2hlcmUgdGhlIGNv
ZGUgc2VlbXMgdG8gYXNzdW1lIHRoYXQgZ3Vlc3QgbWVtb3J5IG11c3QgaGF2ZSBhICJzdHJ1Y3Qg
cGFnZSIuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaHNldCBpbnRyb2R1Y2VzIGEgbmV3IG1hcHBpbmcg
aW50ZXJmYWNlIHRvIG1hcCBndWVzdCBtZW1vcnkgaW50byBob3N0DQo+ID4ga2VybmVsIG1lbW9y
eSB3aGljaCBhbHNvIHN1cHBvcnRzIFBGTi1iYXNlZCBtZW1vcnkgKGkuZS4gbWVtb3J5IHdpdGhv
dXQgJ3N0cnVjdA0KPiA+IHBhZ2UnKS4gSXQgYWxzbyBjb252ZXJ0cyBhbGwgb2ZmZW5kaW5nIGNv
ZGUgdG8gdGhpcyBpbnRlcmZhY2Ugb3Igc2ltcGx5DQo+ID4gcmVhZC93cml0ZSBkaXJlY3RseSBm
cm9tIGd1ZXN0IG1lbW9yeS4gUGF0Y2ggMiBpcyBhZGRpdGlvbmFsbHkgZml4aW5nIGFuDQo+ID4g
aW5jb3JyZWN0IHBhZ2UgcmVsZWFzZSBhbmQgbWFya2luZyB0aGUgcGFnZSBhcyBkaXJ0eSAoaS5l
LiBhcyBhIHNpZGUtZWZmZWN0IG9mDQo+ID4gdXNpbmcgdGhlIGhlbHBlciBmdW5jdGlvbiB0byB3
cml0ZSkuDQo+ID4gDQo+ID4gQXMgZmFyIGFzIEkgY2FuIHNlZSBhbGwgb2ZmZW5kaW5nIGNvZGUg
aXMgbm93IGZpeGVkIGV4Y2VwdCB0aGUgQVBJQy1hY2Nlc3MgcGFnZQ0KPiA+IHdoaWNoIEkgd2ls
bCBoYW5kbGUgaW4gYSBzZXBlcmF0ZSBzZXJpZXMgYWxvbmcgd2l0aCBkcm9wcGluZw0KPiA+IGt2
bV92Y3B1X2dmbl90b19wYWdlIGFuZCBrdm1fdmNwdV9ncGFfdG9fcGFnZSBmcm9tIHRoZSBpbnRl
cm5hbCBLVk0gQVBJLg0KPiA+IA0KPiA+IFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uIG9mIHRo
ZSBuZXcgQVBJIHVzZXMgbWVtcmVtYXAgdG8gbWFwIG1lbW9yeSB0aGF0IGRvZXMNCj4gPiBub3Qg
aGF2ZSBhICJzdHJ1Y3QgcGFnZSIuIFRoaXMgcHJvdmVzIHRvIGJlIHZlcnkgc2xvdyBmb3IgaGln
aCBmcmVxdWVuY3kNCj4gPiBtYXBwaW5ncy4gU2luY2UgdGhpcyBkb2VzIG5vdCBhZmZlY3QgdGhl
IG5vcm1hbCB1c2UtY2FzZSB3aGVyZSBhICJzdHJ1Y3QgcGFnZSINCj4gPiBpcyBhdmFpbGFibGUs
IHRoZSBwZXJmb3JtYW5jZSBvZiB0aGlzIEFQSSB3aWxsIGJlIGhhbmRsZWQgYnkgYSBzZXBlcmF0
ZSBwYXRjaA0KPiA+IHNlcmllcy4NCj4gDQo+IFdoZXJlIGNvdWxkIG9uZSBmaW5kIHRoaXMgcGF0
Y2hzZXQ/DQoNCkxldCBtZSBjbGVhbiBpdCBhbmQgc2VuZCBpdCBvdXQgYXMgd2VsbCA6KQ0KDQo+
IA0KPiBBbHNvIGlzIHRoZXJlIGFuIHNpbXBsZSB0ZXN0LWNhc2UgKG9yIGEgd3JpdGV1cCkgeW91
IGhhdmUgZm9yIHRlc3RpbmcNCj4gdGhpcyBjb2RlPyBTcGVjaWZpY2FsbHkgSSBhbSB0aGlua2lu
ZyBhYm91dCB0aGUgdXNlLWNhc2Ugb2YgIm1lbW9yeQ0KPiB3aXRob3V0IHRoZSAnc3RydWN0IHBh
Z2UnIg0KDQpTbyB0aGUgc2ltcGxlIHdheSB0byBkbyBpdCBpczoNCg0KMS0gUGFzcyAnbWVtPScg
aW4gdGhlIGtlcm5lbCBjb21tYW5kLWxpbmUgdG8gbGltaXQgdGhlIGFtb3VudCBvZiBtZW1vcnkg
bWFuYWdlZMKgDQrCoCDCoGJ5IHRoZSBrZXJuZWwuDQoyLSBNYXAgdGhpcyBwaHlzaWNhbCBtZW1v
cnkgeW91IHdhbnQgdG8gZ2l2ZSB0byB0aGUgZ3Vlc3Qgd2l0aA0KwqAgwqAgwqAgbW1hcCgiL2Rl
di9tZW0iLCBwaHlzaWNhbF9hZGRyZXNzX29mZnNldCwgLi4pDQozLSBVc2UgdGhlIHVzZXItc3Bh
Y2UgdmlydHVhbCBhZGRyZXNzIGFzIHRoZSAidXNlcnNwYWNlX2FkZHIiIGZpZWxkwqANCsKgIMKg
aW7CoEtWTV9TRVRfVVNFUl9NRU1PUllfUkVHSU9OIGlvY3RsLg0KDQpZb3Ugd2lsbCBhbHNvIG5l
ZWQgdGhpcyBwYXRjaCAoaG9wZWZ1bGx5IEkgd2lsbCByZXBvc3QgbmV4dCB3ZWVrIGFzIHdlbGwp
Og0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85MTkxNzU1Lw0KDQpJIHdpbGwg
bWFrZSBzdXJlIHRvIGV4cGFuZCBvbiB0aGlzIGluIHRoZSBjb3ZlciBsZXR0ZXIgaW4gdjYuDQoN
Cj4gDQo+IEFuZCB0aGFuayB5b3UgZm9yIHBvc3RpbmcgdGhpcyBwYXRjaHNldC4gSXQgd2FzIGEg
cGxlYXN1cmUgcmV2aWV3aW5nIHRoZQ0KPiBjb2RlIQ0KCgoKQW1hem9uIERldmVsb3BtZW50IENl
bnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAxMTcgQmVybGluCkdlc2NoYWVmdHNm
dWVocmVyOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBSYWxmIEhlcmJyaWNoClVzdC1JRDogREUgMjg5
IDIzNyA4NzkKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgSFJCIDE0
OTE3MyBCCgo=

