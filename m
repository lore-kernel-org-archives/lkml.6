Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FDFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284CD207E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbfBLPWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:22:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:47087 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbfBLPWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:22:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 07:22:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="114320895"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 12 Feb 2019 07:22:31 -0800
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 12 Feb 2019 07:22:31 -0800
Received: from lcsmsx153.ger.corp.intel.com (10.186.165.228) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 12 Feb 2019 07:22:31 -0800
Received: from hasmsx108.ger.corp.intel.com ([169.254.9.227]) by
 LCSMSX153.ger.corp.intel.com ([169.254.8.211]) with mapi id 14.03.0415.000;
 Tue, 12 Feb 2019 17:22:28 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     cgxu519 <cgxu519@gmx.com>, Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mei: expand minor range when registering chrdev region
Thread-Topic: [PATCH] mei: expand minor range when registering chrdev region
Thread-Index: AQHUwuL4UEcuv89Gu0Gd9FSK0M1FpKXcQwDg
Date:   Tue, 12 Feb 2019 15:22:27 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9DAA3809@hasmsx108.ger.corp.intel.com>
References: <20190212060252.8948-1-cgxu519@gmx.com>
 <20190212092902.GD27450@kroah.com>
 <03e93235-9fc8-dbc5-49e4-45be8e715398@gmx.com>
In-Reply-To: <03e93235-9fc8-dbc5-49e4-45be8e715398@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.126.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiAyLzEyLzE5IDU6MjkgUE0sIEdyZWcgS0ggd3JvdGU6DQo+ID4gT24gVHVlLCBG
ZWIgMTIsIDIwMTkgYXQgMDI6MDI6NTJQTSArMDgwMCwgQ2hlbmdndWFuZyBYdSB3cm90ZToNCj4g
Pj4gQWN0dWFsbHksIHRvdGFsIGFtb3VudCBvZiBhdmFpbGFibGUgbWlub3IgbnVtYmVyIGZvciBh
IHNpbmdsZSBtYWpvcg0KPiA+PiBpcyBNSU5PUk1BUksgKyAxLiBTbyBleHBhbmQgbWlub3IgcmFu
Z2Ugd2hlbiByZWdpc3RlcmluZyBjaHJkZXYNCj4gPj4gcmVnaW9uLg0KPiA+Pg0KPiA+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaGVuZ2d1YW5nIFh1IDxjZ3h1NTE5QGdteC5jb20+DQo+ID4+IC0tLQ0KPiA+
PiAgIGRyaXZlcnMvbWlzYy9tZWkvbWFpbi5jIHwgMiArLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9taXNjL21laS9tYWluLmMgYi9kcml2ZXJzL21pc2MvbWVpL21haW4uYyBpbmRleA0K
PiA+PiA4NzI4MWIzNjk1ZTYuLjNkZjU0ZjFlMWE4YiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVy
cy9taXNjL21laS9tYWluLmMNCj4gPj4gKysrIGIvZHJpdmVycy9taXNjL21laS9tYWluLmMNCj4g
Pj4gQEAgLTg2OSw3ICs4NjksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9u
cyBtZWlfZm9wcyA9IHsNCj4gPj4NCj4gPj4gICBzdGF0aWMgc3RydWN0IGNsYXNzICptZWlfY2xh
c3M7DQo+ID4+ICAgc3RhdGljIGRldl90IG1laV9kZXZ0Ow0KPiA+PiAtI2RlZmluZSBNRUlfTUFY
X0RFVlMgIE1JTk9STUFTSw0KPiA+PiArI2RlZmluZSBNRUlfTUFYX0RFVlMgIChNSU5PUk1BU0sg
KyAxKQ0KPiA+IFdoeSBpcyB0aGlzIG5lZWRlZD8gIEhhdmUgeW91IHJlYWxseSBydW4gb3V0IG9m
IHRoYXQgbWFueSBtaW5vciBub2Rlcw0KPiA+IGZvciB0aGlzIGRyaXZlcj8NCj4gDQo+IE5vdCBy
ZWFsbHksIHByYWN0aWNhbGx5IG1heWJlIHdlIGNhbm5vdCByZWFjaCB0byB0aGUgbGltaXQuDQo+
IEkgd2FzIGp1c3QgY3VyaW91cyB3aHkgb25seSBvbmUgbWlub3IgbnVtYmVyIGxlZnQgdGhlcmUg
YW5kIGFzc3VtZWQgdGhhdCB3YXMNCj4gZnJvbSBhIG1pc3Rha2Uoc2luY2UgSSd2ZSBzZWVuIHNp
bWlsYXIgbWlzdGFrZSBpbiBvdGhlciBkcml2ZXIpLg0KPiBIb3dldmVyLCBpZiBpdCBleHBsaWNp
dGx5IHNldHMgdG8gTUlOT1JNQVNLIGZvciBzb21lIHJlYXNvbnMsIHRoZW4gaXQncyBiZXR0ZXIN
Cj4gdG8ga2VlcCBhcyBpcy4NCg0KSSBndWVzcyB0aGlzIHdhcyBhIGJvaWxlcnBsYXRlIGNvZGUs
IGJ1dCBJJ20gc3VyZSB3ZSBkb24ndCBuZWVkIHNvIG1hbnkgZGV2aWNlcy4NCg0KVGhhbmtzDQpU
b21hcw0KDQoNCg==
