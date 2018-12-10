Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B78C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4971D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="UN7m1ioV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4971D20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbeLJPAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:00:22 -0500
Received: from mail-eopbgr10139.outbound.protection.outlook.com ([40.107.1.139]:3707
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbeLJPAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsrIY2yyxWCcgqZLRPgBMakO6FU7GELeomHUIZ0chIw=;
 b=UN7m1ioVRysVfaZfmoOomrA/q5ykQ0/ZfOR+3PkgStoerkFJBFukBgLicrfCmrxuaJDfeMeDQhHEKlkKCc1yNl6pi9+MMeRCo9fwZYNGF/qXHG5f9RcCgVxlryku5yt8WZYL26RYHvfN7wWO+WcPPgxndKuoQlm5ftOjZ6fyNQo=
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com (10.170.247.141) by
 HE1PR07MB4442.eurprd07.prod.outlook.com (20.176.167.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.17; Mon, 10 Dec 2018 15:00:17 +0000
Received: from HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb]) by HE1PR07MB3434.eurprd07.prod.outlook.com
 ([fe80::e491:596c:4d4e:ffdb%2]) with mapi id 15.20.1425.016; Mon, 10 Dec 2018
 15:00:17 +0000
From:   "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
CC:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 0/3] i2c-axxia: support Sequence command
Thread-Topic: [PATCH 0/3] i2c-axxia: support Sequence command
Thread-Index: AQHUkJkP2JFJjvH9dUmvu7KoirhJYQ==
Date:   Mon, 10 Dec 2018 15:00:17 +0000
Message-ID: <cover.1544453688.git.krzysztof.adamski@nokia.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0046.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::14) To HE1PR07MB3434.eurprd07.prod.outlook.com
 (2603:10a6:7:2c::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=krzysztof.adamski@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [131.228.32.190]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB4442;6:SFetobggbqnXQFq2Mk6OEP9YiUfUVDw8yjJJwIRJ3Df5UDEgPeDnoN09A4r0O09VRFto5QuTWCrE8d9Lexs/A2/X0SfqJBot5tZGeXCZJSfBWHiLOf9pjDITp1cKlAgpbAOcsh8wYmQhHSFb8ulLSVtVHnlV1sNZlF+dGy7QlRnR4dkvZRhTHs0vmxAPsy7lCgKo7KLezk0LLXS78qYUMQygkisplBcZBWnrEcjLfkdnJf3aHEVVNrpD3jud1NDV7VGBNPk0JCM0YdFheZ8Z/5TXkM0dsD7OcW92j9O+bQlKW2MFDMh2lY0AIO3fzOdCkOeVPjTniGqhqvCaB6XfuYky8gq8V7AOQ8Zd8LZShH12sl6yURDdwGgi9SQ+b/TgHEw6oFQApNrvNWzyo37DmqozNnYHikIqpRLXrC7b+sU1iCU/Si4fGyDaCj/OmeA5cA+bJiDR87Dux5Ngr4ixUg==;5:bgH9tAxzVMlPbgJg7U5nltahZ63mcBTaq+SczeiZtKd9a5rQYftY6kfKQURxo7xAcrelx+Xs5/2DTfJCz8i39ogQfe5pZ7d8mX2JSL8rfglxETQzvBL0OIVkcllIAC4bbjYBjk5C6MunrdlNS1lEdExAxNVwiN/MF5VzD1fJshs=;7:PaY6iWk7vyj3LAN1dritbvCMGOwi7t05boiKuREbBMlAVQxe9hnX6JcnQukkAaEX82wcjpLdEXvLfouCFQtkZrAWqhXsq7tdTzj0iIcd1Peij3NDdIxs7mzQTdt2O0tz8J56J5qEmgPLHlT76TMRYA==
x-ms-office365-filtering-correlation-id: 28988e7a-3440-45d9-62ea-08d65eb03242
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB4442;
x-ms-traffictypediagnostic: HE1PR07MB4442:
x-microsoft-antispam-prvs: <HE1PR07MB44421ECD8CF0C2F27D6B93CCEFA50@HE1PR07MB4442.eurprd07.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231455)(999002)(11241501185)(806100)(944501520)(52105112)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB4442;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB4442;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(6486002)(6436002)(256004)(54906003)(486006)(8936002)(305945005)(52116002)(26005)(186003)(66066001)(81166006)(81156014)(6116002)(53936002)(2616005)(36756003)(7736002)(476003)(110136005)(71200400001)(3846002)(71190400001)(6636002)(2906002)(316002)(8676002)(99286004)(97736004)(4326008)(478600001)(25786009)(6512007)(386003)(86362001)(14454004)(106356001)(6506007)(105586002)(102836004)(551934003)(5660300001)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB4442;H:HE1PR07MB3434.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QsG5ijz/elHR9SzxafNesMWqflrGUvEiXlS/EEEAt69H+cmJHRkpSHa8DaNEWThCKOJA9s/DgxhiN1S6QvICC++iLWjnElncxPLACu4UgsQEauW1oLGLsMVvkeR9U7Iii26RASYH2uJUFGFCjzPmUEfMzipNUaZYmMS4L6O1c/LVoQx+OqmHDCaLq7ztcA+JnFubV3C0qFRQr8lvOxO6DP6Bo5cPtp0+vIWDw2+K6UquHaOXvD4/tcSG41Sm59kmyudDFC7ebDZQxD4Au/VGH2rN/J+O9eWilcSpO3CJZOkTjh5zXTXYq0upIqmrc8ht
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C803EC27A8711D44BDD9335C563E21C2@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28988e7a-3440-45d9-62ea-08d65eb03242
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 15:00:17.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4442
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Woflram,

This patch was based on your i2c/for-current branch as it adds to my
patch you incuded there. First two patches are just preparations and the
3rd one which is the actual change. It allows us using hardware mode to
send i2c transfers consisting for a write followed by read without the
need of the CPU interaction inbetween which is an opportunity to trigger
25ms SMbus timeout and abort transaction.

--------------------------------------------------------------------
Krzysztof Adamski (3):
  i2c-axxia: dedicated function to set client addr
  i2c-axxia: check for error conditions first
  i2c-axxia: support sequence command mode

 drivers/i2c/busses/i2c-axxia.c | 159 ++++++++++++++++++++++++++-------
 1 file changed, 126 insertions(+), 33 deletions(-)

--=20
2.17.2

