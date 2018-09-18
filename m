Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22573ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37F6214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LNdSrkD8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37F6214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeIRGpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:45:06 -0400
Received: from mail-eopbgr30081.outbound.protection.outlook.com ([40.107.3.81]:51520
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbeIRGpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBCxPOJUh9exIHQ5L/rX744vUaxSI0h2yJyZnw9lsJI=;
 b=LNdSrkD8JihSzoJbyZ0/0o3WEGoXshxyWVMpmEEz5KTz9Nsy95oqhfcIhkgw9MwUuWChyHpzXf7dg2Nv7gWgYq3VJLKvge+SfWncq2l6SJtwQJduyrTgEWsE/hkZfdfFMEvf/7OqvmsecYSRC9z95Gziu9IwbbQ0strb9zUAwRU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.71.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 01:15:02 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2%5]) with mapi id 15.20.1143.017; Tue, 18 Sep 2018
 01:15:02 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
Thread-Topic: [PATCH] ARM: dts: imx6ull: update vdd_soc voltage for 900MHz
 operating point
Thread-Index: AQHUSnEkTUNaxTyCoESMrG9rWlwir6TsUDKAgAAAJBCACPScwA==
Date:   Tue, 18 Sep 2018 01:15:02 +0000
Message-ID: <DB3PR0402MB3916936F80C14D00F5D07966F51D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1536740009-32735-1-git-send-email-Anson.Huang@nxp.com>
 <d989e700-0cf1-607a-b333-bdead49ae813@i2se.com>
 <DB3PR0402MB3916249305E241849A32DC05F51B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916249305E241849A32DC05F51B0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3787;6:4F68wIEvY/V1Ft6BeblcS6SH5HY+xFlaPcyhCkFrmwm2YDCFsSdzPVbNWoZY1bP0Feu2TB/qGH9O7yoSudEJiSwgPM8BhPKXbdQEUFU3WM0pAoI5/7yvkcOtKzxsAFPXEcV9g9Ah5ayU/YMA4J2nvgxKogHYGFhOdovkRd7C5dMenX/8yyFaONeoBpfb6YHgUvVKwJenDDHS2NqWtjbbBZkPt02K31S22RyINoE9+ZCZka155z9FuWBa8UYkJfaN+jZX9/7nYKgtSHzztN95O4joBGYRlcjWp2k0tBdx7VaEgJ/xYZbdOQF+f1oTwamYuWjdc59oKD1Q91JOsgGdGaKAMZSWyZg9aSe9kqZKa8PJh/rl3++hBvxwohQvp//8oYljsmXN1PUp4Hp59bMfDt3ULFP/0o0B/XLaswiWbsiDHRYk6TW4TWBvjeoErl5Va2tKshuPuYn4yj/d4iPZyg==;5:5QiHrqt1YfHoWXW9AOGlkpbSRECjh43aUurACpSAShEzsGtaXpnndzqpkL8EREQMkchA5a/640Uyzq2lTwjG8bZYJum7oxeG3p+1Sa68tbaRCDbibthvgHiMYP0tT19PyzinWjWuQ4XLdpStSAubUTxQZsmNV3h0sig7rxr9H1o=;7:Fzs+ppuIyWjgOEvil4AItfDMi78X/iRs9WXX748YMUTleLHUYLigQckZJtpCrh1VTWQvaelS/qHzEt7Z+N3mhrR5O2UwmdSeDtHHSaFixvu/qiLEiiq8S6yuWAu/NdnTappmqAN44BPmjALro/j9tcvTvB338wj1MFQzyB+suLxSFBgXYEv7bd0JhUI8K+1wEDgt2+ig69hN3iMxViYSOW2wIzts2XdXO6lP6wADRoqdEHQvPU7dUYVEJzY8mUKF
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e8ef1970-d36d-4b36-bc3d-08d61d042943
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-microsoft-antispam-prvs: <DB3PR0402MB378704327706DDF3E494C062F51D0@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699050);SRVR:DB3PR0402MB3787;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3787;
x-forefront-prvs: 0799B1B2D7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(346002)(376002)(396003)(13464003)(199004)(189003)(7736002)(9686003)(256004)(14444005)(6436002)(74316002)(14454004)(76176011)(5250100002)(81166006)(81156014)(53936002)(105586002)(99286004)(8936002)(2906002)(106356001)(44832011)(2501003)(97736004)(68736007)(478600001)(55016002)(15650500001)(6506007)(2201001)(66066001)(8676002)(86362001)(305945005)(53546011)(3846002)(6116002)(102836004)(26005)(486006)(25786009)(476003)(7696005)(229853002)(5660300001)(186003)(110136005)(316002)(11346002)(446003)(4326008)(33656002)(6246003)(2900100001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: IcOzKZRuPK6j7i8UNPKDgIyIa5PxUvb0b7nrfOFpCHPz5PzoVfYigqooVuV8X1OpXUPcQXt/aageU2cQC3vQslN9n0iQ4NKFQZQnMQdOSJ11LwfAMMx/JaLWFokGfdrtuCPWC1vKJKKKdooKp+a/tBp2M9H3XZaD1TYoxGcTSLsBZU+DBhGfY1UFXNn/u0tfbxgz5fb3hryJIW/5XAtb+Zc2V02iGfEaDodFVmB1FZdMpVfRtuFzdaCFrCdGqin8Xte5pKxI9WnDOR5VScYSbtn+DBUSVebcwl+mw9dn/O8e9aAJxpIH+zgMGoz9uD95+EI0fSclCPdgg588eKA+oQ6JeCp4g75Gu0vYzqoq3c4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ef1970-d36d-4b36-bc3d-08d61d042943
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2018 01:15:02.8263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZWZhbg0KDQpBbnNvbiBIdWFuZw0KQmVzdCBSZWdhcmRzIQ0KDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5zb24gSHVhbmcNCj4gU2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgMTIsIDIwMTggNDozMCBQTQ0KPiBUbzogU3RlZmFuIFdhaHJlbiA8c3RlZmFu
LndhaHJlbkBpMnNlLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgRmFiaW8gRXN0ZXZhbQ0KPiA8ZmFiaW8u
ZXN0ZXZhbUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNv
bTsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gQVJN
OiBkdHM6IGlteDZ1bGw6IHVwZGF0ZSB2ZGRfc29jIHZvbHRhZ2UgZm9yIDkwME1Ieg0KPiBvcGVy
YXRpbmcgcG9pbnQNCj4gDQo+IEhpLCBTdGVmYW4NCj4gDQo+IEFuc29uIEh1YW5nDQo+IEJlc3Qg
UmVnYXJkcyENCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJv
bTogU3RlZmFuIFdhaHJlbiA8c3RlZmFuLndhaHJlbkBpMnNlLmNvbT4NCj4gPiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAxOCA0OjI4IFBNDQo+ID4gVG86IEFuc29uIEh1YW5nIDxh
bnNvbi5odWFuZ0BueHAuY29tPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gPiBzLmhhdWVyQHBl
bmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IEZhYmlvIEVzdGV2YW0NCj4gPiA8
ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRA
YXJtLmNvbTsNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBBUk06IGR0czogaW14NnVsbDogdXBkYXRlIHZkZF9zb2Mgdm9sdGFnZSBmb3IN
Cj4gPiA5MDBNSHogb3BlcmF0aW5nIHBvaW50DQo+ID4NCj4gPiBIaSBBbnNvbiwNCj4gPg0KPiA+
IEFtIDEyLjA5LjIwMTggdW0gMTA6MTMgc2NocmllYiBBbnNvbiBIdWFuZzoNCj4gPiA+IFVwZGF0
ZSBWRERfU09DIHZvbHRhZ2UgdG8gMS4yNVYgZm9yIDkwME1IeiBvcGVyYXRpbmcgcG9pbnQgYWNj
b3JkaW5nDQo+ID4gPiB0byBkYXRhc2hlZXQgUmV2LiAxLjMsIDA4LzIwMTgsIDI1bVYgaXMgYWRk
ZWQgdG8gdGhlIG1pbmltdW0gYWxsb3dlZA0KPiA+ID4gdmFsdWVzIHRvIGNvdmVyIHBvd2VyIHN1
cHBseSByaXBwbGUuDQo+ID4NCj4gPiBpcyB0aGVyZSBhIHJlYXNvbiB3aHkgdGhlIG5ldyBkYXRh
c2hlZXQgaXNuJ3QgcHVibGlzaGVkIHlldD8NCj4gDQo+IFdlIGp1c3QgZ290IHRoaXMgbmV3IGRh
dGFzaGVldCByZWNlbnRseSwgaXQgd2lsbCBiZSBwdWJsaXNoZWQgc29vbi4NCj4gDQo+IEFuc29u
IA0KDQpUaGUgdjEuMyBkYXRhc2hlZXQgaGFzIGJlZW4gcHVibGlzaGVkLiBQbGVhc2UgY2hlY2sg
aXQgZnJvbSBOWFAgd2Vic2l0ZSwgdGhhbmtzLg0KDQpBbnNvbi4NCg0KPiANCj4gPg0KPiA+IFJl
Z2FyZHMNCj4gPiBTdGVmYW4NCg0K
