Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E160FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9817221738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 03:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jJsUXECR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfBTDoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 22:44:03 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:57904
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfBTDoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 22:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frvyzBPkZb1sEbAUZge4GAX9L+4PqLvnF8dfXd1djhg=;
 b=jJsUXECRi8gSItZE70AK9YcF1GlCEjK3VIOCK3Sqa0YPQk5vAaWQfGJxgifr1XWAFGf2ZcTl+5E3YW0M6NsCFi6DS0hqqPebGqZoNJwIaqdgk3g4Sw5QUDAVuL6O7UHLCPqttqLB3Lraau6ct6dV1x/MTdKbuMIO8ojKtdOWNVA=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 03:43:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 03:43:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V6 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUvsrbmfXgtz1KZEeItOtlZ1aFAqXoGd6wgAADgWA=
Date:   Wed, 20 Feb 2019 03:43:54 +0000
Message-ID: <DB3PR0402MB3916F868BBB10B2898C46026F57D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB4215E32892899A6E84182D43807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB4215E32892899A6E84182D43807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 531f61e6-7cd2-45a0-a046-08d696e5a306
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM5MzE7MjM6bUc4K2JnN29IRmhaUTRZTUZmcHk3WW5u?=
 =?gb2312?B?YnlwbEVtOFRRMFBFYkJaaDBDeFMxNklPcFZaK3lNalI1ZEQrTzJMVHhtcEIr?=
 =?gb2312?B?L1pIUzVGMGVLbGcraXZySi92Zkk1bG14THAyT25MdXRNdWZQWFlYdzdWMFEy?=
 =?gb2312?B?WkdDMXJIQ2RmSWdmY3N6MHhzQVM1dGY2TzJNbkNVMk5lU1NzQlptcDFhWG5x?=
 =?gb2312?B?dCsvL242b0lmY1pjZEdGYk81Y29CUHVOR2ZGeS8xRWpHc0Z3ckU4bzk3cURw?=
 =?gb2312?B?ZUFXdHZIUUpKWFhKb21OUU8rcExhK0NEa3VwN3NWWGFsTEplT09mSkcwQ1NP?=
 =?gb2312?B?cHdMcHI5ZHd1Z1k3OWtzaEJiZnZQOFJjTldlYjRJOFBDQmNmaTUvdWtRSE5J?=
 =?gb2312?B?ejQvaEhCWXhNV1lBZTdtZjRZSktQcGZWVmZ3YVpLc29YZGQ2Qk1ib1U4T21s?=
 =?gb2312?B?SjRuaWNPRFV1UGlEcjI3V29VL0ZnNjUvMzZqL1RpTWZTbk1iNHYzR2pGbUpJ?=
 =?gb2312?B?WFFyZGkrTFJobzI3emRpaUhmbWc5N20xOWdEOUgvVXk2R2M3Sk1YMmhldjMw?=
 =?gb2312?B?Q0M0QVh3OS9PVzJpT1gzd3Q4bHhIOUhPOVh4TEFtT0RaWEEyQkhRek9LZkNR?=
 =?gb2312?B?amtTM3hudVBWTnZsWDlkWkxGTlNpTWxjUHRIYWFEbnh4ZW1vdmN2eGxWenIv?=
 =?gb2312?B?MzVzNVM2b2RvNzl0bk5ENG8wY1owemEzS3JmdUU3TE1reUtPcDRPMlhVUnJk?=
 =?gb2312?B?RGk1WmhkTExBTXhHYzlFblpoUVBBOERCZjBlcjh5WHJvRkZDbU00WU5kaUM4?=
 =?gb2312?B?YUxYWENEb2dnQTNjbVVSSGs5b0UxMUVmajRSano0TTJmTXNtU29yQ01laHpJ?=
 =?gb2312?B?cXRxYzRFbmlFbkE2eHU3Sk92M1FveU5vOXorZDN2U3NDZUtoVVhZcCtkNXo5?=
 =?gb2312?B?N0U2bW9DTkVMaDBkalhQWFczT2RHdDBEVklPaUZxeHNwV1ZnVTRYT0FYQXNs?=
 =?gb2312?B?bXN6TEhJNGNEVzBBb0Y5MTZ2dmtOeWVGZzVRUjhSVkZ5b1ZHNHpVb1RwK3R0?=
 =?gb2312?B?ajdrWTZBU3dsYTM4MVkvVDFUK3F1Vm1UZTVVaWJBTnFWR3lQY0pSUzJjVGtX?=
 =?gb2312?B?OURObnBVRnFzVk1sUDRQK0pCR3I2cUczS2szU0FzeFYwS2FaN0JIVDJ6QXZE?=
 =?gb2312?B?ODhqSU5hUStDYTFTZEpEdjJFQU9uNGNSY3hZcFBkR1M0dUtXM09vL21uSTJo?=
 =?gb2312?B?UWpDV21yTTVUU21VNEtZSEk4WXlyc3F3eklHQi9zTmJoSnZzSFNGeXgyMTJ4?=
 =?gb2312?B?QmJKREJkMVZ4TDVTN0ZMNDdET1ZTVEJWeHNYRHd3am9SQmdOVGZ1aWdyWmtr?=
 =?gb2312?B?Y2F4bFBkYy9Ucy9oZWtlY3djcksrUElnNmp5MUc5Lzg4bTcwYnlTZDNQa010?=
 =?gb2312?B?RS9yS1VyV2JHR1JBZ05MdktzcEVaZjROU2tjd3dIajdDVGdoZ3p4NUx3Z21u?=
 =?gb2312?B?N3h6WmdqNEcvRG9OSklqSkRhMllXeXZlM0FmYnFiSFQ2TzFqRVJWSnFZQ2tN?=
 =?gb2312?B?NVYxc2xSMElLeU1vZUVHcnBGQU5ITGtGaXFUWnBWQnNSYU5oT3BqS0hrcnor?=
 =?gb2312?B?YklVdmh1Vk15L3cvejN2d25QUXozSlpWQk5BUzc2OFBGRkUrMjBKdzc1N3NR?=
 =?gb2312?B?NGQ4MlBQeVFmQWk0dDlPS0FJeVVzOW4vbnB4SGdWQmtrd3FlTjh1MnlaUUYx?=
 =?gb2312?B?WTE5VFRGaDJWZEppU0xZbkI5RXM3Vm50N1d1UVNCQW1NNjVGNHNLMGNRTmZS?=
 =?gb2312?B?N2ppY09vOVN5bzI1enB3RzI4MHRZQWN1ZDNmK08xdEFIQ1FUYjlZL3htbHg0?=
 =?gb2312?Q?eZFRwKKPVv1b4=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB393145BA654B963A0F86D050F57D0@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(376002)(39860400002)(54534003)(13464003)(199004)(189003)(5660300002)(4326008)(74316002)(7696005)(106356001)(229853002)(446003)(305945005)(76176011)(7736002)(6436002)(71200400001)(55016002)(2501003)(476003)(86362001)(256004)(6246003)(9686003)(2201001)(71190400001)(99286004)(68736007)(14454004)(186003)(8936002)(102836004)(53546011)(6506007)(478600001)(3846002)(25786009)(6116002)(2906002)(486006)(97736004)(316002)(66066001)(81156014)(44832011)(33656002)(105586002)(11346002)(81166006)(53936002)(110136005)(8676002)(7416002)(26005)(921003)(1121003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VqgC6spW8XuNq7g8ycvfvcdO1Tej7UcR7MEcFJPUI6ww3JMHTfxVwlP37bJFWVRGz/hURNz6KucJ9OtQGcyEAS8OJDsPqyBR/G2PEc6vjkaFvvC5TLFM30cU7sHOeN/3/7VqITMNQr/ZGi1ZH8nufihnAGZH2AcR9IlPGHr1NJlJfNCG3B+GzTDOeTJdQ8I0Q4g1BS/OOA3dYKsUHD+sDevlHwU3LsMfAD21HUhDbanDPzpLbvvsUn9jeb5dqCUQxufZesQKfWKKnpib++wP0YdkzIrEo5MZm+JLfE17KdPOl5ppKtGuuN4dOwHznFiyStBbCwAvBqM34f3Ok4oxfbBPrn7eEG8o0CHN2JEjgLNMX6F+zVgUYb9Z9p73BDs8WD/K7qQKEivNL/iQbGRFWMXT83tJG8SAtFlh8Z6dBt8=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531f61e6-7cd2-45a0-a046-08d696e5a306
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 03:43:54.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IDIwMTnE6jLUwjIwyNUgMTE6MjcN
Cj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwu
b3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVl
ckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFp
bC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBy
dWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tOw0KPiBkYW5pZWwubGV6Y2Fu
b0BsaW5hcm8ub3JnOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBEYW5pZWwgQmFsdXRhDQo+IDxk
YW5pZWwuYmFsdXRhQG54cC5jb20+OyBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgQW5keSBH
cm9zcw0KPiA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgaGVpa29Ac250ZWNoLmRlOyBhcm5kQGFy
bmRiLmRlOw0KPiBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tOyBqYWdhbkBhbWFydWxhc29sdXRp
b25zLmNvbTsNCj4gYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGVucmljLmJhbGxldGJvQGNv
bGxhYm9yYS5jb207DQo+IG1hcmMudy5nb256YWxlekBmcmVlLmZyOyBvbG9mQGxpeG9tLm5ldDsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IHBtQHZn
ZXIua2VybmVsLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4g
U3ViamVjdDogUkU6IFtQQVRDSCBWNiAxLzRdIGR0LWJpbmRpbmdzOiBmc2w6IHNjdTogYWRkIHRo
ZXJtYWwgYmluZGluZw0KPiANCj4gPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiA+IFNlbnQ6IFRodXJz
ZGF5LCBGZWJydWFyeSA3LCAyMDE5IDU6NTMgUE0NCj4gWy4uLl0NCj4gPg0KPiA+IE5YUCBpLk1Y
OFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lkZSBhcyBzeXN0
ZW0NCj4gPiBjb250cm9sbGVyLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9m
IHN5c3RlbSBwb3dlciwgY2xvY2sNCj4gPiBhbmQgdGhlcm1hbCBzZW5zb3JzIGV0Yy4gbWFuYWdl
bWVudCwgTGludXgga2VybmVsIGhhcyB0byBjb21tdW5pY2F0ZQ0KPiA+IHdpdGggc3lzdGVtIGNv
bnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpIElQQyB0byBnZXQgdGVtcGVyYXR1cmUNCj4g
PiBmcm9tIHRoZXJtYWwgc2Vuc29ycywgdGhpcyBwYXRjaCBhZGRzIGJpbmRpbmcgZG9jIGZvciBp
Lk1YIHN5c3RlbQ0KPiBjb250cm9sbGVyIHRoZXJtYWwgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlTG9n
IHNpbmNlIFY1Og0KPiA+IAktIGFkZCAiaW14LHNlbnNvci1yZXNvdXJjZS1pZCIgaW4gZWFjaCB0
aGVybWFsIHpvbmUgdG8gcGFzcyByZXNvdXJjZQ0KPiA+IElEIGZvciB0aGVybWFsIGRyaXZlci4N
Cj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2ws
c2N1LnR4dCAgICB8IDIwDQo+ID4gKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+
ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2ws
c2N1LnR4dA0KPiA+IGluZGV4IDcyZDQ4MWMuLjRiNzk3NTEgMTAwNjQ0DQo+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQN
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2Fs
ZS9mc2wsc2N1LnR4dA0KPiA+IEBAIC0xMjIsNiArMTIyLDIwIEBAIFJUQyBiaW5kaW5ncyBiYXNl
ZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KPiA+IFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4g
IC0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJmc2wsaW14OHF4cC1zYy1ydGMiOw0KPiA+DQo+ID4g
K1RoZXJtYWwgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wNCj4gPiArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICstIGNvbXBhdGlibGUgOiBN
dXN0IGJlICJmc2wsaW14OHF4cC1zYy10aGVybWFsIjsNCj4gPiArLSB0c2Vucy1udW0gOiBUb3Rh
bCBudW1iZXIgb2YgdGhlcm1hbCBzZW5zb3JzIHN1cHBvcnRlZDsNCj4gPiArLSAjdGhlcm1hbC1z
ZW5zb3ItY2VsbHMgOiBTaG91bGQgYmUgMS4gU2VlDQo+ID4gKw0KPiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdGhlcm1hbC90aGVybWFsLnR4dA0KPiA+ICsJCQkgIGZvciBhIGRl
c2NyaXB0aW9uLg0KPiA+ICstIGlteCxzZW5zb3ItcmVzb3VyY2UtaWQgOiBUaGlzIHByb3BlcnR5
IHNob3VsZCBiZSBkZWZpbmVkIGluIGVhY2gNCj4gPiArdGhlcm1hbA0KPiA+IHpvbmUNCj4gPiAr
CQkJICAgb2YgdGhlcm1hbC16b25lcyBub2RlLCBpdCBwYXNzZXMgZWFjaCB0aGVybWFsDQo+IHpv
bmUncw0KPiA+ICsJCQkgICByZXNvdXJjZSBpZCBmb3IgdGhlcm1hbCBkcml2ZXIgdG8gZ2V0IHRl
bXBlcmF0dXJlDQo+IHZpYQ0KPiA+ICsJCQkgICBTQ1UgSVBDLg0KPiANCj4gVGhpcyBpcyBtaXNz
aW5nIGluIHRoZSBleGFtcGxlPw0KDQpUaGVyZSBhcmUgdHdvIHBhcnRzIG9mIHRoZXJtYWwgZHRz
LCBvbmUgaXMgdGhlIHRzZW5zIHdoaWNoIGFyZSBkaWZmZXJlbnQgb24gZWFjaCBwbGF0Zm9ybS4N
ClRoZSBvdGhlciBhcmUgY29tbW9uIHRoZXJtYWwtem9uZSBkZWZpbml0aW9ucywgdGhlc2UgYXJl
IGNvdmVyZWQgYnkgdGhlcm1hbCBiaW5kaW5nIGRvYy4NClRoZSBwcm9wZXJ0eSBpcyBhZGRlZCBi
eSB1cyBmb3Igb3VyIHBsYXRmb3JtcywgaWYgd2FudCB0byBwdXQgaXQgaW4gZXhhbXBsZSwgSSBu
ZWVkIHRvIGNvcHkNCkhvcGUgcGllY2Ugb2YgY29tbW9uIHRoZXJtYWwtem9uZSBub2RlLg0KDQo+
IA0KPiBCVFcsIGlzIHRoaXMgU0NVIGZ1bmN0aW9uIGxpa2VseSBwbGF0Zm9ybSBkZXBlbmRlbnQ/
DQo+IElmIG5vdCwgeW91IHByb2JhYmx5IGNvdWxkIGFkZCBhIGZhbGxiYWNrIGNvbXBhdGlibGUg
c3VjaCBhcyAiZnNsLHNjdS1ydGMiDQoNCkZvciBub3csIHRoZSBTQ1UgQVBJIHdlIHVzZWQgYXJl
IHBsYXRmb3JtIGluZGVwZW5kZW50LCB0aGUgT05MWSBwYXJhbWV0ZXIgZGVwZW5kcw0Kb24gcGxh
dGZvcm0gaXMgcmVzb3VyY2UgSUQsIHdlIGNhbiBnZXQgaXQgZnJvbSBkdGIgbm9kZS4NCg0KT0ss
IEkgdGhpbmsgd2UgY2FuIHVzZSBhIG1vcmUgZ2VuZXJpYyBjb21wYXRpYmxlIG5hbWUgbGlrZSAi
ZnNsLGlteC1zYy10aGVybWFsIi4NCg0KQW5zb24uDQo+IA0KPiBSZWdhcmRzDQo+IERvbmcgQWlz
aGVuZw0KPiANCj4gPiArDQo+ID4gIEV4YW1wbGUgKGlteDhxeHApOg0KPiA+ICAtLS0tLS0tLS0t
LS0tDQo+ID4gIGxzaW9fbXUxOiBtYWlsYm94QDVkMWMwMDAwIHsNCj4gPiBAQCAtMTY4LDYgKzE4
MiwxMiBAQCBmaXJtd2FyZSB7DQo+ID4gIAkJcnRjOiBydGMgew0KPiA+ICAJCQljb21wYXRpYmxl
ID0gImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4gIAkJfTsNCj4gPiArDQo+ID4gKwkJdHNlbnM6
IHRoZXJtYWwtc2Vuc29yIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy10
aGVybWFsIjsNCj4gPiArCQkJdHNlbnMtbnVtID0gPDE+Ow0KPiA+ICsJCQkjdGhlcm1hbC1zZW5z
b3ItY2VsbHMgPSA8MT47DQo+ID4gKwkJfTsNCj4gPiAgCX07DQo+ID4gIH07DQo+ID4NCj4gPiAt
LQ0KPiA+IDIuNy40DQoNCg==
