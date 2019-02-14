Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16945C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E5F222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qE+EkYEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732846AbfBNHSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:18:44 -0500
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:18896
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfBNHSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF+Dfgyyn22bLRSga0QVxjfGzChVthjcOLt0WSBryf4=;
 b=qE+EkYEhe4iqSlke2GfhqefRGmEpYHVzgjeNFLliO2x5yyheruB7cskuotX+zJgBC5Y0asODc8WNOS3GUXcqlx6IizMUu+9aQyeSd0ob6+RD53HIfHLvmJZRqxCwnBbAdFpxwzgP2r2J9RT3mTKoA9PPjaZKT5yVQ+az2YUyX1I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3739.eurprd04.prod.outlook.com (52.134.67.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.18; Thu, 14 Feb 2019 07:18:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 07:18:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Topic: [PATCH V4 1/2] arm64: dts: freescale: imx8qxp: add cpu opp table
Thread-Index: AQHUxAgoEGMMDf+QVUa0wIDEs6tvwqXe4T6AgAAAZYA=
Date:   Thu, 14 Feb 2019 07:18:33 +0000
Message-ID: <DB3PR0402MB3916351935518583A506364CF5670@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550108915-574-1-git-send-email-Anson.Huang@nxp.com>
 <20190214071233.7uypqihkfasxqyw6@vireshk-i7>
In-Reply-To: <20190214071233.7uypqihkfasxqyw6@vireshk-i7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3ba4047-4c27-458f-5846-08d6924ca157
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3739;
x-ms-traffictypediagnostic: DB3PR0402MB3739:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM3Mzk7MjM6VVQySHZEUElJbVMrbEpvY3lIaUhWakRp?=
 =?gb2312?B?VzF5b0JHVVdkSDd0bzNNZ2l6TmRpRkZoSVZyVlpnVTF3NEFJa1oyNWpLSUxl?=
 =?gb2312?B?OHQrUVFycmZMMGhnclMyWkQ2b09wVGNGSlNMNHEycVdQWTErRjZDYVQ4Q01J?=
 =?gb2312?B?bEJiMFZsTmw4QVRKQy9kdmJaVStpcGw5cVQveVozUnJ5a0dMNWxMNmR5UFlI?=
 =?gb2312?B?OWVOZVoySm9GcWRuTFhxQ2ZOSUtJT3dYMXZaWTR0ZlMzOU15cGppd0J4c3ZP?=
 =?gb2312?B?ekI2NDlOdnQrQVJiNzV2Rk1jRFR2dUdlU1ZKTHdSUnl4R0t3Q0hmVmdkajFX?=
 =?gb2312?B?c3pEM1A4RWFQT0pTZjBYTWJFRkhIL0FKK2RObGVycWZ4QWw5dGlWc3pSMlFN?=
 =?gb2312?B?VjNldlIvK3RPTFlOaUxVUGxFV0FYOXNTak10Vk5ncE5CNW9ZV21sTFE3ZWxH?=
 =?gb2312?B?MlFiNGJHbjBURFBTclhCcE11YXREWFBEYnoySjhrNjN5RUZNUDBCSERISVB4?=
 =?gb2312?B?SXJSZEdpQmh4aTlQVVphbHJ0aXRvNkRSczJGS1l1b0xVcVBHOVh2VGZHb210?=
 =?gb2312?B?aXlQcjJZRkVzNlJvTXo2UTd4ZnNDaTkzK05KeDNtaU9CdGNqeHVSNUhIMnVI?=
 =?gb2312?B?eGVQWkFGdlluQnRVbDlETUhRMy9ZMTRKSkRvNlBZNnV4TUs5bjBwalJINlFS?=
 =?gb2312?B?T1p5M1l5N3dFRTRoTVNiY0JHbWtFUmlIRStEeEdpMkswYzVFZXFXTUtxeHZ3?=
 =?gb2312?B?SGFqRW9Pckc4OG1xVWNhSmNRd0JrTXg2Y3hjc2t2d2l4NG4wTlFnYUxMdlo4?=
 =?gb2312?B?MDRrMHF5NThmRys1aEEvNTFMUElpQmpMNS9TcS9kOTJVcVJjUE9iSnJZNmQr?=
 =?gb2312?B?OXBtNVJkblg2WHA5U3h1S1BVVnpGeGJWOTh0NWNYcUI4NVpsdUJJZFpKcFBs?=
 =?gb2312?B?M3hzdWcxRWljMXp6Sk1FSjlsY1IwdXEyTHpOUFRJMlhNMTIvbWZZNUs5Ukti?=
 =?gb2312?B?UnQ2aEhlUWwxV3A5UzBqaWVHZVlHQ1R1NHFXWXpacW1jSmdhaUhjdy9mK1M3?=
 =?gb2312?B?RS9wdUJvMGtXWG9DNEJnZHdBb24wUUhhWWRIMGh2VElOa2s5TmYvY0h4cHRo?=
 =?gb2312?B?cjZqOHZkYXlSRXJ1dE5qZW4yeWV4QjVmeGJVTmpSNzlpYW40czJCbG1KZjRW?=
 =?gb2312?B?SDduWldGeTJsMGd5d2ZHWmdEem54Z1FtUmdmdmRrT2VRbUJlZlpuWmtrd25s?=
 =?gb2312?B?SE04b01NT05rQU1lakRWVUJqendCWjVlSkk4Y2l1dWRNVW9jS1R3Q2tvMllQ?=
 =?gb2312?B?OGxncGxNOVNIMHZkcmFiT2JlMlZuNEw1SGI2MDJyZjdCdGk5c3l5bHBtdlBR?=
 =?gb2312?B?KzVKSlJUUjdrcFFTeXEzTWpndFA0WTBTTm1iejhwa1o4MnlTQlZpd3kyQytY?=
 =?gb2312?B?Q3JER3lFRlgwcTdPdGdlSUtUZnZnbExaMmFXNG1yR0tkYXIwNzllUXBQVzdw?=
 =?gb2312?B?cEVYU2FPWXZIRUlGTnVrKzR1Rm9ScnEwRlpBRnRHNEV5RzJBNGd5S1JpNXBn?=
 =?gb2312?B?SlByWkJGTFhNYS8zUUNEQUs0UWs2Vno1R0ZWd1BnZFlNY2IrUjBRWnFORW9Q?=
 =?gb2312?B?Q3U4YzNoazdPU2htdEZhclJuZUhlNldxSmgvVW5ZTzNaSjdPeWp4WERpZjFZ?=
 =?gb2312?B?REp6ZjlNRTBlNm5jcnhIOGhDVXhyQy9YYVNEQlRwYllET1dXeWJxYmF5K28w?=
 =?gb2312?B?ZkNOQ2wxY0lpTnF5V3BLSCt3PT0=?=
x-microsoft-antispam-prvs: <DB3PR0402MB3739E308D378F0F43C2C7489F5670@DB3PR0402MB3739.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(13464003)(189003)(44832011)(7696005)(99286004)(316002)(54906003)(11346002)(68736007)(476003)(2906002)(14454004)(229853002)(76176011)(71200400001)(71190400001)(6916009)(486006)(33656002)(478600001)(8676002)(256004)(86362001)(66066001)(55016002)(305945005)(53936002)(74316002)(102836004)(186003)(81156014)(81166006)(4326008)(97736004)(14444005)(26005)(25786009)(106356001)(6116002)(53546011)(6506007)(6436002)(446003)(6246003)(9686003)(7416002)(7736002)(105586002)(3846002)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3739;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OiGv4VR/sZrRp8558LGGSREjG/qoqDrSVQn1xBH4jVTURVsNPwvxyCSASrFBARPxH95jfLbz99/Mb1GMgFzMNFNWyhhiaVbI9xK8CI5qZsCbel96G93A5bJrrOea6SX8SidyZZk0FOHx0r3bRdlkw21s+x2Fq3lsJ8/+GX3q4P12QmM6hPEpPy3edXueQJaM0rxhFT0Yy54t7c78y/nGGBEmhJCxFlTPvaxoMp9G5EGAxPOV8fkT4r16KYrpVq3TGIqZ5eU+J9ccC2R2DllJ+htv/m2uXu7hcLiimy93qD2fvBumWZZXzEyo6rxjQ9wzfBMpgAR/G+EOvyUG/eRa05vldEXvOkiyATh0URFB8dAzF5u69BX+a7n+pUfo041wYfAiUHBJE9mbrOVntrR9CxiifXvgbmu0hPuo6o3tyms=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ba4047-4c27-458f-5846-08d6924ca157
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 07:18:34.0248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFZpcmVzaA0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZpcmVzaCBLdW1hciBbbWFpbHRvOnZpcmVzaC5rdW1h
ckBsaW5hcm8ub3JnXQ0KPiBTZW50OiAyMDE5xOoy1MIxNMjVIDE1OjEzDQo+IFRvOiBBbnNvbiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBt
dHVycXVldHRlQGJheWxpYnJlLmNvbTsgc2JveWRAa2VybmVsLm9yZzsgQWlzaGVuZyBEb25nDQo+
IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhw
LmNvbT47DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1jbGtAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBWNCAxLzJdIGFybTY0OiBkdHM6IGZyZWVzY2FsZTog
aW14OHF4cDogYWRkIGNwdSBvcHANCj4gdGFibGUNCj4gDQo+IE9uIDE0LTAyLTE5LCAwMTo1NCwg
QW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gQWRkIGkuTVg4UVhQIENQVSBvcHAgdGFibGUgdG8gc3Vw
cG9ydCBjcHVmcmVxLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gTm8gY2hhbmdlIHNpbmNlIFYzLg0KPiA+IC0t
LQ0KPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgfCAyNQ0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI1IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4cXhwLmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhxeHAuZHRzaQ0KPiA+IGluZGV4IDQwMjFmMjUuLjU5M2UyZGIgMTAwNjQ0DQo+ID4gLS0t
IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHF4cC5kdHNpDQo+ID4gQEAgLTM0LDYg
KzM0LDEwIEBADQo+ID4gIAkJCXJlZyA9IDwweDAgMHgwPjsNCj4gPiAgCQkJZW5hYmxlLW1ldGhv
ZCA9ICJwc2NpIjsNCj4gPiAgCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmQTM1X0wyPjsNCj4gPiAr
CQkJY2xvY2tzID0gPCZjbGsgSU1YX0EzNV9DTEs+Ow0KPiA+ICsJCQljbG9jay1sYXRlbmN5ID0g
PDYxMDM2PjsNCj4gDQo+IFdobyB1c2VzIHRoaXMgdmFsdWUgPyBBbmQgd2h5IGlzIGl0IGRpZmZl
cmVudCBmcm9tIHRoZSBvbmUgbWVudGlvbmVkIGluIHRoZQ0KPiBPUFAgdGFibGUgPw0KDQpTb3Jy
eSwgZm9yZ290IHRvIHJlbW92ZSBpdC4gV2lsbCByZW1vdmUgaXQgaW4gbmV4dCB2ZXJzaW9uLg0K
DQo+IA0KPiA+ICsJCQkjY29vbGluZy1jZWxscyA9IDwyPjsNCj4gDQo+IGNsb2NrcyBhbmQgY29v
bGluZy1jZWxscyBtdXN0IGJlIGRlZmluZWQgZm9yIGFsbCB0aGUgQ1BVcy4NCg0KT0suDQoNCj4g
DQo+ID4gKwkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmEzNV8wX29wcF90YWJsZT47DQo+ID4g
IAkJfTsNCj4gPg0KPiA+ICAJCUEzNV8xOiBjcHVAMSB7DQo+ID4gQEAgLTQyLDYgKzQ2LDcgQEAN
Cj4gPiAgCQkJcmVnID0gPDB4MCAweDE+Ow0KPiA+ICAJCQllbmFibGUtbWV0aG9kID0gInBzY2ki
Ow0KPiA+ICAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZBMzVfTDI+Ow0KPiA+ICsJCQlvcGVyYXRp
bmctcG9pbnRzLXYyID0gPCZhMzVfMF9vcHBfdGFibGU+Ow0KPiA+ICAJCX07DQo+ID4NCj4gPiAg
CQlBMzVfMjogY3B1QDIgew0KPiA+IEBAIC01MCw2ICs1NSw3IEBADQo+ID4gIAkJCXJlZyA9IDww
eDAgMHgyPjsNCj4gPiAgCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gPiAgCQkJbmV4dC1s
ZXZlbC1jYWNoZSA9IDwmQTM1X0wyPjsNCj4gPiArCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwm
YTM1XzBfb3BwX3RhYmxlPjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gIAkJQTM1XzM6IGNwdUAzIHsN
Cj4gPiBAQCAtNTgsNiArNjQsNyBAQA0KPiA+ICAJCQlyZWcgPSA8MHgwIDB4Mz47DQo+ID4gIAkJ
CWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQo+ID4gIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkEz
NV9MMj47DQo+ID4gKwkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmEzNV8wX29wcF90YWJsZT47
DQo+ID4gIAkJfTsNCj4gPg0KPiA+ICAJCUEzNV9MMjogbDItY2FjaGUwIHsNCj4gPiBAQCAtNjUs
NiArNzIsMjQgQEANCj4gPiAgCQl9Ow0KPiA+ICAJfTsNCj4gPg0KPiA+ICsJYTM1XzBfb3BwX3Rh
YmxlOiBvcHAtdGFibGUgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAib3BlcmF0aW5nLXBvaW50cy12
MiI7DQo+ID4gKwkJb3BwLXNoYXJlZDsNCj4gPiArDQo+ID4gKwkJb3BwLTkwMDAwMDAwMCB7DQo+
ID4gKwkJCW9wcC1oeiA9IC9iaXRzLyA2NCA8OTAwMDAwMDAwPjsNCj4gPiArCQkJb3BwLW1pY3Jv
dm9sdCA9IDwxMDAwMDAwPjsNCj4gPiArCQkJY2xvY2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0K
PiA+ICsJCX07DQo+ID4gKw0KPiA+ICsJCW9wcC0xMjAwMDAwMDAwIHsNCj4gPiArCQkJb3BwLWh6
ID0gL2JpdHMvIDY0IDwxMjAwMDAwMDAwPjsNCj4gPiArCQkJb3BwLW1pY3Jvdm9sdCA9IDwxMTAw
MDAwPjsNCj4gPiArCQkJY2xvY2stbGF0ZW5jeS1ucyA9IDwxNTAwMDA+Ow0KPiA+ICsJCQlvcHAt
c3VzcGVuZDsNCj4gDQo+IFlvdSB3YW50IHRvIGdvIHRvIGEgaGlnaGVyIGZyZXF1ZW5jeSBvbiBz
dXNwZW5kID8NCg0KWWVzLCBvbiBtb3N0IG9mIGkuTVggU29Dcywgd2UgYWx3YXlzIHVzZSBoaWdo
ZXN0IGZyZXF1ZW5jeSBmb3Igc3VzcGVuZCB0byByZWR1Y2UNCnRoZSBzdXNwZW5kL3Jlc3VtZSBs
YXRlbmN5Lg0KDQpUaGFua3MsDQpBbnNvbi4NCg0KPiANCj4gPiArCQl9Ow0KPiA+ICsJfTsNCj4g
PiArDQo+ID4gIAlnaWM6IGludGVycnVwdC1jb250cm9sbGVyQDUxYTAwMDAwIHsNCj4gPiAgCQlj
b21wYXRpYmxlID0gImFybSxnaWMtdjMiOw0KPiA+ICAJCXJlZyA9IDwweDAgMHg1MWEwMDAwMCAw
IDB4MTAwMDA+LCAvKiBHSUMgRGlzdCAqLw0KPiA+IC0tDQo+ID4gMi43LjQNCj4gDQo+IC0tDQo+
IHZpcmVzaA0K
