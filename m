Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFCDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EDC20846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9EDC20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387947AbeGKQhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:37:54 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:59959 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387727AbeGKQhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:37:54 -0400
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id w6BGWLOX007142
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 01:32:21 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6BGWLJF021870;
        Thu, 12 Jul 2018 01:32:21 +0900
Received: from mail02.kamome.nec.co.jp (mail02.kamome.nec.co.jp [10.25.43.5])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id w6BGWLXD002287;
        Thu, 12 Jul 2018 01:32:21 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.140] [10.38.151.140]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-1905699; Thu, 12 Jul 2018 01:31:16 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC12GP.gisp.nec.co.jp ([10.38.151.140]) with mapi id 14.03.0319.002; Thu,
 12 Jul 2018 01:31:15 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Masaki Tachibana <mas-tachibana@vf.jp.nec.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] uts: Don't randomize "struct uts_namespace".
Thread-Topic: [PATCH] uts: Don't randomize "struct uts_namespace".
Thread-Index: AQHUFX6ASnXzCzL8XECr2n/5vacVkaSKO0hA
Date:   Wed, 11 Jul 2018 16:31:15 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035582C1@BPXM09GP.gisp.nec.co.jp>
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
 <271dcdcd-d622-552c-338a-5eeca5e2b4a0@i-love.sakura.ne.jp>
