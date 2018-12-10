Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E828C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CACF720870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 10:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACF720870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbeLJKfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 05:35:42 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:55586 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJKfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 05:35:42 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 5158167A868;
        Mon, 10 Dec 2018 11:35:36 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 10 Dec
 2018 11:35:35 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Mon, 10 Dec 2018 11:35:35 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Topic: [PATCH v5 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Thread-Index: AQHUfZ16K+V2Xzw84ki+MmwTwSKgB6VxfoaAgAZOooCAAA8EgA==
Date:   Mon, 10 Dec 2018 10:35:35 +0000
Message-ID: <b616a9c7-40cf-d2da-b164-0d56a82c6cbc@kontron.de>
References: <1542366701-16065-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1542366701-16065-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <eb8a31d8-2ba6-f27c-addf-545c77921b77@kontron.de>
 <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB57267D9F69719B4BEF38BF8699A50@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <09BA064FA0EDFB4488DEE315E521920F@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 5158167A868.AF09A
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh@kernel.org,
        shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWW9nZXNoLA0KDQpPbiAxMC4xMi4xOCAxMDo0MSwgWW9nZXNoIE5hcmF5YW4gR2F1ciB3cm90
ZToNClsuLi5dPj4+ICsNCj4+PiArc3RhdGljIHZvaWQgbnhwX2ZzcGlfcHJlcGFyZV9sdXQoc3Ry
dWN0IG54cF9mc3BpICpmLA0KPj4+ICsJCQkJIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCkN
Cj4+PiArew0KPj4+ICsJdm9pZCBfX2lvbWVtICpiYXNlID0gZi0+aW9iYXNlOw0KPj4+ICsJdTMy
IGx1dHZhbFs0XSA9IHt9Ow0KPj4+ICsJaW50IGx1dGlkeCA9IDEsIGk7DQo+Pj4gKw0KPj4+ICsJ
LyogY21kICovDQo+Pj4gKwlsdXR2YWxbMF0gfD0gTFVUX0RFRigwLCBMVVRfQ01ELCBMVVRfUEFE
KG9wLT5jbWQuYnVzd2lkdGgpLA0KPj4+ICsJCQkgICAgIG9wLT5jbWQub3Bjb2RlKTsNCj4+PiAr
DQo+Pj4gKwkvKiBhZGRyIGJ1cyB3aWR0aCAqLw0KDQpUaGlzIGNvbW1lbnQgc2hvdWxkIG1hdGNo
IHRoZSBjb2RlIGJlbG93LiBTbyBtYXliZSBvbmx5ICJhZGRyIiBzaG91bGQgYmUgDQplbm91Z2gu
DQoNCj4+PiArCWlmIChvcC0+YWRkci5uYnl0ZXMpIHsNCj4+PiArCQl1MzIgYWRkcmxlbiA9IDA7
DQo+Pj4gKw0KPj4+ICsJCXN3aXRjaCAob3AtPmFkZHIubmJ5dGVzKSB7DQo+Pj4gKwkJY2FzZSAx
Og0KPj4+ICsJCQlhZGRybGVuID0gQUREUjhCSVQ7DQo+Pj4gKwkJCWJyZWFrOw0KPj4+ICsJCWNh
c2UgMjoNCj4+PiArCQkJYWRkcmxlbiA9IEFERFIxNkJJVDsNCj4+PiArCQkJYnJlYWs7DQo+Pj4g
KwkJY2FzZSAzOg0KPj4+ICsJCQlhZGRybGVuID0gQUREUjI0QklUOw0KPj4+ICsJCQlicmVhazsN
Cj4+PiArCQljYXNlIDQ6DQo+Pj4gKwkJCWFkZHJsZW4gPSBBRERSMzJCSVQ7DQo+Pj4gKwkJCWJy
ZWFrOw0KPj4+ICsJCWRlZmF1bHQ6DQo+Pj4gKwkJCWRldl9lcnIoZi0+ZGV2LCAiSW4tY29ycmVj
dCBhZGRyZXNzIGxlbmd0aFxuIik7DQo+Pj4gKwkJCXJldHVybjsNCj4+PiArCQl9DQo+Pg0KPj4g
WW91IGRvbid0IG5lZWQgdG8gdmFsaWRhdGUgb3AtPmFkZHIubmJ5dGVzIGhlcmUsIHRoaXMgaXMg
YWxyZWFkeSBkb25lIGluDQo+PiBueHBfZnNwaV9zdXBwb3J0c19vcCgpLg0KPiANCj4gWWVzLCBJ
IG5lZWQgdG8gdmFsaWRhdGUgb3AtPmFkZHIubmJ5dGVzIGVsc2UgTFVUIHdvdWxkIGdvaW5nIHRv
IGJlIHByb2dyYW1tZWQgZm9yIDAgYWRkcmxlbi4NCj4gSSBoYXZlIGNoZWNrZWQgdGhpcyBvbiB0
aGUgdGFyZ2V0Lg0KPiANCj4+DQo+Pj4gKw0KPj4+ICsJCWx1dHZhbFtsdXRpZHggLyAyXSB8PSBM
VVRfREVGKGx1dGlkeCwgTFVUX0FERFIsDQo+Pj4gKwkJCQkJICAgICAgTFVUX1BBRChvcC0+YWRk
ci5idXN3aWR0aCksDQo+Pj4gKwkJCQkJICAgICAgYWRkcmxlbik7DQo+Pg0KPj4gWW91IGNhbiBh
bHNvIGp1c3QgcmVtb3ZlIHRoZSB3aG9sZSBzd2l0Y2ggc3RhdGVtZW50IGFib3ZlIGFuZCB1c2Ug
dGhpczoNCj4+DQo+PiBsdXR2YWxbbHV0aWR4IC8gMl0gfD0gTFVUX0RFRihsdXRpZHgsIExVVF9B
RERSLA0KPj4gCQkJICAgICAgTFVUX1BBRChvcC0+YWRkci5idXN3aWR0aCksDQo+PiAJCQkgICAg
ICBvcC0+YWRkci5uYnl0ZXMgKiA4KTsNCj4+DQo+IE9rLCB3b3VsZCBpbmNsdWRlIGluIG5leHQg
dmVyc2lvbi4NCj4gDQo+Pj4gKwkJbHV0aWR4Kys7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJLyog
ZHVtbXkgYnl0ZXMsIGlmIG5lZWRlZCAqLw0KPj4+ICsJaWYgKG9wLT5kdW1teS5uYnl0ZXMpIHsN
Cj4+PiArCQlsdXR2YWxbbHV0aWR4IC8gMl0gfD0gTFVUX0RFRihsdXRpZHgsIExVVF9EVU1NWSwN
Cj4+PiArCQkvKg0KPj4+ICsJCSAqIER1ZSB0byBGbGV4U1BJIGNvbnRyb2xsZXIgbGltaXRhdGlv
biBudW1iZXIgb2YgUEFEIGZvcg0KPj4gZHVtbXkNCj4+PiArCQkgKiBidXN3aWR0aCBuZWVkcyB0
byBiZSBwcm9ncmFtbWVkIGFzIGVxdWFsIHRvIGRhdGEgYnVzd2lkdGguDQo+Pj4gKwkJICovDQo+
Pj4gKwkJCQkJICAgICAgTFVUX1BBRChvcC0+ZGF0YS5idXN3aWR0aCksDQo+Pj4gKwkJCQkJICAg
ICAgb3AtPmR1bW15Lm5ieXRlcyAqIDggLw0KPj4+ICsJCQkJCSAgICAgIG9wLT5kdW1teS5idXN3
aWR0aCk7DQo+Pj4gKwkJbHV0aWR4Kys7DQo+Pj4gKwl9DQo+Pj4gKw0KPj4+ICsJLyogcmVhZC93
cml0ZSBkYXRhIGJ5dGVzICovDQo+Pj4gKwlpZiAob3AtPmRhdGEubmJ5dGVzKSB7DQo+Pj4gKwkJ
bHV0dmFsW2x1dGlkeCAvIDJdIHw9IExVVF9ERUYobHV0aWR4LA0KPj4+ICsJCQkJCSAgICAgIG9w
LT5kYXRhLmRpciA9PQ0KPj4gU1BJX01FTV9EQVRBX0lOID8NCj4+PiArCQkJCQkgICAgICBMVVRf
TlhQX1JFQUQgOiBMVVRfTlhQX1dSSVRFLA0KPj4+ICsJCQkJCSAgICAgIExVVF9QQUQob3AtPmRh
dGEuYnVzd2lkdGgpLA0KPj4+ICsJCQkJCSAgICAgIDApOw0KPj4+ICsJCWx1dGlkeCsrOw0KPj4+
ICsJfQ0KPj4+ICsNCj4+PiArCS8qIHN0b3AgY29uZGl0aW9uLiAqLw0KPj4+ICsJbHV0dmFsW2x1
dGlkeCAvIDJdIHw9IExVVF9ERUYobHV0aWR4LCBMVVRfU1RPUCwgMCwgMCk7DQo+Pj4gKw0KPj4+
ICsJLyogdW5sb2NrIExVVCAqLw0KPj4+ICsJZnNwaV93cml0ZWwoZiwgRlNQSV9MVVRLRVlfVkFM
VUUsIGYtPmlvYmFzZSArIEZTUElfTFVUS0VZKTsNCj4+PiArCWZzcGlfd3JpdGVsKGYsIEZTUElf
TENLRVJfVU5MT0NLLCBmLT5pb2Jhc2UgKyBGU1BJX0xDS0NSKTsNCj4+PiArDQo+Pj4gKwkvKiBm
aWxsIExVVCAqLw0KPj4+ICsJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUobHV0dmFsKTsgaSsr
KQ0KPj4+ICsJCWZzcGlfd3JpdGVsKGYsIGx1dHZhbFtpXSwgYmFzZSArIEZTUElfTFVUX1JFRyhp
KSk7DQo+Pj4gKw0KPj4+ICsJZGV2X2RiZyhmLT5kZXYsICJDTURbJXhdIGx1dHZhbFswOiV4IFx0
IDE6JXggXHQgMjoleCBcdCAzOiV4XVxuIiwNCj4+PiArCQlvcC0+Y21kLm9wY29kZSwgbHV0dmFs
WzBdLCBsdXR2YWxbMV0sIGx1dHZhbFsyXSwgbHV0dmFsWzNdKTsNCj4+PiArDQo+Pj4gKwkvKiBs
b2NrIExVVCAqLw0KPj4+ICsJZnNwaV93cml0ZWwoZiwgRlNQSV9MVVRLRVlfVkFMVUUsIGYtPmlv
YmFzZSArIEZTUElfTFVUS0VZKTsNCj4+PiArCWZzcGlfd3JpdGVsKGYsIEZTUElfTENLRVJfTE9D
SywgZi0+aW9iYXNlICsgRlNQSV9MQ0tDUik7IH0NClsuLi5dDQo+Pj4gKw0KPj4+ICtzdGF0aWMg
aW50IG54cF9mc3BpX2V4ZWNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwgY29uc3Qgc3RydWN0DQo+
Pj4gK3NwaV9tZW1fb3AgKm9wKSB7DQo+Pj4gKwlzdHJ1Y3QgbnhwX2ZzcGkgKmYgPSBzcGlfY29u
dHJvbGxlcl9nZXRfZGV2ZGF0YShtZW0tPnNwaS0+bWFzdGVyKTsNCj4+PiArCWludCBlcnIgPSAw
Ow0KPj4+ICsNCj4+PiArCW11dGV4X2xvY2soJmYtPmxvY2spOw0KPj4+ICsNCj4+PiArCS8qIFdh
aXQgZm9yIGNvbnRyb2xsZXIgYmVpbmcgcmVhZHkuICovDQo+Pj4gKwllcnIgPSBmc3BpX3JlYWRs
X3BvbGxfdG91dChmLCBmLT5pb2Jhc2UgKyBGU1BJX1NUUzAsDQo+Pj4gKwkJCQkgICBGU1BJX1NU
UzBfQVJCX0lETEUsIDEsIFBPTExfVE9VVCwgdHJ1ZSk7DQo+Pj4gKwlXQVJOX09OKGVycik7DQo+
Pj4gKw0KPj4+ICsJbnhwX2ZzcGlfc2VsZWN0X21lbShmLCBtZW0tPnNwaSk7DQo+Pj4gKw0KPj4+
ICsJbnhwX2ZzcGlfcHJlcGFyZV9sdXQoZiwgb3ApOw0KPj4+ICsJLyoNCj4+PiArCSAqIElmIHdl
IGhhdmUgbGFyZ2UgY2h1bmtzIG9mIGRhdGEsIHdlIHJlYWQgdGhlbSB0aHJvdWdoIHRoZSBBSEIg
YnVzDQo+Pj4gKwkgKiBieSBhY2Nlc3NpbmcgdGhlIG1hcHBlZCBtZW1vcnkuIEluIGFsbCBvdGhl
ciBjYXNlcyB3ZSB1c2UNCj4+PiArCSAqIElQIGNvbW1hbmRzIHRvIGFjY2VzcyB0aGUgZmxhc2gu
DQo+Pj4gKwkgKi8NCj4+PiArCWlmIChvcC0+ZGF0YS5uYnl0ZXMgPiAoZi0+ZGV2dHlwZV9kYXRh
LT5yeGZpZm8gLSA0KSAmJg0KPj4+ICsJICAgIG9wLT5kYXRhLmRpciA9PSBTUElfTUVNX0RBVEFf
SU4pIHsNCj4+PiArCQlueHBfZnNwaV9yZWFkX2FoYihmLCBvcCk7DQo+Pj4gKwl9IGVsc2Ugew0K
Pj4+ICsJCWlmIChvcC0+ZGF0YS5uYnl0ZXMgJiYgb3AtPmRhdGEuZGlyID09IFNQSV9NRU1fREFU
QV9PVVQpDQo+Pj4gKwkJCW54cF9mc3BpX2ZpbGxfdHhmaWZvKGYsIG9wKTsNCj4+PiArDQo+Pj4g
KwkJZXJyID0gbnhwX2ZzcGlfZG9fb3AoZiwgb3ApOw0KPj4+ICsNCj4+PiArCQkvKiBJbnZhbGlk
YXRlIHRoZSBkYXRhIGluIHRoZSBBSEIgYnVmZmVyLiAqLw0KPj4+ICsJCWlmIChvcC0+ZGF0YS5u
Ynl0ZXMgJiYgb3AtPmRhdGEuZGlyID09IFNQSV9NRU1fREFUQV9PVVQpDQo+Pj4gKwkJCW54cF9m
c3BpX2ludmFsaWQoZik7DQo+Pg0KPj4gRS5nLiBpbiBjYXNlIG9mIGFuIGVyYXNlIG9wZXJhdGlv
biBvciBhIE5BTkQgbG9hZCBwYWdlIG9wZXJhdGlvbiwgdGhlDQo+PiBpbnZhbGlkYXRpb24gaXMg
bm90IHRyaWdnZXJlZCwgYnV0IGZsYXNoL2J1ZmZlciBjb250ZW50cyBoYXZlIGNoYW5nZWQuDQo+
PiBTbyBJJ20gbm90IHN1cmUgaWYgdGhpcyBpcyBlbm91Z2guLi4NCj4gT2ssIHdvdWxkIGNoYW5n
ZSB0aGlzIGFuZCBoYXZlIGludmFsaWRhdGUgZm9yIGFsbCBvcGVyYXRpb25zLg0KDQpNYXliZSB5
b3UgY2FuIGZpbmQgb3V0IHRoZSBjb3JyZWN0IHdheSB0aHJvdWdoIHRlc3Rpbmcgd2l0aCBOT1Ig
YW5kIE5BTkQu
