Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77EC20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfBTNwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:52:02 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:55517 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbfBTNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:52:00 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-3-bPYqFGAfPcihNxlGMAzATg-1;
 Wed, 20 Feb 2019 13:51:57 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 Feb 2019 13:52:40 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Feb 2019 13:52:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        "jmorris@namei.org" <jmorris@namei.org>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KEYS: user: Align the payload buffer
Thread-Topic: [PATCH] KEYS: user: Align the payload buffer
Thread-Index: AQHUySDST0ZEr/LQC0mQ8ti2hSdKCKXotDKQ
Date:   Wed, 20 Feb 2019 13:52:40 +0000
Message-ID: <6bf441ffc1a54d06ad27ed01c6d06a58@AcuMS.aculab.com>
References: <155066953188.21038.12015964986007814182.stgit@warthog.procyon.org.uk>
In-Reply-To: <155066953188.21038.12015964986007814182.stgit@warthog.procyon.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: bPYqFGAfPcihNxlGMAzATg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgSG93ZWxscw0KPiBTZW50OiAyMCBGZWJydWFyeSAyMDE5IDEzOjMyDQo+IA0K
PiBGcm9tOiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQo+IA0KPiBBbGlnbiB0
aGUgcGF5bG9hZCBvZiAidXNlciIgYW5kICJsb2dvbiIga2V5cyBzbyB0aGF0IHVzZXJzIG9mIHRo
ZQ0KPiBrZXlyaW5ncyBzZXJ2aWNlIGNhbiBhY2Nlc3MgaXQgYXMgYSBzdHJ1Y3QgdGhhdCByZXF1
aXJlcyBtb3JlIHRoYW4NCj4gMi1ieXRlIGFsaWdubWVudC4gIGZzY3J5cHQgY3VycmVudGx5IGRv
ZXMgdGhpcyB3aGljaCByZXN1bHRzIGluIHRoZSByZWFkDQo+IG9mIGZzY3J5cHRfa2V5OjpzaXpl
IGJlaW5nIG1pc2FsaWduZWQgYXMgaXQgbmVlZHMgNC1ieXRlIGFsaWdubWVudC4NCj4gDQo+IEFs
aWduIHRvIF9fYWxpZ25vZl9fKHU2NCkgcmF0aGVyIHRoYW4gX19hbGlnbm9mX18obG9uZykgc2lu
Y2UgaW4gdGhlDQo+IGZ1dHVyZSBpdCdzIGNvbmNlaXZhYmxlIHRoYXQgcGVvcGxlIHdvdWxkIHVz
ZSBzdHJ1Y3RzIGJlZ2lubmluZyB3aXRoDQo+IHU2NCwgd2hpY2ggb24gc29tZSBwbGF0Zm9ybXMg
d291bGQgcmVxdWlyZSBtb3JlIHRoYW4gJ2xvbmcnIGFsaWdubWVudC4NCi4uLg0KPiAgaW5jbHVk
ZS9rZXlzL3VzZXItdHlwZS5oIHwgICAgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9rZXlzL3Vz
ZXItdHlwZS5oIGIvaW5jbHVkZS9rZXlzL3VzZXItdHlwZS5oDQo+IGluZGV4IGUwOThjYmUyN2Ri
NS4uMTJiYWJlOTkxNTk0IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2tleXMvdXNlci10eXBlLmgN
Cj4gKysrIGIvaW5jbHVkZS9rZXlzL3VzZXItdHlwZS5oDQo+IEBAIC0zMSw3ICszMSw3IEBADQo+
ICBzdHJ1Y3QgdXNlcl9rZXlfcGF5bG9hZCB7DQo+ICAJc3RydWN0IHJjdV9oZWFkCXJjdTsJCS8q
IFJDVSBkZXN0cnVjdG9yICovDQo+ICAJdW5zaWduZWQgc2hvcnQJZGF0YWxlbjsJLyogbGVuZ3Ro
IG9mIHRoaXMgZGF0YSAqLw0KPiAtCWNoYXIJCWRhdGFbMF07CS8qIGFjdHVhbCBkYXRhICovDQo+
ICsJY2hhcgkJZGF0YVswXSBfX2FsaWduZWQoX19hbGlnbm9mX18odTY0KSk7IC8qIGFjdHVhbCBk
YXRhICovDQo+ICB9Ow0KDQpJJ2QgbWFrZSB0aGUgJ2RhdGFsZW4nIGZpZWxkICd1bnNpZ25lZCBp
bnQnIGF0IHRoZSBzYW1lIHRpbWUuDQpJdCB3aWxsIHVzZSBzb21lIG9mIHRoZSBob2xlIHlvdSd2
ZSBtYWRlIGFuZCBnZW5lcmF0ZSBiZXR0ZXINCmNvZGUgb24gbW9zdCBhcmNoZXMuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

