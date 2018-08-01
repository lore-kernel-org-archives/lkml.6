Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C523DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E4C20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ri2anwF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E4C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390065AbeHAR4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:56:39 -0400
Received: from mail-eopbgr10069.outbound.protection.outlook.com ([40.107.1.69]:32032
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389988AbeHAR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdCnix+rsORK1W9GM/v6yZhGsSdMcMtdDfKinrWwRE8=;
 b=ri2anwF9zkplsojMmEIHp9G1fM1o32VzJCW1gptpyBi8nLOx+FvUIj3pxaKeY/T8g7tyMQNwwC2KDQOT2x8SbYXbHZaAEGxAbxftucniYuqUWIqN1lYITpefTFkGFynUjylinnHWzsk953v8E3SIZrluoTb6+KmtqzZbqtBY+1I=
Received: from rhuath.am.freescale.net (64.157.242.222) by
 AM3PR04MB338.eurprd04.prod.outlook.com (2a01:111:e400:881e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.19; Wed, 1 Aug
 2018 16:10:07 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 1/4] staging: fsl-dpaa2/eth: Cleanup comments
Date:   Wed,  1 Aug 2018 11:09:48 -0500
Message-Id: <20180801160951.3350-2-ruxandra.radulescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c4a9652-eb5a-4903-2d03-08d5f7c940b3
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM3PR04MB338;
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;3:iFmUDv+qB/TgSCn8Ljjdh9wtG0zzz/i6vmB4QAmg3cZ4qPXIi43O0V/ceSB9RqiDVKEfg3pSoZZMFXQxX+xHsJrsMkXraHAKLcFA7347IuRWKY7VsY2+LTq0+1wkGbupdk0+ucOBuHKlRcUiUoCutWsRIMDSnq9a1FRFe3w/pAkL0wRxksv2WFvMVAYX14wrzYhe6UlWhqCjcXiK69W4MfVoE9dYECVl04nWSVtBtJK1WVc+6ZzGfKxgRs/vVgGe;25:UlmGb2OZrr8ADpQmJr5o3xehEi5v60AcJJrlOEbWAVCD0wjw+yhytWrb+FYkYjTcQElQR5i3z1WItQcne0AP2CV9LNYSuy2CkKaWrzQZU1RTwHcQZXmdrBoCK8nCNQyejMGlhxY9wJ5k86V6wlDaCf+q8eNOQdfiphySEoBPc2QUBS7Qgr/x+LzyCZhsY8xPNfMZGWFI7Ot0f3bhqxrSiBFFqaDAGmQkrhto7pg0GTGIQ+4Q+6Rfg8W/ep2gsR1m6uc4SVyTLJ6km8ZoL5n6mpFtlyiV5/AAH0UXKyKsDB74m5x7vFFsD5pomU81fFiZqBTMByBhoDF99PB2wSMH0Q==;31:geOqtl7zQ/8cx5gU7tKNDHdYhc+ErpK1bIvn8BkzbFo7fCE+jVs/yjfJcVO5OrzxgdNOnXu5bcX9MeMzWMykoFhsplAqWQX2grWhA0vN44fAkDztgMTeF6asOu8ox+z9ikQ1kodBpQJ8I5KjdwfXvL2jlkKyJ3gcOpDDKVjwxgmr1kfyLJUrprwWF4knT8KINg7ewBzHSIaz6oYQ8ZTUBocPTYjtXh3Rt5dmidD86zg=
X-MS-TrafficTypeDiagnostic: AM3PR04MB338:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;20:i2EBCIyrkN4vDcsBj906YCoK4uPung59Xk25mNciUpGiUTpQ0C1gP8otuoL/BaysaprZ66hvMykrmKCIWXp+3UPkrBVdRwikEv/+mxYhB/wjcjL4l05TaDgNwVU4ARHfiTJGA2qSf7eel4EgjHF91yEk7sxgTLF+ZxkzUljOw8jrgvMSQvXmWT7QkGmYASBPflL2xfU3xbfnHMDM9K+dRXTDzQmLdR0dbGIHM/ZngRugWujCMdeDr6OroydBfaDT9UmLFefkmg34S3s8IXRSw4FYDYq4WEemngyDy6QZEB/rEPUOf9iDDRmAW8dc6Do0RTqQG3JIKbwvr9+PWL8vvlTl0bQ5oM4cB/5iJDhdppkZ+mJTqAZfXRGkuLHdEL/5mtf4732zLsIetahWzhNILbxJf8KEYco2kGr4ZPoFihX8jNgtom4MYPLMeCCpsGy6nhLTi4xsJivEOcVScE4iak5lUCJAl7NZXaS9EcqZ6caC44t6mGTIDWFaA1LDk7i8;4:/ye9FOfDsF++WDQqKDnFpipfB9wHXprMICnXNW2Dk7wN0FbK3iHbMzBXxrtOONbno+vBHH27SZ0RH39Ghe0QTVC7EBH6Zkwav8g4S+cVCsXQRcZNcRKLngjrys6WnPEQQeBrECsPDnfl0J60h5IKu2RtqSESrUEJCSS2VGC651gs58EgatD4tEiNWvnX++GB1I50IFVo9ePGgUChbU6cvSSNYJRjNlNBqqtwcHv0uoxseDJ8Ehcj+o5QmqSV4HC+CHu7exsf35Bwf8dyhlv+gS2NLUFfivbMcQe2DPWgEusSPNl5vydftIkLeZFbF3Wi
X-Microsoft-Antispam-PRVS: <AM3PR04MB33801DB9639DC3917EED9A6942D0@AM3PR04MB338.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM3PR04MB338;BCL:0;PCL:0;RULEID:;SRVR:AM3PR04MB338;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(5660300001)(186003)(2616005)(8936002)(53936002)(16526019)(2906002)(11346002)(97736004)(51416003)(446003)(68736007)(486006)(476003)(956004)(2351001)(50226002)(105586002)(81156014)(2361001)(52116002)(478600001)(26005)(6512007)(7736002)(8676002)(50466002)(48376002)(6506007)(81166006)(1076002)(305945005)(6486002)(6116002)(36756003)(66066001)(6916009)(47776003)(106356001)(3846002)(76176011)(6666003)(316002)(25786009)(16586007)(86362001)(4326008)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR04MB338;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM3PR04MB338;23:BkVwZCNXVLkgL7NBiEf3oFUlcA8L8SL2VL8yVRnLRy?=
 =?us-ascii?Q?ek2lISIzt7j3e+SFmFXlg21RJoP0j6W2TkWCVL6IafoETuhiPUdhtNt2/FXz?=
 =?us-ascii?Q?NtOJG9nRJZmeeczWJrxtMs+yID2dTIvYHXvnJOP8WB89mqDM8heMvBb812cD?=
 =?us-ascii?Q?rue1bJN8CrgI/U+g5NdK7tRq7T3eX9iiXT11u4K9bz0NkDMdUjwk2R8MnMpg?=
 =?us-ascii?Q?SiorVmjWPX+TyKXH7qWnW3koRXt7NkVM+zaD9jBca1ro/V/Y7heINeY9tQiT?=
 =?us-ascii?Q?Sw1dEZyFNqxvV6e734Thw1eynwfppN861Ph7S/63Iy98llMsl7Ew6+XNvC0+?=
 =?us-ascii?Q?PFXs7jdEiER6KEGo3mENxZybRa2AU3cIFjc0ToGJApglMAM8QjSYEBPCzzlQ?=
 =?us-ascii?Q?Bsal3GSjQ0rg1TzLwqJlUDurjKWFMrZQ6/d41zOVH1uV9svgfwn2Gtv1dkYi?=
 =?us-ascii?Q?cyNDG1Ow1fUeNzjSZDXmBO4YGgt5uR4rHSTZLgrA/2xrymWcMDT0mDUnIC8i?=
 =?us-ascii?Q?gJHz9exCyjcnT7raXPKTLJeCsDegIE5YYsRhd+rpZZww1ZJghKWCY8tumIfI?=
 =?us-ascii?Q?RNFsI/Nsso30ay5tzjZjj8/FFF/lwRd9yVrxDs0Zpx0tuNnIXZsyYQhGx0ri?=
 =?us-ascii?Q?+lRONsOQ6HskTWpJxYBuZtpgbboXiXFCNzARmfyqugoeamQYEO7M2E5Ux2hs?=
 =?us-ascii?Q?l5Ebu65IKhIZ/pzbhTtSQhr7qRexULxeK7eY8R7UnGqV+wTKyVhtNx7AhoE5?=
 =?us-ascii?Q?hOT0FGCFJ8PynvvX7KVpSGZosqbawFHglQB6qffsAuiVYB/bNC0D3MBQ1u2n?=
 =?us-ascii?Q?LrIKQLthGlxusYrIjrfE7d7AlRthUOQ/M1JgNENICjk6lNMGA9Qqg/tcU1E/?=
 =?us-ascii?Q?Ocy09xlyJ0L80xAzgg9j3wk5w/9gELkeyGbdgy8UcKMTXKzOeUbopG8G7jgB?=
 =?us-ascii?Q?sezLKGQmLHhrHwh0ehnDV8gL+jdr66snQJPFK0dvJWAqS6TLyF5pmrDGTnrx?=
 =?us-ascii?Q?jj7hAabxrhercVoEwybKN7Cws/NUG+T14Y7+nD3iH3eqA92vWuH7EyVmv7pk?=
 =?us-ascii?Q?NSvz0kxo7CfbL3Nktdcq9rjv/SvNxz2KcT/JeiMoqh82YHaR0GB/QXSeeUWx?=
 =?us-ascii?Q?qUuBGlzlRqjUSu4QkrQ2Yv4KGnUWzDwRxCLjAGlc45UxbzB5oKC6z4I6t7Uz?=
 =?us-ascii?Q?d3aKKXK0YMuv8FDaMZkbTtXN3tPAl3OWi+4TewwD7MQhPFr4TOwV9Kpg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 1Rhkjw2K66ILzQ0Ww6bZPVWEFfq5lGLOpDleehlyXfNFO9Q0qv0LIUf99bMe3Oy9eH0YM836LlDOuQuZmmE5L+nMJlGFWVuEBiPo749UlksLhaj2Ut5LnRhzv7cS1shTvOQTRY1eNw95Yy5/nsITPmGdXlMBUFMK7LYJ8R0H+fktWo4SEThpuZMSLSlCry1Fp4LsBC+j9MBWnRE8c19nRjvVIwd2byY/9muyKg9WESFb1LkbQl+zC/k1O9kJMf5M978TmYzJQIoy04u80VeJU97nVRlQFF5MVKsCN5Lll9cYuxcheLexMqOI6kqXzj6fTRMLXhwO83ijKWIMT19XhN//rsa82o1wh9jXuZcxhi0=
X-Microsoft-Exchange-Diagnostics: 1;AM3PR04MB338;6:9u+DCDPRf0pozApZSDfdwwB+0U+9V0xYhpI88vr+dLwOf+dWhE1pZiD1Jasp43fTXlQO5Urvy7WBCwyXX2Myk7Ec1ILPujy1Jey19AA4h7HAjWTFWOOVQ3b0tsSWyurSlHbjfnSUN2JyWyQoq3XHHjQQvP+0CdJYRx++8WoUE3zZ9rloDwcsNx/S10jIQeALtWpr3wYnoqqdeb6ePA0w4Cz5g4li148/UHPDOXuIV31vsW4vBIo7z2PkfG77PMjLAmkfgmdlBkdqPR1ROygrt4OO6JDFdnRBZfb5QzuWrh97D/p5MyTx+OsKTbPwZtR7bBzYNyYE/LQ3i9XkeGjBZlgkpVrEvuO1UylPZinPO19TOoLi/K8qQyVSaf0x49jnxrsVw0FTbO8gFz6lRvE4mSBZwcnA7mEkyYa2eXMI2H5JgQskv8ZQEqJHLQMJUTuZOYNhJ7p/5b7pSYpLmfdbig==;5:M9xkh+ohNKCsrdh9r38D3fh0WGM3tJarve5+1QtRtd8nC27WgGJ60G2+Q1xaCOmKF+VJgTTUWvQ9eVT1l1sGx6MRhTEPkHP9rVic90e+zH5LGyIqUYcEhA0axhbe6Z6XJLMYqP2YiU0z0YJdix6axJX2+hRtx3UW2kCmonyXVM8=;7:ZR46f4vgJZ+kAjck+dBAmuwDaVsbgIP+HWIvf/kXZZJDbFScWMwsR9XyHQp76XcdjpZNmNp/tGjnXjBa7XapZ22Iai0qG6pAYj2XI2FWVlRM5cXOzE1BsZVSDRGAqeZN/NU2L9egQipCVx9umjPthQa33DvYoOydDnDy/qYkhpUPeI6azcZzivjUEhGfl0RRN9JIGdYq0cNMrsPjLXRqJCApTXj00qlSXaqWc8N3Xm6VJ+7vgor49CcyUdQQZwHr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 16:10:07.8295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4a9652-eb5a-4903-2d03-08d5f7c940b3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comments in file net.h are too fancy for their own good,
so convert them to the regular format.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/net.h | 76 ++++++++++++++++----------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/net.h b/drivers/staging/fsl-dpaa2/ethernet/net.h
index 75a2d3a..ddea940 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/net.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/net.h
@@ -6,11 +6,9 @@
 
 #define LAST_HDR_INDEX 0xFFFFFFFF
 
-/*****************************************************************************/
-/*                Protocol fields                                            */
-/*****************************************************************************/
+/* Protocol fields */
 
-/*************************  Ethernet fields  *********************************/
+/* Ethernet fields */
 #define NH_FLD_ETH_DA                         (1)
 #define NH_FLD_ETH_SA                         (NH_FLD_ETH_DA << 1)
 #define NH_FLD_ETH_LENGTH                     (NH_FLD_ETH_DA << 2)
@@ -21,7 +19,7 @@
 
 #define NH_FLD_ETH_ADDR_SIZE                 6
 
-/***************************  VLAN fields  ***********************************/
+/* VLAN fields */
 #define NH_FLD_VLAN_VPRI                      (1)
 #define NH_FLD_VLAN_CFI                       (NH_FLD_VLAN_VPRI << 1)
 #define NH_FLD_VLAN_VID                       (NH_FLD_VLAN_VPRI << 2)
@@ -33,7 +31,7 @@
 					       NH_FLD_VLAN_CFI | \
 					       NH_FLD_VLAN_VID)
 
