Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD86FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E6E20861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UG83KXmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E6E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbeINN5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:57:03 -0400
Received: from mail-db5eur01on0069.outbound.protection.outlook.com ([104.47.2.69]:15280
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728090AbeINN5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJxBVkwijO8ByalK54jT/Jq1f2jwlSlaW6F9HsEftq4=;
 b=UG83KXmRY190tecxHafG27Vt3RGC8Q4p5zoR9KOeO9IzmB0pxMn7L0Qc9BMWacOJFwMZiKfCXRBB5rQJQ81vxjmMkeQz64gfDR+roB9gBkseRXiRqmva/iDXkKohjr55N90aa7BhzWpuC01TIrtk7cxwh3P+zxzIWon6Pb1OVsw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4800.eurprd04.prod.outlook.com (2603:10a6:803:53::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.19; Fri, 14 Sep 2018 08:43:21 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     sudeep.holla@arm.com, oss@buserror.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
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
Subject: [PATCH v2 5/5] arm64: dts: add LX2160ARDB board support
Date:   Fri, 14 Sep 2018 02:07:55 +0530
Message-Id: <1536871075-3732-6-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
References: <1536871075-3732-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::23) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7da8e70-f43e-43a0-c710-08d61a1e22fc
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4800;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;3:9Lav2V0jF78dSs69EFRCONIUGV9XRJRzPW2wLyBo0f2Q6JD78r5tiNDystfcBFstyfFW70U5puXTTnmQww0akC228/hoGaSS9hm4yosgT3xjHHGGgmSUZJ5iZIfZU2In1FV3oxaNOgLLuGM4RSfuEgZqnqJvoTaF0MGkjSLtG6HHjZe2YJMu5SXYKXOu4+OYw8+CW+f8umErrYB8Q57YPEqiTc3kR9iuLDAA3vDYxR45xJwe3AfRBNdVTk39+KoI;25:fl9Kfn6j1LbHnpC4lPpj1dffKxWAMOKCtS7TnGUwEkjZt8GweACKfgYWTyC7QdZB0tgA6p99ytHsHjZ3UHiNQhHCxLI6okhQNvljSo+jsVlGQDXtWqnIwew+ogG7nit6P6+0oWdF+HyBXnARRUpGGcPjyKhWIIG/8SB/ASVrFBW8HNjpzfE/O6GvMBFbrBLP0Bp4kffqnU6zsI3DDwXFzqzzfsoIMfPOJtTIutjRi/ZjPig6Lij7UcL22A+CHYc4E229UEaaOezYKU8b9DdiwZJmACjIwlUgg1m67CUd2YDn6bHpUJs+SRwlWfl6FfmZU+9/507HvS0Zq09e3adSCQ==;31:YyDgTZXyGi6zR8GLHgErBGX5r6TdEIywdyFhPlmB1P3U1eg22MwK7R2T25wXFoNrVjhQFfki3cHVJltkAxzHwt/CIVqlUGJxyuAi5fYMLREhfzBEuBYx2V1Bmio9YQuDt2/n/hZcK1y6hVChAv90MmbrVYWumnnDi9D6V5cat2IGv6JhAEjoefLdtFhm789BTBRWBUALWwLYpV0G2evCGhBcxvjGVGbZXbX2uUErWf4=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4800:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;20:gbThAzYpUzzRfmYGSwncHaAbgAq3Ne/roj4Y0Wkpjb9XnfHyRKhrKiNVk9IHlKDuCguVndH9Wt4sS4RfWIhh0VT3UUWIE7tBV2E3fggH2xdERpaWBZPTbl2NTPm4uQFVhjQaXtZm4a6n6Lv5IZ8du4HZMx2YuhDqYwN4WlWOH415YORAs69iZtuBvkTPEwrfb3M01bWw3UuF6ww83fBGwHv4MvzZ1DuNlGq4HRowXKLygGZM5xASt6AUBd/mimlgq/4tbgD2qzpmfGAc59EDLAmQpdWrnmJJvq8ZFvnQ2NsDxtLa+YbPuPoJIHDGx8jf2cGACPA3dWYdaxhqw/kkOu22L7s1VMPfnFbsAWVpWDYJ4/ptX6/WtAsCdgmnUTfFdelTcWUDGmK5ydYJV0l2TXpMnFnkgs/b0z+EEphDRnbm7/eSgJG993G0D/Vd9UWTnMWPcZ9wXAUaJEJdqJeeYrBBfDNKNUjL31riIp1eOxhbPWv3FD487vezfl6MzQ2P;4:XeiX+F8MJl4j0ZJ8KBfvIwxUPd7nkbuV45W6Aw4mUwnig/HaMNkPB/te3QuuRnnDRRVz+gaX3IDykpCbbjeLKOCYWbYwGVtemy/J2GLYgv75pxvZnp7Rns+vx6zDDKRccNiiYBECf+aO9CwMKtGvL7dY9BOzrcsUF1oNV5rYPR+T6vVzZeByHSnm7UecSkNWi9FhTE9p4tj/u/ooz8BZ7FlLEhn/O0te/HD5SlJYnD67GRS3t7x3nVWlknpwFGHN0BkK3aen7HvGARlwxu38tqYHZlfSSy58Mylw2LgPLmNW7P9Z7dgbtkLf2AhedI58
X-Microsoft-Antispam-PRVS: <VI1PR04MB48001BD34D8D1BB5D95A9986F3190@VI1PR04MB4800.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:VI1PR04MB4800;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4800;
X-Forefront-PRVS: 07954CC105
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(7416002)(305945005)(7736002)(51416003)(2906002)(76176011)(4326008)(25786009)(36756003)(68736007)(52116002)(54906003)(478600001)(47776003)(81156014)(81166006)(8936002)(6506007)(386003)(55236004)(6486002)(50226002)(5009440100003)(86362001)(66066001)(6512007)(16526019)(105586002)(2616005)(956004)(11346002)(186003)(486006)(476003)(6666003)(44832011)(16586007)(8676002)(316002)(6116002)(3846002)(53936002)(106356001)(48376002)(446003)(26005)(50466002)(97736004)(5660300001)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4800;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4800;23:Xg/snD2qTaOCe6NHBSvduPnRRvP8mQKLqdztemOMq?=
 =?us-ascii?Q?9VJSuIZ0iURsRnjgDkU8KHRdI2ZXeUx4/IlJxuRwEzhh1OFdEF/ObH81Li7K?=
 =?us-ascii?Q?Xeh/IWWbWjJT9pFOnCaWYghfioSMtUssT6hBu/pu4oI6ubHLUaGqgk9mZIoY?=
 =?us-ascii?Q?c5bbzpjOXDJb4eQDkhvGAkHgA1iiFJX3LFwkbHoZH8skbFITOU/oi8cWpPXu?=
 =?us-ascii?Q?gA9qZjHrZ9t4dP/Ttwkzpiw3JK+1wrX9RrCCqwc9xPj1t7/LbVbAm2RWSpcS?=
 =?us-ascii?Q?puZ+pKK1iSXgtRVLec6nczShVev8Gm8Kg6EAEZ4aLFScguBPN/ftbNE+cvrP?=
 =?us-ascii?Q?MCgs2d4I+N6GqilNkiLsHA6u61Iatr1VDCzhwlH1JJTwU1GJ7ebYPW0/I4qG?=
 =?us-ascii?Q?ZNnYg+X3OhWt87a2vpztYXsTEUFgP1QLMCFCeaGOE6E9PJ5zcCxHZ+kl5hPK?=
 =?us-ascii?Q?Jplf45WlZGfVygzeA7Jmlk1v6VXeyK/5HwcXwglU8+JbAzqJIdKxAeIST86B?=
 =?us-ascii?Q?o+R8ODGfp4bwNiEzQbrNSACCsMtE6yLi5Nm+pe5aFGO1QuV48k24umNnxf/k?=
 =?us-ascii?Q?mU+qC6n7ZhXxPdTd+2VdzfDZ+EDzMgXFsH/oNwu/W4to8yfHS/nhPY//gYCC?=
 =?us-ascii?Q?8CkpC+fiMUDuQG/jhzub2oDvDXOmAMD7nDdviE4IF2i5m70LI2LkCEN6RJCp?=
 =?us-ascii?Q?f+wwGmOCWd+Zs3HZrjdjMYaNUwJ98lEMoebP5Mk6MH+xnxdBUD7wZOdFp+mt?=
 =?us-ascii?Q?6ju/GkYZCuDsLcWoYd9Kf88/h57gH+qD+HtqiRkYXWV/z/R+ubj7uBK9/D02?=
 =?us-ascii?Q?nmWWahhyFteEkiihFn8hFOZPwDsgXm6F+skV+Lde4Ln1VYhOW87tnvX06q7C?=
 =?us-ascii?Q?3QzFftaXcU2tXYk5zMMY2h88NKuEkYj6ZNzmfJ5uN97PXEn4U5DvCK7/qU10?=
 =?us-ascii?Q?/18hJ4kck/P85o5sVSD8H5BBAhJe11tmFMZpa3FtU6/HxHOp7CQH1RccGsVU?=
 =?us-ascii?Q?2onsodvPfThfVSMnUg/sGT5pNafhho49dLxe4uZE2thgTzbuXs8aadk/LIwO?=
 =?us-ascii?Q?rwDodUXJZe0ymDjI7ebDnxImbRf/Kn1pG8Jvvt+wh+CXpgy3R45p3B/tNFcb?=
 =?us-ascii?Q?fVpuwJ5AC8TKwmPO8WgcLlK0Uly04CZKNYLCUZoquaVLtfyneeZAVnY55FCw?=
 =?us-ascii?Q?Emxa7B8aAIEVO56ZEzvvqwa0gB2yk3GKT8L7SFjOK1jwmxlXjflgyX+uJPir?=
 =?us-ascii?Q?UdPeLfcaMB//JdP3g/hCBp2SR/z26RpBji5cRbhTemc32Y6+6ogOYPZ2uRV2?=
 =?us-ascii?Q?n1kxOXr6xlc9Ke+TcJwL6c=3D?=
X-Microsoft-Antispam-Message-Info: 7J8g7Bl3YK5dpIIAOGLO6KsRAraycclpayTw8S7dJA9bH4dbfpeGoxxQ1fSi0heT+crt097IeqiQi/l9D7ja54MyUz9qzQ1gj9W0LWDix/nH9/PhMC5hix7l6L2YxGRMW+TqfzywbD+SAzivEMGCHKtXViW1UP26pMD7Sx5RobhiMgDingAklVB2FWVY6h9V9itvMiA0TvQmIoUo09AJWs8mWx0wlcYwQDpDQVSsylT8/YVesZ1fdhRKouSeeabGaPlALR8i6WQVcuSoVdJUb1rt/TXNSXTlVKvtBipwR5orKoAuxK5zG0/8ypKB/QzjoKTgkFclY5zSLmWYsZIOkLl1YAmG8hdmsxt7WuDcw6M=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4800;6:dIVELwb+kY3uacrlNksLCuJluq0BKzQPJ3tjg+KBICC7H3vz+JkK2/M3dCVGubsrNLwoctrzfHSKp9wgTdDPu6i/yhC/zPrnfkSBuf3/YsgWXQDq9seqol+1xZkeKgybqSJUhLbkCayjwQhgV65s6wjfOr7vhVdNj328zwhwJM8YYXUBUsuyl1i70Z3PeDYE7kAc+tGj6H4iT+0ZScGBhTjpmWJgeHLSFS1hScCzNzwVm+F0TRZsqPHDpHsGEGLMkf1jYCnKZkusmuLA3nuCTwUv/V4vHfdup6pBz+AnhmO3tVjUC4UOdy4Umiy5iuUwM8Mnx8JhZOxCKwXZ5t9YE6E83vKTer7toMAdJDE7B7Aphvein+si+7nN45vHVkWbC7cX0/0NNY0BY1bMKYA/zWtjbuCe97hRWv3zy6vawLQNQ5v82LWr1GgQuKcACBtSMYzKFn4G5TUkwPSsvJ5YeQ==;5:R3ZpHp9+xCnqC03V4Unz0Qj/ppQ8P/wTGo4t75pizRcYFw+VXrls5lzyTXULkAjUNWD6fqQHM1L6uJcOhwXaFpQXRNpGj59xyVWqB+mk2sge//91j24delRzlTZfld5gpSdTF23pNuQvystcbbfAyWm7QlhnrChGakVwKvlVN/k=;7:6h2eWC9yYbkIdLHOddVZ3cX/rbCtlbGIiRyGEvFa953rCgJhPkXWRkxdjRn3B/JQmWW1JCuUaU/uAniXYFCZCqqp02UC5SDl1qylg4Avf1z8NT2ssoWWl49s6ambv99IFOhSav/d8R0+zR3w+vJxHAQHiUBKAJFjp1rpFbsqHPnYlQTyJrtUFqdLHL/NQeDbhzx5sjq5HFfv5/dbXHPMSBpS4PNLyKYDx7cEY1wShtqhuxoEUouQ44TaLIhnMn2k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 08:43:21.0111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7da8e70-f43e-43a0-c710-08d61a1e22fc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4800
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
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 88 +++++++++++++++++++++++
 2 files changed, 89 insertions(+)
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
index 0000000..1bbe663
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -0,0 +1,88 @@
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
+	i2c-mux@77 {
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
+			power-monitor@40 {
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
+			temperature-sensor@4c {
+				compatible = "nxp,sa56004";
+				reg = <0x4c>;
+			};
+
+			temperature-sensor@4d {
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

