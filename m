Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7951AECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F3C20858
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 07:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F3C20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeGRIYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:24:18 -0400
Received: from enterprise03.smtp.diehl.com ([193.201.238.214]:6721 "EHLO
        enterprise03.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728912AbeGRIYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:24:17 -0400
X-Greylist: delayed 597 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jul 2018 04:24:16 EDT
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,369,1526335200"; 
   d="scan'208";a="1553064"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 1/5] rtc: sysfs: facilitate attribute add to rtc device
Thread-Topic: [PATCH v4 1/5] rtc: sysfs: facilitate attribute add to rtc
 device
Thread-Index: AQHUGDKQ7gjvnwME1UyQbN8b3dTaxqSUfvwAgAADiYA=
Date:   Wed, 18 Jul 2018 07:37:47 +0000
Message-ID: <1531899467.6017.9.camel@diehl.com>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
         <20180710090710.9066-2-Denis.Osterland@diehl.com>
         <20180718072508.GG3211@piout.net>
In-Reply-To: <20180718072508.GG3211@piout.net>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc26g7IkGoKpJo6jEGE3cBJkHEtr4BfjwJVggEhgQsDgN
X-TNEFEvaluated: 1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <A1561C653B0AAF40BC0155DDE3A9F19E@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCnRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KQW0gTWl0dHdvY2gsIGRl
biAxOC4wNy4yMDE4LCAwOToyNSArMDIwMCBzY2hyaWViIEFsZXhhbmRyZSBCZWxsb25pOg0K
PiBIZWxsbywNCj4gDQo+IE9uIDEwLzA3LzIwMTggMDk6NDQ6MTUrMDAwMCwgRGVuaXMgT1NU
RVJMQU5EIHdyb3RlOg0KPiA+wqANCj4gPiArDQo+ID4gK3N0YXRpYyBzaXplX3QgcnRjX2dy
b3VwX2NvdW50KHN0cnVjdCBydGNfZGV2aWNlICpydGMpDQo+ID4gK3sNCj4gSSBkb24ndCBm
ZWVsIHRoaXMgZnVuY3Rpb24gaXMgbmVjZXNzYXJ5LCB5b3UgY2FuIGluY2x1ZGUgaXQgaW4g
X19ydGNfYWRkX2dyb3VwDQpJIHRoaW5rIHRoYXQgaXQgaXMgZWFzaWVyIHRvIHJlYWQsIGJ1
dCBzdXJlIEkgY2FuIGluY2x1ZGUgaXQuDQo+IA0KPiA+IA0KPiA+ICsNCj4gPiArc3RhdGlj
IGlubGluZSBpbnQNCj4gPiArX19ydGNfYWRkX2dyb3VwKHN0cnVjdCBydGNfZGV2aWNlICpy
dGMsIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmdycCkNCj4gPiArew0KPiA+ICsJ
c2l6ZV90IGNudCA9IHJ0Y19ncm91cF9jb3VudChydGMpOw0KPiA+ICsJY29uc3Qgc3RydWN0
IGF0dHJpYnV0ZV9ncm91cCAqKmdyb3VwcywgKipvbGQ7DQo+ID4gKw0KPiA+ICsJZ3JvdXBz
ID0gZGV2bV9remFsbG9jKCZydGMtPmRldiwgKGNudCsyKSpzaXplb2YoKmdyb3VwcyksIEdG
UF9LRVJORUwpOw0KPiBQbGVhc2UgdXNlIGRldm1fa2NhbGxvYw0Kb2theQ0KPiANCj4gPiAN
Cj4gPiArCWlmIChJU19FUlJfT1JfTlVMTChncm91cHMpKQ0KPiA+ICsJCXJldHVybiBQVFJf
RVJSKGdyb3Vwcyk7DQo+ID4gKwltZW1jcHkoZ3JvdXBzLCBydGMtPmRldi5ncm91cHMsIGNu
dCpzaXplb2YoKmdyb3VwcykpOw0KPiA+ICsJZ3JvdXBzW2NudF0gPSBncnA7DQo+ID4gKw0K
PiA+ICsJb2xkID0gcnRjLT5kZXYuZ3JvdXBzOw0KPiA+ICsJcnRjLT5kZXYuZ3JvdXBzID0g
Z3JvdXBzOw0KPiA+ICsJaWYgKG9sZCAhPSBydGNfYXR0cl9ncm91cHMpDQo+ID4gKwkJZGV2
bV9rZnJlZSgmcnRjLT5kZXYsIG9sZCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4g
K30NCj4gPiArDQo+ID4gK2ludCBydGNfYWRkX2dyb3VwKHN0cnVjdCBydGNfZGV2aWNlICpy
dGMsIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKmdycCkNCj4gPiArew0KPiA+ICsJ
cmV0dXJuIHJ0Yy0+ZGV2LmtvYmouc3RhdGVfaW5fc3lzZnMgPw0KPiA+ICsJCWRldm1fZGV2
aWNlX2FkZF9ncm91cCgmcnRjLT5kZXYsIGdycCkgOg0KPiA+ICsJCV9fcnRjX2FkZF9ncm91
cChydGMsIGdycCk7DQo+IFVzaW5nIGRldm1fZGV2aWNlX2FkZF9ncm91cCBhZnRlciBSVEMg
cmVnaXN0cmF0aW9uIGlzIHJhY3kgYW5kIHNob3VsZA0KPiBub3QgYmUgYWxsb3dlZC4gSSB3
b3VsZCBtZXJnZSBfX3J0Y19hZGRfZ3JvdXAgaW4gcnRjX2FkZF9ncm91cCBhbmQNCj4gcmV0
dXJuIGFuIGVycm9yIGlmIHJ0Yy0+cmVnaXN0ZXJlZCBpcyB0cnVlLg0KWW91IGFyZSByaWdo
dC4gQW4gZXJyb3IgaW4gdGhpcyBjYXNlIGlzIGJldHRlci4NCj4gDQo+IA0KDQpSZWdhcmRz
IERlbmlzDQoNCkRpZWhsIENvbm5lY3Rpdml0eSBTb2x1dGlvbnMgR21iSA0KR2VzY2jDpGZ0
c2bDvGhydW5nOiBIb3JzdCBMZW9uYmVyZ2VyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IE7D
vHJuYmVyZyAtIFJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQNCk7DvHJuYmVyZzogSFJC
IDMyMzE1DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18N
Cg0KRGVyIEluaGFsdCBkZXIgdm9yc3RlaGVuZGVuIEUtTWFpbCBpc3QgbmljaHQgcmVjaHRs
aWNoIGJpbmRlbmQuIERpZXNlIEUtTWFpbCBlbnRoYWVsdCB2ZXJ0cmF1bGljaGUgdW5kL29k
ZXIgcmVjaHRsaWNoIGdlc2NodWV0enRlIEluZm9ybWF0aW9uZW4uDQpJbmZvcm1pZXJlbiBT
aWUgdW5zIGJpdHRlLCB3ZW5uIFNpZSBkaWVzZSBFLU1haWwgZmFlbHNjaGxpY2hlcndlaXNl
IGVyaGFsdGVuIGhhYmVuLiBCaXR0ZSBsb2VzY2hlbiBTaWUgaW4gZGllc2VtIEZhbGwgZGll
IE5hY2hyaWNodC4NCkplZGUgdW5lcmxhdWJ0ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24sIEJl
a2FubnRnYWJlLCBBZW5kZXJ1bmcsIFZlcnRlaWx1bmcgdW5kL29kZXIgUHVibGlrYXRpb24g
ZGllc2VyIEUtTWFpbCBpc3Qgc3RyZW5nc3RlbnMgdW50ZXJzYWd0Lg0KVGhlIGNvbnRlbnRz
IG9mIHRoZSBhYm92ZSBtZW50aW9uZWQgZS1tYWlsIGlzIG5vdCBsZWdhbGx5IGJpbmRpbmcu
IFRoaXMgZS1tYWlsIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBhbmQvb3IgbGVnYWxseSBwcm90
ZWN0ZWQgaW5mb3JtYXRpb24uIFBsZWFzZSBpbmZvcm0gdXMgaWYgeW91IGhhdmUgcmVjZWl2
ZWQgdGhpcyBlLW1haWwgYnkNCm1pc3Rha2UgYW5kIGRlbGV0ZSBpdCBpbiBzdWNoIGEgY2Fz
ZS4gRWFjaCB1bmF1dGhvcml6ZWQgcmVwcm9kdWN0aW9uLCBkaXNjbG9zdXJlLCBhbHRlcmF0
aW9uLCBkaXN0cmlidXRpb24gYW5kL29yIHB1YmxpY2F0aW9uIG9mIHRoaXMgZS1tYWlsIGlz
IHN0cmljdGx5IHByb2hpYml0ZWQuIA0K
