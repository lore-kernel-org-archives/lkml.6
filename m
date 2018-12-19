Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3481C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D721841
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xqLDXOf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeLSHLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:11:49 -0500
Received: from mail-eopbgr20070.outbound.protection.outlook.com ([40.107.2.70]:62336
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbeLSHLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcW0Dhuf5Yt4JWGtbzMKXNkUdhlaZAUVqZmd65OLHI0=;
 b=xqLDXOf73IYzl0sq0CdkVFJfNxUcrbrymvaVeapFJAem4pd9KZqWi+E/mDvRWKvIBhEnQV6MAZj3rVVh0ktTcexy+KVOp3WpDyuAJcdt7u0etmX3VNVACzg8QFZVgLs+8KRS9zpQRVhTY2tRY370wcwSMVk0B+eKRlity68YGCs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3881.eurprd04.prod.outlook.com (52.134.73.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 07:11:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::adf8:f49d:deb4:58fd%3]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 07:11:42 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V2] dt-bindings: timer: gpt: update binding doc
Thread-Topic: [PATCH V2] dt-bindings: timer: gpt: update binding doc
Thread-Index: AQHUkesyTVVs0WJXMkO1LYqT6j/uOaWExbEAgADp7MA=
Date:   Wed, 19 Dec 2018 07:11:42 +0000
Message-ID: <DB3PR0402MB391611FFEFC910394D671E43F5BE0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1544598889-2995-1-git-send-email-Anson.Huang@nxp.com>
 <20181218171150.GA21403@bogus>
