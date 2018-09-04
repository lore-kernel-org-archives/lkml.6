Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF25C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A0620869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A0620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbeIDMWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:22:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:27269 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbeIDMWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:22:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 00:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="71418189"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga006.jf.intel.com with ESMTP; 04 Sep 2018 00:57:53 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 00:57:53 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 4 Sep 2018 00:57:53 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.226]) with mapi id 14.03.0319.002;
 Tue, 4 Sep 2018 15:57:50 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Auger Eric <eric.auger@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@linux.intel.com" <yi.l.liu@linux.intel.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "christoffer.dall@arm.com" <christoffer.dall@arm.com>
Subject: RE: [RFC 01/13] iommu: Introduce bind_guest_stage API
Thread-Topic: [RFC 01/13] iommu: Introduce bind_guest_stage API
Thread-Index: AQHUOttfqy1SkTByKESItK+VEUbEjaTM7zGAgAxtLACAAAuEgIAGZ4Rg
Date:   Tue, 4 Sep 2018 07:57:50 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912EFB76@SHSMSX101.ccr.corp.intel.com>
References: <1535026656-8450-1-git-send-email-eric.auger@redhat.com>
 <1535026656-8450-2-git-send-email-eric.auger@redhat.com>
 <22c01a4d-c74a-7279-d4ae-39e29a3bc942@redhat.com>
 <b7909f1b-57ce-f4db-d916-140a63283232@arm.com>
 <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
In-Reply-To: <4309832b-27ed-597a-b5a1-f439fbea9843@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGU5YTczNmYtYjA0Mi00MzVmLThmYTgtYWM2MjAzM2I5ODUxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoia2dscVh3dWFQU21cL09ZdlROSXdrTlViYTFSVWxsSnhwQldwXC9SNTJoZGJvRzZUWFNsVSsrTE41XC94UlJDYlVxNSJ9
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

PiBGcm9tOiBBdWdlciBFcmljDQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDMxLCAyMDE4IDk6NTIg
UE0NCj4gDQo+IEhpIEplYW4tUGhpbGlwcGUsDQo+IA0KPiBPbiAwOC8zMS8yMDE4IDAzOjExIFBN
LCBKZWFuLVBoaWxpcHBlIEJydWNrZXIgd3JvdGU6DQo+ID4gSGkgRXJpYywNCj4gPg0KPiA+IE9u
IDIzLzA4LzE4IDE2OjI1LCBBdWdlciBFcmljIHdyb3RlOg0KPiA+Pj4gK2ludCBpb21tdV9iaW5k
X2d1ZXN0X3N0YWdlKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgc3RydWN0DQo+IGRldmlj
ZSAqZGV2LA0KPiA+Pj4gKwkJCSAgIHN0cnVjdCBpb21tdV9ndWVzdF9zdGFnZV9jb25maWcgKmNm
ZykNCj4gPg0KPiA+IEFib3V0IHRoZSBuYW1lIGNoYW5nZSBmcm9tIGlvbW11X2JpbmRfcGFzaWRf
dGFibGU6IGlzIHRoZSBpbnRlbnQgdG8NCj4gPiByZXVzZSB0aGlzIEFQSSBmb3IgU01NVXYyLCB3
aGljaCBzdXBwb3J0cyBuZXN0ZWQgYnV0IG5vdCBQQVNJRD8gU2VlbXMNCj4gPiBsaWtlIGEgZ29v
ZCBpZGVhIGJ1dCAiaW9tbXVfYmluZF90YWJsZSIgbWF5IGJlIGJldHRlciBzaW5jZSAic3RhZ2Ui
IGlzDQo+ID4gb25seSB1c2VkIGJ5IEFybS4NCj4gDQo+IEF0IHRoZSBtb21lbnQgSSBkb24ndCB0
YXJnZXQgU01VdjIgYnV0IGp1c3QgU01NVXYzLiBNeSBmb2N1cyB3YXMgb24NCj4gbmVzdGVkIHN0
YWdlIGVuYWJsZW1lbnQgd2l0aG91dCBlbmFibGluZyB0aGUgbXVsdGktQ0QgZmVhdHVyZSAoUEFT
SUQpLA0KPiB3aGlzaCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBRRU1VIHZTTU1VdjMuIEFmdGVy
d2FyZHMgSSByZWFsaXplZCB0aGF0DQo+IGJhc2ljYWxseSB3ZSBhcmUgcG9pbnRpbmcgdG8gYSBD
RCBvciBQQVNJRCB0YWJsZSBhbmQgdGhhdCdzIGFib3V0IHRoZQ0KPiBzYW1lLiBJIGRvbid0IGhh
dmUgYSBzdHJvbmcgb3BpbmlvbiBvbiB0aGUgbmFtZSwgaW9tbXVfYmluZF9ndWVzdF90YWJsZQ0K
PiBvciBpb21tdV9iaW5kX3Bhc2lkX3RhYmxlIHdvdWxkIGJlIGZpbmUgd2l0aCBtZS4gSW5kZWVk
ICJzdGFnZSIgaXMgQVJNDQo+IHZvY2FibGUgKGxldmVsIGZvciBJbnRlbD8pDQoNCkludGVsIHVz
ZXMgZmlyc3QgbGV2ZWwvc2Vjb25kIGxldmVsLiANCg0KaW9tbXVfYmluZF90YWJsZSBpcyBhIGJp
dCBjb25mdXNpbmcuIHdoYXQgc2hvdWxkIHBlb3BsZSB0YWtlIHRhYmxlIGFzPw0KdGhlcmUgaXMg
UEFTSUQgdGFibGUuIHRoZXJlIGlzIGFsc28gcGFnZSB0YWJsZSBsaW5rZWQgaW4gZWFjaCBzdGFn
ZS9sZXZlbC4gYW5kDQptYXliZSBvdGhlciB0YWJsZXMgaW4gdmVuZG9yLXNwZWNpZmljIGRlZmlu
aXRpb24uDQoNCnRvIG1lIGlvbW11X2JpbmRfcGFzaWRfdGFibGUgaXMgc3RpbGwgY2xlYXJlci4g
YW55d2F5IGluIG90aGVyIHBsYWNlcw0Kd2UndmUgdXNlZCBwYXNpZCBleHBsaWNpdGx5IGluIHZm
aW8vaW9tbXUgQVBJcywgdGhlbiBpdCBzaG91bGQgYmUgZ2VuZXJhbA0KZW5vdWdoIHRvIHJlcHJl
c2VudCB2YXJpb3VzIGltcGxlbWVudGF0aW9ucy4NCg0KVGhhbmtzDQpLZXZpbg0KDQoNCg0K