-/************************  IP (generic) fields  ******************************/
+/* IP (generic) fields */
 #define NH_FLD_IP_VER                         (1)
 #define NH_FLD_IP_DSCP                        (NH_FLD_IP_VER << 2)
 #define NH_FLD_IP_ECN                         (NH_FLD_IP_VER << 3)
@@ -46,7 +44,7 @@
 
 #define NH_FLD_IP_PROTO_SIZE                  1
 
-/*****************************  IPV4 fields  *********************************/
+/* IPV4 fields */
 #define NH_FLD_IPV4_VER                       (1)
 #define NH_FLD_IPV4_HDR_LEN                   (NH_FLD_IPV4_VER << 1)
 #define NH_FLD_IPV4_TOS                       (NH_FLD_IPV4_VER << 2)
@@ -67,7 +65,7 @@
 #define NH_FLD_IPV4_ADDR_SIZE                 4
 #define NH_FLD_IPV4_PROTO_SIZE                1
 
-/*****************************  IPV6 fields  *********************************/
+/* IPV6 fields */
 #define NH_FLD_IPV6_VER                       (1)
 #define NH_FLD_IPV6_TC                        (NH_FLD_IPV6_VER << 1)
 #define NH_FLD_IPV6_SRC_IP                    (NH_FLD_IPV6_VER << 2)
