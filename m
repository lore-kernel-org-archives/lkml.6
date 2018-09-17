Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE5EECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B352147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 14:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B352147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbeIQUZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:25:24 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6420 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726885AbeIQUZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:25:24 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 4EFE29D9581F1;
        Mon, 17 Sep 2018 22:57:37 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Mon, 17 Sep 2018 22:57:37 +0800
Received: from DGGEMM527-MBS.china.huawei.com ([169.254.5.129]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0399.000;
 Mon, 17 Sep 2018 22:57:35 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Steve Grubb <sgrubb@redhat.com>
Subject: RE: [PATCH] fanotify support save thread id
Thread-Topic: [PATCH] fanotify support save thread id
Thread-Index: AQHUTm18FZ4qRm1KoEelUlHKs8+JXqTzxnUAgADG2dA=
Date:   Mon, 17 Sep 2018 14:57:35 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7B71DA@DGGEMM527-MBS.china.huawei.com>
References: <20180917091602.21531-1-nixiaoming@huawei.com>
 <CAOQ4uxiBMD7ZRVz=iiY9bUEmvQOYSqz7wWxMQvwj7EpAd-ft1A@mail.gmail.com>
In-Reply-To: <CAOQ4uxiBMD7ZRVz=iiY9bUEmvQOYSqz7wWxMQvwj7EpAd-ft1A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.88.168]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIFNlcCAxNywgMjAxOCA2OjU0IFBNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBn
bWFpbC5jb20+IHdyb3RlOg0KPk9uIE1vbiwgU2VwIDE3LCAyMDE4IGF0IDE6MDIgUE0gbml4aWFv
bWluZyA8bml4aWFvbWluZ0BodWF3ZWkuY29tPiB3cm90ZToNCj4+DQo+PiBBZGRlZCBGQU5fRVZF
TlRfSU5GT19USUQgdG8gc2VsZWN0IHRoZSB0aHJlYWQgaWQgb2YgdGhlIGV2ZW50IHRyaWdnZXIN
Cj4+DQo+DQo+TWF5YmUgInRvIHJlcG9ydCB0aGUgdGhyZWFkIGlkIG9mIHRoZSB0YXNrIHRoYXQg
Y2F1c2VkIHRoZSBldmVudCIuDQo+QWxzbyBpbiBjb21taXQgdGl0bGUsIEkgdGhpbmsgInJlcG9y
dGluZyB0aHJlYWQgaWQiIGlzIG1vcmUgdG8gdGhlIHBvaW50DQo+dGhhbiAic2F2ZSB0aHJlYWQg
aWQiLg0KPg0KVmVyeSBnb29kIGFkdmljZSwgSSB3aWxsIHVwZGF0ZSB0aGUgcGF0Y2ggZGVzY3Jp
cHRpb24gYmFzZWQgb24geW91ciBzdWdnZXN0aW9ucy4NCg0KPg0KPj4gU2lnbmVkLW9mZi1ieTog
bml4aWFvbWluZyA8bml4aWFvbWluZ0BodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAtLS0gYS9pbmNs
dWRlL3VhcGkvbGludXgvZmFub3RpZnkuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Zh
bm90aWZ5LmgNCj4+IEBAIC0xOCw2ICsxOCw3IEBADQo+Pg0KPj4gICNkZWZpbmUgRkFOX09ORElS
ICAgICAgICAgICAgICAweDQwMDAwMDAwICAgICAgLyogZXZlbnQgb2NjdXJyZWQgYWdhaW5zdCBk
aXIgKi8NCj4+DQo+PiArI2RlZmluZSBGQU5fRVZFTlRfSU5GT19USUQgICAgIDB4MDIwMDAwMDAg
ICAgICAvKiBldmVudCBzYXZlIHRocmVhZCBpZCByZXBsYWNlIHRnaWQgKi8NCj4+ICAjZGVmaW5l
IEZBTl9FVkVOVF9PTl9DSElMRCAgICAgMHgwODAwMDAwMCAgICAgIC8qIGludGVyZXN0ZWQgaW4g
Y2hpbGQgZXZlbnRzICovDQo+Pg0KPg0KPm5peGlhb21pbmcsDQo+DQo+WW91IG1pc3VuZGVyc3Rv
b2QgbWUuDQo+DQo+SSBtZWFudCB0aGF0IHlvdSBzaG91bGQgYWRkIHN1cHBvcnQgZm9yIGZsYWcg
RkFOX0VWRU5UX0lORk9fVElEDQo+Zm9yIHRoZSBmYW5vdGlmeV9pbml0KCkgc3lzY2FsbCwgbm90
IHRoZSBmYW5vdGlmeV9tYXJrKCkgc3lzY2FsbC4NCj4NCkkgbWlzdGFrZW5seSB0aG91Z2h0IHRo
YXQgYWRkaW5nIGEgdGFnIHRvIGdyb3VwLT5mYW5vdGlmeV9kYXRhIGluIHRoZSBmYW5vdGlmeV9p
bml0IHN5c3RlbSBjYWxsIHdvdWxkIGFmZmVjdCB0aGUgc3lzdGVtIEFCSS4gDQpsb2NhbCB0ZXN0
cyBmb3VuZCB0aGF0IE1vZHVsZS5zeW12ZXJzIGRpZCBub3QgY2hhbmdlIGJlZm9yZSBhbmQgYWZ0
ZXIgdGhlIG1vZGlmaWNhdGlvbi4NCg0KQWNjb3JkaW5nIHRvIHlvdXIgb3BpbmlvbiwgSSBoYXZl
IHJlLW1vZGlmaWVkIGEgdmVyc2lvbiBvZiBmYW5vdGlmeV9pbml0DQpJIHdpbGwgc2VuZCB0aGUg
cGF0Y2ggbGF0ZXIuDQoNCj5TZWUgdGhpcyBjb21taXQgZnJvbSBTdGV2ZSBHcnViYiBmb3IgZXhh
bXBsZSBvZiBhZGRpbmcgbmV3IG9wdC1pbg0KPmJlaGF2aW9yIHRvIGZhbm90aWZ5Og0KPmRlOGNk
ODNlOTFiYyBhdWRpdDogUmVjb3JkIGZhbm90aWZ5IGFjY2VzcyBjb250cm9sIGRlY2lzaW9ucw0K
Pg0KPkJUVywgU3RldmUsIGRpZCB5b3UgZXZlciBmb2xsb3cgdXAgd2l0aCBhIG1hbi1wYWdlcyBw
YXRjaD8NCj4NCj5UaGFua3MsDQo+QW1pci4NCj4NCg0KdGhhbmtzDQo=
