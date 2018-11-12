Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA0BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BCB2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 01:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqk0AS8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3BCB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbeKLLuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:50:13 -0500
Received: from mail-eopbgr80082.outbound.protection.outlook.com ([40.107.8.82]:23040
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729903AbeKLLuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ra2eWJqIg5nxTgZYlSyt1babZsRvcSoeEwullNR+IGM=;
 b=hqk0AS8sKG4oCQMQS384/IYlH/hQMo2128TeCJY8XBoAVeJa7r1d04qZt9B7KbftLjxmR51ug3Qy4k7nr42GqSLKR4GwiS+wvlcKkU5ZF6ieujhu3l+WxWprCdYflTiCB+OdHIFSAA+dOwLd64XA05P0K5dt8b5DWvGgHbNRaig=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB5227.eurprd04.prod.outlook.com (20.176.236.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 12 Nov 2018 01:58:35 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::51ba:96d4:721e:f6a9%5]) with mapi id 15.20.1294.044; Mon, 12 Nov 2018
 01:58:35 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
Thread-Topic: [PATCH V1 1/4] ARM: dts: imx6sx: Add flexcan stop mode wakeup
 support
Thread-Index: AQHUapGLcG+0l0YmQEuEyHO6X3KdtqU/Te2AgAwyRdA=
Date:   Mon, 12 Nov 2018 01:58:35 +0000
Message-ID: <DB7PR04MB461869CFD28338F9A812F334E6C10@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181023052831.2553-1-qiangqing.zhang@nxp.com>
 <20181023052831.2553-2-qiangqing.zhang@nxp.com>
 <20181104073931.GC26016@tiger>
