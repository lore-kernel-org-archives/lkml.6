Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDD7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD2C213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfBZJpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:45:53 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:54934 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:45:53 -0500
X-IronPort-AV: E=Sophos;i="5.58,415,1544486400"; 
   d="scan'208";a="86451762"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Julien Grall <julien.grall@arm.com>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Beulich <JBeulich@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Dave P Martin <Dave.Martin@arm.com>
Subject: RE: [Xen-devel] xen/evtchn and forced threaded irq
Thread-Topic: [Xen-devel] xen/evtchn and forced threaded irq
Thread-Index: AQHUyHlaFDG4xZ7/w0+bq9NWKaEDoqXnvVYAgADuRwCAADAuAIAAEDAAgAAhZICAAAukgIACnDKAgAAPmICABLRVAIAACL8AgAFDuACAAARpgIAAFKIw
Date:   Tue, 26 Feb 2019 09:45:50 +0000
Message-ID: <73014d8f3d234e0ab315f5205d61c8d2@AMSPEX02CL02.citrite.net>
References: <20190220000209.GA4091@localhost.localdomain>
 <a872d480-9f1b-6cd7-e507-ac4fcdf705af@arm.com>
 <21214d47-9c68-e6bf-007a-4047cc2b02f9@oracle.com>
 <8f7445d7-fa50-f3e9-44f5-cc2aebd020f4@arm.com>
 <15bc52cb-82d8-4d2c-e5a8-c6ae8de90276@oracle.com>
 <5df8888a-4a29-fccd-bac2-a9c170244029@arm.com>
 <f7e78bf6-6e65-6d6c-c1ad-dca7f1e66b17@gmail.com>
 <fe44917f-bbe9-3e0e-fdda-2eb4db9f25c2@arm.com>
 <13a9616c-2d9a-f90b-3358-f2dcadbbb64d@gmail.com>
 <dbfd87e9-48fc-f641-9e24-ddb6c4f61135@arm.com>
 <20190226091420.klgldhotiecezw6h@Air-de-Roger>
 <038b837c-63c0-afb7-ca7b-75f61af7518e@citrix.com>
