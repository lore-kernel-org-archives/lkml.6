Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72EB6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 441BD2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfA2MaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:30:11 -0500
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:12515 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfA2MaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:30:08 -0500
Received: from kw-mxq.gw.nic.fujitsu.com (unknown [192.168.231.130]) by mgwkm04.jp.fujitsu.com with smtp
         id 0b63_1865_47820b2b_2bab_4999_a708_85581dd09052;
        Tue, 29 Jan 2019 21:30:01 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by kw-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id F3404AC00E7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 21:30:00 +0900 (JST)
Received: from G01JPEXCHKW18.g01.fujitsu.local (G01JPEXCHKW18.g01.fujitsu.local [10.0.194.57])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id 1118FBD66DF;
        Tue, 29 Jan 2019 21:30:00 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw18 ([10.0.194.57]) with mapi id 14.03.0415.000; Tue, 29 Jan 2019
 21:29:59 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     'Catalin Marinas' <catalin.marinas@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>
Subject: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Topic: [PATCH v3 0/1] arm64: Add workaround for Fujitsu A64FX erratum
 010001
Thread-Index: AdS3xNmu3mhhC9MiQRq9+42ieDlaoA==
Date:   Tue, 29 Jan 2019 12:29:58 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2C04E6@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gc29tZSB2YXJpYW50cyBvZiB0aGUgRnVqaXRzdS1BNjRGWCBjb3JlcyB2
ZXIoMS4wLCAxLjEpLCAgDQptZW1vcnkgYWNjZXNzZXMgbWF5IGNhdXNlIHVu
ZGVmaW5lZCBmYXVsdCAoRGF0YSBhYm9ydCwgREZTQz0wYjExMTExMSkuDQpU
aGlzIHByb2JsZW0gd2lsbCBiZSBmaXhlZCBieSBuZXh0IHZlcnNpb24gb2Yg
RnVqaXRzdS1BNjRGWC4NCg0KVGhpcyBmYXVsdCBvY2N1cnMgdW5kZXIgYSBz
cGVjaWZpYyBoYXJkd2FyZSBjb25kaXRpb24gDQp3aGVuIGEgbG9hZC9zdG9y
ZSBpbnN0cnVjdGlvbiBwZXJmb3JtIGFuIGFkZHJlc3MgdHJhbnNsYXRpb24g
dXNpbmc6DQogIGNhc2UtMSAgVFRCUjBfRUwxIHdpdGggVENSX0VMMS5ORkQw
ID09IDEuDQogIGNhc2UtMiAgVFRCUjBfRUwyIHdpdGggVENSX0VMMi5ORkQw
ID09IDEuDQogIGNhc2UtMyAgVFRCUjFfRUwxIHdpdGggVENSX0VMMS5ORkQx
ID09IDEuDQogIGNhc2UtNCAgVFRCUjFfRUwyIHdpdGggVENSX0VMMi5ORkQx
ID09IDEuDQpBbmQgdGhpcyBmYXVsdCBvY2N1cnMgY29tcGxldGVseSBzcHVy
aW91cy4NCg0KU2luY2UgVENSX0VMeC5ORkQxIGlzIHNldCB0byAnMScgYXQg
dGhlIGtlcm5lbCBpbiB2ZXJzaW9ucyANCnBhc3QgNC4xNywgdGhlIGNhc2Ut
MyBvciBjYXNlLTQgbWF5IGhhcHBlbi4NCg0KVGhpcyBmYXVsdCBjYW4gYmUg
dGFrZW4gb25seSBhdCBzdGFnZS0xLCANCnNvIHRoaXMgZmF1bHQgaXMgdGFr
ZW4gZnJvbSBFTDAgdG8gRUwxL0VMMiwgZnJvbSBFTDEgdG8gRUwxLCANCm9y
IGZyb20gRUwyIHRvIEVMMi4NCg0KSSB3b3VsZCBsaWtlIHRvIHBvc3QgYSB3
b3JrYXJvdW5kIHRvIGF2b2lkIHRoaXMgcHJvYmxlbSBvbiANCmV4aXN0aW5n
IEZ1aml0c3UtQTY0RlggdmVyc2lvbi4NCg0KVGhlcmUgYXJlIDIgcG9pbnRz
IGluIHRoaXMgd29ya2Fyb3VuZC4NClBvaW50MTogdHJhcCBmcm9tIEVMMSB0
byBFTDEsIEVMMiB0byBFTDINClNldCAnMCcgdG8gVENSX0VMeC5ORkQxaW4g
a2VybmVsLWVudHJ5LCANCmFuZCBzZXQgJzEnIGluIGtlcm5lbC1leGl0Lg0K
DQpGcm9tIHRoZSB2aWV3IHBvaW50IG9mIEFSTSBzcGVjaWZpY2F0aW9uLCB0
aGVyZSBpcyBubyBwcm9ibGVtIHRvIA0KcmVzZXQgVENSX0VMeC57TkZEMCxO
RkQxfSB3aGlsZSBpbiBFTDEvRUwyLCBiZWNhdXNlIA0KVENSX0VMeC57TkZE
MCxORkQxfSBjb250cm9scyB3aGV0aGVyIHRvIHBlcmZvcm0gYSB0cmFuc2xh
dGlvbiANCnRhYmxlIHdhbGsgaW4gcmVzcG9uc2UgdG8gYW4gYWNjZXNzIGZy
b20gRUwwLg0KDQpJIGNvbmZpcm1lZCB0aGF0Og0K44O7VGhlcmUgaXMgbm8g
bG9hZC9zdG9yZSBpbnN0cnVjdGlvbiBiZXR3ZWVuIA0KICB0cmFtcF92ZW50
cnkgYW5kIHNldHRpbmcgVENSX0VMeC5ORkQxIHRvICcwJy4NCuODu1RoZXJl
IGlzIG5vIGxvYWQvc3RvcmUgaW5zdHJ1Y3Rpb24gYmV0d2VlbiANCiAgc2V0
dGluZyBUQ1JfRUx4Lk5GRDEgdG8gJzEnIGFuZCB0cmFtcF9leGl0Lg0KDQpQ
b2ludDI6IHRyYXAgZnJvbSBFTDAgdG8gRUwxL0VMMg0KU2luY2UgdGhpcyBm
YXVsdCBhbHNvIG9jY3VycyBpbiBFTDAsDQpyZXBsYWNlIHRoZSBmYXVsdCBo
YW5kbGVyIGZvciBEYXRhIGFib3J0DQpERlNDPTBiMTExMTExIHdpdGggYSBu
ZXcgb25lIHRvIGlnbm9yZSB0aGlzIHVuZGVmaW5lZCBmYXVsdC4NCkkgZ3Vh
cmFudGVlIHRoYXQgYSB0aHJlYWQgd2lsbCBzdG9wIGRlbGl2ZXJpbmcgdGhp
cyBmYXVsdCBjb2RlIGJ5IGlnbm9yZQ0KdGhpcyB1bmRlZmluZWQgZmF1bHQu
DQoNClRoZSBoYXJkd2FyZSBjb25kaXRpb24gd2hpY2ggY2F1c2UgdGhpcyBm
YXVsdCBpcyByZXNldCBhdCBleGNlcHRpb24gZW50cnksIA0KdGhlcmVmb3Jl
IGV4ZWN1dGlvbiBvZiBhdCBsZWFzdCBvbmUgaW5zdHJ1Y3Rpb24gaXMgDQpn
dWFyYW50ZWVkIGJ5IHRoaXMgc2luZ2xlIHJldHJ5Lg0KDQoNClRoaXMgd29y
a2Fyb3VuZCBpcyBiYXNlZCBvbiBsaW51eC01LjAtcmMyLA0Kd2hpY2ggVENS
X0VMeC5ORkQxIGlzIHNldCB0byAnMScgDQpvbmx5IG9uY2UgYXQgYm9vdCBz
ZXF1ZW5jZSwgDQphbmQgVENSX0VMeC5ORkQwIGlzIG5vdCBzZXQgYnkga2Vy
bmVsLg0KSSB3aWxsIHVwZGF0ZSBteSBwYXRjaCBpZiBuZXcga2VybmVsIG1h
a2VzIHNvbWUgY2hhbmdlcw0KYWJvdXQgVENSX0VMeC57TkZEMCxORkQxfS4N
Cg0KQ2hhbmdlcyBzaW5jZSBbdjFdDQpBcyBNYXJrJ3MgcmV2aWV3Og0KDQog
KiBBZG9wdGVkIGVycmF0YSBmcmFtZXdvcmsuDQoNCkNoYW5nZXMgc2luY2Ug
W3YyXQ0KQXMgTWFyayBhbmQgSmFtZXMnIHJldmlldzoNCiANCiAqIEFkZGVk
IGZyYW1ld29yayB0byBjaGFuZ2UgVENSX0VMeC5ORkQxLg0KICAtIENoYW5n
ZSBUQ1JfRUx4Lk5GRDEgdG8gMCB3aGVuIGVudHJ5IGtlcm5lbC4NCiAgLSBD
aGFuZ2UgVENSX0VMeC5ORkQxIHRvIDEgd2hlbiBleGl0IGtlcm5lbC4NCg0K
SSBmdWxseSBhcHByZWNpYXRlIHRoYXQgaWYgc29tZW9uZSBjYW4gdGVzdCB0
aGlzIHBhdGNoIG9uIGRpZmZlcmVudCBjaGlwcyANCnRvIHZlcml0eSBubyBo
YXJtZnVsIGVmZmVjdCBvbiBvdGhlciBjaGlwcy4NCg0KSWYgdGhlcmUgaXMg
bm8gcHJvYmxlbSBvbiBvdGhlciBjaGlwcywgcGxlYXNlIG1lcmdlIHRoaXMg
cGF0Y2guDQoNClRoZSBwYXRjaCBiYXNlZCBvbiBsaW51eC01LjAtcmMyLg0K
DQpaaGFuZyBMZWkgKDEpOg0KICBBcm02NDogQWRkIHdvcmthcm91bmQgZm9y
IEZ1aml0c3UgQTY0RlggZXJyYXR1bSAwMTAwMDENCg0KIERvY3VtZW50YXRp
b24vYXJtNjQvc2lsaWNvbi1lcnJhdGEudHh0IHwgIDEgKw0KIGFyY2gvYXJt
NjQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgIHwgMjIgKysrKysrKysr
KysrKysrKysrKysrKw0KIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1Y2Fw
cy5oICAgICAgIHwgIDMgKystDQogYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9j
cHV0eXBlLmggICAgICAgfCAgNCArKysrDQogYXJjaC9hcm02NC9rZXJuZWwv
Y3B1X2VycmF0YS5jICAgICAgICAgfCAgOCArKysrKysrKw0KIGFyY2gvYXJt
NjQva2VybmVsL2VudHJ5LlMgICAgICAgICAgICAgIHwgMTYgKysrKysrKysr
KysrKysrKw0KIGFyY2gvYXJtNjQvbW0vZmF1bHQuYyAgICAgICAgICAgICAg
ICAgIHwgMTYgKysrKysrKysrKysrKysrLQ0KIGFyY2gvYXJtNjQvbW0vcHJv
Yy5TICAgICAgICAgICAgICAgICAgIHwgMjAgKysrKysrKysrKysrKysrKysr
KysNCiA4IGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQoNCi0tIA0KMS44LjMuMQ0K
