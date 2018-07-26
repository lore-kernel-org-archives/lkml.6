Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EF9C67790
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1391A20647
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1391A20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbeGZEnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 00:43:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:58250 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeGZEnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 00:43:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 20:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,403,1526367600"; 
   d="scan'208";a="70420766"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2018 20:28:26 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 25 Jul 2018 20:28:26 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Wed, 25 Jul 2018 20:28:25 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.57]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.81]) with mapi id 14.03.0319.002;
 Thu, 26 Jul 2018 11:28:23 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     'Jean-Philippe Brucker' <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Topic: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated
 devices
Thread-Index: AQHUIYLU0u0k0vB4lUGhJp9aIAl9hqSbto0AgAFqm4CAAJkvgIABd3XwgAA4QWCAAGW+gIAA/icAgAAMdAA=
Date:   Thu, 26 Jul 2018 03:28:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191282739@SHSMSX101.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
 <1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
 <5B568D5B.5050606@linux.intel.com>
 <ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
 <a530c220-9bf1-05ec-5698-526ccbea127f@arm.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D1912826AE@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912826AE@SHSMSX101.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTMyN2YyN2YtOGY0Yy00ODEzLWJkMzMtZTJjNjk3ZDY1ODYyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiekdZczd3SE1zTFE3UWprZnE4ZEJlcVZuRnJuSEJwcDFFQ3UyUDhGbEwzOVNOSjdPVVNkbUhNZGY0WGVDYW82NyJ9
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

PiBGcm9tOiBUaWFuLCBLZXZpbg0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNiwgMjAxOCAxMTow
NCBBTQ0KWy4uLl0NCj4gPg0KPiA+IFRoZSBJT01NVSBvcGVyYXRpb25zIHdlIGNhcmUgYWJvdXQg
ZG9uJ3QgdGFrZSBhIGRldmljZSBoYW5kbGUsIEkgdGhpbmssDQo+ID4ganVzdCBhIGRvbWFpbi4g
QW5kIFZGSU8gaXRzZWxmIG9ubHkgZGVhbHMgd2l0aCBkb21haW5zIHdoZW4gZG9pbmcNCj4gPiBt
YXAvdW5tYXAuIE1heWJlIHdlIGNvdWxkIGFkZCB0aGlzIG9wZXJhdGlvbiB0byB0aGUgSU9NTVUN
Cj4gc3Vic3lzdGVtOg0KPiA+DQo+ID4gY2hpbGRfZG9tYWluID0gZG9tYWluX2NyZWF0ZV9jaGls
ZChwYXJlbnRfZGV2LCBwYXJlbnRfZG9tYWluKQ0KPiA+DQo+ID4gQSBjaGlsZCBkb21haW4gd291
bGQgYmUgYSBzbWFsbGVyIGlzb2xhdGlvbiBncmFudWxlLCBnZXR0aW5nIGEgUEFTSUQgaWYNCj4g
PiB0aGF0J3Mgd2hhdCB0aGUgSU9NTVUgaW1wbGVtZW50cyBvciBhbm90aGVyIG1lY2hhbmlzbSBm
b3IgMikuIEl0IGlzDQo+ID4gYXV0b21hdGljYWxseSBhdHRhY2hlZCB0byBpdHMgcGFyZW50J3Mg
ZGV2aWNlcywgc28gYXR0YWNoL2RldGFjaA0KPiA+IG9wZXJhdGlvbnMgd291bGRuJ3QgYmUgbmVj
ZXNzYXJ5IG9uIHRoZSBjaGlsZC4NCj4gPg0KPiA+IERlcGVuZGluZyBvbiB0aGUgdW5kZXJseWlu
ZyBhcmNoaXRlY3R1cmUgdGhlIGNoaWxkIGRvbWFpbiBjYW4gc3VwcG9ydA0KPiA+IG1hcC91bm1h
cCBvbiBhIHNpbmdsZSBzdGFnZSwgb3IgbWFwL3VubWFwIGZvciAybmQgbGV2ZWwgYW5kDQo+ID4g
YmluZF9wZ3RhYmxlDQo+ID4gZm9yIDFzdCBsZXZlbC4NCj4gPg0KPiA+IEknbSBub3Qgc3VyZSBo
b3cgdGhpcyB3b3JrcyBmb3IgaG9zdCBTVkEgdGhvdWdoLiBJIHRoaW5rIHRoZQ0KPiA+IHN2YV9i
aW5kX2RldigpIEFQSSBjb3VsZCBzdGF5IHRoZSBzYW1lLCBidXQgdGhlIGludGVybmFscyB3aWxs
IG5lZWQNCj4gPiB0byBjaGFuZ2UuDQo+ID4NCj4gDQo+IGhpZXJhcmNoaWNhbCBkb21haW4gbWln
aHQgYmUgdGhlIHJpZ2h0IHdheSB0byBnbywgYnV0IGxldCdzIGRvIG1vcmUNCj4gdGhpbmtpbmcg
b24gYW55IGNvcm5lciBjYXNlcy4NCj4gDQoNCmJ0dyBtYXliZSB3ZSBkb24ndCBuZWVkIG1ha2Ug
aXQgJ2hpZXJhcmNoaWNhbCcsIGFzIG1haW50YWluaW5nDQpoaWVyYXJjaHkgdXN1YWxseSBicmlu
Z3MgbW9yZSB3b3JrLiBXaGF0IHdlIHJlcXVpcmUgaXMgcG9zc2libHkNCmp1c3QgdGhlIGNhcGFi
aWxpdHkgb2YgaGF2aW5nIG9uZSBkZXZpY2UgYmluZCB0byBtdWx0aXBsZSANCmlvbW11X2RvbWFp
bnMuIE9uZSBkb21haW4gaXMgcmVzZXJ2ZWQgZm9yIHBhcmVudCBkcml2ZXIncw0Kb3duIERNQSBh
Y3Rpdml0aWVzIChlLmcuIHNlcnZpbmcgRE1BIEFQSXMpLCB3aGlsZSBvdGhlciBkb21haW5zDQph
cmUgYXV4aWxpYXJ5IGFuZCBjYW4gYmUgdGFnZ2VkIHdpdGggYSBQQVNJRCAob3IgYW55IG90aGVy
IGlkZW50aWZpZXINCndoaWNoIElPTU1VIGNhbiB1c2UgdG8gc3VwcG9ydCBtdWx0aXBsZSBkb21h
aW5zKS4gU3VjaCBpZGVudGlmaWVycyANCm1heSBiZSBhdXRvbWF0aWNhbGx5IHByb3Zpc2lvbmVk
IHdoZW4gYXV4aWxpYXJ5IGRvbWFpbiBpcyBhdHRhY2hlZCwgDQppLmUuIG5vdCByZXF1aXJpbmcg
YW4gZXhwbGljaXQgcmVxdWVzdCBmcm9tIGNhbGxlci4gSU1PIGl0J3Mgc2FmZSB0byANCmFzc3Vt
ZSB0aGF0IHN1cHBvcnRpbmcgbXVsdGlwbGUgaW9tbXUgZG9tYWlucyBhbnl3YXkgaW1wbGllcyAN
CnNvbWUgZmluZXItZ3JhaW5lZCBjYXBhYmlsaXR5IHRoYW4gUklELWJhc2VkIGluIHVuZGVybHlp
bmcgSU9NTVUuDQpUaGVuIHRoZXJlIGlzIG5vIG5lZWQgb2YgcGFyZW50L2NoaWxkIGNvbmNlcHQu
DQoNCnRob3VnaHRzPw0KDQpUaGFua3MNCktldmluDQo=