In-Reply-To: <20181104073931.GC26016@tiger>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB5227;6:fNdKSPIkGdJK+Ue6FlmNrCuIMe+wQF2/r9i15Rog7KrDou7siwlE52+vgXqwmFh/irvd0J4BDxRayr69jCL6mnaE+fRyMfeKxvHf1WmtCJSAILqigEfsvRrYHfwt1CJ08F2nuf5jrRWKHlDCTZW3yUxPS2NfxpxArkFzn5FN+TQOqz3T37dv3SsOlIKC4XwN9L8qtuIvQn1DrktJwvBo5B5oF6ulT2e71zkvhB6Q8nZfM4y++F7XXxqma3321VncGMcjpJ79ltSFbSOLQhIEntn06hOBoZQyBdWyTyyHrRQ8WXzNFxLYIgEHUzYK6wDCaVV9Pn81FBDcbPwqlv3Doqr9VsLoZj4qsaHoIFW2tmbduzETm82NeTCzaZ6DcSBAgO0kUd6tEFZf4suxRJV1WNG8/OyPFfb9tOrFr0MtdZGelLm/9GnHmxQ0KrMUL2DnniCHSKvIbs4w1o54dt3Wlg==;5:Yfhn5WAvuvMFG8Ib7DNgBbynqKnnwFR7WNBOoEk5lHaCmUeyu1dSwUaTCprzWtkag9Ts4t75UZFeML5haZzRQUwloI3wBuyIV+iskLC7fnLmotohfyyhWv6/svaLVw5ScvfjkchaZrpoVuvpPO/7yWkAHdXc9DQ1gDXv/VqvxdI=;7:TtvrphSknYiW2udQabSyOs0uJxxKugyHdvgLqXn6RZuTkDcTFxTuV2t7bYH6/kb9jAyuD/odqUiW/+3yFep7GTFlwSoTRVAwwzNrptktM4RLvqYEu30oN7x1RoKsLO9TQ4aCkKYKje/RWp1jbTx9Bw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8cd2bf9d-1480-4f9c-e8db-08d648425b22
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB5227;
x-ms-traffictypediagnostic: DB7PR04MB5227:
x-microsoft-antispam-prvs: <DB7PR04MB52277AFB39D67D4443D9A72EE6C10@DB7PR04MB5227.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(258649278758335)(9452136761055)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231382)(944501410)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB5227;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB5227;
x-forefront-prvs: 0854128AF0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(189003)(13464003)(199004)(4326008)(53936002)(25786009)(14454004)(55016002)(305945005)(106356001)(2900100001)(81156014)(26005)(7736002)(9686003)(86362001)(6916009)(105586002)(81166006)(186003)(8936002)(5660300001)(68736007)(8676002)(97736004)(6506007)(14444005)(256004)(229853002)(54906003)(2906002)(99286004)(66066001)(446003)(71200400001)(71190400001)(478600001)(6436002)(74316002)(476003)(76176011)(6116002)(7696005)(316002)(53546011)(486006)(11346002)(102836004)(3846002)(33656002)(6246003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB5227;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QGEUX/Ys7Gj7Ms7XK3gdJpwOazZJQt/2mOknE/YkP3GpdAxiHa2osxd3Q3GQ9OpEyi5TQZDUCh1aao0W1kMJc15xFswtHYJqkgtmc19SXaEIrVbV02ejV8xoMHiuNswi68WX2vjTGUcc42xQ1Id1UyCNVhSTWgGwnQtkMvUkHFMVjz9i2x11nj/fuUTHnc7g1cCg9AwcbJOPRf4aJg6SZR1HRn+wnyGq7n1EWUz5XgEbsnHw61NcANgoxQVOrQBKnTOpjKm6eXblO63YhpVC/vwuLsk/wjNJ2UIbuNu648ZFiqOSf7eFUP3FhDbz/hiEDqbaqtzhnKpq5arn+KMeVGW6PczICFIl9FEmMhuldkI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2bf9d-1480-4f9c-e8db-08d648425b22
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2018 01:58:35.2398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5227
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNoYXduIEd1byA8c2hhd25n
dW9Aa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOMTqMTHUwjTI1SAxNTo0MA0KPiBUbzogSm9ha2lt
IFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IHMuaGF1ZXJAcGVuZ3V0cm9u
aXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmFiaW8uZXN0
ZXZhbUBueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
QS5zLiBEb25nDQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SCBWMSAxLzRdIEFSTTogZHRzOiBpbXg2c3g6IEFkZCBmbGV4Y2FuIHN0b3AgbW9kZSB3YWtldXAN
Cj4gc3VwcG9ydA0KPiANCj4gT24gVHVlLCBPY3QgMjMsIDIwMTggYXQgMDU6MzA6NDRBTSArMDAw
MCwgSm9ha2ltIFpoYW5nIHdyb3RlOg0KPiA+IEZyb206IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5k
b25nQG54cC5jb20+DQo+ID4NCj4gPiBBZGQgc3RvcC1tb2RlIHByb3BlcnR5IHdoaWNoIGlzIHJl
cXVpcmVkIGJ5IHN0b3AgbW9kZSB3YWtldXAgZmVhdHVyZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAg
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9pbXg2c3guZHRzaQ0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kgaW5kZXgg
ODQ0Y2FhMzkzNjRmLi4zZjQ1OWQ2ZGE3ZmMNCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2c3guZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZz
eC5kdHNpDQo+ID4gQEAgLTQ0OCw2ICs0NDgsNyBAQA0KPiA+ICAJCQkJY2xvY2tzID0gPCZjbGtz
IElNWDZTWF9DTEtfQ0FOMV9JUEc+LA0KPiA+ICAJCQkJCSA8JmNsa3MgSU1YNlNYX0NMS19DQU4x
X1NFUklBTD47DQo+ID4gIAkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsNCj4gPiArCQkJ
CXN0b3AtbW9kZSA9IDwmZ3ByIDB4MTAgMSAweDEwIDE3PjsNCj4gDQo+IElzIGl0IHN1cHBvcnRl
ZCBieSB1cHN0cmVhbT8gIEkgY2Fubm90IGZpbmQgdGhpcyBwcm9wZXJ0eSBpbiBldGhlciBmbGV4
Y2FuDQo+IGJpbmRpbmdzIGRvYyBvciBrZXJuZWwgZHJpdmVyLg0KPiANCj4gU2hhd24NCg0KSGkg
U2hhd24sDQpUaGlzIHByb3BlcnR5IGhhcyBiZWVuIHJldmlld2VkIGJ5IG1haW50YWluZXIgaW4g
ZmxleGNhbiBiaW5kaW5ncyBhbmQga2VybmVsIGRyaXZlciBoYXMgc2VudCB0byByZXZpZXcuDQoN
CkJlc3QgUmVnYXJkcywNCkpvYWtpbSBaaGFuZw0KDQo+ID4gIAkJCQlzdGF0dXMgPSAiZGlzYWJs
ZWQiOw0KPiA+ICAJCQl9Ow0KPiA+DQo+ID4gQEAgLTQ1OCw2ICs0NTksNyBAQA0KPiA+ICAJCQkJ
Y2xvY2tzID0gPCZjbGtzIElNWDZTWF9DTEtfQ0FOMl9JUEc+LA0KPiA+ICAJCQkJCSA8JmNsa3Mg
SU1YNlNYX0NMS19DQU4yX1NFUklBTD47DQo+ID4gIAkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAi
cGVyIjsNCj4gPiArCQkJCXN0b3AtbW9kZSA9IDwmZ3ByIDB4MTAgMiAweDEwIDE4PjsNCj4gPiAg
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ID4gIAkJCX07DQo+ID4NCj4gPiAtLQ0KPiA+IDIu
MTcuMQ0KPiA+DQo=
