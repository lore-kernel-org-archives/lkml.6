Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297E6C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD624208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD624208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbeHAVwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:52:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:9502 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeHAVwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:52:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 13:05:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,433,1526367600"; 
   d="scan'208";a="77923461"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2018 13:05:10 -0700
Received: from irsmsx112.ger.corp.intel.com (10.108.20.5) by
 IRSMSX152.ger.corp.intel.com (163.33.192.66) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 1 Aug 2018 21:05:09 +0100
Received: from irsmsx103.ger.corp.intel.com ([169.254.3.208]) by
 irsmsx112.ger.corp.intel.com ([169.254.1.22]) with mapi id 14.03.0319.002;
 Wed, 1 Aug 2018 21:05:09 +0100
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Interrupt flags mismatch check in __setup_irq()
Thread-Topic: Interrupt flags mismatch check in __setup_irq()
Thread-Index: AQHUKdLyK6QiTPuOkEym/kA7pEdaZw==
Date:   Wed, 1 Aug 2018 20:05:08 +0000
Message-ID: <9d935c253796909c5d005dd9416f33cb5bbd8537.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.72.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <07C6A7A7E6F22E499FC4E5C21FC9AAB6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkhDQoNClJlY2VudGx5IEkgaGF2ZSBleHBlcmllbmNlZCBzb21lIG5hc3R5IGlzc3VlDQoNCmdl
bmlycTogRmxhZ3MgbWlzbWF0Y2ggaXJxIDE4LiAwMDAwMjAwMCAoaW50ZWxfbXJmbGRfcHdyYnRu
KSB2cy4NCjAwMDAyMDAwIChiY292ZV9pcnFfY2hpcF9wd3JidG4pDQoNCmJ1dCBpdCBpcyBub3Qg
YSBtZXJpdCBvZiBteSBtZXNzYWdlIGhlcmUuDQoNCldoaWxlIHRyeWluZyB0byB1bmRlcnN0YW5k
IHRoZSBsb2dpYyBiZWhpbmQgcmVhbCBjb2RlIGFuZCB3aGF0IGlzIHdpc2hlZA0KKGJhc2VkIG9u
IGEgY29tbWVudCkgSSBoYXZlIGdvdCBkaWZmZXJlbmNlcy4NCg0KVGh1cywgSSB3cm90ZSBzbWFs
bCBweXRob24gc2NyaXB0IFsxXSB0byB1bmRlcnN0YW5kIGJldHRlci4NCkkgYXNzdW1lIGl0IGhh
cyBmZXcgZmFsc2UtcG9zaXRpdmVzLCBidXQgSSBhbHNvIGJlbGlldmUgdGhhdCBsb2dpYyBhbmQN
CmNvbW1lbnQgYXJlIG5vdCBpbiBhbGlnbm1lbnQgYW5kIHdlIG1pZ2h0IG5lZWQgdG8gZml4IGxv
Z2ljLCBjb21tZW50LCBvcg0KYm90aC4NCg0KQ2FuIHlvdSBjaGVjayB0aGF0IHNjcmlwdCBhbmQg
dGVsbCBtZSBpZiB0aGVyZSBpcyAoaW4gX19zZXR1cF9pcnEoKQ0KY2hlY2spIGFuIGlzc3VlIG9y
IG5vdD8NCg0KWzFdOiBodHRwczovL2dpc3QuZ2l0aHViLmNvbS9hbmR5LXNoZXYvYjg1YzUxMjlm
Y2ZlNjNjYjg4ODQ5ODA1ZTVhN2UzYTQNCg0KUC5TLiBTbWFsbCBleHBsYW5hdGlvbiwgdGhlIGZ1
bmN0aW9ucyBhcmUgbWFwcGVkIHRvIHRoZSBmb2xsb3dpbmcgbG9naWM6DQoNCmNvZGViYXNlKCkg
LSByZXBlYXRzIHdoYXQgd2UgaGF2ZSBpbiBrZXJuZWwNCmNvbW1lbnQoKSAtIG15IHVuZGVyc3Rh
bmRpbmcgaG93IGl0J3Mgc3VwcG9zZWQgdG8gd29yaw0KYWxnbygpIC0gYWJzdHJhY3Rpb24gb2Yg
YWxnb3JpdGhtLCBzbywgY2FuIGJlIGV4dGVuZGVkIHRocnUgdGhlIFJVTEVTDQpzZXQNCg0KSXQg
cHJpbnRzIG91dCBpbiBjYXNlIHdoZW4gY29kZWJhc2UoKSAhPSBjb21tZW50KCkgZm9yIHRoZSBz
YW1lIHBhaXIgb2YNCmZsYWdzLg0KDQotLSANCkFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZj
aGVua29AaW50ZWwuY29tPg0KSW50ZWwgRmlubGFuZCBPeSAtIEJJQyAwMzU3NjA2LTQgLSBXZXN0
ZW5kaW5rYXR1IDcsIDAyMTYwIEVzcG9v
