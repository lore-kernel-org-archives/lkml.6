Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D597C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFFE625D8D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="uzbeBjye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFE625D8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeGBNty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:49:54 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:22752
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbeGBNtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s/3nN1PK33qcXEDJBtEQmKV/sYO0tdn5Xp+f32fefg=;
 b=uzbeBjyetiVm7AdxaX/SP2qFYWv8Y/ns+AKiVgguV5D7R3zo/9uo+PibfTZRnAgF22TF3rGlwhBjTdMh5qLoCtZ6UpZImvO7xVbtJvrGCeDRKwoK2xBbtJl/5NhP6Dd0DV+1EAwp3VzXJWUwm7ou54SbsqWWJ6eqKJKx1FKC1lc=
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.126.145) by
 AM0PR04MB5042.eurprd04.prod.outlook.com (20.177.40.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.26; Mon, 2 Jul 2018 13:49:47 +0000
Received: from AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec]) by AM0PR04MB4290.eurprd04.prod.outlook.com
 ([fe80::1cd1:a089:87a0:25ec%2]) with mapi id 15.20.0906.026; Mon, 2 Jul 2018
 13:49:47 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Gong <yibin.gong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 0/2] soc: imx: gpc: Power off PU domain in suspend/resume
 on 6qp
Thread-Topic: [PATCH 0/2] soc: imx: gpc: Power off PU domain in suspend/resume
 on 6qp
Thread-Index: AQHUEfs2n92/MHJ3K0CVZykTXT0djKR72LcAgAAaYAA=
Date:   Mon, 2 Jul 2018 13:49:47 +0000
Message-ID: <8dc9a2359f65b570a8a94aad5e8113dfd642e441.camel@nxp.com>
References: <cover.1530530881.git.leonard.crestez@nxp.com>
         <1530533718.22468.87.camel@pengutronix.de>
