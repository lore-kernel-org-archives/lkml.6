Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE73C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED68220891
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UM9o/IYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED68220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbeG0Kyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:54:36 -0400
Received: from mail-eopbgr50053.outbound.protection.outlook.com ([40.107.5.53]:47824
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729547AbeG0Kyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sndeGSUnsvMNlFa8qgjsGG+Vor/eJ2mwYw2KODfocX0=;
 b=UM9o/IYuDhWDEQaIgo1+uYVpMaEbFTbGjboiRRCOphgCkTCzQbjGPBEe2ZRS1YGz0Q+bTFzrfRo5OIFXt23TcWBHCKTA3/hDBKQqk45otxeSks2E4iXkXcNO7yV7jqlDWLoMZkz7Cum41IJuvb3LdFrvhD2D3aFusNQOEg+C/68=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3287.eurprd04.prod.outlook.com (10.170.216.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.16; Fri, 27 Jul 2018 09:33:28 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::b52c:4b0a:5bf4:cbfd%4]) with mapi id 15.20.0973.022; Fri, 27 Jul 2018
 09:33:28 +0000
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
Subject: RE: [PATCH v8 6/6] ARM: dts: imx6: RIoTboard provide standby on power
 off option
Thread-Topic: [PATCH v8 6/6] ARM: dts: imx6: RIoTboard provide standby on
 power off option
