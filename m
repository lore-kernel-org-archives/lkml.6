Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D961EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AA02064D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hGpnqeck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AA02064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbeG0Pf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:35:27 -0400
Received: from mail-eopbgr00052.outbound.protection.outlook.com ([40.107.0.52]:1281
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730709AbeG0Pf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMmlmQHsmSzE8oj93ajLpDC8xO5bN5UlpSqYJlMR9mM=;
 b=hGpnqeckIzqHzY8VHaE4WBwITdO+8YH23OrC+KDFYtxrEiKQgYyroMOkzPGb42PziUQfmnrjm0oRwIYcAa0ZZlYFzRZ0jpSlDfdIfWag4u5y/ufumvc6ZOuB8ezTw8ua542Y7sR3eWf8i0U93dOHq7lELt641H8P13Puhtj+mmI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ruxandra.radulescu@nxp.com; 
Received: from rhuath.am.freescale.net (64.157.242.222) by
 DB4PR04MB348.eurprd04.prod.outlook.com (2a01:111:e400:9831::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.22; Fri, 27 Jul
 2018 14:13:12 +0000
From:   Ioana Radulescu <ruxandra.radulescu@nxp.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com
Subject: [PATCH 1/2] staging: fsl-dpaa2/eth: Update default hash key
Date:   Fri, 27 Jul 2018 09:12:59 -0500
Message-Id: <20180727141300.17511-1-ruxandra.radulescu@nxp.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: SN6PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:805:8e::23) To DB4PR04MB348.eurprd04.prod.outlook.com
 (2a01:111:e400:9831::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b293a7db-92cf-4e4e-6460-08d5f3cb1765
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB4PR04MB348;
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB348;3:q4aV66/4JT2I78RR5apYrTiujrvS/weYO0sLTGyNmUIJvgcbIYzkhCLs7M9S905vwG8AZpt9sRIj3v9eVbLFtFbnb9trP52wjX6BDdSIYYkOaTbz/YDfL+cR4j3E3N7ACvFjNvf4jFXsA+mFf/PbvOn8J/ZtEAGM8itNmDo68JmlnZ3vQac3cVJbB9XiVsqDvCAtQzxuGu/FdzPVMucO2ATf2NpuKCA7WrQ4f7hOU+aAPYyIhKrc/EJarBoUy8Xb;25:blsjo/p3CZC7gtxqrJ2nkJX81y4K8eOl8C4no7kRxQ9hc3LtF9qX/T87P7/A+/vBID7G8r2TfhOoW68qsN0Ud6ApHI1OoR+3cSysk3wCel1sAs/zZ0QVSxBRwibCIfAPQjISvAesHV+sBPc3ecjeAzdOEvLPqk572xh9MypPE6CCU6G1e84aYnGMo8RQ1K8NgSE6QTFNXG1DRyzuj46vBNFabrPk//4gdZZqbM0+ONQBvF7vZ20OV63waqhlXPFYAY/bLa7OoPappvEMcrmSWEn9voxRF9eH60UMXgvrsIxbC7oeTE3d1gZc3NHGb7+0pPSw9c829r8fdWJ4a2vh6w==;31:cQqlroKp0C/+7swtx9EyrS4fxZFgVKXedDV/Fml/XwaE//S7V1TxnviQyL1gEzHZqxnm4XrHD59/SFumfCTXA8/yKn21DXHHEwYd78pU8GQ0ejD7JLzM6jaycuZu/UoRhpaM+nt/DU3wCX9q/Yws7VCK1Az16U1NakbE7hBprqxNehi9/Yy3E0ZLaQi5Qnr4FPTimXGROFu9tFR/0o/x8f2vBK4nRN4RNcr9o+nj9j8=
X-MS-TrafficTypeDiagnostic: DB4PR04MB348:
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB348;20:Pa3ieyt8S/JM3WXTdtYYX/OXcjRFWvvYyKuWyc4FxEK69mTXygKur9YjoAcZt8+ABe03f3aiUbtDgvctSIptyJSTdrOikOsnWkmJpNrKgv37vXYg1yzi5FJMEMoC3F6UMYsXVNF6V+9ZQPTMma4OUjNPaMJ5z31VbN9IPmoM6XIcU85y8f8wile/LIQNkMETSASabNM/qMWTduSjsd4pJ7WNm7Qsr99BlbsEZkra4twc6m+KEQIYATjVLPZthAVBE4r2kponehyTS/os6OLOmIUWr4jz0B0dvH3WgOP7Vj+XWmT6PUkLB7RZbPE9Dsrr23St/1xMqXVj5tCxYtgrlL9jFYxPe200ZnLHvSqTpsCO15x7mnBSODP5NHoqU3S3gjr1Km+OA8nce16Kh3BZZw6EH8gK1/B6V40GNb4fNpmQe0w5cJmtehirRrLVbxNnB4LFazIWaiONt6HI6cqIetG3QcmCEfYPYhoBI6+VQaaa65RFL7erQiOMOTjgjaQF;4:Of26+IH1siHcE3/hvdhoOOkXMAHy+MZjklRxKENrFNy5PiAkDK+rXnM9aORip7+bVhFI3lqUS5/c+mTD9T7WwjzGYjzZ3wqdIb2ylzYO9nJDT9gqWl1u5GdM7BMt6dbvGm3GgOOc6NJBht/3hycuD9ZtVHdlkSxNsBM+HMCm/8gE55cHH2nrzJO++bzcqXbWvIPySxH00AMgsTEfU3pET/2MvO8zEdNWlDEZuC4wngouLL2z2L40cEQMjkrEvTABNMLZUE6n9VN5gw5TfQsrTiwtj1B/XEkoLgZgCKH2ZASA2JhluUJjdBekU9SCWof1
X-Microsoft-Antispam-PRVS: <DB4PR04MB348D7CC0BE8F6A5E7C7A4F6942A0@DB4PR04MB348.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB4PR04MB348;BCL:0;PCL:0;RULEID:;SRVR:DB4PR04MB348;
X-Forefront-PRVS: 07467C4D33
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(50226002)(6512007)(316002)(6916009)(15650500001)(16586007)(486006)(8676002)(8936002)(47776003)(476003)(81166006)(6486002)(81156014)(66066001)(52116002)(7736002)(51416003)(2361001)(956004)(25786009)(305945005)(6666003)(478600001)(97736004)(2616005)(68736007)(36756003)(1076002)(2351001)(3846002)(53936002)(6116002)(86362001)(4326008)(2906002)(48376002)(386003)(16526019)(186003)(5660300001)(6506007)(50466002)(106356001)(14444005)(105586002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB4PR04MB348;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB4PR04MB348;23:51p0UmZYmAm5h+VaJ60KPfIlCFiTQMcipL9jWvGgl0?=
 =?us-ascii?Q?L1Q2AZ6rlK86xj2Co7Wv3fEzLKxmlIfxVsX4GZhnAhKW2Iq+/FgJxLoLJEq7?=
 =?us-ascii?Q?6tNfz2gaSB5p6HrvE6R72JBxFadYFCYhEvRhodst+zCoOSUOK8f97AWfWgiO?=
 =?us-ascii?Q?o9hJH8zuuad+hwDggPjTg2lOaHuseIE1EuMgQ7lArwarhZgNi60NfmOCw2GN?=
 =?us-ascii?Q?aEcsKgWe5K3hCMoEdGFQF9ICJPBXV3R9v77b9z1PrgbCOsd8LouQ2xvzLQvQ?=
 =?us-ascii?Q?pCMyMU+mnEPP7wpErHNqs7NQodzPy5FyZczbmS75kbbbZ1Czm1Pf6woYSgYH?=
 =?us-ascii?Q?OltfwcXWE1WO1KrWSD6DWTyeMKxdz5gfqJh9eNCsXt0GdBXV6BSMzvpylIfy?=
 =?us-ascii?Q?hfC0nlFEEeNOnEBVqr2ybm6VMf7rDEiym+BCeYc1An1Cip6YSzoXdYa9eB9g?=
 =?us-ascii?Q?CoDz3EqI3VeVYPmB+T87SePffi8nmFlZdOdrGPJVhSLFxTKjRkNdKAowGVmL?=
 =?us-ascii?Q?Vi8KyRYl2QCKni7SSohXPsJb/qFX0yrmy53wyu2ID93O67FYmAvwo98+E0ev?=
 =?us-ascii?Q?kFDJ70Ql/bC0Dl07O6EiKI76jFqRid4seLzFBfAInbRf3XrzRZKQ0LcqUStP?=
 =?us-ascii?Q?zoVzJK35GCp0BSgVpNOMKzvr1VEVzBGctPqeGODmoB26ImM+v8LkbxH9gbEP?=
 =?us-ascii?Q?hghtSjaYrcXPOVlMV/VLE3E1cm8OdjT5kaJMXN7FHfijsm8NQBJQB9B3mDgR?=
 =?us-ascii?Q?tI+guOT4iynxs+Xg/J83T5mxvkPEr5bL52xRnFBLArodsP3An/KqyljmqblZ?=
 =?us-ascii?Q?eJ5zR67+MpJo/aE7R6OaDe3GZd+7qvFu/iZbfGs4Xnpu0lXm05jSAcHbXWwq?=
 =?us-ascii?Q?Dq4419Vai8LWONHtPh5fAccRyDZImx373kYZGhofEIMrmrdD2gipaoPSKbp6?=
 =?us-ascii?Q?ostHolIpKChAyYFW1zIcj+qqI41WHYhjMGpEqa00l4OjF/R5OVqm5CI/cSuR?=
 =?us-ascii?Q?ja2gSNcOHPWFHWUCkm5TMJquxhoKAozV/+6oQDSRa+eYlKrmdua9rFTaBJr8?=
 =?us-ascii?Q?sRcJzmi6byo6ix8OEMY7poSJko574ynQCKEGyooncNNydGBPA06FrjlpSocA?=
 =?us-ascii?Q?zUQ2nRMfBqTJmT436tXQuE0/b1EVWG1c2n91tc8AbFCbN5vHY2rnpr5wyr4n?=
 =?us-ascii?Q?RPN0YbnTwFJdWALx1oTdNP3c6s6gk/ofyf?=
X-Microsoft-Antispam-Message-Info: zwYtprkbCR7FaFiY+xndpdnKJo21i28tftavfSnJCSXHdaYQpEgjEH3icQUKAL+OK/f6Sqe4i0tTR/m3Xsxo9JDRFB72emlQ78cvTtvIlyOE0ruKxK1qijiOOcVR2seXU4JRNIV3RKUzYNdXgQ/geVZmAVefsWuPxqwv8AZhHSyI1my05h1/NxV3TrsfG5e9+lyDsg/FMsd4bkJgAnY0sibBC/b0dIZNS5qtO9iGVzSKWIj25ZnW4iVRfgfLcJ/Sfnl/K9O6O2BvMw+SEGfX9cuR/t6MuJkAd7+veKfq62nECi4rLLnSd2Elsrzj5SDAwXFmfgBe+wIUfwurh6UuDF4Bjax5liXDSPWy7WzHoMo=
X-Microsoft-Exchange-Diagnostics: 1;DB4PR04MB348;6:kZ5Wu/ixUc1xkwYDd9ceu8InSanR8hCyMr2NKy+G8i1pnJ1kEPI4cuMzY2Fut9osZv+sTi1X0OvHkob7hY0nb+QBnXolB1Kx+7NW/Pl9gkfpGgvIGynhVi6aHPLcwbcewFxCgkzsod8tmP6X2PdqKEQl55ij0f8BdgoTx6ZS9/q0u+3cK7/4EmyN4KjUnX5ZXkxA/ZJnHqTYzFWSflRbur9DZIjbq2uPocWu9AQ9WTfvVpU8nvBlXeRxWizEguF93gcuZjymhK3J58LwUNWFIQeFcfJ50xYXtV06Cccr18hOnhdoDPANVY5SD7Vcw3NtTxsb7uUmhwylNWAFtFMjJShkvcSE70ILPT5eghqcLJLclJYIcz1wi2nrR/Y1zBrBRoR6RyxPBP+g3Dy/jp02+ULwUaq6b168Vj6yXo1B6Q66XfYdAVw81d0BhSeX7qfAs0qVjmiNVZOOWlGXYWzClA==;5:GA6J4I0MQp6xwneoiODCngpX30OXUmu7m3tPEl1Twmvuf8iB3NzCHoxGsWUeEvSW80f7M4kGKHWHRfHDPBPgbRihZ//ogkkgYwkB1C+BtTKg8vMNhtK+XH+CpP7CsJwgoTmONV1PjdLGY7uXHjCOdXs/YbV24l24Cp6gA1P6mLw=;7:MIZqhGAlbDABxo0nUvCWAXcq2Xkm4Dqcy9cM4PXcowtA6Vo1ObBg7+WuQuwD4JcmkiIIpjOGGGAXWF4SLIaVfZZQz24ZG1z+emBwD2zXHnGCWoS5PnfFvQeKRnWcoV7AfWEl8ukkxAl/n32tn1hww8S4lgjhsXMjh6ufEZY4y4d4dp0YGu2gls7pdWFMHGc+eSLaWXAImIcnLq82iRrODSGUBBDYLVPr2MlsBfsu5n1JgRK9gdgxsKjs+6uav4P0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2018 14:13:12.8912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b293a7db-92cf-4e4e-6460-08d5f3cb1765
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR04MB348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our documentation, we claim to use a 5-tuple key for Rx hash
distribution of flows. The code however configures a key composed
of all supported header fields.

Update the Rx hash key to contain only the documented fields:
{IP src, IP dst, IP nextproto, L4 src, L4 dst}, which was the
original intention and makes most sense as a default.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 6 +++---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h | 5 ++++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index da993ed..5dd73b1 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -2195,10 +2195,10 @@ static int bind_dpni(struct dpaa2_eth_priv *priv)
 		return err;
 	}
 
-	/* have the interface implicitly distribute traffic based on supported
-	 * header fields
+	/* have the interface implicitly distribute traffic based on
+	 * the default hash key
 	 */
-	err = dpaa2_eth_set_hash(net_dev, DPAA2_RXH_SUPPORTED);
+	err = dpaa2_eth_set_hash(net_dev, DPAA2_RXH_DEFAULT);
 	if (err)
 		dev_err(dev, "Failed to configure hashing\n");
 
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 905a4e6..5589738 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -377,11 +377,14 @@ struct dpaa2_eth_priv {
 	u64 rx_hash_fields;
 };
 
-/* default Rx hash options, set during probing */
 #define DPAA2_RXH_SUPPORTED	(RXH_L2DA | RXH_VLAN | RXH_L3_PROTO \
 				| RXH_IP_SRC | RXH_IP_DST | RXH_L4_B_0_1 \
 				| RXH_L4_B_2_3)
 
+/* default Rx hash options, set during probing */
+#define DPAA2_RXH_DEFAULT	(RXH_L3_PROTO | RXH_IP_SRC | RXH_IP_DST | \
+				 RXH_L4_B_0_1 | RXH_L4_B_2_3)
+
 #define dpaa2_eth_hash_enabled(priv)	\
 	((priv)->dpni_attrs.num_queues > 1)
 
-- 
2.7.4

