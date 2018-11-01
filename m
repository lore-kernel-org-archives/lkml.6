Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68BDBC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB9820657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB9820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeKAUgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:36:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:37412 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728276AbeKAUgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:36:03 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-106-dhW4TLwOPHGUnI_xeUDSoQ-1; Thu, 01 Nov 2018 11:33:24 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 1 Nov 2018 11:33:29 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 1 Nov 2018 11:33:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Colascione' <dancol@google.com>,
        Tycho Andersen <tycho@tycho.ws>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Christian Brauner" <christian.brauner@canonical.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: RE: [PATCH v3] Implement /proc/pid/kill
Thread-Topic: [PATCH v3] Implement /proc/pid/kill
Thread-Index: AQHUcVCToRlxhbXYLEGWot7AOxCGmqU6yY1g
Date:   Thu, 1 Nov 2018 11:33:29 +0000
Message-ID: <c49f552e34784e8dbb40a43015bed642@AcuMS.aculab.com>
References: <20181029221037.87724-1-dancol@google.com>
 <20181031155912.45088-1-dancol@google.com> <20181031175448.GC2180@cisco>
 <CAKOZuevrFxWLY1J1DVPNGaEy8UbkD1r_M9T9FQTOtSrqp-G0qw@mail.gmail.com>
 <20181031181717.GD2180@cisco>
 <CAKOZuetdSK8jhD1snja8p4AQTNPrLOugQrVn642RCH8S4QBGFg@mail.gmail.com>
In-Reply-To: <CAKOZuetdSK8jhD1snja8p4AQTNPrLOugQrVn642RCH8S4QBGFg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: dhW4TLwOPHGUnI_xeUDSoQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuaWVsIENvbGFzY2lvbmUNCj4gU2VudDogMzEgT2N0b2JlciAyMDE4IDE5OjMzDQou
Li4NCj4gWW91IGNhbid0IGRvIGl0IHRvZGF5IHdpdGgga2lsbC4gVGhlIGlkZWEgdGhhdCBrZWVw
aW5nIGEgb3BlbiBmaWxlDQo+IGRlc2NyaXB0b3IgdG8gYSAvcHJvYy9waWQgb3IgYSBmaWxlIHdp
dGhpbiBpdCBwcmV2ZW50cyBQSUQgcmV1c2UgaXMNCj4gd2lkZXNwcmVhZCwgYnV0IGluY29ycmVj
dC4NCg0KSXMgdGhlcmUgYSByZWFsIGdvb2QgcmVhc29uIHdoeSB0aGF0IHNob3VsZG4ndCBiZSB0
aGUgY2FzZT8NCmllIEhvbGRpbmcgYSByZWZlcmVuY2Ugb24gdGhlICdzdHJ1Y3QgcGlkJyBiZWlu
ZyBlbm91Z2ggdG8gc3RvcCByZXVzZS4NCg0KQSBwYXRjaCB0byBkbyB0aGF0IHdvdWxkIGJlIG1v
cmUgZ2VuZXJhbGx5IHVzZWZ1bC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

