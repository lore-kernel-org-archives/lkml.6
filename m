Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8813C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75A220989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfA3NiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:38:06 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:53666 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3NiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:38:05 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 133CB67C52C;
        Wed, 30 Jan 2019 14:37:58 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Wed, 30 Jan
 2019 14:37:57 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Wed, 30 Jan 2019 14:37:57 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <bbrezillon@kernel.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] mtd: nand: Always store info about bad block
 markers in chip struct
Thread-Topic: [PATCH v3 1/5] mtd: nand: Always store info about bad block
 markers in chip struct
Thread-Index: AQHUuJvz9LZKjU9NdkCgOImqm/qQ2KXHvW4AgAACm4A=
Date:   Wed, 30 Jan 2019 13:37:57 +0000
Message-ID: <872cfbb0-f0dd-df25-4835-bb0cca3044cc@kontron.de>
References: <20190130130111.32724-1-frieder.schrempf@kontron.de>
 <20190130130111.32724-2-frieder.schrempf@kontron.de>
 <20190130142838.5590f8b4@bbrezillon>
In-Reply-To: <20190130142838.5590f8b4@bbrezillon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F7DB32BBC5F1B4DA87C94FDFF663BA5@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 133CB67C52C.A3712
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, kyungmin.park@samsung.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXMsDQoNClRoYW5rcyBmb3IgcmV2aWV3aW5nLg0KDQpPbiAzMC4wMS4xOSAxNDoyOCwg
Qm9yaXMgQnJlemlsbG9uIHdyb3RlOg0KPiBPbiBXZWQsIDMwIEphbiAyMDE5IDEzOjAxOjQ0ICsw
MDAwDQo+IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4gd3Jv
dGU6DQo+IA0KPj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250
cm9uLmRlPg0KPj4NCj4+IFRoZSBpbmZvcm1hdGlvbiBhYm91dCB3aGVyZSB0aGUgbWFudWZhY3R1
cmVyIHB1dHMgdGhlIGJhZCBibG9jaw0KPj4gbWFya2VycyBpbnNpZGUgdGhlIGJhZCBibG9jayBh
bmQgaW4gdGhlIE9PQiBkYXRhIGlzIHN0b3JlZCBpbg0KPj4gZGlmZmVyZW50IHBsYWNlcy4gTGV0
J3MgbW92ZSB0aGlzIGluZm9ybWF0aW9uIHRvIG5hbmRfY2hpcC5vcHRpb25zDQo+PiBhbmQgbmFu
ZF9jaGlwLmJhZGJsb2NrcG9zLg0KPj4NCj4+IEFzIHRoaXMgY2hpcC1zcGVjaWZpYyBpbmZvcm1h
dGlvbiBpcyBub3QgZGlyZWN0bHkgcmVsYXRlZCB0byB0aGUNCj4+IGJhZCBibG9jayB0YWJsZSAo
QkJUKSwgd2UgYWxzbyByZW5hbWUgdGhlIGZsYWdzIHRvIE5BTkRfQkJNXyouDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRl
Pg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2Jhc2UuYyB8
ICAyICstDQo+PiAgIGRyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2JidC5jICB8ICAy
ICstDQo+PiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYW1kLmMgICAgICAgICB8ICAyICst
DQo+PiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmFzZS5jICAgICAgICB8IDEyICsrKysr
Ky0tLS0tLQ0KPj4gICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX2JidC5jICAgICAgICAgfCAg
NCArKy0tDQo+PiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfZXNtdC5jICAgICAgICB8ICAy
ICstDQo+PiAgIGRyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfaHluaXguYyAgICAgICB8ICA0ICsr
LS0NCj4+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9tYWNyb25peC5jICAgIHwgIDIgKy0N
Cj4+ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9taWNyb24uYyAgICAgIHwgIDIgKy0NCj4+
ICAgZHJpdmVycy9tdGQvbmFuZC9yYXcvbmFuZF9zYW1zdW5nLmMgICAgIHwgIDQgKystLQ0KPj4g
ICBkcml2ZXJzL210ZC9uYW5kL3Jhdy9uYW5kX3Rvc2hpYmEuYyAgICAgfCAgMiArLQ0KPj4gICBk
cml2ZXJzL210ZC9uYW5kL3Jhdy9zaF9mbGN0bC5jICAgICAgICAgfCAgNCArKy0tDQo+PiAgIGlu
Y2x1ZGUvbGludXgvbXRkL2JibS5oICAgICAgICAgICAgICAgICB8IDE0ICstLS0tLS0tLS0tLS0t
DQo+PiAgIGluY2x1ZGUvbGludXgvbXRkL3Jhd25hbmQuaCAgICAgICAgICAgICB8IDE1ICsrKysr
KysrKysrKysrKw0KPiANCj4gTWlnaHQgYmUgYmV0dGVyIHRvIHNwbGl0IHRoYXQgaW4gMiBwYXRj
aGVzOg0KPiAtIHVwZGF0ZSBvbmVuYW5kIGxvZ2ljDQo+IC0gdXBkYXRlIHJhd25hbmQgbG9naWMN
Cg0KT2sNCg0KPiANCj4+ICAgMTQgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMzQg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvb25lbmFu
ZC9vbmVuYW5kX2Jhc2UuYyBiL2RyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2Jhc2Uu
Yw0KPj4gaW5kZXggNGNhNGIxOTRlN2Q3Li5kNjcwMWI4ZjAzMWYgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL210ZC9uYW5kL29uZW5hbmQvb25lbmFuZF9iYXNlLmMNCj4+ICsrKyBiL2RyaXZlcnMv
bXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2Jhc2UuYw0KPj4gQEAgLTI0NTgsNyArMjQ1OCw3IEBA
IHN0YXRpYyBpbnQgb25lbmFuZF9kZWZhdWx0X2Jsb2NrX21hcmtiYWQoc3RydWN0IG10ZF9pbmZv
ICptdGQsIGxvZmZfdCBvZnMpDQo+PiAgICAgICAgICAgICAgICAgICBiYm0tPmJidFtibG9jayA+
PiAyXSB8PSAweDAxIDw8ICgoYmxvY2sgJiAweDAzKSA8PCAxKTsNCj4+ICAgDQo+PiAgICAgICAg
ICAgLyogV2Ugd3JpdGUgdHdvIGJ5dGVzLCBzbyB3ZSBkb24ndCBoYXZlIHRvIG1lc3Mgd2l0aCAx
Ni1iaXQgYWNjZXNzICovDQo+PiAtICAgICAgICBvZnMgKz0gbXRkLT5vb2JzaXplICsgKGJibS0+
YmFkYmxvY2twb3MgJiB+MHgwMSk7DQo+PiArICAgICAgICBvZnMgKz0gbXRkLT5vb2JzaXplICsg
KHRoaXMtPmJhZGJsb2NrcG9zICYgfjB4MDEpOw0KPiANCj4gTG9va3MgbGlrZSB0aGUgLT5iYWRi
bG9ja3BvcyBmaWVsZCBkb2VzIG5vdCBleGlzdCBpbiBzdHJ1Y3QNCj4gb25lbmFuZF9jaGlwLCB3
aGljaCBtZWFucyB5b3UgZGlkbid0IGNvbXBpbGUgdGVzdCB0aGlzIHBhcnQgOy0pLg0KDQpIbSwg
aW5kZWVkLiBJIGZvcmdvdCB0byBlbmFibGUgb25lbmFuZCBpbiBteSBjb25maWcuIEkgd2lsbCBh
ZGQgdGhlIA0KZmllbGQgdG8gdGhlIG9uZW5hbmRfY2hpcCBzdHJ1Y3QsIHRvIGJlIGNvbnNpc3Rl
bnQgd2l0aCByYXduYW5kLg0KDQo+IA0KPj4gICAJLyogRklYTUUgOiBXaGF0IHRvIGRvIHdoZW4g
bWFya2luZyBTTEMgYmxvY2sgaW4gcGFydGl0aW9uDQo+PiAgIAkgKiAJICAgd2l0aCBNTEMgZXJh
c2VzaXplPyBGb3Igbm93LCBpdCBpcyBub3QgYWR2aXNhYmxlIHRvDQo+PiAgIAkgKgkgICBjcmVh
dGUgcGFydGl0aW9ucyBjb250YWluaW5nIGJvdGggU0xDIGFuZCBNTEMgcmVnaW9ucy4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL29uZW5hbmQvb25lbmFuZF9iYnQuYyBiL2RyaXZl
cnMvbXRkL25hbmQvb25lbmFuZC9vbmVuYW5kX2JidC5jDQo+PiBpbmRleCBkZGUyMDQ4NzkzN2Qu
Ljg4MGIwYWJkMzZjOCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvb25lbmFuZC9v
bmVuYW5kX2JidC5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9uYW5kL29uZW5hbmQvb25lbmFuZF9i
YnQuYw0KPj4gQEAgLTE5MSw3ICsxOTEsNyBAQCBzdGF0aWMgaW50IG9uZW5hbmRfc2Nhbl9iYnQo
c3RydWN0IG10ZF9pbmZvICptdGQsIHN0cnVjdCBuYW5kX2JidF9kZXNjciAqYmQpDQo+PiAgIAkJ
cmV0dXJuIC1FTk9NRU07DQo+PiAgIA0KPj4gICAJLyogU2V0IHRoZSBiYWQgYmxvY2sgcG9zaXRp
b24gKi8NCj4+IC0JYmJtLT5iYWRibG9ja3BvcyA9IE9ORU5BTkRfQkFEQkxPQ0tfUE9TOw0KPj4g
Kwl0aGlzLT5iYWRibG9ja3BvcyA9IE5BTkRfQkJNX1BPU19PTkVOQU5EOw0KPiANCj4gVGhpcyBz
aG91bGQgYmUgZG9uZSBpbiBvbmVuYW5kX2Jhc2UuYyBub3Qgb25lbmFuZF9iYnQuYy4NCg0KT2su
DQoNCj4gDQo+PiAgIA0KPj4gICAJLyogU2V0IGVyYXNlIHNoaWZ0ICovDQo+PiAgIAliYm0tPmJi
dF9lcmFzZV9zaGlmdCA9IHRoaXMtPmVyYXNlX3NoaWZ0Ow0KPiANCj4gLi4uDQo+IA0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmJ0LmMgYi9kcml2ZXJzL210ZC9u
YW5kL3Jhdy9uYW5kX2JidC5jDQo+PiBpbmRleCAxYjcyMmZlOTIxM2MuLjg2MmVhYTNhMDU1MiAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmJ0LmMNCj4+ICsrKyBi
L2RyaXZlcnMvbXRkL25hbmQvcmF3L25hbmRfYmJ0LmMNCj4+IEBAIC00NjYsNyArNDY2LDcgQEAg
c3RhdGljIGludCBjcmVhdGVfYmJ0KHN0cnVjdCBuYW5kX2NoaXAgKnRoaXMsIHVpbnQ4X3QgKmJ1
ZiwNCj4+ICAgDQo+PiAgIAlwcl9pbmZvKCJTY2FubmluZyBkZXZpY2UgZm9yIGJhZCBibG9ja3Nc
biIpOw0KPj4gICANCj4+IC0JaWYgKGJkLT5vcHRpb25zICYgTkFORF9CQlRfU0NBTjJORFBBR0Up
DQo+PiArCWlmICh0aGlzLT5vcHRpb25zICYgTkFORF9CQk1fU0VDT05EUEFHRSkNCj4+ICAgCQlu
dW1wYWdlcyA9IDI7DQo+PiAgIAllbHNlDQo+PiAgIAkJbnVtcGFnZXMgPSAxOw0KPj4gQEAgLTQ4
Nyw3ICs0ODcsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV9iYnQoc3RydWN0IG5hbmRfY2hpcCAqdGhp
cywgdWludDhfdCAqYnVmLA0KPj4gICAJCWZyb20gPSAobG9mZl90KXN0YXJ0YmxvY2sgPDwgdGhp
cy0+YmJ0X2VyYXNlX3NoaWZ0Ow0KPj4gICAJfQ0KPj4gICANCj4+IC0JaWYgKHRoaXMtPmJidF9v
cHRpb25zICYgTkFORF9CQlRfU0NBTkxBU1RQQUdFKQ0KPj4gKwlpZiAodGhpcy0+YmJ0X29wdGlv
bnMgJiBOQU5EX0JCTV9MQVNUUEFHRSkNCj4gDQo+IFlvdSdyZSBub3QgY2hlY2tpbmcgdGhlIHJp
Z2h0IGZpZWxkIGhlcmU6DQo+IA0KPiAJaWYgKHRoaXMtPm9wdGlvbnMgJiBOQU5EX0JCTV9MQVNU
UEFHRSkNCg0KSSB3aWxsIGZpeCB0aGlzLg0KDQpSZWdhcmRzLA0KRnJpZWRlcg0KDQo+IA0KPj4g
ICAJCWZyb20gKz0gbXRkLT5lcmFzZXNpemUgLSAobXRkLT53cml0ZXNpemUgKiBudW1wYWdlcyk7
DQo+PiAgIA0KPj4gICAJZm9yIChpID0gc3RhcnRibG9jazsgaSA8IG51bWJsb2NrczsgaSsrKSB7
