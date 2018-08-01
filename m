Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7B120841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WVQEeCkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7B120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390116AbeHAR4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:56:42 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:32032
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732937AbeHAR4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6T5j3mElnItGWjXq8bit5YJH7hzHyqjvgUc+k28whI=;
 b=WVQEeCkQpwn10nFAfdfBeEzDaw0zGuQ3DbDn8GR/qdPjUNoygJxkGdcrMninzUmJ+1zhZJ9APK97ZGOFMSKcZBbPyuRKUSOvWDLFr5/rTWVZXAACTbq5XeiZuc6XsaOAEAMyu/PQOO0DG3O6Iu9zlMxmLoIZ45JHzqdnK96LSu0=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB338.eurprd04.prod.outlook.com (2a01:111:e400:881e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 16:10:09 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 2/4] staging: fsl-dpaa2/eth: Remove dead code
Date:   Wed,  1 Aug 2018 11:09:49 -0500
Message-Id: <20180801160951.3350-3-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801160951.3350-1-ruxandra.radulescu@nxp.com>
References: <20180801160951.3350-1-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN1PR12CA0093.namprd12.prod.outlook.com
 (2603:10b6:802:21::28) To AM3PR04MB338.eurprd04.prod.outlook.com
 (2a01:111:e400:881e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb58a04-d747-4a1b-852c-08d5f7c9418e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB338;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;3:DhjLFiWU3O6gzvXC6NGtklCARh6CCTWHVd4UquB4UdUzCD5riPFQ3+KtAVWUYLJWdBY3Y7Nx4RPKVViWkJV52bveW4y3t2Gf4E+12t+tY180DCzGT92IJp3Y77a53DjW5k1LVuTN7ce/5BwexwqvfQ0J8Xk22hHCKSMBSrrWO3o3VLkaEPI/7nInKvsHiVBNx9sv74XySTBNE7lYQybEhgRV3eRF+eZbTl0wPjm0UM7kAKWkdoudSV/uyLZE0UxX;25:N/F2R3PvMfOfuz+kFcKlE45P4P6ouVhU/owvxx3fGlnfrsa1/Ftn97w6cYDyuaEYAMzpAooFLAua4HGs7BYjNedzwRgC9wXa+APLz9+Qs6+1Helq4C6nnLzJKnH/2NPU8lORmMriLLQolERmq8yuBTpeLRzt6m2N26cpWZgnHcjHt7Z8QG/UYStxj2NcWHfSApoTGnrJ9XOBP8Z2cxE4QwbCykcZzs63QdvTPZXYK/x6SgWcF/Nl8xFZs1ljIvuvbbEy44rqC2UTu43zo0ztyW3dLmlchFCDDU1Zm1ZUHuZ40hoTck21eBMcQV42JXw977zkm1W7xiCd8RDNJLMS/w==;31:IYuAypx/1DoOXKYuM8H/U6z5yKcPLeGQ3YsXJE3UfqH2nO1X0y2kYwc9E5JggZL4rOPRQisBXKUcjgOB2V56nApB1Y6m3SSBOAcGbCIK7z0vQjHrZGGp2/55Jr5LXquV/HJiK3LGHy+OFSfYumpKcHy+Ow7EoVUrlgB25u/OGY/O3DT6NJBTyjGwz6ySpp4vvRzr4pq3P8JUWX1OgxFlR62XxdcxxRzfg31BzCB001g=
X-MS-TrafficTypeDiagnostic: AM3PR04MB338:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;20:vdwpaxifJFbYjjwT8RyLPLY0SH9W5KxdPS0zbn8A9qJ4ny3cBcq7esM/atbgwiq7xj8mpyF+bcIWQWlCFcW9XCB5lN+U37WXYKlyPH6wv3j+AKJSdxumkf6VYuaVUwqgBGiX6tMYvDDPqwoLiaTdRJGDRDjXWGxYEEJcrdy17nS+ajTr06P8djjM5qFnH8CwW5WqS2+1TX+v9GV+NQkNkghDEHCbNqYu5rCGkk+gJ3ojdWbur4Rgfy6hD2j7/9ZvTvmBquVtoSN1mu2EQnuXBsTSHHlihCBI95hYm1OeWbLZ2T3EvhYEO5Su2xHgybABYGSSprfRkeXDHBgRPBQQUP2L4AsbnbKsl8gKHTKdlAJZbETJiJtba7zo1ONsh8qJrL4kmVRVkhaoZ6JojuUhw0ZCA6mCiF00FeMDI1IaGTbR5IWhtLQSAJmhJleTxsMcuIwmLv0RHF+xDw1Jl/lZQxkxSlYi2Z33s4aDT3RjpMdELAxaBUYYzr3+TPSMHrQk;4:zPzolknWP5WxysN3ZA79kkIiqRAXcmKcwUvBY+LAB0xTe3+BfdPJko9whCUZirKgGZLFDwLE9lInsF8i0JOEng21HRztW3YflFeozRW7H5t2LIJWsXsWEsSZk0KSAz3eR3zBR6ampxZh5024xLhwkRk3U04+7yk+ng/qeHhifVGKcVrC5G/wYr1P405Pvbw3tMKjRZJ72LGUT0vVMFSlGMsnN1x1rx7QYE2xvUqHXwqXwxarWX3NW4Ua2hmY6SiJikKsHOVlSEL4nvrN1hfzi5iINecVguN0jPzWu5B/4TEqmRebxJZhiNNnrLgKzdZN
X-Microsoft-Antispam-PRVS: <AM3PR04MB3381FCAA941B80D0527B7B4942D0@AM3PR04MB338.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB338;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB338;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(5660300001)(186003)(2616005)(8936002)(53936002)(16526019)(2906002)(11346002)(97736004)(51416003)(446003)(68736007)(486006)(476003)(956004)(2351001)(50226002)(105586002)(81156014)(2361001)(52116002)(478600001)(26005)(6512007)(7736002)(8676002)(50466002)(48376002)(6506007)(81166006)(1076002)(305945005)(6486002)(6116002)(36756003)(66066001)(6916009)(47776003)(106356001)(3846002)(76176011)(6666003)(316002)(25786009)(16586007)(86362001)(4326008)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB338;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB338;23:wS4AuIfLw+9DpTZ/Hhg8/5ol5mCIOm2M8mqiCDtcyq?=
 =?us-ascii?Q?nCJOYc3Wm0Wpik2HbYNNTW8bVLyZJwYk+kLZPIlTWhM8sZZ62ZDJ3AZzyr2z?=
 =?us-ascii?Q?ovfOwFWWfkOPDTojav9CKWJ5NjX4nihvJL2QuSB27SJgRgQkO67ZQ7dyfnrr?=
 =?us-ascii?Q?Fro9tUNDLa709znmelCoGjpOH+xe0RErHC5WtxtTd2gsSjPjuETjFllrIJCP?=
 =?us-ascii?Q?Z/u29p2WL1EughXI4q3KeZeqRxu/uqZ9Sl0dyCti3dnFAyTpN+o/8nZpE4HS?=
 =?us-ascii?Q?p9BaehI2uC7wVEmMiTa3k0mXKYj/ZTmygVRiUHy2fKZYxnQAbm5EJ1Gbv0Ge?=
 =?us-ascii?Q?UVUTygYTJBQR+buF5WCDDo8cH6AbYIKU+9m3e11Mm7ERyDKjG/zGPx5p7nGB?=
 =?us-ascii?Q?RaPwMJnarSScMGpp8UfmwgChu4kREHxtoU/avLmqSlK/Tq3sGIBQZWsarq2q?=
 =?us-ascii?Q?5Wh5+084NpQfVUj0rUF63NQYXu3fGl2CyQKNtbavzO8OEFAIX+GI62B8WuYA?=
 =?us-ascii?Q?i2iPlpALsnAJQG5QJQe0F/yMAEUNGZo05SapQqFtq9FDUalTws7j24De1SWz?=
 =?us-ascii?Q?sAHbXMF8YPkOJ1YSLqjapfTGgttyHWlmP10CCltXirSym2ztjLOuBiHFt7i1?=
 =?us-ascii?Q?erFnyw0LXexXvPsFeNS2BvfPFMKPoIeeBtpGenuHS+3kE8Thm+QW3m5YcAWe?=
 =?us-ascii?Q?QNHMqqM/Nic87Mxu+Y+DHqNHIi3oVS8xLKS4hhL1Yw7GaI5MS21DPDHwMIES?=
 =?us-ascii?Q?xZtvoPpSbDMiZy3nXHQuRTDAru6GEXy0Uohwok7G7uJltR4xKlf5gcQppqBo?=
 =?us-ascii?Q?+qJ5DHI5ltfossEbD4es3z8X+2hIkfQq6ak3lDr0bDEKxNKTen1BBOrIfFPH?=
 =?us-ascii?Q?Ea3Hi3vwkTWy0B3Azy0I388AxzPmmdVM8Jy9ZDmS6BkjtC4zwHdwwARAk60a?=
 =?us-ascii?Q?n/fWuuI/kYAdH2376FCHppoYQDJoRmDTeqUYX+2e6wBsCFSqFdJPXgV/vDLJ?=
 =?us-ascii?Q?QnDM5nB311b6k8ZX3ntfXmmxqN3TjEQjdKH2OiAwW8+ehPGl90Ix2KRJib5j?=
 =?us-ascii?Q?9DH526Un/I9Cvy4Mwz3rmMCulpMccIspR+hj5aKSHw3A6TSptU/9JEKoEoIP?=
 =?us-ascii?Q?yu6aABoPg80Kik/DlVyczg9RQIacXXBzA9/kgpi8SHBZTRTRCxoQpeRI682W?=
 =?us-ascii?Q?A/8Y2pk5m1JlUemFSjNCeVXYbq5zSqltWRiO4TfI2RFai1yj96MBQgpg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +xC8VB+tHyGyAx4giHWssIWF4uBKUKuxo1N8CUEiyebz7dB6bScsqOsXjxxl2yVAZrJ/g+4+VThZF8pXWPE9+P0tKU8XhO4A5y6YHSjWSZRDhfEGUqYynvPW2k7R1tfqwhPHQOTULyy3t1cgybm9ZQY4DRQIrNq14adXsftrlWZik2oi2YUYcaMZ4iZBzK7RJHMvWXLGW9dc4aWw2D7C8NbSFjOvfD0JDpQDsqRU6Ymg/mcVGR3o1/9VIJ3kgYOMwVB6YUy8832yXz9gNJPvKmMuPgsTH/O9EEiKZz9jjbprqiIPCRGAL+B1Yn7qyeTMunJGnlxQpVMybi+b2FFD3dMFEAxthVhtShq1sUl7e7Y=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;6:OxgrvPE3zim/JoZ1Ev6Mo7I7vPwkuoJVLr7R9VzadtfeW3WZhJkEd2lX8iYivdbxitDOswY+dFeqG+G9NF3TAnS26kc6qZTrq+VsgDbAqcQ2/bUtRZw3i3QWBWDi+vp6TvkIY/f0KS3VgmlOjaYPdHoKkGIPt7ZD1naP+xlXuZFIHOOouW9mRBMZl24e8kXd9uNqutRmd9CwR5yiAKdYJd5yR8BrDfMzdpFELEk35rKrJw8m3MX4g6ioXtmO8DQyZxZp1/It5OpUrEGj3oAwQ9MmF/ifZLJic5mjugx6RP/YX3wUUreFscoFIgunn5bw5kMaj1p7hFAWPOlOFPjrRjfQoiLZylo1mjxaSWmunpoZOjDzzhPPX0uSCvwi/BTPvyFvba279mLb4dbHim2Jc4gLckKM/ZVj4vRTbGt1n4Voln1Zuh9GVCUq2nvIYr5QoXofpfIfUqt2pec8UnBf8Q==;5:8YFpykdtEUZQL1/+0Zy3aJ0R4WTRjsac/tRXn87mkMsp/PJ4VidwdMhuFq/rmoB+RW4ouaF7C+3lJq8k2Z9t4GSuBqI2+cuMaP6Jo+oZtKNAzQ7HKaI5Ru9n+1sDIo9/hd7sL0kpfyeVtFX7vu5mnDXzS/bUW++Gv/xgQGDo6uA=;7:KjVmCc6EcgW/Z5UaYWD669jn6Qyreu5HfB/95fxqOeGYlilLX/Mr1DtFfSh6V5yjvmUwO47rrK1c92CSquzJnbYbrsEyRtqKh0M7WRT/y2VkRncTrmv2R7IClH8uXTJ1l/Hg3rlXjkJ9iud3SFSKHYQPHCSF5/2h8LKu1MIDF7Lg4lr8snK4ASHwaClXT3nfB1CaYM4TSR8bBq8CUMKy5Sifi3UAGdKigeHAmgkgGUh2XCFTVf6rMNVlleBa4Prq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:10:09.2514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb58a04-d747-4a1b-852c-08d5f7c9418e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File net.h contains unused defines, so remove them.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/net.h | 85 --------------------------------
 1 file changed, 85 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/net.h b/drivers/staging/fsl-dpaa2/ethernet/net.h
index ddea940..2461d6e 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/net.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/net.h
@@ -4,8 +4,6 @@
 #ifndef __FSL_NET_H
 #define __FSL_NET_H
 
-#define LAST_HDR_INDEX 0xFFFFFFFF
-
 /* Protocol fields */
 
 /* Ethernet fields */
@@ -17,8 +15,6 @@
 #define NH_FLD_ETH_PADDING                    (NH_FLD_ETH_DA << 5)
 #define NH_FLD_ETH_ALL_FIELDS                 ((NH_FLD_ETH_DA << 6) - 1)
 
-#define NH_FLD_ETH_ADDR_SIZE                 6
-
 /* VLAN fields */
 #define NH_FLD_VLAN_VPRI                      (1)
 #define NH_FLD_VLAN_CFI                       (NH_FLD_VLAN_VPRI << 1)
@@ -42,8 +38,6 @@
 #define NH_FLD_IP_ID                          (NH_FLD_IP_VER << 8)
 #define NH_FLD_IP_ALL_FIELDS                  ((NH_FLD_IP_VER << 9) - 1)
 
-#define NH_FLD_IP_PROTO_SIZE                  1
-
 /* IPV4 fields */
 #define NH_FLD_IPV4_VER                       (1)
 #define NH_FLD_IPV4_HDR_LEN                   (NH_FLD_IPV4_VER << 1)
@@ -62,9 +56,6 @@
 #define NH_FLD_IPV4_OPTS_COUNT                (NH_FLD_IPV4_VER << 14)
 #define NH_FLD_IPV4_ALL_FIELDS                ((NH_FLD_IPV4_VER << 15) - 1)
 
-#define NH_FLD_IPV4_ADDR_SIZE                 4
-#define NH_FLD_IPV4_PROTO_SIZE                1
-
 /* IPV6 fields */
 #define NH_FLD_IPV6_VER                       (1)
 #define NH_FLD_IPV6_TC                        (NH_FLD_IPV6_VER << 1)
@@ -76,9 +67,6 @@
 #define NH_FLD_IPV6_ID			      (NH_FLD_IPV6_VER << 7)
 #define NH_FLD_IPV6_ALL_FIELDS                ((NH_FLD_IPV6_VER << 8) - 1)
 
-#define NH_FLD_IPV6_ADDR_SIZE                 16
-#define NH_FLD_IPV6_NEXT_HDR_SIZE             1
-
 /* ICMP fields */
 #define NH_FLD_ICMP_TYPE                      (1)
 #define NH_FLD_ICMP_CODE                      (NH_FLD_ICMP_TYPE << 1)
@@ -87,9 +75,6 @@
 #define NH_FLD_ICMP_SQ_NUM                    (NH_FLD_ICMP_TYPE << 4)
 #define NH_FLD_ICMP_ALL_FIELDS                ((NH_FLD_ICMP_TYPE << 5) - 1)
 
-#define NH_FLD_ICMP_CODE_SIZE                 1
-#define NH_FLD_ICMP_TYPE_SIZE                 1
-
 /* IGMP fields */
 #define NH_FLD_IGMP_VERSION                   (1)
 #define NH_FLD_IGMP_TYPE                      (NH_FLD_IGMP_VERSION << 1)
@@ -111,8 +96,6 @@
 #define NH_FLD_TCP_OPTS_COUNT                 (NH_FLD_TCP_PORT_SRC << 10)
 #define NH_FLD_TCP_ALL_FIELDS                 ((NH_FLD_TCP_PORT_SRC << 11) - 1)
 
-#define NH_FLD_TCP_PORT_SIZE                  2
-
 /* UDP fields */
 #define NH_FLD_UDP_PORT_SRC                   (1)
 #define NH_FLD_UDP_PORT_DST                   (NH_FLD_UDP_PORT_SRC << 1)
@@ -120,16 +103,12 @@
 #define NH_FLD_UDP_CKSUM                      (NH_FLD_UDP_PORT_SRC << 3)
 #define NH_FLD_UDP_ALL_FIELDS                 ((NH_FLD_UDP_PORT_SRC << 4) - 1)
 
-#define NH_FLD_UDP_PORT_SIZE                  2
-
 /* UDP-lite fields */
 #define NH_FLD_UDP_LITE_PORT_SRC              (1)
 #define NH_FLD_UDP_LITE_PORT_DST              (NH_FLD_UDP_LITE_PORT_SRC << 1)
 #define NH_FLD_UDP_LITE_ALL_FIELDS \
 	((NH_FLD_UDP_LITE_PORT_SRC << 2) - 1)
 
-#define NH_FLD_UDP_LITE_PORT_SIZE             2
-
 /* UDP-encap-ESP fields */
 #define NH_FLD_UDP_ENC_ESP_PORT_SRC         (1)
 #define NH_FLD_UDP_ENC_ESP_PORT_DST         (NH_FLD_UDP_ENC_ESP_PORT_SRC << 1)
@@ -140,9 +119,6 @@
 #define NH_FLD_UDP_ENC_ESP_ALL_FIELDS \
 	((NH_FLD_UDP_ENC_ESP_PORT_SRC << 6) - 1)
 
-#define NH_FLD_UDP_ENC_ESP_PORT_SIZE        2
-#define NH_FLD_UDP_ENC_ESP_SPI_SIZE         4
-
 /* SCTP fields */
 #define NH_FLD_SCTP_PORT_SRC                  (1)
 #define NH_FLD_SCTP_PORT_DST                  (NH_FLD_SCTP_PORT_SRC << 1)
@@ -150,15 +126,11 @@
 #define NH_FLD_SCTP_CKSUM                     (NH_FLD_SCTP_PORT_SRC << 3)
 #define NH_FLD_SCTP_ALL_FIELDS                ((NH_FLD_SCTP_PORT_SRC << 4) - 1)
 
-#define NH_FLD_SCTP_PORT_SIZE                 2
-
 /* DCCP fields */
 #define NH_FLD_DCCP_PORT_SRC                  (1)
 #define NH_FLD_DCCP_PORT_DST                  (NH_FLD_DCCP_PORT_SRC << 1)
 #define NH_FLD_DCCP_ALL_FIELDS                ((NH_FLD_DCCP_PORT_SRC << 2) - 1)
 
-#define NH_FLD_DCCP_PORT_SIZE                 2
-
 /* IPHC fields */
 #define NH_FLD_IPHC_CID                       (1)
 #define NH_FLD_IPHC_CID_TYPE                  (NH_FLD_IPHC_CID << 1)
@@ -324,7 +296,6 @@
 #define NH_FLD_IPSEC_ESP_SEQUENCE_NUM         (NH_FLD_IPSEC_ESP_SPI << 1)
 #define NH_FLD_IPSEC_ESP_ALL_FIELDS           ((NH_FLD_IPSEC_ESP_SPI << 2) - 1)
 
-#define NH_FLD_IPSEC_ESP_SPI_SIZE             4
 
 /* MPLS fields */
 #define NH_FLD_MPLS_LABEL_STACK               (1)
@@ -338,54 +309,6 @@
 /* GTP fields */
 #define NH_FLD_GTP_TEID                       (1)
 
-/* Protocol options */
-
-/* Ethernet options */
-#define	NH_OPT_ETH_BROADCAST			1
-#define	NH_OPT_ETH_MULTICAST			2
-#define	NH_OPT_ETH_UNICAST			3
-#define	NH_OPT_ETH_BPDU				4
-
-#define NH_ETH_IS_MULTICAST_ADDR(addr) (addr[0] & 0x01)
-/* also applicable for broadcast */
-
-/* VLAN options */
-#define	NH_OPT_VLAN_CFI				1
-
-/* IPV4 options */
-#define	NH_OPT_IPV4_UNICAST			1
-#define	NH_OPT_IPV4_MULTICAST			2
-#define	NH_OPT_IPV4_BROADCAST			3
-#define	NH_OPT_IPV4_OPTION			4
-#define	NH_OPT_IPV4_FRAG			5
-#define	NH_OPT_IPV4_INITIAL_FRAG		6
-
-/* IPV6 options */
-#define	NH_OPT_IPV6_UNICAST			1
-#define	NH_OPT_IPV6_MULTICAST			2
-#define	NH_OPT_IPV6_OPTION			3
-#define	NH_OPT_IPV6_FRAG			4
-#define	NH_OPT_IPV6_INITIAL_FRAG		5
-
-/* General IP options (may be used for any version) */
-#define	NH_OPT_IP_FRAG				1
-#define	NH_OPT_IP_INITIAL_FRAG			2
-#define	NH_OPT_IP_OPTION			3
-
-/* Minenc. options */
-#define	NH_OPT_MINENCAP_SRC_ADDR_PRESENT	1
-
-/* GRE. options */
-#define	NH_OPT_GRE_ROUTING_PRESENT		1
-
-/* TCP options */
-#define	NH_OPT_TCP_OPTIONS			1
-#define	NH_OPT_TCP_CONTROL_HIGH_BITS		2
-#define	NH_OPT_TCP_CONTROL_LOW_BITS		3
-
-/* CAPWAP options */
-#define	NH_OPT_CAPWAP_DTLS			1
-
 /* Supported protocols */
 enum net_prot {
 	NET_PROT_NONE = 0,
@@ -441,12 +364,4 @@ enum net_prot {
 	NET_PROT_DUMMY_LAST
 };
 
-/*! IEEE8021.Q */
-#define NH_IEEE8021Q_ETYPE  0x8100
-#define NH_IEEE8021Q_HDR(etype, pcp, dei, vlan_id)	\
-	    ((((u32)((etype) & 0xFFFF)) << 16) |	\
-	    (((u32)((pcp) & 0x07)) << 13) |		\
-	    (((u32)((dei) & 0x01)) << 12) |		\
-	    (((u32)((vlan_id) & 0xFFF))))
-
 #endif /* __FSL_NET_H */
-- 
2.7.4

