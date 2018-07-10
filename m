Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20914C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38DD2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38DD2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933229AbeGJLwr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:52:47 -0400
Received: from smtpbg328.qq.com ([14.17.43.160]:37913 "EHLO smtpbg328.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932710AbeGJLwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:52:45 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Jul 2018 07:52:44 EDT
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: EdayP7/cfZDMMq9zCJa/MxbqdsqPPWbiyxDMMmTX56ldfil4bX+i+onz7026S
        ItRly2mWD1uYOMCUwqfQxoO/vvCx56WHOcLUfSQtR5kJFhCoBiIIc+Hg3zEMJpYgcSX0sYg
        fymj2uoiX3csvPR7igyaiz2kW6qoTs6C591Aqf5YCXQwZQlzNm2QZES2YffFX9HqyAi7lCP
        qBR7woteDXlqAuYTWTM8TYUlMi8vMcjYn1Za5zH40XEXmVf1Zg4t6vayCKsSnO9hoOT191T
        rHDJLKpomu+3k+ASQQGEhIJIMPm/q3ARH33A==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 121.238.154.171
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1531223122t79535
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?UGV0ZXIgWmlqbHN0cmE=?=" <peterz@infradead.org>
Cc:     "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>,
        "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <jhogan@kernel.org>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?QWxhbiBTdGVybg==?=" <stern@rowland.harvard.edu>,
        "=?utf-8?B?QW5kcmVhIFBhcnJp?=" <andrea.parri@amarulasolutions.com>,
        "=?utf-8?B?V2lsbCBEZWFjb24=?=" <will.deacon@arm.com>,
        "=?utf-8?B?Qm9xdW4gRmVuZw==?=" <boqun.feng@gmail.com>,
        "=?utf-8?B?TmljaG9sYXMgUGlnZ2lu?=" <npiggin@gmail.com>,
        "=?utf-8?B?RGF2aWQgSG93ZWxscw==?=" <dhowells@redhat.com>,
        "=?utf-8?B?SmFkZSBBbGdsYXZl?=" <j.alglave@ucl.ac.uk>,
        "=?utf-8?B?THVjIE1hcmFuZ2V0?=" <luc.maranget@inria.fr>,
        "=?utf-8?B?UGF1bCBFLiBNY0tlbm5leQ==?=" <paulmck@linux.vnet.ibm.com>,
        "=?utf-8?B?QWtpcmEgWW9rb3Nhd2E=?=" <akiyks@gmail.com>,
        "=?utf-8?B?TEtNTA==?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 10 Jul 2018 19:45:22 +0800
X-Priority: 3
Message-ID: <tencent_26F8B9E004D4512B2225FCE1@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
        <20180709164939.uhqsvcv4a7jlbhvp@pburton-laptop>
        <CAAhV-H7bqhz+dzgPk0_tTAN6y_k_8Ds9heF0p5uPHsHNg0v4Rg@mail.gmail.com>
        <20180710093637.GF2476@hirez.programming.kicks-ass.net>
        <20180710105437.GT2512@hirez.programming.kicks-ass.net>
In-Reply-To: <20180710105437.GT2512@hirez.programming.kicks-ass.net>
X-QQ-ReplyHash: 3233511450
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Tue, 10 Jul 2018 19:45:24 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb19
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyLA0KDQpJJ20gYWZyYWlkIHRoYXQgeW91IGhhdmUgbWlzc2luZyBzb21ldGhp
bmcuLi4uLi4NCg0KRmlyc3RseSwgb3VyIHByZXZpb3VzIGNvbmNsdXNpb24gKFJFQURfT05D
RSBuZWVkIGEgYmFycmllciB0byBhdm9pZCAncmVhZHMgcHJpb3JpdGlzZWQgb3ZlciB3cml0
ZXMnKSBpcyB0b3RhbGx5IHdyb25nLiBTbyBkZWZpbmUgY3B1X3JlbGF4KCkgdG8gc21wX21i
KCkgbGlrZSBBUk0xMU1QQ29yZSBpcyBpbmNvcnJlY3QsIGV2ZW4gaWYgaXQgY2FuICdzb2x2
ZScgTG9vbmdzb24ncyBwcm9ibGVtLg0KU2Vjb25kbHksIEkgdGhpbmsgdGhlIHJlYWwgcHJv
YmxlbSBpcyBsaWtlIHRoaXM6DQogMSwgQ1BVMCBzZXQgdGhlIGxvY2sgdG8gMCwgdGhlbiBk
byBzb21ldGhpbmc7DQogMiwgV2hpbGUgQ1BVMCBpcyBkb2luZyBzb21ldGhpbmcsIENQVTEg
c2V0IHRoZSBmbGFnIHRvIDEgd2l0aCBXUklURV9PTkNFKCksIGFuZCB0aGVuIHdhaXQgdGhl
IGxvY2sgYmVjb21lIHRvIDEgd2l0aCBhIFJFQURfT05DRSgpIGxvb3A7DQogMywgQWZ0ZXIg
Q1BVMCBjb21wbGV0ZSBpdHMgd29yaywgaXQgd2FpdCB0aGUgZmxhZyBiZWNvbWUgdG8gMSwg
YW5kIGlmIHNvIHRoZW4gc2V0IHRoZSBsb2NrIHRvIDE7IA0KIDQsIElmIHRoZSBsb2NrIGJl
Y29tZXMgdG8gMSwgQ1BVMSB3aWxsIGxlYXZlIHRoZSBSRUFEX09OQ0UoKSBsb29wLg0KSWYg
d2l0aG91dCBTRkIsIGV2ZXJ5dGhpbmcgaXMgT0suIEJ1dCB3aXRoIFNGQiBpbiBzdGVwIDIs
IGEgUkVBRF9PTkNFKCkgbG9vcCBpcyByaWdodCBhZnRlciBXUklURV9PTkNFKCksIHdoaWNo
IG1ha2VzIHRoZSBmbGFnIGNhY2hlZCBpbiBTRkIgKHNvIGJlIGludmlzaWJsZSBieSBvdGhl
ciBDUFVzKSBmb3IgZXZlciwgdGhlbiBib3RoIENQVTAgYW5kIENQVTEgd2FpdCBmb3IgZXZl
ci4NCg0KSSBkb24ndCB0aGluayB0aGlzIGlzIGEgaGFyZHdhcmUgYnVnLCBpbiBkZXNpZ24s
IFNGQiB3aWxsIGZsdXNoZWQgdG8gTDEgY2FjaGUgaW4gdGhyZWUgY2FzZXM6DQoxLCBkYXRh
IGluIFNGQiBpcyBmdWxsIChiZSBhIGNvbXBsZXRlIGNhY2hlIGxpbmUpOw0KMiwgdGhlcmUg
aXMgYSBzdWJzZXF1ZW50IHJlYWQgYWNjZXNzIGluIHRoZSBzYW1lIGNhY2hlIGxpbmU7DQoz
LCBhICdzeW5jJyBpbnN0cnVjdGlvbiBpcyBleGVjdXRlZC4NCg0KSW4gdGhpcyBjYXNlLCB0
aGVyZSBpcyBubyBvdGhlciBtZW1vcnkgYWNjZXNzIChyZWFkIG9yIHdyaXRlKSBiZXR3ZWVu
IFdSSVRFX09OQ0UoKSBhbmQgUkVBRF9PTkNFKCkgbG9vcC4gU28gQ2FzZSAxIGFuZCBDYXNl
IDIgd2lsbCBub3QgaGFwcGVuLCBhbmQgdGhlIG9ubHkgd2F5IHRvIG1ha2UgdGhlIGZsYWcg
YmUgdmlzaWJsZSBpcyB3YmZsdXNoICh3YmZsdXNoIGlzIHN5bmMgaW4gTG9vbmdzb24ncyBj
YXNlKS4NCg0KSSB0aGluayB0aGlzIHByb2JsZW0gaXMgbm90IG9ubHkgaGFwcGVucyBvbiBM
b29uZ3NvbiwgYnV0IHdpbGwgaGFwcGVuIG9uIG90aGVyIENQVXMgd2hpY2ggaGF2ZSB3cml0
ZSBidWZmZXIgKHVubGVzcyB0aGUgd3JpdGUgYnVmZmVyIGhhcyBhIDR0aCBjYXNlIHRvIGJl
IGZsdXNoZWQpLg0KDQpIdWFjYWkNCiANCi0tLS0tLS0tLS0tLS0tLS0tLSBPcmlnaW5hbCAt
LS0tLS0tLS0tLS0tLS0tLS0NCkZyb206ICAiUGV0ZXIgWmlqbHN0cmEiPHBldGVyekBpbmZy
YWRlYWQub3JnPjsNCkRhdGU6ICBUdWUsIEp1bCAxMCwgMjAxOCAwNjo1NCBQTQ0KVG86ICAi
SHVhY2FpIENoZW4iPGNoZW5oY0BsZW1vdGUuY29tPjsNCkNjOiAgIlBhdWwgQnVydG9uIjxw
YXVsLmJ1cnRvbkBtaXBzLmNvbT47ICJSYWxmIEJhZWNobGUiPHJhbGZAbGludXgtbWlwcy5v
cmc+OyAiSmFtZXMgSG9nYW4iPGpob2dhbkBrZXJuZWwub3JnPjsgImxpbnV4LW1pcHMiPGxp
bnV4LW1pcHNAbGludXgtbWlwcy5vcmc+OyAiRnV4aW4gWmhhbmciPHpoYW5nZnhAbGVtb3Rl
LmNvbT47ICJ3dXpoYW5namluIjx3dXpoYW5namluQGdtYWlsLmNvbT47ICJzdGFibGUiPHN0
YWJsZUB2Z2VyLmtlcm5lbC5vcmc+OyAiQWxhbiBTdGVybiI8c3Rlcm5Acm93bGFuZC5oYXJ2
YXJkLmVkdT47ICJBbmRyZWEgUGFycmkiPGFuZHJlYS5wYXJyaUBhbWFydWxhc29sdXRpb25z
LmNvbT47ICJXaWxsIERlYWNvbiI8d2lsbC5kZWFjb25AYXJtLmNvbT47ICJCb3F1biBGZW5n
Ijxib3F1bi5mZW5nQGdtYWlsLmNvbT47ICJOaWNob2xhcyBQaWdnaW4iPG5waWdnaW5AZ21h
aWwuY29tPjsgIkRhdmlkIEhvd2VsbHMiPGRob3dlbGxzQHJlZGhhdC5jb20+OyAiSmFkZSBB
bGdsYXZlIjxqLmFsZ2xhdmVAdWNsLmFjLnVrPjsgIkx1YyBNYXJhbmdldCI8bHVjLm1hcmFu
Z2V0QGlucmlhLmZyPjsgIlBhdWwgRS4gTWNLZW5uZXkiPHBhdWxtY2tAbGludXgudm5ldC5p
Ym0uY29tPjsgIkFraXJhIFlva29zYXdhIjxha2l5a3NAZ21haWwuY29tPjsgIkxLTUwiPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+Ow0KU3ViamVjdDogIFJlOiBbUEFUQ0ggVjJd
IE1JUFM6IGltcGxlbWVudCBzbXBfY29uZF9sb2FkX2FjcXVpcmUoKSBmb3IgTG9vbmdzb24t
Mw0KIA0KT24gVHVlLCBKdWwgMTAsIDIwMTggYXQgMTE6MzY6MzdBTSArMDIwMCwgUGV0ZXIg
WmlqbHN0cmEgd3JvdGU6DQoNCj4gU28gbm93IGV4cGxhaW4gd2h5IHRoZSBjcHVfcmVsYXgo
KSBoYWNrIHRoYXQgYXJtIGRpZCBkb2Vzbid0IHdvcmsgZm9yDQo+IHlvdT8NCg0KU28gYmVs
b3cgaXMgdGhlIHBhdGNoIEkgdGhpbmsgeW91IHdhbnQ7IGlmIG5vdCBleHBsYWluIGluIGRl
dGFpbCBob3cNCnRoaXMgaXMgd3JvbmcuDQoNCmRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5j
bHVkZS9hc20vcHJvY2Vzc29yLmggYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vcHJvY2Vzc29y
LmgNCmluZGV4IGFmMzRhZmJjMzJkOS4uZTU5NzczZGU2NTI4IDEwMDY0NA0KLS0tIGEvYXJj
aC9taXBzL2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQorKysgYi9hcmNoL21pcHMvaW5jbHVk
ZS9hc20vcHJvY2Vzc29yLmgNCkBAIC0zODYsNyArMzg2LDE3IEBAIHVuc2lnbmVkIGxvbmcg
Z2V0X3djaGFuKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCk7DQogI2RlZmluZSBLU1RLX0VTUCh0
c2spICh0YXNrX3B0X3JlZ3ModHNrKS0+cmVnc1syOV0pDQogI2RlZmluZSBLU1RLX1NUQVRV
Uyh0c2spICh0YXNrX3B0X3JlZ3ModHNrKS0+Y3AwX3N0YXR1cykNCiANCisjaWZkZWYgQ09O
RklHX0NQVV9MT09OR1NPTjMNCisvKg0KKyAqIExvb25nc29uLTMgaGFzIGEgQ1BVIGJ1ZyB3
aGVyZSB0aGUgc3RvcmUgYnVmZmVyIGdldHMgc3RhcnZlZCB3aGVuIHN0dWNrIGluIGENCisg
KiByZWFkIGxvb3AuIFNpbmNlIHNwaW4gbG9vcHMgb2YgYW55IGtpbmQgc2hvdWxkIGhhdmUg
YSBjcHVfcmVsYXgoKSBpbiB0aGVtLA0KKyAqIGZvcmNlIGEgc3RvcmUtYnVmZmVyIGZsdXNo
IGZyb20gY3B1X3JlbGF4KCkgc3VjaCB0aGF0IGFueSBwZW5kaW5nIHdyaXRlcw0KKyAqIHdp
bGwgYmVjb21lIGF2YWlsYWJsZSBhcyBleHBlY3RlZC4NCisgKi8NCisjZGVmaW5lIGNwdV9y
ZWxheCgpCXNtcF9tYigpDQorI2Vsc2UNCiAjZGVmaW5lIGNwdV9yZWxheCgpCWJhcnJpZXIo
KQ0KKyNlbmRpZg0KIA0KIC8qDQogICogUmV0dXJuX2FkZHJlc3MgaXMgYSByZXBsYWNlbWVu
dCBmb3IgX19idWlsdGluX3JldHVybl9hZGRyZXNzKGNvdW50KQ==

