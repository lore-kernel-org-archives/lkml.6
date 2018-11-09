Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8A1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E7E2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E7E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeKIMhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:37:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:5684 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeKIMho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:37:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2018 18:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,481,1534834800"; 
   d="scan'208";a="87845311"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 08 Nov 2018 18:59:08 -0800
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 8 Nov 2018 18:59:08 -0800
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 8 Nov 2018 18:59:07 -0800
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.117]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.102]) with mapi id 14.03.0415.000;
 Fri, 9 Nov 2018 10:59:05 +0800
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
Thread-Index: AQHUdMlDcnwPlQkmSk2wysYaWtdoaqVDpZEQgAD8+ICAAJeH4P//nPMAgACJwKD//4QhgIAAlskQgACu4YCAAJv/wA==
Date:   Fri, 9 Nov 2018 02:59:04 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439D6114F@SHSMSX104.ccr.corp.intel.com>
References: <20181105053151.7173-1-baolu.lu@linux.intel.com>
 <20181105053151.7173-5-baolu.lu@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D5FAA2@SHSMSX104.ccr.corp.intel.com>
 <a6e43ddd-0889-4a4a-b908-993db28c6d87@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D604DF@SHSMSX104.ccr.corp.intel.com>
 <915876cd-6a1f-097b-b9be-9cb3df18a1df@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D60581@SHSMSX104.ccr.corp.intel.com>
 <ad4f7e5b-9af1-7134-a573-6e78184de0ee@linux.intel.com>
 <A2975661238FB949B60364EF0F2C257439D6061D@SHSMSX104.ccr.corp.intel.com>
 <af077cad-d99b-1cd8-046b-4dbfae3d32f9@linux.intel.com>
