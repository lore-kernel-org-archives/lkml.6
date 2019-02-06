Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB382C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B808820B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbfBFLsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:48:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37790 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726750AbfBFLsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:48:07 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-54-sUogVLojMLCk6jX27cd6tg-1; Wed, 06 Feb 2019 11:48:02 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 6 Feb 2019 11:48:44 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 6 Feb 2019 11:48:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mathieu Desnoyers' <mathieu.desnoyers@efficios.com>,
        Kees Cook <keescook@chromium.org>
CC:     William Cohen <wcohen@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "lttng@reliableembeddedsystems.com" 
        <lttng@reliableembeddedsystems.com>,
        lttng-dev <lttng-dev@lists.lttng.org>
Subject: RE: optimized kprobes illegal instructions in v4.19 stable kernels
Thread-Topic: optimized kprobes illegal instructions in v4.19 stable kernels
Thread-Index: AdS+EenMuTZKVrnAShWmIxd2cEb4Sw==
Date:   Wed, 6 Feb 2019 11:48:44 +0000
Message-ID: <76948cf5011e454494107cea61c6930c@AcuMS.aculab.com>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
In-Reply-To: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: sUogVLojMLCk6jX27cd6tg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWF0aGlldSBEZXNub3llcnMNCj4gU2VudDogMDQgRmVicnVhcnkgMjAxOSAxOToxNQ0K
PiBJIG5vdGljZSB0aGlzIGNvbW1pdCBhcyBhIHBvc3NpYmxlIGN1bHByaXQgb2YgdGhlIGlsbGVn
YWwgaW5zdHJ1Y3Rpb25zIG15IGx0dG5nDQo+IHVzZXJzIGFyZSBub3RpY2luZyBvbiBhcm0zMiB3
aGVuIHVzaW5nIGtwcm9iZXMgb24gYSB2NC4xOS4xMyBMaW51eCBrZXJuZWwNCj4gaW4gYSBZb2N0
byBlbnZpcm9ubWVudCBbMV0uIFRoZXkgd2VyZSBhYmxlIHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUg
d2l0aCBwZXJmDQo+IGFzIHdlbGwuDQo+IA0KPiBjb21taXQgZTQ2ZGFlZTUzYmI1MGJkZTM4ODA1
ZjE4MjNhMTgyOTc5NzI0YzIyOQ0KPiBBdXRob3I6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21p
dW0ub3JnPg0KPiBEYXRlOiAgIFR1ZSBPY3QgMzAgMjI6MTI6NTYgMjAxOCArMDEwMA0KPiANCj4g
ICAgIEFSTTogODgwNi8xOiBrcHJvYmVzOiBGaXggZmFsc2UgcG9zaXRpdmUgd2l0aCBGT1JUSUZZ
X1NPVVJDRQ0KPiANCj4gSSAqdGhpbmsqIHRoZSBpbnRlbnQgdGhlcmUgd2FzIHRvIGRvDQo+IA0K
PiAtICAgICAgIG1lbWNweShjb2RlLCAmb3B0cHJvYmVfdGVtcGxhdGVfZW50cnksDQo+ICsgICAg
ICAgbWVtY3B5KGNvZGUsICh1bnNpZ25lZCBsb25nICopJm9wdHByb2JlX3RlbXBsYXRlX2VudHJ5
LA0KPiANCj4gQnV0IGlmIHlvdSBsb29rIGF0IHRoZSBjb21taXQsIHRoZSAiJiIgc2VlbXMgdG8g
aGF2ZSBiZWVuIHN0cmlwcGVkIGF3YXksDQo+IHdoaWNoIGhhcHBlbnMgdG8gY2hhbmdlIHRoZSBi
ZWhhdmlvciBzaWduaWZpY2FudGx5Lg0KDQpXaGljaCBpcyB3aHkgeW91IHNob3VsZG4ndCBhZGQg
Y2FzdHMgdG8gc2h1dCB1cCBjb21waWxlciB3YXJuaW5ncyAuLi4uDQoNCglEYXZpZA0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

