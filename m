Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B765AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8675C20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 14:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8675C20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbeK2B5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 20:57:44 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:55886 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeK2B5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 20:57:44 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id C412B67A7D5;
        Wed, 28 Nov 2018 15:55:45 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 28 Nov
 2018 15:55:45 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 28 Nov 2018 15:55:45 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Thread-Topic: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Thread-Index: AQHUhiUV+bbi1IymHUOKrtHQUP0AvaVlM7kAgAAEGQA=
Date:   Wed, 28 Nov 2018 14:55:45 +0000
Message-ID: <7634bb45-6167-31e8-e169-b5c9bf7e2fc5@kontron.de>
References: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
 <20181128154104.577d5923@bbrezillon>
In-Reply-To: <20181128154104.577d5923@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1C7C49255D6A542A08440A9CD6218C2@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: C412B67A7D5.AEE5A
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNCk9uIDI4LjExLjE4IDE1OjQxLCBCb3JpcyBCcmV6aWxsb24gd3JvdGU6DQo+
IE9uIFR1ZSwgMjcgTm92IDIwMTggMDc6NDQ6NTIgKzAwMDANCj4gU2NocmVtcGYgRnJpZWRlciA8
ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPiB3cm90ZToNCj4gDQo+PiBGaXggdGhlIHNpemUg
b2YgdGhlIGJ1ZmZlciBhbGxvY2F0ZWQgdG8gc3RvcmUgdGhlIGluLW1lbW9yeSBCQlQuDQo+PiBU
aGlzIGJ1ZyB3YXMgcHJldmlvdXNseSBoaWRkZW4gYnkgYSBkaWZmZXJlbnQgYnVnLCB0aGF0IHdh
cyBmaXhlZCBpbg0KPj4gZDA5ODA5M2JhMDZlLg0KPj4NCj4+IEZpeGVzOiA5YzM3MzZhM2RlMjEg
KCJtdGQ6IG5hbmQ6IEFkZCBjb3JlIGluZnJhc3RydWN0dXJlIHRvIGRlYWwgd2l0aCBOQU5EIGRl
dmljZXMiKQ0KPj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1i
eTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPiANCj4g
TG9va3MgbGlrZSB5b3VyIEZyb20gaGVhZGVyIGRvZXMgbm90IG1hdGNoIHRoZSBTb0IgdGFnDQo+
ICgnRnJpZWRlciBTY2hyZW1wZicgdnMgJ1NjaHJlbXBmIEZyaWVkZXInKSBhbmQgY2hlY2twYXRj
aCBkb2VzIG5vdCBsaWtlDQo+IHRoYXQuIEknbGwgZml4IGl0IHdoZW4gYXBwbHlpbmcsIGJ1dCBt
YXliZSB5b3Ugc2hvdWxkIGZpeA0KPiB5b3VyIC5naXRjb25maWcgdG8gbWFrZSB0aGVtIG1hdGNo
Lg0KDQpBY3R1YWxseSB0aGUgRnJvbSBoZWFkZXIgaW4gbXkgbG9jYWwgcGF0Y2ggaXMgY29ycmVj
dCAoPGZpcnN0IG5hbWU+IA0KPGxhc3QgbmFtZT4sIEZyaWVkZXIgU2NocmVtcGYpIGFzIGl0IGNv
bWVzIGZyb20gbXkgZ2l0IGNvbmZpZy4gQnV0IHNpbmNlIA0Kb3VyIGNvbXBhbnkgd2FzIHJlbmFt
ZWQgYW5kIG91ciBtYWlsIHNlcnZlcnMgd2VyZSB0cmFuc2ZlcnJlZCwgb3VyIA0KZS1tYWlscyBh
cmUgc2VudCB3aXRoIEZyb209PGxhc3QgbmFtZT4gPGZpcnN0IG5hbWU+Lg0KDQpJdCBzZWVtcyBs
aWtlIGdpdCBzZW5kLWVtYWlsIG9yIHBhdGNod29yayBvciB3aGF0ZXZlciB1c2VzIHRoZSANCmlu
Zm9ybWF0aW9uIGZyb20gdGhlIGUtbWFpbCBoZWFkZXIgaW5zdGVhZCBvZiB3aGF0IGlzIGluIHRo
ZSBwYXRjaC4NCg0KSSB3aWxsIHRyeSB0byByYWlzZSB0aGlzIGlzc3VlIHdpdGggb3VyIElUIGRl
cGFydG1lbnQgYXMgdGhpcyB3b3VsZCBiZSANCmJlc3QgZml4ZWQgb24gdGhlaXIgc2lkZS4NCg0K
VGhhbmtzLA0KRnJpZWRlcg0KDQo+IA0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbXRkL25hbmQvYmJ0
LmMgfCAzICsrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvYmJ0LmMgYi9kcml2
ZXJzL210ZC9uYW5kL2JidC5jDQo+PiBpbmRleCA1NmNkZTM4Li5jMTI0OTdmIDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9tdGQvbmFuZC9iYnQuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9i
YnQuYw0KPj4gQEAgLTI3LDcgKzI3LDggQEAgaW50IG5hbmRkZXZfYmJ0X2luaXQoc3RydWN0IG5h
bmRfZGV2aWNlICpuYW5kKQ0KPj4gICAJdW5zaWduZWQgaW50IG53b3JkcyA9IERJVl9ST1VORF9V
UChuYmxvY2tzICogYml0c19wZXJfYmxvY2ssDQo+PiAgIAkJCQkJICAgQklUU19QRVJfTE9ORyk7
DQo+PiAgIA0KPj4gLQluYW5kLT5iYnQuY2FjaGUgPSBremFsbG9jKG53b3JkcywgR0ZQX0tFUk5F
TCk7DQo+PiArCW5hbmQtPmJidC5jYWNoZSA9IGt6YWxsb2MobndvcmRzICogKEJJVFNfUEVSX0xP
TkcgLyBCSVRTX1BFUl9CWVRFKSwNCj4+ICsJCQkJICBHRlBfS0VSTkVMKTsNCj4+ICAgCWlmICgh
bmFuZC0+YmJ0LmNhY2hlKQ0KPj4gICAJCXJldHVybiAtRU5PTUVNOw0KPj4gICANCj4g
