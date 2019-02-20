Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E95C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CF0208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JLx4Ikbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfBTJJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:09:33 -0500
Received: from mail-eopbgr30079.outbound.protection.outlook.com ([40.107.3.79]:12957
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726155AbfBTJJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8o0KwoseZ7v4H1g4roqviCGy7khpT9T2aaFz//IbrpQ=;
 b=JLx4IkbueRcNNW1vTRKazBl4Mhn6SCmvdgSsUEL+PgvRYy8sN1Whp8Ey6bqkidTgyRcjw614JOk5v3ubOvRRw0rDgKg9Jf/DbVEbqoKYaIlJ1kFiuHDjp7C7q2qKHt9zevd9edkYOgryuL4XFgC0jHpx6vHTVN4vNCCTDvINkBY=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5997.eurprd04.prod.outlook.com (20.178.123.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 09:09:27 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::558f:3cb4:9a6a:8f84%4]) with mapi id 15.20.1643.014; Wed, 20 Feb 2019
 09:09:27 +0000
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
Thread-Index: AQHUtIYwnQmxzXZ3L0eB1kWs+99RWKXcoYiAgAB0axCAC3cJwA==
Date:   Wed, 20 Feb 2019 09:09:27 +0000
Message-ID: <VI1PR04MB44317749BC70B3F77321014EED7D0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190125081013.21663-1-peng.ma@nxp.com>
 <20190125081013.21663-2-peng.ma@nxp.com> <20190212190059.GA9272@suse.de>
 <VI1PR04MB44315EBEB2BD414FEF6B3547ED670@VI1PR04MB4431.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB44315EBEB2BD414FEF6B3547ED670@VI1PR04MB4431.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3be1e751-4cd0-43fb-521a-08d697131dba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5997;
