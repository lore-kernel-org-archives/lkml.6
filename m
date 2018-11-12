Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B294E224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B294E224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeKMGHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:07:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:50273 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbeKMGHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:07:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 12:12:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,496,1534834800"; 
   d="scan'208";a="107480643"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga001.fm.intel.com with ESMTP; 12 Nov 2018 12:12:57 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 12 Nov 2018 12:12:57 -0800
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.166]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.42]) with mapi id 14.03.0415.000;
 Mon, 12 Nov 2018 12:12:57 -0800
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
Thread-Index: AQHUeg2skAoKAiPRukOIXOKhcDUPNaVM/bWA//+BOQCAAJKggP//flWQ
Date:   Mon, 12 Nov 2018 20:12:55 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53BB9FBAD@ORSMSX110.amr.corp.intel.com>
References: <20181111221619.915519183@linuxfoundation.org>
 <20181111221623.163909820@linuxfoundation.org>
 <9da1c8e8-d237-11b3-8918-859a4bbdbcc4@applied-asynchrony.com>
 <CF6A88132359CE47947DB4C6E1709ED53BB9FB49@ORSMSX110.amr.corp.intel.com>
 <341e972a-d941-f44e-73b9-926ac6cf0ccf@applied-asynchrony.com>
In-Reply-To: <341e972a-d941-f44e-73b9-926ac6cf0ccf@applied-asynchrony.com>
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
eSwgTm92ZW1iZXIgMTIsIDIwMTggMTE6NDIgQU0NCj4gVG86IFNjaG1hdXNzLCBFcmlrIDxlcmlr
LnNjaG1hdXNzQGludGVsLmNvbT47IEdyZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBzdGFi
bGVAdmdlci5rZXJuZWwub3JnOyBKZWFuLU1hcmMgTGVub2lyIDxhcmNobGludXhAamloZW1lbC5j
b20+Ow0KPiBXeXNvY2tpLCBSYWZhZWwgSiA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC4xOSAwMjUvMzYxXSBBQ1BJQ0E6IEFNTCBpbnRlcnByZXRl
cjogYWRkIHJlZ2lvbg0KPiBhZGRyZXNzZXMgaW4gZ2xvYmFsIGxpc3QgZHVyaW5nIGluaXRpYWxp
emF0aW9uDQo+IA0KPiBIZWxsbyBFcmlrLA0KPiANCj4gdGhhbmtzIGZvciByZXNwb25kaW5nLg0K
PiANCj4gT24gMTEvMTIvMTggODowMSBQTSwgU2NobWF1c3MsIEVyaWsgd3JvdGU6DQo+ID4+IEFz
IHByb2JhYmx5IGV4cGVjdGVkIHRoaXMgcGF0Y2ggY2F1c2VzIHByb2JsZW1zLiBJbiBteSBjYXNl
IG9uZQ0KPiA+PiBzZXJ2ZXIgY2FuIG5vIGxvbmdlciBsb2FkIHRoZSBuY3Q2Nzc1IGh3bW9uIG1v
ZHVsZSwgd2hpY2ggbWVhbnMgdGhlDQo+ID4+IGZhbiBjYW5ub3QgYmUgbW9uaXRvcmVkLCBhbmQg
dGhlcmVmb3JlIG15IG1vbml0b3Jpbmcgc3lzdGVtIHByb21wdGx5DQo+ID4+IHN0YXJ0cyBzcGFt
bWluZyBtZSB3aXRoIGFsZXJ0cyB0aGF0IG15IGZhbiBoYXMgZmFpbGVkIC0gd2hpY2ggaXMgb2Yg
Y291cnNlDQo+IG5vdCB0cnVlLg0KPiA+Pg0KPiA+PiAtLXNuaXAtLQ0KPiA+PiBOb3YgMTIgMTg6
MDg6NTYgdHV4IGtlcm5lbDogbmN0Njc3NTogRm91bmQgTkNUNjc3NkQvRiBvciBjb21wYXRpYmxl
DQo+ID4+IGNoaXAgYXQNCj4gPj4gMHgyZToweDI5MCBOb3YgMTIgMTg6MDg6NTYgdHV4IGtlcm5l
bDogQUNQSSBXYXJuaW5nOiBTeXN0ZW1JTyByYW5nZQ0KPiA+PiAweDAwMDAwMDAwMDAwMDAyOTUt
MHgwMDAwMDAwMDAwMDAwMjk2IGNvbmZsaWN0cyB3aXRoIE9wUmVnaW9uDQo+ID4+IDB4MDAwMDAw
MDAwMDAwMDI5MC0weCBOb3YgMTIgMTg6MDg6NTYgdHV4IGtlcm5lbDogQUNQSTogSWYgYW4gQUNQ
SQ0KPiA+PiBkcml2ZXIgaXMgYXZhaWxhYmxlIGZvciB0aGlzIGRldmljZSwgeW91IHNob3VsZCB1
c2UgaXQgaW5zdGVhZCBvZiB0aGUNCj4gPj4gbmF0aXZlIGRyaXZlcg0KPiA+PiAtLXNuaXAtLQ0K
PiA+Pg0KPiA+PiBUaGlzIGlzIGNlcnRhaW5seSBjYXVzZWQgYnkgbXkgb2xkIEJJT1MgYW5kIGl0
cyBicm9rZW4gQUNQSQ0KPiA+PiBpbXBsZW1lbnRhdGlvbiwgaG93ZXZlciBzaW5jZSBpdCdzIHdv
cmtpbmcgcGVyZmVjdGx5IGZpbmUgb3RoZXJ3aXNlIEkNCj4gPj4gc2VlIG5vIHJlYXNvbiB0byBy
ZXBsYWNlIGl0LiBUaGF0IGJlaW5nIHNhaWQsIEkgbXVzdCBiZSBhYmxlIHRvDQo+ID4+IG1vbml0
b3IgbXkgZmFuLCBzbyBmb3Igbm93IHJldmVydGluZyB0aGUgcGF0Y2ggaW1tZWRpYXRlbHkgImZp
eGVkIg0KPiA+PiB0aGUgcHJvYmxlbSBmb3IgbWUgLSB0aGUgZmFuIGVudHJpZXMgYXBwZWFyZWQg
aW4gc3lzZnMgYWdhaW4gYWZ0ZXINCj4gc3VjY2Vzc2Z1bGx5IGxvYWRpbmcgdGhlIG1vZHVsZS4N
Cj4gPj4NCj4gPj4gSWRlYSwgd29ya2Fyb3VuZHMgb3IgcGF0Y2hlcyB3ZWxjb21lLg0KPiA+DQo+
ID4gSXMgdGhlcmUgYSBmaXJtd2FyZSB1cGRhdGUgYXZhaWxhYmxlIGZvciB0aGlzIG1hY2hpbmU/
IElmIHNvLCB5b3UgbWF5DQo+ID4gd2FudCB0byBkbyBhIGZpcm13YXJlIHVwZGF0ZS4NCj4gDQo+
IFRoZSBtb3RoZXJib2FyZCBpcyBmcm9tIDIwMTEgYW5kIEkgYWxyZWFkeSBpbnN0YWxsZWQgdGhl
IGxhc3QgYXZhaWxhYmxlIEJJT1MNCj4gZnJvbSAyMDEzIGEgZmV3IHllYXJzIGFnby4gVGhhdCBm
aXhlZCBleGFjdGx5IG5vdGhpbmcuIDopIFRoaXMgd2FzIG15IGxhc3QNCj4gbW90aGVyYm9hcmQg
ZnJvbSBBc3VzIGV2ZXIsIGJ1dCBhbGFzLCBpdCdzIHN0aWxsIGhlcmUgYW5kIG90aGVyd2lzZSB3
b3JraW5nLA0KPiBzby4uDQo+IA0KPiA+IEFsc28sIHdoYXQgaXMgdGhlIGJlaGF2aW9yIGluIGtl
cm5lbHMgNC4xNiBvciBvbGRlcj8NCj4gDQoNCkhpLA0KPiBFdmVyeXRoaW5nIGp1c3Qgd29ya2Vk
IC0geWVzLCB3aXRoIEFDUEkgc3BldywgYnV0Li4gwq9cKOODhCkvwq8NCj4gSSB1bmRlcnN0YW5k
IHRoYXQgdGhlIHBhdGNoIG1pZ2h0IHdlbGwgYmUgInRlY2huaWNhbGx5IGNvcnJlY3QiIGFuZCBP
SyBmb3INCj4gbWFpbmxpbmUvY3VycmVudCBoYXJkd2FyZSBhbmQgd2lsbCB0cnkgcGxheWluZyB3
aXRoIGFjcGk9Li4ga2VybmVsIGZsYWdzLg0KDQpJdCdzIHN0cmFuZ2UgaG93IHRoZSBkcml2ZXIg
d291bGQgbG9hZCBpbiA0LjE2IGFuZCBmYWlsIHRvIGxvYWQgd2l0aCB0aGlzIHBhdGNoLg0KSSB3
b3VsZCBsaWtlIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSBkcml2ZXIgbG9hZCBiZWhhdmlvciBpcyBu
b3QgYmVpbmcgY2hhbmdlZA0KZnJvbSA0LjE2IG9yIGVhcmxpZXIuDQoNCkNvdWxkIHlvdSBzZW5k
IGEgd29ya2luZyBkbWVzZyBmcm9tIDQuMTYgKG9yIGVhcmxpZXIpIGFuZCBhIGZhaWxpbmcgZG1l
c2cgd2l0aA0KdGhpcyBzdGFibGUgYnJhbmNoIHVzaW5nIHRoZSBzYW1lIGtlcm5lbCBjb21tYW5k
IGxpbmUgcGFyYW1ldGVycyBmb3IgYm90aD8NCg0KSSBkb24ndCBuZWVkIHRvbyBtdWNoIG9mIHRo
ZSBzcGV3IGlmIGl0IGxvb2tzIHRoZSBzYW1lLiBJJ20gbW9yZSBpbnRlcmVzdGVkIGluDQp0aGUg
aW5pdGlhbGl6YXRpb25zIGFuZCB0aGUgd2FybmluZyBtZXNzYWdlLg0KDQpFcmlrDQoNCj4gDQo+
IHRoYW5rcywNCj4gSG9sZ2VyDQo=
