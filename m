Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7FDECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E159E2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 03:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E159E2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeIRIbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 04:31:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6421 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbeIRIbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 04:31:46 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 81E23E1D9BF53;
        Tue, 18 Sep 2018 11:01:15 +0800 (CST)
Received: from DGGEMM527-MBS.china.huawei.com ([169.254.5.129]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0399.000;
 Tue, 18 Sep 2018 11:01:13 +0800
From:   Nixiaoming <nixiaoming@huawei.com>
To:     Amir Goldstein <amir73il@gmail.com>,
        Steve Grubb <sgrubb@redhat.com>
CC:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] fanotify reports the thread id of the event trigger
Thread-Topic: [PATCH v2] fanotify reports the thread id of the event trigger
Thread-Index: AQHUTpfuO8h5GU9em0yW7M1mbnoXxaT0GT8AgAE/CbA=
Date:   Tue, 18 Sep 2018 03:01:13 +0000
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7B97FA@DGGEMM527-MBS.china.huawei.com>
References: <20180917141950.111841-1-nixiaoming@huawei.com>
 <CAOQ4uxj_o9FP8EH9_=TX=Tv9WDfExykrni7OjE3992YZrJDpZg@mail.gmail.com>
In-Reply-To: <CAOQ4uxj_o9FP8EH9_=TX=Tv9WDfExykrni7OjE3992YZrJDpZg@mail.gmail.com>
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

