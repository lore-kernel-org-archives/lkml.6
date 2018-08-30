Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFF9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751E520661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751E520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeH3Tgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:36:54 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:38151 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbeH3Tgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:36:54 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-50-d_oZkD_5Ny2tcsryVzKzZQ-1; Thu, 30 Aug 2018 16:34:00 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 Aug 2018 16:35:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 Aug 2018 16:35:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Jiri Slaby" <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Thread-Topic: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Thread-Index: AQHUQFJsyE6G3E8Q/UO/0Ujg2pGZq6TYbMjw
Date:   Thu, 30 Aug 2018 15:35:39 +0000
Message-ID: <34ad57ec954c481d87ef6af58453ee9f@AcuMS.aculab.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
 <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
In-Reply-To: <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: d_oZkD_5Ny2tcsryVzKzZQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWlndWVsIE9qZWRhDQo+IFNlbnQ6IDMwIEF1Z3VzdCAyMDE4IDEyOjExDQouLi4NCj4g
PiArICAgICAgIHVuc2lnbmVkIGxvbmcgdmFsdWVfYml0bWFwWzFdOyAgLyogZm9yIERBVEFbMC03
XSwgUlMsIFJXICovDQo+IA0KPiAoSSByZWFkIHlvdXIgY29tbWVudHMgaW4gdGhlIG90aGVyIGVt
YWlsKQ0KPiANCj4gSSBzdGlsbCBmaW5kIHRoaXMgb2RkLCBidXQgaWYgZXZlcnlvbmUgaXMgZ29p
bmcgdG8gaGF2ZSB0aGlzIGNoYW5nZQ0KPiBkb25lIGxpa2UgdGhpcywgY29uc2lzdGVuY3kgaXMg
YmV0dGVyLg0KDQpNYXliZSB0aGVyZSBvdWdodCB0byBiZSBhIGRlZmluZSBzbyB5b3UgY2FuIGRv
Og0KCURFRklORV9CSVRNQVAodmFsdWVfYml0bWFwLCAzMik7DQoNCldoaWxlIGl0IG1pZ2h0IGp1
c3QgZ2VuZXJhdGUgYW4gdW5zaWduZWQgbG9uZyBbXSB0aGVyZSBpcyBwcm9iYWJseQ0Kc2NvcGUg
Zm9yIHN0cm9uZ2VyIHR5cGluZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

