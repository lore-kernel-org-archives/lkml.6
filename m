Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69FBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68B42064C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hzn4XgNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfBORsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:48:55 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:41470
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbfBORsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5F5uIdSB82po2NrFHPV4NVNzPf/6iUiTr2LqxEnx2yg=;
 b=hzn4XgNsGOJ4mM7Ek5C0VbLtj3/Y/lDnzAX+m4860wbuxL/0uDpGMucFx9xuDxEXHnrnFoJZJcJC0wjcSGDiILyXZ9nN4vYs02+hTs7/zUV5Rra8bv+4Ww1qz30BUqA14EHqZlVBl3rzqF916wvWrkxP3dNMMtvcui2s4tyrBfQ=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5330.eurprd04.prod.outlook.com (52.134.93.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:48:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 17:48:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Rob Herring <robh@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 2/3] dt-bindings: imx8mq-clock: Add the missing ARM clock
Thread-Topic: [PATCH v2 2/3] dt-bindings: imx8mq-clock: Add the missing ARM
 clock
Thread-Index: AQHUxVayhp29U+VyEkyX04qsEg/skw==
Date:   Fri, 15 Feb 2019 17:48:45 +0000
Message-ID: <1550252913-24532-3-git-send-email-abel.vesa@nxp.com>
References: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:209:1::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad16e2a9-7a4e-43ba-8d43-08d6936dd48d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5330;
x-ms-traffictypediagnostic: AM0PR04MB5330:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5330;23:ye3tlgApLYGJ++VV0xjj3Zt4bbicIp1sOqTkAXB?=
 =?iso-8859-1?Q?ldLm1jF4/IwxoGWCECmi5NfcfMCWvqka781hEznSFjvphWPwYgGjm92nXj?=
 =?iso-8859-1?Q?4zkT8kBr8ur7YXtCB5dl+Fnez2fv6yKC3WxBXCCu5vKoSyZ4TAUZaGmxkT?=
 =?iso-8859-1?Q?sgV423ShbjNZQoR0F6D8kpEU1YyuHIGpo0vVvmCoFDtXQUGp7DvaKMsjA9?=
 =?iso-8859-1?Q?Cu+01C/Q0vsYU5MbJ6WIyUNo1VA15JNdw2uUxovI7hoQ6dwAaKHv/SIk1p?=
 =?iso-8859-1?Q?FIOJzYrb77VV/TpuiB3lwp4dlMpwaZSJ9dCjs2VTeA0n/MGfTFOEb2f2nX?=
 =?iso-8859-1?Q?76ro1llFJOY7mMDQiB+KCyB3J4qXMs8+SU9EAJ6uF2WaxZRn/Zft0ayvp4?=
 =?iso-8859-1?Q?GjfXdz+bb9s8pNoWMbKir46IZD1X0t/VuGbbbuQEuy1iqMzr47YFTwlqGd?=
 =?iso-8859-1?Q?fYI+1EEsMyfKCPu9ByCcMDxW+zEGBmSZ/x72wkEnLr7NDJ6IGx4+oo5H58?=
 =?iso-8859-1?Q?Nh/lsqxthukpTrlU6q8GRfXT4BIP/p9Zc7aQ+/GX3//hLTidfpwcV/Eo4r?=
 =?iso-8859-1?Q?g5Vo8CKpFsLFIISK5FmRwGOgSvHJ3MAR7LMRTcgeCdQVqMSCtfFXrqqHnR?=
 =?iso-8859-1?Q?c2wFDM+2ardk46j2oNAKs1b2VOoTzS1XcXj9AGr2MxipB+X9NglmBnQMrH?=
 =?iso-8859-1?Q?Nph7NeavXi/ScMQdMXl5PZ2KGWtjQkS4w2RqGEuH2fKgBjiJqC9MuhaPFx?=
 =?iso-8859-1?Q?N89BUGPZBUeJ6iRsK0Pc9oPe7XkSDCNC+k5cDJ9WpcTJHE1ihmXJZi/K3J?=
 =?iso-8859-1?Q?wt+GRh2OC/CoBzFsWhYEOxm3Wic1hI5Bur2Jqly+a6S30/qx/lAG/nX2pD?=
 =?iso-8859-1?Q?4dKhtPhc+btAuXdNbpK0pqUSAjCSWMD184e9p2jYVBm92a6lmtsIdORyx1?=
 =?iso-8859-1?Q?QpSU+RvMdsBiiaEtgpt+gTTXOIjssPyRD2Tlws07g2fHoC5Q1bWTC0z0VN?=
 =?iso-8859-1?Q?oA8CPs3AwofccER/wR7E/gsls7u6KoBRZsjXQ0FJMVKepw2rLu8VPn96Hk?=
 =?iso-8859-1?Q?7T0qgw804qj54EN+oAOpAgAXUlyjD/KQZxgEcmxsxX4p9zVBpn7SYwODl2?=
 =?iso-8859-1?Q?E8xilYVu5NcU/i5Lk+04ZD9SxPdGOxFDjFANjcOgMbWF9IDImNz9NvAgYR?=
 =?iso-8859-1?Q?+nUYi0CwCTkdPTwUW3TId5MY0iRjtxyQ4DNNmuSbhb0BpiogilTVmlsgvq?=
 =?iso-8859-1?Q?Gs1HRElU2v4WB7WRYcM86kwnS1BJ+iMHgyldr+e1favStdhFD7/NnbEwSw?=
 =?iso-8859-1?Q?BU2nsPPi0ymJQcx3I70Lu8Q?=
x-microsoft-antispam-prvs: <AM0PR04MB53301370168B83797E99999AF6600@AM0PR04MB5330.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(6436002)(14454004)(6116002)(3846002)(97736004)(186003)(478600001)(476003)(110136005)(71200400001)(105586002)(106356001)(26005)(71190400001)(11346002)(68736007)(2616005)(86362001)(446003)(6486002)(50226002)(54906003)(316002)(44832011)(486006)(7416002)(99286004)(81166006)(81156014)(8676002)(53936002)(76176011)(8936002)(66066001)(386003)(6506007)(4326008)(36756003)(25786009)(52116002)(2906002)(305945005)(6512007)(256004)(14444005)(102836004)(4744005)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5330;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y05WqEzVvoWhc/WIv9ucbwIDT0b2CjW7VURmAy7Ak8f+X0mx43EIfqWpPFqWMONuwD+jJIUVFODSmPVcxhKN4VfL+IjRnGQAc3KNsI4NTGpIlKuoJ/L5+ajLII43gsGYe5528EPSSn4ot8toiZzAQ/ibK9vSgrYhp1K7QdEw7ekkOqcM+8QXR+B7HTFMbYwYDhkkNPL2muRHEkLqSPjQlT0LaKUcy8E9U9u8Dr0s9D8OfG5QuDeVPPHlnoDtPhceGUqE3xadN6GLFrb/TkHRQAiWvrsTCeN45CAWBTm0MD0pp6kNhJSj6Jjz2HUfu1SCG+ASACXPujle2SjZCkSkA6Bks2gSTBuMLsPIPlGDUdY3m587QJVBfjEGxZTHcJ6h6VZM2oREJp03ZxbwWl3piAk4Nh2mY4LRS1ty7MMrQ8I=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad16e2a9-7a4e-43ba-8d43-08d6936dd48d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:48:44.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing ARM clock which will be used by cpufreq

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
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

