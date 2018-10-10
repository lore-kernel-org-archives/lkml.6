Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BBE21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BBE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeJJSmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 14:42:04 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25449 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726721AbeJJSmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 14:42:04 -0400
X-UUID: 495baa22912342c1b2aacf08a8782bb7-20181010
X-UUID: 495baa22912342c1b2aacf08a8782bb7-20181010
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 19850537; Wed, 10 Oct 2018 19:20:18 +0800
Received: from MTKMBS32N1.mediatek.inc (172.27.4.71) by
 MTKMBS32DR.mediatek.inc (172.27.6.104) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Oct 2018 19:20:16 +0800
Received: from MTKMBS32N1.mediatek.inc ([fe80::693d:d64d:d0b8:6f3e]) by
 MTKMBS32N1.mediatek.inc ([fe80::693d:d64d:d0b8:6f3e%23]) with mapi id
 15.00.1395.000; Wed, 10 Oct 2018 19:20:16 +0800
From:   =?utf-8?B?Q2h1bmh1aSBMaSAo5p2O5pil6L6JKQ==?= 
        <chunhui.li@mediatek.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morse <james.morse@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        =?utf-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <Miles.Chen@mediatek.com>,
        =?utf-8?B?V2FsdGVyLVpIIFd1ICjlkLPnpZblr7Ap?= 
        <Walter-ZH.Wu@mediatek.com>,
        =?utf-8?B?WXUgTGlhbmcgKOaigeWuhyk=?= <Yu.Liang@mediatek.com>,
        =?utf-8?B?TmljaG9sYXMgVGFuZyAo6YSt56em6LydKQ==?= 
        <nicholas.tang@mediatek.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0ga2FzYW46IGF2b2lkIG91dC1vZi1i?=
 =?utf-8?Q?ounds_in_unwind=5Fframe?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGthc2FuOiBhdm9pZCBvdXQtb2YtYm91bmRzIGlu?=
 =?utf-8?Q?_unwind=5Fframe?=
Thread-Index: AQHUX7hlcl/5Uvjz3E+Pcy5y9duGWqUWMuaAgAHVIND//6kFAIAApc6w
Date:   Wed, 10 Oct 2018 11:20:16 +0000
Message-ID: <a96f9343ed35422498432cc24405f39b@MTKMBS32N1.mediatek.inc>
References: <1539079863-19645-1-git-send-email-chunhui.li@mediatek.com>
 <20181009103833.sk2jyhl77f5fb64r@lakrids.cambridge.arm.com>
 <193a2b2efdaf41f39cb35a72feb3b39e@MTKMBS32N1.mediatek.inc>
 <20181010092618.pwkrqqw7br7762rs@lakrids.cambridge.arm.com>
