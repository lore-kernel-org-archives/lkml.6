Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65E9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B36C2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RkQtIjZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436911AbfBNJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:18:51 -0500
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:2304
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2395057AbfBNJSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toDarl+sYyzZ7dCTlADxYIg0deo18M7uumFyleP5Wec=;
 b=RkQtIjZrRGysOXt6Iuc0uhcjEjVQC+q3pWB/qwf9LM7O9BliXZywGOUA79EXJFWWNASN4dfOL9ZLCG9EsEhkQRM2tszYcSeav1xEKWK1qqc0G+WEruC9vL495XMRPpQmwEYsEYXo8vfI05HesuQ7Ecjpw2wY4FBM4VlnRG7sff0=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB3117.eurprd04.prod.outlook.com (10.170.229.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Thu, 14 Feb 2019 09:18:46 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84%4]) with mapi id 15.20.1622.016; Thu, 14 Feb 2019
 09:18:46 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Mian Yousaf Kaukab <ykaukab@suse.de>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andy Tang <andy.tang@nxp.com>
Subject: RE: [v5 2/2] arm64: dts: lx2160a: add sata node support
Thread-Topic: [v5 2/2] arm64: dts: lx2160a: add sata node support
Thread-Index: AQHUtIYwnQmxzXZ3L0eB1kWs+99RWKXcoYiAgAB0axA=
Date:   Thu, 14 Feb 2019 09:18:45 +0000
Message-ID: <VI1PR04MB44315EBEB2BD414FEF6B3547ED670@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com> <20190212190059.GA9272@suse.de>
In-Reply-To: <20190212190059.GA9272@suse.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecd2faca-eed9-40cc-fbf3-08d6925d6c0c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3117;
x-ms-traffictypediagnostic: VI1PR04MB3117:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIzMTE3OzIzOjRiclZWQXdYOE1QUEN6NE9KRFBnMWxVOERL?=
 =?utf-8?B?VG9CRW4wRy9DVDRVMExEMDdiREtFR2I3YXNCTUp0TTM1NlRLVzFYNGtJL3hj?=
 =?utf-8?B?SUp4Q1ZFRGowNVVacmZVN0VEQmozdW1FNVhDV1lWVkFMMlVmaUpUUnYrSzlT?=
 =?utf-8?B?S1BkZjA5T3Bya3JrYkFBVWoyUGM4UFZ6SThGOUFYaHBJVEtlTHBhdXVIQkgr?=
 =?utf-8?B?QnZ5MGRuZmpQM2RGT2dCbFJuRkRvYm9CRVNRa1dmNW5ZbkVpNlNUSnpKQ2hh?=
 =?utf-8?B?WHllaU9DMlhiQXdaaWVJcEhvK3dkaTlzem1qSVBzczZ2UXRhVW5WUVpLa2Yw?=
 =?utf-8?B?U1VOL3lSSUJxRmNkck81bUk5RTV4ems5SXRiTWY0amRtS0VWaDIzMVluUHY2?=
 =?utf-8?B?T1Z2UGhCVXMyc3JsdDM5dzlBZjY0MHRDS05ZUVQ1bGhqTGVZVEI1Z3BDRXk1?=
 =?utf-8?B?ZDhaaytWNk9RZjZmTmtGcGY0U0dyd3Q2b3dSSzNIc1BuSEh2aGFUNklKRERT?=
 =?utf-8?B?aEEzek52RW9qNDl6b1RnTnA2eXU5ek5TYXlSVHU1K2htWjlzaUhCUWx2VS8w?=
 =?utf-8?B?SWs0MEUrUHNJUzdmQnZwMjJTb3UyYlhhYXpBKzVvdXZVVHVKa1NpMjBieWhr?=
 =?utf-8?B?NndnaWFvYzFrY3AxQnMrYjNXK21sTU9PRTZxQTVjR0ZCM2xrZXBCUVRlTGhX?=
 =?utf-8?B?TXN0QmdiYyt2aXd1Q1hSRUdSRGdjWkJEcDRXUHVpSGt5M3NUKzFiMlE0RktX?=
 =?utf-8?B?SWs4a29ib1hOV1ZEdk1ESU9iaFNnVmlQcWVTUzZ5NTF4QXArWFN6d0tsc2ow?=
 =?utf-8?B?NnFQMzBpMlZ6aTVuYUIybW9FZXlhODh3Mmg0ZWp4TWNHcDJVMlQwcEJmY2dF?=
 =?utf-8?B?UklneFp1Mm1LekY1LzFqbHl2M0NOWjVoWUtyS09RMndrcmJtMTNUK0t6dXly?=
 =?utf-8?B?YnFhWlNwb0o2aHp3dWtHdFJ3ZE1NdGc4SU1oUXVmZGNTUlRndzNQNjBHb3lV?=
 =?utf-8?B?ZC8yVWFaSVp4ckU3RnFYdHYzUGVqQ00zalpoVGw4cm1wMUVNMUJDSkNZQjYx?=
 =?utf-8?B?SlVlNkIxUE9WbXNaUEhQYU5tMHdhTHV5NXlEemFRMFJnSTNHc2FpNHM4SlpT?=
 =?utf-8?B?T3NuRU5FdEprSkNTbE96TUZRdUNmZmJ0MUFQaTIrQ3Z1T015Zld1NlpVSWE2?=
 =?utf-8?B?UlM3dWpQa3g0RFhVOW9IcEd0ZWRHeS85eWgrTWQ5dVJwQ2dHR1k4bzQzOGgz?=
 =?utf-8?B?SDZ2dXRPL0hoR2pMMXpWUmY2OHN6ZEdPdjJPLzBDK0Fkb0RlbG96WVlHbXpY?=
 =?utf-8?B?L0FEb0RhSmxOaHpyZXZ1VURUR2wzZk5aL3FnV3JGT2wxNzFqRlFOcWprTVZK?=
 =?utf-8?B?QjFlcjdST2xXK3h5ZDBHVG13Y1hDYXl5T0FoSkxOOGRFcjBvWWZabUl3UU5H?=
 =?utf-8?B?Y1ZrdksyTU9pOC9IandhLzVlQXdrdW1PZ0NGTnpjR2JJMGhaeitSbGRydzBS?=
 =?utf-8?B?VFZ0KzVaSXlCM3l2eGJzU2FCRjh4dW1YVElwSVB5UjhLUDJwRTlIaGVpTnYr?=
 =?utf-8?B?aDhOc2Vlc3V0dlN4N2dBZDBQV04xUlExYTJIMTVkTkc1anVkeUNBQkFrVk9o?=
 =?utf-8?B?cFVmZGIzb3VrUUVDdmp6bHdVVkhsUm9tT01KZk14MjlYTVY3QVBLNVhRPT0=?=
