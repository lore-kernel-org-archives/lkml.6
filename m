Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED259C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C5320855
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 02:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BC14/Id8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfBXC64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 21:58:56 -0500
Received: from mail-eopbgr40062.outbound.protection.outlook.com ([40.107.4.62]:45616
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727915AbfBXC6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 21:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iVoaH0iLum1psmBJlvnBWBGjvGqpWkhNdlwj4UsScg=;
 b=BC14/Id8mOQqEXt9prL8rwqfOCEq+K79OiQV7K3CvENyiFFM7rSjBFlA+o9NDUOiT+buv7ZGPIbgX9Pejr/RLmmXKZ4kKcZQ5LZblYbQXOgZj/fxrwCNPuXpT9GPuo/rSNPHaraIKAp+JHjMYWO/vMJg0vCguznqod35W3fWh60=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3931.eurprd04.prod.outlook.com (52.134.65.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Sun, 24 Feb 2019 02:58:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Sun, 24 Feb 2019
 02:58:06 +0000
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
Subject: RE: [PATCH V8 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Topic: [PATCH V8 2/4] thermal: imx_sc: add i.MX system controller
 thermal support
Thread-Index: AQHUybAULnz4bMD1zUS0pt2wSf6zwKXt7P6AgABYItA=
Date:   Sun, 24 Feb 2019 02:58:06 +0000
Message-ID: <DB3PR0402MB39168CA4597A88B9AF78AF99F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <1550730831-14995-2-git-send-email-Anson.Huang@nxp.com>
 <20190223213858.GB1472@localhost.localdomain>
In-Reply-To: <20190223213858.GB1472@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c356301-b34f-4e49-c95f-08d69a03e6b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3931;
x-ms-traffictypediagnostic: DB3PR0402MB3931:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM5MzE7MjM6OWNGK1pnbytmOTc4TUphdVN3bXphcWlO?=
 =?gb2312?B?bVhzZkJuVE1zMldXNGdralVndWsyWFdFelpiN21vRDhBOGIvdEVEOFpqQWl1?=
 =?gb2312?B?dDl0d0RQS05ud09hSVhzSzlBZ3JLcHRaUmozWW1kOXpvSXZjcG0xRDd3Qlhp?=
 =?gb2312?B?U2psNk9vR05Va3ROeHlMUnU5Z2MzK2VXRGRwQmYwK3ZvSTdlcmF5ZkY5bjI4?=
 =?gb2312?B?eHJSRm5xUVRDT0lzY2FZVk5QaDRrRE1qblJvL25JTUVYR0RnZ2dvNUUwczFR?=
 =?gb2312?B?UER4ZEgwVmtpVkZOYmcyMnpURzAraGJtL0U2a2RoMTVCWjJ1ZnhwUFMzdWd0?=
 =?gb2312?B?YmszVlRGMGJVeWZlQWg4OUNvSWNiSjBId015cENKcjI4a2dBYjZsTjg1UEtY?=
 =?gb2312?B?VEY1cHZsamEyTXpKUFNaSU1Tdy8zVGpvUmVmN1BhUFpTR1FMUDk1dGlyK1Ba?=
 =?gb2312?B?bTVvaHFXTnU3aEZKSDZpcXpqdWRVUEpmWnhMRGVWVHgwMHgxKzRFd3ZRRU1L?=
 =?gb2312?B?endMbE9vYTdjV1BjZHhLZGNOME5kVWxPWXA5elpFa201QWN4MnBVRVRVQndS?=
 =?gb2312?B?NzlIaWZSRTV4L2pPZCtza1pWdXY4WVdRSEt4b21MdWpNRFBkZnMvVU4yZ1B1?=
 =?gb2312?B?WTFnbjZhZ1ZpWGxrRGxzRG10ODE5eXMyemg3UHg0a2J4U3JxK0d0TXNmeU4r?=
 =?gb2312?B?QzNhazdoR0k5SWxCbVdNbU5nYkM4UkZKUTR5bjQwQjRBcytpNit4WW8vQmZZ?=
 =?gb2312?B?UFowUXpVbDdRSDdNVFhudjNRU3JqcHhLU1FPSTVLakxuS1pWN2J5S1VHaDZH?=
 =?gb2312?B?RkN0VmphUU9JYUxiVC9vOFhmMGw3NjVUWmtJYmZPME9zdGlGdnN5aTh4ZW5H?=
 =?gb2312?B?Q2l6S1puR0xkaExrL3lPcmZQVm1pckNCa2Y4WFBlRmx3UVpnL2pVd0p3WHBh?=
 =?gb2312?B?YTFXbGNrZFlybmtvZStaQlRyc0VGSUtvVkpXWmRXamcrNFM3bVUyQkxJaFJw?=
 =?gb2312?B?b2xMMXJSY3owdnlaNWtaYTdZUUw4cGtsME9DcCtZd05BbnFIdDAzMjVjb0cw?=
 =?gb2312?B?anFYb0doVklyZVhxT2dka2dmN2orcExybTV2aC9GRFc4bmxTeGx3RWlodm92?=
 =?gb2312?B?RTJRakpBYlVuZk56L3pDcStReDM5NWVYZ1FxeGE4YVZPSXZyQm11UFNwd1N6?=
 =?gb2312?B?cFgxYUYxWnBZTDRQNHF4Y2tIRVhMZ1RHdUFtWlV1ZXkxWkgrTWQxWVRlUUhr?=
 =?gb2312?B?cVozdHVCSnNGRXh4cW1XR3UzK3J4dTd5OGljUkR3elZKV0tOamhyS2d1RFNL?=
 =?gb2312?B?bFZOL0RYdkJzWkpJOHllK0lubWF1eFhjQnhBVWhYamhNTitvV0xXUnhtQTVu?=
 =?gb2312?B?QmlYTXhuMGprVzYyWVg0cjVVdWxycTBZdFRBaklwZVRhdGxHVEpaczlDYWZh?=
 =?gb2312?B?SlBMRGJTK3dmZEFiYkgyVFZ5MEtJeDBBeHl6OCtuRzFYOGlnbXZtaFczUldv?=
 =?gb2312?B?NCtWcHNBWExNK1d5OWd5S2pQS1pKRTk5N1M2K05taHllVDdYNUlWbjJRdmFh?=
 =?gb2312?B?R3JRcnJld296YitrQTBOUHo0T0RRZ1N5VnFoMGg4S1d6NHREcVBiejI2bklJ?=
 =?gb2312?B?WDc2aWlyU2NTS3NCMElPdWhhejM4MmJNdDkrc2Y2TXhWTHpMSy8wMEQzSHYy?=
 =?gb2312?B?aW9LZjRYejAwT2hmajdhUTFtcnlMMEpYUCtTQXlKUkgyblhIUXpOTnlRRnJD?=
 =?gb2312?B?bzVrKzZvWWVtMkRLT2FSYXU5d3VyUkQ0cURYQlFzclFmMFlMQ3BSOGFDZTFk?=
 =?gb2312?B?RTYwYVYzUzRuZkNST3B1YVZaSStVSktKaGc5T05LSVZrYTRjQT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB3931D4B3DF4990BDE7551DD9F5790@DB3PR0402MB3931.eurprd04.prod.outlook.com>
x-forefront-prvs: 09583628E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(136003)(13464003)(189003)(199004)(51914003)(71200400001)(71190400001)(26005)(6116002)(6506007)(6436002)(3846002)(97736004)(316002)(86362001)(53546011)(229853002)(7416002)(52536013)(5660300002)(102836004)(68736007)(54906003)(25786009)(81156014)(7736002)(256004)(186003)(81166006)(8676002)(305945005)(4326008)(446003)(76176011)(33656002)(14454004)(476003)(1411001)(74316002)(486006)(6246003)(53936002)(44832011)(66066001)(105586002)(2906002)(478600001)(11346002)(55016002)(99286004)(8936002)(9686003)(6916009)(7696005)(106356001)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3931;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wt08oyGseFsD333Jfbi5dI6sfKjQMo7oVP9L5Skb7EUebOpakToam9MNVSZFqZOR+B2T1V2IQ5qVLWTcDdZhN7KVcnSo+pARrPoGlGZla24pyVN0F2eZQ2vz3qs6KSW2w4bTCNLcLthVe1dgmJVnBJXjL/o2jxKvkV2L07oSX44kXI8kqS7WyPIi902oBs1qi95ZjkWsiG4f4iw5LijqY42FoiQcArGapA96kwQD4sfXfgblaLvYeRp13Ifz83KVYADN0bYfTeqPAv0dLL5bHdcAyfSiJVsAEMqT7EQxOzxYA+U9VHsNFWLrd2zvt6LX98fPjZqTzWGbXj2tkB2t8EL+oHI6aG4I09164rJ0vIT1Sm/oKDSPxIBE0eoTASrUp+4pzW25huPyyTDHknRtqmQYkMVgDTRBIf8qKdlB7VE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c356301-b34f-4e49-c95f-08d69a03e6b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2019 02:58:06.4481
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
dmFsQGdtYWlsLmNvbV0NCj4gU2VudDogMjAxOcTqMtTCMjTI1SA1OjM5DQo+IFRvOiBBbnNvbiBI
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
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY4IDIvNF0gdGhlcm1hbDog
aW14X3NjOiBhZGQgaS5NWCBzeXN0ZW0gY29udHJvbGxlcg0KPiB0aGVybWFsIHN1cHBvcnQNCj4g
DQo+IEhleSBBbnNvbiwNCj4gDQo+IE9uIFRodSwgRmViIDIxLCAyMDE5IGF0IDA2OjM4OjM5QU0g
KzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3
aGljaCBoYXMgYSBDb3J0ZXgtTTQgc3lzdGVtIGNvbnRyb2xsZXINCj4gPiBpbnNpZGUsIHRoZSBz
eXN0ZW0gY29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2YgY29udHJvbGxpbmcgcG93ZXIsIGNsb2Nr
DQo+ID4gYW5kIHRoZXJtYWwgc2Vuc29ycyBldGMuLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGRz
IGkuTVggc3lzdGVtIGNvbnRyb2xsZXIgdGhlcm1hbCBkcml2ZXIgc3VwcG9ydCwgTGludXgNCj4g
PiBrZXJuZWwgaGFzIHRvIGNvbW11bmljYXRlIHdpdGggc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1V
IChtZXNzYWdlIHVuaXQpDQo+ID4gSVBDIHRvIGdldCBlYWNoIHRoZXJtYWwgc2Vuc29yJ3MgdGVt
cGVyYXR1cmUsIGl0IHN1cHBvcnRzIG11bHRpcGxlDQo+ID4gc2Vuc29ycyB3aGljaCBhcmUgcGFz
c2VkIGZyb20gZGV2aWNlIHRyZWUsIHBsZWFzZSBzZWUgdGhlIGJpbmRpbmcgZG9jDQo+ID4gZm9y
IGRldGFpbHMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIFY3Og0KPiA+IAktIHJlbW92
ZSB1bnVzZWQgc3RydWN0dXJlIGlteF9zY190aGVybWFsX2RhdGEgdG8gc2ltcGx5IHRoZSBkcml2
ZXI7DQo+ID4gCS0gbW92ZSB0aGUgImlteCxzZW5zb3ItcmVzb3VyY2UtaWQiIHByb3BlcnR5IGZy
b20gdGhlcm1hbCB6b25lDQo+IG5vZGUgdG8gc2N1IHRzZW5zIG5vZGUsIGFuZA0KPiA+IAkgIGdl
dCB0aGlzIHByb3BlcnR5IHVzaW5nIHBoYW5kbGU7DQo+ID4gCS0gcmVtb3ZlIHVudXNlZCBzZW5z
b3IgbnVtYmVyIGdvdCBmcm9tIGR0cywgbm93IGl0IGlzIG5vdCBuZWVkZWQuDQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvdGhlcm1hbC9LY29uZmlnICAgICAgICAgIHwgIDExICsrKw0KPiA+ICBkcml2
ZXJzL3RoZXJtYWwvTWFrZWZpbGUgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvdGhlcm1h
bC9pbXhfc2NfdGhlcm1hbC5jIHwgMTQ0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTU2IGluc2VydGlvbnMoKykNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvdGhlcm1hbC9pbXhfc2NfdGhlcm1hbC5jDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL0tjb25maWcgYi9kcml2ZXJzL3Ro
ZXJtYWwvS2NvbmZpZyBpbmRleA0KPiA+IDU4YmI3ZDcuLmZlYzBlZjUgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy90aGVybWFsL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3RoZXJtYWwvS2Nv
bmZpZw0KPiA+IEBAIC0yMjMsNiArMjIzLDE3IEBAIGNvbmZpZyBJTVhfVEhFUk1BTA0KPiA+ICAJ
ICBjcHVmcmVxIGlzIHVzZWQgYXMgdGhlIGNvb2xpbmcgZGV2aWNlIHRvIHRocm90dGxlIENQVXMg
d2hlbiB0aGUNCj4gPiAgCSAgcGFzc2l2ZSB0cmlwIGlzIGNyb3NzZWQuDQo+ID4NCj4gPiArY29u
ZmlnIElNWF9TQ19USEVSTUFMDQo+ID4gKwl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29yIGRy
aXZlciBmb3IgTlhQIGkuTVggU29DcyB3aXRoIFN5c3RlbQ0KPiBDb250cm9sbGVyIg0KPiA+ICsJ
ZGVwZW5kcyBvbiAoQVJDSF9NWEMgJiYgSU1YX1NDVSkgfHwgQ09NUElMRV9URVNUDQo+ID4gKwlk
ZXBlbmRzIG9uIE9GDQo+ID4gKwloZWxwDQo+ID4gKwkgIFN1cHBvcnQgZm9yIFRlbXBlcmF0dXJl
IE1vbml0b3IgKFRFTVBNT04pIGZvdW5kIG9uIE5YUCBpLk1YDQo+IFNvQ3Mgd2l0aA0KPiA+ICsJ
ICBzeXN0ZW0gY29udHJvbGxlciBpbnNpZGUsIExpbnV4IGtlcm5lbCBoYXMgdG8gY29tbXVuaWNh
dGUgd2l0aA0KPiBzeXN0ZW0NCj4gPiArCSAgY29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5p
dCkgSVBDIHRvIGdldCB0ZW1wZXJhdHVyZSBmcm9tDQo+IHRoZXJtYWwNCj4gPiArCSAgc2Vuc29y
LiBJdCBzdXBwb3J0cyBvbmUgY3JpdGljYWwgdHJpcCBwb2ludCBhbmQgb25lDQo+ID4gKwkgIHBh
c3NpdmUgdHJpcCBwb2ludCBmb3IgZWFjaCB0aGVybWFsIHNlbnNvci4NCj4gPiArDQo+ID4gIGNv
bmZpZyBNQVg3NzYyMF9USEVSTUFMDQo+ID4gIAl0cmlzdGF0ZSAiVGVtcGVyYXR1cmUgc2Vuc29y
IGRyaXZlciBmb3IgTWF4aW0gTUFYNzc2MjAgUE1JQyINCj4gPiAgCWRlcGVuZHMgb24gTUZEX01B
WDc3NjIwDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9NYWtlZmlsZSBiL2RyaXZl
cnMvdGhlcm1hbC9NYWtlZmlsZSBpbmRleA0KPiA+IDQ4NmQ2ODIuLjQwNjI2MjcgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy90aGVybWFsL01ha2VmaWxlDQo+ID4gKysrIGIvZHJpdmVycy90aGVy
bWFsL01ha2VmaWxlDQo+ID4gQEAgLTQwLDYgKzQwLDcgQEAgb2JqLSQoQ09ORklHX0RCODUwMF9U
SEVSTUFMKQkrPQ0KPiBkYjg1MDBfdGhlcm1hbC5vDQo+ID4gIG9iai0kKENPTkZJR19BUk1BREFf
VEhFUk1BTCkJKz0gYXJtYWRhX3RoZXJtYWwubw0KPiA+ICBvYmotJChDT05GSUdfVEFOR09fVEhF
Uk1BTCkJKz0gdGFuZ29fdGhlcm1hbC5vDQo+ID4gIG9iai0kKENPTkZJR19JTVhfVEhFUk1BTCkJ
Kz0gaW14X3RoZXJtYWwubw0KPiA+ICtvYmotJChDT05GSUdfSU1YX1NDX1RIRVJNQUwpCSs9IGlt
eF9zY190aGVybWFsLm8NCj4gPiAgb2JqLSQoQ09ORklHX01BWDc3NjIwX1RIRVJNQUwpCSs9IG1h
eDc3NjIwX3RoZXJtYWwubw0KPiA+ICBvYmotJChDT05GSUdfUU9SSVFfVEhFUk1BTCkJKz0gcW9y
aXFfdGhlcm1hbC5vDQo+ID4gIG9iai0kKENPTkZJR19EQTkwNjJfVEhFUk1BTCkJKz0gZGE5MDYy
LXRoZXJtYWwubw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3RoZXJtYWwvaW14X3NjX3RoZXJt
YWwuYw0KPiA+IGIvZHJpdmVycy90aGVybWFsL2lteF9zY190aGVybWFsLmMNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjE0NWU3M2INCj4gPiAtLS0gL2Rldi9u
dWxsDQo+ID4gKysrIGIvZHJpdmVycy90aGVybWFsL2lteF9zY190aGVybWFsLmMNCj4gPiBAQCAt
MCwwICsxLDE0NCBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsN
Cj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IDIwMTgtMjAxOSBOWFAuDQo+ID4gKyAqLw0KPiA+
ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Vyci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvZmly
bXdhcmUvaW14L3NjaS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gKyNp
bmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L3NsYWIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3RoZXJtYWwuaD4NCj4gPiArDQo+ID4g
KyNpbmNsdWRlICJ0aGVybWFsX2NvcmUuaCINCj4gPiArDQo+ID4gKyNkZWZpbmUgSU1YX1NDX01J
U0NfRlVOQ19HRVRfVEVNUAkxMw0KPiA+ICsjZGVmaW5lIElNWF9TQ19DX1RFTVAJCQkwDQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3RydWN0IGlteF9zY19pcGMgKnRoZXJtYWxfaXBjX2hhbmRsZTsNCj4g
PiArDQo+ID4gK3N0cnVjdCBpbXhfc2Nfc2Vuc29yIHsNCj4gPiArCXN0cnVjdCB0aGVybWFsX3pv
bmVfZGV2aWNlICp0emQ7DQo+ID4gKwl1MzIgcmVzb3VyY2VfaWQ7DQo+ID4gK307DQo+ID4gKw0K
PiA+ICtzdHJ1Y3QgcmVxX2dldF90ZW1wIHsNCj4gPiArCXUxNiByZXNvdXJjZV9pZDsNCj4gPiAr
CXU4IHR5cGU7DQo+ID4gK30gX19wYWNrZWQ7DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgcmVzcF9nZXRf
dGVtcCB7DQo+ID4gKwl1MTYgY2Vsc2l1czsNCj4gPiArCXU4IHRlbnRoczsNCj4gPiArfSBfX3Bh
Y2tlZDsNCj4gPiArDQo+ID4gK3N0cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3RlbXAgew0KPiA+
ICsJc3RydWN0IGlteF9zY19ycGNfbXNnIGhkcjsNCj4gPiArCXVuaW9uIHsNCj4gPiArCQlzdHJ1
Y3QgcmVxX2dldF90ZW1wIHJlcTsNCj4gPiArCQlzdHJ1Y3QgcmVzcF9nZXRfdGVtcCByZXNwOw0K
PiA+ICsJfSBkYXRhOw0KPiA+ICt9IF9fcGFja2VkOw0KPiA+ICsNCj4gPiArc3RhdGljIGludCBp
bXhfc2NfdGhlcm1hbF9nZXRfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXApIHsNCj4gPiArCXN0
cnVjdCBpbXhfc2NfbXNnX21pc2NfZ2V0X3RlbXAgbXNnOw0KPiA+ICsJc3RydWN0IGlteF9zY19y
cGNfbXNnICpoZHIgPSAmbXNnLmhkcjsNCj4gPiArCXN0cnVjdCBpbXhfc2Nfc2Vuc29yICpzZW5z
b3IgPSBkYXRhOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwltc2cuZGF0YS5yZXEucmVz
b3VyY2VfaWQgPSBzZW5zb3ItPnJlc291cmNlX2lkOw0KPiA+ICsJbXNnLmRhdGEucmVxLnR5cGUg
PSBJTVhfU0NfQ19URU1QOw0KPiA+ICsNCj4gPiArCWhkci0+dmVyID0gSU1YX1NDX1JQQ19WRVJT
SU9OOw0KPiA+ICsJaGRyLT5zdmMgPSBJTVhfU0NfUlBDX1NWQ19NSVNDOw0KPiA+ICsJaGRyLT5m
dW5jID0gSU1YX1NDX01JU0NfRlVOQ19HRVRfVEVNUDsNCj4gPiArCWhkci0+c2l6ZSA9IDI7DQo+
ID4gKw0KPiA+ICsJcmV0ID0gaW14X3NjdV9jYWxsX3JwYyh0aGVybWFsX2lwY19oYW5kbGUsICZt
c2csIHRydWUpOw0KPiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCXByX2VycigicmVhZCB0ZW1wIHNl
bnNvciAlZCBmYWlsZWQsIHJldCAlZFxuIiwNCj4gPiArCQkJc2Vuc29yLT5yZXNvdXJjZV9pZCwg
cmV0KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCSp0ZW1wID0g
bXNnLmRhdGEucmVzcC5jZWxzaXVzICogMTAwMCArIG1zZy5kYXRhLnJlc3AudGVudGhzICogMTAw
Ow0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIGlteF9zY190aGVybWFsX29wcyA9
IHsNCj4gPiArCS5nZXRfdGVtcCA9IGlteF9zY190aGVybWFsX2dldF90ZW1wLCB9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBpbXhfc2NfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KSB7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wLCAqc2Vuc29yX25wOw0K
PiA+ICsJaW50IHJldCwgaSA9IDA7DQo+ID4gKw0KPiA+ICsJcmV0ID0gaW14X3NjdV9nZXRfaGFu
ZGxlKCZ0aGVybWFsX2lwY19oYW5kbGUpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4g
cmV0Ow0KPiA+ICsNCj4gPiArCW5wID0gb2ZfZmluZF9ub2RlX2J5X25hbWUoTlVMTCwgInRoZXJt
YWwtem9uZXMiKTsNCj4gPiArCWlmICghbnApDQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+IA0K
PiBJIGFtIHN0aWxsIGZhaWxpbmcgdG8gdW5kZXJzdGFuZCB3aHkgeW91IG5lZWQgdG8gZG8gdGhl
IHNlYXJjaCBhYm92ZSBhbmQgLi4NCg0KSSB1c2VkIHRoaXMgdG8gZGV0ZXJtaW5lIGhvdyBtYW55
IHRoZXJtYWwgem9uZXMgd2lsbCBiZSBzdXBwb3J0ZWQgZnJvbSBkdHMsIGFuZA0KZ2V0IGVhY2gg
dGhlcm1hbCB6b25lJ3MgcmVzb3VyY2UgSUQgZm9yIGNvbW11bmljYXRpbmcgd2l0aCBzeXN0ZW0g
Y29udHJvbGxlciwgYnV0DQpub3cgSSBqdXN0IGZvdW5kIEkgY2FuIHVzZSB0aGUgICJpbXgsc2Vu
c29yLXJlc291cmNlLWlkIiBwcm9wZXJ0eSdzIGVsZW1lbnQgY291bnQNCnRvIGRldGVybWluZSB0
aGUgdGhlcm1hbCB6b25lIG51bWJlciwgc28gaW4gVjkgcGF0Y2ggc2VyaWVzLCBJIHJlbW92ZSB0
aGlzIHNlYXJjaC4NCg0KPiANCj4gPiArDQo+ID4gKwlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRf
b2Zfbm9kZShucCwgc2Vuc29yX25wKSB7DQo+ID4gKwkJc3RydWN0IG9mX3BoYW5kbGVfYXJncyB0
c2Vuc19hcmdzOw0KPiA+ICsJCXN0cnVjdCBpbXhfc2Nfc2Vuc29yICpzZW5zb3IgPQ0KPiA+ICsJ
CQlkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpzZW5zb3IpLA0KPiBHRlBfS0VSTkVM
KTsNCj4gPiArCQlpZiAoIXNlbnNvcikNCj4gPiArCQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0K
PiA+ICsJCXJldCA9IG9mX3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKHNlbnNvcl9ucCwgInRoZXJt
YWwtDQo+IHNlbnNvcnMiLA0KPiA+ICsJCQkJIiN0aGVybWFsLXNlbnNvci1jZWxscyIsIGksICZ0
c2Vuc19hcmdzKTsNCj4gDQo+IHRoZSBhYm92ZSBzaG91bGRudCBiZSBuZWVkZWQgdG9vLg0KDQpB
bHJlYWR5IHJlbW92ZWQgaW4gVjkuDQoNCj4gDQo+ID4gKwkJaWYgKHJldCA8IDApDQo+ID4gKwkJ
CXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2lu
ZGV4KHRzZW5zX2FyZ3MubnAsDQo+ID4gKwkJCSJpbXgsc2Vuc29yLXJlc291cmNlLWlkIiwgaSwg
JnNlbnNvci0+cmVzb3VyY2VfaWQpOw0KPiANCj4gSWYgeW91IHB1dCAiaW14LHNlbnNvci1yZXNv
dXJjZS1pZCIgaW5zaWRlIHRzZW5zIG5vZGUsIGxpa2UgZGVzY3JpYmVkIGluIHlvdXINCj4gcGF0
Y2ggMDEsIHlvdSBzaG91bGQgYmUgYWJsZSB0byBnZXQgIG5wIGZyb20gcGRldi0+ZGV2Lm9mX25v
ZGUsIHJpZ2h0Pw0KPiANCj4gVGhlbiB5b3Ugc2hvdWxkIGJlIGFibGUgdG8ganVzdCByZWFkIHRo
ZSAiaW14LHNlbnNvci1yZXNvdXJjZS1pZCINCj4gZGlyZWN0bHkgZnJvbSBwZGV2LT5kZXYub2Zf
bm9kZSwgbm8/DQoNCkFoLCB5ZXMsIEkganVzdCBkb24ndCByZW1lbWJlcmVkIHdoeSBJIG5lZWQg
dG8gZ2V0IHRoZSBkZXZpY2Ugbm9kZSBmcm9tIHBoYW5kbGUsDQpzbyBzdHVwaWQgaW4gbGFzdCBw
YXRjaCBzZXJpZXMuLi4gVGhhbmtzIGZvciB0aGUgY29tbWVudCwgcGxlYXNlIGhlbHAgcmV2aWV3
IFY5IHBhdGNoIHNlcmllcy4NCg0KQW5zb24uDQoNCj4gDQo+ID4gKwkJaWYgKHJldCkgew0KPiA+
ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsDQo+ID4gKwkJCQkiZmFpbGVkIHRvIGdldCB2YWxpZCBz
ZW5zb3IgcmVzb3VyY2UgaWQ6ICVkXG4iLA0KPiA+ICsJCQkJcmV0KTsNCj4gPiArCQkJYnJlYWs7
DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQlzZW5zb3ItPnR6ZCA9DQo+IGRldm1fdGhlcm1hbF96
b25lX29mX3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2LA0KPiA+ICsJCQkJCQkJCSAgIGkrKywN
Cj4gPiArCQkJCQkJCQkgICBzZW5zb3IsDQo+ID4gKw0KPiAmaW14X3NjX3RoZXJtYWxfb3BzKTsN
Cj4gPiArCQlpZiAoSVNfRVJSKHNlbnNvci0+dHpkKSkgew0KPiA+ICsJCQlkZXZfZXJyKCZwZGV2
LT5kZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgdGhlcm1hbA0KPiB6b25lXG4iKTsNCj4gPiArCQkJ
cmV0ID0gUFRSX0VSUihzZW5zb3ItPnR6ZCk7DQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJCX0NCj4g
PiArCX0NCj4gPiArDQo+ID4gKwlvZl9ub2RlX3B1dChucCk7DQo+ID4gKwlvZl9ub2RlX3B1dChz
ZW5zb3JfbnApOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGlteF9zY190aGVybWFsX3RhYmxlW10g
PSB7DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxpbXgtc2MtdGhlcm1hbCIsIH0sDQo+ID4g
Kwl7fQ0KPiA+ICt9Ow0KPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBpbXhfc2NfdGhlcm1h
bF90YWJsZSk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBpbXhf
c2NfdGhlcm1hbF9kcml2ZXIgPSB7DQo+ID4gKwkJLnByb2JlID0gaW14X3NjX3RoZXJtYWxfcHJv
YmUsDQo+ID4gKwkJLmRyaXZlciA9IHsNCj4gPiArCQkJLm5hbWUgPSAiaW14LXNjLXRoZXJtYWwi
LA0KPiA+ICsJCQkub2ZfbWF0Y2hfdGFibGUgPSBpbXhfc2NfdGhlcm1hbF90YWJsZSwNCj4gPiAr
CQl9LA0KPiA+ICt9Ow0KPiA+ICttb2R1bGVfcGxhdGZvcm1fZHJpdmVyKGlteF9zY190aGVybWFs
X2RyaXZlcik7DQo+ID4gKw0KPiA+ICtNT0RVTEVfQVVUSE9SKCJBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4iKTsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJUaGVybWFsIGRyaXZl
ciBmb3IgTlhQIGkuTVggU29DcyB3aXRoIHN5c3RlbQ0KPiA+ICtjb250cm9sbGVyIik7IE1PRFVM
RV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCg==
