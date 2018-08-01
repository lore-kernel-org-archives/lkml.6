Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A3DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025C7208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025C7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mut-group.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbeHAMVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:21:03 -0400
Received: from mut-gw.mut-group.com ([213.209.114.184]:55618 "EHLO
        mut-gw.mut-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbeHAMVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:21:03 -0400
Received: from [192.168.20.11] (port=43361 helo=zcom03.mut-group.com)
        by mut-gw.mut-group.com with esmtps (TLSv1.2:AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <mhellwig@mut-group.com>)
        id 1fkoTw-0004F5-0a; Wed, 01 Aug 2018 12:35:52 +0200
Received: from ZCOM03.mut-group.com (192.168.20.11) by ZCOM03.mut-group.com
 (192.168.20.11) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 1 Aug
 2018 12:35:51 +0200
Received: from ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960]) by
 ZCOM03.mut-group.com ([fe80::6097:6956:3dd6:4960%12]) with mapi id
 15.00.1263.000; Wed, 1 Aug 2018 12:35:51 +0200
From:   Marcel Hellwig <mhellwig@mut-group.com>
To:     'Eric Dumazet' <eric.dumazet@gmail.com>,
        "'davem@davemloft.net'" <davem@davemloft.net>,
        "'kuznet@ms2.inr.ac.ru'" <kuznet@ms2.inr.ac.ru>,
        "'yoshfuji@linux-ipv6.org'" <yoshfuji@linux-ipv6.org>,
        "'andrew@lunn.ch'" <andrew@lunn.ch>
CC:     "'netdev@vger.kernel.org'" <netdev@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Matthias Wystrik" <mwystrik@mut-group.com>
Subject: AW: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Topic: AW: PROBLEM: Kernel Oops in UDP stack
Thread-Index: AdQo32X7ylxOxyzCQIq96qKkvZ0yzgAovJrxAAAgVdA=
Date:   Wed, 1 Aug 2018 10:35:51 +0000
Message-ID: <9f9d731107594b368504cbbaf698bc3d@ZCOM03.mut-group.com>
References: <18092446dfa7435aaa8deaab65afbf23@ZCOM03.mut-group.com>
 <f1940127-7307-e1ba-7a05-075680a6d3c1@gmail.com>
 <b8ceab2531f345d295686903b003787b@ZCOM03.mut-group.com>
 <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
In-Reply-To: <96753ca4-88fe-aa26-b439-6e22eaf8b524@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.21.69]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gWzxjMDIyOGFkYz5dICh1ZHBfcmVjdm1zZysweDI4NC8weDMzYykgZnJvbSBbPGMwMjMwNmUw
Pl0gKGluZXRfcmVjdm1zZysweDM4LzB4NGMpOiBuZXQvaXB2NC91ZHAuYzoxMjM0DQo+DQo+ICAg
ICAgICAgICAgICBzaW4tPnNpbl9hZGRyLnNfYWRkciA9IGlwX2hkcihza2IpLT5zYWRkcjsNCj4N
Cj5VbmFsaWduZWQgYWNjZXNzIHRyYXAgKHZpcnR1YWwgYWRkcmVzcyBjMTRmZTYzYSksIHNvIGVp
dGhlciBzaW4gb3IgaXBfaGRyKHNrYikgYXJlIG5vdCBvbiBhIDMyYml0IGFsaWdubWVudA0KPg0K
PkNhbiB5b3UgcHJvZHVjZSB0aGUgZGlzYXNzZW1ibHkgb2YgdGhlIHRyYXBwaW5nIGluc3RydWN0
aW9uID8NCg0KaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vaGVsbG93NTU0LzZiMTFjNmMwODI3ZDVk
YjgwYTdlNjZmNzFmNTYzNmZmI2ZpbGUtbmV0X3VpcHY0X3VkcC1sc3QtTDE4OTItTDE4OTUNCg0K
CQlzaW4tPnNpbl9hZGRyLnNfYWRkciA9IGlwX2hkcihza2IpLT5zYWRkcjsNCmMwMjI4YWQ4Ogll
NTk0MzA4MCAJbGRyCXIzLCBbcjQsICMxMjhdCTsgMHg4MA0KYzAyMjhhZGM6CWU1OTMzMDBjIAls
ZHIJcjMsIFtyMywgIzEyXQ0KYzAyMjhhZTA6IAllNTgyMzAwNAlzdHIJcjMsIFtyMiwgIzRdDQoN
Cg0KTWl0IGZyZXVuZGxpY2hlbiBHcsO8w59lbiAvIFdpdGgga2luZCByZWdhcmRzDQoNCk1hcmNl
bCBIZWxsd2lnDQpCLiBTYy4gSW5mb3JtYXRpaw0KRW50d2lja2xlcg0KDQptLXUtdMKgR21iSA0K
QW0gTWFyaWVuaG9mIDINCjIyODgwIFdlZGVsDQpHZXJtYW55DQoNClBob25lOgkrNDkgNDEwMyA5
MzA4IC0gNDc0DQpGYXg6wqDCoAkrNDkgNDEwMyA5MzA4IC0gOTkNCm1oZWxsd2lnQG11dC1ncm91
cC5jb20NCg0Kd3d3Lm11dC1ncm91cC5jb20NCg0KR2VzY2jDpGZ0c2bDvGhyZXLCoChNYW5hZ2lu
ZyBEaXJlY3Rvcik6IEZhYmlhbiBQZXRlcnMNCkFtdHNnZXJpY2h0IFBpbm5lYmVyZyAoQ29tbWVy
Y2lhbCBSZWdpc3RlciBOby4pOiBIUkLCoDEwMzA0IFBJDQpVU3QtSWROci4gKFZBVC1Oby4pOiBE
RTIyODI3NTM5MA0KV0VFRS1SZWctTnIuOiBERSA3MjI3MTgwOA0KDQoNCg==
