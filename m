Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751781AbeEEIdQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:33:16 -0400
Received: from mail-he1eur01on0061.outbound.protection.outlook.com ([104.47.0.61]:32326
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751191AbeEEIdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:33:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, haibo.chen@freescale.com,
        fugang.duan@nxp.com, aisheng.dong@nxp.com, yibin.gong@nxp.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 3/7] ARM: dts: imx6sx-sabreauto: add IO expander max7310 support
Date: Sat,  5 May 2018 16:29:19 +0800
Message-Id: <1525508963-7986-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: TY1PR01CA0199.jpnprd01.prod.outlook.com (2603:1096:403::29)
 To AM3PR04MB1315.eurprd04.prod.outlook.com (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:r6tSdU8h3LyszeiM8LqUG9Njv4Z0ykEbtyFp3g5q3+hYVJqBRkHWnrxSoBymPKPGdT0RkYS9Vi2nafmgc5Hnlgq/srP2baVtUj0qE4+fHqu+Gc63oFU7B97tqrzb6VXySlYV6/XCjgYDcT/MGqbXrVbUVZ1avdEWxZN+6NHEXvjDh86hp4x90W7bry/KMKDUiT5BsyXFn5umQvb1OUH10DHpnWcx4rQDgI1W8EwIk5Y/NWZ1oWysqV/Mb7lktmOZ;25:ZtHCUUpWWav9RealecOLhhhGSUaREW2Xab1B1xXthFC3GQAWNAYvcF4xfR+BbKCCc/jhV09HtNX8LYH2RF4L7XxWcmSgi9aT10CzgK+UtdrUHmMLt8503Y4LkFj1EJ3anA32cwM02PCnJnlLwXjUSUte9fYs2Gb+48tc9Z4alyM+04EmRY8j5T2cVcoDIcritvB8HjfYDglWyZ3cAwuXeTCnLBH2ns9Xa8P+3UFutT2bzlV+VkkMcLHaXWmyofMTORmSJlWuGnC5qp6qkwr8V15nmdchZzORzSBJhq1giFg+5w5PBd1nnQ21bfMNScTBMNoeWXi3SETjLC6gXWP0Rw==;31:0R2EM/3PKvA0Tho1XLadF3dkawsQX419PaK+MXGytOiX0XQ7HDbutxNxQyYy8uh14HmthiBxB9GQnVebehzwVpKjDlSSeyU5ba080A7aoM/M23atJTmYH6dZuN6fWp0sqVMhah04vb5DPn1yiQM+MO1iqAAryHC+bRi0RYtxd42Ccd77QYkqhq+Qnfnv6OJ6E+anUPZM80/37xM5XnxZcw15b3GpH3mGRcASp6/161E=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:A/QMhyugj0vp8McR7StciovquOFvmmA1gEeIlgLoNszIzI7mYqXUMZwQlOx4tyPr2Vq/xZtDsecFJmOslV13iLo2QdDEVHP7ldZ6SMutCwsehXjF83WQhMesLa8d/0NCvdZkduf2kljhiNX9lI546iSXwkTWtDpb3UirGjau5M0bN57stdgH3dxBZH5xyhtlZzrA0MRun2lKJmvUYHLNjeSAQpwB8T5s3vUwnuQT57md9LxvQGqZB/f9xR2o3kN0SMq4W+/gvQNcX8MZ/YKlqO4CCDUpQ3NlH+Yrr5gqhmtFqHd7sj4oJNUsX38wACw3YV2o5dHKXUvERgeu2HZ1m0EyTGtQtxF/yMs7ITMNaGSVIHXWSs+EHQg9KTJjusYaOgHXCsqw0jD0x7BtuGVd5X4/9iUwtNf/msNC53R7v/md8XdkgQJV9cCibYl8kaRLfQZ/9An/Esvtan1uPFERTJumfT/CVPvjuyD8MPyaEYGVj24Yz49N9W9brTMJovQZ;4:XQU+bXpKxtZmFA6gPCCE9n+LU8vjqqxn91lB5pvNR1U7xTWbY9FDg804HiqC3Qavm4fWW3DKn/JE0dFhdISzpOrCVcAyfZID8Lau4nuz6nqE6p1DUiyXveXNjnlkIKWloIAXV6O13AvsHJjQUQOnrzYG/ECiTC49XLYmp2ZT1KoBFHsWuSxNQc0DmdKKS9grznNgfq9YbWiVvIXPooNgo8hgRhkFBggGzERV8MuXWFpL4CgVVZjhnaYY5zYsLDlzSCM8hXamf6km/CpHE1fBph2yUimlvDmZgckNOn+Yjh7nh/Ahue/QVZ2CjQeeZ2eS
X-Microsoft-Antispam-PRVS: <AM3PR04MB13157FFC4D4575E090BD7657F5850@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(396003)(39380400002)(376002)(199004)(189003)(6666003)(53936002)(81156014)(68736007)(6636002)(7736002)(50226002)(4326008)(6116002)(16586007)(6512007)(3846002)(8936002)(575784001)(186003)(86362001)(97736004)(8676002)(25786009)(16526019)(66066001)(50466002)(52116002)(51416003)(478600001)(106356001)(105586002)(26005)(956004)(76176011)(305945005)(47776003)(386003)(2616005)(5660300001)(316002)(81166006)(48376002)(446003)(6486002)(6506007)(476003)(2906002)(11346002)(36756003)(486006)(32563001)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:7k/5kj5ya/G+3MSrMfhnJYyLkflJ9OM41SWhONzDu?=
 =?us-ascii?Q?px/D3nFMcw1L7Z989N4+HzV169Vc4G0Au0M7bBZGxNf1iMRiHuLeXiPcIAXH?=
 =?us-ascii?Q?6VRrdxRGbHAJNZdau8mqxDU5lhOiqnLpqS5ogt8qaxeZzb/CfincTwiEOu4e?=
 =?us-ascii?Q?/yX8fhw6JIdRI8vK6zzAHf9uIftGhRHUGyWg5MomB/wY9E6GM+zNJ0plr8He?=
 =?us-ascii?Q?nEEszZJPXDVZmogh+Ca7vpiaJ4oB1xKYmV9pPvvvqVuS5jQrIbSGidv2OUC0?=
 =?us-ascii?Q?rZ1e08baBjXyTnnBd2l56gxjZATzUHGoOq925Dbzy8/VyaqjRCQRbQ49TneX?=
 =?us-ascii?Q?DcFV3e1wKQbO+4Pu6HisLcbLmiMhu5olp2K+40v6nnnpDagPY2eG5ty/Baxa?=
 =?us-ascii?Q?FPf16ceSJjlPPEjODfbW8I6CvHr42IVrfFmmsmwMBeEU3xmq+/JUODmHup6v?=
 =?us-ascii?Q?Gs04Q7TEfo0TTxBvI9aGCToAPgqWkI8QvwOJXcY5Sm7jC3b8ClOKI+33J58J?=
 =?us-ascii?Q?NXjbop+oAsaX+fGmt6nJH4s5eao4QpV48k/1pKzqvxDfleUJkOFiqDLAA1tt?=
 =?us-ascii?Q?L7ADhYaR4m/re+WZIHooFafDWxWN0tcA/YDHKx7HB60KXfSznl1T3FtTU5+W?=
 =?us-ascii?Q?ka7zOnxqV5RtbsO2wIE1JoJEeGfZS6DeJY4039nBr9lFsVfRSNr+ZkrtKqp/?=
 =?us-ascii?Q?NEIdz5w2e11IxWTSAIBak80thcaIoldubqSYZqpskMcvhovnhE2uC18GD2Z2?=
 =?us-ascii?Q?4PbRqPU7J3qBwo8rtCpnEUK/5wNDGEzCNkk/BDfrjswGYlxV+JTdHAB1e3M5?=
 =?us-ascii?Q?c/YRkr5wyGdEurB9nkNlTX+ZduVtRL3qFAaUvJuC5CGO7E/SUN786TGwWZar?=
 =?us-ascii?Q?oMjV83l67GorpHwg/DqmddMBUKNaon6EY2wmOe1t8PBPYw6tDWqWBbFhUqjq?=
 =?us-ascii?Q?7sTXlTNEE5WOFzj2GRomTY3TcOvN0lFI9QJwy/ZMF0SN/p0Hqtr7WDoqx3cn?=
 =?us-ascii?Q?zW7EjZ2Hg46hJjCTNF3xln3KW6x4nqxnGEsVMxgKnz2prPFB0mCgZ5M7t2l0?=
 =?us-ascii?Q?hwFsgBExkr0j5PbQwJifAHcoRGdzflLr0X6NxF1PLGItFT9T31xxpEky6Tj5?=
 =?us-ascii?Q?COOHKNq4i0p2p2chiK5yYqARRpqdMuFNPFBTwgzJLt8SrSlUac5dQb9Deq3T?=
 =?us-ascii?Q?WrlBDc3xenMARlMtie9gzlg4pjzxWYKSpk2LDzdMngpiF4bmbqsQ6hlWbZ7u?=
 =?us-ascii?Q?XITEJ1PKYONS1ORFvE=3D?=
X-Microsoft-Antispam-Message-Info: YcEPQwlpBCnAaTFaiLAsfiJt8CatMUQ+SLfsJBkYpHPAJyluhRI1+j/ejCf+a7Lv3aPUzfbEm10kH4YeAgCmYovRKVuoSJpCOZGl0RSgrw/+n0AWdOEQ59OH8qskVP4YRTgjGIwQHIMaIXhn9U7CM1u0tfeJz6cUcl9cGh3F4l7DcU+1o1paBjfRz/qU3ODD
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:EVR16ejs1Jsz0hrMhGafYbCZkNfYZjMAmftpPfxbXw88YOrOG7kiHlIDZiRtr4FJhe0xlibcmS4aExq+8v6Jhq4WC906R3sXgnZbK/DIG1YEz7BuoPv4p/AphCPhgdLCjF4rOMurPuOHoJ0/NF699BrTqirJEDpV3n4yARTgO8qqpsPNUoHAJM96Eg3v+nwJ+xoDKQGlCcpEViT915pYvqCzkwpAaFibGtmNdT24mg/Ur1+Q+CLEv5fzOa0xVnc1fW7OEphds//BJo4fZqO17xtzTRRVCd67wn9LyHf5255mpPY+96ptx84sLrbFTCxY8D6ScTzVqLXcTk46/P5ES2sIaw+7X249WGwum7grmGD68NdaHUbB6c65BC895QMGSopB5E2p338kJuZsUy4xkNbpr6kiEDTbpeJ2pS2eEFycoSViy47N1d50VKqKE1VUkWzWnc3lMLukYVGIvsF6sw==;5:enwFM0ajQdj8zMUuRxCN90ymZZl1qQp5AYSe2rrUOS5wg6wyLbRsGzrUwTtuCxoiUDhFPnWkiw1aJqO2W73xibVpPBA29gMgqTU2lZnnkocvN9bunLNdHcRz0v54ASUn6WmmVvO/sXU+pOrM+dE3Tw6ZkyAfqIespsvlq+5HMf8=;24:kbJM/+dbVQuc9nx0j3gurG0sPx/XrXVCNIb5mDYSIP/KIqNH4QJXn1j7b5JcyxsUWE5oWKeuv7eF5iUFr2UjqHheboVPU3hoQAvJEtAV6HI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:p6cTnHby4QY9HzVQM0qRTaStxeJeUZpRrF9xoOYLz1vlu+YLWUQCPbRYtKwcCbLHv/eHkWExdK8/52RWMSfu7HyEeSjJ/vrpWMY2oxspXsgfP1nrwfxyOaHSX+JT3Gz5Z4gDx1I1RNAN9vdZEpsJT8d+T6qupm0u5cPxEbl6viOM6m4sEZdUG/4Njixcp+suHrPtLhUzsEIbxDZBizWUrQB8aM8s2jOirAO9E4mjcTSi7z155iKhRQZ72zhAnxwB
X-MS-Office365-Filtering-Correlation-Id: f4a97c4e-44e9-4749-4c89-08d5b262d359
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 08:33:01.7202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a97c4e-44e9-4749-4c89-08d5b262d359
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX Sabre Auto board has two max7310 IO expander on I2C3 bus, add
support for them.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V5:
	improve pinctrl node name.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index ae253af..4d41b4d 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -73,6 +73,13 @@
 		>;
 	};
 
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SX_PAD_KEY_ROW4__I2C3_SDA            0x4001b8b1
+			MX6SX_PAD_KEY_COL4__I2C3_SCL            0x4001b8b1
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -262,3 +269,24 @@
 		#gpio-cells = <2>;
 	};
 };
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
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