@@ -81,7 +79,7 @@
 #define NH_FLD_IPV6_ADDR_SIZE                 16
 #define NH_FLD_IPV6_NEXT_HDR_SIZE             1
 
-/*****************************  ICMP fields  *********************************/
+/* ICMP fields */
 #define NH_FLD_ICMP_TYPE                      (1)
 #define NH_FLD_ICMP_CODE                      (NH_FLD_ICMP_TYPE << 1)
 #define NH_FLD_ICMP_CKSUM                     (NH_FLD_ICMP_TYPE << 2)
@@ -92,14 +90,14 @@
 #define NH_FLD_ICMP_CODE_SIZE                 1
 #define NH_FLD_ICMP_TYPE_SIZE                 1
 
-/*****************************  IGMP fields  *********************************/
+/* IGMP fields */
 #define NH_FLD_IGMP_VERSION                   (1)
 #define NH_FLD_IGMP_TYPE                      (NH_FLD_IGMP_VERSION << 1)
 #define NH_FLD_IGMP_CKSUM                     (NH_FLD_IGMP_VERSION << 2)
 #define NH_FLD_IGMP_DATA                      (NH_FLD_IGMP_VERSION << 3)
 #define NH_FLD_IGMP_ALL_FIELDS                ((NH_FLD_IGMP_VERSION << 4) - 1)
 
