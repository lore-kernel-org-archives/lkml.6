Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE242C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0772084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PDYPaD7A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0772084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeJEBGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:06:52 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:47226
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727519AbeJEBGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e/+YZTdGDDx9oAS+L8990gX1xLFs+FfE9A0PNFFgKc=;
 b=PDYPaD7A97g1YOJt7fEjEoc7zdEoYTubycPim5zVyZFgEzM9TdKpvtqDGckntJQjimC+HjKDmuc1O3nzkFghWChaI6+7EWpn1TRApbPryPYnvZJ86N+n5AL7WETpGrWBBN0hgO4qnMv3OyCreMYDAJ+6c1kCqO5UxZnlf2aOmbM=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB4130.eurprd04.prod.outlook.com (52.134.125.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Thu, 4 Oct 2018 18:12:21 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::3836:6416:4ebd:34ef%3]) with mapi id 15.20.1207.022; Thu, 4 Oct 2018
 18:12:21 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Andy Duan <fugang.duan@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Topic: [PATCH v2] ARM: dts: imx6sx-sdb: Fix enet phy regulator
Thread-Index: AQHUW/mFEvH7cglHbUuy4iC9ILMEk6UPY56A
Date:   Thu, 4 Oct 2018 18:12:21 +0000
Message-ID: <fb04dc8e8b3fb45485254c40c2a0342e012e7af4.camel@nxp.com>
References: <c7161f1258c7cd12093af1d8919a8a95e5e65a73.1538667700.git.leonard.crestez@nxp.com>
In-Reply-To: <c7161f1258c7cd12093af1d8919a8a95e5e65a73.1538667700.git.leonard.crestez@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4130;6:T5RfiQ028pbWMFhct3Xth7cVRAdvlpm+tjoqUX5kRlA/0Bei1DtysCN3MVRb7KifH8SOAtYryQwG2r6F3BGxbsrC5VpdKlebrQrzt+YIqhudfVBZJO+0hwTQ72wPfOvC+raWRgFM2CR+ga++SZXgjsdJH5yE01uegpoYcg9LrzHkA6EyvfAmYhB/UYbYhvjDNe8nN4Ku+pf6ysw4JkXYJeo6uVLtCcq/YRb6z5wRzsrMHjqlvZrblXVwXN4PbDUTVwekk2TQ/yCtBKMQNj+ui6fht4rfmr26FoM6ZTjL4ymxfpoQYtZUHmuPCRjirpPZygSpIwreRQjBSuu0Ji3P9gSJotyP+rRooBjFfiv+gmB53u9h7Bv/CvfSikZf7wkfQDxZzMEZ0lkraQTflkn47EeiFdDX+uwkT8kTOyKpa8ypBsbCpeR8fkynN6b/qonw83hgvz/vKfRolKefq3t0Kw==;5:YeF9ZHQxN74/pnWPLPDbpSlPbRqi6snjYza+ZT6ysCZVLuxDepeAm97ZxhMAuiAVAD69zLP2Bc5PM/bD3zH4Wb13BqkSXSaIWjjx59JH3CxS72APes7mdtuWFmSwO3vkkDjmP24Kd/wJOT/o8ndwomiUYrdpagOS3c8d96w+l0g=;7:gEeinjR/ABcCDXbeHUKViF++UaIcez513WFaAjkfpgutNvxe+o2bqAhGIZfhBfO8tkPNyzjLDPrOeai5WP7+UXTjYplI6Z5Em7LICmogyMAKZxgfnI2CUNqr1jagjK1ELOCItTjbw1xtLBw5QCdoJiPjF0QSq/u9HunbUp/f3P4OI5E24wBeNAphF5V0fz5K/coPSlQTUXEkU2Crh1hXZTyBfY1ELoVy8t+6hzic22DJiMnrZXfTQxBBFZCLkneQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bb586772-a0e2-4782-7fcc-08d62a24eda8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4130;
x-ms-traffictypediagnostic: AM0PR04MB4130:
x-microsoft-antispam-prvs: <AM0PR04MB41303BABB5A3B0B580E3EA82EEEA0@AM0PR04MB4130.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM0PR04MB4130;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4130;
x-forefront-prvs: 0815F8251E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39860400002)(396003)(199004)(189003)(229853002)(2906002)(6636002)(446003)(50226002)(36756003)(6506007)(11346002)(102836004)(81166006)(39060400002)(26005)(486006)(54906003)(44832011)(8676002)(81156014)(110136005)(8936002)(186003)(575784001)(86362001)(316002)(6436002)(71200400001)(71190400001)(256004)(14444005)(99286004)(118296001)(6486002)(2900100001)(5250100002)(97736004)(6246003)(305945005)(66066001)(6512007)(2501003)(25786009)(478600001)(4326008)(105586002)(76176011)(966005)(476003)(68736007)(2616005)(5660300001)(6306002)(6116002)(53936002)(7736002)(3846002)(14454004)(106356001)(99106002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4130;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: co5aQ4b+8Tncz8gS9YQnhv0iPZNryhS8nqnYlM6WkUOumucdMVsElxRPG229CCrmhGh7011+vSAxup+hGxeBkhcdy61TNVVmios7/dIoCteC1vkQcq9Rl+yTcPUeAcP2S/XJRJTFmySBRZ99VFzy2XaGqS+ZEyYuFh7vEV09FrveFf9mYBt1YYezcSbO6fjsH35PKji5MRzSBmgYPi/B0Pi/dDhFMqr3AMul6KfJzK9Cf3QB85/Ck0/QB1V+9iXJADI8Gjp281gBNa8xuPqP98Ukqfd5W2STePNI9NDzP5SRUECMXMhkgwQJCaOCBkqTzcWwRNSwk/P0D+9oqPHQ9hwofGSCbAakILO0po0jzus=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <79C6DE619B88FF4288AFB7B768AC30A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb586772-a0e2-4782-7fcc-08d62a24eda8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2018 18:12:21.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTEwLTA0IGF0IDE1OjQ3ICswMDAwLCBMZW9uYXJkIENyZXN0ZXogd3JvdGU6
DQo+IEJpbmRpbmdzIGZvciAiZml4ZWQtcmVndWxhdG9yIiBvbmx5IGV4cGxpY2l0bHkgc3VwcG9y
dCAiZ3BpbyIgcHJvcGVydHksDQo+IG5vdCAiZ3Bpb3MiLiBGaXggYnkgY29ycmVjdGluZyB0aGUg
cHJvcGVydHkgbmFtZS4NCj4gDQo+IFRoZSBlbmV0IFBIWXMgb24gaW14NnN4LXNkYiBuZWVkcyB0
byBiZSBleHBsaWNpdGx5IHJlc2V0IGFmdGVyIGEgcG93ZXINCj4gY3ljbGUsIGhhbmRsZSB0aGlz
IGJ5IGFkZGluZyB0aGUgcGh5LXJlc2V0LWdwaW9zIHByb3BlcnR5Lg0KPiANCj4gQm90aCBwaHlz
IHNoYXJlIGEgc2luZ2xlIHJlc2V0LCBhIHNjZW5hcmlvIHNpbWlsYXIgdG8gaW14N2Qtc2RiLg0K
PiANCj4gVGhpcyBpc3N1ZSB3YXMgZXhwb3NlZCBieSBjb21taXQgZWZkZmViMDc5Y2MzICgicmVn
dWxhdG9yOiBmaXhlZDoNCj4gQ29udmVydCB0byB1c2UgR1BJTyBkZXNjcmlwdG9yIG9ubHkiKSB3
aGljaCBjYXVzZXMgdGhlICJncGlvcyIgcHJvcGVydHkNCj4gdG8gYWxzbyBiZSBwYXJzZWQuIEJl
Zm9yZSB0aGF0IGNvbW1pdCB0aGUgImdwaW9zIiBwcm9wZXJ0eSBoYWQgbm8NCj4gZWZmZWN0LCBQ
SFkgcmVzZXQgd2FzIG9ubHkgaGFuZGxlZCBpbiB0aGUgdGhlIGJvb3Rsb2FkZXIuDQo+IA0KPiBU
aGlzIGZpeGVzIGxpbnV4LW5leHQgYm9vdCBmYWlsdXJlcyBwcmV2aW91c2x5IHJlcG9ydGVkIGhl
cmU6DQo+ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvOTgyNDM3LyMx
MTc3OTAwDQo+ICBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvOTk0MDkx
LyMxMTc4MzA0DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQu
Y3Jlc3RlekBueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2Fs
bGVpakBsaW5hcm8ub3JnPg0KPiBSZXZpZXdlZC1ieTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1A
Z21haWwuY29tPg0KDQpQbGVhc2UgaG9sZCwgdGhpcyBwYXRjaCBzdGlsbCBkb2Vzbid0IGRlYWwg
Y29ycmVjdGx5IHdpdGggc3VzcGVuZDsgbGluaw0KbmV2ZXIgY29tZXMgYmFjayB1cC4NCg0KSXQg
bWlnaHQgYmUgYmV0dGVyIHRvIGFwcGx5IGEgc2ltcGxlciBmaXggd2hpY2gganVzdCBrZWVwcyBy
ZWdfZW5ldF8zdjMNCmFsd2F5cyBvbi4NCg0KPiANCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0
cy9pbXg2c3gtc2RiLmR0c2kgfCA1ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAgKiBVc2Ug
MHgxMGIwIGZvciBwaHkgcmVzZXQgcGluY3RybCB2YWx1ZSAoRmFiaW8pDQo+ICAqIExpbmsgdG8g
djE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC85OTQ4NzEvDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LXNkYi5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnN4LXNkYi5kdHNpDQo+IGluZGV4IDUzYjM0MDhiNWZhYi4uMjkxOTY0
NzZjZTBjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2c3gtc2RiLmR0c2kN
Cj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LXNkYi5kdHNpDQo+IEBAIC0xMTUsMTEg
KzExNSwxMSBAQA0KPiAgCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiAgCQlwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfZW5ldF8zdjM+Ow0KPiAgCQlyZWd1bGF0b3ItbmFtZSA9ICJlbmV0XzN2
MyI7DQo+ICAJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiAgCQlyZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gLQkJZ3Bpb3MgPSA8JmdwaW8yIDYg
R1BJT19BQ1RJVkVfTE9XPjsNCj4gKwkJZ3BpbyA9IDwmZ3BpbzIgNiBHUElPX0FDVElWRV9MT1c+
Ow0KPiAgCX07DQo+ICANCj4gIAlyZWdfcGNpZV9ncGlvOiByZWd1bGF0b3ItcGNpZS1ncGlvIHsN
Cj4gIAkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiAgCQlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiBAQCAtMTc4LDEwICsxNzgsMTEgQEANCj4gIAlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiAgCXBpbmN0cmwtMCA9IDwmcGluY3RybF9lbmV0MT47DQo+ICAJcGh5
LXN1cHBseSA9IDwmcmVnX2VuZXRfM3YzPjsNCj4gIAlwaHktbW9kZSA9ICJyZ21paSI7DQo+ICAJ
cGh5LWhhbmRsZSA9IDwmZXRocGh5MT47DQo+ICsJcGh5LXJlc2V0LWdwaW9zID0gPCZncGlvMiA3
IEdQSU9fQUNUSVZFX0xPVz47DQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgDQo+ICAJbWRpbyB7
DQo+ICAJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgCQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4g
QEAgLTM3MSwxMCArMzcyLDEyIEBADQo+ICAJCQkJTVg2U1hfUEFEX1JHTUlJMV9SRDFfX0VORVQx
X1JYX0RBVEFfMQkweDMwODENCj4gIAkJCQlNWDZTWF9QQURfUkdNSUkxX1JEMl9fRU5FVDFfUlhf
REFUQV8yCTB4MzA4MQ0KPiAgCQkJCU1YNlNYX1BBRF9SR01JSTFfUkQzX19FTkVUMV9SWF9EQVRB
XzMJMHgzMDgxDQo+ICAJCQkJTVg2U1hfUEFEX1JHTUlJMV9SWF9DVExfX0VORVQxX1JYX0VOCTB4
MzA4MQ0KPiAgCQkJCU1YNlNYX1BBRF9FTkVUMl9SWF9DTEtfX0VORVQyX1JFRl9DTEtfMjVNCTB4
OTENCj4gKwkJCQkvKiBwaHkgcmVzZXQgKi8NCj4gKwkJCQlNWDZTWF9QQURfRU5FVDJfQ1JTX19H
UElPMl9JT183CQkweDEwYjANCj4gIAkJCT47DQo+ICAJCX07DQo+ICANCj4gIAkJcGluY3RybF9l
bmV0XzN2MzogZW5ldDN2M2dycCB7DQo+ICAJCQlmc2wscGlucyA9IDwNCg0K
