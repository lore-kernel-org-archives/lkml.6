Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96596C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A6021019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bmw.de header.i=@bmw.de header.b="YagG7q0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfAWJcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:32:24 -0500
Received: from esa10.bmw.c3s2.iphmx.com ([68.232.139.98]:22640 "EHLO
        esa10.bmw.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfAWJcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:32:24 -0500
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 04:32:23 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1548235943; x=1579771943;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ve80A8e2A5LkypWTBG8cSwRkGtMplMUhyXWZk8GF8jY=;
  b=YagG7q0A3kE69gpmNQURMRg45Y8yaTfFUQNUQCTEJOta3AFz3PUF+CUJ
   2MMlcQr1qXpP/KVAX6ng+FKOdszjIomZkTTYVTD8kbEfCo7+hVMWGB4qS
   DcTUwjvnj6NshtQHNFoevrAjHq87XHruhKplMeHBmcxwqi195YODN6EdD
   I=;
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
 esa10.bmw.c3s2.iphmx.com with ESMTP/TLS; 23 Jan 2019 10:22:10 +0100
Received: from esabb4.muc ([160.50.100.33])  by esagw1.muc with ESMTP/TLS;
 23 Jan 2019 10:22:10 +0100
Received: from smucm10j.bmwgroup.net (HELO smucm10j.europe.bmw.corp) ([160.48.96.46])
 by esabb4.muc with ESMTP/TLS; 23 Jan 2019 10:22:10 +0100
Received: from smucm10m.europe.bmw.corp (160.48.96.49) by smucm10j.europe.bmw.corp
 (160.48.96.46) with Microsoft SMTP Server (TLS;
 Wed, 23 Jan 2019 10:22:09 +0100
Received: from smucm10m.europe.bmw.corp ([160.48.96.49]) by
 smucm10m.europe.bmw.corp ([160.48.96.49]) with mapi id 15.00.1395.000; Wed,
 23 Jan 2019 10:22:09 +0100
From:   <Viktor.Rosendahl@bmw.de>
To:     <joel@joelfernandes.org>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] preemptirq_delay_test: Add the burst feature and a
 sysfs trigger
Thread-Topic: [PATCH 2/4] preemptirq_delay_test: Add the burst feature and a
 sysfs trigger
Thread-Index: AQHUsYXNcK9cjUUxdkmzjGk8G6n9LKW7xeyAgADAf4A=
Date:   Wed, 23 Jan 2019 09:22:09 +0000
Message-ID: <6b0bf71d9c4cf1f16f70d0aeb18a3b3448010025.camel@bmw.de>
References: <1548074113-16599-1-git-send-email-Viktor.Rosendahl@bmw.de>
         <1548074113-16599-3-git-send-email-Viktor.Rosendahl@bmw.de>
         <20190122215311.GA200493@google.com>
In-Reply-To: <20190122215311.GA200493@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.221.38]
Content-Type: text/plain; charset="utf-8"
Content-ID: <018EB073A504E04A9484D6B9B74FF54E@bmwmail.corp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9lbCwNCg0KT24gVHVlLCAyMDE5LTAxLTIyIGF0IDE2OjUzIC0wNTAwLCBKb2VsIEZlcm5h
bmRlcyB3cm90ZToNCj4gQ291bGQgeW91IENDIG1lIG9uIHRoZSBvdGhlciBwYXRjaGVzIGFzIHdl
bGwsIG5leHQgdGltZT8gSSBhbSBxdWl0ZQ0KPiBpbnRlcmVzdGVkIGFuZCByZWNlbnRseSBoYXZl
IHdvcmtlZCBvbiB0aGUgbGF0ZW5jeSB0cmFjZXIuDQo+IA0KDQpTdXJlLCBJIHdpbGwuDQoNCj4g
DQo+ID4gK01PRFVMRV9QQVJNX0RFU0MoYnVyc3Rfc2l6ZSwgIlRoZSBzaXplIG9mIGEgYnVyc3Qg
KGRlZmF1bHQgMSkiKTsNCj4gDQo+IFdoZXJlIGFyZSB3ZSBib3VuZHMgY2hlY2tpbmcgdGhlIGJ1
cnN0X3NpemUgaGVyZT8gSXQgc2VlbXMgbGlrZSBhIGhpZ2gNCj4gYnVyc3Rfc2l6ZSBjYW4gb3Zl
cmZsb3cgeW91ciBhcnJheSBvZiBmdW5jdGlvbnMuDQo+IA0KDQpJIGRvbid0IHRoaW5rIHNvLiBJ
IHVzZSAiaSAlIE5SX1RFU1RfRlVOQ1MiIGFzIGluZGV4IHdoZW4gSSBjYWxsIGZ1bmN0aW9ucyBp
bg0KdGhlIGFycmF5LiANCg0KQmFzaWNhbGx5LCBpZiB0aGUgdXNlciBzcGVjaWZpZXMgYSBidXJz
dCBzaXplIGxhcmdlciB0aGFuIDEwLCB0aGVuIHdlIHdpbGwgYmVnaW4NCnRvIHJldXNlIHRoZSB0
ZXN0IGZ1bmN0aW9ucy4gDQoNCj4gPiANCj4gPiArREVDTEFSRV9URVNURk4oOSkNCj4gDQo+IFlv
dSByZWFsbHkgb25seSBuZWVkIDIgZnVuY3Rpb25zIGhlcmUsIHNpbmNlIHRoZSBvZGQgYW5kIGV2
ZW4gc3VmZml4ZWQNCj4gZnVuY3Rpb25zIGFyZSBpZGVudGljYWwuDQo+IA0KDQpUaGlzIHdvdWxk
IGluZGVlZCBtYWtlIHRoZSBjb2RlIG1vcmUgbmVhdCBhbmQgY29tcGFjdC4NCg0KSG93ZXZlciwg
aXQgd291bGQgbm8gbG9uZ2VyIGJlIGEgZ29vZCB0ZXN0IGZvciB0aGUgbGF0ZW5jeS1jb2xsZWN0
b3IsIHdoaWNoIEkNCnBvc3RlZCBoZXJlOg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMTkvMS8y
MS81NzINCg0KSWYgd2Ugd2FudCB0byB0ZXN0IHRoZSBsYXRlbmN5LWNvbGxlY3RvciBwcm9wZXJs
eSwgd2UgbmVlZCBiYWNrdHJhY2VzIHRoYXQgbG9vaw0KZGlmZmVyZW50IGZyb20gZWFjaCBvdGhl
ciwgb3RoZXJ3aXNlLCB0aGVyZSBpcyBubyB3YXkgb2Yga25vd2luZyB3aGV0aGVyIHRoZQ0KbGF0
ZW5jeS1jb2xsZWN0b3IgY2FwdHVyZWQgdGhlIGZpcnN0IGxhdGVuY3ksIHRoZSBsYXN0IGxhdGVu
Y3kgb3Igb25lIHNvbWV3aGVyZQ0KaW4gdGhlIG1pZGRsZS4NCg0KV2l0aCBteSBjb2RlIHdlIHNl
ZSBiYWNrdHJhY2VzIGxpa2UgdGhpczoNCg0KID0+IHByZWVtcHRpcnF0ZXN0XzQNCiA9PiBwcmVl
bXB0aXJxX2RlbGF5X3J1bg0KID0+IGt0aHJlYWQNCiA9PiByZXRfZnJvbV9mb3JrDQoNClRoaXMg
dGVsbHMgdXMgdGhhdCB0aGUgbGF0ZW5jeS1jb2xsZWN0b3IgY2FwdHVyZWQgdGhlIDV0aCBsYXRl
bmN5IGluIGEgYnVyc3QuIEkNCndhbnQgdG8gYmUgYWJsZSB0byBzZWUgdGhhdCwgeWVzIHRoZSBs
YXRlbmN5LWNvbGxlY3RvciBjYW4gZmlzaCBvdXQgdGhlIDV0aA0KbGF0ZW5jeSBpbiBhIGJ1cnN0
IG9mIDEwLg0KDQpIYXZpbmcgMTAgdGVzdGZ1bmN0aW9ucyBhbmQgdGhlbiByZXVzaW5nIHRoZW0g
d2l0aCB0aGUgbW9kdWxvIGdhbWUgaXMgYW4gYXR0ZW1wdA0KYXQgYSBjb21wcm9taXNlIGJldHdl
ZW4gaGF2aW5nIGFuIGluaWZpbnRlIG51bWJlciBvZiB0ZXN0ZnVuY3Rpb25zIGFuZCBjb21wYWN0
DQpjb2RlLiBBbiBhbHRlcm5hdGl2ZSB3b3VsZCBiZSB0byBjaGVjayB0aGF0IHRoZSBidXJzdF9z
aXplIHBhcmFtZXRlciBpcyBub3QNCmdyZWF0ZXIgdGhhbiB0aGUgbnVtYmVyIG9mIGZ1bmN0aW9u
cy4NCg0KPiA+IA0KPiANCj4gSSBob25lc3RseSBmZWVsIGEgc3lzZnMgdHJpZ2dlciBmaWxlIGlz
IHBvaW50bGVzcy4gV2h5IGNhbid0IHRoZSBtb2R1bGUgYmUNCj4gcmVsb2FkZWQ/IA0KDQpJdCBp
cyBqdXN0IGEgY29udmVuZW5pbmNlIGZvciBsYXp5IHBlb3BsZSB3aG8gbWFudWFsbHkgd2FudCB0
byByZXBlYXQgdGhlIHNhbWUNCnRlc3Qgd2l0aG91dCBoYXZpbmcgdG8gd3JpdGUgYSBzaGVsbCBz
Y3JpcHQgd2l0aCBtb2Rwcm9iZSAmIHJtbW9kLiBPciBwZXJoYXBzDQpmb3IgdGhvc2Ugd2hvIGFy
ZSB3b3JyaWVkIGFib3V0IHNwZW5kaW5nIENQVSBjeWNsZXMgb24gbW9kdWxlIGxvYWRpbmcgOikN
Cg0KPiBOb3RlIGFsc28gdGhhdCBtb2R1bGUgcGFyYW1ldGVycyBjYW4gYmUgY2hhbmdlZCBhZnRl
ciB0aGUgbW9kdWxlDQo+IGhhcyBiZWVuIGxvYWRlZC4gUGVyaGFwcyB0aGF0IGNhbiBiZSB1c2Vk
IGFzIGEgdHJpZ2dlcj8NCg0KSSB3YXMgbm90IGF3YXJlIG9mIHRoaXMgcG9zc2liaWxpdHkuIEkg
Y2FuIHRyeSB0byBtYWtlIGl0IHNvIGlmIGl0J3MgZGVzaXJlZC4NCg0KPiAgU28gaWYgdGhlIHRl
c3RfbW9kZQ0KPiBpcyBjaGFuZ2VkLCB0aGVuIHRoZSB0ZXN0IGlzIHJlLXJ1bi4NCj4gDQo+IEhv
d2V2ZXIsIGlmIFN0ZXZlIHByZWZlcnMgdGhlIHN5c2ZzIHRyaWdnZXIgZmlsZSwgdGhlbiBJIGFt
IE9rIHdpdGggdGhhdC4NCj4gDQo+IA0KDQpJIHdvdWxkIHN0aWxsIHByZWZlciB0byBrZWVwIHRo
ZSBzeXNmcyB0cmlnZ2VyIGJ1dCBJIGRvbid0IGluc2lzdCBvbiBpdC4NCg0KV2hlbiB0ZXN0aW5n
IHRoZSBsYXRlbmN5LWNvbGxlY3RvciBpdCdzIG9mdGVuIGRlc2lyZWQgdG8gcmVwZWF0IHRoZSBl
eGFjdCBzYW1lDQp0ZXN0IG1hbnkgdGltZXMuDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0K
DQpiZXN0IHJlZ2FyZHMsDQoNClZpa3Rvcg0KDQo=
