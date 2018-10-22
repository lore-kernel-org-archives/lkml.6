Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C021ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54122083C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SCN8rI33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54122083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJVJ7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:59:49 -0400
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:43884
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbeJVJ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQeWlJxD9EauiDIB7iCGOrk1HfSzkO6wonRqab8j5AU=;
 b=SCN8rI33y5+qgcC/4uTvA00oSAG9okc1+B8K0U6ZkKwW7ljg7DtFad3+gUN9e9KsyDVM1SQlTeDNt9pCnZkmspNV/tfvGiRnNZmyhzzOubA3uUkJ1P1dMOtrzpjdlNZS2jQxpcHLsBArXMs1bEf+7y+HEJJEGYCGTv3tHI3igEk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.20; Mon, 22 Oct 2018 01:43:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::ddfd:3571:1813:2ee4%3]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 01:43:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] thermal: imx: improve error message
Thread-Topic: [PATCH 1/2] thermal: imx: improve error message
Thread-Index: AQHUS2fDDgOCVSUxtEuXx9Y8c/3aYqUbVnTQgA9j6oA=
Date:   Mon, 22 Oct 2018 01:43:21 +0000
Message-ID: <DB3PR0402MB39167401447D80C62A427BB5F5F40@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
 <3ef674ab-6152-dc77-6c5e-5d5d23642a9f@linaro.org>
 <DB3PR0402MB3916867EF2740736050170CAF5E20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916867EF2740736050170CAF5E20@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB3PR0402MB3707;6:x4w0KlN9PjLw9XyjdZwfBH35y95JqZrXc1R5gW/zmHnNIymNCoXWTsT586SCkVhaqx3bBYC4GBvfNIbW2UR8cEuZnu8VxeHjHrBw/KVAa20psHLubPuPq29XX1hLhAOYgSPHENwM1nqf2qvKD0A3rs3nBQogixrkLE70V9gzOvDa3Vqye7V7pGkJ7SjH0Xqsclw85917JjV1y2pVY2JA9zZUxCuSJzXfX02F5i4GmmppBwY8FHXHxyzZTGfydk0ms3zuQmNB5glzvBL9RM7np6u3QXAyuF8TMh8/4hPUqkA6lFCAQJHXzixdOxB4PqdKyYM4iTaOxC3Rx1/viDPn59QlIZLn/oXrQPc4FaRcW825Bya5Z9FJsKj0qiCegF/Ty7KLjVa1JW8W5eH9dI84SeoPBGyAknqezLi4iu1smSwDzEvu1EeLrU0116u3YoqEpIbxgnGw0vWJtDEDZxSzfw==;5:JO69R9Ugx4YQ1MUxp3dhlX641DPVSTZSwou8INISrJOrn3RgX2doTODIg1o4M3ljuGlCO7K2tJmux6TEGLWoK2TRLBiPH5GEuFx0Onw4XEVsp3nc8B/Uij83EOPrUdgI5Zl0wVj6hPMDE6YY06ydxWwM+/cLFxJKY6kAiKRIX6s=;7:3b8IIpVsVXXPxSeN2c+iqbFbyImvUp4aOu0XLxCPXAMwCVbxd7lhzze4MJOepAc5IGGmwqfUUHwuArBFVG66PK3zHbhduorormvR570yiiX8rMDljHDQ2+AO3djS4w0PCIucziW0CULaU1Zf60hc1pK25VfVNHXUBcBYuXQ/kcM8OsTB9GpTJ6dSKHkQUmROCQgD4oGl0rjPLmYQJPgalMve0uER2zOiDwqALEWBCZCCg3144LZLmO9ziyOx6Nd3
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 37003824-6ed8-452b-1c1d-08d637bfc066
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-antispam-prvs: <DB3PR0402MB3707EEC50D62B7C2BD324E2FF5F40@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(85827821059158)(9452136761055)(64217206974132)(185117386973197)(81227570615382)(148322886591682)(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DB3PR0402MB3707;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3707;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(346002)(136003)(189003)(199004)(13464003)(71190400001)(71200400001)(106356001)(86362001)(6306002)(39060400002)(2900100001)(53546011)(2201001)(575784001)(478600001)(66066001)(256004)(14454004)(229853002)(6116002)(6436002)(3846002)(110136005)(33656002)(53936002)(2501003)(305945005)(6246003)(99286004)(186003)(55016002)(74316002)(97736004)(316002)(5250100002)(15650500001)(68736007)(25786009)(2906002)(76176011)(11346002)(102836004)(476003)(6506007)(105586002)(44832011)(446003)(81156014)(7736002)(26005)(81166006)(7696005)(8676002)(8936002)(486006)(9686003)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: zHQ7UODqSxvdVnMenOfZ4vcHNNVY7bgOFHWN4x2936vB5PgJnE2JGbwUjFzNceXuR48JwDZg4C8UAehdBbAHzNZbCr6Q4cLprxsprxC4HFYq/RsC+LBTSykgsMMLd+LH3/7U9zA8pUkMSVKGtKJhi7Zg9XY7X4NaQMualggBTRDryB8VubrczsoAna0MZ90X2N7cUOpn+KK67bvRFtDaJ92mr6OFEaTvsYJptddfAPBTcxkBXwzTTiTy7uGJG4bqqWrHiP5MOmk8bRfUWt8NuyRfKp/3aKtxZgOVjQS6YM8D5TiZHPgY+DJgrHMmigkdIorHm2ioqk9jvD20HyPg0ylm9RBd5g2KOQd+RtE0VJY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37003824-6ed8-452b-1c1d-08d637bfc066
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 01:43:22.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGluZy4uLg0KDQpBbnNvbiBIdWFuZw0KQmVzdCBSZWdhcmRzIQ0KDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5zb24gSHVhbmcNCj4gU2VudDogRnJpZGF5LCBPY3Rv
YmVyIDEyLCAyMDE4IDI6NDIgUE0NCj4gVG86ICdEYW5pZWwgTGV6Y2FubycgPGRhbmllbC5sZXpj
YW5vQGxpbmFyby5vcmc+OyBydWkuemhhbmdAaW50ZWwuY29tOw0KPiBlZHViZXp2YWxAZ21haWwu
Y29tOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzJdIHRoZXJtYWw6IGlteDogaW1wcm92ZSBl
cnJvciBtZXNzYWdlDQo+IA0KPiBHZW50bGUgcGluZyB0aGlzIHBhdGNoIHNldC4uLi4NCj4gDQo+
IEFuc29uIEh1YW5nDQo+IEJlc3QgUmVnYXJkcyENCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxp
bmFyby5vcmc+DQo+ID4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAxMywgMjAxOCA5OjQzIFBN
DQo+ID4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsgcnVpLnpoYW5nQGlu
dGVsLmNvbTsNCj4gPiBlZHViZXp2YWxAZ21haWwuY29tOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5v
cmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8yXSB0aGVybWFsOiBpbXg6IGltcHJvdmUgZXJyb3IgbWVzc2FnZQ0KPiA+DQo+ID4g
T24gMTMvMDkvMjAxOCAxMToxMywgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gPiBSZW1vdmUgdGhl
IGR1cGxpY2F0ZWQgImZyb20iIHRvIGltcHJvdmUgdGhlIGVycm9yIG1lc3NhZ2UuDQo+ID4gPg0K
PiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gPiAtLS0NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxl
emNhbm9AbGluYXJvLm9yZz4NCj4gPg0KPiA+IC0tDQo+ID4NCj4gPg0KPiA8aHR0cHM6Ly9lbWVh
MDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwJTNBJTJGJTJGd3d3
DQo+ID4gLmxpbmFyby5vcmclMkYmYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1YW5nJTQwbnhw
LmNvbSU3Qzc0YjANCj4gZTMNCj4gPg0KPiA2OWRlYTQ0MmNkMjNjYTA4ZDYxOTdlZTUxOCU3QzY4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDDQo+ID4NCj4gMCU3QzAlN0M2MzY3MjQ0
MzAxMjk3ODkwMTMmYW1wO3NkYXRhPUM5bDhRRnQ1OFlKVm81cHJ2d0hOcVNpT1A1DQo+ID4gNG9w
VU1QR09menlWNFBaRkElM0QmYW1wO3Jlc2VydmVkPTA+IExpbmFyby5vcmcg4pSCIE9wZW4gc291
cmNlDQo+IHNvZnR3YXJlDQo+ID4gZm9yIEFSTSBTb0NzDQo+ID4NCj4gPiBGb2xsb3cgTGluYXJv
Og0KPiA+DQo+IDxodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNv
bS8/dXJsPWh0dHAlM0ElMkYlMkZ3d3cNCj4gPiAuZmFjZWJvb2suY29tJTJGcGFnZXMlMkZMaW5h
cm8mYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1YW5nJQ0KPiA0MA0KPiA+DQo+IG54cC5jb20l
N0M3NGIwZTM2OWRlYTQ0MmNkMjNjYTA4ZDYxOTdlZTUxOCU3QzY4NmVhMWQzYmMyYjRjNmZhOTIN
Cj4gPiBjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3MjQ0MzAxMjk3ODkwMTMmYW1wO3NkYXRh
PVNxZkdmNmE0bg0KPiA+IE1Rdk81ZHZBamhYUGt4SlJLeFptOSUyRk8zN0xMeDhuQm1KNCUzRCZh
bXA7cmVzZXJ2ZWQ9MD4NCj4gPiBGYWNlYm9vayB8DQo+ID4gPGh0dHBzOi8vZW1lYTAxLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRnR3aQ0KPiA+IHR0
DQo+IGVyLmNvbSUyRiUyMyElMkZsaW5hcm9vcmcmYW1wO2RhdGE9MDIlN0MwMSU3Q0Fuc29uLkh1
YW5nJTQwbnhwLmMNCj4gPg0KPiBvbSU3Qzc0YjBlMzY5ZGVhNDQyY2QyM2NhMDhkNjE5N2VlNTE4
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTkNCj4gPg0KPiBjNWMzMDE2MzUlN0MwJTdDMCU3QzYz
NjcyNDQzMDEyOTc4OTAxMyZhbXA7c2RhdGE9ZU9mMm52Q2RKRXJtVg0KPiA+IHJhMTJ1eGxaNDJM
RmpqcnlIQTN1NEJxbUVGaEFwRSUzRCZhbXA7cmVzZXJ2ZWQ9MD4gVHdpdHRlciB8DQo+ID4NCj4g
PGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0
cCUzQSUyRiUyRnd3dw0KPiA+IC5saW5hcm8ub3JnJTJGbGluYXJvLWJsb2clMkYmYW1wO2RhdGE9
MDIlN0MwMSU3Q0Fuc29uLkh1YW5nJTQwbnhwLg0KPiBjDQo+ID4NCj4gb20lN0M3NGIwZTM2OWRl
YTQ0MmNkMjNjYTA4ZDYxOTdlZTUxOCU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5DQo+ID4NCj4g
YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY3MjQ0MzAxMjk3ODkwMTMmYW1wO3NkYXRhPVZjcTJDWjNX
dXR6NloNCj4gPiB4UTc3dHBvdzMwWDJ3JTJGVnNtajQzeWwxTTUzR2NXVSUzRCZhbXA7cmVzZXJ2
ZWQ9MD4gQmxvZw0KDQo=
