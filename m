Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F07AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B23214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C42cE67s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfBLMjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:39:01 -0500
Received: from mail-eopbgr150053.outbound.protection.outlook.com ([40.107.15.53]:18969
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728413AbfBLMjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YtpZeWCAOvn1ru8dT3ZZ4KF1cEfLxMB1PzaY/F1YWY=;
 b=C42cE67sfIWK8tiKCAnrZYp9vBrnPMqwcZJ2nVd34Qa+SMYje38D9yZOc92SOvJyhY4vLdgLNm2csg7s9+fk3vfdjOrRaIMOozWDgbBFNhJEYpaTkv7VEdUPgBMIb6lZIPMN2k8Nr8ey36Wk1mb7JGqEVYNoAQ970ABv/0xp5pU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3659.eurprd04.prod.outlook.com (52.134.66.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 12:38:55 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::14e8:6d2e:fe21:4fd5%3]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 12:38:54 +0000
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
Thread-Index: AQHUsvHOk0zMHq5joEWG3q1+7cErPKXcOd5w
Date:   Tue, 12 Feb 2019 12:38:54 +0000
Message-ID: <DB3PR0402MB3916FECAC4645C2B12FAB65EF5650@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1548230179-26076-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3659;6:IwjFSc5wPbrMWcCIeQMgA1MaF39M0YANAXs40UfAxyvm0H3Trag2AICLn51sAPe9ZQ/f1aNxSDC3ZlTd+QFqhhxDgTtIqqTRNhu4yC1FqUjoy8NHHOuVo9ThfeJS3ceahcmsUcTvu8bezloUNLcvXsql380CbqiRX4qYc/wPgXH0wkYD5OKg11QqRc6GtAsyVoUQ0yXaA8GFvJMgyzFwr9sLYlFLjX+GmtpwK1m3Ta95NkVhwRvtnsb+20H4eDCvdaeu6gOHrpAJWmnkRH4zwHd6OlhE82BfDcvZQyKehH6VdJJta8xVnex36EvaikBDZOAEHrVWnLFEhavliRkreiBf8540FhGAfQK3j3HkZfv4z5XyYu04qH9r0Ui7h8uZUq5WanJ0kvxEiIt2eGJRl2NzdX5GuWvZI4oV+leFZvPlGBM246tGEL3ijVbsf9XLkmFVDVhtLRYbJiYDYYZbAg==;5:MbtYsMV1jzv0RPMygnxVHUxq0jMolz5ACRQsYFM9ZxSKnB0Rlbmxn0Mfuqa8REu8eMtosefxAhUzihSQTRMIFf4aDG2gG+ngp1cl8OECgs1Js7atl1eVmcIpen0ZTkEozs1Ytrn6U0UTzKJVCnkveslsRMrJ9hr8/MD6S8nsu1ztZS6eQpo57Jb/V4FLvTqiriSlfjDb9B3OCldSwRfXNg==;7:aUVVg6X0NHmOEu5U5k9u4WrWxK9e5NyhpunHKPZurgw+emtuBS4pFIQQd/ctt/YBShpR2umeCsyi7H+X1b2cKCOVsxZVaA6v7+OaEy3OJch1NKw2GEXmrZOi/QDtgtD+J6G0Ia1jdGpaEhuVceELWQ==
x-ms-office365-filtering-correlation-id: bc17ad70-54a3-465d-29a6-08d690e70cf6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3659;
x-ms-traffictypediagnostic: DB3PR0402MB3659:
x-microsoft-antispam-prvs: <DB3PR0402MB3659241C14399E5E9F6BEF83F5650@DB3PR0402MB3659.eurprd04.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(13464003)(189003)(199004)(4326008)(71200400001)(7736002)(186003)(33656002)(71190400001)(7696005)(446003)(6246003)(11346002)(74316002)(44832011)(476003)(486006)(25786009)(76176011)(97736004)(305945005)(3846002)(53936002)(6116002)(2906002)(68736007)(66066001)(2501003)(55016002)(110136005)(102836004)(316002)(8936002)(81156014)(8676002)(9686003)(14454004)(106356001)(7416002)(256004)(86362001)(6436002)(26005)(229853002)(105586002)(478600001)(6506007)(53546011)(81166006)(99286004)(2201001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3659;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +vjhuQRwsW4g2KCVhBP9v3lJjdHH+3tgTErZ1tc3YDIxznLgI8QvVjpdMCrZWag9+ENCDkZTegbw6QZ12ZJX7KZ/1olKZkOzdP0PylFaB7oc/+b2QfQUEpUAFL9nd2UagbXj3UZBRPyedai7QeLVZHm7f0mHkbp4pbumeFLiBF+upwNY/4MJIDnjyiO3EbxGua72AgLcNCMlChqF0URvT32Wl0pmWSkPntnb3+6D8OGWBWkW846y74UJNeS/0oXXc+h+DbIH3V4s0SP7hJ4YpF62iggSVYNmdWXkSeUhSl1JMbP6/i0Kt7qK6qYLd8NhErTQEu4UgbHarQAqPa/fihYxIGK1ILd1GK3MGYZHsZthBujR44mk2/oxwZEOLH3YjC59JGeE1Lvf08CBn2Eb/f1muPYwGmO7QOA1IwZ8B78=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc17ad70-54a3-465d-29a6-08d690e70cf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 12:38:54.7667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VudGxlIHBpbmcuLi4NCg0KQmVzdCBSZWdhcmRzIQ0KQW5zb24gSHVhbmcNCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiAyMDE5xOox
1MIyM8jVIDE2OjAxDQo+IFRvOiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0u
Y29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJu
ZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gQWlzaGVuZyBEb25nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IERhbmllbA0KPiBC
YWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0ggMS8zXSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCBnZW5lcmFs
IGludGVycnVwdCBzdXBwb3J0DQo+IA0KPiBBZGQgc2N1IGdlbmVyYWwgaW50ZXJydXB0IGZ1bmN0
aW9uIHN1cHBvcnQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVh
bmdAbnhwLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxzY3UudHh0ICAgICAgfCAxOCArKysrKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxz
Y3UudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2Nh
bGUvZnNsLHNjdS50eHQNCj4gaW5kZXggZmQyYmVkMi4uM2M5NzZhYyAxMDA2NDQNCj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50
eHQNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2Nh
bGUvZnNsLHNjdS50eHQNCj4gQEAgLTIyLDkgKzIyLDExIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6
DQo+ICAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAtIGNvbXBhdGlibGU6CXNob3VsZCBiZSAiZnNs
LGlteC1zY3UiLg0KPiAgLSBtYm94LW5hbWVzOglzaG91bGQgaW5jbHVkZSAidHgwIiwgInR4MSIs
ICJ0eDIiLCAidHgzIiwNCj4gLQkJCSAgICAgICAicngwIiwgInJ4MSIsICJyeDIiLCAicngzIi4N
Cj4gLS0gbWJveGVzOglMaXN0IG9mIHBoYW5kbGUgb2YgNCBNVSBjaGFubmVscyBmb3IgdHggYW5k
IDQgTVUgY2hhbm5lbHMNCj4gLQkJZm9yIHJ4LiBBbGwgOCBNVSBjaGFubmVscyBtdXN0IGJlIGlu
IHRoZSBzYW1lIE1VIGluc3RhbmNlLg0KPiArCQkJICAgICAgICJyeDAiLCAicngxIiwgInJ4MiIs
ICJyeDMiLA0KPiArCQkJICAgICAgICJnaTMiLg0KPiArLSBtYm94ZXM6CUxpc3Qgb2YgcGhhbmRs
ZSBvZiA0IE1VIGNoYW5uZWxzIGZvciB0eCwgNCBNVSBjaGFubmVscyBmb3INCj4gKwkJcngsIGFu
ZCAxIE1VIGNoYW5uZWwgZm9yIGdlbmVyYWwgaW50ZXJydXB0LiBBbGwgOSBNVSBjaGFubmVscw0K
PiArCQltdXN0IGJlIGluIHRoZSBzYW1lIE1VIGluc3RhbmNlLg0KPiAgCQlDcm9zcyBpbnN0YW5j
ZXMgYXJlIG5vdCBhbGxvd2VkLiBUaGUgTVUgaW5zdGFuY2UgY2FuIG9ubHkNCj4gIAkJYmUgb25l
IG9mIExTSU8gTVUwfk00IGZvciBpbXg4cXhwIGFuZCBpbXg4cW0uIFVzZXJzDQo+IG5lZWQNCj4g
IAkJdG8gbWFrZSBzdXJlIHVzZSB0aGUgb25lIHdoaWNoIGlzIG5vdCBjb25mbGljdCB3aXRoIG90
aGVyIEBADQo+IC0zNCw2ICszNiw3IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAJCUNoYW5u
ZWwgMSBtdXN0IGJlICJ0eDEiIG9yICJyeDEiLg0KPiAgCQlDaGFubmVsIDIgbXVzdCBiZSAidHgy
IiBvciAicngyIi4NCj4gIAkJQ2hhbm5lbCAzIG11c3QgYmUgInR4MyIgb3IgInJ4MyIuDQo+ICsJ
CUdlbmVyYWwgaW50ZXJydXB0IGNoYW5uZWwgbXVzdCBiZSAiZ2kzIi4NCj4gIAkJZS5nLg0KPiAg
CQltYm94ZXMgPSA8JmxzaW9fbXUxIDAgMA0KPiAgCQkJICAmbHNpb19tdTEgMCAxDQo+IEBAIC00
Miw3ICs0NSw4IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ICAJCQkgICZsc2lvX211MSAxIDAN
Cj4gIAkJCSAgJmxzaW9fbXUxIDEgMQ0KPiAgCQkJICAmbHNpb19tdTEgMSAyDQo+IC0JCQkgICZs
c2lvX211MSAxIDM+Ow0KPiArCQkJICAmbHNpb19tdTEgMSAzDQo+ICsJCQkgICZsc2lvX211MSAz
IDM+Ow0KPiAgCQlTZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gv
ZnNsLG11LnR4dA0KPiAgCQlmb3IgZGV0YWlsZWQgbWFpbGJveCBiaW5kaW5nLg0KPiANCj4gQEAg
LTEzMCw3ICsxMzQsOCBAQCBmaXJtd2FyZSB7DQo+ICAJc2N1IHsNCj4gIAkJY29tcGF0aWJsZSA9
ICJmc2wsaW14LXNjdSI7DQo+ICAJCW1ib3gtbmFtZXMgPSAidHgwIiwgInR4MSIsICJ0eDIiLCAi
dHgzIiwNCj4gLQkJCSAgICAgInJ4MCIsICJyeDEiLCAicngyIiwgInJ4MyI7DQo+ICsJCQkgICAg
ICJyeDAiLCAicngxIiwgInJ4MiIsICJyeDMiLA0KPiArCQkJICAgICAiZ2kzIjsNCj4gIAkJbWJv
eGVzID0gPCZsc2lvX211MSAwIDANCj4gIAkJCSAgJmxzaW9fbXUxIDAgMQ0KPiAgCQkJICAmbHNp
b19tdTEgMCAyDQo+IEBAIC0xMzgsNyArMTQzLDggQEAgZmlybXdhcmUgew0KPiAgCQkJICAmbHNp
b19tdTEgMSAwDQo+ICAJCQkgICZsc2lvX211MSAxIDENCj4gIAkJCSAgJmxzaW9fbXUxIDEgMg0K
PiAtCQkJICAmbHNpb19tdTEgMSAzPjsNCj4gKwkJCSAgJmxzaW9fbXUxIDEgMw0KPiArCQkJICAm
bHNpb19tdTEgMyAzPjsNCj4gDQo+ICAJCWNsazogY2xrIHsNCj4gIAkJCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtY2xrIjsNCj4gLS0NCj4gMi43LjQNCg0K
