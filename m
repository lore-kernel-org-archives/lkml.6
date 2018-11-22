Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD17C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA0C20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA0C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbeKVRWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:22:00 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:48212 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeKVRWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:22:00 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAM6hp4N011030
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 15:43:51 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAM6hpgD019393;
        Thu, 22 Nov 2018 15:43:51 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAM6h5Ic005469;
        Thu, 22 Nov 2018 15:43:51 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.149] [10.38.151.149]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-5774320; Thu, 22 Nov 2018 15:42:29 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC21GP.gisp.nec.co.jp ([10.38.151.149]) with mapi id 14.03.0319.002; Thu,
 22 Nov 2018 15:42:28 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     "Zhangfei (Tyler)" <tyler.zhang@huawei.com>
CC:     Xiexiuqi <xiexiuqi@huawei.com>, linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Lvzhipeng (pang, Intelligent Computing R&D)" <lvzhipeng@huawei.com>,
        meinanjing <meinanjing@huawei.com>,
        Dukaitian <dukaitian@huawei.com>,
        "Chenglongfei (Longfei Cheng, Intelligent Computing R&D)" 
        <chenglongfei@huawei.com>,
        "Liugang (Robert, Intelligent Computing R&D)" <robert.liu@huawei.com>,
        "Chenzhuowei (Intelligent Computing R&D)" <chenzhuowei@huawei.com>
Subject: =?utf-8?B?UmU6IOetlOWkjTogW1JGQ10gYSBxdWVzdGlvbiBhYm91dCByZXVzZSBod3Bv?=
 =?utf-8?B?aXNvbiBwYWdlIGluIHNvZnRfb2ZmbGluZV9wYWdlKCk=?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUkZDXSBhIHF1ZXN0aW9uIGFib3V0IHJldXNlIGh3cG9pc29u?=
 =?utf-8?B?IHBhZ2UgaW4gc29mdF9vZmZsaW5lX3BhZ2UoKQ==?=
Thread-Index: AQHUH/5XW0YhNomut06MiYrg0IqjkqSXxwRQgAQKzgCAvXXW0IACPoyA
Date:   Thu, 22 Nov 2018 06:42:27 +0000
Message-ID: <20181122064227.GA3364@hori1.linux.bs1.fc.nec.co.jp>
References: <99235479-716d-4c40-8f61-8e44c242abf8.xishi.qiuxishi@alibaba-inc.com>
 <20180706081847.GA5144@hori1.linux.bs1.fc.nec.co.jp>
 <7f0ff90d-578b-2096-92c0-542a490b06a1@huawei.com>
 <E690DE8F4F207D4EB356CAC7B78E15467E402966@DGGEMA503-MBX.china.huawei.com>
 <20180723061114.GB26102@hori1.linux.bs1.fc.nec.co.jp>
 <E690DE8F4F207D4EB356CAC7B78E15467E478160@DGGEMA503-MBX.china.huawei.com>
