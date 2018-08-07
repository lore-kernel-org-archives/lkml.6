Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F853C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13802089E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13802089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeHGEkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 00:40:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:51673 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeHGEkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 00:40:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 19:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,453,1526367600"; 
   d="scan'208";a="222504519"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2018 19:28:24 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 6 Aug 2018 19:27:34 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.226]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.143]) with mapi id 14.03.0319.002;
 Tue, 7 Aug 2018 10:27:32 +0800
From:   "Zhang, Ning A" <ning.a.zhang@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Li, Ting" <ting.li@intel.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "markus@trippelsdorf.de" <markus@trippelsdorf.de>
Subject: Re: [PATCH] firmware: make sure builtin firmware is page alignment
Thread-Topic: [PATCH] firmware: make sure builtin firmware is page alignment
Thread-Index: AQHUKsvC0DwQCuNy/kuL3+VLNIom66Ss/RQAgAAzBACAAB5xgIAEJPmAgADNxQCAAM9ngA==
Date:   Tue, 7 Aug 2018 02:27:31 +0000
Message-ID: <1533608851.20683.78.camel@intel.com>
References: <20180803014521.21527-1-ning.a.zhang@intel.com>
         <20180803053948.GB1852@kroah.com> <1533285744.20683.67.camel@intel.com>
         <20180803103121.GB6557@kroah.com> <1533520123.20683.71.camel@intel.com>
         <20180806140512.GA19844@kroah.com>
