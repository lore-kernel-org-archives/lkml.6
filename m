Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487D72077B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfBSIQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:16:50 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2505 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfBSIQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:16:49 -0500
Received: from DGGEMA402-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 7726650D7C7325BAB31B;
        Tue, 19 Feb 2019 16:16:44 +0800 (CST)
Received: from DGGEMA422-HUB.china.huawei.com (10.1.198.155) by
 DGGEMA402-HUB.china.huawei.com (10.3.20.43) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 19 Feb 2019 16:16:43 +0800
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.64]) by
 dggema422-hub.china.huawei.com ([10.1.198.155]) with mapi id 14.03.0399.000;
 Tue, 19 Feb 2019 16:16:36 +0800
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
Subject: Re: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Thread-Topic: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Thread-Index: AdTIKsBW2gpAWHtWSgWckva/AXbo3Q==
Date:   Tue, 19 Feb 2019 08:16:36 +0000
Message-ID: <79A62BFA453EFB42B7A4E40AD8F3A2264F2AA52F@DGGEMA503-MBX.china.huawei.com>
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

SGksDQoNCkkgYW0gc29ycnkgdGhpcyBlbWFpbCB3YXMgc2VudCBieSBhY2NpZGVudC4gUGxlYXNl
IGlnbm9yZSB0aGlzIGVtYWlsLg0KDQpCZXN0IFJlZ2FyZHMNCg0KDQoNCi0tLS0t6YKu5Lu25Y6f
5Lu2LS0tLS0NCuWPkeS7tuS6ujogY2hlbnplZmVuZyAoQSkgDQrlj5HpgIHml7bpl7Q6IDIwMTnl
ubQy5pyIMTnml6UgMTQ6MzgNCuaUtuS7tuS6ujogJ1BldHIgTWxhZGVrJyA8cG1sYWRla0BzdXNl
LmNvbT47IGNoZW5namlhbiAoRCkgPGNqLmNoZW5namlhbkBodWF3ZWkuY29tPg0K5oqE6YCBOiAn
c3RhYmxlQHZnZXIua2VybmVsLm9yZycgPHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+OyBKaXJpIEtv
c2luYSA8amlrb3NAa2VybmVsLm9yZz47IGhqbC50b29sc0BnbWFpbC5jb207IGpwb2ltYm9lQHJl
ZGhhdC5jb207IHNqZW5uaW5nQHJlZGhhdC5jb207IHZvanRlY2hAc3VzZS5jb207IHRnbHhAbGlu
dXRyb25peC5kZTsgbWluZ29AcmVkaGF0LmNvbTsgaHBhQHp5dG9yLmNvbTsgZ3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc7IHg4NkBrZXJuZWwub3JnOyBsaXZlLXBhdGNoaW5nQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgWGlleGl1cWkgPHhpZXhpdXFpQGh1
YXdlaS5jb20+DQrkuLvpopg6IFJlOltQQVRDSF0geDg2OiBsaXZlcGF0Y2g6IFRyZWF0IFJfWDg2
XzY0X1BMVDMyIGFzIFJfWDg2XzY0X1BDMzINCg0KT24gTW9uIDIwMTktMDItMTggMTc6MjIsIFBl
dHIgd3JvdGU6DQoNCj4gT24gTW9uIDIwMTktMDItMTggMTM6Mjk6MTEsIGNoZW5namlhbiAoRCkg
d3JvdGU6DQo+ID4gSGnvvIxKaXJpDQo+ID4NCj4gPg0KPiA+IFRoaXMgcGF0Y2ggc2hvdWxkIGJl
IG1lcmdlZCBpbnRvIDQuNCBzdGFibGUsDQo+ID4NCj4gPiB3aGljaCBzdGlsbCB1c2Uga2xwX3dy
aXRlX21vZHVsZV9yZWxvYy4NCj4gPg0KPiA+DQo+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjQuNC4xNzQvc291cmNlL2FyY2gveDg2L2tlcm5lbC9saXZlcA0KPiA+IGF0Y2gu
Yw0KPiA+DQo+ID4NCj4gPiBaZUZlbmcgbWF5IGhhdmUgc2VudCBhIHN0YWJsZSg0LjQteSkgcGF0
Y2ggdG8gdGhlIHdyb25nIG1haWwtbGlzdChtYWlubGluZSkuDQo+IA0KPiBaZUZlbmcgb3IgQ2hl
bmdqaWFuLCBwbGVhc2UsIHNlbmQgdGhlIHBhdGNoIG9uY2UgYWdhaW4gd2l0aCBzdGFibGVAdmdl
ci5rZXJuZWwub3JnIGluIENDIGFuZCBleHBsYW5hdGlvbiB0aGF0IGl0IGlzIG5lZWRlZCBvbmx5
IGZvciA0LjQgYW5kIHdoeS4NCj4gDQo+IFRoaXMgdGhyZWFkIGlzIGFscmVhZHkgdG9vIGxvbmcg
YW5kIG1lc3NlZCB0byBiZSBwcm9jZWVkIGJ5IHN0YWJsZSBwZW9wbGUgZWZmZWN0aXZlbHkuDQo+
DQo+IEJlc3QgUmVnYXJkcywNCj4gUGV0cg0KDQpPbiB4ODYtNjQsIGZvciAzMi1iaXQgUEMtcmVs
YWNpdmUgYnJhbmNoZXMsIHdlIGNhbiBnZW5lcmF0ZSBQTFQzMiByZWxvY2F0aW9uLCBpbnN0ZWFk
IG9mIFBDMzIgcmVsb2NhdGlvbi4gYW5kIFJfWDg2XzY0X1BMVDMyIGNhbiBiZSB0cmVhdGVkIHRo
ZSBzYW1lIGFzIFJfWDg2XzY0X1BDMzIgc2luY2UgbGludXgga2VybmVsIGRvZXNuJ3QgdXNlIFBM
VC4NCg0KY29tbWl0IGIyMWViZjJmYjRjZCAoIng4NjogVHJlYXQgUl9YODZfNjRfUExUMzIgYXMg
Ul9YODZfNjRfUEMzMiIpIGJlZW4gZml4ZWQgZm9yIHRoZSBtb2R1bGUgbG9hZGluZywgYnV0IG5v
dCBmaXhlZCBmb3IgbGl2ZXBhdGNoIHJlbG9jYXRpb24sIHdoaWNoIHdpbGwgZmFpbCB0byBsb2Fk
IGxpdmVwYXRjaCB3aXRoIHRoZSBlcnJvciBtZXNzYWdlIGFzIGZvbGxvdzoNCnJlbG9jYXRpb24g
ZmFpbGVkIGZvciBzeW1ib2wgPHN5bWJvbCBuYW1lPiBhdCA8c3ltYm9sIGFkZHJlc3M+DQoNClRo
aXMgaXNzdWUgb25seSBlZmZhY3RlZCB0aGUga2VybmVsIHZlcnNpb24gZnJvbSA0LjAgdG8gNC42
LCBiZWNhdWNlIHRoZSBmdW5jdGlvbiBrbHBfd3JpdGVfbW9kdWxlX3JlbG9jIGlzIGludHJvZHVj
ZWQgYnk6DQpjb21taXQgYjcwMGU3ZjAzZGY1ICgibGl2ZXBhdGNoOiBrZXJuZWw6IGFkZCBzdXBw
b3J0IGZvciBsaXZlIHBhdGNoaW5nIikgYW5kIGRlbGV0ZWQgYnk6IGNvbW1pdCA0MjU1OTVhN2Zj
MjANCigibGl2ZXBhdGNoOiByZXVzZSBtb2R1bGUgbG9hZGVyIGNvZGUgdG8gd3JpdGUgcmVsb2Nh
dGlvbnMiKQ0KDQpTaWduZWQtb2ZmLWJ5OiBjaGVuemVmZW5nIDxjaGVuemVmZW5nMkBodWF3ZWku
Y29tPg0KLS0tDQogYXJjaC94ODYva2VybmVsL2xpdmVwYXRjaC5jIHwgMSArDQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvbGl2
ZXBhdGNoLmMgYi9hcmNoL3g4Ni9rZXJuZWwvbGl2ZXBhdGNoLmMgaW5kZXggZDFkMzVjYy4uNTc5
ZjhmOCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9saXZlcGF0Y2guYw0KKysrIGIvYXJj
aC94ODYva2VybmVsL2xpdmVwYXRjaC5jDQpAQCAtNTgsNiArNTgsNyBAQCBpbnQga2xwX3dyaXRl
X21vZHVsZV9yZWxvYyhzdHJ1Y3QgbW9kdWxlICptb2QsIHVuc2lnbmVkIGxvbmcgdHlwZSwNCiAJ
CXZhbCA9IChzMzIpdmFsdWU7DQogCQlicmVhazsNCiAJY2FzZSBSX1g4Nl82NF9QQzMyOg0KKwlj
YXNlIFJfWDg2XzY0X1BMVDMyOg0KIAkJdmFsID0gKHUzMikodmFsdWUgLSBsb2MpOw0KIAkJYnJl
YWs7DQogCWRlZmF1bHQ6DQotLQ0KMS44LjUuNg0KDQoNCg==