In-Reply-To: <20181218171150.GA21403@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3881;6:Jbyqs3ecknerdqzsG8M7xEEViom2eTyAxSYX0Troap1mAKj+5U7wBwBFPQ7V4+cbzRiHC3omYj/y7toHOxSZl5hv55TZIs5WE/7gzpBHBXH6iRihGLqQsETRISAiAc6T0oaNCAUa+mTYCm2j7TX27AuVYkYMG2SRFZGXjPRq0SVSvixCHUS0qUQPjxc9GUb5nRPUM2Zxnjl8rTXcDzgZlcwBJJNf1gniXjaaX/POck+ZQYhEuTyFo4UZ4f89pCsN/MVlBQ4eWhZZOxYAmv57J+YrP2ZGJMVKD7HLvBDBPe8kNjfSAVy4+5IAgP6Mo11T/CCoZK9cuzZ09XqnEptBM913cwyuVHPnsWYeBi6PfuTuXpJ3JQ6vpmlzrP2mRoO372JEu/s20XByzbJvRDknLPpGpfoiaWFBTcfjwp46yJf4+Qv33iHTwcmWIchspIxtanVT0jf/lCuyEsW0n9W13Q==;5:NkbiDJpWpRD2zEDUJkaZ1uq4wjn4N/kqzQjE8nrRyY/ryo3L/9rhx+B4Rc9w/kmwVs2iZP8rqnXlJiwG1Yiix4EIjXsdoj6En59nEYNxszHakYE0J8n990NaWa5aOJKEEkuAW/nOVOS9eeGzYnccSYDCQlUOPsYW69bZEZaLcu0=;7:vvuIlqjV5TybNyhfi54o33s0CGnZklkUaP4JlTWBuVay8dnZAZtCF4ztMphi+6oshXzMLJ/2Nf2CoEdhfDiIWzDUJ03DNN24A9jHEC2YrRr/PHkDoeXBCxSeJxvEq9jSK6bs3tcM6M9sOwM1b55TkA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cbffa0c9-1c72-4f9e-b2c7-08d665813a72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3881;
x-ms-traffictypediagnostic: DB3PR0402MB3881:
x-microsoft-antispam-prvs: <DB3PR0402MB3881D329DD6A367843A4F8FCF5BE0@DB3PR0402MB3881.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3881;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3881;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(396003)(376002)(136003)(13464003)(199004)(189003)(26005)(106356001)(11346002)(71200400001)(76176011)(71190400001)(66066001)(9686003)(6436002)(102836004)(53936002)(478600001)(54906003)(25786009)(2906002)(14454004)(33656002)(7696005)(81166006)(81156014)(6116002)(14444005)(3846002)(15650500001)(53546011)(6506007)(229853002)(55016002)(446003)(44832011)(8676002)(6246003)(6916009)(256004)(305945005)(68736007)(97736004)(4326008)(476003)(5660300001)(8936002)(105586002)(186003)(99286004)(7736002)(74316002)(486006)(86362001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3881;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: nzms7yW2JpqZqaxKw7zN3H7/HSez4FaI2SeiTBImswueRREjDILlAfRLdT2pqNTMzL2ocagbhnuD0zi/HxgFhg07tHNLoPID1yVG6caLjZn3xbJom0n8xkdihpL537FmEfB0olUaaGGXtTm5/a7H4ZhZvQzrcUIO7RQk3kE2mJXX5QqyeBXW4LKrMl3/6icWCOBSTstNgahD5uEv2j+jUbYmhi3PNQOTa4yPJP50sS1tAoPuUS100Tb0zLZx6Ffc3x42n6Yzm6WqmghX30Pwe6IZUR/ZMKsxa0KwVL0VZUydwp8097vTqwl8z6nR+6kw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbffa0c9-1c72-4f9e-b2c7-08d665813a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 07:11:42.4195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE4xOoxMtTCMTnI1SAxOjEyDQo+IFRvOiBBbnNvbiBIdWFuZyA8YW5zb24u
aHVhbmdAbnhwLmNvbT4NCj4gQ2M6IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IHRnbHhAbGlu
dXRyb25peC5kZTsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBkdC1iaW5kaW5nczog
dGltZXI6IGdwdDogdXBkYXRlIGJpbmRpbmcgZG9jDQo+IA0KPiBPbiBXZWQsIERlYyAxMiwgMjAx
OCBhdCAwNzoyMDo0NEFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiBUaGUgaS5NWCBH
UFQgdGltZXIgZHJpdmVyIGJpbmRpbmcgZG9jIGlzIG91dCBvZiBkYXRlLCB1cGRhdGUgaXQNCj4g
PiBhY2NvcmRpbmcgdG8gY3VycmVudCBHUFQgdGltZXIgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0ICAgICAgIHwgMjgN
Cj4gKysrKysrKysrKysrKysrKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdGltZXIvZnNsLGlteGdwdC50eHQNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9mc2wsaW14Z3B0LnR4dA0KPiA+IGlu
ZGV4IDk4MDliMTEuLjJlZDg0YWQgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3RpbWVyL2ZzbCxpbXhncHQudHh0DQo+ID4gQEAgLTIs
MTcgKzIsMzMgQEAgRnJlZXNjYWxlIGkuTVggR2VuZXJhbCBQdXJwb3NlIFRpbWVyIChHUFQpDQo+
ID4NCj4gPiAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPg0KPiA+IC0tIGNvbXBhdGlibGUgOiBz
aG91bGQgYmUgImZzbCw8c29jPi1ncHQiDQo+ID4gLS0gcmVnIDogU3BlY2lmaWVzIGJhc2UgcGh5
c2ljYWwgYWRkcmVzcyBhbmQgc2l6ZSBvZiB0aGUgcmVnaXN0ZXJzLg0KPiA+IC0tIGludGVycnVw
dHMgOiBBIGxpc3Qgb2YgNCBpbnRlcnJ1cHRzOyBvbmUgcGVyIHRpbWVyIGNoYW5uZWwuDQo+ID4g
LS0gY2xvY2tzIDogVGhlIGNsb2NrcyBwcm92aWRlZCBieSB0aGUgU29DIHRvIGRyaXZlIHRoZSB0
aW1lci4NCj4gPiArLSBjb21wYXRpYmxlIDogbXVzdCBiZSBvbmUgb2YgZm9sbG93aW5nOg0KPiA+
ICsgIC0gImZzbCxpbXgxLWdwdCIsDQo+ID4gKyAgLSAiZnNsLGlteDIxLWdwdCIsDQo+ID4gKyAg
LSAiZnNsLGlteDI3LWdwdCIsDQo+ID4gKyAgLSAiZnNsLGlteDMxLWdwdCIsDQo+ID4gKyAgLSAi
ZnNsLGlteDI1LWdwdCIsDQo+ID4gKyAgLSAiZnNsLGlteDUwLWdwdCIsDQo+ID4gKyAgLSAiZnNs
LGlteDUxLWdwdCIsDQo+ID4gKyAgLSAiZnNsLGlteDUzLWdwdCIsDQo+ID4gKyAgLSAiZnNsLGlt
eDZxLWdwdCIsDQo+ID4gKyAgLSAiZnNsLGlteDZkbC1ncHQiLA0KPiA+ICsgIC0gImZzbCxpbXg2
c2wtZ3B0IiwNCj4gPiArICAtICJmc2wsaW14NnN4LWdwdCIuDQo+IA0KPiBZb3UgbmVlZCB0byBs
aXN0IGZhbGwtYmFja3MgaGVyZS4gSU9XLCB3aGF0IGFyZSB0aGUgdmFsaWQgY29tYmluYXRpb25z
Pw0KDQpJIGxpc3RlZCB0aGUgY29tYmluYXRpb25zIGluIFYzIHBhdGNoOw0KDQo+IA0KPiA+ICst
IHJlZyA6IHNwZWNpZmllcyBiYXNlIHBoeXNpY2FsIGFkZHJlc3MgYW5kIHNpemUgb2YgdGhlIHJl
Z2lzdGVycy4NCj4gPiArLSBpbnRlcnJ1cHRzIDogc2hvdWxkIGJlIHRoZSBjbG9jayBldmVudCBk
ZXZpY2UgaW50ZXJydXB0Lg0KPiANCj4gJ2Nsb2NrIGV2ZW50JyBpcyBhIExpbnV4IHRoaW5nIGFu
ZCBzaG91bGRuJ3QgYmUgcGFydCBvZiB0aGUgYmluZGluZy4NCj4gDQo+IFdoYXQgaGFwcGVuZWQg
dG8gdGhlIDQgaW50ZXJydXB0cz8NCg0KWWVzLCB1c2luZyAiZ3B0IGludGVycnVwdCIgaXMgYmV0
dGVyIHRoYW4gImNsb2NrIGV2ZW50IiwgYW5kIGxvb2tzIGxpa2UgdGhlIGkuTVggR1BUDQpkcml2
ZXIgZG9lcyBOT1Qgc3VwcG9ydCA0IGludGVycnVwdHMgYXQgYWxsLCBPTkxZIDEgZ2VuZXJhbCBH
UFQgaW50ZXJydXB0IGlzIG5lZWRlZCwNCnNvIEkgdXBkYXRlZCBpdDsNCg0KPiANCj4gPiArLSBj
bG9ja3MgOiB0aGUgY2xvY2tzIHByb3ZpZGVkIGJ5IHRoZSBTb0MgdG8gZHJpdmUgdGhlIHRpbWVy
LCBtdXN0IGNvbnRhaW4NCj4gPiArICAgICAgICAgICBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeSBp
biBjbG9jay1uYW1lcy4NCj4gPiArLSBjbG9jay1uYW1lcyA6IG11c3QgaW5jbHVkZSAiaXBnIiBl
bnRyeSBmaXJzdCwgdGhlbiAicGVyIiBlbnRyeSwgIm9zY19wZXIiDQo+ID4gKyAgICAgICAgICAg
ICAgICBjYW4gYmUgYSBzdWJzdGl0dXRlIG9mICJwZXIiIGVudHJ5IG9uIHNvbWUgU29Dcy4NCj4g
DQo+IHBlciBvciBvc2NfcGVyIHNob3VsZCBiZSBkZXByZWNhdGVkIHNvIG9ubHkgb25lIGlzIHVz
ZWQgZ29pbmcgZm9yd2FyZC4NCg0Kb3NjX3BlciBpcyBqdXN0IGEgc3BlY2lhbCBjYXNlIGZvciBp
Lk1YNlEsIHNvIEkgcmVtb3ZlIGl0LCBqdXN0IG1lbnRpb24gdGhlIGlwZyBhbmQgcGVyIGNsb2Nr
Lg0KUGxlYXNlIGhlbHAgcmV2aWV3IFYzLCB0aGFua3MuDQoNCkFuc29uLg0KDQo+IA0KPiA+DQo+
ID4gIEV4YW1wbGU6DQo+ID4NCj4gPiAgZ3B0MTogdGltZXJAMTAwMDMwMDAgew0KPiA+IC0JY29t
cGF0aWJsZSA9ICJmc2wsaW14MjctZ3B0IiwgImZzbCxpbXgxLWdwdCI7DQo+ID4gKwljb21wYXRp
YmxlID0gImZzbCxpbXgyNy1ncHQiLCAiZnNsLGlteDIxLWdwdCI7DQo+ID4gIAlyZWcgPSA8MHgx
MDAwMzAwMCAweDEwMDA+Ow0KPiA+ICAJaW50ZXJydXB0cyA9IDwyNj47DQo+ID4gLQljbG9ja3Mg
PSA8JmNsa3MgNDY+LCA8JmNsa3MgNjE+Ow0KPiA+ICsJY2xvY2tzID0gPCZjbGtzIElNWDI3X0NM
S19HUFQxX0lQR19HQVRFPiwNCj4gPiArCQkgPCZjbGtzIElNWDI3X0NMS19QRVIxX0dBVEU+Ow0K
PiA+ICAJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQo+ID4gIH07DQo+ID4gLS0NCj4gPiAy
LjcuNA0KPiA+DQo=
