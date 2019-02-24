Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD81C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BF52054F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f0pPtzWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfBXCxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 21:53:55 -0500
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:63136
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727955AbfBXCxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 21:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYDO4TWdR0CUjMsWksBYGJyv7n711tWtKUGdRi86Xb8=;
 b=f0pPtzWBr1tchT3Abcyw8AxQGF3DKGcmzc3rwZi8lys9kf7+MDWzFUya+EYdvmMvRTLtn0Tb5SuAHQu/ViGLdMMcdSrzcbZyiysOw8GNYHrjRiWZ4n12Aij+OIPwPf+aDfijv5GACblooYelM3v8bnIcqr1a9PrzlaJPaGyby+c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 02:53:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 02:53:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V8 1/4] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHUybAPUmnoI6Ce/UqIMDTlZO/oOqXt7LgAgABXLoA=
Date:   Sun, 24 Feb 2019 02:53:44 +0000
Message-ID: <DB3PR0402MB39164677D09DA6CB3A6951B3F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <20190223213759.GA1472@localhost.localdomain>
In-Reply-To: <20190223213759.GA1472@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48b9108a-8809-43ad-0572-08d69a034ade
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM5MzE7MjM6Yll6RjZmQmRDQ3VKbDVWQTE0dVQxVld5?=
 =?gb2312?B?ZnBBbDFUcit5bS9MdXE4bkZlRm5LZ29wYzkzVk5CY2lnTXJvSVZhSTJVN0tF?=
 =?gb2312?B?SGJHTnFLZDlybC92VVJxMjNmZ09mQkFBZDRHSHp1NXN6bzZrZ01RY2xybEFx?=
 =?gb2312?B?a3VxdWFTTU8vNVlqeTFFMkpEWFZQSG1qUUZsaFRPMVl4QUU0d0MwZHhyeXll?=
 =?gb2312?B?Q2w1dWVsSnlXV2F6aEhmWnNvWCtGNjZsbEtxK1NKdS9PUmRGWEtMS0tJTEdh?=
 =?gb2312?B?cFJQRFMzYXAxaDREMmhYT2p2V3hPTGlGY21WQUtXZGM4UkpOWmJHWVNEay90?=
 =?gb2312?B?NnZyUnl0TkVtcWxCK25pRWhYWjg3T0tjWkxTQTNPMGlvMm83SVBhVU1xNHk3?=
 =?gb2312?B?eG5TWGNDU29wMld4SXdlVytWc1RTbjRJdmlkT3BUZ092d3ZCaVlXbXRpbzR5?=
 =?gb2312?B?Z0Y3RGcwZkxqMUNkUHNxaGcwME03eC83eVBvbm01MXdhblZIQXFmNndxcEtU?=
 =?gb2312?B?WUpPekN5SVY3bEtZVVBzQUpMUmJiQy9nZ2h4SHY5Z3ROeWxOUTNFTFMrQ3ls?=
 =?gb2312?B?NHZPR1F1REVockc1eDlPOXJMc3dnQXVuRnk1bEJQUjE2R2QxN1Y4UnJkcjdi?=
 =?gb2312?B?cy9ZS0RaZitOcWZRSlN4VGhnaDR1OGUvQVpGb1ozZlN4bmJzQkphNHliWFoz?=
 =?gb2312?B?ZVZ0VUdlbGJVU0swMFdPNEdRbmNGajZMYkljeSs2dXdGZUx2eHFCL2pyN2xH?=
 =?gb2312?B?S293dk8xakNDZmoyUGsxMUY0blYraENmdndQTHozTjFuTnNSMVpSNWFvSS85?=
 =?gb2312?B?bGsrcVpqTlRnVndQNndBZGZxNkxSSnAvTVFJU2pFaXBldFB0QnZ1OWtWTm8x?=
 =?gb2312?B?aWtJcGZkTzBKSzZmRUlvME5kQjg0WWRJWWNnazJnTkVrN1F2Q2RzN1dnNW1K?=
 =?gb2312?B?SWw4UlY5U3FKY3VzUWwyKzVHc1JSNzc0eG9JTTl1M2JJL3lmMkFMdXd1blZJ?=
 =?gb2312?B?RmVXMU85WFpPUVBoOHNpb1RXTzI5aXRoV3E1b3BUYU1kelVwbmlFV2tFSFRS?=
 =?gb2312?B?MURMUXQvNVFOVU9VMERKNXRlVGpuWlZyaStEbzJaV1JKWE5UL2dWL3BLVzJx?=
 =?gb2312?B?bzFHcWgyc05WT1dreDFydDRiSFdlRVhVOXpJdkY4M25yUUUvYmhMZkhQek5Y?=
 =?gb2312?B?K3YyYk0wOFgreEk0ajRZMm05aFJnTlpZZEgrYjd1bHJXRWVqSzNlbzJuYVFh?=
 =?gb2312?B?d0FReWlKU1Zxd1lFbkxlcU9oWHRmVlJ6TU1NVEdLMUFlek1vYzF0cGpVdUhI?=
 =?gb2312?B?UjBqNWJrZi9ZNkthL0xtZ2RjWVcwb2xQMUJUUjVDK2VOdVkvMEE1SkVTQVBy?=
 =?gb2312?B?UVFhalA1aEZ6VEtiQVJBaUp4SGZFTEIxVm45RmNaZ1dXS1diZ04rRnJWOFpj?=
 =?gb2312?B?S3M0Sk5pS2Y5RnRVcTZQdGRKekIwTER1SFBxZXZVWnVPRzJ5UmVqRVRDaWo5?=
 =?gb2312?B?NGxYSHRhb1ZNZTA1S29CUFVnY2V4NGRrZ0xmZ1l4MTRxUUgvYXRLNUpoVXJr?=
 =?gb2312?B?YmFWLzR6RDZSRnZWWmJZRysxQ2dZK2wyVGhlTjkrQ0E0NWVqcFdpcENZc1NU?=
 =?gb2312?B?MHVVcWh0MTFVSEk5UXB5UTdBZHZhS1lYaGFDUWlxbDZ4S2ZPbmVkUzVJT3Nl?=
 =?gb2312?B?QlJ2LzJ4amVVblIwQlVJZ0NqbFVwVHpSVWV5RWRJS2swY3RJcExHVmtsK1F1?=
 =?gb2312?B?U2ZXRURPTXVMVEJFckRZQUxLWFViYm9Jais0cVNGY3U4YnN5MGF1a0R2dFcv?=
 =?gb2312?B?OG9STEhoc1JqeFhuVWl5ZjNIeFRoZ2NpZGtOTlI2SlJjRzZ6QT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB39315FECE9F86A3B7D2B3072F5790@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39850400004)(396003)(136003)(13464003)(189003)(199004)(71200400001)(71190400001)(26005)(6116002)(6506007)(6436002)(3846002)(97736004)(316002)(86362001)(53546011)(229853002)(7416002)(52536013)(5660300002)(14444005)(102836004)(68736007)(54906003)(25786009)(81156014)(7736002)(256004)(186003)(81166006)(8676002)(305945005)(4326008)(446003)(76176011)(33656002)(14454004)(476003)(1411001)(74316002)(486006)(6246003)(53936002)(44832011)(66066001)(105586002)(2906002)(478600001)(11346002)(55016002)(99286004)(8936002)(9686003)(6916009)(7696005)(106356001)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FbcKP2JOoE8TQAE0DM0F82FFKnZiU5AsAg+0qQn5wp73qmBUUxC0yQCdrlYHqqj4l0qTCzOuIaRXHutgAHkMJRuHcPKVy2KRHkqC9t9vMV6N3UgxtEuwS4rBftlkQpNSpn339uILR8NYLHy2N+rJAuffr8HcLqmdwL9/11WTN3aHCPgOvr563N4D4BrTYmca942DVZlSQrCnQ/0ju8jRYLcp09Mev15GgOGdOFx2jjj/kETPM/IFWiWrIMpwdSCry0SuHpJRFKhTwxurjS27xumKamjblZ7oAZd/lcxaihsDCXEfXkbxtBkPWWN2wRCvHO4PwZIWkbCf3JjA+XjGuuGZBpMPEnDBDrRdyRBijmmnY3QdIAXtg371JiWfMX8W9hBvianta7ro/O6LfOi6kw3IgdvESJeyMbTrcQF1hsg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b9108a-8809-43ad-0572-08d69a034ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 02:53:44.9846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3931
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEVkdWFyZG8NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFZHVhcmRvIFZhbGVudGluIFttYWlsdG86ZWR1YmV6
dmFsQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMjTI1SA1OjM4DQo+IFRvOiBBbnNvbiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgcnVpLnpoYW5nQGlu
dGVsLmNvbTsNCj4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT47DQo+IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IHNib3lkQGtlcm5l
bC5vcmc7IERhbmllbCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IEFuZHkgR3Jv
c3MgPGFuZHkuZ3Jvc3NAbGluYXJvLm9yZz47DQo+IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1
OyBoZWlrb0BzbnRlY2guZGU7IGFybmRAYXJuZGIuZGU7DQo+IG1heGltZS5yaXBhcmRAYm9vdGxp
bi5jb207IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOw0KPiBqYWdhbkBhbWFydWxhc29sdXRp
b25zLmNvbTsgZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gbWFyYy53LmdvbnphbGV6
QGZyZWUuZnI7IG9sb2ZAbGl4b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4g
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOyBsaW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY4IDEvNF0gZHQtYmluZGlu
Z3M6IGZzbDogc2N1OiBhZGQgdGhlcm1hbCBiaW5kaW5nDQo+IA0KPiBPbiBUaHUsIEZlYiAyMSwg
MjAxOSBhdCAwNjozODozMEFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBOWFAgaS5N
WDhRWFAgaXMgYW4gQVJNdjggU29DIHdpdGggYSBDb3J0ZXgtTTQgY29yZSBpbnNpZGUgYXMgc3lz
dGVtDQo+ID4gY29udHJvbGxlciwgdGhlIHN5c3RlbSBjb250cm9sbGVyIGlzIGluIGNoYXJnZSBv
ZiBzeXN0ZW0gcG93ZXIsIGNsb2NrDQo+ID4gYW5kIHRoZXJtYWwgc2Vuc29ycyBldGMuIG1hbmFn
ZW1lbnQsIExpbnV4IGtlcm5lbCBoYXMgdG8gY29tbXVuaWNhdGUNCj4gPiB3aXRoIHN5c3RlbSBj
b250cm9sbGVyIHZpYSBNVSAobWVzc2FnZSB1bml0KSBJUEMgdG8gZ2V0IHRlbXBlcmF0dXJlDQo+
ID4gZnJvbSB0aGVybWFsIHNlbnNvcnMsIHRoaXMgcGF0Y2ggYWRkcyBiaW5kaW5nIGRvYyBmb3Ig
aS5NWCBzeXN0ZW0NCj4gPiBjb250cm9sbGVyIHRoZXJtYWwgZHJpdmVyLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gQ2hhbmdl
cyBzaW5jZSBWNzoNCj4gPiAgICAgICAgIC0gcmVtb3ZlIHVudXNlZCBwcm9wZXJ0eSAidHNlbnMt
bnVtIjsNCj4gPiAgICAgICAgIC0gaW1wcm92ZSB0aGUgY29tcGF0aWJsZSBkZXNjcmlwdGlvbjsN
Cj4gPiAgICAgICAgIC0gdXBkYXRlIGV4YW1wbGVzIGFjY29yZGluZyB0byBsYXRlc3QgZHRzIGZp
bGUuDQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUv
ZnNsLHNjdS50eHQgICAgIHwgMTkNCj4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2Zz
bCxzY3UudHh0DQo+ID4gaW5kZXggNzJkNDgxYy4uZDg5MTQ3ZSAxMDA2NDQNCj4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4
dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0DQo+ID4gQEAgLTEyMiw2ICsxMjIsMTkgQEAgUlRDIGJpbmRpbmdzIGJh
c2VkIG9uIFNDVSBNZXNzYWdlIFByb3RvY29sDQo+ID4gUmVxdWlyZWQgcHJvcGVydGllczoNCj4g
PiAgLSBjb21wYXRpYmxlOiBzaG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4NCj4g
PiArVGhlcm1hbCBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KPiA+ICst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZToJ
CQlTaG91bGQgYmUgOg0KPiA+ICsJCQkJICAiZnNsLGlteDhxeHAtc2MtdGhlcm1hbCINCj4gPiAr
CQkJCWZvbGxvd2VkIGJ5ICJmc2wsaW14LXNjLXRoZXJtYWwiOw0KPiA+ICsNCj4gPiArLSAjdGhl
cm1hbC1zZW5zb3ItY2VsbHM6CVNlZQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGhlcm1hbC90aGVybWFsLnR4dA0KPiA+ICsJCQkJZm9yIGEgZGVzY3JpcHRpb24uDQo+ID4g
Kw0KPiA+ICstIGlteCxzZW5zb3ItcmVzb3VyY2UtaWQ6IAlQcm9wZXJ0eSBhcnJheSB0byBzcGVj
aWZ5IGVhY2ggdGhlcm1hbCB6b25lJ3MNCj4gc2Vuc29yIHJlc291cmNlIElELg0KPiANCj4gSWYg
dGhpcyBpcyBhbiBhcnJheS4uLg0KPiANCj4gPiArDQo+ID4gIEV4YW1wbGUgKGlteDhxeHApOg0K
PiA+ICAtLS0tLS0tLS0tLS0tDQo+ID4gIGxzaW9fbXUxOiBtYWlsYm94QDVkMWMwMDAwIHsNCj4g
PiBAQCAtMTY4LDYgKzE4MSwxMiBAQCBmaXJtd2FyZSB7DQo+ID4gIAkJcnRjOiBydGMgew0KPiA+
ICAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4gIAkJfTsNCj4gPiAr
DQo+ID4gKwkJdHNlbnM6IHRoZXJtYWwtc2Vuc29yIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJm
c2wsaW14OHF4cC1zYy10aGVybWFsIiwgImZzbCxpbXgtc2MtDQo+IHRoZXJtYWwiOw0KPiA+ICsJ
CQkjdGhlcm1hbC1zZW5zb3ItY2VsbHMgPSA8MD47DQo+ID4gKwkJCWlteCxzZW5zb3ItcmVzb3Vy
Y2UtaWQgPSA8SU1YX1NDX1JfU1lTVEVNPjsNCj4gDQo+IHRoZW4gdGhpcyBleGFtcGxlIHNob3Vs
ZCBoYXZlIGFuIGFycmF5LCB0byBiZSBiZXR0ZXIgZXhwcmVzcyBob3cgdGhpcyBpcw0KPiBzdXBw
b3NlZCB0byB3b3JrLiBDYW4geW91IHBsZWFzZSByZXNlbmQgdGhpcyB3aXRoIGFuIGFycmF5IGlu
c3RlYWQ/DQoNCk9uIGkuTVg4UVhQLCB0aGVyZSBpcyBPTkxZIDEgdGhlcm1hbCB6b25lIGF2YWls
YWJsZSBjdXJyZW50bHksIGJ1dCB0aGUgdGhlcm1hbCBkcml2ZXINCmlzIHN1cHBvc2VkIHRvIHN1
cHBvcnQgbXVsdGkgdGhlcm1hbCB6b25lcyBhcyB3ZWxsIGZvciBpLk1YOFFNLCBpbiBWOSBwYXRj
aCBzZXQgSSBqdXN0DQpzZW50LCBJIHVzZSB0aGUgIiBpbXgsc2Vuc29yLXJlc291cmNlLWlkICIg
ZWxlbWVudCBjb3VudCB0byBkZXRlcm1pbmUgaG93IG1hbnkgdGhlcm1hbA0Kc2Vuc29ycyB3aWxs
IGJlIHN1cHBvcnRlZCwgc28gdGhhdCB3ZSBjYW4gYWxzbyBnZXQgcmlkIG9mIHNlYXJjaGluZyB0
aGUgdGhlcm1hbC16b25lcycgY2hpbGQNCm5vZGUsIEkgaW1wcm92ZWQgdGhlIGRlc2NyaXB0aW9u
IGFzIGJlbG93LCBpcyBpdCBPSz8gDQoNCiA0MSArLSBpbXgsc2Vuc29yLXJlc291cmNlLWlkOiAg
ICAgIEEgc2luZ2xlIGludGVnZXIgZm9yIHNpbmdsZSB0aGVybWFsIHpvbmUncyByZXNvdXJjZSBJ
RCBvcg0KIDQyICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW4gYXJyYXkgb2YgaW50
ZWdlcnMgdG8gc3BlY2lmeSBlYWNoIHRoZXJtYWwgem9uZSdzIHNlbnNvcg0KIDQzICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcmVzb3VyY2UgSUQuDQoNCg0KVGhhbmtzLA0KQW5zb24u
DQoNCj4gDQo+ID4gKwkJfTsNCj4gPiAgCX07DQo+ID4gIH07DQo+ID4NCj4gPiAtLQ0KPiA+IDIu
Ny40DQo+ID4NCg==