x-microsoft-antispam-prvs: <VI1PR04MB3117561259AE14BF98C3C79CED670@VI1PR04MB3117.eurprd04.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(396003)(376002)(366004)(13464003)(199004)(189003)(106356001)(33656002)(74316002)(6246003)(11346002)(446003)(9686003)(66066001)(3846002)(6116002)(478600001)(7736002)(6916009)(305945005)(486006)(476003)(14444005)(256004)(105586002)(53936002)(2906002)(14454004)(6506007)(6436002)(102836004)(8936002)(54906003)(81156014)(55016002)(4326008)(86362001)(81166006)(76176011)(8676002)(26005)(99286004)(7696005)(71190400001)(71200400001)(25786009)(97736004)(68736007)(186003)(44832011)(316002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3117;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a64UPY3+jq7c9cbs6FAu9wscHYNxA+Y5l6ZxIF3zxohcIiAnw77o5PLNso83c4Py758EAYUlUz8BWgs+VIOkhUUYJRcf83WjNC5vlJziDLmkj4TY6ET1jIE8yNADK+EvdOldtpCqJIWPEr+c2gwfXOKM34Cw6OZv1dNWs4xXId4VwzfG2SogP3F+PC+E512pFH4LQS8kIvjVuoRaFUNmaAitFOwMxMxWy0AlOWQa9nVphO1FgpbRDgpKxeL/1vTHprtnK95dX8gGQ/M6Omz4eKjWGexYigdoUuwPlTYOumW0J8CRIXTgmMrSDVB3KHk7SqyNTgaqcnu071OcTy22pxFYA2WM6r+zjRehYXydqW5FhooCXRdriAUr2A5x6/bkGheds9TxI9nXMxk40OjxcCgPYQqlIbguO7IIx6r/GCE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd2faca-eed9-40cc-fbf3-08d6925d6c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 09:18:46.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pYW4gWW91c2FmIEthdWth
YiA8eWthdWthYkBzdXNlLmRlPg0KPlNlbnQ6IDIwMTnlubQy5pyIMTPml6UgMzowMQ0KPlRvOiBQ
ZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+Q2M6IGF4Ym9lQGtlcm5lbC5kazsgc2hhd25ndW9A
a2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPm1hcmsucnV0bGFuZEBhcm0uY29tOyBM
ZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+bGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBBbmR5IFRhbmcNCj48YW5k
eS50YW5nQG54cC5jb20+DQo+U3ViamVjdDogUmU6IFt2NSAyLzJdIGFybTY0OiBkdHM6IGx4MjE2
MGE6IGFkZCBzYXRhIG5vZGUgc3VwcG9ydA0KPg0KPk9uIEZyaSwgSmFuIDI1LCAyMDE5IGF0IDA4
OjEwOjEzQU0gKzAwMDAsIFBlbmcgTWEgd3JvdGU6DQo+PiBBZGQgU0FUQSBkZXZpY2Ugbm9kZXMg
Zm9yIGZzbC1seDIxNjBhIGFuZCBlbmFibGUgc3VwcG9ydCBmb3IgUURTIGFuZA0KPj4gUkRCIGJv
YXJkcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+
PiAtLS0NCj4+IGNoYW5nZWQgZm9yIFY1Og0KPj4gCS0gbm8gY2hhbmdlDQo+Pg0KPj4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFkcy5kdHMgfCAgIDE2ICsrKysr
KysNCj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRz
IHwgICAxNiArKysrKysrDQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4
MjE2MGEuZHRzaSAgICB8ICAgNDQNCj4rKysrKysrKysrKysrKysrKysrKysNCj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFkcy5kdHMN
Cj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcWRzLmR0cw0K
Pj4gaW5kZXggOTlhMjJhYi4uMWE1YWNmNiAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFkcy5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXFkcy5kdHMNCj4+IEBAIC05NSw2ICs5NSwy
MiBAQA0KPj4gIAl9Ow0KPj4gIH07DQo+Pg0KPj4gKyZzYXRhMCB7DQo+PiArCXN0YXR1cyA9ICJv
a2F5IjsNCj4+ICt9Ow0KPj4gKw0KPj4gKyZzYXRhMSB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsN
Cj4+ICt9Ow0KPj4gKw0KPj4gKyZzYXRhMiB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICt9
Ow0KPj4gKw0KPj4gKyZzYXRhMyB7DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+ICt9Ow0KPj4g
Kw0KPj4gICZ1YXJ0MCB7DQo+PiAgCXN0YXR1cyA9ICJva2F5IjsNCj4+ICB9Ow0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMN
Cj4+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcmRiLmR0cw0K
Pj4gaW5kZXggNjQ4MWU1Zi4uNWI2Nzk5ZSAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4+IEBAIC0xMDIsNiArMTAy
LDIyIEBADQo+PiAgCX07DQo+PiAgfTsNCj4+DQo+PiArJnNhdGEwIHsNCj4+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPj4gK307DQo+PiArDQo+PiArJnNhdGExIHsNCj4+ICsJc3RhdHVzID0gIm9rYXki
Ow0KPj4gK307DQo+PiArDQo+PiArJnNhdGEyIHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4g
K307DQo+PiArDQo+PiArJnNhdGEzIHsNCj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4gK307DQo+
PiArDQo+PiAgJnVhcnQwIHsNCj4+ICAJc3RhdHVzID0gIm9rYXkiOw0KPj4gIH07DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0K
Pj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQo+PiBp
bmRleCBhNzlmNWMxLi41OTIwMzRiIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0KPj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaQ0KPj4gQEAgLTY3MSw2ICs2NzEsNTAgQEANCj4+
ICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gIAkJfTsNCj4+DQo+PiArCQlzYXRhMDogc2F0
YUAzMjAwMDAwIHsNCj4+ICsJCQljb21wYXRpYmxlID0gImZzbCxseDIxNjBhLWFoY2kiOw0KPj4g
KwkJCXJlZyA9IDwweDAgMHgzMjAwMDAwIDB4MCAweDEwMDAwPiwNCj4+ICsJCQkgICAgICA8MHg3
IDB4MTAwNTIwIDB4MCAweDQ+Ow0KPj4gKwkJCXJlZy1uYW1lcyA9ICJhaGNpIiwgInNhdGEtZWNj
IjsNCj4+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTMzIElSUV9UWVBFX0xFVkVMX0hJR0g+
Ow0KPj4gKwkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gNCAzPjsNCj4+ICsJCQlkbWEtY29oZXJlbnQ7
DQo+PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICsJCX07DQo+PiArDQo+PiArCQlzYXRh
MTogc2F0YUAzMjEwMDAwIHsNCj4+ICsJCQljb21wYXRpYmxlID0gImZzbCxseDIxNjBhLWFoY2ki
Ow0KPj4gKwkJCXJlZyA9IDwweDAgMHgzMjEwMDAwIDB4MCAweDEwMDAwPiwNCj4+ICsJCQkgICAg
ICA8MHg3IDB4MTAwNTIwIDB4MCAweDQ+Ow0KPj4gKwkJCXJlZy1uYW1lcyA9ICJhaGNpIiwgInNh
dGEtZWNjIjsNCj4+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTM2IElSUV9UWVBFX0xFVkVM
X0hJR0g+Ow0KPj4gKwkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gNCAzPjsNCj4+ICsJCQlkbWEtY29o
ZXJlbnQ7DQo+PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+ICsJCX07DQo+PiArDQo+PiAr
CQlzYXRhMjogc2F0YUAzMjIwMDAwIHsNCj4+ICsJCQljb21wYXRpYmxlID0gImZzbCxseDIxNjBh
LWFoY2kiOw0KPj4gKwkJCXJlZyA9IDwweDAgMHgzMjIwMDAwIDB4MCAweDEwMDAwPiwNCj4+ICsJ
CQkgICAgICA8MHg3IDB4MTAwNTIwIDB4MCAweDQ+Ow0KPj4gKwkJCXJlZy1uYW1lcyA9ICJhaGNp
IiwgInNhdGEtZWNjIjsNCj4+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgOTcgSVJRX1RZUEVf
TEVWRUxfSElHSD47DQo+PiArCQkJY2xvY2tzID0gPCZjbG9ja2dlbiA0IDM+Ow0KPj4gKwkJCWRt
YS1jb2hlcmVudDsNCj4+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKwkJfTsNCj4+ICsN
Cj4+ICsJCXNhdGEzOiBzYXRhQDMyMzAwMDAgew0KPj4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGx4
MjE2MGEtYWhjaSI7DQo+PiArCQkJcmVnID0gPDB4MCAweDMyMzAwMDAgMHgwIDB4MTAwMDA+LA0K
Pj4gKwkJCSAgICAgIDwweDcgMHgxMDA1MjAgMHgwIDB4ND47DQo+WW91IGFyZSB1c2luZyBzYW1l
IHJlZyB2YWx1ZXMgZm9yIHNhdGEtZWNjIGluIGFsbCBzYXRhIGluc3RhbmNlcy4gRG9lcyB0aGlz
DQo+YWN0dWFsbHkgd29yaz8gTm8gZXJyb3JzIHdoZW4gdGhlIGFoY2lfcW9yaXEgZHJpdmVyIGRv
IGlvcmVtYXAgb24gaXQgd2hpbGUNCj5wcm9iaW5nIHNlY29uZCBpbnN0YW5jZSBhbmQgb253YXJk
Pw0KPg0KIFRoYW5rcyBmb3IgeW91IHBvaW50IG91dCB0aGUgcHJvYmxlbS4gSSB3aWxsIGZpeGVk
IGl0IHdpdGggdHdvIG9yIG1vcmUgc2F0YSBlbmFibGUuDQo+ZnNsLWxzMjA4eGEuZHRzaSBpcyB0
aGUgb25seSBvdGhlciBmaWxlIGhlcmUgd2l0aCBtdWx0aXBsZSBzYXRhIGluc3RhbmNlcyBhbmQg
aXQNCj5kb2VzbuKAmXQgY2FyZSBhYm91dCBzYXRhLWVjYy4NCj4NClRoZSBsczIwOHhhIHBsYXRm
b3JtcyBpcyBub3QgbmVjZXNzYXJ5IHRvIHNldCBzYXRhLWVjYyBhZGRyLg0KQlIsDQpQZW5nDQo+
PiArCQkJcmVnLW5hbWVzID0gImFoY2kiLCAic2F0YS1lY2MiOw0KPj4gKwkJCWludGVycnVwdHMg
PSA8R0lDX1NQSSAxMDAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+PiArCQkJY2xvY2tzID0gPCZj
bG9ja2dlbiA0IDM+Ow0KPj4gKwkJCWRtYS1jb2hlcmVudDsNCj4+ICsJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPj4gKwkJfTsNCj4+ICsNCj4+ICAJCXNtbXU6IGlvbW11QDUwMDAwMDAgew0KPj4g
IAkJCWNvbXBhdGlibGUgPSAiYXJtLG1tdS01MDAiOw0KPj4gIAkJCXJlZyA9IDwwIDB4NTAwMDAw
MCAwIDB4ODAwMDAwPjsNCj4NCj5CUiwNCj5Zb3VzYWYNCg==
