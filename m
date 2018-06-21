Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58218C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B5E621A5E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5E621A5E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933277AbeFUS4Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:56:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:16099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932795AbeFUS4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:56:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2018 11:56:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,253,1526367600"; 
   d="scan'208";a="59176394"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jun 2018 11:56:19 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.228]) by
 ORSMSX106.amr.corp.intel.com ([169.254.1.45]) with mapi id 14.03.0319.002;
 Thu, 21 Jun 2018 11:56:18 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "jannh@google.com" <jannh@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Accardi, Kristen C" <kristen.c.accardi@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH 3/3] vmalloc: Add debugfs modfraginfo
Thread-Topic: [PATCH 3/3] vmalloc: Add debugfs modfraginfo
Thread-Index: AQHUCONi65aZWTYXlUK6HyiH/5MW+6RrG3IAgABrRQA=
Date:   Thu, 21 Jun 2018 18:56:18 +0000
Message-ID: <1529607394.29548.199.camel@intel.com>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
         <1529532570-21765-4-git-send-email-rick.p.edgecombe@intel.com>
         <CAG48ez1QbKgoBCb-M=L+M5DJHj0URhNvS34h+Ax6RudckgCEEA@mail.gmail.com>
In-Reply-To: <CAG48ez1QbKgoBCb-M=L+M5DJHj0URhNvS34h+Ax6RudckgCEEA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.7.197.56]
Content-Type: text/plain; charset="utf-8"
Content-ID: <176C2E2898EA79478B62E2CBA2A27909@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTIxIGF0IDE0OjMyICswMjAwLCBKYW5uIEhvcm4gd3JvdGU6DQo+IE9u
IFRodSwgSnVuIDIxLCAyMDE4IGF0IDEyOjEyIEFNIFJpY2sgRWRnZWNvbWJlDQo+IDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gQWRkIGRlYnVnZnMgZmlsZSAi
bW9kZnJhZ2luZm8iIGZvciBwcm92aWRpbmcgaW5mbyBvbiBtb2R1bGUgc3BhY2UNCj4gPiBmcmFn
bWVudGF0aW9uLsKgwqBUaGlzIGNhbiBiZSB1c2VkIGZvciBkZXRlcm1pbmluZyBpZiBsb2FkYWJs
ZSBtb2R1bGUNCj4gPiByYW5kb21pemF0aW9uIGlzIGNhdXNpbmcgYW55IHByb2JsZW1zIGZvciBl
eHRyZW1lIG1vZHVsZSBsb2FkaW5nDQo+ID4gc2l0dWF0aW9ucywNCj4gPiBsaWtlIGh1Z2UgbnVt
YmVycyBvZiBtb2R1bGVzIG9yIGV4dHJlbWVseSBsYXJnZSBtb2R1bGVzLg0KPiA+IA0KPiA+IFNh
bXBsZSBvdXRwdXQgd2hlbiBSQU5ET01JWkVfQkFTRSBhbmQgWDg2XzY0IGlzIGNvbmZpZ3VyZWQ6
DQo+ID4gTGFyZ2VzdCBmcmVlIHNwYWNlOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgODQ3MjUz
NTA0DQo+ID4gRXh0ZXJuYWwgTWVtb3J5IEZyYWdlbWVudGF0aW9uOiAyMCUNCj4gPiBBbGxvY2F0
aW9ucyBpbiBiYWNrdXAgYXJlYTrCoMKgwqDCoMKgMA0KPiA+IA0KPiA+IFNhbXBsZSBvdXRwdXQg
b3RoZXJ3aXNlOg0KPiA+IExhcmdlc3QgZnJlZSBzcGFjZTrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoDg0NzI1MzUwNA0KPiA+IEV4dGVybmFsIE1lbW9yeSBGcmFnZW1lbnRhdGlvbjogMjAlDQo+
IFsuLi5dDQo+ID4gDQo+ID4gK8KgwqDCoMKgwqDCoMKgc2VxX3ByaW50ZihtLCAiTGFyZ2VzdCBm
cmVlIHNwYWNlOlx0XHQlbHVcbiIsDQo+ID4gbGFyZ2VzdF9mcmVlKTsNCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAodG90YWxfZnJlZSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
c2VxX3ByaW50ZihtLCAiRXh0ZXJuYWwgTWVtb3J5DQo+ID4gRnJhZ2VtZW50YXRpb246XHQlbHUl
JVxuIiwNCj4gIkZyYWdtZW50YXRpb24iDQo+IA0KPiA+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMTAwLSgxMDAqbGFyZ2VzdF9mcmVlL3RvdGFs
X2ZyZWUpKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBlbHNlDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHNlcV9wdXRzKG0sICJFeHRlcm5hbCBNZW1vcnkNCj4gPiBGcmFnZW1lbnRh
dGlvbjpcdDAlJVxuIik7DQo+ICJGcmFnbWVudGF0aW9uIg0KDQpPb3BzISBUaGFua3MuDQoNCj4g
Wy4uLl0NCj4gPiANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgZGVi
dWdfbW9kdWxlX2ZyYWdfb3BlcmF0aW9ucyA9DQo+ID4gew0KPiA+ICvCoMKgwqDCoMKgwqDCoC5v
cGVuwqDCoMKgwqDCoMKgwqA9IHByb2NfbW9kdWxlX2ZyYWdfZGVidWdfb3BlbiwNCj4gPiArwqDC
oMKgwqDCoMKgwqAucmVhZMKgwqDCoMKgwqDCoMKgPSBzZXFfcmVhZCwNCj4gPiArwqDCoMKgwqDC
oMKgwqAubGxzZWVrwqDCoMKgwqDCoD0gc2VxX2xzZWVrLA0KPiA+ICvCoMKgwqDCoMKgwqDCoC5y
ZWxlYXNlwqDCoMKgwqA9IHNpbmdsZV9yZWxlYXNlLA0KPiA+ICt9Ow0KPiA+IA0KPiA+ICtzdGF0
aWMgdm9pZCBkZWJ1Z19tb2RmcmFnX2luaXQodm9pZCkNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKg
wqDCoGRlYnVnZnNfY3JlYXRlX2ZpbGUoIm1vZGZyYWdpbmZvIiwgMHgwNDAwLCBOVUxMLCBOVUxM
LA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJmRl
YnVnX21vZHVsZV9mcmFnX29wZXJhdGlvbnMpOw0KPiAweDA0MDAgaXMgMDIwMDAsIHdoaWNoIGlz
IHRoZSBzZXRnaWQgYml0LiBJIHRoaW5rIHlvdSBtZWFudCB0byB0eXBlDQo+IDA0MDA/DQoNClll
cywgdGhhbmtzLg==