In-Reply-To: <271dcdcd-d622-552c-338a-5eeca5e2b4a0@i-love.sakura.ne.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.133.131]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGV0c3VvLA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwb3J0Lg0KDQpPbiBGcmlkYXksIEp1bHkg
NiwgMjAxOCA3OjEwIFBNLCBUZXRzdW8gSGFuZGEgd3JvdGU6DQo+IEhlbGxvIEtlbidpY2hpLA0K
PiANCj4gSSBub3RpY2VkIHRoYXQgbWFrZWR1bXBmaWxlICggaHR0cHM6Ly9zb3VyY2Vmb3JnZS5u
ZXQvcC9tYWtlZHVtcGZpbGUvY29kZS8gKQ0KPiBjYW4gbm8gbG9uZ2VyIGRldGVjdCBrZXJuZWwg
dmVyc2lvbiBjb3JyZWN0bHkgYmVjYXVzZSAic3RydWN0IHV0c19uYW1lc3BhY2UiDQo+ICh3aGlj
aCBpcyBleHBvc2VkIHRvIHVzZXJzcGFjZSB2aWEgdm1jb3JlaW5mbykgaXMgc3ViamVjdGVkIHRv
IHJhbmRvbWl6YXRpb24NCj4gYnkgR0NDX1BMVUdJTl9SQU5EU1RSVUNUIGtlcm5lbCBjb25maWcg
b3B0aW9uIHNpbmNlIDQuMTMuDQo+IA0KPiBUaGUgY29kZSB3YXMgaW50cm9kdWNlZCBieSBiZWxv
dyBjb21taXQuDQo+IA0KPiAgIGNvbW1pdCBiZmM4ZmUxODFjODIyYWQwZDg0OTVjZWRhM2M3MTA5
YTQwNzE5MmYwDQo+ICAgQXV0aG9yOiBrZW4xX29obWljaGkgPGtlbjFfb2htaWNoaT4NCj4gICBE
YXRlOiAgIEZyaSBEZWMgMjIgMDc6NDE6MTQgMjAwNiArMDAwMA0KPiANCj4gICAgICAgbGludXgt
Mi42LjE5IHN1cHBvcnQuDQo+ICAgICAgIE9uIGxpbnV4LTIuNi4xOCBvciBmb3JtZXIsIHRoZSBy
ZWxlYXNlIGluZm9ybWF0aW9uIGNvdWxkIGJlIGdvdHRlbiBmcm9tDQo+ICAgICAgIHRoZSBzeW1i
b2wgInN5c3RlbV91dHNuYW1lIi4gQnV0IG9uIGxpbnV4LTIuNi4xOSwgaXQgY2FuIGJlIGRvbmUg
ZnJvbSB0aGUNCj4gICAgICAgc3ltYm9sICJpbml0X3V0c19ucyIuIEEgbmV3IG1ha2VkdW1wZmls
ZSBjYW4gZ2V0IHRoZSByZWxlYXNlIGluZm9ybWF0aW9uDQo+ICAgICAgIGZyb20gdGhlIGV4aXN0
aW5nIHN5bWJvbC4NCj4gDQo+IENhbiB5b3UgZGV0ZWN0IGtlcm5lbCB2ZXJzaW9uIHdpdGhvdXQg
dXNpbmcgInN0cnVjdCB1dHNfbmFtZXNwYWNlIiA/DQoNCm1ha2VkdW1wZmlsZSBuZWVkcyBhIHdo
b2xlICJzdHJ1Y3QgbmV3X3V0c25hbWUiIGRhdGEgaW4gInN0cnVjdCB1dHNfbmFtZXNwYWNlIg0K
YmVjYXVzZSBpdCBoYXMgdG8gd3JpdGUgdGhlIGRhdGEgb3V0IHRvIGR1bXAgZmlsZSBoZWFkZXIs
IHNvIHdlIG5lZWQgdG8gYWRkDQp0aGUgb2Zmc2V0IG9mIHV0c19uYW1lc3BhY2UubmFtZSB0byB2
bWNvcmVpbmZvIG9yIGdldCBpdCBmcm9tIHZtbGludXguDQpCdXQgSSdtIG5vdCBzdXJlIHdoZXRo
ZXIgaXQgaXMgYWxsIHRvIGdldCBtYWtlZHVtcGZpbGUgd29ya2luZyB3ZWxsIHdpdGggdGhlDQpy
YW5kb21pemF0aW9uLCBlLmcuIHNvbWUgYWRkaXRpb25hbCBvZmZzZXQgZXhwb3N1cmVzIG1pZ2h0
IGJlIG5lZWRlZC4NCg0KQW5kIEkgc2F3IGEgcmVwb3J0IHRvIHRoZSBjcmFzaCB1dGlsaXR5IG1h
aWxpbmcgbGlzdCB0aGF0IGNyYXNoIGFsc28gY291bGRuJ3QNCndvcmsgd2l0aCB0aGUgcmFuZG9t
aXphdGlvbiBkdWUgdG8gYSB2bWxpbnV4IGlzc3VlLCBzbyBpZiBpdCBpcyBzdGlsbCBub3QgZml4
ZWQsDQpldmVuIGlmIG1ha2VkdW1wZmlsZSAoYW5kIGtlcm5lbCkgaXMgZml4ZWQsIHdlIGNhbm5v
dCB1c2UgY3Jhc2guDQoNCiogW0NyYXNoLXV0aWxpdHldIFVzaW5nIGNyYXNoIHdpdGggc3RydWN0
dXJlIGxheW91dCByYW5kb21pemVkIGtlcm5lbA0KICBodHRwczovL3d3dy5yZWRoYXQuY29tL2Fy
Y2hpdmVzL2NyYXNoLXV0aWxpdHkvMjAxOC1KYW51YXJ5L3RocmVhZC5odG1sIzAwMDM1DQoNClRo
YW5rcywNCkthenUNCg0KPiANCj4gT24gMjAxOC8wNy8wNyAxOjExLCBMaW51cyBUb3J2YWxkcyB3
cm90ZToNCj4gPiBPbiBGcmksIEp1bCA2LCAyMDE4IGF0IDM6MDcgQU0gVGV0c3VvIEhhbmRhDQo+
ID4gPHBlbmd1aW4ta2VybmVsQGktbG92ZS5zYWt1cmEubmUuanA+IHdyb3RlOg0KPiA+Pg0KPiA+
PiBJIG5vdGljZWQgdGhhdCBtYWtlZHVtcGZpbGUgdXRpbGl0eSBpcyBmYWlsaW5nIHRvIGNoZWNr
IGtlcm5lbCB2ZXJzaW9uLCBmb3INCj4gPj4gaXQgZGVwZW5kcyBvbiBvZmZzZXQgb2YgInN0cnVj
dCB1dHNfbmFtZXNwYWNlIi0+bmFtZSBiZWluZyBzaXplb2YoaW50KS4NCj4gPg0KPiA+IEZvciBz
b21ldGhpbmcgbGlrZSB0aGlzLCB3ZSBmaXggbWFrZWR1bXBmaWxlIGluc3RlYWQuIFRoaXMgaXMg
bm90IGENCj4gPiAidXNlciBwcm9ncmFtIiB1c2luZyBzeXN0ZW0gY2FsbHMgZXRjLCB0aGlzIGlz
IHNvbWV0aGluZyB0aGF0IGRlbHZlcw0KPiA+IGludG8gdGhlIGtlcm5lbCBkdW1wIGFuZCB0cmll
cyB0byBtYWtlIHNlbnNlIG9mIGl0Lg0KPiA+DQo+ID4gV2hlcmUgaXMgdGhlIG1ha2VkdW1wZmls
ZSBzb3VyY2UgY29kZT8gV2hhdCBpcyBpdCB0cnlpbmcgdG8gZG8sIGFuZCB3aHk/DQo+ID4NCj4g
PiBPbmUgb3B0aW9uIGlzIHRvIGp1c3Qgc2F5ICJoZXksIHlvdSBjYW4ndCBtYWtlIG11Y2ggc2Vu
c2Ugb2YgYQ0KPiA+IHJhbmRvbWl6ZWQga2VybmVsIGR1bXAgYW55d2F5LCBzbyBkb24ndCBldmVu
IHRyeSIuDQo+ID4NCj4gPiAgICAgICAgICAgICAgICAgIExpbnVzDQo+ID4NCj4gDQoNCg==

