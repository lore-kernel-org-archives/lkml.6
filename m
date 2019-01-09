Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90304C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5616620821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 08:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="XWbdkg+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfAIIjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 03:39:54 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:32372
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729702AbfAIIju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 03:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X5WufLdl6C4xDXT7zUD87Hlzq6ddiSdwW5IIH9z2RI=;
 b=XWbdkg+5c+hnPjsCSM5rf0C809Nh0EnViQ8iuhUtytplmk7/5OrQq7fpsI8l8dBC6kOvl0U5Ef2b40W9/G5bIoaYdwbF4hnWIityz6a2VEqpmrUFoxvpMNtADwEDlVddZgxABOWx1lgb6ZyXdigTxiaiZbZb/144v4TdLf6aft8=
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com (52.133.38.156) by
 AM0PR0402MB3780.eurprd04.prod.outlook.com (52.133.39.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Wed, 9 Jan 2019 08:39:45 +0000
Received: from AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72]) by AM0PR0402MB3716.eurprd04.prod.outlook.com
 ([fe80::3cc1:26a4:94be:1d72%5]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 08:39:45 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMy80XSBBUk06IGR0czogaW14MjgtY2ZhMTAw?=
 =?utf-8?Q?36:_Fix_the_reset_gpio_signal_polarity?=
Thread-Topic: =?utf-8?B?W1JFU0VORMKgUEFUQ0ggdjIgMy80XSBBUk06IGR0czogaW14MjgtY2ZhMTAw?=
 =?utf-8?Q?36:_Fix_the_reset_gpio_signal_polarity?=
Thread-Index: AQHUp/bfZySPJuWB2EyT3HhF7tbjsQ==
Date:   Wed, 9 Jan 2019 08:39:45 +0000
Message-ID: <1547023165-111798-4-git-send-email-michal.vokac@ysoft.com>
References: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
In-Reply-To: <1547023165-111798-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::35) To AM0PR0402MB3716.eurprd04.prod.outlook.com
 (2603:10a6:208:d::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.1.4
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3780;6:OoTFPoC1cjIDKvg+J9ADnkhVdUFFcyWLCqhSy4ioLpgCU9nR2/adCLVniRp+GkFcf19nuSeZUzcH2XI2gJqicPmWN7RI1OxdrqzkHTBYoUojieke+MwSyea2hIOOVg0ZjA1ugFjDrO9RlDsdo5CgloqSx6LoqvKAnEJX6vKUDeKcFyhrFWHGuNXml1tJZK1R69rPTqRLXjSSW+2W8K00KG/i25V45DDOUEpapAnQ5aZyJg4e1MKyJEfKI/EtIOEsK4lkmu+Zgq9s1Z9q41t6Nj0rvUpxGfpyl5R4UdQfKZkqE5GRH0s+U4828z1rZWO3QOdkW+dfu7xtlFEiaX+V8kCEzdAZr4cvVomVRyoQeIDT9Vb+G1BO5FfTy8HR8qndrWMM7xq1ABXEe+fdKJzlPhL0eN/MiBYRH9ElLkJ1Q0S9pNk4X0xT7ucQwXf9F6OdAyQjW+MhKsLXp9oHgXp/qg==;5:zn6Byl+e0VZ+6CqxQaOFgTojpRxe0tNnLqVKHh2I/BzhfW22UVUGB54AQwiJtn8Ub0H4td/WYUV7mybR1tJJ6qKTvrUk/HexU1RoelCzLBsmukc+2TLqQBkBRfR6PX4eZLgrv0VZfRr19IP69EpywpAp5atJt5w3rLA3eEUZ1RTrYETg0HGd6dm6c6gLPrb4+maK8sZxRPoYiUujIeINEg==;7:KXP8w94XnBaPbgXVCBz8D6AVFK7xgSFoqwYLN1KNLjg89FgWikYgeNtxketm4FMJQeG4sn5OUoA7i1OOCF98agwd2OKWEkjv73UaL4dsThOq0FdDfXOvrC68ysVvFnLqfdf67C/f1XJVa1jEQvSTmg==
x-ms-office365-filtering-correlation-id: 4ed3795e-036d-4dc5-74a1-08d6760e01ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3780;
x-ms-traffictypediagnostic: AM0PR0402MB3780:
x-microsoft-antispam-prvs: <AM0PR0402MB37809E281808BF517F13E8C19E8B0@AM0PR0402MB3780.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR0402MB3780;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3780;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(346002)(136003)(39850400004)(199004)(189003)(53936002)(5660300001)(66066001)(8936002)(6512007)(72206003)(6916009)(25786009)(4326008)(14444005)(256004)(36756003)(107886003)(106356001)(6116002)(14454004)(6436002)(105586002)(81156014)(81166006)(97736004)(486006)(6486002)(3846002)(50226002)(2906002)(305945005)(7736002)(86362001)(85182001)(11346002)(478600001)(446003)(476003)(2616005)(68736007)(6346003)(76176011)(102836004)(99286004)(386003)(6506007)(186003)(71190400001)(54906003)(71200400001)(316002)(52116002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3780;H:AM0PR0402MB3716.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: K0Gs/pJ7qMmquzdI5aZUHCTY5O5EvbCHqdfP4zbzORp6fxj4XPNkrKpvhcoP8uYgg1X4KrEYnBgmzN7wemw4dB26JBoojuYi41luyWSMuKqauGjtekx+Vo8SOoBAmlE6qBgnmfqZ8R2YctWg9BdH/dO7/liybo3B5BV/zNfnIoenTv7SQjPaXRQOB1QxlMbpHclsFdu/RuSFQMvGGe8g1ZbzCEefW/7nTxm7YS1ylDZa2Bm8T4fYyA2A+k8u8pQBQn7aWe6kojhfucRezYJ7lIIQdgJIrZWtaShve1i4qqRkbFIKEQiI6sIJjOSsjD8L
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <59CB9D9C49917343B72AD630C19E9533@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed3795e-036d-4dc5-74a1-08d6760e01ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 08:39:44.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3780
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHJlc2V0IHNpZ25hbCBvZiB0aGUgU1NEMTMwNiBPTEVEIGRpc3BsYXkgaXMgYWN0dWFsbHkg
YWN0aXZlLWxvdy4NCkFkYXB0IHRoZSBEVCB0byByZWZsZWN0IHRoZSByZWFsIHdvcmxkLg0KDQpS
ZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCkFja2VkLWJ5OiBBbGV4
YW5kcmUgQmVsbG9uaSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBNaWNoYWwgVm9rw6HEjSA8bWljaGFsLnZva2FjQHlzb2Z0LmNvbT4NCi0tLQ0KQ2hhbmdl
cyBpbiB2MiByZXNlbmQ6DQogLSBBZGQgQWNrZWQtYnkgZnJvbSBBbGV4YW5kcmUuDQoNCkNoYW5n
ZXMgZnJvbSB2MToNCiAtIEFkZCBSLWJ5IGZyb20gUm9iDQoNCiBhcmNoL2FybS9ib290L2R0cy9p
bXgyOC1jZmExMDAzNi5kdHMgfCAzICsrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDI4
LWNmYTEwMDM2LmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDI4LWNmYTEwMDM2LmR0cw0KaW5k
ZXggZDNlMzYyMi4uZGU0OGI1OCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDI4
LWNmYTEwMDM2LmR0cw0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14MjgtY2ZhMTAwMzYuZHRz
DQpAQCAtMTEsNiArMTEsNyBAQA0KIA0KIC9kdHMtdjEvOw0KICNpbmNsdWRlICJpbXgyOC5kdHNp
Ig0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCiANCiAvIHsNCiAJbW9kZWwg
PSAiQ3J5c3RhbGZvbnR6IENGQS0xMDAzNiBCb2FyZCI7DQpAQCAtOTYsNyArOTcsNyBAQA0KIAkJ
CQkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAJCQkJCXBpbmN0cmwtMCA9IDwmc3NkMTMw
Nl9jZmExMDAzNj47DQogCQkJCQlyZWcgPSA8MHgzYz47DQotCQkJCQlyZXNldC1ncGlvcyA9IDwm
Z3BpbzIgNyAwPjsNCisJCQkJCXJlc2V0LWdwaW9zID0gPCZncGlvMiA3IEdQSU9fQUNUSVZFX0xP
Vz47DQogCQkJCQlzb2xvbW9uLGhlaWdodCA9IDwzMj47DQogCQkJCQlzb2xvbW9uLHdpZHRoID0g
PDEyOD47DQogCQkJCQlzb2xvbW9uLHBhZ2Utb2Zmc2V0ID0gPDA+Ow0KLS0gDQoyLjEuNA0KDQo=
