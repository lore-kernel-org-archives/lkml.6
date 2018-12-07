Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33577C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EA620892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EA620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLGJbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:31:51 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:38200 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:31:51 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 4F7E967A1AA;
        Fri,  7 Dec 2018 10:31:48 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Fri, 7 Dec 2018
 10:31:47 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Fri, 7 Dec 2018 10:31:47 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peron.clem@gmail.com" <peron.clem@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3] mtd: spinand: Fix ECC status and OOB layout for
 Toshiba TC58CVG2S0H
Thread-Topic: [PATCH v3] mtd: spinand: Fix ECC status and OOB layout for
 Toshiba TC58CVG2S0H
Thread-Index: AQHUit5r+i/3AIRP0kKtRCmx1SJH2qVy32SAgAAZdIA=
Date:   Fri, 7 Dec 2018 09:31:47 +0000
Message-ID: <8e70737f-0780-d607-eadc-f6435288f660@kontron.de>
References: <1543823821-18352-1-git-send-email-frieder.schrempf@kontron.de>
 <20181207090041.6b8d9731@xps13>
In-Reply-To: <20181207090041.6b8d9731@xps13>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAF1D694DF93514797F313C830929559@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 4F7E967A1AA.AED86
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

SGkgTWlxdcOobCwNCg0KT24gMDcuMTIuMTggMDk6MDAsIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+
IEhpIFNjaHJlbXBmLCBDbMOpbWVudCwNCj4gDQo+IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIu
c2NocmVtcGZAa29udHJvbi5kZT4gd3JvdGUgb24gTW9uLCAzIERlYyAyMDE4DQo+IDA4OjAxOjM4
ICswMDAwOg0KPiANCj4+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZA
a29udHJvbi5kZT4NCj4+DQo+PiBXaGVuIHJlYWRpbmcgdGhlIHN0YXR1cyBvZiB0aGUgb24tY2hp
cCBFQ0MsIHRoZSBUb3NoaWJhIGNoaXAgcmV0dXJucw0KPj4gdHdvIGRpZmZlcmVudCBzdGF0ZXMg
Zm9yIHJlcG9ydGluZyBjb3JyZWN0ZWQgYml0ZmxpcHMuIFdlIHNob3VsZCBjaGVjaw0KPj4gZm9y
IGJvdGggb2YgdGhlbS4NCj4+DQo+PiBBbHNvIHJldHVybiB0aGUgZnJlZSBPT0IgYnl0ZXMgYXMg
b25lIGNvbnRpZ3VvdXMgYXJlYSwgaW5zdGVhZCBvZg0KPj4gbXVsdGlwbGUgc2VjdGlvbnMuDQo+
Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDbMOpbWVudCBQw6lyb24gPHBlcm9uLmNsZW1AZ21haWwuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBr
b250cm9uLmRlPg0KPj4gQWNrZWQtYnk6IENsw6ltZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFp
bC5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgZm9yIHYzOg0KPj4gPT09PT09PT09PT09PT09DQo+
PiAqIEFkZCBBY2tlZC1ieQ0KPj4gKiBBZGQgY29tbWVudCBmb3IgQkJNIGluIE9PQiBsYXlvdXQN
Cj4+DQo+PiBDaGFuZ2VzIGZvciB2MjoNCj4+ID09PT09PT09PT09PT09PQ0KPj4gKiBSZW1vdmUg
dGhlIGNoYW5nZXMgdG8gdGhlIEVDQyBieXRlcyBpbiB0aGUgT09CIGxheW91dA0KPj4gLS0tDQo+
PiAgIGRyaXZlcnMvbXRkL25hbmQvc3BpL3Rvc2hpYmEuYyB8IDExICsrKysrKy0tLS0tDQo+PiAg
IDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL3Rvc2hpYmEuYyBiL2RyaXZlcnMvbXRk
L25hbmQvc3BpL3Rvc2hpYmEuYw0KPj4gaW5kZXggMjk0YmNmNi4uMDgxMjY1NSAxMDA2NDQNCj4+
IC0tLSBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL3Rvc2hpYmEuYw0KPj4gKysrIGIvZHJpdmVycy9t
dGQvbmFuZC9zcGkvdG9zaGliYS5jDQo+PiBAQCAtMTEsNiArMTEsNyBAQA0KPj4gICAjaW5jbHVk
ZSA8bGludXgvbXRkL3NwaW5hbmQuaD4NCj4+ICAgDQo+PiAgICNkZWZpbmUgU1BJTkFORF9NRlJf
VE9TSElCQQkJMHg5OA0KPj4gKyNkZWZpbmUgVE9TSF9TVEFUVVNfRUNDX0hBU19CSVRGTElQU19U
CSgzIDw8IDQpDQo+PiAgIA0KPj4gICBzdGF0aWMgU1BJTkFORF9PUF9WQVJJQU5UUyhyZWFkX2Nh
Y2hlX3ZhcmlhbnRzLA0KPj4gICAJCVNQSU5BTkRfUEFHRV9SRUFEX0ZST01fQ0FDSEVfWDRfT1Ao
MCwgMSwgTlVMTCwgMCksDQo+PiBAQCAtMzMsMTkgKzM0LDE4IEBAIHN0YXRpYyBpbnQgdGM1OGN2
ZzJzMGhfb29ibGF5b3V0X2VjYyhzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgaW50IHNlY3Rpb24sDQo+
PiAgIAlyZWdpb24tPm9mZnNldCA9IDEyOCArIDE2ICogc2VjdGlvbjsNCj4+ICAgCXJlZ2lvbi0+
bGVuZ3RoID0gMTY7DQo+PiAgIA0KPj4gLQ0KPj4gICAJcmV0dXJuIDA7DQo+PiAgIH0NCj4+ICAg
DQo+PiAgIHN0YXRpYyBpbnQgdGM1OGN2ZzJzMGhfb29ibGF5b3V0X2ZyZWUoc3RydWN0IG10ZF9p
bmZvICptdGQsIGludCBzZWN0aW9uLA0KPj4gICAJCQkJICAgICAgc3RydWN0IG10ZF9vb2JfcmVn
aW9uICpyZWdpb24pDQo+PiAgIHsNCj4+IC0JaWYgKHNlY3Rpb24gPiA3KQ0KPj4gKwlpZiAoc2Vj
dGlvbiA+IDApDQo+PiAgIAkJcmV0dXJuIC1FUkFOR0U7DQo+PiAgIA0KPj4gLQlyZWdpb24tPm9m
ZnNldCA9IDIgKyAxNiAqIHNlY3Rpb247DQo+PiAtCXJlZ2lvbi0+bGVuZ3RoID0gMTQ7DQo+PiAt
DQo+PiArCS8qIDIgYnl0ZXMgcmVzZXJ2ZWQgZm9yIEJCTSAqLw0KPj4gKwlyZWdpb24tPm9mZnNl
dCA9IDI7DQo+PiArCXJlZ2lvbi0+bGVuZ3RoID0gMTI2Ow0KPj4gICANCj4+ICAgCXJldHVybiAw
Ow0KPj4gICB9DQo+PiBAQCAtNzAsNiArNzAsNyBAQCBzdGF0aWMgaW50IHRjNThjdmcyczBoX2Vj
Y19nZXRfc3RhdHVzKHN0cnVjdCBzcGluYW5kX2RldmljZSAqc3BpbmFuZCwNCj4+ICAgCQlyZXR1
cm4gLUVCQURNU0c7DQo+PiAgIA0KPj4gICAJY2FzZSBTVEFUVVNfRUNDX0hBU19CSVRGTElQUzoN
Cj4+ICsJY2FzZSBUT1NIX1NUQVRVU19FQ0NfSEFTX0JJVEZMSVBTX1Q6DQo+PiAgIAkJLyoNCj4+
ICAgCQkgKiBMZXQncyB0cnkgdG8gcmV0cmlldmUgdGhlIHJlYWwgbWF4aW11bSBudW1iZXIgb2Yg
Yml0ZmxpcHMNCj4+ICAgCQkgKiBpbiBvcmRlciB0byBhdm9pZCBmb3JjaW5nIHRoZSB3ZWFyLWxl
dmVsaW5nIGxheWVyIHRvIG1vdmUNCj4gDQo+IElmIHlvdSBkb24ndCBtaW5kLCBJIHdvdWxkIGxp
a2UgdG8gc3F1YXNoIHRoaXMgd2l0aCB0aGUgb3JpZ2luYWwgcGF0Y2guDQo+IFdoYXQgYWJvdXQg
YWxzbyBhZGRpbmcgQ2xlbWVudCdzIEFja2VkLWJ5IHRvIGl0Pw0KDQpTdXJlLCB5b3UgY2FuIHNx
dWFzaCB0aGlzIHdpdGggdGhlIG9yaWdpbmFsIHBhdGNoLiBBbmQgSSBndWVzcyBhZGRpbmcgDQpD
bMOpbWVudCdzIEFja2VkLWJ5IHdvdWxkIGJlIGFwcHJvcHJpYXRlLCB0b28uDQoNClRoYW5rcywN
CkZyaWVkZXI=
