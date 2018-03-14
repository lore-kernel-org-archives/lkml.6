Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeCNNja (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:39:30 -0400
Received: from mail-he1eur01on0042.outbound.protection.outlook.com ([104.47.0.42]:55200
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752003AbeCNNic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:38:32 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] dpaa_eth: remove duplicate initialization
Date: Wed, 14 Mar 2018 08:37:30 -0500
Message-Id: <20180314133732.24068-4-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To AM5PR04MB3267.eurprd04.prod.outlook.com
 (2603:10a6:206:d::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 13b26256-a1a9-4779-1f72-08d589b0dff5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3267;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;3:gGDhM9zK4DQII/rj8VYv2v9NFrJn881xcw+vuXxKY+eXc43HWoy6fIyQkgK864D5+dblDBTODoAmqon1Kcvbf28tAnV7dvg1AtaMAlK6MFe/eUMZpCquMQcBI9wr6vJyrNM46iX1RYJ+r2a6A6dkzmhb/7p3wBKiynNLnE8SfAytedgP7nGyyuItq0mNMHORzvwP7qWJRMIK+Srnau2pF3qx1JQbXGm6oM6j6zYpnjBj8KMPVpNb8VfazG7z3hid;25:zse8Yn/dq3bF/EB3sOosUqxJCLctDTzso+k9wZMRX6WEK2FgKdiWYuQfRZWkGmpLqu/o4N3THqt8NdRmlbfA9WF1T+PwjJyTWmtv/x2nyUjfl2ncKtX2cBFS2Df9dHvRbksafmgpEf9Mm4Np/mNqYaJti9ITsQsdi2RZrt2J3EjG0y5oV3KYaLfZUcbrc9pXNmgddFmdKihEkV7qMkduHJiNk4rxuOjESA7gS+Cj9n/VWXDPyzYlWCsVI6ekYhFhOe+EJ3udz8B5xBrWoGeIE1CUUENbeps0bcbNXbKMEDjE9ZgcNdholqWi3zpVACOa2Bi10VSOpzV7FI7krJdh+A==;31:bfT5fQhb44RcyYpMTjoM4IVzMSiF77POSPNAoE/T5emPX/k+jg94hAeFUsCD+NSmFk0JEyeQWOKrPbTliLNyQ+X82dQT82xanXuW+CO3n5j/44KNziR5gNYZ8oTDrLoChGEkETrHXn/hrYRWOKYXlTdrDg72ny6RlQHJQcT8LUCUEq8qAmOFxID4zRRUVz4JiKA4RUHqbXJmouhpPvFJ/2TaSrYKoC71ji7IVOvXxA4=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;20:BSeYW0qmBAf61bbkiEw8vMEt4nDw8OXpawEWyZ4uzGOet28lD0JFogNZGSZHpDdAelmdeXSQ4R0NvC/f9nZ5xhYTMVK3xmq/KBpc/qOwiRdbCyoP4EePtkPBGP5VpSs5L0Uptiw/D+NYtS/b0KsQql0qClwARYJemIHYYG/nAs5/GhBgFBIX19VDdDSBcCZj5mKKIbk1OXd5V7YG3mte0zdzot7NBJCLV3fOz0q6p7/UGaRv/i/3ViTE/pFFA7hWnGYYhium8yblNebTiKQrT4YbcBqgxOBWy6sV1wfoDIpSz0sbmjys8mllzzpgPflbyruj/biGK+yl/3Xmcwh3qrMiweKjoYT7s8srePMDxipgglJT+T4XrPIcHMbbv2oeQ19tMeDTU2PFYm5rJvI/P25noNnXsyUM5o4h2D8/lqNIdkfPNl09D5PIYXqkwOKvFeJmnhHRemOm6GsuaF5xusLbpUiAABRHP8UYrfSJohg7Ah+TgMoTBRL40c09YgSi;4:fSQhnSuAhLYx5mlQmpBjd531onZH1qJM4XyvgUTgh2tcZBuL5uZVVLp0FA5boVibXqO3x339/h7o1NGf/vGWtN38bKyqDWPxbti4Sn0hdUdmZ0qrovUWh6D1Je3ckLhqARhI0uXvm9qk66s96a1p+q5af4YXQE3dOC4yVJoF87YwmJ1CB3VmpCQysQvOaXXm9FbSUZPniKS6hEgjAaXikMUbBZgvyp+cop1QGc66GQWDAmcTR9JB68Oc4Xnc2VyGceb3J7885iZhEHdaXVT24XShAfbtmwsq9SZeE6xV4mWBER/CA0J8OQ43//SyVBAk
X-Microsoft-Antispam-PRVS: <AM5PR04MB3267F985C1011363CD1F5BF0ECD10@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR04MB3267;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3267;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(1076002)(68736007)(7736002)(6916009)(47776003)(4326008)(8676002)(2950100002)(316002)(6666003)(50466002)(81156014)(25786009)(81166006)(66066001)(50226002)(305945005)(3846002)(8936002)(53936002)(6116002)(36756003)(48376002)(575784001)(2906002)(16526019)(26005)(3450700001)(2361001)(86362001)(186003)(59450400001)(478600001)(51416003)(76176011)(106356001)(52116002)(16586007)(43066004)(6512007)(2351001)(6486002)(97736004)(5660300001)(386003)(105586002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3267;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3267;23:qkzKDP1Cy4AdzFxtn0R2f0uUiJ8bX0DaVVQGgCnEj?=
 =?us-ascii?Q?xS6cLhP+9AzhVMBMFga7azD3EpDxsbklF4iCuHGjPzUfQ1jjxmLXwDokE39l?=
 =?us-ascii?Q?Cn4k08ocyZDRInedPYsWwUWHfTWUsNnfGtJolGnYoYfpK0ncR0S88xX16rIo?=
 =?us-ascii?Q?1i8wEdSl8jNd3O8Di9/LiGx7HnfizUggQvPtL/9GgedvN35JLTjhu0DCg+Pe?=
 =?us-ascii?Q?OTJ5tf8CwU5KGaiWL1eBGB26MoBnrYtBZm9S3ZDsfgY7T4t+U2fokHgEANOG?=
 =?us-ascii?Q?B/H/R62hhad6RMQgw3xMii+c7kTQc4KhnBpjchkNKGJzQgQAZMfn9bTXI24G?=
 =?us-ascii?Q?XJu0nXpUKmsvnOZp5zyC23dMWy//SICx8iHtiB+8NHWW3AqR9lvwW+y7fqVQ?=
 =?us-ascii?Q?ceokhzyz6rpKIRaREK35hbVrUQaypexVFLahEwXv3PH2VuyJ8KtBjRebMuzm?=
 =?us-ascii?Q?Q3lqaSGTjLx9LnkxzpVUN/dl+6hchZek4ixrJqzXIsa8I0mnuSR8jlcqsz+t?=
 =?us-ascii?Q?9GXCUUHtkvGajfOvKr8xRfwTbzqWJHi/uGoO0nPr2SS/tdwuFjM/FzA2g182?=
 =?us-ascii?Q?mr073tOKC67CowjJkVnLpFnoKaR1euwmKAZ3dAy6ThQAO/utYhCMUeg3m5b5?=
 =?us-ascii?Q?kAlrTj9DHibVv/cShpItCmiQO7yTlNSLZ9U+ZhoTSMfGRyrWQ+80GXGVuhhe?=
 =?us-ascii?Q?6t8d8jAqOv2DRZav9TdpNE5UzrP4QdxilIKD4nnVGfYO13xtg2Ct75s3I+h2?=
 =?us-ascii?Q?j1ANbfl+QUccoNwTMpysUPDlmtt6RaS3t9el88DyC1zXPfpiCBMwM4VurVIZ?=
 =?us-ascii?Q?Jv0M5bbuKb51GATOrGrqqm54DBJBMoQzclLkKSJwW/kF70+e3UwSrN/1j4Bj?=
 =?us-ascii?Q?JiWQAPNSIfteJ8m0UBADPlHXqnBGOvZQPJJmW0LThZvZKhDDgPRwRM5dKSHo?=
 =?us-ascii?Q?yglBqiPOKAOUlZNqjR6hbQenCau+9QfAG66YaQ3KU9uJJ3i5uWofQtTvhSXc?=
 =?us-ascii?Q?X7E3k48nrANjlpbVwh12d9+bZADgj6v5J0xh5FJQrf/+K4XZkIRkClHD3Tie?=
 =?us-ascii?Q?3sXyoBX0fOhCrqBhnTWOBgHNpc70qFhq5Z6a/zH2Wp0RkE2nMwXev3KOqJQh?=
 =?us-ascii?Q?ITW4U7LGG2QvTdAcuCisJbRQTM0tCrS+4zxClrj9kR/HfCODAL/QkBspmzYq?=
 =?us-ascii?Q?JNxgRu6p1he2cJU88PrPOU9+dr800otr4a6pQmZAJWpcH09qP1pgD0JfVqQv?=
 =?us-ascii?Q?yXEAtljdgCiJkJTLCE=3D?=
X-Microsoft-Antispam-Message-Info: MLZSgHL8flDorHUgMmD67gFClIL5dUDj+WOQkVL0rr/htp3dAptN9ffcf1j7FyyxGlvX0a5zl46o8zF+mpCZopc+W4gGoE675d5jDuiziU8wI/GuG0V1ofcd8l6QIy3ISMO8cD3YlwtryRfpBsxL3v8kVilkzy/rq/oXmsviWUhcz7ZMzHdRprc1T6WA9/mS
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;6:V1MCcRw4lPO4NnhxK/OwexwqkbvbzvnOMU4HWj4fhNi8uXbCgu++q7o3qH1loyFFfMU3AZVAiNv6DIsOLy5GA0UqzGqSszB/mVgWJwXDp1KuGRGQM7E7Ze1vWQhXwrm7bcp1FTXTPaCSExDMpHJ8xBf48DsdjUUDW5dB5TMjdsGvg1ukYi6QaZddcaPzsIC4zxZ6ytCoQojHJfLsnr16HqxGV2vsz1piLtlhEX5zdJ1R8qNt7dDfAOHhWXYm1EAwxfSek8gw/wqY++pFc0g1Qy1n2DPepkjWCAEFy5bY/Tv9QRoKQwIcPSvL2m4l4uM2Ns9rCIIRM/Q+pg6bQR5ToM8YYpHfgvlde3kJezPoqOk=;5:IRiuRYOTelSBA6SQDOYnf+zbuCfweGFdfTFRQLdYQeV8Ewd4u3hQT/H3TKL06oHDf/c4UYCaHINHzcaBsf4vbWPe1fq8OxRst1AZvbnHqw/UFRYbQThCzWOD/iGQ0ENG8hVBNCLm2Rd3TqB8Cajrzx/ChvIMsA2g1o4q5XUneBQ=;24:MHoS6X6sk1P6dgeRw4nxiRAaSrSwo1pvp7EEDpbQrtLsQbTuiNPMthtCNIuiYc/+UepyGSYBWOIhkBnguZcPAaPrbRVmN5wvQ310KW+nxR0=;7:/oxRwlLsi2j4FveX2Rja2I797W+aAxag67xu1jSYILUofGHxuTG86RuaYTUMIracp6b7IT+FYROHkVg+/eoDkmR7v2VCQKA91W0Gv5fx8onBfHPcwYz9NhO2kdQmnLL6Ef7nT6PF0DXokFZhShatV23tirwy0WzopVrgjuJ8P0Jzb9x+SJB1qTcB5pK76hETBP5w9eTFzZQ09C/pIeecr3Rp3uSN7vLuYOfj7bDbhf+f84iPg5lJYVnd/4WbwgTM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 13:38:29.2738
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b26256-a1a9-4779-1f72-08d589b0dff5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Camelia Groza <camelia.groza@nxp.com>

The fd_format has already been initialized at this point.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 128e0a4..3e83d79 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2289,7 +2289,6 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	vaddr = phys_to_virt(addr);
 	prefetch(vaddr + qm_fd_get_offset(fd));
 
-	fd_format = qm_fd_get_format(fd);
 	/* The only FD types that we may receive are contig and S/G */
 	WARN_ON((fd_format != qm_fd_contig) && (fd_format != qm_fd_sg));
 
-- 
2.1.0