In-Reply-To: <038b837c-63c0-afb7-ca7b-75f61af7518e@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYZW4tZGV2ZWwgW21haWx0bzp4
ZW4tZGV2ZWwtYm91bmNlc0BsaXN0cy54ZW5wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIEFuZHJl
dyBDb29wZXINCj4gU2VudDogMjYgRmVicnVhcnkgMjAxOSAwOTozMA0KPiBUbzogUm9nZXIgUGF1
IE1vbm5lIDxyb2dlci5wYXVAY2l0cml4LmNvbT47IEp1bGllbiBHcmFsbCA8anVsaWVuLmdyYWxs
QGFybS5jb20+DQo+IENjOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+OyBTdGVmYW5v
IFN0YWJlbGxpbmkgPHNzdGFiZWxsaW5pQGtlcm5lbC5vcmc+OyBPbGVrc2FuZHINCj4gQW5kcnVz
aGNoZW5rbyA8YW5kcjIwMDBAZ21haWwuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgSmFuIEJldWxpY2ggPEpCZXVsaWNoQHN1c2UuY29tPjsNCj4geGVuLWRldmVsIDx4ZW4tZGV2
ZWxAbGlzdHMueGVucHJvamVjdC5vcmc+OyBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9zdHJvdnNr
eUBvcmFjbGUuY29tPjsgRGF2ZSBQDQo+IE1hcnRpbiA8RGF2ZS5NYXJ0aW5AYXJtLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtYZW4tZGV2ZWxdIHhlbi9ldnRjaG4gYW5kIGZvcmNlZCB0aHJlYWRlZCBp
cnENCj4gDQo+IE9uIDI2LzAyLzIwMTkgMDk6MTQsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+
ID4gT24gTW9uLCBGZWIgMjUsIDIwMTkgYXQgMDE6NTU6NDJQTSArMDAwMCwgSnVsaWVuIEdyYWxs
IHdyb3RlOg0KPiA+PiBIaSBPbGVrc2FuZHIsDQo+ID4+DQo+ID4+IE9uIDI1LzAyLzIwMTkgMTM6
MjQsIE9sZWtzYW5kciBBbmRydXNoY2hlbmtvIHdyb3RlOg0KPiA+Pj4gT24gMi8yMi8xOSAzOjMz
IFBNLCBKdWxpZW4gR3JhbGwgd3JvdGU6DQo+ID4+Pj4gSGksDQo+ID4+Pj4NCj4gPj4+PiBPbiAy
Mi8wMi8yMDE5IDEyOjM4LCBPbGVrc2FuZHIgQW5kcnVzaGNoZW5rbyB3cm90ZToNCj4gPj4+Pj4g
T24gMi8yMC8xOSAxMDo0NiBQTSwgSnVsaWVuIEdyYWxsIHdyb3RlOg0KPiA+Pj4+Pj4gRGlzY3Vz
c2luZyB3aXRoIG15IHRlYW0sIGEgc29sdXRpb24gdGhhdCBjYW1lIHVwIHdvdWxkIGJlIHRvDQo+
ID4+Pj4+PiBpbnRyb2R1Y2Ugb25lIGF0b21pYyBmaWVsZCBwZXIgZXZlbnQgdG8gcmVjb3JkIHRo
ZSBudW1iZXIgb2YNCj4gPj4+Pj4+IGV2ZW50IHJlY2VpdmVkLiBJIHdpbGwgZXhwbG9yZSB0aGF0
IHNvbHV0aW9uIHRvbW9ycm93Lg0KPiA+Pj4+PiBIb3cgd2lsbCB0aGlzIGhlbHAgaWYgZXZlbnRz
IGhhdmUgc29tZSBwYXlsb2FkPw0KPiA+Pj4+IFdoYXQgcGF5bG9hZD8gVGhlIGV2ZW50IGNoYW5u
ZWwgZG9lcyBub3QgY2FycnkgYW55IHBheWxvYWQuIEl0IG9ubHkNCj4gPj4+PiBub3RpZnkgeW91
IHRoYXQgc29tZXRoaW5nIGhhcHBlbi4gVGhlbiB0aGlzIGlzIHVwIHRvIHRoZSB1c2VyIHRvDQo+
ID4+Pj4gZGVjaWRlIHdoYXQgdG8geW91IHdpdGggaXQuDQo+ID4+PiBTb3JyeSwgSSB3YXMgcHJv
YmFibHkgbm90IHByZWNpc2UgZW5vdWdoLiBJIG1lYW4gdGhhdCBhbiBldmVudCBtaWdodCBoYXZl
DQo+ID4+PiBhc3NvY2lhdGVkIHBheWxvYWQgaW4gdGhlIHJpbmcgYnVmZmVyLCBmb3IgZXhhbXBs
ZSBbMV0uIFNvLCBjb3VudGluZyBldmVudHMNCj4gPj4+IG1heSBoZWxwIHNvbWVob3csIGJ1dCB0
aGUgcmluZydzIGRhdGEgbWF5IHN0aWxsIGJlIGxvc3QNCj4gPj4gRnJvbSBteSB1bmRlcnN0YW5k
aW5nIG9mIGV2ZW50IGNoYW5uZWxzIGFyZSBlZGdlIGludGVycnVwdHMuIEJ5IGRlZmluaXRpb24s
DQo+ID4gSU1PIGV2ZW50IGNoYW5uZWxzIGFyZSBhY3RpdmUgaGlnaCBsZXZlbCBpbnRlcnJ1cHRz
Lg0KPiA+DQo+ID4gTGV0J3MgdGFrZSBpbnRvIGFjY291bnQgdGhlIGZvbGxvd2luZyBzaXR1YXRp
b246IHlvdSBoYXZlIGFuIGV2ZW50DQo+ID4gY2hhbm5lbCBtYXNrZWQgYW5kIHRoZSBldmVudCBj
aGFubmVsIHBlbmRpbmcgYml0IChha2luIHRvIHRoZSBsaW5lIG9uDQo+ID4gYmFyZSBtZXRhbCkg
Z29lcyBmcm9tIGxvdyB0byBoaWdoICgwIC0+IDEpLCB0aGVuIHlvdSB1bm1hc2sgdGhlDQo+ID4g
aW50ZXJydXB0IGFuZCB5b3UgZ2V0IGFuIGV2ZW50IGluamVjdGVkLiBJZiBpdCB3YXMgYW4gZWRn
ZSBpbnRlcnJ1cHQNCj4gPiB5b3Ugd29udCBnZXQgYW4gZXZlbnQgaW5qZWN0ZWQgYWZ0ZXIgdW5t
YXNraW5nLCBiZWNhdXNlIHlvdSB3b3VsZA0KPiA+IGhhdmUgbG9zdCB0aGUgZWRnZS4gSSB0aGlu
ayB0aGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgTGludXggdHJlYXRzDQo+ID4gZXZlbnQgY2hhbm5l
bHMgYXMgZWRnZSBpbnRlcnJ1cHRzLCB3aGVuIHRoZXkgYXJlIGFjdHVhbGx5IGxldmVsLg0KPiAN
Cj4gRXZlbnQgY2hhbm5lbHMgYXJlIGVkZ2UgaW50ZXJydXB0cy7CoCBUaGVyZSBhcmUgc2V2ZXJh
bCB2ZXJ5IHN1YnRsZSBidWdzDQo+IHRvIGJlIGhhZCBieSBzb2Z0d2FyZSB3aGljaCB0cmVhdHMg
dGhlbSBhcyBsaW5lIGludGVycnVwdHMuDQoNClRoZXkgYXJlIG1vcmUgc3VidGxlIHRoYW4gdGhh
dCBhcmUgdGhleSBub3Q/IFRoZXJlIGlzIGEgc2luZ2xlIHBlci12Y3B1IEFDSyB3aGljaCBjYW4g
Y292ZXIgbXVsdGlwbGUgZXZlbnQgY2hhbm5lbHMuDQoNCiAgUGF1bA0KDQo+IA0KPiBNb3N0IGNy
aXRpY2FsbHksIGlmIHlvdSBmYWlsIHRvIGFjayB0aGVtLCByZWJpbmQgdGhlbSB0byBhIG5ldyB2
Y3B1LCBhbmQNCj4gcmVlbmFibGUgaW50ZXJydXB0cywgeW91IGRvbid0IGdldCBhIG5ldyBpbnRl
cnJ1cHQgbm90aWZpY2F0aW9uLsKgIFRoaXMNCj4gd2FzIHRoZSBzb3VyY2Ugb2YgYSA0IG1vbnRo
IGJ1ZyB3aGVuIFhlblNlcnZlciB3YXMgbW92aW5nIGZyb20NCj4gY2xhc3NpYy14ZW4gdG8gUFZP
cHMgd2hlcmUgdXNpbmcgaXJxYmFsYW5jZSB3b3VsZCBjYXVzZSBkb20wIHRvDQo+IG9jY2FzaW9u
YWxseSBsb3NlIGludGVycnVwdHMuDQo+IA0KPiB+QW5kcmV3DQo+IA0KPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBYZW4tZGV2ZWwgbWFpbGluZyBs
aXN0DQo+IFhlbi1kZXZlbEBsaXN0cy54ZW5wcm9qZWN0Lm9yZw0KPiBodHRwczovL2xpc3RzLnhl
bnByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8veGVuLWRldmVsDQo=
