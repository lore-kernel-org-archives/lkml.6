Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9527BC64EBC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F40206B2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 00:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F40206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeJEHP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 03:15:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:48883 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727588AbeJEHP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 03:15:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 17:19:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,342,1534834800"; 
   d="scan'208";a="75522455"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga007.fm.intel.com with ESMTP; 04 Oct 2018 17:19:57 -0700
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 4 Oct 2018 17:19:57 -0700
Received: from orsmsx155.amr.corp.intel.com ([169.254.7.228]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.23]) with mapi id 14.03.0319.002;
 Thu, 4 Oct 2018 17:19:56 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zloch, Jacek" <jacek.zloch@intel.com>,
        "Rusocki, Krzysztof" <krzysztof.rusocki@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm, pmem: Fix badblocks population for 'raw'
 namespaces
Thread-Topic: [PATCH] libnvdimm, pmem: Fix badblocks population for 'raw'
 namespaces
Thread-Index: AQHUXD+rd+AzWpNqc0CnBeeqj7v9pqUQPx+A
Date:   Fri, 5 Oct 2018 00:19:55 +0000
Message-ID: <cdba20f7ba8186862f8b3596b0766be240297162.camel@intel.com>
References: <153869739732.2904401.10895695693942634646.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <153869739732.2904401.10895695693942634646.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.18.116.7]
Content-Type: text/plain; charset="utf-8"
Content-ID: <447E5AF6DDADFC4BBD954C7C29688426@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMTgtMTAtMDQgYXQgMTY6NTYgLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gVGhlIGRyaXZlciBpcyBvbmx5IGluaXRpYWxpemluZyBiYl9yZXMgaW4gdGhlIGRldm1fbWVt
cmVtYXBfcGFnZXMoKQ0KPiBwYXRocywgYnV0IHRoZSByYXcgbmFtZXNwYWNlIGNhc2UgaXMgcGFz
c2luZyBhbiB1bmluaXRpYWxpemVkIGJiX3Jlcw0KPiB0bw0KPiBudmRpbW1fYmFkYmxvY2tzX3Bv
cHVsYXRlKCkuDQo+IA0KPiBGaXhlczogZThkNTEzNDgzMzAwICgibWVtcmVtYXA6IGNoYW5nZSBk
ZXZtX21lbXJlbWFwX3BhZ2VzDQo+IGludGVyZmFjZS4uLiIpDQo+IENjOiA8c3RhYmxlQHZnZXIu
a2VybmVsLm9yZz4NCj4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiBSZXBv
cnRlZC1ieTogSmFjZWsgWmxvY2ggPGphY2VrLnpsb2NoQGludGVsLmNvbT4NCj4gUmVwb3J0ZWQt
Ynk6IEtyenlzenRvZiBSdXNvY2tpIDxrcnp5c3p0b2YucnVzb2NraUBpbnRlbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvbnZkaW1tL3BtZW0uYyB8ICAgIDQgKysrLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZkaW1tL3BtZW0uYyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiBpbmRleCA2MDcx
ZTI5NDIwNTMuLjIwODJhZTAxYjljOCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcG1l
bS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiBAQCAtNDIxLDkgKzQyMSwxMSBA
QCBzdGF0aWMgaW50IHBtZW1fYXR0YWNoX2Rpc2soc3RydWN0IGRldmljZSAqZGV2LA0KPiAgCQlh
ZGRyID0gZGV2bV9tZW1yZW1hcF9wYWdlcyhkZXYsICZwbWVtLT5wZ21hcCk7DQo+ICAJCXBtZW0t
PnBmbl9mbGFncyB8PSBQRk5fTUFQOw0KPiAgCQltZW1jcHkoJmJiX3JlcywgJnBtZW0tPnBnbWFw
LnJlcywgc2l6ZW9mKGJiX3JlcykpOw0KPiAtCX0gZWxzZQ0KPiArCX0gZWxzZSB7DQo+ICAJCWFk
ZHIgPSBkZXZtX21lbXJlbWFwKGRldiwgcG1lbS0+cGh5c19hZGRyLA0KPiAgCQkJCXBtZW0tPnNp
emUsIEFSQ0hfTUVNUkVNQVBfUE1FTSk7DQo+ICsJCW1lbWNweSgmYmJfcmVzLCAmbnNpby0+cmVz
LCBzaXplb2YoYmJfcmVzKSk7DQo+ICsJfQ0KDQoNCkdvb2QgZmluZCENClJldmlld2VkLWJ5OiBW
aXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg==
