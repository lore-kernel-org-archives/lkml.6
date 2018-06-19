Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07C1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7F720693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E7F720693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756260AbeFSGr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:47:29 -0400
Received: from SMTPBG352.QQ.COM ([183.57.50.167]:47953 "EHLO smtpbg352.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755808AbeFSGq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:46:59 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2018 02:46:58 EDT
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: t/i7ssdcq52yk8lXRRkc/B+qdDiKzulJ3i5tuRWUXHwoUgJuI1e64WVgfXu7i
        87PabkET5g21sfrtjcGTWp81dgpQfoUxby1n+OpPQ5+EG0+zDLh13nkpw3n+os2V+lPAnCh
        7gS+w/+9yGVbb/4uEwUIWDwmV5HOsT9nS+t9rVAdEFs3A0dHXC71QzaRQeQw4YkKfoJYfrG
        8spAeqXCi+Vaqav65vPQFc4AzxrhyM7jUNz6uuJogSxkUvK8XSe48b+9kPRV3RN88b75fx5
        LvHWc+9sKfP8dpq/9MXjc+ksJLAlgVIHUpXukRr1uaYByc
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree34t1529390415t7731
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>
Cc:     "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <james.hogan@mips.com>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?SHVhY2FpIENoZW4=?=" <chenhuacai@gmail.com>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?QWxhbiBTdGVybg==?=" <stern@rowland.harvard.edu>,
        "=?utf-8?B?QW5kcmVhUGFycmk=?=" <andrea.parri@amarulasolutions.com>,
        "=?utf-8?B?V2lsbCBEZWFjb24=?=" <will.deacon@arm.com>,
        "=?utf-8?B?UGV0ZXIgWmlqbHN0cmE=?=" <peterz@infradead.org>,
        "=?utf-8?B?Qm9xdW4gRmVuZw==?=" <boqun.feng@gmail.com>,
        "=?utf-8?B?TmljaG9sYXMgUGlnZ2lu?=" <npiggin@gmail.com>,
        "=?utf-8?B?RGF2aWQgSG93ZWxscw==?=" <dhowells@redhat.com>,
        "=?utf-8?B?SmFkZSBBbGdsYXZl?=" <j.alglave@ucl.ac.uk>,
        "=?utf-8?B?THVjIE1hcmFuZ2V0?=" <luc.maranget@inria.fr>,
        "=?utf-8?B?UGF1bCBFLiBNY0tlbm5leQ==?=" <paulmck@linux.vnet.ibm.com>,
        "=?utf-8?B?QWtpcmEgWW9rb3Nhd2E=?=" <akiyks@gmail.com>,
        "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Date:   Tue, 19 Jun 2018 14:40:14 +0800
X-Priority: 3
Message-ID: <tencent_59DC823168EC2F5D42AE44F0@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
        <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
In-Reply-To: <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
X-QQ-ReplyHash: 2984761072
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Tue, 19 Jun 2018 14:40:18 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBhdWwsDQoNCkZpcnN0IG9mIGFsbCwgY291bGQgeW91IHBsZWFzZSBjaGVjayB3aHkg
bGludXgtbWlwcyByZWplY3QgZS1tYWlscyBmcm9tIGxlbW90ZS5jb20/IE9mIGNvdXJzZSBJ
IGNhbiBzZW5kIGUtbWFpbHMgYnkgZ21haWwsIGJ1dCBteSBnbWFpbCBjYW4ndCByZWNlaXZl
IGUtbWFpbHMgZnJvbSBsaW51eC1taXBzIHNpbmNlIE1hcmNoLCAyMDE4Lg0KDQpJIGhhdmUg
YWxyZWFkeSByZWFkIERvY3VtZW50YXRpb24vbWVtb3J5LWJhcnJpZXJzLnR4dCwgYnV0IEkg
ZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGRlZmluZSBhIHNtcF9yZWFkX2JhcnJpZXJfZGVwZW5k
cygpIGZvciBMb29uZ3Nvbi0zLiBCZWNhdXNlIExvb25nc29uLTMncyBiZWhhdmlvciBpc24n
dCBsaWtlIEFscGhhLCBhbmQgaW4gc3ludGF4LCB0aGlzIGlzIG5vdCBhIGRhdGEtZGVwZW5k
ZW50IGlzc3VlLg0KDQpUaGVyZSBpcyBubyBkb2N1bWVudCBhYm91dCBMb29uZ3Nvbi0zJ3Mg
U0ZCLiBJbiBteSBvcGluaW9uLCBTRkIgbG9va3MgbGlrZSB0aGUgTDAgY2FjaGUgYnV0IHNv
bWV0aW1lcyBpdCBpcyBvdXQgb2YgY2FjaGUtY29oZXJlbnQgbWFjaGFuaXNtIChMMSBjYWNo
ZSdzIGNyb3NzLWNvcmUgY29oZXJlbmN5IGlzIG1haW50YWluZWQgYnkgaGFyZHdhcmUsIGJ1
dCBub3QgYWx3YXlzIHRydWUgZm9yIFNGQikuIHNtcF9tYigpIGlzIG5lZWRlZCBmb3Igc21w
X2NvbmRfbG9hZF9hY3F1aXJlKCksIGJ1dCBub3QgZXZlcnkgUkVBRF9PTkNFKCkuDQoNCkh1
YWNhaQ0KIA0KLS0tLS0tLS0tLS0tLS0tLS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0t
LQ0KRnJvbTogICJQYXVsIEJ1cnRvbiI8cGF1bC5idXJ0b25AbWlwcy5jb20+Ow0KRGF0ZTog
IFR1ZSwgSnVuIDE5LCAyMDE4IDAyOjUxIEFNDQpUbzogICJIdWFjYWkgQ2hlbiI8Y2hlbmhj
QGxlbW90ZS5jb20+Ow0KQ2M6ICAiUmFsZiBCYWVjaGxlIjxyYWxmQGxpbnV4LW1pcHMub3Jn
PjsgIkphbWVzIEhvZ2FuIjxqYW1lcy5ob2dhbkBtaXBzLmNvbT47ICJsaW51eC1taXBzIjxs
aW51eC1taXBzQGxpbnV4LW1pcHMub3JnPjsgIkZ1eGluIFpoYW5nIjx6aGFuZ2Z4QGxlbW90
ZS5jb20+OyAid3V6aGFuZ2ppbiI8d3V6aGFuZ2ppbkBnbWFpbC5jb20+OyAiSHVhY2FpIENo
ZW4iPGNoZW5odWFjYWlAZ21haWwuY29tPjsgInN0YWJsZSI8c3RhYmxlQHZnZXIua2VybmVs
Lm9yZz47ICJBbGFuIFN0ZXJuIjxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1PjsgIkFuZHJl
YVBhcnJpIjxhbmRyZWEucGFycmlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyAiV2lsbCBEZWFj
b24iPHdpbGwuZGVhY29uQGFybS5jb20+OyAiUGV0ZXIgWmlqbHN0cmEiPHBldGVyekBpbmZy
YWRlYWQub3JnPjsgIkJvcXVuIEZlbmciPGJvcXVuLmZlbmdAZ21haWwuY29tPjsgIk5pY2hv
bGFzIFBpZ2dpbiI8bnBpZ2dpbkBnbWFpbC5jb20+OyAiRGF2aWQgSG93ZWxscyI8ZGhvd2Vs
bHNAcmVkaGF0LmNvbT47ICJKYWRlIEFsZ2xhdmUiPGouYWxnbGF2ZUB1Y2wuYWMudWs+OyAi
THVjIE1hcmFuZ2V0IjxsdWMubWFyYW5nZXRAaW5yaWEuZnI+OyAiUGF1bCBFLiBNY0tlbm5l
eSI8cGF1bG1ja0BsaW51eC52bmV0LmlibS5jb20+OyAiQWtpcmEgWW9rb3Nhd2EiPGFraXlr
c0BnbWFpbC5jb20+OyAibGludXgta2VybmVsIjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPjsNClN1YmplY3Q6ICBSZTogW1BBVENIXSBNSVBTOiBpbXBsZW1lbnQgc21wX2NvbmRf
bG9hZF9hY3F1aXJlKCkgZm9yIExvb25nc29uLTMNCiANCkhpIEh1YWNhaSwNCg0KT24gRnJp
LCBKdW4gMTUsIDIwMTggYXQgMDI6MDc6MzhQTSArMDgwMCwgSHVhY2FpIENoZW4gd3JvdGU6
DQo+IEFmdGVyIGNvbW1pdCA3ZjU2YjU4YTkyYWFmMmMgKCJsb2NraW5nL21jczogVXNlIHNt
cF9jb25kX2xvYWRfYWNxdWlyZSgpDQo+IGluIE1DUyBzcGluIGxvb3AiKSBMb29uZ3Nvbi0z
IGZhaWxzIHRvIGJvb3QuIFRoaXMgaXMgYmVjYXVzZSBMb29uZ3Nvbi0zDQo+IGhhcyBTRkIg
KFN0b3JlIEZpbGwgQnVmZmVyKSBhbmQgUkVBRF9PTkNFKCkgbWF5IGdldCBhbiBvbGQgdmFs
dWUgaW4gYQ0KPiB0aWdodCBsb29wLiBTbyBpbiBzbXBfY29uZF9sb2FkX2FjcXVpcmUoKSB3
ZSBuZWVkIGEgX19zbXBfbWIoKSBhZnRlcg0KPiBldmVyeSBSRUFEX09OQ0UoKS4NCg0KVGhh
bmtzIC0gbW9kaWZ5aW5nIHNtcF9jb25kX2xvYWRfYWNxdWlyZSgpIGlzIGEgc3RlcCBiZXR0
ZXIgdGhhbg0KbW9kaWZ5aW5nIGFyY2hfbWNzX3NwaW5fbG9ja19jb250ZW5kZWQoKSB0byBh
dm9pZCBpdCwgYnV0IEknbSBzdGlsbCBub3QNCnN1cmUgd2UndmUgcmVhY2hlZCB0aGUgcm9v
dCBvZiB0aGUgcHJvYmxlbS4gSWYgdGlnaHQgbG9vcHMgdXNpbmcNClJFQURfT05DRSgpIGFy
ZSBhdCBmYXVsdCB0aGVuIHdoYXQncyBzcGVjaWFsIGFib3V0DQpzbXBfY29uZF9sb2FkX2Fj
cXVpcmUoKT8gQ291bGQgb3RoZXIgc3VjaCBsb29wcyBub3QgaGl0IHRoZSBzYW1lDQpwcm9i
bGVtPw0KDQpJcyB0aGUgc2NlbmFyaW8geW91IGVuY291bnRlciB0aGUgc2FtZSBhcyB0aGF0
IG91dGxpbmVkIGluIHRoZSAiREFUQQ0KREVQRU5ERU5DWSBCQVJSSUVSUyAoSElTVE9SSUNB
TCkiIHNlY3Rpb24gb2YNCkRvY3VtZW50YXRpb24vbWVtb3J5LWJhcnJpZXJzLnR4dCBieSBh
bnkgY2hhbmNlPyBJZiBzbyB0aGVuIHBlcmhhcHMgaXQNCndvdWxkIGJlIGJldHRlciB0byBp
bXBsZW1lbnQgc21wX3JlYWRfYmFycmllcl9kZXBlbmRzKCksIG9yIGp1c3QgcmF3DQpyZWFk
X2JhcnJpZXJfZGVwZW5kcygpIGRlcGVuZGluZyB1cG9uIGhvdyB5b3VyIFNGQiBmdW5jdGlv
bnMuDQoNCklzIHRoZXJlIGFueSBwdWJsaWMgZG9jdW1lbnRhdGlvbiBkZXNjcmliaW5nIHRo
ZSBiZWhhdmlvdXIgb2YgdGhlIHN0b3JlDQpmaWxsIGJ1ZmZlciBpbiBMb29uZ3Nvbi0zPw0K
DQpQYXJ0IG9mIHRoZSBwcm9ibGVtIGlzIHRoYXQgSSdtIHN0aWxsIG5vdCBzdXJlIHdoYXQn
cyBhY3R1YWxseSBoYXBwZW5pbmcNCmluIHlvdXIgc3lzdGVtIC0gaXQgd291bGQgYmUgaGVs
cGZ1bCB0byBoYXZlIGZ1cnRoZXIgaW5mb3JtYXRpb24gaW4gdGhlDQpjb21taXQgbWVzc2Fn
ZSBhYm91dCB3aGF0IGFjdHVhbGx5IGhhcHBlbnMuIEZvciBleGFtcGxlIGlmIHlvdSBjb3Vs
ZA0Kd2FsayB1cyB0aHJvdWdoIGFuIGV4YW1wbGUgb2YgdGhlIHByb2JsZW0gc3RlcCBieSBz
dGVwIGluIHRoZSBzdHlsZSBvZg0KdGhlIGRpYWdyYW1zIHlvdSdsbCBzZWUgaW4gRG9jdW1l
bnRhdGlvbi9tZW1vcnktYmFycmllcnMudHh0IHRoZW4gSQ0KdGhpbmsgdGhhdCB3b3VsZCBo
ZWxwIHVzIHRvIHNlZSB3aGF0IHRoZSBiZXN0IHNvbHV0aW9uIGhlcmUgaXMuDQoNCkkndmUg
Y29waWVkIHRoZSBMS01NIG1haW50YWluZXJzIGluIGNhc2UgdGhleSBoYXZlIGZ1cnRoZXIg
aW5wdXQuDQoNClRoYW5rcywNCiAgICBQYXVsDQoNCj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2Ug
YSBMb29uZ3Nvbi1zcGVjaWZpYyBzbXBfY29uZF9sb2FkX2FjcXVpcmUoKS4gQW5kDQo+IGl0
IHNob3VsZCBiZSBiYWNrcG9ydGVkIHRvIGFzIGVhcmx5IGFzIGxpbnV4LTQuNSwgaW4gd2hp
Y2ggcmVsZWFzZSB0aGUNCj4gc21wX2NvbmRfYWNxdWlyZSgpIGlzIGludHJvZHVjZWQuDQo+
IA0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBIdWFj
YWkgQ2hlbiA8Y2hlbmhjQGxlbW90ZS5jb20+DQo+IC0tLQ0KPiAgYXJjaC9taXBzL2luY2x1
ZGUvYXNtL2JhcnJpZXIuaCB8IDE3ICsrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvbWlwcy9p
bmNsdWRlL2FzbS9iYXJyaWVyLmggYi9hcmNoL21pcHMvaW5jbHVkZS9hc20vYmFycmllci5o
DQo+IGluZGV4IGE1ZWIxYmIuLjRlYTM4NGQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvbWlwcy9p
bmNsdWRlL2FzbS9iYXJyaWVyLmgNCj4gKysrIGIvYXJjaC9taXBzL2luY2x1ZGUvYXNtL2Jh
cnJpZXIuaA0KPiBAQCAtMjIyLDYgKzIyMiwyMyBAQA0KPiAgI2RlZmluZSBfX3NtcF9tYl9f
YmVmb3JlX2F0b21pYygpCV9fc21wX21iX19iZWZvcmVfbGxzYygpDQo+ICAjZGVmaW5lIF9f
c21wX21iX19hZnRlcl9hdG9taWMoKQlzbXBfbGxzY19tYigpDQo+ICANCj4gKyNpZmRlZiBD
T05GSUdfQ1BVX0xPT05HU09OMw0KPiArLyogTG9vbmdzb24tMyBuZWVkIGEgX19zbXBfbWIo
KSBhZnRlciBSRUFEX09OQ0UoKSBoZXJlICovDQo+ICsjZGVmaW5lIHNtcF9jb25kX2xvYWRf
YWNxdWlyZShwdHIsIGNvbmRfZXhwcikJXA0KPiArKHsJXA0KPiArCXR5cGVvZihwdHIpIF9f
UFRSID0gKHB0cik7CVwNCj4gKwl0eXBlb2YoKnB0cikgVkFMOwlcDQo+ICsJZm9yICg7Oykg
ewlcDQo+ICsJVkFMID0gUkVBRF9PTkNFKCpfX1BUUik7CVwNCj4gKwlfX3NtcF9tYigpOwlc
DQo+ICsJaWYgKGNvbmRfZXhwcikJXA0KPiArCWJyZWFrOwlcDQo+ICsJY3B1X3JlbGF4KCk7
CVwNCj4gKwl9CVwNCj4gKwlWQUw7CVwNCj4gK30pDQo+ICsjZW5kaWYJLyogQ09ORklHX0NQ
VV9MT09OR1NPTjMgKi8NCj4gKw0KPiAgI2luY2x1ZGUgPGFzbS1nZW5lcmljL2JhcnJpZXIu
aD4NCj4gIA0KPiAgI2VuZGlmIC8qIF9fQVNNX0JBUlJJRVJfSCAqLw0KPiAtLSANCj4gMi43
LjANCj4=

