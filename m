Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3E58EC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2450208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2450208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbeFNUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:04:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:37231 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754806AbeFNUE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:04:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jun 2018 13:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,224,1526367600"; 
   d="scan'208";a="49977729"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 14 Jun 2018 13:04:54 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 14 Jun 2018 13:04:54 -0700
Received: from fmsmsx105.amr.corp.intel.com ([169.254.4.232]) by
 FMSMSX125.amr.corp.intel.com ([169.254.2.165]) with mapi id 14.03.0319.002;
 Thu, 14 Jun 2018 13:04:54 -0700
From:   "Walker, Benjamin" <benjamin.walker@intel.com>
To:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "srinath.mannam@broadcom.com" <srinath.mannam@broadcom.com>
CC:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vikram.prakash@broadcom.com" <vikram.prakash@broadcom.com>,
        "okaya@codeaurora.org" <okaya@codeaurora.org>,
        "hch@lst.de" <hch@lst.de>,
        "abhishek.shah@broadcom.com" <abhishek.shah@broadcom.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: Requirement to get BAR pci_bus_address in user space
Thread-Topic: Requirement to get BAR pci_bus_address in user space
Thread-Index: AQHUA8eOtXneMM+eiUmUDy5p+o+7m6RgAEuAgAACxICAAAENgIAABBKAgABDnYCAAFfmgA==
Date:   Thu, 14 Jun 2018 20:04:53 +0000
Message-ID: <fc8795b0a4619d4c4abc55fdf010015db7272db5.camel@intel.com>
References: <CABe79T41Cr0mjH_k2drzccHvObFwRcW3n+WKCj0JvFUBy0wz-A@mail.gmail.com>
         <20180614102001.GA20836@lst.de>
         <CABe79T6k387EnDrpydTbQYQ+sZoWXKUee23EDzDJqnkroOmodA@mail.gmail.com>
         <92a9eeced36f863458ca2fd029f17a20@codeaurora.org>
         <CABe79T5ZRBToOgCY0Myo47mkeOQ5FWrxgF-Bbdx-Pa3fmYPDGw@mail.gmail.com>
         <20180614085015.3f39b367@w520.home>
