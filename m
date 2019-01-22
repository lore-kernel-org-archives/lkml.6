Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEE0C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839FF20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfAVNJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:09:49 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:51976 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728465AbfAVNJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:09:48 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 7DC2667BC80;
        Tue, 22 Jan 2019 14:09:42 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 22 Jan
 2019 14:09:42 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 22 Jan 2019 14:09:42 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 0/4] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Topic: [PATCH v2 0/4] mtd: rawnand: Support bad block markers in first,
 second or last page
Thread-Index: AQHUskTiZRErDsCrDEO9QpZop6Kcx6W7MiuA
Date:   Tue, 22 Jan 2019 13:09:41 +0000
Message-ID: <4ac34d36-8170-8e0d-7257-d1204dc67171@kontron.de>
References: <20190122112258.20042-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190122112258.20042-1-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4C8EA1F88C5FE41B682F4ADE9B4E34C@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7DC2667BC80.ADA2E
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjIuMDEuMTkgMTI6MjIsIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+IEZyb206IEZyaWVk
ZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gDQo+IEN1cnJlbnRs
eSBzdXBwb3J0ZWQgYmFkIGJsb2NrIG1hcmtlciBwb3NpdGlvbnMgd2l0aGluIHRoZSBibG9jayBh
cmU6DQo+ICogaW4gZmlyc3QgcGFnZSBvbmx5DQo+ICogaW4gbGFzdCBwYWdlIG9ubHkNCj4gKiBp
biBmaXJzdCBvciBzZWNvbmQgcGFnZQ0KPiANCj4gU29tZSBFU01UIE5BTkRzIGFyZSBrbm93biB0
byBoYXZlIGJlZW4gc2hpcHBlZCBieSB0aGUgbWFudWZhY3R1cmVyDQo+IHdpdGggYmFkIGJsb2Nr
IG1hcmtlcnMgaW4gdGhlIGZpcnN0IG9yIGxhc3QgcGFnZSwgaW5zdGVhZCBvZiB0aGUNCj4gZmly
c3Qgb3Igc2Vjb25kIHBhZ2UuDQo+IA0KPiBBbHNvIHRoZSBkYXRhc2hlZXRzIGZvciBDeXByZXNz
L1NwYW5zaW9uL0FNRCBOQU5EcyBjbGFpbSB0aGF0IHRoZQ0KPiBmaXJzdCwgc2Vjb25kICphbmQq
IGxhc3QgcGFnZSBuZWVkcyB0byBiZSBjaGVja2VkLg0KPiANCj4gVGhlcmVmb3JlIHdlIG1ha2Ug
aXQgcG9zc2libGUgdG8gc2V0IE5BTkRfQkJUX1NDQU4yTkRQQUdFIGFuZA0KPiBOQU5EX0JCVF9T
Q0FOTEFTVFBBR0UgYXQgdGhlIHNhbWUgdGltZSB0byBzY2FuL3NldCBhbGwgdGhyZWUgcGFnZXMu
DQoNCkluIHYyIHRoZSBmbGFncyB3ZXJlIHJlZGVmaW5lZCBhbmQgYXJlIG5vdyBjYWxsZWQgTkFO
RF9CQk1fRklSU1RQQUdFLCANCk5BTkRfQkJNX0ZJUlNUUEFHRSBhbmQgTkFORF9CQk1fTEFTVFBB
R0UuIEkgZm9yZ290IHRvIGVkaXQgdGhpcyBwYXJhZ3JhcGguDQoNCj4gDQo+IFRoaXMgc2VyaWVz
IGFsc28gY29udGFpbnMgcGF0Y2hlcyBmb3IgQU1EL1NwYW5zaW9uL0N5cHJlc3MgYW5kIEVTTVQN
Cj4gY2hpcHMgdG8gZW5hYmxlIGJvdGggZmxhZ3MgYXQgdGhlIHNhbWUgdGltZS4NCj4gLS0tDQo+
IENoYW5nZXMgaW4gdjI6DQo+ID09PT09PT09PT09PT09DQo+ICogUmViYXNlIG9uIDUuMC1yYzEN
Cj4gKiBBZGQgcGF0Y2ggdG8gbW92ZSBiYWQgYmxvY2sgbWFya2VyIHBvc2l0aW9uIGluZm8gdG8g
YSBjb21tb24gcGxhY2UgYW5kDQo+ICAgIHJlbmFtZS9wcmVwYXJlIGV4aXN0aW5nIGZsYWdzDQo+
ICogaW1wcm92ZS9yZW5hbWUgZnVuY3Rpb24gbmFuZF9iYm1fZ2V0X25leHRfcGFnZSgpIHRvIHVz
ZSBuZXcgZmxhZ3MNCj4gLS0tDQo+IEZyaWVkZXIgU2NocmVtcGYgKDQpOg0KPiAgICBtdGQ6IG5h
bmQ6IEFsd2F5cyBzdG9yZSBpbmZvIGFib3V0IGJhZCBibG9jayBtYXJrZXJzIGluIGNoaXAgc3Ry
dWN0DQo+ICAgIG10ZDogcmF3bmFuZDogU3VwcG9ydCBiYWQgYmxvY2sgbWFya2VycyBpbiBmaXJz
dCwgc2Vjb25kIG9yIGxhc3QgcGFnZQ0KPiAgICBtdGQ6IHJhd25hbmQ6IEVTTVQ6IEFsc28gdXNl
IHRoZSBsYXN0IHBhZ2UgZm9yIGJhZCBibG9jayBtYXJrZXJzDQo+ICAgIG10ZDogcmF3bmFuZDog
QU1EOiBBbHNvIHVzZSB0aGUgbGFzdCBwYWdlIGZvciBiYWQgYmxvY2sgbWFya2Vycw0KPiANCj4g
ICBkcml2ZXJzL210ZC9uYW5kL29uZW5hbmQvb25lbmFuZF9iYXNlLmMgfCAgMiArLQ0KPiAgIGRy
aXZlcnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2JidC5jICB8ICAyICstDQo+ICAgZHJpdmVy
cy9tdGQvbmFuZC9yYXcvaW50ZXJuYWxzLmggICAgICAgIHwgIDEgKw0KPiAgIGRyaXZlcnMvbXRk
L25hbmQvcmF3L25hbmRfYW1kLmMgICAgICAgICB8ICA4ICsrKy0NCj4gICBkcml2ZXJzL210ZC9u
YW5kL3Jhdy9uYW5kX2Jhc2UuYyAgICAgICAgfCA2NCArKysrKysrKysrKysrKysrKy0tLS0tLS0t
DQo+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9iYnQuYyAgICAgICAgIHwgMjggKysrKyst
LS0tLS0NCj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2VzbXQuYyAgICAgICAgfCAgOSAr
KystDQo+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9oeW5peC5jICAgICAgIHwgIDQgKy0N
Cj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX21hY3Jvbml4LmMgICAgfCAgMiArLQ0KPiAg
IGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfbWljcm9uLmMgICAgICB8ICAyICstDQo+ICAgZHJp
dmVycy9tdGQvbmFuZC9yYXcvbmFuZF9zYW1zdW5nLmMgICAgIHwgIDQgKy0NCj4gICBkcml2ZXJz
L210ZC9uYW5kL3Jhdy9uYW5kX3Rvc2hpYmEuYyAgICAgfCAgMiArLQ0KPiAgIGRyaXZlcnMvbXRk
L25hbmQvcmF3L3NoX2ZsY3RsLmMgICAgICAgICB8ICA0ICstDQo+ICAgaW5jbHVkZS9saW51eC9t
dGQvYmJtLmggICAgICAgICAgICAgICAgIHwgMTQgKy0tLS0tDQo+ICAgaW5jbHVkZS9saW51eC9t
dGQvcmF3bmFuZC5oICAgICAgICAgICAgIHwgMTYgKysrKysrKw0KPiAgIDE1IGZpbGVzIGNoYW5n
ZWQsIDEwMCBpbnNlcnRpb25zKCspLCA2MiBkZWxldGlvbnMoLSkNCj4g
