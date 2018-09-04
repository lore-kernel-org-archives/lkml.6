Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2423C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B37420869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:23:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B37420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeIDKqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:46:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:28041 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbeIDKqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 23:22:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="68183004"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 03 Sep 2018 23:22:24 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 3 Sep 2018 23:22:13 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 3 Sep 2018 23:22:13 -0700
Received: from shsmsx103.ccr.corp.intel.com ([169.254.4.240]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 14:22:10 +0800
From:   "Yang, Bin" <bin.yang@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 3/5] x86/mm: add help function to check specific
 protection flags in range
Thread-Topic: [PATCH v3 3/5] x86/mm: add help function to check specific
 protection flags in range
Thread-Index: AQHUOOyheVq47NZM80Gn2ALUdJB6D6TereYAgACJEoA=
Date:   Tue, 4 Sep 2018 06:22:09 +0000
Message-ID: <6709897a0ecec7112a52a53d3fe2d3fca649c902.camel@intel.com>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>
         <1534814186-37067-4-git-send-email-bin.yang@intel.com>
         <alpine.DEB.2.21.1809032357430.1462@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809032357430.1462@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.4.160]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BB55705DAC66E48863D03ADB9B9C514@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE4LTA5LTA0IGF0IDAwOjEwICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IE9uIFR1ZSwgMjEgQXVnIDIwMTgsIEJpbiBZYW5nIHdyb3RlOg0KPiA+ICAvKg0KPiA+ICsg
