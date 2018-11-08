Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD3FC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A80D2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 04:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A80D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeKHNeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 08:34:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:16014 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbeKHNeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 08:34:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 20:00:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="98536525"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga003.jf.intel.com with ESMTP; 07 Nov 2018 20:00:31 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 20:00:23 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 20:00:23 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.84]) with mapi id 14.03.0415.000;
 Thu, 8 Nov 2018 12:00:20 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v4 06/12] iommu/vt-d: Add second level page table
 interface
Thread-Topic: [PATCH v4 06/12] iommu/vt-d: Add second level page table
 interface
Thread-Index: AQHUdMlG2B4LjCEoyEG7Np1y1OKvIqVD5GeAgADBPQCAAJ+AkA==
Date:   Thu, 8 Nov 2018 04:00:20 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D60506@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-7-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FB11@SHSMSX104.ccr.corp.intel.com>
 <e987773c-a547-01e4-a04f-1f34506420ac@linux.intel.com>
In-Reply-To: <e987773c-a547-01e4-a04f-1f34506420ac@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmMyN2VmMmQtYzU1YS00MjlhLTkyMjAtYjAwZmQxNDU2MjkzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaXZIY251NXZ3N3hPSDV4K3IyaFo1REhkeXZHZnZ4TjRhZVNFMWFNakViVTRYeG5Ub21XcmJXQ1hxcUoxQmJROSJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gRnJvbTogTHUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21d
DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA4LCAyMDE4IDEwOjI4IEFNDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgMDYvMTJdIGlvbW11L3Z0LWQ6IEFkZCBzZWNvbmQgbGV2ZWwgcGFnZSB0
YWJsZSBpbnRlcmZhY2UNCj4gDQo+IEhpLA0KPiANCj4gT24gMTEvNy8xOCAzOjEzIFBNLCBMaXUs
IFlpIEwgd3JvdGU6DQo+ID4gSGkgQmFvbHUsDQo+ID4NCj4gPj4gRnJvbTogTHUgQmFvbHUgW21h
aWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+IFNlbnQ6IE1vbmRheSwgTm92ZW1i
ZXIgNSwgMjAxOCAxOjMyIFBNDQo+ID4+DQo+ID4+IFRoaXMgYWRkcyB0aGUgaW50ZXJmYWNlcyB0
byBzZXR1cCBvciB0ZWFyIGRvd24gdGhlIHN0cnVjdHVyZXMgZm9yDQo+ID4+IHNlY29uZCBsZXZl
bCBwYWdlIHRhYmxlIHRyYW5zbGF0aW9ucy4gVGhpcyBpbmNsdWRlcyB0eXBlcyBvZiBzZWNvbmQN
Cj4gPj4gbGV2ZWwgb25seSB0cmFuc2xhdGlvbiBhbmQgcGFzcyB0aHJvdWdoLg0KPiA+DQo+ID4g
QSBsaXR0bGUgYml0IHJlZmluaW5nIHRvIHRoZSBkZXNjcmlwdGlvbjopICJUaGlzIHBhdGNoIGFk
ZHMgaW50ZXJmYWNlcw0KPiA+IGZvciBzZXR1cCBvciB0ZWFyIGRvd24gc2Vjb25kIGxldmVsIHRy
YW5zbGF0aW9uIGluIFBBU0lEIGdyYW51bGFyaXR5Lg0KPiA+IFRyYW5zbGF0aW9uIHR5cGUgaW5j
bHVkZXMgc2Vjb25kIGxldmVsIG9ubHkgdHlwZSBhbmQgcGFzcy10aHJvdWdoDQo+ID4gdHlwZS4i
DQo+ID4NCj4gPj4gQ2M6IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4NCj4gPj4gQ2M6
IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+ID4+IENjOiBLZXZp
biBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gPj4gQ2M6IExpdSBZaSBMIDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNhbmpheSBLdW1hciA8c2FuamF5Lmsu
a3VtYXJAaW50ZWwuY29tPg0KPiA+DQo+ID4gWy4uLl0NCj4gPg0KPiA+PiArDQo+ID4+ICt2b2lk
IGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11LA0K
PiA+PiArCQkJCSBzdHJ1Y3QgZGV2aWNlICpkZXYsIGludCBwYXNpZCkNCj4gPj4gK3sNCj4gPj4g
KwlzdHJ1Y3QgcGFzaWRfZW50cnkgKnB0ZTsNCj4gPg0KPiA+IHB0ZSBpcyBjb25mdXNpbmcgYXMg
aXQgaXMgc2ltaWxhciB3aXRoIHB0ZSBpbiBwYWdpbmcgc3RydWN0dXJlcy4gbWF5DQo+ID4gdXNl
IHB0X2VudHJ5IG9yIGp1c3QgcGFzaWRfZW50cnkuIFRoaXMgY29tbWVudCBhcHBsaWVzIHRvIG90
aGVyICJwdGUicw0KPiA+IGluIHRoaXMgcGF0Y2guDQo+IA0KPiAicHRlIiBpbiB0aGlzIGZpbGUg
bWVhbnMgInBhc2lkIHRhYmxlIGVudHJ5Iiwgbm90ICJwYWdlIHRhYmxlIGVudHJ5Ii4NCj4gVGhp
cyBmaWxlIGhvbGRzIGNvZGUgdG8gaGFuZGxlIHBhc2lkIHRhYmxlIHJlbGF0ZWQgc3RhZmYuIEl0
IGhhcyBub3RoaW5nIHRvIGRvIHdpdGgNCj4gcGFnaW5nIHN0cnVjdHVyZS4gSSB0aGluayB0aGVy
ZSBzaG91bGQgYmUgbm8gY29uZnVzaW9uIGhlcmUuDQo+IDotKQ0KDQpJIHNlZS4gVGhlbiB1cCB0
byB5b3UuIDopIEl0J3MganVzdCBteSBmZWVsaW5nIHdoZW4gcmVhZGluZyB0aGUgcGF0Y2gsIGl0
IGxlYWRzIG1lIHRvDQpiZWxpZXZlIGl0IGlzIHBhZ2luZyBzdHJ1Y3R1cmUuDQoNClJlZ2FyZHMs
DQpZaSBMaXUNCg==