Thread-Index: AQHUJMI3AipE7lfQt02cE9VAQT4f9qSiz+rg
Date:   Fri, 27 Jul 2018 09:33:28 +0000
Message-ID: <DB6PR04MB3223FA7B91D0D43B2EC1EE2A892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-7-o.rempel@pengutronix.de>
In-Reply-To: <20180726092220.17250-7-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3287;6:ZNlSzYMH6tbVhGPvTW+Qd66HWLcmFsFn6TGEJ3DkRoYkj8kHZQdwwD30JSxa36Qjug/uXIBQ1cweujU3EOguN16Vm5odpfFfZs13VRmBKC7ya9Uz9C/tVc4xZp7/lQfK4+cYSC4kKxMnDJfOasy/j4/51ISTDKBaRJMbCXq52yIHtjtLPu5tpTuqerenylLe7sQX6KZM4HJZdfNmliZP3MEPLC3cs4NHPGpKDY/1TkE1HsmJoUjeR7a9filh94P6WsipZZawICizMFP/24p43qwMxpzwDvkUUOp9hYYGEm0BrgSHtZlaJCXX7aUmiJppzCBg4qv+8yt5DWwF/PRKpYqdEiWdzaDDnWibMJE/EftIh7aZxMRyJkxP00tQecvU3NnCHIkaBHdM8xPKK/JQtL9CjDRx8ADnnGB76XR+Jh9/tlHvNS5co9L+UGRYd6aeL7h0MJ42hoeWXvcdCAJxYA==;5:pWNXVnDYw+klNmPfsIVsvprNq88dOnZFOro/aR6C8YosXo7ioqi/W9ewE3+JFIDmaGx/aEudPCJ2S7NZTVSVHO+ld6Dw02Tysrm1GYABRoxcJRt5IvruxTBuXxLU+RoqEMhlYhoPMeAMsjDGN9KK63hW0+U8nGM5ugZ89+xyBls=;7:uVnFeuRQN8F0Ywuuj+WlhVVrGiKl32MDKwg3fBMFvo1F9iWgoI1EbkvlV966WRLGD2iCybGDM+2q14S0rCCPKuA7dkdPzsZeoTJ3yjVz1DNZ5NKC7S5GigGyihsoRZ+VeegzWssgfL3Fy1fmKRRtutPtsFRsuWmtURIFS7ME0rdAxRhMUT+/v1WM387/3idxIKCpfE/Tl+Pe7/it6Q9LvmqcrMEtw0jNx0Dt07NyFGGIKOfGsl+pL6CRBLFwrsyj
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d61333e1-5daa-487e-4979-08d5f3a4024e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3287;
x-ms-traffictypediagnostic: DB6PR04MB3287:
x-microsoft-antispam-prvs: <DB6PR04MB328740BB3FC0AD924F9825E4892A0@DB6PR04MB3287.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(85827821059158)(258649278758335)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3287;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3287;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(39860400002)(396003)(366004)(346002)(376002)(136003)(13464003)(189003)(199004)(4326008)(54906003)(7736002)(305945005)(33656002)(25786009)(6436002)(6246003)(229853002)(110136005)(256004)(81156014)(39060400002)(5660300001)(8676002)(81166006)(74316002)(316002)(2906002)(7416002)(8936002)(2900100001)(76176011)(99286004)(7696005)(106356001)(186003)(26005)(53546011)(446003)(11346002)(105586002)(5250100002)(6116002)(6506007)(3846002)(476003)(66066001)(102836004)(486006)(9686003)(86362001)(478600001)(55016002)(575784001)(14454004)(97736004)(53936002)(68736007)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3287;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 0X+RCShBlByt5vrbk5LWHPsdo++86sBr/Vs5lLA7+vAziNl/xLQBj5GjAFyQ+IsDJfMU/hkvA8756iMb2FC1fOKQvg9+zISOyouX12QJTm+NTze9F87B8rXHfwEIn0pzcs5UbytDi/YkvMfz1OMz5vsKDMUwptf/Mnv1xaTzqlpNlrhOzpC0NqLnUQrJXEXtNYdipEUYcgi+ELPAiU2XidJYXcqBlEl2S0jO/uyg+FFNetH/PJ9khDXZiF5jWH9Fvpf1UxiVrnkneFEuOgoDH8WSEip6GyadRcsleFxe05QvZqD/K4LQm5e3XqH6uVOZG3XOyQX7Wh12Tk03vz+0UggO/DViL+j2GSsh8Re1pj8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d61333e1-5daa-487e-4979-08d5f3a4024e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 09:33:28.0193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3287
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
Y29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjggNi82XSBBUk06IGR0czogaW14NjogUklvVGJvYXJk
IHByb3ZpZGUgc3RhbmRieSBvbiBwb3dlcg0KPiBvZmYgb3B0aW9uDQo+IA0KPiBUaGlzIGJvYXJk
LCBhcyB3ZWxsIGFzIHNvbWUgb3RoZXIgYm9hcmRzIHdpdGggaS5NWDYgYW5kIGEgUE1JQywgdXNl
cyBhDQo+ICJQTUlDX1NUQllfUkVRIiBsaW5lIHRvIG5vdGlmeSB0aGUgUE1JQyBhYm91dCBhIHN0
YXRlIGNoYW5nZS4NCj4gVGhlIFBNSUMgaXMgcHJvZ3JhbW1lZCBmb3IgYSBzcGVjaWZpYyBzdGF0
ZSBjaGFuZ2UgYmVmb3JlIHRyaWdnZXJpbmcgdGhlIGxpbmUuDQo+IEluIHRoaXMgY2FzZSwgUE1J
Q19TVEJZX1JFUSBjYW4gYmUgdXNlZCBmb3Igc3RhbmQgYnksIHNsZWVwIGFuZCBwb3dlciBvZmYN
Cj4gbW9kZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxA
cGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLXJpb3Ri
b2FyZC5kdHMgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLXJpb3Rib2FyZC5kdHMN
Cj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2ZGwtcmlvdGJvYXJkLmR0cw0KPiBpbmRleCAyZTk4
YzkyYWRmZjcuLmEwZTk3NTNlZTc2NyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NmRsLXJpb3Rib2FyZC5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NmRsLXJp
b3Rib2FyZC5kdHMNCj4gQEAgLTkwLDYgKzkwLDEwIEBADQo+ICAJc3RhdHVzID0gIm9rYXkiOw0K
PiAgfTsNCj4gDQo+ICsmY2xrcyB7DQo+ICsJZnNsLHBtaWMtc3RieS1wb3dlcm9mZjsNCj4gK307
DQpJdCdzIGJldHRlciByZW1vdmUgdGhlIGRlZmF1bHQgInN5c2Nvbi1wb3dlcm9mZiIgcG93ZXIg
b2ZmIG5vZGUuDQo+ICsNCj4gICZmZWMgew0KPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7
DQo+ICAJcGluY3RybC0wID0gPCZwaW5jdHJsX2VuZXQ+Ow0KPiBAQCAtMTcwLDYgKzE3NCw3IEBA
DQo+ICAJCXJlZyA9IDwweDA4PjsNCj4gIAkJaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzU+Ow0K
PiAgCQlpbnRlcnJ1cHRzID0gPDE2IDg+Ow0KPiArCQlmc2wscG1pYy1zdGJ5LXBvd2Vyb2ZmOw0K
PiANCj4gIAkJcmVndWxhdG9ycyB7DQo+ICAJCQlyZWdfdmRkY29yZTogc3cxYWIgewkJCQkvKiBW
RERBUk1fSU4gKi8NCj4gLS0NCj4gMi4xOC4wDQoNCg==
