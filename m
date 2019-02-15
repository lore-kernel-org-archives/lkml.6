Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B984D218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394928AbfBONOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:14:31 -0500
Received: from mx.socionext.com ([202.248.49.38]:50791 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387962AbfBONOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:14:30 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 15 Feb 2019 22:14:28 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B60016117D;
        Fri, 15 Feb 2019 22:14:28 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Fri, 15 Feb 2019 22:14:28 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Fri, 15 Feb 2019 22:14:28 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Fri, 15 Feb 2019 22:14:28 +0900
From:   <sugaya.taichi@socionext.com>
To:     <arnd@arndb.de>
CC:     <kanematsu.shinji@socionext.com>, <masami.hiramatsu@linaro.org>,
        <daniel.lezcano@linaro.org>, <linux-kernel@vger.kernel.org>,
        <kasai.kazuhiro@socionext.com>, <jaswinder.singh@linaro.org>,
        <orito.takao@socionext.com>, <arnd.bergmann@linaro.org>,
        <linux-soc@vger.kernel.org>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
Thread-Topic: [PATCH v2 06/15] clocksource/drivers/timer-milbeaut: Introduce
 timer for Milbeaut SoCs
Thread-Index: AQHUv6l5WxG4u1Q7vEyLFPML69i0XKXbTjSAgAGq3YCAAdg9gIAACa+AgAC6TYCAAHBngIAA24mg
Date:   Fri, 15 Feb 2019 13:14:27 +0000
Message-ID: <9b1543a25ce34affa8f0301a7505196a@SOC-EX02V.e01.socionext.com>
References: <1549628812-31235-1-git-send-email-sugaya.taichi@socionext.com>
 <80f521e5-6207-a32f-2f79-c2cb81dd1908@linaro.org>
 <c6fd5a9d-17df-a13d-7634-4c54d3e65f9c@socionext.com>
 <8f4ea33f-f176-e8d6-40fc-3286bd6a3fcc@linaro.org>
 <CAK8P3a1u=u93v7FSwXMmexCvoTectdm1tDQ+g2AoB2_rTRTs=Q@mail.gmail.com>
 <feb7c60c-ed9a-1ff0-0871-d9b3fc7a40dc@socionext.com>
 <CAK8P3a0G_5JmL8SMCpP4metQAG2JFeDd86t6V0K+4yxzBSEGrw@mail.gmail.com>
In-Reply-To: <CAK8P3a0G_5JmL8SMCpP4metQAG2JFeDd86t6V0K+4yxzBSEGrw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.3.2
x-shieldmailcheckerpolicyversion: POLICY180220
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGludXgtYXJtLWtl
cm5lbA0KPiBbbWFpbHRvOmxpbnV4LWFybS1rZXJuZWwtYm91bmNlc0BsaXN0cy5pbmZyYWRlYWQu
b3JnXSBPbiBCZWhhbGYgT2YNCj4gQXJuZCBCZXJnbWFubg0KPiBTZW50OiBGcmlkYXksIEZlYnJ1
YXJ5IDE1LCAyMDE5IDY6MDggUE0NCj4gVG86IFN1Z2F5YSwgVGFpY2hpLxskQj97QysbKEIgGyRC
QkAwbBsoQg0KPiBDYzogS2FuZW1hdHN1LCBTaGluamkvGyRCN3M+PhsoQiAbJEI/LTwhGyhCOyBN
YXNhbWkgSGlyYW1hdHN1OyBEYW5pZWwgTGV6Y2FubzsNCj4gTGludXggS2VybmVsIE1haWxpbmcg
TGlzdDsgS2FzYWksIEthenVoaXJvLxskQjNeMGYbKEIgGyRCMGxNThsoQjsgSmFzc2kgQnJhcjsg
T3JpdG8sDQo+IFRha2FvLxskQj8lOE0bKEIgGyRCTUBAOBsoQjsgQXJuZCBCZXJnbWFubjsgbGlu
dXgtc29jQHZnZXIua2VybmVsLm9yZzsgVGhvbWFzDQo+IEdsZWl4bmVyOyBMaW51eCBBUk0NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNi8xNV0gY2xvY2tzb3VyY2UvZHJpdmVycy90aW1lci1t
aWxiZWF1dDoNCj4gSW50cm9kdWNlIHRpbWVyIGZvciBNaWxiZWF1dCBTb0NzDQo+IA0KPiBPbiBG
cmksIEZlYiAxNSwgMjAxOSBhdCAzOjI1IEFNIFN1Z2F5YSwgVGFpY2hpDQo+IDxzdWdheWEudGFp
Y2hpQHNvY2lvbmV4dC5jb20+IHdyb3RlOg0KPiA+IE9uIDIwMTkvMDIvMTUgMDoxOCwgQXJuZCBC
ZXJnbWFubiB3cm90ZToNCj4gPiA+IE9uIFRodSwgRmViIDE0LCAyMDE5IGF0IDM6NDQgUE0gRGFu
aWVsIExlemNhbm8NCj4gPiA+IDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPiB3cm90ZToNCj4g
PiA+Pg0KPiA+ID4+IE9uIDEzLzAyLzIwMTkgMTE6MzQsIFN1Z2F5YSwgVGFpY2hpIHdyb3RlOg0K
PiA+ID4+PiBIaSwNCj4gPiA+Pj4NCj4gPiA+Pj4gT24gMjAxOS8wMi8xMiAxODowNiwgRGFuaWVs
IExlemNhbm8gd3JvdGU6DQo+ID4gPj4+PiBPbiAwOC8wMi8yMDE5IDEzOjI2LCBTdWdheWEgVGFp
Y2hpIHdyb3RlOg0KPiA+ID4+Pj4+IEFkZCB0aW1lciBkcml2ZXIgZm9yIE1pbGJlYXV0IFNvQ3Mg
c2VyaWVzLg0KPiA+ID4+Pj4+DQo+ID4gPj4+Pj4gVGhlIHRpbWVyIGhhcyB0d28gMzItYml0IHdp
ZHRoIGRvd24gY291bnRlcnMsIG9uZSBvZiB3aGljaCBpcw0KPiBjb25maWd1cmVkDQo+ID4gPj4+
Pj4gYXMgYSBjbG9ja2V2ZW50IGRldmljZSBhbmQgdGhlIG90aGVyIGlzIGNvbmZpZ3VyZWQgYXMg
YSBjbG9jaw0KPiBzb3VyY2UuDQo+ID4gPj4+Pj4NCj4gPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBT
dWdheWEgVGFpY2hpIDxzdWdheWEudGFpY2hpQHNvY2lvbmV4dC5jb20+DQo+ID4gPj4+Pg0KPiA+
ID4+Pj4gRG8gd2FudCBtZSB0byB0YWtlIGl0IHRocm91Z2ggbXkgdHJlZT8NCj4gPiA+Pj4+DQo+
ID4gPj4+DQo+ID4gPj4+IFllcywgcGxlYXNlLg0KPiA+ID4+Pg0KPiA+ID4+PiBCeSB0aGUgd2F5
LCB0aGUgcGF0Y2ggc2VyaWVzIGluY2x1ZGVzIG90aGVyIHN1Yi1zeXN0ZW0gZHJpdmVycywNCj4g
c28NCj4gPiA+Pj4gc2hvdWxkIGl0IGJlIHNwbGl0dGVkIGludG8gZWFjaCBkcml2ZXIgcGF0Y2gg
Pw0KPiA+ID4+DQo+ID4gPj4gV2VsbCB1c3VhbGx5IGNoYW5nZXMgYXJlIHBlciBzdWItc3lzdGVt
cyBidXQgaW4gY2FzZSBvZiBmaXJzdA0KPiBzdWJtaXNzaW9uDQo+ID4gPj4geW91IG1heSBhc2sg
bGludXgtc29jQCB0ZWFtIHRvIHRha2UgYWxsIHRoZSBwYXRjaGVzIHRvZ2V0aGVyIHdpdGgNCj4g
dGhlDQo+ID4gPj4gYWNrZWQtYnkgdGFncyBmcm9tIHRob3NlIHN1YnN5c3RlbXMgbWFpbnRhaW5l
ci4NCj4gPiA+Pg0KPiA+ID4+IEFkZGVkIGluIENjOiBBcm5kQCBhbmQgbGludXgtc29jQA0KPiA+
ID4+DQo+ID4gPj4gSSdsbCB3YWl0IGEgYml0IGJlZm9yZSBhcHBseWluZyB0aGUgcGF0Y2ggeW91
IGNsYXJpZnkgdGhpcy4NCj4gPiA+DQo+ID4gPiBZZXMsIEkgdGhpbmsgbWVyZ2luZyB0aGVtIGFs
bCB0b2dldGhlciBpcyBiZXN0IGhlcmUuDQo+ID4gPg0KPiA+ID4gSSBzYXcgdGhlIHBhdGNoZXMg
Zmx5IHBhc3QgYnV0IGRpZCBub3QgZG8gYSBjb21wbGV0ZSByZXZpZXcsDQo+ID4gPiBidXQgaWYg
YWxsIG90aGVyIHJldmlldyBjb21tZW50cyBhcmUgYWRkcmVzc2VkLCBJJ2Qgc3VnZ2VzdA0KPiA+
ID4gc2VuZGluZyB0aGUgZW50aXJlIHNlcmllcyBmb3IgaW5jbHVzaW9uIHRvIGxpbnV4LXNvY0B2
Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IHdpdGggdGhlIEFja2VkLWJ5L1Jldmlld2VkLWJ5IHRhZ3Mg
ZnJvbSBzdWJzeXN0ZW0gbWFpbnRhaW5lcnMNCj4gPiA+IGFkZGVkIGluLg0KPiA+DQo+ID4gVGhh
bmsgeW91IGZvciBzdWdnZXN0aW9uLg0KPiA+IE9LLiBJIHdpbGwgc2VuZCB0aGUgc2VyaWVzIHRv
IHRoZSBNTCB3aXRoIHRoZSBBY2tlZC1ieS9SZXZpZXdlZC1ieSB0YWdzLg0KPiANCj4gT25lIGNv
cnJlY3Rpb246IHBsZWFzZSBzZW5kIHRoZSBwYXRjaGVzIHRvIGFkZHJlc3MgInNvY0BrZXJuZWwu
b3JnIg0KPiBmb3IgaW5jbHVzaW9uLg0KPg0KDQpJIGdvdCBpdCENCg0KVGhhbmtzLA0KU3VnYXlh
IFRhaWNoaQ0KDQogDQo+ICAgICAgIEFybmQNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg==
