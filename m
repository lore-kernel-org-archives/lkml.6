Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BC2ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D863D2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oLXqg72k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D863D2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeGMJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:53:46 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:13498
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbeGMJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJiPU3RRtHNjdrEUGy3LKmOU4ecvqmh5kDBmHxUS/1g=;
 b=oLXqg72kdy95u03/y9VsPtljiAGtPUAN5ADFNDGur4i073Ka9tdSgbUo5f/HRYp8JxVTpiTSqNSOn0ADsOpE/wSy480L3c0QftbZFd6T4SnWJ2LbyoK2vUF9hTeZJecZl0efhH0daQoV0l9/tNz7TcWh/KGdWvk6TkLXhnaNGuU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 DB7PR04MB4298.eurprd04.prod.outlook.com (2603:10a6:5:28::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Fri, 13 Jul 2018 09:39:49 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Marius Vlad <marius-cristian.vlad@nxp.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: imx6sl: Add vivante gpu nodes
Date:   Fri, 13 Jul 2018 12:39:35 +0300
Message-Id: <51acc44e6fd0458e63635b92428fe7743e18a3c7.1531474202.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM0PR05CA0036.eurprd05.prod.outlook.com
 (2603:10a6:208:55::49) To DB7PR04MB4298.eurprd04.prod.outlook.com
 (2603:10a6:5:28::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f7f8c4-c72f-408b-71ff-08d5e8a4940d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4298;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4298;3:mp/w4GIRNggD0LajqYrCj+xArwo5tU1rXPShiZBqgb/my5E7HonjxcBUo5cqZEyuaMjTs6xA1xhp9G+BB9ADpLJSiQUTXa+bFnXP71CEDsJ7VOPHJcGjAse6UPtB1ARa9EoGpq4jityNDeY9SxKWX5NPqENjEdaDxFBacgQ1NJEbz9JtM+yF89Eb5UKwOg2gF+UvGE4/HkuK6ym3RY0QeRUkMHYWpdgg5Dv8Sx2nmtWZ0bUhMrSpxBkvvP3A92J1;25:ilw8YxxyAQAje7/WhkqdU7soZ6lIduMSr+Zv+7Icqg7cgZjpUDjjLmNezg/u+cuc6xqzMQfvYAQymszWnUE8Idk0kn9pzIFEeuOREPw/r+mARDwkRFrhivNAadIXNFXaV8JrQRkVyDCvwK4KIWWeZknBOTshFDYcx2D2whW+QVXqOPKnRUZ0PY3kslwjsJy/QH7qr8dqWXly3d4wO9P8uOPIU+Sxl+UFNj3UVfwGrQyCtfvZe4y4vtpmQ2GTX6REA7qC9XGMCRNZtaldzvlnVNDZV1CZuz1KEZ9aikRnuj/NI4YBD6zRX2/Q98KjZWGX8F0PAZ72DWt0Wb1KoEo8Ow==;31:Yh53iM3j9+fRcx7wjwwn7JQo0ghJXqHUKrRCMJ9SiItCb2e5EpfBZHO9IPQUEkMugRpBnEnl1BNG9uDA7HwUi7Th624JeMI4sdG3+KvRyRu89LLfEgNuG4iefO1rHvdezKRlsTdCD20RQPlndBAK0cGQkSp+lOio8R3gh2EMaWbmmw0DulgRSHY743+dRmXQjxuh9yB+dTHevxpyQACVK9he6Mo3gg0fcoc0f63I6IQ=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4298:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4298;20:/cjeoQpzlm0X7xf7CB9gZvN5Ekmy69mzPQs2kQsKHzE9CCIkSiY5uSbsGwlfaKnBgoKWUtXgvQUu4Y2LxVXbVQ1IO6kHMzfc7QP95UcVTx85vqq6RAgbE6+6pwuxU5LjT2GEoQEDJZ964FIaNUlEVva4J8mvMENnnze4KA+dI/08XaSavse93z/RnyR2Ia29heNAS+lYK6Oi224AWzL+hYYu1c9u66o8aixjOMlhXWolMycpb/YmWb+zk+b8wXNRs5PVNORMPrA4+ipU57zzgaWU3wowNs2OUbWp1C5j9m7NSu+rIERxGqG8hgsGfHxQKpvf8g0IHEbNTRXZkLkxkBsWgpY5p9wLuzeAcGzD5jABOREkY3oze8sMxKJpJKM2WwnmCPF2Q4B/ceNuZZw2CnV3TIEVVje+JY1qL/MMJcgZo2pu8VDAtCMNqTS3t6R9OmkISDokXZ+nJxtO4CJn+R2p9fkLPPX9syzo3Yneh9F4DbEMGFyYfvi8C4NZ5gSY;4:/VMliW50IHaOgUfpqEA8Dda50ejbaHE+hydw8I5BFUjFk4P4T2kiao+t6FGLHv4jgg7zjrwDke7/TQX461tEX/Qz1FFB/wZxRyV/m1krq+5Lz+4sy/MoI6T2lU9nb7TYqAzLhGFWcCcBdHMf/APxINfT1BUcRZBd5htpuqyzO/FCNd6jrLmel8vHyxhj1H8rR2v8uG4nwIbAUaLFiOFFqlq1xGGrRXW7kZQeIAkKjiG5UawGYyvZe0+W9AwaEsgX04lObgPfyePooSiDQpDU2uKMofd24+JvW4Pk/WhYqp9+NNTyFbNU2W+i/xUJjNyzwM+5u0Y2Ahvhv3Xl23RkIwDEYeP/+m4cPmbqNfC1MC4=
X-Microsoft-Antispam-PRVS: <DB7PR04MB4298E551C8B27A586C37AB59EE580@DB7PR04MB4298.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(217544274631240);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4298;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4298;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(50226002)(956004)(476003)(2616005)(97736004)(6486002)(7736002)(52116002)(44832011)(118296001)(305945005)(51416003)(81156014)(39060400002)(8936002)(81166006)(316002)(16526019)(8676002)(186003)(25786009)(26005)(110136005)(36756003)(54906003)(50466002)(66066001)(47776003)(6306002)(4326008)(6512007)(48376002)(478600001)(486006)(966005)(6506007)(386003)(106356001)(105586002)(2906002)(16586007)(53936002)(68736007)(86362001)(575784001)(6116002)(3846002)(6666003)(6636002)(14444005)(5660300001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4298;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4298;23:E4E+62j1SAnW+aTS0AJcbyJWMXh3GrimQVLjfHplL?=
 =?us-ascii?Q?rQnmNuNh7thu3NCfobU5yAwVzu0AUgjG4J5WBfGoF1wcL/uDgW0c0kt+tKC+?=
 =?us-ascii?Q?8fiVapsbsnUy9xrETcuE0badn27jctUVEeiaNhdgzBmBkVzquL1L4wL6VHvx?=
 =?us-ascii?Q?r2NEFffGy7FPJos0jg363E5wUKit5FVoT0HjXVZpuJzRkBGQ9swjLSmLE85z?=
 =?us-ascii?Q?Yim21fPu367InsBN6enO4J8hW7te9pjuMc8dPgC7pWMdHXE2nq68onAK8DJc?=
 =?us-ascii?Q?hjz7inZ5kLSroOCtpWB6Q7Bh1gCbJdSMrYk3ltwSIfN+vkDlqUkim/aaOCTo?=
 =?us-ascii?Q?1KxxQrX8jgrzTuAGtgKlcVyEqKqEOoeusfW5pXclj3yL6yk0Nvhuq29DTd+s?=
 =?us-ascii?Q?qfRH9ED2Nf3Xf93LYQ7JiiqIDLy7WhVtwT8GVLSqcy32YRAiIZiHONa6uT9y?=
 =?us-ascii?Q?Hem9zIO70NeuY7KDbtos47BtmgfduTwr4CYjHa5VsBUgXE3ZCew6VKqZsFtW?=
 =?us-ascii?Q?MI+gGEGgQ0ioGHikadzLRLLAj03us1OOJGUElb1DoDct84cPgWm43vp+R2zI?=
 =?us-ascii?Q?OT+5f3rlbgbOD9FGnLAnlXFUryNZj4bQzSZqcy7wn7falOU9dkHWoomfzGiX?=
 =?us-ascii?Q?6WhpT3FJCezCa8f+0gfIYnTY40mxb99ubsRiJLHXeUxwXZGIp+GR5gor2Nxv?=
 =?us-ascii?Q?+eaMKmsPjyGIWHIjlROZv2Gn0R0pvHy2DE/0j7SYRhvkeanZr6zPpqP90iA5?=
 =?us-ascii?Q?wNgV4OLtSScPco5Nikreg/8UE7r/8vJQVBr6fjWdDezQI2NJv+rXWvXqhiLF?=
 =?us-ascii?Q?rhbwip0wodcBTju3cbYNIIOTst5FY+hZIKTzKrgCDeLS4MZ7p00hzve8v/pj?=
 =?us-ascii?Q?p6NtYPmEk07QgFu8aBndrt35ISz9DAPC3jiB0iwVXONgMepWjV6g3zfyLFpV?=
 =?us-ascii?Q?M6314eJ/odb4613XLUYFXjiQ80FEFBQqGV0IDU8/VCjbI/GphONUyxIpJ85m?=
 =?us-ascii?Q?rN8oUck/2cVKGkDAdlTkTQc2rGq8ca8T01x8pKTgErcbHX2ujofqhUdv9A/D?=
 =?us-ascii?Q?f2rOFG183ba4bYaG0ejZpMGbsPeSZYSK15+owbYWMtNfNhlbxZ0EQkQbH4xy?=
 =?us-ascii?Q?0dbyU3Ejt4PjBOgORdAPXNTIZIzLqz6pd72VwXYg5UrIj2U61lOTqBrJIVEk?=
 =?us-ascii?Q?EFwmv2J68HHceC7n4vFl88AkYxAGPrx/xUoDm/Ci3/ziSEfcx5n8t4094TpD?=
 =?us-ascii?Q?+EmYfOpQtA7fZe73YeqGvaClkK3NXQx+kJLxY0Z9Q5SknEuBDPTHXfCT88/m?=
 =?us-ascii?Q?vuijSdkvbJoD0cAeIgb8x4zTwS14IJiQCdNlBC6R3cd?=
X-Microsoft-Antispam-Message-Info: ZFqAtDO3ISZPX4fHkB9qq3VWZQ34iG1Dn6CjaBF2xQ3Y0xsIvI+/uX7YnpIU15AL/TMZjlnDqCUNJ0wDN+MBx+0fEP5Tcgbb1FOp7LWOCMe4WYNk5Svlm0Lq2YrKLpGX1BLb6Lf7l6VxvPEyG53nGJcYrZmrcdKRYMKM4Lo1C+FBOxFmVcv1G5Mme/qf0tShufLkUAklFw1n2cW09Z7rkyA3KHdIkL8s+kqfWGt3XCjsfvHN4WPkq84XR+REynf18LdAq/v4VlX2YWWSJuwh2m1ocODlcvXy1jMC0OVikjAxSCWsPJkuaExWn4vQl7hDWoxgvncYF9eDagiFhrL8XMDE+Nvn3DVbOFRIQofjWyw=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4298;6:XJrB6MnskSD9osSTS/INISbtJEeoYns5uTbcUlVcQmaVZsxvZ+t6N0CD0EfLjC4Dnd9ZE/tEvVQVGOnZFpmGL0vApGwwulIgRZKKHoEYmr6MSyJuqZjtWQ5xNlcAjf63DzTRtyhegeP3gW0AjGZk8RZaU2f6HxfWai6gcr8tYU+rAfVlDbc/FfCBM9mgPctFyNBaAn9CxDU1ljBWMSEgpAuSd+3A8dpp+NmJvHLHZ7SZuHNW8pS4ztC1cok0mL3yL/SJZJQE/EPqRK/DmdJ2mMJKMd3LvWSksycSDJxPMMCZGJh9H7whnUd2HGv3z8NLYw/Ma67cb2tkvZg+nYMYry93/iNmQXZurGegb6ENrPd+BoxxdJuLO1FOKWv09xFupqx0nw5JQW/aAk/xpOX1H/FNrXHTDKKaT0q8sOkAQivY4wcXliPJn5He6BUo4aAYzOpjfoZfkP5jSfu0XO+vkA==;5:/iZbxb40yG8BCxkkKWSkD+w8QIL5v7qSTPhaazohnXlK6qpuXLPEBxQX5bsTeI+Byg5HdFSILyYvjbBp/RoppcvwjUwPx3Q9yltRAn3V92YZCULOh8eOIbUOpIiNvz0h+2Grds5t3OxA6dp3XBeNKPG+jLdTjHzBlutyV/Hqyk8=;24:oklerAQfPFNM8nCBfXBhCb6uk6uFXulUXzuKmT/NecBAucNXZPeia0xuOIK0jISmu5fKeGFQK8WNiNAsF4oBn0axjquYI8aQsiFq7t97vq4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4298;7:1Q7g3i8p+S1FHPiE6k8c9LvQlVG0T7+5dm6mth77f4UjKVQnvHj9Ysj3wPCDcqmuITP1G4hZGaburpQovRDQ90uCTAZlLEwlNXqTATr0H194Taaj52clFfZRMnQ0v5AQlvNpuqD7S9g6JFV53Par9rDqeJKqNYfJkbh1koryL2lL8bnhSYC9P/rIUyKSyjlBz7uDBDg4oU93YgQd4hpTyXgEPcf2zyuHvmtltVsO3axcUFE4xlLv1f9hq6JES2mL
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 09:39:49.1317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f7f8c4-c72f-408b-71ff-08d5e8a4940d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4298
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6sl soc has gpu_2d and gpu_vg, no 3d support:

etnaviv-gpu 2200000.gpu: model: GC320, revision: 5007
etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215

The IP blocks seem to be already supported.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

---
 arch/arm/boot/dts/imx6sl.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Changes since v1:
 * Move nodes to the end of the file, sorting by address.

Link to v1: https://lists.freedesktop.org/archives/dri-devel/2018-July/183273.html

Tested by using yocto fsl community bsp built in "mainline" mode. This
patch makes x11 start up and turning on drm.debug shows that the etnaviv
driver is being used.

Patch is against shawguo/imx/dt, it depends on newly accepted
commit 13211eec7b0e ("ARM: dts: imx6sl: Convert gpc to new bindings")

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a6bc21433839..84413725b722 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -946,7 +946,27 @@
 				compatible = "fsl,imx6sl-audmux", "fsl,imx31-audmux";
 				reg = <0x021d8000 0x4000>;
 				status = "disabled";
 			};
 		};
+
+		gpu_2d: gpu@2200000 {
+			compatible = "vivante,gc";
+			reg = <0x02200000 0x4000>;
+			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
+				 <&clks IMX6SL_CLK_GPU2D_OVG>;
+			clock-names = "bus", "core";
+			power-domains = <&pd_pu>;
+		};
+
+		gpu_vg: gpu@2204000 {
+			compatible = "vivante,gc";
+			reg = <0x02204000 0x4000>;
+			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
+				 <&clks IMX6SL_CLK_GPU2D_OVG>;
+			clock-names = "bus", "core";
+			power-domains = <&pd_pu>;
+		};
 	};
 };
-- 
2.17.1

