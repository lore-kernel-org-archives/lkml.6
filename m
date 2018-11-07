Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF85C46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826802085B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AwsmEJv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826802085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389316AbeKGM3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:29:16 -0500
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:11844
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388308AbeKGM3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOS7mtIF/kjPyl03Ueti1QaiO+CjjuRXgiLHTHpSj0U=;
 b=AwsmEJv6MyOXZKh0i8ZeSv68BChIVd/DO+Jl6LOjTrzYYLq7wNdBDR0trcQYfqhNPq/8oBsgoLpyHJX2IeOQJgX67nut5Jf3KAmVeRj67z9BApsJ8wq9X7l7NDRxw4dnD9KMWUQLY0DZApt+rL0Uwjbk4RyylhYqMjminjWQqSQ=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4961.eurprd04.prod.outlook.com (20.176.215.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Wed, 7 Nov 2018 03:00:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 03:00:48 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Topic: [PATCH RESEND V4 0/9] clk: add imx7ulp clk support
Thread-Index: AQHUaT95oCO6Jr50e0qyeeRGaZQa8qUprLpggBlLwPCAAAFpgIAAv5yw
Date:   Wed, 7 Nov 2018 03:00:47 +0000
Message-ID: <AM0PR04MB42118A6086D98F84542E954F80C40@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
         <AM0PR04MB4211576EF2FE906A6B0C3F1680FB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
         <AM0PR04MB4211280B09B72F637FC5650280CB0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <7e58f0dcf83a0bd8139e58e27bfa137fc186b4bf.camel@nxp.com>
In-Reply-To: <7e58f0dcf83a0bd8139e58e27bfa137fc186b4bf.camel@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4961;6:lQa0C24+pDaa/Z5sKrRZyPMGgM4NDJwFGiIuyLj0LWQqZjphuk8ZRIw1FKROFRchfJI6EHT0cHw0BCRpPFK5wAMJKAZFrIEQYwDvCjWPI+IFN+aqPlrk1KWHvW5mNZqBzb1FKmW7GPu0694+0ZFF14cjypcuTk3js2PeCCpNQrxVUlFmHrGFZ4VubEzuKXVm7BLc2zJfDCoWqseZ1eZ/wVW5RYKxvnZgCRgvJfKjSIaidv5ymntjiVuqIL+kFa98tfWRJGnkjGSZBhpjUZ8lqu9nB79af565J5KrQeOlbNSIkPiXR15mKv8GQGsOki14tBkoW8FoGB0eNbj+20wxMuIz2DZQqIpp1Ct6MFDbBEmVWPdpAzrxtq/WNTkne8LbNsyQ43fEHTDj2v8b2nI8YrQ6D14s60a9T7YgxAVLSGrENOmRRd3AW+g1rgso9IoTnbFaXEllxHuNBiyg6tcpJg==;5:pLhXLmG8+YeOsaPKkPTdj1k6Ppzz+JG0/gxltn6lv2hddcGwEYp2OFVIvuULoq3D7aPGZim57WB+Ney1I2etIOtX2gdNLFNc90/zjAq9gtKBvp41m1xGlUgCUhJYEgesfv+vnHtOGgOD5//GH7Y219TYoHYIaErZ8jBRMAuj+RY=;7:h7ok5iCS+fVdU19GNGdDIPZtkPtduDDsSz2X89BEsf31Qm2XRgDBxxjJkmvwdHBpfDO/gcMIICkcypWwTUUFwQzNJ85tL8LVFltbRxth+wwKp/CWh68WuZDezZUqeDDQXLWKtRyWHzdqUdS4Y9SR3w==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: de74b03e-97f0-4bb6-d90a-08d6445d37f3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4961;
x-ms-traffictypediagnostic: AM0PR04MB4961:
x-microsoft-antispam-prvs: <AM0PR04MB49613792A7A67D6C27C2FF5580C40@AM0PR04MB4961.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4961;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4961;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(136003)(39860400002)(396003)(13464003)(189003)(199004)(106356001)(81166006)(81156014)(2900100001)(2501003)(86362001)(316002)(105586002)(33656002)(5660300001)(446003)(11346002)(71200400001)(25786009)(217873002)(186003)(6436002)(110136005)(71190400001)(6246003)(478600001)(8936002)(8676002)(99286004)(74316002)(97736004)(14444005)(6506007)(256004)(6116002)(229853002)(54906003)(93886005)(305945005)(3846002)(68736007)(66066001)(26005)(9686003)(7736002)(102836004)(486006)(14454004)(4326008)(476003)(2906002)(76176011)(55016002)(53936002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4961;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RwAvJySEXgE7RrYTwDUe4WPZC/16NpQZ4yMFIqycZRW4tszpTu+FDm0Kjsw7CsEEKLHAvpn5lVvUYF8jxXgrc5ItwlUWVdpZbR1fG7L363Bv+jzRrqu2ua4Tig+AoM2Uf50Upo+7FtoNSUedfgjflbV9cZIEFb4uJxxnmHusbcFzsrfPKvDyQho+DyU85X+AHLp55fFha1GZVmfFEXK9tDbu5tjJcRgzMXGZNIUURSlpMy0Kj45YCzVDO6MLyuZAeIXa9kzIXYGsbo88OJ2JEjH95UKSVEiKjYef/0aYV4stymSfNedVo6bvi8HYE+p0f43kumExoR+jzAIeuBjag8SMvaXj5qyMjtdmHD57g4g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de74b03e-97f0-4bb6-d90a-08d6445d37f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 03:00:48.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMZW9uYXJkIENyZXN0ZXoNCj4g
U2VudDogVHVlc2RheSwgTm92ZW1iZXIgNiwgMjAxOCAxMTozNCBQTQ0KWy4uLl0NCj4gDQo+IE9u
IFR1ZSwgMjAxOC0xMS0wNiBhdCAxNTozMCArMDAwMCwgQS5zLiBEb25nIHdyb3RlOg0KPiA+IEdl
bnRseSBQaW5nLi4uDQo+IA0KPiA+IGRyaXZlcnMvY2xrL2lteC9jbGstY29tcG9zaXRlLmMgICAg
ICAgICAgICAgICAgICAgIHwgIDg1ICsrKysrKysrKw0KPiANCj4gRHVyaW5nIHJldmlldyBmb3Ig
OG0gY2xvY2tzIGEgc2VwYXJhdGUgYnV0IGRpZmZlcmVudCBjb21wb3NpdGUgY2xrIHdhcyBhZGRl
ZC4NCj4gSW4gb3JkZXIgdG8gYXZvaWQgY29uZnVzaW9uIHRoYXQgd2FzIG5hbWVkICJjbGstY29t
cG9zaXRlLThtLmMiLCBpdCB3b3VsZA0KPiBtYWtlIHNlbnNlIHRvIG1vdmUgdGhlIDd1bHAgY29k
ZSB0byBjbGstY29tcG9zaXRlLTd1bHAuYy4NCj4gDQoNCkkgZ3Vlc3Mgd2UgY2FuIGRvIGl0LCB0
aGFua3MuDQoNClJlZ2FyZHMNCkRvbmcgQWlzaGVuZw0KDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IExl
b25hcmQNCg==
