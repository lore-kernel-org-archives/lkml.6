Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C360C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CC5222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9rGUDzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406338AbfBNJ6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:58:03 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:43875
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391766AbfBNJ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmE01YmJbB8gEq/sCADQQX4OidMe6K+1n08h8tCt4+o=;
 b=F9rGUDziGCkRRZ7rB0JzrxlckAN4Jg5nbvqWsDbBX9mp8w+eRzVAuuJp+oxLfvbRDUTV5cIzS6Ty5AjyrMR9TaojGzM/WNO1/k1gxoeWa5att60XYIzCGfkatJNWd4Fr2r52ynMmTamz2li3Xw9F+ZMFUn4mIaCtjJypaft4Nso=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4300.eurprd04.prod.outlook.com (52.135.131.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 09:57:45 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:57:45 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/2] can: flexcan: add PE clock source select support
Thread-Topic: [PATCH 0/2] can: flexcan: add PE clock source select support
Thread-Index: AQHUkrKRyn6yL7TqVE+qZvWvbmx6sKWzNfCAgCw8E9A=
Date:   Thu, 14 Feb 2019 09:57:45 +0000
Message-ID: <DB7PR04MB4618DA79F033D1FCB0E131E1E6670@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB4618E703A466628F22BCFBF6E6830@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB4618E703A466628F22BCFBF6E6830@DB7PR04MB4618.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13445ce4-399d-4c7d-258d-08d69262de70
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4300;
x-ms-traffictypediagnostic: DB7PR04MB4300:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUI0MzAwOzIzOnZ1WUdWVXE2WVNaMXV0cVpxdUhTdW9EQm9n?=
 =?gb2312?B?STdSdmcvcDZubHVUc1ZTQTZpTFpIWmhRWDQ0T2JIdzZUKzJlV25WSzc4bGlE?=
 =?gb2312?B?NERNKzJxRnZxZ1RxaEo1emRjK3VwV1NkaXRwbERZU0NrQWhMNU9mZDQreDBj?=
 =?gb2312?B?MzB5WTlpUDFNaVJRbm42WHEzMDFjUWptM3dTUFc3L1U3VzNjTDE4bWJJdFRp?=
 =?gb2312?B?Q3ZHZG56OTZsdTYxT0FCL0JZRDBwU3Y5K1o3ZVUxbkFhdGRHOVUzcTVaOTVr?=
 =?gb2312?B?UUV0WnNEU3hCV3FvMVlTdG81UVViK3VMTWJGSC8xdWdUQ2swZTRKMEdwMkE1?=
 =?gb2312?B?T0JLZUV6amR1Ym5DcXQxQXd6dnlNc2lJTTIrdEtJVXRwaUFDR1R4Q0RRV0Fy?=
 =?gb2312?B?Ukt3Z1dEK3dSdE1yQnE4cDhMSnY2OUJyR1o3RURpL3lCUGVtWjV3bW9SdHhq?=
 =?gb2312?B?WUxPMTg2aWZCZFhObzAxRmlDUFRPcFNoeTl5aWU1UWs1UzR4a2NDbjlLVy83?=
 =?gb2312?B?SDk4dzQ5b1JWa2FHYU9FcG9DVXBLM21mcDBEZ1l2RjFOZ3JxUXh4UmpDaEcz?=
 =?gb2312?B?cGxTU3MvV2xXVE8rK285V0xrRGZJZ3RHRlVLd29IK2pXTmtiNWtiOXJEMGZN?=
 =?gb2312?B?KzVaQU5IbTRVV3BXMFRoQjhvZWp5WW1hTnRGQWNWV1ZQT0d1ZmNGOGlnbVNp?=
 =?gb2312?B?bFJDeVJpUUxsd1JkTk1CMWFzODE3NEEzam9vQkNGWjgxMitIM2JtbURUVEU3?=
 =?gb2312?B?ajhUeWpPdjRjOTR5dUVjRHZDWUp5MG9PU0FaQ05yN2NBczZiNDJXME5rVGM2?=
 =?gb2312?B?TUFybG1KR2ZoYVAzbmdpK2owTjRuSmtCaHZ3ZFZUVGJzSTJQUUFobmxCbnd2?=
 =?gb2312?B?ZWo5LzRENUZ5bklIdHVMNVF3bktTOEUxR3R5QzdUUFo0aEFaMDNkQzlUOGFm?=
 =?gb2312?B?bzNxeEZ6UXhlQm1ocFpkcVlzblVqK1A5ZTRiQi91enZOOEhHcVcvZHlJYzJj?=
 =?gb2312?B?c0NWaEc1YXJKT0UzdXlkaEpKelk3ZzBoeHFrak0zdWI4QXZ4ZWdmc0sydXgr?=
 =?gb2312?B?RCs0d0V4RzFtVXNkL1pBMFd0dlJDQnh0WnpDSm1pejZFUWpnSldlUCsvUFNH?=
 =?gb2312?B?WlhtUTBPRUt0dFlkL2djSE1UZnR5QUpxUXpQL2dCR0VlWm96UlpZY2hvLzQ2?=
 =?gb2312?B?QTFKZVUzQjNlNWVvRHk0RWhrcVQ0bGdOS1k0YXZrYjUxdE9raWJtajR5T1pY?=
 =?gb2312?B?VjJiaG9kaVlTem4yL3Y1VDdwNk5TRnYzb254cXZyc2xPMFRwV21tdVBNUTFI?=
 =?gb2312?B?a0IxbzZxMlVJUC9Fb3R1QU9PbXZGZnN1RmVxdkh3NTlmTU4rbzladVJ0Tng5?=
 =?gb2312?B?QjJMZlZGcnNXbXNSSG9HMldtQ1crbk13Sm1hYzB2R2ZJWVdVby9nY1RoS0p2?=
 =?gb2312?B?UmM3eDFZUkgvcmZOeHlZNEI5ZDFTeHdFRFZzZGM1M2tyR2IrbzZ4NTlGZTNv?=
 =?gb2312?B?bFpQcGpKV0g4U2g4MDlZUUtnd01RWTdYam9sQTdZdjR1WTdLbFFPYlJxbVFN?=
 =?gb2312?B?a1ZkL1Niak1qVXpiTlovSUZDN3pjci9mWGZDZUNKNk5oRXZKTDAzUXRoSkVK?=
 =?gb2312?B?SzJMSnhmV00xOERtSHNhYjdXZlVhaHhsU3pEN3VaSUJmVTB4a1dSUElzWFdv?=
 =?gb2312?Q?gNJKTj4w7K1yIVr3Lk=3D?=
