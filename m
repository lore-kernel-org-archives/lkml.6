Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36140C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFE22081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="M4yadYkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFE22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeKJABq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:01:46 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:50316 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbeKJABq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:01:46 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 6F1D224E096E;
        Fri,  9 Nov 2018 06:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541773258; bh=TR+XpSyEJfvsXKXwcIVjqgoCL6DmXKpa3iQs27vLTjY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=M4yadYkX/b5/wicbte3fm8tFa3RTYLYZC5BcQq1x/TX5cqN6m9Zyje9UmilbHVSwm
         B9yx0qyPiBJ8MCgIaf4YJ5cEL5izjIR/XluGA9wpETFHZWMAQftWcTLCr+eKBWXqi5
         mZe4CH5RAiysSBUTeS6WL0WHopGCaFU6SOgneFBx5ZsVeXGnTnJTi/8RiWMospuCWO
         8nf7hI4Gh57LZjZXN3gzT+5oZL9V9X2Jcu1lJXeAYl+miaWwv+PgmAtqJjK49IBQPt
         eP8gHXIxT0nFkLEa9WADijOCYsdvmJU5IsbvEnacodmeWwHPmVoGJ6N9yBZZKxoKDF
         rv1MotWglTD9A==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5331F3E05;
        Fri,  9 Nov 2018 06:20:58 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 9 Nov 2018 06:20:58 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCB.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Fri,
 9 Nov 2018 15:20:56 +0100
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     "ldv@altlinux.org" <ldv@altlinux.org>
CC:     "lineprinter@altlinux.org" <lineprinter@altlinux.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "vineet.gupta1@synopsys.com" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH 02/13] elf-em.h: add EM_ARC
Thread-Topic: [PATCH 02/13] elf-em.h: add EM_ARC
Thread-Index: AQHUd9qM9aFs73hD9Uit6LJSRYSl/aVHbmAA
Date:   Fri, 9 Nov 2018 14:20:55 +0000
Message-ID: <662c91c2859af216fb7c16351d8136310afd05cd.camel@synopsys.com>
References: <20181109031536.GB21511@altlinux.org>
In-Reply-To: <20181109031536.GB21511@altlinux.org>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.2 (3.30.2-2.fc29) 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <69956CFF419EE2438AAD060261880F38@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG1pdHJ5LA0KDQpPbiBGcmksIDIwMTgtMTEtMDkgYXQgMDY6MTUgKzAzMDAsIERtaXRyeSBW
LiBMZXZpbiB3cm90ZToNCj4gVGhlIHVhcGkvbGludXgvYXVkaXQuaCBoZWFkZXIgaXMgZ29pbmcg
dG8gdXNlIEVNX0FSQyBpbiBvcmRlcg0KPiB0byBkZWZpbmUgQVVESVRfQVJDSF9BUkMgd2hpY2gg
aXMgbmVlZGVkIHRvIGltcGxlbWVudA0KPiBzeXNjYWxsX2dldF9hcmNoKCkgd2hpY2ggaW4gdHVy
biBpcyByZXF1aXJlZCB0byBleHRlbmQNCj4gdGhlIGdlbmVyaWMgcHRyYWNlIEFQSSB3aXRoIFBU
UkFDRV9HRVRfU1lTQ0FMTF9JTkZPIHJlcXVlc3QuDQo+IA0KPiBUaGUgdmFsdWUgZm9yIEVNX0FS
QyBoYXMgYmVlbiB0YWtlbiBmcm9tDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwLTNBX193d3cuc2NvLmNvbV9kZXZlbG9wZXJzX2dhYmlfMjAxMi0yRDEy
LTJEMzFfY2g0LmVoZWFkZXIuaHRtbCZkPUR3SUNBZyZjPURQTDZfWF82SmtYRng3QVhXcUIwdGcm
cj1scWRlZVNTRWVzMEdGRERsNjU2ZVZpWE83YnJlUzU1eXRXa2hwazVSODFJJm09WGg3UE85WmN3
dGJId3p3dWd3aHUwTlp5cE85T2JNNXpNa1hpUTJqYS1RSSZzPTIzcHFqcDM3VVhLU3hRQzBBRnpx
QmpQcXVKZHJoXzRGalNXMDBGTFJmNGsmZT0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERtaXRyeSBW
LiBMZXZpbiA8bGR2QGFsdGxpbnV4Lm9yZz4NCj4gLS0tDQo+ICBpbmNsdWRlL3VhcGkvbGludXgv
ZWxmLWVtLmggfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9lbGYtZW0uaCBiL2luY2x1ZGUvdWFwaS9s
aW51eC9lbGYtZW0uaA0KPiBpbmRleCBiYTM2OTZlM2Q2OTQuLjU2ZmYzZjlkOTYzMyAxMDA2NDQN
Cj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L2VsZi1lbS5oDQo+ICsrKyBiLw0KPiBAQCAtMjYs
NiArMjYsNyBAQA0KPiAgI2RlZmluZSBFTV9BUk0JCTQwCS8qIEFSTSAzMiBiaXQgKi8NCj4gICNk
ZWZpbmUgRU1fU0gJCTQyCS8qIFN1cGVySCAqLw0KPiAgI2RlZmluZSBFTV9TUEFSQ1Y5CTQzCS8q
IFNQQVJDIHY5IDY0LWJpdCAqLw0KPiArI2RlZmluZSBFTV9BUkMJCTQ1CS8qIEFyZ29uYXV0IFJJ
U0MgQ29yZSAqLw0KPiAgI2RlZmluZSBFTV9IOF8zMDAJNDYJLyogUmVuZXNhcyBIOC8zMDAgKi8N
Cj4gICNkZWZpbmUgRU1fSUFfNjQJNTAJLyogSFAvSW50ZWwgSUEtNjQgKi8NCj4gICNkZWZpbmUg
RU1fWDg2XzY0CTYyCS8qIEFNRCB4ODYtNjQgKi8NCg0KSSBndWVzcyB3ZSBuZWVkIHRvIGFkZCBB
UkN2MiBoZXJlIGFzIHdlbGwgbGlrZSB0aGF0Og0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPjgt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9l
bGYtZW0uaCBiL2luY2x1ZGUvdWFwaS9saW51eC9lbGYtZW0uaA0KaW5kZXggMzFhYTEwMTc4MzM1
Li41YzZjMjYzZDVjNjkgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvZWxmLWVtLmgN
CisrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9lbGYtZW0uaA0KQEAgLTQxLDYgKzQxLDcgQEANCiAj
ZGVmaW5lIEVNX1RJTEVQUk8gICAgIDE4OCAgICAgLyogVGlsZXJhIFRJTEVQcm8gKi8NCiAjZGVm
aW5lIEVNX01JQ1JPQkxBWkUgIDE4OSAgICAgLyogWGlsaW54IE1pY3JvQmxhemUgKi8NCiAjZGVm
aW5lIEVNX1RJTEVHWCAgICAgIDE5MSAgICAgLyogVGlsZXJhIFRJTEUtR3ggKi8NCisjZGVmaW5l
IEVNX0FSQ1YyICAgICAgIDE5NSAgICAgLyogU3lub3BzeXMgQVJDdjIgSVNBICovDQogI2RlZmlu
ZSBFTV9CUEYgICAgICAgICAyNDcgICAgIC8qIExpbnV4IEJQRiAtIGluLWtlcm5lbCB2aXJ0dWFs
IG1hY2hpbmUgKi8NCiAjZGVmaW5lIEVNX0ZSViAgICAgICAgIDB4NTQ0MSAgLyogRnVqaXRzdSBG
Ui1WICovDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+OC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQoNClNlZSBodHRwczovL3NvdXJjZXdhcmUub3JnL2dpdC9naXR3ZWIuY2dpP3A9YmludXRpbHMt
Z2RiLmdpdDthPWJsb2I7Zj1pbmNsdWRlL2VsZi9jb21tb24uaDtoYj1IRUFEI2wzMDkNCk5vdGUg
dGhvdWdoIHRoYXQgd2UncmUgbW92aW5nIGZyb20gRU1fQVJDX0NPTVBBQ1QyIHRvIEVNX0FSQ1Yy
IG5hbWUNCnNvIGl0IG1hdGNoZXMgcmVhbCBJU0EgbmFtZS4gVGhpcyBpcyB3aGF0IHdlIHVzZSBp
biBHbGliYyBwb3J0IHdlJ3JlDQp1cHN0cmVhbWluZyBub3cuDQoNCi1BbGV4ZXkNCg==
