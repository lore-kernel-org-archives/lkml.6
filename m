Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B6FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E082C2086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 07:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E082C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbeKGRD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 12:03:58 -0500
Received: from mga11.intel.com ([192.55.52.93]:52367 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeKGRD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:03:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 23:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,474,1534834800"; 
   d="scan'208";a="105972478"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga001.fm.intel.com with ESMTP; 06 Nov 2018 23:34:50 -0800
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 6 Nov 2018 23:34:50 -0800
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 fmsmsx156.amr.corp.intel.com (10.18.116.74) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 6 Nov 2018 23:34:49 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.84]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 15:34:47 +0800
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>
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
Subject: RE: [PATCH v4 10/12] iommu/vt-d: Add first level page table
 interface
Thread-Topic: [PATCH v4 10/12] iommu/vt-d: Add first level page table
 interface
Thread-Index: AQHUdMlOzB7aisraS0uqhCvHRMya1qVD7geg
Date:   Wed, 7 Nov 2018 07:34:47 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D5FB43@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-11-baolu.lu@linux.intel.com>
In-Reply-To: <20181105053151.7173-11-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZGU4YjU2OTMtMzhmOC00NzA0LThhOGItNjhiNjM1ZTI3MzAyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiT2JRMXhnekZhZDdBSStYaURiWE1RbERFOEhoUTZRRm4zXC9iR25lWHJHblFHNXR1VVZCSllhbEpIRkprVFFRaU4ifQ==
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvbHUsDQoNCj4gRnJvbTogTHUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNSwgMjAxOCAxOjMyIFBNDQo+IFN1Ympl
Y3Q6IFtQQVRDSCB2NCAxMC8xMl0gaW9tbXUvdnQtZDogQWRkIGZpcnN0IGxldmVsIHBhZ2UgdGFi
bGUgaW50ZXJmYWNlDQo+IA0KPiBUaGlzIGFkZHMgYW4gaW50ZXJmYWNlIHRvIHNldHVwIHRoZSBQ
QVNJRCBlbnRyaWVzIGZvciBmaXJzdA0KDQpUaGlzIHBhdGNoIGFkZHMgaW50ZXJmYWNlIHRvIHNl
dHVwIHRoZSBQQVNJRCBlbnRyaWVzIGZvciBmaXJzdC4gOikNCg0KPiBsZXZlbCBwYWdlIHRhYmxl
IHRyYW5zbGF0aW9uLg0KPiANCj4gQ2M6IEFzaG9rIFJhaiA8YXNob2sucmFqQGludGVsLmNvbT4N
Cj4gQ2M6IEphY29iIFBhbiA8amFjb2IuanVuLnBhbkBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBL
ZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gQ2M6IExpdSBZaSBMIDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNhbmpheSBLdW1hciA8c2FuamF5Lmsua3Vt
YXJAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogQXNob2sgUmFqIDxhc2hvay5yYWpAaW50ZWwuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvaW50ZWwtcGFzaWQuYyB8IDgxICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvaW9tbXUvaW50ZWwtcGFzaWQu
aCB8IDExICsrKysrDQo+ICBpbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmggfCAgMSArDQo+ICAz
IGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2lvbW11L2ludGVsLXBhc2lkLmMgYi9kcml2ZXJzL2lvbW11L2ludGVsLXBhc2lkLmMNCj4g
aW5kZXggNjk1MzAzMTdjMzIzLi5kOGNhMWU2YThlNWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
aW9tbXUvaW50ZWwtcGFzaWQuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsLXBhc2lkLmMN
Cj4gQEAgLTEwLDYgKzEwLDcgQEANCj4gICNkZWZpbmUgcHJfZm10KGZtdCkJIkRNQVI6ICIgZm10
DQo+IA0KPiAgI2luY2x1ZGUgPGxpbnV4L2JpdG9wcy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2Nw
dWZlYXR1cmUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9kbWFyLmg+DQo+ICAjaW5jbHVkZSA8bGlu
dXgvaW50ZWwtaW9tbXUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9pb21tdS5oPg0KPiBAQCAtMzg4
LDYgKzM4OSwyNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcGFzaWRfc2V0X3BhZ2Vfc25vb3Aoc3Ry
dWN0IHBhc2lkX2VudHJ5DQo+ICpwZSwgYm9vbCB2YWx1ZSkNCj4gIAlwYXNpZF9zZXRfYml0cygm
cGUtPnZhbFsxXSwgMSA8PCAyMywgdmFsdWUpOw0KPiAgfQ0KPiANCj4gKy8qDQo+ICsgKiBTZXR1
cCB0aGUgRmlyc3QgTGV2ZWwgUGFnZSB0YWJsZSBQb2ludGVyIGZpZWxkIChCaXQgMTQwfjE5MSkN
Cj4gKyAqIG9mIGEgc2NhbGFibGUgbW9kZSBQQVNJRCBlbnRyeS4NCj4gKyAqLw0KPiArc3RhdGlj
IGlubGluZSB2b2lkDQo+ICtwYXNpZF9zZXRfZmxwdHIoc3RydWN0IHBhc2lkX2VudHJ5ICpwZSwg
dTY0IHZhbHVlKQ0KPiArew0KPiArCXBhc2lkX3NldF9iaXRzKCZwZS0+dmFsWzJdLCBWVERfUEFH
RV9NQVNLLCB2YWx1ZSk7DQo+ICt9DQo+ICsNCj4gKy8qDQo+ICsgKiBTZXR1cCB0aGUgRmlyc3Qg
TGV2ZWwgUGFnaW5nIE1vZGUgZmllbGQgKEJpdCAxMzB+MTMxKSBvZiBhDQo+ICsgKiBzY2FsYWJs
ZSBtb2RlIFBBU0lEIGVudHJ5Lg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQNCj4gK3Bh
c2lkX3NldF9mbHBtKHN0cnVjdCBwYXNpZF9lbnRyeSAqcGUsIHU2NCB2YWx1ZSkNCj4gK3sNCj4g
KwlwYXNpZF9zZXRfYml0cygmcGUtPnZhbFsyXSwgR0VOTUFTS19VTEwoMywgMiksIHZhbHVlIDw8
IDIpOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZA0KPiAgcGFzaWRfY2FjaGVfaW52YWxpZGF0
aW9uX3dpdGhfcGFzaWQoc3RydWN0IGludGVsX2lvbW11ICppb21tdSwNCj4gIAkJCQkgICAgdTE2
IGRpZCwgaW50IHBhc2lkKQ0KPiBAQCAtNDU4LDYgKzQ3OSw2NiBAQCB2b2lkIGludGVsX3Bhc2lk
X3RlYXJfZG93bl9lbnRyeShzdHJ1Y3QgaW50ZWxfaW9tbXUNCj4gKmlvbW11LA0KPiAgCQlkZXZ0
bGJfaW52YWxpZGF0aW9uX3dpdGhfcGFzaWQoaW9tbXUsIGRldiwgcGFzaWQpOw0KPiAgfQ0KPiAN
Cj4gKy8qDQo+ICsgKiBTZXQgdXAgdGhlIHNjYWxhYmxlIG1vZGUgcGFzaWQgdGFibGUgZW50cnkg
Zm9yIGZpcnN0IG9ubHkNCj4gKyAqIHRyYW5zbGF0aW9uIHR5cGUuDQo+ICsgKi8NCj4gK2ludCBp
bnRlbF9wYXNpZF9zZXR1cF9maXJzdF9sZXZlbChzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11LA0K
PiArCQkJCSAgc3RydWN0IGRldmljZSAqZGV2LCBwZ2RfdCAqcGdkLA0KPiArCQkJCSAgaW50IHBh
c2lkLCBpbnQgZmxhZ3MpDQo+ICt7DQo+ICsJdTE2IGRpZCA9IEZMUFRfREVGQVVMVF9ESUQ7DQo+
ICsJc3RydWN0IHBhc2lkX2VudHJ5ICpwdGU7DQoNCmFoYSwgc2FtZSBjb21tZW50IHdpdGggcHJl
dmlvdXMgcGF0Y2guIG1heSBiZSBiZXR0ZXIgdXMgcHRfZW50cnkNCm9yIHBhc2lkX2VudHJ5Lg0K
DQpSZWdhcmRzLA0KWWkgTGl1DQo=
