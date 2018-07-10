Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD98C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CD4208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CD4208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=diehl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933447AbeGJOHt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:07:49 -0400
Received: from enterprise02.smtp.diehl.com ([193.201.238.220]:35592 "EHLO
        enterprise02.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933248AbeGJOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:07:47 -0400
X-$ESA-Groupmapping: true
X-IronPort-AV: E=Sophos;i="5.51,334,1526335200"; 
   d="scan'";a="34027571"
From:   Denis OSTERLAND <denis.osterland@diehl.com>
To:     "lkp@intel.com" <lkp@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v4 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Topic: [PATCH v4 2/5] rtc: isl1208: add support for isl1219 with tamper
 detection
Thread-Index: AQHUGDKQWWI1tXLeOU6HiRfwsL9pvqSIT4MAgAANFgA=
Date:   Tue, 10 Jul 2018 14:06:57 +0000
Message-ID: <1531231616.7366.2.camel@diehl.com>
References: <20180710090710.9066-3-Denis.Osterland@diehl.com>
         <201807102100.7IWfwFfW%fengguang.wu@intel.com>
In-Reply-To: <201807102100.7IWfwFfW%fengguang.wu@intel.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: 415AWy8o668fDtCxszluzzk90jytLqG5wVLAY6WnVDNNBAa63Oo/QlRqTebX2d+c
X-TNEFEvaluated: 1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-ID: <E3167535FD5AFB41B9C55D2C3830842C@diehl.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCnNlZW1zIDIvNSB3YXMgYXBwbGllZCBiZWZvcmUgMS81Lg0KMS81IGludHJvZHVj
ZXMgcnRjX2FkZF9ncm91cC4NCg0KUmVnYXJkcyBEZW5pcw0KDQpBbSBEaWVuc3RhZywgZGVu
IDEwLjA3LjIwMTgsIDIxOjIwICswODAwIHNjaHJpZWIga2J1aWxkIHRlc3Qgcm9ib3Q6DQo+
IEhpIE1pY2hhZWwsDQo+IA0KPiBJIGxvdmUgeW91ciBwYXRjaCEgWWV0IHNvbWV0aGluZyB0
byBpbXByb3ZlOg0KPiANCj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiBhYmVsbG9uaS9y
dGMtbmV4dF0NCj4gW2Fsc28gYnVpbGQgdGVzdCBFUlJPUiBvbiB2NC4xOC1yYzQgbmV4dC0y
MDE4MDcwOV0NCj4gW2lmIHlvdXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0
IHRyZWUsIHBsZWFzZSBkcm9wIHVzIGEgbm90ZSB0byBoZWxwIGltcHJvdmUgdGhlIHN5c3Rl
bV0NCj4gDQo+IHVybDrCoMKgwqDCoGh0dHBzOi8vZ2l0aHViLmNvbS8wZGF5LWNpL2xpbnV4
L2NvbW1pdHMvRGVuaXMtT1NURVJMQU5EL3J0Yy1pc2wxMjA4LWZpeGVzLWRvY3VtZW50YXRp
b24tYW5kLWlzbDEyMTktc3VwcG9ydC8yMDE4MDcxMC0xODE3MDkNCj4gYmFzZTrCoMKgwqBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9hYmVsbG9u
aS9saW51eC5naXQgcnRjLW5leHQNCj4gY29uZmlnOiB4ODZfNjQtcmFuZGNvbmZpZy1zNC0w
NzEwMTg1NyAoYXR0YWNoZWQgYXMgLmNvbmZpZykNCj4gY29tcGlsZXI6IGdjYy03IChEZWJp
YW4gNy4zLjAtMTYpIDcuMy4wDQo+IHJlcHJvZHVjZToNCj4gwqDCoMKgwqDCoMKgwqDCoCMg
c2F2ZSB0aGUgYXR0YWNoZWQgLmNvbmZpZyB0byBsaW51eCBidWlsZCB0cmVlDQo+IMKgwqDC
oMKgwqDCoMKgwqBtYWtlIEFSQ0g9eDg2XzY0wqANCj4gDQo+IEFsbCBlcnJvcnMgKG5ldyBv
bmVzIHByZWZpeGVkIGJ5ID4+KToNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IEVSUk9SOiAi
cnRjX2FkZF9ncm91cCIgW2RyaXZlcnMvcnRjL3J0Yy1pc2wxMjA4LmtvXSB1bmRlZmluZWQh
DQo+IC0tLQ0KPiAwLURBWSBrZXJuZWwgdGVzdCBpbmZyYXN0cnVjdHVyZcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgT3BlbiBTb3VyY2UgVGVjaG5vbG9neSBDZW50ZXINCj4g
aHR0cHM6Ly9saXN0cy4wMS5vcmcvcGlwZXJtYWlsL2tidWlsZC1hbGzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEludGVsIENvcnBvcmF0aW9uDQoNCkRpZWhsIENv
bm5lY3Rpdml0eSBTb2x1dGlvbnMgR21iSA0KR2VzY2jDpGZ0c2bDvGhydW5nOiBIb3JzdCBM
ZW9uYmVyZ2VyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6IE7DvHJuYmVyZyAtIFJlZ2lzdGVy
Z2VyaWNodDogQW10c2dlcmljaHQNCk7DvHJuYmVyZzogSFJCIDMyMzE1DQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCg0KRGVyIEluaGFsdCBkZXIg
dm9yc3RlaGVuZGVuIEUtTWFpbCBpc3QgbmljaHQgcmVjaHRsaWNoIGJpbmRlbmQuIERpZXNl
IEUtTWFpbCBlbnRoYWVsdCB2ZXJ0cmF1bGljaGUgdW5kL29kZXIgcmVjaHRsaWNoIGdlc2No
dWV0enRlIEluZm9ybWF0aW9uZW4uDQpJbmZvcm1pZXJlbiBTaWUgdW5zIGJpdHRlLCB3ZW5u
IFNpZSBkaWVzZSBFLU1haWwgZmFlbHNjaGxpY2hlcndlaXNlIGVyaGFsdGVuIGhhYmVuLiBC
aXR0ZSBsb2VzY2hlbiBTaWUgaW4gZGllc2VtIEZhbGwgZGllIE5hY2hyaWNodC4NCkplZGUg
dW5lcmxhdWJ0ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24sIEJla2FubnRnYWJlLCBBZW5kZXJ1
bmcsIFZlcnRlaWx1bmcgdW5kL29kZXIgUHVibGlrYXRpb24gZGllc2VyIEUtTWFpbCBpc3Qg
c3RyZW5nc3RlbnMgdW50ZXJzYWd0Lg0KVGhlIGNvbnRlbnRzIG9mIHRoZSBhYm92ZSBtZW50
aW9uZWQgZS1tYWlsIGlzIG5vdCBsZWdhbGx5IGJpbmRpbmcuIFRoaXMgZS1tYWlsIGNvbnRh
aW5zIGNvbmZpZGVudGlhbCBhbmQvb3IgbGVnYWxseSBwcm90ZWN0ZWQgaW5mb3JtYXRpb24u
IFBsZWFzZSBpbmZvcm0gdXMgaWYgeW91IGhhdmUgcmVjZWl2ZWQgdGhpcyBlLW1haWwgYnkN
Cm1pc3Rha2UgYW5kIGRlbGV0ZSBpdCBpbiBzdWNoIGEgY2FzZS4gRWFjaCB1bmF1dGhvcml6
ZWQgcmVwcm9kdWN0aW9uLCBkaXNjbG9zdXJlLCBhbHRlcmF0aW9uLCBkaXN0cmlidXRpb24g
YW5kL29yIHB1YmxpY2F0aW9uIG9mIHRoaXMgZS1tYWlsIGlzIHN0cmljdGx5IHByb2hpYml0
ZWQuIA0K