In-Reply-To: <20181010092618.pwkrqqw7br7762rs@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.27.4.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KT2ssIHRoYW5rcyBmb3IgeW91ciBoZWxwDQoNCkJlc3QgcmVnYXJkcywNCkNo
dW5odWkgTGkNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBNYXJrIFJ1dGxh
bmQgW21haWx0bzptYXJrLnJ1dGxhbmRAYXJtLmNvbV0gDQrlj5HpgIHml7bpl7Q6IDIwMTjlubQx
MOaciDEw5pelIDE3OjI2DQrmlLbku7bkuro6IENodW5odWkgTGkgKOadjuaYpei+iSkNCuaKhOmA
gTogQ2F0YWxpbiBNYXJpbmFzOyBXaWxsIERlYWNvbjsgTWF0dGhpYXMgQnJ1Z2dlcjsgTWFyYyBa
eW5naWVyOyBBcmQgQmllc2hldXZlbDsgSmFtZXMgTW9yc2U7IE1hc2FoaXJvIFlhbWFkYTsgbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnOyB3c2RfdXBzdHJlYW07
IE1pbGVzIENoZW4gKOmZs+awkeaouik7IFdhbHRlci1aSCBXdSAo5ZCz56WW5a+wKTsgWXUgTGlh
bmcgKOaigeWuhyk7IE5pY2hvbGFzIFRhbmcgKOmEreenpui8nSkNCuS4u+mimDogUmU6IOetlOWk
jTogW1BBVENIXSBrYXNhbjogYXZvaWQgb3V0LW9mLWJvdW5kcyBpbiB1bndpbmRfZnJhbWUNCg0K
T24gV2VkLCBPY3QgMTAsIDIwMTggYXQgMDY6NDU6MTdBTSArMDAwMCwgQ2h1bmh1aSBMaSAo5p2O
5pil6L6JKSB3cm90ZToNCj4gSGkgTWFyaywNCj4gDQo+IGthc2FuIGRldGVjdCBvdXQtb2YtYm91
bmRzIGluIHN0YWNrdHJhY2UuYyBsaW5lIDcwLCBpdCdzIGFscmVhZHkgb3ZlciANCj4gUkVBRF9P
TkNFX05PQ0hFQ0ssIGJ1dCBzdGlsbCBjcmFzaCANCj4ga2VybmVsLTQuOS9hcmNoL2FybTY0L2tl
cm5lbC9zdGFja3RyYWNlLmMNCj4gNjlmcmFtZS0+c3AgPSBmcCArIDB4MTA7DQo+IDcwZnJhbWUt
PmZwID0gUkVBRF9PTkNFX05PQ0hFQ0soKih1bnNpZ25lZCBsb25nICopKGZwKSk7DQo+IA0KPiB3
ZSB0ZXN0IG9uIEFuZHJvaWQgcGxhdGZvcm0sIGtlcm5lbC00LjkgYnVpbGQgd2l0aCBjbGFuZyA2
LjAuMiwgd2Ugd2lsbCBkbyBleHBlcmltZW50IHRvIGNsYXJpZnkgd2hldGhlciBjb21waWxlciBy
ZWxhdGVkIGlzc3VlLg0KPiANCj4gUkVBRF9PTkNFX05PQ0hFQ0stPl9fcmVhZF9vbmNlX3NpemVf
bm9jaGVjayB3aXRoIF9fbm9fc2FuaXRpemVfYWRkcmVzcyANCj4gaWYgZW5hYmxlIENPTkZJR19L
QVNBTg0KPiANCj4ga2VybmVsLTQuOS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWdjYy5oDQo+ICNk
ZWZpbmUgX19ub19zYW5pdGl6ZV9hZGRyZXNzIF9fYXR0cmlidXRlX18oKG5vX3Nhbml0aXplX2Fk
ZHJlc3MpKQ0KPiANCj4ga2VybmVsLTQuOS9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWNsYW5nLmgN
Cj4gI2RlZmluZSBfX25vX3Nhbml0aXplX2FkZHJlc3MgX19hdHRyaWJ1dGVfXygobm9fc2FuaXRp
emUoImFkZHJlc3MiKSkpDQoNCklmIFJFQURfT05DRV9OT0NIRUNLKCkgaXNuJ3Qgd29ya2luZyBh
cyBpbnRlbmRlZCwgdGhlbiB0aGlzIGlzIGEgY29tcGlsZXIgaXNzdWUsIGFuZCB0aGVyZSBhcmUg
YmlnZ2VyIHByb2JsZW1zIHJlZ2FyZGxlc3MuDQoNCklmIHdlIG5lZWQgdG8gd29ya2Fyb3VuZCBz
b21lIGNvbXBpbGVyIGlzc3VlLCB0aGF0IHNob3VsZCBiZSBkb25lIGluIHRoZSBpbXBsZW1lbnRh
dGlvbiBvZiBSRUFEX09OQ0VfTk9DSEVDSygpLg0KDQpQbGVhc2Ugbm90ZSB0aGF0IHRoZXJlIGFy
ZSBvdGhlciBpc3N1ZXMgd2l0aCB1c2luZyBjbGFuZyB0byBjb21waWxlIHRoZSBrZXJuZWw7IGF0
IG1pbmltdW0gNy4wLjAgaXMgcmVxdWlyZWQgdG8gYnVpbGQgYSBtYWlubGluZSBrZXJuZWwgKGFu
ZCBldmVuIHRoZW4sIHRoZSBMU0UgYXRvbWljcyBoYXZlIHRvIGJlIGV4cGxpY2l0bHkgZGlzYWJs
ZWQpLCBzbyBpZiB0aGlzIG9ubHkgYWZmZWN0cyA2LjAueCwgSSBkb24ndCB0aGluayB3ZSBuZWVk
IHRvIGNhcnJ5IGFueSB3b3JrYXJvdW5kIHVwc3RyZWFtLg0KDQo+IHRoZXJlIGlzIHBhdGNoIGZy
b20gaW50ZXJuZXQsIGF2b2lkIGthc2FuIGJ5IHdyYXBwaW5nIHdpdGgga2FzYW5fZGlzYWJsZV9j
dXJyZW50LCBpdCBzZWVtcyBiZXR0ZXIuDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNo
d29yay9wYXRjaC82NDQ0NjMNCj4gc3VjaCBhczoNCj4gK2thc2FuX2Rpc2FibGVfY3VycmVudCgp
Ow0KPiAgIC8vIGFjY2VzcyBmcA0KPiAra2FzYW5fZW5hYmxlX2N1cnJlbnQoKTsNCg0KUGxlYXNl
IG5vdGUgdGhhdCB0aGUgc29sdXRpb24gbGF0ZXIgaW4gdGhlIHRocmVhZCBbMV0gd2FzIHRvIHVz
ZSBSRUFEX09OQ0VfTk9DSEVDSygpLg0KDQpUaGFua3MsDQpNYXJrLg0KDQpbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzY0NDQ2My8jODI5ODU4DQo=
