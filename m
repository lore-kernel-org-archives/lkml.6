Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D1AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EF420838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EF420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeH3W2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:28:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:49478 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbeH3W2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:28:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 11:25:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="70381986"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2018 11:24:30 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 30 Aug 2018 11:24:29 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.2]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.64]) with mapi id 14.03.0319.002;
 Thu, 30 Aug 2018 11:24:29 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] KASLR feature to randomize each loadable module
Thread-Topic: [PATCH v4 0/3] KASLR feature to randomize each loadable module
Thread-Index: AQHUP+v93yMqf0bnq0qPnDSGtSat5qTYB2EAgAELowA=
Date:   Thu, 30 Aug 2018 18:24:28 +0000
Message-ID: <1535653498.1689.175.camel@intel.com>
References: <1535583579-6138-1-git-send-email-rick.p.edgecombe@intel.com>
         <20180830022703.xxl5eolthinicgwp@ast-mbp>
In-Reply-To: <20180830022703.xxl5eolthinicgwp@ast-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.168]
Content-Type: text/plain; charset="utf-8"
Content-ID: <428C3DEADE9E50409548C98A6FE035EE@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA4LTI5IGF0IDE5OjI3IC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFdlZCwgQXVnIDI5LCAyMDE4IGF0IDAzOjU5OjM2UE0gLTA3MDAsIFJpY2sgRWRn
ZWNvbWJlIHdyb3RlOg0KPiA+IENoYW5nZXMgZm9yIFYzOg0KPiA+IMKgLSBDb2RlIGNsZWFudXAg
YmFzZWQgb24gaW50ZXJuYWwgZmVlZGJhY2suICh0aGFua3MgdG8gRGF2ZSBIYW5zZW4gYW5kDQo+
ID4gQW5kcml5DQo+ID4gwqDCoMKgU2hldmNoZW5rbykNCj4gPiDCoC0gU2xpZ2h0IHJlZmFjdG9y
IG9mIGV4aXN0aW5nIGFsZ29yaXRobSB0byBtb3JlIGNsZWFubHkgbGl2ZSBhbG9uZyBzaWRlIG5l
dw0KPiA+IMKgwqDCoG9uZS4NCj4gPiDCoC0gQlBGIHN5bnRoZXRpYyBiZW5jaG1hcmsNCj4gSSBk
b24ndCBzZWUgdGhpcyBiZW5jaG1hcmsgaW4gdGhpcyBwYXRjaCBzZXQuDQo+IENvdWxkIHlvdSBw
cmVwYXJlIGl0IGFzIGEgdGVzdCBpbiB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvID8NCj4g
c28gd2UgY2FuIGRvdWJsZSBjaGVjayB3aGF0IGlzIGJlaW5nIHRlc3RlZCBhbmQgcnVuIGl0IHJl
Z3VsYXJseQ0KPiBsaWtlIHdlIGRvIGZvciBhbGwgb3RoZXIgdGVzdHMgaW4gdGhlcmUuDQpTdXJl
Lg0KDQpUaGVyZSB3ZXJlIHR3byBiZW5jaG1hcmtzIEkgaGFkIHJ1biB3aXRoIEJQRiBpbiBtaW5k
LCBvbmUgd2FzIHRoZSB0aW1pbmcgdGhlDQptb2R1bGVfYWxsb2MgZnVuY3Rpb24gaW4gZGlmZmVy
ZW50IHNjZW5hcmlvcywgbG9va2luZyB0byBtYWtlIHN1cmUgdGhlcmUgd2VyZSBubw0Kc2xvd2Rv
d25zIGZvciBpbnNlcnRpb25zLg0KDQpUaGUgb3RoZXIgd2FzIHRvIGNoZWNrIGlmIHRoZSBmcmFn
bWVudGF0aW9uIGNhdXNlZCBhbnkgbWVhc3VyYWJsZSBydW50aW1lDQpwZXJmb3JtYW5jZToNCiJG
b3IgcnVudGltZSBwZXJmb3JtYW5jZSwgYSBzeW50aGV0aWMgYmVuY2htYXJrIHdhcyBydW4gdGhh
dCBkb2VzIDUwMDAwMDAgQlBGDQpKSVQgaW52b2NhdGlvbnMgZWFjaCwgZnJvbSB2YXJ5aW5nIG51
bWJlcnMgb2YgcGFyYWxsZWwgcHJvY2Vzc2VzLCB3aGlsZSB0aGUNCmtlcm5lbCBjb21waWxlcyBz
aGFyaW5nIHRoZSBzYW1lIENQVSB0byBzdGFuZCBpbiBmb3IgdGhlIGNhY2hlIGltcGFjdCBvZiBh
IHJlYWwNCndvcmtsb2FkLiBUaGUgc2VjY29tcCBmaWx0ZXIgaW52b2NhdGlvbnMgd2VyZSBqdXN0
IEphbm4gSG9ybidzIHNlY2NvbXAgZmlsdGVyaW5nDQp0ZXN0IGZyb20gdGhpcyB0aHJlYWQgaHR0
cDovL29wZW53YWxsLmNvbS9saXN0cy9rZXJuZWwtaGFyZGVuaW5nLzIwMTgvMDcvMTgvMiwNCmV4
Y2VwdCBub24tcmVhbCB0aW1lIHByaW9yaXR5LiBUaGUga2VybmVsIHdhcyBjb25maWd1cmVkIHdp
dGggS1BUSSBhbmQNCnJldHBvbGluZSwgYW5kIHBjaWQgd2FzIGRpc2FibGVkLiBUaGVyZSB3YXNu
J3QgYW55IHNpZ25pZmljYW50IGRpZmZlcmVuY2UNCmJldHdlZW4gdGhlIG5ldyBhbmQgdGhlIG9s
ZC4iDQoNCkZyb20gd2hhdCBJIGtub3cgYWJvdXQgdGhlIGJwZiBrc2VsZnRlc3QsIHRoZSBmaXJz
dCBvbmUgd291bGQgcHJvYmFibHkgYmUgYQ0KYmV0dGVyIGZpdC4gTm90IHN1cmUgaWYgdGhlIHNl
Y29uZCBvbmUgd291bGQgZml0LCB3aXRoIHRoZSBrZXJuZWwgY29tcGlsaW5nDQpzaGFyaW5nIHRo
ZSBzYW1lIENQVSwgYSBzcGVjaWFsIGNvbmZpZywgYW5kIGEgaHVnZSBhbW91bnQgb2YgcHJvY2Vz
c2VzIGJlaW5nDQpzcGF3bmVkLi4uIEkgY2FuIHRyeSB0byBhZGQgYSBtaWNyby1iZW5jaG1hcmsg
aW5zdGVhZCBpZiB0aGF0IHNvdW5kcyBnb29kLg0KDQpSaWNr
