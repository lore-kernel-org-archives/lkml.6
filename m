Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CABC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858E12087E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cFYkQ7AX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbfA2R00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:26:26 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:60102 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfA2R00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:26:26 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 281B324E2189;
        Tue, 29 Jan 2019 09:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548782786; bh=kPvUhwU6rQy2WKLVaIcLpTo4V484C+OVWh7gwmJRhh8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cFYkQ7AXytAN0LAqqg+R70VPYl3BCREwBqaPcKsGkYgccfHQuEFPwFvkR7PWGJ2QK
         nftIryV1o5D+197F7zsEKDWSv2u7aK2OY22n3lLT1y40ixtq28TMEmYcChdboE2knF
         dBw0idfQ+/rxbqqjHkIpUGQ7m0bYorMBXp1gvujH9d5tL/2st+YE+O7+vJjtWGob7x
         ZWlV6RLrxrOiROUdUrR1mu4jcpexJQ27qgpixDSzTFhSQGkVT069FQgH8ur29/FMJh
         hIO8uGXNq7x1MjsMoN4nHBBHl0IGwIvja1J8KYm7TNKaylG0lcSGLkvJR4ZLbjpFM9
         ZpddXzqQNiFww==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E0F91A005A;
        Tue, 29 Jan 2019 17:26:21 +0000 (UTC)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 29 Jan 2019 09:26:00 -0800
Received: from DE02WEMBXB.internal.synopsys.com ([fe80::95ce:118a:8321:a099])
 by DE02WEHTCA.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 29 Jan 2019 18:25:57 +0100
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     "Eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 1/2] ARCv2: Enable unaligned access in early ASM code
Thread-Topic: [PATCH 1/2] ARCv2: Enable unaligned access in early ASM code
Thread-Index: AQHUrY7S1r2HqQHrAUmKrUzEXiBQFaXGgk+AgAABMgA=
Date:   Tue, 29 Jan 2019 17:25:57 +0000
Message-ID: <1548782756.29008.20.camel@synopsys.com>
References: <20190116112951.10641-1-Eugeniy.Paltsev@synopsys.com>
         <3c341dd9-f360-640e-a3c9-3291300d02ae@synopsys.com>
In-Reply-To: <3c341dd9-f360-640e-a3c9-3291300d02ae@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F6D8FD84281D84CB117EC3F745A1C6B@internal.synopsys.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAxLTI5IGF0IDA5OjIxIC0wODAwLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+
IE9uIDEvMTYvMTkgMzoyOSBBTSwgRXVnZW5peSBQYWx0c2V2IHdyb3RlOg0KPiA+IEV2ZW4gdGhv
dWdoIHdlIGRvIGVuYWJsZSBBRCBiaXQgaW4gYXJjX2luaXRfSVJRKCkgd2UgbmVlZCB0byBkbw0K
PiA+IGl0IGluIGVhcmx5IEFTTSBjb2RlIG90aGVyd2lzZSB3ZSBtYXkgZmFjZSB1bmFsaWduZWQg
ZGF0YSB1bnRpbA0KPiA+IHdlIHJlYWNoIGFyY19pbml0X0lSUSgpIGJlY2F1c2UgR0NDIHN0YXJ0
aW5nIGZyb20gdjguMS4wIGFjdGl2ZWx5DQo+ID4gZ2VuZXJhdGVzIHVuYWxpZ25lZCBkYXRhIGFz
IGl0IGFzc3VtZXMgdGhhdDoNCj4gPiAgKiBBUkN2MiBhbHdheXMgaGFzIHN1cHBvcnQgb2YgdW5h
bGlnZWQgZGF0YQ0KPiA+ICAqIFRoaXMgc3VwcG9ydCBpcyB0dXJuZWQgb24gaW4gcnVudGltZQ0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2
QHN5bm9wc3lzLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcmMva2VybmVsL2hlYWQuUyB8IDEw
ICsrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcmMva2VybmVsL2hlYWQuUyBiL2FyY2gvYXJjL2tlcm5l
bC9oZWFkLlMNCj4gPiBpbmRleCA4YjkwZDI1YTE1Y2MuLmQ1YjdhNTcyMzY1YSAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FyYy9rZXJuZWwvaGVhZC5TDQo+ID4gKysrIGIvYXJjaC9hcmMva2VybmVs
L2hlYWQuUw0KPiA+IEBAIC0xNyw2ICsxNyw5IEBADQo+ID4gICNpbmNsdWRlIDxhc20vZW50cnku
aD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9hcmNyZWdzLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vY2Fj
aGUuaD4NCj4gPiArI2lmZGVmIENPTkZJR19JU0FfQVJDVjINCj4gPiArI2luY2x1ZGUgPGFzbS9p
cnFmbGFncy1hcmN2Mi5oPg0KPiA+ICsjZW5kaWYNCj4gDQo+IEkgcHJlc3VtZSB0aGVyZSBpcyBu
byBzcGVjaWZpYyByZWFzb24gdG8gaW5jbHVkZSB0aGlzIGNvbmRpdGlvbmFsbHkuDQo+IGlycWZs
YWdzLmggYWxyZWFkeSBpbmNsdWRlcyB0aGUgcmlnaHQgdmVyc2lvbi4NCg0KQWdyZWUuDQpJJ3Zl
IGp1c3QgZm9yZ290dGVuIGFib3V0IGNvbW1vbiBpcnFmbGFncy5oDQoNCldpbGwgZml4IGluIFYy
Lg0KDQo+ID4gIA0KPiA+ICAubWFjcm8gQ1BVX0VBUkxZX1NFVFVQDQo+ID4gIA0KPiA+IEBAIC00
Nyw2ICs1MCwxMyBAQA0KPiA+ICAJc3IJcjUsIFtBUkNfUkVHX0RDX0NUUkxdDQo+ID4gIA0KPiA+
ICAxOg0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR19JU0FfQVJDVjINCj4gPiArCTsgRW5hYmxl
IGhhbmRsaW5nIG9mIHVuYWxpZ25lZCBhY2Nlc3MgaW4gdGhlIENQVSBhcyBieSBkZWZhdWx0DQo+
ID4gKwk7IHRoaXMgSFcgZmVhdHVyZSBpcyBkaXNhYmxlZCB3aGlsZSBHQ0Mgc3RhcnRpbmcgZnJv
bSA4LjEuMA0KPiA+ICsJOyB1bmNvbmRpdGlvbmFsbHkgdXNlcyBpdCBmb3IgQVJDIEhTIGNvcmVz
Lg0KPiA+ICsJZmxhZyAgICAxIDw8IFNUQVRVU19BRF9CSVQNCj4gPiArI2VuZGlmDQo+ID4gIC5l
bmRtDQo+ID4gIA0KPiA+ICAJLnNlY3Rpb24gLmluaXQudGV4dCwgImF4IixAcHJvZ2JpdHMNCj4g
PiANCj4gDQo+IA0KLS0gDQogRXVnZW5peSBQYWx0c2V2
