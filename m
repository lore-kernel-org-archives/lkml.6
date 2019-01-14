Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DE8C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BF120850
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfANDHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:07:54 -0500
Received: from mx23.baidu.com ([61.135.165.120]:43202 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726622AbfANDHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:07:54 -0500
X-Greylist: delayed 974 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Jan 2019 22:07:53 EST
Received: from M1-MAIL-EX05.internal.baidu.com (unknown [10.44.83.53])
        by Forcepoint Email with ESMTPS id 4EC2DB0FF6A49;
        Mon, 14 Jan 2019 10:51:34 +0800 (CST)
Received: from BC-Mail-Ex16.internal.baidu.com (172.31.40.52) by
 M1-MAIL-EX05.internal.baidu.com (10.44.83.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Mon, 14 Jan 2019 10:51:34 +0800
Received: from BC-Mail-Ex13.internal.baidu.com (172.31.40.49) by
 BC-Mail-Ex16.internal.baidu.com (172.31.40.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1531.3; Mon, 14 Jan 2019 10:51:34 +0800
Received: from BC-Mail-Ex13.internal.baidu.com ([172.31.40.49]) by
 Bc-Mail-Ex13.internal.baidu.com ([172.31.40.49]) with mapi id 15.01.1531.010;
 Mon, 14 Jan 2019 10:51:34 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     "Kohli, Gaurav" <gkohli@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alan@linux.intel.com" <alan@linux.intel.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW3YyXSB0dHk6IGZpeCByYWNlIGJldHdlZW4gZmx1?=
 =?utf-8?B?c2hfdG9fbGRpc2MgYW5kIHR0eV9vcGVu?=
Thread-Topic: [PATCH][v2] tty: fix race between flush_to_ldisc and tty_open
Thread-Index: AQHUqbWc97Jwf2tPUkWdFqROaSi6Q6WuBOCQ
Date:   Mon, 14 Jan 2019 02:51:34 +0000
Message-ID: <3a26e298dc604350b6ecf4e3381009a8@baidu.com>
References: <1545619432-8875-1-git-send-email-lirongqing@baidu.com>
 <fc359e35-6b07-832b-6770-46f00d1a84c6@codeaurora.org>
In-Reply-To: <fc359e35-6b07-832b-6770-46f00d1a84c6@codeaurora.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.24.150.58]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Baidu-BdMsfe-DateCheck: 1_M1-MAIL-EX05_2019-01-14 10:51:34:976
X-Baidu-BdMsfe-VirusCheck: M1-MAIL-EX05_GRAY_Inside_WithoutAtta_2019-01-14
 10:51:35:008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogS29obGksIEdhdXJhdiBbbWFp
bHRvOmdrb2hsaUBjb2RlYXVyb3JhLm9yZ10NCj4g5Y+R6YCB5pe26Ze0OiAyMDE55bm0MeaciDEx
5pelIDIxOjU3DQo+IOaUtuS7tuS6ujogTGksUm9uZ3FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29t
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ganNsYWJ5QHN1c2UuY29tOyBncmVn
a2hAbGludXhmb3VuZGF0aW9uLm9yZzsgYWxhbkBsaW51eC5pbnRlbC5jb20NCj4g5Li76aKYOiBS
ZTogW1BBVENIXVt2Ml0gdHR5OiBmaXggcmFjZSBiZXR3ZWVuIGZsdXNoX3RvX2xkaXNjIGFuZCB0
dHlfb3Blbg0KPiANCj4gSGksDQo+IA0KPiBpdCBkb24ndCBzZWVtcyB0byBiZSBnb29kIGlkZWEg
dG8gcHV0IGxvY2sgb24gb25lIGZ1bmN0aW9uIGFuZCB1bmxvY2sgaW4gc29tZQ0KPiBvdGhlciBm
dW5jdGlvbi4gSWYgaW4gZnV0dXJlIHNvbWUgb25lIGhhcyB0byBjYWxsIHR0eV9pbml0X2Rldiwg
aG93IGhlIGNhbiB0cmFjaw0KPiB0aGUgdW5sb2NraW5nIGFzIHdlbGwgb2YgbGRpc2MgbG9jay4N
Cj4gDQo+IFJlZ2FyZHMNCj4gR2F1cmF2DQo+IA0KDQpUaGlzIHNpbWlsYXIgY29uZGl0aW9uIGhh
cyBleGlzdGVkIGZvciBhIGxvbmcgdGltZSwgdHR5X3VubG9jayh0dHkpIG11c3QgYmUgY2FsbGVk
IGluDQpzb21lIG90aGVyIGZ1bmN0aW9ucyB3aG8gY2FsbCB0dHlfaW5pdF9kZXYsIHNpbmNlIHR0
eV9pbml0X2RldiBob2xkIHR0eV9sb2NrLCBhbmQgZG9lcw0Kbm90IHJlbGVhc2UgaXQNCg0Kc28g
SSB0aGluayBpdCBpcyB1c2VyIHJlc3BvbnNpYmlsaXR5IHRvIGZ1bGx5IHVuZGVyc3RhbmQgdHR5
X2luaXRfZGV2OyBhbmQgSSBjYW4gYWRkIHNvbWUgDQpjb21tZW50cyBmb3IgdHR5X2luaXRfZGV2
IGlmIHRoaXMgcGF0Y2ggY2FuIGJlIGFjY2VwdGFibGU7DQoNCg0Kb3IgYSB3b3JrYXJvdW5kIGxp
a2UgYmVsb3c6DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvdHR5X2J1ZmZlci5jIGIvZHJpdmVy
cy90dHkvdHR5X2J1ZmZlci5jDQppbmRleCBhNDJhMDI4YTlkNGUuLjJmNWFkMjU2YjZhZCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvdHR5L3R0eV9idWZmZXIuYw0KKysrIGIvZHJpdmVycy90dHkvdHR5
X2J1ZmZlci5jDQpAQCAtNDI1LDcgKzQyNSw3IEBAIHN0YXRpYyB2b2lkIGZsdXNoX3RvX2xkaXNj
KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCiAgICAgICAgc3RydWN0IHR0eV9sZGlzYyAqZGlz
YzsNCiANCiAgICAgICAgdHR5ID0gcG9ydC0+aXR0eTsNCi0gICAgICAgaWYgKHR0eSA9PSBOVUxM
KQ0KKyAgICAgICBpZiAodHR5ID09IE5VTEwgfHwgdHR5LT5kcml2ZXJfZGF0YSA9PSBOVUxMKQ0K
ICAgICAgICAgICAgICAgIHJldHVybjsNCiANCiAgICAgICAgZGlzYyA9IHR0eV9sZGlzY19yZWYo
dHR5KTsNCg0KdGhhbmtzDQoNCi1Sb25nUWluZw0KDQoNCg0K
