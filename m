Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F65C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D81320891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vad+UOkm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D81320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbeG0KTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:19:23 -0400
Received: from mail-he1eur01on0076.outbound.protection.outlook.com ([104.47.0.76]:8352
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729445AbeG0KTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJpRdaVtdB1EPh2DPm7ldx0VaKgWM1iMK5eGcMUWHR4=;
 b=Vad+UOkmM3KhiwqRRCKoS+/xRSHXs9G6h5/IY6qYel9WinExPY8tAtQ5byhnMcgheGVKIxWpa90nSEUdQlRewLy3bver+3TGurYNgfl0LRSeh4Fcie4lMAOkHigZ0cReaUE52IIiBXmYoWeB0Kx61W+wKuB2EwdJ8EgKI8DlyeU=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3046.eurprd04.prod.outlook.com (10.170.213.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Fri, 27 Jul 2018 08:58:22 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 08:58:22 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Topic: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Index: AQHUJMI388q4zA1ybU+fByMY2n4yEKShPSxQgAAjboCAAOXVUIAAeB2AgAAFoqA=
Date:   Fri, 27 Jul 2018 08:58:22 +0000
Message-ID: <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
         <20180726092220.17250-2-o.rempel@pengutronix.de>
         <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
         <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
         <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532680211.32306.36.camel@pengutronix.de>
In-Reply-To: <1532680211.32306.36.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3046;6:E+nWJedWI/U/VrGfivOnA0q1ElugvTmOkBhcfotHWNg3FFSmeXy4c38OXbafZKEKzHEYlRXG/rdpm72eHFCKu5wFuByfsr4Y15XelxGTlC++1MsrU9xLExUPDU+Rp4McRuGShlJ4hXRYHaPhpKdNoOhafLe6rK5p/a0Rc09Zx8AEsxCVDBwCXOX4cJxnzOXQ7nEmIQhuJFKR6r5wQt65aeLzBzLQAsuufV+g/i3G7kxAbkdj9PrLtmHKf65pex6zbN8TtjoEzCWU8iJ0v0wRBxAqY7rvZN5u03LQg9d2kG3XWORF+uQXr/OfEUna1gvKvnlTPcX5Rp0EkWiyM5Dg28w1XPsGsAN8jrSnJ0dVitNx24s7R26QLx/xYot7pd+gnmz84l9wporYFBvTl5MxWkDZyJV93Vmm7EGZ1awFbWFQKO/3alq9TYcSAnh8b8+9vj7kS39l9eZiBVpE9R9mXg==;5:4UtcDmuhar8m3bdlJuI1Y8O5vSHmQf4sB/sRMVISOYI5kGLsp/78JSlbkY7wEZdL1gIfNTZ87oU2oIhONynEda6Ijiu1MZpSWtRGkBbTA0AQgkqk5SlwSa5P28VOR+gs9oXMO6f3Uskv7+VCQHjmTTY82ML6x6zvU2xEwqKYz1s=;7:WnB1ZHNX1qdjOFV4Nc11rI8wHKFalZorYnjIJLZBjMo/S7o8afBF2kP4r29uBrZ8On29u3ZXhd7sq3F/wWDItWdAnVclPDujB6Vx1petZIBLHB83Vf3DkChUBnt1/GTgNwiJdOAtwvUDfxW0BJ7fhkH0feSNbiIL5BCUICbLXfonC9kophVTWcYp9hmXtYo7wLYNQCCTcTSEpQxqKZ+14h38kcFfxZCuDMag/GfUTBGzB9pY78BpdgUDyyYvfhy0
x-ms-office365-filtering-correlation-id: 4e5a8cab-c9c9-42b0-bf6b-08d5f39f1b81
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3046;
x-ms-traffictypediagnostic: DB6PR04MB3046:
x-microsoft-antispam-prvs: <DB6PR04MB3046D90DC7A36682DAC3D1A7892A0@DB6PR04MB3046.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(21532816269658)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3046;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3046;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(13464003)(66066001)(476003)(6506007)(74316002)(6116002)(3846002)(8676002)(478600001)(53546011)(229853002)(39060400002)(33656002)(9686003)(11346002)(53936002)(55016002)(14454004)(105586002)(316002)(4326008)(7696005)(81156014)(81166006)(8936002)(97736004)(76176011)(54906003)(110136005)(106356001)(99286004)(2906002)(5250100002)(25786009)(486006)(86362001)(2900100001)(186003)(7416002)(102836004)(5660300001)(7736002)(305945005)(446003)(14444005)(6436002)(256004)(26005)(68736007)(93886005)(6246003)(32563001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3046;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ER5cJESDYSg86RA7yiY3fHr+L0wTL8Ltk8RberL62BT/EuYRQyuE39kuHSEF+cM5c9BrPJzk+cz+lU7XvpCjiCo7Rq5UTx7S0zCEL2Zqj+U3NuyM9T3jEIGHRpye9YddNm7rvJJQ5ECtzFNUqOMAHuMj5k2vk9401U0aeG5CKapxlV67NmWe652zqEh/QUuT56I50EyNQf1e6m2WUdQlejQ+iTI1lAd9SVD58l33Uqq/C3FVfbIaXpld3hln57smJAR9pSfzetBOCS95sYULcFHI5LkqLfHicpYS7i3H7KEgOUmfbJ0EtGTlB3a9dqia/4ndAT8bbHz1EOg4khQdjFT0V2XIrTqDV/56jrnC0Lo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5a8cab-c9c9-42b0-bf6b-08d5f39f1b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 08:58:22.8059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMgU3RhY2ggW21h
aWx0bzpsLnN0YWNoQHBlbmd1dHJvbml4LmRlXQ0KPiBTZW50OiAyMDE45bm0N+aciDI35pelIDE2
OjMwDQo+IFRvOiBSb2JpbiBHb25nIDx5aWJpbi5nb25nQG54cC5jb20+OyBPbGVrc2lqIFJlbXBl
bA0KPiA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+OyBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5l
bC5vcmc+OyBNYXJrDQo+IEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBSYWZhZWwgSi4gV3lz
b2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1h
cmsucnV0bGFuZEBhcm0uY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IE1pY2hh
ZWwgVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNvbT47IFN0ZXBoZW4gQm95ZA0KPiA8
c2JveWRAY29kZWF1cm9yYS5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBMaWFt
IEdpcmR3b29kDQo+IDxsZ2lyZHdvb2RAZ21haWwuY29tPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz47IGRsLWxpbnV4LWlteA0KPiA8bGludXgtaW14QG54cC5jb20+OyBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IEEucy4gRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBGYWJp
byBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBSdXNzZWxsDQo+IEtpbmcgPGxpbnV4
QGFybWxpbnV4Lm9yZy51az47IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5v
cmc+Ow0KPiBMZW9uYXJkIENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsgbGludXgt
Y2xrQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMS82XSBBUk06IGlteDZxOiBwcm92aWRlIGRv
Y3VtZW50YXRpb24gZm9yIG5ldw0KPiBmc2wscG1pYy1zdGJ5LXBvd2Vyb2ZmIHByb3BlcnR5DQo+
IA0KPiBIaSBSb2JpbiwNCj4gDQo+IEFtIEZyZWl0YWcsIGRlbiAyNy4wNy4yMDE4LCAwMTo1MSAr
MDAwMCBzY2hyaWViIFJvYmluIEdvbmc6DQo+IFsuLi5dDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+
ID4gwqBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14NnEtY2xvY2su
dHh0IHwgOA0KPiA+ID4gPiA+ICsrKysrKysrDQo+ID4gPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+
ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svaW14NnEtY2xvY2su
dHh0DQo+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2sv
aW14NnEtY2xvY2sudHh0DQo+ID4gPiA+ID4gaW5kZXggYTQ1Y2E2N2E5ZDVmLi5lMTMwODM0NmUw
MGQgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Nsb2NrL2lteDZxLWNsb2NrLnR4dA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9pbXg2cS1jbG9jay50eHQNCj4gPiA+ID4gPiBAQCAt
Niw2ICs2LDE0IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gPiA+ID4gwqAtIGludGVycnVw
dHM6IFNob3VsZCBjb250YWluIENDTSBpbnRlcnJ1cHQNCj4gPiA+ID4gPiDCoC0gI2Nsb2NrLWNl
bGxzOiBTaG91bGQgYmUgPDE+DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiArT3B0aW9uYWwgcHJvcGVy
dGllczoNCj4gPiA+ID4gPiArLSBmc2wscG1pYy1zdGJ5LXBvd2Vyb2ZmOiBDb25maWd1cmUgQ0NN
IHRvIGFzc2VydCBQTUlDX1NUQllfUkVRDQo+ID4gPiA+ID4gK3NpZ25hbA0KPiA+ID4gPiA+ICvC
oMKgb24gcG93ZXIgb2ZmLg0KPiA+ID4gPiA+ICvCoMKgVXNlIHRoaXMgcHJvcGVydHkgaWYgdGhl
IFNvQyBzaG91bGQgYmUgcG93ZXJlZCBvZmYgYnkNCj4gPiA+ID4gPiArZXh0ZXJuYWwgcG93ZXIN
Cj4gPiA+ID4gPiArwqDCoG1hbmFnZW1lbnQgSUMgKFBNSUMpIHRyaWdnZXJlZCB2aWEgUE1JQ19T
VEJZX1JFUSBzaWduYWwuDQo+ID4gPiA+DQo+ID4gPiA+IFBNSUNfT05fUkVRIGRpZG4ndCBjb25u
ZWN0IHRvIGFueSBwaW4gb2YgUE1JQyBpbiB5b3VyIGNhc2U/DQo+ID4gPg0KPiA+ID4gTm8uIEZp
cnN0LCBpdCB3YXMgb25seSBvbmUgY3VzdG9tZXIgc3BlY2lmaWMgaXNzdWUuIEFmdGVyIHNvbWUN
Cj4gPiA+IHJlc2VhcmNoIEkgZm91bmQgZXZlbiBwdWJsaWNseSBhdmFpbGFibGUgYm9hcmRzIChm
b3IgZXhhbXBsZQ0KPiA+ID4gUmlvVGJvYXJkKSB3aGljaCBoYXMgc2FtZS9zaW1pbGFyIGRlc2ln
bi4gQWZ0ZXIgc2VlaW5nIHRoaXMgaW4gaW14Ng0KPiA+ID4gZG9jdW1lbnRhdGlvbiBhcyB2YWxp
ZCBwb3dlciBvZmYgd2F5LCBJIGhhdmUgbm8gZG91YnRzIC0gdGhlcmUgc2hvdWxkIGJlDQo+IGV2
ZW4gbW9yZSBkZXZpY2VzIGRvaW4gdGhpcyBpbiB0aGUgd2lsZC4NCj4gPg0KPiA+IE5vdCBzdXJl
IHdoeSB0aGUgY3VzdG9tZXIgZGlkbid0IGZvbGxvdyByZWZlcmVuY2UgZGVzaWduLCBzaW5jZQ0K
PiA+IFBNSUNfT05fUkVRIGNhbiBwcm92aWRlIHBvd2VyIG9mZi9vbiBmZWF0dXJlIGJ5IHByZXNz
aW5nIE9OT0ZGIGtleQ0KPiA+IHdoaWNoIGNvbm5lY3RlZCBPTk9GRiBwaW4gb2YgaS5teDYoT05P
RkYgd2lsbCB0b2dnbGUgUE1JQ19PTl9SRVEgdG8NCj4gPiBwb3dlciBvZmYvb24gUE1JQykuIFRo
ZSBvZmZpY2lhbCBwb3dlciBvZmYvb24gd2F5IChQTUlDX09OX1JFUSkgY2FuDQo+ID4gYWxzbyBw
b3dlciBvZmYgYWxsIHBvd2VyIHJhaWxzIG9mIFBGVVpFIGV4Y2VwdCBzbnZzIGFzIHlvdXIgcGF0
Y2ggZGlkDQo+ID4gb24gUE1JQ19TVEJZX1JFUS7CoMKgUE1JQ19TVEJZX1JFUSBpcyB1c2VkIHRv
IG5vdGlmeSBwbWljIHN3aXRjaCBwb3dlcg0KPiA+IG1vZGUgKFBGTS9BUFMpIG9yIGRlY3JlYXNl
IHZvbHRhZ2UgdG8gc2F2ZSBwb3dlciBpbiBrZXJuZWwgc3VzcGVuZCwgbm90DQo+IHBvd2VyIG9m
Zi4uLi5JIGFtIG5vdCBzdXJlIGlmIHdlIG5lZWQgdGhpcyBwYXRjaHNldCB0byAnd29ya2Fyb3Vu
ZCcgdGhlIGJvYXJkDQo+IGlzc3VlLg0KPiA+DQo+IE5vdCBhbGwgYm9hcmRzIGZvbGxvdyB0aGUg
cmVmZXJlbmNlIGRlc2lnbiwgdGhhdCdzIGEgZmFjdCBvZiBsaWZlLg0KPiANCj4gUGxlYXNlIGxv
b2sgYXQgdGhlIGkuTVg2USByZWZlcmVuY2UgbWFudWFsLiBUaGUgc2VxdWVuY2UgaW1wbGVtZW50
ZWQgaW4gdGhpcw0KPiBwYXRjaHNldCBjYW4gYmUgZm91bmQgYXMgYSB2YWxpZCB3YXkgdG8gcG93
ZXIgb2ZmIHRoZSBzeXN0ZW0gaW4NCj4gIjYwLjQuMyBQb3dlciBtb2RlIHRyYW5zaXRpb25zIiAi
Tm9ybWFsIE9OIHRvIE9GRiB3aXRoIGV4dGVybmFsIFBNSUMiLCBzbw0KPiB0aGVyZSBpcyBoYXJk
bHkgYW55IHdheSB0byBhcmd1ZSB0aGF0IHRoaXMgaXMgYSBib2FyZCBzcGVjaWZpYyBxdWlyay4g
VGhpcyBpcyBvbmUgb2YNCj4gdGhlIEZyZWVzY2FsZS9OWFAgcmVjb21tZW5kZWQgc2VxdWVuY2Vz
IHRvIHR1cm4gb2ZmIHRoZSBzeXN0ZW0uDQpPa2F5LCBidXQgY291bGQgeW91IGFkZCBvbmUgbW9y
ZSBjb21tZW50IGZvciB0aGlzIHNvbHV0aW9uPyBSVEMgYWxhcm0gYW5kIE9OT0ZGDQpCdXR0b24g
d2FrZXVwIGZlYXR1cmUgY2FuJ3QgYmUgc3VwcG9ydCBpbiB0aGlzIGNhc2UuDQo+IA0KPiBSZWdh
cmRzLA0KPiBMdWNhcw0K
