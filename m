Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D9421480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D9421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731194AbeIYBCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:02:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:10727 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbeIYBCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:02:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 11:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="93319298"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2018 11:57:36 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 24 Sep 2018 11:57:35 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.23]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.186]) with mapi id 14.03.0319.002;
 Mon, 24 Sep 2018 11:57:35 -0700
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
Subject: Re: [PATCH v6 2/4] x86/modules: Increase randomization for modules
Thread-Topic: [PATCH v6 2/4] x86/modules: Increase randomization for modules
Thread-Index: AQHUS6nwBsySFaAeZU6Tsy01ge2+q6T7mgWAgAS1CwA=
Date:   Mon, 24 Sep 2018 18:57:35 +0000
Message-ID: <1537815484.19013.48.camel@intel.com>
References: <1536874298-23492-1-git-send-email-rick.p.edgecombe@intel.com>
         <1536874298-23492-3-git-send-email-rick.p.edgecombe@intel.com>
         <CAGXu5jJ9nZYbVn5xdi7nsMJRD6ScLeWP2DWjrD8yEfwi-XXcRw@mail.gmail.com>
In-Reply-To: <CAGXu5jJ9nZYbVn5xdi7nsMJRD6ScLeWP2DWjrD8yEfwi-XXcRw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C7B10887068584C86F3A3ACD6F60B7C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE4LTA5LTIxIGF0IDEyOjA1IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IFRodSwgU2VwIDEzLCAyMDE4IGF0IDI6MzEgUE0sIFJpY2sgRWRnZWNvbWJlDQo+IDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4gd3JvdGU6DQo+IEkgd291bGQgZmluZCB0aGlzIG11Y2ggbW9y
ZSByZWFkYWJsZSBhczoNCj4gc3RhdGljIHVuc2lnbmVkIGxvbmcgZ2V0X21vZHVsZV92bWFsbG9j
X3N0YXJ0KHZvaWQpDQo+IHsNCj4gwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGFkZHIgPSBN
T0RVTEVTX1ZBRERSOw0KPiANCj4gwqDCoMKgwqDCoMKgwqBpZiAoa2FzbHJfcmFuZG9taXplX2Jh
c2UoKSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFkZHIgKz0gZ2V0X21vZHVsZV9s
b2FkX29mZnNldCgpOw0KPiANCj4gwqDCoMKgwqDCoMKgwqBpZiAoa2FzbHJfcmFuZG9taXplX2Vh
Y2hfbW9kdWxlKCkpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFkZHIgKz0gZ2V0
X21vZHVsZXNfcmFuZF9sZW4oKTsNCj4gDQo+IMKgwqDCoMKgwqDCoMKgcmV0dXJuIGFkZHI7DQo+
IH0NClRoYW5rcywgdGhhdCBsb29rcyBiZXR0ZXIuDQoNCj4gDQo+ID4gwqB2b2lkICptb2R1bGVf
YWxsb2ModW5zaWduZWQgbG9uZyBzaXplKQ0KPiA+IMKgew0KPiA+IEBAIC04NCwxNiArMjAxLDE4
IEBAIHZvaWQgKm1vZHVsZV9hbGxvYyh1bnNpZ25lZCBsb25nIHNpemUpDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoGlmIChQQUdFX0FMSUdOKHNpemUpID4gTU9EVUxFU19MRU4pDQo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gTlVMTDsNCj4gPiANCj4gPiAtwqDCoMKgwqDC
oMKgwqBwID0gX192bWFsbG9jX25vZGVfcmFuZ2Uoc2l6ZSwgTU9EVUxFX0FMSUdOLA0KPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgTU9EVUxFU19WQUREUiArDQo+ID4gZ2V0X21vZHVsZV9sb2FkX29mZnNldCgp
LA0KPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgTU9EVUxFU19FTkQsIEdGUF9LRVJORUwsDQo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBQQUdFX0tFUk5FTF9FWEVDLCAwLCBOVU1BX05PX05PREUsDQo+ID4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHAg
PSB0cnlfbW9kdWxlX3JhbmRvbWl6ZV9lYWNoKHNpemUpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDC
oMKgwqBpZiAoIXApDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHAgPSBfX3Zt
YWxsb2Nfbm9kZV9yYW5nZShzaXplLCBNT0RVTEVfQUxJR04sDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ2V0X21vZHVs
ZV92bWFsbG9jX3N0YXJ0KCksIE1PRFVMRVNfRU5ELA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdGUF9LRVJORUwsIFBB
R0VfS0VSTkVMX0VYRUMsIDAsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTlVNQV9OT19OT0RFLCBfX2J1aWx0aW5fcmV0
dXJuX2FkZHJlc3MoMCkpOw0KPiBJbnN0ZWFkIG9mIGhhdmluZyB0d28gb3Blbi1jb2RlZCBfX3Zt
YWxsb2Nfbm9kZV9yYW5nZSgpIGNhbGxzIGxlZnQgaW4NCj4gdGhpcyBhZnRlciB0aGUgY2hhbmdl
LCBjYW4gdGhpcyBiZSBkb25lIGluIHRlcm1zIG9mIGEgY2FsbCB0bw0KPiB0cnlfbW9kdWxlX2Fs
bG9jKCkgaW5zdGVhZD8gSSBzZWUgdGhleSdyZSBzbGlnaHRseSBkaWZmZXJlbnQsIGJ1dCBpdA0K
PiBtaWdodCBiZSBuaWNlIGZvciBtYWtpbmcgdGhlIHR3byBwYXRocyBzaGFyZSBtb3JlIGNvZGUu
DQpOb3Qgc3VyZSB3aGF0IHlvdSBtZWFuLiBBY3Jvc3MgdGhlIHdob2xlIGNoYW5nZSwgdGhlcmUg
aXMgb25lIGNhbGwNCnRvwqBfX3ZtYWxsb2Nfbm9kZV9yYW5nZSwgYW5kIG9uZSB0b8KgX192bWFs
bG9jX25vZGVfdHJ5X2FkZHIu