T24gTW9uLCBTZXAgMTcsIDIwMTggMTE6NTEgUE0gQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdt
YWlsLmNvbT4gd3JvdGU6DQo+T24gTW9uLCBTZXAgMTcsIDIwMTggYXQgNjowNSBQTSBuaXhpYW9t
aW5nIDxuaXhpYW9taW5nQGh1YXdlaS5jb20+IHdyb3RlOg0KPj4NCj4+IEluIG9yZGVyIHRvIGlk
ZW50aWZ5IHdoaWNoIHRocmVhZCB0cmlnZ2VyZWQgdGhlIGV2ZW50IGluIHRoZQ0KPj4gbXVsdGkt
dGhyZWFkZWQgcHJvZ3JhbSwgYWRkIHRoZSBGQU5fRVZFTlRfSU5GT19USUQgdGFnIGluIGZhbm90
aWZ5X2luaXQNCj4NCj5BY2NvcmRpbmcgdG8gY29kZSBhbmQgbWFuIHBhZ2UgdGhpcyBpcyBhICdm
bGFnJyBub3QgYSAndGFnJw0KPlBsZWFzZSBzdGljayB0byBleGlzdGluZyB0ZXJtaW5vbG9neS4N
Cj4NClRoYW5rIHlvdSBmb3IgeW91ciBndWlkYW5jZSwgSSB3aWxsIGNvcnJlY3QgaXQgaW4gYSBs
YXRlciBwYXRjaC4NCg0KPj4gdG8gc2VsZWN0IHdoZXRoZXIgdG8gcmVwb3J0IHRoZSBldmVudCBj
cmVhdG9yJ3MgdGhyZWFkIGlkIGluZm9ybWF0aW9uLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IG5p
eGlhb21pbmcgPG5peGlhb21pbmdAaHVhd2VpLmNvbT4NCi4uLi4uLi4NCj4+IEBAIC02OTMsOSAr
NjkzLDkgQEAgU1lTQ0FMTF9ERUZJTkUyKGZhbm90aWZ5X2luaXQsIHVuc2lnbmVkIGludCwgZmxh
Z3MsIHVuc2lnbmVkIGludCwgZXZlbnRfZl9mbGFncykNCj4+ICAgICAgICAgICAgICAgICByZXR1
cm4gLUVQRVJNOw0KPj4NCj4+ICAjaWZkZWYgQ09ORklHX0FVRElUU1lTQ0FMTA0KPj4gLSAgICAg
ICBpZiAoZmxhZ3MgJiB+KEZBTl9BTExfSU5JVF9GTEFHUyB8IEZBTl9FTkFCTEVfQVVESVQpKQ0K
Pj4gKyAgICAgICBpZiAoZmxhZ3MgJiB+KEZBTl9BTExfSU5JVF9GTEFHUyB8IEZBTl9FTkFCTEVf
QVVESVQgfCBGQU5fRVZFTlRfSU5GT19USUQpKQ0KPj4gICNlbHNlDQo+PiAtICAgICAgIGlmIChm
bGFncyAmIH5GQU5fQUxMX0lOSVRfRkxBR1MpDQo+PiArICAgICAgIGlmIChmbGFncyAmIH4oRkFO
X0FMTF9JTklUX0ZMQUdTIHwgRkFOX0VWRU5UX0lORk9fVElEKSkNCj4NCj5Ob3QgdGhpcyB3YXku
IFlvdSBuZWVkIHRvIGFkZCBGQU5fRVZFTlRfSU5GT19USUQgdG8gRkFOX0FMTF9JTklUX0ZMQUdT
Lg0KVGhhbmsgeW91IGZvciB5b3VyIGd1aWRhbmNlLCBJIHdpbGwgY29ycmVjdCBpdCBpbiBhIGxh
dGVyIHBhdGNoLg0KDQo+DQo+PiAgI2VuZGlmDQo+PiAgICAgICAgICAgICAgICAgcmV0dXJuIC1F
SU5WQUw7DQo+Pg0KPj4gQEAgLTczMSw2ICs3MzEsNyBAQCBTWVNDQUxMX0RFRklORTIoZmFub3Rp
ZnlfaW5pdCwgdW5zaWduZWQgaW50LCBmbGFncywgdW5zaWduZWQgaW50LCBldmVudF9mX2ZsYWdz
KQ0KPj4gICAgICAgICB9DQo+Pg0KPj4gICAgICAgICBncm91cC0+ZmFub3RpZnlfZGF0YS51c2Vy
ID0gdXNlcjsNCj4+ICsgICAgICAgZ3JvdXAtPmZhbm90aWZ5X2RhdGEuc2hvdWxkX3JlcG9ydF90
aWQgPSAoZmxhZ3MgJiBGQU5fRVZFTlRfSU5GT19USUQpID8gdHJ1ZSA6IGZhbHNlOw0KPg0KPlBs
ZWFzZSBkcm9wICI/IHRydWUgOiBmYWxzZSIgaXRzIG5vdCBuZWVkZWQuDQo+DQo+PiAgICAgICAg
IGF0b21pY19pbmMoJnVzZXItPmZhbm90aWZ5X2xpc3RlbmVycyk7DQo+PiAgICAgICAgIGdyb3Vw
LT5tZW1jZyA9IGdldF9tZW1fY2dyb3VwX2Zyb21fbW0oY3VycmVudC0+bW0pOw0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5X2JhY2tlbmQuaCBiL2luY2x1ZGUvbGlu
dXgvZnNub3RpZnlfYmFja2VuZC5oDQo+PiBpbmRleCBiOGY0MTgyLi40NGM2NTlmIDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9mc25vdGlmeV9iYWNrZW5kLmgNCj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvZnNub3RpZnlfYmFja2VuZC5oDQo+PiBAQCAtMTkzLDYgKzE5Myw3IEBAIHN0cnVj
dCBmc25vdGlmeV9ncm91cCB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBp
bnQgbWF4X21hcmtzOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHVzZXJfc3Ry
dWN0ICp1c2VyOw0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBhdWRpdDsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGJvb2wgc2hvdWxkX3JlcG9ydF90aWQ7DQo+DQo+Rm9yIGJy
ZXZpdHkgSSB3b3VsZCBjYWxsIHRoYXQgcmVwb3J0X3RpZCwgYnV0IG5vdCBpbnNpc3RpbmcuDQo+
DQoNCldoZXRoZXIgaXQgaXMgYmV0dGVyIHRvIGNoYW5nZSB0byAidW5zaWduZWQgaW50IGZsYWdz
Ig0KU2F2ZSAiZ3JvdXAtPmZhbm90aWZ5X2RhdGEuZmxhZ3M9ZmxhZ3M7IiBpbiAiZmFub3RpZnlf
aW5pdCINCkRldGVybWluZSB3aGV0aGVyICJncm91cC0+ZmFub3RpZnlfZGF0YS5mbGFncyIgY29u
dGFpbnMgIkZBTl9FVkVOVF9JTkZPX1RJRCIgaW4gImZhbm90aWZ5X2FsbG9jX2V2ZW50IjsNCg0K
QXQgdGhlIHNhbWUgdGltZSwgaWYgdGhlcmUgYXJlIG90aGVyIGZsYWdzIHRoYXQgbmVlZCB0byBi
ZSB1c2VkIGxhdGVyLCB0aGVyZSBpcyBubyBuZWVkIHRvIGFkZCBuZXcgbWVtYmVycy4NCg0KQnkg
dGhlIHdheSwgd2hldGhlciBvciBub3QgImJvb2wgYXVkaXQiIGNhbiBhbHNvIGJlIGluY2x1ZGVk
IGJ5IGZsYWdzDQoNCnRoYW5rcw0KDQoNCj4+ICAgICAgICAgICAgICAgICB9IGZhbm90aWZ5X2Rh
dGE7DQo+PiAgI2VuZGlmIC8qIENPTkZJR19GQU5PVElGWSAqLw0KPj4gICAgICAgICB9Ow0KPj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9mYW5vdGlmeS5oIGIvaW5jbHVkZS91YXBp
L2xpbnV4L2Zhbm90aWZ5LmgNCj4+IGluZGV4IDc0MjQ3OTEuLjRlYmE0MWMgMTAwNjQ0DQo+PiAt
LS0gYS9pbmNsdWRlL3VhcGkvbGludXgvZmFub3RpZnkuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L2Zhbm90aWZ5LmgNCj4+IEBAIC0xOCw2ICsxOCw3IEBADQo+Pg0KPj4gICNkZWZpbmUg
RkFOX09ORElSICAgICAgICAgICAgICAweDQwMDAwMDAwICAgICAgLyogZXZlbnQgb2NjdXJyZWQg
YWdhaW5zdCBkaXIgKi8NCj4+DQo+PiArI2RlZmluZSBGQU5fRVZFTlRfSU5GT19USUQgICAgIDB4
MDIwMDAwMDAgICAgICAvKiByZXBvcnRzIHRoZSB0aHJlYWQgaWQgb2YgdGhlIGV2ZW50IHRyaWdn
ZXIgKi8NCj4NCj5UaGF0IGlzIG5vdCB0aGUgcmlnaHQgcGxhY2Ugbm9yIHRoZSBzZW5zaWJsZSB2
YWx1ZSBmb3IgdGhpcyBmbGFnLCBidXQgdGhpczoNCj4NCj4jZGVmaW5lIEZBTl9VTkxJTUlURURf
UVVFVUUgICAgIDB4MDAwMDAwMTANCj4jZGVmaW5lIEZBTl9VTkxJTUlURURfTUFSS1MgICAgIDB4
MDAwMDAwMjANCj4jZGVmaW5lIEZBTl9FTkFCTEVfQVVESVQgICAgICAgIDB4MDAwMDAwNDANCj4r
I2RlZmluZSBGQU5fRVZFTlRfSU5GT19USUQgICAgIDB4MDAwMDAwODANCj4NCj5UaGFua3MsDQo+
QW1pci4NCj4NCg==
