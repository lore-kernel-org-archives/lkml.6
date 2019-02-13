Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2B1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698C4222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OTi6GhZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392546AbfBMTHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:07:18 -0500
Received: from mail-eopbgr30065.outbound.protection.outlook.com ([40.107.3.65]:34493
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730942AbfBMTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Rw71WWwyLVXH8o3lP2EgYZdWVGz5uiXKCDWt0BtHBk=;
 b=OTi6GhZ/Q97f7eZvXpB57gA26iRHY0hoMaLmqHQq3F4acv+RkbRHgDtVewKkT8uwKVe0/eJhX8NH0ITo6ee4z5oz6Ewefi5HGw3brEhsSKitg/QMlJ5imwM2SuslnRMbpiyQhqffqWYsoOeiaSKYAL+CkOzLDmMpHIoztXvnWa8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5012.eurprd04.prod.outlook.com (20.176.214.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 19:05:14 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 19:05:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 2/5] dt-bindings: imx8mq-clock: Add the missing ARM clock
Thread-Topic: [RFC 2/5] dt-bindings: imx8mq-clock: Add the missing ARM clock
Thread-Index: AQHUw88MHS8LHxaqrEeZDFZsxI5zZg==
Date:   Wed, 13 Feb 2019 19:05:14 +0000
Message-ID: <1550084693-9797-3-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:203:2::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89a88e86-d699-4cd6-3adb-08d691e62ed2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5012;
x-ms-traffictypediagnostic: AM0PR04MB5012:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5012;23:bsj4AxI1fEGaU4zJ9uphxOsUSzua56pw2IfoN1a?=
 =?iso-8859-1?Q?ePw3fjrjaIaI2hQ4lRXRKmVrW0lG04Mj0EGvPfPj1aq9cY6pCWcspn7K6X?=
 =?iso-8859-1?Q?eSOzHyYVhRSxRC5NQmgOe3Ulrrk6R7uof/Jco7VaG3CUtaVVwReOYrG+vj?=
 =?iso-8859-1?Q?umhsGwLn9eQRGBvE6dy91zpaXe0UAGzHTtbD7YVObS9EHUYkWuGw3xHBcM?=
 =?iso-8859-1?Q?BX6T3Hf23qP8yNCz9bZUaRsURESAF/Vfs7rrddtstnnYTetmqqby2o6Png?=
 =?iso-8859-1?Q?VIgoXivrIwtYnB2VLqbnLhNgc9W7NbjxdUtgAZD2HMvD6BATKWi9FkEBVO?=
 =?iso-8859-1?Q?BJbXiGSLn88rhFAmHj3C7fjSohWsXt1lpW/oiijWCXfYCQLOaX+9glDfQ8?=
 =?iso-8859-1?Q?Fhf9uGygEfjnO4OAL1tw0qO1HEiWz6nC5OKESryO6Jbw09c9SFwHbC4OTj?=
 =?iso-8859-1?Q?FFQNZ/R83ihfouq7Bf/sEGbmStYt7m8nmN8iiCMbt66NXZlpL6eHBwpYaO?=
 =?iso-8859-1?Q?T31g8Ethypy44x/fS1tO4LufqaCgP8qZw430r1ILwUFlda1bXDg1Vh1sAB?=
 =?iso-8859-1?Q?aUwUdaNLaGq2pPuQlIwfxyMDKsUWh1DQuwgex23JePqLHLzL2efLTWCKkE?=
 =?iso-8859-1?Q?yquz+Me6Co8oiZe6th4l0qUisAsd/u7hk8pXZaOsurD2RkLeWoeRxKNJX9?=
 =?iso-8859-1?Q?tAI8mwDLpLVTf8oSytbr9q0fWU9Gxap0gJ/lvmKHuTZ+NfCQAkcpy4mtv4?=
 =?iso-8859-1?Q?+ycidCS68AUglEny+sQBu1TAOQYLzVarEMuRl+Ld/PrTC/8tHxHtu0bfIa?=
 =?iso-8859-1?Q?AOf8maUtRHDwxZAOYdHHkFD5yEgnuRVmmmrQSI0qcWFWs4ZBqX14R1OoMq?=
 =?iso-8859-1?Q?/w9Qkf+lNAupG5c6yvP70aB/qV/ux0qNJJU0wK/RoG8DoJuByGPOerfON7?=
 =?iso-8859-1?Q?BXhJ6ecpp+iUkoEuWmS89ucXiUgAIjrCi2gefNB+2+BOeVijOnWrI1GBg3?=
 =?iso-8859-1?Q?oyk8pg4qnmWS/9d/hv52TeCpl7MFgBvNRzq7Y1nV61eroS2sO8ARx1Md/h?=
 =?iso-8859-1?Q?aMqXQdvGUyoiY4ZEbo/7wXc9qhezLz0d0UKx+whhGgLr6eGs9V3Kf6HSAj?=
 =?iso-8859-1?Q?sMEu3XKuIY52/fbsBizy5efu6XHWiQXIZ59tEAsBGIF1571O5A69epaxrD?=
 =?iso-8859-1?Q?ewdBJP/zwqJjQbw3/mu/Ctx913aq10dh949WBf0K59wPQ8HCrRPhDKkVHm?=
 =?iso-8859-1?Q?SXEEO2a832w5H+PVr0C56ADQddfahuKxijyG7eQvYtEve3+V4JIa8rwvHj?=
 =?iso-8859-1?Q?F2ln5YiUJpc0P4Dztspe+WH?=
x-microsoft-antispam-prvs: <AM0PR04MB5012F8C15A37E65B7CD2BA75F6660@AM0PR04MB5012.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(376002)(396003)(136003)(199004)(189003)(36756003)(186003)(68736007)(6116002)(76176011)(3846002)(54906003)(66066001)(52116002)(4744005)(25786009)(4326008)(6512007)(476003)(106356001)(26005)(53936002)(110136005)(105586002)(256004)(446003)(6436002)(14444005)(2616005)(486006)(11346002)(86362001)(44832011)(2906002)(71190400001)(81156014)(8936002)(6486002)(7736002)(81166006)(7416002)(102836004)(316002)(478600001)(99286004)(14454004)(50226002)(71200400001)(386003)(6506007)(6636002)(97736004)(305945005)(8676002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5012;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /273hiyxNPb/UXJRWdO1EuZcWkej2Pb6dC6dMAa3UU/xJF5umRfV+IOMkDR2A72D8SpHbYh3WerDe252BqVZGBhlJBVRQhshP9HGt2kg4nz4fFnJ0SQ4vo8/sujh2X84QVC0RFKKqCDxyzf9nNFnlT5HWX9fcb0qVUGimXUUehqM9JxrNplbL4P7lkoByRsP14wq8Erf955Xnd86A8EiRRoneFrqKjn44wClE05a3zZ5yskOhc4qI2vramnGHk2olCb7HMqJe73IExwCpfCwfpUy27FdFUjlBVd+gEqxbt3r6/E7XxCtJ7E8G7f13kGqb7tLuzFpaFgz8KzRh9lKWe6dLualaAZTolsnTx+jl89YZIk4qF94pgufq+18sza/PkaAMqNAml1DyKFI+bOrHBv00yleTRCShPYcuwGiuqI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89a88e86-d699-4cd6-3adb-08d691e62ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 19:05:12.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing ARM clock which will be used by cpufreq

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
index 04f7ac3..47c790c 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -391,5 +391,7 @@
=20
 #define IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK	267
=20
-#define IMX8MQ_CLK_END				268
+#define IMX8MQ_CLK_ARM				268
+
+#define IMX8MQ_CLK_END				269
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.7.4

