Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F73BC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDDE2082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDDE2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeJ3LQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:16:44 -0400
Received: from mail2.tencent.com ([163.177.67.195]:48296 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3LQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:16:44 -0400
Received: from EXHUB-SZMail05.tencent.com (unknown [10.14.6.11])
        by mail2.tencent.com (Postfix) with ESMTP id 2F66A8EAC2;
        Tue, 30 Oct 2018 10:25:13 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail05.tencent.com ([::1]) with mapi id 14.03.0415.000; Tue, 30 Oct
 2018 10:25:12 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        "christian@brauner.io" <christian@brauner.io>,
        =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
Subject: RE: [PATCH] binder: ipc namespace support for android binder
Thread-Topic: [PATCH] binder: ipc namespace support for android binder
Thread-Index: AdRv89rwLQRqk4PeRAqGHjPLWmMeoA==
Date:   Tue, 30 Oct 2018 02:25:11 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F6DF27@EXMBX-SZMAIL022.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.209.57]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gSXQncyBub3Qgb2J2aW91cyBmcm9tIHRoaXMgcGF0Y2ggd2hlcmUgdGhpcyBkZXBlbmRl
bmN5IGNvbWVzIA0KPiA+ID4gZnJvbS4uLndoeSBpcyBTWVNWSVBDIHJlcXVpcmVkPyBJJ2QgbGlr
ZSB0byBub3QgaGF2ZSB0byByZXF1aXJlIA0KPiA+ID4gSVBDX05TIGVpdGhlciBmb3IgZGV2aWNl
cy4NCj4gPg0KPiA+IFllcywgdGhlIHBhdGNoIGlzIG5vdCBoaWdobHkgZGVwZW5kZW50IG9uIFNZ
U1ZJUEMsIGJ1dCBpdCB3aWxsIGJlIA0KPiA+IGNvbnZlbmllbnQgaWYgcmVxdWlyZSBpdC4gSSB3
aWxsIHVwZGF0ZSBpdCB0byBkcm9wIGRlcGVuZGVuY3kgb2YgaXQgaW4gDQo+ID4gVjIgcGF0Y2gu
IFRoaXMgcGF0Y2ggZG9lc24ndCBuZWVkIElQQ19OUyBzZXQgYXQgcHJlc2VudC4NCj4gDQo+IEFj
dHVhbGx5IGl0IGlzIGRlcGVuZGVudCBvbiBJUENfTlMgc2luY2UgaXQgbWFrZXMgY2hhbmdlcyB0
byBpcGMvbmFtZXNwYWNlLmMgd2hpY2ggaXMgY29tcGlsZWQgb25seSBpZiBDT05GSUdfSVBDX05T
Lg0KPiANCg0KQWN0dWFsbHkgaXQgZG9lcyBub3QgcmVxdWlyZSBJUENfTlMsIHRoZSBjb2RlIGlu
IGlwYy9uYW1lc3BhY2UuYyBhcmUgbmFtZXNwYWNlIHNwZWNpZmljLCBhbmQgaXMgKm5vdCBuZWVk
ZWQqIGlmIGlwYyBuYW1lc3BhY2UgaXMgc3VwcG9ydGVkLg0KDQo+IFRoZXJlIGFyZSBhIGNvdXBs
ZSBtb3JlIGltcGxlbWVudGF0aW9ucyBzaW1pbGFyIHRvIHRoaXMgb25lLg0KPiBodHRwczovL2x3
bi5uZXQvQXJ0aWNsZXMvNTc3OTU3LyBhbmQgc29tZSBzdWJtaXNzaW9ucyB0byBBT1NQIGRlcml2
ZWQgZnJvbSB0aGF0IG9uZSB0aGF0IGludHJvZHVjZSBhIGdlbmVyaWMgcmVnaXN0cmF0aW9uIGZ1
bmN0aW9uIGZvciBuYW1lc3BhY2Ugc3VwcG9ydCBbMV0sIGFuZCBjaGFuZ2VzIHRvIGJpbmRlciB0
byBpbXBsZW1lbnQgbmFtZXNwYWNlcyBbMl0uDQo+IA0KPiBJZiB0aGlzIGlzIHJlYWxseSBuZWVk
ZWQsIHRoZW4gd2Ugc2hvdWxkIGhhdmUgYSBzb2x1dGlvbiB0aGF0IHdvcmtzIGZvciBkZXZpY2Vz
IHdpdGhvdXQgcmVxdWlyaW5nIElQQ19OUyBvciBTWVNWSVBDLiBBbHNvLCB3ZSBzaG91bGQgbm90
IGFkZCBiaW5kZXItc3BlY2lmaWMgY29kZSB0byBpcGMvbmFtZXNwYWNlLmMgb3IgaW5jbHVkZS9s
aW51eC9pcGNfbmFtZXNwYWNlLmguDQo+IA0KPiAtVG9kZA0KPiANCj4gWzFdIGh0dHBzOi8vYW5k
cm9pZC1yZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9jL2tlcm5lbC9jb21tb24vKy80NzE5NjENCj4g
WzJdIGh0dHBzOi8vYW5kcm9pZC1yZXZpZXcuZ29vZ2xlc291cmNlLmNvbS9jL2tlcm5lbC9jb21t
b24vKy80NzE4MjUNCj4NCg0KSWYgdGhlIGJpbmRlciB3aWxsIGJlIGlzb2xhdGVkIGJ5IG5hbWVz
cGFjZSwgaXQgbXVzdCBwdXQgYmluZGVyIHByb2MgYW5kIGJpbmRlciBjb250ZXh0IGluIGlwY19u
YW1lc3BhY2UgKG9yIHdpdGggc29tZXRoaW5nIGxpa2Ugdm9pZCogYXMgWzFdIGRpZCkNCkkgaGF2
ZSBzZW50IHRoZSBWMiBwYXRjaCwgdGhhdCBwYXRjaCBkb2VzIG5vdCByZXF1aXJlIFNZU1ZJUEMg
b3IgSVBDX05TLiBJZiBJUENfTlMgaXMgbm90IHNldCwgYmluZGVyX2luaXQgd2lsbCBwdXQgcHJv
YyBhbmQgY29udGV4dCBpbnRvIGluaXRfaXBjX25zLg0KSWYgU1lTVklQQyBhbmQgQ09ORklHX1BP
U0lYX01RVUVVRSBhcmUgYm90aCB1bnNldCwgSSB3aWxsIG1ha2UgYSBmYWtlIGluaXRfaXBjX25z
IHRvIHB1dCB0aGVtLiBpdCBpcyBtYXJrZWQgYXMgbm8gc3RhdGljIGludGVudGlvbmFsbHkgdG8g
bGV0IGNvbXBpbGUgDQpnZW5lcmF0ZSBhbiBlcnJvciBpZiBpdCBoYXMgZGVmaW5lZCBzb21ld2hl
cmUgYWxzZS4gVGhlIGNvZGUgaW4gaXBjL25hbWVzcGFjZS5jIGlzIGp1c3QgdG8gbm90aWZ5IGJp
bmRlciB0byBkbyBzb21lIGluc3RhbGxhdGlvbndoZXJlIG5hbWVzcGFjZSBhcmUNCmNyZWF0aW5n
LCBJZiBubyBJUENfTlMgc2V0LCB0aGUgaW5pdGlhbGl6YXRpb24gaW4gYmluZGVyX2luaXQgd2ls
bCBiZSBlbm91Z2guDQpTbyBwbGVhc2UgcmV2aWV3IGFuZCB0ZXN0IHRoZSBWMiBwYXRjaC4NCg==
