Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718BDC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1F520850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 21:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1F520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLCVTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:19:19 -0500
Received: from mga11.intel.com ([192.55.52.93]:47940 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbeLCVTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 16:19:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 13:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="300668341"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga005.fm.intel.com with ESMTP; 03 Dec 2018 13:19:18 -0800
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 3 Dec 2018 13:19:18 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.114]) by
 fmsmsx121.amr.corp.intel.com ([169.254.6.226]) with mapi id 14.03.0415.000;
 Mon, 3 Dec 2018 13:19:18 -0800
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zloch, Jacek" <jacek.zloch@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: Fix user-initiated ARS to be "ARS-long"
 rather than "ARS-short"
Thread-Topic: [PATCH] acpi/nfit: Fix user-initiated ARS to be "ARS-long"
 rather than "ARS-short"
Thread-Index: AQHUizgEvTTJ+bh5AECDlFgPQFBDM6VuC1uA
Date:   Mon, 3 Dec 2018 21:19:17 +0000
Message-ID: <f62c2c146b846286a19bf708aa7204d5341b1fe4.camel@intel.com>
References: <154386182529.24428.16722249724563229676.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154386182529.24428.16722249724563229676.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.112.170]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A828882E70DA6D41BFD2CD7592019C98@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIDIwMTgtMTItMDMgYXQgMTA6MzAgLTA4MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gQSAic2hvcnQiIEFSUyAoYWRkcmVzcyByYW5nZSBzY3J1YikgaW5zdHJ1Y3RzIHRoZSBwbGF0
Zm9ybSBmaXJtd2FyZQ0KPiB0bw0KPiByZXR1cm4ga25vd24gZXJyb3JzLiBJbiBjb250cmFzdCwg
YSAibG9uZyIgQVJTIGluc3RydWN0cyBwbGF0Zm9ybQ0KPiBmaXJtd2FyZSB0byBhcnJhbmdlIGV2
ZXJ5IGRhdGEgYWRkcmVzcyBvbiB0aGUgRElNTSB0byBiZSByZWFkIC8NCj4gY2hlY2tlZA0KPiBm
b3IgcG9pc29uZWQgZGF0YS4NCj4gDQo+IFRoZSBjb252ZXJzaW9uIG9mIHRoZSBmbGFncyBpbiBj
b21taXQgZDNhYmFmNDNiYWI4ICJhY3BpLCBuZml0OiBGaXgNCj4gQWRkcmVzcyBSYW5nZSBTY3J1
YiBjb21wbGV0aW9uIHRyYWNraW5nIiwgY2hhbmdlZCB0aGUgbWVhbmluZyBvZg0KPiBwYXNzaW5n
DQo+ICcwJyB0byBhY3BpX25maXRfYXJzX3Jlc2NhbigpLiBQcmV2aW91c2x5ICcwJyBtZWFudCAi
bm90IHNob3J0Iiwgbm93DQo+ICcwJw0KPiBpcyBBUlNfUkVRX1NIT1JULiBQYXNzIEFSU19SRVFf
TE9ORyB0byByZXN0b3JlIHRoZSBleHBlY3RlZCBzY3J1Yi0NCj4gdHlwZQ0KPiBiZWhhdmlvciBv
ZiB1c2VyLWluaXRpYXRlZCBBUlMgc2Vzc2lvbnMuDQo+IA0KPiBGaXhlczogZDNhYmFmNDNiYWI4
ICgiYWNwaSwgbmZpdDogRml4IEFkZHJlc3MgUmFuZ2UgU2NydWIgY29tcGxldGlvbg0KPiB0cmFj
a2luZyIpDQo+IFJlcG9ydGVkLWJ5OiBKYWNlayBabG9jaCA8amFjZWsuemxvY2hAaW50ZWwuY29t
Pg0KPiBDYzogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+IFNpZ25l
ZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyB8ICAgIDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpMb29rcyBnb29kLA0KUmV2aWV3ZWQt
Ynk6IFZpc2hhbCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPg0KDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5jIGIvZHJpdmVycy9hY3BpL25maXQvY29y
ZS5jDQo+IGluZGV4IDE0ZDlmNWJlYTAxNS4uNTkxMmQzMDAyMGM3IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5j
DQo+IEBAIC0xMzA4LDcgKzEzMDgsNyBAQCBzdGF0aWMgc3NpemVfdCBzY3J1Yl9zdG9yZShzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+ICAJaWYgKG5kX2Rlc2MpIHsNCj4gIAkJc3RydWN0IGFjcGlfbmZp
dF9kZXNjICphY3BpX2Rlc2MgPQ0KPiB0b19hY3BpX2Rlc2MobmRfZGVzYyk7DQo+ICANCj4gLQkJ
cmMgPSBhY3BpX25maXRfYXJzX3Jlc2NhbihhY3BpX2Rlc2MsIDApOw0KPiArCQlyYyA9IGFjcGlf
bmZpdF9hcnNfcmVzY2FuKGFjcGlfZGVzYywgQVJTX1JFUV9MT05HKTsNCj4gIAl9DQo+ICAJZGV2
aWNlX3VubG9jayhkZXYpOw0KPiAgCWlmIChyYykNCj4gDQoNCg==
