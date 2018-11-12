Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2924C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA7422504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA7422504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeKME4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 23:56:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:38438 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeKME4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 23:56:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 11:01:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="273422977"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 12 Nov 2018 11:01:53 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 12 Nov 2018 11:01:52 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.8]) with mapi id 14.03.0415.000;
 Mon, 12 Nov 2018 11:01:52 -0800
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     =?utf-8?B?SG9sZ2VyIEhvZmZzdMOkdHRl?= 
        <holger@applied-asynchrony.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jean-Marc Lenoir <archlinux@jihemel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: RE: [PATCH 4.19 025/361] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Topic: [PATCH 4.19 025/361] ACPICA: AML interpreter: add region
 addresses in global list during initialization
Thread-Index: AQHUeg2skAoKAiPRukOIXOKhcDUPNaVM/bWA//+BOQA=
Date:   Mon, 12 Nov 2018 19:01:51 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB9FB49@ORSMSX110.amr.corp.intel.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221623.163909820@linuxfoundation.org>
 <9da1c8e8-d237-11b3-8918-859a4bbdbcc4@applied-asynchrony.com>
In-Reply-To: <9da1c8e8-d237-11b3-8918-859a4bbdbcc4@applied-asynchrony.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9sZ2VyIEhvZmZzdMOk
dHRlIFttYWlsdG86aG9sZ2VyQGFwcGxpZWQtYXN5bmNocm9ueS5jb21dDQo+IFNlbnQ6IE1vbmRh
eSwgTm92ZW1iZXIgMTIsIDIwMTggMTA6MzEgQU0NCj4gVG86IEdyZWcgS3JvYWgtSGFydG1hbiA8
Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZzsgSmVhbi1NYXJjIExlbm9pciA8YXJj
aGxpbnV4QGppaGVtZWwuY29tPjsNCj4gU2NobWF1c3MsIEVyaWsgPGVyaWsuc2NobWF1c3NAaW50
ZWwuY29tPjsgV3lzb2NraSwgUmFmYWVsIEoNCj4gPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDQuMTkgMDI1LzM2MV0gQUNQSUNBOiBBTUwgaW50ZXJw
cmV0ZXI6IGFkZCByZWdpb24NCj4gYWRkcmVzc2VzIGluIGdsb2JhbCBsaXN0IGR1cmluZyBpbml0
aWFsaXphdGlvbg0KPiANCj4gT24gMTEvMTEvMTggMTE6MTYgUE0sIEdyZWcgS3JvYWgtSGFydG1h
biB3cm90ZToNCj4gPiA0LjE5LXN0YWJsZSByZXZpZXcgcGF0Y2guICBJZiBhbnlvbmUgaGFzIGFu
eSBvYmplY3Rpb25zLCBwbGVhc2UgbGV0IG1lDQo+IGtub3cuDQo+IA0KDQpIaSwNCg0KPiBBcyBw
cm9iYWJseSBleHBlY3RlZCB0aGlzIHBhdGNoIGNhdXNlcyBwcm9ibGVtcy4gSW4gbXkgY2FzZSBv
bmUgc2VydmVyIGNhbg0KPiBubyBsb25nZXIgbG9hZCB0aGUgbmN0Njc3NSBod21vbiBtb2R1bGUs
IHdoaWNoIG1lYW5zIHRoZSBmYW4gY2Fubm90IGJlDQo+IG1vbml0b3JlZCwgYW5kIHRoZXJlZm9y
ZSBteSBtb25pdG9yaW5nIHN5c3RlbSBwcm9tcHRseSBzdGFydHMgc3BhbW1pbmcNCj4gbWUgd2l0
aCBhbGVydHMgdGhhdCBteSBmYW4gaGFzIGZhaWxlZCAtIHdoaWNoIGlzIG9mIGNvdXJzZSBub3Qg
dHJ1ZS4NCj4gDQo+IC0tc25pcC0tDQo+IE5vdiAxMiAxODowODo1NiB0dXgga2VybmVsOiBuY3Q2
Nzc1OiBGb3VuZCBOQ1Q2Nzc2RC9GIG9yIGNvbXBhdGlibGUgY2hpcCBhdA0KPiAweDJlOjB4Mjkw
IE5vdiAxMiAxODowODo1NiB0dXgga2VybmVsOiBBQ1BJIFdhcm5pbmc6IFN5c3RlbUlPIHJhbmdl
DQo+IDB4MDAwMDAwMDAwMDAwMDI5NS0weDAwMDAwMDAwMDAwMDAyOTYgY29uZmxpY3RzIHdpdGgg
T3BSZWdpb24NCj4gMHgwMDAwMDAwMDAwMDAwMjkwLTB4IE5vdiAxMiAxODowODo1NiB0dXgga2Vy
bmVsOiBBQ1BJOiBJZiBhbiBBQ1BJIGRyaXZlciBpcw0KPiBhdmFpbGFibGUgZm9yIHRoaXMgZGV2
aWNlLCB5b3Ugc2hvdWxkIHVzZSBpdCBpbnN0ZWFkIG9mIHRoZSBuYXRpdmUgZHJpdmVyDQo+IC0t
c25pcC0tDQo+IA0KPiBUaGlzIGlzIGNlcnRhaW5seSBjYXVzZWQgYnkgbXkgb2xkIEJJT1MgYW5k
IGl0cyBicm9rZW4gQUNQSSBpbXBsZW1lbnRhdGlvbiwNCj4gaG93ZXZlciBzaW5jZSBpdCdzIHdv
cmtpbmcgcGVyZmVjdGx5IGZpbmUgb3RoZXJ3aXNlIEkgc2VlIG5vIHJlYXNvbiB0bw0KPiByZXBs
YWNlIGl0LiBUaGF0IGJlaW5nIHNhaWQsIEkgbXVzdCBiZSBhYmxlIHRvIG1vbml0b3IgbXkgZmFu
LCBzbyBmb3Igbm93DQo+IHJldmVydGluZyB0aGUgcGF0Y2ggaW1tZWRpYXRlbHkgImZpeGVkIiB0
aGUgcHJvYmxlbSBmb3IgbWUgLSB0aGUgZmFuIGVudHJpZXMNCj4gYXBwZWFyZWQgaW4gc3lzZnMg
YWdhaW4gYWZ0ZXIgc3VjY2Vzc2Z1bGx5IGxvYWRpbmcgdGhlIG1vZHVsZS4NCj4gDQo+IElkZWEs
IHdvcmthcm91bmRzIG9yIHBhdGNoZXMgd2VsY29tZS4NCg0KSXMgdGhlcmUgYSBmaXJtd2FyZSB1
cGRhdGUgYXZhaWxhYmxlIGZvciB0aGlzIG1hY2hpbmU/IElmIHNvLCB5b3UgbWF5IHdhbnQgdG8g
ZG8NCmEgZmlybXdhcmUgdXBkYXRlLg0KDQpBbHNvLCB3aGF0IGlzIHRoZSBiZWhhdmlvciBpbiBr
ZXJuZWxzIDQuMTYgb3Igb2xkZXI/DQoNCkVyaWsNCj4gDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4NCj4gPiBGcm9tOiBFcmlrIFNjaG1hdXNzIDxlcmlrLnNjaG1hdXNzQGludGVsLmNvbT4N
Cj4gPg0KPiA+IGNvbW1pdCA0YWJiOTUxYjczZmYwYThhOTc5MTEzZWYxODU2NTFhYTNjOGRhMTli
IHVwc3RyZWFtLg0KPiA+DQo+ID4gVGhlIHRhYmxlIGxvYWQgcHJvY2VzcyBvbWl0dGVkIGFkZGlu
ZyB0aGUgb3BlcmF0aW9uIHJlZ2lvbiBhZGRyZXNzDQo+ID4gcmFuZ2UgdG8gdGhlIGdsb2JhbCBs
aXN0LiBUaGlzIG9taXNzaW9uIGlzIHByb2JsZW1hdGljIGJlY2F1c2UgdGhlIE9TDQo+ID4gcXVl
cmllcyB0aGUgZ2xvYmFsIGxpc3QgdG8gY2hlY2sgZm9yIGFkZHJlc3MgcmFuZ2UgY29uZmxpY3Rz
IGJlZm9yZQ0KPiA+IGRlY2lkaW5nIHdoaWNoIGRyaXZlcnMgdG8gbG9hZC4gVGhpcyBjb21taXQg
bWF5IHJlc3VsdCBpbiB3YXJuaW5nDQo+ID4gbWVzc2FnZXMgdGhhdCBsb29rIGxpa2UgdGhlIGZv
bGxvd2luZzoNCj4gPg0KPiA+IFsgICAgNy44NzE3NjFdIEFDUEkgV2FybmluZzogc3lzdGVtX0lP
IHJhbmdlIDB4MDAwMDA0MjgtMHgwMDAwMDQyRg0KPiBjb25mbGljdHMgd2l0aCBvcF9yZWdpb24g
MHgwMDAwMDQwMC0weDAwMDAwNDdGIChcUE1JTykNCj4gKDIwMTgwNTMxL3V0YWRkcmVzcy0yMTMp
DQo+ID4gWyAgICA3Ljg3MTc2OV0gQUNQSTogSWYgYW4gQUNQSSBkcml2ZXIgaXMgYXZhaWxhYmxl
IGZvciB0aGlzIGRldmljZSwgeW91IHNob3VsZA0KPiB1c2UgaXQgaW5zdGVhZCBvZiB0aGUgbmF0
aXZlIGRyaXZlcg0KPiA+DQo+ID4gSG93ZXZlciwgdGhlc2UgbWVzc2FnZXMgZG8gbm90IHNpZ25p
ZnkgcmVncmVzc2lvbnMuIEl0IGlzIGEgcmVzdWx0IG9mDQo+ID4gcHJvcGVybHkgYWRkaW5nIGFk
ZHJlc3MgcmFuZ2VzIHdpdGhpbiB0aGUgZ2xvYmFsIGFkZHJlc3MgbGlzdC4NCj4gPg0KPiA+IExp
bms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjAwMDExDQo+
ID4gVGVzdGVkLWJ5OiBKZWFuLU1hcmMgTGVub2lyIDxhcmNobGludXhAamloZW1lbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogRXJpayBTY2htYXVzcyA8ZXJpay5zY2htYXVzc0BpbnRlbC5jb20+
DQo+ID4gQ2M6IEFsbCBhcHBsaWNhYmxlIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJhZmFlbCBKLiBXeXNvY2tpIDxyYWZhZWwuai53eXNvY2tpQGludGVsLmNv
bT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPg0KPiA+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2FjcGkvYWNwaWNhL2Rz
b3Bjb2RlLmMgfCAgICA0ICsrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMo
KykNCj4gPg0KPiA+IC0tLSBhL2RyaXZlcnMvYWNwaS9hY3BpY2EvZHNvcGNvZGUuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvYWNwaS9hY3BpY2EvZHNvcGNvZGUuYw0KPiA+IEBAIC00MTcsNiArNDE3LDEw
IEBAIGFjcGlfZHNfZXZhbF9yZWdpb25fb3BlcmFuZHMoc3RydWN0IGFjcGkNCj4gPiAgIAkJCSAg
QUNQSV9GT1JNQVRfVUlOVDY0KG9ial9kZXNjLT5yZWdpb24uYWRkcmVzcyksDQo+ID4gICAJCQkg
IG9ial9kZXNjLT5yZWdpb24ubGVuZ3RoKSk7DQo+ID4NCj4gPiArCXN0YXR1cyA9IGFjcGlfdXRf
YWRkX2FkZHJlc3NfcmFuZ2Uob2JqX2Rlc2MtPnJlZ2lvbi5zcGFjZV9pZCwNCj4gPiArCQkJCQkg
ICBvYmpfZGVzYy0+cmVnaW9uLmFkZHJlc3MsDQo+ID4gKwkJCQkJICAgb2JqX2Rlc2MtPnJlZ2lv
bi5sZW5ndGgsIG5vZGUpOw0KPiA+ICsNCj4gPiAgIAkvKiBOb3cgdGhlIGFkZHJlc3MgYW5kIGxl
bmd0aCBhcmUgdmFsaWQgZm9yIHRoaXMgb3ByZWdpb24gKi8NCj4gPg0KPiA+ICAgCW9ial9kZXNj
LT5yZWdpb24uZmxhZ3MgfD0gQU9QT0JKX0RBVEFfVkFMSUQ7DQo+ID4NCj4gPg0KPiA+DQoNCg==
