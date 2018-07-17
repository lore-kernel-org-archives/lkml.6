Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F29ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AEB208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bRY88sso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AEB208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeGQFru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 01:47:50 -0400
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:22653
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbeGQFru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 01:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5FUGIdUQU/dzQmHcGjX4HjbBTINJXWL76PIM7J4AuA=;
 b=bRY88sso+mzCqLMqYjeHJyn/UNnXX+82VNRWuaHPlIens834l4SPG8OLtZMkQxmLQraHhoiVLGqPa2f/qUpz5PTgAX173r0PCO2l7HaXKA1DN5bm7NCJ2++9ZnHb5OwT0yV6fbak+kcoQExYhCPpBGV0bVEx3OaR91EEl5ua9X0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Tue, 17 Jul
 2018 05:16:57 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yibin.gong@nxp.com
Cc:     Linux-imx@nxp.com
Subject: [PATCH 4/4] ARM: dts: imx6sl-evk: make pfuze100 sw4 always on
Date:   Tue, 17 Jul 2018 13:12:05 +0800
Message-Id: <1531804325-3476-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
References: <1531804325-3476-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::32) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f88c263-bef0-4cce-0478-08d5eba486d6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:niH131/xqmDIc57dlh+WxPNnPSxv2N1GgYxzHVSg/pLFM9F+Ks+O2Wxv2BEkgnzTGCDFHbrsOV1giWyMWZ+Fy5CpFLKIbI0RoSYYMvAnaWBBSED2BcO9KF5uHnB/4ClSoYf40kW/cm53NfY8paNDai2nEDMw1cY8u7RZm9Is0gXIWFOG1BgbEc27GWkPwT418hAjlqCmc+mCIHDRz/ToIVpGNawATvGpHhq7uh8AlqnALzuX/PIqTPdbRPorZDH3;25:yxJOcKGxE0zOPapSXbX4kgQ0pJrRcA4N1lGurPWaa+iwiwiwsYTzIDg3Utux9Mn8/pthN2VPgKF9YfDqQkPZXDgXIw+yyT+jOHM1Ur17CfAiy2FW9VMr8VRgUCjDagHlh+ITSupnuArHasCsIsgP12JF18pD4aVzJ86o9dnbLnC3MIxzzPUS9VQAuuglcJlvnPNSD95O0BraYF/awkCIj+wAnEDai7tvwx8J2W43u+oOT75O2YWGZstiOdgWuA163tkDPmYQkF2fAQlDHPc8/7N01F0Cho6008z6RPCJmalhfo3C9ImcVxaLQtcV56VmCpzHFf5P6uFm+wMSmtBOEg==;31:tHC2k9xA5qrcnFM/neOcc0cS6tHtJvmFXfIp8njN39zwLmQ6hArFU+rsR7hKy0JVLCu0Vme46vTcsBR0mv9NMk/t56HMH9kbUfs8vyNUnC1N4rIbiFRg2SdgV6cIuWksa3xIK2tWCyk5rMB9O4RPky+M05NB1vGGS5xA+V/RkDyIz02WHMKg0VEOQWPG95CJJAVhX7oh+pS7lsb6vhBr/osN6MN3PPBhDd//8gHI6q0=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:tTdVO82Amweq0ZzcS9QW0KAejCEhvgxVIj2jzHK9QtAOrBMaN6BD4bxzkJGLegjuCvEZUeQ0dDsLs2vV0Lh8dt32Dj7nE0uxAKa0OzG1M4fHLgb9rTpmU5vbfjpmc8CU3vOpDWPN/4b6M48nN3rLqINWUYbJgFJLPHRWPpOw+RUTf98wmikJhEN/GcMNuckOuxX+77XCPiSccXUNDukZ2kO8wyxPzmC5RpAeKLW+9nBa2PY/0NXSP9bQ5gXj1w0APE+zybgrbNplpA0/+7okYQNrC9L34/bCl8TnOxjF7amxwUL2mpDLMusLmenKZNJq5hhsZM5MADrcjhHC1aBscy/5dk8naJjyc3JYcltwF5SK8SFgZGiEQet7gBy8mqZ5r60VxHEVanyp2yTBYFUMsnjKFwTagWBaL2gLRTV46u8KUSyn83d0mr/ZcpRfsLY4Q0f7hj92KGRR6xWI93RzL6LgB1YFBkKEVC1XhMCLgUl0RWZfe1qJTXC8Lm8MBp9f;4:+UNcJdqVrzaDF3vMnlo16DCRcIbUnBsYBeeiemuq4NbLgmQtB3adc6t5yhtcKt0Ayt6s/n6f7/xzcgFEP38VnBft4oKcOyXY3BGehyRKMo/N7H4K2EilFbax0Iw5taNlJkdT3jq7KzpGDjsydyVxajzqUh8PH+Xtkxa03nLe4cHgYhKa4YESuP5XW6N3dPL+HuEDOHY9cuM3Y9fBYR2uV3qyLgy+UGzH38P2rdJklJ3O07qZpj74rRZFv7QdHcWb+swd0gBMlAgASj8lucVg5Odkp4u5JqJZZ9JFsWzPomy9n4aGrQpmnBNFAFfbIK0S
X-Microsoft-Antispam-PRVS: <AM3PR04MB1315459320AFA4F721AB7742F55C0@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 073631BD3D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(136003)(346002)(189003)(199004)(50226002)(66066001)(486006)(6506007)(25786009)(2906002)(47776003)(16586007)(68736007)(478600001)(6636002)(86362001)(316002)(6666003)(36756003)(50466002)(386003)(26005)(5660300001)(48376002)(106356001)(956004)(2616005)(11346002)(3846002)(476003)(81166006)(81156014)(446003)(105586002)(53936002)(8676002)(8936002)(6486002)(6116002)(16526019)(4326008)(51416003)(7736002)(186003)(97736004)(305945005)(52116002)(76176011)(6512007)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:56o7duhzppIpLxbXfmHHzQ+zWogr2e7QRRwve/RFY?=
 =?us-ascii?Q?tXtlhD+5u7Y3kMmqaDfXK2DSsfNgbjDV5yZuFVXVrNiaCMw8nVpT4s1ragdn?=
 =?us-ascii?Q?L8NN8lWj3yhKzulUMHUcZX8lOV7rL2mBtqWZ3gCeNVbLwGf6C/ZAs+yJReiK?=
 =?us-ascii?Q?DaDNcfqeDzOdv3RBpQGIjzol3k9lXrxK0TbwynHnVo2y6beopoQmAJvj4I2+?=
 =?us-ascii?Q?0FUsDioOaUMWN9sU1+Z+w2SMLCZ0hLQ5lnaYsUDWVgfKu4uVohBUfYtSe1Z4?=
 =?us-ascii?Q?28VqTFsUJUbTp0OU9TxTappG2cfP5mpKX19WzWxNw7oRhdvcZvqh5UX2Dbbv?=
 =?us-ascii?Q?yRBdQYDYfx4seR4geM+VS8/kYQ2l+iiQYuCsgjmvpLVKfHc3V8EjfG5PI2o9?=
 =?us-ascii?Q?9t58eIPr1O3JVssrKoWdvjtCaPJ7eq/gu8DOVo9v6s9206wLn2TvfXg+iEwu?=
 =?us-ascii?Q?VRMKTh4IY0Ft3BT8SVg/5QXS+y3m7HiTldnf1t35rwrH8KasHwrOT2NwrNPr?=
 =?us-ascii?Q?z6sZ82NTyG3cFIsu27qvsdnPC4L05ydem5pkarCGCBJVABjKkn4EqOoaCiRm?=
 =?us-ascii?Q?mwxBaiD4LIOAu6I7O9/y4VvLxEJalcGFm7mqMjKWFogFTpcNnhQVRLJckmqU?=
 =?us-ascii?Q?yeFS0pX8quN91B8lqRnCpm+40u+ns5hQhuPC0O/+jyCbdBx+viyS+QdTLsxQ?=
 =?us-ascii?Q?ONJNXeXu4nniZhCJTKDMntiTgf6xqRXHtNaVRYQhDbSKknHsaAYGY4x9scg5?=
 =?us-ascii?Q?Z+U8MQIpewg4jOAcC475GFezZghwH98txE/jzIIfww9qNqegQEjeWnsL1eE9?=
 =?us-ascii?Q?69h0NwAXgDizNvEMWheDsbRg2kidq7naTg1NFHhV9zrReWf0XycP0+fiAOe0?=
 =?us-ascii?Q?mRKrAkWgdhlAIQf3oL65+ngcEWhPmUQvkJRAx6jhCrWROY9QrbQbEVOIDK9p?=
 =?us-ascii?Q?TkFZOy9v8NfhFldBHJ/9DCCtBYvS5u6xo04PN8rfhFkIO6TW2BD8Yh+yDvCt?=
 =?us-ascii?Q?BrQ6OXerFBG/R3JCfkh6tWjhvZJEm3Fa82Rpm7x4vXvwHFi8rX7hx0OoGcLw?=
 =?us-ascii?Q?BeaCaQ/1xqBM2yYdceyQ5DAZyw4tpS2YUE6axpwKlZcqbN5Pe/s4k75IY8QU?=
 =?us-ascii?Q?pAPWD4wiWv7xKuP5w8M16Q7NL2yxjOQWIM4yKAdaGU3q7a8pONo7ySU3VCBp?=
 =?us-ascii?Q?mmjD7MgNk5wj8KCVin1jo0YUAIuzWR6Sk7eT/6eAhmBxJye1bDnEeRs4w=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: Bhje0PgU0orhC55trtLtTLbClErqyav5xrgACQWGyNsVUjh+FaAhV826Bk4Cf+C27MdXnvaZQg1t4pQ43YFVk+F1gSZUTaY6BGYhsRXIBNdfF/tSoAhxovO4d+u6gSkwjCR5RPRKmKro+eZd+4gGkqzVvSxtUuEAvQSK7RIUxuSsJcwpMQaVEkAXQa16J09nZDWckqkJiiZ7kQyFdGnDQmkJanzy6WZvA62g8ZtZcsJs9EgVqUviAO6LizSr38NtGxG+LoDJHpZ94MwSA4QjWAxMY93NSTFYk+hxaowliIhJMTniDScpUi7lF2gS4qGp1fgJdMTT3anqEtFFLOga+fiaR0ScHPGHYgWBOnmdnts=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:0vHef4S+PhJzFqD2V9Q6081AlMAhYFVjD3Ei/9GEgyUcanQVU4W8lCdfpH7L/YyOmllhwbu8IZD+yUIizfbK5DDj2PhhvIZEVJnCpAWQcti12szycqJqNRIvXDweP066Yt+k685yp+055ayoMIOy4VedMK+GhKx2GJJ9U6vf1rucInfxI0NcV+EEbLHPbE8MQhyIyOKP3U5yp2uGSZ3fP/+J3+N6U/z5I0/4YUxARV5ZgQSCHkWbJ9KfBpbNeydY9gCDGHmoXdSVRqnwXCYIuzFPLU0SCrbLcJ7Wx1QoSx4w0eDvLZa3R5KXC1XRGexSVIF+TotMiuyvJN6uZjNG02fzim+VblDsyRL51lU+cPnkq2+Ia2xlfM+ga7sUaf4msxaujWC8CKAY439vDrEHVzDy1VeAT8xu61F08JPCk3tdCQ4e4e2UosvRNGT+OM1d0p1WXSUAaMy+ukxnBuGgfA==;5:8nOyN2ECv4J+b1Q4gMWJRwRoIktptR4f2sb5fLMhEhMQ+6m+Nc8tsdCb5wV2iz6UHWzCOszGcBIezfubZPV4uCgrjRgp35d/RA7ntnEj/LM6csJz0uhFQ3oDfAb0iYrW6O0z8J7Zi6jXLLHteytrzvjciFboEVemfLbDnjFYPOY=;24:vPunUdSDkUDNGW+MOWJeqc+Pr2gXvGVtAwW1qybPh5iuy5vJTfndti25CeHs19WFJSBUxx8ed1uqz2p50Nksd3MZcD+otyS6NCBlMGZDyJI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:fBBwymsex31mqiW/Dvjut5Bnewh2Ayv9Mml9ELxsmIXC/pZkR7o7tVl7pmsUo1y1Bsa4/wAqeaFe0xnbb31vfjz5vLsc2OLomGhPpI01UYM3BuV+vY8W8Huqj0VwxAnv1VkggHgC98jYm3MNLpxr5mAHW64ML5XSihetERacU7P0x0jUGacsGZj2teZHviTU6kKLNz7m15+7strEqr7vFOL3adchoeN0aNFabd/9pBtRYuBj9X8L+8CdRUMDZ9Jj
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 05:16:57.8614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f88c263-bef0-4cce-0478-08d5eba486d6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Gong <yibin.gong@nxp.com>

On i.MX6SL EVK board, pfuze100 sw4 supplies
LPDDR2 which is critical for system, must be
always on.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 046cfab..679b448 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -201,6 +201,7 @@
 			sw4_reg: sw4 {
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
 			};
 
 			swbst_reg: swbst {
-- 
2.7.4

