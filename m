Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5B2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251892172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WExuDPQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251892172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeI1Nv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:51:58 -0400
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:43925
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728811AbeI1Nv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mJrzVlgmDGCV5z00UKFd/PULRw8CmiMPm6Dtinnw4c=;
 b=WExuDPQ/1dkP7TmgS0XrusScwFWznThpq/P65s86ReQ3VehlMGVMYNTr0fdCTK0XUskTAomlnWILsuRqN+4Ksm3O9ZYjhXG5NdN6g4pSIY4Z1FPm5MH16YX9O8hXpsKsB9PQ22UixhKZpq/QZKmTHCH+Da+X+OK9k9K57CssX30=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB4965.eurprd04.prod.outlook.com (20.177.33.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Fri, 28 Sep 2018 07:29:18 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::e955:4d48:f0eb:3fe%2]) with mapi id 15.20.1143.022; Fri, 28 Sep 2018
 07:29:18 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: RE: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Topic: [PATCH 1/2] spi: spi-mem: Add the spi_set_xfer_bpw function
Thread-Index: AQHUUXmVvI4Eamit80qkSTJAtq5nJ6UFSniAgAAAtKCAAAjOgIAAAaWg
Date:   Fri, 28 Sep 2018 07:29:18 +0000
Message-ID: <AM6PR04MB435700CF27EE20D9271C0A2397EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180928084431.300b7bf9@bbrezillon>
        <AM6PR04MB43573478FFD0E512A117484097EC0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <20180928091833.15e95f7f@bbrezillon>