-/*****************************  TCP fields  **********************************/
+/* TCP fields */
 #define NH_FLD_TCP_PORT_SRC                   (1)
 #define NH_FLD_TCP_PORT_DST                   (NH_FLD_TCP_PORT_SRC << 1)
 #define NH_FLD_TCP_SEQ                        (NH_FLD_TCP_PORT_SRC << 2)
@@ -115,7 +113,7 @@
 
 #define NH_FLD_TCP_PORT_SIZE                  2
 
-/*****************************  UDP fields  **********************************/
+/* UDP fields */
 #define NH_FLD_UDP_PORT_SRC                   (1)
 #define NH_FLD_UDP_PORT_DST                   (NH_FLD_UDP_PORT_SRC << 1)
 #define NH_FLD_UDP_LEN                        (NH_FLD_UDP_PORT_SRC << 2)
@@ -124,7 +122,7 @@
 
 #define NH_FLD_UDP_PORT_SIZE                  2
 
-/***************************  UDP-lite fields  *******************************/
+/* UDP-lite fields */
 #define NH_FLD_UDP_LITE_PORT_SRC              (1)
 #define NH_FLD_UDP_LITE_PORT_DST              (NH_FLD_UDP_LITE_PORT_SRC << 1)
 #define NH_FLD_UDP_LITE_ALL_FIELDS \
