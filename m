Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33DA2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33DA2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbeGRLWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:22:13 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:26753 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726869AbeGRLWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:22:13 -0400
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,370,1526335200"; 
   d="scan'208";a="34285486"
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
Subject: Re: [PATCH v4 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Topic: [PATCH v4 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Index: AQHUGDKQWWI1tXLeOU6HiRfwsL9pvqSUjGuAgAAqXwA=
Date:   Wed, 18 Jul 2018 10:44:52 +0000
Message-ID: <1531910692.6017.18.camel@diehl.com>
References: <20180710090710.9066-1-Denis.Osterland@diehl.com>
         <20180710090710.9066-3-Denis.Osterland@diehl.com>
         <20180718081313.GI3211@piout.net>
In-Reply-To: <20180718081313.GI3211@piout.net>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc3IS6AR/NFilMnzgm2Ves0ahI+udyIA6o5iqoQO19AhU
X-TNEFEvaluated: 1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <ED44C69EC80A27448F3F68A28901759B@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkFtIE1pdHR3b2NoLCBkZW4gMTguMDcuMjAxOCwgMTA6MTMgKzAyMDAgc2Nocmll
YiBBbGV4YW5kcmUgQmVsbG9uaToNCj4gT24gMTAvMDcvMjAxOCAwOTo0NDoxNSswMDAwLCBE
ZW5pcyBPU1RFUkxBTkQgd3JvdGU6DQo+ID7CoA0KPiA+ICsJaWYgKGlkLT5kcml2ZXJfZGF0
YSA9PSBUWVBFX0lTTDEyMTkpIHsNCj4gPiArCQlyYyA9IElTTDEyMTlfUkVHX0VWX0VWRU47
DQo+ID4gKwkJcmMgPSBpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNsaWVudCwgSVNMMTIx
OV9SRUdfRVYsIHJjKTsNCj4gSSdkIHBhc3MgSVNMMTIxOV9SRUdfRVZfRVZFTiBkaXJlY3Rs
eSBpbnN0ZWFkIG9mIGFzc2lnbmluZyBpdCB0byByYy4NCj4gDQpCZWNhdXNlIG9mIHRoZSA4
MCBjaGFyYWN0ZXIgbGltaXQgcGVyIHJvdywgSSB0aG91Z2h0IHRoaXM6DQrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJjID0gSVNMMTIxOV9SRUdfRVZfRVZFTjsNCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmMgPSBpMmNfc21idXNfd3JpdGVfYnl0ZV9k
YXRhKGNsaWVudCwgSVNMMTIxOV9SRUdfRVYsIHJjKTsNCndvdWxkIGxvb2sgbmljZXIgdGhh
biB0aGF0Og0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByYyA9IGkyY19zbWJ1
c193cml0ZV9ieXRlX2RhdGEoY2xpZW50LCBJU0wxMjE5X1JFR19FViwNCsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBJU0wxMjE5
X1JFR19FVl9FVkVOKTsNCkFyZSB0aGVyZSBhbnkgcmVhc29ucyB3aHkgSSBzaG91bGQgcHJl
ZmVyIHRoZSBzZWNvbmQgb25lPw0KDQpSZWdhcmRzIERlbmlzDQoNCkRpZWhsIENvbm5lY3Rp
dml0eSBTb2x1dGlvbnMgR21iSA0KR2VzY2jDpGZ0c2bDvGhydW5nOiBIb3JzdCBMZW9uYmVy
Z2VyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IE7DvHJuYmVyZyAtIFJlZ2lzdGVyZ2VyaWNo
dDogQW10c2dlcmljaHQNCk7DvHJuYmVyZzogSFJCIDMyMzE1DQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRGVyIEluaGFsdCBkZXIgdm9yc3Rl
aGVuZGVuIEUtTWFpbCBpc3QgbmljaHQgcmVjaHRsaWNoIGJpbmRlbmQuIERpZXNlIEUtTWFp
bCBlbnRoYWVsdCB2ZXJ0cmF1bGljaGUgdW5kL29kZXIgcmVjaHRsaWNoIGdlc2NodWV0enRl
IEluZm9ybWF0aW9uZW4uDQpJbmZvcm1pZXJlbiBTaWUgdW5zIGJpdHRlLCB3ZW5uIFNpZSBk
aWVzZSBFLU1haWwgZmFlbHNjaGxpY2hlcndlaXNlIGVyaGFsdGVuIGhhYmVuLiBCaXR0ZSBs
b2VzY2hlbiBTaWUgaW4gZGllc2VtIEZhbGwgZGllIE5hY2hyaWNodC4NCkplZGUgdW5lcmxh
dWJ0ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24sIEJla2FubnRnYWJlLCBBZW5kZXJ1bmcsIFZl
cnRlaWx1bmcgdW5kL29kZXIgUHVibGlrYXRpb24gZGllc2VyIEUtTWFpbCBpc3Qgc3RyZW5n
c3RlbnMgdW50ZXJzYWd0Lg0KVGhlIGNvbnRlbnRzIG9mIHRoZSBhYm92ZSBtZW50aW9uZWQg
ZS1tYWlsIGlzIG5vdCBsZWdhbGx5IGJpbmRpbmcuIFRoaXMgZS1tYWlsIGNvbnRhaW5zIGNv
bmZpZGVudGlhbCBhbmQvb3IgbGVnYWxseSBwcm90ZWN0ZWQgaW5mb3JtYXRpb24uIFBsZWFz
ZSBpbmZvcm0gdXMgaWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgYnkNCm1pc3Rh
a2UgYW5kIGRlbGV0ZSBpdCBpbiBzdWNoIGEgY2FzZS4gRWFjaCB1bmF1dGhvcml6ZWQgcmVw
cm9kdWN0aW9uLCBkaXNjbG9zdXJlLCBhbHRlcmF0aW9uLCBkaXN0cmlidXRpb24gYW5kL29y
IHB1YmxpY2F0aW9uIG9mIHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIA0K
