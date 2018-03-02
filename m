Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164513AbeCBDzw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:55:52 -0500
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:27550
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163455AbeCBDzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:55:46 -0500
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
Subject: [PATCH V6 1/2] ARM: dts: imx7s: add temperature monitor support
Date: Fri, 2 Mar 2018 09:59:29 +0800
Message-ID: <1519955970-11365-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131644365443672451;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(39860400002)(376002)(346002)(2980300002)(1109001)(1110001)(339900001)(199004)(189003)(305945005)(356003)(51416003)(26826003)(72206003)(86362001)(97736004)(498600001)(26005)(85426001)(48376002)(53936002)(107886003)(50226002)(106466001)(2201001)(50466002)(77096007)(81166006)(8676002)(81156014)(316002)(54906003)(110136005)(16586007)(4326008)(47776003)(2906002)(8936002)(104016004)(336012)(450100002)(68736007)(6666003)(36756003)(105606002)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR0301MB0608;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD023;1:UtSQ1tQgfUAgY7hWCQbmutWY8vAsPI+weveFCoDs77V9g2BZSotn9tBIX/r6QKBav42HSvy2A575lUMm/py3gF9vyEbWLsBh5NTUSZiNnynetxs+K7vQSDB9vVtBotkX
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a842b42-039f-4c89-4822-08d57ff17968
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:DM2PR0301MB0608;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0608;3:s6xuwaHKzM+YW/Nh82iO2yITUBb6OVr5CVL/IBI4B/EJGOPK3pSK3A7CgEN+Xu7/9psK05KzLcZusBF+HcJfYes5hrLLO+5MFCoAmxM9VQqQcnFhVDA7NdwxlxPftk+8B0QOq1LDTjM0VNfusJTFKQp6VGe+fFvbegt+UoW4p66p6FJSuSClY+c0T+4BRyllSRkSW6zruAPGnIEFexPPCSJwMOp3gKt/CPMn4lR9ATLT8fk6QdvAbLV8Mol6cyFl0zC2JzVOGrHe80XwUyuiQ7B1W/Bg6je4HSr+na9M7ONt4EDAk6UYX1C+jVey+SzjgjscZs1C1BXESMM5EtJFE6V4s36s/k+StxHCgw4QfUo=;25:44k1jOn44H5YI5lW5jEKijf7IdWVYHQj2QHiFJehoHpOKTeeLxM1fOBJRk7O0mUa2wZCwq60+7X1EZT+1El/OoiRTa0KnpneR2x8GbzstJ/AsCQUn/N+/gvwBk0AP7tCvTvvV8+tvfYI95Ygbzd0YOrgiR1nc7gjpAkJOIskZ9OSLXGS59gVXCniJug7Fo/g+MTd4CDE4mRU0VXym50kU74QSs2MlIvHx8Ca0jy9OHKLTAciDaZ5BD8+a9y6ngb3otaVVfY++e2v1XuvBHYcvScEsYZaJtXr9vJMCewc3cY11Lm6SEkd4/H+7OeXu3aYOX923x+SVmW0syFi5YhcPg==
X-MS-TrafficTypeDiagnostic: DM2PR0301MB0608:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0608;31:1My2GN1ITrvpEaRCMMAzZcVj1QG6r7iNSeFoJ9+CQ8ISSKPaD8xz6gOuWF92i1VpBMsMn8h+4LWddhyIqrdL6gRZZ/yMdqluNxeH211YBXs4RoCkPo15JN0Xcd5P3k8ofDoi+kj148sQkG89cKRBGB4F1rdQUJXStuq5h6Zq48rXUIRA0PBQTSAuMlaJnyBlKNzRXsl3e7WopfSm7uNxgVUG6JHC9rthe3xc62HTrAY=;4:+QPGlttUf/yiOiOL3TzeyyGIFjwQpgGS3WTLJKUGo/tOnPt9txSd2LURUMYg3Z0RwnaglQY4abH3wBaHW81nVXJwJJtoK1JP8gRFqEoanlcV7OpJaciNPjqn3lUl8mKzoL4gkkYHQ1ZfTRRtllG8NmHgi1IeVorkZe89lbxLyEjkDtoKpAa9m3gaJ4hRLOsrIkER9bfhdjnPm2vyt1u1pcRG9C+EC8ZhS0zv2YqGUEIUny+Zkp4EzFAuzYDX7/+k5LkRGxYUnrYn9AEhEeJpo9DXZuKG4DiYvUlNtAaeL374YXZOl8zvakMIf8z66TDN
X-Microsoft-Antispam-PRVS: <DM2PR0301MB06087D4D95A116768E8D6A1CF5C50@DM2PR0301MB0608.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231220)(944501235)(52105095)(6055026)(6096035)(20161123559100)(20161123565025)(20161123556025)(20161123561025)(20161123563025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(201708071742011);SRVR:DM2PR0301MB0608;BCL:0;PCL:0;RULEID:(400006);SRVR:DM2PR0301MB0608;
X-Forefront-PRVS: 05991796DF
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR0301MB0608;23:KfTyB2f8XRq2ia6utvjzHktFKlsj9zDPmi5fMFR?=
 =?us-ascii?Q?S7XoMijGR56Id+/QcD2jA9Ck+UPhkj3Z3lZlz8SzmEEiABJ4QHkbsutlnqk7?=
 =?us-ascii?Q?nKSUM4BsidJ3f7PUuDhQejkV5P8g+Ub33EYoxdm7DxYlsuV96i2GBJX8wmWU?=
 =?us-ascii?Q?Sc9T47qTwoGbcS5bMcnVGGeiqK/5N8AecAsRC6tTzm6DXvQEfj7lXPz2oMUx?=
 =?us-ascii?Q?zYKMqiBnj/jbJRX0P7A/F+uHhACV5V2TIzwrp9VZ+mqJu8AnjT27dNzM+Ero?=
 =?us-ascii?Q?uQ8lwFYBYpavom5BLTekearCHLdnqrSucd9WBrS6C/eXYF8em9PFLc2fUY8u?=
 =?us-ascii?Q?69443ezMBLroh5Q/gSjhtvs0o19Gj/emvuoCduJCkz5f8oYOl4JqwqanVBaz?=
 =?us-ascii?Q?Q2HLynE1TRs33jEWXWA52F9Ezoy7/ts9udK61CRSWzrcqdRwGhe1F6weHBBK?=
 =?us-ascii?Q?zWkHifWo1f0n/wswrSULcC5DnuFZzdnPHGf7hvkeekcRP0L6OzpUfsJ4tDXA?=
 =?us-ascii?Q?mIQ5+IeKZ8Lr8yZZ1kWmABW6KHagM5PU7xBVWiIYyS0O+XG3uZm/VwUUF5ZP?=
 =?us-ascii?Q?Vjb8lOR8AJ/IQyXafyds9wWw24VYRsjSrWdPNv2pS16ihiZpjOo47F1tSF7n?=
 =?us-ascii?Q?IVIxPk05k6Se/MOi95vIc3e0KRHOsl2ydwCMYV8uEQjwussk8cp7TJW7kYSV?=
 =?us-ascii?Q?j6W9DlDi+ZmgXxMIydneqJRWwBx8ZdpiLFecLzmhBJegZVOTBVg/dm9OQGCe?=
 =?us-ascii?Q?iaTSQjs1IYcxi3AHWYdRNYZAHXXBY61X/Q1gmYdHt9S1CXSV6+Hpld2JTV/E?=
 =?us-ascii?Q?b/JLMgMo04F01aYmARMBweCA4/PbDTgX3LaK48n4rBIrdNuG3UgWDPbgvnIg?=
 =?us-ascii?Q?E1zM23Qw2rQi0R1cDvcRsaEyOGYQ8jxWK3CwcoqdUMCqqG5qtPtCkkcniRKU?=
 =?us-ascii?Q?CmND8nZ09m+yx5gtVXDnFDPolQAPs4tCKMZfqizgg3WjlgBYL+vMldMkEbOt?=
 =?us-ascii?Q?tWtuaMfLKLlYePm/3/E/rd3n/lg75/KPQidE2x2NbwDDc8Q1sPUmjO8DAU1b?=
 =?us-ascii?Q?K/EIEB4DWEUm0bQ2Pqz5/UA5lS1pBOqJnwsB1AQpbuMj0lBRC/T4mC8A/utA?=
 =?us-ascii?Q?YlhiiMTkwQ0M=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR0301MB0608;6:N6XVs98ISVrUo2CtyZJALzJEZPCgyTFqXvB9qQE6dcaqOiP19hvCIRnthmZoK/WHC0xnrmWWFn9BVD2nPJuAccLIEaRyAaO12uaoDOPzQkJGSkAKcH6Z74NwZ4pQtfW+4y9PgFlabkCo7frN0KHLo5QLv1HG6yGglEvpnTISpOYMEKNYbDvLLejb/GLyDTVd2gI1Ou7ea0wO2JNNiNYiLEcqO4ocM6bDXLE6BMSf+2cpC5u79kn4wMtFuIT/B8Zdm+2bivz+FeGPmexf5m38C8JUqyzvG0WpxhsNrDIbRsiGP6qiVXDacbETlL14jRZuufSl5xmK1QaICJNUSWvZabPR3Vhj9QT99TbN9r7DiW8=;5:6Otds2HDelUzzYb4hCw6yxwfJ+dlW8ovxStnk/9my36GCKAyOH7EgqYhXW2zD8kJyt2sBlq8gBYMR85QcPxUAElV2AywMEAcf5wfpO4WaO+iEXzVg/ojk9Pq5/45E5zW2NOxxOdZk3dysxW5oTGsQ+m0vlESIhDC+XAMS4EgBno=;24:MGoyWXXl14AtE2bmwfEGz/2sp8d9ExqClpKxA2NI70JUd9nS5jSBS5xYFAIPDshbQVzP9UthLFSNaMTlUslEGbbZo4Ibt5EDblcJGRz/Ixw=;7:ttjD871fACqzIUjS1AcXx9yizXHo4gzIYgADmHaTR+NvZh4gPYYkQcey6QzN9u7mWL4J+qGuMKAouuWbM1l227sdbeHDyFuJChSoBBHhSawWq4+81ynyXAPz9txrXt9pHDzfgnHTDcmIPzogrb6oIOthdzp3RoPvb405m7ErhCj9vF03QFw+sUNzF7n+yJ2IoU3koz8aIXKQGcsi6W4K3FD9xSVyKeLgT2UyJJ3hsiThk6eMirUbW9aCbazV5Mok
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 03:55:44.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a842b42-039f-4c89-4822-08d57ff17968
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0301MB0608
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i.MX7 temperature monitor support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
changes since V5:
	no code change, just add Reviewed-by.
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
