Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0FEC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6037C2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 01:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m5X/pxFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6037C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKILG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 06:06:58 -0500
Received: from mail-ve1eur01on0076.outbound.protection.outlook.com ([104.47.1.76]:33136
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727157AbeKILG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 06:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUXzomLYhkqjx8swvMfh3GqRrlwbbWKQNiOP1cPZgwc=;
 b=m5X/pxFP62VKOFZZK+sqtzBIhiMK0x67vV5YULDCexNPVdp13fw0HTNr4PiEQdIuD9BqXkOp8Dj151o+rrWHbGm5TpJKP34VogA0NowdtfURNRkzWUK+YFPMeaHH/IYGLZihnGLu6q69OTiSEv5/5NoaT5WC6B1v3j5dJCI/Rr4=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Fri, 9 Nov 2018 01:27:54 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e992:8455:42e:7a0b%2]) with mapi id 15.20.1294.034; Fri, 9 Nov 2018
 01:27:54 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Topic: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
Thread-Index: AQHUdllc2yTfT4Rj4kWlQDRFrtQfPqVEFXiAgAEAYuCAABDCgIAAAX8ggADdLICAAKTAwA==
Date:   Fri, 9 Nov 2018 01:27:54 +0000
Message-ID: <DB3PR0402MB3916021FA80AE9C236537281F5C60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
 <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com>
 <DB3PR0402MB3916B027A9C724D349C7969EF5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAOMZO5CPZKqJdTPzZDw=19HW_YCg_JGvLpw9i3iKsi+EJF-yNg@mail.gmail.com>
