Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF27C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C0221736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfAGMgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:36:33 -0500
Received: from asrmicro.com ([210.13.118.86]:19113 "EHLO spam.asrmicro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726718AbfAGMgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:36:31 -0500
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123])
        by spam.asrmicro.com with ESMTP id x07CZptJ086790;
        Mon, 7 Jan 2019 20:35:51 +0800 (GMT-8)
        (envelope-from yizeng@asrmicro.com)
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 7 Jan
 2019 20:36:16 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Mon, 7 Jan 2019 20:36:16 +0800
From:   =?gb2312?B?WmVuZyBZaaOo1PjS46Op?= <yizeng@asrmicro.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] i2c: dev: prevent adapter retries being set as minus
 value
Thread-Topic: [PATCH] i2c: dev: prevent adapter retries being set as minus
 value
Thread-Index: AQHUmRAMoMHPCO+TGkKV7ehFCTsiI6WdfTkAgAZYtQA=
Date:   Mon, 7 Jan 2019 12:36:15 +0000
Message-ID: <764917762fa14ac497bdfa9ea3737489@mail2012.asrmicro.com>
References: <1545384726-12463-1-git-send-email-yizeng@asrmicro.com>
 <20190103193006.2ekn4ugibm73nfcy@ninjato>
In-Reply-To: <20190103193006.2ekn4ugibm73nfcy@ninjato>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.166.151]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: spam.asrmicro.com x07CZptJ086790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV29sZnJhbSBTYW5nLA0KDQpUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHJldmlldyBh
bmQga2luZGx5IHN1Z2dlc3Rpb25zLCB3b3VsZCB5b3UgcGxlYXNlIHNlZSBteSBjb21tZW50cyBi
ZWxvdzoNCg0KQmVzdCBSZWdhcmRzLA0KWWkgWmVuZw0KKzg2LTIxLTYwMzM2NTg4IGV4dC4gODY4
Ng0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXb2xmcmFtIFNhbmcgW21h
aWx0bzp3c2FAdGhlLWRyZWFtcy5kZV0gDQpTZW50OiBGcmlkYXksIEphbnVhcnkgMDQsIDIwMTkg
MzozMCBBTQ0KVG86IFplbmcgWWmjqNT40uOjqQ0KQ2M6IGxpbnV4LWkyY0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGky
YzogZGV2OiBwcmV2ZW50IGFkYXB0ZXIgcmV0cmllcyBiZWluZyBzZXQgYXMgbWludXMgdmFsdWUN
Cg0KSGkgWWkgWmVuZywNCg0KT24gRnJpLCBEZWMgMjEsIDIwMTggYXQgMDU6MzI6MDZQTSArMDgw
MCwgWWkgWmVuZyB3cm90ZToNCj4gSWYgc2V0IGFkYXB0ZXItPnJldHJpZXMgdG8gbWludXMgdmFs
dWUgZnJvbSB1c2VyIHNwYWNlIHZpYSBpb2N0bCwgd2lsbCANCj4gbWFrZSBfX2kyY190cmFuc2Zl
ciBhbmQgX19pMmNfc21idXNfeGZlciBqdW1wIHRoZSBjYWxsaW5nIHRvDQo+IGFkYXB0ZXItPmFs
Z28tPm1hc3Rlcl94ZmVyIGFuZCBhZGFwdGVyLT5hbGdvLT5zbWJ1c194ZmVyIHRoYXQNCj4gcmVn
aXN0ZXJlZCBieSB0aGUgdW5kZXJseWluZyBidXMgZHJpdmVycywgYW5kIHJldHVybiB2YWx1ZSAw
IHRvIGFsbCANCj4gdGhlIGNhbGxlcnMuIFRoZSBidXMgZHJpdmVyIHdpbGwgbmV2ZXIgYmUgYWNj
ZXNzZWQgYW55bW9yZSBieSBhbGwgDQo+IHVzZXJzLCBiZXNpZGVzLCB0aGUgdXNlcnMgbWF5IHN0
aWxsIGdldCBzdWNjZXNzZnVsIHJldHVybiB2YWx1ZSB3aXRoIA0KPiBubyBhbnkgZXJyb3Igb3Ig
aW5mb3JtYXRpb24gbG9nIHByaW50IG91dC4NCg0KPj4gVGhhbmtzISBUaGUgaXNzdWUgeW91IG9i
c2VydmVkIGlzIGNvcnJlY3QuIEl0IGFsc28gYXBwbGllcyB0byBJMkNfVElNRU9VVC4gV291bGQg
eW91IG1pbmQgZml4aW5nIGl0IHRoZXJlIGFzIHdlbGw/DQpZZXMsIEkgYW0gdmVyeSBnbGFkIHRv
IGRvIHRoaXMgZml4LiBJIHdpbGwgYWRkIHRoZSBjaGFuZ2VzIHRvIHRoZSBwcmV2aW91cyBwYXRj
aC4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBZaSBaZW5nIDx5aXplbmdAYXNybWljcm8uY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvaTJjL2kyYy1kZXYuYyB8IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2kyYy9pMmMt
ZGV2LmMgYi9kcml2ZXJzL2kyYy9pMmMtZGV2LmMgaW5kZXggDQo+IDFhY2E3NDIuLmMzNDlmNTgg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaTJjL2kyYy1kZXYuYw0KPiArKysgYi9kcml2ZXJzL2ky
Yy9pMmMtZGV2LmMNCj4gQEAgLTQ3MCw2ICs0NzAsMTQgQEAgc3RhdGljIGxvbmcgaTJjZGV2X2lv
Y3RsKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLCB1bnNpZ25lZCBsb25nIGFy
ZykNCj4gIAkJCQkJICBkYXRhX2FyZy5kYXRhKTsNCj4gIAl9DQo+ICAJY2FzZSBJMkNfUkVUUklF
UzoNCj4gKwkJLyoNCj4gKwkJICogVGhlIGFkYXB0ZXItPnJldHJpZXMgaXMgZGVmaW5lZCBhcyBp
bnQgdHlwZSwgYW5kIGFzDQo+ICsJCSAqIHRoZSB1cHBlciBsaW1pdCBmb3IgdGltZXMgb2YgaTJj
IHRyYW5zZmVyIHJldHJ5IHdoZW4NCj4gKwkJICogZ2V0IC1FQUdBSU4sIGl0IHNob3VsZCBub3Qg
YmUgc2V0IGFzIG1pbnVzIHZhbHVlLg0KPiArCQkgKi8NCg0KPj4gSSB1c3VhbGx5IGxpa2UgY29t
bWVudHMgZXhwbGFpbmluZyB0aGUgc2l0dWlhdGlvbi4gSG93ZXZlciwgaGVyZSBJIHRoaW5rIGl0
IGlzIHByZXR0eSBjbGVhciB0aGF0IHRoZSBjb2RlIGRvZXMganVzdCBzYW5pdHkgY2hlY2tzLiBT
bywgSSB0aGluayB3ZSBjYW4gZHJvcCBpdC4NClRoYW5rIHlvdSwgSSB3aWxsIGRyb3AgaXQgaW4g
dGhlIHVwZGF0ZXMuDQoNCj4gKwkJaWYgKChpbnQpYXJnIDwgMCkNCj4gKwkJCXJldHVybiAtRUlO
VkFMOw0KDQo+PiBNaW5vciBuaXQ6IEknZCB0aGluayB0aGlzIGlzIGEgbGl0dGxlIG1vcmUgcmVh
ZGFibGUNCg0KPj4JaWYgKGFyZyA+IElOVF9NQVgpDQo+PgkJCXJldHVybiAtRUlOVkFMDQoNCj4+
IEJ1dCBJIGhhdmUgbm8gc3Ryb25nIG9waW5pb24gaGVyZS4NClRoYW5rIHlvdSB2ZXJ5IG11Y2gg
Zm9yIHlvdXIgc3VnZ2VzdGlvbiwgSSB0aGluayB0aGlzIGlzIG11Y2ggYmV0dGVyIHRoYW4gdGhl
IHByZXZpb3VzLg0KDQpLaW5kIHJlZ2FyZHMsDQoNCiAgIFdvbGZyYW0NCg0K
