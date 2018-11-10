Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67D9C0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F42B20854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWteegTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F42B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeKKBvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:51:19 -0500
Received: from mail-eopbgr80055.outbound.protection.outlook.com ([40.107.8.55]:36096
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbeKKBvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYidXwbyih+QewoHTQEfCLMMjjNZJd7e6wJST+ytwGQ=;
 b=HWteegTMfgfJaGZQHIwWqWp/a3WmIi54Y7G5PeH1cyYnmDmvpVMOCH7DGf6SCyr95ZSeJA72DkFx7YttsASKa9VLk6zZUcsCK5zgt2IbPADj2claXYPcFW5DapE6JOqacRxhyM2P6MWHOVrSCHcpsceaUy1XYXqm9hw9fKSUOdw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4387.eurprd04.prod.outlook.com (52.135.148.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Sat, 10 Nov 2018 16:05:45 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 16:05:45 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Abel Vesa <abel.vesa@nxp.com>
CC:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abelvesa@linux.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Thread-Topic: [PATCH v9 3/5] clk: imx: add SCCG PLL type
Thread-Index: AQHUU/MO81otzv3HrECrskcsoP96EaUj/uoAgCB6iYCAAHcbAIAAF9uAgABA3YCAAMxCgIAAZFiAgAL6x7A=
Date:   Sat, 10 Nov 2018 16:05:44 +0000
Message-ID: <AM0PR04MB42118C6960C39387051B57F280C70@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-4-git-send-email-abel.vesa@nxp.com>
 <153980615257.5275.13866740376184829057@swboyd.mtv.corp.google.com>
 <20181107115444.gscxwud7e57nx3c7@fsr-ub1664-175>
 <154161726247.88331.15629902810537417880@swboyd.mtv.corp.google.com>
 <20181107202624.oya2runvbbwcilzu@fsr-ub1664-175>
 <154163631513.88331.1765456171211364913@swboyd.mtv.corp.google.com>
 <20181108122938.mnhu3ttnlztfeyot@fsr-ub1664-175>
 <154170172752.88331.2213352243956732809@swboyd.mtv.corp.google.com>
In-Reply-To: <154170172752.88331.2213352243956732809@swboyd.mtv.corp.google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4387;6:otNkMwAxQnMhJFWubi+6aPT/lMTT6Oa+D7rI5CckATjJMK1hY9oyKprDbngt7Gqnm7dcrTSJ11mjKsonuaO4pYzX6bTEMjTTHtCljN99jJf+L10f8DtiNPMP1ud3LlDGGQ8qx1pNoQJzW7W+BjusJpz3RlJG1tf4pzkmJtpCHL2Uh9tQbHNP0Z9CDUU0+wRRNOfrf42lTjZggTzc36BDIqcO6JnjiZuJqaZSquGdNOQ5ahXC4n11Q8yp9AKh0UlcAeXdyazX2NQQ94ID2CECGF5PA+CN7KY6Q2GBeLFVPRfUVNkx0cJI3dXK/zWWn6u9UAOCxC5I1O8JrK9d8TCpnw9eLzABpSiN/hJJIcAwKCEQPBpkCOd7YRGYIkB3f76xigkvBb2Wqlwg/WWeSK1U1x1AE1I5S3na7ijd4vMJ5xgNztvF/GMuBBLdGPLlQvElUW32uSh4PNeP+bP9zl5pgQ==;5:VxUMaasQNjwtiRrix3/UAWY1nx76dSRbMO541uzNxajkIzI6nfQo1lc+k+ejxq5MCbvIS3gK1Z8aGZHUyhpYSaMz6ycRGAYfMEofCnque4bVnpOMSZfejkDYDePpmtXklGIm/ijYU5tAHVo4l9vhLhJSvV1Wo34XqQhm/RI6T3Q=;7:8z0/4LmeWHmemFXD+PUZGi5bpKTJZ+wJeW+qI042L94x4wusQ0mdTd+gAa1EupzreFvPVrLPnWCnH7pDcTQVX1BlgVqYlsMjPU+ABawbZn05MiFLAIGCTZvO+L4xdyeB8PCmkE4bvHOtf93i82ayPw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7274f414-15ac-4605-0d73-08d647265f3c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4387;
x-ms-traffictypediagnostic: AM0PR04MB4387:
x-microsoft-antispam-prvs: <AM0PR04MB4387E90B3B73FD191D260DA880C70@AM0PR04MB4387.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231382)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4387;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4387;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(366004)(39860400002)(346002)(199004)(189003)(81156014)(81166006)(53936002)(39060400002)(68736007)(229853002)(8676002)(9686003)(102836004)(6246003)(76176011)(33656002)(4326008)(66066001)(6636002)(55016002)(7416002)(6506007)(2900100001)(99286004)(26005)(7696005)(256004)(305945005)(186003)(74316002)(7736002)(97736004)(6436002)(106356001)(8936002)(105586002)(86362001)(25786009)(478600001)(2906002)(217873002)(11346002)(93886005)(5660300001)(476003)(486006)(316002)(3846002)(110136005)(6116002)(54906003)(71200400001)(446003)(71190400001)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4387;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wMmo+nCkeVzYsbWenKzJQhkR3o2oGWwzc8Nfpwfp3ICwryz+vb8d2fNWzUqSYsZD57vFLHBI8PT3bw2qE5xfnc8Pzh+5IEHujMyYKD7VvFaFg+P0qK6+UUMyLbPQjAk8bUtkOWh4HdMpg6qhuKW6x7s32yyZgDzNpl8L49V+EADccfUGbUd2PP40nknNnSfXKd2vA0GLjBjCiYORM9BpjoCBjU3siEEs2SBsrCMIlfLr9VoOxM3l2xWz3g1Q1uTQbbbSusKsPDJu5u0np0nYJOZNh9E7YuwTvRziq84Dr8j1OuOuPeVrGhgjyzq9JrXaWKR4eu0AxdTF1RROUFNzkfm10lVYQtJmu8jxmDXOgkw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7274f414-15ac-4605-0d73-08d647265f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 16:05:45.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4387
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KWy4uLl0NCj4gPiBJIGFscmVhZHkgc2VudCB0aGUgMTJ0aCB2ZXJzaW9u
IG9mIHRoaXMgY3VycmVudCBwYXRjaCBzZXJpZXMgYW5kIEkNCj4gPiB3b3VsZCByZWFsbHkgbGlr
ZSB0byBnZXQgdGhpcyBpbiBBU0FQIHNvIHRoYXQgdGhlIGJvb3RpbmcgdXAgb2YgaW14OG1xIHdp
bGwNCj4gbm90IGJlIGRlbGF5ZWQuDQo+ID4NCj4gDQo+IE9rLiBXZWxsIHdlJ3JlIGluIHJjMSBy
aWdodCBub3csIGFuZCBzbyB3ZSdyZSBub3QgbWVyZ2luZyBuZXcgZHJpdmVycyBpbnRvDQo+IG1h
aW5saW5lLiBJIGNhbiBtZXJnZSB0aGUgY2xrIGRyaXZlciBpbnRvIGNsay1uZXh0LCBidXQgeW91
J2xsIGhhdmUgdG8gd2FpdCBmb3IgdGhlDQo+IHN0YWJpbGl6YXRpb24gcGVyaW9kIHRvIGVuZCAo
YXBwcm94aW1hdGVseSA2IG9yIDcgd2Vla3MpIGJlZm9yZSB0aGlzIGNhbiBnZXQNCj4gaW50byB0
aGUgbmV4dCBrZXJuZWwgdmVyc2lvbi4gSXQgd2lsbCBiZSBpbiBsaW51eC1uZXh0IG11Y2ggc29v
bmVyIG9mIGNvdXJzZS4NCg0KVGhhdCB3b3VsZCBiZSBncmVhdCBpZiB5b3UgY2FuIGhlbHAgdGhh
dC4NCldlJ3JlIG5vdyB3b3JraW5nIHdpdGggU1VTRSB0byBlbmFibGUgaS5NWDggc3VwcG9ydC4N
ClRoZWlyIGNyaXRlcmlhIGlzIG9ubHkgYmFja3BvcnRpbmcgcGF0Y2hlcyB3aGljaCBtdXN0IGJl
IGF0IGxlYXN0IGluIG1haW50YWluZXIncw0KbmV4dCB0cmVlIGFscmVhZHkuIFNvIGVpdGhlciBw
aWNrZWQgdXAgYnkgeW91IG9yIFNoYXduIHdvdWxkIGhlbHAgYSBsb3Qgb24gaXQuDQoNCkJUVywg
b25lIHNpbXBsZSBxdWVzdGlvbiBpcyB0aGF0IGJlY2F1c2UgTVg4TVEgRFRTIHBhdGNoZXMgZGVw
ZW5kcyBvbg0KdGhpcyBjbG9jayBkcml2ZXIgc2VyaWVzLiBIb3cgd291bGQgeW91IHN1Z2dlc3Qg
dGhpcyBzZXJpZXMgdG8gZ28gdGhyb3VnaA0KeW91ciB0cmVlIG9yIFNoYXduJ3MgdHJlZT8NCg0K
UmVnYXJkcw0KRG9uZyBBaXNoZW5nDQo=
