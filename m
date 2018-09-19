Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC90ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C772098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 06:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lobTuqMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C772098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731154AbeISLqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:46:43 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:53674
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730951AbeISLqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MHybJYWvttfDnDAkwfN+mTuuo0xJ8Y7J9WIQKjmG+Q=;
 b=lobTuqMCPqyxmZ1urul1vtUcnhzwvw3zoOPyf7zDIDAYzu2akYOHFLtfYBiWahurALlrWkZYfvYiO/742Fg03pi9yvMT+2ZDTXdbiqot+JqndVDn+C/sXMo53X0t0mduXO+LW+LiSKnHGNBuPSRNx2TPZETKxmyoQzsfQ54Jm2Q=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.71.159) by
 DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.72.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 19 Sep 2018 06:10:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1c65:743b:56d0:5aa2%5]) with mapi id 15.20.1143.017; Wed, 19 Sep 2018
 06:10:16 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/4] Add i.MX6ULZ SoC support
Thread-Topic: [PATCH 0/4] Add i.MX6ULZ SoC support
Thread-Index: AQHUTxgyBr1+L8IGckCWXRP0/S23g6T1pvYAgAF5hYA=
Date:   Wed, 19 Sep 2018 06:10:16 +0000
Message-ID: <DB3PR0402MB39162EA4FD240720276A4482F51C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
 <e82e2894-2a0d-0084-913c-b7c6d966fc13@i2se.com>
