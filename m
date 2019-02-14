Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C03C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837932089F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Asgmg/HC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395455AbfBNDrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:47:25 -0500
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:46912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387562AbfBNDrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjNIB7CI77rzizTNpeOWuQY+pSQD/T/8IAOX2kstVeQ=;
 b=Asgmg/HCOX5ld/QTp7nRU4WSRFWDW6QhYaVYX5FPKRAmQRgsgadGQgbuW3qb3rOiV8bPndAFpq2Ycc1vRxiA3Cfk2dyy+ESQW8gWf4b4bsTf0erFN4KAGZZF7RLZWd6PL13QWefeon1fCNuo4/cS66r+hqm3AC09CcQn8o5QdPk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 03:47:19 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 03:47:19 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/3] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH 1/3] dt-bindings: fsl: scu: add general interrupt support
Thread-Index: AQHUsvHOk0zMHq5joEWG3q1+7cErPKXcOd5wgAKPjXA=
Date:   Thu, 14 Feb 2019 03:47:19 +0000
Message-ID: <DB3PR0402MB391645B7AF7B9F81EECABA18F5670@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
 <DB3PR0402MB3916FECAC4645C2B12FAB65EF5650@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916FECAC4645C2B12FAB65EF5650@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6933431d-4723-4862-e958-08d6922f1eb3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM2NzU7MjM6M3FFdEVhSU1RVFFFR0w1ZjhENEZEN2l5?=
 =?gb2312?B?aEJIWmVOVUd4TFdOdEhHVXhKWDFvZkJ1RWVMc3JWMlY4S2FKTDhOQ1JhbmFh?=
 =?gb2312?B?LzEydTE5RXU5U2R5MUxTNlVLOGNGaU5yN2xzZlZ6MjBjb0RCdTBBMUFyYzVq?=
 =?gb2312?B?Q0VnSFlPK1R5VFFraWFreUNSanBqamR2ZjFEclhmOEFielRvVzd2TFN2NWIr?=
 =?gb2312?B?Zlp1ZndyN2gxcTZGNEFvRnJhQ3JhVTRab2U4MGZKZDh6U2JnbE15bWMwdkNt?=
 =?gb2312?B?QlhLT0NncE9wRFZiWm9EcE85MUUvalp5eVZFVml3dXN2Y0VtbStTZW1YSUhw?=
 =?gb2312?B?dks1SlZpNDNkYlJpczVISUQwZ09aSU02OFNGeXo2NUpsVEtJcW1KMXdpRVJT?=
 =?gb2312?B?VHI2K3hMRFIza3YvSXNDVms5T2xFb2JvRjRUdDd2RTJ0ZURVUmRScDJXc3ph?=
 =?gb2312?B?cUpIR3B3NVIvWHNJSjVUd2RaR0x2alBXL0xleXNIQXVDZXduTDcxNTJGbnhV?=
 =?gb2312?B?dmJ4WmFlZGdnRjVMSDFzb29JWnE0b3VnUWxzUjQ4dFI0bkFzRzB1d2JqOXBa?=
 =?gb2312?B?RlNpN0NiRjI1SGZLazgxMFdScGRVQWxMUjk0elZYeDZTaG9qbm1CQXpIWFAv?=
 =?gb2312?B?SGkyazkrcERyMDJWN3hzSUROR1BKS0hORjVhSkVMajRCTTUyWkFBMEVMS0xN?=
 =?gb2312?B?d1Z6alQ3WEJ0MmlYQWZiSUJha1d4TVNINkVhR2lic2VUUUxZbWp3dU5uQ05H?=
 =?gb2312?B?TnkxUFBHQy9oc09ZYlQ0YTJRNklPZGk5VmtBYjlaT0N2aVp2NlV5L1RBblpK?=
 =?gb2312?B?Q1oySXZwRVhMWVgyTjk2TTBVOXNkdlRaZTN5N0JwUXA5L29hSE1OL3hoVjFQ?=
 =?gb2312?B?WS9oK0VUT05QdnRIU2RIUVVUZC90ZEpsSi9DQWgweFl5U3cycVlWY3d5VEFn?=
 =?gb2312?B?U3dmYUFCVS9Pd2pOV1gvUVQ0ZDhDYjVZaWxDWHFRVTFpQWZTYkJTME4wUzdR?=
 =?gb2312?B?VnZyRldwS1lnS3ZJVURtRjFtSjExOFRncEh5ai9UbzAyTTEwT0FkS1Y4QU5s?=
 =?gb2312?B?NEhCWUN2REtMbVRPZVdHL0l0V2JSMEl2VXdxbXBSbWZKOGVHbzRzcUZXWDR6?=
 =?gb2312?B?ZHFpdk9kTlJpWHFJZWo2NDFaaU9VbTFXQlFCRmNHcSs2ZGduWDBrL3pXakpJ?=
 =?gb2312?B?N0xtNnE3VEJ6OHJOSmd6d3h0YUJkZ0xuSlJialk0N1BnMTBDZlpNTzBZTmZP?=
 =?gb2312?B?bGpzQmNPZ2h2SlFLV0NZa3lQRDJHSS90S3ZiNWQ4RndueEFNaWNCOE1EaHpT?=
 =?gb2312?B?RWJlUHk0NEhwS2xEcTJodHNUc2FXVm1rMzhkSDR3TFBvaEFSaTZhMFZ0M2s4?=
 =?gb2312?B?ZmMvQXdqZlVHY1lCM0pNUkpmVkQ1Y3UxYURqdk9wSnpwOGRUVjAwaHdHaVlr?=
 =?gb2312?B?NnRvZVlPTSthaXdHVWdRbUQrQmcyMFp0RnJIS3dOaHYveFpxcUFDbE9OVGha?=
 =?gb2312?B?elQ2VXhuTjJhKzZ3S1JYWkFyOGg0UDR1T2wySE56aDVHeFFPbGxRQzgxVFZN?=
 =?gb2312?B?L0wzeUE0NGdhNkZ6MDlQVmRyWlFwSUFLcXpRNDBWWnh4Y3BmSWdFbUg5cGkw?=
 =?gb2312?B?WGZhOCt2RGo1RkhUdWpOdmNDQjFVbEE2eTNmVWZrYVIvdkJSVUs3bW0xR2Vo?=
 =?gb2312?B?SGdrL01SSFpjV28wUHRvY01wcUM5S21zYzZlQ3Z5QTZuSjhVRkIzQkFpSlUx?=
 =?gb2312?Q?dgwQsYy30yvVk9E6XpwnHfCBicTaM89HLYmq++M=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3675B27396C81103C6586BDBF5670@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(346002)(39860400002)(199004)(189003)(13464003)(76176011)(486006)(97736004)(4326008)(53936002)(6246003)(256004)(305945005)(3846002)(74316002)(229853002)(9686003)(14444005)(2906002)(476003)(106356001)(446003)(2201001)(8936002)(6116002)(14454004)(11346002)(68736007)(44832011)(71190400001)(71200400001)(478600001)(81166006)(7736002)(7696005)(86362001)(81156014)(8676002)(7416002)(55016002)(105586002)(186003)(33656002)(26005)(6506007)(25786009)(6436002)(102836004)(110136005)(316002)(99286004)(2501003)(66066001)(53546011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a66pHAkGafWY/eJ0KhPBMpAJURhSKZEfVXxCWTGlU0CmWWozgteDSwTpDz9wQ3+4kVfjAqx08+fFBzqE9/nR2Jwsh34VQZMuaC+lZ6qeaVz0QyrYdpw3DfxWMB4aRggADzSrH/30etNW59UrD0/mWv6YAACu63gjSn2dN8cc0oMPU2aRf6wXJFDDLE2Fdx2MvZFpYiOs007kWpXaz+ph9PKhmw2ZLHlN2Y5Ujo408D9oe0RcBuL21ksn/Wj8wyTsdiAXnbeR84noXBMobzYPmL0j8fkJzcESwsWBkw5YjYoQf5h7KCqjzIWdYaXcg5ybC7lXP3X1aSS6G67XDFOcpftoU2rFK2yV2+W/yZy7e1dq906rTv84J6h+o/1m3CKydcFTXFSFCG4n5TDdfx4qeizsklR9dEMbOeM5fZVGjGs=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6933431d-4723-4862-e958-08d6922f1eb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 03:47:19.5148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBqdXN0IHVwZGF0ZSB0aGUgcGF0Y2ggc2VyaWVzIGFuZCBhbHNvIGFkZCBSVEMgYWxhcm0gc3Vw
cG9ydCB0byB1c2UgaS5NWCBTQ1UgZ2VuZXJhbCBpbnRlcnJ1cHQgYXMgYW4gZXhhbXBsZSwgYmVj
YXVzZSBSVEMgYWxhcm0gcGF0Y2ggZGVwZW5kcyBvbiBpdCwgc28gSSBzZW50IHRoZW0gdG9nZXRo
ZXIgaW4gT05FIHBhdGggc2VyaWVzLCBwbGVhc2UganVzdCBoZWxwIHJldmlldyB0aGUgVjIgcGF0
Y2ggc2VyaWVzLCB0aGFua3MuDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5zb24gSHVhbmcNCj4gU2VudDogMjAx
OcTqMtTCMTLI1SAyMDozOQ0KPiBUbzogcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRA
YXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsg
a2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IEFpc2hlbmcgRG9u
ZyA8YWlzaGVuZy5kb25nQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBEYW5pZWwN
Cj4gQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNv
bT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiBmc2w6IHNjdTogYWRk
IGdlbmVyYWwgaW50ZXJydXB0IHN1cHBvcnQNCj4gDQo+IEdlbnRsZSBwaW5nLi4uDQo+IA0KPiBC
ZXN0IFJlZ2FyZHMhDQo+IEFuc29uIEh1YW5nDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gRnJvbTogQW5zb24gSHVhbmcNCj4gPiBTZW50OiAyMDE5xOox1MIyM8jVIDE2
OjAxDQo+ID4gVG86IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207IHNo
YXduZ3VvQGtlcm5lbC5vcmc7DQo+ID4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+ID4gQWlzaGVuZyBEb25nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IERhbmllbA0KPiA+IEJh
bHV0YSA8ZGFuaWVsLmJhbHV0YUBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LQ0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiA+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
Pg0KPiA+IFN1YmplY3Q6IFtQQVRDSCAxLzNdIGR0LWJpbmRpbmdzOiBmc2w6IHNjdTogYWRkIGdl
bmVyYWwgaW50ZXJydXB0DQo+ID4gc3VwcG9ydA0KPiA+DQo+ID4gQWRkIHNjdSBnZW5lcmFsIGlu
dGVycnVwdCBmdW5jdGlvbiBzdXBwb3J0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQgICAgICB8IDE4ICsrKysrKysrKysr
Ky0tLS0tDQo+IC0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDYgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiBp
bmRleCBmZDJiZWQyLi4zYzk3NmFjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQN
Cj4gPiBAQCAtMjIsOSArMjIsMTEgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+ICAtIGNvbXBhdGlibGU6CXNob3VsZCBiZSAiZnNsLGlteC1zY3Ui
Lg0KPiA+ICAtIG1ib3gtbmFtZXM6CXNob3VsZCBpbmNsdWRlICJ0eDAiLCAidHgxIiwgInR4MiIs
ICJ0eDMiLA0KPiA+IC0JCQkgICAgICAgInJ4MCIsICJyeDEiLCAicngyIiwgInJ4MyIuDQo+ID4g
LS0gbWJveGVzOglMaXN0IG9mIHBoYW5kbGUgb2YgNCBNVSBjaGFubmVscyBmb3IgdHggYW5kIDQg
TVUgY2hhbm5lbHMNCj4gPiAtCQlmb3IgcnguIEFsbCA4IE1VIGNoYW5uZWxzIG11c3QgYmUgaW4g
dGhlIHNhbWUgTVUgaW5zdGFuY2UuDQo+ID4gKwkJCSAgICAgICAicngwIiwgInJ4MSIsICJyeDIi
LCAicngzIiwNCj4gPiArCQkJICAgICAgICJnaTMiLg0KPiA+ICstIG1ib3hlczoJTGlzdCBvZiBw
aGFuZGxlIG9mIDQgTVUgY2hhbm5lbHMgZm9yIHR4LCA0IE1VIGNoYW5uZWxzIGZvcg0KPiA+ICsJ
CXJ4LCBhbmQgMSBNVSBjaGFubmVsIGZvciBnZW5lcmFsIGludGVycnVwdC4gQWxsIDkgTVUgY2hh
bm5lbHMNCj4gPiArCQltdXN0IGJlIGluIHRoZSBzYW1lIE1VIGluc3RhbmNlLg0KPiA+ICAJCUNy
b3NzIGluc3RhbmNlcyBhcmUgbm90IGFsbG93ZWQuIFRoZSBNVSBpbnN0YW5jZSBjYW4gb25seQ0K
PiA+ICAJCWJlIG9uZSBvZiBMU0lPIE1VMH5NNCBmb3IgaW14OHF4cCBhbmQgaW14OHFtLiBVc2Vy
cw0KPiBuZWVkDQo+ID4gIAkJdG8gbWFrZSBzdXJlIHVzZSB0aGUgb25lIHdoaWNoIGlzIG5vdCBj
b25mbGljdCB3aXRoIG90aGVyIEBADQo+ID4gLTM0LDYgKzM2LDcgQEAgUmVxdWlyZWQgcHJvcGVy
dGllczoNCj4gPiAgCQlDaGFubmVsIDEgbXVzdCBiZSAidHgxIiBvciAicngxIi4NCj4gPiAgCQlD
aGFubmVsIDIgbXVzdCBiZSAidHgyIiBvciAicngyIi4NCj4gPiAgCQlDaGFubmVsIDMgbXVzdCBi
ZSAidHgzIiBvciAicngzIi4NCj4gPiArCQlHZW5lcmFsIGludGVycnVwdCBjaGFubmVsIG11c3Qg
YmUgImdpMyIuDQo+ID4gIAkJZS5nLg0KPiA+ICAJCW1ib3hlcyA9IDwmbHNpb19tdTEgMCAwDQo+
ID4gIAkJCSAgJmxzaW9fbXUxIDAgMQ0KPiA+IEBAIC00Miw3ICs0NSw4IEBAIFJlcXVpcmVkIHBy
b3BlcnRpZXM6DQo+ID4gIAkJCSAgJmxzaW9fbXUxIDEgMA0KPiA+ICAJCQkgICZsc2lvX211MSAx
IDENCj4gPiAgCQkJICAmbHNpb19tdTEgMSAyDQo+ID4gLQkJCSAgJmxzaW9fbXUxIDEgMz47DQo+
ID4gKwkJCSAgJmxzaW9fbXUxIDEgMw0KPiA+ICsJCQkgICZsc2lvX211MSAzIDM+Ow0KPiA+ICAJ
CVNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9mc2wsbXUudHh0
DQo+ID4gIAkJZm9yIGRldGFpbGVkIG1haWxib3ggYmluZGluZy4NCj4gPg0KPiA+IEBAIC0xMzAs
NyArMTM0LDggQEAgZmlybXdhcmUgew0KPiA+ICAJc2N1IHsNCj4gPiAgCQljb21wYXRpYmxlID0g
ImZzbCxpbXgtc2N1IjsNCj4gPiAgCQltYm94LW5hbWVzID0gInR4MCIsICJ0eDEiLCAidHgyIiwg
InR4MyIsDQo+ID4gLQkJCSAgICAgInJ4MCIsICJyeDEiLCAicngyIiwgInJ4MyI7DQo+ID4gKwkJ
CSAgICAgInJ4MCIsICJyeDEiLCAicngyIiwgInJ4MyIsDQo+ID4gKwkJCSAgICAgImdpMyI7DQo+
ID4gIAkJbWJveGVzID0gPCZsc2lvX211MSAwIDANCj4gPiAgCQkJICAmbHNpb19tdTEgMCAxDQo+
ID4gIAkJCSAgJmxzaW9fbXUxIDAgMg0KPiA+IEBAIC0xMzgsNyArMTQzLDggQEAgZmlybXdhcmUg
ew0KPiA+ICAJCQkgICZsc2lvX211MSAxIDANCj4gPiAgCQkJICAmbHNpb19tdTEgMSAxDQo+ID4g
IAkJCSAgJmxzaW9fbXUxIDEgMg0KPiA+IC0JCQkgICZsc2lvX211MSAxIDM+Ow0KPiA+ICsJCQkg
ICZsc2lvX211MSAxIDMNCj4gPiArCQkJICAmbHNpb19tdTEgMyAzPjsNCj4gPg0KPiA+ICAJCWNs
azogY2xrIHsNCj4gPiAgCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1jbGsiOw0KPiA+IC0t
DQo+ID4gMi43LjQNCg0K
