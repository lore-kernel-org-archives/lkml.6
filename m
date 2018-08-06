Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D92C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EA0219C5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 02:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERfZ+y8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EA0219C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeHFElj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 00:41:39 -0400
Received: from mail-db5eur01on0050.outbound.protection.outlook.com ([104.47.2.50]:59393
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbeHFEli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 00:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O30R5Vrz/3L42YIGl3IRK1vvDBB+mNZfOTvERDZQyh0=;
 b=ERfZ+y8qVKD3mjrT5gBGgFF5mpj0BaXWkdrhsDYcABOlZ2/hshp+LvvpQWhhhvA0NWvjJOX1S2AQRngbe1Gm49l9f/bPJotxSLGKtMw7A+ZtJR19rt6kLFDRtiwKOHCzbU9hxeTTVNHGpu6EDb/c2EHYxRPuFStNxyEk89Osbz0=
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com (10.170.211.19) by
 DB6PR04MB3141.eurprd04.prod.outlook.com (10.170.214.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 6 Aug 2018 02:34:43 +0000
Received: from DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::5a5:2607:a2c7:681c]) by DB6PR04MB3223.eurprd04.prod.outlook.com
 ([fe80::5a5:2607:a2c7:681c%2]) with mapi id 15.20.1017.019; Mon, 6 Aug 2018
 02:34:43 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Topic: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Thread-Index: AQHUJMI388q4zA1ybU+fByMY2n4yEKShPSxQgAAjboCAAOXVUIAAeB2AgAAFoqCABKnngIAKpAaQ
Date:   Mon, 6 Aug 2018 02:34:43 +0000
Message-ID: <DB6PR04MB3223362445234D81383F0D1689200@DB6PR04MB3223.eurprd04.prod.outlook.com>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532680211.32306.36.camel@pengutronix.de>
 <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <02f4b642-14a8-f2db-ea23-c42a4f6f1652@pengutronix.de>