In-Reply-To: <1530533718.22468.87.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.1-2 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5042;7:BAi4yiXOWnrLklkWNTV0Gio5NOFgAeL10y+BI9x4yN/ANFfugiZ30WCOtd553Mxs+viMIMhWCLlLnDOhXlr2gezY4mgGp+f++s2o9fkOlS1MueNSsuqqHiHnTw3+shn/Jvzepk/GbiogOSFqgqfMwnQX9gKe1VM4x/LESHnXSzVOdfloYbDRbVKuGSHzt6qWp3O/2xeGkE4EyWiU9q056fq1ck/R+Rnpy8QTOWAQHGpLqkf3snl2qVgl0oB+xR4h
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cff68611-330c-4160-493f-08d5e022acc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5042;
x-ms-traffictypediagnostic: AM0PR04MB5042:
x-microsoft-antispam-prvs: <AM0PR04MB5042511F2AD7F5DBC7117C3FEE430@AM0PR04MB5042.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB5042;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5042;
x-forefront-prvs: 07215D0470
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(476003)(186003)(2616005)(53936002)(81166006)(81156014)(76176011)(486006)(6346003)(102836004)(6506007)(2351001)(44832011)(26005)(6916009)(106356001)(229853002)(6246003)(68736007)(3846002)(6116002)(50226002)(118296001)(478600001)(105586002)(14454004)(446003)(36756003)(11346002)(7736002)(5660300001)(6512007)(305945005)(6436002)(2900100001)(2501003)(2906002)(86362001)(316002)(25786009)(14444005)(8936002)(54906003)(8676002)(5250100002)(99286004)(4326008)(6486002)(256004)(39060400002)(5640700003)(66066001)(97736004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5042;H:AM0PR04MB4290.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-microsoft-antispam-message-info: 7O0jPKeEJrJ+9Fqz7+FSBNWXa54DzTKL92T0POSPnN8RawjbkJdM5KLaT3l+ra5zKRrhKEQkJO2ofLBZCwOtScrB6qMtsZIDzLnRgkh36mu7U/z0JjCDRVlyzOpkFP2Ne6OJ8Gt2JE8maW3zOtAfWuTZv+GjLJsrbfkaRgme/O4F9sAOHiTE+H0D6TW6+ZrIhkJmU0A9T7sjTpdnbL1ATeMdD8N7lejVYy4G/LRMCx89oGQPe4yhHAsB6Fb6GXptznvYT7VwlZZWEZA1U+lVhNxWNl6PNjDipKYdwnuXOSVhlD5A4V/h0fetH61odhfSuWOCiFVRotcRSUamnuHyzi1Qh+FAE6deSUktlz+k5p8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D0E96E428DA1F47A8635340D6F04BA9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff68611-330c-4160-493f-08d5e022acc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2018 13:49:47.3525
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE4LTA3LTAyIGF0IDE0OjE1ICswMjAwLCBMdWNhcyBTdGFjaCB3cm90ZToNCj4g
QW0gTW9udGFnLCBkZW4gMDIuMDcuMjAxOCwgMTQ6NTIgKzAzMDAgc2NocmllYiBMZW9uYXJkIENy
ZXN0ZXo6DQoNCj4gPiBXaXRoIGN1cnJlbnQgY29kZSAoZXZlbiB3aXRob3V0IG15IHBhdGNoZXMp
IGF0dGVtcHRpbmcgdG8gZHluYW1pY2FsbHkNCj4gPiByZW1vdmUvcHJvYmUgdGhlIEdQQyBmaWxz
IHNpbmNlIHNpbmNlIHRoZSBwZXItcGdjIHBsYXRmb3JtX2RldmljZQ0KPiA+IGluc3RhbmNlcyBh
cmUgbm90IHJlbW92ZWQuIEknbSB0cnlpbmcgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gPiANCj4g
PiBlY2hvIDEzMDAwMC5ncHUgPiAvc3lzL2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2V0bmF2aXYtZ3B1
L3VuYmluZA0KPiA+IGVjaG8gMTM0MDAwLmdwdSA+IC9zeXMvYnVzL3BsYXRmb3JtL2RyaXZlcnMv
ZXRuYXZpdi1ncHUvdW5iaW5kDQo+ID4gZWNobyAyMGRjMDAwLmdwYyAgPiAvc3lzL2J1cy9wbGF0
Zm9ybS9kcml2ZXJzL2lteC1ncGMvdW5iaW5kDQo+ID4gZWNobyAyMGRjMDAwLmdwYyAgPiAvc3lz
L2J1cy9wbGF0Zm9ybS9kcml2ZXJzL2lteC1ncGMvYmluZA0KPiA+IA0KPiA+IEJ1dCBpcyB0aGVy
ZSBhbnkgdXNlY2FzZSBmb3IgZHluYW1pY2FsbHkgcmVtb3ZpbmcgdGhlIEdQQz8gSW5zdGVhZCBv
Zg0KPiA+IHRyeWluZyB0byBmaXggaXQgSSdkIHJhdGhlciBkZWxldGUgaW14X2dwY19kcml2ZXIu
cmVtb3ZlLCBqdXN0IGxpa2UNCj4gPiBmb3IgZ3BjdjIuIFdvdWxkIGFueW9uZSBvYmplY3QgdG8g
YSBwYXRjaCBkb2luZyB0aGlzPw0KPiANCj4gWWVzLCBhcyB0aGlzIGlzIHRha2luZyB0aGluZ3Mg
aW4gd3JvbmcgZGlyZWN0aW9uLiBXaXRoIGRldmljZS1saW5rcyB3ZQ0KPiBhcmUgYWJsZSB0byB1
bmJpbmQgY29uc3VtZXIgZGV2aWNlcyB3aGVuIGEgcHJvdmlkZXIgaXMgcmVtb3ZlZC4gQXMgdGhl
DQo+IEdQQyBpcyBhIGNvbnN1bWVyIG9mIGEgcmVndWxhdG9yLCBub3QgaGF2aW5nIHRoZSBhYmls
aXR5IHRvIHVuYmluZCBpdA0KPiB3b3VsZCBicmVhayB0aGF0IHVzZSBjYXNlLg0KDQpUaGUgR1BD
IGlzIGEgImNvbnN1bWVyIiBvZiB0aGUgTERPIHJlZ3VsYXRvcnMgd2hpY2ggYXJlIGJ1aWx0IGlu
dG8gdGhlDQpTT0MuIFdoeSB3b3VsZCB5b3Ugd2FudCB0byB1bmJpbmQgYW55IG9mIHRoaXMgc3R1
ZmY/DQoNCkkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgdXNlY2FzZSwgbWF5YmUgeW91IGNhbiBlbGFi
b3JhdGU/
