Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EC42081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EC42081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbeK3AI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:08:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45380 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727402AbeK3AI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:08:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-128-ksHSXy-0PDK_DMzir5DLCg-1; Thu, 29 Nov 2018 13:03:39 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 29 Nov 2018 13:03:48 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 29 Nov 2018 13:03:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jose Abreu' <jose.abreu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "Vitor Soares" <vitor.soares@synopsys.com>
Subject: RE: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Topic: [PATCH] ARC: io.h: Implement reads{x}()/writes{x}()
Thread-Index: AQHUh+ESdH/rG0Kzu06tJT42U+4QdqVms3xQgAAB04CAAAGjgA==
Date:   Thu, 29 Nov 2018 13:03:47 +0000
Message-ID: <a35837f403f54d058dd31c901a007923@AcuMS.aculab.com>
References: <bdcc49c9eab45bda6815b1419590943e603d8dc2.1543484040.git.joabreu@synopsys.com>
 <f634eb3e39284e48923552a0c21562c6@AcuMS.aculab.com>
 <2d58c25b-60d0-4616-d2d2-ea490a7261f5@synopsys.com>
In-Reply-To: <2d58c25b-60d0-4616-d2d2-ea490a7261f5@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ksHSXy-0PDK_DMzir5DLCg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zZSBBYnJldSBbbWFpbHRvOmpvc2UuYWJyZXVAc3lub3BzeXMuY29tXQ0KPiBPbiAy
OS0xMS0yMDE4IDEyOjQ3LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogSm9zZSBBYnJl
dQ0KPiA+PiBTZW50OiAyOSBOb3ZlbWJlciAyMDE4IDEyOjQyDQo+ID4+DQo+ID4+IFNvbWUgQVJD
IENQVSdzIGRvIG5vdCBzdXBwb3J0IHVuYWxpZ25lZCBsb2Fkcy9zdG9yZXMuIEN1cnJlbnRseSwg
Z2VuZXJpYw0KPiA+PiBpbXBsZW1lbnRhdGlvbiBvZiByZWFkc3tiL3cvbH0oKS93cml0ZXN7Yi93
L2x9KCkgaXMgYmVpbmcgdXNlZCB3aXRoIEFSQy4NCj4gPj4gVGhpcyBjYW4gbGVhZCB0byBtaXNm
dW5jdGlvbiBvZiBzb21lIGRyaXZlcnMgYXMgZ2VuZXJpYyBmdW5jdGlvbnMgZG8gYQ0KPiA+PiBw
bGFpbiBkZXJlZmVyZW5jZSBvZiBhIHBvaW50ZXIgdGhhdCBjYW4gYmUgdW5hbGlnbmVkLg0KPiA+
Pg0KPiA+PiBMZXQncyB1c2Uge2dldC9wdXR9X3VuYWxpZ25lZCgpIGhlbHBlciBpbnN0ZWFkIG9m
IHBsYWluIGRlcmVmZXJlbmNlIG9mDQo+ID4+IHBvaW50ZXIgaW4gb3JkZXIgdG8gZml4IHRoaXMu
DQo+ID4gSXMgaXQgd29ydGggYWRkaW5nIGEgY2hlY2sgZm9yIHRoZSBwb2ludGVyIGJlaW5nIGFs
aWduZWQ/DQo+IA0KPiBXZSBjb3VsZCBidXQgdGhlbiB3ZSB3b3VsZCBuZWVkIHRvIGtub3cgd2hp
Y2ggQ1BVIHZlcnNpb24gaXMNCj4gY3VycmVudGx5IHJ1bm5pbmcgYmVjYXVzZSBzb21lIEFSQyBw
cm9jZXNzb3JzIHN1cHBvcnQgdW5hbGlnbmVkDQo+IGFjY2Vzc2VzLg0KDQpFaD8NCklmIHRoZSBD
UFUgc3VwcG9ydHMgdW5hbGlnbmVkIGFjY2Vzc2VzIHlvdSBjb3VsZCBwYXRjaCB0aGUgY29kZQ0K
dG8gZG8gdW5hbGlnbmVkIGFjY2Vzc2VzLg0KDQpJIHdhcyB0aGlua2luZyBvZiB0aGUgKHByb2Jh
Ymx5IGxpa2VseSkgY2FzZSB3aGVyZSB0aGUgcG9pbnRlciBpcw0KYWN0dWFsbHkgYWxpZ25lZC4N
CkFuIGV4dHJhIGNoZWNrIGZvciAoKHBvaW50ZXIpICYgMykgaXMgYWxtb3N0IGNlcnRhaW5seSBh
ICd3aW4nDQpvdmVyIHRoZSBieXRlIGFjY2Vzc2VzIGFuZCBzaGlmdC9tYXNrL29yIHVzZSBieSBn
ZXQvcHV0X3VuYWxpZ25lZCgpLg0KDQpUaGUgSU8gYWNjZXNzZXMgcHJvYmFibHkgZG9taW5hdGUg
bWFraW5nIG1vcmUgY29tcGxleCBvcHRpbWlzYXRpb25zDQpsZXNzIGxpa2VseSB0byBoYXZlIGFu
eSBiZW5lZml0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

