Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5865C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD73218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfBGRdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:33:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:40444 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbfBGRdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:33:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 09:33:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,344,1544515200"; 
   d="scan'208";a="298013818"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2019 09:33:38 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.62]) by
 ORSMSX104.amr.corp.intel.com ([169.254.4.11]) with mapi id 14.03.0415.000;
 Thu, 7 Feb 2019 09:33:38 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>
Subject: Re: [PATCH 16/17] Plug in new special vfree flag
Thread-Topic: [PATCH 16/17] Plug in new special vfree flag
Thread-Index: AQHUrfxTN/9E5iQS/ECuiIskA2n60aXTmtoAgAGlzAA=
Date:   Thu, 7 Feb 2019 17:33:37 +0000
Message-ID: <16a2ac45ceef5b6f310f816d696ad2ea8df3b45c.camel@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
         <20190117003259.23141-17-rick.p.edgecombe@intel.com>
         <20190206112356.64cc5f0d@gandalf.local.home>
In-Reply-To: <20190206112356.64cc5f0d@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA377F3CE86CB84DB34EDE487645D269@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTA2IGF0IDExOjIzIC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gV2VkLCAxNiBKYW4gMjAxOSAxNjozMjo1OCAtMDgwMA0KPiBSaWNrIEVkZ2Vjb21iZSA8
cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBBZGQgbmV3IGZsYWcg
Zm9yIGhhbmRsaW5nIGZyZWVpbmcgb2Ygc3BlY2lhbCBwZXJtaXNzaW9uZWQgbWVtb3J5IGluIHZt
YWxsb2MNCj4gPiBhbmQgcmVtb3ZlIHBsYWNlcyB3aGVyZSBtZW1vcnkgd2FzIHNldCBSVyBiZWZv
cmUgZnJlZWluZyB3aGljaCBpcyBubyBsb25nZXINCj4gPiBuZWVkZWQuDQo+ID4gDQo+ID4gSW4g
a3Byb2JlcywgYnBmIGFuZCBmdHJhY2UgdGhpcyBqdXN0IGFkZHMgdGhlIGZsYWcsIGFuZCByZW1v
dmVzIHRoZSBub3cNCj4gPiB1bm5lZWRlZCBzZXRfbWVtb3J5XyBjYWxscyBiZWZvcmUgY2FsbGlu
ZyB2ZnJlZS4NCj4gPiANCj4gPiBJbiBtb2R1bGVzLCB0aGUgZnJlZWluZyBvZiBpbml0IHNlY3Rp
b25zIGlzIG1vdmVkIHRvIGEgd29yayBxdWV1ZSwgc2luY2UNCj4gPiBmcmVlaW5nIG9mIFJPIG1l
bW9yeSBpcyBub3Qgc3VwcG9ydGVkIGluIGFuIGludGVycnVwdCBieSB2bWFsbG9jLg0KPiA+IElu
c3RlYWQgb2YgY2FsbF9yY3UsIGl0IG5vdyB1c2VzIHN5bmNocm9uaXplX3JjdSgpIGluIHRoZSB3
b3JrIHF1ZXVlLg0KPiA+IA0KPiA+IENjOiBSdXN0eSBSdXNzZWxsIDxydXN0eUBydXN0Y29ycC5j
b20uYXU+DQo+ID4gQ2M6IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtlcm5lbC5vcmc+DQo+
ID4gQ2M6IERhbmllbCBCb3JrbWFubiA8ZGFuaWVsQGlvZ2VhcmJveC5uZXQ+DQo+ID4gQ2M6IEFs
ZXhlaSBTdGFyb3ZvaXRvdiA8YXN0QGtlcm5lbC5vcmc+DQo+ID4gQ2M6IEplc3NpY2EgWXUgPGpl
eXVAa2VybmVsLm9yZz4NCj4gPiBDYzogU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5v
cmc+DQo+ID4gQ2M6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAbGludXguaWJtLmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5j
b20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9mdHJhY2UuYyAgICAgICB8ICA2ICst
LQ0KPiANCj4gRm9yIHRoZSBmdHJhY2UgY29kZS4NCj4gDQo+IEFja2VkLWJ5OiBTdGV2ZW4gUm9z
dGVkdCAoVk13YXJlKSA8cm9zdGVkdEBnb29kbWlzLm9yZz4NCj4gDQo+IC0tIFN0ZXZlDQo+IA0K
VGhhbmtzIQ0KDQpSaWNrDQo+ID4gIGFyY2gveDg2L2tlcm5lbC9rcHJvYmVzL2NvcmUuYyB8ICA3
ICstLS0NCj4gPiAgaW5jbHVkZS9saW51eC9maWx0ZXIuaCAgICAgICAgIHwgMTYgKystLS0tLQ0K
PiA+ICBrZXJuZWwvYnBmL2NvcmUuYyAgICAgICAgICAgICAgfCAgMSAtDQo+ID4gIGtlcm5lbC9t
b2R1bGUuYyAgICAgICAgICAgICAgICB8IDc3ICsrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPiAgNSBmaWxlcyBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCA2MiBkZWxldGlv
bnMoLSkNCj4gPiANCg==
