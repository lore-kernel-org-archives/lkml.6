Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932788AbeDXCJS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:09:18 -0400
Received: from mail-eopbgr40040.outbound.protection.outlook.com ([40.107.4.40]:28992
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932670AbeDXCJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:09:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] ARM: dts: imx6sx-sabreauto: add PMIC support
Date: Tue, 24 Apr 2018 10:04:57 +0800
Message-Id: <1524535501-8567-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To AM3PR04MB1315.eurprd04.prod.outlook.com
 (2a01:111:e400:586e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB1315;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;3:AGj7+JoL2zBIEFnjIkTs0g9W2B4rUUA4ShCdm/emL3q7MVjidV61dAorUzLrLE1Pb6KUe9Hd2iGosGZQi5t6aVos0fZDqaMQCXYbVv7UD5ggCfhtwTqVFBNlSwTlqXIkn6vt4vk1mHB04HdhNtnsA1k5iLnQoDUb7J/PUiapyuILwXa7yHbkgirHv1vWiy1jzOS0YXJ5jVqgWD/cbG5ppr5olpEP3EAIaK0wpj0E8mMycBJ8l0uFh3OqhUS7dkRB;25:yAqKjfXhQL8hXfg28d0lbzF728gavAh15Y+zlZuO7X3oeP6lhBEArp+w7PcgdtnZSFDQJVDM+HlW1LECOVd/Gk5dmGaJnFnH4YqQlF9zxq3yBtUYFHqdC5dqLVZGLxOMGd2siF9uzxe4pQ3/mUA+ca7l3G06qcQ636Dc6krYi7iMoVxNOh/3HMv8fxL5lHa9SuplwYa67kJ4fuvbTD6BJ144dets8EhacegpuGxRciF1neiN4bXgaVU9MDIwEIMfdckEGDW/mhPzUCBszPlHPhxPXbc8I31qwL7BSFAoHwig+sAuyxvX8m/o9arC51wz1ifnlS5xzemiT0PvAhAwSw==;31:/9Oac/QgMKyPw//DwEDQxveS2pKfSSKTg8EwbN6X4C/rGBT38ND7DV3DMEYQVmbQEkd2RoMpPiR09fKixjUZiTSUJxaubIIEJELDru9cj4QWWYQ9CdSuNNOQ3fohLjf9eIRUYy/F8X0y9jcv6G2PPzn4gZSHCW3VBR08lNVnzHLh8BSXpLpTWqfkqg0Oue3Ci2eILjQJvJ3VoiDaERyPRyjX2IjI8X/wceF9O+t6c0g=
X-MS-TrafficTypeDiagnostic: AM3PR04MB1315:
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;20:C3cXJ1nqX58dO7/QY8V2C42SERE1/PutQo7og4iiFCeNm8epuDrZ8KJlKuVc1KPoILNiyY0zIqFIuy+Ujx34KUIGFmuNAIyOx5xEgXPMJ2Udn5M4ebhJmy8xYD7gjOHFPaOD8aeb5D1OdnL4tY2PQIpQzNv8OgdQ1PjICZfFit90nZFQnB1/D6tz43qbRQmFIRI/JMxxoJXiZze2u7DW2+oDt92cc8HxKNaJLPPu+GG9VV8sz3n6lmJzPUnhrnWidqejdmGdw0cbHgCdSVG5JaD74WGiUiGx0Dod4OtOL5OOEtI9hasZd3hHuv6r+OPT1XRKA2frT2fdwzWphvZAEXsh8295jIosuVcz/qyp1IGN3GNpA/CQWaCqjI/fIDZmIdaqIeIpRp8mRzacS/FuNenOjIln1c3JRaqMVtKvqYSmOIFHroIDUT69Dxm+Zhl6rhRhmXOgSFKZCdphK0+2z+kqK6ETqpo+KsGitv9qtrLdNbIa+xYqsM3xdtPCUdit;4:C0Q7jJ8YaYmO7xgR0ZKn7iP2dsfHBuG/ND+tNyfRBkeZa+mv5DnwxGus7RsOgBu3Gwj3iw5tLTYyS7lbGWPEA0oU49WAUtfyHbtCzojXD2rGFPvlExkuccw6xK6cHQZu1BIRUDlUgw9VbenfldukTBPvxeXOPrt4u81MignFNIno69WBJLCaZy4WX+YfCOjTFNmRKbejRB8kf+P79EmC3ux7aKxHrkVS5q8Dh/1dtoW8E9QnhDsTyv+goSp7G+pZAF239UumanL/SJDFVTk6LQT5fC405bUelxDIYoQR5cKdmlmuj7bus8HA/fMviaqf
X-Microsoft-Antispam-PRVS: <AM3PR04MB13158D9B4DEA98166B399D03F5880@AM3PR04MB1315.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:AM3PR04MB1315;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB1315;
X-Forefront-PRVS: 0652EA5565
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(366004)(39860400002)(376002)(346002)(48376002)(6116002)(6506007)(386003)(6512007)(53936002)(316002)(16586007)(16526019)(186003)(26005)(52116002)(51416003)(2616005)(476003)(25786009)(575784001)(86362001)(8936002)(6666003)(956004)(6486002)(4326008)(50226002)(305945005)(7736002)(5660300001)(36756003)(2906002)(3846002)(66066001)(47776003)(8676002)(478600001)(50466002)(81166006)(32563001)(473944003)(357404004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB1315;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;MLV:nov;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB1315;23:VPYTvw8yvktgHYS+yBKJ2XrifXHVoCKpU2VK5LPGa?=
 =?us-ascii?Q?3f/ZfKHbqE2swkhDnLITp5f1GM2VRkIp/VyiECKZ6PNFRqrD6CHaoq5WDnS9?=
 =?us-ascii?Q?VAC6frZirOhVsVB3QbZA1lZ1vpafZ5ai4JgjjKMnX3Gsrtgw6DvSDqnRLuG0?=
 =?us-ascii?Q?KdVih7d2yGMx6ykkiHyK4ZjkMHvLKcZyX3UCma8xV9GgMbublFd54JGYdhRS?=
 =?us-ascii?Q?BgzeGUvUwvVD0NGpgmzlVEuoIv36tprlW55DJedMpmDfCD08YNdqQrFrDeYo?=
 =?us-ascii?Q?uSJBI87YnWSLpTa32/oFLwz+3ehOZRu7IFziWYiZsxVtUm/zB7x+Y6BMzx5q?=
 =?us-ascii?Q?X4SI2/BjtbmuBvHccPfT84zH3RTaYKmj96IS7ot4jObdPDBKGQeAmK+uoZRz?=
 =?us-ascii?Q?ziokJYmfIdKN26k0M+nNzQN0lJQOg630qarzrqY+KXyWwgh6Fg3Euiz/mz1W?=
 =?us-ascii?Q?32b1Ie5vAWstgmoDKeTaUWVVHZn7aiEHzAha48G/UUftTiEmtO2a3413JMJj?=
 =?us-ascii?Q?l4QZ+pkviZRN7d0norIfGG0u0IOXuTZeKaI82vYKtxk++zYTJE4Td3WzRJ3A?=
 =?us-ascii?Q?Z8uqKX/d3arEAODYJbs3AxAchhU41WNta2RYygP5kotn3b1/3RzlMJG0sUFt?=
 =?us-ascii?Q?g1c8PgbCsXE3Y2a5hYJZY7sNjH9skvo5JeSm2w13C9J+PCCJngtAsH+wrGrv?=
 =?us-ascii?Q?GlUr6IVj0lyFzfWCXT/k2i55qx8V3BVJfLUChqssQpBv7nnwxPLl4CuW/aa+?=
 =?us-ascii?Q?CX7UtOfUdA6SRYOQ6pYGkMPRj+0K/F8h5NTSivRGZv39EYxWqE5rkmu9t7pG?=
 =?us-ascii?Q?UITVI2mGinmTnTjnaDaInbsyiPDMisoS+4DVdoIAyg7kU2nnUpA6Ohl582Z+?=
 =?us-ascii?Q?hLkGE7iVGsdbqZMiKtphHOXXE+I9Cl50JXiQVWOg2zFHU7IEZGj7zcHPSLqV?=
 =?us-ascii?Q?Skh0Q3d1zoYittFnSdhgs6ODYrED46jhmmG1umApIH7d8NKX8G4Zkte87EbG?=
 =?us-ascii?Q?N3q8/Nw5M+uD+7jIHoA93DSWr6oxutnVNEdgRu2v3+vyQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: 9VEvG67I3x8ejSgHEhY4YewUZi1uPycnoSSTfeVKYTXjR5FTQs5jhdUGe2MBt8Xi3FJBV5qaVGZl2RSINPyH4usDw8BevNl2P09zh1cCp+Y6slnZhidV4AKZzhymmuj7qkbwQejn7bMPHTEmAjQfc2rW5RAUIccWgWtrmTMR2HLW/CIIumMTDH0yqm33uwmg
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;6:KopmICMIOctmADd+ruEmztSk626qfVqgjWwh92Yv1ddnijG6R48teDnPO9pccKThOo/92dAHv9ueoAVkqSHNGt7GlDCjWsmUNQpx2vjTrZQM5txpAV+uginFpZS6P2MCql3ZHEbAbYIHXMFbwSwqPPxwjXLbgaKqR/PM3SRtytRPpB9hJhL94O2goMS9jN3lFDZfBAZUae15GV0xG++ixHp/DQ8Uqa3GOJ1zc1P+Txho7aYgW+x/cGjHh4Zb2eQW7yS9U0Kf46FYJKKKBznbuidJOtS72IbF4iYo9AF29qJulYeTYEHK5a1O1fklUNdlW2M2z+AWSBKVA6TR16vPaIUVRtxnFBI6+5JxkvVTJu/Z97fFyzjlIEIyZFAvik7S+PNxuyXpXsvMwOUsvGcQaNUzFPlyAUZZ9vgsWmhX8lu6f4gv+8/iiEOw5PEwu4vsIqOMV1jQWnkAtX8QUzLfgg==;5:6CvnwAyyN6T9CWbr1BRTk3dINRgKk9kz4SKuvklD25aRPMI78RFY+kVU863Df9YSQawlvjFMZaANSQ/0DHkoMWHTOQ4Xd3ONGPUqQcUdPcwoXa47+4cOiAAhUQnZiyAl6gOfrdDwrDwCnBLeLiAGPhn/gbtd1djF6muMDxEApi4=;24:MRXrJlnbDmQg31PbE9VNI1j5cw1ziyTFLyRfNO72oHlyxh2sTf7xU8WksvSOoCLfse0fkoMVO+gvvoWqxsoDMS7P6NB2/I6E7e8zWj0xoAs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB1315;7:sEWl38tUJosW/X79WxAbeczDRweruxhmkTpZ31NoqxpIvGW5v8jyHWTzdR2rKTLnSw6+zJ1CfNBdV3VGePaGsRdl11P099ZltJi46tWTtXYtbbPMeIEAuY6+sgKaN9uDHrt5R/vYUF9kXM4aHIVDUt12MDXoXdYh5yGKc/7kiOP5pQSM/5DlVLRKO8VBvSNa1/O2x1/Bhsde0vAU6FPdP5zgtiIwNjWOLpABylckLEk7VYEgqwVlE5ZHimHZ9lSY
X-MS-Office365-Filtering-Correlation-Id: 52556a43-a5f2-4225-1778-08d5a9885fdc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2018 02:09:10.1624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52556a43-a5f2-4225-1778-08d5a9885fdc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1315
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pfuze100 support on i.MX6SX Sabre Auto board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V1.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 117 +++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 57d1ea0..2caca934 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -74,6 +74,14 @@
 
 &iomuxc {
 	imx6x-sabreauto {
+
+		pinctrl_i2c2_1: i2c2grp-1 {
+			fsl,pins = <
+				MX6SX_PAD_GPIO1_IO03__I2C2_SDA          0x4001b8b1
+				MX6SX_PAD_GPIO1_IO02__I2C2_SCL          0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
@@ -148,3 +156,112 @@
 		};
 	};
 };
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
+	status = "okay";
+
+	pmic: pfuze100@08 {
+		compatible = "fsl,pfuze100";
+		reg = <0x08>;
+
+		regulators {
+			sw1a_reg: sw1ab {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw1c_reg: sw1c {
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1875000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <6250>;
+			};
+
+			sw2_reg: sw2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3a_reg: sw3a {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw3b_reg: sw3b {
+				regulator-min-microvolt = <400000>;
+				regulator-max-microvolt = <1975000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			sw4_reg: sw4 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			swbst_reg: swbst {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5150000>;
+			};
+
+			snvs_reg: vsnvs {
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vref_reg: vrefddr {
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			vgen1_reg: vgen1 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+				regulator-always-on;
+			};
+
+			vgen2_reg: vgen2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1550000>;
+			};
+
+			vgen3_reg: vgen3 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen4_reg: vgen4 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen5_reg: vgen5 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vgen6_reg: vgen6 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+		};
+	};
+};
-- 
2.7.4