@@ -132,7 +130,7 @@
 
 #define NH_FLD_UDP_LITE_PORT_SIZE             2
 
-/***************************  UDP-encap-ESP fields  **************************/
+/* UDP-encap-ESP fields */
 #define NH_FLD_UDP_ENC_ESP_PORT_SRC         (1)
 #define NH_FLD_UDP_ENC_ESP_PORT_DST         (NH_FLD_UDP_ENC_ESP_PORT_SRC << 1)
 #define NH_FLD_UDP_ENC_ESP_LEN              (NH_FLD_UDP_ENC_ESP_PORT_SRC << 2)
@@ -145,7 +143,7 @@
 #define NH_FLD_UDP_ENC_ESP_PORT_SIZE        2
 #define NH_FLD_UDP_ENC_ESP_SPI_SIZE         4
 
-/*****************************  SCTP fields  *********************************/
+/* SCTP fields */
 #define NH_FLD_SCTP_PORT_SRC                  (1)
 #define NH_FLD_SCTP_PORT_DST                  (NH_FLD_SCTP_PORT_SRC << 1)
 #define NH_FLD_SCTP_VER_TAG                   (NH_FLD_SCTP_PORT_SRC << 2)
@@ -154,14 +152,14 @@
 
 #define NH_FLD_SCTP_PORT_SIZE                 2
 
