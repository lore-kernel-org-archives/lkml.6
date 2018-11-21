Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024BE214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024BE214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732928AbeKVGXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:23:49 -0500
Received: from mga18.intel.com ([134.134.136.126]:62521 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbeKVGXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:23:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2018 11:48:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,262,1539673200"; 
   d="scan'208";a="110471809"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga002.jf.intel.com with ESMTP; 21 Nov 2018 11:48:08 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.8]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.166]) with mapi id 14.03.0415.000;
 Wed, 21 Nov 2018 11:48:08 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v2 0/2] bpf: permit JIT allocations to be served outside
 the module region
Thread-Topic: [PATCH v2 0/2] bpf: permit JIT allocations to be served
 outside the module region
Thread-Index: AQHUgZydCKe1eTjWBEyL9vhgp2X8cqVbKbGA
Date:   Wed, 21 Nov 2018 19:48:07 +0000
Message-ID: <9d7f77959e1be0a9a3ff511a8fc45518068c85a6.camel@intel.com>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.128]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D81533A08F543140AC15BAFCF1713818@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTIxIGF0IDE0OjE3ICswMTAwLCBBcmQgQmllc2hldXZlbCB3cm90ZToN
Cj4gT24gYXJtNjQsIG1vZHVsZXMgYXJlIGFsbG9jYXRlZCBmcm9tIGEgMTI4IE1CIHdpbmRvdyB3
aGljaCBpcyBjbG9zZSB0bw0KPiB0aGUgY29yZSBrZXJuZWwsIHNvIHRoYXQgcmVsYXRpdmUgZGly
ZWN0IGJyYW5jaGVzIGFyZSBndWFyYW50ZWVkIHRvIGJlDQo+IGluIHJhbmdlIChleGNlcHQgaW4g
c29tZSBLQVNMUiBjb25maWd1cmF0aW9ucykuIEFsc28sIG1vZHVsZV9hbGxvYygpDQo+IGlzIGlu
IGNoYXJnZSBvZiBhbGxvY2F0aW5nIEtBU0FOIHNoYWRvdyBtZW1vcnkgd2hlbiBydW5uaW5nIHdp
dGggS0FTQU4NCj4gZW5hYmxlZC4NCj4gDQo+IFRoaXMgbWVhbnMgdGhhdCB0aGUgd2F5IEJQRiBy
ZXVzZXMgbW9kdWxlX2FsbG9jKCkvbW9kdWxlX21lbWZyZWUoKSBpcw0KPiB1bmRlc2lyYWJsZSBv
biBhcm02NCAoYW5kIHBvdGVudGlhbGx5IG90aGVyIGFyY2hpdGVjdHVyZXMgYXMgd2VsbCksDQo+
IGFuZCBzbyB0aGlzIHNlcmllcyByZWZhY3RvcnMgQlBGJ3MgdXNlIG9mIHRob3NlIGZ1bmN0aW9u
cyB0byBwZXJtaXQNCj4gYXJjaGl0ZWN0dXJlcyB0byBjaGFuZ2UgdGhpcyBiZWhhdmlvci4NCj4g
DQpIaSBBcmQsDQoNCkkgYW0gbG9va2luZyBhdCBhZGRpbmcgb3B0aW9uYWwgQlBGIEpJVCBpbiB2
bWFsbG9jIGZ1bmN0aW9uYWxpdHkgZm9yIHg4NiB0aGF0DQp3b3VsZCB1c2UgdGhpcyByZWZhY3Rv
ci4gSW4gZmFjdCBJIGhhdmUgZG9uZSB0aGUgc2FtZSB0aGluZyB3aXRoIGp1c3QgZGlmZmVyZW50
DQpuYW1lcy4NCg0KTXkgaW1wbGVtZW50YXRpb24gaW50ZW5kcyB0byB1c2UgdGhlIG1vZHVsZSBz
cGFjZSB1bnRpbCBhIHVzYWdlIGxpbWl0IGlzIHJlYWNoZWQNCmFuZCB0aGVuIG92ZXJmbG93IGlu
dG8gdm1hbGxvYywgc28gaXQgd291bGQgYmUgYW4gYWRkaXRpb25hbCBrbm9iIGxpa2UNCiJicGZf
aml0X2xpbWl0Ii4gV29uZGVyaW5nIGlmIHRoYXQgc2hvdWxkIGJlIGEgY3Jvc3MtYXJjaCBjb25j
ZXB0IHRoYXQgY29ubmVjdHMNCnRvIHRoaXMuIERvZXMgaXQgZml0IGluIHdpdGggd2hhdCB5b3Ug
YXJlIHRyeWluZyB0byBkbyBmb3IgYXJtNjQgaGVyZT8NCg0KVGhhbmtzLA0KDQpSaWNrDQo=