KiBzdGF0aWNfcHJvdGVjdGlvbnMoKSAiZm9yY2VzIiBwYWdlIHByb3RlY3Rpb25zIGZvciBzb21l
IGFkZHJlc3MNCj4gPiArICogcmFuZ2VzLiAgUmV0dXJuIHRydWUgaWYgYW55IHBhcnQgb2YgdGhl
IGFkZHJlc3MvbGVuIHJhbmdlIGlzIGZvcmNlZA0KPiA+ICsgKiB0byBjaGFuZ2UgZnJvbSAncHJv
dCcuDQo+ID4gKyAqLw0KPiA+ICtzdGF0aWMgaW5saW5lIGJvb2wNCj4gPiArbmVlZHNfc3RhdGlj
X3Byb3RlY3Rpb25zKHBncHJvdF90IHByb3QsIHVuc2lnbmVkIGxvbmcgYWRkcmVzcywNCj4gPiAr
CQl1bnNpZ25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9uZyBwZm4pDQo+ID4gK3sNCj4gPiArCWlu
dCBpOw0KPiA+ICsNCj4gPiArCWFkZHJlc3MgJj0gUEFHRV9NQVNLOw0KPiA+ICsJbGVuID0gUEZO
X0FMSUdOKGxlbik7DQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgKGxlbiA+PiBQQUdFX1NISUZUKTsg
aSsrLCBhZGRyZXNzICs9IFBBR0VfU0laRSwgcGZuKyspIHsNCj4gPiArCQlwZ3Byb3RfdCBjaGtf
cHJvdCA9IHN0YXRpY19wcm90ZWN0aW9ucyhwcm90LCBhZGRyZXNzLCBwZm4pOw0KPiA+ICsNCj4g
PiArCQlpZiAocGdwcm90X3ZhbChjaGtfcHJvdCkgIT0gcGdwcm90X3ZhbChwcm90KSkNCj4gPiAr
CQkJcmV0dXJuIHRydWU7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogRG9lcyBzdGF0aWNfcHJv
dGVjdGlvbnMoKSBkZW1hbmQgYSBjaGFuZ2UgPyAqLw0KPiA+ICsJcmV0dXJuIGZhbHNlOw0KPiA+
ICt9DQo+IA0KPiAuLi4NCj4gDQo+ID4gIAlpZiAoY3BhLT5mb3JjZV9zcGxpdCkNCj4gPiBAQCAt
NjYwLDE0ICs2ODQsOCBAQCB0cnlfcHJlc2VydmVfbGFyZ2VfcGFnZShwdGVfdCAqa3B0ZSwgdW5z
aWduZWQgbG9uZyBhZGRyZXNzLA0KPiA+ICAJICogc3RhdGljX3Byb3RlY3Rpb24oKSByZXF1aXJl
cyBhIGRpZmZlcmVudCBwZ3Byb3QgZm9yIG9uZSBvZg0KPiA+ICAJICogdGhlIHBhZ2VzIGluIHRo
ZSByYW5nZSB3ZSB0cnkgdG8gcHJlc2VydmU6DQo+ID4gIAkgKi8NCj4gPiAtCXBmbiA9IG9sZF9w
Zm47DQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgKHBzaXplID4+IFBBR0VfU0hJRlQpOyBpKyssIGFk
ZHIgKz0gUEFHRV9TSVpFLCBwZm4rKykgew0KPiA+IC0JCXBncHJvdF90IGNoa19wcm90ID0gc3Rh
dGljX3Byb3RlY3Rpb25zKHJlcV9wcm90LCBhZGRyLCBwZm4pOw0KPiA+IC0NCj4gPiAtCQlpZiAo
cGdwcm90X3ZhbChjaGtfcHJvdCkgIT0gcGdwcm90X3ZhbChuZXdfcHJvdCkpDQo+ID4gLQkJCWdv
dG8gb3V0X3VubG9jazsNCj4gPiAtCX0NCj4gPiAtDQo+ID4gKwlpZiAobmVlZHNfc3RhdGljX3By
b3RlY3Rpb25zKG5ld19wcm90LCBhZGRyLCBwc2l6ZSwgb2xkX3BmbikpDQo+ID4gKwkJZ290byBv
dXRfdW5sb2NrOw0KPiANCj4gVGhpcyBpcyBub3QgdGhlIHNhbWUuIFRoZSBleGlzdGluZyBjb2Rl
IGRvZXM6DQo+IA0KPiAgICAgIG5ld19wcm90ID0gc3RhdGljX3Byb3RlY3Rpb25zKHJlcV9wcm90
LCBhZGRyZXNzLCBwZm4pOw0KPiANCj4gd2hpY2ggaXMgdGhlIHByb3RlY3Rpb24gdXBkYXRlZCBw
Z3Byb3QgZm9yIHRoZSBiYXNlIG9mIHRoZSBhZGRyZXNzIHJhbmdlDQo+IHdoaWNoIHNob3VsZCBi
ZSBtb2RpZmllZC4gVGhlIGxvb3AgZG9lczoNCj4gDQo+ICAgICBjaGtfcHJvdCA9IHN0YXRpY19w
cm90ZWN0aW9ucyhyZXFfcHJvdCwgYWRkciwgcGZuKTsNCj4gDQo+ICAgICBpZiAoY2hrX3Byb3Qg
IT0gbmV3X3Byb3QpDQo+ICAgICAJICAgZ290byBzcGxpdDsNCj4gDQo+IE5vdyBtYXBwaW5nIHlv
dXIgbmV3IGZ1bmN0aW9uIGJhY2sgYW5kIHRoZW4gdGhlIGxvb3AgYmVjb21lczoNCj4gDQo+ICAg
ICBjaGtfcHJvdCA9IHN0YXRpY19wcm90ZWN0aW9ucyhuZXdfcHJvdCwgYWRkciwgcGZuKTsNCj4g
DQo+ICAgICBpZiAoY2hrX3Byb3QgIT0gbmV3X3Byb3QpDQo+ICAgICAJICAgZ290byBzcGxpdDsN
Cj4gDQo+IHdoaWNoIGlzIGJyb2tlbiBpbiBjYXNlIHRoYXQgYWZ0ZXIgdGhlIGluaXRpYWwgc3Rh
dGljIHByb3RlY3Rpb25zDQo+IGludm9jYXRpb24NCj4gDQo+IAluZXdfcHJvdCA9IHN0YXRpY19w
cm90ZWN0aW9ucyhyZXFfcHJvdCwgYWRkcmVzcywgcGZuKTsNCj4gDQo+IHRoZSByZXN1bHQgaXM6
DQo+IA0KPiAgICBuZXdfcHJvdCAhPSByZXFfcHJvdA0KPiANCj4gYW5kIGluIHRoZSBsb29wDQo+
IA0KPiAgICBuZXdfcHJvdCBpcyB2YWxpZCBmb3IgX0FMTF8gcGFnZXMgaW4gdGhlIGxhcmdlIHBh
Z2UgYmVjYXVzZSB0aGUgc3RhdGljDQo+ICAgIHByb3RlY3Rpb24gd2hpY2ggZ290IGFwcGxpZWQg
Zm9yIHRoZSBmaXJzdCBhZGRyZXNzIGNhbiBiZSBhcHBsaWVkIHRvIHRoZQ0KPiAgICBjb21wbGV0
ZSByYW5nZSwgaS5lLiBuZXdfcHJvdCBpdCBpcyBub3QgZnVydGhlciBtb2RpZmllZCBieQ0KPiAg
ICBzdGF0aWNfcHJvdGVjdGlvbnMoKSBmb3IgYW55IHBhZ2UuDQo+IA0KPiBUaGF0IGFnYWluIGNh
biBjYXVzZSB3cm9uZyBsYXJnZSBwYWdlIHByZXNlcnZhdGlvbnMuDQoNClNvcnJ5IGZvciB0aGlz
IG1pc3Rha2UuIENvdWxkIEkgY2hhbmdlIGl0IGFzIGJlbG93Pw0KDQpzdGF0aWMgaW5saW5lIGJv
b2wNCm5lZWRzX3N0YXRpY19wcm90ZWN0aW9ucyhwZ3Byb3RfdCBuZXdfcHJvdCwgcGdwcm90X3Qg
cmVxX3Byb3QsDQogICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBhZGRyZXNzLCB1bnNpZ25l
ZCBsb25nIGxlbiwgdW5zaWduZWQgbG9uZyBwZm4pDQouLi4NCiAgICAgICAgICAgICAgICBwZ3By
b3RfdCBjaGtfcHJvdCA9IHN0YXRpY19wcm90ZWN0aW9ucyhyZXFfcHJvdCwgYWRkcmVzcywgcGZu
KTsNCg0KICAgICAgICAgICAgICAgIGlmIChwZ3Byb3RfdmFsKGNoa19wcm90KSAhPSBwZ3Byb3Rf
dmFsKG5ld19wcm90KSkNCi4uLg0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAJdGdseA0KPiANCg==
