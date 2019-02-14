Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66829222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="r8lIE1mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406364AbfBNJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:58:07 -0500
Received: from mail-eopbgr30059.outbound.protection.outlook.com ([40.107.3.59]:43875
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404577AbfBNJ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:58:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPo997u4tdVda57jeQoPSmGZ+2fYO9lNGQ+XdcTINCA=;
 b=r8lIE1mCjotgMEK5A34xJYQfQJP6UGXWtX90wLb7HGCvpZxXMtMrE2XyhSQfWeOuV5taLl6J95iZd/AKkuUge8580GxAk8g65kMnRe3zdl9bvqXku/9gPYQmpJfhESzHrnxKw7RNLVb3+3PHKDx2SyySf9oon69z/QDWXKEynuA=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.138.152) by
 DB7PR04MB4300.eurprd04.prod.outlook.com (52.135.131.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.22; Thu, 14 Feb 2019 09:58:01 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::2083:76ce:c2b6:6a39%4]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 09:58:01 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
CC:     "wg@grandegger.com" <wg@grandegger.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 0/3] can: flexcan: add imx8qm support
Thread-Topic: [PATCH 0/3] can: flexcan: add imx8qm support
Thread-Index: AQHUl3ZIyDiPbeOVSkuQb8q6fDKkQqWzLKAQgCw78/A=
Date:   Thu, 14 Feb 2019 09:58:00 +0000
Message-ID: <DB7PR04MB4618806ABA32BAC905DD6C49E6670@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <20181219083637.641-1-qiangqing.zhang@nxp.com>
 <DB7PR04MB46187B4AABF3607876DA30D4E6830@DB7PR04MB4618.eurprd04.prod.outlook.com>