In-Reply-To: <af077cad-d99b-1cd8-046b-4dbfae3d32f9@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDljZWY5MDgtYzc1Yy00NTRmLWFkZTMtMGY4MzE4NzI5OTBhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZVU0NzNiSUFOMmJEUFhKNlg5UlJ0aWVvTUsrUW4yZzB1R3dEXC9IRmhzeUY0XC9INVpiNzRaT1B0TzM3YUpvdGpyIn0=
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gRnJvbTogTHUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21d
DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgOSwgMjAxOCA5OjQwIEFNDQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjQgMDQvMTJdIGlvbW11L3Z0LWQ6IEFkZCAyNTYtYml0IGludmFsaWRhdGlvbiBk
ZXNjcmlwdG9yDQo+IHN1cHBvcnQNCj4gDQo+IEhpLA0KPiANCj4gT24gMTEvOC8xOCAzOjIwIFBN
LCBMaXUsIFlpIEwgd3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPj4gRnJvbTogTHUgQmFvbHUgW21h
aWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBOb3Zl
bWJlciA4LCAyMDE4IDI6MTQgUE0NCj4gPj4NCj4gPj4gSGksDQo+ID4+DQo+ID4+IE9uIDExLzgv
MTggMTo0NSBQTSwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+Pj4+IEZyb206IEx1IEJhb2x1IFttYWls
dG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiA+Pj4+IFNlbnQ6IFRodXJzZGF5LCBOb3Zl
bWJlciA4LCAyMDE4IDE6MjUgUE0NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDA0LzEy
XSBpb21tdS92dC1kOiBBZGQgMjU2LWJpdCBpbnZhbGlkYXRpb24NCj4gPj4+PiBkZXNjcmlwdG9y
IHN1cHBvcnQNCj4gPj4+Pg0KPiA+Pj4+IEhpLA0KPiA+Pj4+DQo+ID4+Pj4gT24gMTEvOC8xOCAx
MTo0OSBBTSwgTGl1LCBZaSBMIHdyb3RlOg0KPiA+Pj4+PiBIaSwNCj4gPj4+Pj4NCj4gPj4+Pj4+
IEZyb206IEx1IEJhb2x1IFttYWlsdG86YmFvbHUubHVAbGludXguaW50ZWwuY29tXQ0KPiA+Pj4+
Pj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDgsIDIwMTggMTA6MTcgQU0NCj4gPj4+Pj4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDQvMTJdIGlvbW11L3Z0LWQ6IEFkZCAyNTYtYml0DQo+ID4+
Pj4+PiBpbnZhbGlkYXRpb24gZGVzY3JpcHRvciBzdXBwb3J0DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4g
SGkgWWksDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gT24gMTEvNy8xOCAyOjA3IFBNLCBMaXUsIFlpIEwg
d3JvdGU6DQo+ID4+Pj4+Pj4gSGkgQmFvbHUsDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gRnJvbTog
THUgQmFvbHUgW21haWx0bzpiYW9sdS5sdUBsaW51eC5pbnRlbC5jb21dDQo+ID4+Pj4+Pj4+IFNl
bnQ6IE1vbmRheSwgTm92ZW1iZXIgNSwgMjAxOCAxOjMyIFBNDQo+ID4+Pj4+Pj4gWy4uLl0NCj4g
Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiAtLS0NCj4gPj4+Pj4+Pj4gICAgICBkcml2ZXJzL2lvbW11L2Rt
YXIuYyAgICAgICAgICAgICAgICB8IDgzICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+
ID4+Pj4+Pj4+ICAgICAgZHJpdmVycy9pb21tdS9pbnRlbC1zdm0uYyAgICAgICAgICAgfCA3NiAr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+Pj4+Pj4+PiAgICAgIGRyaXZlcnMvaW9tbXUv
aW50ZWxfaXJxX3JlbWFwcGluZy5jIHwgIDYgKystDQo+ID4+Pj4+Pj4+ICAgICAgaW5jbHVkZS9s
aW51eC9pbnRlbC1pb21tdS5oICAgICAgICAgfCAgOSArKystDQo+ID4+Pj4+Pj4+ICAgICAgNCBm
aWxlcyBjaGFuZ2VkLCAxMTUgaW5zZXJ0aW9ucygrKSwgNTkgZGVsZXRpb25zKC0pDQo+ID4+Pj4+
Pj4+DQo+ID4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2RtYXIuYyBiL2RyaXZl
cnMvaW9tbXUvZG1hci5jIGluZGV4DQo+ID4+Pj4+Pj4+IGQ5Yzc0OGI2ZjllNC4uZWMxMDQyN2I5
OGFjIDEwMDY0NA0KPiA+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2RtYXIuYw0KPiA+Pj4+
Pj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2RtYXIuYw0KPiA+Pj4+Pj4+PiBAQCAtMTE2MCw2ICsx
MTYwLDcgQEAgc3RhdGljIGludCBxaV9jaGVja19mYXVsdChzdHJ1Y3QNCj4gPj4+Pj4+Pj4gaW50
ZWxfaW9tbXUgKmlvbW11LCBpbnQNCj4gPj4+Pj4+Pj4gaW5kZXgpDQo+ID4+Pj4+Pj4+ICAgICAg
CWludCBoZWFkLCB0YWlsOw0KPiA+Pj4+Pj4+PiAgICAgIAlzdHJ1Y3QgcV9pbnZhbCAqcWkgPSBp
b21tdS0+cWk7DQo+ID4+Pj4+Pj4+ICAgICAgCWludCB3YWl0X2luZGV4ID0gKGluZGV4ICsgMSkg
JSBRSV9MRU5HVEg7DQo+ID4+Pj4+Pj4+ICsJaW50IHNoaWZ0ID0gcWlfc2hpZnQoaW9tbXUpOw0K
PiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiAgICAgIAlpZiAocWktPmRlc2Nfc3RhdHVzW3dhaXRfaW5k
ZXhdID09IFFJX0FCT1JUKQ0KPiA+Pj4+Pj4+PiAgICAgIAkJcmV0dXJuIC1FQUdBSU47DQo+ID4+
Pj4+Pj4+IEBAIC0xMTczLDEzICsxMTc0LDE1IEBAIHN0YXRpYyBpbnQgcWlfY2hlY2tfZmF1bHQo
c3RydWN0DQo+ID4+Pj4+Pj4+IGludGVsX2lvbW11ICppb21tdSwgaW50IGluZGV4KQ0KPiA+Pj4+
Pj4+PiAgICAgIAkgKi8NCj4gPj4+Pj4+Pj4gICAgICAJaWYgKGZhdWx0ICYgRE1BX0ZTVFNfSVFF
KSB7DQo+ID4+Pj4+Pj4+ICAgICAgCQloZWFkID0gcmVhZGwoaW9tbXUtPnJlZyArIERNQVJfSVFI
X1JFRyk7DQo+ID4+Pj4+Pj4+IC0JCWlmICgoaGVhZCA+PiBETUFSX0lRX1NISUZUKSA9PSBpbmRl
eCkgew0KPiA+Pj4+Pj4+PiArCQlpZiAoKGhlYWQgPj4gc2hpZnQpID09IGluZGV4KSB7DQo+ID4+
Pj4+Pj4+ICsJCQlzdHJ1Y3QgcWlfZGVzYyAqZGVzYyA9IHFpLT5kZXNjICsgaGVhZDsNCj4gPj4+
Pj4+Pj4gKw0KPiA+Pj4+Pj4+PiAgICAgIAkJCXByX2VycigiVlQtZCBkZXRlY3RlZCBpbnZhbGlk
IGRlc2NyaXB0b3I6ICINCj4gPj4+Pj4+Pj4gICAgICAJCQkJImxvdz0lbGx4LCBoaWdoPSVsbHhc
biIsDQo+ID4+Pj4+Pj4+IC0JCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylxaS0+ZGVzY1tpbmRleF0u
bG93LA0KPiA+Pj4+Pj4+PiAtCQkJCSh1bnNpZ25lZCBsb25nIGxvbmcpcWktPmRlc2NbaW5kZXhd
LmhpZ2gpOw0KPiA+Pj4+Pj4+PiAtCQkJbWVtY3B5KCZxaS0+ZGVzY1tpbmRleF0sICZxaS0+ZGVz
Y1t3YWl0X2luZGV4XSwNCj4gPj4+Pj4+Pj4gLQkJCQkJc2l6ZW9mKHN0cnVjdCBxaV9kZXNjKSk7
DQo+ID4+Pj4+Pj4+ICsJCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylkZXNjLT5xdzAsDQo+ID4+Pj4+
Pj4+ICsJCQkJKHVuc2lnbmVkIGxvbmcgbG9uZylkZXNjLT5xdzEpOw0KPiA+Pj4+Pj4+IFN0aWxs
IG1pc3NpbmcgcXcyIGFuZCBxdzMuIE1heSBtYWtlIHRoZSBwcmludCBkaWZmZXIgYmFzZWQgb24g
aWYNCj4gPj4+Pj4+PiBzbXRzIGlzDQo+ID4+IGNvbmZpZ2VkLg0KPiA+Pj4+Pj4gcXcyIGFuZCBx
dzMgYXJlIHJlc2VydmVkIGZyb20gc29mdHdhcmUgcG9pbnQgb2Ygdmlldy4gV2UgZG9uJ3QNCj4g
Pj4+Pj4+IG5lZWQgdG8gcHJpbnQgaXQgZm9yIGluZm9ybWF0aW9uLg0KPiA+Pj4+PiBCdXQgZm9y
IFNjYWxhYmxlIG1vZGUsIGl0IHNob3VsZCBiZSB2YWxpZD8NCj4gPj4+PiBOby4gSXQncyByZXNl
cnZlZCBmb3Igc29mdHdhcmUuDQo+ID4+PiBObywgSSBkb27igJl0IHRoaW5rIHNvLiBQUlEgcmVz
cG9uc2Ugd291bGQgYWxzbyBiZSBxdWV1ZWQgdG8gaGFyZHdhcmUNCj4gPj4+IGJ5IFFJLiBGb3Ig
c3VjaCBRSSBkZXNjcmlwdG9ycywgdGhlIGhpZ2ggYml0cyBhcmUgbm90IHJlc2VydmVkLg0KPiA+
Pj4NCj4gPj4NCj4gPj4gRG8geW91IG1lYW4gdGhlIHByaXZhdGUgZGF0YSBmaWVsZHMgb2YgYSBw
YWdlIHJlcXVlc3QgZGVzY3JpcHRvciBvciBhDQo+ID4+IHBhZ2UgZ3JvdXAgcmVzcG9uc2UgZGVz
Y3JpcHRvcj8gVGhvc2UgZmllbGRzIGNvbnRhaW5zIHNvZnR3YXJlDQo+ID4+IGRlZmluZWQgcHJp
dmF0ZSBkYXRhIChtaWdodCBhIGtlcm5lbCBwb2ludGVyPykuIFdlIHNob3VsZCBhdm9pZA0KPiA+
PiBsZWFraW5nIHN1Y2ggaW5mb3JtYXRpb24gaW4gdGhlIGdlbmVyaWMga2VybmVsIG1lc3NhZ2Ug
Zm9yIHNlY3VyaXR5IGNvbnNpZGVyYXRpb24uDQo+ID4+IE9yIGFueXRoaW5nIEkgbWlzc2VkPw0K
PiA+DQo+ID4geWVzLCBJJ20gbm90IHN1cmUgd2hhdCBraW5kIG9mIGRhdGEgaXQgbWF5IGJlIGlu
IHRoZSBwcml2YXRlIGRhdGENCj4gPiBmaWVsZC4gRnJvbSBzb2Z0d2FyZSBwb2ludCBvZiB2aWV3
LCBpdCBtYXkgYmUgaGVscGZ1bCB0byBzaG93IHRoZSBmdWxsDQo+ID4gY29udGVudCBvZiB0aGUg
UUkgZGVzY3JpcHRvciBmb3IgZXJyb3IgdHJpYWdlLiBQZXJzb25hbGx5LCBJJ20gZmluZSBpZiB5
b3Uga2VlcCBpdCBvbg0KPiB0aGlzIHBvaW50Lg0KPiA+DQo+IA0KPiBPa2F5LCB0aGFua3MuDQo+
IA0KPiBJIHRoaW5rIEkgbmVlZCB0byBwdXQgc29tZSBjb21tZW50cyB0aGVyZSBzbyB0aGF0IHBl
b3BsZSBjb3VsZCB1bmRlcnN0YW5kIG15DQo+IGNvbnNpZGVyYXRpb24uDQoNCnllYWgsIHRoYXQg
d291bGQgYmUgaGVscGZ1bC4gOi0pDQoNClJlZ2FyZHMsDQpZaSBMaXUNCg==
