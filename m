Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69AFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638B92081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638B92081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeKAUzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:55:52 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:42993 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbeKAUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:55:51 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id uk-mta-1-E57vVgMIPaGGlaiKSXZBbQ-1;
 Thu, 01 Nov 2018 11:53:11 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 1 Nov 2018 11:53:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 1 Nov 2018 11:53:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Colascione' <dancol@google.com>,
        Oleg Nesterov <oleg@redhat.com>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        "Joel Fernandes" <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Kees Cook" <keescook@chromium.org>,
        Christian Brauner <christian.brauner@canonical.com>
Subject: RE: [RFC PATCH] Implement /proc/pid/kill
Thread-Topic: [RFC PATCH] Implement /proc/pid/kill
Thread-Index: AQHUcR2JeS0BWWU92kSHqh9yuRXmu6U6z9Pw
Date:   Thu, 1 Nov 2018 11:53:15 +0000
Message-ID: <061df748f65d41b5bbd4749074dbce29@AcuMS.aculab.com>
References: <20181029221037.87724-1-dancol@google.com>
 <87bm7a3et9.fsf@xmission.com> <20181031124435.GA9007@redhat.com>
 <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
In-Reply-To: <CAKOZuevTF2cjJ0-nK7nv7jbgFexyW-deScaYVzE3iEPC48SAJg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: E57vVgMIPaGGlaiKSXZBbQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU2VudDogMzEgT2N0b2JlciAyMDE4IDEzOjI4DQouLi4NCj4gKiBJIGFjdHVhbGx5IGhh
dmUgYSBsb2NhbCB2YXJpYW50IG9mIHRoZSBwYXRjaCB0aGF0IHdvdWxkIGhhdmUgeW91DQo+IG9w
ZW4gIi9wcm9jLyRQSUQva2lsbC8kU0lHTk8iIGluc3RlYWQsIHNpbmNlIGRpZmZlcmVudCBzaWdu
YWwgbnVtYmVycw0KPiBoYXZlIGRpZmZlcmVudCBwZXJtaXNzaW9uIGNoZWNrcy4NCg0KSSB0aGlu
ayB5b3UnZCBuZWVkIHRoZSBvcGVuKCkgdG8gc3BlY2lmeSBzb21lIHNwZWNpZmljIHVudXN1YWwN
Cm9wZW4gbW9kZXMuDQpPdGhlcndpc2UgaXQnbGwgYmUgZmFyIHRvbyBlYXN5IGZvciBzY3JpcHRz
IChhbmQgcGVvcGxlKSB0bw0KYWNjaWRlbnRhbGx5IHNlbmQgZXZlcnkgc2lnbmFsIHRvIGV2ZXJ5
IHByb2Nlc3MuDQoNCkFsc28gdGhpbmsgb2YgdGhlIG1lbW9yeSBmb290cHJpbnQuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

