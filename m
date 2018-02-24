Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBXJzw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 04:55:52 -0500
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:22653
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750841AbeBXJzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 04:55:48 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Anson Huang <Anson.Huang@nxp.com>
To: <rui.zhang@intel.com>, <edubezval@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <shawnguo@kernel.org>, <kernel@pengutronix.de>,
        <fabio.estevam@nxp.com>, <linux@armlinux.org.uk>
CC: <Linux-imx@nxp.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V4 1/2] ARM: dts: imx7s: add temperature monitor support
Date: Sat, 24 Feb 2018 16:02:48 +0800
Message-ID: <1519459369-29083-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131639397456775563;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39380400002)(39860400002)(346002)(396003)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(104016004)(106466001)(498600001)(336011)(72206003)(26826003)(5660300001)(68736007)(47776003)(450100002)(107886003)(77096007)(2906002)(26005)(54906003)(110136005)(50466002)(50226002)(4326008)(316002)(16586007)(53936002)(356003)(36756003)(85426001)(305945005)(105606002)(48376002)(2201001)(8676002)(51416003)(8936002)(97736004)(81156014)(81166006)(86362001)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR03MB477;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11OLC015;1:NZTOUv/lzHunxMxMxrsw9SRt4P+TxP9Vr65Ov2X6/nxhDYqjDA5y3cgL42TMzTCcXcUmeYc8PAsPwChuebRooEZrfu5oFIErG9hNQzOn/heEXJCSjb7Epjvo8W2J6jVA
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5470201-01ba-4009-bbdf-08d57b6cc63a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:DM2PR03MB477;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB477;3:eNYSTbqjSxxs0Q6DP7tccW6RA4izkf8I5bBOsSaRjPjiecRx1VNxJK0eBKlvV5IZ+fxGZei332/+V4Pcmll5XE/Utlgev0ctULySY7gSHd7umhzBvQJfjWwRevu2SlsH5TASMaEx6YJ6BCVtP/737ex10ARmZivX23b0lJoH/FI6yQfhn8jLPQPCh/+aFncsCqeLx6KmtJBh3qvwm5ER930C1Na836o8kmu+QtW63PlHyD1kKi3dFZY/KXfh9ga/MM6EIvlC7fL3NXBuFZSkJJia3lnfYYjHkCcHxxRvIUHWzKMGyFceHr/i8wryEUc7D63QwghXHTchSAxUSEoUZHTks8NE00/DKqsjaCJ1OW0=;25:quLMqLwqm7CENq2OoaH4yIsBuau1RP/IYMzzr8u3f4xtIPJPN0DdpqSpy0ADALrAkRmalLWltzMiTk0lyKGkg0srZt72ZdStx/3WoftwZOMqVFbRuDOwy8YJVaTUUAfXm4Y1ftQVq/8vzBTuRkssemV5ENR1i9SueE5LHWZjpRoc883NtxN+7JCYTwtSnbEkLoitbPfXFuSGEPRtJec2mi7k0mZaBbh38PIp6gF8Ej/6Xz+Z7+OuCNm7Difc63cbfvMbvzsidxrALCxwRJfq+Glw9gNpcL8PYDMKbD7y92rS7ZSBQOvlF+lMw2LF6fGdGDMtvGU3xs9f0TYQorOQqg==
X-MS-TrafficTypeDiagnostic: DM2PR03MB477:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB477;31:g4WUFY2tI2T168BDVhPJ8525qscZW8HiwAbj9Ow3pZUslSS5mFgGH8DkoBy/mDg0VdEYNWVWxjZgbWjRMjNQP7D7oOrFaMnorhnPYYu7SPIXHcE7vJR1BtIlcayWUgYnRXRcGNtAbndgkd8YuwBTdGBEOWDAch4eYAJS0XSpa7QT9ZrZjDO4Od8kq+rdMZhIbK/nmAbKtPFDxSgQCg2Md2JpTGbKwuXv4Y1d8PrhpD8=;4:O5s9qA9SLjoPi8TfzuJ1D3HGHux4FZdhJ/8ZagU2ARP+EMM6Tz0rY+2LzWYI2l78/DC1q3TFDq9Rn202PA7OmjDln+Qt3a5FbEeclrdTzDjwxIg/vaRcgEKFcTP6RRAeCgMQhv0dNGazD/P4R9SVjnMVsj/cSRlz98Dh6tYTRePHjGj7oxJ5M94ypbr17BdxsDZHOamt8QD81UC8QjVcZZTPhorWNdL8ml6Xjt6QhZQIV89eg9z2+5Y151qoUvV1jHYncSQA4qJotRSyQkoqW/XwkTd9GscPmlBwBJWXHaHROCN6JKHMgPBB9Ldg297N
X-Microsoft-Antispam-PRVS: <DM2PR03MB477CE18780434789DC3482AF5C30@DM2PR03MB477.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123559100)(20161123561025)(20161123556025)(20161123563025)(20161123565025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:DM2PR03MB477;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR03MB477;
X-Forefront-PRVS: 0593E261C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR03MB477;23:9mKBc/EmY2jUfa0jIG4jXFZv9jFzwcjFBnzhFDWfx7?=
 =?us-ascii?Q?frgVueDC4y5kOQtDVdhmMZQ+kIeJDQGoJ0YW2UyRA2eW5kZsD+p3x0ShdAuR?=
 =?us-ascii?Q?twjkpJivGUNLLMJfSid5S36PLPGrnKkuDNJUc0naWyiBkrZiBxHPBn1xawwi?=
 =?us-ascii?Q?hXb4XOvqungs2drQgr7zo6CxUVky5DtDfyrUx+RJLiVjdfDPHEoGKGdIQz/v?=
 =?us-ascii?Q?GHp5LLWE4s3bod2GdwS/J2GMDt3kMAD9JEV6C6OWu52j2B0Y+CziOmDi+JWj?=
 =?us-ascii?Q?Vcvxp59R/CjJwARsHHosjl/jOR5Xe2dhnMvQkRLYY0R19GcAzyBAa5oKvRqz?=
 =?us-ascii?Q?URxO2WCQZKrOkhZFGe6kdfihxO/sbojDLUYBHSq7gPSYfxJGGYQkRg6ukOcF?=
 =?us-ascii?Q?3S7QRBtb+lkelliB17IdeKRDm86wq2AmyyIlcH7FVA3sYSMwWD3Lww2qwgPQ?=
 =?us-ascii?Q?IKcQEy13SSDVbKs0tc8iB2fyR/3N10OQphhX8lJsgwsZO6IPA54rEc2dJNOO?=
 =?us-ascii?Q?1SIA+F1mDPwHdRG3CNAozvMIX88ksAu9ksrLRosHoLILdSwm8FmaTjAkoiLI?=
 =?us-ascii?Q?Jqz9wu1QUZsqpFP6AZXHam+gePAD9j/0w5dccIM3+39L5AOBfpGJ98oBXUKk?=
 =?us-ascii?Q?Jxy0L+V6yjJi4ZVK90zz9u2EslR6Mx6AvsFbN0g7I/zuLI8AX5vMUs5O3BCI?=
 =?us-ascii?Q?Mo60zuTfezHNASLQEgCA/9Qmg94BdQNZ8B2iGZZcKxSClea6ShHbzOZa+EZ6?=
 =?us-ascii?Q?7KA625Oan9ybZDvjx3zQw05e5wR1gHYohxGZe0x12pTiezZpYgsr1h+4nikr?=
 =?us-ascii?Q?Ov1mHyZC46MjlrWbOqaMJ8SR9eQ3X0eyQuLJsGAAmCEqz6j7uwKFFs/nuc0d?=
 =?us-ascii?Q?+iw2bEyS9Xtm9XrFExuzMYo//ji7XthNXLwTrUKgqmbLKJSl70vRU4cQn1c7?=
 =?us-ascii?Q?WSLjktynUIwiZhNxHh2jMIPScw1henlkdFez76y9i9d/RdoS7PlMN2opxHwp?=
 =?us-ascii?Q?o69tgJGmdcbI8BAg4O4i0lDaPQZ9jYnH9P4t4TlmPY2nj646tIiuQ7ztuu/C?=
 =?us-ascii?Q?YhPScHAv9GoQBsHMi7FW9qRZx9jKTv7acj0Jms2SdcrJ+apHLuLVvG6CAcIV?=
 =?us-ascii?Q?aceqvmUsI=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR03MB477;6:70hGaycr2HMSEeoq8FG79EuT3xP8KE+/RyR+k+1vv5n1Nu0KjBSq1CeTSAndTELImGTlH/Q4NRjiQmEiwCW8TAOiwVetByKld++DoKhNPHabQp6q/VeuPt+p2z23ek8kxuSdIe39g9/uMND7pUw/5lYgAVuSfq0ytfWL/REJEVSuwwxDWQ0nJyCqdfeGNPEKdFnxITuFiicH/Ia5sDLFwyB6ser6mfpeS6tw/Q2HfESwa8H/nV8dk9tZywQd/jRv7kyB3c9kh+yvIJWk54Do1NvpU+T0SVuOw0KEBniXkMPFdHOOrlgywrTOAywnZ85buO16b+QttZOSWegi178oJEBuZtlLc1BF8wUbkEVybjU=;5:pZL1fgcg2xhE4STsWdlhBhYArDFmzqzybOOzmyEaZ0AIttuk0mIxoEuOMtubxQsldrbaI1hjFePwcrFLkTpiNMAN8rSSUOPpHGsFxuhCP8/pCfZjD5COLOb9RTWGmQFVv94LxEWuZjob2iJ7PC6PvLgasj0MfEvSRJrd+NuzKxY=;24:gWvUZMHHwoGLorrkqzy2OUyunxUGtqJEKbZroB1jZ5HTed0kxYKa7fJuwt1+W+EeskJD+BE1+i6gKSzdMCMooMPliVvEuSIg4OpfvrRo9po=;7:GFp4wAQBdb4RFLkJjbtvLjDszyGTE44pWslel1HDctEveBg9YoGYatvnLC14IcPRKR7Wt1jlRwxTizaRHaz+XbUeo2gMe+trVJzhc8NjIuxqAx4id6Vx4pvNBCQhaOgA3+0tktjPfZxLCK+v4UDW4+ZzilBm5qyKWO+fUTI0xnuFkF1EGHOmy4sblwIqM5F7W2SO11wgPrt2BmUQ0S0/UCNfXfb1OHJx8PAymBiVPOJ4OxCAYy1NYSlMk4e+1KTF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 09:55:45.3499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5470201-01ba-4009-bbdf-08d57b6cc63a
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR03MB477
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7 temperature monitor support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V3:
	use "fsl,imx7d-tempmon" instead of "fsl,imx7-tempmon" as compatible string
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
