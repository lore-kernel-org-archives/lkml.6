Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21281ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 01:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C462620854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 01:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C462620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeGUC1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 22:27:44 -0400
Received: from smtpbg328.qq.com ([14.17.43.160]:34014 "EHLO smtpbg328.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbeGUC1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 22:27:43 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: fKTAE3WXKxJqiNAiSitpGIecBOTNBUEswmVUwdcxYCFM2LzKT2Q1o9MMJUIlh
        p6a4kRt2Iamw3Xgr4gF8+j5rqma3kcKMajn9ewxWI1NwrayYpv2c8L++NPWfCzs5VaTrp4W
        HdM4aJaeo7ztZnFIyAZhkdIsGpJulewmly5YuSH9ZQLKOBMYKrHWpSak9vRprpUgIKYAfJ3
        J9sho5VqHw6+BI/BQZa6XlcIxAOVsI2ElCKbYGDaQBK+WZVOjyODbgd7uDge54MfmAKZQ/w
        jdlTs5W3FQ02BBQLOeP4WwSKU=
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 114.217.176.75
X-QQ-STYLE: 
X-QQ-mid: bizmailfree7t1532136959t33537
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>
Cc:     "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <jhogan@kernel.org>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?QWxhbiBTdGVybg==?=" <stern@rowland.harvard.edu>,
        "=?utf-8?B?QW5kcmVhIFBhcnJp?=" <andrea.parri@amarulasolutions.com>,
        "=?utf-8?B?V2lsbCBEZWFjb24=?=" <will.deacon@arm.com>,
        "=?utf-8?B?UGV0ZXIgWmlqbHN0cmE=?=" <peterz@infradead.org>,
        "=?utf-8?B?Qm9xdW4gRmVuZw==?=" <boqun.feng@gmail.com>,
        "=?utf-8?B?TmljaG9sYXMgUGlnZ2lu?=" <npiggin@gmail.com>,
        "=?utf-8?B?RGF2aWQgSG93ZWxscw==?=" <dhowells@redhat.com>,
        "=?utf-8?B?SmFkZSBBbGdsYXZl?=" <j.alglave@ucl.ac.uk>,
        "=?utf-8?B?THVjIE1hcmFuZ2V0?=" <luc.maranget@inria.fr>,
        "=?utf-8?B?UGF1bCBFLiBNY0tlbm5leQ==?=" <paulmck@linux.vnet.ibm.com>,
        "=?utf-8?B?QWtpcmEgWW9rb3Nhd2E=?=" <akiyks@gmail.com>,
        "=?utf-8?B?TEtNTA==?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Change definition of cpu_relax() for Loongson-3
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Sat, 21 Jul 2018 09:35:59 +0800
X-Priority: 3
Message-ID: <tencent_49EB501232FD02AC001F9E93@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1531467477-9952-1-git-send-email-chenhc@lemote.com>
        <20180717175232.ea7pi2bqswnzmznc@pburton-laptop>
        <CAAhV-H5_==ZdKTOJTNXkRBTqmr5cxFvcaVabfNarEiQt_LvHZQ@mail.gmail.com>
        <20180719211547.7hlkkljnmtbdubot@pburton-laptop>
In-Reply-To: <20180719211547.7hlkkljnmtbdubot@pburton-laptop>
X-QQ-ReplyHash: 2149179568
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Sat, 21 Jul 2018 09:36:02 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb19
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBhdWwsDQogDQpTRkIgY2FuIGltcHJvdmUgdGhlIG1lbW9yeSBiYW5kd2lkdGggYXMg
bXVjaCBhcyAzMCUsIGFuZCB3ZSBhcmUgcGxhbm5pbmcgdG8gZW5hYmxlIFNGQiBieSBkZWZh
dWx0LiBTbywgd2Ugd2FudCB0byBjb250cm9sIGNwdV9yZWxheCgpIHVuZGVyIENPTkZJR19D
UFVfTE9PTkdTT04zLCBub3QgdW5kZXIgQ09ORklHX0xPT05HU09OM19FTkhBTkNFTUVOVC4N
Cg0KSHVhY2FpDQogDQotLS0tLS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0t
LS0tLS0tDQpGcm9tOiAgIlBhdWwgQnVydG9uIjxwYXVsLmJ1cnRvbkBtaXBzLmNvbT47DQpE
YXRlOiAgRnJpLCBKdWwgMjAsIDIwMTggMDU6MTUgQU0NClRvOiAgIkh1YWNhaSBDaGVuIjxj
aGVuaGNAbGVtb3RlLmNvbT47IA0KQ2M6ICAiUmFsZiBCYWVjaGxlIjxyYWxmQGxpbnV4LW1p
cHMub3JnPjsgIkphbWVzIEhvZ2FuIjxqaG9nYW5Aa2VybmVsLm9yZz47ICJsaW51eC1taXBz
IjxsaW51eC1taXBzQGxpbnV4LW1pcHMub3JnPjsgIkZ1eGluIFpoYW5nIjx6aGFuZ2Z4QGxl
bW90ZS5jb20+OyAid3V6aGFuZ2ppbiI8d3V6aGFuZ2ppbkBnbWFpbC5jb20+OyAic3RhYmxl
IjxzdGFibGVAdmdlci5rZXJuZWwub3JnPjsgIkFsYW4gU3Rlcm4iPHN0ZXJuQHJvd2xhbmQu
aGFydmFyZC5lZHU+OyAiQW5kcmVhIFBhcnJpIjxhbmRyZWEucGFycmlAYW1hcnVsYXNvbHV0
aW9ucy5jb20+OyAiV2lsbCBEZWFjb24iPHdpbGwuZGVhY29uQGFybS5jb20+OyAiUGV0ZXIg
WmlqbHN0cmEiPHBldGVyekBpbmZyYWRlYWQub3JnPjsgIkJvcXVuIEZlbmciPGJvcXVuLmZl
bmdAZ21haWwuY29tPjsgIk5pY2hvbGFzIFBpZ2dpbiI8bnBpZ2dpbkBnbWFpbC5jb20+OyAi
RGF2aWQgSG93ZWxscyI8ZGhvd2VsbHNAcmVkaGF0LmNvbT47ICJKYWRlIEFsZ2xhdmUiPGou
YWxnbGF2ZUB1Y2wuYWMudWs+OyAiTHVjIE1hcmFuZ2V0IjxsdWMubWFyYW5nZXRAaW5yaWEu
ZnI+OyAiUGF1bCBFLiBNY0tlbm5leSI8cGF1bG1ja0BsaW51eC52bmV0LmlibS5jb20+OyAi
QWtpcmEgWW9rb3Nhd2EiPGFraXlrc0BnbWFpbC5jb20+OyAiTEtNTCI8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IA0KU3ViamVjdDogIFJlOiBbUEFUQ0hdIE1JUFM6IENoYW5n
ZSBkZWZpbml0aW9uIG9mIGNwdV9yZWxheCgpIGZvciBMb29uZ3Nvbi0zDQoNCiANCkhpIEh1
YWNhaSwNCg0KT24gV2VkLCBKdWwgMTgsIDIwMTggYXQgMDk6MTU6NDZBTSArMDgwMCwgSHVh
Y2FpIENoZW4gd3JvdGU6DQo+ID4+IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvaW5jbHVkZS9h
c20vcHJvY2Vzc29yLmggYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vcHJvY2Vzc29yLmgNCj4g
Pj4gaW5kZXggYWYzNGFmYi4uYThjNGEzYSAxMDA2NDQNCj4gPj4gLS0tIGEvYXJjaC9taXBz
L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQo+ID4+ICsrKyBiL2FyY2gvbWlwcy9pbmNsdWRl
L2FzbS9wcm9jZXNzb3IuaA0KPiA+PiBAQCAtMzg2LDcgKzM4NiwxNyBAQCB1bnNpZ25lZCBs
b25nIGdldF93Y2hhbihzdHJ1Y3QgdGFza19zdHJ1Y3QgKnApOw0KPiA+PiAgI2RlZmluZSBL
U1RLX0VTUCh0c2spICh0YXNrX3B0X3JlZ3ModHNrKS0+cmVnc1syOV0pDQo+ID4+ICAjZGVm
aW5lIEtTVEtfU1RBVFVTKHRzaykgKHRhc2tfcHRfcmVncyh0c2spLT5jcDBfc3RhdHVzKQ0K
PiA+Pg0KPiA+PiArI2lmZGVmIENPTkZJR19DUFVfTE9PTkdTT04zDQo+ID4+ICsvKg0KPiA+
PiArICogTG9vbmdzb24tMydzIFNGQiAoU3RvcmUtRmlsbC1CdWZmZXIpIG1heSBnZXQgc3Rh
cnZlZCB3aGVuIHN0dWNrIGluIGEgcmVhZA0KPiA+PiArICogbG9vcC4gU2luY2Ugc3BpbiBs
b29wcyBvZiBhbnkga2luZCBzaG91bGQgaGF2ZSBhIGNwdV9yZWxheCgpIGluIHRoZW0sIGZv
cmNlDQo+ID4+ICsgKiBhIFN0b3JlLUZpbGwtQnVmZmVyIGZsdXNoIGZyb20gY3B1X3JlbGF4
KCkgc3VjaCB0aGF0IGFueSBwZW5kaW5nIHdyaXRlcyB3aWxsDQo+ID4+ICsgKiBiZWNvbWUg
YXZhaWxhYmxlIGFzIGV4cGVjdGVkLg0KPiA+PiArICovDQo+ID4NCj4gPiBJIHRoaW5rICJt
YXkgc3RhcnZlIHdyaXRlcyIgb3IgIm1heSBxdWV1ZSB3cml0ZXMgaW5kZWZpbml0ZWx5IiB3
b3VsZCBiZQ0KPiA+IGNsZWFyZXIgdGhhbiAibWF5IGdldCBzdGFydmVkIi4NCj4NCj4gTmVl
ZCBJIGNoYW5nZSB0aGUgY29tbWVudCBhbmQgcmVzZW5kPyBPciB5b3UgY2hhbmdlIHRoZSBj
b21tZW50IGFuZCBnZXQgbWVyZ2VkPw0KDQpJJ20gaGFwcHkgdG8gZml4IHVwIHRoZSBjb21t
ZW50IC0gYnV0IGhhdmUgYSBjb3VwbGUgbW9yZSBxdWVzdGlvbnMuDQoNCkxvb2tpbmcgaW50
byB0aGUgaGlzdG9yeSwgd291bGQgaXQgYmUgZmFpciB0byBzYXkgdGhhdCB0aGlzIGlzIG9u
bHkgYQ0KcHJvYmxlbSBhZnRlciBjb21taXQgMWU4MjBkYTNjOWFmICgiTUlQUzogTG9vbmdz
b24tMzogSW50cm9kdWNlDQpDT05GSUdfTE9PTkdTT04zX0VOSEFOQ0VNRU5UIikgd2hlbiBD
T05GSUdfTE9PTkdTT04zX0VOSEFOQ0VNRU5UPXksDQp3aGljaCBhZGRzIGNvZGUgdG8gZW5h
YmxlIHRoZSBTRkI/DQoNCklmIHNvIHdvdWxkIGl0IG1ha2Ugc2Vuc2UgdG8gdXNlIENPTkZJ
R19MT09OR1NPTjNfRU5IQU5DRU1FTlQgdG8gc2VsZWN0DQp0aGUgdXNlIG9mIHNtcF9tYigp
Pw0KDQpIb3cgbXVjaCBkb2VzIHBlcmZvcm1hbmNlIGdhaW4gZG9lcyBlbmFibGluZyB0aGUg
U0ZCIGdpdmUgeW91PyBXb3VsZCBpdA0KYmUgcmVhc29uYWJsZSB0byBqdXN0IGRpc2FibGUg
aXQsIHJhdGhlciB0aGFuIHVzaW5nIHRoaXMgd29ya2Fyb3VuZD8NCg0KVGhhbmtzLA0KICAg
IFBhdWw=

