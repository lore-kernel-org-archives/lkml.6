Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260ADC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D21420868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D21420868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLABGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:06:23 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:47961 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbeLABGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:06:23 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-167-UdS3UQMsOiu0EZlHpn-T7A-1; Fri, 30 Nov 2018 13:56:57 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 30 Nov 2018 13:57:06 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Nov 2018 13:57:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        "jose.abreu@synopsys.com" <jose.abreu@synopsys.com>
CC:     "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>
Subject: RE: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH v2] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUh+/vHIi8Q+1XAUeZFbx1QKnaT6Vm0lZggAGDfZeAAAJ5YA==
Date:   Fri, 30 Nov 2018 13:57:06 +0000
Message-ID: <3afe0e1bbf2d42d3bb178ec789553c28@AcuMS.aculab.com>
References: <19fb2e394afcb073bbc109e432417fbbc03323f6.1543499759.git.joabreu@synopsys.com>
 <ff1e11923e92405d883474d715008c0a@AcuMS.aculab.com>
 <89122bd8-bca2-2ae1-0dd0-160abbebcace@synopsys.com>
 <d2d133e5-267c-c42a-7329-22892bbbdee4@synopsys.com>
 <CAK8P3a2U3ft3crF2SiAuc=PQdDooEUaVAN9gQDyxsxvBn5+xRw@mail.gmail.com>
 <57437493-31bb-eced-032c-1f54470b030e@synopsys.com>
 <CAK8P3a2mqEb4_F4wB1DvL5jJJobLhOg6-bW3ZDNGhvbv-_qW3A@mail.gmail.com>
