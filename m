Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1C1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C4121773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="MJ5VVKoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbfBLJSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:18:34 -0500
Received: from mail-eopbgr40138.outbound.protection.outlook.com ([40.107.4.138]:55817
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbfBLJSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ/8cBnNZWoE94Y0mu89l9LIOpUWIau70PbxOqqOJQY=;
 b=MJ5VVKoanccMI2bjPfzsOQgQ+0JFmL4S5DdWECj+f+PIBb5xX9Ne/r19HldbWqv/0E/+zZRG2i8JrQ5BijSkUOY2/4CG0mJbsJ70aYCBq0uM8Q+cYDhYENzH+eMIp5p9rq/BvwL3EYWwNsCSjSqqwCIRcxxDL9Z1y5U6nlCN9QU=
Received: from HE1PR0502MB3755.eurprd05.prod.outlook.com (10.167.127.145) by
 HE1PR0502MB3786.eurprd05.prod.outlook.com (10.167.127.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 09:18:27 +0000
Received: from HE1PR0502MB3755.eurprd05.prod.outlook.com
 ([fe80::a4bd:b1f4:2783:c498]) by HE1PR0502MB3755.eurprd05.prod.outlook.com
 ([fe80::a4bd:b1f4:2783:c498%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 09:18:27 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: Re: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Thread-Topic: [PATCH 0/2] Adding DTS to support STMPE811 ADC on Toradex Boards
Thread-Index: AQHUslV3UOqu5BeJCkKTCmFMhM/Y2KXKWf0AgBGmyQCAAAJgAA==
Date:   Tue, 12 Feb 2019 09:18:27 +0000
Message-ID: <f635ea20437d8a716b56e7a579ce90d86dc2c2d0.camel@toradex.com>
References: <20190122132135.5012-1-dev@pschenker.ch>
         <20190201033633.GE19882@dragon> <20190212090954.GP22487@dragon>
In-Reply-To: <20190212090954.GP22487@dragon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB3786;6:58nC3sHTlPYgaPCpw5ex8wIOkPalpi/VZimaRGpk4SrCwTI82BXX2E+BPrvsYoUZGyYSJzlgOwu/b2M4iL3RLa6vy5nSXgthjEGfruhuNDhNiw2LlYaDywYcWMr7g0fQWicaO2RtjkBSU+vQGvDPAG5xclLaP6OpHbNPPfb7J8USTCXLJN7/CPZnN7njBhZfy9CMZM+VVnVAd7X2mTW7DfuvJs1xSySdbZIQybjTcE/Gm1TYSrPQHXhbSWRWfQU1GwJhogwEeTUuoa/rBzSs4Y6CWpJg/IwoUuV9Imtv9RcnEYph3/cmkVx+f7I+SVmvWQf3+x4WVOj1Jnu+YtOui/dt8yz2K0fc+BOm1BhD+TO8HKE5+b3LAap5/pYTwAbkLmVlYP8DIc1brDAoifn5BIbqtY07Az4KPQY+m7WTRjQspmYciGTruu3Jm2Yxflp/hb0McKgO+6BnXWvtYyccjQ==;5:Z+anIZ44QPLEm5onbjqVOFHiTMp8pMZaZH0i3nlVnDIOFxgHTs1DSvhe4kVyygC2+pjJgGYWXQYc3FBab0ZeAcHnwjyqoD8Os69FSW2fvi9xK+1Ls54k2Emxr/umh1J60Cp5gy3gLYRt626LUowgE4mKWdASsjI4hFmNwUkptfjWkCn/tr0i1Tm3utN1sDn46DObzFTxzercBuMr1WU0dA==;7:u9xjsR3/IM6m3RPpoed+leCARB6MVnOce5BhFFQRxsdPaSPoA4qrmuYUDtpMuimZcq5OY7u1M5tdCVlOeiqQ6xzQJWy+2mU3/ESy4ShLL2dcQ/q1BkYyLvvPZOHsAha0UaazTntztHw9/7sSxZm91w==
x-ms-office365-filtering-correlation-id: 2ba09f71-282e-483f-4169-08d690cb0c42
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB3786;
x-ms-traffictypediagnostic: HE1PR0502MB3786:
x-microsoft-antispam-prvs: <HE1PR0502MB37869C63407CD005FAA0AD99F4650@HE1PR0502MB3786.eurprd05.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39850400004)(136003)(396003)(366004)(199004)(189003)(26005)(6506007)(99286004)(76176011)(256004)(486006)(54906003)(186003)(316002)(2906002)(446003)(1361003)(7416002)(11346002)(81156014)(476003)(2616005)(44832011)(105586002)(8676002)(4744005)(106356001)(2351001)(8936002)(478600001)(305945005)(7736002)(81166006)(102836004)(2501003)(14454004)(36756003)(6116002)(71190400001)(71200400001)(25786009)(6916009)(66066001)(97736004)(118296001)(68736007)(6512007)(53936002)(6436002)(6246003)(229853002)(6486002)(86362001)(5640700003)(4326008)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0502MB3786;H:HE1PR0502MB3755.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1KvXFICJrIOsA9RzxTSYyQcdPov6BhBdZKIIEVI1bCeMJCgFFyoCILehwlZPftmeqgMjYj04OTr7AeF740agIW5mwcMUy+0GAmfJb3fy5psk0ZFLLu9Oq3mzixywnHWYvwuLPlYRjYoHkfYLZPNuZ0JLyGqcpgFdpo5FmNFWlXoO6dkUXG1zU6cg1Tig6Y/YdVL07K4UixHOYsOtKY6glLnd+1wzgbzyhLE32gH6jjSx2QIhQUJ4aEhyoH7HyzELG+wdmWiLRxC43Qc7+vDH3aS81ZNKj90ErOBbfRV9YPH/xNWScfVtN1YUP1j+eEHdzWl+/f6aFa3RUoK9DqQC0CxV3hhQeoOedQENgnXOeoUg/vcJZNP4kIgwe0TjBDes1y7srvUToGRNzPG587TYuuAwG+0IeudhN8G0Ub4QZHw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B919EDEC12B004EA2C62F5E8FB69376@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba09f71-282e-483f-4169-08d690cb0c42
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 09:18:27.6192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3786
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAyLTEyIGF0IDE3OjA5ICswODAwLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9u
IEZyaSwgRmViIDAxLCAyMDE5IGF0IDExOjM2OjM0QU0gKzA4MDAsIFNoYXduIEd1byB3cm90ZToN
Cj4gPiBPbiBUdWUsIEphbiAyMiwgMjAxOSBhdCAwMjoyMTozM1BNICswMTAwLCBQaGlsaXBwZSBT
Y2hlbmtlciB3cm90ZToNCj4gPiA+IFBoaWxpcHBlIFNjaGVua2VyICgyKToNCj4gPiA+ICAgQVJN
OiBkdHM6IEFkZCBzdG1wZS1hZGMgRFQgbm9kZSB0byBUb3JhZGV4IGlNWDYgbW9kdWxlcw0KPiA+
ID4gICBBUk06IGR0czogQWRkIHN0bXBlLWFkYyBEVCBub2RlIHRvIFRvcmFkZXggVDMwIG1vZHVs
ZXMNCj4gPiANCj4gPiBBcHBsaWVkIGJvdGgsIHRoYW5rcy4NCj4gDQo+IFNvcnJ5LCB0aGUgVDMw
IG9uZSBzaG91bGRuJ3QgYmUgYXBwbGllZCBieSBtZS4gIERyb3BwZWQgZnJvbSBteSB0cmVlLg0K
PiANCj4gU2hhd24NCg0KQFRoaWVycnkgY291bGQgeW91IHRoZW4gcGxlYXNlIHB1bGwgIkFSTTog
ZHRzOiBBZGQgc3RtcGUtYWRjIERUIG5vZGUgdG8gVG9yYWRleA0KVDMwIG1vZHVsZXMiID8gVGhh
bmtzIGEgbG90IQ0KDQpQaGlsaXBwZQ0K