-/*****************************  DCCP fields  *********************************/
+/* DCCP fields */
 #define NH_FLD_DCCP_PORT_SRC                  (1)
 #define NH_FLD_DCCP_PORT_DST                  (NH_FLD_DCCP_PORT_SRC << 1)
 #define NH_FLD_DCCP_ALL_FIELDS                ((NH_FLD_DCCP_PORT_SRC << 2) - 1)
 
 #define NH_FLD_DCCP_PORT_SIZE                 2
 
-/*****************************  IPHC fields  *********************************/
+/* IPHC fields */
 #define NH_FLD_IPHC_CID                       (1)
 #define NH_FLD_IPHC_CID_TYPE                  (NH_FLD_IPHC_CID << 1)
 #define NH_FLD_IPHC_HCINDEX                   (NH_FLD_IPHC_CID << 2)
@@ -169,7 +167,7 @@
 #define NH_FLD_IPHC_D_BIT                     (NH_FLD_IPHC_CID << 4)
 #define NH_FLD_IPHC_ALL_FIELDS                ((NH_FLD_IPHC_CID << 5) - 1)
 
-/*****************************  SCTP fields  *********************************/
+/* SCTP fields */
 #define NH_FLD_SCTP_CHUNK_DATA_TYPE           (1)
 #define NH_FLD_SCTP_CHUNK_DATA_FLAGS          (NH_FLD_SCTP_CHUNK_DATA_TYPE << 1)
 #define NH_FLD_SCTP_CHUNK_DATA_LENGTH         (NH_FLD_SCTP_CHUNK_DATA_TYPE << 2)
@@ -183,7 +181,7 @@
 #define NH_FLD_SCTP_CHUNK_DATA_ALL_FIELDS \
 	((NH_FLD_SCTP_CHUNK_DATA_TYPE << 10) - 1)
 
-/***************************  L2TPV2 fields  *********************************/
+/* L2TPV2 fields */
 #define NH_FLD_L2TPV2_TYPE_BIT                (1)
 #define NH_FLD_L2TPV2_LENGTH_BIT              (NH_FLD_L2TPV2_TYPE_BIT << 1)
 #define NH_FLD_L2TPV2_SEQUENCE_BIT            (NH_FLD_L2TPV2_TYPE_BIT << 2)
@@ -200,7 +198,7 @@
 #define NH_FLD_L2TPV2_ALL_FIELDS \
 	((NH_FLD_L2TPV2_TYPE_BIT << 13) - 1)
 
-/***************************  L2TPV3 fields  *********************************/
+/* L2TPV3 fields */
 #define NH_FLD_L2TPV3_CTRL_TYPE_BIT           (1)
 #define NH_FLD_L2TPV3_CTRL_LENGTH_BIT         (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 1)
 #define NH_FLD_L2TPV3_CTRL_SEQUENCE_BIT       (NH_FLD_L2TPV3_CTRL_TYPE_BIT << 2)
@@ -220,12 +218,12 @@
 #define NH_FLD_L2TPV3_SESS_ALL_FIELDS \
 	((NH_FLD_L2TPV3_SESS_TYPE_BIT << 4) - 1)
 
-/****************************  PPP fields  ***********************************/
+/* PPP fields */
 #define NH_FLD_PPP_PID                        (1)
 #define NH_FLD_PPP_COMPRESSED                 (NH_FLD_PPP_PID << 1)
 #define NH_FLD_PPP_ALL_FIELDS                 ((NH_FLD_PPP_PID << 2) - 1)
 
-/**************************  PPPoE fields  ***********************************/
+/* PPPoE fields */
 #define NH_FLD_PPPOE_VER                      (1)
 #define NH_FLD_PPPOE_TYPE                     (NH_FLD_PPPOE_VER << 1)
 #define NH_FLD_PPPOE_CODE                     (NH_FLD_PPPOE_VER << 2)
@@ -235,13 +233,13 @@
 #define NH_FLD_PPPOE_PID                      (NH_FLD_PPPOE_VER << 6)
 #define NH_FLD_PPPOE_ALL_FIELDS               ((NH_FLD_PPPOE_VER << 7) - 1)
 
