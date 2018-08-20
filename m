Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9970FC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459352173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FQoLoFbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459352173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeHTWJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:09:12 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:28224
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbeHTWJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cISeDrFCHJNFl6ZKOxQ6LpMqGFhXy3Fhykj8Cjjsw6Q=;
 b=FQoLoFbgLY627KJlBQXJb7HBnGWrwZteNHkYXfGAfQ4XgtUfidqAr8sfgUH25K7Ca9Te82SOQ2QjqW6gT34lIXxUgmRy6wKuU/7qr4V4iTnGu8cp2FcUweWNnMgRBFIk25OMPm91EcaP1LpCTodhYSHU88moaVViu9PaOWVlBss=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 18:52:15 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        kstewart@linuxfoundation.org, yamada.masahiro@socionext.com
Cc:     linux@armlinux.org.uk, V.Sethi@nxp.com, udit.kumar@nxp.com,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Priyanka Jain <priyanka.jain@nxp.com>,
        Sriram Dash <sriram.dash@nxp.com>
Subject: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
Date:   Mon, 20 Aug 2018 12:17:16 +0530
Message-Id: <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::30)
 To VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffb3c3ca-ed41-4a82-8919-08d606ce0e90
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4799;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;3:OPmHKD4gCQMXveMHzhmvJ46fFbGzQnlRB+35rR4IzeL4G4D0sfV0OsMt+0C+EcHessM4HeCen9i1nTsOQ1VarjtszSLRCimRH2IkF283bIvckOiwJDFG3La2dnI7N+jN9kLA0TluGNsrv1hBsYvE9LgXkYYIt3+oAEGr/38L1hocFUD82EKI5s71NXJnaDNO/Bh1ty2ZcyPv4b0M5Cdnii2q4ZN8R6xC56jd8nHi4zhKkXIPXLMKWCkHLLx6FOU6;25:PWQpHSyCdMa9Noy1zOaX3V0gOx9+SD6cOZiPI6WJ7D5aeZWv4XcFWCzuFvROXhM2XUw2KNovPiZEb9qsfDA3oHwHXUhSDuSHm4cTJ9CoDf5n9cl2LrUIivXUmwADRiJ4M0h0/ipwndqrb5U3MLiIGf64pKiakkRMTg24IXIy8zpmmflm2yxziauKj+2ByhdaW1xIOJo9RDCFheN0xMCE9GnpEv6wFQANiKkLbDXWwYrnNDVib+6wFuQzXkq1WqbTliuNJriEqN6qRBoTrng3mOKzcu+iPiwhoogCbocmpkNbEB6mzjXcWSBvh3DWoygUYdqFvOTJThQwO/Nkzo9hVw==;31:MGx/lquZWNFQU+hihP9AGlRmvQ1WTwO+NMFbd57HmEblt82aU+A0IExi6ZymvluAeh+IHMOtkH+jt1wKd/qtwEmp6zLv0eHc/fRzXmQp1v5HJVHCskbFzDip211RGdAmKJepemjRfje/5nZNCv23Z8bW9QalFzrQ9N7z4pSfkrLxkQCiN3G+Am1CqAUfV7H6Fd54B1PCNTNHicjmlavv8Hvr8R3xoD4IOoFvoK9hqJs=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4799:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;20:lE+sGdW1lNR3pY+O+x7aSjd3O34CqwCzBAyI3bz660EQqiD87MZWYJwfNZL1EIbxYgoMN3nHZbrBhsjjewLraFnuMPke282gw+L4rZuahq/4vZmFZ7oAXbJAiBL5RjHKKhz8hcvoFT5vSvdvSquEhuQ43Km1dpy/PjF0u1FBeAUsmQ+Q6l5XpwBrXUYktuZ5XFxcY80xqQ4pXMQf2nKES58OpT/BFqNrw53+6YUkVL2JE34hVN43mdBPYry3fAoGh/zpMlRqkoz+WfSO3qxKki+iMvtSyx2/3mgpBSzi/5QlBLbBJAGuaPRtgZxGMkgYpJLWbfnX9Vkhs1wFCPn0ckm7oTgMZqeIu57GjSMQeihYEzrR3BLOeVc3WzV/s1+LqMAqDyRMx74lYLuyQbXiA7GcLYSh2uIc7C2PUZf83++Q3AiqUk4SEK8xSbDcpm72L9iUSjPxvokiYkrxeo9jDVpEe+nnFtnon2qMekg29OkOVMG1LyPp2XAP2pdBlEp2;4:N7RCPmn8k6HpZP8ZcLWmRVPZmmTOUKCFSi23m9pyAUFm4prXqpRxnSMIgtGXE2A7UYCYFtZi9olNv85Ig06Cq0W9JBveBu8Tj98maQqTMeKHAT5MRbK6yNieAA41eB+MwbZhI7aOcoUm8KVDQVpSBojBmjFFotnZNarvNT2j90OWPZKRYGGkdn7eYRtNYV/Vb1y69Fai80AHMb9c0mGzeeeO3bLakbYYHRt47M0U6YeD69guOMfAMedU7buRDFFzlxcWmjEOPfDKLUW3Q+ZZY2QEqVWOU+R5/XoYLwtLmEfMXP7HyOfiJJyVH2YL/Rzz
X-Microsoft-Antispam-PRVS: <VI1PR04MB4799CADD87269C2CC314BA36F3320@VI1PR04MB4799.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR04MB4799;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4799;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(8676002)(36756003)(7736002)(81156014)(81166006)(305945005)(16526019)(186003)(26005)(478600001)(25786009)(4326008)(386003)(6506007)(48376002)(55236004)(50466002)(106356001)(5009440100003)(3846002)(105586002)(5660300001)(44832011)(7416002)(6116002)(51416003)(52116002)(76176011)(2906002)(316002)(16586007)(54906003)(8936002)(476003)(6486002)(486006)(66066001)(47776003)(6512007)(86362001)(446003)(11346002)(68736007)(97736004)(53936002)(956004)(2616005)(50226002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4799;23:pUJaITRAOBkBHfwSW72V2qb0x8GfwV2g2D4SpvQKe?=
 =?us-ascii?Q?PtJfYN/PoiOJ5B+zAEItAMApP4fowlrJKZsNoWnIVdd2wST4n2wigN7uIZfv?=
 =?us-ascii?Q?e59nqZtQM/9ppZ9Bgd4n7dzfB4Gr8g7+Bb89WYjH2b1FGlGvYAUzY786nwxk?=
 =?us-ascii?Q?dxLbgW3fXMydLM2Vry/ohJmriusIYQjqryS27fw0UXFRGeQdMVOJ5w/HS5Fh?=
 =?us-ascii?Q?trakBkyiEgn3PeulndeULctYo3oZMIjkfPELvb0jvQv4DEHRnmKXgMU3V4WW?=
 =?us-ascii?Q?8d6l00/9X3zDIBbv0iFOb48HBPon6dgmbX6uBRrn5H/75tPsUudbnCf7GzVp?=
 =?us-ascii?Q?0sr5pFvhmTV1Aesup0oAL0ebCuapxL+GHHj2D2lIlc9apECgKWWCwUkSQ7rd?=
 =?us-ascii?Q?Oxk6CB6TajVj1FYznAZ5opREYGZl0CGcpSgi3Ex/URBngVbr+TfPcW9QZ5sX?=
 =?us-ascii?Q?JCLSa5bP4XC9qzc5X9YfTTEHEWaGkr9AvIeoDIGGiCdc3Wwql0QOBZY1xBQj?=
 =?us-ascii?Q?4iWV7fgCx99HsAfcH1e7FKpmpIHXDco0jUReLKNGkmLfJUHQmjRkkazJs+na?=
 =?us-ascii?Q?KIaYtGu6vr3QfRF3i30tr5biMeOWZm2KuOWoujPQ9hHSaMF7z4kq9Y1GWhtx?=
 =?us-ascii?Q?isheFUmkA4OXjPxk+bv3kdgUKgwRMLkMjY3WtooT566N2PpBsWgDHt7TDoer?=
 =?us-ascii?Q?fFA3+OPLGlzLJ/TBDGEBcwVkWI3Hs1UpFzR2mXFQ3NU3IylUwA0D4PlGySWV?=
 =?us-ascii?Q?Ms0dpQapjZ4p8+lnVxwjzNtEq236mx/hlBcUPsSR/xlr9F81NAZYHu5UK7o+?=
 =?us-ascii?Q?LQ1DNkg2xvEUJeAUBp6t+HWuZuheA+pKLTre8uLX/zvffutDffOrf3V8/lVz?=
 =?us-ascii?Q?dIT2yDTRKmQUpaQWe/JaLgrAk0gKIwUg0Q2z4C52rraYwcipGd4tWm7I0LKL?=
 =?us-ascii?Q?wFVI8bZ+ZOOu3KN8sJgKikrUrEWDOx6gMVyF7SFx4e9Lp/1oJnEXg9Gsw/6t?=
 =?us-ascii?Q?C8THt8c/y0tA+Ha9V+UOkcGYhmXcjgLOq7tUx68pLWecNyf6NLk5hPTa8TCF?=
 =?us-ascii?Q?2BN+LSytbNwUQ9zlZ2QnoftUQ4kyg1aLn0P0GHIVEo/XsTTbYkvpcYzjwlLC?=
 =?us-ascii?Q?+dyYAL8josDet0cNMo4MWuNeoCQzNFQ7qFDPsU2Ho1RWlLkxLisaRN6/ko7p?=
 =?us-ascii?Q?KXeDRYU92eehUN8yh/VzsYMxF92kojaGvtZ5UzitJ4E0PC5kv3zd4CD8KNJz?=
 =?us-ascii?Q?5kTZHxZXzhbzFewD5p3V/XqTS1ixqUkFCG+BdlD2lX9kQF1Eh95fZOrR5m0r?=
 =?us-ascii?Q?02viPGu1Pm050MoIsocTMg=3D?=
X-Microsoft-Antispam-Message-Info: hk8PgVwl2UJgeAfgZEKGIAI065iGSOuTamLvCmwjx1F+dG1g+uAO6L/eX+/fyKqISwWN9jts+UOql3N9jpkWovpBPaTIz8t01bHrGntwreA1bwX/Ia+L//TIROqAOIWQmWpYo152JJetTXjVnBNpMZc7XZlwn/JAXhWc2q6Qtd/5siXV6O66kMWfDZjEgD9MxWU2NDDLC7VvEuP8GYK+hBAyF7CWbfX9twvLnV0icO570ZuqyBJezi3gYxfafFdTW66EMPrUQ/tAJaAjo1flujTnvKaqTYtFhpkODF5jsy1Lld3cl8aPmbnkRJlqNMimW2h3BJExiUtPYkULJ/ZONwvJmVrEgVrKg06Vm2cDxSg=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;6:3pp00Iwu7DXrhSFxqlzMe+gjjD3c/+h9dQT7qmp8HGdLQVThAKHeEj2g5zn9SsvLV/wJjLyFDg/u+OgtHkrbshdvh1H5SWMBkabb+AbV0uGvP5bm3cHGB70S+89SePbGTGETVvbxk0xbHr3gXSQI6EqETeLjVskK5wAPN/bfRzlSMJ4QZi+XmBsdNrlDW6D57brHkX3UQqnsDX6fl9iMHD8l9Hs/9HpMevJKraBuoYbTkRqAlYBQIgdvGL3AgcihTDi5t29Zkgk++lRoDyXU4BJT4I18lYDPlyCrymwXTFak4SRKpe+lpvgU8raTDAO6+vedCcVPo5EagW1xzkWGno29PMrc5UDjeJaYGSCK6Tcj7N/TrWIMR4YBL2TNsd0ihWBhUigLPdCmpy15uNYKuiYZDX0dOAH67EZ8gh0NauRgo1XbI5PHeqtHdh2sj/pLGFmHqZzljQM4sx5s+Sjy2w==;5:UmJs/hLixna9w5r4W59hdddNLFoOQ6E9Yzt0EvdwRUAzGSt4I6RcQehMAIXYBsge+fTJGn6qBTeQQtMHpD4cKI+wM0xNANBydKw+QThwOxITyBbz9FA4fRB25DcdJEvi2NmdLwyuKhiSC4kpIIPBO18kyGDBJKnvr138oaQw+NI=;7:bFvaVJaZOw9OLPNBRnPOJ1rg1j7lr173zs0CLhPJTLGtTm2z7j9fUk0WoUItxP9HPKs3dCVOJAu2fPNQlI3crzuBvyRY+SDkkZ6oI0rgvzkK3/ABMbAkk6u+0uxXis7AVRdj+TkT8ncdtzJdxIkjGvp+bo39AIMzWaLSO4MbqG3bzVnGpQ0TkzTl+suuQRCUq+/SXIasImi6sMYZY/nzjnN5X8LmUzPLiKyfRI2UvgfW6AQEHv4et1OPf7axbBDU
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 18:52:15.6597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3c3ca-ed41-4a82-8919-08d606ce0e90
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LX2160A reference design board (RDB) is a high-performance
computing, evaluation, and development platform with LX2160A
SoC.

Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 arch/arm64/boot/dts/freescale/Makefile            |  1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 95 +++++++++++++++++++++++
 2 files changed, 96 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 86e18ad..445b72b 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
 dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
new file mode 100644
index 0000000..70fad20
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Device Tree file for LX2160ARDB
+//
+// Copyright 2018 NXP
+
+/dts-v1/;
+
+#include "fsl-lx2160a.dtsi"
+
+/ {
+	model = "NXP Layerscape LX2160ARDB";
+	compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
+
+	aliases {
+		crypto = &crypto;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+	};
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+	pca9547@77 {
+		compatible = "nxp,pca9547";
+		reg = <0x77>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x2>;
+
+			ina220@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+		};
+
+		i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x3>;
+
+			sa56004@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+			};
+
+			sa56004@4d {
+				compatible = "nxp,sa56004";
+				reg = <0x4d>;
+			};
+		};
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	rtc@51 {
+		compatible = "nxp,pcf2129";
+		reg = <0x51>;
+		// IRQ10_B
+		interrupts = <0 150 0x4>;
+		};
+
+};
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&crypto {
+	status = "okay";
+};
-- 
2.7.4

