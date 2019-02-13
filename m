Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9D2C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4E0222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 05:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="StSC8Jj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfBMFhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 00:37:38 -0500
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:10368
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbfBMFhh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 00:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4z8H9EmWQAjHpCLn2EYCF9m9Ih3dZSbiKhESnjs2QM=;
 b=StSC8Jj082mI1SOceo5Yg5CTR1YL08JePhwvu0DQ1YHmTi7cezv+bVRZJLJTXie60uimBKolbSR+oiO03jWZ60CrnJh/xYBk+kJA/WEyXUxo5kcuUhE+EHtF+iYyIEbS1At+GAlGm8M8zpP7CvMvDKEZ2t6hWGYPCJ4IScBxabU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3644.eurprd04.prod.outlook.com (52.134.70.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Wed, 13 Feb 2019 05:35:51 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 05:35:51 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
        Aisheng Dong <aisheng.dong@nxp.com>,
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
Thread-Index: AQHUvsrbmfXgtz1KZEeItOtlZ1aFAqXdPkZw
Date:   Wed, 13 Feb 2019 05:35:51 +0000
Message-ID: <DB3PR0402MB39165EFE027405873E8AB4ECF5660@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1549532838-27025-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e17287e2-33a4-4b09-7e0e-08d691751daf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3644;
x-ms-traffictypediagnostic: DB3PR0402MB3644:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM2NDQ7MjM6UHYyUU9OOXpVRkpmREdGb29KbWZkaDEz?=
 =?gb2312?B?Lytsck01SWFXemJ4WHlFSEU1NExLRHl4RnMxTHRWNXBUU1p0amQ3ZXRmOEtT?=
 =?gb2312?B?bFgxNzBqcGIyb0dha2pQVWlXWjZMYkRVdmRXZ1puc3JyeTVqbGxEMUVvSXZs?=
 =?gb2312?B?SVFGZ3JEZW5BdGxRRVFGVmR4UHFzOWRkSnpXUjRHTHZoY0hVNndodXhWRk4r?=
 =?gb2312?B?OGZMWXBJWXo2czBCc1JrUXpoKzZsRFZ2RWN1c2xucFE1bGE4bS9KcXovZWVD?=
 =?gb2312?B?M0NuQW53MTlDb0xlY3VnOWNlbm42cUgzNHZRdWQwYXQ2T1o1U05iOTJ1U1hO?=
 =?gb2312?B?bWRXTzJlK0F4dkpnWDQ0Zm04VHVKWjlhZ0MrQklVc3ZiS1VXcXFLM3dtRkIr?=
 =?gb2312?B?ZGl5NzV5N2o5TmRLZFc5Q2JqM0UrMlhaRjNRcDJCekdPVmFZdkVYN3M4aHZG?=
 =?gb2312?B?SGNIU1BoaUFmdVFhODdFendRL2ZIVVA5V3F4THRrK0JzY0syMjRlK1FBQmk4?=
 =?gb2312?B?aDhYcG9rYm93b0RETVNCdnVSU2l3RXpHK3RRSlhUV1dXRHVtMXFvcTRpbkZh?=
 =?gb2312?B?NXVCSG9KeU9xbzN1TjJYUzRrV085dU5ZNDIrT2lBc29Pc0VaQTVGSkNOaGJm?=
 =?gb2312?B?eDJzQVFCQnVoallzdndvR0txVDFLaGJQZXVlY1lQMmNucHFvZmJUNjVTNHU0?=
 =?gb2312?B?dlYwdGNEL1lReWZzU0ZXYTBUbE43ZmNxdGpwd0o2dFZadFkySGw3aTZCWlUz?=
 =?gb2312?B?YXhVQTdrVTF6M0UxVXFQY1JsMStFWEJMMVd0aE41N29EQUttRHUyMkV4N3Np?=
 =?gb2312?B?ajFGM2tjcXl5WGNuSnFhT0RPMnpycGRqbHlyNmhUcTQ4MkQ1ZzRheWUvN2Yw?=
 =?gb2312?B?QjFDS2xVSGhyRTRhTXQwVFEvZms0NjFXUmFnZlhwZk5IQWRpVFFsQ0YrNmIx?=
 =?gb2312?B?RjRvM2EvTDFrLzAyU1FqZVhLVXVlMFNWcGFnVXdVY3M4SC9QbiszWHpaQzFv?=
 =?gb2312?B?MktqVzhhOUhTMWFMY1NHNlpLK29ocjBQOGFDdU1zWGEvMTlVdG1WSWRzVVpW?=
 =?gb2312?B?MkhhQ09yUy9BdHlzOHJmaTU3M0Q5UVJka1dZR2NxVGZiUUd2K2hXNFJkTDV1?=
 =?gb2312?B?UFBRZDBQRzNkRzE5S3hsNmwyK3pPamFwUnJ0WDVuazVsVHBScEtJYnE2OXJa?=
 =?gb2312?B?dTNwUEUxV21VQnJlVDl6OEF0aU5oakxIbmh0SGlDYmRhbzBTaU9FRERLTFZK?=
 =?gb2312?B?dEZxNFlwbFRkTE5KVXlSNnhyd1k2U2luMmlGZ2FVeTVFSDVTWDl5UE1uQ2hC?=
 =?gb2312?B?bis2QjJlbE5vN1NMVGdTMzNWVStweElFVWk3dDYrOGJBbnpOTE5mYzZuWldH?=
 =?gb2312?B?bjZIM2xIK2E0dXMrRllsZ2FrbU9xdU5remtyeGg2RldoU3phQzd0TmF3K0tp?=
 =?gb2312?B?a2x1MkJ0K0t6WFZIRjJPclAweHRHbjhIQkRVSWpZZXJmNVkwN2VOUHh4L2xp?=
 =?gb2312?B?UVBUQkhGakQrV1RwOGJ4QnRQVHhzc2h2S1hXdFVkYnJielVxczZSaGdNSmtF?=
 =?gb2312?B?LzcyNVkrTU81QStRRlp0YlFDSE0zVUZTeGx0TmN3dkRUWE9MVW5DQnlJVEps?=
 =?gb2312?B?WjRvNFQ3eHJzNmdJdlo0YytXQmNJTDloeDRxODZHVy9PUnY0V0s1TzcwaFVl?=
 =?gb2312?B?dHc4ZForQzE3R2NEUnV3OERPVjdDTEpYNVhJVjRBcnZ4U0ZKbUVpN2lKSnY2?=
 =?gb2312?B?M3YybUlDN2hVMmJpeXdOQzlubnpLYzI2cjd3Y1VxekZlWHlybWNvUzRmL0gx?=
 =?gb2312?B?N0ZHa2Mwd3o2WWhtZnpOMHdRS0xFakxKelVYcDVkQyt4R1o0UT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB3644A9A3066E9D859927020AF5660@DB3PR0402MB3644.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(13464003)(54534003)(53936002)(478600001)(6436002)(229853002)(106356001)(3846002)(105586002)(97736004)(6116002)(25786009)(2201001)(86362001)(2906002)(2501003)(55016002)(9686003)(68736007)(44832011)(186003)(33656002)(74316002)(66066001)(81166006)(81156014)(8676002)(4326008)(71190400001)(7736002)(486006)(8936002)(71200400001)(7696005)(53546011)(476003)(316002)(7416002)(6506007)(99286004)(76176011)(256004)(26005)(11346002)(446003)(6346003)(6246003)(110136005)(102836004)(14454004)(305945005)(921003)(15866825006)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3644;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sVLioYqJY7PNuc7zgH3r5GE2p/bEAjP2obsmKQGwRflC5crjTZn1lRNAZrL126Ilj25tQLL1wlgMs22Tqx4KPAwidZRf1KesnmvIPEMYq99BQEiJaLmX8l7PZEdPpfMWwn1/XrZxhxFLT7qFq2nOWg7xia6C/jLrWhYYAu9UwhIO6xdoAUFLOfJrdMX1jz/yp90xF21lecDk5gLMddWjpeiOcAiPQeiKKeRYqywFKV5uERzGrPhfgIzDQnqt01QlYG5kaNhReZUsjNzuh6kjlb9mfXBjpxoG6NDb3QjtWnTWIWZYxnQli7+62i4khipIRMsJSizkYiYXPo99JtEh8LRQz0hsBG8MP0quWbgz7xQZJ2GgUuSpr+ezzQv1+2BaJu/Ezu6iynIzmyQLNEFgiwzpcbcJRDfqPwzPma+WtzE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17287e2-33a4-4b09-7e0e-08d691751daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 05:35:51.4074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGFsIHBpbmcuLi4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiAyMDE5xOoy
1MI3yNUgMTc6NTMNCj4gVG86IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5j
b207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBjYXRhbGluLm1hcmluYXNA
YXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgcnVpLnpoYW5nQGludGVsLmNvbTsNCj4gZWR1
YmV6dmFsQGdtYWlsLmNvbTsgZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgQWlzaGVuZyBEb25n
DQo+IDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IERhbmll
bCBCYWx1dGENCj4gPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IGhvcm1zK3JlbmVzYXNAdmVyZ2Uu
bmV0LmF1OyBBbmR5IEdyb3NzDQo+IDxhbmR5Lmdyb3NzQGxpbmFyby5vcmc+OyBoZWlrb0BzbnRl
Y2guZGU7IGFybmRAYXJuZGIuZGU7DQo+IG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb207IGphZ2Fu
QGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgZW5y
aWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsNCj4gbWFyYy53LmdvbnphbGV6QGZyZWUuZnI7IG9s
b2ZAbGl4b20ubmV0OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC0NCj4gcG1Admdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlt
eEBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0ggVjYgMS80XSBkdC1iaW5kaW5nczogZnNsOiBz
Y3U6IGFkZCB0aGVybWFsIGJpbmRpbmcNCj4gDQo+IE5YUCBpLk1YOFFYUCBpcyBhbiBBUk12OCBT
b0Mgd2l0aCBhIENvcnRleC1NNCBjb3JlIGluc2lkZSBhcyBzeXN0ZW0NCj4gY29udHJvbGxlciwg
dGhlIHN5c3RlbSBjb250cm9sbGVyIGlzIGluIGNoYXJnZSBvZiBzeXN0ZW0gcG93ZXIsIGNsb2Nr
IGFuZA0KPiB0aGVybWFsIHNlbnNvcnMgZXRjLiBtYW5hZ2VtZW50LCBMaW51eCBrZXJuZWwgaGFz
IHRvIGNvbW11bmljYXRlIHdpdGgNCj4gc3lzdGVtIGNvbnRyb2xsZXIgdmlhIE1VIChtZXNzYWdl
IHVuaXQpIElQQyB0byBnZXQgdGVtcGVyYXR1cmUgZnJvbSB0aGVybWFsDQo+IHNlbnNvcnMsIHRo
aXMgcGF0Y2ggYWRkcyBiaW5kaW5nIGRvYyBmb3IgaS5NWCBzeXN0ZW0gY29udHJvbGxlciB0aGVy
bWFsDQo+IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5I
dWFuZ0BueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gLS0tDQo+IENoYW5nZUxvZyBzaW5jZSBWNToNCj4gCS0gYWRkICJpbXgsc2Vuc29yLXJl
c291cmNlLWlkIiBpbiBlYWNoIHRoZXJtYWwgem9uZSB0byBwYXNzIHJlc291cmNlDQo+IElEIGZv
ciB0aGVybWFsIGRyaXZlci4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICAgIHwgMjANCj4gKysrKysrKysrKysrKysrKysrKysNCj4g
IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQN
Cj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2ws
c2N1LnR4dA0KPiBpbmRleCA3MmQ0ODFjLi40Yjc5NzUxIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2ws
c2N1LnR4dA0KPiBAQCAtMTIyLDYgKzEyMiwyMCBAQCBSVEMgYmluZGluZ3MgYmFzZWQgb24gU0NV
IE1lc3NhZ2UgUHJvdG9jb2wNCj4gUmVxdWlyZWQgcHJvcGVydGllczoNCj4gIC0gY29tcGF0aWJs
ZTogc2hvdWxkIGJlICJmc2wsaW14OHF4cC1zYy1ydGMiOw0KPiANCj4gK1RoZXJtYWwgYmluZGlu
Z3MgYmFzZWQgb24gU0NVIE1lc3NhZ2UgUHJvdG9jb2wNCj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICtSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KPiArLSBjb21wYXRpYmxlIDogTXVzdCBiZSAiZnNsLGlteDhxeHAtc2Mt
dGhlcm1hbCI7DQo+ICstIHRzZW5zLW51bSA6IFRvdGFsIG51bWJlciBvZiB0aGVybWFsIHNlbnNv
cnMgc3VwcG9ydGVkOw0KPiArLSAjdGhlcm1hbC1zZW5zb3ItY2VsbHMgOiBTaG91bGQgYmUgMS4g
U2VlDQo+ICsNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RoZXJtYWwvdGhl
cm1hbC50eHQNCj4gKwkJCSAgZm9yIGEgZGVzY3JpcHRpb24uDQo+ICstIGlteCxzZW5zb3ItcmVz
b3VyY2UtaWQgOiBUaGlzIHByb3BlcnR5IHNob3VsZCBiZSBkZWZpbmVkIGluIGVhY2ggdGhlcm1h
bA0KPiB6b25lDQo+ICsJCQkgICBvZiB0aGVybWFsLXpvbmVzIG5vZGUsIGl0IHBhc3NlcyBlYWNo
IHRoZXJtYWwNCj4gem9uZSdzDQo+ICsJCQkgICByZXNvdXJjZSBpZCBmb3IgdGhlcm1hbCBkcml2
ZXIgdG8gZ2V0IHRlbXBlcmF0dXJlDQo+IHZpYQ0KPiArCQkJICAgU0NVIElQQy4NCj4gKw0KPiAg
RXhhbXBsZSAoaW14OHF4cCk6DQo+ICAtLS0tLS0tLS0tLS0tDQo+ICBsc2lvX211MTogbWFpbGJv
eEA1ZDFjMDAwMCB7DQo+IEBAIC0xNjgsNiArMTgyLDEyIEBAIGZpcm13YXJlIHsNCj4gIAkJcnRj
OiBydGMgew0KPiAgCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy1ydGMiOw0KPiAgCQl9
Ow0KPiArDQo+ICsJCXRzZW5zOiB0aGVybWFsLXNlbnNvciB7DQo+ICsJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg4cXhwLXNjLXRoZXJtYWwiOw0KPiArCQkJdHNlbnMtbnVtID0gPDE+Ow0KPiArCQkJ
I3RoZXJtYWwtc2Vuc29yLWNlbGxzID0gPDE+Ow0KPiArCQl9Ow0KPiAgCX07DQo+ICB9Ow0KPiAN
Cj4gLS0NCj4gMi43LjQNCg0K
