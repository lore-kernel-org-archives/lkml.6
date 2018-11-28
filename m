Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3892C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A752F20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A752F20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeK2ADW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:03:22 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:51470 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbeK2ADW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:03:22 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 4844B679802;
        Wed, 28 Nov 2018 14:01:40 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 28 Nov
 2018 14:01:39 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 28 Nov 2018 14:01:39 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Thread-Topic: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Thread-Index: AQHUdz2L3HigzaAOUUKXPQ4ku2nhHqVjxsKAgAAC1ACAABdiAIABUpuAgAACLoA=
Date:   Wed, 28 Nov 2018 13:01:39 +0000
Message-ID: <94c0d54b-8268-b5b9-bd17-a06eea44d96d@kontron.de>
References: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
 <0fc1f198-0e87-01af-5a0e-3d21613c39f3@kontron.de>
 <CAJiuCceD=qyasCUPqjyGQso3JGoxz4g_yg3uj18wP-2CKY9wyg@mail.gmail.com>
 <1655b66f-37e2-427f-a047-8305f86fc22c@kontron.de>
 <20181128135351.488194ee@bbrezillon>
In-Reply-To: <20181128135351.488194ee@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7CC52446C7D1747B29AEAEDBA8E3EEF@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4844B679802.A9B50
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com,
        peron.clem@gmail.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCk9uIDI4LjExLjE4IDEzOjUzLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+
