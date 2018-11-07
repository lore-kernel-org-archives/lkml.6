Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E36C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2A520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="iDMEK9hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2A520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeKGSGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:06:11 -0500
Received: from mail-eopbgr60057.outbound.protection.outlook.com ([40.107.6.57]:47328
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbeKGSGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94nqPPvQ8nHd2ddWixXDDxX45GarMVahew/2gLKWIz0=;
 b=iDMEK9hje2AZuPXFRJUda1PmWKRmKbGgLHBk6jIQMo/u5RDfsSdXI+1HfBPpl97cv/YwlKyV+UeqPKX2Z0kbYY2AxHsK0eXXp59EOcFcXNGGEWOhF4b2LWmY+nYC0wgjvcxs1R6PaeWkHe6ePr1d74Hm9Q/DXYZflkZtNPHf++8=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4315.eurprd04.prod.outlook.com (52.135.131.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Wed, 7 Nov 2018 08:36:48 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2849:23b4:7b26:a421%3]) with mapi id 15.20.1294.034; Wed, 7 Nov 2018
 08:36:47 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "robh@kernel.org" <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Subject: Re: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
Thread-Topic: [PATCH 03/24] leds: dt-bindings: Add LED_FUNCTION definitions
Thread-Index: AQHUdh10T7EtvrmxkEaTvWDGVilVDKVD/cyA
Date:   Wed, 7 Nov 2018 08:36:47 +0000
Message-ID: <ee6b35ab-6e26-a5fa-538e-d33b88903330@ysoft.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
In-Reply-To: <1541542052-10081-4-git-send-email-jacek.anaszewski@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6P193CA0114.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::19) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4315;6:gnw1V2FeULwrI+curyMSS/yOF9vz99tojlisdyElgaqD1Y8vwmEsEfTsGV+aWvocpZ6O+S5VF0l3IXpRcTG8xc1ctkjp1drtVB6/Z3O+GrjNWaU6m7jRQcRB8G/Gq0SMgLt6VwpohwD7LaFrzOQ/To6en50kRMpWrYP9gUgAAegEZuJU9izrC1QgpyQBePmK2Zf+tvAx05vGiLzDf5G6K4PrTKw/ijckYZPF/JVMcFbU0ZNmcm5KWDi1C2bUL5bFk2ANe5OZZc/AO9TFQecYfsufd+Hjd+mW3aze2filZBNyesqx0AC4eueksashpRBWvkA87/Bkvj51tQveXOpRC3VE6OulRr57qtDFFBZ4kdBdea2PkmP9psQwCdyQ97xEVr3cbalrlNZLtdRJXPff66nERR527y02bwS+Xb1h7yn66idlhuROZXaanvO6szILVSjp3IlZTUs+sA0D43mUQw==;5:7TiAEC4g4kFU6DxdVcasV3Bq39PE9wduH8vugnFCoe6Hc8b9imPxOkDXRJmlaGphI11JS+Nl+GpzD5zYeMHtcMU4saAMANn5NRb3CnbwKFCE8GYnI4JFrPcQwHx9t3hD28VyyTcxgSXj3g0tZGMBw2bz7tqVffjbeDNCG3UNnEE=;7:R5Cdx38Gh6GTG5tp9x4oP0TeB1VUMFnD6tXxiQga2McvbqLyLqfMKYyqfvTrSO7ZiZcpDWRAJALTaV7eM62AiVz4lGT/gY7jEEh7gkdgta2Y79RerrcSy2enQN35arJNbkTr0xIiQKnPsXw3bYmg/Q==
x-ms-office365-filtering-correlation-id: ddce7184-8577-4c0d-de8f-08d6448c27f5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4315;
x-ms-traffictypediagnostic: DB7PR04MB4315:
x-microsoft-antispam-prvs: <DB7PR04MB43159E1905BC1BA31860C4699EC40@DB7PR04MB4315.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(31051911155226)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4315;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4315;
x-forefront-prvs: 08497C3D99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39850400004)(136003)(396003)(189003)(199004)(256004)(85182001)(2906002)(53546011)(86362001)(229853002)(71190400001)(6506007)(386003)(54906003)(6486002)(2501003)(316002)(31696002)(110136005)(478600001)(71200400001)(102836004)(14454004)(72206003)(52116002)(99286004)(105586002)(31686004)(3846002)(106356001)(6116002)(2900100001)(5660300001)(76176011)(68736007)(81156014)(6436002)(25786009)(2616005)(8936002)(476003)(305945005)(11346002)(97736004)(81166006)(446003)(7736002)(6246003)(486006)(6512007)(7416002)(66066001)(4326008)(39060400002)(8676002)(36756003)(186003)(53936002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4315;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iSf0j6i+SVUwjwPNKY0AExV8SAje8d7vLJpW0DH2TwB7a9A6CkcP1p5hDhi8qqqv8L9YOjRwmfB0CQFWe/2RlZETF88jkXGVzsUfhr+nuspmZxmmAJibxVHPHDYB5WcsFqW55JZrXCUufGM5HEHQnALGF6l+fryHkYzH6pFVsmEln8ob8AeeI6I+YWIfz2KL0WI4K1uatU63v8heJ4AtMosNIFKdtYR/naF5USN720dIh/oNFF/FPU43GF5eEkuBy3MsOoaFf5HNGAMD/6AFFXTqQWsA0CJ6pYJw1nvqylsBnyavi1lxY3H/wEtVKcW6yYZJd3rGGxwdbWQEQzXjqk3QsvWjXbxqvh4z2USlauo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <7204B21C1CC9C648B27D7350CDA8D6DE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddce7184-8577-4c0d-de8f-08d6448c27f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2018 08:36:47.8030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi4xMS4yMDE4IDIzOjA3LCBKYWNlayBBbmFzemV3c2tpIHdyb3RlOg0KPiBBZGQgY29tbW9u
IExFRCBmdW5jdGlvbiBkZWZpbml0aW9ucyBmb3IgdXNlIGluIERldmljZSBUcmVlLg0KPiBUaGUg
ZnVuY3Rpb24gbmFtZXMgd2VyZSBleHRyYWN0ZWQgZnJvbSBleGlzdGluZyBkdHMgZmlsZXMNCj4g
YWZ0ZXIgZWxpbWluYXRpbmcgb2RkaXRpZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYWNlayBB
bmFzemV3c2tpIDxqYWNlay5hbmFzemV3c2tpQGdtYWlsLmNvbT4NCj4gQ2M6IEJhb2xpbiBXYW5n
IDxiYW9saW4ud2FuZ0BsaW5hcm8ub3JnPg0KPiBDYzogRGFuaWVsIE1hY2sgPGRhbmllbEB6b25x
dWUub3JnPg0KPiBDYzogRGFuIE11cnBoeSA8ZG11cnBoeUB0aS5jb20+DQo+IENjOiBMaW51cyBX
YWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+IENjOiBPbGVoIEtyYXZjaGVua28g
PG9sZWdAa2FhLm9yZy51YT4NCj4gQ2M6IFNha2FyaSBBaWx1cyA8c2FrYXJpLmFpbHVzQGxpbnV4
LmludGVsLmNvbT4NCj4gQ2M6IFNpbW9uIFNoaWVsZHMgPHNpbW9uQGxpbmVhZ2Vvcy5vcmc+DQo+
IENjOiBYaWFvdG9uZyBMdSA8eGlhb3RvbmcubHVAc3ByZWFkdHJ1bS5jb20+DQo+IC0tLQ0KPiAg
IGluY2x1ZGUvZHQtYmluZGluZ3MvbGVkcy9mdW5jdGlvbnMuaCB8IDEwMSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9u
cygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2xlZHMvZnVu
Y3Rpb25zLmgNCg0KSGkgSmFjZWssDQpKdXN0IG5pdCBwaWNraW5nLiBJIHRoaW5rIHRoZSBzdWJq
ZWN0IHNob3VsZCBiZToNCg0KImR0LWJpbmRpbmdzOiBsZWRzOiAuLi4iIHRvIGJlIGNvbnNpc3Rl
bnQuDQoNCkJlc3QgcmVnYXJkcywNCk1pY2hhbA0KDQo=
