Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D87C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2636E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 04:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2636E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=xiaomi.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbeJaM4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:56:08 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.126]:47422 "EHLO
        outboundhk.mxmail.xiaomi.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728467AbeJaM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:56:08 -0400
X-AuditID: 0a3808ce-4c9ff70000012663-7f-5bd928413013
Received: from xiaomi.com (cnbox9.mioffice.cn [10.237.8.149])
        by outboundhk.mxmail.xiaomi.com (xiaomi.com) with SMTP id 18.08.09827.14829DB5; Wed, 31 Oct 2018 11:57:53 +0800 (HKT)
Received: from CNBOX2.mioffice.cn (10.237.8.142) by CNBOX9.mioffice.cn
 (10.237.8.149) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Wed, 31 Oct
 2018 11:57:52 +0800
Received: from CNBOX2.mioffice.cn ([fe80::212f:6b18:4f64:d874]) by
 cnbox2.mioffice.cn ([fe80::212f:6b18:4f64:d874%20]) with mapi id
 15.00.1365.000; Wed, 31 Oct 2018 11:57:52 +0800
From:   =?gb2312?B?UGVuZzE1IFdhbmcgzfXF9A==?= <wangpeng15@xiaomi.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>
CC:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        "Tony Luck" <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "vipwangerxiao@gmail.com" <vipwangerxiao@gmail.com>
Subject: Re: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
Thread-Topic: [PATCH v4] pstore: Avoid duplicate call of persistent_ram_zap()
Thread-Index: AQHUcCWUM4rhaZU8CEaPf5LcErlgeaU3y1YAgAAEB4CAAAaIgIAA4+op
Date:   Wed, 31 Oct 2018 03:57:51 +0000
Message-ID: <1540958265198.28846@xiaomi.com>
References: <20181030075234.21137-1-wangpeng15@xiaomi.com>
 <20181030213818.GA32621@google.com>
 <CAGXu5j+tRWseaecob04U5iXHa-P_z=Hvj3PmhE5YWFUO=LT7Sw@mail.gmail.com>,<20181030221605.GA44036@joelaf.mtv.corp.google.com>
In-Reply-To: <20181030221605.GA44036@joelaf.mtv.corp.google.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.91.193]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsXC9ZZjqq6jxs1og8YV2hYHt2pabN/4jdVi
        WYOqxZnuXIvLu+awWby5cI/F4uTP5awO7B7bdm9j9ZjdcJHFY0L/J0aPnbPusnss3vOSyWPh
        p6+sHp83yQWwR3HZpKTmZJalFunbJXBlPLr/ka2gT7Vi2cx3TA2MU1S6GDk5JARMJFZf2sbe
        xcjFISSwlVHiwNE+FpCEkMAqRolXt2IgEtsZJZYuPM0GkmATcJZY/+Y0I4gtIuAnsaN3MhNI
        EbPASUaJjXvvsIMkhAV8JPbNh5gkIuArsXZ3N5TtJvHp5hUwm0VAVeL0549gQ3kFdCRe9f9n
        hdh8m1Fi8qVaEJtTwEHi3v0LTCA2o4CsxNWWbWD1zALiEreezGeCeEFAYsme88wQtqjEy8f/
        WCFsA4mtS/exQNiKEtOX3Yfq1ZKY1/CbCcJWlJjS/ZAd4gZBiZMzn7BMYBSfhWTFLCQts5C0
        zELSsoCRZRWjZEZ+Xno2EBcXJOYa6uVm5qelZSan6iXnbWIExa8Fx7kdjBPepR5iFOBgVOLh
        fZB8I1qINbGsuDL3EKMEB7OSCO/UCqAQb0piZVVqUX58UWlOavEhRmkOFiVxXoPGA9FCAumJ
        JanZqakFqUUwWSYOTqkGxuP3f9vJ5jNX+G+484qv47xORNDGVJfcqOCcKsWdMnufpu9p/eej
        dX3yVZeVOVsOtTRX3wkVDrx4szZRfenzV3IiofZhc663nZ0Xpcsi07XR9dWXz9dtU3Qbftev
        25/wvkgklU3x0Onnhj8DmP9HPz7M/3DNAaOYL8vyTr/b1BH0i6+2z4CzQImlOCPRUIu5qDgR
        APvh9cfbAgAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj5Gcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4KPlNlbnQ6IFdl