x-ms-traffictypediagnostic: VI1PR04MB5997:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI1OTk3OzIzOlZSZVM0c1JpZXpIekhBaVk3bVBZWk1QY3pX?=
 =?utf-8?B?aHc3MFcyMjUraFgwak5VNWFjcmpZckFmRlNSTldsNFVRZXRic2tpTjZ4ZU9I?=
 =?utf-8?B?bkhBRXZUd0NBYmdidTJrTXRiTmRKTkM3ZS91a2ovQk0zTmt6Q0ZwMk91aktW?=
 =?utf-8?B?bVNYSnJRcU5vVGh4Q1pzKzl0RVdKZWJrR0pWMEp0NGRPZnNXajBmSW9yRmNR?=
 =?utf-8?B?bEJKeVRjUXZKUXpQVkMvdExINUx1YnU4MnI5dzVBQUJQVmY1U3l2aHVoejR5?=
 =?utf-8?B?OUQ2eHVRcFBpQ1NHTEJoQTZOT1d2ZEhiYTRCWDFHR2tLdFlZaFdVVFhYdTFz?=
 =?utf-8?B?V0dMWWxWaW9wRmt3Smdid05oYVJ2Y05Td2Q3SmxOZ2ttbHdWWGM3SjNyTm1l?=
 =?utf-8?B?N3hYMFN5MitybVRIUGdURU5pOVVQb3lDRERYelJzRzB3aUdpcjVzOFZNV1Z6?=
 =?utf-8?B?OEdCci9KNkhxa09OaVMwekZGSG5VbUFteDBKV0tFTzBHdTBXNjVySllPcXk4?=
 =?utf-8?B?WVdUWXpMc1pFbEFObDFoZStpS2paT2l1MEkrNUVNcDlLQk04M0FRa2RHSW5H?=
 =?utf-8?B?Mm5WdUE5YUlaMHNmN2hidUlSelRzMFNJRERDcFc4dElTajQweE5KN2VwYytV?=
 =?utf-8?B?NkI1QkFFSzhuMWlIYXBZSHMzZzJkMkROWi80UytJOU8wcHJZb3F6cUVyMmdD?=
 =?utf-8?B?TkFiWVZnZ0dzWktveXljOGY5NTA3WEF3UlpmVGNWeHhuUGdFN3poT1ZlbUUx?=
 =?utf-8?B?VFJtbWRDRkJPMDY4Y2hrak51UFd6L2MyV2NZcHJFRVlKTkM3MDVvQVJYNXoz?=
 =?utf-8?B?Szc4ZDdwK0wyWkhvT0FPZjJSMUhrdG9JZTRJK01uQmdqNkFheUU4Qkd6ckJR?=
 =?utf-8?B?K1FjdlJqYmNZMWxVcmZuUG52ZkJ2dkgxUmxzb29xYVkweVBCdXFlYU9LSk1K?=
 =?utf-8?B?MnQ5YWJEbkw0c1BRUURoM3hYUytYWmlyMnpNMzdqWmtKN1J5TmU4UlN2YVFa?=
 =?utf-8?B?a245YmpnRWdMOFZSTUJjd3hCV3lLM1VQTytvVk5XVE9zM2lYWmI1dmdvM1g3?=
 =?utf-8?B?cmJvdnpkbmNXV29RMzJDQmZJNDk3SExVQkp3NXFXOGpUUVhuVHZod2VCMEFh?=
 =?utf-8?B?S0dCSi9NVDVlUWp1NEpCYTlzMXBISkJSOXNzZHFHQzQ5cnV1aEU5bURwam1m?=
 =?utf-8?B?YXNlb0RzcUVxWE5SUVpQM3NQUmsrYTJiQzBqTXVCYnJUN0czZ3YyM0kzY0ox?=
 =?utf-8?B?MGdTaTNGeDA5YlQwRUpLMEZnVlNYb0tUVlBZZDNoVnI3KzVLbjllQ3A5Vkho?=
 =?utf-8?B?VXQ5MVhURFVTS3dGR2Y3dDdpYjB4RFFOTXBkc1dycTFpZGdtWkNoczBYa092?=
 =?utf-8?B?Y2JvZU81TTQzdkVyK2dTS2pmMjBiTmZqRDZPN0tYaWdIVWhUU3VXUWZib0dy?=
 =?utf-8?B?VkRSOXJjc0I5cWJ3YXJoNUhNaUg0VWVYeERsK0VxOFdyY1BnVDRGdnR5dUpa?=
 =?utf-8?B?MDRPdE9xT3V6clBMZ2RSdXFrZVF6TGR4Z2lsc3RMSEc4R01lbG0zblpaTFVW?=
 =?utf-8?B?NFlkaGpUMndxbkxtU2g3Z1N0c0svOGhBaHJiUEFTQWljTE9VOWp5UzVWZFVy?=
 =?utf-8?B?NFpUcFFEYlAzSjBiVTdiUFNPblI3T2w5NnMyajhGUFM1bFF0NUF4RGw0eXNz?=
 =?utf-8?Q?UGEwbIsqWOj1J5kKF4b6iZOfzyfhRHhbUmCqK9v?=
