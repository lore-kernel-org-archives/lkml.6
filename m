Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E4EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36F321741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="zV+pbYvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731736AbeLTMOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:14:07 -0500
Received: from mail-eopbgr80040.outbound.protection.outlook.com ([40.107.8.40]:27280
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730229AbeLTMOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:14:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds/i01Shbd2+mLJZpBWmXmb+7qnXp0HJ0ZKhnvjYqis=;
 b=zV+pbYvfGAg1L8N4gbK0H60+wMpS4Del5Q8sDZQWBr/ZH0cY1+n8vX3Y9lxZRrIP/NJGTIN7vTZpXyBz8fFS05TN+I0tXoFefD2S7Q3jiebQcZW49+NOQ73w/mxkhqaPexDrZsTcr/1t53vHvOBaPnRm/U1zObt1oITbUYfdAb8=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4555.eurprd04.prod.outlook.com (52.135.138.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 20 Dec 2018 12:13:59 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1446.020; Thu, 20 Dec 2018
 12:13:59 +0000
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
Subject: [PATCH v2 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio signal
 polarity
Thread-Topic: [PATCH v2 3/4] ARM: dts: imx28-cfa10036: Fix the reset gpio
 signal polarity
Thread-Index: AQHUmF16OKwH2/RaskKVLrwUwh2wfQ==
Date:   Thu, 20 Dec 2018 12:13:56 +0000
Message-ID: <1545308005-51559-4-git-send-email-michal.vokac@ysoft.com>
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
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4555;6:PVXmt/HvCdUf/5eb97wyjC76Wa1ouYmM0NvqCh2MDn4qWjFg+GXVplRuSLDljQgpR0g6pcCPk+Mj2PIAIydnvC8K/9Qp/L+P7AFoD/rNGK4si9b/KleuO4wtZRZzjnP/T8zOnzfL5LquwTSX3gwwulFVBNm9QcYEh/aWU18YUOHgnt1JstEuTXnyKFefhM6LVc2SAXYUZEJG7ttrx22Oqvd708a0M+Lvt/bZ5t2dTkEHJpB9qk7gYwuHiRWk7KQ8YmYaJlHgGnm5MT/J8urI9okRtUT1JmRn3ZIkEtivD5hKermUPiWrOWYfBVReRATJgezBpUHEQsQEp+w5f/Lnq3BPSho/DRs1rnqSaLZR/VSq/G3nLIlgXdeudTx/6LpjSMLUJYdxFB2NBNQO5YkE7y4q6PPYo7nwiUml95VLrX7V9WhPeTWSeUna8TnxPQcJxHAySCKcF7jvPCkGYqWH/w==;5:XaQnsJxBfCpZIhsbgyGicqUpH0Dn9QtyrPLFjB+SDl/gIJd4GfhlRq2DQng9bATLwXaRR+guknP0fPDmytgs8V2CYo/Tqw9AuQdhMv6TsA6y8F8npHdNAm7d1MhUlr7S6GibhoHvT/WVQJqY7pXoLb6oYk+SkaZmg1yyISjusk4=;7:y0Rd6wBq9Ynfw3Wwz8z7XMQtB+MWMCqxRPoPLTFvlfHvmEtJPFt8aicUHbVK+l1HhhQPvE2iSqj/hYzf2ns1WPAiVtr1pPgp1rfu4ZR6h2vT2AqADIpI0PpRjmt2cvw4Q0HYi9g7x03mJtOMP5RBDg==
x-ms-office365-filtering-correlation-id: 1b91ee92-1740-46ae-0625-08d666749d3b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4555;
x-ms-traffictypediagnostic: DB7PR04MB4555:
x-microsoft-antispam-prvs: <DB7PR04MB4555B5EF417C4A471BEA58319EBF0@DB7PR04MB4555.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(3231475)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4555;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4555;
x-forefront-prvs: 0892FA9A88
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39850400004)(376002)(366004)(396003)(199004)(189003)(99286004)(305945005)(7736002)(102836004)(14454004)(66066001)(110136005)(72206003)(478600001)(8676002)(81166006)(6486002)(8936002)(71200400001)(71190400001)(81156014)(76176011)(446003)(6436002)(476003)(386003)(6506007)(2616005)(486006)(11346002)(86362001)(68736007)(54906003)(5660300001)(85182001)(53936002)(36756003)(107886003)(6116002)(3846002)(256004)(14444005)(106356001)(52116002)(105586002)(25786009)(6666004)(26005)(2906002)(316002)(6512007)(4326008)(186003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4555;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +X5Q4x1n0p7p4pJYWlOmkFCCn0/v7DtkbU9VxaVtSIzGeJm6lxrYJBhS6vX7svqBnzt71osDCS3CwySNQObk2FaPHaV+2pdEDA8JB+a++6AGmTjT++L2QK2Gu1tLZirsGyPTVtd3zjTVVB5Q5RseylI2bSABzPs5PvdvOCfUBKFn7OXDqQvMiW/3wQXiYIKss/GNYwue9ypQ0yPmEQwJxZx5K13EHJB/3lCqCoG/YXikVSQqw5Ez5wxM/HL+LlI5plYISYrZ3JvcpVfzdvzG0SAXC4G6RNhYf60XPEmuMf7N8Ak2FtDNuk5+6RvVMW6/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3235D77651BFC4CBB212D5A41E669E5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b91ee92-1740-46ae-0625-08d666749d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2018 12:13:56.2376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4555
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlc2V0IHNpZ25hbCBvZiB0aGUgU1NEMTMwNiBPTEVEIGRpc3BsYXkgaXMgYWN0dWFsbHkg
YWN0aXZlLWxvdy4NCkFkYXB0IHRoZSBEVCB0byByZWZsZWN0IHRoZSByZWFsIHdvcmxkLg0KDQpS
ZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6
IE1pY2hhbCBWb2vDocSNIDxtaWNoYWwudm9rYWNAeXNvZnQuY29tPg0KLS0tDQpDaGFuZ2VzIGZy
b20gdjE6DQogLSBBZGQgUi1ieSBmcm9tIFJvYg0KDQogYXJjaC9hcm0vYm9vdC9kdHMvaW14Mjgt
Y2ZhMTAwMzYuZHRzIHwgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXgyOC1jZmEx
MDAzNi5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXgyOC1jZmExMDAzNi5kdHMNCmluZGV4IDgz
MzdjYTIuLmQ2ZWNhMzEgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXgyOC1jZmEx
MDAzNi5kdHMNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDI4LWNmYTEwMDM2LmR0cw0KQEAg
LTExLDYgKzExLDcgQEANCiANCiAvZHRzLXYxLzsNCiAjaW5jbHVkZSAiaW14MjguZHRzaSINCisj
aW5jbHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQogDQogLyB7DQogCW1vZGVsID0gIkNy
eXN0YWxmb250eiBDRkEtMTAwMzYgQm9hcmQiOw0KQEAgLTk1LDcgKzk2LDcgQEANCiAJCQkJCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogCQkJCQlwaW5jdHJsLTAgPSA8JnNzZDEzMDZfY2Zh
MTAwMzY+Ow0KIAkJCQkJcmVnID0gPDB4M2M+Ow0KLQkJCQkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW8y
IDcgMD47DQorCQkJCQlyZXNldC1ncGlvcyA9IDwmZ3BpbzIgNyBHUElPX0FDVElWRV9MT1c+Ow0K
IAkJCQkJc29sb21vbixoZWlnaHQgPSA8MzI+Ow0KIAkJCQkJc29sb21vbix3aWR0aCA9IDwxMjg+
Ow0KIAkJCQkJc29sb21vbixwYWdlLW9mZnNldCA9IDwwPjsNCi0tIA0KMi4xLjQNCg0K