ZG5lc2RheSwgT2N0b2JlciAzMSwgMjAxOCA2OjE2Cj5UbzogS2VlcyBDb29rCj5DYzogUGVuZzE1
IFdhbmcgzfXF9DsgQW50b24gVm9yb250c292OyBDb2xpbiBDcm9zczsgVG9ueSBMdWNrOyBMS01M
OyB2aXB3YW5nZXJ4aWFvQGdtYWlsLmNvbQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NF0gcHN0b3Jl
OiBBdm9pZCBkdXBsaWNhdGUgY2FsbCBvZiBwZXJzaXN0ZW50X3JhbV96YXAoKQo+Cj5PbiBUdWUs
IE9jdCAzMCwgMjAxOCBhdCAwMjo1Mjo0M1BNIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6Cj4+IE9u
IFR1ZSwgT2N0IDMwLCAyMDE4IGF0IDI6MzggUE0sIEpvZWwgRmVybmFuZGVzIDxqb2VsQGpvZWxm
ZXJuYW5kZXMub3JnPiB3cm90ZToKPj4gPiBPbiBUdWUsIE9jdCAzMCwgMjAxOCBhdCAwMzo1Mjoz
NFBNICswODAwLCBQZW5nIFdhbmcgd3JvdGU6Cj4+ID4+IFdoZW4gaW5pdGlhbGluZyBwcnogd2l0
aCBpbnZhbGlkIGRhdGEgaW4gYnVmZmVyKG5vIFBFUlNJU1RFTlRfUkFNX1NJRyksCj4+ID4+IGZ1
bmN0aW9uIGNhbGwgcGF0aCBpcyBsaWtlIHRoaXM6Cj4+ID4+Cj4+ID4+IHJhbW9vcHNfaW5pdF9w
cnogLT4KPj4gPj4gfAo+PiA+PiB8LT4gcGVyc2lzdGVudF9yYW1fbmV3IC0+IHBlcnNpc3RlbnRf
cmFtX3Bvc3RfaW5pdCAtPiBwZXJzaXN0ZW50X3JhbV96YXAKPj4gPj4gfAo+PiA+PiB8LT4gcGVy
c2lzdGVudF9yYW1femFwCj4+ID4+Cj4+ID4+IEFzIHdlIGNhbiBzZWUsIHBlcnNpc3RlbnRfcmFt
X3phcCgpIGlzIGNhbGxlZCB0d2ljZS4KPj4gPj4gV2UgY2FuIGF2b2lkIHRoaXMgYnkgYWRkaW5n
IGFuIG9wdGlvbiB0byBwZXJzaXN0ZW50X3JhbV9uZXcoKSwgYW5kCj4+ID4+IG9ubHkgY2FsbCBw
ZXJzaXN0ZW50X3JhbV96YXAoKSB3aGVuIGl0IGlzIG5lZWRlZC4KPj4gPj4KPj4gPj4gU2lnbmVk
LW9mZi1ieTogUGVuZyBXYW5nIDx3YW5ncGVuZzE1QHhpYW9taS5jb20+Cj4+ID4+IC0tLQo+PiA+
PiAgZnMvcHN0b3JlL3JhbS5jICAgICAgICAgICAgfCA0ICstLS0KPj4gPj4gIGZzL3BzdG9yZS9y
YW1fY29yZS5jICAgICAgIHwgNSArKystLQo+PiA+PiAgaW5jbHVkZS9saW51eC9wc3RvcmVfcmFt
LmggfCAxICsKPj4gPj4gIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQo+PiA+Pgo+PiA+PiBkaWZmIC0tZ2l0IGEvZnMvcHN0b3JlL3JhbS5jIGIvZnMvcHN0
b3JlL3JhbS5jCj4+ID4+IGluZGV4IGZmY2ZmNjUxNmU4OS4uYjUxOTAxZjk3ZGMyIDEwMDY0NAo+
PiA+PiAtLS0gYS9mcy9wc3RvcmUvcmFtLmMKPj4gPj4gKysrIGIvZnMvcHN0b3JlL3JhbS5jCj4+
ID4+IEBAIC02NDAsNyArNjQwLDcgQEAgc3RhdGljIGludCByYW1vb3BzX2luaXRfcHJ6KGNvbnN0
IGNoYXIgKm5hbWUsCj4+ID4+Cj4+ID4+ICAgICAgIGxhYmVsID0ga2FzcHJpbnRmKEdGUF9LRVJO
RUwsICJyYW1vb3BzOiVzIiwgbmFtZSk7Cj4+ID4+ICAgICAgICpwcnogPSBwZXJzaXN0ZW50X3Jh
bV9uZXcoKnBhZGRyLCBzeiwgc2lnLCAmY3h0LT5lY2NfaW5mbywKPj4gPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjeHQtPm1lbXR5cGUsIDAsIGxhYmVsKTsKPj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjeHQtPm1lbXR5cGUsIFBSWl9GTEFHX1pBUF9PTEQs
IGxhYmVsKTsKPj4gPj4gICAgICAgaWYgKElTX0VSUigqcHJ6KSkgewo+PiA+PiAgICAgICAgICAg
ICAgIGludCBlcnIgPSBQVFJfRVJSKCpwcnopOwo+PiA+Cj4+ID4gTG9va3MgZ29vZCB0byBtZSBl
eGNlcHQgdGhlIG1pbm9yIGNvbW1lbnQgYmVsb3c6Cj4+ID4KPj4gPj4KPj4gPj4gQEAgLTY0OSw4
ICs2NDksNiBAQCBzdGF0aWMgaW50IHJhbW9vcHNfaW5pdF9wcnooY29uc3QgY2hhciAqbmFtZSwK
Pj4gPj4gICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+PiA+PiAgICAgICB9Cj4+ID4+Cj4+ID4+
IC0gICAgIHBlcnNpc3RlbnRfcmFtX3phcCgqcHJ6KTsKPj4gPj4gLQo+PiA+PiAgICAgICAqcGFk
ZHIgKz0gc3o7Cj4+ID4+Cj4+ID4+ICAgICAgIHJldHVybiAwOwo+PiA+PiBkaWZmIC0tZ2l0IGEv
ZnMvcHN0b3JlL3JhbV9jb3JlLmMgYi9mcy9wc3RvcmUvcmFtX2NvcmUuYwo+PiA+PiBpbmRleCAx
MmUyMWY3ODkxOTQuLjJlZGVkZDFlYTFjMiAxMDA2NDQKPj4gPj4gLS0tIGEvZnMvcHN0b3JlL3Jh
bV9jb3JlLmMKPj4gPj4gKysrIGIvZnMvcHN0b3JlL3JhbV9jb3JlLmMKPj4gPj4gQEAgLTUwNSwx
NSArNTA1LDE2IEBAIHN0YXRpYyBpbnQgcGVyc2lzdGVudF9yYW1fcG9zdF9pbml0KHN0cnVjdCBw
ZXJzaXN0ZW50X3JhbV96b25lICpwcnosIHUzMiBzaWcsCj4+ID4+ICAgICAgICAgICAgICAgICAg
ICAgICBwcl9kZWJ1ZygiZm91bmQgZXhpc3RpbmcgYnVmZmVyLCBzaXplICV6dSwgc3RhcnQgJXp1
XG4iLAo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVmZmVyX3NpemUocHJ6
KSwgYnVmZmVyX3N0YXJ0KHByeikpOwo+PiA+PiAgICAgICAgICAgICAgICAgICAgICAgcGVyc2lz
dGVudF9yYW1fc2F2ZV9vbGQocHJ6KTsKPj4gPj4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAwOwo+PiA+PiArICAgICAgICAgICAgICAgICAgICAgaWYgKCEocHJ6LT5mbGFncyAmIFBSWl9G
TEFHX1pBUF9PTEQpKQo+PiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
MDsKPj4gPgo+PiA+IFRoaXMgY291bGQgYmUgd3JpdHRlbiBkaWZmZXJlbnRseS4KPj4gPgo+PiA+
IFdlIGNvdWxkIGp1c3QgZG86Cj4+ID4KPj4gPiBpZiAocHJ6LT5mbGFncyAmIFBSWl9GTEFHX1pB
UF9PTEQpCj4+ID4gICAgICAgICBwZXJzaXN0ZW50X3JhbV96YXAocHJ6KTsKPj4gPgo+PiA+IEFu
ZCByZW1vdmUgdGhlIHphcCBmcm9tIGJlbG93IGJlbG93Lgo+Pgo+PiBJIGFjdHVhbGx5IHJlYXJy
YW5nZWQgdGhpbmdzIGEgbGl0dGxlIHRvIGF2b2lkIGFkZGl0aW9uYWwgcm91bmQtdHJpcHMKPj4g
b24gdGhlIG1haWxpbmcgbGlzdC4gOikKPj4KPj4gPiBTaW5jZSBLZWVzIGFscmVhZHkgdG9vayB0
aGlzIHBhdGNoLCBJIGNhbiBqdXN0IHBhdGNoIHRoaXMgaW4gbXkgc2VyaWVzIGlmCj4+ID4gS2Vl
cyBhbmQgeW91IGFyZSBPayB3aXRoIHRoaXMgc3VnZ2VzdGlvbi4KPj4KPj4gSSd2ZSBwdXQgaXQg
dXAgaGVyZToKPj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQva2Vlcy9saW51eC5naXQvY29tbWl0Lz9oPXBzdG9yZS9kZXZlbCZpZD1hYzU2NGUwMjMyNDhl
M2Y0ZDg3OTE3YjkxZDEyMzc2ZGRmY2E1MDAwCj4KPkNvb2wsIGl0IExHVE0gOikKPgo+LSBKb2Vs
Cj4KClRoYW5rIHlvdSBhbGwgZm9yIHRoZXNlIHdhcm0gaGVscC4KClRoaXMgaXMgbXkgZmlyc3Qg
dGltZSB0byBzdWJtaXQgYSBwYXRjaCB0byBjb21tdW5pdHkuIEZlZWwgZ3JlYXQhCg==
