Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BCEC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0C520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="bsxXMAcH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C0C520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933504AbeFTWAe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:00:34 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49753 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933097AbeFTWAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:00:32 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DA77A8365A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:00:29 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529532029;
        bh=LZ1sEfPL7/gbpTTkSebN3EL0u7mC1pmxSx4jhBr0dFo=;
        h=From:To:Subject:Date:References:In-Reply-To;
        b=bsxXMAcHvPpbV2QFBBO7K4Dkwjwk0lMMF7h9ujBk3L3yLSheYrtaoptznBOoqzLVr
         5POtcpD+saFnDo+z3kaqYhbsl0COAtSPmfObRjhV787omA93Fqr4tTMZwmR2/fYRJs
         /sLz+uyYyy/wuKr8yoZE5TAUO6hnYlDvPhl1O+7M=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2ace7e0001>; Thu, 21 Jun 2018 10:00:30 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 21 Jun 2018 10:00:29 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 21 Jun 2018 10:00:29 +1200
From:   Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To:     Mike Christie <mchristi@redhat.com>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: uio regression in 4.18-rc1 due to "uio: Prevent device
 destruction while fds are open"
Thread-Topic: uio regression in 4.18-rc1 due to "uio: Prevent device
 destruction while fds are open"
Thread-Index: AQHUCLCjdReacLuUCEy3eFISAy+lF6Ro6aYA
Date:   Wed, 20 Jun 2018 22:00:28 +0000
Message-ID: <c835824b-901e-3b27-ae32-1ed2a927892a@alliedtelesis.co.nz>
References: <5B2A7B73.5090000@redhat.com>
In-Reply-To: <5B2A7B73.5090000@redhat.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.16.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <318AC3580BEA8C4FB89254BF48661113@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlrZSwNCg0KVGhhbmtzIGZvciByZXBvcnRpbmcgdGhpcyBwcm9ibGVtIHdpdGggbXkgcGF0
Y2guDQoNClRvIGJlIGhvbmVzdCBJJ20gcG9zc2libHkgb3V0IG9mIG15IGRlcHRoIGhlcmUuIEkg
Z2F0aGVyIGRvaW5nIHRoaW5ncyANCmxpa2Ugc2xlZXBpbmcgYW5kIG1lbW9yeSBhbGxvY2F0aW9u
IGFyZSBhIGJpZyBuby1ubyB3aGVuIHVuZGVyIHNwaW5fbG9jayANCmFuZCBJIHRha2UgeW91ciBw
b2ludCB0aGF0IGl0IGlzIG5vdCByZWFsaXN0aWMgdG8gZXhwZWN0IGFsbCB0aGUgDQpjYWxsb3V0
cyBmcm9tIHRoZSB2YXJpb3VzIHVpb19mb3BzIHRvIGtub3cgb3IgcmVzcGVjdCB0aGF0IHRoZXkg
bWlnaHQgYmUgDQp1bmRlciBhIHNwaW5fbG9jay4NCg0KSSdkIHRha2UgeW91ciBhZHZpc2Ugb24g
d2hldGhlciBhbHRlcmluZyB0aGUgdHlwZSBvZiBsb2NraW5nIHVzZWQgYXJvdW5kIA0KYWNjZXNz
ZXMgdG8gdGhlICdpbmZvJyBtZW1iZXIgb2Ygc3RydWN0IHVpb19kZXZpY2UgbWlnaHQgYmUgYSBw
YXRoIA0KZm9yd2FyZCBoZXJlIG9yIGlzIGxpa2VseSB0byBsZWFkIHRvIHNpbWlsYXIgb3Igd29y
c2UgaXNzdWVzLiBGb3IgDQpleGFtcGxlIGNvdWxkIHdlIGNoYW5nZSB0aGUgc3Bpbl9sb2NrIHRv
IHNvbWV0aGluZyBtb3JlIGhlYXZ5d2VpZ2h0IGxpa2UgDQphIG11dGV4Pw0KDQpNeSBpZGVhIG9m
IGNvbXBsZXRpbmcgQnJpYW4gUnVzc2VsbCdzIHdvcmsgYnkgaW50cm9kdWNpbmcgdGhpcyBsb2Nr
aW5nIA0KY29uc3RydWN0IGlzIGFsc28gcG9zc2libHkgdGhlIHdyb25nIGFwcHJvYWNoLiBJdCBz
ZWVtcyBuaWNlIHRoYXQgd2UgY2FuIA0KbWFrZSB0aGUgdWlvIGNvcmUgY29wZSB3aXRoIHRoZSBk
aXNhcHBlYXJhbmNlIG9mIHRoZSB1aW9faW5mbyBtZW1vcnkgDQp0aGF0IHRoZSBpbmZvIG1lbWJl
ciBwb2ludHMgdG8sIGJ1dCBJJ20gYmVnaW5uaW5nIHRvIHRoaW5rIHRoYXQgd2UgDQpzaG91bGQg
Y29uc2lkZXIgYSBtb3JlIGZ1bmRhbWVudGFsIGNoYW5nZSB0byBhbGxvdyB0aGUgdWlvIGNvcmUg
dG8gDQpjb250cm9sIHRoZSBsaWZlIGN5Y2xlIG9mIHRoYXQgdWlvX2luZm8gc3RydWN0dXJlLiBU
aGlzIHNwaW5fbG9jayBpZGVhIA0Kc2VlbWVkIGxpa2UgYSBjbGVhbiB3YXkgb2YgYXZvaWRpbmcg
dGhhdCwgYnV0IHBlcmhhcHMgd2UganVzdCBuZWVkIHRvIA0KbGFuY2UgdGhhdCBib2lsIGluIGEg
bW9yZSB3aWRlLXJhbmdpbmcgZmFzaGlvbiBhbmQgYWNjZXB0IHRoZSANCmNvbnNlcXVlbmNlcyBz
dWNoIGFzIGJyZWFraW5nIG91dC1vZi10cmVlIGRyaXZlcnMuIFN1Y2ggYSB3aWRlIHJhbmdpbmcg
DQpjaGFuZ2Ugd291bGQgYmUgYmV0dGVyIGRvbmUgb3V0IG9mIHRoZSByZWxlYXNlIHBlcmlvZCBh
bmQgcmV2ZXJ0aW5nIHRoaXMgDQpjaGFuZ2Ugd291bGQgYmUgdGhlIGJlc3QgcmVzcG9uc2UgdG8g
dGhpcyByZWdyZXNzaW9uIGZvciA0LjE4Lg0KDQpJZiBhbnlvbmUgZWxzZSB3YW50cyB0byB3ZWln
aCBpbiBoZXJlIHBsZWFzZSBkbyBzby4NCg0KVGhhbmtzLA0KSGFtaXNoIE0uDQoNCk9uIDA2LzIx
LzIwMTggMDQ6MDYgQU0sIE1pa2UgQ2hyaXN0aWUgd3JvdGU6DQo+IEhpIEhhbWlzaCwNCj4NCj4g
SSBhbSBoaXR0aW5nIGEgcmVncmVzc2lvbiB3aXRoIHlvdXIgcGF0Y2g6DQo+DQo+IGNvbW1pdCBh
OTNlN2IzMzE1NjgyMjc1MDAxODZhNDY1ZmVlM2MyY2I1ZGZmZDFmDQo+IEF1dGhvcjogSGFtaXNo
IE1hcnRpbiA8aGFtaXNoLm1hcnRpbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBEYXRlOiAgIE1v
biBNYXkgMTQgMTM6MzI6MjMgMjAxOCArMTIwMA0KPg0KPiAgICAgIHVpbzogUHJldmVudCBkZXZp
Y2UgZGVzdHJ1Y3Rpb24gd2hpbGUgZmRzIGFyZSBvcGVuDQo+DQo+IFRoZSBwcm9ibGVtIGlzIHRo
ZSBhZGRpdGlvbiBvZiBzcGluX2xvY2tfaXJxc2F2ZSBpbiB1aW9fd3JpdGUuIFRoaXMNCj4gbGVh
ZHMgdG8gaGl0dGluZyAgdWlvX3dyaXRlIC0+IGNvcHlfZnJvbV91c2VyIC0+IF9jb3B5X2Zyb21f
dXNlciAtPg0KPiBtaWdodF9mYXVsdCBhbmQgdGhlIGxvZ3MgZmlsbGluZyB1cCB3aXRoIHNsZWVw
aW5nIHdhcm5pbmdzLg0KPg0KPiBJIGFsc28gbm90aWNlZCBzb21lIHVpbyBkcml2ZXJzIGFsbG9j
YXRlIG1lbW9yeSwgc2xlZXAsIGdyYWIgbXV0ZXhlcw0KPiBmcm9tIGNhbGxvdXRzIGxpa2Ugb3Bl
bigpIGFuZCByZWxlYXNlIGFuZCB1aW8gaXMgbm93IGRvaW5nDQo+IHNwaW5fbG9ja19pcnFzYXZl
IHdoaWxlIGNhbGxpbmcgdGhlbS4NCj4NCj4gTm90ZSB0YXJnZXRfY29yZV91c2VyJ3MgaXJxY29u
dHJvbCBsb29rcyBidWdneSBhbmQgd2FzIGp1c3QgZG9pbmcgbW9yZQ0KPiB3b3JrIHRoYW4gaXQg
c2hvdWxkIGluIHRoYXQgY2FsbG91dC4gSSBjYW4gZml4IHRoYXQgZHJpdmVyLg0K
