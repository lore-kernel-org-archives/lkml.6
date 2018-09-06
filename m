Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771E7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296F82083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 01:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296F82083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbeIFG2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 02:28:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:17483 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbeIFG2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 02:28:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2018 18:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,334,1531810800"; 
   d="scan'208";a="261104202"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga006.fm.intel.com with ESMTP; 05 Sep 2018 18:55:09 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 18:55:08 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 5 Sep 2018 18:55:08 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.150]) with mapi id 14.03.0319.002;
 Thu, 6 Sep 2018 09:55:06 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v2 01/12] iommu/vt-d: Enumerate the scalable mode
 capability
Thread-Topic: [PATCH v2 01/12] iommu/vt-d: Enumerate the scalable mode
 capability
Thread-Index: AQHUQAHqHRDkbxmLD0mdUrO7cGgRlqTiiRZg
Date:   Thu, 6 Sep 2018 01:55:06 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912F2A40@SHSMSX101.ccr.corp.intel.com>
References: <20180830013524.28743-1-baolu.lu@linux.intel.com>
 <20180830013524.28743-2-baolu.lu@linux.intel.com>
In-Reply-To: <20180830013524.28743-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTZkODdjOGQtZjUzNS00MjAwLWFkZGEtMzM1NTZlMGZmMWM2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVktlaXJuY25rdVwvMjF2eTZHcXZ2OU5aZ0RYKzVINFIwWjVBVWpuOVhObWJDM1lvREx5RWZzMTRodXQ5OUFEcFYifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMdSBCYW9sdSBbbWFpbHRvOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gU2Vu
dDogVGh1cnNkYXksIEF1Z3VzdCAzMCwgMjAxOCA5OjM1IEFNDQo+IA0KPiBUaGUgSW50ZWwgdnQt
ZCBzcGVjIHJldjMuMCBpbnRyb2R1Y2VzIGEgbmV3IHRyYW5zbGF0aW9uDQo+IG1vZGUgY2FsbGVk
IHNjYWxhYmxlIG1vZGUsIHdoaWNoIGVuYWJsZXMgUEFTSUQtZ3JhbnVsYXINCj4gdHJhbnNsYXRp
b25zIGZvciBmaXJzdCBsZXZlbCwgc2Vjb25kIGxldmVsLCBuZXN0ZWQgYW5kDQo+IHBhc3MtdGhy
b3VnaCBtb2Rlcy4gQXQgdGhlIHNhbWUgdGltZSwgdGhlIHByZXZpb3VzDQo+IEV4dGVuZGVkIENv
bnRleHQgKEVDUykgbW9kZSBpcyBkZXByZWNhdGVkIChubyBwcm9kdWN0aW9uDQo+IGV2ZXIgaW1w
bGVtZW50cyBFQ1MpLg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIGVudW1lcmF0aW9uIGZvciBTY2Fs
YWJsZSBNb2RlIGFuZCByZW1vdmVzDQo+IHRoZSBkZXByZWNhdGVkIEVDUyBlbnVtZXJhdGlvbi4g
SXQgcHJvdmlkZXMgYSBib290IHRpbWUNCj4gb3B0aW9uIHRvIGRpc2FibGUgc2NhbGFibGUgbW9k
ZSBldmVuIGhhcmR3YXJlIGNsYWltcyB0bw0KPiBzdXBwb3J0IGl0Lg0KPiANCj4gQ2M6IEFzaG9r
IFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4NCj4gQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBh
bkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNv
bT4NCj4gQ2M6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFNhbmpheSBLdW1hciA8c2FuamF5Lmsua3VtYXJAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5
OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQXNo
b2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29tPg0KDQpSZXZpZXdlZC1ieTogS2V2aW4gVGlhbiA8
a2V2aW4udGlhbkBpbnRlbC5jb20+DQo=
