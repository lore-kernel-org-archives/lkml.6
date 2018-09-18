Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5429ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6028A206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6028A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeIRPWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:22:14 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:6040 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728912AbeIRPWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:22:14 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 8585425005012;
        Tue, 18 Sep 2018 17:50:22 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.399.0; Tue, 18 Sep 2018 17:50:23 +0800
Received: from DGGEMM527-MBS.china.huawei.com ([169.254.5.129]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0399.000;
 Tue, 18 Sep 2018 17:50:21 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Amir Goldstein <amir73il@gmail.com>
CC:     Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] fanotify reports the thread id of the event trigger
Thread-Topic: [PATCH v2] fanotify reports the thread id of the event trigger
Thread-Index: AQHUTpfuO8h5GU9em0yW7M1mbnoXxaT0GT8AgAE/CbD//8DMAIAAst+A
Date:   Tue, 18 Sep 2018 09:50:21 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7B9DD9@DGGEMM527-MBS.china.huawei.com>
References: <20180917141950.111841-1-nixiaoming@huawei.com>
 <CAOQ4uxj_o9FP8EH9_=TX=Tv9WDfExykrni7OjE3992YZrJDpZg@mail.gmail.com>
 <E490CD805F7529488761C40FD9D26EF12A7B97FA@DGGEMM527-MBS.china.huawei.com>
 <CAOQ4uxg+BE5pkN5Mi3Z8ShA=s69Jp+whOsJ3+0BP-1NMK769_g@mail.gmail.com>
In-Reply-To: <CAOQ4uxg+BE5pkN5Mi3Z8ShA=s69Jp+whOsJ3+0BP-1NMK769_g@mail.gmail.com>
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

