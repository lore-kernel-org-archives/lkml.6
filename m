Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F800C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EBD21B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731869AbfBKT1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:27:06 -0500
Received: from mga07.intel.com ([134.134.136.100]:9822 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbfBKT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:27:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 11:27:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="319486949"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga005.fm.intel.com with ESMTP; 11 Feb 2019 11:27:04 -0800
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 11 Feb 2019 11:27:03 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.70]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.122]) with mapi id 14.03.0415.000;
 Mon, 11 Feb 2019 11:27:03 -0800
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
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
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v2 13/20] Add set_alias_ function and x86 implementation
Thread-Topic: [PATCH v2 13/20] Add set_alias_ function and x86 implementation
Thread-Index: AQHUt2sVkrG1Bgg4x0e07u2CUOZGlKXbkeGAgAAE7gA=
Date:   Mon, 11 Feb 2019 19:27:03 +0000
Message-ID: <468a81ee8983a7dfc3e5ab5c269fc89ff16b6b21.camel@intel.com>
References: <20190129003422.9328-1-rick.p.edgecombe@intel.com>
         <20190129003422.9328-14-rick.p.edgecombe@intel.com>
         <20190211190925.GQ19618@zn.tnic>
In-Reply-To: <20190211190925.GQ19618@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <112F179FA06F5143B572137122F136C3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAyLTExIGF0IDIwOjA5ICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IE9uIE1vbiwgSmFuIDI4LCAyMDE5IGF0IDA0OjM0OjE1UE0gLTA4MDAsIFJpY2sgRWRnZWNv
bWJlIHdyb3RlOg0KPiA+IFRoaXMgYWRkcyB0d28gbmV3IGZ1bmN0aW9ucyBzZXRfYWxpYXNfZGVm
YXVsdF9ub2ZsdXNoIGFuZA0KPiANCj4gcy9UaGlzIGFkZHMvQWRkLw0KPiANCj4gPiBzZXRfYWxp
YXNfbnZfbm9mbHVzaCBmb3Igc2V0dGluZyB0aGUgYWxpYXMgbWFwcGluZyBmb3IgdGhlIHBhZ2Ug
dG8gaXRzDQo+IA0KPiBQbGVhc2UgZW5kIGZ1bmN0aW9uIG5hbWVzIHdpdGggcGFyZW50aGVzZXMs
IGJlbG93IHRvby4NCk9rLg0KPiA+IGRlZmF1bHQgdmFsaWQgcGVybWlzc2lvbnMgYW5kIHRvIGFu
IGludmFsaWQgc3RhdGUgdGhhdCBjYW5ub3QgYmUgY2FjaGVkIGluDQo+ID4gYSBUTEIsIHJlc3Bl
Y3RpdmVseS4gVGhlc2UgZnVuY3Rpb25zIHRvIG5vdCBmbHVzaCB0aGUgVExCLg0KPiANCj4gcy90
by9kby8NCj4gDQpBcmdoLCB0aGFua3MuDQo+IEFsc28sIHBscyBwdXQgdGhhdCBkZXNjcmlwdGlv
biBhcyBjb21tZW50cyBvdmVyIHRoZSBmdW5jdGlvbnMgaW4gdGhlDQo+IGNvZGUuIE90aGVyd2lz
ZSB0aGF0ICJudiIgYXMgcGFydCBvZiB0aGUgbmFtZSBkb2Vzbid0IHJlYWxseSBleHBsYWluDQo+
IHdoYXQgaXQgZG9lcy4NCj4gDQo+IEFjdHVhbGx5LCB5b3UgY291bGQganVzdCBhcyB3ZWxsIGNh
bGwgdGhlIGZ1bmN0aW9uDQo+IA0KPiBzZXRfYWxpYXNfaW52YWxpZF9ub2ZsdXNoKCkNCj4gDQo+
IEFsbCB0aGUgb3RoZXIgd29yZHMgYXJlIHdyaXR0ZW4gaW4gZnVsbCwgbm8gbmVlZCB0byBoYXZl
ICJudiIgdGhlcmUuDQo+IA0KPiBUaHguDQpZZXMsIHRoYXQgc2VlbXMgYmV0dGVyLg0KDQpUaGFu
a3MsDQoNClJpY2sNCg==
