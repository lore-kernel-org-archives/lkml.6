Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDEDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9BB2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N3w5couH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfBTIvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:51:16 -0500
Received: from mail-eopbgr150075.outbound.protection.outlook.com ([40.107.15.75]:23431
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725846AbfBTIvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLditB7VGTYwgx3AZVPYAaI5ukLY57tRMb+ffAsw/Q4=;
 b=N3w5couHGftdeXrnmLFByg0H+bsU6YcJxG+F6fzFGmbNeXsabdBFf87p0sCj+EZ6+oTH80Eu4OHhy/58Bt0WzxsqAKYOpSummNGwMD5uNNmZO/42AlLf6yAbFjUdIp7JzI86y/zbG03iGbpfhgNGcYVmomwleC53/ti9qzQiOD0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3817.eurprd04.prod.outlook.com (52.134.73.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 08:51:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 20 Feb 2019
 08:51:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
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
        "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V7 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUyOj9eEW+Gy1rWUqASm4hcJoqZKXoTK+QgAAOHmA=
Date:   Wed, 20 Feb 2019 08:51:06 +0000
Message-ID: <DB3PR0402MB39165AFD394E16C9FAA6FC4AF57D0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550645332-2907-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB42152F3A2F9C6E6D8CF3D0DA807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB42152F3A2F9C6E6D8CF3D0DA807D0@AM6PR04MB4215.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.23.231]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1376b3e9-3506-4ff4-1926-08d697108d33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3817;
x-ms-traffictypediagnostic: DB3PR0402MB3817:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM4MTc7MjM6a2QxMzQwRVR6c2ZhNms5ZnBLM1FzdXFy?=
 =?gb2312?B?YTRSNTIyeCtoVWR3WmNqY0VmTWFxcFJKZWh6bGV3VGRYZC9Gam82VlA1Q25u?=
 =?gb2312?B?aWxtdks3aEZWWHpXYllDU2dGTVdCYzluRGJZTzI4UUx5Sm1KU3RjODcwdFlR?=
 =?gb2312?B?MWo2dU5IMm1XY09KTE1oeEE4YThwZURIekdNQmJCaGZESlRlNVJ3bGJQM1Yy?=
 =?gb2312?B?cWZwSzBDM0hPWDY0c3V2b2QxcG41R3N5c2s3UDByMUFJTUZuSW5yanhxY0xz?=
 =?gb2312?B?NDNkS1k3Mk50OFdlSDBGT0NscEMwR3kwVXF6eVdKTStGNlFCcFNSVFdWOWdJ?=
 =?gb2312?B?VjlnWGwwS3NadVl2Snh5ajVldmhHanNrR2NpZU1EL1ByLzdES21zTHNFUHB1?=
 =?gb2312?B?dDYxdjN2YmRLaUY1bHU4akd0dVhTZFdZOXowQ2xSSHdHak1YRHdOTnJEdVpQ?=
 =?gb2312?B?TGxoSEMzYTRIR1d3K3lQM2RDWUt6KzFUOUpTYnNMOG1rN0ZIZ2JDT29kcEhZ?=
 =?gb2312?B?b1ZMSGxsVk4rODZIZGp4V3NId0xwMmR3UDFPcERIelVnVFZLaWdwUFlNWFVs?=
 =?gb2312?B?TG5LY3VkM1JITDA3bkxCT1VnTmQ5cjRnUFhBOEk2bUpzRVJzVXBTVFBZZmJk?=
 =?gb2312?B?cnFtZ0ttRGs2MmtwaVF1S2FRR2lqT0NodTBacGJIT2VSbjVIODZCalRwL21C?=
 =?gb2312?B?OWJDZG53a3BmWG91MGV0Z3lodFY1RC9CQVlYNDRpdVUxajQrcTF2bUdlU0hQ?=
 =?gb2312?B?Q1RVTTU5aVI0K3BtbHhvOTZNWFFMK1l6dk55d2Vramk2VS9kdWNocVhGR0tM?=
 =?gb2312?B?VUxHYm9SdHNpZFd1NE9uSUlnQk9oZWVpMmRTdmgrRGRkQTRWU3daTmtGZ0ti?=
 =?gb2312?B?MmFURUlWb1pBMHRwTTFpY25QMDJTK0FVN1c2VHJuVFZ6SEpiaTl6a3hqendL?=
 =?gb2312?B?eTIza1hvbG5vWW5wazg5OGtYK0ZFTzd3ZVdLNUxYWnF0QUY1aFE4ek1VY0la?=
 =?gb2312?B?MVo5aHlKYjZEYnBjUmtnL0tuMlljNkZoaHpaWnk4VlJ1aGlnODlPSCtOcTYw?=
 =?gb2312?B?MTIxd2piR2hPZTcyenExbzdxdGZKdHg4UFJwcm5QVVhIYTdTdllqMFVzRWZ5?=
 =?gb2312?B?eU9kNWwvUGkxRFB4alV1VFBUbFAzQmdIaGQ1aWFsNmhHK1lSWjdUbE9iWVRD?=
 =?gb2312?B?UmtTZisyT1VDSTlrYkx3My9MUlR3cDNpeHNCa0svdnB4aEwrazRlNmJiNFVq?=
 =?gb2312?B?cEIvOWc0MXVoS0w4U3JxV3ZpZWZ3NCs3WjdXblYyUnRpL2dkbC9aemxXL2tT?=
 =?gb2312?B?MXlEQzJSbDZnanpUVHUrd053UVRNV0VNMjlpaEo0dkJxN3NLTmtINTdYdm1s?=
 =?gb2312?B?SmNZbXc0Rm9sYmpxZ0dWN3NHWmhra05EOVVDbXVYZFJGYXUzRVdDTnJUb0Fu?=
 =?gb2312?B?YVh4OHNpWFgzWi9tNWs4WWZmNGtqbUtIYlJoSUR0Z3k1RitGWVYrcUpCbS9o?=
 =?gb2312?B?enlRQjFldndaSVhhRGQrWlhicmY0V3dRSFI3MGhPNEZvY1lYcTRWYW5KL254?=
 =?gb2312?B?YTc4QmQxS2dsQ21mWkROKzJtTmdmNzdRM1pzSUJrZi9FVVZoR0lVT1JrVzlY?=
 =?gb2312?B?QTZVZ3N2akhBZndRaHVIWUNuNjVORTBZUGEvNExPRE1EQlBaREN4RmpYWGx2?=
 =?gb2312?B?K2ZsNkdqdlZSbkJzaEd6Q2d5OW1YZUJCbm81R20rU3lDRXNBTDErc3QxS01v?=
 =?gb2312?B?ZGIxZFJEdEVKNXRyZzE5OVlaeE1FQjBaRm5xMTlMWUl2eGovU0kxNDViRzdq?=
 =?gb2312?B?elluQldHWmFOUzN5aTFOZWlQWUxTTk9pVkkydmVvNllrM0phZz09?=
x-microsoft-antispam-prvs: <DB3PR0402MB3817CBF4F29932C847CCF47AF57D0@DB3PR0402MB3817.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(13464003)(81166006)(81156014)(305945005)(55016002)(8676002)(71190400001)(71200400001)(8936002)(53546011)(102836004)(76176011)(256004)(6506007)(106356001)(99286004)(4326008)(74316002)(53936002)(5660300002)(6246003)(7736002)(7416002)(9686003)(14454004)(2906002)(7696005)(6436002)(25786009)(2501003)(97736004)(478600001)(186003)(2201001)(3846002)(86362001)(229853002)(486006)(68736007)(26005)(6116002)(105586002)(44832011)(476003)(33656002)(316002)(110136005)(446003)(11346002)(66066001)(921003)(1121003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3817;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R+jKhaF+51pOTBoPKWHVMS4hv9djj0JjWvCpCawwQzq49uL/I690vlrPJene3NltUYF0Gik13KibYC0UKIZG79iqqzs/jjlgpi6uOLFn/1LI7Tba62djdb1IcRcmxpUkpIjFkC8l8QIzdsNDBadF79KyEqAlsvshXL3Ggpc6Ab9urKMWlfGq18j84f6XNavakvRk4xl+27Zw3mL95NQplnxteBKwjxra7kT+P535GqIaga9XGH5arWlpR5ntAqX9xByAw5K0zeOH8Z3tpyFozn6cqe8oQfpYtVn8VXEtpJxQ7/T17BmXf7cy/rCnwiBa2OC0x8NhAAVuNPmnpTgolvT92Lz9FQmbtGfVxDRWdAFYO3wlLTfkHROok3yiddFHBKRYt8YiTxR84D4JS04dg3hFijXkd8x4wzsDXxWRrmA=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1376b3e9-3506-4ff4-1926-08d697108d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 08:51:06.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3817
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IDIwMTnE6jLUwjIwyNUgMTU6NDUN
Cj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgbWFyay5ydXRsYW5kQGFy
bS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29tOyBjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gcnVpLnpoYW5nQGludGVsLmNvbTsg
ZWR1YmV6dmFsQGdtYWlsLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsNCj4gdWxmLmhh
bnNzb25AbGluYXJvLm9yZzsgRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsN
Cj4gaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7IEFuZHkgR3Jvc3MgPGFuZHkuZ3Jvc3NAbGlu
YXJvLm9yZz47DQo+IGhlaWtvQHNudGVjaC5kZTsgYXJuZEBhcm5kYi5kZTsgb2xvZkBsaXhvbS5u
ZXQ7DQo+IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBqYWdhbkBhbWFydWxhc29sdXRpb25z
LmNvbTsNCj4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgbWFyYy53LmdvbnphbGV6QGZy
ZWUuZnI7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51
eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjcgMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6
IGFkZCB0aGVybWFsIGJpbmRpbmcNCj4gDQo+ID4gRnJvbTogQW5zb24gSHVhbmcNCj4gPiBTZW50
OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDIwLCAyMDE5IDI6NTQgUE0NCj4gPg0KPiA+IE5YUCBpLk1Y
OFFYUCBpcyBhbiBBUk12OCBTb0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lkZSBhcyBzeXN0
ZW0NCj4gPiBjb250cm9sbGVyLCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9m
IHN5c3RlbSBwb3dlciwgY2xvY2sNCj4gPiBhbmQgdGhlcm1hbCBzZW5zb3JzIGV0Yy4gbWFuYWdl
bWVudCwgTGludXgga2VybmVsIGhhcyB0byBjb21tdW5pY2F0ZQ0KPiA+IHdpdGggc3lzdGVtIGNv
bnRyb2xsZXIgdmlhIE1VIChtZXNzYWdlIHVuaXQpIElQQyB0byBnZXQgdGVtcGVyYXR1cmUNCj4g
PiBmcm9tIHRoZXJtYWwgc2Vuc29ycywgdGhpcyBwYXRjaCBhZGRzIGJpbmRpbmcgZG9jIGZvciBp
Lk1YIHN5c3RlbQ0KPiBjb250cm9sbGVyIHRoZXJtYWwgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQt
Ynk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBz
aW5jZSBWNjoNCj4gPiAJLSBwdXQgImlteCxzZW5zb3ItcmVzb3VyY2UtaWQiIHByb3BlcnR5IGlu
IHRoZXJtYWwgem9uZSBub2Rlcy4NCj4gPiAtLS0NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dCAgfCAyNw0KPiA+ICsrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRp
ZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJl
ZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+IGluZGV4IDcyZDQ4MWMuLmFkOTY4ODEg
MTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9m
cmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+IEBAIC0xMjIsNiArMTIyLDI3
IEBAIFJUQyBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KPiA+IFJlcXVp
cmVkIHByb3BlcnRpZXM6DQo+ID4gIC0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJmc2wsaW14OHF4
cC1zYy1ydGMiOw0KPiA+DQo+ID4gK1RoZXJtYWwgYmluZGluZ3MgYmFzZWQgb24gU0NVIE1lc3Nh
Z2UgUHJvdG9jb2wNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
PiA+ICstIGNvbXBhdGlibGUgOiBNdXN0IGJlICJmc2wsaW14LXNjLXRoZXJtYWwiOw0KPiA+ICst
IHRzZW5zLW51bSA6IFRvdGFsIG51bWJlciBvZiB0aGVybWFsIHNlbnNvcnMgc3VwcG9ydGVkOw0K
PiANCj4gV2UgcHJvcGVybHkgZG9uJ3QgbmVlZCB0aGlzIHByb3BlcnR5IGlmIHRoZSBudW1iZXIg
b2Ygc2Vuc29yIGlzIGZpeGVkIG9uIGENCj4gc3BlY2lmaWMgU29DLg0KDQpBZnRlciBmdXJ0aGVy
IGNoZWNrLCBJIHRoaW5rIHdlIGNhbiB1c2UgIiBmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zf
bm9kZSAiDQp0byBnZXQgZXZlcnkgdGhlcm1hbCB6b25lJ3MgSFcgcmVzb3VyY2UgSUQgYW5kIHJl
bW92ZSB0aGlzIHByb3BlcnR5Lg0KDQo+IA0KPiA+ICstICN0aGVybWFsLXNlbnNvci1jZWxscyA6
IFNob3VsZCBiZSAxLiBTZWUNCj4gPiArDQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy90aGVybWFsL3RoZXJtYWwudHh0DQo+ID4gKwkJCSAgZm9yIGEgZGVzY3JpcHRpb24uDQo+
ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzIGZvciB0aGVybWFsIHpvbmUgbm9kZXM6DQo+
ID4gKy0gaW14LHNlbnNvci1yZXNvdXJjZS1pZCA6IFRoaXMgcHJvcGVydHkgc2hvdWxkIGJlIGRl
ZmluZWQgaW4gZWFjaA0KPiA+ICt0aGVybWFsDQo+IA0KPiBBZnRlciBhIGZ1cnRoZXIgbG9va2lu
ZyBhdCBpdCwgSSB3b25kZXIgdGhpcyBwcm9wZXJ0eSBtYXkgbm90IG5lZWRlZCBlaXRoZXIuDQo+
IA0KDQpJZiB3ZSBkbyBOT1QgaGF2ZSBzdWNoIHByb3BlcnR5LCB3ZSBoYXZlIHRvIGRvIHRoZSBt
YXBwaW5nIGluIGRyaXZlciB0byBnZXQNCnJlc291cmNlIElELCBmb3IgZGlmZmVyZW50IFNvQywg
d2Ugd2lsbCBoYXZlIHRvIGNyZWF0ZSBkaWZmZXJlbnQgbWFwcGluZyB0YWJsZSwNCnRoZSB0aGVy
bWFsIHpvbmUgSUQgZ2l2ZW4gYnkgY29tbW9uIHRoZXJtYWwgZnJhbWV3b3JrIGlzIHZpcnR1YWwg
SUQgc3RhcnRpbmcNCmZyb20gMC4gQWRkaW5nIHRoaXMgcHJvcGVydHkgaW4gdGhlcm1hbCB6b25l
IG5vZGUgaXMgdG8gbWFrZSBTQyB0aGVybWFsIGRyaXZlcg0KbW9yZSBnZW5lcmljIGZvciBvdGhl
ciBTb0NzLg0KDQo+ID4gem9uZQ0KPiA+ICsJCQkgICBvZiB0aGVybWFsLXpvbmVzIG5vZGUsIGl0
IHBhc3NlcyBlYWNoIHRoZXJtYWwNCj4gem9uZSdzDQo+ID4gKwkJCSAgIHJlc291cmNlIGlkIGZv
ciB0aGVybWFsIGRyaXZlciB0byBnZXQgdGVtcGVyYXR1cmUNCj4gdmlhDQo+ID4gKwkJCSAgIFND
VSBJUEMuDQo+ID4gKw0KPiA+ICsJCQkgICBGb3IgdGhlcm1hbCB6b25lIG5vZGVzLCBwbGVhc2Ug
cmVmZXIgdG8gYmVsb3cNCj4gYmluZGluZw0KPiA+ICsJCQkgICBkb2MgZm9yIGRldGFpbHM6DQo+
ID4gKw0KPiA+ICtbMV0gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwv
dGhlcm1hbC50eHQNCj4gPiArDQo+ID4gIEV4YW1wbGUgKGlteDhxeHApOg0KPiA+ICAtLS0tLS0t
LS0tLS0tDQo+ID4gIGxzaW9fbXUxOiBtYWlsYm94QDVkMWMwMDAwIHsNCj4gPiBAQCAtMTY4LDYg
KzE4OSwxMiBAQCBmaXJtd2FyZSB7DQo+ID4gIAkJcnRjOiBydGMgew0KPiA+ICAJCQljb21wYXRp
YmxlID0gImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4gIAkJfTsNCj4gPiArDQo+ID4gKwkJdHNl
bnM6IHRoZXJtYWwtc2Vuc29yIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1z
Yy10aGVybWFsIjsNCj4gPiArCQkJdHNlbnMtbnVtID0gPDE+Ow0KPiA+ICsJCQkjdGhlcm1hbC1z
ZW5zb3ItY2VsbHMgPSA8MT47DQo+IA0KPiBUaGlzIGxvb2tzIG1heSBub3QgY29ycmVjdCBpZiBz
ZW5zb3IgY2VsbHMgaXMgMSBidXQgdGhlIHNlbnNvciBudW1iZXIgSXMgYWxzbyAxLg0KPiBTbyB3
ZSBwcm9iYWJseSBiZXR0ZXIgcmVtb3ZlIHRzZW5zLW51bSBwcm9wZXJ0eS4NCg0KWWVzLCB0aGlz
IHNob3VsZCBiZSAwIGlmIDEgdGhlcm1hbCB6b25lIE9OTFkgaGF2ZSAxIHRoZXJtYWwgc2Vuc29y
LCBsYXRlciB3ZSB3aWxsDQphZGQgb3RoZXIgdGhlcm1hbCB6b25lIGxpa2UgRERSIHpvbmUsIGN1
cnJlbnRseSB0aGVyZSBpcyBzdGlsbCBzb21lIGlzc3VlcyBzbyBTQ0ZXDQpkb2VzIE5PVCBwcm92
aWRlIHN1cHBvcnQgZm9yIHRoaXMgem9uZSwgYWZ0ZXIgaXNzdWUgZml4ZWQsIFNDRlcgbWF5IGFk
ZCB0aGlzIHRoZXJtYWwNCnpvbmUncyBzdXBwb3J0LiBXaWxsIGZpeCB0aGVtIGluIG5leHQgdmVy
c2lvbi4NCg0KVGhhbmtzLA0KQW5zb24uDQoNCj4gDQo+IFJlZ2FyZHMNCj4gRG9uZyBBaXNoZW5n
DQo+IA0KPiA+ICsJCX07DQo+ID4gIAl9Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gLS0NCj4gPiAyLjcu
NA0KDQo=
