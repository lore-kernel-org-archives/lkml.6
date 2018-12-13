Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE1DC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6812086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:02:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6812086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbeLMTCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:02:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:46023 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeLMTCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:02:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2018 11:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="259267541"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga004.jf.intel.com with ESMTP; 13 Dec 2018 11:02:53 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.201]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.59]) with mapi id 14.03.0415.000;
 Thu, 13 Dec 2018 11:02:52 -0800
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
Thread-Index: AQHUka9V1MIYVg+ExEqbD4KauZHiBaV8StmAgAFEtYA=
Date:   Thu, 13 Dec 2018 19:02:51 +0000
Message-ID: <ae9292380803f891a2472ebec70361b7c1af48d8.camel@intel.com>
References: <20181212000354.31955-1-rick.p.edgecombe@intel.com>
         <20181212000354.31955-3-rick.p.edgecombe@intel.com>
         <3AD9DBCA-C6EC-4FA6-84DC-09F3D4A9C47B@vmware.com>
In-Reply-To: <3AD9DBCA-C6EC-4FA6-84DC-09F3D4A9C47B@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.141]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A94C43946908D040A3E03262A753F155@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTEyLTEyIGF0IDIzOjQwICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPiA+
IE9uIERlYyAxMSwgMjAxOCwgYXQgNDowMyBQTSwgUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdl
Y29tYmVAaW50ZWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+IA0KPiA+IEFkZCBuZXcgZmxhZ3MgZm9y
IGhhbmRsaW5nIGZyZWVpbmcgb2Ygc3BlY2lhbCBwZXJtaXNzaW9uZWQgbWVtb3J5IGluDQo+ID4g
dm1hbGxvYywNCj4gPiBhbmQgcmVtb3ZlIHBsYWNlcyB3aGVyZSB0aGUgaGFuZGxpbmcgd2FzIGRv
bmUgaW4gbW9kdWxlLmMuDQo+ID4gDQo+ID4gVGhpcyB3aWxsIGVuYWJsZSB0aGlzIGZsYWcgZm9y
IGFsbCBhcmNoaXRlY3R1cmVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2sgRWRnZWNv
bWJlIDxyaWNrLnAuZWRnZWNvbWJlQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiBrZXJuZWwvbW9k
dWxlLmMgfCA0MyArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiANCj4gSSBjb3VudCBvbiB5b3UgZm9yIG1lcmdpbmcgeW91ciBwYXRjaC1zZXQgd2l0aCBt
aW5lLCBzaW5jZSBjbGVhcmx5IHRoZXkNCj4gY29uZmxpY3QuDQo+IA0KWWVzLCBJIGNhbiByZWJh
c2Ugb24gdG9wIG9mIHlvdXJzIGlmIHlvdSBvbWl0IHRoZSBjaGFuZ2VzIGFyb3VuZCBtb2R1bGVf
bWVtZnJlZSANCmZvciB5b3VyIG5leHQgdmVyc2lvbi4gSXQgc2hvdWxkIGZpdCB0b2dldGhlciBw
cmV0dHkgY2xlYW5seSBmb3IgQlBGIGFuZCBtb2R1bGVzDQpJIHRoaW5rLiBOb3Qgc3VyZSB3aGF0
IHlvdSBhcmUgcGxhbm5pbmcgZm9yIGtwcm9iZXMgYW5kIGZ0cmFjZS4NCg==
