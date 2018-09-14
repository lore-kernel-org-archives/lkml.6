Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231BCC04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F1820882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 02:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F1820882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeINIIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:08:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:12910 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbeINIIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:08:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2018 19:56:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,371,1531810800"; 
   d="scan'208";a="80323190"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Sep 2018 19:53:41 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 13 Sep 2018 19:53:40 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.205]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.16]) with mapi id 14.03.0319.002;
 Fri, 14 Sep 2018 10:53:38 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Bie, Tiwei" <tiwei.bie@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: RE: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Thread-Topic: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Thread-Index: AQHUQBd63AINefsFr0WaDhgLiguCyqTpPryAgAI/kgCAAP6ogIACJwgAgACHctA=
Date:   Fri, 14 Sep 2018 02:53:37 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19130381B@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
 <380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
 <aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
 <3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
 <4b24f0c6-5985-efbc-f842-8bde239dfc2a@linux.intel.com>
In-Reply-To: <4b24f0c6-5985-efbc-f842-8bde239dfc2a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmQ5OTU5ZTEtMjZlYS00ZjViLThhOTctZGY5Y2JhYThkYmFlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUGcyUExndklXQjBOcGJ3RjNKQ3Z0cUVyc1I4XC9yTmhpNVlkbEJhYU1PUXNoS3kxSW9XVGF6cmFNRjZUVGM4TDIifQ==
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
dDogRnJpZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMTggMTA6NDcgQU0NCj4gDQo+IEhpLA0KPiANCj4g
T24gMDkvMTMvMjAxOCAwMTo1NCBBTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOg0KPiA+
IE9uIDEyLzA5LzIwMTggMDM6NDIsIEx1IEJhb2x1IHdyb3RlOg0KPiA+PiBIaSwNCj4gPj4NCj4g
Pj4gT24gMDkvMTEvMjAxOCAxMjoyMiBBTSwgSmVhbi1QaGlsaXBwZSBCcnVja2VyIHdyb3RlOg0K
PiA+Pj4gSGksDQo+ID4+Pg0KPiA+Pj4gT24gMzAvMDgvMjAxOCAwNTowOSwgTHUgQmFvbHUgd3Jv
dGU6DQo+ID4+Pj4gQmVsb3cgQVBJcyBhcmUgaW50cm9kdWNlZCBpbiB0aGUgSU9NTVUgZ2x1ZSBm
b3IgZGV2aWNlIGRyaXZlcnMgdG8NCj4gdXNlDQo+ID4+Pj4gdGhlIGZpbmVyIGdyYW51bGFyaXR5
IHRyYW5zbGF0aW9uLg0KPiA+Pj4+DQo+ID4+Pj4gKiBpb21tdV9jYXBhYmxlKElPTU1VX0NBUF9B
VVhfRE9NQUlOKQ0KPiA+Pj4+ICAgICAtIFJlcHJlc2VudHMgdGhlIGFiaWxpdHkgZm9yIHN1cHBv
cnRpbmcgbXVsdGlwbGUgZG9tYWlucyBwZXIgZGV2aWNlDQo+ID4+Pj4gICAgICAgKGEuay5hLiBm
aW5lciBncmFudWxhcml0eSB0cmFuc2xhdGlvbnMpIG9mIHRoZSBJT01NVSBoYXJkd2FyZS4NCj4g
Pj4+IGlvbW11X2NhcGFibGUoKSBjYW5ub3QgcmVwcmVzZW50IGhhcmR3YXJlIGNhcGFiaWxpdGll
cywgd2UgbmVlZA0KPiA+Pj4gc29tZXRoaW5nIGVsc2UgZm9yIHN5c3RlbXMgd2l0aCBtdWx0aXBs
ZSBJT01NVXMgdGhhdCBoYXZlIGRpZmZlcmVudA0KPiA+Pj4gY2Fwcy4gSG93IGFib3V0IGlvbW11
X2RvbWFpbl9nZXRfYXR0ciBvbiB0aGUgZGV2aWNlJ3MgZG9tYWluDQo+IGluc3RlYWQ/DQo+ID4+
IERvbWFpbiBpcyBub3QgYSBnb29kIGNob2ljZSBmb3IgcGVyIGlvbW11IGNhcCBxdWVyeS4gQSBk
b21haW4gbWlnaHQNCj4gYmUNCj4gPj4gYXR0YWNoZWQgdG8gZGV2aWNlcyBiZWxvbmdpbmcgdG8g
ZGlmZmVyZW50IGlvbW11J3MuDQo+ID4+DQo+ID4+IEhvdyBhYm91dCBhbiBBUEkgd2l0aCBkZXZp
Y2Ugc3RydWN0dXJlIGFzIHBhcmFtZXRlcj8gQSBkZXZpY2UgYWx3YXlzDQo+ID4+IGJlbG9uZ3Mg
dG8gYSBzcGVjaWZpYyBpb21tdS4gVGhpcyBBUEkgaXMgc3VwcG9zZWQgdG8gYmUgdXNlZCB0aGUN
Cj4gPj4gZGV2aWNlIGRyaXZlci4NCj4gPiBBaCByaWdodCwgZG9tYWluIGF0dHJpYnV0ZXMgd29u
J3Qgd29yay4gWW91ciBzdWdnZXN0aW9uIHNlZW1zIG1vcmUNCj4gPiBzdWl0YWJsZSwgYnV0IG1h
eWJlIHVzZXJzIGNhbiBzaW1wbHkgdHJ5IHRvIGVuYWJsZSBhdXhpbGlhcnkgZG9tYWlucw0KPiA+
IGZpcnN0LCBhbmQgY29uY2x1ZGUgdGhhdCB0aGUgSU9NTVUgZG9lc24ndCBzdXBwb3J0IGl0IGlm
IGl0IHJldHVybnMgYW4NCj4gZXJyb3INCj4gPg0KPiANCj4gU29tZSBkcml2ZXIgbWlnaHQgd2Fu
dCB0byBjaGVjayB3aGV0aGVyIGhhcmR3YXJlIHN1cHBvcnRzDQo+IEFVWF9ET01BSU4NCj4gZHVy
aW5nIHRoZSBkcml2ZXIgcHJvYmUgc3RhZ2UsIGJ1dCBkb2Vzbid0IHdhbnQgdG8gZW5hYmxlIEFV
WF9ET01BSU4NCj4gYXQgdGhhdCB0aW1lLiBPbmUgcmVhc29uYWJsZSB1c2UgY2FzZSBpcyBkcml2
ZXIgY2hlY2sgQVVYX0RPTUFJTiBjYXANCj4gZHVyaW5nIGRyaXZlciBwcm9iZSBhbmQgZXhwb3Nl
IGRpZmZlcmVudCBzeXNmcyBub2RlcyBhY2NvcmRpbmcgdG8NCj4gd2hldGhlciBBVVhfRE9NQUlO
IGlzIHN1cHBvcnQgb3Igbm90LCB0aGVuIEFVWF9ET01BSU4gaXMgZW5hYmxlZCBvcg0KPiBkaXNh
YmxlZCBkdXJpbmcgcnVuIHRpbWUgdGhyb3VnaCBhIHN5c2ZzIG5vZGUuIFdpdGggdGhpcyBjb25z
aWRlcmF0aW9uLA0KPiB3ZSBzdGlsbCBuZWVkIGEgQVBJIHRvIGNoZWNrIGNhcC4NCj4gDQo+IEhv
dyBhYm91dA0KPiANCj4gKiBpb21tdV9jaGVja19hdXhfZG9tYWluKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gICAgIC0gQ2hlY2sgd2hldGhlciB0aGUgaW9tbXUgZHJpdmVyIHN1cHBvcnRzIG11bHRp
cGxlIGRvbWFpbnMgb24gQGRldi4NCj4gDQoNCm1heWJlIGdlbmVyYWxpemVkIGFzIGlvbW11X2No
ZWNrX2F0dHIgd2l0aCBhdXhfZG9tYWluIGFzIGEgZmxhZywNCmluIGNhc2Ugb3RoZXIgSU9NTVUg
Y2hlY2tzIGludHJvZHVjZWQgaW4gdGhlIGZ1dHVyZS4gaGludGVkIGJ5IEplYW4ncw0KY29tbWVu
dCBvbiBpb21tdV9zdmFfZGV2aWNlX2luaXQgcGFydC4NCg0KVGhhbmtzDQpLZXZpbg0K
