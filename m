Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA77EC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8762320857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 05:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8762320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeKHPW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 10:22:27 -0500
Received: from mga06.intel.com ([134.134.136.31]:13544 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbeKHPW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 10:22:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 21:48:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="106287853"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2018 21:48:39 -0800
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 21:48:39 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.161]) with mapi id 14.03.0415.000;
 Thu, 8 Nov 2018 13:48:38 +0800
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
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Topic: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Index: AQHUdMlDcnwPlQkmSk2wysYaWtdoaqVDpZEQgAD8+ICAAJeH4P//nPMAgACJwKCAAAKt0A==
Date:   Thu, 8 Nov 2018 05:48:37 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D60599@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
 <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODg5NTVlMGMtMzlmNi00MGM5LWFiYjUtMzA3YWQyOWM4N2M0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYU81clFPZWk1MDNSelorWkl1WWJRTDJGSW1RelpZTjNRRURRUEJDcW5rU256cHpiUzh3aWVwYlBtQm1GUUpJbiJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBMaXUsIFlpIEwNCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDgsIDIwMTggMTo0
NSBQTQ0KPiA+ID4+Pj4gKwkJCW1lbWNweShkZXNjLCBxaS0+ZGVzYyArICh3YWl0X2luZGV4IDw8
IHNoaWZ0KSwNCj4gPiA+Pj4NCj4gPiA+Pj4gV291bGQgIm1lbWNweShkZXNjLCAodW5zaWduZWQg
bG9uZyBsb25nKSAocWktPmRlc2MgKyAgKHdhaXRfaW5kZXgNCj4gPiA+Pj4gPDwgc2hpZnQpLCIg
YmUgbW9yZSBzYWZlPw0KPiA+ID4+DQo+ID4gPj4gQ2FuIHRoYXQgYmUgY29tcGlsZWQ/IG1lbWNw
eSgpIHJlcXVpcmVzIGEgImNvbnN0IHZvaWQgKiIgZm9yIHRoZQ0KPiA+ID4+IHNlY29uZA0KPiA+
IHBhcmFtZXRlci4NCj4gPiA+PiBCeSB0aGUgd2F5LCB3aHkgaXQncyBzYWZlciB3aXRoIHRoaXMg
Y2FzdGluZz8NCj4gPiA+DQo+ID4gPiBUaGlzIGlzIGp1c3QgYW4gZXhhbXBsZS4gTXkgcG9pbnQg
aXMgdGhlIHBvc3NpYmlsaXR5IHRoYXQgInFpLT5kZXNjDQo+ID4gPiArICh3YWl0X2luZGV4IDw8
DQo+ID4gc2hpZnQpIg0KPiA+ID4gd291bGQgYmUgdHJlYXRlZCBhcyAicWktPmRlc2MgcGx1cyAo
d2FpdF9pbmRleCA8PA0KPiA+ID4gc2hpZnQpKnNpemVvZigqcWktPmRlc2MpIi4gSXMgaXQgcG9z
c2libGUgZm9yIGtlcm5lbCBidWlsZD8NCj4gPg0KPiA+IHFpLT5kZXNjIGlzIG9mIHR5cGUgb2Yg
InZvaWQgKiIuDQo+IA0KPiBubywgSSBkb27igJl0IHRoaW5rIHNvLi4uIFJlZmVyIHRvIHRoZSBj
b2RlIGJlbG93LiBFdmVuIGl0IGhhcyBubyBjb3JyZWN0bmVzcyBpc3N1ZSBoZXIsDQo+IEl0J3Mg
bm90IGR1ZSB0byBxaS0+ZGVzYyBpcyAidm9pZCAqIiB0eXBlLi4uDQo+IA0KPiBzdHJ1Y3QgcWlf
ZGVzYyB7DQo+IC0JdTY0IGxvdywgaGlnaDsNCj4gKwl1NjQgcXcwOw0KPiArCXU2NCBxdzE7DQo+
ICsJdTY0IHF3MjsNCj4gKwl1NjQgcXczOw0KPiB9Ow0KDQpPb3BzLCBqdXN0IHNlZSB5b3UgbW9k
aWZpZWQgaXQgdG8gYmUgInZvaWQgKiIgaW4gdGhpcyBwYXRjaC4gT2ssIHRoZW4gdGhpcyBpcyBm
YWlyIGVub3VnaC4NCg0KVGhhbmtzLA0KWWkgTGl1DQo=
