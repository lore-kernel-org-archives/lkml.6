Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36C020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36C020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbeHaB7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:59:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:9008 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbeHaB7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:59:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 14:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,308,1531810800"; 
   d="scan'208";a="81682116"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga002.fm.intel.com with ESMTP; 30 Aug 2018 14:51:03 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 30 Aug 2018 14:51:03 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 FMSMSX102.amr.corp.intel.com ([169.254.10.133]) with mapi id 14.03.0319.002;
 Thu, 30 Aug 2018 14:51:02 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>,
        "oceanhehy@gmail.com" <oceanhehy@gmail.com>,
        "Jiang, Dave" <dave.jiang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "hehy1@lenovo.com" <hehy1@lenovo.com>
Subject: Re: [PATCH] libnvdimm, region_devs: stop NDD_ALIASING bit test if
 one test pass
Thread-Topic: [PATCH] libnvdimm, region_devs: stop NDD_ALIASING bit test if
 one test pass
Thread-Index: AQHUN3FcsL+8tCG990ewsmJSCVMzj6TZXYoA
Date:   Thu, 30 Aug 2018 21:51:01 +0000
Message-ID: <1535665860.5995.78.camel@intel.com>
References: <1534651288-30306-1-git-send-email-oceanhehy@gmail.com>
In-Reply-To: <1534651288-30306-1-git-send-email-oceanhehy@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A477C5E3CE53F441B670DD46FE4182C9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBTdW4sIDIwMTgtMDgtMTkgYXQgMDA6MDEgLTA0MDAsIE9jZWFuIEhlIHdyb3RlOg0KPiBG
cm9tOiBPY2VhbiBIZSA8aGVoeTFAbGVub3ZvLmNvbT4NCj4gDQo+IFRoZXJlIGlzIG5vIG5lZWQg
dG8gZmluaXNoIGVudGlyZSBsb29wIHRvIGV4ZWN1dGUgTkREX0FMSUFTSU5HIGJpdA0KPiB0ZXN0
DQo+IGFnYWluc3QgZXZlcnkgbnZkaW1tLT5mbGFncy4gSW4gcHJhY3RpY2UsIGFsbCB0aGUgbmRf
bWFwcGluZy0+bnZkaW1tDQo+IGhhdmUgdGhlIHNhbWUgZmxhZ3MuDQo+IA0KPiBCZWNhdXNlIHRo
ZSBjaGVjayBvZiBhbGlhcyBpcyAiaWYgKGFsaWFzKSIgYnV0IG5vdCANCj4gImlmIChhbGlhcyA9
PSBuZF9yZWdpb24tPm5kcl9tYXBwaW5ncykiLCB0aGVyZSBpcyBubyBmdW5jdGlvbiBjaGFuZ2UN
Cj4gd2hpbGUNCj4ganVzdCBzYXZlIGEgZmV3IGN5Y2xlcy4gIA0KPiANCj4gU2lnbmVkLW9mZi1i
eTogT2NlYW4gSGUgPGhlaHkxQGxlbm92by5jb20+DQo+IC0tLQ0KPiBBIHRlc3QgdG8gY2hlY2sg
aWYgYWxsIHRoZSBuZF9tYXBwaW5nLT5udmRpbW0gaGF2ZSB0aGUgc2FtZSBmbGFncywNCj4gdXNp
bmcgDQo+IExlbm92byBUaGlua1N5c3RlbSBTUjYzMCBhbmQgNC4xOC1yYzYuDQo+IA0KPiAjIGlw
bWN0bCBzaG93IC1kaW1tDQo+IA0KPiBEaW1tSUQgIENhcGFjaXR5ICAgICAgICBIZWFsdGhTdGF0
ZSAgICAgQWN0aW9uUmVxdWlyZWQgIExvY2tTdGF0ZSAgICANCj4gICAgRldWZXJzaW9uDQo+IDB4
MDAyMSAgMTI1LjcNCj4gR2lCICAgICAgIEhlYWx0aHkgICAgICAgICAwICAgICAgICAgICAgICAg
RGlzYWJsZWQgICAgICAgIDAxLjAwLjAwLjQ4DQo+IDg4DQo+IDB4MDEyMSAgMTI1LjcNCj4gR2lC
ICAgICAgIEhlYWx0aHkgICAgICAgICAwICAgICAgICAgICAgICAgRGlzYWJsZWQgICAgICAgIDAx
LjAwLjAwLjQ4DQo+IDg4DQo+IDB4MTAyMSAgMTI1LjcNCj4gR2lCICAgICAgIEhlYWx0aHkgICAg
ICAgICAwICAgICAgICAgICAgICAgRGlzYWJsZWQgICAgICAgIDAxLjAwLjAwLjQ4DQo+IDg4DQo+
IDB4MTEyMSAgMTI1LjcNCj4gR2lCICAgICAgIEhlYWx0aHkgICAgICAgICAwICAgICAgICAgICAg
ICAgRGlzYWJsZWQgICAgICAgIDAxLjAwLjAwLjQ4DQo+IDg4DQo+IA0KPiAjIGlwbWN0bCBjcmVh
dGUgLWYgLWdvYWwgLXNvY2tldCAweDAgUGVyc2lzdGVudE1lbW9yeVR5cGU9QXBwRGlyZWN0DQo+
IA0KPiAjIGlwbWN0bCBjcmVhdGUgLWYgLWdvYWwgLXNvY2tldCAweDEgUGVyc2lzdGVudE1lbW9y
eVR5cGU9QXBwRGlyZWN0DQo+IA0KPiAjIHJlYm9vdCwgdG8gbWFrZSBnb2FsIGNvbmZpZ3VyYXRp
b24gdGFrZSBlZmZlY3QuDQo+IA0KPiAjIG5kY3RsIGNyZWF0ZS1uYW1lc3BhY2UgLXIgcmVnaW9u
MCAtcyAxMDBtIC10IHBtZW0gLW0gZnNkYXgNCj4gDQo+ICMgbmRjdGwgY3JlYXRlLW5hbWVzcGFj
ZSAtciByZWdpb24xIC1zIDEwMG0gLXQgcG1lbSAtbSBmc2RheA0KPiANCj4gIyByZWJvb3QgYW5k
IGZpbmQgYWxsIHRoZSBuZF9tYXBwaW5nLT5udmRpbW0gaGF2ZSB0aGUgc2FtZSBmbGFncy4NCj4g
DQo+ICBkcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KPiBiL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9k
ZXZzLmMNCj4gaW5kZXggZWMzNTQzYi4uZmMzYmMxYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
dmRpbW0vcmVnaW9uX2RldnMuYw0KPiArKysgYi9kcml2ZXJzL252ZGltbS9yZWdpb25fZGV2cy5j
DQo+IEBAIC0yMzQsOCArMjM0LDEwIEBAIGludCBuZF9yZWdpb25fdG9fbnN0eXBlKHN0cnVjdCBu
ZF9yZWdpb24NCj4gKm5kX3JlZ2lvbikNCj4gIAkJCXN0cnVjdCBuZF9tYXBwaW5nICpuZF9tYXBw
aW5nID0gJm5kX3JlZ2lvbi0NCj4gPm1hcHBpbmdbaV07DQo+ICAJCQlzdHJ1Y3QgbnZkaW1tICpu
dmRpbW0gPSBuZF9tYXBwaW5nLT5udmRpbW07DQo+ICANCj4gLQkJCWlmICh0ZXN0X2JpdChORERf
QUxJQVNJTkcsICZudmRpbW0tPmZsYWdzKSkNCj4gKwkJCWlmICh0ZXN0X2JpdChORERfQUxJQVNJ
TkcsICZudmRpbW0tPmZsYWdzKSkNCj4gew0KPiAgCQkJCWFsaWFzKys7DQo+ICsJCQkJYnJlYWs7
DQoNCkkgdGhpbmsgd2UgY2FuIGdvIGEgc3RlcCBmdXJ0aGVyLCBhbmQgaW5zdGVhZCBvZiB0aGUg
J2JyZWFrJyBmb2xsb3dlZA0KYnkgYSBjaGVjayBmb3IgdGhlICdhbGlhcycgdmFyaWFibGUsIGlu
IHRoZSBsb29wLCBqdXN0IHJldHVybg0KTkRfREVWSUNFX05BTUVTUEFDRV9QTUVNIGlmIHRoZSBO
RERfQUxJQVNJTkcgYml0IGlzIGZvdW5kIGZvciBhbnkNCm1hcHBpbmcuIE91dHNpZGUgdGhlIGxv
b3AsIHNpbXBseSByZXR1cm4gTkRfREVWSUNFX05BTUVTUEFDRV9JTy4gVGhhdA0KbWFrZXMgaXQg
bXVjaCBjbGVhbmVyIGFuZCBub3cgd2UgY2FuIGdldCByaWQgb2YgJ2FsaWFzJyBlbnRpcmVseS4N
Cg0KPiArCQkJfQ0KPiAgCQl9DQo+ICAJCWlmIChhbGlhcykNCj4gIAkJCXJldHVybiBORF9ERVZJ
Q0VfTkFNRVNQQUNFX1BNRU07DQo=
