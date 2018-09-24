Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B347FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD63208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u1u0eXvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD63208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeIXSQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:16:38 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:43072
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730241AbeIXSQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJxBVkwijO8ByalK54jT/Jq1f2jwlSlaW6F9HsEftq4=;
 b=u1u0eXvWmqmUELHO6i5Q8fBmpk0eSmEfigppmqoO5tBClOqBMDsW402CiOwLhpDxIw1O9TaT/PR5Gann3rqtYecpjzgfPxhPfDga0i+eu13By5GyzFfw04yWuDbvJ4HK6sSQrelPwBuVOXFhCncfBx8jA+YimEk4VXAVXDg21/c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
Received: from uefi-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 VI1PR04MB4798.eurprd04.prod.outlook.com (2603:10a6:803:53::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 12:14:38 +0000
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
Subject: [PATCH v3 6/6] arm64: dts: add LX2160ARDB board support
Date:   Mon, 24 Sep 2018 05:39:01 +0530
Message-Id: <1537747741-6245-7-git-send-email-vabhav.sharma@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: BM1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::21) To VI1PR04MB4798.eurprd04.prod.outlook.com
 (2603:10a6:803:53::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7358c241-e18f-4456-eecf-08d622174f22
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4798;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;3:fhGbGSy7FIa9ydQsJbQRLf2IdO/yNhPBHB4SS2oLFSDWsq/lgIRDg3q9Gg8JrNC7RLukHaPc61q0NeKMcW25Q+kIgkSMuD8327iZV+VhvwkysrRE1TVCjTgeYtlk25JSeFyWUushIquUlLV0tpt6ehE2Wz/+W7NZdHvi8iqrqIZmYp/HraNolgpU0mkbT8G7pT5+BX6+R8okTtd8J6yMs6+gVqD3V0cCSobiEnaJ0rBZO6SXV0PNL/jMmTduZ3lq;25:tKUeNPrEAC/bemhVSBhFsObz5xlmWuYpcAaKKRbGiOqA5rYWYWVner3iRhpD/XoSP6LyQxi6SX3suqr+XiPVPngXZwqvnGGRMtlwMa2lXSmR5KNPeLbWNv4uvf6jKh750zhTjfzi8UF56cLgVc4Ljs+16AldvoQvvJu0kR9VlgngBNN8yY7821AUg7MCNenJ03R/lxv1Y8fia7iBTciL2bdQgmWPJAOyTXtkLFN9J7qaNhjHQUUaaEWtmeFxioEdrq1KaZIkXx3/bxVg3E5KQmS7kcZ7CC9hHUMD3eGe/CuhdDOz2yAk+kvLvEkmgOabBxIrv7qFjo3tMyzVjXgEtA==;31:OoEf3THIhnr2XSpCNjy0KBENz5aFf0FJuM4m55SBIAjESCTHCqNr0m3ZdJSy3McrHQBfwXlT0WTd7DuVDLoEMV2T9yyoToPjzUNg3NGlNKvQTJjZSu/C7pvOXBpRMiZlp/NCjEkZLSwE6xkOow7858m5fokOB/U/XRQdC809dIjxc38gk+oUJUWhVwiy7/I6EbRcC+Q6CwYCwQvo/zG3J9NsiezdAC3k7kB7bT97RbE=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4798:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;20:1gZeR9TJXMpucMSvwbfxiSJnII582wEkG/s8Pb8Vs2X50cNUZactVNnYIAcz+pny0/1FspR9ezpQ2Bb1N5HT60jFci4Xmgtpb49P5GZZBihQfWjmt1PP7LLcrfl2lYWLahTJDIQfo0ADFvdKTfNOYkVcIiblb9OvZVMFVwJQg/JzgRGaNtXAAEWqvhK1vevyQZwC2/uU6vOv2CNp2AMg7aVtB7fsV0DBOrTzHEGZJF8K8u7kWNCbCyPvuAffbehfxOIHIo6Hdbo9WK9XMMnVYR8Bayeo6tbOQyPeZaP6+lHhIEyM5vB4hWusGAF2ieNi+L+LvHJH3ecA6uE6+617lazsN8Fp4sPiB5fT0LiLaVMJWvJr2jz2XD15YqfXcTPbDJk2vRbikemIRpU7WRAFr0LVbx08i0Ge+kqSX2sUVX9jzgOixLBEn9fa/RylqfIPhX3yWLU8HvwUwFnM4I/WmPX32yfsciYxhHWY0aa4nq/r8DyCsrs0/6I8nhtnvE2x;4:TR+wINvfuBCydEZoOxxBQALSPeG9Y0gCRS5vPl6VAO6muESA+0n51F8X08+JcFlHhceW60ApePuXXNtYtTYUTnVyuZw3uCXqEKxjcBnEP07kkHNVaiKYaTChR+O5ZbSyjq3Ec8GXs2sdg0WF5rVbs4A1cPTSsURCURjXl6mAaoTnG7fxMuDMOC//kQvTxAXs+1FklzMHDUO65f/lTgnQ+3UkqFcQ5glGI041sbr7NofmJFX6yk6OAcsOhBwo8ffty4wLU8WSYgw89jnyOfpuwfjhj/N54HhWIJGXOIx6ACh5gNTMtseOm8CgDWsBasM5
X-Microsoft-Antispam-PRVS: <VI1PR04MB47982068ED0B51B86C255557F3170@VI1PR04MB4798.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB4798;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4798;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(376002)(39860400002)(346002)(366004)(136003)(396003)(199004)(189003)(4326008)(97736004)(5660300001)(6512007)(48376002)(6506007)(86362001)(47776003)(53936002)(386003)(6666003)(25786009)(52116002)(76176011)(51416003)(956004)(50466002)(186003)(7736002)(54906003)(81166006)(16586007)(7416002)(486006)(36756003)(50226002)(6116002)(44832011)(68736007)(5009440100003)(26005)(446003)(305945005)(11346002)(16526019)(2906002)(66066001)(478600001)(106356001)(81156014)(105586002)(8936002)(2616005)(316002)(3846002)(476003)(8676002)(6486002)(110426005)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4798;H:uefi-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4798;23:jgSmkIUHXj1jUS9lR9i8z93nR/ntYEmchST+DuOkd?=
 =?us-ascii?Q?OuiIS48lJqmiILmJmSTCuRaNLPLuakypLbT0rVesLBbGBvMHQL2PQSxanBUr?=
 =?us-ascii?Q?lNR9ZeQdRGOfVr/RiEDV5vNTVPimjYrZ5UOO18M3K9xYjE6LMDnP18PAVx1c?=
 =?us-ascii?Q?6SEC46Y0qK+Bc6AW9C03d6za3oTcbtPCZwdi1Tq3hvn9UWSdi+ZV3GYeZ7BC?=
 =?us-ascii?Q?Pslqqn799YosNJ9fRn9Y1XEufsvNoXVcfiBQX+MmKTZIa3qI4pxeKspNtDHX?=
 =?us-ascii?Q?cdIi49JxdVZ0VS3seaEy9Fxg8vkOtBOJmWvQHS1ox/V/bAtv5kN5BzdyfnbP?=
 =?us-ascii?Q?lDLIJfosQK3Hagzw1iESC6WamejZKXewclv7ljvV6MBapwdbshk/W0vue3Rn?=
 =?us-ascii?Q?OrkhzZBkkkDZUyHZAMpUZY3yqa/bqGm98fpleRDvFSIH4g5DQ5f3L+vfkwnf?=
 =?us-ascii?Q?IMGSUWliYgcd8aL9Ze3y7iluTUZWZxnNe4QSLqJzlCto2O5PNbY+tyCSPcFj?=
 =?us-ascii?Q?uDwkwLZ/3Z75e1u7D+tNbZxARXsqNMF4SKWh1APLsQe6Km2wqW4UbyAvJHzW?=
 =?us-ascii?Q?0RNo54jj3VzeHZFzeSKGGL5sertPMAgXkINbOYVbI2zv295oEd9dg4oG9eTT?=
 =?us-ascii?Q?2kyamG/rVWsCR8aQdZM85GxzRTKvv+QtLg60zbuKlntUIVQdhgTyWAeJy9lQ?=
 =?us-ascii?Q?jp3LYdQvtuRD9+diS4IyeIxf0mNvp1DedmJZ2ekoYToJprvGbsQcfr05R5Yt?=
 =?us-ascii?Q?hjSogbTbHR9/IjB1pW7fOuI3AjJawc9frJ5iR/H5juOD0ExMWCFfG8/TvnTs?=
 =?us-ascii?Q?yRpxhUjQfevM5SCdYtB2CISXbzaJLeZXIRixkE1kG9psYh0oWl00JH8ahaeF?=
 =?us-ascii?Q?lIIGvSu3Cb0RfgO7pltCsvpNL4n0lYfhVyJbSQCn7rAsn6w27GequPYtOuAH?=
 =?us-ascii?Q?AYY4expQf1p0aj//LaKXc73bFXiKfsgXa1QGVz26Sd6AGZN/Nfvpwi+MWAnN?=
 =?us-ascii?Q?gIcxy9metPEmQLz5j+gSbS3UH19KbXkjbvTBVpZ+yrUPAuMycOzYyz0OdR/J?=
 =?us-ascii?Q?f6GRoH62W11o+ayQwaCUM6L1HQ3Ueb6bEvdsgNkfSEN0YQI0y4uln53xaQmp?=
 =?us-ascii?Q?5zc6KVEZV4+2+9Af5MGUiAuUHBlPqRqlBYGZqj71t7I32ZDxaHazaLMI+5WC?=
 =?us-ascii?Q?JlfnEk6MrC0tRGj5NeSxOBJL/tlCHhVZYNO/wwe97AascbvSJBzMCKLWi03t?=
 =?us-ascii?Q?cgAs9yRhitGftSIiRyWDzqPppxOWARh2bc/EtZEZOjwsuxqjx2muikISZ3jT?=
 =?us-ascii?Q?FlZQbs5IIloJe5GtIWZhr8aQ80AfF4f1wWS9ITFrZwWh1NqXBIZW/JsaI9JW?=
 =?us-ascii?Q?YJZ34Ok12yiYJzqA77bNCK/SDeTVbfRdFibJba547q7n+Bu?=
X-Microsoft-Antispam-Message-Info: a4GC8LSJEDRGsTsIqN7WRaVBWvZNYGLes5OXNcGQPfZ8gYn8uQhEb5Gtrj0jOTeW1jB8Sg1jhGa0xVSOCryXRFEuAXHwc2vEEXfXhk28KzyYMKOLgqcAPdcAxMd8D+9vkDOqOKeUV0Mxsh5c2XqaKTEjUdytf2Xt8hOowVE2vCnDl/wSU+03YYW6miTUap9zcCjFIlno3wKqeiyVjJZkjpyGBN09h4n0A4yyrJnI3yJzAltakQTerUGL9hXMUU5L049N6Eyfpdh4BktvePz4DSt3K6X+MDEXmRf+SHYW217f8mjB9GqVdwgGC5BoSkfSiTehxk9nMKaYcGSc+x7F5tVAccnt3LsIvIWVmHqPyOA=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4798;6:tLbl6ZRpkZBh2RDoV5mZwsml/aERDMNFPuBBBacgh73maHEiWuXJb/8RBLTezbDKiPLd+CCH1Kg5P/fd2hjvmm5OhDJPL6ImxgvYa7PJg8i30t1Vy8bINyTD+ssteZOl+atNOCU+U/grUrTiEaWN4mH9hgXnqnbIEuf+2lnxPSpMihA72RBB2KKddZ4A8gTRvwZaRDpVJswF/zcqoYu0dMGah4IX+a2e/NqWPcmAc7aY3fYMVznfmNE8AMYXcNyEUdCGk/ud7OvutCkUMhtEzD0+68qvb7p+I/6QYp8pLMk1JoOEc7AwbAgs6oi1KGawE20FhWoKlYjqwI/xL0O1JTTkloAGOJpwji2UfM1xaleFsS+yT9WvFCLidpqVAvjo+sFeHM9dhZ3QyWionjZb39jtZt20Vl/eo1O0Jv+NCQFS52FQfdlFzwaICoLRxLOibqrHi0VpiUGPrL0VrCYBxQ==;5:fbdV0E69y89g+995r0gs4Z5qd6T5Gbfr9b+ZFgErrrMxQlAfiDLiaDC+vsLm/egVmJBUwMOvu9T7blejYzTnKE3fUr86R1prCWaFr0tFk+221Wu79/Bv8vslCNhI36YVwU9TOPs3g84b9IgJfSL1DRAi5weInUSu5hkT+DXO/dk=;7:vxBHtoKow4AnGJpyEcMa+toQi5jcLq/luuMY83E2HMUrBRw02nBiUyd1+oPo7I2WU3w0uTpAZKB+yudp04wCzzkw3LCkuyy3fMb8tZVvC0RAWbHEulLaIn32Oe8SVnkBSvW53WioccM1S5exL68ZVaBBqizBk4X0BB8uLhliQaQ/Y3P+SvY1Ox7hHbvUfJeXWVEoEH5YkHVzgVDizgzGHcEKN84hjI7LgDLHes7QhQWoSrAkY26TcEWfLls9cv5V
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 12:14:38.1003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7358c241-e18f-4456-eecf-08d622174f22
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4798
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

