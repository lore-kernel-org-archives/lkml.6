Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeBHJcr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:32:47 -0500
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:47008
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751963AbeBHJcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:32:41 -0500
Authentication-Results: spf=fail (sender IP is 192.88.168.50)
 smtp.mailfrom=nxp.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=nxp.com;
From: Ran Wang <ran.wang_1@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC: Leo Li <leoyang.li@nxp.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>, Yuantian Tang <andy.tang@nxp.com>
Subject: [PATCH 1/3] arm64: dts: ls1012a: add cpu idle support
Date: Thu, 8 Feb 2018 15:54:34 +0800
Message-ID: <20180208075436.38443-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.14.1
X-EOPAttributedMessage: 0
X-Matching-Connectors: 131625559601617079;(91ab9b29-cfa4-454e-5278-08d120cd25b8);()
X-Forefront-Antispam-Report: CIP:192.88.168.50;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(376002)(396003)(39860400002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(68736007)(54906003)(48376002)(450100002)(106466001)(53936002)(47776003)(85426001)(5660300001)(110136005)(4326008)(50466002)(305945005)(16586007)(104016004)(316002)(356003)(2906002)(59450400001)(498600001)(51416003)(26826003)(36756003)(86362001)(26005)(81156014)(81166006)(8676002)(50226002)(1076002)(77096007)(97736004)(336011)(105606002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB466;H:tx30smr01.am.freescale.net;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BN1BFFO11FD036;1:QiNEovjaNKEAyRJlG9zW5xalSauaHXFtlDFnqlOjwZtm+cA0kpJX8WkBd7TUlEGPJW1XpjtGK67ZWIbVf+3mTJnvXVfudc3ue7kyeVM88ZwpWWTbXTV3uIZyaHGlgfel
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27c4105d-19ed-446e-8daf-08d56ed6e5ce
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(5600026)(4604075)(2017052603307);SRVR:BL2PR03MB466;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB466;3:n0gv/KJ+Vopw4LRrCh/G/ZZAklnh/hzbQAsNnDp1cLoQwa6XEKs7/R5wW1DLZB3Lf/lAu1VLPzuW/mk5AyXedPgim4qvAzA1EuruFOmYD+IinRVMtGu5XX+V5VpaLmuiv7yal/NIFqJwcAaay35UvaQdDKJeOqa9ARNJh2C0VKm0JI1/D02nevaANIr7qMy6w8d5RAx1QysVC78YSEOAmh6VoGmsFm9dRUxshIzGMiteLA7DNVrOzZp4wj2uMvLbjawWgFJy9ub1bAwoMdR0Tr+yTs4/UUvLYtoDZjq7qk/7VvUdmSnyqgBOFk4auqylyCHpushq5c0I2tkPnezgDJvBVPPCGkhneqxfUrGaT6w=;25:OSZcx8OVA22wufW14Ua8hFvNI+RqK48LdgcDJnoVW7MAlsbNBjDpNnMiLbIA0d5f7nsNP9W3oOGEGCZ/twLMXiz9Pxax1o0GEJTQtwPL/9POpVMv5x+o1ew4H7WtxGh2Ctn+yBMA+APgk+karxLE4zvgT4MbBdfhUBsSdZOReagBDgcOFBN7ek3itDQS4pKUeF8fkE5tDAO35QqcqIMK7fbMTX4HP9P7Yw1OwwbBPLo+LQAfq54rpWr0q7KcJUzRzT9S/Xrm1IHFLSi6RDT1iv9PJ17IZcmLXH9ZXb7egDra8J5uYUsM7pcbTDJTUDTJczigJVCQ6HlLBSYg1ezWqg==
X-MS-TrafficTypeDiagnostic: BL2PR03MB466:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB466;31:ujdA9tLTkfMCjGEKEk6Cu5O/2+/ywO4n/YwlssPhM8tj/cFbVyogYnyd7/3xXxV/C0UUCsJyu2gMfngYxksLHoXI5m6A1X1aIVKoPPh76c8JhIRMHzfJHD5PEty+jXTYafQwE4wN+ahxlFYZLXNF7rPWA9nBLC4fXCj+1/m+1oGTR7RKrIIB+27/FKWyawwODXxhCOWH2skDomUSKw6b3GSV1dbP8f6YJm105CTV6sE=;4:NDO7dCwj600KLt2ZRzGyDys1jB5I3Z0oKuY+5WM1wcG0iSzlowUvZaNBpLRJ8TE6hkXAhX5upJLwtciTwd8QavpQvFkkCgfDNx7ovjh+RtKcoKURdMKDwgl8mQ8pFaDsCeTPHakGW+Plo8uI8WTBPWf/HgnyRrDVvPLGFAoBhb3nGt0UyI+i95F46Vyi2YJ93c6q32eCfzEwbjhmq0fcm1dxUxG2t3vXiw5uvzXTHsoxiSBQ+18sW1XMipDoI8m9OgG0oyE06y14n2GCyN40SpbXzXb6AxjxI7gQsiWq+9J/cGl0XjD6kTB3dTe67caF
X-Microsoft-Antispam-PRVS: <BL2PR03MB4668D339C8872AFEB8A61FCF1F30@BL2PR03MB466.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6095135)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6096035)(20161123561025)(201703131430075)(201703131448075)(201703131433075)(201703151042153)(20161123559100)(20161123556025)(20161123563025)(20161123565025)(201708071742011);SRVR:BL2PR03MB466;BCL:0;PCL:0;RULEID:(400006);SRVR:BL2PR03MB466;
X-Forefront-PRVS: 0577AD41D6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR03MB466;23:6bCuoQnnpOypYtihVN3sxxkrzp5DJoxBlW5PQaQ7f3?=
 =?us-ascii?Q?4/lALu6WOmlBjNPj6sLZV4CPWMxkAIoI2PlSnM/E0P16ulmRwFwuNaCe7vwW?=
 =?us-ascii?Q?jsgXF53Is2FDzUUscBsZuQ4XuunwW3lrXJQV2/SjF6/HAHFSvERRKY8o6MVv?=
 =?us-ascii?Q?L49vmf7MYd2hztR+MMb1PAO89JNqlqg2R41iywyKMtKZ9ejzrtTJFDpEHPAz?=
 =?us-ascii?Q?mORLycvw4WWGJ7tNNhtNG9DWie957w0Yn/VPPeCUjtIdIpPUsye6dkbK7PVw?=
 =?us-ascii?Q?7tG3MWSZo6nfkamTEW6qhwoO3qmq7v0apIVQfwKENoe7DXrvNYEBvCot/Lxb?=
 =?us-ascii?Q?lfzoz2wng8tY+9ioebMLehFysGGLQIHlr2kGttrVSxM0s6GpmdPPfANhyrXz?=
 =?us-ascii?Q?abHWPqAOwqqUUGJyVjXlC+U6s1mVkLkuiMJ6g+4pZoemF4xnTMU9BMXuP6mM?=
 =?us-ascii?Q?HJjfou6Hd00EI05PZ/e7fX9LFYrVdLimRepTpi7ONFCqsIafs5aX21Q6zLXG?=
 =?us-ascii?Q?SchqDUWSmcUqB/3zdzxLjnffYXf19xqMakzuMXVvjngGNzFR84+4ug5ucrC0?=
 =?us-ascii?Q?3t6wUYvqjkcgAosm0rJMdAt1sktin046KOBINku0z8bNWYOGOmiDQkTgKgTj?=
 =?us-ascii?Q?HVy6ZwEgF4FeWUiDUy1AXws3lo23yYuqLRSBpL3tQb+z66J3RjQVP9ao8t4H?=
 =?us-ascii?Q?4kL86ZcXaipJmHb905TvHUUexsfPYdNxVEARTbDIQmHCGLbnx2r5low8Ha1K?=
 =?us-ascii?Q?7JU4mCLh2XPk1ErmCSIE5DPEKtaT9+c62pPZPxsiTmW7Wi/4r+Jkn+VREBzh?=
 =?us-ascii?Q?Gqnb33yo7+PT89S1FNycadqtjUE6m5d3slXep3JXB4uInKoFWxRnWv8h58BT?=
 =?us-ascii?Q?R9R42VR/xgxdUqpSKD12KjIWRXu17kfRsF3O5XkTWrTrhQu4gdchPv0EQSJW?=
 =?us-ascii?Q?YH3TJwO3xAYMSc68mAMFKdBasj0sy/HNgOmxloJ7lMxyAoblsC1sn5pHq75v?=
 =?us-ascii?Q?p+V5/ZDc7F+4FAnaWP7G563nKRs02JYAyjH4RUurVlaZDlwb+iiSVi3M7y71?=
 =?us-ascii?Q?AsMJG7nSAjyHJIpq4+w3ssK6toCMZI/0wVGEc9hfEP3XyLuQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB466;6:QOQbD37NneZTBl1nCja1psEuYdZcdi1sbEeC2QZvG6S+k1f8ST9/5LiXrafPBbdJgcza9Pqwng2rk02shIKYBpWHvJNlgekh4dOgsJgp9OUBInPITKTT59h7EUpRzQcI+EZHGN2c0X0IdLmjHKr+U9tlJ7ijbRJ5joEVkb9zFZ4wbJA+B7MFKxNkVWICD9CkeCbsRRfa4EIgyDdTnr1/uXUEzkvvnA3gcTvf6/WGBPoGC/s/oZ/d78wbH9HIK6L+cfd68wGUR4P1LOtOFRESh6SdXzzk46Mg2bPUpMdRRGaFzGKnNGNgdXNksCCGIZAXhsDYkwb60Gy3/mDT6pxTcnYhufUWxHjJ9d1MLxz9mxw=;5:J43pq3GqJuFdOa1/ODOi+EA2fwog0MDn5SEHZwZgnz2gMDOoVJWi1zmQsjqMSMqOyMgYydhKwW1Xs8jd0POh56vgm6/W/k6bw7ZmBxxZfEzIIEsUOgKh5VCp1cgAprypvPKjZ0lpm5ofNXM9BkkKhTITN1nN6dB8jOQI1uDeqxk=;24:lQX3vfKz3y7fGNUv0u+253Bv5hpgeZNd1dfNNekjqIumNkIh/4mkw7OtM9zWEajnZCNJAIvIoKj7aXzyVpsA4Ev5peyG0oNX0QCYUV4WUWA=;7:QQsLPL9OSryUVJJVJkWNO5sUSjJrQsc/jBFzbsy0XbLyPwZxZ9rkXcf6JaTsZQTqDgmc7nyDrCdIG7JUUped6TBy11xaQHofUcBxWU1gdJqdMYGZpyf2niuqdejXHSjC7PNE5UQgq+PhXHdJ3LeNjx2RyBfX+7eaf44O/CB1LT/zlT0c7pPJ8r+vegeTRkNquhLNDSd0z6lFj3CNnPFtLQFwF49yn7Df2WzIaWBqWhNnMWUhdrt7X/CC7IlO1zRz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 09:32:39.8497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c4105d-19ed-446e-8daf-08d56ed6e5ce
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[192.88.168.50];Helo=[tx30smr01.am.freescale.net]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB466
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuantian Tang <andy.tang@nxp.com>

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 82b272f..15421ef 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -70,6 +70,24 @@
 			reg = <0x0>;
 			clocks = <&clockgen 1 0>;
 			#cooling-cells = <2>;
+			cpu-idle-states = <&CPU_PH20>;
+		};
+	};
+
+	idle-states {
+		/*
+		 * PSCI node is not added default, U-boot will add missing
+		 * parts if it determines to use PSCI.
+		 */
+		entry-method = "arm,psci";
+
+		CPU_PH20: cpu-ph20 {
+			compatible = "arm,idle-state";
+			idle-state-name = "PH20";
+			arm,psci-suspend-param = <0x00010000>;
+			entry-latency-us = <1000>;
+			exit-latency-us = <1000>;
+			min-residency-us = <3000>;
 		};
 	};
 
-- 
1.7.1