In-Reply-To: <20180806140512.GA19844@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.16.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A15D6A460FD4BD48A1C392C78AAA5FC5@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMTgtMDgtMDbkuIDnmoQgMTY6MDUgKzAyMDDvvIxncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZ+WGmemBk++8mg0KPiBPbiBNb24sIEF1ZyAwNiwgMjAxOCBhdCAwMTo0ODo0NEFNICswMDAw
LCBaaGFuZywgTmluZyBBIHdyb3RlOg0KPiA+IOWcqCAyMDE4LTA4LTAz5LqU55qEIDEyOjMxICsw
MjAw77yMZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmflhpnpgZPvvJoNCj4gPiA+IE9uIEZyaSwg
QXVnIDAzLCAyMDE4IGF0IDA4OjQyOjI1QU0gKzAwMDAsIFpoYW5nLCBOaW5nIEEgd3JvdGU6DQo+
ID4gPiA+IOWcqCAyMDE4LTA4LTAz5LqU55qEIDA3OjM5ICswMjAw77yMR3JlZyBLSOWGmemBk++8
mg0KPiA+ID4gPiA+IE9uIEZyaSwgQXVnIDAzLCAyMDE4IGF0IDA5OjQ1OjIxQU0gKzA4MDAsIFpo
YW5nIE5pbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiB3aGVuIGZpcm13YXJlIGlzIGluIGZpbGVzeXN0
ZW0sIHJlcXVlc3RfZmlybXdhcmUgd2lsbCBsb2FkDQo+ID4gPiA+ID4gPiBpdCwNCj4gPiA+ID4g
PiA+IGFuZCBjb3B5IGl0IHRvIHZtYWxsb2MgbWVtb3J5LCB0aGF0IGlzIHBhZ2UgYWxpZ24gbWVt
b3J5Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBidXQgd2hlbiBmaXJtd2FyZSBpcyBidWls
dGluLCBpdCBpcyA4IGJ5dGVzIG9yIDQgYnl0ZXMNCj4gPiA+ID4gPiA+IGFsaWdubWVudC4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gbWFrZSBzdXJlIGJ1aWx0aW4gZmlybXdhcmUgaXMgcGFn
ZSBhbGdubWVudCwgdGhhdCBjYW4NCj4gPiA+ID4gPiA+IHNpbXBsaWZ5DQo+ID4gPiA+ID4gPiBh
bGdvcml0aG0NCj4gPiA+ID4gPiA+IHRvIGhhbmRsZSBmaXJtd2FyZS4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBIb3cgaXMgaXQgc2ltcGxpZmllZD/CoMKgSSBkb24ndCBzZWUgYW55IHN1Y2ggY2hh
bmdlIGxpa2UgdGhhdA0KPiA+ID4gPiA+IGhlcmUNCj4gPiA+ID4gPiA6KA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiANCj4gPiA+ID4gVGhhbmsgeW91IGZvciByZXZpZXcgdGhpcyBwYXRjaC4NCj4gPiA+
ID4gDQo+ID4gPiA+IFdoZW4gZHJpdmVyIGhhbmRsZXMgaXRzIGZpcm13YXJlIGJhc2VkIG9uwqDC
oHBhZ2UsIGxpa2UgYmVsb3c6DQo+ID4gPiA+IA0KPiA+ID4gPiAJc3RydWN0IHBhZ2UgKnA7DQo+
ID4gPiA+IAlwID0gdm1hbGxvY190b19wYWdlKGZ3LT5kYXRhKTvCoMKgLy8gZm9yIGZpbGVzeXN0
ZW0NCj4gPiA+ID4gZmlybXdhcmUNCj4gPiA+ID4gCXAgPSB2aXJ0X3RvX3BhZ2UoZnctPmRhdGEp
OyAvLyBmb3IgYnVpbHRpbiBmaXJtd2FyZQ0KPiA+ID4gPiANCj4gPiA+ID4gYnV0IGlmIGJ1aWx0
aW4gZmlybXdhcmUgaXMgbm90IHBhZ2UgYWxpZ25tZW50LCBwYWdlIHBvaW50ZXIgZm9yDQo+ID4g
PiA+IGJ1aWx0aW4NCj4gPiA+ID4gZmlybXdhcmUgaXMgd3JvbmcsIGl0IGNvbnRhaW5zIG1lbW9y
eSBub3QgYmVsb25nIHRvIGZpcm13YXJlLg0KPiA+ID4gPiBkcml2ZXJzDQo+ID4gPiA+IGhhcyB0
byB1c2UgYWRkaXRpb25hbCBjb2RlIHRvIGhhbmRsZSB0aGlzLsKgDQo+ID4gPiA+IA0KPiA+ID4g
PiBpZiBidWlsdGluIGZpcm13YXJlIGlzIGFsc28gcGFnZSBhbGlnbm1lbnQsIG5vIG5lZWQgYWRk
aXRpb25hbA0KPiA+ID4gPiBjb2RlDQo+ID4gPiA+IHRvDQo+ID4gPiA+IGhhbmRsZSBidWlsdGlu
IGZpcm13YXJlLiBzaW1wbGlmaWVkLg0KPiA+ID4gDQo+ID4gPiBCdXQgeW91IGRpZCBub3QgY2hh
bmdlIGFueXRoaW5nIGxpa2UgdGhpcyBpbiB5b3VyIGNvZGUsIHNvIHdoeQ0KPiA+ID4gd291bGQN
Cj4gPiA+IEkNCj4gPiA+IGtub3cgdGhpcz8NCj4gPiANCj4gPiBJIHVuZGVyc3RhbmQgaXQgaXMg
dmVyeSBkaWZmaWN1bHQgdG8gcmV2aWV3IHRoaXMgcGF0Y2ggd2l0aG91dA0KPiA+IGNvbnRleHQu
DQo+ID4gVGhlIGRyaXZlciBpcyBub3Qgb3BlbnNvdXJjZSwgSSBjYW4ndCBzaG93IHRoZSBwYXRj
aCBmb3IgZHJpdmVyLg0KPiANCj4gVGhlbiBJIGNhbiBub3QgYWNjZXB0IHlvdXIgcGF0Y2guwqDC
oEdvIHRhbGsgdG8geW91ciBjb3Jwb3JhdGUgbGF3eWVycw0KPiBhYm91dCBjaGFuZ2luZyBjb3Jl
IGtlcm5lbCBjb2RlIGZvciBhIGNsb3NlZCBzb3VyY2UgZHJpdmVyIGFuZCB3aGF0DQo+IHRoYXQN
Cj4gaW1wbGllcyBhYm91dCB0aGF0IGNsb3NlZCBkcml2ZXIgKGhpbnQsIHlvdXIgZHJpdmVyIGNh
biBub3QgYmUNCj4gY2xvc2VkLi4uKSA6KQ0KDQpJdCdzIHZlcnkgc2FkLCBidXQgYW55d2F5LCB0
aGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3Lg0KeW91ciByZXZpZXcgd2lsbCBkZWZpbml0ZWx5IGhl
bHAgdXMgaW1wcm92ZSBvdXIgd29yay4NCg0KQlIuDQpOaW5nLg0KDQo+IA0KPiBUaGVuIGNvbWUg
YmFjayB3aXRoIGEgcHJvcGVyIG9wZW4gc291cmNlZCBkcml2ZXIsIHRoYXQncyB0aGUgb25seSB3
YXkNCj4gTGludXggZHJpdmVycyBjYW4gYmUgd3JpdHRlbiBzb3JyeS4NCj4gDQo+IGJlc3Qgb2Yg
bHVjaywNCj4gDQo+IGdyZWcgay1oDQo+IA==
