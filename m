Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7522AC00319
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC4A20842
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfBVAzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:55:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:32672 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbfBVAzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:55:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 16:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="135401743"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2019 16:55:50 -0800
Received: from orsmsx115.amr.corp.intel.com (10.22.240.11) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Feb 2019 16:55:49 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.70]) by
 ORSMSX115.amr.corp.intel.com ([169.254.4.136]) with mapi id 14.03.0415.000;
 Thu, 21 Feb 2019 16:55:49 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
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
        <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v3 18/20] x86/ftrace: Use vmalloc special flag
Thread-Topic: [PATCH v3 18/20] x86/ftrace: Use vmalloc special flag
Thread-Index: AQHUykBbJ0x53lHatE6GL2AlMLdzQ6XreugAgAAJbQA=
Date:   Fri, 22 Feb 2019 00:55:49 +0000
Message-ID: <3cd659eb8c7d43cf46bebc6562c1c26bb6c51b51.camel@intel.com>
References: <20190221234451.17632-1-rick.p.edgecombe@intel.com>
         <20190221234451.17632-19-rick.p.edgecombe@intel.com>
         <20190221192210.3e038fc3@gandalf.local.home>
In-Reply-To: <20190221192210.3e038fc3@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A4A8CD00D4DF448B0BFB3995685F0A4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAyLTIxIGF0IDE5OjIyIC0wNTAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gVGh1LCAyMSBGZWIgMjAxOSAxNTo0NDo0OSAtMDgwMA0KPiBSaWNrIEVkZ2Vjb21iZSA8
cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBVc2UgbmV3IGZsYWcg
Vk1fRkxVU0hfUkVTRVRfUEVSTVMgZm9yIGhhbmRsaW5nIGZyZWVpbmcgb2Ygc3BlY2lhbA0KPiA+
IHBlcm1pc3Npb25lZCBtZW1vcnkgaW4gdm1hbGxvYyBhbmQgcmVtb3ZlIHBsYWNlcyB3aGVyZSBt
ZW1vcnkgd2FzIHNldCBOWA0KPiA+IGFuZCBSVyBiZWZvcmUgZnJlZWluZyB3aGljaCBpcyBubyBs
b25nZXIgbmVlZGVkLg0KPiA+IA0KPiA+IENjOiBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29k
bWlzLm9yZz4NCj4gPiBBY2tlZC1ieTogU3RldmVuIFJvc3RlZHQgKFZNd2FyZSkgPHJvc3RlZHRA
Z29vZG1pcy5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9rZXJuZWwvZnRyYWNl
LmMgfCA2ICsrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvZnRyYWNl
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvZnRyYWNlLmMNCj4gPiBpbmRleCAxM2M4MjQ5YjE5N2YuLjkz
ZWZlMzk1NTMzMyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvZnRyYWNlLmMNCj4g
PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnRyYWNlLmMNCj4gPiBAQCAtNjkyLDEwICs2OTIsNiBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgKmFsbG9jX3RyYW1wKHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4g
PiAgfQ0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgdHJhbXBfZnJlZSh2b2lkICp0cmFtcCwgaW50
IHNpemUpDQo+IA0KPiBBcyBzaXplIGlzIG5vIGxvbmdlciB1c2VkIHdpdGhpbiB0aGUgZnVuY3Rp
b24sIGNhbiB5b3UgcmVtb3ZlIHRoYXQgdG9vLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gLS0gU3Rl
dmUNCj4gDQpHb29kIHBvaW50LCBJJ2xsIHJlbW92ZSBpdC4NCg0KVGhhbmtzLA0KDQpSaWNrDQoN
CltzbmlwXQ0K
