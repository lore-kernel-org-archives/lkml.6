Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C024EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836EA2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836EA2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387929AbeIYBCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:02:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:17548 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeIYBCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:02:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 11:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="235549248"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga004.jf.intel.com with ESMTP; 24 Sep 2018 11:58:44 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX108.amr.corp.intel.com ([169.254.2.163]) with mapi id 14.03.0319.002;
 Mon, 24 Sep 2018 11:58:44 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jannh@google.com" <jannh@google.com>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v6 3/4] vmalloc: Add debugfs modfraginfo
Thread-Topic: [PATCH v6 3/4] vmalloc: Add debugfs modfraginfo
Thread-Index: AQHUS6nxBgyNfAhWIEuTl8eC0MDMfaT7l6+AgAS3tAA=
Date:   Mon, 24 Sep 2018 18:58:44 +0000
Message-ID: <1537815554.19013.49.camel@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
         <1536874298-23492-4-git-send-email-rick.p.edgecombe@intel.com>
         <CAGXu5jJj+08J9UeyQs5ku8CziYWA72iJ+hxMR2Z2tLiVwvU8MA@mail.gmail.com>
In-Reply-To: <CAGXu5jJj+08J9UeyQs5ku8CziYWA72iJ+hxMR2Z2tLiVwvU8MA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C183D5357C751A439DE80245741D78EA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTIxIGF0IDExOjU2IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDEzLCAyMDE4IGF0IDI6MzEgUE0sIFJpY2sgRWRnZWNvbWJlDQo+IDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gK2RvbmU6DQo+ID4gK8KgwqDCoMKgwqDC
oMKgZ2FwID0gKE1PRFVMRVNfRU5EIC0gbGFzdF9lbmQpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlm
IChnYXAgPiBsYXJnZXN0X2ZyZWUpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGxhcmdlc3RfZnJlZSA9IGdhcDsNCj4gPiArwqDCoMKgwqDCoMKgwqB0b3RhbF9mcmVlICs9IGdh
cDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgc3Bpbl91bmxvY2soJnZtYXBfYXJlYV9sb2Nr
KTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgc2VxX3ByaW50ZihtLCAiXHRMYXJnZXN0IGZy
ZWUgc3BhY2U6XHQlbHUga0JcbiIsIGxhcmdlc3RfZnJlZSAvDQo+ID4gMTAyNCk7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgc2VxX3ByaW50ZihtLCAiXHTCoMKgVG90YWwgZnJlZSBzcGFjZTpcdCVsdSBr
QlxuIiwgdG90YWxfZnJlZSAvIDEwMjQpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAo
SVNfRU5BQkxFRChDT05GSUdfUkFORE9NSVpFX0JBU0UpICYmIGthc2xyX2VuYWJsZWQoKSkNCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc2VxX3ByaW50ZihtLCAiQWxsb2NhdGlv
bnMgaW4gYmFja3VwIGFyZWE6XHQlbHVcbiIsDQo+ID4gYmFja3VwX2NudCk7DQo+IEkgZG9uJ3Qg
dGhpbmsgdGhlIElTX0VOQUJMRUQgaXMgbmVlZGVkIGhlcmU/DQpUaGUgcmVhc29uIGZvcsKgdGhp
cyBpcyB0aGF0IGZvciBBUkNIPXVtLCBDT05GSUdfWDg2XzY0IGlzIGRlZmluZWQgYnV0DQprYXNs
cl9lbmFibGVkIGlzIG5vdC4ga2FzbHJfZW5hYmxlZCBpcyBkZWNsYXJlZCBhYm92ZSB0byBwcm90
ZWN0IGFnYWluc3QgYQ0KY29tcGlsZXIgZXJyb3IuDQoNClNvIElTX0VOQUJMRUQoQ09ORklHX1JB
TkRPTUlaRV9CQVNFKSBpcyBwcm90ZWN0aW5nIGthc2xyX2VuYWJsZWQgZnJvbSBjYXVzaW5nIGEN
CmxpbmtlciBlcnJvci4gSXQgZ2V0cyBjb25zdGFudCBldmFsdWF0ZWQgdG8gMCBhbmQgdGhlIGNv
bXBpbGVyIG9wdGltaXplcyBvdXQgdGhlDQprYXNscl9lbmFibGVkIGNhbGwuIFRob3VnaHQgaXQg
d2FzIGJldHRlciB0byBndWFyZCB3aXRoIENPTkZJR19SQU5ET01JWkVfQkFTRQ0KdGhhbiB3aXRo
IENPTkZJR19VTSwgdG8gdHJ5IHRvIGNhdGNoIHRoZSBicm9hZGVyIHNpdHVhdGlvbi4gSSBndWVz
cyBJIGNvdWxkIG1vdmUNCml0IHRvIGEgaGVscGVyIGluc2lkZSBpZmRlZnMgaW5zdGVhZC4gV2Fz
IHRyeWluZyB0byBrZWVwIHRoZSBpZmRlZi1lZCBjb2RlIGRvd24uDQoNCj4gSSB3b25kZXIgaWYg
dGhlcmUgaXMgYSBiZXR0ZXIgd2F5IHRvIGFycmFuZ2UgdGhpcyBjb2RlIHRoYXQgdXNlcyBmZXdl
cg0KPiBpZmRlZnMsIGV0Yy4gTWF5YmUgYSBzaW5nbGUgQ09ORklHIHRoYXQgY2FwdHVyZSB3aGV0
aGVyIG9yIG5vdA0KPiBmaW5lLWdyYWluZWQgbW9kdWxlIHJhbmRvbWl6YXRpb24gaXMgYnVpbHQg
aW4sIGxpa2U6DQo+IA0KPiBjb25maWcgUkFORE9NSVpFX0ZJTkVfTU9EVUxFDQo+IMKgwqDCoMKg
ZGVmX2Jvb2wgeSBpZiBSQU5ET01JWkVfQkFTRSAmJiBYODZfNjQNCj4gDQo+ICNpZmRlZiBDT05G
SUdfUkFORE9NSVpFX0ZJTkVfTU9EVUxFDQo+IC4uLg0KPiAjZW5kaWYNCj4gDQo+IEJ1dCB0aGF0
IGRvZXNuJ3QgY2FwdHVyZSB0aGUgREVCVUdfRlMgYW5kIFBST0NfRlMgYml0cyAuLi4gc28gLi4u
DQo+IG1heWJlIG5vdCB3b3J0aCBpdC4gSSBndWVzcywgZWl0aGVyIHdheToNCkhtbW0sIGRpZG4n
dCBrbm93IGFib3V0IHRoYXQuIFdvdWxkIGNsZWFuIGl0IHVwIHNvbWUgYXQgbGVhc3QuDQoNCkkg
d2lzaCB0aGUgZGVidWdmcyBpbmZvIGNvdWxkIGJlIGluIG1vZHVsZS5jIHRvIGhlbHAgd2l0aCB0
aGlzIElGREVGcywgYnV0IGl0DQpuZWVkcyB2bWFsbG9jIGludGVybmFscy4gTU9EVUxFU19WQURE
UiBpcyBub3Qgc3RhbmRhcmRpemVkIGFjcm9zcyB0aGUgQVJDSCdzIGFzDQp3ZWxsLCBzbyB0aGlz
IHdhcyBteSBiZXN0IGF0dGVtcHQgdG8gaW1wbGVtZW50IHRoaXMgd2l0aG91dCBoYXZpbmcgdG8g
bWFrZQ0KY2hhbmdlcyBpbiBvdGhlciBhcmNoaXRlY3R1cmVzLg0KPiBSZXZpZXdlZC1ieTogS2Vl
cyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+IA0KPiAtS2Vlcw0KPiA=
