Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C49FC7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FAC42054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 09:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FAC42054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeJORKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 13:10:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43247 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726593AbeJORK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 13:10:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-145-TY_yltWpMzSa0j3fDrgy7w-1; Mon, 15 Oct 2018 10:26:00 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 15 Oct 2018 10:26:02 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 15 Oct 2018 10:26:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'ndesaulniers@google.com'" <ndesaulniers@google.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>
CC:     "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KEYS: trusted: fix -Wvarags warning
Thread-Topic: [PATCH] KEYS: trusted: fix -Wvarags warning
Thread-Index: AQHUYaFtz6yVKVwaakuhVxq6kXztuKUgDL3Q
Date:   Mon, 15 Oct 2018 09:26:02 +0000
Message-ID: <0180360cfcb5458d8ff099744e8884d4@AcuMS.aculab.com>
References: <1539274203.2623.56.camel@linux.vnet.ibm.com>
 <20181011203126.15338-1-ndesaulniers@google.com>
In-Reply-To: <20181011203126.15338-1-ndesaulniers@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: TY_yltWpMzSa0j3fDrgy7w-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogbmRlc2F1bG5pZXJzQGdvb2dsZS5jb20NCj4gU2VudDogMTEgT2N0b2JlciAyMDE4IDIx
OjMxDQouLi4NCj4gYnkgc3dhcHBpbmcgaDIgYW5kIGgzLg0KPiANCj4gc2VjdXJpdHkva2V5cy90
cnVzdGVkLmM6MTQ2OjE3OiB3YXJuaW5nOiBwYXNzaW5nIGFuIG9iamVjdCB0aGF0DQo+IHVuZGVy
Z29lcyBkZWZhdWx0DQo+ICAgICAgIGFyZ3VtZW50IHByb21vdGlvbiB0byAndmFfc3RhcnQnIGhh
cyB1bmRlZmluZWQgYmVoYXZpb3IgWy1XdmFyYXJnc10NCj4gICAgICAgICB2YV9zdGFydChhcmdw
LCBoMyk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBzZWN1cml0eS9rZXlzL3RydXN0
ZWQuYzoxMjY6Mzc6IG5vdGU6IHBhcmFtZXRlciBvZiB0eXBlICd1bnNpZ25lZA0KPiBjaGFyJyBp
cyBkZWNsYXJlZCBoZXJlDQo+IHVuc2lnbmVkIGNoYXIgKmgyLCB1bnNpZ25lZCBjaGFyIGgzLCAu
Li4pDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+IFNwZWNpZmljYWxseSwg
aXQgc2VlbXMgdGhhdCBib3RoIHRoZSBDOTAgKDQuOC4xLjEpIGFuZCBDMTEgKDcuMTYuMS40KQ0K
PiBzdGFuZGFyZHMgZXhwbGljaXRseSBjYWxsIHRoaXMgb3V0IGFzIHVuZGVmaW5lZCBiZWhhdmlv
cjoNCg0KSSBndWVzcyB0aGF0IHByb2JsZW1zIGFyaXNlIHdoZW4gYWxsIHRoZSBhcmd1bWVudHMg
YXJlIHN0YWNrZWQNCmFuZCB2YV9zdGFydC92YV9hcmcgdXNlIG5haXZlIHBvaW50ZXIgbWFuaXB1
bGF0aW9uLg0KSW4gdGhhdCBjYXNlICZoMyBtaWdodCBiZSA0biszIGFsaWduZWQgc28gdmFfYXJn
KCkgd2lsbCBhY2Nlc3MNCm1pc2FsaWduZWQgc3RhY2sgbG9jYXRpb25zLg0KDQpJIGRvdWJ0IGFu
eSBtb2Rlcm4gY29tcGlsZXJzICh3aGVyZSB2YV9zdGFydCBhbmQgdmFfYXJnIGFyZSBidWlsdGlu
cykNCndpbGwgZ2V0IHRoaXMgJ3dyb25nJyBldmVuIHdoZW4gYWxsIGFyZ3VtZW50cyBhcmUgc3Rh
Y2tlZC4NCg0KU2VlbXMgY2xhbmcgaXMgYmVpbmcgb3ZlciBjYXV0aW91cy4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

