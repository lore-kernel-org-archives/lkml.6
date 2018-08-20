Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1230C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8785620896
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ty8RoTGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8785620896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbeHTWJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:09:03 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:28224
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726734AbeHTWJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr7jcIGI85ThC2fGN0WpILM6b88eWXTI5WQaWogkENQ=;
 b=ty8RoTGCzAz+zazA6lH7NWJBQjX28mpc9s3B+OzxLOWa7vWU1GLtU1T3n8C8TSa7p52kcgPJFhps+q+mmWejJ0cu+3WSxxXv88XxKiBKgODXmdDfZVRu2aCRHuOwq2ZQRW4jZyn6mZvnN5pDBXfkOxpdAWCqjfLjoLcG5rX86hA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.142.187.166) by
 VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Mon, 20 Aug 2018 18:52:05 +0000
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
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Tang Yuantian <andy.tang@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
Date:   Mon, 20 Aug 2018 12:17:14 +0530
Message-Id: <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::30)
 To VI1PR04MB4799.eurprd04.prod.outlook.com (2603:10a6:803:53::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c668b01f-5016-4eec-9b88-08d606ce08c6
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4799;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;3:Hi+wpwDrq3NQvUvHDhqRb39bdwjJ4IYSoLIBGIs+NC/3+ByhGMNpYmma5EVpmr33VKibM9FC5tBooLTsI4zS2khQHsYX1bd9QnWbgPyCCgH7DURiupdK44xF7f4sfJYe1P4BzSuFIbkwjrJVPms5ia9TsUDHq+oI+InqcvOBl5mxr69v5ariWxjpPqqLF8pGN5loE8aP7gC/1hG/AtsF5ted0lEZGIvKxnJfM3RI5c1umw+Vw4QJyxf5TdPu0Gr0;25:inNXj620YjF4Mke1UkxpgO9EbSlEOmYDKyVk5JEFNX1CiDGmdthFn0zQFuowyxKZFkvZLnSRBUo0PSgywLkU0BsH9xR3hCFbplSu4uBHW6CcekfCdJm5Ft8HI4pF27iRfLUDc8wVbP/uo82db4ae8Jq6wqVKrhRj18U2D/IgFvZ/jGr2ZDHJSEEsb4BNHIbp8IRCvkmbqmXHOF6xmHg7CC/Odfv6pjL4sbYnJqL78qWrWrZ3ciV7czg8GuyQWN/HHeipfpc5evcwMDqM9F2lUKsRl5e45Lz2RcPiSAYD0DLVw5zE7QkNa/ZTI5CDJZZIfo9ABL4+lt7YVs7ewV33Sg==;31:8EdULVc0ePsCNgzzLd+hviwOJKjt1uzpXqSFBaNhOjN66JKPsPz9sfKSlUdLhNrHLfL6pYyPj/FgHnFB99hjq8hHGuxqkMu1WWaIPbOFtlv8xvDoLFFWNQMQVTEv26hH8+pUpCE6ZjQjK2hA9e6r98uVWQsnM5G1YEBX4hxWY/iqH7xyGbLKgTkppo6df88rGCbu9bSdWQB8IzTXpHktP7eJtwKL5bmJyueTtt8cc9E=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4799:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;20:uWOhu1R6p+C3P5x05M8Tzd33DWADY+GhMryQlaf1V5TqtetTbrrFwbaNnJ5H1vBR7HjpkCciyzkntHlOXFrQcnlfee45Yle2a0NhvKBLogQPQR/pAw5rd15HwMe8SMAb5JRxGmZkAJ1rRxLJBbBnN6tA8tp4hkQVFowNVFVRemq98Z+CWgvK7TyAua/cJV3ve/rDAGCdWqR4m+9ALQFKw1L+6Sa6XG8I+6MJ+TrlHYVlFd9WTPNuW/vKmQ/ZbajKWi2m9cCu0+tUMVu9pj0YFrTFThpL1m3mk3CAP3Wmm4rDYYd0B33gH/Y3ro6OetFEOs6FwnTFNd2x91qGmo1c+lutSvqDX3MN0rr6U4jE/YVRwh+hjcqRar1y+A0syBikx1G9JiLgpyHoxc0Oxj2FPGCSulw8naeCYZHOgFSaTp2PT/0Wzpx2UGZN9swY1rqe2p6I/boZdYU/74eknkD41I0vJl2rQtjFhWO0mQUWfIssnZJViYgZ0TQi3C5mZi3y;4:30tGLX06ySk7+tPS5TH4Q/U+jTW5CHCYGD+/TgT4YeWoFIq/lWP4vDtokS+RUudyqsLDrjLzIjtNG4Pl6nPM9zv7B+5Nzy2/s6mevej4sDt22qmqsBPjxUKNVuNTO6QybyQPsKzohiPFAN7l8J3Jp7KOH6OBagSXK1Z4DJ9/5eGDI8rH1Egzj7SbPyS9QTZAzex/HmAt6ZgULSl68KBMnPcbCOE7QCReXikNV1JfFKvliZ9frjGYXvqBszpkRU1bnq8qRNC8dCHc6Mcmb8UvS/UfYi3LQ5lnt2v/mr8jzadXNVpcK5ua8tFZh2IqWOXL
X-Microsoft-Antispam-PRVS: <VI1PR04MB47990FA48013C9ADCA47BDD9F3320@VI1PR04MB4799.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699016);SRVR:VI1PR04MB4799;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4799;
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(346002)(136003)(376002)(199004)(189003)(6666003)(8676002)(36756003)(7736002)(81156014)(81166006)(305945005)(16526019)(186003)(26005)(478600001)(25786009)(4326008)(386003)(6506007)(48376002)(55236004)(50466002)(106356001)(5009440100003)(3846002)(105586002)(5660300001)(44832011)(7416002)(14444005)(6116002)(51416003)(52116002)(76176011)(2906002)(316002)(16586007)(54906003)(8936002)(476003)(6486002)(486006)(66066001)(47776003)(6512007)(86362001)(446003)(11346002)(68736007)(97736004)(53936002)(956004)(2616005)(50226002)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4799;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4799;23:uKJVNZ5JdUJR4S3maF7ohy1KwBYYlHJ/+5HM/6b3Z?=
 =?us-ascii?Q?KM57Y7obP5u7Ds7V5rMcvq8b1TB1ncMvtnoyrFEx0JAB89oTmGwhRZ0o6VR2?=
 =?us-ascii?Q?1CwmMrc+HR4My6tCzLKs3v9tq3POZsCEppqQvb8r8hpvkN0h8CDBsof+3/US?=
 =?us-ascii?Q?s+p4AZQyz+By5OWstk3dAhBIs6EQFiv+sA8dQ6OGaPNGW/5/UBMmBmdlVfJC?=
 =?us-ascii?Q?TKUbp0tYlZuz6zyGVFnI0+r22l1j7tIAa2PwhCTmaIMqseuE/6bMhgEVCHst?=
 =?us-ascii?Q?f2Wc+LOYKbOCmHmk07uw+aHhlRy1JohPzl6rWUDiGq7Gsz8UIFYGjPIRXVNq?=
 =?us-ascii?Q?tMcVHGKZr/ebswGCAV7fwdSueZG4VFq3QXrj5QJR6tFB+xY+p6CnO3BG3S2T?=
 =?us-ascii?Q?w2iElXBcV6KKcr90IhFNd/FK2G8/aU1b6BIrbTTGbLz3GodNWf0Buxj42nPO?=
 =?us-ascii?Q?wprF/aorChsdY1dBwxGj5QGl4r7yIswh6igHGXZoOIB1jiLVjGtX+KLyEESO?=
 =?us-ascii?Q?WxK/GuhIOJ1iafXZZTJJaynIHyZwCm3CHeKBthlBb4nGMA5jvXZLEYL1wbJH?=
 =?us-ascii?Q?fGzoOTB8TyaHNc8hVgcHMdrjbc50+RworgxP5gRmuOKshoUs+kocylknluzq?=
 =?us-ascii?Q?lTQybw9ijT1sGzLFPneX0xwWEHOc5mYaHDWCfiHGDjLwLV7glRKWMpu/y7h7?=
 =?us-ascii?Q?NSHhOsKq6Hq9Tq/FGziC9eJpnGVgv3ie85v1SZo32w8yX7g7ELPrViO4fX2K?=
 =?us-ascii?Q?SnWTkgu6X2vKBJs/Q1fpR2+1zLSHtAasBDAU1rogSSuiiBLhd6JMrEnSqU1N?=
 =?us-ascii?Q?mTgyRnO1aWii8jkDc6LIgjdzcV2LxApxzBsb7y2LWAsCWc2yamw0uA4p/PW3?=
 =?us-ascii?Q?NaowwQa7lT+tsj2iyUC7ekKDMUDQwhvKB0DO/1JsCxSVEfa9NI3SwnJdjCPT?=
 =?us-ascii?Q?BqyPzsbZyDZ4ymr9UflxuYsXdD92yJIPoAMI9y7MCCnzPzAkGk6bTcRAzjTu?=
 =?us-ascii?Q?9K97jU0kR6yWYYd0QuoZpOq012PYBsuHzyrUQmQeWPjhGA12rIwv5KpiLLps?=
 =?us-ascii?Q?XZWkIpedsSE6FQnSM7RyQZdwsE7HlX9nWF2LewjLqCeMhb8TkySIWdjquabS?=
 =?us-ascii?Q?45hnhpoR1kZrwBItWoj4E28GNlzImhrz0K0O8I5dXM66jxxoMYg55s9k7b78?=
 =?us-ascii?Q?Stiun46MyTdGBr9WzFqg7dNrJnUhSFbMqaiCoH7ycspWndssNchlkZg3KDLo?=
 =?us-ascii?Q?CnQ0iKsd/H4zulN7WMb7x8vx/f9PUTSSLn8xewkteXvG5M6rmjkVGMT5zADL?=
 =?us-ascii?Q?FnIf+mdZu1L3A7oKeF3BoKTyB5zqDNBimIypugf3GLk?=