In-Reply-To: <E690DE8F4F207D4EB356CAC7B78E15467E478160@DGGEMA503-MBX.china.huawei.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0AB5C335E29934D845CF9316C387824@gisp.nec.co.jp>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWmhhbmdmZWksDQoNCk9uIFR1ZSwgTm92IDIwLCAyMDE4IGF0IDExOjM2OjE2QU0gKzAwMDAs
IFpoYW5nZmVpIChUeWxlcikgd3JvdGU6DQo+IEhpIE5hb3lhDQo+IAlBbnkgVXBkYXRlIG9uIHRo
aXMgaXNzdWXvvJ9JcyB0aGVyZSBhIGZpbmFsIGNvbmNsdXNpb24gb24gaG93IHRvIGZpeCB0aGlz
IGlzc3VlPw0KDQpUaGlzIGlzc3VlIGlzIHNvbHZlZCBieSB0aGUgZm9sbG93aW5nIGNvbW1pdCBm
b3IgNGtCIHBhZ2VzOg0KDQogICAgY29tbWl0IGQ0YWU5OTE2ZWEyOTQ3MzQxMTgwZDJiNTM4ZjQ4
ODc1ZmYzOTNhODYNCiAgICBBdXRob3I6IE5hb3lhIEhvcmlndWNoaSA8bi1ob3JpZ3VjaGlAYWgu
anAubmVjLmNvbT4NCiAgICBEYXRlOiAgIFRodSBBdWcgMjMgMTc6MDA6NDIgMjAxOCAtMDcwMA0K
ICAgIA0KICAgICAgICBtbTogc29mdC1vZmZsaW5lOiBjbG9zZSB0aGUgcmFjZSBhZ2FpbnN0IHBh
Z2UgYWxsb2NhdGlvbg0KDQpUaGUgcmVwb3J0ZWQgc2lnYnVzIGlzc3VlIHNob3VsZCBub3QgcmVw
cm9kdWNlIGJlY2F1c2UgUGFnZUhXUG9pc29uIGlzDQpzZXQgdW5kZXIgem9uZS0+bG9jay4gV2Ug
c2FmZWx5IGdpdmUgdXAgcGFnZSBjb250YWltZW50IGlmIHRoZSByYWNlIGhhcHBlbnMuDQoNClRo
YW5rcywNCk5hb3lhIEhvcmlndWNoaQ0KDQo+IA0KPiBUaGlua3MNCj4gCQ0KPiAtLS0tLemCruS7
tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTmFveWEgSG9yaWd1Y2hpIFttYWlsdG86bi1ob3Jp
Z3VjaGlAYWguanAubmVjLmNvbV0gDQo+IOWPkemAgeaXtumXtDogMjAxOOW5tDfmnIgyM+aXpSAx
NDoxMQ0KPiDmlLbku7bkuro6IFpoYW5nZmVpIChUeWxlcikgPHR5bGVyLnpoYW5nQGh1YXdlaS5j
b20+DQo+IOaKhOmAgTogWGlleGl1cWkgPHhpZXhpdXFpQGh1YXdlaS5jb20+OyDoo5jnqIDnn7Mo
56iA55+zKSA8eGlzaGkucWl1eGlzaGlAYWxpYmFiYS1pbmMuY29tPjsgbGludXgtbW0gPGxpbnV4
LW1tQGt2YWNrLm9yZz47IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz47IHp5LnpoZW5neWkgPHp5LnpoZW5neWlAYWxpYmFiYS1pbmMuY29tPjsgbHZ6aGlwZW5nIDxs
dnpoaXBlbmdAaHVhd2VpLmNvbT47IG1laW5hbmppbmcgPG1laW5hbmppbmdAaHVhd2VpLmNvbT47
IHpob25namlhbmcgPHpob25namlhbmdAaHVhd2VpLmNvbT47IER1a2FpdGlhbiA8ZHVrYWl0aWFu
QGh1YXdlaS5jb20+OyBDaGVuZ2xvbmdmZWkgPGNoZW5nbG9uZ2ZlaUBodWF3ZWkuY29tPg0KPiDk
uLvpopg6IFJlOiBbUkZDXSBhIHF1ZXN0aW9uIGFib3V0IHJldXNlIGh3cG9pc29uIHBhZ2UgaW4g
c29mdF9vZmZsaW5lX3BhZ2UoKQ0KPiANCj4gT24gRnJpLCBKdWwgMjAsIDIwMTggYXQgMDg6NTA6
MjJBTSArMDAwMCwgWmhhbmdmZWkgKFR5bGVyKSB3cm90ZToNCj4gPiBIaSBOYW95YSZ4aXNoae+8
mg0KPiA+IAlXZSBoYXZlIGEgc2ltaWxhciBwcm9ibGVtLCB0aGUgZGlmZmVyZW5jZSBpcyB0aGF0
IHdlIGRpZCBub3QgRW5hYmxlIGh1Z2VwYWdlLCB0aGUgc29mdC1vZmZsaW5lIHdhcyBleGVjdXRl
ZCBpbiB0aGUgY2FzZSBvZiBub3JtYWwgNEsgcGFnZXMsIGFuZCBmaW5hbGx5IHRoZSBNQ0Uga2ls
bCB3YXMgdHJpZ2dlcmVk77yIZmluZCBod3BvaXNvbiBmbGFnIGlzIGFscmVhZHkgc2V0LS0+cmV0
ID0gVk1fRkFVTFRfSFdQT0lTT04tLT5tbV9mYXVsdF9lcnJvciAtLT5kb19zaWdidXMgLS0+IG1j
ZSBraWxs77yJLiBXZSBub3RpY2VkIHRoYXQgdGhlIG5ldyBwYXRjaCBtYWRlIHNvbWUgbW9kaWZp
Y2F0aW9ucyB0byB0aGUgY2FzZSBvZiBodWdlIHBhZ2Ugb2ZmbGluZSwgQnV0IGhvdyBjYW4gd2Ug
YXZvaWQgdGhpcyByYWNlIGNvbmRpdGlvbiBmb3IgdGhlIGNhc2Ugb2Ygbm9ybWFsIHBhZ2U/DQo+
IA0KPiBIaSBUeWxlciwNCj4gDQo+IExhdGVzdCB2ZXJzaW9uIG9mIHRoZSBmaXggaXMgYXZhaWxh
YmxlIG9uIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzcvMTcvNjAuDQo+IEknbSBzdGlsbCBk
aXNjdXNzaW5nIHdpdGggTWljaGFsIGFib3V0IGJldHRlciBkZXNpZ24gb2YgdGhpcyBhcmVhLCBi
dXQgSSB0aGluayB3ZSdsbCBnbyB3aXRoIHRoaXMgZm9yIHNob3J0IHRlcm0gZml4Lg0KPiANCj4g
VGhhbmtzLA0KPiBOYW95YSBIb3JpZ3VjaGkNCj4gDQo+ID4gDQo+ID4gLS0tLS3pgq7ku7bljp/k
u7YtLS0tLQ0KPiA+IOWPkeS7tuS6ujogWGlleGl1cWkNCj4gPiDlj5HpgIHml7bpl7Q6IDIwMTjl
ubQ35pyIMjDml6UgMTU6NTANCj4gPiDmlLbku7bkuro6IE5hb3lhIEhvcmlndWNoaSA8bi1ob3Jp
Z3VjaGlAYWguanAubmVjLmNvbT47IOijmOeogOefsyjnqIDnn7MpIA0KPiA+IDx4aXNoaS5xaXV4
aXNoaUBhbGliYWJhLWluYy5jb20+DQo+ID4g5oqE6YCBOiBsaW51eC1tbSA8bGludXgtbW1Aa3Zh
Y2sub3JnPjsgbGludXgta2VybmVsIA0KPiA+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pjsgenkuemhlbmd5aSANCj4gPiA8enkuemhlbmd5aUBhbGliYWJhLWluYy5jb20+OyBaaGFuZ2Zl
aSAoVHlsZXIpIA0KPiA+IDx0eWxlci56aGFuZ0BodWF3ZWkuY29tPjsgbHZ6aGlwZW5nIDxsdnpo
aXBlbmdAaHVhd2VpLmNvbT47IG1laW5hbmppbmcgDQo+ID4gPG1laW5hbmppbmdAaHVhd2VpLmNv
bT47IHpob25namlhbmcgPHpob25namlhbmdAaHVhd2VpLmNvbT4NCj4gPiDkuLvpopg6IFJlOiBb
UkZDXSBhIHF1ZXN0aW9uIGFib3V0IHJldXNlIGh3cG9pc29uIHBhZ2UgaW4gDQo+ID4gc29mdF9v
ZmZsaW5lX3BhZ2UoKQ0KPiA+IA0KPiA+IEhpIE5hb3lhLCBYaXNoaSwNCj4gPiANCj4gPiBXZSBo
YXZlIGEgc2ltaWxhciBwcm9ibGVtLg0KPiA+IEB6aGFuZ2ZlaSwgY291bGQgeW91IHBsZWFzZSBk
ZXNjcmliZSB5b3VyIHByb2JsZW0gaGVyZS4NCj4gPiANCj4gPiBPbiAyMDE4LzcvNiAxNjoxOCwg
TmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKdWwgMDYsIDIwMTggYXQgMTE6
Mzc6NDFBTSArMDgwMCwg6KOY56iA55+zKOeogOefsykgd3JvdGU6DQo+ID4gPj4gVGhpcyBwYXRj
aCBhZGQwNWNlYw0KPiA+ID4+IChtbTogc29mdC1vZmZsaW5lOiBkb24ndCBmcmVlIHRhcmdldCBw
YWdlIGluIHN1Y2Nlc3NmdWwgcGFnZQ0KPiA+ID4+IG1pZ3JhdGlvbikgcmVtb3Zlcw0KPiA+ID4+
IHNldF9taWdyYXRldHlwZV9pc29sYXRlKCkgYW5kIHVuc2V0X21pZ3JhdGV0eXBlX2lzb2xhdGUo
KSBpbiANCj4gPiA+PiBzb2Z0X29mZmxpbmVfcGFnZSAoKS4NCj4gPiA+Pg0KPiA+ID4+IEFuZCB0
aGlzIHBhdGNoIDI0M2FiZDViDQo+ID4gPj4gKG1tOiBodWdldGxiOiBwcmV2ZW50IHJldXNlIG9m
IGh3cG9pc29uZWQgZnJlZSBodWdlcGFnZXMpIGNoYW5nZXMgDQo+ID4gPj4gaWYNCj4gPiA+PiAo
IWlzX21pZ3JhdGVfaXNvbGF0ZV9wYWdlKHBhZ2UpKSB0byBpZiAoIVBhZ2VIV1BvaXNvbihwYWdl
KSksIHNvIGl0IA0KPiA+ID4+IGNvdWxkIHByZXZlbnQgc29tZW9uZSByZXVzZSB0aGUgZnJlZSBo
dWdldGxiIGFnYWluIGFmdGVyIHNldCB0aGUgDQo+ID4gPj4gaHdwb2lzb24gZmxhZyBpbiBzb2Z0
X29mZmxpbmVfZnJlZV9wYWdlKCkNCj4gPiA+Pg0KPiA+ID4+IE15IHF1ZXN0aW9uIGlzIHRoYXQg
aWYgc29tZW9uZSByZXVzZSB0aGUgZnJlZSBodWdldGxiIGFnYWluIGJlZm9yZQ0KPiA+ID4+IHNv
ZnRfb2ZmbGluZV9mcmVlX3BhZ2UoKSBhbmQNCj4gPiA+PiBhZnRlciBnZXRfYW55X3BhZ2UoKSwg
dGhlbiBpdCB1c2VzIHRoZSBob3BvaXNvbiBwYWdlLCBhbmQgdGhpcyBtYXkgDQo+ID4gPj4gdHJp
Z2dlciBtY2Uga2lsbCBsYXRlciwgcmlnaHQ/DQo+ID4gPiANCj4gPiA+IEhpIFhpc2hpLA0KPiA+
ID4gDQo+ID4gPiBUaGFuayB5b3UgZm9yIHBvaW50aW5nIG91dCB0aGUgaXNzdWUuIFRoYXQncyBu
aWNlIGNhdGNoLg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoYXQgdGhlIHJhY2UgY29uZGl0aW9u
IGl0c2VsZiBjb3VsZCBoYXBwZW4sIGJ1dCBpdCBkb2Vzbid0IA0KPiA+ID4gbGVhZCB0byBNQ0Ug
a2lsbCBiZWNhdXNlIFBhZ2VIV1BvaXNvbiBpcyBub3QgdmlzaWJsZSB0byBIVyB3aGljaCB0cmln
Z2VycyBNQ0UuDQo+ID4gPiBQYWdlSFdQb2lzb24gZmxhZyBpcyBqdXN0IGEgZmxhZyBpbiBzdHJ1
Y3QgcGFnZSB0byByZXBvcnQgdGhlIG1lbW9yeSANCj4gPiA+IGVycm9yIGZyb20ga2VybmVsIHRv
IHVzZXJzcGFjZS4gU28gZXZlbiBpZiBhIENQVSBpcyBhY2Nlc3NpbmcgdG8gdGhlIA0KPiA+ID4g
cGFnZSB3aG9zZSBzdHJ1Y3QgcGFnZSBoYXMgUGFnZUhXUG9pc29uIHNldCwgdGhhdCBkb2Vzbid0
IGNhdXNlIGEgDQo+ID4gPiBNQ0UgdW5sZXNzIHRoZSBwYWdlIGlzIHBoeXNpY2FsbHkgYnJva2Vu
Lg0KPiA+ID4gVGhlIHR5cGUgb2YgbWVtb3J5IGVycm9yIHRoYXQgc29mdCBvZmZsaW5lIHRyaWVz
IHRvIGhhbmRsZSBpcyANCj4gPiA+IGNvcnJlY3RlZCBvbmUgd2hpY2ggaXMgbm90IGEgZmFpbHVy
ZSB5ZXQgYWx0aG91Z2ggaXQncyBzdGFydGluZyB0byB3ZWFyLg0KPiA+ID4gU28gc3VjaCBQYWdl
SFdQb2lzb24gcGFnZSBjYW4gYmUgcmV1c2VkLCBidXQgdGhhdCdzIG5vdCBjcml0aWNhbCANCj4g
PiA+IGJlY2F1c2UgdGhlIHBhZ2UgaXMgZnJlZWQgYXQgc29tZSBwb2ludCBhZnRlcndvcmQgYW5k
IGVycm9yIGNvbnRhaW5tZW50IGNvbXBsZXRlcy4NCj4gPiA+IA0KPiA+ID4gSG93ZXZlciwgSSBu
b3RpY2VkIHRoYXQgdGhlcmUncyBhIHNtYWxsIHBhaW4gaW4gZnJlZSBodWdldGxiIGNhc2UuDQo+
ID4gPiBXZSBjYWxsIGRpc3NvbHZlX2ZyZWVfaHVnZV9wYWdlKCkgaW4gc29mdF9vZmZsaW5lX2Zy
ZWVfcGFnZSgpIHdoaWNoIA0KPiA+ID4gbW92ZXMgdGhlIFBhZ2VIV1BvaXNvbiBmbGFnIGZyb20g
dGhlIGhlYWQgcGFnZSB0byB0aGUgcmF3IGVycm9yIHBhZ2UuDQo+ID4gPiBJZiB0aGUgcmVwb3J0
ZWQgcmFjZSBoYXBwZW5zLCBkaXNzb2x2ZV9mcmVlX2h1Z2VfcGFnZSgpIGp1c3QgcmV0dXJuIA0K
PiA+ID4gd2l0aG91dCBkb2luZyBhbnkgZGlzc29sdmUgd29yayBiZWNhdXNlICJpZiAoUGFnZUh1
Z2UocGFnZSkgJiYgIXBhZ2VfY291bnQocGFnZSkpIg0KPiA+ID4gYmxvY2sgaXMgc2tpcHBlZC4N
Cj4gPiA+IFRoZSBodWdlcGFnZSBpcyBhbGxvY2F0ZWQgYW5kIHVzZWQgYXMgdXN1YWwsIGJ1dCB0
aGUgY29udGFpbWVudCANCj4gPiA+IGRvZXNuJ3QgY29tcGxldGUgYXMgZXhwZWN0ZWQgaW4gdGhl
IG5vcm1hbCBwYWdlLCBiZWNhdXNlDQo+ID4gPiBmcmVlX2h1Z2VfcGFnZXMoKSBkb2Vzbid0IGNh
bGwgZGlzc29sdmVfZnJlZV9odWdlX3BhZ2UoKSBmb3IgDQo+ID4gPiBod3BvaXNvbiBodWdlcGFn
ZS4gVGhpcyBpcyBub3QgY3JpdGljYWwgYmVjYXVzZSBzdWNoIGVycm9yIGh1Z2VwYWdlIA0KPiA+
ID4ganVzdCByZXNpZGUgaW4gZnJlZSBodWdlcGFnZSBsaXN0LiBCdXQgdGhpcyBtaWdodCBsb29r
cyBsaWtlIGEga2luZCANCj4gPiA+IG9mIG1lbW9yeSBsZWFrLiBBbmQgZXZlbiB3b3JzZSB3aGVu
IGh1Z2VwYWdlIHBvb2wgaXMgc2hyaW5rZWQgYW5kIA0KPiA+ID4gdGhlIGh3cG9pc29uIGh1Z2Vw
YWdlIGlzIGZyZWVkLCB0aGUgUGFnZUhXUG9pc29uIGZsYWcgaXMgc3RpbGwgb24gdGhlIGhlYWQg
cGFnZSB3aGljaCBpcyB1bmxpa2VseSB0byBiZSBhbiBhY3R1YWwgZXJyb3IgcGFnZS4NCj4gPiA+
IA0KPiA+ID4gU28gSSB0aGluayB3ZSBuZWVkIGltcHJvdmVtZW50IGhlcmUsIGhvdyBhYm91dCB0
aGUgZml4IGxpa2UgYmVsb3c/DQo+ID4gPiANCj4gPiA+ICAgKG5vdCB0ZXN0ZWQgeWV0LCBzb3Jy
eSkNCj4gPiA+IA0KPiA+ID4gICBkaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LWZhaWx1cmUuYyBiL21t
L21lbW9yeS1mYWlsdXJlLmMNCj4gPiA+ICAgLS0tIGEvbW0vbWVtb3J5LWZhaWx1cmUuYw0KPiA+
ID4gICArKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQo+ID4gPiAgIEBAIC0xODgzLDYgKzE4ODMs
MTEgQEAgc3RhdGljIHZvaWQgc29mdF9vZmZsaW5lX2ZyZWVfcGFnZShzdHJ1Y3QgcGFnZSAqcGFn
ZSkNCj4gPiA+ICAgICAgICAgICBzdHJ1Y3QgcGFnZSAqaGVhZCA9IGNvbXBvdW5kX2hlYWQocGFn
ZSk7DQo+ID4gPiAgIA0KPiA+ID4gICAgICAgICAgIGlmICghVGVzdFNldFBhZ2VIV1BvaXNvbiho
ZWFkKSkgew0KPiA+ID4gICArICAgICAgICAgICAgICAgaWYgKHBhZ2VfY291bnQoaGVhZCkpIHsN
Cj4gPiA+ICAgKyAgICAgICAgICAgICAgICAgICAgICAgQ2xlYXJQYWdlSFdQb2lzb24oaGVhZCk7
DQo+ID4gPiAgICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiA+ICAgKyAgICAg
ICAgICAgICAgIH0NCj4gPiA+ICAgKw0KPiA+ID4gICAgICAgICAgICAgICAgICAgbnVtX3BvaXNv
bmVkX3BhZ2VzX2luYygpOw0KPiA+ID4gICAgICAgICAgICAgICAgICAgaWYgKFBhZ2VIdWdlKGhl
YWQpKQ0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICBkaXNzb2x2ZV9mcmVlX2h1Z2Vf
cGFnZShwYWdlKTsNCj4gPiA+IA0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gTmFveWEgSG9yaWd1Y2hp
DQo+ID4gPiANCj4gPiA+IC4NCj4gPiA+IA0KPiA+IA0KPiA+IC0tDQo+ID4gVGhhbmtzLA0KPiA+
IFhpZSBYaXVRaQ0KPiA+IA==

