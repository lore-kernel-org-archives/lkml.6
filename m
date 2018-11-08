Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D93C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641F520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 07:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641F520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeKHQ46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 11:56:58 -0500
Received: from mga14.intel.com ([192.55.52.115]:46890 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbeKHQ45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 11:56:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 23:20:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="84242902"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2018 23:20:48 -0800
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 23:20:47 -0800
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 23:20:47 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX151.ccr.corp.intel.com ([169.254.3.199]) with mapi id 14.03.0415.000;
 Thu, 8 Nov 2018 15:20:45 +0800
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
Subject: RE: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Topic: [PATCH v4 04/12] iommu/vt-d: Add 256-bit invalidation
 descriptor support
Thread-Index: AQHUdMlDcnwPlQkmSk2wysYaWtdoaqVDpZEQgAD8+ICAAJeH4P//nPMAgACJwKD//4QhgIAAlskQ
Date:   Thu, 8 Nov 2018 07:20:44 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D6061D@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
 <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D60581@SHSMSX104.ccr.corp.intel.com>
 <ad4f7e5b-9af1-7134-a573-6e78184de0ee@linux.intel.com>
In-Reply-To: <ad4f7e5b-9af1-7134-a573-6e78184de0ee@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYWQ3MTkzYmQtZWY2MS00NWU1LWI1MGQtYzY4NTUzZGFmNmFlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiR1d1NGpzUTFTNFk3Ulh2NDhOWUZcL3FWS21ONmluNGRpUHdZeWdveVdcL1wvRDExaFA2cnlodENxakxTb25NWE1pQyJ9
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gRnJvbTogTHUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21d
DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA4LCAyMDE4IDI6MTQgUE0NCj4gDQo+IEhpLA0K
PiANCj4gT24gMTEvOC8xOCAxOjQ1IFBNLCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4+IEZyb206IEx1
IEJhb2x1IFttYWlsdG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiA+PiBTZW50OiBUaHVy
c2RheSwgTm92ZW1iZXIgOCwgMjAxOCAxOjI1IFBNDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djQgMDQvMTJdIGlvbW11L3Z0LWQ6IEFkZCAyNTYtYml0IGludmFsaWRhdGlvbg0KPiA+PiBkZXNj
cmlwdG9yIHN1cHBvcnQNCj4gPj4NCj4gPj4gSGksDQo+ID4+DQo+ID4+IE9uIDExLzgvMTggMTE6
NDkgQU0sIExpdSwgWWkgTCB3cm90ZToNCj4gPj4+IEhpLA0KPiA+Pj4NCj4gPj4+PiBGcm9tOiBM
dSBCYW9sdSBbbWFpbHRvOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gPj4+PiBTZW50OiBU
aHVyc2RheSwgTm92ZW1iZXIgOCwgMjAxOCAxMDoxNyBBTQ0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjQgMDQvMTJdIGlvbW11L3Z0LWQ6IEFkZCAyNTYtYml0IGludmFsaWRhdGlvbg0KPiA+
Pj4+IGRlc2NyaXB0b3Igc3VwcG9ydA0KPiA+Pj4+DQo+ID4+Pj4gSGkgWWksDQo+ID4+Pj4NCj4g
Pj4+PiBPbiAxMS83LzE4IDI6MDcgUE0sIExpdSwgWWkgTCB3cm90ZToNCj4gPj4+Pj4gSGkgQmFv
bHUsDQo+ID4+Pj4+DQo+ID4+Pj4+PiBGcm9tOiBMdSBCYW9sdSBbbWFpbHRvOmJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbV0NCj4gPj4+Pj4+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNSwgMjAxOCAx
OjMyIFBNDQo+ID4+Pj4+IFsuLi5dDQo+ID4+Pj4+DQo+ID4+Pj4+PiAtLS0NCj4gPj4+Pj4+ICAg
ICBkcml2ZXJzL2lvbW11L2RtYXIuYyAgICAgICAgICAgICAgICB8IDgzICsrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tDQo+ID4+Pj4+PiAgICAgZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYyAg
ICAgICAgICAgfCA3NiArKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+Pj4+Pj4gICAgIGRy
aXZlcnMvaW9tbXUvaW50ZWxfaXJxX3JlbWFwcGluZy5jIHwgIDYgKystDQo+ID4+Pj4+PiAgICAg
aW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oICAgICAgICAgfCAgOSArKystDQo+ID4+Pj4+PiAg
ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMTUgaW5zZXJ0aW9ucygrKSwgNTkgZGVsZXRpb25zKC0pDQo+
ID4+Pj4+Pg0KPiA+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvZG1hci5jIGIvZHJp
dmVycy9pb21tdS9kbWFyLmMgaW5kZXgNCj4gPj4+Pj4+IGQ5Yzc0OGI2ZjllNC4uZWMxMDQyN2I5
OGFjIDEwMDY0NA0KPiA+Pj4+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9kbWFyLmMNCj4gPj4+Pj4+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvZG1hci5jDQo+ID4+Pj4+PiBAQCAtMTE2MCw2ICsxMTYwLDcg
QEAgc3RhdGljIGludCBxaV9jaGVja19mYXVsdChzdHJ1Y3QNCj4gPj4+Pj4+IGludGVsX2lvbW11
ICppb21tdSwgaW50DQo+ID4+Pj4+PiBpbmRleCkNCj4gPj4+Pj4+ICAgICAJaW50IGhlYWQsIHRh
aWw7DQo+ID4+Pj4+PiAgICAgCXN0cnVjdCBxX2ludmFsICpxaSA9IGlvbW11LT5xaTsNCj4gPj4+
Pj4+ICAgICAJaW50IHdhaXRfaW5kZXggPSAoaW5kZXggKyAxKSAlIFFJX0xFTkdUSDsNCj4gPj4+
Pj4+ICsJaW50IHNoaWZ0ID0gcWlfc2hpZnQoaW9tbXUpOw0KPiA+Pj4+Pj4NCj4gPj4+Pj4+ICAg
ICAJaWYgKHFpLT5kZXNjX3N0YXR1c1t3YWl0X2luZGV4XSA9PSBRSV9BQk9SVCkNCj4gPj4+Pj4+
ICAgICAJCXJldHVybiAtRUFHQUlOOw0KPiA+Pj4+Pj4gQEAgLTExNzMsMTMgKzExNzQsMTUgQEAg
c3RhdGljIGludCBxaV9jaGVja19mYXVsdChzdHJ1Y3QNCj4gPj4+Pj4+IGludGVsX2lvbW11ICpp
b21tdSwgaW50IGluZGV4KQ0KPiA+Pj4+Pj4gICAgIAkgKi8NCj4gPj4+Pj4+ICAgICAJaWYgKGZh
dWx0ICYgRE1BX0ZTVFNfSVFFKSB7DQo+ID4+Pj4+PiAgICAgCQloZWFkID0gcmVhZGwoaW9tbXUt
PnJlZyArIERNQVJfSVFIX1JFRyk7DQo+ID4+Pj4+PiAtCQlpZiAoKGhlYWQgPj4gRE1BUl9JUV9T
SElGVCkgPT0gaW5kZXgpIHsNCj4gPj4+Pj4+ICsJCWlmICgoaGVhZCA+PiBzaGlmdCkgPT0gaW5k
ZXgpIHsNCj4gPj4+Pj4+ICsJCQlzdHJ1Y3QgcWlfZGVzYyAqZGVzYyA9IHFpLT5kZXNjICsgaGVh
ZDsNCj4gPj4+Pj4+ICsNCj4gPj4+Pj4+ICAgICAJCQlwcl9lcnIoIlZULWQgZGV0ZWN0ZWQgaW52
YWxpZCBkZXNjcmlwdG9yOiAiDQo+ID4+Pj4+PiAgICAgCQkJCSJsb3c9JWxseCwgaGlnaD0lbGx4
XG4iLA0KPiA+Pj4+Pj4gLQkJCQkodW5zaWduZWQgbG9uZyBsb25nKXFpLT5kZXNjW2luZGV4XS5s
b3csDQo+ID4+Pj4+PiAtCQkJCSh1bnNpZ25lZCBsb25nIGxvbmcpcWktPmRlc2NbaW5kZXhdLmhp
Z2gpOw0KPiA+Pj4+Pj4gLQkJCW1lbWNweSgmcWktPmRlc2NbaW5kZXhdLCAmcWktPmRlc2Nbd2Fp
dF9pbmRleF0sDQo+ID4+Pj4+PiAtCQkJCQlzaXplb2Yoc3RydWN0IHFpX2Rlc2MpKTsNCj4gPj4+
Pj4+ICsJCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylkZXNjLT5xdzAsDQo+ID4+Pj4+PiArCQkJCSh1
bnNpZ25lZCBsb25nIGxvbmcpZGVzYy0+cXcxKTsNCj4gPj4+Pj4gU3RpbGwgbWlzc2luZyBxdzIg
YW5kIHF3My4gTWF5IG1ha2UgdGhlIHByaW50IGRpZmZlciBiYXNlZCBvbiBpZiBzbXRzIGlzDQo+
IGNvbmZpZ2VkLg0KPiA+Pj4+IHF3MiBhbmQgcXczIGFyZSByZXNlcnZlZCBmcm9tIHNvZnR3YXJl
IHBvaW50IG9mIHZpZXcuIFdlIGRvbid0IG5lZWQNCj4gPj4+PiB0byBwcmludCBpdCBmb3IgaW5m
b3JtYXRpb24uDQo+ID4+PiBCdXQgZm9yIFNjYWxhYmxlIG1vZGUsIGl0IHNob3VsZCBiZSB2YWxp
ZD8NCj4gPj4gTm8uIEl0J3MgcmVzZXJ2ZWQgZm9yIHNvZnR3YXJlLg0KPiA+IE5vLCBJIGRvbuKA
mXQgdGhpbmsgc28uIFBSUSByZXNwb25zZSB3b3VsZCBhbHNvIGJlIHF1ZXVlZCB0byBoYXJkd2Fy
ZSBieQ0KPiA+IFFJLiBGb3Igc3VjaCBRSSBkZXNjcmlwdG9ycywgdGhlIGhpZ2ggYml0cyBhcmUg
bm90IHJlc2VydmVkLg0KPiA+DQo+IA0KPiBEbyB5b3UgbWVhbiB0aGUgcHJpdmF0ZSBkYXRhIGZp
ZWxkcyBvZiBhIHBhZ2UgcmVxdWVzdCBkZXNjcmlwdG9yIG9yIGEgcGFnZSBncm91cA0KPiByZXNw
b25zZSBkZXNjcmlwdG9yPyBUaG9zZSBmaWVsZHMgY29udGFpbnMgc29mdHdhcmUgZGVmaW5lZCBw
cml2YXRlIGRhdGEgKG1pZ2h0IGENCj4ga2VybmVsIHBvaW50ZXI/KS4gV2Ugc2hvdWxkIGF2b2lk
IGxlYWtpbmcgc3VjaCBpbmZvcm1hdGlvbiBpbiB0aGUgZ2VuZXJpYyBrZXJuZWwNCj4gbWVzc2Fn
ZSBmb3Igc2VjdXJpdHkgY29uc2lkZXJhdGlvbi4NCj4gT3IgYW55dGhpbmcgSSBtaXNzZWQ/DQoN
CnllcywgSSdtIG5vdCBzdXJlIHdoYXQga2luZCBvZiBkYXRhIGl0IG1heSBiZSBpbiB0aGUgcHJp
dmF0ZSBkYXRhIGZpZWxkLiBGcm9tIHNvZnR3YXJlDQpwb2ludCBvZiB2aWV3LCBpdCBtYXkgYmUg
aGVscGZ1bCB0byBzaG93IHRoZSBmdWxsIGNvbnRlbnQgb2YgdGhlIFFJIGRlc2NyaXB0b3IgZm9y
IGVycm9yDQp0cmlhZ2UuIFBlcnNvbmFsbHksIEknbSBmaW5lIGlmIHlvdSBrZWVwIGl0IG9uIHRo
aXMgcG9pbnQuDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==
