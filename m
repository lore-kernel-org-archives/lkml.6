Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbeDZHDE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:03:04 -0400
Received: from mail-db5eur01on0044.outbound.protection.outlook.com ([104.47.2.44]:48704
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752419AbeDZHC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:02:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: shawnguo@kernel.org, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 2/6] ARM: dts: imx6sx-sabreauto: add max7322 IO expander support
Date: Thu, 26 Apr 2018 14:58:14 +0800
Message-Id: <1524725898-27974-2-git-send-email-Anson.Huang@nxp.com>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:qusUVV0ZL0alQEF+Ru/2dqyWPsZzCoRLV+u6XfLXkBz+OUBAuJdUxpaZiHdPWCyDRCT+PFMJuh/4AmNTvaiLC+ccvKsp15YLmW5dnl1LKbXQLjG6tEFt7WwAAtXe9pXNpGmj9V1YLYqsgiVmCHUutXOMqVqz1iQVG5+HM6+mtg72itj2kVX51drn5hzr8AWj0KgNpUynkMWH+SywBwzzwc6Pct/RWfBv/158+xTZWxd1A/PYOlA67IzHHnXSyXYe;25:TpyjFL0H/d+RGIbqgsdgE/Vo49J8xu508XGccOfc9VR24scQA9d6Swv5k63cMk7hndfXFmlF2kIC3KBJWh1DPaliTkcVEbqsSGSajinpqLBHyML5XA40Gia3YX3C2sckB9Dmp10hVw+Fr2eFZqTgJpgYqSSw9hKyGyiN9Lp4OztXr8yW1XD5co/0/51EAmpGFWFBMhHHigGtuL8TrzLhUw8Zd2M7Yj3S5rcTfJyLuDiAq7w60L13P191y2FVhtgO9ItwlkhVrjAcBjLBeLT2GGOW1hiUDqcLaM4VLByAEOxEfPw3mgZA9HlgDAZKaxd7yqU90U7PD53XhW3LJCPdbw==;31:VgTQTiqXhidwWXO5IEZiwSSCAgHmqV1D67KZNUrXjUOaOrEYeRF22I/5CuhytCqG+YX69dLxNSV3lHHxvp6Xr+jedKz4nm+mhx3B65sAnzQvOfWdrKFKLWLnXozG+WH3yWO+2Y0mF48XjiMnEaNUDwpvVK2zHJerS/QMnKfMgE+8Ov+p3XuUuffVlohIf4yklemDGgw5Dd3YSZNpiOJs64tlEj74GdaRokzgcAy2/jM=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:sspfZZ67yI+t8r+pGgeZYSrKdk0XHHueJtsB0l51RvlLUEKMybQjVYE7ah89FUTJa81weRhZouNTsHfjBqNyZen2lUqWh1OlFBi/j4c2FnY7M3pjXfCoHrLOXzij2KI/IWR8e4FwjUv8JcTMUvwCGzGqLOxvowB0A+y/B4/Vje54PVv9s8qQ191D8qry251siClwlRJn5f64mfVf3EGpqhYdSv3Zmrla7GsLXndsWw50eHiDczbdp4/kkbw2u9HZhYY8h3c4TM0efQ+yStDZ/ajOF0denzVWcYStl5R+2/VYSoSWgutj9+ndtc5v6YSWmGJVwtFhqza+jbiS6TAY1daVu0Ca3RKYokhZjnsjUnj99K1016D5+/I/zOL7Gq4x4ZXwHYtf3brfFMUqquuX6/30eDC/BrqRX+lvUma2iSkyYCg7yE9zQtfup9I3LtppZC7nA4ZVlyAgAT14DFLfygtl2vRB3DTw9Kurmp4QYOCImBaPabjsRv9Tr47VmLT3;4:J9H+oikI8JsWxHWv2iGXgcnxXLayusp9XWE4FBT1FHU0NW5FtlFbfDS++pmBgnnLKRuY4KzXNOfarEey7HBo47qE+Xg2fesQ4ARsxkWmDVUXxZT5JnsNrnR5mMWoiYo3FrzrhIlYXT7p5vCgTlmdpHQ4zZ+LsTCq2qKlkw6t3+jkw52zNmxeuGBLuJeoqwrNE2plUsZANBww6YLYBrTiXPeIPQ2/i41j1TysbZB0fw9eIsX+iMdcT4L3uWRIPtmVl/47bXEpQMT8MaGuwZS7GtB+xzNDpf60eHsImatM4xLSdiMy7xIEsT/YlLiJu+PK
X-Microsoft-Antispam-PRVS: <VI1PR04MB132784FD33AE7CB1BF17B866F58E0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(199004)(189003)(36756003)(2616005)(106356001)(8936002)(11346002)(6486002)(97736004)(956004)(50226002)(25786009)(305945005)(7736002)(8676002)(81166006)(6116002)(478600001)(81156014)(446003)(105586002)(16526019)(6666003)(51416003)(50466002)(3846002)(47776003)(52116002)(386003)(6506007)(6512007)(316002)(16586007)(76176011)(26005)(2906002)(186003)(53936002)(486006)(5660300001)(4326008)(86362001)(48376002)(66066001)(476003)(68736007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:lf4oIe+xlE/60V+qJHMYlqVzInLZDp/H0dY037B1m?=
 =?us-ascii?Q?gJb6C6P6dWJkEkQ2tcrbwpYWuTuN6c+VuTWrkMDHcH6fgxO8f8w0cjDA4zZR?=
 =?us-ascii?Q?qLqRdRytW18lIw90ekPnY3zsTcDhoAUi9RRy7+QHjofk/rjGNbV0sL0n7Min?=
 =?us-ascii?Q?mM0QVWDiw5aSwfP/mX/9d7aohQIasAumdFUdjbdmT9bUDK7KpZLtteW8EWuQ?=
 =?us-ascii?Q?4luwzZjU7k8WeIpcEmJjs9Q79HEjKlTDteVupmHzgKywUt8j2uksfyMN3/JJ?=
 =?us-ascii?Q?hjZMh8gJmQ5XwNxbKp2qAtvk8ZqukAEroW0pDpMfY2pGLWveb8yGCrdmHW7m?=
 =?us-ascii?Q?ihtpH6Vh+/oLrdQFZ67lrphar7JhdKwunLe8tVHM5u2HFzG12P5bIDaVIxN+?=
 =?us-ascii?Q?2dGXkANERtrr6XhL1ALEC5HVYzqGtzyU0eVroe/YhiTPg5SfjRNm0jC44Ui0?=
 =?us-ascii?Q?jMfSx3EpFB6KrQf8uoUoADMFxwUVyCmE4XAKsENI5+ZStxK+IJvyyD9yif2c?=
 =?us-ascii?Q?Gq4XPH0ny2+alILt78jX5EfgRJWrZ2Y2BjO8tQrCS3fJ11a7GvcootvCR7QN?=
 =?us-ascii?Q?0UADlg609+3s2Nzeh5wU3uSX1jpsafOsg7tCjLBNwGjAC2XAWQZ40mQ4Y81T?=
 =?us-ascii?Q?cao9o/1PXx1qVTiCZNytIfLyZBvoMLHk0xheU6ptt6LeKEZCK5dlHNXghNhG?=
 =?us-ascii?Q?H77cOoT9UEMdRjscJlV+BOFO1bbq5nuyJUgALTA7sXjRA1nOOSYJQ1NHXL+p?=
 =?us-ascii?Q?vE8VsdaDNP8hL49BRbt+ozZW9r+xaj2VGtZjngVJW5eDB64TScurq7RtQQbS?=
 =?us-ascii?Q?DaraxSsfKM+K8TACh0LUo8V4VmEXhoDuiUiHnU2Be/IIuLpQWVzadioNVI/q?=
 =?us-ascii?Q?v86MilFWqjbxJZ4pDu0Ji23L86PVfTBukjT4C2QWdtIr4+dwjxaKlYginpwA?=
 =?us-ascii?Q?Kfi3ILIxKfft/QU32zt9ggl593FOFJ0TDCisjOv08gua2jkoKrd/GLb36Dxp?=
 =?us-ascii?Q?SXcwPKh38N8/5DJebMjVHu1YrrG8oE9PJ1seuMdglvwRgEsfJ3tF/Drtzk5f?=
 =?us-ascii?Q?Fw70mi2YbIlXA+Urk7Txw/NLqm4Qztph2+eucklQ3kPeRtx3sZIICJFj9VDi?=
 =?us-ascii?Q?LettSOwYcnAfloN9FI6MI+u5YstpIfXjErxNXUbHxS6Sl/IdmnCmVCWUdRU7?=
 =?us-ascii?Q?t/4jLZhJhZZORM=3D?=
X-Microsoft-Antispam-Message-Info: 8jQ9UTuaaSkM708Iv+OrnYvleMUeeWopRyJagjWuRwqs5lkxPu79t4n7pDtTUFvnCuNY1U2cpIWavjzklRs8hcqQIXJXdCQRoqzSjA0bZD+GLV6sVi9Q4BuUZvbhbDu17/b+8q5ds6Rg1mMHruB498QRzkKsb5wkAaPsvvEbhoROc3TIoUxM8DEc1Bl3TeYm
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:+q289JaDl3zfG/TcQohlcSksZlHU8l6eLyhR4RGlW7QyhXrVyRouVYhk/yUcmjd5kXW++x1l5dAYaWdXy9clqZwfN9WnWcP1EzEfQ8L8VBZMtKM28MdJV0PSvbFYjk5hpEzuYKCOVGc6WKwkM5VbCC3GTb9u7NOls50o0dmUKAWQf1fV7KTOCYfVeVu+mrG91H+NGMMOF8CZE9zEZvj3hRTeNRS7DisdohPH7/h9XYrSVztQtz3lu5+LNp4K3b/fu43zU2uEjWdbo0cN6uesd5C2zqBB2Vje3pekorilcq1zGX7Ttdmm6GHeC6AvvPuST+7GTnkUTLmCAQXhJAPKJP5Gmj/uPUj/wIIHrBysAve/lzxtkSObNeef3WZnNfwZH/ymFVZKbKu6IsAc7eYfwsLli93h+7IPh385EK04GnjHa70/Oieyw3d6riE9EzcJbL7k9y5ycOy2MFv+WqRE6Q==;5:XfvXvt/H1GR1MTAVkxMUHFLnm33wivHfLKsHtaT8itMeS40jerwm9O4HFlGVlV2qr6421o6hda8xaI0BoFnwvHd14Wrk1NHMjJ8mpdyzetdsWrrixSEjbtorgk/JbGrkHLiz9aPYcUfNBlHN8K6FmgpOL2YDBGxhNWzeInfU/78=;24:rxYrIJi4etFF+aPnMGEilvNOJDhmKLLS/cyrcnzezpcj+Rqj9dCwXWPR3id4qzn9tcVDb+F+OGXKtBCZgKi/xbfaq/uYnokE7Bql/y7yfjg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:Yfsuj+mW97ypeZmYvbXR/e9J/Zpf4YImUxVpZ5LLizYaOac2W0gSQkgE2nS2GTZUA3MJM8GrwBogQlxwX6r+oGKj3awVZljQjpcsCC8eUvkmn0M43kKu2htGqAqBVAEwhL0ERZZmXsPm9PYSLuDNHen0VFD8ctlr7NGYsJzCXVyo8ziEHSOYJ43RNrmtlkN+vpaPWlv+WCsiQc6JiPEfe7Qlyg+ECA8VUzEQDfsJnSrgwoo4B1uASia2feAFdQi3
X-MS-Office365-Filtering-Correlation-Id: 3a5b43f5-829c-4c98-a2e1-08d5ab43ba45
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 07:02:46.3449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5b43f5-829c-4c98-a2e1-08d5ab43ba45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAX7322 IO expander support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V4.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 2caca934..d59084f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -163,6 +163,13 @@
 	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	pmic: pfuze100@08 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
