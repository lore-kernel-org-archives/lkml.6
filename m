Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeDZHEL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:04:11 -0400
Received: from mail-ve1eur01on0084.outbound.protection.outlook.com ([104.47.1.84]:6444
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753886AbeDZHDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:03:02 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 3/6] ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
Date: Thu, 26 Apr 2018 14:58:15 +0800
Message-Id: <1524725898-27974-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: OSAPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:604:d::30) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:CL9HME2Xtm6+RMDpbapD3ZW3IJtPxMnzGVqjRKn7XuzmlaJd7i8Dt5s55rjY6tLXZybEASqlKFsOnj4IKhj6AXNbtikWWPppXTuLlh0xMIcU+/4AyNtdthB2yA7zNFkAMXTU8JNkWpyp7XRTBizCfv+ddEm7nGoqMaiat6Oz/L00iStdqOnVesgqlaA51UxWwYY2OSHJDZ3Bmf/yRqFuDutyHoyEruJWQXFdcpU2xXoctfadoC9J915a9ejELVu1;25:cMGHUdAp+OBJ7l0671rUhC4WnP1Tqm2N1dAK+bJ4Shk49wl5wbU0URHuPoG9WFwBnCvFDuQZrWNsRKIs861iimgMhKe8JCK8IXmMb9e4H2M3yiIWy2fMFKR4PdK9qTg045arQQlMZbdHonIjV49vuuNSovsPIvhuQLUgkzdra5o32Q/4pmFNSJVt+UWTcQ5wCkfo/MSsq8BfDKts1XcIl35QH6eULpzIG4QY6eTGTM5JczsLlWJ2WxrgqJ5fDbGlWvloONHQfaAea6jwP+HivclSw2LwtWiqUTxv6tKVFcPAC6cCWKq3UGdmOSiM4jRZdQnYvo6xe8ijlHQH7leB5Q==;31:rWCpXHkwaf9HvaTS6IIdzjYUMGGDEBbfxqUYk4LW/nQFbkIdVFY0okjHOHdfECT/bzuqzAKV4tbYog4M2AF2gra8YEaLsGiEYoWFiPXuPVQWKxgVMM/1z9hIYlh1+ojjAsHZasDo+EKhDepcB6yLRkHA7RBjslyle+Cyfy/O6KPvInFz8upWxsnWslDnaav6FEdA5X+o9uUzGqgxmgylRQ+csPeKg01pd6KD6UtN4EI=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:2J2iMVtKiUF+KB3TTLGSaQkhEFxoquSQtD9Uad7pKSKB6sd+FMhveN/XaBtRd4fxcuaRsMwvHkX5UhsaWHwxjAOYZdk5OTK0o18p+yQB7e3i9nqz8fqIYVUPmVizMu3e8QgvmhknWSeFOd5e3k5uf0935bAAEvQHK7wLgcWFf/EnvyN9jgLZ9wLydHFPWiCS4nrDam3qPdzqvpl6JCDNhoCrdMtDqxpKVXjXxck4GTcycSZk5cQViQb2kBvbv4pU0stCqIV82VkLk1dfvuXjncevMyXQ4cO4vKJol3ltC9q6aUJ0UBd177It8AznhqnHmSXJpfn7Dj3newd7M7el9+FxstrEacrKz30cDEMeJmrCCT4OJlIuT6NhCuHxzpNoL6lhYRHTomliz/adMIKeK7tZGQd99voMOgCDkwHpjwokIsj4vQElYopU9hb75MKnIr/rLYkKuB7eS1EgQOuiDZLqPWILWSXOoAablGRoKamPMlpremUWZv05f5aEe4K2;4:YhMn8VOcGf2kRWh474+cnX/3rAqlzoelKWnbYNhCS4M+Tf32M68LrL7CwdA59ggOa6r6OYnZJxAAz2qWrtQMjNQLG4Pbbsuymk7eLAoodYTbU8yRgIG2ViTB69BTlaF1kz1hWPOCcnEji/AMJ1gMmx2LhKBBpwm7oWb/cD+3ksvnUELItS2+8dDLuTpJlhmqq6KYdhzjKzgVy2jVqAeyjnbl4l3HWCFuibwknN5+hpgFUhfg6i1NfEITNJQXaXthTsOCVSHTnduB/xIUxElFy0jD4RbB80Ozzc5KlB1Q837cDdsgom6t0u/8SYzS79fZ
X-Microsoft-Antispam-PRVS: <VI1PR04MB132774EBB8B6E575897FFEEAF58E0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(36756003)(2616005)(106356001)(8936002)(11346002)(6486002)(97736004)(956004)(50226002)(25786009)(305945005)(7736002)(8676002)(81166006)(6116002)(478600001)(81156014)(446003)(105586002)(16526019)(6666003)(51416003)(50466002)(3846002)(47776003)(52116002)(386003)(6506007)(6512007)(316002)(16586007)(76176011)(26005)(2906002)(186003)(53936002)(486006)(5660300001)(575784001)(4326008)(86362001)(48376002)(66066001)(476003)(68736007)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:qi1sFcIUoBCxhRoF6oBHlihihygKblppLe9GL4Jad?=
 =?us-ascii?Q?MnMhb+6XG0yx26MbLzcBOgFbY6vTscOxvJPPJUv8PyrQ7T1Rr0A9ZpoO9xEG?=
 =?us-ascii?Q?pQfDugeiCUnZuJrEc6GP610z32ERdDAO+kilJnqvYHZvJ+lGr9o+mH2HlFcB?=
 =?us-ascii?Q?z7QAHKThYS2ZWY6rNCNTTWzU094Z/QAl1w47Dis2//3ysUwZtxqnqe8eorhH?=
 =?us-ascii?Q?inYJetu1RtQEBuEDWCeyJx5/jWS7y3N41zc8mrJywTMkdItWVugshadd7eNM?=
 =?us-ascii?Q?DfEyjI0ht7xHpUcNGmk8MWBVGEFnlN8K8E3gg8cXXbyrpEk2e46RNhdcUwWv?=
 =?us-ascii?Q?7g59cmUEzzn0UQhFvY5tdwPdP/SLwabTeD7Yqwdl6CS9STxmRIz9nSZJz9Eq?=
 =?us-ascii?Q?6bU+ggESuLdHDrJzZ/fy5R4w3t3dtNy2dvl2EJOV7sYvOLxQp4vVaf7FyQm1?=
 =?us-ascii?Q?/mLjFErjoqt886OOmaReoNeYiaDWf69BSnis3LtuXriehD73JUCwtBl7FzNk?=
 =?us-ascii?Q?3oWCWjJWGahELNncg4Y2vJQqxyU1F1azMXjXwPoZl6yuGqKSPSWJPOTy7eVL?=
 =?us-ascii?Q?jj76eSMRo8DjkL1DodBlZVyObkeWs9Bx3aL6imezZ6Fualimzx5VDpQ31Klu?=
 =?us-ascii?Q?s6KADwRj6T7s/CYvSXSPQXS7LHDdB5jDVgfls1ykM8+nwKJTcZtC+rzLF3rx?=
 =?us-ascii?Q?HLGqf+4jd2Kp3n1B6EY5aueF1MuO47Y2amAGNyTPv9utj5VuzkYy1bamc7Wb?=
 =?us-ascii?Q?hoV67SrRZplaCVy9S1vTgUhuVneWVhNKInXPwPClQ6PsT9Kpbt9DOPAn+n/e?=
 =?us-ascii?Q?34UsMOUiIsnFE8MoEPakMElNDdt/etj4clxfAivEDrVI9h9rGxTffW6Hi87P?=
 =?us-ascii?Q?faa6gYktzVnpLGY3Cblh3M/Mdpcm4k1jFFy/3f2/pd8J2XiYdpSKoGuTPKJ2?=
 =?us-ascii?Q?63PFB0dkeQ1nvqCMmKlaheIOqckmJSuy1BtkYVt61Xhgov2EGdkOZT998ILF?=
 =?us-ascii?Q?Yaj7klIkSfj5W0jaINDj/H6sf1mjLuuBLJCxMRQtEdZOh5rz79/OS8gz6P/V?=
 =?us-ascii?Q?vF0ukuxuJuvkN/5+VmW8Yr45W39c7nxsT7qAsfrBhDx5GwfI8yfvdEbnJGIJ?=
 =?us-ascii?Q?xH+D0JlgFA1PTOnNFbDBXVH27dXAHBl9UvDueEceY7A1UPJxRNq4Ohc8Ygse?=
 =?us-ascii?Q?xoF1rUZdzlpjnqrUVPenl0x6+awWa9qdZEFWGut7dj0cFcoB/c0Oc5l4A=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: tZfb6wn8zXKSKkuepsz9rRh6tmo2U24e3D2a6Nr5EAMIXtVecfJZrE01/Ra0m6lDB2YD5zYfSQ4WF1eAZIPmRCFXwVc1yEsJvgYjVnKd5rJP84g4XTbv5do0u9eoo2bfJyzBNBw7wNPghItvv8pBa9KiB4PuqtmiphItBs7Agsuh0RpAScGnohate2EDQMnI
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:s/WOoFAp0TwRVhfSQI4bwJZgOuoUX3Z7IquNRZj4g8e7eh4cHKNE4Y5e+nIKqjC2VrarGHCd5Kv/6aKgcD8mPvXvg2ZMSUB1aEEuk1rX/WjPvvDVKEHd0TtW36HJA66JFCq53nWjVflRq10J8uUafg1Kt7Mmo+fUrGkgR6bCThg9sLmNrB/PYLAffCEW94CTwMfs73EzueIiLPem+3H276QOf1manUugKC3MRluauFa7ujDYVAE2NMzvLdYtfiunpFsNtnzRm4KKU0BYFbJ5x84OBhR3ksR0g/bgGxpKJ+pLDC84LDzJ/qrj2CPQ5eIfm856ffnaIqvKIpFWS+hZ45ArM53I+GhHEV+EK78+mquWhb+5czzunqF0CCwyziUGXv5GqtEkcUDnm8pYhL1Gc1nb1EDOoa4D+nkQsG5qHDK9uG6HCXRaSlY1IpDqYgpLtyjtwPtRh0NJwaDKP+B2yw==;5:rbqjqmU8L8Q2E+wD7bcG2gwj1qr72/J3/q3fgcB13qkXMMEFWcK59jZ60ad15teTx2xRN/FOLhmfjeA+KvPUa9fGcPccfyJ/6ttdjRlsgYfrd1JQhoYcHgQbO7jz+8lctLH0amUHpLy/NYXOtGUkcucHnFP27cv1zQIsdB5xq8E=;24:1GmF0nnAqPm70DYvxAmmTLdUWJq4gFX782NZPhndCfPXBzjX/572r9/MEQcFiru2lugubpYS8nwNfZsJuT9AcF9FprcnqWDun/bKGyFD2f4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:6hCzggbP6Or5RirGq8+LCBResNLjAnW8q2Z+wBfMlVod0jOph6OqKmxsOCPg1SflWVhbLFcsqmdHRLFV3JetRjYQUVy8mOIvARNh+NnqF4xH3tOwduKriywJq18ElLStk4pjprjD5Muw6I1P96ks/XcPmnJ68i1hiD11UEPZNn1QfSLt2x397OzIGk2CnRRwAtFizVVec4UDXShgTjpbV846JbSrcOvUkkFQQ2NxnWmkoySSnXtr2/SG+jSt8rCT
X-MS-Office365-Filtering-Correlation-Id: a5a04494-57c1-4666-74ae-08d5ab43bd77
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 07:02:52.7515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a04494-57c1-4666-74ae-08d5ab43bd77
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has two max7310 IO expander
on I2C3 bus, add support for them.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V4.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index d59084f..812f40b 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -82,6 +82,13 @@
 			>;
 		};
 
+		pinctrl_i2c3_2: i2c3grp-2 {
+			fsl,pins = <
+				MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
+				MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -272,3 +279,24 @@
 		};
 	};
 };
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_2>;
+	status = "okay";
+
+	max7310_a: gpio@30 {
+		compatible = "maxim,max7310";
+		reg = <0x30>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	max7310_b: gpio@32 {
+		compatible = "maxim,max7310";
+		reg = <0x32>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
2.7.4
