Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEBAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960ED214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960ED214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.De
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbeKOVuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:50:44 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:55376 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeKOVuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:50:44 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id DD35E67A08D;
        Thu, 15 Nov 2018 12:43:05 +0100 (CET)
Received: from sntmail11s.snt-is.com (10.203.32.181) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 15 Nov
 2018 12:43:05 +0100
Received: from sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a]) by
 sntmail11s.snt-is.com ([fe80::b972:ad22:ada5:7c6a%4]) with mapi id
 15.01.1466.003; Thu, 15 Nov 2018 12:43:05 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.De>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Brown <broonie@kernel.org>, Han Xu <han.xu@nxp.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Prabhakar Kushwaha" <prabhakar.kushwaha@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Topic: [PATCH v5 3/9] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Thread-Index: AQHUe1dsObjF/PT8B0W0ex5X9UGX6qVO47aAgAADEgCAAAN+AIAAG+cAgAAGuQCAAUK+AIAAWaYA
Date:   Thu, 15 Nov 2018 11:43:05 +0000
Message-ID: <3e9aa917-cf3a-cf0e-8516-4e73d30eb2a1@kontron.de>
References: <1542116782-13118-1-git-send-email-frieder.schrempf@kontron.de>
 <1542116782-13118-4-git-send-email-frieder.schrempf@kontron.de>
 <VI1PR04MB572679944542ED6A438FD2FB99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <ce9cbfc0-3257-f117-aa21-cdee068579ce@kontron.de>
 <65577d13-b17d-8f69-313c-01d23240d1d9@kontron.de>
 <VI1PR04MB572664063A0E237D2EB7203A99C30@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <eb4b79be-c12b-16e7-e1dd-86a157cfdc7d@kontron.de>
 <VI1PR04MB57265222E26C013D5D9C009B99DC0@VI1PR04MB5726.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB57265222E26C013D5D9C009B99DC0@VI1PR04MB5726.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.42]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BB603BF787F11438470E8FAAE371820@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: DD35E67A08D.ADC4C
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com, broonie@kernel.org,
        computersforpeace@gmail.com, david.wolfe@nxp.com,
        dwmw2@infradead.org, fabio.estevam@nxp.com, han.xu@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, prabhakar.kushwaha@nxp.com,
        richard@nod.at, shawnguo@kernel.org, yogeshnarayan.gaur@nxp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMTEuMTggMDc6MjIsIFlvZ2VzaCBOYXJheWFuIEdhdXIgd3JvdGU6DQo+IEhpIEZyaWVk
