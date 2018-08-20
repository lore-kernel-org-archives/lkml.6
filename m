Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4E02173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4E02173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeHTVKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:10:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:30184 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTVKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:10:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 10:54:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="76880490"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga003.jf.intel.com with ESMTP; 20 Aug 2018 10:54:01 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 20 Aug 2018 10:54:01 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.40]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.15]) with mapi id 14.03.0319.002;
 Mon, 20 Aug 2018 10:54:01 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.z.zhang@linux.intel.com" <yi.z.zhang@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>, "jack@suse.cz" <jack@suse.cz>
CC:     "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
Thread-Topic: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
Thread-Index: AQHUMrVUqnGbwTSujk2GEE0hKSwAsKTJbXcA
Date:   Mon, 20 Aug 2018 17:53:59 +0000
Message-ID: <1534787638.13739.52.camel@intel.com>
References: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
In-Reply-To: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <121A1013E5C94F42A6AA0DB9CD0A043C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIDIwMTgtMDgtMTMgYXQgMjA6MDIgKzA4MDAsIFpoYW5nIFlpIHdyb3RlOg0KPiBU
aGlzIHBhdGNoIHByZXZlbnRzIGEgdXNlciBtYXBwaW5nIGFuIGlsbGVnYWwgdm1hIHJhbmdlIHRo
YXQgaXMgbGFyZ2VyDQo+IHRoYW4gYSBkYXggZGV2aWNlIHBoeXNpY2FsIHJlc291cmNlLg0KPiAN
Cj4gV2hlbiBxZW11IG1hcHMgdGhlIGRheCBkZXZpY2UgZm9yIHZpcnR1YWwgbnZkaW1tJ3MgYmFj
a2VuZCBkZXZpY2UsIHRoZQ0KPiB2LW52ZGltbSBsYWJlbCBhcmVhIGlzIGRlZmluZWQgYXQgdGhl
IGVuZCBvZiBtYXBwZWQgcmFuZ2UuIEJ5IHVzaW5nIGFuDQo+IGlsbGVnYWwgc2l6ZSB0aGF0IGV4
Y2VlZHMgdGhlIHJhbmdlIG9mIHRoZSBkZXZpY2UgZGF4LCBpdCB3aWxsIHRyaWdnZXIgYQ0KPiBm
YXVsdCB3aXRoIHFlbXUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBZaSA8eWkuei56aGFu
Z0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9kYXgvZGV2aWNlLmMgfCAyOSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2Vy
dGlvbnMoKykNCj4gDQoNCkxvb2tzIGdvb2QgdG8gbWU6DQpSZXZpZXdlZC1ieTogVmlzaGFsIFZl
cm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZGF4L2RldmljZS5jIGIvZHJpdmVycy9kYXgvZGV2aWNlLmMNCj4gaW5kZXggMTA4YzM3Zi4uNmZl
OGMzMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9kYXgvZGV2aWNlLmMNCj4gKysrIGIvZHJpdmVy
cy9kYXgvZGV2aWNlLmMNCj4gQEAgLTE3Nyw2ICsxNzcsMzMgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhdHRyaWJ1dGVfZ3JvdXAgKmRheF9hdHRyaWJ1dGVfZ3JvdXBzW10gPSB7DQo+ICAJTlVMTCwN
Cj4gIH07DQo+ICANCj4gK3N0YXRpYyBpbnQgY2hlY2tfdm1hX3JhbmdlKHN0cnVjdCBkZXZfZGF4
ICpkZXZfZGF4LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwNCj4gKwkJY29uc3QgY2hhciAq
ZnVuYykNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmZGV2X2RheC0+ZGV2Ow0KPiAr
CXN0cnVjdCByZXNvdXJjZSAqcmVzOw0KPiArCXVuc2lnbmVkIGxvbmcgc2l6ZTsNCj4gKwlpbnQg
cmV0LCBpOw0KPiArDQo+ICsJaWYgKCFkYXhfYWxpdmUoZGV2X2RheC0+ZGF4X2RldikpDQo+ICsJ
CXJldHVybiAtRU5YSU87DQo+ICsNCj4gKwlzaXplID0gdm1hLT52bV9lbmQgLSB2bWEtPnZtX3N0
YXJ0ICsgKHZtYS0+dm1fcGdvZmYgPDwgUEFHRV9TSElGVCk7DQo+ICsJcmV0ID0gLUVJTlZBTDsN
Cj4gKwlmb3IgKGkgPSAwOyBpIDwgZGV2X2RheC0+bnVtX3Jlc291cmNlczsgaSsrKSB7DQo+ICsJ
CXJlcyA9ICZkZXZfZGF4LT5yZXNbaV07DQo+ICsJCWlmIChzaXplID4gcmVzb3VyY2Vfc2l6ZShy
ZXMpKSB7DQo+ICsJCQlkZXZfaW5mb19yYXRlbGltaXRlZChkZXYsDQo+ICsJCQkJIiVzOiAlczog
ZmFpbCwgdm1hIHJhbmdlIG92ZXJmbG93XG4iLA0KPiArCQkJCWN1cnJlbnQtPmNvbW0sIGZ1bmMp
Ow0KPiArCQkJcmV0ID0gLUVJTlZBTDsNCj4gKwkJCWNvbnRpbnVlOw0KPiArCQl9IGVsc2UNCj4g
KwkJCXJldHVybiAwOw0KPiArCX0NCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICBzdGF0
aWMgaW50IGNoZWNrX3ZtYShzdHJ1Y3QgZGV2X2RheCAqZGV2X2RheCwgc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEsDQo+ICAJCWNvbnN0IGNoYXIgKmZ1bmMpDQo+ICB7DQo+IEBAIC00NjksNiAr
NDk2LDggQEAgc3RhdGljIGludCBkYXhfbW1hcChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IHZt
X2FyZWFfc3RydWN0ICp2bWEpDQo+ICAJICovDQo+ICAJaWQgPSBkYXhfcmVhZF9sb2NrKCk7DQo+
ICAJcmMgPSBjaGVja192bWEoZGV2X2RheCwgdm1hLCBfX2Z1bmNfXyk7DQo+ICsJaWYgKCFyYykN
Cj4gKwkJcmMgPSBjaGVja192bWFfcmFuZ2UoZGV2X2RheCwgdm1hLCBfX2Z1bmNfXyk7DQo+ICAJ
ZGF4X3JlYWRfdW5sb2NrKGlkKTsNCj4gIAlpZiAocmMpDQo+ICAJCXJldHVybiByYzsNCg==
