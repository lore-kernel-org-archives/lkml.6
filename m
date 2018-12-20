Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C443C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FF220989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 03:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B1rqT5AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbeLTDM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 22:12:26 -0500
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]:43061
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727973AbeLTDMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 22:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T6PKDyQRphP17Cfx9tTYP5qBKhr0d2MMq9jDXx0f/Ls=;
 b=B1rqT5AUs1YaIHg4rarAwIN2KtrQyomi5UPE5cgQmJiv+W17MbY33b/Hg7Ckl695AWk9lgRcGJOw+6DNTFfDtyNn1Ir53yl69qtHuimYMpdihu7OeEnht6myo+LPwAMGuihxHtmAj92eirQFe2D+yn2zlGB5U6/0HU4MYIlz518=
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com (52.134.122.155) by
 VI1PR04MB4367.eurprd04.prod.outlook.com (52.134.123.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Thu, 20 Dec 2018 03:12:20 +0000
Received: from VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::19a0:4a1c:4c02:da90]) by VI1PR04MB4333.eurprd04.prod.outlook.com
 ([fe80::19a0:4a1c:4c02:da90%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 03:12:20 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64: dts: nxp: ls208xa: add more thermal zone support
Thread-Topic: [PATCH] arm64: dts: nxp: ls208xa: add more thermal zone support
Thread-Index: AQHUcNVyBYocMa5cAEilDltj8SkefKWEXSoAgAFiIQCAAYKKEA==
Date:   Thu, 20 Dec 2018 03:12:20 +0000
Message-ID: <VI1PR04MB4333CAADFE46B52CA090F4B7F3BF0@VI1PR04MB4333.eurprd04.prod.outlook.com>
References: <20181031044742.26327-1-andy.tang@nxp.com>
 <VI1PR04MB433351E63826CC2128153943F3BD0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <20181219040820.GA13728@dragon>
In-Reply-To: <20181219040820.GA13728@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andy.tang@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4367;6:CNqTd1Rz17vNyBC6qQdak30bQ46lvcKSJAcv+dWRxI3ESqfm1dOkmndn2VwSdHBhx+399icmeiEpimbLb5PhRWMHLSYn5LycPk54a7C/8XVJuhO0HB7OlWzyrLE1t0EQWk/XLhmXoOkwIPPiSZKzxU6dLJfOaPsVITjjvYs9sK/gnfbWVXpY2Oxyfxn37nD46/u7BOEXvKSQdUUKAM2RqqwHOz8M6k/fjkWLku7HlMkLMzvNo3TiRI3IHpSZ7/wjLMJqXdy8pZt4NA3Agd9emr8iVQjZpGMjbE7piYreCvEJgZ61CDv78SZ69SfmZtbXj7+1/xjoyhMhyKS5SBGm9ENCumPj+YCUuhAMqmmG38VUds6uc7YAsgi5OqWzGib06+rffCJVahXG2XwUHpsAtGYqDgTVraH/rBJmorE0xVHe0RLa8qmm8n/H5dG9ZHZWtrLKkDFqroXjWRVoI1GNGQ==;5:UnHXfhl6AZma9rdLDv3MAlM4ypVKmkoFafB69FcLtGXecuSM7QP9zQnVf7ImSAWwZL6jm51Qu5z9mHbhrRs2kjVeupNaXiwoPwQe/0sGZM8TSAAbNDILe18s4UPaYDiXVAR2gdhVOhPZVjJtxjK0enfLMGJzh3w3yJvYR/aeNno=;7:SS81Ja1Ig5WJ9zLza7yfLoJxU7d6OxU+d6azO9gSCXDYTaTNqw91+zG1rfP5jZIuKFUWPN2Ek5Mt6rklbYGXblkzFo20HN93fnyS4osR6Wf1uH3o3KctsdTUsw94RHrKYDiCrMmKF4edW4J6fFzSCA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c317dbf9-d6cf-45a2-4652-08d66628f443
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4367;
x-ms-traffictypediagnostic: VI1PR04MB4367:
x-microsoft-antispam-prvs: <VI1PR04MB4367C412730AF6B2D661BC46F3BF0@VI1PR04MB4367.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR04MB4367;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4367;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(366004)(39860400002)(136003)(189003)(13464003)(199004)(25786009)(575784001)(54906003)(5660300001)(86362001)(14454004)(316002)(7736002)(33656002)(7696005)(8676002)(81156014)(81166006)(6436002)(6916009)(229853002)(966005)(68736007)(6246003)(71200400001)(71190400001)(45080400002)(6306002)(6506007)(53546011)(9686003)(99286004)(76176011)(102836004)(478600001)(4326008)(186003)(97736004)(8936002)(486006)(74316002)(26005)(53936002)(105586002)(106356001)(44832011)(11346002)(446003)(2906002)(305945005)(3846002)(476003)(256004)(66066001)(6116002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4367;H:VI1PR04MB4333.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: f5zLELIPXKm3l/vWm+5WbGgaF2HXNbErEfHcGyDueC26tHffxC2UBU+6BJYZDMZSoYzvc4aFpg0rjT2VecVcWNOJYySuHjCLPUF/zSPh9ew8dkevXMwBuvMikkKVJwz6Mb2Rt6P0by7J/HwGAALvSow0qLWj77uQwxOjSwSG9WwnmpbvJ4mAwQ94i3T03ryttoSnqtnkcIwFsQuPboD4K5G8fO3Nu6X1yyRUlUpQJpUiXwlRuJtP5yBJpxF38uSMafhOXweVaF9Ko6g57xhQR4IGGPis97uMPF62Z7sK9sAr/MGYeStVI79av7W9gT1t
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c317dbf9-d6cf-45a2-4652-08d66628f443
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 03:12:20.0677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4367
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDE45bm0MTLmnIgxOeaXpSAxMjowOA0KPiBUbzog
QW5keSBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gZGFuaWVsLmxlemNhbm9AbGluYXJvLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54
cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBh
cm02NDogZHRzOiBueHA6IGxzMjA4eGE6IGFkZCBtb3JlIHRoZXJtYWwgem9uZSBzdXBwb3J0DQo+
IA0KPiBPbiBUdWUsIERlYyAxOCwgMjAxOCBhdCAwNzowMTozMkFNICswMDAwLCBBbmR5IFRhbmcg
d3JvdGU6DQo+ID4gSGksDQo+ID4NCj4gPiBQSU5HLg0KPiA+DQo+ID4gQlIsDQo+ID4gQW5keQ0K
PiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogWXVhbnRp
YW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+ID4gPiBTZW50OiAyMDE45bm0MTDmnIgzMeaX
pSAxMjo0OA0KPiA+ID4gVG86IHNoYXduZ3VvQGtlcm5lbC5vcmcNCj4gPiA+IENjOiBMZW8gTGkg
PGxlb3lhbmcubGlAbnhwLmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gPiA+IG1hcmsucnV0
bGFuZEBhcm0uY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4g
PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiA+IHJ1aS56aGFuZ0BpbnRlbC5jb207IGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc7
IEFuZHkgVGFuZw0KPiA+ID4gPGFuZHkudGFuZ0BueHAuY29tPg0KPiA+ID4gU3ViamVjdDogW1BB
VENIXSBhcm02NDogZHRzOiBueHA6IGxzMjA4eGE6IGFkZCBtb3JlIHRoZXJtYWwgem9uZQ0KPiA+
ID4gc3VwcG9ydA0KPiA+ID4NCj4gPiA+IExzMjA4eGEgaGFzIHNldmVyYWwgdGhlcm1hbCBzZW5z
b3JzLiBBZGQgYWxsIHRoZSBzZW5zb3IgaWQgdG8gZHRzIHRvDQo+ID4gPiBlbmFibGUgdGhlbS4N
Cj4gPiA+DQo+ID4gPiBUbyBtYWtlIHRoZSBkdHMgY2xlYW5lciwgcmUtb3JnYW5pemUgdGhlIG5v
ZGVzIHRvIHNwbGl0IG91dCB0aGUNCj4gPiA+IGNvbW1vbiBwYXJ0IHNvIHRoYXQgaXQgY2FuIGJl
IHNoYXJlZCB3aXRoIG90aGVyIFNvQ3MuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWXVh
bnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+DQo+IA0KPiBQbGVhc2UgdGFrZSBhIGxvb2sg
YXQgcGF0Y2ggYmVsb3cuDQo+IA0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlv
bi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGcGF0Y2gNCj4gd29yay5rZXJuZWwub3Jn
JTJGcGF0Y2glMkYxMDY4NTgxNSUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDYW5keS50YW5nDQo+ICU0
MG54cC5jb20lN0M0NDBkNjA3ZmVlZGU0NTA2OGRjNjA4ZDY2NTY3Yzk3OCU3QzY4NmVhMWQzYmMy
YjRjNmZhDQo+IDkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODA3ODkzNzY1OTM2OTgzJmFt
cDtzZGF0YT1RQyUyQnk5Zg0KPiBtdkk0MnQ5ZVMzTFM0WUdEMjNLcXE2RVVEMEVwSUduREVEaHJB
JTNEJmFtcDtyZXNlcnZlZD0wDQo+IA0KVGhhbmtzLCB3aWxsIHJlYmFzZSBteSBwYXRjaC4NCg0K
QlIsDQpBbmR5DQo+IFNoYXduDQo=