In-Reply-To: <CAOMZO5CPZKqJdTPzZDw=19HW_YCg_JGvLpw9i3iKsi+EJF-yNg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3737;6:sR7KMMYHNEQoj2/TDldhTC+VgvCu3cWQ+ORf9cDS2ggwbmH5981liOngm/zuvNz8siOxK3VMVy0VhkXdJMTxe2YI4ZAqDs7qNByvp2y2FdtwlPHMSMGlUVxRWOJF/LQGy1YGJazBG03sfHL/q3PfrUJEdDNWP/A7yvCjFr7hjed8DD6D+Nkn28umvlOgOf5WNpRcS5d0mHS8PMx4Wd/7PmFwPX7ZtIgiEE5btE5yTccTX6Gcz0YBspWeGOs3AJPv96ZoWp/cJh33+mt3gYRJtuS079J8qySgMrOd0jxC14NfZ3cgeh1SXDuV+dbRm1XfJrWM9M+7ob8dJJgh17K9tLVIWxy3ifOzMUgpPpK+esoyMPTas/+Y1vKgp3PF/kc2oE3K+8jP1aekCwv9V+QK4j0gtRy8RKjLMD0TSRG4Gsuf42AOrkds2km4YrHcPqmZoxaMyzKzFPyo11wCzhMvGQ==;5:6wHSZX+V3pQEpNqXentxdN5J3fx8botq4aYtR9VLHkCoaAUkgcoRq65tC90QesulyaincW9/jRiUlz1qLjEu0zTtep9qwCoVrUaWllW4Dh1SrZwOVqEhLNbercLmRsjalz9dKNvxp8pqBIAB+NqQuAjVN47zq3QWy0MVyRHNuMM=;7:dzD+FMfjwDbvbYGpqwXzbamE5GIxcogAI+OuwzA09Jn/1yKSJBgUw+6ivjutaHLdovW7u6ORBo3/yE8jV+Gz+5BxSf7n0ir7y5MAFcIssSxcEz74TjZ/98aeYV/1Ptl5MdcUgkm8g3n44Gv0ScEPWQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e845ce51-d27e-4064-e025-08d645e292c6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3737;
x-ms-traffictypediagnostic: DB3PR0402MB3737:
x-microsoft-antispam-prvs: <DB3PR0402MB37370635582EE76FFAF66CCDF5C60@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(185117386973197)(180628864354917)(9452136761055)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231382)(944501410)(52105095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3737;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3737;
x-forefront-prvs: 08512C5403
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(39860400002)(396003)(376002)(13464003)(51914003)(199004)(189003)(8936002)(2900100001)(1411001)(229853002)(7736002)(6436002)(256004)(71200400001)(71190400001)(9686003)(3846002)(6116002)(6916009)(478600001)(55016002)(6246003)(305945005)(74316002)(86362001)(81156014)(81166006)(53936002)(44832011)(8676002)(97736004)(102836004)(7696005)(186003)(39060400002)(2906002)(476003)(66066001)(106356001)(26005)(14454004)(105586002)(6506007)(76176011)(53546011)(486006)(4326008)(316002)(99286004)(25786009)(5660300001)(54906003)(11346002)(68736007)(93886005)(33656002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7hv3gzXt8zZad5jxKC/+9e1z5RSbx1SuHB2et/eDBXlOmm8STZgAW7ttBIncCYqCIqv7KZmW7bY8WShyjo0Yml7J1xEHOmtU9T/dx0+p1NOZP97wVKyhP0j/ic84q5/v8Bh3WGF67cY/5IDn7wZRGM0ZoJwZqCH2ApsIQDhVG9G+/CRGU3CT4dNmD306agFN1kzlhoIUSth/irh2uqbNZk7iHr8IeXa20bDKtQNY3KkO7ErE7c2GMHwnoZICFd3m1iWX5aog/wJ7H2fEjkvCzCVpNBNx27JgMFxLuU7nPN+JIdBHWdfaJYOSLwBCO5mOhPctVc6Vurdvl7uSRUsdYS50xwZfLFQ8ncJPPCSJCbk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e845ce51-d27e-4064-e025-08d645e292c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2018 01:27:54.6155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmlvDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSBbbWFpbHRvOmZlc3RldmFtQGdt
YWlsLmNvbV0NCj4gU2VudDogMjAxOOW5tDEx5pyIOOaXpSAyMzozOA0KPiBUbzogQW5zb24gSHVh
bmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJu
ZWwub3JnPjsgTWFyayBSdXRsYW5kDQo+IDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IFNoYXduIEd1
byA8c2hhd25ndW9Aa2VybmVsLm9yZz47IFNhc2NoYQ0KPiBIYXVlciA8cy5oYXVlckBwZW5ndXRy
b25peC5kZT47IFNhc2NoYSBIYXVlciA8a2VybmVsQHBlbmd1dHJvbml4LmRlPjsNCj4gRmFiaW8g
RXN0ZXZhbSA8ZmFiaW8uZXN0ZXZhbUBueHAuY29tPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUg
QU5EDQo+IEZMQVRURU5FRCBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc+OyBsaW51eC1rZXJuZWwNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBtb2RlcmF0ZWQgbGlzdDpBUk0vRlJFRVNDQUxFIElNWCAvIE1YQw0KPiBBUk0gQVJDSElURUNU
VVJFIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBkbC1saW51eC1pbXgN
Cj4gPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0czog
aW14N2Qtc2RiOiBhZGQgcmV2LWEgYm9hcmQgc3VwcG9ydA0KPiANCj4gSGkgQW5zb24sDQo+IA0K
PiBPbiBUaHUsIE5vdiA4LCAyMDE4IGF0IDEyOjMwIEFNIEFuc29uIEh1YW5nIDxhbnNvbi5odWFu
Z0BueHAuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gVGhhbmtzIGZvciBwb2ludGluZyBvdXQgdGhp
cyBpc3N1ZSwgSSBtYWRlIGEgbWlzdGFrZSB3aGVuIGRvaW5nIHRoZSBzZWFyY2ggaW4NCj4gZ2l0
IHJlcG8uLg0KPiA+IFNvLCBpZiB3ZSBoYXZlIHRvIGFzc2VydCBhIEdQSU8sIHRoZXJlIGlzIG5v
IGNvbW1vbiB3YXkgaW4gcGluY3RybA0KPiA+IGRyaXZlcj8gSGF2ZSB0byBkbyBpdCBpbiBkcml2
ZXIgaXRzZWxmPyBMaWtlIHRoaXMgY2FzZSwgd2UgaGF2ZSB0byBhc3NlcnQgdGhlDQo+IEdQSU8g
aW4gZmVjIGRyaXZlcj8NCj4gDQo+IFlvdSBjb3VsZCBwYXNzICJwaHktc3VwcGx5IiBwcm9wZXJ0
eSAgYW5kIG1vZGVsIGl0IGFzIGdwaW8gY29udHJvbGxlZA0KPiByZWd1bGF0b3IuDQoNClRoYW5r
cyBmb3IgdGhlIHN1Z2dlc3Rpb24sIEkgdHJpZWQgaXQgYW5kIGl0IHdvcmtzLCBwbGVhc2UgaGVs
cCByZXZpZXcgVjIgcGF0Y2guDQoNCkFuc29uLg0KDQo=