In-Reply-To: <20180928091833.15e95f7f@bbrezillon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR04MB4965;6:8x/qU8NhNo/U9u6Lu7qnl2RW6Pw9dKo25uRutz3quKuX2eTrtHPrm8SAnD0vpvaIwdOb+ntmWdOF1whBtc5suSrk/O9dKymLeiQmQpOGJzrSmVIqFYNtvYgwj1oSUvZUWnflK/5Ot47+OgqLne2PKeNGFFPsvM/n4a5g16P8bcEXCab0V4CiMN1FhBr++ii+B9eVnSPe34P1q7KTntzWil40eAjvolADviozeXDIhRBTTwGUTab1UmTM3/WPaQcAJihGMTE+dxZQp7nNg7BudtMvWzNBbs9IsamR1Vs/sBuZrpIj0zIF65dQRB0Q50NdbWrWWDuSnolhg2FraQrrLOkwRkqwcwIO940BAyvKEwqTSGZRnb4Ye/SZkU5WWTcidu7qZgwhjv0LuQpFEFRiK2EOiR4tXIxzDayRRhAINMX0wm6rQ51avMXyyUilQHePd26gmElOoH7DZUQXvuZJvg==;5:lbr58t7eJ9xPNiXY1P984tFAgzGoF2J0iaK2mjJwNiNgfWI5vUyNO8p9FudzHM87q1P3xpYDZvUY+xMfdif9F08nY2I+p9YBDJys4wYvUiVpShJUQ40UR1guaf9eYZHW3JlMVLeuUMrFUH9t3RTRh7uRR1KqU6FzXZhFZzP1Xlw=;7:gh6tBSC2InaGMh4qRDruTapAj7Co9ieEE3oImfzrHlpPqL8zGjfAt9dK6Fmm1uV6e9bPK9RHsIZh93CurHg00JLcFhpvsmuB2zYQCNFip5ySWIOeEhQEjrs4Vi2IlCgV+6KKYuL5lCJ3iJbeT8gqfUh40AVF3Q9dwjSq/spvzsjShsSVp5SeS1pfpvMgxsnEOzLOt8WSLrrXXNjT4RS0Cl9eJA11zOBte7+sS94TwkGwwyL9gR+Y9rapyYe/gR/6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: aee67747-6bf2-4a75-5509-08d6251419ea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4965;
x-ms-traffictypediagnostic: AM6PR04MB4965:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM6PR04MB496513F5C81AE10F3D7DB9EB97EC0@AM6PR04MB4965.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(45079756050767)(189930954265078)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:AM6PR04MB4965;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4965;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(13464003)(54906003)(486006)(2900100001)(6116002)(53546011)(3846002)(6506007)(476003)(76176011)(26005)(11346002)(446003)(34290500001)(86362001)(316002)(7696005)(5660300001)(6246003)(6916009)(99286004)(44832011)(93886005)(4326008)(53936002)(25786009)(45080400002)(478600001)(9686003)(6306002)(55016002)(5250100002)(7736002)(14444005)(81156014)(81166006)(14454004)(33656002)(6436002)(74316002)(305945005)(66066001)(8936002)(68736007)(229853002)(102836004)(105586002)(106356001)(71200400001)(256004)(2906002)(97736004)(71190400001)(186003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4965;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: aZWIosyMXbH0+oDqhKr1RI+hHvr0TIDGO/JdNsTyqc2ljuAfOTMV4yJTOIN4/d2gaALh1E4nBU+0sbxmI7bbej3jpl4VPBRb6JTn0u24gr0jx9ZTxRH4DJh3/ezBWuTy29ahKq38RN3KJiVr7yYF9bqZCqoH2ehtar+zV0ynjUQfApxXT8l5wwTcwD63ctHXkHIOm28irCnMInrIe9f182G2LIq6AyP5Q4YS372Gi6tN0zi5G2ANs9Vvz8Y1chjBIHTYinLTTMc7gZwp4CSg5HP6SF3uxCpzGws+/6//r6VueK0IibgCMYUm2RKNP5kH6ieceiTLgaMNWEeNDdcS+39SBEa3cpNSEko8QXsczlc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aee67747-6bf2-4a75-5509-08d6251419ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 07:29:18.3174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQm9yaXMgQnJlemlsbG9u
IDxib3Jpcy5icmV6aWxsb25AYm9vdGxpbi5jb20+DQo+IFNlbnQ6IDIwMTjE6jnUwjI4yNUgMTU6
MTkNCj4gVG86IENodWFuaHVhIEhhbiA8Y2h1YW5odWEuaGFuQG54cC5jb20+DQo+IENjOiBicm9v
bmllQGtlcm5lbC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGVoYUBkZWlmLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gc3BpOiBzcGktbWVtOiBBZGQgdGhlIHNwaV9zZXRfeGZlcl9icHcgZnVuY3Rpb24NCj4gDQo+
IE9uIEZyaSwgMjggU2VwIDIwMTggMDY6NTk6NTggKzAwMDANCj4gQ2h1YW5odWEgSGFuIDxjaHVh
bmh1YS5oYW5AbnhwLmNvbT4gd3JvdGU6DQo+IA0KPiA+ID4NCj4gPiA+IEl0J3Mgc3RpbGwgdW5j
bGVhciB3aHkgeW91IG5lZWQgdG8gc3BlY2lmeSBhIGJpdHNfcGVyX3dvcmQgdmFsdWUsDQo+ID4g
PiBidXQgaWYgdGhpcyBpcyBuZWVkZWQsIGl0J3MgcHJvYmFibHkgc29tZXRoaW5nIHlvdSB3YW50
IHRvIGFkZCB0bw0KPiA+ID4gc3BpLmMsIHdoZW4gYSBtZXNzYWdlIGlzIHF1ZXVlZC4NCj4gPiBU
byBzcGVjaWZ5IGEgc3BlY2lmaWMgYml0c19wZXJfd29yZCB0byBiZSBhYmxlIHRvIHVzZSB0aGUg
eHNwaQ0KPiA+ICgzMmJpdCkgbW9kZSBvZiB0aGUgZnNsX2RzcGkgbW9kdWxlIHRvIHRyYW5zZmVy
IGRhdGEsIHlvdSBjYW4gbG9vayBhdA0KPiA+IG15IFBBVENIIDIvMi4gRG8gbm90IGFkZCBhIHZh
bHVlIGluIHNwaXMuYyB0aGF0IHRha2VzIGludG8gYWNjb3VudA0KPiA+IHRoYXQgdGhlIHZhbHVl
IGFzc2lnbmVkIHRvIGJpdHNfcGVyX3dvcmQgaXMgZGVjaWRlZCBiZWZvcmUgdGhlDQo+ID4gdHJh
bnNmZXIuIFRoYW5rcyBmb3IgeW91ciBjaGVjayBhbmQgcmVwbHkhDQo+IA0KPiBJIG1pZ2h0IGJl
IHdyb25nLCBidXQgdGhhdCdzIG5vdCBteSB1bmRlcnN0YW5kaW5nIG9mIC0+Yml0c19wZXJfd29y
ZC4NCj4gVG8gbWUsIGl0J3Mgc29tZXRoaW5nIHRoYXQgeW91IGNhbiB1c2Ugd2hlbiB5b3VyICpk
ZXZpY2UqIChub3QNCj4gY29udHJvbGxlcikgZXhwZWN0cyBub24tYnl0ZSBhbGlnbmVkIHdvcmRz
IFsxXS4gVGhlIHNwaS1tZW0gcHJvdG9jb2wgaXMNCj4gZGVmaW5pdGVseSBkZXNpZ25lZCB0byB3
b3JrIHdpdGggMWJ5dGUgbGFyZ2Ugd29yZHMsIHNvLCBhcyBJIHNhaWQsIEkgc3VzcGVjdA0KPiB5
b3UncmUgYWJ1c2luZyB4ZmVyLT5iaXRzX3Blcl93b3JkIHRvIGFkZHJlc3MgYSBjb250cm9sbGVy
IGRyaXZlciBpc3N1ZS4NCj4gDQo+IFsxXWh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZlbGkNCj4geGlyLmJvb3RsaW4uY29t
JTJGbGludXglMkZsYXRlc3QlMkZzb3VyY2UlMkZpbmNsdWRlJTJGbGludXglMkZzcGklMkZzcGkN
Cj4gLmglMjNMMTE0JmFtcDtkYXRhPTAyJTdDMDElN0NjaHVhbmh1YS5oYW4lNDBueHAuY29tJTdD
N2VjNjFkNmQNCj4gN2VmNzQxYWJhODQ0MDhkNjI1MTJhOWUxJTdDNjg2ZWExZDNiYzJiNGM2ZmE5
MmNkOTljNWMzMDE2MzUlN0MwDQo+ICU3QzAlN0M2MzY3MzcxNTk0MjA4MjAwNTAmYW1wO3NkYXRh
PWl3RmdYRzN5RnZIN1J1YWM3TUdDb2FQOGgNCj4gbDJNOTE2bTklMkJaZVY3bmtzVGclM0QmYW1w
O3Jlc2VydmVkPTANCkFoLCBJJ2xsIHN0dWR5IGl0LiBUaGFuayB5b3WjoQ0K
