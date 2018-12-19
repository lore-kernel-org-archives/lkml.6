Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7886C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A213A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbeLSXTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:19:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:25542 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbeLSXTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:19:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Dec 2018 15:19:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,374,1539673200"; 
   d="scan'208";a="285129198"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga005.jf.intel.com with ESMTP; 19 Dec 2018 15:19:32 -0800
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.103]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.212]) with mapi id 14.03.0415.000;
 Wed, 19 Dec 2018 15:19:31 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: RE: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
Thread-Topic: [PATCHv2 01/12] acpi: Create subtable parsing infrastructure
Thread-Index: AQHUkO3XM2Ol/XZNM0q95bVci98IHqV50HwAgAzrutA=
Date:   Wed, 19 Dec 2018 23:19:30 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C557D62@ORSMSX122.amr.corp.intel.com>
References: <20181211010310.8551-1-keith.busch@intel.com>
 <20181211010310.8551-2-keith.busch@intel.com>
 <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iqC2CwR2nM7eF6pDcJe2Me-_fFekX=s16-1TGZ6f6gcA@mail.gmail.com>
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
bC5vcmddIE9uIEJlaGFsZiBPZiBSYWZhZWwgSi4gV3lzb2NraQ0KPiBTZW50OiBUdWVzZGF5LCBE
ZWNlbWJlciAxMSwgMjAxOCAxOjQ1IEFNDQo+IFRvOiBCdXNjaCwgS2VpdGggPGtlaXRoLmJ1c2No
QGludGVsLmNvbT4NCj4gQ2M6IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+OyBBQ1BJIERldmVsDQo+IE1hbGluZyBMaXN0IDxsaW51eC1hY3Bp
QHZnZXIua2VybmVsLm9yZz47IExpbnV4IE1lbW9yeSBNYW5hZ2VtZW50IExpc3QNCj4gPGxpbnV4
LW1tQGt2YWNrLm9yZz47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+OyBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+Ow0KPiBIYW5z
ZW4sIERhdmUgPGRhdmUuaGFuc2VuQGludGVsLmNvbT47IFdpbGxpYW1zLCBEYW4gSg0KPiA8ZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjIgMDEvMTJdIGFj
cGk6IENyZWF0ZSBzdWJ0YWJsZSBwYXJzaW5nIGluZnJhc3RydWN0dXJlDQo+IA0KPiBPbiBUdWUs
IERlYyAxMSwgMjAxOCBhdCAyOjA1IEFNIEtlaXRoIEJ1c2NoIDxrZWl0aC5idXNjaEBpbnRlbC5j
b20+DQo+IHdyb3RlOg0KPiA+DQoNCkhpIFJhZmFlbCBhbmQgQm9iLA0KDQo+ID4gUGFyc2luZyBl
bnRyaWVzIGluIGFuIEFDUEkgdGFibGUgaGFkIGFzc3VtZWQgYSBnZW5lcmljIGhlYWRlcg0KPiA+
IHN0cnVjdHVyZSB0aGF0IGlzIG1vc3QgY29tbW9uLiBUaGVyZSBpcyBubyBzdGFuZGFyZCBBQ1BJ
IGhlYWRlciwNCj4gPiB0aG91Z2gsIHNvIGxlc3MgY29tbW9uIHR5cGVzIHdvdWxkIG5lZWQgY3Vz
dG9tIHBhcnNlcnMgaWYgdGhleSB3YW50IGdvDQo+ID4gdGhyb3VnaCB0aGVpciBzdWItdGFibGUg
ZW50cnkgbGlzdC4NCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhlIHByb2JsZW0gYXQgaGFuZCBpcyB0
aGF0IGFjcGlfaG1hdF9zdHJ1Y3R1cmUgaXMgaW5jb21wYXRpYmxlDQo+IHdpdGggYWNwaV9zdWJ0
YWJsZV9oZWFkZXIgYmVjYXVzZSBvZiB0aGUgZGlmZmVyZW50IGxheW91dCBhbmQgZmllbGQgc2l6
ZXMuDQoNCkp1c3Qgb3V0IG9mIGN1cmlvc2l0eSwgd2h5IGRvbid0IHdlIHVzZSBBQ1BJQ0EgY29k
ZSB0byBwYXJzZSBzdGF0aWMgQUNQSSB0YWJsZXMNCmluIExpbnV4Pw0KDQpXZSBoYXZlIGEgZGlz
YXNzZW1ibGVyIGZvciBzdGF0aWMgdGFibGVzIHRoYXQgcGFyc2VzIGFsbCBzdXBwb3J0ZWQgdGFi
bGVzLiBUaGlzDQpzZWVtcyBsaWtlIGEgZHVwbGljYXRpb24gb2YgY29kZS9lZmZvcnQuLi4NCg0K
RXJpaw0KPiANCj4gSWYgc28sIHBsZWFzZSBzdGF0ZSB0aGF0IGNsZWFybHkgaGVyZS4NCj4gDQo+
IFdpdGggdGhhdCwgcGxlYXNlIGZlZWwgZnJlZSB0byBhZGQNCj4gDQo+IFJldmlld2VkLWJ5OiBS
YWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IA0KPiB0byB0
aGlzIHBhdGNoLg0K