T24gVHVlLCBTZXAgMTgsIDIwMTggMzowNyBQTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21h
aWwuY29tPg0KPk9uIFR1ZSwgU2VwIDE4LCAyMDE4IGF0IDY6MDEgQU0gTml4aWFvbWluZyA8bml4
aWFvbWluZ0BodWF3ZWkuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBNb24sIFNlcCAxNywgMjAxOCAx
MTo1MSBQTSBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPiB3cm90ZToNCj4+ID5P
biBNb24sIFNlcCAxNywgMjAxOCBhdCA2OjA1IFBNIG5peGlhb21pbmcgPG5peGlhb21pbmdAaHVh
d2VpLmNvbT4gd3JvdGU6DQo+Li4uDQo+PiA+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9m
c25vdGlmeV9iYWNrZW5kLmggYi9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2JhY2tlbmQuaA0KPj4g
Pj4gaW5kZXggYjhmNDE4Mi4uNDRjNjU5ZiAxMDA2NDQNCj4+ID4+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvZnNub3RpZnlfYmFja2VuZC5oDQo+PiA+PiArKysgYi9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5
X2JhY2tlbmQuaA0KPj4gPj4gQEAgLTE5Myw2ICsxOTMsNyBAQCBzdHJ1Y3QgZnNub3RpZnlfZ3Jv
dXAgew0KPj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IG1heF9tYXJr
czsNCj4+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB1c2VyX3N0cnVjdCAqdXNl
cjsNCj4+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgYXVkaXQ7DQo+PiA+PiArICAg
ICAgICAgICAgICAgICAgICAgICBib29sIHNob3VsZF9yZXBvcnRfdGlkOw0KPj4gPg0KPj4gPkZv
ciBicmV2aXR5IEkgd291bGQgY2FsbCB0aGF0IHJlcG9ydF90aWQsIGJ1dCBub3QgaW5zaXN0aW5n
Lg0KPj4gPg0KPj4NCj4+IFdoZXRoZXIgaXQgaXMgYmV0dGVyIHRvIGNoYW5nZSB0byAidW5zaWdu
ZWQgaW50IGZsYWdzIg0KPj4gU2F2ZSAiZ3JvdXAtPmZhbm90aWZ5X2RhdGEuZmxhZ3M9ZmxhZ3M7
IiBpbiAiZmFub3RpZnlfaW5pdCINCj4+IERldGVybWluZSB3aGV0aGVyICJncm91cC0+ZmFub3Rp
ZnlfZGF0YS5mbGFncyIgY29udGFpbnMgIkZBTl9FVkVOVF9JTkZPX1RJRCIgaW4gImZhbm90aWZ5
X2FsbG9jX2V2ZW50IjsNCj4+DQo+PiBBdCB0aGUgc2FtZSB0aW1lLCBpZiB0aGVyZSBhcmUgb3Ro
ZXIgZmxhZ3MgdGhhdCBuZWVkIHRvIGJlIHVzZWQgbGF0ZXIsIHRoZXJlIGlzIG5vIG5lZWQgdG8g
YWRkIG5ldyBtZW1iZXJzLg0KPj4NCj4+IEJ5IHRoZSB3YXksIHdoZXRoZXIgb3Igbm90ICJib29s
IGF1ZGl0IiBjYW4gYWxzbyBiZSBpbmNsdWRlZCBieSBmbGFncw0KPj4NCj4NCj5JIHN0cm9uZ2x5
IGFncmVlLiBEaWRuJ3Qgd2FudCB0byBpbXBvc2UgdGhpcyBjaGFuZ2Ugb24geW91LCBidXQgaW4N
Cj5mYWN0LCBJIGFscmVhZHkgZGlkDQo+dGhhdCBpbiBteSBvd24gcGF0Y2ggc2V0LCBzbyB5b3Ug
Y2FuIHVzZSBteSBwYXRjaGVzIGFzIHJlZmVyZW5jZToNCj5odHRwczovL2dpdGh1Yi5jb20vYW1p
cjczaWwvbGludXgvY29tbWl0LzUyMjVmZTFlMTljNzRmNGQ3YTRhNGNjOThmZjZlZjU4NzJjOGU2
MjANCj5odHRwczovL2dpdGh1Yi5jb20vYW1pcjczaWwvbGludXgvY29tbWl0LzBkMWEyMjZmNWMx
ODAxMmYxOWVkNmVhYmZhYjQ2ZjBmMTI1ZWMxOTANCj4NCj5JZiB5b3UgZG8gdGhpcyB5b3UgbmVl
ZCB0byBzZXBhcmF0ZSB5b3VyIGNoYW5nZSBpbnRvIDIgcGF0Y2hlcy4NCj5GaXJzdCBtYWtlIHRo
ZSBmYW5vdGlmeV9kYXRhLmZsYWdzIGNoYW5nZSBjb2xsZWN0aW5nIHRoZSBwaWVjZXMgZnJvbSBi
b3RoDQo+bXkgcGF0Y2hlcy4NCj5UaGVuIG1ha2UgeW91ciBUSUQgY2hhbmdlIHVzaW5nIGZhbm90
aWZ5X2RhdGEuZmxhZ3MuDQo+DQo+VGhhbmtzLA0KPkFtaXIuDQo+DQpTaG91bGQgSSBkbyB0aGlz
Og0KMSBnaXQgY2hlcnJ5LXBpY2sgNTIyNWZlMWUxOWM3NGY0ZDdhNGE0Y2M5OGZmNmVmNTg3MmM4
ZTYyMCANCsKgwqDCoMKgR2l0IGNoZXJyeS1waWNrIDBkMWEyMjZmNWMxODAxMmYxOWVkNmVhYmZh
YjQ2ZjBmMTI1ZWMxOTANCsKgwqBNYW51YWxseSBoYW5kbGUgcGF0Y2ggY29uZmxpY3RzIA0KMiBB
ZGQgYSBuZXcgZmxhZyAiRkFOX0VWRU5UX0lORk9fVElEIiBpbnRvIGZhbm90aWZ5X2RhdGEuZmxh
Z3MNCjMgSW5jb3Jwb3JhdGUgImJvb2wgYXVkaXQiIGludG8gZmFub3RpZnlfZGF0YS5mbGFncw0K
NCBTdWJtaXQgNCBwYXRjaGVzDQoNCnRoYW5rcw0K