X-Microsoft-Antispam-Message-Info: j/nF7/QyEKWegNeCiaZ4OJtHFv6uHrPyjneLKOdDf8pcuulIs7Lg8vl9SQ+BNo96I+j6mOVFkA5dAE9hok7jJHIq3OoC15TFVNHmiRUwo+VDWlJPQ7d0LphM3p98jfvOurIHiGEhV8P0tpAxC8lizHmLS2SlzBp9Nsjy8RVuxGan70xqZFhD57liDS2CyRLlInL9rvhBP6ZaC/pxXsgRDDNAdfYew7sOWW0Rvmo6lnaDi0jKxdxRRTNj7X2UWNnB062hyGQKemAFpfkcrWjbbERqElHZ1+Sxb/AXOTC1EOop4HYdjGKBd3fGHPIZNmlgBxqq7/PDkMTAG1OYuHmIA/PpktPjl0+ewHL34tldcNI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4799;6:4L+8j0wVzNiwXpBw6puxeQKr+Jj9SrMrr8an4sEkNsvrI1EfZXZWI5+BCVuIURFOlyase/iWPWEi2wXM7iAnD3k/G0USFhLGAZp+TA025ybJtDo4/jlxAQbwBSYdNvL383TIN0kUpGoXhrmxAIneng4Vzs4q68ulHXOfFywaSLtMCaAJ6cPX5Q0HNoiPSjt/cqHjb0PkvjPIWAG1g59RawK0Ol5yPqabUJIaMgYlBUzJKVJZu1PhmNpIRJKGxkwXQ/nB3AkNjVSP2kSyBPLpgbyamAJwM3tzpz7a8xdwWkz6tzZlyn1wvL1v2+RPcNNdMBufXFNTyLTQw4UanXFgWP9VgNu/PFrgNN+a7ENfpJY8IdhS4TBaRcHARPTfeQ2OnyZtD1J2O/BgdZICTpbVlSj2eAxFcv8twmuseBg7eoMxqmJqwPFk4Ng47dYVFWz72NmLbcaWmGpzMXU8RC0MGA==;5:pVtsjsmCX3VJaXYgYheSanYWO5sqpkv22ZLEgHsC7D0Y893qtvFYZiImVn0A3b9u0wk8+FouAAmWcZiolZ0GxWCsiZGTFygNotj6qrpEPb6A4PlvbMMhNyzjrX8w/FBJk14GZadzYtZfEAVD64LaAO2jDnCiOijFXiMJBKvugwY=;7:rW50b2jDkiSAfnWw27dhWs7Pyq7ubUkbp5rBZ3Ze/BLhsr1l05xQQ+WXMgNdXBrCSS2yubFN1iQFsR/hTKDygld7oi7PJAjBbBo6mKN8ws8QveVBVwfuUnpYAmcq5O8isBlyvp7ybEaMcaHcmYfx3rNtDFcHun+YJUyZs8lrwDPyxKD/po/sKxtri1s5Qz23LyUHttSOXpeUp/rNT1+d1anEmo7ftAoZLVPk8gOtl8mvfV+k94yEeyZJKyCQEsHN
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 18:52:05.9608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c668b01f-5016-4eec-9b88-08d606ce08c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Add clockgen support for lx2160a.
Added entry for compat 'fsl,lx2160a-clockgen'.
As LX2160A is 16 core, so modified value for NUM_CMUX

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
---
 drivers/clk/clk-qoriq.c         | 14 +++++++++++++-
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 3a1812f..fc6e308 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -60,7 +60,7 @@ struct clockgen_muxinfo {
 };
 
 #define NUM_HWACCEL	5
-#define NUM_CMUX	8
+#define NUM_CMUX	16
 
 struct clockgen;
 
@@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
 	},
 	{
+		.compat = "fsl,lx2160a-clockgen",
+		.cmux_groups = {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group = {
+			0, 0, 0, 0, 1, 1, 1, 1, -1
+		},
+		.pll_mask = 0x37,
+		.flags = CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat = "fsl,p2041-clockgen",
 		.guts_compat = "fsl,qoriq-device-config-1.0",
 		.init_periph = p2041_init_periph,
@@ -1424,6 +1435,7 @@ CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1046a, "fsl,ls1046a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_init);
 
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3d773f6..83921b7 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initconst = {
 	{ .compatible = "fsl,ls1046a-clockgen", },
 	{ .compatible = "fsl,ls1088a-clockgen", },
 	{ .compatible = "fsl,ls2080a-clockgen", },
+	{ .compatible = "fsl,lx2160a-clockgen", },
 	{ .compatible = "fsl,p4080-clockgen", },
 	{ .compatible = "fsl,qoriq-clockgen-1.0", },
 	{ .compatible = "fsl,qoriq-clockgen-2.0", },
-- 
2.7.4