x-microsoft-antispam-prvs: <DB7PR04MB4300EA8A057012C4EA779AEEE6670@DB7PR04MB4300.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(13464003)(256004)(81166006)(8936002)(316002)(76176011)(110136005)(8676002)(106356001)(105586002)(26005)(25786009)(33656002)(55016002)(2501003)(2906002)(71190400001)(4326008)(6246003)(7736002)(74316002)(305945005)(186003)(97736004)(99286004)(6436002)(54906003)(81156014)(7696005)(478600001)(53936002)(6116002)(3846002)(11346002)(68736007)(486006)(446003)(229853002)(66066001)(14454004)(9686003)(569044001)(71200400001)(6506007)(86362001)(476003)(102836004)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4300;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MP4jRqPKtnIQC47JD9UE/lCibUoQi2qotbbgUVss4WGi5csiClPhJJ1bTm56a3FY0SFVv8KrVR5BKwLEixpmNQ7d3DtuJE6OWVhR+YGCY8ZVRoydjfL9krZ6JXNe5shStUVlpm9ZKFY+HqCFuJDN9J57bgIrUMLGwQz1kNSuU46xfBMQH1YWRamPSgxbbZkepWZxY2jKl5+pAth/5GuPd8kLDrd09yqNUORBc+5xe6HEUlv1pFOBDGW6t9vbTzS/KyJluaFdpLQSayWG+zdEc4Hteo3UyMXASIPPTkb81Mhvne0qxspd4pioxU/JKERNa7bgGOQwXmZc7OD+S3bE0dTBnCyS/bpMePZwZ7mXI737EM6SPDsNYbHM+xYM8Igl4P3bqbSzsbPDhyFgNTGHW8Z8gSXI78KtFGVIKX73roU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13445ce4-399d-4c7d-258d-08d69262de70
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:57:45.4785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpLaW5kbHkgUGluZy4uLg0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2FraW0gWmhhbmcNCj4gU2VudDogMjAx
OcTqMdTCMTfI1SAxNDoyOA0KPiBUbzogbWtsQHBlbmd1dHJvbml4LmRlOyByb2JoQGtlcm5lbC5v
cmcNCj4gQ2M6IGxpbnV4LWNhbkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxp
bnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDAvMl0gY2FuOiBmbGV4Y2Fu
OiBhZGQgUEUgY2xvY2sgc291cmNlIHNlbGVjdCBzdXBwb3J0DQo+IA0KPiANCj4gS2luZGx5IFBp
bmcuLi4NCj4gDQo+IEJlc3QgUmVnYXJkcywNCj4gSm9ha2ltIFpoYW5nDQo+IA0KPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogSm9ha2ltIFpoYW5nDQo+ID4gU2VudDog
MjAxOMTqMTLUwjEzyNUgMTU6MDgNCj4gPiBUbzogbWtsQHBlbmd1dHJvbml4LmRlOyByb2JoQGtl
cm5lbC5vcmcNCj4gPiBDYzogbGludXgtY2FuQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2
Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IEpvYWtpbQ0KPiA+IFpoYW5nIDxxaWFuZ3Fpbmcu
emhhbmdAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBbUEFUQ0ggMC8yXSBjYW46IGZsZXhjYW46IGFk
ZCBQRSBjbG9jayBzb3VyY2Ugc2VsZWN0IHN1cHBvcnQNCj4gPg0KPiA+IFRoZSBwYXRjaCBzZXQg
aW50ZW5kcyB0byBhZGQgc3VwcG9ydCBmb3IgUEUgY2xvY2sgc291cmNlIHNlbGVjdC4gVGhlDQo+
ID4gRmxleENBTiBjb250cm9sbGVyIGNhbiBwYXJzZSAiZnNsLGNsay1zb3VyY2UiIHByb3BlcnR5
IGZyb20gZGV2aWNlDQo+ID4gdHJlZSB0byBzZWxlY3QgY2xvY2sgc291cmNlLg0KPiA+DQo+ID4g
RG9uZyBBaXNoZW5nICgyKToNCj4gPiAgIERvY3VtZW50YXRpb246IGNhbjogZmxleGNhbjogYWRk
IFBFIGNsb2NrIHNvdXJjZSBwcm9wZXJ0eSB0byBkZXZpY2UNCj4gPiAgICAgdHJlZQ0KPiA+ICAg
Y2FuOiBmbGV4Y2FuOiBhZGQgc3VwcG9ydCBmb3IgUEUgY2xvY2sgc291cmNlIHNlbGVjdA0KPiA+
DQo+ID4gIC4uLi9iaW5kaW5ncy9uZXQvY2FuL2ZzbC1mbGV4Y2FuLnR4dCAgICAgICAgICAgfCAg
OCArKysrKysrKw0KPiA+ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jICAgICAgICAgICAgICAg
ICAgICAgIHwgMTggKysrKysrKysrKysrKystLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IC0tDQo+ID4gMi4xNy4xDQoN
Cg==
