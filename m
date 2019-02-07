Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C41C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D111A2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfBGSUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:20:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:16047 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfBGSUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:20:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 10:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,345,1544515200"; 
   d="scan'208";a="120751908"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga007.fm.intel.com with ESMTP; 07 Feb 2019 10:20:49 -0800
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 7 Feb 2019 10:20:47 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.62]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.107]) with mapi id 14.03.0415.000;
 Thu, 7 Feb 2019 10:20:46 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHUrfxTN/9E5iQS/ECuiIskA2n60aXTmtoAgAGlzACAAASHgIAACKWA
Date:   Thu, 7 Feb 2019 18:20:45 +0000
Message-ID: <e71683c86dbe1b32fcec5cc708e8773e72242519.camel@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
         <20190117003259.23141-17-rick.p.edgecombe@intel.com>
         <20190206112356.64cc5f0d@gandalf.local.home>
         <16a2ac45ceef5b6f310f816d696ad2ea8df3b45c.camel@intel.com>
         <20190207124949.0ea219a7@gandalf.local.home>
In-Reply-To: <20190207124949.0ea219a7@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <04CF8A361999FE4C8001D62D362CA687@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTA3IGF0IDEyOjQ5IC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gVGh1LCA3IEZlYiAyMDE5IDE3OjMzOjM3ICswMDAwDQo+ICJFZGdlY29tYmUsIFJpY2sg
UCIgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IA0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIGFyY2gveDg2L2tlcm5lbC9mdHJhY2UuYyAgICAgICB8ICA2ICstLSAgDQo+
ID4gPiANCj4gPiA+IEZvciB0aGUgZnRyYWNlIGNvZGUuDQo+ID4gPiANCj4gPiA+IEFja2VkLWJ5
OiBTdGV2ZW4gUm9zdGVkdCAoVk13YXJlKSA8cm9zdGVkdEBnb29kbWlzLm9yZz4NCj4gPiA+IA0K
PiA+ID4gLS0gU3RldmUNCj4gPiA+ICAgDQo+ID4gDQo+ID4gVGhhbmtzIQ0KPiANCj4gSSBqdXN0
IG5vdGljZWQgdGhhdCB0aGUgc3ViamVjdCBpcyBpbmNvcnJlY3Q7IEl0IGlzIG1pc3NpbmcgdGhl
DQo+ICJzdWJzeXN0ZW06IiBwYXJ0LiBTZWUgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRp
bmctcGF0Y2hlcy5yc3QNCj4gDQo+IC0tIFN0ZXZlDQpTb3JyeSBhYm91dCB0aGF0LiBUaGVyZSBp
cyBhY3R1YWxseSB2MiBvZiB0aGlzIHBhdGNoc2V0IG91dCB0aGVyZSwgd2hlcmUgdGhlcmUNCmFy
ZSBubyBjb2RlIGNoYW5nZXMgZm9yIHRoaXMgcGF0Y2gsIGJ1dCBpdCBpcyBzcGxpdCBpbnRvIHNl
cGFyYXRlIHBhdGNoZXMgZm9yDQplYWNoIHN1YnN5c3RlbS4gSXQgaGFzICJ4ODYvZnRyYWNlOiAi
IGZvciB0aGUgZnRyYWNlIHBhdGNoLg0KDQpSaWNrDQo=
