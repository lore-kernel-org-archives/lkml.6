Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B156DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E117208B6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E117208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbeHBPIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:08:32 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:60806 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732270AbeHBPIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:08:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-49-a-eTiuIMOI2_MTukArGm7g-1; Thu, 02 Aug 2018 14:17:18 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 2 Aug 2018 14:18:57 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 2 Aug 2018 14:18:57 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Eric Dumazet' <eric.dumazet@gmail.com>,
        'Marcel Hellwig' <mhellwig@mut-group.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: RE: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzgAovJrxAAAgVdAAL5l3oAAGOkwAAAJHfLA=
Date:   Thu, 2 Aug 2018 13:18:57 +0000
Message-ID: <b124d0aedf7c41fba86c59efe4c957a2@AcuMS.aculab.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
 <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
 <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
In-Reply-To: <405319c1-2fa0-e1b5-7173-b19d9769d98a@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: a-eTiuIMOI2_MTukArGm7g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRXJpYyBEdW1hemV0DQo+IFNlbnQ6IDAyIEF1Z3VzdCAyMDE4IDE0OjEzDQo+IA0KPiBB
IG1pc2FsaWduIGZyYW1lIGRyaXZlciBwcm9ibGVtIHdvdWxkIGhhdmUgZmF1bHRlZCBlYXJsaWVy
IGluIElQIHN0YWNrLA0KPiBtdWNoIGJlZm9yZSB3ZSBwZXJmb3JtIHRoZSBjb3B5IHRvIHVzZXIg
c3BhY2UgaW4gdWRwX3JlY3Ztc2coKQ0KDQpBbmQgbXkgbWFpbGVyIGZhaWxlZCB0byB0aHJlYWQg
YWxsIHRoZSBsYXRlciByZXNwb25zZXMgOi0oDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFk
ZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywg
TUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

