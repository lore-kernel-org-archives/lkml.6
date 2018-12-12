Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2819C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACC820849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="4YrNE5lD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACC820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeLLMEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:04:54 -0500
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:2323
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbeLLMEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0FuCFSYOVWLj5HDGKlE1cLftiX8e4sOGCAfZEbSTh8=;
 b=4YrNE5lDW0OA3ZJWh+5XMTtdXrgWjO56ZlJsr4/e1gccDEAkjqAmTf4XBJPjJWZqYyvoOjv4e6nj4fLptWMEAW8gqqDxChbrO8+4FQ6CKmN9E0S47TD9OvTNE+Kbp2inKAGY7kL2jM4hLYULBTRy41Q/0kDgWOS8QFy8G6eNTv0=
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com (52.135.139.13) by
 DB7PR04MB4121.eurprd04.prod.outlook.com (52.135.130.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.18; Wed, 12 Dec 2018 12:04:49 +0000
Received: from DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490]) by DB7PR04MB4667.eurprd04.prod.outlook.com
 ([fe80::2561:ec02:4e5e:f490%3]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 12:04:49 +0000
From:   =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@karo-electronics.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: [RFC PATCH v4 0/2] pwm: imx: Configure output to GPIO in disabled
 state
Thread-Topic: [RFC PATCH v4 0/2] pwm: imx: Configure output to GPIO in
 disabled state
Thread-Index: AQHUkhLhvFuGSyQDQ0qu8mxZRy1JSw==
Date:   Wed, 12 Dec 2018 12:04:49 +0000
Message-ID: <1544616263-82642-1-git-send-email-michal.vokac@ysoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0022.eurprd07.prod.outlook.com
 (2603:10a6:203:51::32) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.24.100.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB7PR04MB4121;6:KuWsQTd7cA7FXKvYpbq/YlLRhU9fjzn7CQYoVFfZe4pYyzfKP78E8C7/XpqMSYYSzlaRlrV3LNY1gAIoPTQBDHi7wA25jgda8jPcQ67fMOaXbsigHcFSElfpYs0U4m4qqGvVls6s3m7JaE/Dt7fAtvnwxvnxYEh6Y8Ra8wKb21KcWerM0SaRbh5oAU9bZdSeYecYNZS0uIEBmqONa2VtX8TQaM67NSPfBpEEI5rhkbWQMg/rCSiqRJcdh806Un5Jec+LPeJcrJJ7J/TtbVNfUHRurDfOOlg9rm7MEdKuBU8mqh3kDum1n4sWLhUD1gCo5HbURty50KhDnUwwmGKjV37H4DXJq5s2dga2n5tAx0NaihrI/x+1m4uvjlstlF4akn4onpmmSsRxDk+5SmZ6i7RISWs+Niut5ADLPDp2gK2+5LeghkeyTREcYZlw1yXnbrYQg/De0EAnAEI+K1cFmg==;5:orK8DTviDM5RyxGoAYpskjJdB4fDgCDAaXqM3KqpCnvpT+Bjfg4SRs18ck2c6bQc/BxtEShvog63TvpssVL4vaQ6Ok/KwsVhX8p4UcL61FqKi+ph88dyGQSdHpT29VLbbsbO8v+SU5lqvH2xXlRSURNnDbiGhIQo7A/o9y2+V+M=;7:PCEp3s/1yQYglDIsDImsc/qlzcLVNTwQRNC3VQ4NtK4V7sat6Q99+WFab80TCBicNVE8A5kJkLVyr9h2Qj9K93Mvt/hHi95NWhOm8jJ6K5vNIEXNju1zHVmLjjuYIv8K0ZYXS7yJabxGDts7Jre7Qw==
x-ms-office365-filtering-correlation-id: e59d1b2f-5b1e-4d36-5380-08d6602a03fc
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4121;
x-ms-traffictypediagnostic: DB7PR04MB4121:
x-microsoft-antispam-prvs: <DB7PR04MB4121439AC4F5706A480278E89EA70@DB7PR04MB4121.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DB7PR04MB4121;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4121;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39850400004)(396003)(366004)(189003)(199004)(66066001)(105586002)(6436002)(71190400001)(14454004)(106356001)(71200400001)(7736002)(72206003)(4326008)(7416002)(97736004)(25786009)(305945005)(86362001)(5660300001)(478600001)(8676002)(6512007)(39060400002)(53936002)(107886003)(14444005)(256004)(68736007)(486006)(3846002)(6506007)(102836004)(386003)(2906002)(26005)(476003)(316002)(2616005)(85182001)(186003)(52116002)(110136005)(99286004)(6116002)(81166006)(36756003)(81156014)(54906003)(6486002)(217873002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4121;H:DB7PR04MB4667.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZUs/5UHZj5yI4OS2/c0Pv8+0FisOGeZMTAQtpooMoJYZhI0z2KMWe3SU96fMOFEV8ctTUyaPQKkFuHxwAZCR0ySFukL0vix7UQOF4PmmZrwbuYyXws6Qgrq0Balyk5Bq+hbCtgXNivePSo7PXfM7CqrW6B8YTmnjEWmH9oA/9gmePyhlx1BLTJuXODfc5QIVEHlEttY4/cF9lYMht5w3V82DL2Wv4GWsrwIEoe/pk4MqtXC/rFYHxz5cZmGJ1vlAZ5GKZkmBLitnrSxsX8Hi8dkLMfq7y6IZUh9Fcs4VJhHgOtKJ1f/1UYi6hSIsz04b
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4B6D36AE49ABA44834BA66DF79EDE8E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59d1b2f-5b1e-4d36-5380-08d6602a03fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 12:04:49.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpcyBhbiBhdHRlbXB0IHRvIGRlYWwgd2l0aCBpLk1YIFNvQyBQV00gSFcgbGltaXRhdGlv
bi4NCldoZW4gYSBwYWQgaXMgY29uZmlndXJlZCBhcyBhIFBXTSBvdXRwdXQgdGhlIG91dHB1dCBs
ZXZlbCBpcyBhbHdheXMgMFYNCmlmIHRoZSBQV00gYmxvY2sgaXMgZGlzYWJsZWQuIFRoaXMgY2Fu
IGNhdXNlIHByb2JsZW1zIHdoZW4gaW52ZXJ0ZWQgUFdNDQpzaWduYWwgaXMgbmVlZGVkIHRvIGRy
aXZlIHRoZSBjb25uZWN0ZWQgY2lyY3VpdC4gV2l0aCBpbnZlcnRlZCBvdXRwdXQNCmR1dHkgY3lj
bGUgPSAwJSBjb3JyZXNwb25kcyB0byBoaWdoIG91dHB1dCBsZXZlbCBhbmQgZHV0eSBjeWNsZSA9
IDEwMCUNCmNvcnJlc3BvbmRzIHRvIGxvdyBvdXRwdXQgbGV2ZWwuIFRoaXMgbWVhbnMgdGhhdCB3
aGVuZXZlciB0aGUgUFdNIGJsb2NrDQppcyBkaXNhYmxlZCB0aGUgY29ubmVjdGVkIGNpcmN1aXQg
aXMgZmVkIHdpdGggMTAwJSBkdXR5IGN5Y2xlLg0KDQpUaGlzIGJpbmRpbmcgaXMgdG90YWxseSBv
cHRpb25hbCBhbmQgY3VycmVudCB1c2VycyBhcmUgbm90IGFmZmVjdGVkLg0KVGhlIGlkZWEgaXMg
dG8gdXNlIHR3byBuZXcgcGluY3RybCBzdGF0ZXMsICJwd20iIGFuZCAiZ3BpbyIsIGluc3RlYWQg
b2YNCnRoZSAiZGVmYXVsdCIgcGluY3RybCBzdGF0ZS4gVGhlIGdwaW8gc3RhdGUgaXMgc2VsZWN0
ZWQgIHdoZW4gUFdNIGlzDQpkaXNhYmxlZCBhbmQgdGhlIHB3bSBwaW5jdHJsIHN0YXRlIGlzIHNl
bGVjdGVkIHdoZW4gUFdNIGlzIGVuYWJsZWQuIEluIHRoZQ0KZ3BpbyBzdGF0ZSBsZXZlbCBvbiB0
aGUgb3V0cHV0IGlzIGNvbnRyb2xsZWQgYnkgdGhlIGludGVybmFsIHB1bGwtdXAuDQoNCk1pY2hh
bCBWb2vDocSNICgyKToNCiAgZHQtYmluZGluZ3M6IHB3bTogaW14OiBBbGxvdyBzd2l0Y2hpbmcg
UFdNIG91dHB1dCBiZXR3ZWVuIFBXTSBhbmQgR1BJTw0KICBwd206IGlteDogQ29uZmlndXJlIG91
dHB1dCB0byBHUElPIGluIGRpc2FibGVkIHN0YXRlDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcHdtL2lteC1wd20udHh0IHwgNDkgKysrKysrKysrKysrKysrDQogZHJpdmVy
cy9wd20vcHdtLWlteC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDc3ICsrKysrKysr
KysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKQ0KDQot
LSANCjIuMS40DQoNCg==
