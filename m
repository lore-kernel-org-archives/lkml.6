Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4572FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 053F423BFB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 053F423BFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933495AbeGDKPu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:15:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:54638 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932652AbeGDKPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:15:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2018 03:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,306,1526367600"; 
   d="scan'208";a="52559879"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga008.fm.intel.com with ESMTP; 04 Jul 2018 03:15:48 -0700
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 03:15:48 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 4 Jul 2018 03:15:47 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.81]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.57]) with mapi id 14.03.0319.002;
 Wed, 4 Jul 2018 18:15:46 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
Thread-Topic: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
Thread-Index: AQHUDseZVh/k/cdi3Uy1ChlFZXY9E6R9B+GAgAEOxwCAABo1AIAAGosAgAABdYCAAA8QgA==
Date:   Wed, 4 Jul 2018 10:15:45 +0000
Message-ID: <34a76fad5c43c11ce8ceb491537b453d8053bdb2.camel@intel.com>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>
          <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de>
          <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>
          <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de>
         <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com>
         <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.4.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C72B6A02C414EA4EA3F2949637359C1F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZTgyMCB0YWJsZToNCj09PT09PT09PT09PT09PT09DQoNClsgICAgMC4wMDAwMDBdIEJJT1MtZTgy
MDogW21lbSAweDAwMDAwMDAwMDAwMDAwMDAtMHgwMDAwMDAwMDAwMDlmYmZmXQ0KdXNhYmxlDQpb
ICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMDlmYzAwLTB4MDAwMDAw
MDAwMDA5ZmZmZl0NCnJlc2VydmVkDQpbICAgIDAuMDAwMDAwXSBCSU9TLWU4MjA6IFttZW0gMHgw
MDAwMDAwMDAwMGYwMDAwLTB4MDAwMDAwMDAwMDBmZmZmZl0NCnJlc2VydmVkDQpbICAgIDAuMDAw
MDAwXSBCSU9TLWU4MjA6IFttZW0gMHgwMDAwMDAwMDAwMTAwMDAwLTB4MDAwMDAwMDBiZmZkZmZm
Zl0NCnVzYWJsZQ0KWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBiZmZl
MDAwMC0weDAwMDAwMDAwYmZmZmZmZmZdDQpyZXNlcnZlZA0KWyAgICAwLjAwMDAwMF0gQklPUy1l
ODIwOiBbbWVtIDB4MDAwMDAwMDBmZWZmYzAwMC0weDAwMDAwMDAwZmVmZmZmZmZdDQpyZXNlcnZl
ZA0KWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBmZmZjMDAwMC0weDAw
MDAwMDAwZmZmZmZmZmZdDQpyZXNlcnZlZA0KWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVt
IDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDAxM2ZmZmZmZmZdDQp1c2FibGUNCg0KY2FsbCBj
aGFpbjoNCj09PT09PT09PT09PT09PT09PT09PT0NCg0KLi4uDQo9PiBmcmVlX2luaXRfcGFnZXMo
d2hhdD0iaW5pdHJkIiBvciAidW51c2VkIGtlcm5lbCIsDQpiZWdpbj1mZmZmOWIyNmIuLi4uMDAw
LCBlbmQ9ZmZmZjliMjZjLi4uLjAwMCk7IGJlZ2luIGFuZCBlbmQgYWRkcmVzc2VzDQphcmUgcmFu
ZG9tLiBUaGUgYmVnaW4vZW5kIHZhbHVlIGFib3ZlIGlzIGp1c3QgZm9yIHJlZmVyZW5jZS4NCg0K
PT4gc2V0X21lbW9yeV9ydygpDQo9PiBjaGFuZ2VfcGFnZV9hdHRyX3NldCgpDQo9PiBjaGFuZ2Vf
cGFnZV9hdHRyX3NldF9jbHIoKQ0KPT4gX19jaGFuZ2VfcGFnZV9hdHRyX3NldF9jbHIoKTsgY3Bh
LT5udW1wYWdlcyBpcyA1MTIgb24gbXkgYm9hcmQgaWYNCndoYXQ9PSJ1bnVzZWQga2VybmVsIg0K
PT4gX19jaGFuZ2VfcGFnZV9hdHRyKCkNCj0+IHRyeV9wcmVzZXJ2ZV9sYXJnZV9wYWdlKCk7IGFk
ZHJlc3M9ZmZmZjliMjZiZmFjZjAwMCwgcGZuPTgwMDAwLA0KbGV2ZWw9MzsgYW5kIHRoZSBjaGVj
ayBsb29wIGNvdW50IGlzIDI2MjE0NCwgZXhpdCBsb29wIGFmdGVyIDg2MSB1c2Vjcw0Kb24gbXkg
Ym9hcmQNCg0KDQp0aGUgYWN0dWFsIHByb2JsZW0NCj09PT09PT09PT09PT09PT09PT0NCnNvbWV0
aW1lcywgZnJlZV9pbml0X3BhZ2VzIHJldHVybnMgYWZ0ZXIgaHVuZHJlZHMgb2Ygc2Vjb3VuZHMu
IFRoZQ0KbWFqb3IgaW1wYWN0IGlzIGtlcm5lbCBib290IHRpbWUuDQoNCg0KT24gV2VkLCAyMDE4
LTA3LTA0IGF0IDExOjIwICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IE9uIFdlZCwg
NCBKdWwgMjAxOCwgWWFuZywgQmluIHdyb3RlOg0KPiANCj4gPiBZb3UgYXJlIGNvbXBsZXRlbHkg
cmlnaHQuIEFmdGVyIGNvbnNpZGVyaW5nLCBJIHRoaW5rIG15IHBhdGNoIGlzDQo+ID4gbGlrZSBh
DQo+ID4gd29ya2Fyb3VuZCBidXQgbm90IHJlYWwgZml4LiBJIGFtIHRyeWluZyB0byByZS13cml0
ZSBhIG5ldyBwYXRjaA0KPiA+IHdpdGhvdXQgY2FjaGUgaW1wbGVtZW50YXRpb24uDQo+IA0KPiBD
YXJlIHRvIGV4cGxhaW4gdGhlIGFjdHVhbCBwcm9ibGVtIGNvaGVyZW50bHkgX2JlZm9yZV8gd3Jp
dGluZyB5ZXQNCj4gYW5vdGhlcg0KPiBwYXRjaD8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4