-/*************************  PPP-Mux fields  **********************************/
+/* PPP-Mux fields */
 #define NH_FLD_PPPMUX_PID                     (1)
 #define NH_FLD_PPPMUX_CKSUM                   (NH_FLD_PPPMUX_PID << 1)
 #define NH_FLD_PPPMUX_COMPRESSED              (NH_FLD_PPPMUX_PID << 2)
 #define NH_FLD_PPPMUX_ALL_FIELDS              ((NH_FLD_PPPMUX_PID << 3) - 1)
 
-/***********************  PPP-Mux sub-frame fields  **************************/
+/* PPP-Mux sub-frame fields */
 #define NH_FLD_PPPMUX_SUBFRM_PFF            (1)
 #define NH_FLD_PPPMUX_SUBFRM_LXT            (NH_FLD_PPPMUX_SUBFRM_PFF << 1)
 #define NH_FLD_PPPMUX_SUBFRM_LEN            (NH_FLD_PPPMUX_SUBFRM_PFF << 2)
@@ -250,25 +248,26 @@
 #define NH_FLD_PPPMUX_SUBFRM_ALL_FIELDS \
 	((NH_FLD_PPPMUX_SUBFRM_PFF << 5) - 1)
 
-/***************************  LLC fields  ************************************/
+/* LLC fields */
 #define NH_FLD_LLC_DSAP                       (1)
 #define NH_FLD_LLC_SSAP                       (NH_FLD_LLC_DSAP << 1)
 #define NH_FLD_LLC_CTRL                       (NH_FLD_LLC_DSAP << 2)
 #define NH_FLD_LLC_ALL_FIELDS                 ((NH_FLD_LLC_DSAP << 3) - 1)
 
-/***************************  NLPID fields  **********************************/
+/* NLPID fields */
 #define NH_FLD_NLPID_NLPID                    (1)
 #define NH_FLD_NLPID_ALL_FIELDS               ((NH_FLD_NLPID_NLPID << 1) - 1)
 
-/***************************  SNAP fields  ***********************************/
+/* SNAP fields */
 #define NH_FLD_SNAP_OUI                       (1)
 #define NH_FLD_SNAP_PID                       (NH_FLD_SNAP_OUI << 1)
 #define NH_FLD_SNAP_ALL_FIELDS                ((NH_FLD_SNAP_OUI << 2) - 1)
 
-/***************************  LLC SNAP fields  *******************************/
+/* LLC SNAP fields */
 #define NH_FLD_LLC_SNAP_TYPE                  (1)
 #define NH_FLD_LLC_SNAP_ALL_FIELDS            ((NH_FLD_LLC_SNAP_TYPE << 1) - 1)
 
+/* ARP fields */
 #define NH_FLD_ARP_HTYPE                      (1)
 #define NH_FLD_ARP_PTYPE                      (NH_FLD_ARP_HTYPE << 1)
 #define NH_FLD_ARP_HLEN                       (NH_FLD_ARP_HTYPE << 2)
@@ -280,7 +279,7 @@
 #define NH_FLD_ARP_TPA                        (NH_FLD_ARP_HTYPE << 8)
 #define NH_FLD_ARP_ALL_FIELDS                 ((NH_FLD_ARP_HTYPE << 9) - 1)
 
-/***************************  RFC2684 fields  ********************************/
+/* RFC2684 fields */
 #define NH_FLD_RFC2684_LLC                    (1)
 #define NH_FLD_RFC2684_NLPID                  (NH_FLD_RFC2684_LLC << 1)
 #define NH_FLD_RFC2684_OUI                    (NH_FLD_RFC2684_LLC << 2)
@@ -289,13 +288,13 @@
 #define NH_FLD_RFC2684_VPN_IDX                (NH_FLD_RFC2684_LLC << 5)
 #define NH_FLD_RFC2684_ALL_FIELDS             ((NH_FLD_RFC2684_LLC << 6) - 1)
 
