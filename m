Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1211CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2416218D0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vJjqqZZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfB0IrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:47:12 -0500
Received: from mail-eopbgr30084.outbound.protection.outlook.com ([40.107.3.84]:21403
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726724AbfB0IrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQSXfVGkG5wsbVQa89gr1UBWnOhl0oz7TkRoFQDWjRw=;
 b=vJjqqZZrn8+L8g53D+L8M8elrCohyKP33CVDPF3gYqFgrKSGi2H30IF2lMELyCIBO+5OWzOC4Qxzp6bad7sgAPoYIUIwnqpcGxRsc5e9Gda8hdYDebfv8kiNUQqq8rshyjs5ySO6nYrk4PlNdvS+pqqxtnyMd1atJpPJY2RGw3I=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3674.eurprd04.prod.outlook.com (52.134.66.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Wed, 27 Feb 2019 08:47:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Wed, 27 Feb 2019
 08:47:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Eduardo Valentin <edubezval@gmail.com>
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
Thread-Index: AQHUybAPUmnoI6Ce/UqIMDTlZO/oOqXt7LgAgABXLoCAA716YIABXR0g
Date:   Wed, 27 Feb 2019 08:47:00 +0000
Message-ID: <DB3PR0402MB3916B83ED9B460ED36B52248F5740@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1550730831-14995-1-git-send-email-Anson.Huang@nxp.com>
 <20190223213759.GA1472@localhost.localdomain>
 <DB3PR0402MB39164677D09DA6CB3A6951B3F5790@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB422261F6A295A58FF06E90DE807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB422261F6A295A58FF06E90DE807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05cf5790-818e-4c05-aa81-08d69c9023ba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3674;
x-ms-traffictypediagnostic: DB3PR0402MB3674:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM2NzQ7MjM6ejk0WTRDQVB5dTE1RVkvSHNueFdZOGxi?=
 =?gb2312?B?UkExSmxLMkttQWVORjFwYndQQVdMK3NwRW5SWGtSRkE0Z2lTWjA3V3NpalNl?=
 =?gb2312?B?U0R2Zi8xdDJEL3dVWThUdUJHL0htaVB1YVg0OXkyRDNyWTVQemVIZnF5SXBV?=
 =?gb2312?B?aGhiQ3phbjZOOGdDWmI1UTNqSTFsOTFtbGxxbS84MGhNQlZ6dEtYOUVEeitG?=
 =?gb2312?B?ZDdJTmpqT3FORmZHS2NQUk5zazkvMzRpVUNnQmRYYnBmY2tFSHoxSWlRbklS?=
 =?gb2312?B?ZWIxbHZBZFljN1JCWUxVNDZ4R2xrWW5OSzBvWSsvQThrTTNITGZRL25ZTnZO?=
 =?gb2312?B?TktFcVFucVZZSFBEWk5PVVlEOFRxSGdsenZYdHVCZVg0Z0JWVndZOG1jeFVw?=
 =?gb2312?B?RWFWYTZkTGRVOWxFK3ZUSTM5d3JZMVNUaUhnS1hPNGVWc3A2Vkd0MFA0L2lY?=
 =?gb2312?B?dHJpSW91OUVWMkM1N1MyS3A5YmtZZlZPRGxXMzRBdXhlU1lOdWVrLzZsVDU4?=
 =?gb2312?B?S3hpRlNJeWpnb2xzMlFOWnBsWnB3czRibm1FYWhnSENRenJKNGdWR1RuUkNJ?=
 =?gb2312?B?cDF1NW5nWDBoM3QzUEl4WjVYY1Y3bHE5dXV1MHVURGhLWUFxdU1CZzRxelUx?=
 =?gb2312?B?L2JveUthOEZKVDFCZUtHTXA0bzdNOGd2OE4zYkpoRWQvZ3RYdG9Fb2Z6UDVL?=
 =?gb2312?B?d0hBWFI2NzlHM2trUTBrV3JnS00yT1RiWGxYNHJQMWxQMUhpWE50VnQvdTJ3?=
 =?gb2312?B?SkN6eTAwRzcweDFUcjhZZmRVUHNwaUEwZ2QxK0VNT05JOFlGcExPT1IvNVhh?=
 =?gb2312?B?MHRkQVBOeGRLTjZHNkhTbG9pWU5ya3NYcUllbEtkeE9Lc2VXcjVtOWZyOEla?=
 =?gb2312?B?RDFYNHNWeCtxQVkzN2hnS24wcjduNCszUEZkZW84b0pNMmVKSXNwRkpla3lw?=
 =?gb2312?B?NkxVYzJKYXlDc0EyYjVCc1FDNDBHV1ZzM3labkZWYWlTeW16ZDJCakMwNlkw?=
 =?gb2312?B?OEt1b09EcUlDYi9pRms2RlNrdUZXNnF1elZDUlh5YnNKRzEyZ3F2UVNKY1VO?=
 =?gb2312?B?UXMrYUtwbDJQbmd3dkN6cVlaRFJzNEpDTHFhNWV1VzM0aVFBMWp4TzdBMjcr?=
 =?gb2312?B?aytQVEwvamYvMms5M2JTQTNzR0xlaG9hbm5saVdJTG5Wa01tRFlDeFFQVmJM?=
 =?gb2312?B?dWR6ZFZEK2VkakVranhkZ3lDRUtoTzJMVlE5YWxRa2JyMkkvbC96ODlEVlQz?=
 =?gb2312?B?RVltTUEzb3cvcWdvRTJJMW1KYW5uN0YxVnVmTWtOLzFkYWFNNGZlY1p1TzY5?=
 =?gb2312?B?emt4Z0FUaUFTZkZZbDgzZkJReFg0ZlJSOHZzWXRrbDF1ZTVqUWNDYmdVbjFC?=
 =?gb2312?B?VHkzdngzcGp3VGQxeDBVNk11NTJNRi9IM00wemI4WGUwTDY1NHprWXUrcmpx?=
 =?gb2312?B?YkdoRER5d2V0VkI1R0xseFhTQlloMGRJOWs0VU1lbFZRSjVPakJjL1U3Yklq?=
 =?gb2312?B?YUlGdCtBVEdMWWJ2Z2lsdVJhS2VSNll2cEdyR2VtTWlGTkt0V08xZU93ZXRX?=
 =?gb2312?B?YWdEeUwrOFgxZGJ2ak9uU0RrcEIvYXZML0JRRm8vMGt6bTdOTkVOczh6QkJ5?=
 =?gb2312?B?NE8xTVNkQjdxV25IY2RqVVVObDZJVjRGbFlnTGtXcGtKanVQTnI2RlFnR1dI?=
 =?gb2312?B?RGVUQ3pJdnk3SnNGbzBKMHRwSG1FdTVqK25MdGJtZ2RaYzlZSmhYMDZHcHg0?=
 =?gb2312?B?WktjeUFIKzJrUnlMYnpud29MVjA1M2cxeUh5TGRXZWpWUkkwUElucW1CSi9F?=
 =?gb2312?B?dDQrS0sxWlNyeHVjM2x6MU1zK3g4NE03ZlZ4WHR4R0w1QjkzUT09?=
x-microsoft-antispam-prvs: <DB3PR0402MB367488A29B3BD7CF138AD734F5740@DB3PR0402MB3674.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(13464003)(189003)(199004)(25786009)(102836004)(229853002)(2906002)(6246003)(81166006)(8676002)(4326008)(3846002)(6116002)(478600001)(81156014)(14454004)(8936002)(53546011)(52536013)(68736007)(6506007)(6436002)(186003)(71200400001)(71190400001)(26005)(5660300002)(9686003)(86362001)(54906003)(316002)(7736002)(7696005)(110136005)(66066001)(305945005)(14444005)(97736004)(93886005)(7416002)(55016002)(11346002)(105586002)(44832011)(33656002)(99286004)(74316002)(106356001)(486006)(476003)(256004)(76176011)(446003)(53936002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3674;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LtaR/Xpl172eEBiKEjFGeBxzhVLm2XDabJlFdrsYvfgdT6I3HiJEreMBLfEUgcBM/m0zfPCQddjLfdVR8qki+P2LgPm89SGruxNZ5/rSha0CSi2k/AMNnbIhC1qjlkMObzfc4NMiRJlyPkwPS8lnTgbXDQgjB2pQUMBOOjSs4r+i0qMGGUnsJ+faO58/ob78e9R/eofqpwLkuYEk/RMM2+az6ZrxGlyUybjZMI1nuPSBOikrAQVtSOaOJZxcz0a5kDHWEpMD9jVTijPuxlahUKMQ2dnK3TBJqJUIceSjBVK/ejkt3bfm52YFZqKIyfq9RTFdfzI3flBQ0RkMz4NktH7AsJWPsK0ljly2YtE3MXf1M+ovycrTl5yfIoECV1FWtZSSUjHJSkVE9I7V974xZX2o5tp+faZdITAFLpdjspg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05cf5790-818e-4c05-aa81-08d69c9023ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 08:47:00.6712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IDIwMTnE6jLUwjI2yNUgMjA6MDEN
Cj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgRWR1YXJkbyBWYWxlbnRp
bg0KPiA8ZWR1YmV6dmFsQGdtYWlsLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0
cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgcnVpLnpoYW5nQGlu
dGVsLmNvbTsNCj4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZzsgdWxmLmhhbnNzb25AbGluYXJv
Lm9yZzsgc2JveWRAa2VybmVsLm9yZzsNCj4gRGFuaWVsIEJhbHV0YSA8ZGFuaWVsLmJhbHV0YUBu
eHAuY29tPjsgQW5keSBHcm9zcw0KPiA8YW5keS5ncm9zc0BsaW5hcm8ub3JnPjsgaG9ybXMrcmVu
ZXNhc0B2ZXJnZS5uZXQuYXU7IGhlaWtvQHNudGVjaC5kZTsNCj4gYXJuZEBhcm5kYi5kZTsgbWF4
aW1lLnJpcGFyZEBib290bGluLmNvbTsgYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7DQo+IGph
Z2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBlbnJpYy5iYWxsZXRib0Bjb2xsYWJvcmEuY29tOw0K
PiBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsgb2xvZkBsaXhvbS5uZXQ7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiBwbUB2Z2VyLmtlcm5lbC5vcmc7
IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0gg
VjggMS80XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCB0aGVybWFsIGJpbmRpbmcNCj4gDQo+
IFsuLi5dDQo+ID4gPiBPbiBUaHUsIEZlYiAyMSwgMjAxOSBhdCAwNjozODozMEFNICswMDAwLCBB
bnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+ID4gTlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3
aXRoIGEgQ29ydGV4LU00IGNvcmUgaW5zaWRlIGFzDQo+ID4gPiA+IHN5c3RlbSBjb250cm9sbGVy
LCB0aGUgc3lzdGVtIGNvbnRyb2xsZXIgaXMgaW4gY2hhcmdlIG9mIHN5c3RlbQ0KPiA+ID4gPiBw
b3dlciwgY2xvY2sgYW5kIHRoZXJtYWwgc2Vuc29ycyBldGMuIG1hbmFnZW1lbnQsIExpbnV4IGtl
cm5lbCBoYXMNCj4gPiA+ID4gdG8gY29tbXVuaWNhdGUgd2l0aCBzeXN0ZW0gY29udHJvbGxlciB2
aWEgTVUgKG1lc3NhZ2UgdW5pdCkgSVBDIHRvDQo+ID4gPiA+IGdldCB0ZW1wZXJhdHVyZSBmcm9t
IHRoZXJtYWwgc2Vuc29ycywgdGhpcyBwYXRjaCBhZGRzIGJpbmRpbmcgZG9jDQo+ID4gPiA+IGZv
ciBpLk1YIHN5c3RlbSBjb250cm9sbGVyIHRoZXJtYWwgZHJpdmVyLg0KPiA+ID4gPg0KPiA+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gPiA+
ID4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IA0KPiBZb3Ug
bmVlZCBkcm9wIHRoZSBmb3JtZXIgUmV2aWV3ZWQtYnkgb25jZSB0aGVyZSdzIHNpZ25pZmljYW50
IGNoYW5nZXMuDQo+IA0KPiA+ID4gPiArVGhlcm1hbCBiaW5kaW5ncyBiYXNlZCBvbiBTQ1UgTWVz
c2FnZSBQcm90b2NvbA0KPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICsNCj4gPiA+ID4gK1JlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ID4gPiA+ICstIGNvbXBhdGlibGU6CQkJU2hvdWxkIGJlIDoNCj4gPiA+
ID4gKwkJCQkgICJmc2wsaW14OHF4cC1zYy10aGVybWFsIg0KPiA+ID4gPiArCQkJCWZvbGxvd2Vk
IGJ5ICJmc2wsaW14LXNjLXRoZXJtYWwiOw0KPiA+ID4gPiArDQo+ID4gPiA+ICstICN0aGVybWFs
LXNlbnNvci1jZWxsczoJU2VlDQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdGhlcm1hbC90aGVybWFsLnR4dA0KPiA+ID4gPiArCQkJCWZvciBhIGRlc2NyaXB0aW9uLg0K
PiA+ID4gPiArDQo+ID4gPiA+ICstIGlteCxzZW5zb3ItcmVzb3VyY2UtaWQ6IAlQcm9wZXJ0eSBh
cnJheSB0byBzcGVjaWZ5IGVhY2gNCj4gdGhlcm1hbA0KPiA+IHpvbmUncw0KPiA+ID4gc2Vuc29y
IHJlc291cmNlIElELg0KPiA+ID4NCj4gPiA+IElmIHRoaXMgaXMgYW4gYXJyYXkuLi4NCj4gPiA+
DQo+ID4gPiA+ICsNCj4gPiA+ID4gIEV4YW1wbGUgKGlteDhxeHApOg0KPiA+ID4gPiAgLS0tLS0t
LS0tLS0tLQ0KPiA+ID4gPiAgbHNpb19tdTE6IG1haWxib3hANWQxYzAwMDAgew0KPiA+ID4gPiBA
QCAtMTY4LDYgKzE4MSwxMiBAQCBmaXJtd2FyZSB7DQo+ID4gPiA+ICAJCXJ0YzogcnRjIHsNCj4g
PiA+ID4gIAkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2MtcnRjIjsNCj4gPiA+ID4gIAkJ
fTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCQl0c2VuczogdGhlcm1hbC1zZW5zb3Igew0KPiA+ID4g
PiArCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OHF4cC1zYy10aGVybWFsIiwgImZzbCxpbXgtc2Mt
DQo+ID4gPiB0aGVybWFsIjsNCj4gPiA+ID4gKwkJCSN0aGVybWFsLXNlbnNvci1jZWxscyA9IDww
PjsNCj4gPiA+ID4gKwkJCWlteCxzZW5zb3ItcmVzb3VyY2UtaWQgPSA8SU1YX1NDX1JfU1lTVEVN
PjsNCj4gPiA+DQo+ID4gPiB0aGVuIHRoaXMgZXhhbXBsZSBzaG91bGQgaGF2ZSBhbiBhcnJheSwg
dG8gYmUgYmV0dGVyIGV4cHJlc3MgaG93DQo+ID4gPiB0aGlzIGlzIHN1cHBvc2VkIHRvIHdvcmsu
IENhbiB5b3UgcGxlYXNlIHJlc2VuZCB0aGlzIHdpdGggYW4gYXJyYXkNCj4gaW5zdGVhZD8NCj4g
Pg0KPiA+IE9uIGkuTVg4UVhQLCB0aGVyZSBpcyBPTkxZIDEgdGhlcm1hbCB6b25lIGF2YWlsYWJs
ZSBjdXJyZW50bHksIGJ1dCB0aGUNCj4gPiB0aGVybWFsIGRyaXZlciBpcyBzdXBwb3NlZCB0byBz
dXBwb3J0IG11bHRpIHRoZXJtYWwgem9uZXMgYXMgd2VsbCBmb3INCj4gPiBpLk1YOFFNLCBpbiBW
OSBwYXRjaCBzZXQgSSBqdXN0IHNlbnQsIEkgdXNlIHRoZSAiDQo+ID4gaW14LHNlbnNvci1yZXNv
dXJjZS1pZCAiIGVsZW1lbnQgY291bnQgdG8gZGV0ZXJtaW5lIGhvdyBtYW55IHRoZXJtYWwNCj4g
PiBzZW5zb3JzIHdpbGwgYmUgc3VwcG9ydGVkLCBzbyB0aGF0IHdlIGNhbiBhbHNvIGdldCByaWQg
b2Ygc2VhcmNoaW5nDQo+ID4gdGhlIHRoZXJtYWwtem9uZXMnIGNoaWxkIG5vZGUsIEkgaW1wcm92
ZWQgdGhlIGRlc2NyaXB0aW9uIGFzIGJlbG93LCBpcyBpdCBPSz8NCj4gPg0KPiANCj4gRGV2aWNl
IHRyZWUgaXMgdXNlZCB0byBkZXNjcmliZSBIVy4NCj4gI3RoZXJtYWwtc2Vuc29yLWNlbGxzIGlz
IGxlc3MgdG8gYmUgYW4gb3B0aW9uYWwgcGFyYW1ldGVyIHRvIG1lLg0KPiBJZiBIVyBzdXBwb3J0
cywgdGhlbiBpdCBzaG91bGQgYmUgMSBhbmQgdXBkYXRlIHRoZSBleGFtcGxlIGFjY29yZGluZ2x5
Lg0KDQpPSywgSSBjaGFuZ2VkIGl0IHRvICIxIiBpbiBWMTAgcGF0Y2ggc2VyaWVzLg0KDQpUaGFu
a3MsDQpBbnNvbi4NCg0KPiANCj4gUmVnYXJkcw0KPiBEb25nIEFpc2hlbmcNCj4gDQo+ID4gIDQx
ICstIGlteCxzZW5zb3ItcmVzb3VyY2UtaWQ6ICAgICAgQSBzaW5nbGUgaW50ZWdlciBmb3Igc2lu
Z2xlIHRoZXJtYWwgem9uZSdzDQo+ID4gcmVzb3VyY2UgSUQgb3INCj4gPiAgNDIgKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhbiBhcnJheSBvZiBpbnRlZ2VycyB0byBzcGVjaWZ5IGVh
Y2gNCj4gPiB0aGVybWFsIHpvbmUncyBzZW5zb3INCj4gPiAgNDMgKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICByZXNvdXJjZSBJRC4NCg0K
