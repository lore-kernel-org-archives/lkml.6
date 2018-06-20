Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955ECC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE7A208A6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE7A208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lemote.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754344AbeFTDc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:32:59 -0400
Received: from SMTPBG352.QQ.COM ([183.57.50.167]:59213 "EHLO smtpbg352.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753906AbeFTDc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:32:57 -0400
X-QQ-GoodBg: 0
X-QQ-SSF: 00100000000000F0
X-QQ-FEAT: jfJxHuYZxOBqvDRBa/CXOT5wfvJzZ0pU/0mIY+w0l/eDbG99rNI3v1GyQeB8b
        hLhJd4Tc/tBBLJxRVodjfV6hXV7JEuTUJBD7bE4oNlJMnqmONbm8tiBIlQYpSNfgHfJIMWD
        n2nEDkiMXMBr5hdKjjby43cYeZacCJ1GdKHdkbJP7HZSvYXfOu3aU8w+uImf0Q3/4Hd7/NS
        I5R1FkB8irFHN9Ul3Hu1BoARoz1PJQlwcQB1uPU53vQioXy8138F8AiFp2lNqjc6n9qJSqd
        cyEOnUK4f2roA8sni+/ajjbQ+x/d3UJAckdQ==
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 222.92.124.153
X-QQ-STYLE: 
X-QQ-mid: bizmailfree34t1529465515t9517
From:   "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
To:     "=?utf-8?B?UGV0ZXIgWmlqbHN0cmE=?=" <peterz@infradead.org>
Cc:     "=?utf-8?B?UGF1bCBCdXJ0b24=?=" <paul.burton@mips.com>,
        "=?utf-8?B?UmFsZiBCYWVjaGxl?=" <ralf@linux-mips.org>,
        "=?utf-8?B?SmFtZXMgSG9nYW4=?=" <james.hogan@mips.com>,
        "=?utf-8?B?bGludXgtbWlwcw==?=" <linux-mips@linux-mips.org>,
        "=?utf-8?B?RnV4aW4gWmhhbmc=?=" <zhangfx@lemote.com>,
        "=?utf-8?B?d3V6aGFuZ2ppbg==?=" <wuzhangjin@gmail.com>,
        "=?utf-8?B?SHVhY2FpIENoZW4=?=" <chenhuacai@gmail.com>,
        "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>,
        "=?utf-8?B?QWxhbiBTdGVybg==?=" <stern@rowland.harvard.edu>,
        "=?utf-8?B?QW5kcmVhUGFycmk=?=" <andrea.parri@amarulasolutions.com>,
        "=?utf-8?B?V2lsbCBEZWFjb24=?=" <will.deacon@arm.com>,
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
Date:   Wed, 20 Jun 2018 11:31:55 +0800
X-Priority: 3
Message-ID: <tencent_2BF857EC332473814C12A753@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
        <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
        <tencent_59DC823168EC2F5D42AE44F0@qq.com>
        <20180619072242.GC2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180619072242.GC2494@hirez.programming.kicks-ass.net>
X-QQ-ReplyHash: 4186894581
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Wed, 20 Jun 2018 11:32:00 +0800 (CST)
Feedback-ID: bizmailfree:lemote.com:qybgweb:qybgweb7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBldGVyIGFuZCBQYXVsLA0KDQpMb29uZ3Nvbi0zJ3MgU3RvcmUgRmlsbCBCdWZmZXIg
aXMgbmVhcmx5IHRoZSBzYW1lIGFzIHlvdXIgIlN0b3JlIEJ1ZmZlciIsIGFuZCBpdCBpbmNy
ZWFzZXMgdGhlIG1lbW9yeSBvcmRlcmluZyB3ZWFrbmVzcy4gU28sIHNtcF9jb25kX2xvYWRf
YWNxdWlyZSgpIG9ubHkgbmVlZCBhIF9fc21wX21iKCkgYmVmb3JlIHRoZSBsb29wLCBub3Qg
YWZ0ZXIgZXZlcnkgUkVBRF9PTkNFKCkuIEluIG90aGVyIHdvcmQsIHRoZSBmb2xsb3dpbmcg
Y29kZSBpcyBqdXN0IE9LOg0KDQojZGVmaW5lIHNtcF9jb25kX2xvYWRfYWNxdWlyZShwdHIs
IGNvbmRfZXhwcikgICAgICAgICAgICAgICAgICAgXA0KKHsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAg
dHlwZW9mKHB0cikgX19QVFIgPSAocHRyKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQogICAgICAgIHR5cGVvZigqcHRyKSBWQUw7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXA0KICAgICAgICBfX3NtcF9tYigpOyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgIGZvciAoOzspIHsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgIFZB
TCA9IFJFQURfT05DRSgqX19QVFIpOyAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAg
ICAgICAgICAgICBpZiAoY29uZF9leHByKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBcDQogICAgICAgICAgICAgICAgICAgICAgICBicmVhazsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KICAgICAgICAgICAgICAgIGNwdV9yZWxheCgpOyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICAgfSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAg
IF9fc21wX21iKCk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAg
ICAgICAgVkFMOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBcDQp9KQ0KDQp0aGUgX19zbXBfbWIoKSBiZWZvcmUgbG9vcCBpcyB1c2VkIHRv
IGF2b2lkICJyZWFkcyBwcmlvcml0aXNlZCBvdmVyIHdyaXRlcyIsIHdoaWNoIGlzIGNhdXNl
ZCBieSBTRkIncyB3ZWFrIG9yZGVyaW5nIGFuZCBzaW1pbGFyIHRvIEFSTTExTVBDb3JlICht
ZW50aW9uZWQgYnkgV2lsbCBEZWFjb24pLg0KDQpIdWFjYWkNCg0KLS0tLS0tLS0tLS0tLS0t
LS0tIE9yaWdpbmFsIC0tLS0tLS0tLS0tLS0tLS0tLQ0KRnJvbTogICJQZXRlciBaaWpsc3Ry
YSI8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Ow0KRGF0ZTogIFR1ZSwgSnVuIDE5LCAyMDE4IDAz
OjIyIFBNDQpUbzogICLpmYjljY7miY0iPGNoZW5oY0BsZW1vdGUuY29tPjsNCkNjOiAgIlBh
dWwgQnVydG9uIjxwYXVsLmJ1cnRvbkBtaXBzLmNvbT47ICJSYWxmIEJhZWNobGUiPHJhbGZA
bGludXgtbWlwcy5vcmc+OyAiSmFtZXMgSG9nYW4iPGphbWVzLmhvZ2FuQG1pcHMuY29tPjsg
ImxpbnV4LW1pcHMiPGxpbnV4LW1pcHNAbGludXgtbWlwcy5vcmc+OyAiRnV4aW4gWmhhbmci
PHpoYW5nZnhAbGVtb3RlLmNvbT47ICJ3dXpoYW5namluIjx3dXpoYW5namluQGdtYWlsLmNv
bT47ICJIdWFjYWkgQ2hlbiI8Y2hlbmh1YWNhaUBnbWFpbC5jb20+OyAic3RhYmxlIjxzdGFi
bGVAdmdlci5rZXJuZWwub3JnPjsgIkFsYW4gU3Rlcm4iPHN0ZXJuQHJvd2xhbmQuaGFydmFy
ZC5lZHU+OyAiQW5kcmVhUGFycmkiPGFuZHJlYS5wYXJyaUBhbWFydWxhc29sdXRpb25zLmNv
bT47ICJXaWxsIERlYWNvbiI8d2lsbC5kZWFjb25AYXJtLmNvbT47ICJCb3F1biBGZW5nIjxi
b3F1bi5mZW5nQGdtYWlsLmNvbT47ICJOaWNob2xhcyBQaWdnaW4iPG5waWdnaW5AZ21haWwu
Y29tPjsgIkRhdmlkIEhvd2VsbHMiPGRob3dlbGxzQHJlZGhhdC5jb20+OyAiSmFkZSBBbGds
YXZlIjxqLmFsZ2xhdmVAdWNsLmFjLnVrPjsgIkx1YyBNYXJhbmdldCI8bHVjLm1hcmFuZ2V0
QGlucmlhLmZyPjsgIlBhdWwgRS4gTWNLZW5uZXkiPHBhdWxtY2tAbGludXgudm5ldC5pYm0u
Y29tPjsgIkFraXJhIFlva29zYXdhIjxha2l5a3NAZ21haWwuY29tPjsgImxpbnV4LWtlcm5l
bCI8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQpTdWJqZWN0OiAgUmU6IFtQQVRD
SF0gTUlQUzogaW1wbGVtZW50IHNtcF9jb25kX2xvYWRfYWNxdWlyZSgpIGZvciBMb29uZ3Nv
bi0zDQogDQpPbiBUdWUsIEp1biAxOSwgMjAxOCBhdCAwMjo0MDoxNFBNICswODAwLCDpmYjl
jY7miY0gd3JvdGU6DQo+IEhpLCBQYXVsLA0KPiANCj4gRmlyc3Qgb2YgYWxsLCBjb3VsZCB5
b3UgcGxlYXNlIGNoZWNrIHdoeSBsaW51eC1taXBzIHJlamVjdCBlLW1haWxzDQo+IGZyb20g
bGVtb3RlLmNvbT8gT2YgY291cnNlIEkgY2FuIHNlbmQgZS1tYWlscyBieSBnbWFpbCwgYnV0
IG15IGdtYWlsDQo+IGNhbid0IHJlY2VpdmUgZS1tYWlscyBmcm9tIGxpbnV4LW1pcHMgc2lu
Y2UgTWFyY2gsIDIwMTguDQoNCkNvdWxkIHlvdSBwbGVhc2UgbGVhcm4gdG8gdXNlIGVtYWls
PyBObyB0b3AgcG9zdGluZyBhbmQgd3JhcCBsaW5lcyBhdCA3OA0KY2hhcnMuDQoNCj4gSSBo
YXZlIGFscmVhZHkgcmVhZCBEb2N1bWVudGF0aW9uL21lbW9yeS1iYXJyaWVycy50eHQsIGJ1
dCBJIGRvbid0DQo+IHRoaW5rIHdlIHNob3VsZCBkZWZpbmUgYSBzbXBfcmVhZF9iYXJyaWVy
X2RlcGVuZHMoKSBmb3IgTG9vbmdzb24tMy4NCj4gQmVjYXVzZSBMb29uZ3Nvbi0zJ3MgYmVo
YXZpb3IgaXNuJ3QgbGlrZSBBbHBoYSwgYW5kIGluIHN5bnRheCwgdGhpcyBpcw0KPiBub3Qg
YSBkYXRhLWRlcGVuZGVudCBpc3N1ZS4NCg0KQWdyZWVkLCB0aGlzIGlzIG5vdCBhIGRhdGEt
ZGVwZW5kZW5jeSBpc3N1ZS4NCg0KPiBUaGVyZSBpcyBubyBkb2N1bWVudCBhYm91dCBMb29u
Z3Nvbi0zJ3MgU0ZCLiBJbiBteSBvcGluaW9uLCBTRkIgbG9va3MNCj4gbGlrZSB0aGUgTDAg
Y2FjaGUgYnV0IHNvbWV0aW1lcyBpdCBpcyBvdXQgb2YgY2FjaGUtY29oZXJlbnQgbWFjaGFu
aXNtDQo+IChMMSBjYWNoZSdzIGNyb3NzLWNvcmUgY29oZXJlbmN5IGlzIG1haW50YWluZWQg
YnkgaGFyZHdhcmUsIGJ1dCBub3QNCj4gYWx3YXlzIHRydWUgZm9yIFNGQikuIHNtcF9tYigp
IGlzIG5lZWRlZCBmb3Igc21wX2NvbmRfbG9hZF9hY3F1aXJlKCksDQo+IGJ1dCBub3QgZXZl
cnkgUkVBRF9PTkNFKCkuDQoNCkxpbnV4IGRvZXMgX05PVF8gc3VwcG9ydCBub24tY29oZXJl
bnQgU01QLiBJZiB5b3VyIHN5c3RlbSBpcyBub3QgZnVsbHkNCmNvaGVyZW50LCB5b3UncmUg
b3V0IG9mIGx1Y2suDQoNCkJ1dCBwbGVhc2UsIGV4cGxhaW4gaW4gZXhjcnVjaWF0aW5nIGRl
dGFpbCB3aGF0IGV4YWN0bHkgeW91IG5lZWQgdGhhdA0Kc21wX21iIGZvci4gSWYsIGxpa2Ug
SSBwb3NpdGVkIGluIG15IHByZXZpb3VzIGVtYWlsLCBpdCBpcyB0byBlbnN1cmUNCnJlbW90
ZSBzdG9yZSBidWZmZXIgZmx1c2hlcywgdGhlbiB5b3VyIG1hY2hpbmUgaXMgdGVybWluYWxs
eSBicm9rZW4u

