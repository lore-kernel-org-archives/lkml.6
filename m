Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857C4C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062992086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062992086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=med.uni-goettingen.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeIDK4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:56:41 -0400
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:33274 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727482AbeIDK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:56:41 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 06:56:40 EDT
Received: from umg-exc-3.ads.local.med.uni-goettingen.de ([10.76.100.70]:35724)
        by mail1.med.uni-goettingen.de with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Uecker@med.uni-goettingen.de>)
        id 1fx4oc-0002tz-36; Tue, 04 Sep 2018 08:27:54 +0200
Received: from UMG-EXC-1.ads.local.med.uni-goettingen.de
 ([fe80::c97f:60fd:6a2d:e4b9]) by umg-exc-3.ads.local.med.uni-goettingen.de
 ([fe80::f513:fb91:9f16:b175%13]) with mapi id 14.03.0361.001; Tue, 4 Sep 2018
 08:27:53 +0200
From:   "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: VLAs and security
Thread-Topic: VLAs and security
Thread-Index: AQHUQpQcK6e7hvTWREaSPdTt5naSaqTdIVGAgADqgQCAAOe/gIAAlpIA
Date:   Tue, 4 Sep 2018 06:27:54 +0000
Message-ID: <1536042474.25086.1.camel@med.uni-goettingen.de>
References: <1535875700.17858.3.camel@med.uni-goettingen.de>
         <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
         <1535960372.32005.1.camel@med.uni-goettingen.de>
         <CA+55aFy=T6TmG_VcLvSTb02RyKTacxVCxwUALRn8_7cdoic0pA@mail.gmail.com>
In-Reply-To: <CA+55aFy=T6TmG_VcLvSTb02RyKTacxVCxwUALRn8_7cdoic0pA@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.21]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C3201BD87140E479F3221893F2C2990@ads.local.med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gTW9udGFnLCBkZW4gMDMuMDkuMjAxOCwgMTQ6MjggLTA3MDAgc2NocmllYiBMaW51cyBUb3J2
YWxkczoNCj4gT24gTW9uLCBTZXAgMywgMjAxOCBhdCAxMjo0MCBBTSBVZWNrZXIsIE1hcnRpbg0K
PiA8TWFydGluLlVlY2tlckBtZWQudW5pLWdvZXR0aW5nZW4uZGU+IHdyb3RlOg0KPiA+IA0KPiA+
IEJ1dCBpZiB0aGUgdHJ1ZSBib3VuZCBpcyBzbWFsbGVyLCB0aGVuIElNSE8gaXQgaXMgcmVhbGx5
IGJhZCBhZHZpc2UNCj4gPiB0byB0ZWxsIHByb2dyYW1tZXJzIHRvIHVzZQ0KPiA+IA0KPiA+IGNo
YXIgYnVmW01BWF9TSVpFXQ0KPiA+IA0KPiA+IGluc3RlYWQgb2Ygc29tZXRoaW5nIGxpa2UNCj4g
PiANCj4gPiBhc3NlcnQoTiA8PSBNQVhfU0laRSk7DQo+ID4gY2hhciBidWZbTl0NCj4gDQo+IE5v
Lg0KPiANCj4gRmlyc3Qgb2ZmLCB3ZSBkb24ndCB1c2UgYXNzZXJ0cyBpbiB0aGUga2VybmVsLiBO
b3QgYWNjZXB0YWJsZS4gWW91DQo+IGhhbmRsZSBlcnJvcnMsIHlvdSBkb24ndCBjcmFzaC4NCg0K
T2Zjb3Vyc2UuIEJ1dCB0aGlzIGlzIHVucmVsYXRlZCB0byBteSBwb2ludC4NCg0KPiBTZWNvbmRs
eSwgdGhlIGNvbXBpbGVyIGlzIHVzdWFsbHkgdmVyeSBzdHVwaWQsIGFuZCB3aWxsIGdlbmVyYXRl
DQo+IGhvcnJpYmxlIGNvZGUgZm9yIFZMQSdzLg0KPiANCj4gVGhpcmQsIHRoZXJlJ3Mgbm8gZ3Vh
cmFudGVlIHRoYXQgdGhlIGNvbXBpbGVyIHdpbGwgYWN0dWFsbHkgZXZlbg0KPiByZWFsaXplIHRo
YXQgdGhlIHNpemUgaXMgbGltaXRlZCwgYW5kIGd1YXJhbnRlZSB0aGF0IGl0IHdvbid0IHNjcmV3
IHVwDQo+IHRoZSBzdGFjay4NCg0KSWYgdGhpcyBpcyBhYm91dCB0aGUgcXVhbGl0eSBvZiB0aGUg
Z2VuZXJhdGVkIGNvZGUsIG9rLsKgDQoNCkkganVzdCBkb24ndCBidXkgdGhlIGlkZWEgdGhhdCBy
ZW1vdmluZyBwcmVjaXNlIHR5cGUtYmFzZWQNCmluZm9ybWF0aW9uIGFib3V0IHRoZSBzaXplIG9m
IG9iamVjdHMgZnJvbSB0aGUgc291cmNlIGNvZGUNCmlzIGdvb2QgbG9uZy10ZXJtIHN0cmF0ZWd5
IGZvciBpbXByb3Zpbmcgc2VjdXJpdHkuDQoNCj4gU28gbm8uIFZMQSdzIGFyZSBub3QgYWNjZXB0
YWJsZSBpbiB0aGUga2VybmVsLiBEb24ndCBkbyB0aGVtLiBXZSdyZQ0KPiBnZXR0aW5nIHJpZCBv
ZiB0aGVtLg0KDQpBbGwgcmlnaHQgdGhlbi4NCg0KTWFydGluDQo=
