Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0415AECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C544521470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C544521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJSPfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:35:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:1924 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbeJSPfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:35:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 00:30:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,399,1534834800"; 
   d="scan'208";a="242572382"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2018 00:30:54 -0700
Received: from hasmsx107.ger.corp.intel.com (10.184.198.27) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Fri, 19 Oct 2018 00:30:54 -0700
Received: from HASMSX109.ger.corp.intel.com ([169.254.3.28]) by
 hasmsx107.ger.corp.intel.com ([169.254.2.223]) with mapi id 14.03.0319.002;
 Fri, 19 Oct 2018 10:30:51 +0300
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>
CC:     "nayna@linux.vnet.ibm.com" <nayna@linux.vnet.ibm.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: tpm_i2c_nuvoton: use correct command duration for
 TPM 2.x
Thread-Topic: [PATCH] tpm: tpm_i2c_nuvoton: use correct command duration for
 TPM 2.x
Thread-Index: AQHUZ2btLmkTCCBG+k+DpgFokEiphqUl+QmA
Date:   Fri, 19 Oct 2018 07:30:50 +0000
Message-ID: <1539933995.19334.9.camel@intel.com>
References: <20181017163223.25141-1-tomas.winkler@intel.com>
         <6e12d4b6-cb84-3be5-8a62-6868be43d43d@linux.ibm.com>
In-Reply-To: <6e12d4b6-cb84-3be5-8a62-6868be43d43d@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.91.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <87AC378C383C2C49A85DEC6491EE7FF0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTEwLTE5IGF0IDEwOjE0ICswNTMwLCBOYXluYSBKYWluIHdyb3RlOg0KPiAN
Cj4gT24gMTAvMTcvMjAxOCAxMDowMiBQTSwgVG9tYXMgV2lua2xlciB3cm90ZToNCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jaGFyL3RwbS90cG1faTJjX251dm90b24uYyBiL2RyaXZlcnMvY2hh
ci90cG0vdHBtX2kyY19udXZvdG9uLmMNCj4gPiBpbmRleCBjYWE4NmIxOWM3NmQuLmY3NGY0NTFi
YWY2YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2NoYXIvdHBtL3RwbV9pMmNfbnV2b3Rvbi5j
DQo+ID4gKysrIGIvZHJpdmVycy9jaGFyL3RwbS90cG1faTJjX251dm90b24uYw0KPiA+IEBAIC0z
NjksNiArMzY5LDcgQEAgc3RhdGljIGludCBpMmNfbnV2b3Rvbl9zZW5kKHN0cnVjdCB0cG1fY2hp
cCAqY2hpcCwgdTggKmJ1Ziwgc2l6ZV90IGxlbikNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlICpkZXYg
PSBjaGlwLT5kZXYucGFyZW50Ow0KPiA+ICAgCXN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0
b19pMmNfY2xpZW50KGRldik7DQo+ID4gICAJdTMyIG9yZGluYWw7DQo+ID4gKwl1bnNpZ25lZCBs
b25nIGR1cmF0aW9uOw0KPiA+ICAgCXNpemVfdCBjb3VudCA9IDA7DQo+ID4gICAJaW50IGJ1cnN0
X2NvdW50LCBieXRlczJ3cml0ZSwgcmV0cmllcywgcmMgPSAtRUlPOw0KPiA+IA0KPiA+IEBAIC00
NTUsMTAgKzQ1NiwxMiBAQCBzdGF0aWMgaW50IGkyY19udXZvdG9uX3NlbmQoc3RydWN0IHRwbV9j
aGlwICpjaGlwLCB1OCAqYnVmLCBzaXplX3QgbGVuKQ0KPiA+ICAgCQlyZXR1cm4gcmM7DQo+ID4g
ICAJfQ0KPiA+ICAgCW9yZGluYWwgPSBiZTMyX3RvX2NwdSgqKChfX2JlMzIgKikgKGJ1ZiArIDYp
KSk7DQo+ID4gLQlyYyA9IGkyY19udXZvdG9uX3dhaXRfZm9yX2RhdGFfYXZhaWwoY2hpcCwNCj4g
PiAtCQkJCQkgICAgIHRwbV9jYWxjX29yZGluYWxfZHVyYXRpb24oY2hpcCwNCj4gPiAtCQkJCQkJ
CQkgICAgICAgb3JkaW5hbCksDQo+ID4gLQkJCQkJICAgICAmcHJpdi0+cmVhZF9xdWV1ZSk7DQo+
ID4gKwlpZiAoY2hpcC0+ZmxhZ3MgJiBUUE1fQ0hJUF9GTEFHX1RQTTIpDQo+ID4gKwkJZHVyYXRp
b24gPSB0cG0yX2NhbGNfb3JkaW5hbF9kdXJhdGlvbihjaGlwLCBvcmRpbmFsKTsNCj4gPiArCWVs
c2UNCj4gPiArCQlkdXJhdGlvbiA9IHRwbV9jYWxjX29yZGluYWxfZHVyYXRpb24oY2hpcCwgb3Jk
aW5hbCk7DQo+ID4gKw0KPiA+ICsJcmMgPSBpMmNfbnV2b3Rvbl93YWl0X2Zvcl9kYXRhX2F2YWls
KGNoaXAsIGR1cmF0aW9uLCAmcHJpdi0+cmVhZF9xdWV1ZSk7DQo+ID4gICAJaWYgKHJjKSB7DQo+
ID4gICAJCWRldl9lcnIoZGV2LCAiJXMoKSB0aW1lb3V0IGNvbW1hbmQgZHVyYXRpb25cbiIsIF9f
ZnVuY19fKTsNCj4gPiAgIAkJaTJjX251dm90b25fcmVhZHkoY2hpcCk7DQo+IA0KPiBJIG9ubHkg
aGF2ZSBOdXZvdG9uIFRQTSAyLjAsIHRlc3RlZCBmb3IgdGhhdC4NCj4gDQo+IFJldmlld2VkLWJ5
OiBOYXluYSBKYWluIDxuYXluYUBsaW51eC5pYm0uY29tPg0KPiBUZXN0ZWQtYnk6IE5heW5hIEph
aW4gPG5heW5hQGxpbnV4LmlibS5jb20+IChGb3IgVFBNIDIuMCkNCg0KVGhhdCdzIHdoYXQgd2Ug
bmVlZGVkIGFzIFRQTSAxLjIgc2hvdWxkIGJlIHVuY2hhbmdlZC4NClJlYWxseSBhcHByZWNpYXRl
IHRoZSBxdWljayByZXNwb25zZS4gSSB3aWxsIHJlYmFzZSB0aGUgc2VyaWVzIG9uIHRvIG9mDQp0
aGlzIHBhdGNoLiANCg0KVGhhbmtzDQpUb21hcw0K