In-Reply-To: <20180614085015.3f39b367@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.182.136.86]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CFFD063DCCAC340BCEBB0092DE786CA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA2LTE0IGF0IDA4OjUwIC0wNjAwLCBBbGV4IFdpbGxpYW1zb24gd3JvdGU6
DQo+IE9uIFRodSwgMTQgSnVuIDIwMTggMTY6MTg6MTUgKzA1MzANCj4gU3JpbmF0aCBNYW5uYW0g
PHNyaW5hdGgubWFubmFtQGJyb2FkY29tLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEhpIFNpbmFuIEth
eWEsDQo+ID4gDQo+ID4gSGVyZSBhcmUgdGhlIGRldGFpbHMsDQo+ID4gDQo+ID4gVGhlIGlzc3Vl
IGlzLCBGb3IgQ01CIGNhcmRzIFNRcyBhcmUgYWxsb2NhdGVkIGluc2lkZSBkZXZpY2UgQkFSIG1l
bW9yeQ0KPiA+IHdoaWNoIGlzIGRpZmZlcmVudCBmcm9tIG5vcm1hbCBjYXJkcy4NCj4gPiBJbiBO
b3JtYWwgY2FyZHMgU1EgbWVtb3J5IGFsbG9jYXRlZCBhdCBob3N0IHNpZGUuDQo+ID4gSW4gYm90
aCB0aGUgY2FzZXMgcGh5c2ljYWwgYWRkcmVzcyBvZiBDUSBtZW1vcnkgaXMgcHJvZ3JhbW1lZCBp
biBOVk1lDQo+ID4gY29udHJvbGxlciByZWdpc3Rlci4NCj4gPiBUaGlzIG1ldGhvZCB3b3JrcyBm
b3Igbm9ybWFsIGNhcmRzIGJlY2F1c2UgQ1EgbWVtb3J5IGlzIGF0IGhvc3Qgc2lkZS4NCj4gPiBC
dXQgaW4gQ01CIGNhcmRzIHBjaSBidXMgYWRkcmVzcyBlcXVpdmFsZW50IHRvIENRIG1lbW9yeSBu
ZWVkcyB0byBwcm9ncmFtLg0KPiA+IA0KPiA+IE1vcmUgZGV0YWlscyBhcmUgaW4gdGhlIHBhdGNo
OiBudm1lLXBjaTogVXNlIFBDSSBidXMgYWRkcmVzcyBmb3INCj4gPiBkYXRhL3F1ZXVlcyBpbiBD
TUIuDQo+ID4gDQo+ID4gV2l0aCB0aGUgYWJvdmUgcGF0Y2ggaXNzdWUgaXMgZml4ZWQgaW4gdGhl
IE5WTWUga2VybmVsIGRyaXZlciwgQnV0DQo+ID4gc2ltaWxhciBmaXggaXMgcmVxdWlyZWQgaW4g
U1BESyBsaWJyYXJ5IGFsc28uDQo+ID4gU28sIFdlIG5lZWQgYSBtZWNoYW5pc20gdG8gZ2V0IHBj
aV9idXNfYWRkcmVzcyBpbiB1c2VyIHNwYWNlIGxpYnJhcmllcw0KPiA+IHRvIGFkZHJlc3MgdGhp
cyBpc3N1ZS4NCj4gDQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgQ1EgdnMgQ01CLCBidXQgSSB0
aGluayBJIGdhdGhlciB0aGF0IHRoZXJlJ3Mgc29tZQ0KPiBzb3J0IG9mIGJ1ZmZlciB0aGF0J3Mg
YWxsb2NhdGVkIGZyb20gd2l0aGluIHRoZSBkZXZpY2VzIE1NSU8gQkFSIGFuZA0KPiBzb21lIHBy
b2dyYW1taW5nIG9mIHRoZSBkZXZpY2UgbmVlZHMgdG8gcmVmZXJlbmNlIHRoYXQgYnVmZmVyLg0K
PiBXb3VsZG4ndCB5b3UgdGhlcmVmb3JlIHVzZSB0aGUgdmZpbyB0eXBlMSBJT01NVSBNQVBfRE1B
IGlvY3RsIHRvIG1hcA0KPiB0aGUgQkFSIGludG8gdGhlIElPVkEgYWRkcmVzcyBzcGFjZSBhbmQg
eW91IGNhbiB0aGVuIHVzZSB0aGUgSU9WQSArDQo+IG9mZnNldCBpbnRvIHRoZSBCQVIgZm9yIHRo
ZSBkZXZpY2UgdG8gcmVmZXJlbmNlIHRoZSBidWZmZXI/ICBJdCBzZWVtcw0KPiB0aGlzIGlzIHRo
ZSBzYW1lIHdheSB3ZSdkIHNldHVwIGEgcGVlci10by1wZWVyIG1hcHBpbmcsIGJ1dCB3ZSdyZSB1
c2luZw0KPiBpdCBmb3IgdGhlIGRldmljZSB0byByZWZlcmVuY2UgaXRzZWxmIGVmZmVjdGl2ZWx5
LiAgVGhhbmtzLA0KDQpTUERLIGFscmVhZHkgZG9lcyB0aGlzIHRvZGF5LiBJdCdzIGNhcGFibGUg
b2YgcGxhY2luZyBzdWJtaXNzaW9uIGFuZCBjb21wbGV0aW9uDQpxdWV1ZXMgaW4gdGhlIGRldmlj
ZSdzIGNvbnRyb2xsZXIgbWVtb3J5IGJ1ZmZlciAoQ01CKSBhbmQgd2lsbCBkbyBhbGwgb2YgdGhl
DQpyaWdodCB0aGluZ3MgZm9yIGJvdGggdWlvIChsb29rIHVwIHBoeXNpY2FsIGFkZHJlc3MpIGFu
ZCB2ZmlvIChzZW5kDQpJT01NVV9NQVBfRE1BIGlvY3RsIHRvIHNldCBhIGlvdmEgYW5kIHVzZSB0
aGF0KS4gSXQgYWRkaXRpb25hbGx5IGFscmVhZHkNCnN1cHBvcnRzIHVzaW5nIHRoZSBDTUIgYXMg
YSB0YXJnZXQgZm9yIHBlZXItdG8tcGVlciBkYXRhIHRyYW5zZmVycy4NCg0KVGhpcyB3YXMganVz
dCBjb25maXJtZWQgdG8gd29yayBvbiB0aGUgbW9zdCByZWNlbnQgU1BESyByZWxlYXNlLiBJZiB5
b3UgYXJlIG5vdA0Kb24gdGhlIG1vc3QgcmVjZW50IHJlbGVhc2UsIEkgcmVjb21tZW5kIHRyeWlu
ZyB0aGF0IGZpcnN0LiBJZiB0aGVyZSBpcyBzdGlsbA0Kc29tZSBpc3N1ZSwgcGxlYXNlIGRvIHRh
a2UgaXQgdG8gdGhlIFNQREsgbWFpbGluZyBsaXN0Lg0KDQpUaGFua3MsDQpCZW4NCg==
