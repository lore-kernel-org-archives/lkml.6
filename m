Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C002721741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="waTgAtjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbeLTMOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:14:06 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:17074
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731324AbeLTMOD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjIGa+qa+xTJtKyg4i4ZRL86qBux8aDN6IsCNEVpU1o=;
 b=waTgAtjXL/hxXaWp9T04Vo0Oo+n46SRN8d0hLTIvoVlnapd8obrwvxoB8r75pEeIsKBlZWtiCjlqf71l3Ln1RpCoVurdPE8ASsboAtPtLNU2FzyGjOlq/hucLrrO6T6clUmxbk/fVHM6q8y7q6p1S6IUURK8xPe7FS+AIjiyjTs=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4459.eurprd04.prod.outlook.com (52.135.137.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Thu, 20 Dec 2018 12:13:56 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 12:13:56 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [PATCH v2 1/4] dt-bindings: display: ssd1307fb: Remove
 reset-active-low from examples
Thread-Topic: [PATCH v2 1/4] dt-bindings: display: ssd1307fb: Remove
 reset-active-low from examples
Thread-Index: AQHUmF15CPCATSnSS0yYPT2YZUdoGw==
Date:   Thu, 20 Dec 2018 12:13:54 +0000
Message-ID: <1545308005-51559-2-git-send-email-michal.vokac@ysoft.com>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4459;6:JXYWgXDcy9DiNKVoS7V/p1jPipN6+9938Uh/bm/YOvI4G/LfKK+Mooc8uCUuFFZUR/3sWinr489GxazEV1YBH3drxREJBrw2vpZWL5OisgP/UIyImSiUvCeJGl2o3OKat1TnDyGZEZpiUcdh08arZHeaLEJokl+WaaIOE2M8fLyNoQ9aQrgV0w2TPTG2NZPW5V0uI43Jc4eyC14FLpj+92AqEDhGQbanZ5NAlJrxG1w8729ehLkJA+2Rhss8HVUicT1atphcBttl+NBIMeGmeAybV9pgb5T+D+8JODwAdLd0r8pBfb1Zxy1QrR2my5Qqy2CURdfvbfU31o8rfQUtFTMFo/cfwZCbJdHR7TvMrEK+6LtuMRVSvoroR6SyDmshhVM/VFGgNJBpbXS967MDse24G741nrwfn0I/m79PeB1EYqvsegji7l0hKuCq0BTii7PqXuJFKOHBqhKPh13WkA==;5:QJ3X4cl8frzxm41DVT6224jHCwovzcl0Lah9PfF1+cZt+R1666pIbiULMsQ0cU+qgmkkd0kvVNGxnMvNENkk4cvOAlIllG+RU/kS6mkWrZBEqBALFhH6iys6+ZtLJZc3hRrTHfzF7FpJSl6hSdlSza9eu6otj4+/w58OV9Oxht8=;7:i3zuw0T7ebcgVqtlWgZD234eQgX7MfOC/CnPxxJv879qUvILXi3DgeD64XrPy030vsjjYeDEU9PSMrXC5v2xlUyO0V0pdJAf07Tu2+InQj+xkrQYeIVGBN2/j5LBYRu3WTgn0aRCZsnDFmf3u34DLQ==
x-ms-office365-filtering-correlation-id: 3191daa3-fad3-428d-d7dc-08d666749c0c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4459;
x-ms-traffictypediagnostic: DB7PR04MB4459:
x-microsoft-antispam-prvs: <DB7PR04MB445979EFC4F1B7873CE316A39EBF0@DB7PR04MB4459.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(10201501046)(3002001)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4459;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4459;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(39850400004)(376002)(189003)(199004)(11346002)(86362001)(446003)(71190400001)(6436002)(5660300001)(53936002)(6512007)(186003)(102836004)(26005)(386003)(6506007)(85182001)(66066001)(478600001)(105586002)(71200400001)(36756003)(7736002)(4326008)(76176011)(97736004)(6486002)(2616005)(486006)(476003)(68736007)(52116002)(305945005)(8676002)(8936002)(99286004)(106356001)(6116002)(3846002)(110136005)(107886003)(2906002)(256004)(316002)(81166006)(81156014)(54906003)(25786009)(14454004)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4459;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: e10OO9x4Aoc9nMPPq8YEmXXEqYikkiygITj1IBMY/eSKg5eO2BsLtHrpVi/CKgt8H/1L/L7iXHvM7bm80Gf4D0HSVGPdHJ3AXzYFWMYNySXz3BWjptHRGE5MUVkxd10AEzjLmmOYqjETgO5SZIXBKEAY3viTRpTzPxbNB2hmLhh0kTydUA/pneiaqwAtLwaDhjQyqhOLnw6rg1kDpCnPL+K5hZRfaC3o8w6tV7bG+2YddvawOTqKZxpLResVIrtLztQs+m5ibfXXjZjBwMmEFRxjgCO7TdUJHWv2igO/SStclI8PGj62gvICP9DZ0BtgsUyq3416nN+EaaMSAEgoMwlvXLtCg5wdoIHWVNFiou8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <D125841EB3A2364E85DDEE274C70DB32@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3191daa3-fad3-428d-d7dc-08d666749c0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 12:13:54.5144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlc2V0LWFjdGl2ZS1sb3cgcHJvcGVydHkgaGFzIGJlZW4gcmVtb3ZlZCBicm9tIHRoZSBi
aW5kaW5nIGEgd2hpbGUNCmFnby4gU28gcmVtb3ZlIGl0IGZyb20gdGhlIGV4YW1wbGVzIGFzIHdl
bGwuDQoNCkZpeGVzOiA1MTliNGRiICgiZmJkZXY6IHNzZDEzMDdmYjogUmVtb3ZlIHJlc2V0LWFj
dGl2ZS1sb3cgZnJvbSB0aGUgRFQgYmluZGluZyBkb2N1bWVudCIpDQpSZXZpZXdlZC1ieTogUm9i
IEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IE1pY2hhbCBWb2vDocSN
IDxtaWNoYWwudm9rYWNAeXNvZnQuY29tPg0KLS0tDQpDaGFuZ2VzIGZyb20gdjE6DQogLSBBZGQg
Ui1ieSBmcm9tIFJvYg0KDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvc3NkMTMwN2ZiLnR4dCB8IDIgLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L3NzZDEzMDdmYi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9zc2QxMzA3ZmIudHh0DQppbmRleCAyMDlkOTMxLi5iNjdmOGNhIDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvc3NkMTMwN2ZiLnR4dA0KKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvc3NkMTMwN2ZiLnR4
dA0KQEAgLTM2LDcgKzM2LDYgQEAgc3NkMTMwNzogb2xlZEAzYyB7DQogICAgICAgICByZWcgPSA8
MHgzYz47DQogICAgICAgICBwd21zID0gPCZwd20gNCAzMDAwPjsNCiAgICAgICAgIHJlc2V0LWdw
aW9zID0gPCZncGlvMiA3PjsNCi0gICAgICAgIHJlc2V0LWFjdGl2ZS1sb3c7DQogfTsNCiANCiBz
c2QxMzA2OiBvbGVkQDNjIHsNCkBAIC00NCw3ICs0Myw2IEBAIHNzZDEzMDY6IG9sZWRAM2Mgew0K
ICAgICAgICAgcmVnID0gPDB4M2M+Ow0KICAgICAgICAgcHdtcyA9IDwmcHdtIDQgMzAwMD47DQog
ICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbzIgNz47DQotICAgICAgICByZXNldC1hY3RpdmUt
bG93Ow0KICAgICAgICAgc29sb21vbixjb20tbHJyZW1hcDsNCiAgICAgICAgIHNvbG9tb24sY29t
LWludmRpcjsNCiAgICAgICAgIHNvbG9tb24sY29tLW9mZnNldCA9IDwzMj47DQotLSANCjIuMS40
DQoNCg==
