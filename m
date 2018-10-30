Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0583C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65472082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A65472082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbeJ3LXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:23:21 -0400
Received: from mail4.tencent.com ([183.57.53.109]:42875 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3LXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:23:21 -0400
Received: from EXHUB-SZMail05.tencent.com (unknown [10.14.6.11])
        by mail4.tencent.com (Postfix) with ESMTP id D7D0750508;
        Tue, 30 Oct 2018 10:31:49 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail05.tencent.com ([::1]) with mapi id 14.03.0415.000; Tue, 30 Oct
 2018 10:31:48 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        "christian@brauner.io" <christian@brauner.io>
Subject: RE: [PATCH] binder: ipc namespace support for android binder
Thread-Topic: [PATCH] binder: ipc namespace support for android binder
Thread-Index: AdRv89rwLQRqk4PeRAqGHjPLWmMeoAABIbJg
Date:   Tue, 30 Oct 2018 02:31:46 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F6DF85@EXMBX-SZMAIL022.tencent.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F6DF27@EXMBX-SZMAIL022.tencent.com>
In-Reply-To: <5FBCBE569E134E4CA167B91C0A77FD610198F6DF27@EXMBX-SZMAIL022.tencent.com>
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
IGlwYy9uYW1lc3BhY2UuYyBhcmUgbmFtZXNwYWNlIHNwZWNpZmljLCANCmFuZCBpcyAqbm90IG5l
ZWRlZCogaWYgaXBjIG5hbWVzcGFjZSBpcyBub3Qgc3VwcG9ydGVkLiAgPC0tLS0tLSBmaXhlZCBo
ZXJlDQoNCj4gVGhlcmUgYXJlIGEgY291cGxlIG1vcmUgaW1wbGVtZW50YXRpb25zIHNpbWlsYXIg
dG8gdGhpcyBvbmUuDQo+IGh0dHBzOi8vbHduLm5ldC9BcnRpY2xlcy81Nzc5NTcvIGFuZCBzb21l
IHN1Ym1pc3Npb25zIHRvIEFPU1AgZGVyaXZlZCBmcm9tIHRoYXQgb25lIHRoYXQgaW50cm9kdWNl
IGEgZ2VuZXJpYyByZWdpc3RyYXRpb24gZnVuY3Rpb24gZm9yIG5hbWVzcGFjZSBzdXBwb3J0IFsx
XSwgYW5kIGNoYW5nZXMgdG8gYmluZGVyIHRvIGltcGxlbWVudCBuYW1lc3BhY2VzIFsyXS4NCj4g
DQo+IElmIHRoaXMgaXMgcmVhbGx5IG5lZWRlZCwgdGhlbiB3ZSBzaG91bGQgaGF2ZSBhIHNvbHV0
aW9uIHRoYXQgd29ya3MgZm9yIGRldmljZXMgd2l0aG91dCByZXF1aXJpbmcgSVBDX05TIG9yIFNZ
U1ZJUEMuIEFsc28sIHdlIHNob3VsZCBub3QgYWRkIGJpbmRlci1zcGVjaWZpYyBjb2RlIHRvIGlw
Yy9uYW1lc3BhY2UuYyBvciBpbmNsdWRlL2xpbnV4L2lwY19uYW1lc3BhY2UuaC4NCj4gDQo+IC1U
b2RkDQo+IA0KPiBbMV0gaHR0cHM6Ly9hbmRyb2lkLXJldmlldy5nb29nbGVzb3VyY2UuY29tL2Mv
a2VybmVsL2NvbW1vbi8rLzQ3MTk2MQ0KPiBbMl0gaHR0cHM6Ly9hbmRyb2lkLXJldmlldy5nb29n
bGVzb3VyY2UuY29tL2Mva2VybmVsL2NvbW1vbi8rLzQ3MTgyNQ0KPg0KDQpJZiB0aGUgYmluZGVy
IHdpbGwgYmUgaXNvbGF0ZWQgYnkgbmFtZXNwYWNlLCBpdCBtdXN0IHB1dCBiaW5kZXIgcHJvYyBh
bmQgYmluZGVyIGNvbnRleHQgaW4gaXBjX25hbWVzcGFjZSAob3Igd2l0aCBzb21ldGhpbmcgbGlr
ZSB2b2lkKiBhcyBbMV0gZGlkKQ0KSSBoYXZlIHNlbnQgdGhlIFYyIHBhdGNoLCB0aGF0IHBhdGNo
IGRvZXMgbm90IHJlcXVpcmUgU1lTVklQQyBvciBJUENfTlMuIElmIElQQ19OUyBpcyBub3Qgc2V0
LCBiaW5kZXJfaW5pdCB3aWxsIHB1dCBwcm9jIGFuZCBjb250ZXh0IGludG8gaW5pdF9pcGNfbnMu
DQpJZiBTWVNWSVBDIGFuZCBDT05GSUdfUE9TSVhfTVFVRVVFIGFyZSBib3RoIHVuc2V0LCBJIHdp
bGwgbWFrZSBhIGZha2UgaW5pdF9pcGNfbnMgdG8gcHV0IHRoZW0uIGl0IGlzIG1hcmtlZCBhcyBu
byBzdGF0aWMgaW50ZW50aW9uYWxseSB0byBsZXQgY29tcGlsZSANCmdlbmVyYXRlIGFuIGVycm9y
IGlmIGl0IGhhcyBkZWZpbmVkIHNvbWV3aGVyZSBhbHNlLiBUaGUgY29kZSBpbiBpcGMvbmFtZXNw
YWNlLmMgaXMganVzdCB0byBub3RpZnkgYmluZGVyIHRvIGRvIHNvbWUgaW5zdGFsbGF0aW9ud2hl
cmUgbmFtZXNwYWNlIGFyZQ0KY3JlYXRpbmcsIElmIG5vIElQQ19OUyBzZXQsIHRoZSBpbml0aWFs
aXphdGlvbiBpbiBiaW5kZXJfaW5pdCB3aWxsIGJlIGVub3VnaC4NClNvIHBsZWFzZSByZXZpZXcg
YW5kIHRlc3QgdGhlIFYyIHBhdGNoLg0K
