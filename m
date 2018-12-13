Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90174C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E4F2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 21:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E4F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeLMVsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:48:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:56781 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLMVsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 16:48:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 13:48:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="302005701"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga006.fm.intel.com with ESMTP; 13 Dec 2018 13:48:16 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 13 Dec 2018 13:48:15 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.201]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.49]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 13:48:15 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "namit@vmware.com" <namit@vmware.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "jannh@google.com" <jannh@google.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v2 2/4] modules: Add new special vfree flags
Thread-Topic: [PATCH v2 2/4] modules: Add new special vfree flags
Thread-Index: AQHUka9V1MIYVg+ExEqbD4KauZHiBaV8StmAgAFEtYCAAAcIgIAAJy6A
Date:   Thu, 13 Dec 2018 21:48:15 +0000
Message-ID: <427fee623f38d08cf66d070c37ce5a69a8fc2811.camel@intel.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
         <20181212000354.31955-3-rick.p.edgecombe@intel.com>
         <3AD9DBCA-C6EC-4FA6-84DC-09F3D4A9C47B@vmware.com>
         <ae9292380803f891a2472ebec70361b7c1af48d8.camel@intel.com>
         <60C7B565-9009-4070-A632-8C982B692806@vmware.com>
In-Reply-To: <60C7B565-9009-4070-A632-8C982B692806@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE0299C348546439A160617DA4E66F1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEyLTEzIGF0IDE5OjI3ICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiA+
IE9uIERlYyAxMywgMjAxOCwgYXQgMTE6MDIgQU0sIEVkZ2Vjb21iZSwgUmljayBQIDxyaWNrLnAu
ZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIDIwMTgt
MTItMTIgYXQgMjM6NDAgKzAwMDAsIE5hZGF2IEFtaXQgd3JvdGU6DQo+ID4gPiA+IE9uIERlYyAx
MSwgMjAxOCwgYXQgNDowMyBQTSwgUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50
ZWwuY29tPg0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBuZXcgZmxhZ3Mg
Zm9yIGhhbmRsaW5nIGZyZWVpbmcgb2Ygc3BlY2lhbCBwZXJtaXNzaW9uZWQgbWVtb3J5IGluDQo+
ID4gPiA+IHZtYWxsb2MsDQo+ID4gPiA+IGFuZCByZW1vdmUgcGxhY2VzIHdoZXJlIHRoZSBoYW5k
bGluZyB3YXMgZG9uZSBpbiBtb2R1bGUuYy4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgd2lsbCBl
bmFibGUgdGhpcyBmbGFnIGZvciBhbGwgYXJjaGl0ZWN0dXJlcy4NCj4gPiA+ID4gDQo+ID4gPiA+
IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNvbWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNv
bT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IGtlcm5lbC9tb2R1bGUuYyB8IDQzICsrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gMSBmaWxlIGNoYW5nZWQs
IDEyIGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBJIGNvdW50
IG9uIHlvdSBmb3IgbWVyZ2luZyB5b3VyIHBhdGNoLXNldCB3aXRoIG1pbmUsIHNpbmNlIGNsZWFy
bHkgdGhleQ0KPiA+ID4gY29uZmxpY3QuDQo+ID4gDQo+ID4gWWVzLCBJIGNhbiByZWJhc2Ugb24g
dG9wIG9mIHlvdXJzIGlmIHlvdSBvbWl0IHRoZSBjaGFuZ2VzIGFyb3VuZA0KPiA+IG1vZHVsZV9t
ZW1mcmVlIA0KPiA+IGZvciB5b3VyIG5leHQgdmVyc2lvbi4gSXQgc2hvdWxkIGZpdCB0b2dldGhl
ciBwcmV0dHkgY2xlYW5seSBmb3IgQlBGIGFuZA0KPiA+IG1vZHVsZXMNCj4gPiBJIHRoaW5rLiBO
b3Qgc3VyZSB3aGF0IHlvdSBhcmUgcGxhbm5pbmcgZm9yIGtwcm9iZXMgYW5kIGZ0cmFjZS4NCj4g
DQo+IEFyZSB5b3UgYXNraW5nIGFmdGVyIGxvb2tpbmcgYXQgdGhlIGxhdGVzdCB2ZXJzaW9uIG9m
IG15IHBhdGNoLXNldD8NCj4gDQo+IEtwcm9iZXMgaXMgZG9uZSBhbmQgYWNrJ2QuIGZ0cmFjZSBu
ZWVkcyB0byBiZSBicm9rZW4gaW50byB0d28gc2VwYXJhdGUNCj4gY2hhbmdlcyAoc2V0dGluZyB4
IGFmdGVyIHdyaXRpbmcsIGFuZCB1c2luZyB0ZXh0X3Bva2UgaW50ZXJmYWNlcyksIHVubGVzcw0K
PiBTdGV2ZW4gYWNr4oCZcyB0aGVtLiBUaGUgY2hhbmdlcyBpbnRyb2R1Y2Ugc29tZSBvdmVyaGVh
ZCAoM3gpLCBidXQgSSB0aGluayBpdA0KPiBpcyBhIHJlYXNvbmFibGUgc2xvd2Rvd24gZm9yIGEg
ZGVidWcgZmVhdHVyZS4NCj4gDQo+IENhbiB5b3UgaGF2ZSBhIGxvb2sgYXQgdGhlIHNlcmllcyBJ
4oCZdmUgc2VudCBhbmQgbGV0IG1lIGtub3cgd2hpY2ggcGF0Y2hlcw0KPiB0byBkcm9wPyBJdCB3
b3VsZCBiZSBiZXN0IChmb3IgbWUpIGlmIHRoZSB0d28gc2VyaWVzIGFyZSBmdWxseSBtZXJnZWQu
DQoNCkxvb2tpbmcgYXQgdjcsIHRoZSBvbmx5IGV4dHJhIHRoaW5nIGNvdWxkIGJlIHRoZSB0d2Vh
a3MgdG8gdGhlIGV4aXN0aW5nIGxpbmVzIGluDQprcHJvYmVzIGZyZWVfaW5zbl9wYWdlIGJlIG9t
aXR0ZWQsIHNpbmNlIHRob3NlIGxpbmVzIHdvdWxkIGp1c3QgYmUgcmVtb3ZlZCBpbiBteQ0KbGF0
ZXIgY2hhbmdlcy4NCg==
