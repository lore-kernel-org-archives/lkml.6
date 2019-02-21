Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7517920842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 08:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WpEhH7NN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfBUIih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 03:38:37 -0500
Received: from mail-eopbgr20049.outbound.protection.outlook.com ([40.107.2.49]:31006
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfBUIig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 03:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=baImsYE9UK7A2errdVs0hPTOn59gJ5cKG9EotvzW0pg=;
 b=WpEhH7NNkdsPaAOKbO3uBtI61vvebNzol0G528L0Aw6hGz1Mr5ZqWqujApqmZ5dst9FIc1Ma8DMkp9aOO81ubgr9D2RM/HhU97uJsxLKbk+YmuADOzX93zdbsyRXKhP4Ha+4yCpYrtZ83t96HUnalZY6CtVBQ0NsfZxmFuvdBd0=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB5248.eurprd04.prod.outlook.com (20.177.51.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.14; Thu, 21 Feb 2019 08:37:53 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2%3]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 08:37:53 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Topic: [PATCH v3] usb: chipidea: Grab the (legacy) USB PHY by phandle
 first
Thread-Index: AQHUxUqvA6eOAzVWPUW+Xl7987JiyqXk4fzAgABcX4CABELMwIAAcYSAgAAAoXA=
Date:   Thu, 21 Feb 2019 08:37:52 +0000
Message-ID: <VI1PR04MB5327C5FCF2BCF404B78A2C6A8B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190215162225.19284-1-paul.kocialkowski@bootlin.com>
         <VI1PR04MB53274C03CD18C3D3ADB767408B630@VI1PR04MB5327.eurprd04.prod.outlook.com>
         <c80ee02db4a22d15a24281384ae561462593684f.camel@bootlin.com>
         <VI1PR04MB53278AE9AB6C14DA2AB96F6A8B7E0@VI1PR04MB5327.eurprd04.prod.outlook.com>
 <3ed330798d31d01fdfbd40571d016a108c9c5040.camel@bootlin.com>
In-Reply-To: <3ed330798d31d01fdfbd40571d016a108c9c5040.camel@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e324c74-21ad-446f-75c7-08d697d7dec9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5248;
x-ms-traffictypediagnostic: VI1PR04MB5248:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1MjQ4OzIzOmZNdUxobi85ZWU5Q2V4SGo3MSsrbHc5UGR1?=
 =?utf-8?B?bUcxTG1VeVdkcHBUWkZjeExPM3pwOE9MaXlxbzVyVnl5UWw5VWphQi9wLzlu?=
 =?utf-8?B?OUp4SUo1ejNBMnlrM2xlL2Fib1hvZ3NKK21JKzVUN3BmZzdYNWtNT0poVHEx?=
 =?utf-8?B?YWdJRFdKa0NxOWdiUFJ6cFhJbE9qWnkwWTdGN1Q0Vk5UMUNFNnJxQ3doeGdl?=
 =?utf-8?B?azM2bjI0dE1UcVZQSzFnRmpzN0F6UDJLS0VVVkZmbGQ3ZGhvRnZUWGd0Y0hx?=
 =?utf-8?B?V1E5K3hQLy9MY2dRUzdmbnBVOEVwek1VdVRjZnE3ejhqRm5sYVZKcDVBazZE?=
 =?utf-8?B?d3IyeGdkTUtRQVhjNUptR0hFeEhQR3drYis3eUlnVXVnbWdvVENQeEtqKzU1?=
 =?utf-8?B?b0V1c1JFaTZNcTd5STNoWDlSK2Y0SlZERG1aVHFmeVI3WmQ4WWNpYkE5MWFu?=
 =?utf-8?B?VUhlVnRoRHlralg0U241K1d1TitxdkZJbmFCN01RNE01L2toRjRnRFZqKzB0?=
 =?utf-8?B?Sk1rSUM3WDVoRjJ0MU5aVHorZ3V5YU9SN1IvM3F1cllna2lmbzg1ZTFDR3hv?=
 =?utf-8?B?ODBMdHhGOGVGZFcrdE5tSWNodkJOblZubWlmNHNROHZrczYzZ0JWNFo1Nm02?=
 =?utf-8?B?TVBrZmtUNVFZMFpQdzBUdnJ3aUtKWVNhUjlBV3k4aTVPZWdUbW5XV3g1dGNQ?=
 =?utf-8?B?UTQ4bTJKbG16ZEgrZXYyNERvNzhsTmJjVVZudWRuTTUwekhveE1ubTdxY2x2?=
 =?utf-8?B?ZkpsTDJXYUo0UUxOcVFldTZ3cW1yZFNwMkp1d1haWk5RSEpaeFFXQkxHVGZT?=
 =?utf-8?B?R2p5M2l3cjhaNFZVREthdXZUR2RSVFhCSWRhNnlQNjY3ajVVWDRiYzZlWDdq?=
 =?utf-8?B?NkJzTTBLWGlOL0NQbVdtZzhsWmFzbkRET2hZb0k5VE1uektpVUcyeFBXRjZp?=
 =?utf-8?B?UERxNUhuSGVUUUNaTURBQTlOYXV4ZVRlK2pLNnFMNFdnOVV2RW0rZC81Qmoy?=
 =?utf-8?B?NmdyZTRKWFdUaG1KNG0wdzZ2akF0blYxUlhCMGFzenFnNEZTcUpnY1kvd2VL?=
 =?utf-8?B?V0UreS9zcWtxVFNBQlNoZHFhOHNBSFo1SExPeWVJSnFkRHY2YmZoTVUzVFBv?=
 =?utf-8?B?bnRINmJ0SXFXTk9idERvLzU5bGtSS0FQQk41WGE1aGlxU25hakVNV3FCcUo4?=
 =?utf-8?B?aXlFNWlWQWhCVUlpdnFPbFpEOUw4UTgzVmJVREIyVVBXUUZYYkhYZ3BMMnRH?=
 =?utf-8?B?QW5OZUVDb3JKQTF4SSs4dU9Rd1dmNXNqY0tRTDBoazVDaGJWZjRYbDM1SVFD?=
 =?utf-8?B?SDhpS3Y3ck1ZNzRmb21FQjNINlcvSEMyejF4V3Rab2lOMTJhNlBhNjZLeEtJ?=
 =?utf-8?B?M1M2ZEUwNC9JYWw4K2xnaldOb1pXU2hkSS9jcm4zaXFxK3BwTkk1YndFdWZC?=
 =?utf-8?B?TUY3TUxodUdqSHpNVUtwMUkvUDhOTEVUZHRuc3RONytDYnRXMG1EenNQSzIv?=
 =?utf-8?B?OGNDc2p2YjVXNUUwUkd2cEdTQldTaXJuRlNOeDV6czFvTnl6ME9MWm41cmpx?=
 =?utf-8?B?ZUJERGc0QlRBZ09nQU5OV01uaU1wOUJkOVRMYmN0Z1lZZHhmcENOZTJLRWxT?=
 =?utf-8?B?blBUNTRHN2NYOGZUbnVFNzF4WVg5amc5TVk0bEszc2MyanZXUWxkdHRqb0Fq?=
 =?utf-8?B?RlEzNytuT2laVE5BZzR3aCt3azF2ejhzbkxDdWRwbVZBeW53UnpSQ05HK3Bq?=
 =?utf-8?B?R3duTTVISWVvcFNQcmtQQT09?=
x-microsoft-antispam-prvs: <VI1PR04MB524890CB39B6A77308951F758B7E0@VI1PR04MB5248.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(305945005)(54906003)(14454004)(68736007)(93886005)(33656002)(316002)(478600001)(106356001)(110136005)(25786009)(4326008)(74316002)(8676002)(7736002)(97736004)(2906002)(81166006)(66066001)(9686003)(8936002)(81156014)(486006)(4744005)(6506007)(256004)(102836004)(53936002)(6246003)(2501003)(99286004)(55016002)(3846002)(476003)(71200400001)(71190400001)(5660300002)(11346002)(44832011)(186003)(7696005)(26005)(446003)(105586002)(6116002)(2201001)(229853002)(86362001)(6436002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5248;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bS+ER5yPnnvwVHhzS0vA6NZA78zaC7DuWbCMHE6EStFOOQxMGl5NmhFj54BC7VGacvCl/NX14/Bpj2rfqTGS0qgfCs4H5+K+Uii0MO/uu2sD/aiRcKbPrFETC/gbp/4euw66gP6t01KuEVmTjc9bf3mljL505W6xNEwLzCU1CVVTvBzBab/RkvmzX8BSwgEeJjZfXWbJ8ks8LTorOTVg770Ikz8o2KfxMWvBDOBnZPV6Wk88l47HkZ1n4u7oB4AcxaXH66/Vxi37TzCCBb2vqbkpC0Wk/HiR8LUurJB3ubJSRCpTmRBsFVcExpkR8/Mucqnx5XgT7ddWMmcHiP/Rp7UQKSTmU2C3E43veo4C8E0Pcomj1xyRdkBSVEpIOivp0YT/mI0ihhNpUuvQYirZf0Jj9iCn9xdP/pMyMDA0060=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e324c74-21ad-446f-75c7-08d697d7dec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 08:37:53.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5248
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+IElmIHRoZXJlIGlzIGEgZ2VuZXJpYyBQSFkgbm9kZSB1bmRlciBVU0IgY29udHJvbGxl
ciwgYW5kIHRoZXJlIGlzIGENCj4gPiBVU0IgUEhZIGF0IG90aGVyIHNpZGVzLCBib3RoIGNpLT5w
aHkgYW5kIGNpLT51c2JfcGh5IGFyZSB2YWxpZCwgSQ0KPiA+IG9yaWdpbmFsIHRob3VnaHQgaXQg
aXMgdGhlIHByb2JsZW0geW91IG1ldC4NCj4gDQo+IFJpZ2h0LCB0aGlzIGlzIG5vdCB0aGUgcHJv
YmxlbSB3ZSBhcmUgaGF2aW5nLiBUaGUgcHJvYmxlbSBpcyB0aGF0IGxlZ2FjeSBVU0IgUEhZcw0K
PiBhcmUgbm90IGdyYWJiZWQgZnJvbSBkZXZpY2UtdHJlZS4gSW5zdGVhZCwgdGhleSBhcmUgY3Vy
cmVudGx5IG1hdGNoZWQgd2l0aCB0aGVpcg0KPiB0eXBlIGluIHRoZSBsaXN0IG9mIHJlZ2lzdGVy
ZWQgVVNCIFBIWXMsIG1ha2luZyBpdCBpbXBvc3NpYmxlIHRvIHVzZSAyIGRpc3RpbmN0IFVTQg0K
PiBQSFlzIHRoaXMgd2F5Lg0KPiANCj4gPiBTaW5jZSB5b3UgYXJlIHRyeWluZyB0byBmaXggdGhl
IGxlZ2FjeSBVU0IgUEhZIGdyYWIgaXNzdWUsIEkgaG9wZSB5b3UNCj4gPiBjb3VsZCBjb25zaWRl
ciB0aGUgZ2VuZXJpYyBQSFkgYXMgd2VsbC4NCj4gDQo+IFdoYXQgZG8geW91IGhhdmUgaW4gbWlu
ZCBhYm91dCBnZW5lcmljIFBIWXM/IEV2ZXJ5dGhpbmcgYWxyZWFkeSB3b3JrcyBhcw0KPiBleHBl
Y3RlZCB3aXRoIHRoZW0uDQo+IA0KIA0KQ3VycmVudCBjb2RlIHcvbyB5b3VyIHBhdGNoLCBpdCBp
cyBwb3NzaWJsZSBib3RoIGNpLT5waHkgYW5kIGNpLT51c2JfcGh5IGFyZSB2YWxpZA0KaWYgdGhl
IFVTQiBQSFkgaXMgbm90IGF0IHRoZSBkZXZpY2UgdHJlZSwgYnV0IGdlbmVyaWMgUEhZIGlzIGF0
IHRoZSBkZXZpY2UgdHJlZS4NCklmIHlvdSBkb24ndCB3YW50IHRvIGZpeCB0aGlzIGlzc3VlIHdp
dGggdGhpcyBwYXRjaCwgaXQgaXMgb2sgdG9vLiBXZSBjb3VsZCBmaXggaXQgbGF0ZXIuDQoNClBl
dGVyDQoNCg==