In-Reply-To: <CAK8P3a2mqEb4_F4wB1DvL5jJJobLhOg6-bW3ZDNGhvbv-_qW3A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UdS3UQMsOiu0EZlHpn-T7A-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAzMCBOb3ZlbWJlciAyMDE4IDEzOjQ0DQo+IA0K
PiBPbiBGcmksIE5vdiAzMCwgMjAxOCBhdCA5OjU3IEFNIEpvc2UgQWJyZXUgPGpvc2UuYWJyZXVA
c3lub3BzeXMuY29tPiB3cm90ZToNCj4gPiBPbiAyOS0xMS0yMDE4IDIxOjIwLCBBcm5kIEJlcmdt
YW5uIHdyb3RlOg0KPiA+ID4gT24gVGh1LCBOb3YgMjksIDIwMTggYXQgNToxNCBQTSBKb3NlIEFi
cmV1IDxqb3NlLmFicmV1QHN5bm9wc3lzLmNvbT4gd3JvdGU6DQo+ID4gPj4gU2VlIGhvdyB0aGUg
aWYgY29uZGl0aW9uIGFkZGVkIGluIHRoaXMgdmVyc2lvbiBpcyBjaGVja2VkIGluDQo+ID4gPj4g
PHRlc3RfcmVhZHNsKzB4ZTkyPiBhbmQgdGhlbiBpdCB0YWtlcyB0d28gZGlmZmVyZW50IGxvb3Bz
Lg0KPiA+ID4gVGhpcyBsb29rcyBnb29kIHRvIG1lLiBJIHdvbmRlciB3aGF0IHRoZSByZXN1bHQg
aXMgZm9yIENQVXMNCj4gPiA+IHRoYXQgL2RvLyBzdXBwb3J0IHVuYWxpZ25lZCBhY2Nlc3Nlcy4g
Tm9ybWFsbHkgcHV0X3VuYWxpZ25lZCgpDQo+ID4gPiBzaG91bGQgZmFsbCBiYWNrIHRvIGEgc2lt
cGxlIHN0b3JlIGluIHRoYXQgY2FzZSwgYnV0IEknbSBub3QNCj4gPiA+IHN1cmUgaXQgY2FuIGZv
bGQgdGhlIHR3byBzdG9yZXMgYmFjayBpbnRvIG9uZSBhbmQgc2tpcCB0aGUNCj4gPiA+IGFsaWdu
bWVudCBjaGVjay4gUHJvYmFibHkgbm90IHdvcnRoIG92ZXJvcHRpbWl6aW5nIGZvciB0aGF0DQo+
ID4gPiBjYXNlICh0aGUgTU1JTyBhY2Nlc3MgbGF0ZW5jeSBzaG91bGQgYmUgbXVjaCBoaWdoZXIg
dGhhbg0KPiA+ID4gYW55dGhpbmcgeW91IGNvdWxkIGdhaW4gaGVyZSksIGJ1dCBJJ20gc3RpbGwg
Y3VyaW91cyBhYm91dA0KPiA+ID4gaG93IHdlbGwgb3VyIGdldC9wdXRfdW5hbGlnbmVkIG1hY3Jv
cyB3b3JrLg0KPiA+DQo+ID4gSGVyZSBpcyBkaXNhc3NlbWJseSBmb3IgYW4gQVJDIENQVSB0aGF0
IHN1cHBvcnRzIHVuYWxpZ25lZCBhY2Nlc3NlczoNCj4gPg0KPiA+IC0tPjgtLS0NCj4gPiAwMDAw
MGQ0OCA8dGVzdF9yZWFkc2w+Og0KPiA+ICBkNDg6ICAgIGJyZXFfcyByMSwwLDI4ICAgICAgICAg
ICAgLyogaWYgKGNvdW50KSAqLw0KPiA+ICBkNGE6ICAgIHRzdCAgICByMCwweDMNCj4gPiAgZDRl
OiAgICBibmVfcyAzMiAgICAgICAgICAgICAgICAvKiBpZiAoYnB0ciAlICgodCkgLyA4KSkgKi8N
Cj4gPg0KPiA+ICBkNTA6ICAgIGxkIHIyLFsweGRlYWRiZWVmXSAgICAgICAgLyogZmlyc3QgbG9v
cCAqLw0KPiA+ICBkNTg6ICAgIHN1Yl9zIHIxLHIxLDB4MQ0KPiA+ICBkNWE6ICAgIHRzdF9zIHIx
LHIxDQo+ID4gIGQ1YzogICAgYm5lLmQgLTEyDQo+ID4gIGQ2MDogICAgc3QuYWIgcjIsW3IwLDRd
DQo+ID4NCj4gPiAgZDY0OiAgICBkbWIgICAgMHgxICAgICAgICAgICAgICAgICAgICAvKiBjb21t
b24gZXhpdCBwb2ludCAqLw0KPiA+ICBkNjg6ICAgIGpfcyAgICBbYmxpbmtdDQo+ID4gIGQ2YTog
ICAgbm9wX3MNCj4gPg0KPiA+ICBkNmM6ICAgIGxkIHIyLFsweGRlYWRiZWVmXSAgICAgICAgLyog
c2Vjb25kIGxvb3AgKi8NCj4gPiAgZDc0OiAgICBzdWJfcyByMSxyMSwweDENCj4gPiAgZDc2OiAg
ICB0c3RfcyByMSxyMQ0KPiA+ICBkNzg6ICAgIGJuZS5kIC0xMg0KPiA+ICBkN2M6ICAgIHN0LmFi
IHIyLFtyMCw0XQ0KPiA+DQo+ID4gIGQ4MDogICAgYl9zIC0yOCAgICAgICAgICAgICAgICAgICAg
Lyogam1wIHRvIDB4ZDY0ICovDQo+ID4gIGQ4MjogICAgbm9wX3MNCj4gPiAtLS0+OC0tLQ0KPiA+
DQo+ID4gTm90aWNlIGhvdyBmaXJzdCBhbmQgc2Vjb25kIGxvb3AgYXJlIGV4YWN0bHkgZXF1YWwg
Li4uDQo+IA0KPiBPaywgc28gaXQncyBoYWxmd2F5IHRoZXJlOiBpdCBtYW5hZ2VkIHRvIG9wdGlt
aXplIHRoZSB0aGUgdW5hbGlnbmVkDQo+IGNhc2UgY29ycmVjdGx5LCBidXQgaXQgZmFpbGVkIHRv
IG5vdGljZSB0aGF0IGJvdGggc2lkZXMgYXJlDQo+IGlkZW50aWNhbCBub3cuDQoNClRoZXJlJ3Jl
IGV2ZW4gaWRlbnRpY2FsIG9wY29kZXMuLi4NClRoZSBiYXJyaWVyKCkgKGV0YykgaW4gdGhlIGFz
bSBvdXRwdXQgcHJvYmFibHkgc3RvcHBlZCB0aGUgb3B0aW1pc2F0aW9uLg0KDQpJdCBhbHNvIHNl
ZW1zIHRvIGhhdmUgdXNlZCBhIGRpZmZlcmVudCB0eXBlIG9mIGxvb3AgdG8gdGhlDQpvdGhlciBl
eGFtcGxlLCBwcm9iYWJseSBsZXNzIGVmZmljaWVudC4NCihOb3QgdGhhdCBJJ20gYW4gZXhwZXJ0
IG9uIEFSQyBvcGNvZGVzLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

