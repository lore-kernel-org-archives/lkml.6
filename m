Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B23C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F3020837
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 03:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F3020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeKHMet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:34:49 -0500
Received: from mail4.tencent.com ([183.57.53.109]:41091 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728349AbeKHMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:34:49 -0500
Received: from EXHUB-SZMail03.tencent.com (unknown [10.14.6.33])
        by mail4.tencent.com (Postfix) with ESMTP id 64F3A50B4E;
        Thu,  8 Nov 2018 11:01:17 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail03.tencent.com ([::1]) with mapi id 14.03.0415.000; Thu, 8 Nov
 2018 11:01:16 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
Subject: RE: [PATCH V2] binder: ipc namespace support for android binder
Thread-Topic: [PATCH V2] binder: ipc namespace support for android binder
Thread-Index: AdR3D01oz5WISVmGRtWGMtGzvv7LkA==
Date:   Thu, 8 Nov 2018 03:01:15 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F8406F@EXMBX-SZMAIL022.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.208.62]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcgTW9ydG9uIDxha3Bt
QGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgOCwgMjAx
OCA2OjM4IEFNDQo+IFRvOiBjaG91cnl6aG91KOWRqOWogSkgPGNob3VyeXpob3VAdGVuY2VudC5j
b20+DQo+IENjOiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgYXJ2ZUBhbmRyb2lkLmNvbTsg
dGtqb3NAYW5kcm9pZC5jb207DQo+IGRhdmVAc3Rnb2xhYnMubmV0OyBkZXZlbEBkcml2ZXJkZXYu
b3N1b3NsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIFYyXSBiaW5kZXI6IGlwYyBuYW1lc3BhY2Ugc3VwcG9ydCBmb3IgYW5kcm9pZA0KPiBi
aW5kZXINCj4gDQo+IE9uIFdlZCwgNyBOb3YgMjAxOCAwMTo0ODoxMiArMDAwMCBjaG91cnl6aG91
KOWRqOWogSkNCj4gPGNob3VyeXpob3VAdGVuY2VudC5jb20+IHdyb3RlOg0KPiANCj4gPiA+ID4g
LS0tIGEvaXBjL25hbWVzcGFjZS5jDQo+ID4gPiA+ICsrKyBiL2lwYy9uYW1lc3BhY2UuYw0KPiA+
ID4gPiBAQCAtNTYsNiArNTYsOSBAQCBzdGF0aWMgc3RydWN0IGlwY19uYW1lc3BhY2UgKmNyZWF0
ZV9pcGNfbnMoc3RydWN0DQo+ID4gPiB1c2VyX25hbWVzcGFjZSAqdXNlcl9ucywNCj4gPiA+ID4g
ICAgICAgICBucy0+dWNvdW50cyA9IHVjb3VudHM7DQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAg
ZXJyID0gbXFfaW5pdF9ucyhucyk7DQo+ID4gPiA+ICsgICAgICAgaWYgKGVycikNCj4gPiA+ID4g
KyAgICAgICAgICAgICAgIGdvdG8gZmFpbF9wdXQ7DQo+ID4gPiA+ICsgICAgICAgZXJyID0gYmlu
ZGVyX2luaXRfbnMobnMpOw0KPiA+ID4gPiAgICAgICAgIGlmIChlcnIpDQo+ID4gPiA+ICAgICAg
ICAgICAgICAgICBnb3RvIGZhaWxfcHV0Ow0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IERvbid0IHdl
IG5lZWQgYW4gbXFfcHV0X21udCgpIGlmIGJpbmRlcl9pbml0X25zKCkgZmFpbHM/DQo+ID4gPg0K
PiA+ID4gZnJlZV9pcGNfbnMoKSBzZWVtcyB0byBoYXZlIGZvcmdvdHRlbiBhYm91dCB0aGF0IHRv
by4gIEluIHdoaWNoIGNhc2UgaXQNCj4gPiA+IG11c3QgYmUgbWFkbHkgbGVha2luZyBtb3VudHMg
c28gcHJvYmFibHkgSSdtIHdyb25nLiAgQ29uZnVzZWQuDQo+ID4gPg0KPiA+DQo+ID4gbXFfaW5p
dF9ucyB3aWxsIGRvIGNsZWFuIGpvYiBpZiBpdCBmYWlsZWQsIGFuZCBhcyBkbyBiaW5kZXJfaW5p
dF9ucy4NCj4gDQo+IE15IHBvaW50IGlzIHRoYXQgaWYgbXFfaW5pdF9ucygpIHN1Y2NlZWRzIGFu
ZCBiaW5kZXJfaW5pdF9ucygpIGZhaWxzLA0KPiB3ZSBkb24ndCB1bmRvIHRoZSBlZmZlY3RzIG9m
IG1xX2luaXRfbnMoKT8NCg0KT2gsIG1xX3B1dF9tbnQgaXMgY2FsbGVkIGluIHB1dF9pcGNfbnMu
IFdlIHNob3VsZCBpbnZva2UgcHV0X2lwY19ucyBpZiBiaW5kZXJfaW5pdF9ucyBmYWlscy4gSSB3
aWxsIHVwZGF0ZSB0aGUgcGF0Y2ggc29vbi4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgcG9pbnRp
bmcgb3V0IHRoZSBpc3N1ZS4NCg==
