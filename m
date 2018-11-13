Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E279C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA29F2250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA29F2250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbeKMSJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:09:21 -0500
Received: from mail4.tencent.com ([183.57.53.109]:48706 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbeKMSJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:09:20 -0500
Received: from EXHUB-SZMail05.tencent.com (unknown [10.14.6.11])
        by mail4.tencent.com (Postfix) with ESMTP id E411F500C1;
        Tue, 13 Nov 2018 16:12:16 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail05.tencent.com ([::1]) with mapi id 14.03.0415.000; Tue, 13 Nov
 2018 16:12:13 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     Christian Brauner <christian@brauner.io>,
        Todd Kjos <tkjos@google.com>, Martijn Coenen <maco@android.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V4] binder: ipc namespace support for android binder
Thread-Topic: [PATCH V4] binder: ipc namespace support for android binder
Thread-Index: AdR7KIwSksMCqTsrStyoviXkOs52Qg==
Date:   Tue, 13 Nov 2018 08:12:08 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F91F70@EXMBX-SZMAIL022.tencent.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.96.209.157]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGhhdmUgbm90IHJlY2VpdmVkIGFuIGFuc3dlciB0byBteSBxdWVzdGlvbnMgaW4gdGhlIGxh
c3QgdmVyc2lvbiBvZiB0aGlzIHBhdGNoDQo+IHNldC4gQWxzbyBpdCB3b3VsZCBiZSBnb29kIGlm
IEkgY291bGQgYmUgQ2MnZWQgYnkgZGVmYXVsdC4gSSBjYW4ndCBodW50IGRvd24gYWxsDQo+IHBh
dGNoZXMuDQo+IEkgZG8gbm90IGtub3cgb2YgYW55IGtlcm5lbCBlbnRpdHksIHNwZWNpZmljYWxs
eSBkZXZpY2VzLCB0aGF0IGNoYW5nZSBuYW1lc3BhY2VzDQo+IG9uIG9wZW4oKS4NCj4gVGhpcyBz
ZWVtcyBsaWtlIGFuIGludml0YXRpb24gZm9yIGFsbCBraW5kcyBvZiBzZWN1cml0eSBidWdzLg0K
PiBBIGRldmljZSBub2RlIGJlbG9uZ3MgdG8gb25lIG5hbWVzcGFjZSBvbmx5IHdoaWNoIGlzIGF0
dGFjaGVkIHRvIHRoZQ0KPiB1bmRlcmx5aW5nIGtvYmplY3QuIE9wZW5pbmcgdGhlIGRldmljZSBz
aG91bGQgbmV2ZXIgY2hhbmdlIHRoYXQuDQo+IFBsZWFzZSBsb29rIGF0IGhvdyBtcXVldWUgb3Ig
c2htIGFyZSBkb2luZyB0aGlzLiBUaGV5IGRvbid0IGNoYW5nZQ0KPiBuYW1lc3BhY2VzIG9uIG9w
ZW4gZWl0aGVyLg0KPiBJIGhhdmUgdG8gc2F5IHRoYXQgaXMgb25lIG9mIHRoZSBtYWluIHJlYXNv
bnMgd2h5IEkgZGlzYWdyZWUgd2l0aCB0aGF0IGRlc2lnbi4NCj4gDQo+IA0KDQpJZiB3ZSBtdXN0
IHJldHVybiB0aGUgc2FtZSBjb250ZXh0IHdoZW4gZXZlcnkgb3BlbiBpbiBwcm9jLCB3ZSBjYW4g
b25seSBpc29sYXRlDQpiaW5kZXIgd2l0aCBtbnQgbmFtZXNwYWNlIGluc3RlYWQgb2YgaXBjIG5h
bWVzcGFjZSwgd2hhdCBkbyB5b3UgdGhpbmssIFRvZGQ/DQo=
