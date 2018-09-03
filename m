Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B39EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282E20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 09:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C282E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeICOSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 10:18:10 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:63626 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727401AbeICOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 10:18:10 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w839rqIf003258;
        Mon, 3 Sep 2018 11:57:17 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2m7ghthq4e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 03 Sep 2018 11:57:17 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2D33A31;
        Mon,  3 Sep 2018 09:57:12 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B590729A2;
        Mon,  3 Sep 2018 09:57:11 +0000 (GMT)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 3 Sep
 2018 11:57:11 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1347.000; Mon, 3 Sep 2018 11:57:11 +0200
From:   Patrice CHOTARD <patrice.chotard@st.com>
To:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        Sean Wang <sean.wang@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Carlo Caione <carlo@caione.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Andrew Lunn" <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Jean-Christophe Plagniol-Villard" <plagnioj@jcrosoft.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Tony Lindgren" <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Barry Song <baohua@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
Thread-Topic: [PATCH] pinctrl: Convert to using %pOFn instead of
 device_node.name
Thread-Index: AQHUPnInJGmx5I1sBEaSBU1jk4rP0KTeOoeA
Date:   Mon, 3 Sep 2018 09:57:11 +0000
Message-ID: <3335422d-0b46-fde6-d172-005ba9b60d76@st.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-40-robh@kernel.org>
In-Reply-To: <20180828015252.28511-40-robh@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <220F3FA47CE90748951B84F0602886F6@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-03_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iDQoNCk9uIDA4LzI4LzIwMTggMDM6NTIgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBJ
biBwcmVwYXJhdGlvbiB0byByZW1vdmUgdGhlIG5vZGUgbmFtZSBwb2ludGVyIGZyb20gc3RydWN0
IGRldmljZV9ub2RlLA0KPiBjb252ZXJ0IHByaW50ZiB1c2VycyB0byB1c2UgdGhlICVwT0ZuIGZv
cm1hdCBzcGVjaWZpZXIuDQo+IA0KPiBDYzogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBs
aW5hcm8ub3JnPg0KPiBDYzogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4g
Q2M6IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gQ2M6IFNoYXduIEd1byA8
c2hhd25ndW9Aa2VybmVsLm9yZz4NCj4gQ2M6IFN0ZWZhbiBBZ25lciA8c3RlZmFuQGFnbmVyLmNo
Pg0KPiBDYzogUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25peC5kZT4N
Cj4gQ2M6IFNlYW4gV2FuZyA8c2Vhbi53YW5nQG1lZGlhdGVrLmNvbT4NCj4gQ2M6IE1hdHRoaWFz
IEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQo+IENjOiBDYXJsbyBDYWlvbmUgPGNh
cmxvQGNhaW9uZS5vcmc+DQo+IENjOiBLZXZpbiBIaWxtYW4gPGtoaWxtYW5AYmF5bGlicmUuY29t
Pg0KPiBDYzogSmFzb24gQ29vcGVyIDxqYXNvbkBsYWtlZGFlbW9uLm5ldD4NCj4gQ2M6IEFuZHJl
dyBMdW5uIDxhbmRyZXdAbHVubi5jaD4NCj4gQ2M6IEdyZWdvcnkgQ2xlbWVudCA8Z3JlZ29yeS5j
bGVtZW50QGJvb3RsaW4uY29tPg0KPiBDYzogU2ViYXN0aWFuIEhlc3NlbGJhcnRoIDxzZWJhc3Rp
YW4uaGVzc2VsYmFydGhAZ21haWwuY29tPg0KPiBDYzogSmVhbi1DaHJpc3RvcGhlIFBsYWduaW9s
LVZpbGxhcmQgPHBsYWduaW9qQGpjcm9zb2Z0LmNvbT4NCj4gQ2M6IE5pY29sYXMgRmVycmUgPG5p
Y29sYXMuZmVycmVAbWljcm9jaGlwLmNvbT4NCj4gQ2M6IEFsZXhhbmRyZSBCZWxsb25pIDxhbGV4
YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCj4gQ2M6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0Bz
bnRlY2guZGU+DQo+IENjOiBUb255IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPg0KPiBDYzog
SGFvamlhbiBaaHVhbmcgPGhhb2ppYW4uemh1YW5nQGxpbmFyby5vcmc+DQo+IENjOiBQYXRyaWNl
IENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBzdC5jb20+DQo+IENjOiBCYXJyeSBTb25nIDxiYW9o
dWFAa2VybmVsLm9yZz4NCj4gQ2M6IE1heGltZSBDb3F1ZWxpbiA8bWNvcXVlbGluLnN0bTMyQGdt
YWlsLmNvbT4NCj4gQ2M6IEFsZXhhbmRyZSBUb3JndWUgPGFsZXhhbmRyZS50b3JndWVAc3QuY29t
Pg0KPiBDYzogTWF4aW1lIFJpcGFyZCA8bWF4aW1lLnJpcGFyZEBib290bGluLmNvbT4NCj4gQ2M6
IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz4NCj4gQ2M6IGxpbnV4LWdwaW9Admdlci5rZXJu
ZWwub3JnDQo+IENjOiBsaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWFtbG9naWNA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiBDYzogbGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmcNCj4gU2lnbmVkLW9mZi1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICAgZHJpdmVycy9waW5jdHJs
L2Jlcmxpbi9iZXJsaW4uYyAgICAgICAgICAgICAgIHwgIDYgKystLQ0KPiAgIGRyaXZlcnMvcGlu
Y3RybC9mcmVlc2NhbGUvcGluY3RybC1pbXguYyAgICAgICB8ICA3ICsrLS0NCj4gICBkcml2ZXJz
L3BpbmN0cmwvZnJlZXNjYWxlL3BpbmN0cmwtaW14MS1jb3JlLmMgfCAxMiArKystLS0tDQo+ICAg
ZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5jIHwgIDQgKy0tDQo+
ICAgZHJpdmVycy9waW5jdHJsL21lc29uL3BpbmN0cmwtbWVzb24uYyAgICAgICAgIHwgIDIgKy0N
Cj4gICBkcml2ZXJzL3BpbmN0cmwvbXZlYnUvcGluY3RybC1tdmVidS5jICAgICAgICAgfCAgNCAr
LS0NCj4gICBkcml2ZXJzL3BpbmN0cmwvbm9tYWRpay9waW5jdHJsLW5vbWFkaWsuYyAgICAgfCAg
NiArKy0tDQo+ICAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtYXQ5MS5jICAgICAgICAgICAgICAg
IHwgIDggKystLS0NCj4gICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1sYW50aXEuYyAgICAgICAg
ICAgICAgfCAgOCArKy0tLQ0KPiAgIGRyaXZlcnMvcGluY3RybC9waW5jdHJsLXJvY2tjaGlwLmMg
ICAgICAgICAgICB8ICA4ICsrLS0tDQo+ICAgZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtcnphMS5j
ICAgICAgICAgICAgICAgIHwgIDggKystLS0NCj4gICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1z
aW5nbGUuYyAgICAgICAgICAgICAgfCAzMiArKysrKysrKystLS0tLS0tLS0tDQo+ICAgZHJpdmVy
cy9waW5jdHJsL3BpbmN0cmwtc3QuYyAgICAgICAgICAgICAgICAgIHwgIDYgKystLQ0KPiAgIGRy
aXZlcnMvcGluY3RybC9zaXJmL3BpbmN0cmwtYXRsYXM3LmMgICAgICAgICB8ICA0ICstLQ0KPiAg
IGRyaXZlcnMvcGluY3RybC9zdG0zMi9waW5jdHJsLXN0bTMyLmMgICAgICAgICB8ICA0ICstLQ0K
PiAgIGRyaXZlcnMvcGluY3RybC9zdW54aS9waW5jdHJsLXN1bnhpLmMgICAgICAgICB8ICA4ICsr
LS0tDQo+ICAgZHJpdmVycy9waW5jdHJsL3RpL3BpbmN0cmwtdGktaW9kZWxheS5jICAgICAgIHwg
IDggKystLS0NCj4gICAxNyBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCA2OSBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1zdC5j
IGIvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtc3QuYw0KPiBpbmRleCAwOTY2YmIwYmY3MWYuLmU2
NmFmOTNmMmNiZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL3BpbmN0cmwtc3QuYw0K
PiArKysgYi9kcml2ZXJzL3BpbmN0cmwvcGluY3RybC1zdC5jDQo+IEBAIC04MTcsOCArODE3LDgg
QEAgc3RhdGljIGludCBzdF9wY3RsX2R0X25vZGVfdG9fbWFwKHN0cnVjdCBwaW5jdHJsX2RldiAq
cGN0bGRldiwNCj4gICANCj4gICAJZ3JwID0gc3RfcGN0bF9maW5kX2dyb3VwX2J5X25hbWUoaW5m
bywgbnAtPm5hbWUpOw0KPiAgIAlpZiAoIWdycCkgew0KPiAtCQlkZXZfZXJyKGluZm8tPmRldiwg
InVuYWJsZSB0byBmaW5kIGdyb3VwIGZvciBub2RlICVzXG4iLA0KPiAtCQkJbnAtPm5hbWUpOw0K
PiArCQlkZXZfZXJyKGluZm8tPmRldiwgInVuYWJsZSB0byBmaW5kIGdyb3VwIGZvciBub2RlICVw
T0ZuXG4iLA0KPiArCQkJbnApOw0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCX0NCj4gICAN
Cj4gQEAgLTExODQsNyArMTE4NCw3IEBAIHN0YXRpYyBpbnQgc3RfcGN0bF9kdF9wYXJzZV9ncm91
cHMoc3RydWN0IGRldmljZV9ub2RlICpucCwNCj4gICAJCWlmIChwcC0+bGVuZ3RoIC8gc2l6ZW9m
KF9fYmUzMikgPj0gT0ZfR1BJT19BUkdTX01JTikgew0KPiAgIAkJCW5waW5zKys7DQo+ICAgCQl9
IGVsc2Ugew0KPiAtCQkJcHJfd2FybigiSW52YWxpZCBzdCxwaW5zIGluICVzIG5vZGVcbiIsIG5w
LT5uYW1lKTsNCj4gKwkJCXByX3dhcm4oIkludmFsaWQgc3QscGlucyBpbiAlcE9GbiBub2RlXG4i
LCBucCk7DQo+ICAgCQkJcmV0dXJuIC1FSU5WQUw7DQo+ICAgCQl9DQo+ICAgCX0NCg0KRm9yIHBp
bmN0cmwtc3Q6DQoNCkFja2VkLWJ5OiBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBz
dC5jb20+DQoNClRoYW5rcw0KUGF0cmljZQ0K
