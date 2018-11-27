Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3B4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3B4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeK1CGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:06:24 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:38770 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeK1CGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:06:23 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id B66056796ED;
        Tue, 27 Nov 2018 16:08:08 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 27 Nov
 2018 16:08:08 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 27 Nov 2018 16:08:08 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Subject: Re: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Thread-Topic: [PATCH] mtd: nand: spi: Add initial support for Toshiba
 TC58CVG2S0H
Thread-Index: AQHUdz2L3HigzaAOUUKXPQ4ku2nhHqVjxsKA
Date:   Tue, 27 Nov 2018 15:08:08 +0000
Message-ID: <0fc1f198-0e87-01af-5a0e-3d21613c39f3@kontron.de>
References: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
In-Reply-To: <1541665796-21092-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A3DBA771F03544088578E9D3522BE08@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: B66056796ED.AF966
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

K0Nsw6ltZW50IFDDqXJvbg0KDQpIaSBDbMOpbWVudCwNCg0KRllJLCB0aGlzIGhhcyBhbHJlYWR5
IGJlZW4gbWVyZ2VkIHRvIG5hbmQvbmV4dC4NCg0KUmVnYXJkcywNCkZyaWVkZXINCg0KT24gMDgu
MTEuMTggMDk6MjksIEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6DQo+IEFkZCBtaW5pbWFsIHN1cHBv
cnQgZm9yIHRoZSBUb3NoaWJhIFRDNThDVkcyUzBIIFNQSSBOQU5EIGNoaXAuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+
DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbXRkL25hbmQvc3BpL01ha2VmaWxlICB8ICAgMiArLQ0KPiAg
IGRyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyAgICB8ICAgMSArDQo+ICAgZHJpdmVycy9tdGQv
bmFuZC9zcGkvdG9zaGliYS5jIHwgMTM2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiAgIGluY2x1ZGUvbGludXgvbXRkL3NwaW5hbmQuaCAgICB8ICAgMSArDQo+ICAgNCBm
aWxlcyBjaGFuZ2VkLCAxMzkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL01ha2VmaWxlIGIvZHJpdmVycy9tdGQvbmFu
ZC9zcGkvTWFrZWZpbGUNCj4gaW5kZXggYjc0ZTA3NC4uYmU1ZjczNSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9tdGQvbmFuZC9zcGkvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9z
cGkvTWFrZWZpbGUNCj4gQEAgLTEsMyArMSwzIEBADQo+ICAgIyBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMA0KPiAtc3BpbmFuZC1vYmpzIDo9IGNvcmUubyBtYWNyb25peC5vIG1pY3Jv
bi5vIHdpbmJvbmQubw0KPiArc3BpbmFuZC1vYmpzIDo9IGNvcmUubyBtYWNyb25peC5vIG1pY3Jv
bi5vIHRvc2hpYmEubyB3aW5ib25kLm8NCj4gICBvYmotJChDT05GSUdfTVREX1NQSV9OQU5EKSAr
PSBzcGluYW5kLm8NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyBi
L2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYw0KPiBpbmRleCAzMGY4MzY0Li44N2JkZjJhIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL3NwaS9jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy9tdGQvbmFuZC9zcGkvY29yZS5jDQo+IEBAIC03NjYsNiArNzY2LDcgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBuYW5kX29wcyBzcGluYW5kX29wcyA9IHsNCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0
IHNwaW5hbmRfbWFudWZhY3R1cmVyICpzcGluYW5kX21hbnVmYWN0dXJlcnNbXSA9IHsNCj4gICAJ
Jm1hY3Jvbml4X3NwaW5hbmRfbWFudWZhY3R1cmVyLA0KPiAgIAkmbWljcm9uX3NwaW5hbmRfbWFu
dWZhY3R1cmVyLA0KPiArCSZ0b3NoaWJhX3NwaW5hbmRfbWFudWZhY3R1cmVyLA0KPiAgIAkmd2lu
Ym9uZF9zcGluYW5kX21hbnVmYWN0dXJlciwNCj4gICB9Ow0KPiAgIA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9zaGliYS5jIGIvZHJpdmVycy9tdGQvbmFuZC9zcGkvdG9z
aGliYS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAuLjI5NGJjZjYN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL210ZC9uYW5kL3NwaS90b3NoaWJhLmMN
Cj4gQEAgLTAsMCArMSwxMzYgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wDQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChjKSAyMDE4IGV4Y2VldCBlbGVjdHJvbmljcyBH
bWJIDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTggS29udHJvbiBFbGVjdHJvbmljcyBHbWJIDQo+
ICsgKg0KPiArICogQXV0aG9yOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtv
bnRyb24uZGU+DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPg0KPiAr
I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L210ZC9zcGluYW5k
Lmg+DQo+ICsNCj4gKyNkZWZpbmUgU1BJTkFORF9NRlJfVE9TSElCQQkJMHg5OA0KPiArDQo+ICtz
dGF0aWMgU1BJTkFORF9PUF9WQVJJQU5UUyhyZWFkX2NhY2hlX3ZhcmlhbnRzLA0KPiArCQlTUElO
QU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1g0X09QKDAsIDEsIE5VTEwsIDApLA0KPiArCQlTUElO
QU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1gyX09QKDAsIDEsIE5VTEwsIDApLA0KPiArCQlTUElO
QU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX09QKHRydWUsIDAsIDEsIE5VTEwsIDApLA0KPiArCQlT
UElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX09QKGZhbHNlLCAwLCAxLCBOVUxMLCAwKSk7DQo+
ICsNCj4gK3N0YXRpYyBTUElOQU5EX09QX1ZBUklBTlRTKHdyaXRlX2NhY2hlX3ZhcmlhbnRzLA0K
PiArCQlTUElOQU5EX1BST0dfTE9BRCh0cnVlLCAwLCBOVUxMLCAwKSk7DQo+ICsNCj4gK3N0YXRp
YyBTUElOQU5EX09QX1ZBUklBTlRTKHVwZGF0ZV9jYWNoZV92YXJpYW50cywNCj4gKwkJU1BJTkFO
RF9QUk9HX0xPQUQoZmFsc2UsIDAsIE5VTEwsIDApKTsNCj4gKw0KPiArc3RhdGljIGludCB0YzU4
Y3ZnMnMwaF9vb2JsYXlvdXRfZWNjKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBpbnQgc2VjdGlvbiwN
Cj4gKwkJCQkgICAgIHN0cnVjdCBtdGRfb29iX3JlZ2lvbiAqcmVnaW9uKQ0KPiArew0KPiArCWlm
IChzZWN0aW9uID4gNykNCj4gKwkJcmV0dXJuIC1FUkFOR0U7DQo+ICsNCj4gKwlyZWdpb24tPm9m
ZnNldCA9IDEyOCArIDE2ICogc2VjdGlvbjsNCj4gKwlyZWdpb24tPmxlbmd0aCA9IDE2Ow0KPiAr
DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCB0YzU4Y3ZnMnMw
aF9vb2JsYXlvdXRfZnJlZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50IHNlY3Rpb24sDQo+ICsJ
CQkJICAgICAgc3RydWN0IG10ZF9vb2JfcmVnaW9uICpyZWdpb24pDQo+ICt7DQo+ICsJaWYgKHNl
Y3Rpb24gPiA3KQ0KPiArCQlyZXR1cm4gLUVSQU5HRTsNCj4gKw0KPiArCXJlZ2lvbi0+b2Zmc2V0
ID0gMiArIDE2ICogc2VjdGlvbjsNCj4gKwlyZWdpb24tPmxlbmd0aCA9IDE0Ow0KPiArDQo+ICsN
Cj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGRfb29i
bGF5b3V0X29wcyB0YzU4Y3ZnMnMwaF9vb2JsYXlvdXQgPSB7DQo+ICsJLmVjYyA9IHRjNThjdmcy
czBoX29vYmxheW91dF9lY2MsDQo+ICsJLmZyZWUgPSB0YzU4Y3ZnMnMwaF9vb2JsYXlvdXRfZnJl
ZSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBpbnQgdGM1OGN2ZzJzMGhfZWNjX2dldF9zdGF0dXMo
c3RydWN0IHNwaW5hbmRfZGV2aWNlICpzcGluYW5kLA0KPiArCQkJCSAgICAgIHU4IHN0YXR1cykN
Cj4gK3sNCj4gKwlzdHJ1Y3QgbmFuZF9kZXZpY2UgKm5hbmQgPSBzcGluYW5kX3RvX25hbmQoc3Bp
bmFuZCk7DQo+ICsJdTggbWJmID0gMDsNCj4gKwlzdHJ1Y3Qgc3BpX21lbV9vcCBvcCA9IFNQSU5B
TkRfR0VUX0ZFQVRVUkVfT1AoMHgzMCwgJm1iZik7DQo+ICsNCj4gKwlzd2l0Y2ggKHN0YXR1cyAm
IFNUQVRVU19FQ0NfTUFTSykgew0KPiArCWNhc2UgU1RBVFVTX0VDQ19OT19CSVRGTElQUzoNCj4g
KwkJcmV0dXJuIDA7DQo+ICsNCj4gKwljYXNlIFNUQVRVU19FQ0NfVU5DT1JfRVJST1I6DQo+ICsJ
CXJldHVybiAtRUJBRE1TRzsNCj4gKw0KPiArCWNhc2UgU1RBVFVTX0VDQ19IQVNfQklURkxJUFM6
DQo+ICsJCS8qDQo+ICsJCSAqIExldCdzIHRyeSB0byByZXRyaWV2ZSB0aGUgcmVhbCBtYXhpbXVt
IG51bWJlciBvZiBiaXRmbGlwcw0KPiArCQkgKiBpbiBvcmRlciB0byBhdm9pZCBmb3JjaW5nIHRo
ZSB3ZWFyLWxldmVsaW5nIGxheWVyIHRvIG1vdmUNCj4gKwkJICogZGF0YSBhcm91bmQgaWYgaXQn
cyBub3QgbmVjZXNzYXJ5Lg0KPiArCQkgKi8NCj4gKwkJaWYgKHNwaV9tZW1fZXhlY19vcChzcGlu
YW5kLT5zcGltZW0sICZvcCkpDQo+ICsJCQlyZXR1cm4gbmFuZC0+ZWNjcmVxLnN0cmVuZ3RoOw0K
PiArDQo+ICsJCW1iZiA+Pj0gNDsNCj4gKw0KPiArCQlpZiAoV0FSTl9PTihtYmYgPiBuYW5kLT5l
Y2NyZXEuc3RyZW5ndGggfHwgIW1iZikpDQo+ICsJCQlyZXR1cm4gbmFuZC0+ZWNjcmVxLnN0cmVu
Z3RoOw0KPiArDQo+ICsJCXJldHVybiBtYmY7DQo+ICsNCj4gKwlkZWZhdWx0Og0KPiArCQlicmVh
azsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gLUVJTlZBTDsNCj4gK30NCj4gKw0KPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBzcGluYW5kX2luZm8gdG9zaGliYV9zcGluYW5kX3RhYmxlW10gPSB7DQo+
ICsJU1BJTkFORF9JTkZPKCJUQzU4Q1ZHMlMwSCIsIDB4Q0QsDQo+ICsJCSAgICAgTkFORF9NRU1P
UkcoMSwgNDA5NiwgMjU2LCA2NCwgMjA0OCwgMSwgMSwgMSksDQo+ICsJCSAgICAgTkFORF9FQ0NS
RVEoOCwgNTEyKSwNCj4gKwkJICAgICBTUElOQU5EX0lORk9fT1BfVkFSSUFOVFMoJnJlYWRfY2Fj
aGVfdmFyaWFudHMsDQo+ICsJCQkJCSAgICAgICZ3cml0ZV9jYWNoZV92YXJpYW50cywNCj4gKwkJ
CQkJICAgICAgJnVwZGF0ZV9jYWNoZV92YXJpYW50cyksDQo+ICsJCSAgICAgU1BJTkFORF9IQVNf
UUVfQklULA0KPiArCQkgICAgIFNQSU5BTkRfRUNDSU5GTygmdGM1OGN2ZzJzMGhfb29ibGF5b3V0
LA0KPiArCQkJCSAgICAgdGM1OGN2ZzJzMGhfZWNjX2dldF9zdGF0dXMpKSwNCj4gK307DQo+ICsN
Cj4gK3N0YXRpYyBpbnQgdG9zaGliYV9zcGluYW5kX2RldGVjdChzdHJ1Y3Qgc3BpbmFuZF9kZXZp
Y2UgKnNwaW5hbmQpDQo+ICt7DQo+ICsJdTggKmlkID0gc3BpbmFuZC0+aWQuZGF0YTsNCj4gKwlp
bnQgcmV0Ow0KPiArDQo+ICsJLyoNCj4gKwkgKiBUb3NoaWJhIFNQSSBOQU5EIHJlYWQgSUQgbmVl
ZHMgYSBkdW1teSBieXRlLA0KPiArCSAqIHNvIHRoZSBmaXJzdCBieXRlIGluIGlkIGlzIGdhcmJh
Z2UuDQo+ICsJICovDQo+ICsJaWYgKGlkWzFdICE9IFNQSU5BTkRfTUZSX1RPU0hJQkEpDQo+ICsJ
CXJldHVybiAwOw0KPiArDQo+ICsJcmV0ID0gc3BpbmFuZF9tYXRjaF9hbmRfaW5pdChzcGluYW5k
LCB0b3NoaWJhX3NwaW5hbmRfdGFibGUsDQo+ICsJCQkJICAgICBBUlJBWV9TSVpFKHRvc2hpYmFf
c3BpbmFuZF90YWJsZSksDQo+ICsJCQkJICAgICBpZFsyXSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJ
cmV0dXJuIHJldDsNCj4gKw0KPiArCXJldHVybiAxOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IHNwaW5hbmRfbWFudWZhY3R1cmVyX29wcyB0b3NoaWJhX3NwaW5hbmRfbWFudWZf
b3BzID0gew0KPiArCS5kZXRlY3QgPSB0b3NoaWJhX3NwaW5hbmRfZGV0ZWN0LA0KPiArfTsNCj4g
Kw0KPiArY29uc3Qgc3RydWN0IHNwaW5hbmRfbWFudWZhY3R1cmVyIHRvc2hpYmFfc3BpbmFuZF9t
YW51ZmFjdHVyZXIgPSB7DQo+ICsJLmlkID0gU1BJTkFORF9NRlJfVE9TSElCQSwNCj4gKwkubmFt
ZSA9ICJUb3NoaWJhIiwNCj4gKwkub3BzID0gJnRvc2hpYmFfc3BpbmFuZF9tYW51Zl9vcHMsDQo+
ICt9Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpbmFuZC5oIGIvaW5jbHVk
ZS9saW51eC9tdGQvc3BpbmFuZC5oDQo+IGluZGV4IDA4OGZmOTYuLjgxNmM0YjAgMTAwNjQ0DQo+
IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL3NwaW5hbmQuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4
L210ZC9zcGluYW5kLmgNCj4gQEAgLTE5Niw2ICsxOTYsNyBAQCBzdHJ1Y3Qgc3BpbmFuZF9tYW51
ZmFjdHVyZXIgew0KPiAgIC8qIFNQSSBOQU5EIG1hbnVmYWN0dXJlcnMgKi8NCj4gICBleHRlcm4g
Y29uc3Qgc3RydWN0IHNwaW5hbmRfbWFudWZhY3R1cmVyIG1hY3Jvbml4X3NwaW5hbmRfbWFudWZh
Y3R1cmVyOw0KPiAgIGV4dGVybiBjb25zdCBzdHJ1Y3Qgc3BpbmFuZF9tYW51ZmFjdHVyZXIgbWlj
cm9uX3NwaW5hbmRfbWFudWZhY3R1cmVyOw0KPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCBzcGluYW5k
X21hbnVmYWN0dXJlciB0b3NoaWJhX3NwaW5hbmRfbWFudWZhY3R1cmVyOw0KPiAgIGV4dGVybiBj
b25zdCBzdHJ1Y3Qgc3BpbmFuZF9tYW51ZmFjdHVyZXIgd2luYm9uZF9zcGluYW5kX21hbnVmYWN0
dXJlcjsNCj4gICANCj4gICAvKioNCj4g
