Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D20C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23244223C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23244223C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeKLTrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:47:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:47027 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbeKLTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:47:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-140-niB-I7VRPtSO0Uple3pKuw-1; Mon, 12 Nov 2018 09:55:18 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 12 Nov 2018 09:55:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 12 Nov 2018 09:55:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     'Bart Van Assche' <bvanassche@acm.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        "Darryl T. Agostinelli" <dagostinelli@gmail.com>
Subject: RE: [PATCH] slab.h: Avoid using & for logical and of booleans
Thread-Topic: [PATCH] slab.h: Avoid using & for logical and of booleans
Thread-Index: AQHUdUfJjxPqMWIPVkCDxWbeIJk+/6VCg0ZQgAAHZYCAAAoxEIAAH18AgAFtI9CAA7ZBaYAEF9og
Date:   Mon, 12 Nov 2018 09:55:23 +0000
Message-ID: <bf7c2a6b801a4430bf842fc20e826db6@AcuMS.aculab.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
 <62188a351f2249188ce654ee03c894b1@AcuMS.aculab.com>
 <e44e6c8b-e4e4-e7cb-a5ca-88e9559eb0d7@suse.cz>
 <3c9adab0f1f74c46a60b3d4401030337@AcuMS.aculab.com>
 <60deb90d-e521-39e5-5072-fc9efb98e365@suse.cz>
 <9af3ac1d43bb422cb3c41e7e8e422e6e@AcuMS.aculab.com>
 <cbc1fc52-dc8c-aa38-8f29-22da8bcd91c1@suse.cz>
 <20181109110019.c82fba8125d4e2891fbe4a6c@linux-foundation.org>
 <b8ffd59b-0d15-9c98-b9ea-ad71e4c0c734@suse.cz>
In-Reply-To: <b8ffd59b-0d15-9c98-b9ea-ad71e4c0c734@suse.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: niB-I7VRPtSO0Uple3pKuw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVmxhc3RpbWlsIEJhYmthIFttYWlsdG86dmJhYmthQHN1c2UuY3pdDQo+IFNlbnQ6IDA5
IE5vdmVtYmVyIDIwMTggMTk6MTYNCi4uLg0KPiBUaGlzPyBOb3QgdGVycmlibHkgZWxlZ2FudCwg
YnV0IEkgZG9uJ3Qgc2VlIGEgbmljZXIgd2F5IHJpZ2h0IG5vdy4uLg0KDQpNYXliZSBqdXN0IGhh
dmUgdHdvIGNvcGllcyBvZiB0aGUgZnVuY3Rpb24gYm9keT8NCg0KIHN0YXRpYyBfX2Fsd2F5c19p
bmxpbmUgZW51bSBrbWFsbG9jX2NhY2hlX3R5cGUga21hbGxvY190eXBlKGdmcF90IGZsYWdzKQ0K
ew0KI2lmbmRlZiBDT05GSUdfWk9ORV9ETUENCglyZXR1cm4gZmxhZ3MgJiBfX0dGUF9SRUNMQUlN
QUJMRSA/IEtNQUxMT0NfUkVDTEFJTSA6IEtNQUxMT0NfTk9STUFMOw0KI2Vsc2UNCglpZiAobGlr
ZWx5KChmbGFncyAmIChfX0dGUF9ETUEgfCBfX0dGUF9SRUNMQUlNQUJMRSkpID09IDApKQ0KCQly
ZXR1cm4gS01BTExPQ19OT1JNQUw7DQoJcmV0dXJuIGZsYWdzICYgX19HRlBfRE1BID8gS01BTExP
Q19ETUEgOiBLTUFMTE9DX1JFQ0xBSU07DQojZW5kaWYNCn0NCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