In-Reply-To: <e82e2894-2a0d-0084-913c-b7c6d966fc13@i2se.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3947;6:D5YgMDYj3jzF6PXu3LliuJ/LDO6P8T1eeyaDW5KT0kp5sp4g0d+AuTKQ4BP5gqIlD3s9zMmaTy/132cUS3uMC+KItCzX/iwImPru3AD1zIK/KrlwfFMVc1Yeo0Wwns7tIJyNMWPjrmZSj3bJtvfqxhtQj7xsqnP9Workoa4aRPhzHFGq3lVIm65WmizSUNBNYZAaaqhXVdECeHIvZU2HfUilnxMeeMDfw2aGLwpV90UadkHg0I0ow7j7TEnwFQYRk6ClH9teWdKajevo8/dRv1SK94JHBbIV2xNmysSGEOX0BhacHBzLewtfAznjPeShU9eWbRWmacO7BxvkSsqUxY9NJzU2vCrVcQ17Eh+BZDfVmRFsbxE3r43WCMsmz6MXMYDVbx8a6aQwr/+EZX19RgsJkRSgBvKXJdnn8AI4LQgZ6y9G5bSR+JV/Nyf7G9xxqIIaefMeozV12u1P5ngtrA==;5:jokCiceAXkZlYJ5hYt/zyKBeni6APDF9qY8Xeku6Fmg8VhBYMIH5wUx3MyjNLODs/GguTS65cV3G0Tu+zkylNpTuXYHcVcgHKabgH0w/Ksh32P0KhgkqJXEjFCZfrz9Yl+LiJUFYNTxcoxoqPcR2uXZqATCCVx58azUZR2c1fzw=;7:VSC8WCmaJVY9O+DNmC+MnKotOtWBblmtH28dnTcht0tx+UL0hn/76a1Pks+d0/+f90HcKm+Hj+DSE3Mft2klRnBG5YeqPqlW95GEjPTizSNcxFaPjaLrz7d0wvRYtKOw/VvGwi7Mt717ZC8fRdg0yOS1kTx+V8HPggsX7koZDT5hg+ILv5efIPSTY/HHoQXVRnlHluhmSA6iwTWn7PfmA3/tN2nQgIk9Wt7LFUxq4t1c4UWnEhtT6xW0WpIOqNRD
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 724fa101-caa1-400d-1a87-08d61df691b0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3947;
x-ms-traffictypediagnostic: DB3PR0402MB3947:
x-microsoft-antispam-prvs: <DB3PR0402MB39471B31DBF81A4826CD49ECF51C0@DB3PR0402MB3947.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(180628864354917)(9452136761055)(185117386973197)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB3PR0402MB3947;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3947;
x-forefront-prvs: 0800C0C167
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(366004)(13464003)(199004)(189003)(33656002)(102836004)(25786009)(4326008)(44832011)(76176011)(6506007)(6116002)(53546011)(7416002)(7736002)(7696005)(446003)(81156014)(486006)(81166006)(106356001)(97736004)(14454004)(8936002)(11346002)(229853002)(26005)(105586002)(3846002)(5660300001)(186003)(74316002)(8676002)(478600001)(66066001)(6436002)(68736007)(2900100001)(305945005)(2501003)(110136005)(5250100002)(6246003)(14444005)(2906002)(256004)(86362001)(9686003)(476003)(316002)(55016002)(2201001)(99286004)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3947;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PT1MFoUZAmM1XFeCFEvTfJR/1FtwAIikgR0FN72UPnLZhsdZcrWkQGk2BDsNboMwEkiWXMDREsvM0t5i9jw4nbxA9p2jUMUCZ+HWEMe/H6IdZgbHc4NIe4PukKq4BrkjtHpKgo9GiNpyuW8F6Kh8ytyHqwOQ54Wskum9eFfS/IHGgBhrNd91tQPjhenPykgDagUUIQxiU7dD88Dv0F1stV1uolKmnFjxHLiO8z0rmKh2blemOUfpW8OGyE9ySLntveVhsZelzXe9lV2rX+NpAbjU/2oOl/DWm1PJOITkajTJQJFC0Hi0uz9T90Cje3bFUVB2+URCULW/HVWoIlY7vuVWDpLCfqgSlAF/JBwh7rA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 724fa101-caa1-400d-1a87-08d61df691b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2018 06:10:16.1600
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3947
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZWZhbg0KDQpBbnNvbiBIdWFuZw0KQmVzdCBSZWdhcmRzIQ0KDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIFdhaHJlbiA8c3RlZmFuLndhaHJlbkBp
MnNlLmNvbT4NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE4LCAyMDE4IDM6MzggUE0NCj4g
VG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgcm9iaCtkdEBrZXJuZWwub3Jn
Ow0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBGYWJpbyBFc3RldmFtIDxm
YWJpby5lc3RldmFtQG54cC5jb20+Ow0KPiBsaW51eEBhcm1saW51eC5vcmcudWs7IG10dXJxdWV0
dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwub3JnOyBKYWNreQ0KPiBCYWkgPHBpbmcuYmFp
QG54cC5jb20+OyBBLnMuIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsNCj4gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9y
Zw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAwLzRdIEFkZCBpLk1YNlVMWiBTb0Mgc3VwcG9ydA0KPiANCj4gSGkgQW5zb24sDQo+
IA0KPiBBbSAxOC4wOS4yMDE4IHVtIDA4OjE5IHNjaHJpZWIgQW5zb24gSHVhbmc6DQo+ID4gVGhp
cyBwYXRjaCBzZXQgYWRkcyBpLk1YNlVMWiBTb0Mgc3VwcG9ydCwgaS5NWDZVTFogaXMgYSBuZXcg
U29DIG9mDQo+ID4gaS5NWDYgZmFtaWx5LCBjb21wYXJlZCB0byBpLk1YNlVMTCwgaXQgcmVtb3Zl
cyBiZWxvdyBtb2R1bGVzOg0KPiA+DQo+ID4gICAgIC0gVUFSVDUvVUFSVDYvVUFSVDcvVUFSVDg7
DQo+ID4gICAgIC0gUFdNNS9QV002L1BXTTcvUFdNODsNCj4gPiAgICAgLSBlQ1NQSTMvZUNTUEk0
Ow0KPiA+ICAgICAtIENBTjEvQ0FOMjsNCj4gPiAgICAgLSBGRUMxL0ZFQzI7DQo+ID4gICAgIC0g
STJDMy9JMkM0Ow0KPiA+ICAgICAtIEVQSVQyOw0KPiA+ICAgICAtIExDRElGOw0KPiA+ICAgICAt
IEdQVDI7DQo+ID4gICAgIC0gVFNDOw0KPiA+DQo+ID4gQW5kIGkuTVg2VUxaIGhhcyBzYW1lIHNv
Y19pZCBhcyBpLk1YNlVMTCwgYnV0IFNSQ19TQk1SMiBiaXRbNl0gaXMgdG8NCj4gPiBkaWZmZXJl
bnRpYXRlIGkuTVg2VUxaIGZyb20gaS5NWDZVTEwsIDEnYjEgbWVhbnMgaS5NWDZVTFogYW5kDQo+
ID4gMSdiMCBtZWFucyBpLk1YNlVMTC4gaS5NWDZVTFogcmV1c2UgbW9zdCBvZiBpLk1YNlVML2ku
TVg2VUxMIGNvZGUsDQo+ID4ganVzdCBhZGQgdGhlIG5ldyBDUFUgdHlwZSBhbmQgcmVtb3ZlIHRo
b3NlIG5vbi1leGlzdCBtb2R1bGVzIGZyb20gZHRiLg0KPiA+DQo+ID4gQW5zb24gSHVhbmcgKDQp
Og0KPiA+ICAgQVJNOiBkdHM6IGlteDogYWRkIGkubXg2dWx6IGFuZCBpLm14NnVseiAxNHgxNCBl
dmsgc3VwcG9ydA0KPiA+ICAgQVJNOiBpbXg6IGFkZCBpLm14NnVseiBtc2wgc3VwcG9ydA0KPiA+
ICAgY2xrOiBpbXg2dWw6IGFkZCBpLm14NnVseiBzdXBwb3J0DQo+ID4gICBkdC1iaW5kaW5nczog
YXJtOiBhZGQgY29tcGF0aWJsZSBmb3IgaS5NWDZVTFogMTR4MTQgRVZLIGJvYXJkDQo+ID4NCj4g
Pg0KPiANCj4gaSByZWNvbW1lbmQgdGhlIGZvbGxvd2luZyBwYXRjaCBvcmRlcjoNCj4gQVJNOiBp
bXg6IGFkZCBpLm14NnVseiBtc2wgc3VwcG9ydA0KPiBjbGs6IGlteDZ1bDogYWRkIGkubXg2dWx6
IHN1cHBvcnQNCj4gZHQtYmluZGluZ3M6IGFybTogYWRkIGNvbXBhdGlibGUgZm9yIGkuTVg2VUxa
IDE0eDE0IEVWSyBib2FyZA0KPiBBUk06IGR0czogaW14OiBhZGQgaS5teDZ1bHogYW5kIGkubXg2
dWx6IDE0eDE0IGV2ayBzdXBwb3J0DQo+IA0KPiBTdGVmYW4NCiANClRoYW5rcywgSSByZXNlbmQg
dGhlIFYyIHBhdGNoIHNldCB3aXRoIHRoZSBwYXRjaCBvcmRlciB5b3UgcmVjb21tZW5kZWQuDQoN
CkFuc29uLg0KDQo=