In-Reply-To: <DB7PR04MB46187B4AABF3607876DA30D4E6830@DB7PR04MB4618.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b473e478-1bc4-44ad-ec94-08d69262e7b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4300;
x-ms-traffictypediagnostic: DB7PR04MB4300:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjdQUjA0TUI0MzAwOzIzOmNkSkE2aG1QWldLempuYkFxdi9wRUVvQnpq?=
 =?gb2312?B?NDYzZDFnTEhxQ3UzVlczTWJ0V1VzbjNZQ2JrOTV5Q2VHc1o0SkxsK2plZGZi?=
 =?gb2312?B?dndnRkE3QnZRcGVQV1dlbE54aEQ0RzJTQ3RJL0E4Qlhha2tKUHNzRGpMRll4?=
 =?gb2312?B?MVdGTlFwMm9qVnBid3BWc1k0T1JsbzhZUnJyaGlsSDR1bzRWaStXTTBqNkhZ?=
 =?gb2312?B?VEd2anJFWlA4SXhRSGlBdFF6YUtRVEREZjZtb253VmJlZURxUU5WcU40RHVS?=
 =?gb2312?B?VGp5M3BxcWJwVzZvRnErUllEM1VwV0wrVThsUE1wbkdrbG9MSTJZS3JYTVJr?=
 =?gb2312?B?ekM4WXFBVmxjajRoMDRGd2FIQ3E5eEIvNEx6YmticFN5TW1HdHFDK1FIUVBF?=
 =?gb2312?B?ekU1WDBEOTBoR3ZhakFsNGpDRXlwYjhCNnFiZ0lxT0VVNUhIaHJUWFFTTGsy?=
 =?gb2312?B?cXNFZHpDbG9GNEZpK1JYU1lseUMzekFlTFBoRTNicGk2SXVtYkJpZU5uejFi?=
 =?gb2312?B?bVNySmlxWHlYejdETE96ejNqZGx5WjRGdnpSYnFoV3paemtlZytrcm5xS3ln?=
 =?gb2312?B?cGFYWGlhSUF3SGI4dmRoZHdPTFpsU0N1US9hdHF4TkN6LzFxNmlYU3B2T254?=
 =?gb2312?B?cmZvSVNjdHhYR1hOSUlnS212a0o1Rk0yeld0M2ZwdERoOGZZdy9pNnVhWnBG?=
 =?gb2312?B?N2JTdHIzVlhKWGV3Q3Q0SlovYU0rL21ibzhGZ1l5d3ZIUExJNEh3aERNQVU5?=
 =?gb2312?B?eElaWHMxUk1UU2tlYm0xd04xb3Zsd213WnR3YjkxUWgreEpZRGtkbWhna05u?=
 =?gb2312?B?cmRZUWVOK21ab3pJWXBpZnpJRU9VaWZPQkJsdEZaam9kK25XdzlTcTVDNmpr?=
 =?gb2312?B?b1krRTVYY1E3Vlpwblczd1ZkZzYwQTBnWUtSM1JLUjJaa2FYMVpPVWdQREEv?=
 =?gb2312?B?V1FTM3VDUDcxOHF0dzN5dk1EN1NXdjNCL2NueTk5em9DQmJYa3M4d0VyWjk0?=
 =?gb2312?B?WE05elN0TlhoUGVrSVdUY2UzUHhCdFBTTlhKMWRZRm9UVFBwRGlRdWN5REJY?=
 =?gb2312?B?YlBrZ0ErZU9DYXQ0SkxFdW96VllTZXhERWJhYS9TMnE5ekhtNVNnOUN4Nmh6?=
 =?gb2312?B?UHVPN2JMQjB4TGRhdXA4ZityT0hILzFnNmkrUE9mZ1RBUmhwNVFVczlxQUtv?=
 =?gb2312?B?ZjVOeGdNSHBiZlg1Wmpiem14VTQrQzR4Uk1hOXB4aWtCU3gxWXFDM2lSL0RC?=
 =?gb2312?B?T3ptbTJmZmZyaHhlZXNQd1FiOFpLT0ZFdVU5ZDJEWjBQM2JRYXBQamdQRXh2?=
 =?gb2312?B?YjkyRUU2RzE4cGpPTVZBcEM3dkw2VlJtelROMG1keW9zSkd1Y1VlODJTQVdB?=
 =?gb2312?B?Zm1mRGswOVh0UlVZdyt4MmlGQzVFTFhYODJUc29jREJjdDdIa0tqTWNiclNl?=
 =?gb2312?B?NVlBQmFtSlVza2s3S1FvN04zaDdZc0NYKzRZVHBXcWhkV3pmUUhxSTE3QXdU?=
 =?gb2312?B?NkVOSWxSQVg3NU1CdGlvUU5hNVZSaFE3Tm02QlR4RldNdFpyQXhOcTUwelhh?=
 =?gb2312?B?aVdjYUdOb2NCU0o4UXV3Tm9xUytMQ0EyNlE4OExCMk1GUndVeGlMTCtISGpN?=
 =?gb2312?B?dU8vbHM2emk2OHd4bjFtVUpIbmhGanh6SDN2NkoxZkFzZnMxK01NV1NKdDB4?=
 =?gb2312?Q?o8q+s3vrQ7O9PVZPQKFPACVl50RkSS8mmbNLjdH?=
