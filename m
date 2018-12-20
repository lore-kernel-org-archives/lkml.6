Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE4CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C722520811
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeLTBPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:15:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:56605 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726716AbeLTBPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:15:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 17:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,374,1539673200"; 
   d="scan'208";a="129319179"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 19 Dec 2018 17:15:44 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.103]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.191]) with mapi id 14.03.0415.000;
 Wed, 19 Dec 2018 17:15:44 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: RE: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
Thread-Topic: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
Thread-Index: AQHUkO3XM2Ol/XZNM0q95bVci98IHqV50HwAgAzrutCAAJXiAP//iW7Q
Date:   Thu, 20 Dec 2018 01:15:43 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C557DAB@ORSMSX122.amr.corp.intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
 <20181211010310.8551-2-keith.busch@intel.com>
 <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com>
 <CF6A88132359CE47947DB4C6E1709ED53C557D62@ORSMSX122.amr.corp.intel.com>
 <CAPcyv4jmGH0FS8iBP9=A-nicNfgHAmU+nBHsGgxyS3RNZ9tV5Q@mail.gmail.com>
In-Reply-To: <CAPcyv4jmGH0FS8iBP9=A-nicNfgHAmU+nBHsGgxyS3RNZ9tV5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYWNwaS1vd25l
ckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1hY3BpLQ0KPiBvd25lckB2Z2VyLmtlcm5l
bC5vcmddIE9uIEJlaGFsZiBPZiBEYW4gV2lsbGlhbXMNCj4gU2VudDogV2VkbmVzZGF5LCBEZWNl
bWJlciAxOSwgMjAxOCA0OjAwIFBNDQo+IFRvOiBTY2htYXVzcywgRXJpayA8ZXJpay5zY2htYXVz
c0BpbnRlbC5jb20+DQo+IENjOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+
OyBCdXNjaCwgS2VpdGgNCj4gPGtlaXRoLmJ1c2NoQGludGVsLmNvbT47IE1vb3JlLCBSb2JlcnQg
PHJvYmVydC5tb29yZUBpbnRlbC5jb20+Ow0KPiBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgQUNQSSBEZXZlbA0KPiBNYWxpbmcgTGlzdCA8
bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc+OyBMaW51eCBNZW1vcnkgTWFuYWdlbWVudA0KPiBM
aXN0IDxsaW51eC1tbUBrdmFjay5vcmc+OyBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPjsgSGFuc2VuLCBEYXZlDQo+IDxkYXZlLmhhbnNlbkBpbnRlbC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0h2MiAwMS8xMl0gYWNwaTogQ3JlYXRlIHN1YnRhYmxl
IHBhcnNpbmcNCj4gaW5mcmFzdHJ1Y3R1cmUNCj4gDQo+IE9uIFdlZCwgRGVjIDE5LCAyMDE4IGF0
IDM6MTkgUE0gU2NobWF1c3MsIEVyaWsNCj4gPGVyaWsuc2NobWF1c3NAaW50ZWwuY29tPiB3cm90
ZToNCj4gPg0KPiA+DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4g
PiBGcm9tOiBsaW51eC1hY3BpLW93bmVyQHZnZXIua2VybmVsLm9yZyBbbWFpbHRvOmxpbnV4LWFj
cGktDQo+ID4gPiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBSYWZhZWwgSi4g
V3lzb2NraQ0KPiA+ID4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMTEsIDIwMTggMTo0NSBBTQ0K
PiA+ID4gVG86IEJ1c2NoLCBLZWl0aCA8a2VpdGguYnVzY2hAaW50ZWwuY29tPg0KPiA+ID4gQ2M6
IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBBQ1BJDQo+ID4gPiBEZXZlbCBNYWxpbmcgTGlzdCA8bGludXgtYWNwaUB2Z2VyLmtlcm5lbC5v
cmc+OyBMaW51eCBNZW1vcnkNCj4gPiA+IE1hbmFnZW1lbnQgTGlzdCA8bGludXgtbW1Aa3ZhY2su
b3JnPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+ID4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5v
cmc+OyBSYWZhZWwgSi4gV3lzb2NraQ0KPiA8cmFmYWVsQGtlcm5lbC5vcmc+Ow0KPiA+ID4gSGFu
c2VuLCBEYXZlIDxkYXZlLmhhbnNlbkBpbnRlbC5jb20+OyBXaWxsaWFtcywgRGFuIEoNCj4gPiA+
IDxkYW4uai53aWxsaWFtc0BpbnRlbC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIdjIg
MDEvMTJdIGFjcGk6IENyZWF0ZSBzdWJ0YWJsZSBwYXJzaW5nDQo+ID4gPiBpbmZyYXN0cnVjdHVy
ZQ0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgRGVjIDExLCAyMDE4IGF0IDI6MDUgQU0gS2VpdGggQnVz
Y2gNCj4gPGtlaXRoLmJ1c2NoQGludGVsLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+
DQo+ID4gSGkgUmFmYWVsIGFuZCBCb2IsDQo+ID4NCj4gPiA+ID4gUGFyc2luZyBlbnRyaWVzIGlu
IGFuIEFDUEkgdGFibGUgaGFkIGFzc3VtZWQgYSBnZW5lcmljIGhlYWRlcg0KPiA+ID4gPiBzdHJ1
Y3R1cmUgdGhhdCBpcyBtb3N0IGNvbW1vbi4gVGhlcmUgaXMgbm8gc3RhbmRhcmQgQUNQSQ0KPiBo
ZWFkZXIsDQo+ID4gPiA+IHRob3VnaCwgc28gbGVzcyBjb21tb24gdHlwZXMgd291bGQgbmVlZCBj
dXN0b20gcGFyc2VycyBpZiB0aGV5DQo+ID4gPiA+IHdhbnQgZ28gdGhyb3VnaCB0aGVpciBzdWIt
dGFibGUgZW50cnkgbGlzdC4NCj4gPiA+DQo+ID4gPiBJdCBsb29rcyBsaWtlIHRoZSBwcm9ibGVt
IGF0IGhhbmQgaXMgdGhhdCBhY3BpX2htYXRfc3RydWN0dXJlIGlzDQo+ID4gPiBpbmNvbXBhdGli
bGUgd2l0aCBhY3BpX3N1YnRhYmxlX2hlYWRlciBiZWNhdXNlIG9mIHRoZSBkaWZmZXJlbnQNCj4g
bGF5b3V0IGFuZCBmaWVsZCBzaXplcy4NCj4gPg0KPiA+IEp1c3Qgb3V0IG9mIGN1cmlvc2l0eSwg
d2h5IGRvbid0IHdlIHVzZSBBQ1BJQ0EgY29kZSB0byBwYXJzZSBzdGF0aWMNCj4gPiBBQ1BJIHRh
YmxlcyBpbiBMaW51eD8NCj4gPg0KPiA+IFdlIGhhdmUgYSBkaXNhc3NlbWJsZXIgZm9yIHN0YXRp
YyB0YWJsZXMgdGhhdCBwYXJzZXMgYWxsIHN1cHBvcnRlZA0KPiA+IHRhYmxlcy4gVGhpcyBzZWVt
cyBsaWtlIGEgZHVwbGljYXRpb24gb2YgY29kZS9lZmZvcnQuLi4NCj4gDQpIaSBEYW4sDQoNCj4g
T2gsIEkgdGhvdWdodCBhY3BpX3RhYmxlX3BhcnNlX2VudHJpZXMoKSB3YXMgdGhlIGNvbW1vbiBj
b2RlLg0KPiBXaGF0J3MgdGhlIEFDUElDQSBkdXBsaWNhdGU/DQoNCkkgd2FzIHRoaW5raW5nIEFj
cGlEbUR1bXBUYWJsZSgpLiBBZnRlciBsb29raW5nIGF0IHRoaXMgQUNQSUNBIGNvZGUsDQpJIHJl
YWxpemVkIHRoYXQgdGhlIHRoaXMgQUNQSUNBIGRvZXNuJ3QgYWN0dWFsbHkgYnVpbGQgYSBwYXJz
ZSB0cmVlIG9yIGRhdGEgc3RydWN0dXJlLg0KSXQgbG9vcHMgb3ZlciB0aGUgZGF0YSBzdHJ1Y3R1
cmUgdG8gZm9ybWF0IHRoZSBpbnB1dCBBQ1BJIHRhYmxlIHRvIGEgZmlsZS4NCg0KVG8gbWUsIGl0
IHNlZW1zIGxpa2UgYSBnb29kIGlkZWEgZm9yIExpbnV4IGFuZCBBQ1BJQ0EgdG8gc2hhcmUgdGhl
IHNhbWUgY29kZSB3aGVuDQpwYXJzaW5nIGFuZCBhbmFseXppbmcgdGhlc2Ugc3RydWN0dXJlcy4g
SSBrbm93IHRoYXQgTGludXggbWF5IGVtaXQgd2FybmluZ3MNCnRoYXQgYXJlIHNwZWNpZmljIHRv
IExpbnV4IGJ1dCB0aGVyZSBhcmUgc3RydWN0dXJhbCBhbmFseXNlcyB0aGF0IHNob3VsZCBiZSB0
aGUgc2FtZSAoc3VjaCBhcw0KY2hlY2tpbmcgbGVuZ3RocyBvZiB0YWJsZXMgYW5kIHN1YnRhYmxl
cyBzbyB0aGF0IHdlIGRvbid0IGhhdmUgb3V0IG9mIGJvdW5kcyBhY2Nlc3MpLg0KDQpFcmlrDQo=
