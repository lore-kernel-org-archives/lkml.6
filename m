Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965395AbeCAAzy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 19:55:54 -0500
Received: from mail-bl2nam02on0047.outbound.protection.outlook.com ([104.47.38.47]:44091
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965286AbeCAAzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 19:55:51 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <leonard.crestez@nxp.com>, <rui.zhang@intel.com>,
        <edubezval@gmail.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux@armlinux.org.uk>
CC: <Linux-imx@nxp.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V5 1/2] ARM: dts: imx7s: add temperature monitor support
Date: Thu, 1 Mar 2018 07:09:39 +0800
Message-ID: <1519859380-15878-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131643393489245680;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(346002)(39860400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(336011)(8676002)(81156014)(8936002)(81166006)(5660300001)(36756003)(450100002)(4326008)(106466001)(53936002)(107886003)(104016004)(86362001)(2906002)(77096007)(2201001)(26005)(50226002)(305945005)(356003)(51416003)(54906003)(16586007)(316002)(110136005)(105606002)(48376002)(498600001)(6666003)(47776003)(50466002)(26826003)(72206003)(85426001)(97736004)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB0731;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD029;1:XCHHGyrUdoHWbT0PdVjXGF9BpG82nj1gNIprFxMemXdGVPU8A2zfTDXMr3OpmfG3sCaqoBsw1aTbhvL2flc0YM+paJnbX+8dH82hnFiISrtE5heOrWqa5aoUyKJPjFga
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19055f1e-e7bd-4808-b48f-08d57f0f2c68
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:CY1PR0301MB0731;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB0731;3:uph60g9KkJ6bMzxKItOtBCFvP3zDopl72iwOMx40Dn23sjNasuT6vMOIZfpToiuG/klD+OZshjNFS7PiBeqLuuE9aQBMWImi1P12wzdIFH020RiJ99PUiKazZNr5gUM6vanNk8gJZVtK6Kr2Ki9gYrgNIRmFJlY9rZXUbxnz/uyCW7PL14lxnjaJYrbPYOC0rKXeBMExzAsixvYAVZQJkz7MDEvvv3vW5qM8+TNhkymfxDeOYtjCRulubFT2f5uoMyclHRzDbxNNST1iRurhYWGriULTi1vQZDoPwHtvarGkXAXNR6zFzV4Vq507AN1mmRApmD1y8T0cI1xLB4cdo2CXcnXbXkAp8c6p/GgcRJg=;25:gFbzy9GEX15XAj1L7GvpI8msvtOV7QCucZmv3Qn6y4GHrz2vFm4QmB6lLqqdNlJ2MqiCuVcgCuFJ2KyPAmhktj76ardKrVkXgGcdRpl0dLQvGPEj+RmhesBOs8DN2XCOCZB0YICi8OaQ0mR+p39pEez2QMmQTmjFMCkDsEt0GnLqKKbRdA3Kh0LrtcGf1dkV+It0iapPAtKVprLNhncAbAZBTFxX20powUW5tPuTzuHN9wN2DMo74ATmFeoXbk9TA0h2hFsZNXWc0YplErGiQjHLWciqs7SNqaCSGGbVM/h2/fAmRVpI13w0p2pmlXK+7iIdFXXEtL+5MMwXOR7Ifg==
X-MS-TrafficTypeDiagnostic: CY1PR0301MB0731:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB0731;31:j+2390DHsKHkUvYOMzZgxG9YgO3wLCysJqUKeuOxYsxLlelZQOKbkgoOxMDkPg7sPH8PTxtqSq4QgIJ3wGphXh+HZWas6sRO8tB3Vj/so+9KtfwBHzDfhiX19R0kSXTApYDzDKO9CA0Y9G7US1diJFVhKn3JMyq4rBnBkBFLGcyeCXrPmFNWMi3f3i1c+v6QF0MkWJvAuTTuC9fA3ZMdKOt5pvVyz/78zrFMDiX1oMA=;4:1FXADil1/JUx7R6+SJQA5KPgk6IOTxuamX/SoB2a32QUVVn0KUTH3qV98g4V77i0ABzJ+I/n+LEdBMW0fGbcm4WFR2EHBYmNJJwj5yQwt/wzEG7yKTKS+cpXHrDZ3CoBOdH7Rft4EB6NC7TOWecIoSzRrH8kQEAIcXjK4Pd5INlbLpbJEaVaLdsBfouZWtlbEEoIJVujUwQSFUnbeEC+f0pMNY8YIz6V+k2Gy4QDe5/1DTesS8/4Z+3KQPhXWShGEXifGHCvcMO+xAW7AJV5VTo8KR2SD/yUUl7zyl9uHk/akiLFfZyaGp6KiOI5ZLJU
X-Microsoft-Antispam-PRVS: <CY1PR0301MB07311FC197464010C0142FE1F5C60@CY1PR0301MB0731.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501221)(52105095)(93006095)(93001095)(6055026)(6096035)(20161123563025)(20161123561025)(20161123565025)(201703131430075)(201703131433075)(201703131448075)(201703151042153)(20161123559100)(20161123556025)(201708071742011);SRVR:CY1PR0301MB0731;BCL:0;PCL:0;RULEID:(400006);SRVR:CY1PR0301MB0731;
X-Forefront-PRVS: 05986C03E0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB0731;23:zJYqKRLfw1jd4C4TodAH5LyBd7APBzVI4s9kaPC?=
 =?us-ascii?Q?ZyR9GHCVTaiyLwivi76otoE8Tx0WlCkCoFlvyKoXG4uz1jqENquc1qV09jf7?=
 =?us-ascii?Q?irTNR80vDdtt+NFF7vT6ZUt/DxBszrrLDXWpxhoLUX3zeBYzsfd5OIVFZkvI?=
 =?us-ascii?Q?0/5Vtn9s6LfdumPNo/bYhVggnGmwMPY157A/UtM/WgOu4nFEQ1cA1vjpF33q?=
 =?us-ascii?Q?vxoX3yTdwF59c0QhXCMESoVZ3c3jF6ZBMxH+b+acNJTEm0gqQlgAHuf+HTg5?=
 =?us-ascii?Q?0QANBh8spr7cdkFPNSjW1oheYculJXBwP+75P8BqlaPUVIR/CyqzybQ3nuvF?=
 =?us-ascii?Q?fOuMjmt8Vs1Bj7rYGJigoCwzLW1zJk1/6StpIDt0g3XbiBFtQR6SdazF6QHn?=
 =?us-ascii?Q?d6ec+bNflFpZVcrS+Q8L/+yXpJhLd8c2191V2kFu1Y14w/ricnxmy2lt8J4j?=
 =?us-ascii?Q?hOJvZo9DMKAbM4jIEUMvFa9ACZNAStCDaID6WW8eEBsEh8Zp76/Mg+WjvWVl?=
 =?us-ascii?Q?4y3m36bM472OEiOjGdmoyy7EQd83z4aZexrFOb3L24STBsS43sZPlDqVUu4c?=
 =?us-ascii?Q?PQrT2hquVfDh3L4Y7ebFP0XP8axFR5VUCdHiDAP9G6AJILQYltSLDf7W9Iqi?=
 =?us-ascii?Q?uyzODsq8tgbz6oBsQvqGbr0RKfhM3OqjKJlVNTUPGKQdOF/TMTu9mZ5lkevv?=
 =?us-ascii?Q?xSPOHHkKb1B47hInfiirwPB6++2H7jTlCGBpktzsys01jBCEh3J3QZ4Xp7fA?=
 =?us-ascii?Q?GeaXnjPST3DxHVqvE41M3gfWmdAV0HtN2WaH1P8Q2l1CQixnkAhYXC1DkiN9?=
 =?us-ascii?Q?Q2pxCkVzvjl1MMmMfJPqzD02X0z+eCqtCpkDw9Fn6/M+PElfoXerBMXKxD2g?=
 =?us-ascii?Q?HbHLKsyN5zNOhUT75fF1txLGNfKK3+xp1Q0lciN6jqgNSEOi35EWe4nuNHCb?=
 =?us-ascii?Q?GHc6ycHmWvQ7Frf30d+ocVvFtx4QkuPwvg92fKhp/Zi+bDd60QtIASVJL/oR?=
 =?us-ascii?Q?Q3TgmSOV0xy4h6UOspLTnh2Erx+/0ikIECsyIVCYeG7DjnlIfkMsQkkNz3DI?=
 =?us-ascii?Q?CiN7QVTYq9alK+cicmE2YHiucMO4eqktfUHBb3fhZcChmLER3sREXCdxRAlP?=
 =?us-ascii?Q?ixCz9dg3mJiA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB0731;6:J6q34024mu8j07gcV8iOpkP1/7G3QOSHMi3wQIuDJBRS1t0MK0JCWIBo7ZNfF0CRYzTYjrWyKMPx+RxtmWxg85vGJ70z1FbMcclj33Rsif+BNVT1wrTfsdxnlkKHScL5qC4M1j3Tq3E/0cwCPWP8wdUtK4IZts7TALuc5w7pAQkX46LVE1TqLDNEcUEJ3rqtYELhMveKh4IjLWAu/fgA+zKqf9XOakFMiDKGxUhOpRj+zzOoNsaPa9KJZfLepm5rp/BZSRiwB8Bain6Fo1zwbWubLsW6SmCGjurDmM34H6TIgMdrkIEiO3wDiQX5ttIXyFcm4GKv7v50112UU7XqINXxZ7TI27aBXwHf5vo+qEo=;5:RcJupjUm4rHDAkaqBq6q02C5lGb1sYIlF8r6xAZftGGSiwWQytlHndgq26iy4ddu7wJvr9jUIC6tE4YgaSr2Qs30IaKbCkmvMzsFCzg6Ukf3Mkoy/XIuK7Y1U6WKpM6QlUWWqvEX+cAkA8I0DzdzNC2vmQXoB+dvQ+WLcQW4Y/U=;24:IvLFlD0LnRecXWeP/b8UcYVCPSRuEWO/1iezZBpo0u9esY9M/Mz5iaBff5+LQEPwioGz5QVf84/rIKBroMhX3jiai6DraG15FZr1E+20lU0=;7:u2hJp7KSz/PMcxODWuN8AFZdQSzOr/v6WL2f23pDp30X+YY47GoT0DWMKPYjLHf9moWueOY2dS1v73dcdjORTWUuM3NWh150D4PkLSpbE6SVAXzGorG64AzcweQHdMNorysptPk8psEi40o7XDz4oO8guPaMkISV+UczCmTKok8eSigWoKvBASc7t+BeKbHTBH4El8ttgLiL6bY9oi0t324B48z3+1adr6YeagE9/QS58lqmVP9a2/e51OvBLysc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 00:55:45.3365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19055f1e-e7bd-4808-b48f-08d57f0f2c68
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB0731
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7 temperature monitor support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
---
	No changes since V4.
 arch/arm/boot/dts/imx7s.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 9aa2bb9..6a5c1bf 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -511,9 +511,29 @@
 			};
 
 			ocotp: ocotp-ctrl@30350000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
 				compatible = "fsl,imx7d-ocotp", "syscon";
 				reg = <0x30350000 0x10000>;
 				clocks = <&clks IMX7D_OCOTP_CLK>;
+
+				tempmon_calib: calib@3c {
+					reg = <0x3c 0x4>;
+				};
+
+				tempmon_temp_grade: temp-grade@10 {
+					reg = <0x10 0x4>;
+				};
+			};
+
+			tempmon: tempmon {
+				compatible = "fsl,imx7d-tempmon";
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				fsl,tempmon =<&anatop>;
+				nvmem-cells = <&tempmon_calib>,
+					<&tempmon_temp_grade>;
+				nvmem-cell-names = "calib", "temp_grade";
+				clocks = <&clks IMX7D_PLL_SYS_MAIN_CLK>;
 			};
 
 			anatop: anatop@30360000 {
-- 
2.7.4
