Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA244C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF2D20871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BveQovkZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF2D20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754524AbeGJIYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:24:47 -0400
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:3360
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933078AbeGJIYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtZhryWJdE2QbykcZ0YIjY2C6KI9r0ihZi2xoU+z4F4=;
 b=BveQovkZwbo4PNqJcxkBYLdakJO3LXAv8KtxSnsQ2RC40QV2usDhnyO446sV6mprztd9BJVDPfBaHqkiUMMwGNzYlITEgKXDZO5o365vh/8soDx+hcc+NiOvcqWFbhjl+ywkLD90idqdGy9n+uxQviFJDS87Q0Iiy+3IDsk51MY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB6PR04MB3221.eurprd04.prod.outlook.com (2603:10a6:6:6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Tue, 10 Jul 2018 08:24:31 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH v1 4/4] ARM: configs: imx_v6_v7_defconfig: add DMATEST support
Date:   Wed, 11 Jul 2018 00:23:13 +0800
Message-Id: <1531239793-11781-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::20) To DB6PR04MB3221.eurprd04.prod.outlook.com
 (2603:10a6:6:6::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24278b7e-0464-49d7-63d0-08d5e63e91e7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR04MB3221;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;3:CGbos/qZbTPgSsTqqLgQnaOp/0xDsICtvDpVkYe+Xrf7aB6Lq3M1cVs2tgjXkP3QJV+/xv7yziqafmjYnZPT0ErcqATIP79hKC+maGSjt42mrt6GYD2m1Dy+VIoERl9bsRbaBRBFkxqf73zu4xQi+fTiRmBsO26XqmM3IWNHPW2tYGAKjEX3bGSjP3aZTtDFFmM07nvkpQR/Sm0r1YPHFrZu/4Vy+tTx61WVSJFpTLeoVGpUg8PQmlMkvaGCeBuj;25:4WA6DKc2cUqlnnfsjKJYBA8HHXSsxsUM5K/F+xyGEO5shoP72QhkhI6GQWbMPuWMGOPJ6pG/AyFtFYA6R2NKRyTH16gOnoSoHlH/tJklgNwsBhIsS3buHhYzTXl7oTNytihmZ0lqw6rKnXGNTH6NsnHUSXZ/V2F97vmJ4Af+aql7ajH8qGNeSfHdmHnYRF6krG0THTiPFEP+F6c0ARpqBu+Qf/210MGubGv5P8ZmdcIHOaZ7kflzXHAh79mXcpLeKHfOeU2dMVku2i2pJ0mkKW4VZPSYv13vpaYjzvwY5O1M3twcjs/zCdMnTELW9A6Ql0oSUP8tkAQhwOqpabFGlw==;31:bt/AXdPDoOqZUcYQYrhl/eSOy6KwI3M9DggonPB2cO/R6/uYiSPUH91hTddzqUaME4FnYyj27j1NHJO8vCG168Xq4mQ3mvkeyyHpwb/cQp5plPBxduyxL/OZUukwDW7MX/Fuzp4zSLRp39dXyEzY4TcM9pEWYjhcELZbmk43FkLxAUOCnziAaHvYTR5rXgAv479mMGVpkZzf3lffejxWZipgV1ILFpQShqmCY4aqPUU=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3221:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;20:K9cELNwOunpmOcLcxbYI89g1lliE6HU+Q3KMembsJHSdu/qkJ2iE0hBEfNP0yYaSj+j/e6z5OvQWyggtT/MW96bMCS6oHbeFr34QBu2mhebWtS9IYm/7ZoRG6rXJs9nYByuCCyWpPLDinmKMwQq6taC6l4Y3fVdUYf1wAJS422ZF40hKyhpJvc6U58bi8iKrlVXsu3J2Q5X7aRSjZNFiuYzIpS3DQXsqF/xnr+/drRhmROuf2Q7jMag/vx23XZr9fvvODqmO7mO5wMHf7Nr20bbTaKh882CgQ1sCVabHBFDiszfaQqOhgc6srZNADRgc43zsvolUw7fFwClyq6Hw1EfAV6YyrMfynQA39qgQkxl3d30w/0J6DtTvVe3IzqwLRu2WWZHvkrvO+k+PDo0XVx99yuorfOAKkyhZvN5HdvwIC9uu/OsiH6u92IWNBws4qndgDoM0k/E6pcrrlQtgiN6NXkdK4mEtzcIaQv7krsh9vLXoa/dXOT5NM+8ogeFe;4:uYWe+fcOxL7Zi2XNcd1ocL69APH3ZDl892KjcO7VZFo5Crrmi1VIMYZ/d/BFEBx8qvBc2ahBAafkseKy4o+bcu1i4epOIC/CNHo8CaQubKMrC5g5sJvG4bMq/YeUIw1Y2ioDFmwMYJGKn2I7xz7YdSmeJ5yzg4vjIrz0DR0gNyf3W/JsvKgDTOk7CMcDcGA0MuNpGSpjeMD1hv/zz/S8J4j67nNsszNLs8KIjJCIu58xZaDw43RdY7lnP1R1GAOEN7yzzXcm5FNn5xv8gjiU4m7TU5JA1a74vyxb4ZcDy4OYQ26TzBrlgLiF7Ci+vGwU
X-Microsoft-Antispam-PRVS: <DB6PR04MB3221DEF9C7FF19BDDA823EE7895B0@DB6PR04MB3221.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR04MB3221;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3221;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(53936002)(36756003)(5660300001)(50466002)(50226002)(6116002)(6666003)(106356001)(97736004)(8936002)(52116002)(76176011)(51416003)(3846002)(6486002)(47776003)(68736007)(478600001)(86362001)(66066001)(25786009)(48376002)(4326008)(105586002)(2906002)(6512007)(476003)(2616005)(486006)(446003)(956004)(11346002)(305945005)(8676002)(7736002)(15760500003)(26005)(81156014)(16526019)(186003)(316002)(81166006)(6506007)(386003)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3221;H:robin-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3221;23:qrsE1vGs0TRC2q1KXOkaD/FAz+0+OsaclhQ8nJcOZ?=
 =?us-ascii?Q?v+1a0dz4evVcoXKJK1MlXwMUoICIDMTeuTPEFfRVhpEt9zZL1gYhc0xYO+D1?=
 =?us-ascii?Q?ivi5Aods+Q6fEYNt/pTzxkbRC01H3iYtN98To9sH1LGDNL+pnA59EkW1duuU?=
 =?us-ascii?Q?G8SUTETOkWR2whgA+mp351ZnsGZoxisjhoIKLvxzGTEBzopycO0trau5JJTL?=
 =?us-ascii?Q?LeQStnX7LqNoycO/yjHWxd79eGglNbXFPC56DKemW8BCZqZbKWUBOhJyWvkz?=
 =?us-ascii?Q?PGMm7Vyaipn04uf3ua3hgpVls8lyKKeul5vVT5TW/uBO6dLMfWGF5xM0lAb6?=
 =?us-ascii?Q?dUcCV5m6rjzo9qrUXRpsBEQj5stobzNun9cQW2k+O9t3ywznLKfq0ZOGBJml?=
 =?us-ascii?Q?9KEFUUIcMtQNMVeJlTWfMyo3VfB9oks5kO/i5kjW9cP78qP4TABgJJiUOGZK?=
 =?us-ascii?Q?eu0/gpjCrz9/gy7bB1NHlRxXiByhY1usv4YZT3vEh4u2ArcVSPwkXtlP9xHm?=
 =?us-ascii?Q?0WRY3tXuidoDqrAIk76ZhRU+A52eZtc0Ok3FaX4tFoCbvA19rPAf9Qk0nd3m?=
 =?us-ascii?Q?6IeQa1IGsV5/F05Xo50IDTOMhJdA+PN/GQSOltjW3yi6NF/yl3A7eW4dlJHY?=
 =?us-ascii?Q?W35zlErOenaDptsCvazUqGzs2b7NOgKX2SDeA8Us/e6oitmHhvDsOP9qq/td?=
 =?us-ascii?Q?wuk5TWemAg4ltr2WdAIUvRMCNyWQGd/9ZkUWMaAibSg0cKNAeosax/uR+KJX?=
 =?us-ascii?Q?9V4flaLw4GI8tiwCcKg6xDmbj8RhLIaorUquxLJTnVnlhJDYAVIiy96V/Kq+?=
 =?us-ascii?Q?OaHHwEHHdjjTQjNRgZD/JtKluL3va8rhxaumCDGzP0PXkXLw5mjYJdYOXkuX?=
 =?us-ascii?Q?sdEdHAZrxM0G8IW9lsRgxaJGp+cWCQnsuZBM1fCu3NKOYLohT7tWG/FWJ6y9?=
 =?us-ascii?Q?MctIXOTo8iKF3p7Ib24SnlH16rKhabFo0x1KXg2XwWvGvl9yRMfkYTn7SqWe?=
 =?us-ascii?Q?1nhNk2MHaFh54UFcBEtGz+3HUYXagSJ3pAYoRSvMf7qkU4/izAO6eQJsYYmO?=
 =?us-ascii?Q?v1CCblx2LX5msHSDrWmK7VjIBByS7Amq6qrZ6U9IGiZQ9/nzA3TllrFnV9SL?=
 =?us-ascii?Q?EwQzhD6dv42T4VBRounRuH4U7xr9LxtzK2Oejaf7WK0KFTghHKQpV47ldxJJ?=
 =?us-ascii?Q?N1hvEK0oxhsJXM=3D?=
X-Microsoft-Antispam-Message-Info: YW1VhDF7juZKODWM1KOR7kK2etjji5uvxFgQ3oIEa1ZD3EMxpxb8J6QAaOq3OcTc0Y0MJGaSSySDbGXy8/yOHTUfxK9/yjaepxb7bAIxmR4bptI9tXIoy5S05Bs46GMjwRwi3Tvy55v8sBPEDXKxbtySXDO9DEP0aGuTSQVKiI0sXznM+H18GrdW6bwBw9bOlEaeIuZisng/pLcChLZi6p3njNo8dpjoU4Y6jzxcR1Mzij1ful96vAujZlO374gviG5jSAfbxomp4W0/q/XTzUU19oJfAPzyXfEC0baWh7iwZJB3ZTlSDW0V7RfXL/ToHfcT3FplI0I0w/kCwToRvSeaXpGp8MuwcDjP4gtU/iA=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;6:0B5sT204LRtwy3dTOL8/o4So0Fa5csGFbZWXfRUUnBWNm1TMmQxE7irlsPEgcpCl27TlyhOFrsVb53GSJrSHMEu1blwFOVNGPr/zWmIrUrdLtjgSz1JFXns1yflY2F/x62DG9SZslnWTtpzLtE3/9ng5QOvrRLHO2FaN2l9dKljmg82J5CxHuTxr3kZi/UYDgFBYugfF+VQnbF/9ia9+uB2NyybuTszpC1yQ2xVtfB7+eQErz6fMrqZIV2qO5KQD32POi+zVjod2ivdUfkoxmcS+/NNAQVm6aUlhBs1h4qME8trZSXx7a4DG9MMnAqfjQyYWDPGwE0XA/0JtdfDgAjoDECVw5rv02jtCmQGsWbL/tBAPzUsPyu6FjOqTws5Hj9NWutyemWEv1qDIQ9EnbTjkemSbW19AIlh68qoCODd3hAw8F1K5pWpqS6JD0XZmw11jUQvWgjHFtfzfA25G7w==;5:W3t20K9VNCefjARJ4BkUQMtRzKcFI5y3BKFs4ePOOagB9LNL+mgHERIZQMj9JSZl+KXpRgm1bttQ+COxw3H8LYxw00o8U3QQTZ8nJ+UTtN+vVSrRzfmCu5eigBpczJsHGDH2qELVrOQ//Agb74iSnVG7fhEa4lkyO9zWTuoSS3A=;24:87lx3rjzSKOhgK0Tb4PpoegmX8+7HUXBhrGLT1pX0WPMalNW/p0CfwDGzJPXtQ91zrSk2bWgfVMQ8SFfuHC94qA7dEL4Ld+zMAhbLtc6DWY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3221;7:sxgNOD4lq3L6nEnP4QplXlDHGGqfrBW3HEOMifLWOgLmOTolzr/l61gP93uS6wImjqyd5yx5gz0JpAeG/VkogADrxrT4BDycXf8+INQFjsUEygEBQrmfadUrU7tth8i1LmL6mev2E/MKbtFVVQpORiZAG/kbOvVHdlnKus6m4Dr6XVkSrV9k/K9XYABSxAH6a2Xg8PwfUPU0Vo9YMAqXK7NdZgqGSC72AAljEeOzcysRNxMPt5rTc7HN44YDmP/4
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:24:31.4927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24278b7e-0464-49d7-63d0-08d5e63e91e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DMATEST support and remove invalid options, such as
CONFIG_BT_HCIUART_H4 is default enabled and CONFIG_SND_SOC_IMX_WM8962
is out of date and not appear in any config file.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e381d05..f28d4d9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -81,7 +81,6 @@ CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
-CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
 CONFIG_CFG80211_WEXT=y
@@ -282,7 +281,6 @@ CONFIG_SND_SOC_FSL_ASRC=y
 CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
-CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_ES8328=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
@@ -371,6 +369,7 @@ CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
+CONFIG_DMATEST=m
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
-- 
2.7.4

