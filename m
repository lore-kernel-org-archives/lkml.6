Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F314C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AE320685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AE320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeJaVY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:24:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:21342 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728706AbeJaVY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:24:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-166-ZCCFOuJ0O2ycvPydlbA13g-1; Wed, 31 Oct 2018 12:27:08 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 31 Oct 2018 12:27:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 31 Oct 2018 12:27:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Colascione' <dancol@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "timmurray@google.com" <timmurray@google.com>,
        "joelaf@google.com" <joelaf@google.com>
Subject: RE: [RFC PATCH] Minimal non-child process exit notification support
Thread-Topic: [RFC PATCH] Minimal non-child process exit notification support
Thread-Index: AQHUb7BQVhTcKn4SykenXuciwsVIoKU5SOFw
Date:   Wed, 31 Oct 2018 12:27:12 +0000
Message-ID: <4beaaae77bea4cc5b4cc15504331c9a9@AcuMS.aculab.com>
References: <20181029175322.189042-1-dancol@google.com>
In-Reply-To: <20181029175322.189042-1-dancol@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ZCCFOuJ0O2ycvPydlbA13g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuaWVsIENvbGFzY2lvbmUNCj4gU2VudDogMjkgT2N0b2JlciAyMDE4IDE3OjUzDQo+
IA0KPiBUaGlzIHBhdGNoIGFkZHMgYSBuZXcgZmlsZSB1bmRlciAvcHJvYy9waWQsIC9wcm9jL3Bp
ZC9leGl0aGFuZC4NCj4gQXR0ZW1wdGluZyB0byByZWFkIGZyb20gYW4gZXhpdGhhbmQgZmlsZSB3
aWxsIGJsb2NrIHVudGlsIHRoZQ0KPiBjb3JyZXNwb25kaW5nIHByb2Nlc3MgZXhpdHMsIGF0IHdo
aWNoIHBvaW50IHRoZSByZWFkIHdpbGwgc3VjY2Vzc2Z1bGx5DQo+IGNvbXBsZXRlIHdpdGggRU9G
LiAgVGhlIGZpbGUgZGVzY3JpcHRvciBzdXBwb3J0cyBib3RoIGJsb2NraW5nDQo+IG9wZXJhdGlv
bnMgYW5kIHBvbGwoMikuIEl0J3MgaW50ZW5kZWQgdG8gYmUgYSBtaW5pbWFsIGludGVyZmFjZSBm
b3INCj4gYWxsb3dpbmcgYSBwcm9ncmFtIHRvIHdhaXQgZm9yIHRoZSBleGl0IG9mIGEgcHJvY2Vz
cyB0aGF0IGlzIG5vdCBvbmUNCj4gb2YgaXRzIGNoaWxkcmVuLg0KDQpXaHkgZG8geW91IG5lZWQg
YW4gZXh0cmEgZmlsZT8NCkl0IG91Z2h0IHRvIGJlIHBvc3NpYmxlIHRvIHVzZSBwb2xsKCkgdG8g
d2FpdCBmb3IgUE9MTEVSUiBoYXZpbmcgc2V0DQonZXZlbnRzJyB0byB6ZXJvIG9uIGFueSBvZiB0
aGUgbm9kZXMgaW4gL3Byb2MvcGlkIC0gb3IgZXZlbiBvbg0KdGhlIGRpcmVjdG9yeSBpdHNlbGYu
DQoNCkluZGVlZCwgdG8gYXZvaWQga2lsbGluZyB0aGUgd3JvbmcgcHJvY2VzcyB5b3UgbmVlZCB0
byBoYXZlIG9wZW5lZA0Kc29tZSBub2RlIG9mIC9wcm9jL3BpZC8qIChtYXliZSBjbWRsaW5lKSBi
ZWZvcmUgc2VuZGluZyB0aGUga2lsbA0Kc2lnbmFsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