x-microsoft-antispam-prvs: <VI1PR04MB59970A7A3E126039C163BD6DED7D0@VI1PR04MB5997.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(376002)(366004)(396003)(346002)(13464003)(199004)(189003)(9686003)(44832011)(102836004)(99286004)(68736007)(11346002)(446003)(478600001)(486006)(476003)(54906003)(53936002)(55016002)(8936002)(6436002)(93886005)(6916009)(229853002)(316002)(76176011)(6506007)(7696005)(86362001)(14444005)(256004)(71190400001)(5660300002)(2906002)(71200400001)(33656002)(105586002)(106356001)(4326008)(25786009)(6246003)(66066001)(8676002)(81156014)(81166006)(186003)(14454004)(305945005)(7736002)(6116002)(74316002)(3846002)(97736004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5997;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rxK/Qs042ZN+1aoJEZipmIpTE/RHRsWo3+b3s/3qH4pzPrB2aPUxW1+unBz5s6pooOUqoC2bW7kfCwIyODbv6gOrbskRDIEZJeRBE7KukOWzogUVQt1XcGZXd8nwImfzlZjqn/sYjYiQ4LizX4S3l2kqGD3wrcvikNLe2rpXSMWORbWeHzKzlOW5Gn/jehp69EczBTgQ5PMksczV85BpeDu5POt5kD2hDDjShBYcMijPDpIWDBlMaYQ8YvqZ991x2d3tYt6EX53yjrCt/L8yHLtq4d99p66qYgPcRBZNRsDzEvlzVYSsTGGjSA2V893c/5KizFXMRRZ9uYE0AdgjAh6U6e/1ukebCD9U0JbXDAOk0Bll1+WSYlTMM/4OpUsQY8WnzG1aR6zHAXmLXCTmfwH2JDI3hC18j3hXYiKd71o=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be1e751-4cd0-43fb-521a-08d697131dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 09:09:27.7475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5997
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgWW91c2FmLA0KDQpUbyBzZXQgc2F0YSBiaXQgb2YgZWNjLWFkZHIgd2lsbCBhZmZlY3QgYWxs
IHNhdGEgY29udHJvbGxlcnMsIFRoZSB2NiBwYXRjaCBoYXMgYmVlbiBzZW50IHdpbGwgZml4ZWQg
dGhlIHJlbWFwIGVycm9yIHdoZW4gdHdvIG9yIG1vcmUgc2F0YSBjb250cm9sbGVycyBiZSBwcm9i
ZWQsIHBsZWFzZSByZXZpZXcuDQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCj4tLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBlbmcgTWENCj5TZW50OiAyMDE55bm0Muac
iDE05pelIDE3OjE5DQo+VG86ICdNaWFuIFlvdXNhZiBLYXVrYWInIDx5a2F1a2FiQHN1c2UuZGU+
DQo+Q2M6IGF4Ym9lQGtlcm5lbC5kazsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJu
ZWwub3JnOw0KPm1hcmsucnV0bGFuZEBhcm0uY29tOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+bGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmc7DQo+bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnOyBBbmR5IFRhbmcNCj48YW5keS50YW5nQG54cC5jb20+DQo+U3ViamVj
dDogUkU6IFt2NSAyLzJdIGFybTY0OiBkdHM6IGx4MjE2MGE6IGFkZCBzYXRhIG5vZGUgc3VwcG9y
dA0KPg0KPg0KPg0KPj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj5Gcm9tOiBNaWFuIFlv
dXNhZiBLYXVrYWIgPHlrYXVrYWJAc3VzZS5kZT4NCj4+U2VudDogMjAxOeW5tDLmnIgxM+aXpSAz
OjAxDQo+PlRvOiBQZW5nIE1hIDxwZW5nLm1hQG54cC5jb20+DQo+PkNjOiBheGJvZUBrZXJuZWwu
ZGs7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4+bWFyay5ydXRs
YW5kQGFybS5jb207IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4+bGludXgtaWRlQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+PmxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4+QW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4+U3ViamVjdDogUmU6IFt2NSAyLzJd
IGFybTY0OiBkdHM6IGx4MjE2MGE6IGFkZCBzYXRhIG5vZGUgc3VwcG9ydA0KPj4NCj4+T24gRnJp
LCBKYW4gMjUsIDIwMTkgYXQgMDg6MTA6MTNBTSArMDAwMCwgUGVuZyBNYSB3cm90ZToNCj4+PiBB
ZGQgU0FUQSBkZXZpY2Ugbm9kZXMgZm9yIGZzbC1seDIxNjBhIGFuZCBlbmFibGUgc3VwcG9ydCBm
b3IgUURTIGFuZA0KPj4+IFJEQiBib2FyZHMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBQZW5n
IE1hIDxwZW5nLm1hQG54cC5jb20+DQo+Pj4gLS0tDQo+Pj4gY2hhbmdlZCBmb3IgVjU6DQo+Pj4g
CS0gbm8gY2hhbmdlDQo+Pj4NCj4+PiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWx4MjE2MGEtcWRzLmR0cyB8ICAgMTYgKysrKysrKw0KPj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzIHwgICAxNiArKysrKysrDQo+Pj4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgICAgfCAgIDQ0DQo+Pisr
KysrKysrKysrKysrKysrKysrKw0KPj4+ICAzIGZpbGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMo
KyksIDAgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcWRzLmR0cw0KPj4+IGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtcWRzLmR0cw0KPj4+IGluZGV4IDk5YTIyYWIuLjFh
NWFjZjYgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWx4MjE2MGEtcWRzLmR0cw0KPj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjBhLXFkcy5kdHMNCj4+PiBAQCAtOTUsNiArOTUsMjIgQEANCj4+PiAgCX07DQo+
Pj4gIH07DQo+Pj4NCj4+PiArJnNhdGEwIHsNCj4+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+PiAr
fTsNCj4+PiArDQo+Pj4gKyZzYXRhMSB7DQo+Pj4gKwlzdGF0dXMgPSAib2theSI7DQo+Pj4gK307
DQo+Pj4gKw0KPj4+ICsmc2F0YTIgew0KPj4+ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4+ICt9Ow0K
Pj4+ICsNCj4+PiArJnNhdGEzIHsNCj4+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+PiArfTsNCj4+
PiArDQo+Pj4gICZ1YXJ0MCB7DQo+Pj4gIAlzdGF0dXMgPSAib2theSI7DQo+Pj4gIH07DQo+Pj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJk
Yi5kdHMNCj4+PiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJk
Yi5kdHMNCj4+PiBpbmRleCA2NDgxZTVmLi41YjY3OTllIDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLXJkYi5kdHMNCj4+PiArKysgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1yZGIuZHRzDQo+Pj4gQEAg
LTEwMiw2ICsxMDIsMjIgQEANCj4+PiAgCX07DQo+Pj4gIH07DQo+Pj4NCj4+PiArJnNhdGEwIHsN
Cj4+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+PiArfTsNCj4+PiArDQo+Pj4gKyZzYXRhMSB7DQo+
Pj4gKwlzdGF0dXMgPSAib2theSI7DQo+Pj4gK307DQo+Pj4gKw0KPj4+ICsmc2F0YTIgew0KPj4+
ICsJc3RhdHVzID0gIm9rYXkiOw0KPj4+ICt9Ow0KPj4+ICsNCj4+PiArJnNhdGEzIHsNCj4+PiAr
CXN0YXR1cyA9ICJva2F5IjsNCj4+PiArfTsNCj4+PiArDQo+Pj4gICZ1YXJ0MCB7DQo+Pj4gIAlz
dGF0dXMgPSAib2theSI7DQo+Pj4gIH07DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+PiBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4+PiBpbmRleCBhNzlmNWMxLi41OTIwMzRi
IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIx
NjBhLmR0c2kNCj4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgy
MTYwYS5kdHNpDQo+Pj4gQEAgLTY3MSw2ICs2NzEsNTAgQEANCj4+PiAgCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCj4+PiAgCQl9Ow0KPj4+DQo+Pj4gKwkJc2F0YTA6IHNhdGFAMzIwMDAwMCB7DQo+
Pj4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtYWhjaSI7DQo+Pj4gKwkJCXJlZyA9IDww
eDAgMHgzMjAwMDAwIDB4MCAweDEwMDAwPiwNCj4+PiArCQkJICAgICAgPDB4NyAweDEwMDUyMCAw
eDAgMHg0PjsNCj4+PiArCQkJcmVnLW5hbWVzID0gImFoY2kiLCAic2F0YS1lY2MiOw0KPj4+ICsJ
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTMzIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4+ICsJ
CQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47DQo+Pj4gKwkJCWRtYS1jb2hlcmVudDsNCj4+PiAr
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+PiArCQl9Ow0KPj4+ICsNCj4+PiArCQlzYXRhMTog
c2F0YUAzMjEwMDAwIHsNCj4+PiArCQkJY29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1haGNpIjsN
Cj4+PiArCQkJcmVnID0gPDB4MCAweDMyMTAwMDAgMHgwIDB4MTAwMDA+LA0KPj4+ICsJCQkgICAg
ICA8MHg3IDB4MTAwNTIwIDB4MCAweDQ+Ow0KPj4+ICsJCQlyZWctbmFtZXMgPSAiYWhjaSIsICJz
YXRhLWVjYyI7DQo+Pj4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMzYgSVJRX1RZUEVfTEVW
RUxfSElHSD47DQo+Pj4gKwkJCWNsb2NrcyA9IDwmY2xvY2tnZW4gNCAzPjsNCj4+PiArCQkJZG1h
LWNvaGVyZW50Ow0KPj4+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4+ICsJCX07DQo+Pj4g
Kw0KPj4+ICsJCXNhdGEyOiBzYXRhQDMyMjAwMDAgew0KPj4+ICsJCQljb21wYXRpYmxlID0gImZz
bCxseDIxNjBhLWFoY2kiOw0KPj4+ICsJCQlyZWcgPSA8MHgwIDB4MzIyMDAwMCAweDAgMHgxMDAw
MD4sDQo+Pj4gKwkJCSAgICAgIDwweDcgMHgxMDA1MjAgMHgwIDB4ND47DQo+Pj4gKwkJCXJlZy1u
YW1lcyA9ICJhaGNpIiwgInNhdGEtZWNjIjsNCj4+PiArCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDk3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPj4+ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQg
Mz47DQo+Pj4gKwkJCWRtYS1jb2hlcmVudDsNCj4+PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
Cj4+PiArCQl9Ow0KPj4+ICsNCj4+PiArCQlzYXRhMzogc2F0YUAzMjMwMDAwIHsNCj4+PiArCQkJ
Y29tcGF0aWJsZSA9ICJmc2wsbHgyMTYwYS1haGNpIjsNCj4+PiArCQkJcmVnID0gPDB4MCAweDMy
MzAwMDAgMHgwIDB4MTAwMDA+LA0KPj4+ICsJCQkgICAgICA8MHg3IDB4MTAwNTIwIDB4MCAweDQ+
Ow0KPj5Zb3UgYXJlIHVzaW5nIHNhbWUgcmVnIHZhbHVlcyBmb3Igc2F0YS1lY2MgaW4gYWxsIHNh
dGEgaW5zdGFuY2VzLiBEb2VzDQo+PnRoaXMgYWN0dWFsbHkgd29yaz8gTm8gZXJyb3JzIHdoZW4g
dGhlIGFoY2lfcW9yaXEgZHJpdmVyIGRvIGlvcmVtYXAgb24NCj4+aXQgd2hpbGUgcHJvYmluZyBz
ZWNvbmQgaW5zdGFuY2UgYW5kIG9ud2FyZD8NCj4+DQo+IFRoYW5rcyBmb3IgeW91IHBvaW50IG91
dCB0aGUgcHJvYmxlbS4gSSB3aWxsIGZpeGVkIGl0IHdpdGggdHdvIG9yIG1vcmUgc2F0YQ0KPmVu
YWJsZS4NCj4+ZnNsLWxzMjA4eGEuZHRzaSBpcyB0aGUgb25seSBvdGhlciBmaWxlIGhlcmUgd2l0
aCBtdWx0aXBsZSBzYXRhDQo+Pmluc3RhbmNlcyBhbmQgaXQgZG9lc27igJl0IGNhcmUgYWJvdXQg
c2F0YS1lY2MuDQo+Pg0KPlRoZSBsczIwOHhhIHBsYXRmb3JtcyBpcyBub3QgbmVjZXNzYXJ5IHRv
IHNldCBzYXRhLWVjYyBhZGRyLg0KPkJSLA0KPlBlbmcNCj4+PiArCQkJcmVnLW5hbWVzID0gImFo
Y2kiLCAic2F0YS1lY2MiOw0KPj4+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMTAwIElSUV9U
WVBFX0xFVkVMX0hJR0g+Ow0KPj4+ICsJCQljbG9ja3MgPSA8JmNsb2NrZ2VuIDQgMz47DQo+Pj4g
KwkJCWRtYS1jb2hlcmVudDsNCj4+PiArCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4+PiArCQl9
Ow0KPj4+ICsNCj4+PiAgCQlzbW11OiBpb21tdUA1MDAwMDAwIHsNCj4+PiAgCQkJY29tcGF0aWJs
ZSA9ICJhcm0sbW11LTUwMCI7DQo+Pj4gIAkJCXJlZyA9IDwwIDB4NTAwMDAwMCAwIDB4ODAwMDAw
PjsNCj4+DQo+PkJSLA0KPj5Zb3VzYWYNCg==
