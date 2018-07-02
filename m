Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4EC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6E224725
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pLKv93pG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6E224725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934242AbeGBL7k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:59:40 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:31545
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933061AbeGBL7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5lCsuN32Ra7cRdOCg3mZ3NVMcYq+ksb9JF8P6E5qyU=;
 b=pLKv93pGRroHiddZ6ZNSY4e6TZQUiOb11iCOJOREORiMmKs9j4HSMJP56M4kx6XoXomeyDAlJxmUlC9b4rujrgNlaKNgYCASQKm2kF5+CcpwOFGLmg3OdUH5CoKn43mwBemqgPxOSaXo7cmOEuASaGGC5lCuKAp87G/HfuJH3Hc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1607.eurprd04.prod.outlook.com (2a01:111:e400:5994::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.20; Mon, 2 Jul
 2018 11:59:26 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v6 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Date:   Mon,  2 Jul 2018 14:59:05 +0300
Message-Id: <1530532746-619-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530532746-619-1-git-send-email-abel.vesa@nxp.com>
References: <1530532746-619-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0802CA0012.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::22) To DB5PR04MB1607.eurprd04.prod.outlook.com
 (2a01:111:e400:5994::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37e714c9-29cf-43fb-c093-08d5e013438a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1607;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;3:WOFhGuiAnB9zOGlQK8Z4qHG4gWpm+Vh9veIrp/3uuwQyJbhGM7WMZfbcdzrFKAO0LjRm5U7OC5SLPX0NTq1WXT11zaDh7/1WI48i6G1hY/syiWLYAFjI9nKGF9i8pc5ENQqN/oRs+6lkko/fjnQiH4Prli6u5+gdgW50W+q1pc/PT9pkvtw+AnkelXBnWn1SSepJyZQFltCWMtFhyxqgFYr1SeKNZp3ygo5YIyT7za52eRHGIL589kuPQ5nR20BW;25:uV54p0umzt0NZX0+QBnVwAzLWPK5kuQKPMce8T7g9D+IVW2bdcshEARgkGagkaG5+g/6wWAgU+oE24Dim0h6RwIP0jkzsIQAJcsWFHSHK/UCc3hkw1TxsuuVNVc4eOFj0b68OAZm4do/DvrS4JVdV1lEFyYzp2NTVmSCN+jkRrUf79+cXnyMnrIS10+qybXfK+XXArrUVXdH8ksODtXO9Yz5MB+SKXjF/CnMcMs5uL0OQ9mq73GAcSZCYFF/TeXKp+F0W5IelJQYFVug91EgNUdmcIvOxOesj1jPsLXJa/X5N98nvaOO0lwFQ9bWCWMiRNxxH3jmqNs46BYhL9CCWw==;31:gQdiAejI/Wq/RslRxSiZvJ+oCALWDdFiN9DQ+rjMBtuKpgWgk5TIUIXqw1mibIKEemIhCwF4UcVBpOwM+6hDBmJI8AmnPovuaMK9awiawA5HLNUNqf1vBzow6gk59MeoePWC1iXxvVYdeNPn230K4yJmKLQU3HpmI2zZI/YCgm9vwujbqMp24rvuxN+8d0rKmk2nzDZ5Wa1Sl5U/CAa+uipSqlm9UWgnsG4xutbspRQ=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1607:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;20:XT98g0Hmb2gBrzVB5lqU9errxS2jbBqwT5GUC0qMoPHjoKtg629O/KyONUxcLiTB7oYsZaO+XE+Mfzlp3rGGwGglif8uvJVh+bASlgvU0W63VklR2aYTcSYtX1BOatzgOTLHoDdO2TyUhyueIJ72ggLTwIQWJe9VUdDES97dmpq4Cf2hGkHU111VfFkDdk5xkgkbgJ8rHzgnBsfflgTiPylG7Ulk23U2Z3tSoCgB5/TBysKdW8fPGlu5wPttF3IQGcXaqRj7ZGzyEyu2fDL/GzyXhXK4GTRr/snknGT0UC8A/QaenB0IiTyORBPH9S8QHKUgCuAquDY4UuOoZgL7LeNYsDh3ejj9z71k732iaTVEgH4dE++kaknwxOrYCrUYw03YHAkCt/M/Sm0snHI6G3BGAD6JR3LqH4QOmiESLbPzW3NKHgW7ewzajGRWm7pBlNGgSk0RkpE01l15Vl9LmP55giq0zO6fdsuyMSFCuXMsc/aTeQQPXTWcKHgmfgOG;4:vbDPvt3HM9iJleMdbGwrtbqZcpd2z215l8p5nvY3IX82/9lpYRVJ/SCYfGUcI1mMcA+C6Um/37rpwAcKgIjlvlK2qgqCHepH234wXA6KBc805iqhYQTZOevb59km7Tx1hdT2dK9757M10idhUHEFU6RPprtmJgqPSlSY9nj/G9Teh6edqKCzjGI2KUQYe3GPemjYR/pc/aZDNd8dzR/jvuA/vfboBEonzs1acfLQIVYipF8fiW+QI3rlsQIsWJNCEXbGn6S5tpTUvxmGGAu9IORWh7wnGMWL9ACi3jySwNsc/s3yoY8UlEOKSogRXsqv
X-Microsoft-Antispam-PRVS: <DB5PR04MB16071EBF2C12EF0949C5D7DBF6430@DB5PR04MB1607.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB5PR04MB1607;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1607;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(16526019)(446003)(97736004)(186003)(26005)(25786009)(8676002)(476003)(44832011)(956004)(2616005)(6506007)(386003)(47776003)(6486002)(8936002)(81156014)(81166006)(53936002)(4326008)(6512007)(486006)(66066001)(68736007)(11346002)(50466002)(76176011)(3846002)(48376002)(51416003)(52116002)(36756003)(106356001)(105586002)(305945005)(5660300001)(6636002)(6666003)(7736002)(54906003)(478600001)(86362001)(110136005)(2906002)(16586007)(316002)(7416002)(50226002)(6116002)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1607;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1607;23:wNwqT3pn1DfB9u5w5JVG/ONI3JwNow7TzwAN4BaAw?=
 =?us-ascii?Q?xsQMSGxzssnfsj/AsMnSaMch1w7ICCkJ3qk0nosVHKP/XZawpItAioEZr1pU?=
 =?us-ascii?Q?vKFRCzITxwaa6SBAExBYWJxu51Xs71PP6zSNpDmI9OCHl7QEsiUBWdXv4fTD?=
 =?us-ascii?Q?LzZv1Iv7mzglA6U+rZemuxSKPvNvsMbEWQ1XMBnjn4EfQ05n9xDfqHWBY/L2?=
 =?us-ascii?Q?I4AmPs4zBxj7uP5W70lZvlF4HPFnewVXreT5KxbcVBJp1VXw0xGJTTJ7qV75?=
 =?us-ascii?Q?nrLiUCnlw7qQcqc2tx4r+/UUqP7TPkRb29hH+72GQX9HyUy7fRkiuvVw/flt?=
 =?us-ascii?Q?WYBF1qFmTtoGVg+FDTMPD1OQVMFURPQY0NUWQW0VsUHMU7LcPhWyKJHyxsHL?=
 =?us-ascii?Q?mLTZsn9NsR9vRjspPP1pKSQLhNZLYQuo4FSfJwc5Lzq8MTC3dSEMKIFhRlqJ?=
 =?us-ascii?Q?Id0qTuBmelsZlJOE4Wi+F+OKDC82bXBsOq8qZ9ShunuMUkyEBRk+HOZ3wC1L?=
 =?us-ascii?Q?eU14IZnmOoy6VRI2N0xfw7YwZieA7OaMsNCbBRHjO+psVS480Sid1DtTRxNO?=
 =?us-ascii?Q?gBNielZ2E2CihVTVpoiDsUF9KPLA0FL0iJSOSX0dCuinw7/eCU+Tbhb9TTPK?=
 =?us-ascii?Q?MSEDoULon1v9rZkv/JBtGWvccu+8vkmjC8/huSmvFU+nqH8daDEjqcVq1bnw?=
 =?us-ascii?Q?0lwNseBrx/rx1npV0T5UG/8mOJ00bZCVIvrQ7eYrP/eB7GXsqFizM1vDPGdI?=
 =?us-ascii?Q?lQwOg2CIyGfpwMwXgFiwVfeQukb0L6XlwWdxJ9NRXw58gR+MrtU99fTR3erg?=
 =?us-ascii?Q?4FBSEoBnRa/EFrI14ewKbBNanoiyjLfT9/MHZP3VIk2INmGEBf5iEdagtEPz?=
 =?us-ascii?Q?AwrCM49TrLeUp0APkgzUYwPUWcp9lcpt5cIl5S/IE8WrK1FMrOUFndHfvi4i?=
 =?us-ascii?Q?hXqEFbVlDndg7tjhLngaXbGdLDJkPEa8cy/TWNTGonapqIt+qbXohdz4SY3v?=
 =?us-ascii?Q?O/bpClO4MZOYNqDbWF/DjBbedFZGmREa7VYH9gYS/Ppe6/ROfxmscmuFQgBo?=
 =?us-ascii?Q?Frg+zzL05aQEHD+ghFgxG/6edUk91k2YMbhZ6UwqqC5QoGl/uAKkQHR+xaen?=
 =?us-ascii?Q?XnpgtPRrOAgVsu1LC18WVA+DG66Mr32jNZ3gqafHfmn4o9iQVlzBKtjNm71S?=
 =?us-ascii?Q?Swm+i1COUsNPLWQ/l/r9WsJM/pmNTEwVNVThICrVZ/bDpMEidqQLUM9qdEpK?=
 =?us-ascii?Q?uF2rbtRXiKuqum1IJvCgn8Miu1cVNeUkkYdBcmD?=
X-Microsoft-Antispam-Message-Info: 4WJcGgu40HsFr5y9pporPaW5+6fmoZ5cKJvv09FiBgW6hl9DZF2as5fAwUwERrauWpbenu512s9PY2UThoDmcseeWjB/iaCo4lAGe1VvKHe+4+reVlkyNe0h6468pXlamLJWtpnn3MFHBgHIrn3oNnUr8t35URnKsUZIv0EEmQQTnuwpQRCqyj2LcyqHUSyYklkocZ1HYH5XuRHTiMgJ2ZE77taZhkfV8Gnq/Je1czDgaMWZWarzkmCX/XY/a5zDukIaC56MP7JKTx0G9v/9BZzMOXHMwvtB3gBj8zoI2t1K5TZUtfvNCMHHSuNXY36/hXqawP/z7hjfWREiYigGx0eiKXdL/nGZHGdNITotDwI=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;6:XyHw+sbqOhAznhF9wdZ/G1jeXew4Jh199w2c5ZsdO/1OrsJD/UMMwShy1IoiUwKLaVecwRwDRkZU3Fuib4FRqSlR20HAJAshJbAzDSLlOJ3TXlNdFMssGR1BYeYao0Z8+1y50ulQ3HY6VY0Uz8aYIiQSimtezSrUQmukJqhzMjofJWNd2qfIzJoKFwIYju7q1JCWTg8bmA5/xjvNdvUfQ+u/QBGIolo4dMGbvRobmCsSiT39DNzNJGhcnYB8mKTsFyCpwoeUDDZuN1ekNtU3K76bBAArxIgzI6DeMtdMPwJU2j5vd9WL3cm25h3fR+wc5ttF9By6Jth30gYt1cv9xPAUhQ6QgxkNJbWba3kCQX22+F4aigP8FvAWcEtzhjLcd22txdbQefKgv7ZVnzgeGElPujuAfLaRNCxrWittyO9YGI0NoG4ERF8MWMwcYBD1U1FVfPg+sM5fzVew4AYiYw==;5:T5Rsto1DJa4UZ3VnYF9+P7z6rG8QIBpocvRw08kjkLpd3MirGco/nw+34cXquVO29CeauCLQGUjYgtzrK7sUbJ+m13KxhQ+drfVEY+zaRlt7Pxe3GBl+ET/fVU6QK2s46KRmz1juIUrcWivQ84nZzihshdnxo0D862xmSOh3NPY=;24:Tr8FhN9RdAc/InXyLhAMhbPjezXMpsBdfNcG0jc0OJGSxCrwhTDIxeYqxl5UKcRroD10+FYTTFKRuUsVtRy1BfjeQFYPezZNJf3lGRkjZ2U=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1607;7:116sCbr05sEX10vFlkEeDdY5VFadK5f3SDMGKXh4cRRSMZijvFZ6eKMvLM72zVBVgXbxUBGTK/gV+B0GIR5wRm4K64oVy/2k9nN9ImMHUGlTeMumQnbBYR7LVqx+rGXC+hLpzBP4UGPGWQ6Jr8FmUW5NhfTujLu0sBFYXe7FpOG7TQrxxdvfFTOQE0atlJZtuZEcXfBP8vdA1XknQROLGhIyMbhm3iAIBOxapHIEp2eFkqibx/JoAyK+a5syWPj3
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 11:59:26.9178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e714c9-29cf-43fb-c093-08d5e013438a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1607
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the binding for the i.MX8MQ pin controller, in the same
fashion as earlier i.MX SoCs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
new file mode 100644
index 0000000..66de750
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
@@ -0,0 +1,36 @@
+* Freescale IMX8MQ IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+for common binding part and usage.
+
+Required properties:
+- compatible: "fsl,imx8mq-iomuxc"
+- reg: should contain the base physical address and size of the iomuxc
+  registers.
+
+Required properties in sub-nodes:
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx8mq-pinfunc.h under device tree source folder.  The last integer CONFIG is
+  the pad setting value like pull-up on this pin.  Please refer to i.MX8M Quad
+  Reference Manual for detailed CONFIG settings.
+
+Examples:
+
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_uart1>;
+};
+
+iomuxc: pinctrl@30330000 {
+        compatible = "fsl,imx8mq-iomuxc";
+        reg = <0x0 0x30330000 0x0 0x10000>;
+
+        pinctrl_uart1: uart1grp {
+                fsl,pins = <
+                        MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX             0x49
+                        MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX             0x49
+                >;
+        };
+};
-- 
2.7.4

