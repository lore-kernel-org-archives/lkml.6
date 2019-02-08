Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF67C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38E22146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBHAlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:41:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:44680 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfBHAlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:41:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 16:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,346,1544515200"; 
   d="scan'208";a="131930693"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Feb 2019 16:41:11 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 7 Feb 2019 16:41:11 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.29]) by
 FMSMSX157.amr.corp.intel.com ([169.254.14.168]) with mapi id 14.03.0415.000;
 Thu, 7 Feb 2019 16:41:10 -0800
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Burzynski, Grzegorz" <grzegorz.burzynski@intel.com>,
        "Verma, Vishal" <vishal.verma@intel.com>
Subject: Re: [PATCH] acpi/nfit: Fix bus command validation
Thread-Topic: [PATCH] acpi/nfit: Fix bus command validation
Thread-Index: AQHUv0KvK9Aq2jVz9kGaprz2stpXBaXVlYwA
Date:   Fri, 8 Feb 2019 00:41:09 +0000
Message-ID: <df5958d2e4f94e1a898d53761ac13dc543a8b577.camel@intel.com>
References: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154958385172.3932544.193235520333886200.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.4 (3.30.4-1.fc29) 
x-originating-ip: [10.232.112.170]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B19C8DBDAEA5F94DB27A3C30DB33F08D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMTktMDItMDcgYXQgMTU6NTcgLTA4MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gQ29tbWl0IDExMTg5YzEwODlkYSAiYWNwaS9uZml0OiBGaXggY29tbWFuZC1zdXBwb3J0ZWQg
ZGV0ZWN0aW9uIiBicm9rZQ0KPiBORF9DTURfQ0FMTCBmb3IgYnVzLWxldmVsIGNvbW1hbmRzLiBU
aGUgImZ1bmMgPSBjbWQiIGFzc3VtcHRpb24gaXMgb25seQ0KPiB2YWxpZCBmb3I6DQo+IA0KPiAg
ICAgTkRfQ01EX0FSU19DQVANCj4gICAgIE5EX0NNRF9BUlNfU1RBUlQNCj4gICAgIE5EX0NNRF9B
UlNfU1RBVFVTDQo+ICAgICBORF9DTURfQ0xFQVJfRVJST1INCj4gDQo+IFRoZSBmdW5jdGlvbiBu
dW1iZXIgb3RoZXJ3aXNlIG5lZWRzIHRvIGJlIHB1bGxlZCBmcm9tIHRoZSBjb21tYW5kDQo+IHBh
eWxvYWQgZm9yOg0KPiANCj4gICAgIE5GSVRfQ01EX1RSQU5TTEFURV9TUEENCj4gICAgIE5GSVRf
Q01EX0FSU19JTkpFQ1RfU0VUDQo+ICAgICBORklUX0NNRF9BUlNfSU5KRUNUX0NMRUFSDQo+ICAg
ICBORklUX0NNRF9BUlNfSU5KRUNUX0dFVA0KPiANCj4gVXBkYXRlIGNtZF90b19mdW5jKCkgZm9y
IHRoZSBidXMgY2FzZSBhbmQgY2FsbCBpdCBpbiB0aGUgY29tbW9uIHBhdGguDQo+IA0KPiBGaXhl
czogMTExODljMTA4OWRhICgiYWNwaS9uZml0OiBGaXggY29tbWFuZC1zdXBwb3J0ZWQgZGV0ZWN0
aW9uIikNCj4gQ2M6IDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiBDYzogVmlzaGFsIFZlcm1h
IDx2aXNoYWwudmVybWFAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTogR3J6ZWdvcnogQnVyenlu
c2tpIDxncnplZ29yei5idXJ6eW5za2lAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4g
V2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Fj
cGkvbmZpdC9jb3JlLmMgfCAgIDIyICsrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCg0KTG9va3MgZ29vZCwN
ClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg==
