Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C58C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322CE20869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322CE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbeKEUnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:43:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60002 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728899AbeKEUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:43:19 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-170-Dftf6rR-OnOg5abpB7upeg-1; Mon, 05 Nov 2018 11:24:03 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 5 Nov 2018 11:24:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 5 Nov 2018 11:24:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
CC:     Tariq Toukan <tariqt@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Boris Pismenny <borisp@mellanox.com>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        Kamal Heib <kamalh@mellanox.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net/mlx5e: fix high stack usage
Thread-Topic: [PATCH] net/mlx5e: fix high stack usage
Thread-Index: AQHUcsFsWmNXkRFIKUCZH9kBrP0aw6VBDQVA
Date:   Mon, 5 Nov 2018 11:24:06 +0000
Message-ID: <ee55a08ca81149a598aef8c47367f856@AcuMS.aculab.com>
References: <20181102153316.1492515-1-arnd@arndb.de>
In-Reply-To: <20181102153316.1492515-1-arnd@arndb.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Dftf6rR-OnOg5abpB7upeg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwMiBOb3ZlbWJlciAyMDE4IDE1OjMzDQo+IA0K
PiBBIHBhdGNoIHRoYXQgbG9va3MgaGFybWxlc3MgY2F1c2VzIHRoZSBzdGFjayB1c2FnZSBvZiB0
aGUgbWx4NWVfZ3JwX3N3X3VwZGF0ZV9zdGF0cygpDQo+IGZ1bmN0aW9uIHRvIGRyYXN0aWNhbGx5
IGluY3JlYXNlIHdpdGggeDg2IGdjYy00LjkgYW5kIGhpZ2hlciAodGVzdGVkIHVwIHRvIDguMSk6
DQo+IA0KPiBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5fc3RhdHMu
YzogSW4gZnVuY3Rpb24g4oCYbWx4NWVfZ3JwX3N3X3VwZGF0ZV9zdGF0c+KAmToNCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvbWVsbGFub3gvbWx4NS9jb3JlL2VuX3N0YXRzLmM6MjE2OjE6IHdhcm5p
bmc6IHRoZSBmcmFtZSBzaXplIG9mIDEyNzYgYnl0ZXMgaXMNCj4gbGFyZ2VyIHRoYW4gNTAwIGJ5
dGVzIFstV2ZyYW1lLWxhcmdlci10aGFuPV0NCj4gDQo+IEJ5IHNwbGl0dGluZyBvdXQgdGhlIGxv
b3AgYm9keSBpbnRvIGEgbm9uLWlubGluZWQgZnVuY3Rpb24sIHRoZSBzdGFjayBzaXplIGdvZXMN
Cj4gYmFjayBkb3duIHRvIHVuZGVyIDUwMCBieXRlcy4NCg0KSSdkIGxvb2sgYXQgdGhlIGdlbmVy
YXRlZCBjb2RlIGZvciB0aGUgZnVuY3Rpb24uDQpJdCBtaWdodCBiZSB0cnVseSBob3JyaWQuDQoN
Ckkgc3VzcGVjdCB0aGF0IGdjYyBhbGxvY2F0ZXMgJ3ZpcnR1YWwgcmVnaXN0ZXJzJyBmb3IgYWxs
IHRoZQ0Kcy0+dHhfLi4uIG1lbWJlcnMgYW5kIHRoZW4gd3JpdGVzIHRoZW0gdG8gJ3MnIG91dHNp
ZGUgdGhlIGxvb3AuDQpVbmZvcnR1bmF0ZWx5IHRoZXJlIGFyZW4ndCBlbm91Z2ggcmVhbCByZWdp
c3RlcnMgc28gYWxsIHRoZQ0KdmlydHVhbCBvbmVzIGdldCBzcGlsbGVkIHRvIHN0YWNrLg0KDQpJ
J3ZlIHNlZW4gaXQgZG8gc29tZXRoaW5nIHNpbWlsYXIgKGV4dHJhIHNwaWxscyB0byBzdGFjaykg
aW4gdGhlDQppeGdiZSBieXRlIGFuZCBwYWNrZXQgY291bnRpbmcuDQoNCkkgdGhpbmsgaXQgaXMg
cmVhbGx5IGEgZ2NjIGJ1Zy4NCg0KLi4uDQo+ICsJZm9yIChqID0gMDsgaiA8IHByaXYtPm1heF9v
cGVuZWRfdGM7IGorKykgew0KPiArCQlzdHJ1Y3QgbWx4NWVfc3Ffc3RhdHMgKnNxX3N0YXRzID0g
JmNoYW5uZWxfc3RhdHMtPnNxW2pdOw0KDQpUcnkgYWRkaW5nIGJhcnJpZXIoKSBoZXJlLg0KDQo+
ICsNCj4gKwkJcy0+dHhfcGFja2V0cwkJKz0gc3Ffc3RhdHMtPnBhY2tldHM7DQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

