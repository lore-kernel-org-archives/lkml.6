Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57318C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31FE21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 01:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31FE21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391062AbeGLBsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 21:48:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:41112 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388023AbeGLBsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 21:48:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 18:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,339,1526367600"; 
   d="scan'208";a="74103251"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2018 18:40:45 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 11 Jul 2018 18:40:45 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 11 Jul 2018 18:40:44 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.124]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.81]) with mapi id 14.03.0319.002;
 Thu, 12 Jul 2018 09:40:42 +0800
From:   "Lu, Aaron" <aaron.lu@intel.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "Wang, Kemi" <kemi.wang@intel.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC PATCH] mm, page_alloc: double zone's batchsize
Thread-Topic: [RFC PATCH] mm, page_alloc: double zone's batchsize
Thread-Index: AQHUGNxfvDCb+EtPWUewSbswJfn4kaSKBjuAgABEnoA=
Date:   Thu, 12 Jul 2018 01:40:41 +0000
Message-ID: <9f778198327e62cdab0651382740189e0665507a.camel@intel.com>
References: <20180711055855.29072-1-aaron.lu@intel.com>
         <20180711143505.5ccb378fb67dc6ba8fa202a3@linux-foundation.org>
In-Reply-To: <20180711143505.5ccb378fb67dc6ba8fa202a3@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.159.135]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B39D905F2145D74183675215CB519B0C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE4LTA3LTExIGF0IDE0OjM1IC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBXZWQsIDExIEp1bCAyMDE4IDEzOjU4OjU1ICswODAwIEFhcm9uIEx1IDxhYXJvbi5sdUBp
bnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBbNTUwIGxpbmVzIG9mIGNoYW5nZWxvZ10NCj4gDQo+
IE9LLCBJJ20gY29udmluY2VkIDspICBUaGF0IHdhcyBhIGxvdCBvZiB3b3JrIC0gdGhhbmtzIGZv
ciBiZWluZyBleGhhdXN0aXZlLg0KDQpUaGFua3MgQW5kcmV3Lg0KSSB0aGluayB0aGUgY3JlZGl0
IGdvZXMgdG8gRGF2ZSBIYW5zZW4gc2luY2UgaGUgaGFzIGJlZW4gdmVyeSBjYXJlZnVsDQphYm91
dCB0aGlzIGNoYW5nZSBhbmQgd291bGQgbGlrZSBtZSB0byBkbyBhbGwgdGhvc2UgMm5kIHBoYXNl
IHRlc3RzIHRvDQptYWtlIHN1cmUgd2UgZGlkbid0IGdldCBhbnkgc3VycHJpc2UgYWZ0ZXIgZG91
YmxpbmcgYmF0Y2ggc2l6ZSA6LSkNCg0KSSB0aGluayB0aGUgTEtQIHJvYm90IHdpbGwgcnVuIGV2
ZW4gbW9yZSB0ZXN0cyB0byBjYXB0dXJlIHBvc3NpYmxlDQpyZWdyZXNzaW9ucywgaWYgYW55Lg==