ZXIsDQo+IA0KPiBXaXRoIGJlbG93IHBhdGNoIG9uIHRvcCBvZiB5b3VyIHY1LCBSZWFkL1dyaXRl
L0VyYXNlIG9uIENTMSBpcyB3b3JraW5nIGZpbmUgZm9yIG1lLg0KDQpPaywgYXJlIHlvdSBzdXJl
LCB0aGF0IEFIQiByZWFkIGlzIHdvcmtpbmcgdG9vIHdpdGggdGhpcyBwYXRjaD8NCllvdSBhcmUg
cmVtb3ZpbmcgdGhlIG1lbW1hcF9waHkgb2Zmc2V0IGZyb20gU0ZBUiBhbmQgdGhlIFNGWFhBRCBy
ZWdpc3RlciANCnZhbHVlcy4NCg0KSSBjYW4gdW5kZXJzdGFuZCB0aGF0IHNlbGVjdGlvbiBvZiB0
aGUgQ1MgYW5kIElQIGNvbW1hbmRzIHdpbGwgd29yayBsaWtlIA0KdGhpcywgYnV0IEkgY2FuJ3Qg
dW5kZXJzdGFuZCBob3cgQUhCIHJlYWQgc2hvdWxkIHdvcmsgd2l0aG91dCB0aGUgYmFzZSANCmFk
ZHJlc3Mgb2YgdGhlIG1hcHBlZCBtZW1vcnkuDQoNCkknbSBhZnJhaWQgSSBzdGlsbCBkb24ndCBm
dWxseSB1bmRlcnN0YW5kIHRoZSBiYWNrZ3JvdW5kIG9mIHRoZXNlIA0KdGhpbmdzLCBidXQgc3Rp
bGwgdGhhbmsgeW91IGZvciB0ZXN0aW5nLg0KDQo+IA0KPiBJIGhhdmUgdGVzdGVkIHdpdGggSkZG
UzIgbW91bnRpbmcgYW5kIGJvb3RpbmcgYWxzbyBmb3IgYm90aCBDUzAgYW5kIENTMS4NCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NwaS9zcGktZnNsLXFzcGkuYyBiL2RyaXZlcnMvc3BpL3Nw
aS1mc2wtcXNwaS5jDQo+IGluZGV4IGNlNDVlOGUuLjQ0Njc5ODMgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvc3BpL3NwaS1mc2wtcXNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvc3BpL3NwaS1mc2wtcXNw
aS5jDQo+IEBAIC00OTAsMjggKzQ5MCwxMCBAQCBzdGF0aWMgdm9pZCBmc2xfcXNwaV9zZWxlY3Rf
bWVtKHN0cnVjdCBmc2xfcXNwaSAqcSwgc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkNCj4gICB7DQo+
ICAgICAgICAgIHVuc2lnbmVkIGxvbmcgcmF0ZSA9IHNwaS0+bWF4X3NwZWVkX2h6Ow0KPiAgICAg
ICAgICBpbnQgcmV0LCBpOw0KPiAtICAgICAgIHUzMiBtYXBfYWRkcjsNCj4gDQo+ICAgICAgICAg
IGlmIChxLT5zZWxlY3RlZCA9PSBzcGktPmNoaXBfc2VsZWN0KQ0KPiAgICAgICAgICAgICAgICAg
IHJldHVybjsNCj4gDQo+IC0gICAgICAgLyoNCj4gLSAgICAgICAgKiBJbiBIVyB0aGVyZSBjYW4g
YmUgYSBtYXhpbXVtIG9mIGZvdXIgY2hpcHMgb24gdHdvIGJ1c2VzIHdpdGgNCj4gLSAgICAgICAg
KiB0d28gY2hpcCBzZWxlY3RzIG9uIGVhY2ggYnVzLiBXZSB1c2UgZm91ciBjaGlwIHNlbGVjdHMg
aW4gU1cNCj4gLSAgICAgICAgKiB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gdGhlIGZvdXIgY2hp
cHMuDQo+IC0gICAgICAgICogV2UgdXNlIHRoZSBTRkExQUQsIFNGQTJBRCwgU0ZCMUFELCBTRkIy
QUQgcmVnaXN0ZXJzIHRvIHNlbGVjdA0KPiAtICAgICAgICAqIHRoZSBjaGlwIHdlIHdhbnQgdG8g
YWNjZXNzLg0KPiAtICAgICAgICAqLw0KPiAtICAgICAgIGZvciAoaSA9IDA7IGkgPCA0OyBpKysp
IHsNCj4gLSAgICAgICAgICAgICAgIGlmIChpIDwgc3BpLT5jaGlwX3NlbGVjdCkNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgbWFwX2FkZHIgPSBxLT5tZW1tYXBfcGh5Ow0KPiAtICAgICAgICAg
ICAgICAgZWxzZQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICBtYXBfYWRkciA9IHEtPm1lbW1h
cF9waHkgKw0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIgKiBxLT5kZXZ0
eXBlX2RhdGEtPmFoYl9idWZfc2l6ZTsNCj4gLQ0KPiAtICAgICAgICAgICAgICAgcXNwaV93cml0
ZWwocSwgbWFwX2FkZHIsIHEtPmlvYmFzZSArIFFVQURTUElfU0ZBMUFEICsgKGkgKiA0KSk7DQo+
IC0gICAgICAgfQ0KPiAtDQo+ICAgICAgICAgIGlmIChuZWVkc180eF9jbG9jayhxKSkNCj4gICAg
ICAgICAgICAgICAgICByYXRlICo9IDQ7DQo+IA0KPiBAQCAtNTM0LDcgKzUxNiw5IEBAIHN0YXRp
YyB2b2lkIGZzbF9xc3BpX3NlbGVjdF9tZW0oc3RydWN0IGZzbF9xc3BpICpxLCBzdHJ1Y3Qgc3Bp
X2RldmljZSAqc3BpKQ0KPiANCj4gICBzdGF0aWMgdm9pZCBmc2xfcXNwaV9yZWFkX2FoYihzdHJ1
Y3QgZnNsX3FzcGkgKnEsIGNvbnN0IHN0cnVjdCBzcGlfbWVtX29wICpvcCkNCj4gICB7DQo+IC0g
ICAgICAgbWVtY3B5X2Zyb21pbyhvcC0+ZGF0YS5idWYuaW4sIHEtPmFoYl9hZGRyLCBvcC0+ZGF0
YS5uYnl0ZXMpOw0KPiArICAgICAgIG1lbWNweV9mcm9taW8ob3AtPmRhdGEuYnVmLmluLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgcS0+YWhiX2FkZHIgKyBxLT5zZWxlY3RlZCAqIHEtPmRldnR5
cGVfZGF0YS0+YWhiX2J1Zl9zaXplLA0KPiArICAgICAgICAgICAgICAgICAgICAgb3AtPmRhdGEu
bmJ5dGVzKTsNCj4gICB9DQo+IA0KPiAgIHN0YXRpYyB2b2lkIGZzbF9xc3BpX2ZpbGxfdHhmaWZv
KHN0cnVjdCBmc2xfcXNwaSAqcSwNCj4gQEAgLTYzNCw3ICs2MTgsOSBAQCBzdGF0aWMgaW50IGZz
bF9xc3BpX2V4ZWNfb3Aoc3RydWN0IHNwaV9tZW0gKm1lbSwgY29uc3Qgc3RydWN0IHNwaV9tZW1f
b3AgKm9wKQ0KPiANCj4gICAgICAgICAgZnNsX3FzcGlfc2VsZWN0X21lbShxLCBtZW0tPnNwaSk7
DQo+IA0KPiAtICAgICAgIHFzcGlfd3JpdGVsKHEsIHEtPm1lbW1hcF9waHksIGJhc2UgKyBRVUFE
U1BJX1NGQVIpOw0KPiArICAgICAgIHFzcGlfd3JpdGVsKHEsDQo+ICsgICAgICAgICAgICAgICAg
ICAgcS0+c2VsZWN0ZWQgKiBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9idWZfc2l6ZSwNCj4gKyAgICAg
ICAgICAgICAgICAgICBiYXNlICsgUVVBRFNQSV9TRkFSKTsNCj4gDQo+ICAgICAgICAgIHFzcGlf
d3JpdGVsKHEsIHFzcGlfcmVhZGwocSwgYmFzZSArIFFVQURTUElfTUNSKSB8DQo+ICAgICAgICAg
ICAgICAgICAgICAgIFFVQURTUElfTUNSX0NMUl9SWEZfTUFTSyB8IFFVQURTUElfTUNSX0NMUl9U
WEZfTUFTSywNCj4gQEAgLTczMyw2ICs3MTksMTkgQEAgc3RhdGljIGludCBmc2xfcXNwaV9kZWZh
dWx0X3NldHVwKHN0cnVjdCBmc2xfcXNwaSAqcSkNCj4gICAgICAgICAgICAgICAgICAgICAgUVVB
RFNQSV9CVUYzQ1JfQURBVFNaKHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplIC8gOCksDQo+
ICAgICAgICAgICAgICAgICAgICAgIGJhc2UgKyBRVUFEU1BJX0JVRjNDUik7DQo+IA0KPiArICAg
ICAgIC8qDQo+ICsgICAgICAgICogSW4gSFcgdGhlcmUgY2FuIGJlIGEgbWF4aW11bSBvZiBmb3Vy
IGNoaXBzIG9uIHR3byBidXNlcyB3aXRoDQo+ICsgICAgICAgICogdHdvIGNoaXAgc2VsZWN0cyBv
biBlYWNoIGJ1cy4gV2UgdXNlIGZvdXIgY2hpcCBzZWxlY3RzIGluIFNXDQo+ICsgICAgICAgICog
dG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIHRoZSBmb3VyIGNoaXBzLg0KPiArICAgICAgICAqIFdl
IHVzZSB0aGUgU0ZBMUFELCBTRkEyQUQsIFNGQjFBRCwgU0ZCMkFEIHJlZ2lzdGVycyB0byBzZWxl
Y3QNCj4gKyAgICAgICAgKiB0aGUgY2hpcCB3ZSB3YW50IHRvIGFjY2Vzcy4NCj4gKyAgICAgICAg
Ki8NCj4gKw0KPiArICAgICAgIHFzcGlfd3JpdGVsKHEsIHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1
Zl9zaXplLCBiYXNlICsgUVVBRFNQSV9TRkExQUQpOw0KPiArICAgICAgIHFzcGlfd3JpdGVsKHEs
IHEtPmRldnR5cGVfZGF0YS0+YWhiX2J1Zl9zaXplICogMiAsIGJhc2UgKyBRVUFEU1BJX1NGQTJB
RCk7DQo+ICsgICAgICAgcXNwaV93cml0ZWwocSwgcS0+ZGV2dHlwZV9kYXRhLT5haGJfYnVmX3Np
emUgKiAzICwgYmFzZSArIFFVQURTUElfU0ZCMUFEKTsNCj4gKyAgICAgICBxc3BpX3dyaXRlbChx
LCBxLT5kZXZ0eXBlX2RhdGEtPmFoYl9idWZfc2l6ZSAqIDQgLCBiYXNlICsgUVVBRFNQSV9TRkIy
QUQpOw0KPiArDQo+ICAgICAgICAgIHEtPnNlbGVjdGVkID0gLTE7DQo+IA0KPiAtLQ0KPiBSZWdh
cmRzDQo+IFlvZ2VzaCBHYXVyDQo+IA0KPiBbLi5dDQo+IA==
