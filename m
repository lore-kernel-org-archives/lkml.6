Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94238C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD77E20897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHpTKRxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD77E20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbeG0KxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:53:11 -0400
Received: from mail-eopbgr50062.outbound.protection.outlook.com ([40.107.5.62]:31013
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbeG0KxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICIQcJ1aBsmB1cNx00Ytm9szJv/Gf0fTf8OHURmybOY=;
 b=HHpTKRxL8cIiZGIqIrLYbNLqbTWlqjH+UYoPvkrCk6dQa2o7mcr2QyDLhlBC+kSWS6E6zO498dk3cy7bK2lsAuzsRyJyS5acBsFE1mWKu4NxTm5zCCB3vjbpBPWXu2rvapksylZJPb+sbCJAHE7Vt5Mca2b6DDwdKRaWnfSm5Dc=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3096.eurprd04.prod.outlook.com (10.170.214.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.20; Fri, 27 Jul 2018 09:32:02 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 09:32:02 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
Thread-Topic: [PATCH v8 5/6] regulator: pfuze100-regulator: provide
 pm_power_off_prepare handler
Thread-Index: AQHUJMI3bwczuvIkzEyBW8aO9arKeKSizQEw
Date:   Fri, 27 Jul 2018 09:32:02 +0000
Message-ID: <DB6PR04MB32233832762D02F1023861A1892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-6-o.rempel@pengutronix.de>
In-Reply-To: <20180726092220.17250-6-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3096;6:OCH3NfC12jfXeVGT8ADHebC798ZHttvDJjZex1PWg5t6Md/M27ei+ujqU/zkBy5xQBYX85ziqz7m879O/wvSCrQ7VwjxDv6WGp/9ix0GXjNMY0Im9Sx3BYPl/c8RyfT/2mEWrnZ4KyRgwl/RVBtbiwS2M7XvpDT0khHcBGVMKeslDDPxFYNSNYNXI9phKpMrWulreR3vMirX01j2k1xw4f/O/fWEuqDsEI2KwWEFLcNCummCZILEYwaVMVrkmHpZKlrK4bv2099Jeo/2YvP852aA4UynAqTLhfj6Uyuzfm1poJXmc7CdBxBnthLMkL0YQjf+i1mCrFdg27v7P6fukoIeihZddCcb7/f/NBS7wEi4Ef4PDOuTtaTTVZmdKAxta2oiAFGM99GIfd/9bDpVLMEw2gen2Y9UA31acx4YbqboDJLRtL1zlXeOKbMrNmnrK0Cyqx5840LO0S41pTtAew==;5:629mUXnzr13bwTFdRlfHFESayQe+Np52iaXAL5mSHEHk7wQpyRZSCPAD4cBulzcSZQzAxJO6YXW4Hrsgmiz0a95M5aBHPXyLFmT8CFLRgxdwMvSDYpoPQ2DC9rgJC3DMMXdPnFNHYjM7dmhNHkU+8VKJPEi//IV/5JOx+AtYmGg=;7:+1oApQbO7ZUy5cIERjEQ4uZE4C7Dl/U+NK/VzCktsDy6iOFKPQJ62Lq5VgE7YJg+76bEs4+QR8wLoB9w6gRWdTYAQ4nBg18IF82YekZD0oHxyJTPJztts8TxMBAj7TuL+cfxb55rFbTEcFWzOwzLv6q1CMsurlViTKL9VFdXZZOc0u5wkWI/Q2pcUBLzLlUP7SDO2jzoz90k0SSGykPGHcH5LQwA0jsF8n20uVjzFXO0FY7/f+vi4VKhS8fycOgQ
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cd74ceaa-cafb-469f-0803-08d5f3a3cf71
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3096;
x-ms-traffictypediagnostic: DB6PR04MB3096:
x-microsoft-antispam-prvs: <DB6PR04MB3096B54DA929820CE96CC0A3892A0@DB6PR04MB3096.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3096;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3096;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(346002)(136003)(189003)(199004)(13464003)(97736004)(110136005)(6506007)(55016002)(102836004)(5250100002)(8676002)(14454004)(81156014)(14444005)(8936002)(256004)(3846002)(39060400002)(6116002)(6246003)(53546011)(81166006)(6436002)(9686003)(33656002)(486006)(476003)(25786009)(106356001)(478600001)(2906002)(5660300001)(66066001)(76176011)(7696005)(229853002)(4326008)(105586002)(7416002)(2900100001)(7736002)(68736007)(53936002)(86362001)(316002)(575784001)(99286004)(305945005)(54906003)(74316002)(11346002)(186003)(446003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3096;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6TJZGylV838IRlPb4AvK4fLFlkfMe+E4ZyfXkfF5wmF7pTACPVRYmFBdvsjfHw9JpyDqs5R/pD9pNsIi5A+V4sxk3qgpqWJIOPmnLx5FKdwjEwqELAGFwYg39+SpyBbh0HbiQNehNFZndWVxIAyCx838gztDQ9BKYRtI+EesX2JEP+tHYFbxQZA2MqCHYS+PZU4L0rVD64cRdmxlafToW822+lZs7qr/zV739YN474HcvNYxExFpsYR0ymwcqC3zlTC29kqvQkeY06yceAoRk/XnXfOtQUIiOWBf+Hu4Swo6XKfYq4g/wKoVnBYHUglqly1N2EFFfYyXvrn+3rhqxvWxB8GDtHGXXNzccGEibEM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd74ceaa-cafb-469f-0803-08d5f3a3cf71
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 09:32:02.7002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xla3NpaiBSZW1wZWwg
W21haWx0bzpvLnJlbXBlbEBwZW5ndXRyb25peC5kZV0NCj4gU2VudDogMjAxOMTqN9TCMjbI1SAx
NzoyMg0KPiBUbzogU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsgTWFyayBCcm93biA8
YnJvb25pZUBrZXJuZWwub3JnPjsNCj4gUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29j
a2lAaW50ZWwuY29tPg0KPiBDYzogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4
LmRlPjsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1jbGtAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbmRyZXcgTW9ydG9u
DQo+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTGlhbSBHaXJkd29vZCA8bGdpcmR3b29k
QGdtYWlsLmNvbT47DQo+IExlb25hcmQgQ3Jlc3RleiA8bGVvbmFyZC5jcmVzdGV6QG54cC5jb20+
OyBSb2IgSGVycmluZw0KPiA8cm9iaCtkdEBrZXJuZWwub3JnPjsgTWFyayBSdXRsYW5kIDxtYXJr
LnJ1dGxhbmRAYXJtLmNvbT47IE1pY2hhZWwNCj4gVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxp
YnJlLmNvbT47IFN0ZXBoZW4gQm95ZA0KPiA8c2JveWRAY29kZWF1cm9yYS5vcmc+OyBGYWJpbyBF
c3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+OyBSdXNzZWxsDQo+IEtpbmcgPGxpbnV4QGFy
bWxpbnV4Lm9yZy51az47IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBSb2JpbiBH
b25nDQo+IDx5aWJpbi5nb25nQG54cC5jb20+OyBBLnMuIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjggNS82XSByZWd1bGF0b3I6IHBmdXplMTAwLXJlZ3Vs
YXRvcjogcHJvdmlkZQ0KPiBwbV9wb3dlcl9vZmZfcHJlcGFyZSBoYW5kbGVyDQo+IA0KPiBPbiBz
b21lIGJvYXJkcyB0aGUgU29DIGNhbiB1c2Ugb25lIHBpbiAiUE1JQ19TVEJZX1JFUSIgdG8gbm90
aWZ5IHRoIFBNSUMNCj4gYWJvdXQgc3RhdGUgY2hhbmdlcy4gSW4gdGhpcyBjYXNlIGludGVybmFs
IHN0YXRlIG9mIFBNSUMgbXVzdCBiZSBwcmVjb25maWd1cmVkDQo+IGZvciB1cGNvbW1pbmcgc3Rh
dGUgY2hhbmdlLg0KPiBJdCB3b3JrcyBmaW5lIHdpdGggdGhlIGN1cnJlbnQgcmVndWxhdG9yIGZy
YW1ld29yaywgZXhjZXB0IHdpdGggdGhlIHBvd2VyLW9mZg0KPiBjYXNlLg0KPiANCj4gVGhpcyBw
YXRjaCBpcyBwcm92aWRpbmcgYW4gb3B0aW9uYWwgcG1fcG93ZXJfb2ZmX3ByZXBhcmUgaGFuZGxl
ciB3aGljaCB3aWxsDQo+IGNvbmZpZ3VyZSBzdGFuZGJ5IHN0YXRlIG9mIHRoZSBQTUlDIHRvIGRp
c2FibGUgYWxsIHBvd2VyIGxpbmVzLg0KPiANCj4gSW4gbXkgcG93ZXIgY29uc3VtcHRpb24gdGVz
dCBvbiBSSW9UQm9hcmQsIEkgZ290IHRoZSBmb2xsb3dpbmcgcmVzdWx0czoNCj4gcG93ZXIgb2Zm
IHdpdGhvdXQgdGhpcyBwYXRjaDoJMzIwIG1BDQo+IHBvd2VyIG9mZiB3aXRoIHRoaXMgcGF0Y2g6
CTIgICBtQQ0KPiBzdXNwZW5kIHRvIHJhbToJCQk0MCAgbUENCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCj4gLS0tDQo+ICBkcml2
ZXJzL3JlZ3VsYXRvci9wZnV6ZTEwMC1yZWd1bGF0b3IuYyB8IDkyICsrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOTIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL3BmdXplMTAwLXJlZ3VsYXRvci5jDQo+IGIvZHJp
dmVycy9yZWd1bGF0b3IvcGZ1emUxMDAtcmVndWxhdG9yLmMNCj4gaW5kZXggOGQ5ZGJjYzc3NWVh
Li5lMzg2ZTlhY2IzZjcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcmVndWxhdG9yL3BmdXplMTAw
LXJlZ3VsYXRvci5jDQo+ICsrKyBiL2RyaXZlcnMvcmVndWxhdG9yL3BmdXplMTAwLXJlZ3VsYXRv
ci5jDQo+IEBAIC0xNSw2ICsxNSw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL3Bm
dXplMTAwLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaTJjLmg+DQo+ICAjaW5jbHVkZSA8bGludXgv
c2xhYi5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2thbGxzeW1zLmg+DQpJcyBpdCBuZWNlc3Nhcnk/
DQo+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+IA0KPiAgI2RlZmluZSBQRlVaRV9OVU1S
RUdTCQkxMjgNCj4gQEAgLTI5LDExICszMCwxNyBAQA0KPiANCj4gICNkZWZpbmUgUEZVWkUxMDBf
Q09JTlZPTAkweDFhDQo+ICAjZGVmaW5lIFBGVVpFMTAwX1NXMUFCVk9MCTB4MjANCj4gKyNkZWZp
bmUgUEZVWkUxMDBfU1cxQUJNT0RFCTB4MjMNCj4gICNkZWZpbmUgUEZVWkUxMDBfU1cxQ1ZPTAkw
eDJlDQo+ICsjZGVmaW5lIFBGVVpFMTAwX1NXMUNNT0RFCTB4MzENCj4gICNkZWZpbmUgUEZVWkUx
MDBfU1cyVk9MCQkweDM1DQo+ICsjZGVmaW5lIFBGVVpFMTAwX1NXMk1PREUJMHgzOA0KPiAgI2Rl
ZmluZSBQRlVaRTEwMF9TVzNBVk9MCTB4M2MNCj4gKyNkZWZpbmUgUEZVWkUxMDBfU1czQU1PREUJ
MHgzZg0KPiAgI2RlZmluZSBQRlVaRTEwMF9TVzNCVk9MCTB4NDMNCj4gKyNkZWZpbmUgUEZVWkUx
MDBfU1czQk1PREUJMHg0Ng0KPiAgI2RlZmluZSBQRlVaRTEwMF9TVzRWT0wJCTB4NGENCj4gKyNk
ZWZpbmUgUEZVWkUxMDBfU1c0TU9ERQkweDRkDQo+ICAjZGVmaW5lIFBGVVpFMTAwX1NXQlNUQ09O
MQkweDY2DQo+ICAjZGVmaW5lIFBGVVpFMTAwX1ZSRUZERFJDT04JMHg2YQ0KPiAgI2RlZmluZSBQ
RlVaRTEwMF9WU05WU1ZPTAkweDZiDQo+IEBAIC00NCw2ICs1MSwxMyBAQA0KPiAgI2RlZmluZSBQ
RlVaRTEwMF9WR0VONVZPTAkweDcwDQo+ICAjZGVmaW5lIFBGVVpFMTAwX1ZHRU42Vk9MCTB4NzEN
Cj4gDQo+ICsjZGVmaW5lIFBGVVpFMTAwX1NXeE1PREVfTUFTSwkweGYNCj4gKyNkZWZpbmUgUEZV
WkUxMDBfU1d4TU9ERV9BUFNfQVBTCTB4OA0KPiArI2RlZmluZSBQRlVaRTEwMF9TV3hNT0RFX0FQ
U19PRkYJMHg0DQo+ICsNCj4gKyNkZWZpbmUgUEZVWkUxMDBfVkdFTnhMUFdSCUJJVCg2KQ0KPiAr
I2RlZmluZSBQRlVaRTEwMF9WR0VOeFNUQlkJQklUKDUpDQo+ICsNCj4gIGVudW0gY2hpcHMgeyBQ
RlVaRTEwMCwgUEZVWkUyMDAsIFBGVVpFMzAwMCA9IDMgfTsNCj4gDQo+ICBzdHJ1Y3QgcGZ1emVf
cmVndWxhdG9yIHsNCj4gQEAgLTQ5Miw2ICs1MDYsNjkgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm1hdGNoX29mX25vZGUoaW50DQo+IGluZGV4KSAgfSAgI2VuZGlmDQo+IA0K
PiArc3RhdGljIHN0cnVjdCBwZnV6ZV9jaGlwICpzeXNwbV9wZnV6ZV9jaGlwOw0KPiArDQo+ICtz
dGF0aWMgdm9pZCBwZnV6ZV9wb3dlcl9vZmZfcHJlcGFyZSh2b2lkKSANCj4gKwlkZXZfaW5mbyhz
eXNwbV9wZnV6ZV9jaGlwLT5kZXYsICJDb25maWd1cmUgc3RhbmR5IG1vZGUgZm9yIHBvd2VyDQo+
ICtvZmYiKTsNCkFkZCAnaWYgKHN5c3BtX3BmdXplX2NoaXAgLT5jaGlwX2lkID09IFBGVVpFMTAw
KSknIGhlcmUgaXMgZWFzeSBmb3IgZXh0ZW5kIA0KU3VwcG9ydCBvbiBwZnV6ZTIwMC8zMDAwLi4g
aW4gdGhlIGZlYXR1cmUuDQo+ICsNCj4gKwkvKiBTd2l0Y2ggZnJvbSBkZWZhdWx0IG1vZGU6IEFQ
Uy9BUFMgdG8gQVBTL09mZiAqLw0KPiArCXJlZ21hcF91cGRhdGVfYml0cyhzeXNwbV9wZnV6ZV9j
aGlwLT5yZWdtYXAsDQo+IFBGVVpFMTAwX1NXMUFCTU9ERSwNCj4gKwkJCSAgIFBGVVpFMTAwX1NX
eE1PREVfTUFTSywNCj4gUEZVWkUxMDBfU1d4TU9ERV9BUFNfT0ZGKTsNCj4gKwlyZWdtYXBfdXBk
YXRlX2JpdHMoc3lzcG1fcGZ1emVfY2hpcC0+cmVnbWFwLA0KPiBQRlVaRTEwMF9TVzFDTU9ERSwN
Cj4gKwkJCSAgIFBGVVpFMTAwX1NXeE1PREVfTUFTSywNCj4gUEZVWkUxMDBfU1d4TU9ERV9BUFNf
T0ZGKTsNCj4gKwlyZWdtYXBfdXBkYXRlX2JpdHMoc3lzcG1fcGZ1emVfY2hpcC0+cmVnbWFwLCBQ
RlVaRTEwMF9TVzJNT0RFLA0KPiArCQkJICAgUEZVWkUxMDBfU1d4TU9ERV9NQVNLLA0KPiBQRlVa
RTEwMF9TV3hNT0RFX0FQU19PRkYpOw0KPiArCXJlZ21hcF91cGRhdGVfYml0cyhzeXNwbV9wZnV6
ZV9jaGlwLT5yZWdtYXAsDQo+IFBGVVpFMTAwX1NXM0FNT0RFLA0KPiArCQkJICAgUEZVWkUxMDBf
U1d4TU9ERV9NQVNLLA0KPiBQRlVaRTEwMF9TV3hNT0RFX0FQU19PRkYpOw0KPiArCXJlZ21hcF91
cGRhdGVfYml0cyhzeXNwbV9wZnV6ZV9jaGlwLT5yZWdtYXAsDQo+IFBGVVpFMTAwX1NXM0JNT0RF
LA0KPiArCQkJICAgUEZVWkUxMDBfU1d4TU9ERV9NQVNLLA0KPiBQRlVaRTEwMF9TV3hNT0RFX0FQ
U19PRkYpOw0KPiArCXJlZ21hcF91cGRhdGVfYml0cyhzeXNwbV9wZnV6ZV9jaGlwLT5yZWdtYXAs
IFBGVVpFMTAwX1NXNE1PREUsDQo+ICsJCQkgICBQRlVaRTEwMF9TV3hNT0RFX01BU0ssDQo+IFBG
VVpFMTAwX1NXeE1PREVfQVBTX09GRik7DQo+ICsNCj4gKwlyZWdtYXBfdXBkYXRlX2JpdHMoc3lz
cG1fcGZ1emVfY2hpcC0+cmVnbWFwLCBQRlVaRTEwMF9WR0VOMVZPTCwNCj4gKwkJCSAgIFBGVVpF
MTAwX1ZHRU54TFBXUiB8IFBGVVpFMTAwX1ZHRU54U1RCWSwNCj4gKwkJCSAgIFBGVVpFMTAwX1ZH
RU54U1RCWSk7DQo+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKHN5c3BtX3BmdXplX2NoaXAtPnJlZ21h
cCwgUEZVWkUxMDBfVkdFTjJWT0wsDQo+ICsJCQkgICBQRlVaRTEwMF9WR0VOeExQV1IgfCBQRlVa
RTEwMF9WR0VOeFNUQlksDQo+ICsJCQkgICBQRlVaRTEwMF9WR0VOeFNUQlkpOw0KPiArCXJlZ21h
cF91cGRhdGVfYml0cyhzeXNwbV9wZnV6ZV9jaGlwLT5yZWdtYXAsIFBGVVpFMTAwX1ZHRU4zVk9M
LA0KPiArCQkJICAgUEZVWkUxMDBfVkdFTnhMUFdSIHwgUEZVWkUxMDBfVkdFTnhTVEJZLA0KPiAr
CQkJICAgUEZVWkUxMDBfVkdFTnhTVEJZKTsNCj4gKwlyZWdtYXBfdXBkYXRlX2JpdHMoc3lzcG1f
cGZ1emVfY2hpcC0+cmVnbWFwLCBQRlVaRTEwMF9WR0VONFZPTCwNCj4gKwkJCSAgIFBGVVpFMTAw
X1ZHRU54TFBXUiB8IFBGVVpFMTAwX1ZHRU54U1RCWSwNCj4gKwkJCSAgIFBGVVpFMTAwX1ZHRU54
U1RCWSk7DQo+ICsJcmVnbWFwX3VwZGF0ZV9iaXRzKHN5c3BtX3BmdXplX2NoaXAtPnJlZ21hcCwg
UEZVWkUxMDBfVkdFTjVWT0wsDQo+ICsJCQkgICBQRlVaRTEwMF9WR0VOeExQV1IgfCBQRlVaRTEw
MF9WR0VOeFNUQlksDQo+ICsJCQkgICBQRlVaRTEwMF9WR0VOeFNUQlkpOw0KPiArCXJlZ21hcF91
cGRhdGVfYml0cyhzeXNwbV9wZnV6ZV9jaGlwLT5yZWdtYXAsIFBGVVpFMTAwX1ZHRU42Vk9MLA0K
PiArCQkJICAgUEZVWkUxMDBfVkdFTnhMUFdSIHwgUEZVWkUxMDBfVkdFTnhTVEJZLA0KPiArCQkJ
ICAgUEZVWkUxMDBfVkdFTnhTVEJZKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBwZnV6ZV9w
b3dlcl9vZmZfcHJlcGFyZV9pbml0KHN0cnVjdCBwZnV6ZV9jaGlwICpwZnV6ZV9jaGlwKQ0KPiAr
ew0KPiArCWlmIChwZnV6ZV9jaGlwLT5jaGlwX2lkICE9IFBGVVpFMTAwKSB7DQo+ICsJCWRldl93
YXJuKHBmdXplX2NoaXAtPmRldiwgIlJlcXVlc3RlZCBwbV9wb3dlcl9vZmZfcHJlcGFyZQ0KPiBo
YW5kbGVyIGZvciBub3Qgc3VwcG9ydGVkIGNoaXBcbiIpOw0KPiArCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gKwl9DQo+ICsNCj4gKwlpZiAocG1fcG93ZXJfb2ZmX3ByZXBhcmUpIHsNCj4gKwkJZGV2X3dh
cm4ocGZ1emVfY2hpcC0+ZGV2LCAicG1fcG93ZXJfb2ZmX3ByZXBhcmUgaXMgYWxyZWFkeQ0KPiBy
ZWdpc3RlcmVkLlxuIik7DQo+ICsJCXJldHVybiAtRUJVU1k7DQo+ICsJfQ0KPiArDQo+ICsJaWYg
KHN5c3BtX3BmdXplX2NoaXApIHsNCj4gKwkJZGV2X3dhcm4ocGZ1emVfY2hpcC0+ZGV2LCAic3lz
cG1fcGZ1emVfY2hpcCBpcyBhbHJlYWR5IHNldC5cbiIpOw0KPiArCQlyZXR1cm4gLUVCVVNZOw0K
PiArCX0NCj4gKw0KPiArCXN5c3BtX3BmdXplX2NoaXAgPSBwZnV6ZV9jaGlwOw0KPiArCXBtX3Bv
d2VyX29mZl9wcmVwYXJlID0gcGZ1emVfcG93ZXJfb2ZmX3ByZXBhcmU7DQo+ICsNCj4gKwlyZXR1
cm4gMDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGludCBwZnV6ZV9pZGVudGlmeShzdHJ1Y3QgcGZ1
emVfY2hpcCAqcGZ1emVfY2hpcCkgIHsNCj4gIAl1bnNpZ25lZCBpbnQgdmFsdWU7DQo+IEBAIC02
NjEsNiArNzM4LDIwIEBAIHN0YXRpYyBpbnQgcGZ1emUxMDBfcmVndWxhdG9yX3Byb2JlKHN0cnVj
dCBpMmNfY2xpZW50DQo+ICpjbGllbnQsDQo+ICAJCX0NCj4gIAl9DQo+IA0KPiArCWlmIChvZl9w
cm9wZXJ0eV9yZWFkX2Jvb2woY2xpZW50LT5kZXYub2Zfbm9kZSwNCj4gKwkJCQkgICJmc2wscG1p
Yy1zdGJ5LXBvd2Vyb2ZmIikpDQo+ICsJCXJldHVybiBwZnV6ZV9wb3dlcl9vZmZfcHJlcGFyZV9p
bml0KHBmdXplX2NoaXApOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBpbnQgcGZ1emUxMDBfcmVndWxhdG9yX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50
KSB7DQo+ICsJaWYgKHN5c3BtX3BmdXplX2NoaXApIHsNCj4gKwkJc3lzcG1fcGZ1emVfY2hpcCA9
IE5VTEw7DQo+ICsJCXBtX3Bvd2VyX29mZl9wcmVwYXJlID0gTlVMTDsNCj4gKwl9DQo+ICsNCj4g
IAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IEBAIC02NzEsNiArNzYyLDcgQEAgc3RhdGljIHN0cnVj
dCBpMmNfZHJpdmVyIHBmdXplX2RyaXZlciA9IHsNCj4gIAkJLm9mX21hdGNoX3RhYmxlID0gcGZ1
emVfZHRfaWRzLA0KPiAgCX0sDQo+ICAJLnByb2JlID0gcGZ1emUxMDBfcmVndWxhdG9yX3Byb2Jl
LA0KPiArCS5yZW1vdmUgPSBwZnV6ZTEwMF9yZWd1bGF0b3JfcmVtb3ZlLA0KPiAgfTsNCj4gIG1v
ZHVsZV9pMmNfZHJpdmVyKHBmdXplX2RyaXZlcik7DQo+IA0KPiAtLQ0KPiAyLjE4LjANCg0K