IE9uIFR1ZSwgMjcgTm92IDIwMTggMTY6NDE6NTYgKzAwMDANCj4gU2NocmVtcGYgRnJpZWRlciA8
ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPiB3cm90ZToNCj4gDQo+Pj4+PiArc3RhdGljIGlu
dCB0YzU4Y3ZnMnMwaF9vb2JsYXlvdXRfZWNjKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgc2Vj
dGlvbiwNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IG10
ZF9vb2JfcmVnaW9uICpyZWdpb24pDQo+Pj4+PiArew0KPj4+Pj4gKyAgICAgaWYgKHNlY3Rpb24g
PiA3KQ0KPj4+Pj4gKyAgICAgICAgICAgICByZXR1cm4gLUVSQU5HRTsNCj4+Pj4+ICsNCj4+Pj4+
ICsgICAgIHJlZ2lvbi0+b2Zmc2V0ID0gMTI4ICsgMTYgKiBzZWN0aW9uOw0KPj4+Pj4gKyAgICAg
cmVnaW9uLT5sZW5ndGggPSAxNjsNCj4+Pg0KPj4+IEhlcmUgeW91IGV4cG9zZSB0aGUgRUNDIGJp
dHMgaGFzIDggc2VjdGlvbnMgb2YgMTYgYnl0ZXMuDQo+Pj4gQnV0IHJlZ2FyZGluZyB0aGUgZGF0
YXNoZWV0IHRoaXMgc2hvdWxkIG5vdCBiZSBhY2Nlc3NlZCBwYWdlIDMyLg0KPj4+ICJUaGUgRUND
IHBhcml0eSBjb2RlIGdlbmVyYXRlZCBieSBpbnRlcm5hbCBFQ0MgaXMgc3RvcmVkIGluIGNvbHVt
bg0KPj4+IGFkZHJlc3NlcyA0MjI0LTQzNTEgYW5kIHRoZSB1c2VycyBjYW5ub3QgYWNjZXNzIHRv
IHRoZXNlIHNwZWNpZmljDQo+Pj4gYWRkcmVzc2VzIHdoZW4gaW50ZXJuYWwgRUNDIGlzIGVuYWJs
ZWQuIg0KPiANCj4gJ3doZW4gaW50ZXJuYWwgRUNDIGlzIGVuYWJsZWQnIG1lYW5zIHRoYXQgdGhv
c2UgYnl0ZXMgY2FuIGJlIGFjY2Vzc2VkDQo+IHdoZW4gaXQncyBkaXNhYmxlZC4gV2Ugc2hvdWxk
IGtlZXAgZXhwb3NpbmcgdGhlIEVDQyBieXRlIHNlY3Rpb25zLiBOb3RlDQo+IHRoYXQgZXZlbiBp
ZiBFQ0Mgc2VjdGlvbnMgYXJlIG5vdCBleHBvc2VkLCB0aGUgY29yZSB3aWxsIHJlYWQgdGhvc2UN
Cj4gYnl0ZXMuIFRoZXkncmUgcHJvYmFibHkgZmlsbGVkIHdpdGggZ2FyYmFnZSBpbiB0aGlzIGNh
c2UsIGJ1dCB3ZSBkb24ndA0KPiBjYXJlIHNpbmNlIHdlIHdvbid0IHVzZSB0aGVtLg0KPiANCj4+
DQo+PiBUaGlzIGlzIGp1c3QgdG8gbGV0IHRoZSBvdGhlciBsYXllcnMga25vdywgd2hlcmUgdGhl
IGJ5dGVzIHVzZWQgZm9yIEVDQw0KPj4gYXJlLiBBcyBsb25nIGFzIHRoZSBkcml2ZXIgdXNlcyB0
aGUgb24tY2hpcCBFQ0MgaXQgd29uJ3Qgd3JpdGUgdG8gdGhpcw0KPj4gYXJlYS4gU28gdGhpcyBp
cyBjb3JyZWN0IHVubGVzcyBJIG1pc3VuZGVyc3Rvb2QgdGhpcyBjb25jZXB0LiBBbGwgdGhlDQo+
PiBvdGhlciBzdXBwb3J0ZWQgU1BJIE5BTkQgY2hpcHMgdXNlIHRoZSBzYW1lIGFwcHJvYWNoLg0K
PiANCj4gWWVzLCBhbmQgdGhhdCdzIHRoZSByaWdodCB0aGluZyB0byBkby4gV2Ugd2FudCB0byBr
bm93IHdoZXJlIHRoZSBFQ0MNCj4gYnl0ZXMgYXJlLCBlc3BlY2lhbGx5IHdoZW4gZG9pbmcgcmF3
IGFjY2Vzc2VzLg0KDQpUaGFuayB5b3UgZm9yIGNsYXJpZnlpbmcgdGhpcy4gSSB3aWxsIHNlbmQg
YSB2MiBvZiBteSBwYXRjaCBhbmQgcmV2ZXJ0IA0KdGhpcyBjaGFuZ2UuDQoNClRoYW5rcywNCkZy
aWVkZXINCg0KPiANCj4+DQo+Pj4gICAgDQo+Pj4+PiArDQo+Pj4+PiArDQo+Pj4+PiArICAgICBy
ZXR1cm4gMDsNCj4+Pj4+ICt9DQo+Pj4+PiArDQo+Pj4+PiArc3RhdGljIGludCB0YzU4Y3ZnMnMw
aF9vb2JsYXlvdXRfZnJlZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50IHNlY3Rpb24sDQo+Pj4+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXRkX29vYl9yZWdp
b24gKnJlZ2lvbikNCj4+Pj4+ICt7DQo+Pj4+PiArICAgICBpZiAoc2VjdGlvbiA+IDcpDQo+Pj4+
PiArICAgICAgICAgICAgIHJldHVybiAtRVJBTkdFOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICAgcmVn
aW9uLT5vZmZzZXQgPSAyICsgMTYgKiBzZWN0aW9uOw0KPj4+Pj4gKyAgICAgcmVnaW9uLT5sZW5n
dGggPSAxNDsNCj4+Pg0KPj4+IFRoaXMgcmVzZXJ2ZWQgMiBieXRlcyBmb3IgQkJNIGZvciBlYWNo
IHNlY3Rpb24uDQo+Pj4gQnV0IG1heWJlIHdlIGNvdWxkIGRlY2xhcmUgdGhpcyBhcyAxIHNlY3Rp
b24gb2YgMTI4Ynl0ZXM6DQo+Pj4NCj4+PiBpZiAoc2VjdGlvbikNCj4+PiAgICAgICAgICAgIHJl
dHVybiAtRVJBTkdFOw0KPj4+DQo+Pj4gcmVnaW9uLT5vZmZzZXQgPSAyOw0KPj4+IHJlZ2lvbi0+
bGVuZ3RoID0gMTI2Ow0KPiANCj4gSSBhZ3JlZSB3aXRoIHRoaXMgc3VnZ2VzdGlvbjogaWYgdGhl
IGZyZWUgYnl0ZXMgYXJlIGNvbnRpZ3VvdXMsIGl0J3MNCj4gYmV0dGVyIHRvIGV4cG9zZSB0aGVt
IGFzIGEgc2luZ2xlIHNlY3Rpb24uDQo+IA==
