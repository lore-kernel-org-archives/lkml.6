Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D80C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388942086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388942086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJPQCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:02:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59041 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726968AbeJPQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:02:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-22-UPK5rDeFOYeY9zcZOCvDkg-1; Tue, 16 Oct 2018 09:13:24 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 16 Oct 2018 09:13:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 16 Oct 2018 09:13:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>
CC:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KEYS: trusted: fix -Wvarags warning
Thread-Topic: [PATCH] KEYS: trusted: fix -Wvarags warning
Thread-Index: AQHUYaFtz6yVKVwaakuhVxq6kXztuKUgDL3QgADCWICAALy2IA==
Date:   Tue, 16 Oct 2018 08:13:25 +0000
Message-ID: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
 <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
 <CAKwvOdmXVY1iA-VAs-Ns3qVVnMTeU6v4RqxoS2=SJcSeQ23_og@mail.gmail.com>
In-Reply-To: <CAKwvOdmXVY1iA-VAs-Ns3qVVnMTeU6v4RqxoS2=SJcSeQ23_og@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: UPK5rDeFOYeY9zcZOCvDkg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAxNSBPY3RvYmVyIDIwMTggMjI6NTQNCj4g
T24gTW9uLCBPY3QgMTUsIDIwMTggYXQgMjoyNiBBTSBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdo
dEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IG5kZXNhdWxuaWVyc0Bnb29nbGUu
Y29tDQo+ID4gPiBTZW50OiAxMSBPY3RvYmVyIDIwMTggMjE6MzENCj4gPiAuLi4NCj4gPiA+IGJ5
IHN3YXBwaW5nIGgyIGFuZCBoMy4NCj4gPiA+DQo+ID4gPiBzZWN1cml0eS9rZXlzL3RydXN0ZWQu
YzoxNDY6MTc6IHdhcm5pbmc6IHBhc3NpbmcgYW4gb2JqZWN0IHRoYXQNCj4gPiA+IHVuZGVyZ29l
cyBkZWZhdWx0DQo+ID4gPiAgICAgICBhcmd1bWVudCBwcm9tb3Rpb24gdG8gJ3ZhX3N0YXJ0JyBo
YXMgdW5kZWZpbmVkIGJlaGF2aW9yIFstV3ZhcmFyZ3NdDQo+ID4gPiAgICAgICAgIHZhX3N0YXJ0
KGFyZ3AsIGgzKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+ID4gc2VjdXJp
dHkva2V5cy90cnVzdGVkLmM6MTI2OjM3OiBub3RlOiBwYXJhbWV0ZXIgb2YgdHlwZSAndW5zaWdu
ZWQNCj4gPiA+IGNoYXInIGlzIGRlY2xhcmVkIGhlcmUNCj4gPiA+IHVuc2lnbmVkIGNoYXIgKmgy
LCB1bnNpZ25lZCBjaGFyIGgzLCAuLi4pDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXg0KPiA+ID4gU3BlY2lmaWNhbGx5LCBpdCBzZWVtcyB0aGF0IGJvdGggdGhlIEM5MCAo
NC44LjEuMSkgYW5kIEMxMSAoNy4xNi4xLjQpDQo+ID4gPiBzdGFuZGFyZHMgZXhwbGljaXRseSBj
YWxsIHRoaXMgb3V0IGFzIHVuZGVmaW5lZCBiZWhhdmlvcjoNCj4gPg0KPiA+IEkgZ3Vlc3MgdGhh
dCBwcm9ibGVtcyBhcmlzZSB3aGVuIGFsbCB0aGUgYXJndW1lbnRzIGFyZSBzdGFja2VkDQo+ID4g
YW5kIHZhX3N0YXJ0L3ZhX2FyZyB1c2UgbmFpdmUgcG9pbnRlciBtYW5pcHVsYXRpb24uDQo+ID4g
SW4gdGhhdCBjYXNlICZoMyBtaWdodCBiZSA0biszIGFsaWduZWQgc28gdmFfYXJnKCkgd2lsbCBh
Y2Nlc3MNCj4gPiBtaXNhbGlnbmVkIHN0YWNrIGxvY2F0aW9ucy4NCj4gPg0KPiA+IEkgZG91YnQg
YW55IG1vZGVybiBjb21waWxlcnMgKHdoZXJlIHZhX3N0YXJ0IGFuZCB2YV9hcmcgYXJlIGJ1aWx0
aW5zKQ0KPiA+IHdpbGwgZ2V0IHRoaXMgJ3dyb25nJyBldmVuIHdoZW4gYWxsIGFyZ3VtZW50cyBh
cmUgc3RhY2tlZC4NCj4gPg0KPiA+IFNlZW1zIGNsYW5nIGlzIGJlaW5nIG92ZXIgY2F1dGlvdXMu
DQo+IA0KPiBZZXM7IGRpZCB5b3UgaGF2ZSBmZWVkYmFjayBvbiB0aGUgRGVuaXMnIHByb3Bvc2Vk
IGZpeCwgb3IgYW5vdGhlcj8NCg0KUGVyc29uYWxseSBJJ2QgYXZvaWQgY2hhciwgc2hvcnQgYW5k
IGJvb2wgZm9yIGJvdGggZnVuY3Rpb24NCmFyZ3VtZW50cyBhbmQgcmVzdWx0cyBzaW5jZSB0aGV5
IHR5cGljYWxseSByZXF1aXJlIGV4dHJhDQppbnN0cnVjdGlvbnMgZm9yIG1hc2tpbmcgdmFsdWVz
IChldGMpLg0KYm9vbCBpcyBwYXJ0aWN1bGFybHkgb2Jub3hpb3VzLg0KDQpJbiB0aGF0IGNhc2Ug
ZWl0aGVyIGludCBvciB1bnNpZ25lZCBpbnQgaXMgZ29vZC4NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

