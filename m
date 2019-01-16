Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28313C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0049720675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 03:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfAPDAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 22:00:23 -0500
Received: from smtpbgsg2.qq.com ([54.254.200.128]:51683 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbfAPDAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 22:00:22 -0500
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: CaOyJLkxpPnx61D352dvXIWnMUSC/YUqnJQcOILfRgADW3I8/c9vBsquJz1Jb
        DK7JnuuIbPVSs7qeTORBPZSZoDbaNdSBMtErP2fw+NBovf24kJ8c24QiiZyIuNsHz0DjEY9
        qFaIDf1SGYiWXocDB5Ey9Pql4fto7hATn4yNWfvXgADhVJAEk36nqIxFnODlh4/DQnJqAlG
        7wbSOLQ6fGpc4g2UI1TmapX+tloni45wtWKV+4DaNHxNjxWxtunfNmvvmuczlydsRBX9azu
        /TWJmzIaL0EG0UMktuRdg28xE=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1547607607t83862
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?VGhvbWFzIEdsZWl4bmVy?=" <tglx@linutronix.de>
Cc:     "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?Q2hyaXN0b3BoIEhlbGx3aWc=?=" <hch@lst.de>,
        "=?utf-8?B?TWljaGFlbCBIZXJuYW5kZXo=?=" <michael.hernandez@cavium.com>
Subject: Re: [PATCH] genirq/affinity: Assign default affinity to pre/post vectors
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Wed, 16 Jan 2019 11:00:07 +0800
X-Priority: 3
Message-ID: <tencent_7CB943266ADCFDB06DDDE6EF@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1546225404-6775-1-git-send-email-chenhc@lemote.com>
        <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1901151959060.1655@nanos.tec.linutronix.de>
X-QQ-ReplyHash: 3970353298
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Wed, 16 Jan 2019 11:00:10 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFRob21hcywNCg0KSSdtIG5vdCByZW1vdmluZyBhbGwgcmV0dXJuIE5VTEwgb2YgIGly
cV9jcmVhdGVfYWZmaW5pdHlfbWFza3MoKSwgc28gdGhlIG1lbW9yeSBhbGxvY2F0aW9uIGZh
aWx1cmUgc3RpbGwgcmV0dXJuIE5VTEwuIEkganVzdCBoYW5kbGUgdGhlIGNhc2UgdGhhdCB0
aGVyZSBhcmUgbm90IGVub3VnaCBpcnEgdmVjdG9ycy4gRS5nLiBpbiBudm1lIGRyaXZlciwg
dGhlIGNhbGxlciBtYXkgY2FsbCBpcnFfY3JlYXRlX2FmZmluaXR5X21hc2tzKCkgd2l0aCBu
dmVjcz0xLHByZV92ZWN0b3JzPTEscG9zdF92ZWN0b3JzPTAuIEluIHRoaXMgY2FzZSwgdGhl
IG9ubHkgb25lIHZlY3RvcidzIGRlZmF1bHQgYWZmaW5pdHkgYXNzaWduaW5nIGlzIHNraXBw
ZWQuDQoNCkh1YWNhaSANCg0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0t
LS0tLS0tLS0tLQ0KRnJvbTogICJUaG9tYXMgR2xlaXhuZXIiPHRnbHhAbGludXRyb25peC5k
ZT47DQpEYXRlOiAgV2VkLCBKYW4gMTYsIDIwMTkgMDM6MTAgQU0NClRvOiAgIkh1YWNhaSBD
aGVuIjxjaGVuaGNAbGVtb3RlLmNvbT47DQpDYzogICJsaW51eC1rZXJuZWwiPGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyAiRnV4aW4gWmhhbmciPHpoYW5nZnhAbGVtb3RlLmNv
bT47ICJ3dXpoYW5namluIjx3dXpoYW5namluQGdtYWlsLmNvbT47ICJzdGFibGUiPHN0YWJs
ZUB2Z2VyLmtlcm5lbC5vcmc+OyAiQ2hyaXN0b3BoIEhlbGx3aWciPGhjaEBsc3QuZGU+OyAi
TWljaGFlbCBIZXJuYW5kZXoiPG1pY2hhZWwuaGVybmFuZGV6QGNhdml1bS5jb20+Ow0KU3Vi
amVjdDogIFJlOiBbUEFUQ0hdIGdlbmlycS9hZmZpbml0eTogQXNzaWduIGRlZmF1bHQgYWZm
aW5pdHkgdG8gcHJlL3Bvc3QgdmVjdG9ycw0KIA0KT24gTW9uLCAzMSBEZWMgMjAxOCwgSHVh
Y2FpIENoZW4gd3JvdGU6DQoNCj4gR2VuZXJhbGx5LCBpcnFfY3JlYXRlX2FmZmluaXR5X21h
c2tzKCkgYXNzaWduIGRlZmF1bHQgYWZmaW5pdHkgdG8gcHJlLw0KPiBwb3N0IHZlY3RvcnMg
Y29ycmVjdGx5LiBIb3dldmVyLCBpdCBpZ25vcmUgdGhlIGNhc2UgdGhhdCB0aGVyZSBhcmUg
b25seQ0KPiBwcmUvcG9zdCB2ZWN0b3JzICh3aGVuIG52ZWNzID09IGFmZmQtPnByZV92ZWN0
b3JzICsgYWZmZC0+cG9zdF92ZWN0b3JzKQ0KPiBhbmQgcmV0dXJuIE5VTEwuIFRoaXMgY2Fz
ZSB1c3VhbGx5IGhhcHBlbnMgd2hlbiBudmVjcyA9IDEgKGUuZy4gaW4gbnZtZQ0KPiBkcml2
ZXIgd2hlbiBNU0ktWCBpcyB1bmF2YWlsYWJsZSBhbmQgZmFsbGJhY2sgdG8gTVNJKSBhbmQg
d2lsbCB0cmlnZ2VyDQo+IHRoZSB3YXJuaW5nIGluIHBjaV9pcnFfZ2V0X2FmZmluaXR5KCku
IFRoaXMgcGF0Y2ggZml4IHRoZSBjb3JuZXIgY2FzZS4NCg0KRXJybS4gVGhpcyBpcyBqdXN0
IHdyb25nLiBXaGVuIHRoaXMgZnVuY3Rpb24gcmV0dXJucyBOVUxMLCB0aGVuIGl0IGhhcw0K
ZmFpbGVkIGFuZCB0aGUgY2FsbGVyIG9yIGFueSBzdWJzZXF1ZW50IGNvZGUgaXMgbm90IHN1
cHBvc2VkIHRvIHVzZSB0aGUNCnJlc3VsdC4NCg0KVGhlIGZ1bmN0aW9uIGNhbiByZXR1cm4g
TlVMTCBmb3Igb3RoZXIgcmVhc29ucywgZS5nLiB3aGVuIHRoZSBtZW1vcnkNCmFsbG9jYXRp
b24gZmFpbGVkLiBIb3cgYXJlIHlvdSBnb2luZyB0byBkdWN0IHRhcGUgdGhhdCBvbmU/DQoN
ClRoYW5rcywNCg0KdGdseA==