x-microsoft-antispam-prvs: <DB7PR04MB43005883A80C0C76115E0F17E6670@DB7PR04MB4300.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(136003)(199004)(189003)(13464003)(256004)(81166006)(8936002)(316002)(76176011)(110136005)(8676002)(106356001)(105586002)(26005)(25786009)(33656002)(55016002)(2501003)(2906002)(71190400001)(4326008)(6246003)(7736002)(74316002)(305945005)(186003)(97736004)(99286004)(6436002)(54906003)(81156014)(7696005)(478600001)(53936002)(6116002)(3846002)(11346002)(68736007)(486006)(446003)(229853002)(66066001)(14454004)(9686003)(569044001)(71200400001)(6506007)(86362001)(476003)(102836004)(53546011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4300;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: izLuGjOAHB7WNuXxy/ACEMxIqXT6WRxipDcUVhg+M8MrdLcPTz8rCU+AO/1LjUTejP04OYzBWR3dp70hVEcvop576Y/Da9nYAqz9PXUWPSsK8lrhvhqT2gPrZLzlJIeXBeMcfHj/fHlFhu8bseoaq6Z0eE5aoY9u5riSem4CSjQ4eIUuiNdP1WGoQRiXsVlnH29xtHTfVMCw1nDwZ7JXl/9YyrwBiRx6GbzgQhXUGS2h1dH+SlARVeujGq8XX8k8cJfxqNPeUKQibijDG1yAC3Fa4Jg/UqDsg6talsFQKxAPmwq6X8+v5Lh4o9GyRxHcwsvnIFv1xENF3i/k8fNl7b9Cavo7FV1nnJcs1DC2A7KUN1oL54S8GjtaFnPlYNY+nVFksC/gfosF0y5AMDQ4yD0pAmy6pPkAsiEmn2sjqgw=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b473e478-1bc4-44ad-ec94-08d69262e7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:58:00.9862
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
OcTqMdTCMTfI1SAxNDoyOA0KPiBUbzogbWtsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1jYW5Admdl
ci5rZXJuZWwub3JnDQo+IENjOiB3Z0BncmFuZGVnZ2VyLmNvbTsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51
eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSCAwLzNdIGNhbjogZmxleGNhbjog
YWRkIGlteDhxbSBzdXBwb3J0DQo+IA0KPiANCj4gS2luZGx5IFBpbmcuLi4NCj4gDQo+IEJlc3Qg
UmVnYXJkcywNCj4gSm9ha2ltIFpoYW5nDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogSm9ha2ltIFpoYW5nDQo+ID4gU2VudDogMjAxOMTqMTLUwjE5yNUgMTY6
MzkNCj4gPiBUbzogbWtsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1jYW5Admdlci5rZXJuZWwub3Jn
DQo+ID4gQ2M6IHdnQGdyYW5kZWdnZXIuY29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOw0KPiA+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54
cC5jb20+OyBKb2FraW0NCj4gPiBaaGFuZyA8cWlhbmdxaW5nLnpoYW5nQG54cC5jb20+DQo+ID4g
U3ViamVjdDogW1BBVENIIDAvM10gY2FuOiBmbGV4Y2FuOiBhZGQgaW14OHFtIHN1cHBvcnQNCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggc2V0IGludGVuZHMgdG8gYWRkIEZsZXhjYW4gc3VwcG9ydCBmb3Ig
aS5NWDhRTSBwbGF0Zm9ybQ0KPiA+IHdoaWNoIGRlZmF1bHRseSBzdXBwb3J0cyBDQU4gRkQgcHJv
dG9jb2wuIEFsdGhvdWdoIEJSUyBlbmFibGVkIGJ5DQo+ID4gc3lzdGVtIHJlc2V0IHdoZW4gdGhl
IGRyaXZlciBzZXRzIENBTiBGRCBtb2RlLCBub3cgdGhpcyBwYXRjaCBzZXJpYWwNCj4gPiBkb2Vz
IG5vdCBzdXBwb3J0IEJSUyBpbiB0aGUgZHJpdmVyLiBBbmQgdGhlbiBJIHdpbGwgc2VuZCBwYXRj
aCB0bw0KPiA+IGVuYWJsZSBCUlMgYnkgY2hhbmdpbmcgdGhlIHJlZ2lzdGVyIHRvIHNldCBiaXQg
dGltaW5nLg0KPiA+DQo+ID4gRG9uZyBBaXNoZW5nICgzKToNCj4gPiAgIGNhbjogcngtb2ZmbG9h
ZDogYWRkIENBTkZEIHN1cHBvcnQgYmFzZWQgb24gb2ZmbG9hZA0KPiA+ICAgY2FuOiBmbGV4Y2Fu
OiBhZGQgQ0FOIEZEIG1vZGUgc3VwcG9ydA0KPiA+ICAgY2FuOiBmbGV4Y2FuOiBhZGQgaW14OHFt
IHN1cHBvcnQNCj4gPg0KPiA+ICBkcml2ZXJzL25ldC9jYW4vZmxleGNhbi5jICAgICAgfCAxMTQN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2Nh
bi9yeC1vZmZsb2FkLmMgICB8ICAxNiArKystLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2Nhbi9yeC1v
ZmZsb2FkLmggfCAgIDQgKy0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxMTcgaW5zZXJ0aW9ucygr
KSwgMTcgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KDQo=
