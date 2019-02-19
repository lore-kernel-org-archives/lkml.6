Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D785CC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2517217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfBSGir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:38:47 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbfBSGir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:38:47 -0500
Received: from DGGEMA406-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id CD717C7C7DF96631330A;
        Tue, 19 Feb 2019 14:38:40 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.64]) by
 DGGEMA406-HUB.china.huawei.com ([10.3.20.47]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 14:38:33 +0800
From:   "chenzefeng (A)" <chenzefeng2@huawei.com>
To:     Petr Mladek <pmladek@suse.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xiexiuqi <xiexiuqi@huawei.com>
Subject: Re:[PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Thread-Topic: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Thread-Index: AdTIHKxCpDuP5Ci5SDaFfReWrKHLcw==
Date:   Tue, 19 Feb 2019 06:38:33 +0000
Message-ID: <79A62BFA453EFB42B7A4E40AD8F3A2264F2AA4FE@DGGEMA503-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.50.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uIDIwMTktMDItMTggMTc6MjIsIFBldHIgd3JvdGU6DQoNCj4gT24gTW9uIDIwMTktMDIt
MTggMTM6Mjk6MTEsIGNoZW5namlhbiAoRCkgd3JvdGU6DQo+ID4gSGnvvIxKaXJpDQo+ID4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggc2hvdWxkIGJlIG1lcmdlZCBpbnRvIDQuNCBzdGFibGUsDQo+ID4N
Cj4gPiB3aGljaCBzdGlsbCB1c2Uga2xwX3dyaXRlX21vZHVsZV9yZWxvYy4NCj4gPg0KPiA+DQo+
ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjQuNC4xNzQvc291cmNlL2FyY2gv
eDg2L2tlcm5lbC9saXZlcA0KPiA+IGF0Y2guYw0KPiA+DQo+ID4NCj4gPiBaZUZlbmcgbWF5IGhh
dmUgc2VudCBhIHN0YWJsZSg0LjQteSkgcGF0Y2ggdG8gdGhlIHdyb25nIG1haWwtbGlzdChtYWlu
bGluZSkuDQo+IA0KPiBaZUZlbmcgb3IgQ2hlbmdqaWFuLCBwbGVhc2UsIHNlbmQgdGhlIHBhdGNo
IG9uY2UgYWdhaW4gd2l0aCBzdGFibGVAdmdlci5rZXJuZWwub3JnIGluIENDIGFuZCBleHBsYW5h
dGlvbiB0aGF0IGl0IGlzIG5lZWRlZCBvbmx5IGZvciA0LjQgYW5kIHdoeS4NCj4gDQo+IFRoaXMg
dGhyZWFkIGlzIGFscmVhZHkgdG9vIGxvbmcgYW5kIG1lc3NlZCB0byBiZSBwcm9jZWVkIGJ5IHN0
YWJsZSBwZW9wbGUgZWZmZWN0aXZlbHkuDQo+DQo+IEJlc3QgUmVnYXJkcywNCj4gUGV0cg0KDQpP
biB4ODYtNjQsIGZvciAzMi1iaXQgUEMtcmVsYWNpdmUgYnJhbmNoZXMsIHdlIGNhbiBnZW5lcmF0
ZSBQTFQzMiByZWxvY2F0aW9uLCBpbnN0ZWFkIG9mIFBDMzIgcmVsb2NhdGlvbi4gYW5kIFJfWDg2
XzY0X1BMVDMyIGNhbiBiZSB0cmVhdGVkIHRoZSBzYW1lIGFzIFJfWDg2XzY0X1BDMzIgc2luY2Ug
bGludXgga2VybmVsIGRvZXNuJ3QgdXNlIFBMVC4NCg0KY29tbWl0IGIyMWViZjJmYjRjZCAoIng4
NjogVHJlYXQgUl9YODZfNjRfUExUMzIgYXMgUl9YODZfNjRfUEMzMiIpIGJlZW4gZml4ZWQgZm9y
IHRoZSBtb2R1bGUgbG9hZGluZywgYnV0IG5vdCBmaXhlZCBmb3IgbGl2ZXBhdGNoIHJlbG9jYXRp
b24sIHdoaWNoIHdpbGwgZmFpbCB0byBsb2FkIGxpdmVwYXRjaCB3aXRoIHRoZSBlcnJvciBtZXNz
YWdlIGFzIGZvbGxvdzoNCnJlbG9jYXRpb24gZmFpbGVkIGZvciBzeW1ib2wgPHN5bWJvbCBuYW1l
PiBhdCA8c3ltYm9sIGFkZHJlc3M+DQoNClRoaXMgaXNzdWUgb25seSBlZmZhY3RlZCB0aGUga2Vy
bmVsIHZlcnNpb24gZnJvbSA0LjAgdG8gNC42LCBiZWNhdWNlIHRoZSBmdW5jdGlvbiBrbHBfd3Jp
dGVfbW9kdWxlX3JlbG9jIGlzIGludHJvZHVjZWQgYnk6DQpjb21taXQgYjcwMGU3ZjAzZGY1ICgi
bGl2ZXBhdGNoOiBrZXJuZWw6IGFkZCBzdXBwb3J0IGZvciBsaXZlIHBhdGNoaW5nIikgYW5kIGRl
bGV0ZWQgYnk6IGNvbW1pdCA0MjU1OTVhN2ZjMjANCigibGl2ZXBhdGNoOiByZXVzZSBtb2R1bGUg
bG9hZGVyIGNvZGUgdG8gd3JpdGUgcmVsb2NhdGlvbnMiKQ0KDQpTaWduZWQtb2ZmLWJ5OiBjaGVu
emVmZW5nIDxjaGVuemVmZW5nMkBodWF3ZWkuY29tPg0KLS0tDQogYXJjaC94ODYva2VybmVsL2xp
dmVwYXRjaC5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYg
LS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvbGl2ZXBhdGNoLmMgYi9hcmNoL3g4Ni9rZXJuZWwvbGl2
ZXBhdGNoLmMgaW5kZXggZDFkMzVjYy4uNTc5ZjhmOCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tl
cm5lbC9saXZlcGF0Y2guYw0KKysrIGIvYXJjaC94ODYva2VybmVsL2xpdmVwYXRjaC5jDQpAQCAt
NTgsNiArNTgsNyBAQCBpbnQga2xwX3dyaXRlX21vZHVsZV9yZWxvYyhzdHJ1Y3QgbW9kdWxlICpt
b2QsIHVuc2lnbmVkIGxvbmcgdHlwZSwNCiAJCXZhbCA9IChzMzIpdmFsdWU7DQogCQlicmVhazsN
CiAJY2FzZSBSX1g4Nl82NF9QQzMyOg0KKwljYXNlIFJfWDg2XzY0X1BMVDMyOg0KIAkJdmFsID0g
KHUzMikodmFsdWUgLSBsb2MpOw0KIAkJYnJlYWs7DQogCWRlZmF1bHQ6DQotLQ0KMS44LjUuNg0K
DQoNCg==
