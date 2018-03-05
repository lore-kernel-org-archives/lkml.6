Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932919AbeCEFd0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 00:33:26 -0500
Received: from relmlor3.renesas.com ([210.160.252.173]:61936 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932792AbeCEFcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 00:32:46 -0500
X-IronPort-AV: E=Sophos;i="5.47,425,1515423600";
   d="scan'208";a="274206552"
Authentication-Results: spf=none (sender IP is ) smtp.mailfrom=<>; 
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: kishon@ti.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 2/3] phy: rcar-gen3-usb2: Add support for r8a77965
Date: Mon,  5 Mar 2018 14:32:44 +0900
Message-Id: <1520227965-4471-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1520227965-4471-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [211.11.155.138]
X-ClientProxiedBy: OSBPR01CA0013.jpnprd01.prod.outlook.com (52.134.224.25) To
 TY1PR06MB0992.apcprd06.prod.outlook.com (10.164.99.26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b4ca0ea1-6b48-4c19-216d-08d5825a8448
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(8559017)(2017052603307)(7153060)(7193020);SRVR:TY1PR06MB0992;
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;3:KdMmfXCsKKVV5nJ38h62/f9VPgW+P1CAhlHdhxEL+CmKJGR5ew/lTGEVgEZouuEoOd0n100BUAGKqkq6Td+Ol3T9TTELGnVs8B3jX2bU41ManCI2+Wekhbjo9uoKj+TrT1EVgHoAKtGtM6SESp7q+d9FKLd+sKOD9gtQhqupvtSPhVgTvTLUAAt9kjxuPb4eCTLjOWdo7/BE8sSBH44vXVDkpVgpPMhc3NhzpUeUj8ur7X63P+x9LYGtsGfYc5Bz;25:CfF2fz5Q/m0yW/h1NNtve9SYFPpL/97pwzFMWdqQqocKvKV+pvQOhcdgOZ989/N1Hcr4OmqvC0cOuG+iZZSrkVU3V9PSVDTkMwb4OD8CMjfjEtngoO2JavCbnFzqGI61JX+/rzaYvVRMgVKkxHTpxw/eblXjKmIAH+HG0UMydOYMk2v4615OOYb7dSrKImvpug5JKaMebBYdPIw/PJQkEh6pLmqRM2a9Pv+1yc8uwBl+Llha4e/mfv4B6rrJumGzK29sjvRAf01wB9UmgMYzL4PlXM9N9rKn7Qsk9pM2EGEN+DDujL5c6wKhgBEuD2C0eGY5HVhhRLrrBqOrWI0Jtg==;31:9o9bw/hDr+WhRdgRfBpviy6xvD8cZ7EbELOwaMaUpYux4vWd3fwUG/CMnsxfIQDYMp5jT5HAnW7TLy20N6t0pMmxM9qh84Mj/guKUFhjIyJVuOh4eRGEUEgRwARG7I4cB3QoNFXUDpiiJ2Ua3hbCHBVLMx2ccJLiMuXHA8o6GyDET5GEtAC/IMqZQ5tgf2xEmb1aMxFmmud4tzrZIrRmUqM2YYtMTXJAqqprEqbS030=
X-MS-TrafficTypeDiagnostic: TY1PR06MB0992:
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:PMsD9SP0g0i/XHfyU5F1twNHlxNREC1QCMu3qn+aLpnaIN/M9vVZmiMoXi4s0lf21+WAOk4QofVhXMFWlzAVlxFj1WH4qeEh89kBiEcsRpbycsZv6CIgOVMet7vG+7f8ghAjI03aeXiBou9Da0A5IRh4bQ4Tg+pioVLSjoImz1NlKQYGG2KKNPVFeO8/SWu8EmubUi4ZAhULrJEjMTNhBWYfdEW9aNlYMATGEgTRrIxpTP2gqyClwihutsfNKQhDgKKKu86DEqw/WY6fXNmGRecra9ZhWZhOsAwbCcWtFZJSZecf3pZrnbPZqh+vzQ3AuoB0ujhiaBUHSY208l8bQrWCk9kqJcnioJDc6BDG2P33YrXcHLQYcblelqHQx/YNx7ViGbItCEJ8dvyg1vPUPv1+CUuOH2PJFtq/pXB3884wLMaTInPnW1LRF8OZk1J7IU1Ne0EkXzoiwopjav3/z6BS22KXvzCD8YxSNx2f15Egj39rNgLqb+3QRtBy7cNy;4:ZGz2+/K8o72od1PBTats5i6Z/NpxKskPQ5ZlIvOgPs6MLiFpwZgkNWcYOTk5lTx3NwgnuYDkzC/iYQtryRKQR/XLPU8ySnY6jbxVzD8LPbIuF/QNQM5ondIUTaKbMNXZmkU4kQw3iH4CM+ITW6Bm+j1E+7MCKzZgja2/cLnX4MDdTpq7ODJPPqx6aLXanzfr85pXjQnwSwcgegbr2TMhvwcFsvXQrVuIXGriBLY6ZAvHbeKh5JRsS/6PML55n8i/vL3U3o/1ApdUUE8bLLLfVg==
X-Microsoft-Antispam-PRVS: <TY1PR06MB099294796AC2941FD43AB2F2B8DA0@TY1PR06MB0992.apcprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061750153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:TY1PR06MB0992;BCL:0;PCL:0;RULEID:;SRVR:TY1PR06MB0992;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(39380400002)(396003)(39860400002)(366004)(189003)(199004)(8936002)(50226002)(66066001)(68736007)(7736002)(48376002)(16526019)(6116002)(78352004)(498600001)(26005)(305945005)(107886003)(36756003)(2950100002)(6486002)(3846002)(42882007)(25786009)(4326008)(53936002)(97736004)(5660300001)(6506007)(81156014)(81166006)(16586007)(386003)(47776003)(316002)(2906002)(8676002)(105586002)(76176011)(50466002)(106356001)(51416003)(52116002)(6512007)(3720700003);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR06MB0992;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;MX:0;A:0;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;TY1PR06MB0992;23:At5MAt7PD5nW2GkFfqQKNZHpJE4n8axtme5Z2awNT?=
 =?us-ascii?Q?9PqKPh9EDLVgHb4/XjIZ5q0GX/6QAafab6y8WmVsRCl/wRh1rhNr4U/w/iAA?=
 =?us-ascii?Q?sN+1RBEnb4JKg8M8sAzegvlUcjBT7r/qfOfThsjxksOSpW0wLDycJi1a/Qzg?=
 =?us-ascii?Q?f5GuaIYrpVTJ2ndI5Vy/1MKaf77VdQIjf61GH3UyvurH1G+l4VI5WEY2Zhwb?=
 =?us-ascii?Q?9Xvq4G2igZThY3yvIGKBSEmjzuBGpQzwzVcNmGCyKCsPL8f+GxnOyKW1nPlH?=
 =?us-ascii?Q?2QJcIRCGPMSI4uAW3ptJuTr+/1amXLxCNTi+XpV2PRdeGdz+PfGR5rMW3O5g?=
 =?us-ascii?Q?jAhM7UQ7I7mZ8IvW1yHa7IaishfqBzc0NMl4X9sNwb4PEHdSiiZOuXNUHAP1?=
 =?us-ascii?Q?NqO2mzAbuxZJOA4bKzmOZkdoBNR55HK3ewn/ozLRRQlp6k5Fx8gudcYoGx3t?=
 =?us-ascii?Q?/W9PgoLvq2sbjApj8L8Bmpp70aI6echOkRusIQHTt5uOv/CMUIK7cxZDStS3?=
 =?us-ascii?Q?O1VGt9HMGVgE72n8JSu8I2Sg8BHOVBpZU6w4VqyIfi72E490NJVYbc6oeVRu?=
 =?us-ascii?Q?DeQozeYle2V2RPH9y/and8z7vZ3jw/ABjjbg+BSxTAmwon3jcilRMEhQphxV?=
 =?us-ascii?Q?0s1wF5wETwWN1gEUyS6RmP0PzOEqg2jI/AVDoXx0yyS6mxNC2PyU31Uh5CLH?=
 =?us-ascii?Q?iFJ7yIWBdqtXz8OKVl3xTOw+wFkd3mMokmxE7w+LOt9tjG7WQyf6j4m2pnPV?=
 =?us-ascii?Q?nbWaDIuk3ZVP4V0YHMcAftohtlubC3hE7kQ6YJXvczqsYQGsXf1trfK5fsCR?=
 =?us-ascii?Q?2tRzQ1Szi7j/tkuwIrE01LlPG6TC2rpGNkcV+nlYOQ/+Ge5ghvD6uG9mc5Ga?=
 =?us-ascii?Q?k1VJIxnHygara5HAjZqPs2jWXz6U+lU4qfJXhJt69tEMhhLGyakxw6mtsTuO?=
 =?us-ascii?Q?uPdfI/BLgDc5s6KI19dQ4mu8vBEWhdQiNzOJGEWRtPIBr36jKV4Efg1lOxB3?=
 =?us-ascii?Q?XCWj9sytBHQOc0Frect4C2ZOrXQ9dkWEY1hzeS5fED1ZklOIGbdE2EN4tD8T?=
 =?us-ascii?Q?Y4NS/zKFxwG/m+uyfZ5AgtSElkiJcczpLG7YR15msoyMvo80r2Y9HarEh4cf?=
 =?us-ascii?Q?/Dgp6Cc/iIbywFsfkyqwrgSE6uacR9N?=
X-Microsoft-Antispam-Message-Info: cdSHxnDXcPEPPP5iw4JpijnhO9UUHEsw6i++IMuD1zMF4jMDcJcg1SIyUlMGJ7jagIve+Y5SyZhhWPlWx2pBQc08MpkvCKs55AqdyItRntNrqQt9ooNTgx8Rwok31nyWhbtZ2tVU+euLPPT0gfi5n9RRvYzxu8jZph/gwt1rZTUgcqRhnQyxZRkd9R7fFWEn
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;6:lrjCr14Diq2WtSurdz+RzGpAJSxnr8pmSgPPvpqEwYviPBNcz8s06idE2yy/FPTRAZaoOmegmdTCH/UrqlQD3YvAH8gQpSJFiymZCymbaCPiJgyUdYIxsfehjNXLpcTKwbu/Yb/qnphmTtv7uNlrYzWkBTwFWN887VykxIxviRnBf0I6kWP/2mGFfWvx5XYhM4GdjXpmlElR9le5up0Dx31GH96ace0rQJd9QwmTosetVKBV+4quqSjLK5f3SNmfFg0BhKr7lXxisSBVR+R0rtJfdpHRw0U6t6UHkbLl2hdf7af6T8nbZevfwo432XYdtGhQp8YjfSjYaq4LwxfX5p43Djt/Mmo4nsuK7kTJ2No=;5:OCPdJJOXOnUudo1KeILjT3Yh6Bm+dbEvWZJ74KfBdjUYLpmfDUTCGC7APiHHcdcMjj/KuHwS2IESwWwKMSu7Nw+l58X/tzWpb/ZvtWZiAzx0XJ0s3oRsrkZlKlZj3y/6CqOheD/5B4ZFyuwb+JWqxCNyv53tgn7N1NiAz7aWF6M=;24:aS1Smo2iRoqBJF/QqvGQilzxLPsNi+1sC+XPYfGQzbG3CfYas3xs/GhPsrFjApU8KCcA4qhlxlPdp0jg30/p5pXINJQHTnKrURp9H3cl+aA=;7:6+Pi5LLOuFl7zKhOygiWrLXu31qzoGCU5YV7DKxBodnc36xRQO9E+rcuxQioPUbSL0V2UHADwwVUmDuRKLExTTmYOQQ0eXpju7e4USH2bUtOgnx/tIXHWJ33PIOrTbF2J3k4AJtYdc90u/fsLya/Mo7lLcN19aszrlxtt4jlWcngQWwX9MoafckpcS07aJbZ2FZMdu78/r53cnSffh68KPFHCdr6ciy/IRvMr5xQmHJYK5XZvN5sKDxQ1oellgcM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;TY1PR06MB0992;20:yuXEgdJpLlXAkbJ3/RxS4DbZzQxKJS2aQwHG7sDPDwrpERSOgVjqD8ooA+Ll/tMtf5rNK8nLf9N1UK0F3xCyBeS8ylX2Uw6x/L1yAANkxsRdXUc0KHrp0hfVb+N6Gf6oMkd2PlKivfe9X4J6oO4jgB3Ko34mis8AfB1FKgxrXEU=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 05:32:41.8436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ca0ea1-6b48-4c19-216d-08d5825a8448
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR06MB0992
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for r8a77965 (R-Car M3-N). This SoC has
dedicated pins.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 9c90e7d..fb8f05e 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -397,6 +397,10 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
 	},
 	{
+		.compatible = "renesas,usb2-phy-r8a77965",
+		.data = (void *)RCAR_GEN3_PHY_HAS_DEDICATED_PINS,
+	},
+	{
 		.compatible = "renesas,rcar-gen3-usb2-phy",
 	},
 	{ }
-- 
1.9.1