In-Reply-To: <02f4b642-14a8-f2db-ea23-c42a4f6f1652@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR04MB3141;6:ZoKZZKwdVGFmoLsV5CXdtuifBB9nlNSyYq5VYkbijuyoLPYw+tE7egaTDmCKCdvADvfe1bY3AEX4gLQJhVSlAww4MMUlEYdJZ9gsPv4ctF55LYr47Y98A+9eW3mMuxX3IgLRjsKEUnnUQxI43rywB6WnTkpB+Dpa7PAep1Pich8E9pMzMb3l4JnT7BXz9WA1waYDD9qVQq0/YD3MH7GznIx3x/p7Q8xKuyk1BdgI8wWdy/s4ifOsh1RQ/FzeYQG6mKBdlGxSWjmAvj6zC+Q1DFSFdZJpBvbrxNFxVreyqk4Ih/r1dVUyJUpoGYHB4hVE8+qYFBzx5aosVkeL/TjkBOLo4Vv/kQ7jC6/jRXYzT587mbsVtRtI7MmzKUbSVF0hKlXSQ+sXVtV1F+zCO4O0pVmq+2R2B6dguUjw1sGPL17dgEO2ejeCE6jZ1D1l5MhVP2IL8vJe8/cOShOKp722Lw==;5:bC20tTZz0JpvGMixghtXBovK99eHVpiZ6WD4Qh2mMhJKrYdk5iC6V4LEFkC+Emkdk0pM1u4+NDujgSS3xbvv9NK/dKreXh0BDwj8DrKMLgUqGpl3PEcv5cmzk7KqTUh5UzG6tR+l0k1nIl7kcfXaKDS5nXV3Tu8mavPbc9fX/wE=;7:YOnjGlR3SBReYYMTvkHOPoJrJ6na8T+bG3VS4RcHsHRgZ8YsnyPOi8yt5Ey9EVSkdMA77HVj+Kdp6TnJKmcsU6PjmHzNm42N2YxhNvjJOyUeetL725s32AGPMrSPewW8tqsfAe/TGwIVfD2zNEbZ/5Q9Llg1StrR/qeq3oMpJ9+bhI0ZdGp6NSXZ4j3J+hI1J8G7YoQ327z1lq1nIZU799z4xBHoYD0zGpsHojT8obFMbxbOpShlxd+q5kcAjJoz
x-ms-office365-filtering-correlation-id: b0a2587f-67c9-44c6-6afd-08d5fb452b00
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3141;
x-ms-traffictypediagnostic: DB6PR04MB3141:
x-microsoft-antispam-prvs: <DB6PR04MB31419BA23552A17020EBA5BA89200@DB6PR04MB3141.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3141;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3141;
x-forefront-prvs: 07562C22DA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(396003)(136003)(199004)(189003)(54534003)(4326008)(106356001)(39060400002)(25786009)(6246003)(11346002)(7416002)(2906002)(53936002)(9686003)(446003)(33656002)(229853002)(55016002)(5660300001)(105586002)(8936002)(6116002)(6436002)(68736007)(3846002)(316002)(486006)(476003)(5250100002)(14454004)(478600001)(8676002)(76176011)(81156014)(7696005)(81166006)(93886005)(7736002)(66066001)(99286004)(256004)(6506007)(26005)(186003)(74316002)(86362001)(102836004)(2900100001)(54906003)(110136005)(305945005)(97736004)(32563001)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3141;H:DB6PR04MB3223.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OZRjxAPlM2MvrwuIV/UtyHEli6Z7oHuWcundEmpgc8DA9tBmMsJsVC0VJM0NxIsYW5sKl0CO/xiYxRonNOIbTDHRnXx9C7qumveXEXdpB5sqvJKn+20zHT8sNX/7C1dqvkJP6SVAKYmWBJVqmBHwitK156eyIliLAVgB9B6cKt8bHYYs/38+DVsGa+hnkV3LWQxW1MJ1fvTMChqgTKq/BWzdYNh1vHqvci40V713dpDznwM3gUVQ8VvmpFkp5LqjMbcCSgPRrblIhVE2FWqvZyR0MEHHPHpug6Nw7ikYqjNknHzXNu/AfN8HyFKmnZLfxUn39q/IpzRgYGma4LngP6bBav0UB+1Dw9UT0Q7/fU4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a2587f-67c9-44c6-6afd-08d5fb452b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2018 02:34:43.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPj4gTm90IGFsbCBib2FyZHMgZm9sbG93IHRoZSByZWZlcmVuY2UgZGVzaWduLCB0aGF0
J3MgYSBmYWN0IG9mIGxpZmUuDQo+ID4+DQo+ID4+IFBsZWFzZSBsb29rIGF0IHRoZSBpLk1YNlEg
cmVmZXJlbmNlIG1hbnVhbC4gVGhlIHNlcXVlbmNlIGltcGxlbWVudGVkDQo+ID4+IGluIHRoaXMg
cGF0Y2hzZXQgY2FuIGJlIGZvdW5kIGFzIGEgdmFsaWQgd2F5IHRvIHBvd2VyIG9mZiB0aGUgc3lz
dGVtDQo+ID4+IGluDQo+ID4+ICI2MC40LjMgUG93ZXIgbW9kZSB0cmFuc2l0aW9ucyIgIk5vcm1h
bCBPTiB0byBPRkYgd2l0aCBleHRlcm5hbA0KPiA+PiBQTUlDIiwgc28gdGhlcmUgaXMgaGFyZGx5
IGFueSB3YXkgdG8gYXJndWUgdGhhdCB0aGlzIGlzIGEgYm9hcmQNCj4gPj4gc3BlY2lmaWMgcXVp
cmsuIFRoaXMgaXMgb25lIG9mIHRoZSBGcmVlc2NhbGUvTlhQIHJlY29tbWVuZGVkIHNlcXVlbmNl
cyB0bw0KPiB0dXJuIG9mZiB0aGUgc3lzdGVtLg0KPiANCj4gPiBPa2F5LCBidXQgY291bGQgeW91
IGFkZCBvbmUgbW9yZSBjb21tZW50IGZvciB0aGlzIHNvbHV0aW9uPyBSVEMgYWxhcm0NCj4gPiBh
bmQgT05PRkYgQnV0dG9uIHdha2V1cCBmZWF0dXJlIGNhbid0IGJlIHN1cHBvcnQgaW4gdGhpcyBj
YXNlLg0KPiANCj4gRW5vdWdoIHRvIGFkZCBpdCBpbiB0byBjaGFuZ2Vsb2c/IG9yIHNob3VsZCBp
dCBnbyB0byB0aGUgYmluZGluZyBkb2N1bWVudGF0aW9uPw0KVGhlIGJpbmRpbmcgZG9jIGlzIGJl
dHRlci4NCg0K