-/***************************  User defined fields  ***************************/
+/* User defined fields */
 #define NH_FLD_USER_DEFINED_SRCPORT           (1)
 #define NH_FLD_USER_DEFINED_PCDID             (NH_FLD_USER_DEFINED_SRCPORT << 1)
 #define NH_FLD_USER_DEFINED_ALL_FIELDS \
 	((NH_FLD_USER_DEFINED_SRCPORT << 2) - 1)
 
-/***************************  Payload fields  ********************************/
+/* Payload fields */
 #define NH_FLD_PAYLOAD_BUFFER                 (1)
 #define NH_FLD_PAYLOAD_SIZE                   (NH_FLD_PAYLOAD_BUFFER << 1)
 #define NH_FLD_MAX_FRM_SIZE                   (NH_FLD_PAYLOAD_BUFFER << 2)
@@ -304,39 +303,39 @@
 #define NH_FLD_FRAME_SIZE                     (NH_FLD_PAYLOAD_BUFFER << 5)
 #define NH_FLD_PAYLOAD_ALL_FIELDS             ((NH_FLD_PAYLOAD_BUFFER << 6) - 1)
 
-/***************************  GRE fields  ************************************/
+/* GRE fields */
 #define NH_FLD_GRE_TYPE                       (1)
 #define NH_FLD_GRE_ALL_FIELDS                 ((NH_FLD_GRE_TYPE << 1) - 1)
 
-/***************************  MINENCAP fields  *******************************/
+/* MINENCAP fields */
 #define NH_FLD_MINENCAP_SRC_IP                (1)
 #define NH_FLD_MINENCAP_DST_IP                (NH_FLD_MINENCAP_SRC_IP << 1)
 #define NH_FLD_MINENCAP_TYPE                  (NH_FLD_MINENCAP_SRC_IP << 2)
 #define NH_FLD_MINENCAP_ALL_FIELDS \
 	((NH_FLD_MINENCAP_SRC_IP << 3) - 1)
 
-/***************************  IPSEC AH fields  *******************************/
+/* IPSEC AH fields */
 #define NH_FLD_IPSEC_AH_SPI                   (1)
 #define NH_FLD_IPSEC_AH_NH                    (NH_FLD_IPSEC_AH_SPI << 1)
 #define NH_FLD_IPSEC_AH_ALL_FIELDS            ((NH_FLD_IPSEC_AH_SPI << 2) - 1)
 
-/***************************  IPSEC ESP fields  ******************************/
+/* IPSEC ESP fields */
 #define NH_FLD_IPSEC_ESP_SPI                  (1)
 #define NH_FLD_IPSEC_ESP_SEQUENCE_NUM         (NH_FLD_IPSEC_ESP_SPI << 1)
 #define NH_FLD_IPSEC_ESP_ALL_FIELDS           ((NH_FLD_IPSEC_ESP_SPI << 2) - 1)
 
 #define NH_FLD_IPSEC_ESP_SPI_SIZE             4
 
-/***************************  MPLS fields  ***********************************/
+/* MPLS fields */
 #define NH_FLD_MPLS_LABEL_STACK               (1)
 #define NH_FLD_MPLS_LABEL_STACK_ALL_FIELDS \
 	((NH_FLD_MPLS_LABEL_STACK << 1) - 1)
 
-/***************************  MACSEC fields  *********************************/
+/* MACSEC fields */
 #define NH_FLD_MACSEC_SECTAG                  (1)
 #define NH_FLD_MACSEC_ALL_FIELDS              ((NH_FLD_MACSEC_SECTAG << 1) - 1)
 
-/***************************  GTP fields  ************************************/
+/* GTP fields */
 #define NH_FLD_GTP_TEID                       (1)
 
 /* Protocol options */
@@ -387,6 +386,7 @@
 /* CAPWAP options */
 #define	NH_OPT_CAPWAP_DTLS			1
 
+/* Supported protocols */
 enum net_prot {
 	NET_PROT_NONE = 0,
 	NET_PROT_PAYLOAD,
-- 
2.7.4

