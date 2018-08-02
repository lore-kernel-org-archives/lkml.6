Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610C7C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC44214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 09:15:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC44214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731952AbeHBLFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:05:49 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:58940 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730730AbeHBLFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:05:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-12-IoTiB4yAOIawnaw_DlJBOQ-1; Thu, 02 Aug 2018 10:15:31 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 2 Aug 2018 10:17:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 2 Aug 2018 10:17:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcel Hellwig' <mhellwig@mut-group.com>,
        'Eric Dumazet' <eric.dumazet@gmail.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: RE: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzgAovJrxAAAgVdAAL5l3oA==
Date:   Thu, 2 Aug 2018 09:17:10 +0000
Message-ID: <d16f03bf47b24313ad9f2ff4e37d6274@AcuMS.aculab.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
 <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
In-Reply-To: <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: IoTiB4yAOIawnaw_DlJBOQ-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWFyY2VsIEhlbGx3aWcNCj4gU2VudDogMDEgQXVndXN0IDIwMTggMTE6MzYNCj4gPj4g
WzxjMDIyOGFkYz5dICh1ZHBfcmVjdm1zZysweDI4NC8weDMzYykgZnJvbSBbPGMwMjMwNmUwPl0g
KGluZXRfcmVjdm1zZysweDM4LzB4NGMpOg0KPiBuZXQvaXB2NC91ZHAuYzoxMjM0DQo+ID4NCj4g
PiAgICAgICAgICAgICAgc2luLT5zaW5fYWRkci5zX2FkZHIgPSBpcF9oZHIoc2tiKS0+c2FkZHI7
DQo+ID4NCj4gPlVuYWxpZ25lZCBhY2Nlc3MgdHJhcCAodmlydHVhbCBhZGRyZXNzIGMxNGZlNjNh
KSwgc28gZWl0aGVyIHNpbiBvciBpcF9oZHIoc2tiKSBhcmUgbm90IG9uIGEgMzJiaXQNCj4gYWxp
Z25tZW50DQo+ID4NCj4gPkNhbiB5b3UgcHJvZHVjZSB0aGUgZGlzYXNzZW1ibHkgb2YgdGhlIHRy
YXBwaW5nIGluc3RydWN0aW9uID8NCj4gDQo+IGh0dHBzOi8vZ2lzdC5naXRodWIuY29tL2hlbGxv
dzU1NC82YjExYzZjMDgyN2Q1ZGI4MGE3ZTY2ZjcxZjU2MzZmZiNmaWxlLW5ldF91aXB2NF91ZHAt
bHN0LUwxODkyLUwxODk1DQo+IA0KPiAJCXNpbi0+c2luX2FkZHIuc19hZGRyID0gaXBfaGRyKHNr
YiktPnNhZGRyOw0KPiBjMDIyOGFkODoJZTU5NDMwODAgCWxkcglyMywgW3I0LCAjMTI4XQk7IDB4
ODANCj4gYzAyMjhhZGM6CWU1OTMzMDBjIAlsZHIJcjMsIFtyMywgIzEyXQ0KPiBjMDIyOGFlMDog
CWU1ODIzMDA0CXN0cglyMywgW3IyLCAjNF0NCg0KVGhlcmUgYXJlIGFjdHVhbGx5IDIgZmF1bHRz
LCBkaWZmaWN1bHQgdG8gcXVpY2tseSBzb3J0IG91dCB0aGUgbWVyZ2VkIHRyYWNlYmFja3MuDQpZ
b3UgYXJlIGFsc28gcnVubmluZyBhIHJhdGhlciBvbGQga2VybmVsOiBMaW51eCB2ZXJzaW9uIDMu
NC4xMTMuDQoNCkl0IG1heSB3ZWxsIGJlIHRoYXQgd2hpY2hldmVyIGV0aGVybmV0IGRyaXZlciBn
ZW5lcmF0ZWQgdGhlIG1pc2FsaWduZWQgZnJhbWUNCmhhcyBzaW5jZSBiZWVuIGZpeGVkLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

